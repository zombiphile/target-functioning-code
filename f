import board
import digitalio
import time
import busio

score_button=digitalio.DigitalInOut(board.GP5)
ball_count_button=digitalio.DigitalInOut(board.GP6)
score_button.direction = digitalio.Direction.INPUT
ball_count_button.direction = digitalio.Direction.INPUT
score_button.pull = digitalio.Pull.UP
ball_count_button.pull = digitalio.Pull.UP

from lcd.lcd import LCD
from lcd.i2c_pcf8574_interface import I2CPCF8574Interface

ball_count_button.value
score_button.value
score = 0
ball_count = 3

i2c = busio.I2C(board.GP1, board.GP0)

# Talk to the LCD at I2C address 0x27.
lcd = LCD(I2CPCF8574Interface(i2c, 0x27), num_rows=2, num_cols=20)
lcd.set_backlight(True)

while True:
    #print("Clearing LCD")
    lcd.clear()
    # Start at the first line, fifth column (numbering from zero).
   # lcd.set_cursor_pos(0, 1)
    #lcd.print("Pinball Wizard")
    #time.sleep(1)
    #lcd.clear()

    # Start at the first line, fifth column (numbering from zero).
    lcd.set_cursor_pos(0, 1)
    lcd.print("Score: ")
    lcd.print(str(score))
    # When printing a number with this library, you need to make sure
    # to convert it to a string, otherwise you'll get an error
    # about a non-iterable being passed to print()

    #print("Printed score")
    #time.sleep(.5)
    #print("Clearing LCD for the update")
    #lcd.clear()
    lcd.set_cursor_pos(1,2)
    lcd.print(str("Ball Count"))
    lcd.print(":#")
    lcd.print(str(ball_count))
  #  lcd.set_cursor_pos(1,2)


    time.sleep(.01)

    #lcd.clear()
    #lcd.print("Update!")

    # Make the screen scroll sideways
    #for i in range (0,20):
        #lcd.shift_display(1)
        #time.sleep(.25)

    # Bump the score for the next iteration of the loop
    if score_button.value == False:
        score = score+1
    if ball_count_button.value == False:
        ball_count= ball_count-1


