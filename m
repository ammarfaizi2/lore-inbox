Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280238AbRJaOca>; Wed, 31 Oct 2001 09:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280245AbRJaOcV>; Wed, 31 Oct 2001 09:32:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280244AbRJaOcH>; Wed, 31 Oct 2001 09:32:07 -0500
Date: Wed, 31 Oct 2001 09:31:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <01103115390007.00794@nemo>
Message-ID: <Pine.LNX.3.95.1011031092415.9270A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1659251687-1004538699=:9270"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1659251687-1004538699=:9270
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 31 Oct 2001, vda wrote:

[SNIPPED...]

> Hmm.... 64bit jiffies are attractive.
> 
> I'd like to see less #defines in kernel
> Some parts of your patch fight with the fact that jiffies
> is converted to macro -> it is illegal now to have local vars
> called "jiffies". This is ugly. I know that there are tons of similarly
> (ab)used macros in the kernel now but let's stop adding more!
> 
> This test prog shows how to make overlapping 32bit and 64bit vars.
> It works for me.
>  
> #include <stdio.h>
> typedef unsigned long long u64;
> 
> extern u64 jiffies_64;
> extern unsigned long jiffies;
> extern unsigned long jiffies_hi;
> 
> asm(
> "	.bss\n"
> "	.align 8\n"
> ".globl jiffies_64\n"
> ".globl jiffies\n"
> ".globl jiffies_hi\n"
> "jiffies_64:\n"
> // <- a bunch of ifdefs needed here to sort out endianness stuff...
> "jiffies:\n"
> "	.zero	4\n"
> "jiffies_hi:\n"
> "	.zero	4\n"
> 
> //not working!? how to return to prev .data/.text/whatever?
> //I don't know gas...
> //"	.previous\n"
> );
> 
> int main() {
>     jiffies_64 = 0xFEDCBA9876543210UL;
>     printf("lo: 0x%08x\n",jiffies);
>     printf("hi: 0x%08x\n",jiffies_hi);
>     return 0;
> }
> 
> Is this better or not? If not, why?
> --
> vda

The problem is that a 64-bit jiffies on a 32-bit machine would
require a spin-lock every time the jiffies variable is changed!
This is because there are two (or more) memory accesses for
every 64 bit operation, plus two or more register accesses for
every 64 bit operation. If a context-switch or an interrupt
occurs between those operations, all bets are off about the
result.

The appended small tar.gz file contains some 64-bit assembly
plus some 64-bit C, Look at the assembly and it will become
obvious to you that you don't want to use a 64-bit timer
on a 32 bit machine.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


--1678434306-1659251687-1004538699=:9270
Content-Type: APPLICATION/octet-stream; name="64bits.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1011031093139.9270B@chaos.analogic.com>
Content-Description: 

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
KaRPCv0L3Sh9jgBQAAA=
--1678434306-1659251687-1004538699=:9270--
