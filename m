Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292087AbSB0E4G>; Tue, 26 Feb 2002 23:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292091AbSB0Ezz>; Tue, 26 Feb 2002 23:55:55 -0500
Received: from [203.124.139.197] ([203.124.139.197]:6928 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP
	id <S292087AbSB0Ezv>; Tue, 26 Feb 2002 23:55:51 -0500
Reply-To: <krishnakant.mehta@patni.com>
From: "Krishnakant Mehta" <krishnakant.mehta@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Problem with booting in GC+ board
Date: Wed, 27 Feb 2002 10:33:05 +0530
Message-ID: <012601c1bf4c$0b1108d0$a508a8c0@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We are currently porting Linux 2.4.7 on ADs- Graphics Client Plus board.
We are facing a problem as described below:-
We would like to know in what way we can get the help/consultancy
for the below mentioned problem.

Problem definition:-
  
We have modified the kernel source code to make Standard Linux
real time in the following way:-

1) For each IRQ line we have created a kernel thread(eg:-ethernet,serial,LCD
and keyboard)
   The driver handler is invoked from this thread.(The handlers for the
drivers are installed at
   boot time)
2) The bottom half is now a kernel thread.
3) and signal queing (for timer only) is also a kernel thread.

We are facing the following problem while booting:-

After the initial boot message
Uncompressing Linux.........................done,booting the kernel the
system hangs.

We debugged the head-armv.S file and we made the following observations :-
In the head-armv.S we added the following debugging statements to find the
sequence

		mov	r0, #F_BIT | I_BIT | MODE_SVC	@ make sure svc mode
		msr	cpsr_c, r0			@ and all irqs disabled
>>		bl	SYMBOL_NAME(myfunction1)
		bl	__lookup_processor_type
		teq	r10, #0				@ invalid processor?
		moveq	r0, #'p'			@ yes, error 'p'
>>		bl	SYMBOL_NAME(myfunction1)
		beq	__error
>>		bl	SYMBOL_NAME(myfunction1)
		bl	__lookup_architecture_type
		teq	r7, #0				@ invalid architecture?
		moveq	r0, #'a'			@ yes, error 'a'
		beq	__error
>>		bl	SYMBOL_NAME(myfunction1)
		bl	__create_page_tables
		adr	lr, __ret			@ return address
.........
.........
__error:
>>		bl	SYMBOL_NAME(myfunction2)
#ifdef CONFIG_DEBUG_LL
		mov	r8, r0				@ preserve r0
		adr	r0, err_str
		bl	printascii
		mov	r0, r8
		bl	printch

where myfunction1 and myfunction2 are function defined in the init/main.c
file
void myfunction1()
{
puts("Test1\n");
}
void myfunction2()
{
puts("Test2\n");
}

The following output occurs on booting
Uncompressing Linux...................................done,booting the
kernel
Test1
Test1
Test2
This indicates that the __lookup_processor_type fails.

Could you find a possible solution?


Regards,
Krishnakant/Chnadrasekhar

