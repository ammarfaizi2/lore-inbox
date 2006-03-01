Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWCAUpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWCAUpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCAUpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:45:25 -0500
Received: from psmtp03.wxs.nl ([195.121.247.12]:35766 "EHLO psmtp03.wxs.nl")
	by vger.kernel.org with ESMTP id S1751176AbWCAUpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:45:24 -0500
Date: Wed, 01 Mar 2006 17:21:34 -0500 (EST)
From: kees <kees@schoen.mine.nu>
Subject: Crash test
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.58.0603011713330.3608@schoen3.schoen.mine.nu>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_8BMWZ9ySMiTm2ZS0rzf75A)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_8BMWZ9ySMiTm2ZS0rzf75A)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hi All,

I have been haunted by a problem with SMP kernels since 2.4.1. I have an
application program that causes dual processor kernels or Pentium MT
kernels to crash. I have tried to find the cause myself but have not been
succesful in that.

The (original) application does basically:

Open a serial port / write a few bytes / toggle RTS / read a few bytes /
close port.

It does it up to twice a second. There may however arrive bytes while
closing the port.

Attached is a program that demonstrates it. I tried it and yes, my

Linux version 2.4.31 (root@merin) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1
SMP Tue Oct 25 12:31:57 CEST 2005

crashed within 10 minutes :-((((((((

It locks up totally.

I found that 2.6 kernels will crash (at least with the original application)
too.

The serial input data is to be 'simulated' with a square wave generator on
the com port input.

You need a frequency generator of about 1300 Hertz to set the test up.

I have never been able to catch the underlying bug myself. It is probabely a
race problem somewhere in the interrupt allocation/de-allocation part..

I hope that someone with a spare SMP system (my SMP system is my
workstation at work, so I don't like the crashes at all) can try this and
catch the bug.

kind regards

Kees

--Boundary_(ID_8BMWZ9ySMiTm2ZS0rzf75A)
Content-id: <Pine.LNX.4.58.0603011713331.3608@schoen3.schoen.mine.nu>
Content-type: TEXT/X-CSRC; NAME=crash_test.c; CHARSET=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: ATTACHMENT; FILENAME=crash_test.c
Content-description: 

#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <termio.h> 
#include <unistd.h>
#include <sys/poll.h>
#include <signal.h>


/* this test program seeks to demonstrate a (longstanding) problem in
 * 2.4 and 2.6 SMP kernels.
 * The original application that is hindered by the problem is different
 * but this demo program contains enough aspects that it will crash a 
 * SMP linux system soon. My experience is between almost direct to about 30 minutes.
 * 
 * I have been able to immuminize only the 2.4.4 kernel. The same patch on later kernels did 
 * not help any longer.
 *
 * in order to test it apply a square wave generator to a serial port i.e.
 * /dev/ttyS0, I tested with +/ 2.5 Volts and 1300 Hertz. This produces a '?' character 
 * if the port is read with
 * (stty 1200 cs8 </dev/ttyS0 ; cat /dev/ttyS0)
 *
 * +----------------+
 * |                | signal            -----------
 * | 1.3 kHz        |-------------------| 470 Ohm |-----------------  pin 3 serial connector
 * |                |                   -----------
 * | +/- 2.5 Volts  |
 * | square wave    | ground
 * |                |-----------------------------------------------  pin 7 serial connector
 * +----------------+
 *
 * 
 * the test program can be run with
 *
 * crash_test -H /dev/ttyS0 (assuming that this is the correct port)
 *
 * the -S option disables the consequetive opening and closing of the port, if this option 
 * is applied, NO crash follows.
 * 
 * kees schoenmakers kees@schoen.mine.nu / kees.schoenmakers@siemens.com
 * 
 */


int test_open(), read_char(); 
void test_nrts(), test_close();
int smp_opt=0;

struct termio tio;
struct pollfd testfd;

unsigned char tbuf[32];


int main(argc, argv )
int argc;
char **argv;
{
	char c;
	int i;
	char *portname="";

	 while (( c= getopt(argc, argv, "SH:")) != -1){
		     switch (c) {
					case 'H':
										portname=optarg;
										break;

					case 'S':
										smp_opt++;
										break;
	          exit(1);
		    }
	  }

	testfd.fd = -1;
	testfd.events= 0 |POLLIN;
	
  sprintf((char *)&tbuf, "test\n");
	

	signal( SIGFPE, SIG_IGN);

	if( !strlen(portname)){
		if((portname = getenv("TEST_PORT")) == NULL){
			fprintf(stderr,"Port unknown, set TEST_PORT\n");
			exit(1);
		}
	}

	while(1){ 							/* main loop this does it !! */

		if( test_open( portname) < 0)
			exit(-2);

		write(testfd.fd, (char *) &tbuf, strlen (tbuf));
		
		test_nrts();
		
		for( i =0 ; i < 6 ; i++){
			read_char(testfd.fd);
		}

		test_close();
		
		usleep(10000);
	} /* 'main' while */
}

int test_open(portname)
char *portname;
{
extern int errno;

	if( testfd.fd == -1){
		if((testfd.fd = open(portname , O_RDWR)) < 0){
			printf("*** can't open %s port, error %d \n",portname, errno);
			testfd.fd = -1;
			return (-1);
		}
		ioctl(testfd.fd , TCGETA, &tio);
		tio.c_cflag = CS8 | B1200 | CREAD | CLOCAL;
		tio.c_iflag = IGNBRK;
		tio.c_lflag = 0;
		tio.c_oflag = 0;
		tio.c_cc[4] = 1;
		tio.c_cc[5] = 1;
		ioctl(testfd.fd , TCSETA, &tio);
	}
	return(0);
}

/* switch from xmit to receive, toggle RTS line */

void test_nrts()
{
int parm;
		usleep(1000);	/* wait for buffer to drain */
		while(1){
			ioctl(testfd.fd, TIOCSERGETLSR, &parm);
			if (parm)
				break;
		}
		ioctl(testfd.fd, TIOCMGET, &parm);
		parm &= ~TIOCM_RTS; /* RTS off */
		ioctl(testfd.fd, TIOCMSET, &parm );
		return;
}

void test_close()
{
	int parm;

	if(!smp_opt){  /* normally close the port */
	if( testfd.fd >=0)
		close( testfd.fd);
	testfd.fd = -1;
	} else {
		usleep(1000);	
		/* put RTS back on */
		ioctl(testfd.fd, TIOCMGET, &parm);
		parm |= TIOCM_RTS; /* RTS on */
		ioctl(testfd.fd, TIOCMSET, &parm );
	}
}

int read_char()
{
   unsigned char c;
	 int r_stat;

   r_stat=poll(&testfd, 1, 10);
   if(r_stat > 0) 
      read(testfd.fd, &c, 1);
	 return (int) c;
}


--Boundary_(ID_8BMWZ9ySMiTm2ZS0rzf75A)--
