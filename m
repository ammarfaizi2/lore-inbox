Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292899AbSB0Uax>; Wed, 27 Feb 2002 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292939AbSB0UaY>; Wed, 27 Feb 2002 15:30:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55694 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292530AbSB0U3F>; Wed, 27 Feb 2002 15:29:05 -0500
Date: Wed, 27 Feb 2002 15:32:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: artoim@phreaker.net
cc: Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <Pine.LNX.3.95.1020227151958.16459A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>	Here's a sample program. Try running it and open about 2k of 
>connections to port 5222 (you'll need ulimit -n 10000 or like that). It 
>will segfault. Simple asm like this

   __asm__(
	"pushl %eax \n\t"
 	"movl  0(%ebp), %eax \n\t"

Get whatever ss:[%ebp] points to into %eax

	"cmp   $65535, %eax \n\t"

Check to see if that was 0xffff (why should it be?)

	"ja isok \n\t"

	"xor  %eax, %eax \n\t"
Get a zero.

	"movl  %eax, 0(%eax) \n\t"	

 ... and put it into ds:[0]

Which will seg-fault of course.


	"isok: \n\t"
	"popl  %eax \n\t"
   );

>after each subroutine call will show you that after select() [ebp] have 
>weird value. While this is unlikely to be a security flaw, i think this 
>is a bug.


You are not testing the value of EBP, but what it points to on the stack.
Depending upon what was called, and subsequently returned from, stuff
below the current above the current stack is undefined, residual from
previous calls and their local data.

In your asm code, for some reason, you expect SS:[EBP] to point to
the value of 0x00010000 or greater. It could point to anything and
be legal. If you want to test the value of EBP (and you have to do
it within the function that has set it), you would do:

	movl	%ebp, %eax

Since the returned value from a function is in the %eax register, you
could make an ASM function that returns this value at the start of
the function you are testing, save it in a variable, then periodically
check by calling and comparing. You will, no doubt, find that it
will remain the same.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

