Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBNKNw>; Wed, 14 Feb 2001 05:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBNKNl>; Wed, 14 Feb 2001 05:13:41 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:60177 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129106AbRBNKNg>; Wed, 14 Feb 2001 05:13:36 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A8A59BF.5DD01B01@yahoo.com>
Date: Wed, 14 Feb 2001 05:11:11 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: /dev/rtc not working on ASUS A7V133
In-Reply-To: <20010212012755.A656@gondor.com> <20010212021532.A28317@win.tue.nl> <20010212100307.A491@gondor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:

> But I have a correction: The problem does not only occurr if the system
> was started automatically by the bios, a manual 'soft off/soft on' sequence
> shows the same effect. Only 'hard off/hard on' (using the switch directly
> on the power supply) seems to work every time.

Can you run the following program when things are working and then when
they are not - i.e. 

cmosdump > b4
# soft off / on
cmosdump > after
diff -u b4 after

The low registers (0, & 2 IIRC) are for sec and min, so expect changes
there - but of interest will be any changes in reg 0x0a and 0x0b.

Paul.

/*
 *
 *	A quick hack to dump the CMOS RAM values from 0x0 to 0x7f. Note that
 *	some CMOS are only 0x40 in size, so edit accordingly. Released to
 *	the public under the terms and conditions of the Gnu General Public
 *	License (GPL) included herein by reference.
 *
 *	Compile with:
 *		 gcc -s -N -Wall -O cmosdump.c -o cmosdump
 *
 *					Paul Gortmaker		07/95
 */

#define CMOS_SIZE 0x80

#include <stdio.h>
#include <asm/io.h>
#include <unistd.h>
#include <errno.h>

/*
 * <linux/rtc.h>  was <linux/mc146818rtc.h> on kernels prior to 2.2.19, so
 * just define CMOS_READ/WRITE here independently and avoid the hassle.
 */

#define RTC_PORT(x)     (0x70 + (x))
#define CMOS_READ(addr) ({ \
outb_p((addr),RTC_PORT(0)); \
inb_p(RTC_PORT(1)); \
})
#define CMOS_WRITE(val, addr) ({ \
outb_p((addr),RTC_PORT(0)); \
outb_p((val),RTC_PORT(1)); \
})
 

void binprint (unsigned short value);

void main(void) {

unsigned short addr, val;

val= iopl(3);
if (val) {
	perror("iopl");
	exit(errno);
}

printf("Addr:\tHex\tDec.\tBinary\n");

for (addr = 0; addr < CMOS_SIZE; addr++) {
	val = CMOS_READ(addr);
	printf("0x%X:\t0x%X\t%d\t",addr, val, val);
	binprint(val);
	printf("\n");
}

iopl(0);

} /*end*/

void binprint(unsigned short value) {

int bit;

for (bit=128;bit>0;bit/=2) 
	printf("%s", (value & bit) ? "1" : "0");

} /* end binprint */



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

