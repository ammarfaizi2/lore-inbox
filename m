Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWDJNhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWDJNhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDJNhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:37:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:65205 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750910AbWDJNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:37:13 -0400
Subject: [PATCH -rt] Buggy uart (for 2.6.16)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Dv1LYnHIIFajpIOI2R2v"
Date: Mon, 10 Apr 2006 09:37:05 -0400
Message-Id: <1144676225.12145.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dv1LYnHIIFajpIOI2R2v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ingo,

I've noticed that you dropped my "buggy uart" patch.  Probably because
the 2.6.14 version would cause a deadlock on 2.6.16.  I've sent you a
new update, but it must have been lost in all the noise.  Here's the
patch again.  If you don't think this is a bug, try running the attached
program on the machine that deadlocked (it is the one with the buggy
uart). Without the patch, the serial_test will miss a wake up, and then
be stuck in the sleeping TASK_INTERRUPTIBLE state (at least you can
still kill it).  With the patch, it runs fine.

I ran the program with the following parameters:

# ./serial_test /dev/ttyS0 115200 8 0 0 4

(Disclaimer: I did not write this serial_test.  It was hacked up by my
customer to show me that this bug exists).

This may also be a bug with the vanilla kernel, since I don't see why it
is not. I'll run more tests on the vanilla kernel, and if it too misses
a wake up, I'll submit this to vanilla as well.


Some 8250 uarts don't zero out the NO_INTERRUPT bit of the IIR register
on transmit empty interrupts. If this happens, then the interrupt handler
won't process any transmits that are waiting, and we can have processes
stuck waiting to transmit over the serial.

This patch has the interrupt process the transmits regardless if 
the interrupt handler didn't already handle the transmits, and
the uart was previously (on setup) detected to be buggy.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt14/drivers/serial/8250.c
===================================================================
--- linux-2.6.16-rt14.orig/drivers/serial/8250.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16-rt14/drivers/serial/8250.c	2006-04-10 09:14:38.000000000 -0400
@@ -1336,6 +1336,14 @@
 				"irq%d\n", irq);
 			break;
 		}
+		/*
+		 * If we have a buggy TX line, that doesn't
+		 * notify us via iir that we need to transmit
+		 * then force the call.
+		 */
+		if (!handled && (up->bugs & UART_BUG_TXEN))
+			serial8250_handle_port(up, regs);
+
 	} while (l != end);
 
 	spin_unlock(&i->lock);


--=-Dv1LYnHIIFajpIOI2R2v
Content-Disposition: attachment; filename=serial_test.c
Content-Type: text/x-csrc; name=serial_test.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <termios.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/signal.h>
#include <sys/types.h>

#define BAUDRATE B38400
#define MODEMDEVICE "/dev/ttyS1"
#define _POSIX_SOURCE 1         //POSIX compliant source
#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

void signal_handler_IO (int status);    //definition of signal handler
int wait_flag=TRUE;                     //TRUE while no signal received
char devicename[80];
long Baud_Rate = 38400;         // default Baud Rate (110 through 38400)
long BAUD;                      // derived baud rate from command line
long DATABITS;
long STOPBITS;
long PARITYON;
long PARITY;
int Data_Bits = 8;              // Number of data bits
int Stop_Bits = 1;              // Number of stop bits
int Parity = 0;                 // Parity as follows:
                  // 00 = NONE, 01 = Odd, 02 = Even, 03 = Mark, 04 = Space
int Format = 4;
FILE *input;
FILE *output;
int status;

int main(int Parm_Count, char *Parms[])
{
	char version[80] = "       POSIX compliant Communications test program version 1.00 4-25-1999\r\n";
	char version1[80] = "          Copyright(C) Mark Zehner/Peter Baumann 1999\r\n";
	char version2[80] = " This code is based on a DOS based test program by Mark Zehner and a Serial\r\n";
	char version3[80] = " Programming POSIX howto by Peter Baumann, integrated by Mark Zehner\r\n";  
	char version4[80] = " This program allows you to send characters out the specified port by typing\r\n";
	char version5[80] = " on the keyboard.  Characters typed will be echoed to the console, and \r\n";
	char version6[80] = " characters received will be echoed to the console.\r\n";
	char version7[80] = " The setup parameters for the device name, receive data format, baud rate\r\n";
	char version8[80] = " and other serial port parameters must be entered on the command line \r\n";
	char version9[80] = " To see how to do this, just type the name of this program. \r\n";
	char version10[80] = " This program is free software; you can redistribute it and/or modify it\r\n";
	char version11[80] = " under the terms of the GNU General Public License as published by the \r\n";
	char version12[80] = " Free Software Foundation, version 2.\r\n";
	char version13[80] = " This program comes with ABSOLUTELY NO WARRANTY.\r\n";
	char instr[100] ="\r\nOn the command you must include six items in the following order, they are:\r\n";
	char instr1[80] ="   1.  The device name      Ex: ttyS0 for com1, ttyS1 for com2, etc\r\n";
	char instr2[80] ="   2.  Baud Rate            Ex: 38400 \r\n";
	char instr3[80] ="   3.  Number of Data Bits  Ex: 8 \r\n";
	char instr4[80] ="   4.  Number of Stop Bits  Ex: 0 or 1\r\n";
	char instr5[80] ="   5.  Parity               Ex: 0=none, 1=odd, 2=even\r\n";
	char instr6[80] ="   6.  Format of data received:  1=hex, 2=dec, 3=hex/asc, 4=dec/asc, 5=asc\r\n";
	char instr7[80] =" Example command line:  com ttyS0 38400 8 0 0 4 \r\n";
	char Param_strings[7][80];
	char message[90];
	char cntmessage[90];

	int fd, tty, res, i, error, cnt = 1;
	char In1;
	char Keys[] = "jfdslgjdlskfgklsdfjgkdlfsklsjgfdgsdfjglkdsf";
	struct termios oldtio, newtio;       //place for old and new port settings for serial port
	struct termios oldkey, newkey;       //place tor old and new port settings for keyboard teletype
	struct sigaction saio;               //definition of signal action
	char buf[255];                       //buffer for where data is put
   
	input = fopen("/dev/tty", "r");      //open the terminal keyboard
	output = fopen("/dev/tty", "w");     //open the terminal screen

	if (!input || !output){
		fprintf(stderr, "Unable to open /dev/tty\n");
		exit(1);
	}

	error=0;
	fputs(version,output);               //display the program introduction
	fputs(version1,output);
	fputs(version2,output);
	fputs(version3,output);
	fputs(version4,output);
	fputs(version5,output);
	fputs(version6,output);
	fputs(version7,output);
	fputs(version8,output);
	fputs(version9,output);
	fputs(version10,output);
	fputs(version11,output); 
	fputs(version12,output);
	fputs(version13,output);
	//read the parameters from the command line
	if (Parm_Count==7){  //if there are the right number of parameters on the command line
		for (i=1; i < Parm_Count; i++)  // for all wild search parameters
			strcpy(Param_strings[i-1],Parms[i]);
		i=sscanf(Param_strings[0],"%s",devicename);
		if (i != 1)
			error=1;
		i=sscanf(Param_strings[1],"%li",&Baud_Rate);
		if (i != 1)
			error=1;
		i=sscanf(Param_strings[2],"%i",&Data_Bits);
		if (i != 1)
			error=1;
		i=sscanf(Param_strings[3],"%i",&Stop_Bits);
		if (i != 1)
			error=1;
		i=sscanf(Param_strings[4],"%i",&Parity);
		if (i != 1)
			error=1;
		i=sscanf(Param_strings[5],"%i",&Format);
		if (i != 1)
			error=1;
		sprintf(message,"Device=%s, Baud=%li\r\n",devicename, Baud_Rate); //output the received setup parameters
		fputs(message,output);
		sprintf(message,"Data Bits=%i  Stop Bits=%i  Parity=%i  Format=%i\r\n",Data_Bits, Stop_Bits, Parity, Format);
		fputs(message,output);
	}  //end of if param_count==7
  
	if ((Parm_Count==7) && (error==0)){  //if the command line entries were correct
	                                    //run the program
		tty = open("/dev/tty", O_RDWR | O_NOCTTY | O_NONBLOCK); //set the user console port up
		tcgetattr(tty,&oldkey); // save current port settings   //so commands are interpreted right for this program
		// set new port settings for non-canonical input processing  //must be NOCTTY
		newkey.c_cflag = BAUDRATE | CRTSCTS | CS8 | CLOCAL | CREAD;
		newkey.c_iflag = IGNPAR;
		newkey.c_oflag = 0;
		newkey.c_lflag = 0;       //ICANON;
		newkey.c_cc[VMIN]=1;
		newkey.c_cc[VTIME]=0;
		tcflush(tty, TCIFLUSH);
		tcsetattr(tty,TCSANOW,&newkey);

		switch (Baud_Rate){
			case 38400:
			default:
				BAUD = B38400;
				break;
			case 19200:
				BAUD  = B19200;
				break;
			case 9600:
				BAUD  = B9600;
				break;
			case 4800:
				BAUD  = B4800;
				break;
			case 2400:
				BAUD  = B2400;
				break;
			case 1800:
				BAUD  = B1800;
				break;
			case 1200:
				BAUD  = B1200;
				break;
			case 600:
				BAUD  = B600;
				break;
			case 300:
				BAUD  = B300;
				break;
			case 200:
				BAUD  = B200;
				break;
			case 150:
				BAUD  = B150;
				break;
			case 134:
				BAUD  = B134;
				break;
			case 110:
				BAUD  = B110;
				break;
			case 75:
				BAUD  = B75;
				break;
			case 50:
				BAUD  = B50;
				break;
		}  //end of switch baud_rate

		switch (Data_Bits){
			case 8:
			default:
				DATABITS = CS8;
				break;
			case 7:
				DATABITS = CS7;
				break;
			case 6:
				DATABITS = CS6;
				break;
			case 5:
				DATABITS = CS5;
				break;
		}  //end of switch data_bits

		switch (Stop_Bits){
			case 1:
			default:
				STOPBITS = 0;
				break;
			case 2:
				STOPBITS = CSTOPB;
				break;
		}  //end of switch stop bits

		switch (Parity){
			case 0:
			default:                       //none
				PARITYON = 0;
				PARITY = 0;
				break;
			case 1:                        //odd
				PARITYON = PARENB;
				PARITY = PARODD;
				break;
			case 2:                        //even
				PARITYON = PARENB;
				PARITY = 0;
				break;
		}  //end of switch parity
       
		//install the serial handler before making the device asynchronous
		saio.sa_handler = signal_handler_IO;
		sigemptyset(&saio.sa_mask);   //saio.sa_mask = 0;
		saio.sa_flags = 0;
		saio.sa_restorer = NULL;
		sigaction(SIGIO,&saio,NULL);

		// loop while waiting for input. normally we would do something useful here
		while (STOP==FALSE){
			//open the device(com port) to be non-blocking (read will return immediately)
			sprintf(cntmessage,"============== %d =============\r\n", cnt);
			fputs(cntmessage, output);
			fputs("Trying to open device\r\n", output);
			fd = open(devicename, O_RDWR | O_NOCTTY | O_NONBLOCK);
			if (fd < 0){
				perror(devicename);
				exit(-1);
			}
			fputs("Opened device\r\n", output);

			// allow the process to receive SIGIO
			fcntl(fd, F_SETOWN, getpid());
			// Make the file descriptor asynchronous (the manual page says only
			// O_APPEND and O_NONBLOCK, will work with F_SETFL...)
			fcntl(fd, F_SETFL, FASYNC);

			tcgetattr(fd,&oldtio); // save current port settings 
			// set new port settings for canonical input processing 
			newtio.c_cflag = BAUD | /* CRTSCTS | */ DATABITS | STOPBITS | PARITYON | PARITY | CLOCAL | CREAD;
			newtio.c_iflag = IGNPAR;
			newtio.c_oflag = 0;
			newtio.c_lflag = 0;       //ICANON;
			newtio.c_cc[VMIN]=1;
			newtio.c_cc[VTIME]=0;
			tcflush(fd, TCIFLUSH);
			fputs("Trying to set attributes\r\n", output);
			tcsetattr(fd,TCSANOW,&newtio);
			fputs("Set attributes\r\n", output);
			
//			status = fread(&Key,1,1,input);
//			if (status==1){  //if a key was hit
//         			switch (Key){ /* branch to appropiate key handler */
//					case 0x1b: /* Esc */
//						STOP=TRUE;
//						break;
//					default:
//						fputc((int) Key,output);
						//sprintf(message,"%x ",Key);  //debug
						//fputs(message,output);
						write(fd,Keys,sizeof(Keys));          //write 1 byte to the port
						ioctl(fd, TCSBRK, NULL);
//						break;
//				}  //end of switch key
//			}  //end if a key was hit
			// after receiving SIGIO, wait_flag = FALSE, input is available and can be read
			if (wait_flag==FALSE){  //if input is available
				res = read(fd,buf,255);
				if (res){
					for (i=0; i<res; i++){  //for all chars in string
						In1 = buf[i];
						switch (Format){
							case 1:         //hex
								sprintf(message,"%x ",In1);
								fputs(message,output);
								break;
							case 2:         //decimal
								sprintf(message,"%d ",In1);
								fputs(message,output);
								break;
							case 3:         //hex and asc
								if ((In1) || (In1)){
									sprintf(message,"%x",In1);
									fputs(message,output);
								} else
									fputc ((int) In1, output);
								break;
							case 4:         //decimal and asc
							default:
								if ((In1) || (In1)){
									sprintf(message,"%d",In1);
									fputs(message,output);
								} else
									fputc ((int) In1, output);
								break;
							case 5:         //asc
								fputc ((int) In1, output);
								break;
						}  //end of switch format
					}  //end of for all chars in string
				}  //end if res?
				//buf[res]=0;
				//printf(":%s:%d\n", buf, res);
				//if (res==1) STOP=TRUE; /* stop loop if only a CR was input */
				wait_flag = TRUE;      /* wait for new input */
			}  //end if wait flag == FALSE
			fputs("Trying to reset attributes\r\n", output);
			tcsetattr(fd,TCSANOW,&oldtio);
			fputs("Reset attributes\r\n", output);
			fputs("Trying to close device\r\n", output);
			close(fd);        //close the com port
			fputs("Closed device\r\n", output);
			cnt++;
			usleep(500000);
		}  //while stop==FALSE

		// restore old port settings
		
		tcsetattr(tty,TCSANOW,&oldkey);
		close(tty);

	} else { //end if command line entrys were correct
		//give instructions on how to use the command line
		fputs(instr,output);
		fputs(instr1,output);
		fputs(instr2,output);
		fputs(instr3,output);
		fputs(instr4,output);
		fputs(instr5,output);
		fputs(instr6,output);
		fputs(instr7,output);
	}
	fclose(input);
	fclose(output);
	return 0;
}  //end of main

/***************************************************************************
* signal handler. sets wait_flag to FALSE, to indicate above loop that     *
* characters have been received.                                           *
***************************************************************************/

void signal_handler_IO (int status){
	//printf("received SIGIO signal.\n");
	wait_flag = FALSE;
}

--=-Dv1LYnHIIFajpIOI2R2v--

