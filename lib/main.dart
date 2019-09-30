import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _gender = ['Female', 'Male'];
  var _genderSelected = 'Female';
  var _bmrEquation = ['Mifflin-St Jeor', 'Harris-Benedict'];
  var _bmrEquationSelected = 'Mifflin-St Jeor';
  var _activity = [
    'Little/no exercise',
    'Light exercise/sport 1-3 days per week',
    'Moderate exercise/sport 3-5 days per week',
    'Hard exercise/sport 6-7 days per week',
    'Very hard exercise/sport and a physical job'
  ];
  var _activitySelected = 'Little/no exercise';
  var result = 0.0;
  var calories = 0.0;

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMR Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMR Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Text('Gender',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                items: _gender.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newGenderSelected) {
                  _dropDownItemSelected(newGenderSelected);
                },
                value: _genderSelected,
              ),


              Text('BMR Equation',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                items: _bmrEquation.map((String dropDownStringItem2) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem2,
                    child: Text(dropDownStringItem2),
                  );
                }).toList(),
                onChanged: (String newBMREquationSelected) {
                  _dropDownItemSelected2(newBMREquationSelected);
                },
                value: _bmrEquationSelected,
              ),


              Container(
                child: Text(
                  'Age',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
              ),


              Container(
                child: Text(
                  'Height',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "cm"),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
              ),


              Container(
                child: Text(
                  'Weight',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "kg"),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
              ),


              Text('Please select your activity level',
                  style: new TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                items: _activity.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newActivitySelected) {
                  _dropDownItemSelected3(newActivitySelected);
                },
                value: _activitySelected,
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
              ),


              RaisedButton(
                child: Text('Calculate'),
                onPressed: _onPress,
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 15.0),
              ),
              Text(
                "BMR: $result",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Maintenance Calories Per Day: $calories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dropDownItemSelected(String newGenderSelected) {
    setState(() {
      this._genderSelected = newGenderSelected;
    });
  }

  void _dropDownItemSelected2(String newBMREquationSelected) {
    setState(() {
      this._bmrEquationSelected = newBMREquationSelected;
    });
  }

  void _dropDownItemSelected3(String newActivitySelected) {
    setState(() {
      this._activitySelected = newActivitySelected;
    });
  }

  List _onPress() {
    setState(() {
      int age = int.parse(_ageController.text);
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      if ((_genderSelected == "Female") &&
          (_bmrEquationSelected == "Mifflin-St Jeor")) {
        result = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      } else if ((_genderSelected == "Male") &&
          (_bmrEquationSelected == "Mifflin-St Jeor")) {
        result = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else if ((_genderSelected == "Female") &&
          (_bmrEquationSelected == "Harris-Benedict")) {
        result = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
      } else if ((_genderSelected == "Male") &&
          (_bmrEquationSelected == "Harris-Benedict")) {
        result = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
      }


      if (_activitySelected == "Little/no exercise") {
        calories = result * 1.2;
      } else if (_activitySelected ==
          "Light exercise/sport 1-3 days per week") {
        calories = result * 1.375;
      } else if (_activitySelected ==
          "Moderate exercise/sport 3-5 days per week") {
        calories = result * 1.55;
      } else if (_activitySelected == "Hard exercise/sport 6-7 days per week") {
        calories = result * 1.725;
      } else if (_activitySelected ==
          "Very hard exercise/sport and a physical job") {
        calories = result * 1.9;
      }
    });
    return [result, calories];
  }
}
