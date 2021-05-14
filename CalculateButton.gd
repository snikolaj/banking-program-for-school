extends Button

onready var textBox = get_node("../Control/RichTextLabel")
func _on_CalculateButton_pressed():
	var Bj = get_node("../Control/LoanAmount").text.to_int()
	
	var interestRate
	if "%" in get_node("../Control/InterestRate").text:
		interestRate = get_node("../Control/InterestRate").text.to_float() / 100.0
	else:
		interestRate = get_node("../Control/InterestRate").text.to_float()
	
	var numOfn = get_node("../Control/Instalments").text.to_int()
	
	if Bj == 0 or interestRate == 0 or numOfn == 0:
		textBox.bbcode_text = "Invalid input"
	else:
		var interest = getInterest(Bj, interestRate)
		var instalment = (Bj * interestRate)/ (1 - pow((1 + interestRate), - numOfn))
		instalment = round(instalment * 100.0) / 100.0
		
		var principalRepayment = 0
		var bbcode = ("[cell]" + str(0) + "[/cell][cell]" + str(Bj) + "[/cell][cell]" + str(0) + "[/cell][cell]" + str(0) + "[/cell][cell]" + str(0) + "[/cell]")
		
		for i in range(numOfn):
			interest = round(interest * 100.0) / 100.0
			principalRepayment = instalment - interest
			principalRepayment = round(principalRepayment * 100.0) / 100.0
			
			Bj -= principalRepayment
			Bj = round(Bj * 100.0) / 100.0
			bbcode += ("[cell]" + str(i+1) + "[/cell][cell]" + str(Bj) + "[/cell][cell]" + str(interest) + "[/cell][cell]" + str(principalRepayment) + "[/cell][cell]" + str(instalment) + "[/cell]") 
			interest = getInterest(Bj, interestRate)
		
		textBox.bbcode_text += "[table=5]" + "[cell]Payment[/cell][cell]Amount left[/cell][cell]Interest[/cell][cell]Principal[/cell][cell]Instalment[/cell]" + bbcode + "[/table]"


func getInterest(Bj, interestRate):
	return Bj * interestRate
