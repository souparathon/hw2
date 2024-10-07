import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String displayText = '';
  double? firstOperand;
  String? operator;
  
  void _input(String input) {
    setState(() {
      displayText += input;
    });
  }
  
  void _setOperator(String op) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = double.tryParse(displayText);
        displayText = '';
      }
      operator = op;
    });
  }
  
  void _calculate() {
    if (firstOperand != null && operator != null) {
      double secondOperand = double.tryParse(displayText) ?? 0;
      double result;
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand;
          break;
        case '-':
          result = firstOperand! - secondOperand;
          break;
        case '*':
          result = firstOperand! * secondOperand;
          break;
        case '/':
          result = secondOperand != 0 ? firstOperand! / secondOperand : double.nan;
          break;
        default:
          result = 0;
      }
      setState(() {
        displayText = result.toString();
        firstOperand = null;
        operator = null;
      });
    }
  }

  void _clear() {
    setState(() {
      displayText = '';
      firstOperand = null;
      operator = null;
    });
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            //color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(text, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(displayText, style: TextStyle(fontSize: 48)),
          ),
          Column(
            children: [
              Row(children: [
                _buildButton('7', () => _input('7')),
                _buildButton('8', () => _input('8')),
                _buildButton('9', () => _input('9')),
                _buildButton('/', () => _setOperator('/')),
              ]),
              Row(children: [
                _buildButton('4', () => _input('4')),
                _buildButton('5', () => _input('5')),
                _buildButton('6', () => _input('6')),
                _buildButton('*', () => _setOperator('*')),
              ]),
              Row(children: [
                _buildButton('1', () => _input('1')),
                _buildButton('2', () => _input('2')),
                _buildButton('3', () => _input('3')),
                _buildButton('-', () => _setOperator('-')),
              ]),
              Row(children: [
                _buildButton('0', () => _input('0')),
                _buildButton('.', () => _input('.')),
                _buildButton('=', _calculate),
                _buildButton('+', () => _setOperator('+')),
              ]),
              Row(children: [
                _buildButton('Clear', _clear),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
