Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268609AbRHKRug>; Sat, 11 Aug 2001 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbRHKRu0>; Sat, 11 Aug 2001 13:50:26 -0400
Received: from B513f.pppool.de ([213.7.81.63]:16907 "HELO Nicole.muc.suse.de")
	by vger.kernel.org with SMTP id <S268609AbRHKRuS>;
	Sat, 11 Aug 2001 13:50:18 -0400
Subject: Re: __asm__ usage ????
From: Daniel Egger <egger@suse.de>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010810195004.18859.qmail@web20008.mail.yahoo.com>
In-Reply-To: <20010810195004.18859.qmail@web20008.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 11 Aug 2001 19:32:53 +0200
Message-Id: <997551186.791.68.camel@sonja>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10 Aug 2001 12:50:04 -0700 schrieb Raghava Raju:

>    I want some basic insights into assembly level code
> emmbedded in C language. Following is the code of
> PowerPc ambedded in C languagge:

 It's not really kernel related but nevertheless...

 
> unsigned long old,mask, *p;
> 
> 	__asm__ __volatile__(SMP_WMB "\
> 1:	lwarx 	%0,0,%3
> 	andc  	%0,%0,%2
> 	stwcx 	%0,0,%3
> 	bne 	1b"
> 	SMP_MB
> 	: "=&r" (old), "=m" (*p)
> 	: "r" (mask), "r" (p), "m" (*p)
> 	: "cc")"
> 	1) what does these things denote: __volatile__,

It means the compiler should by no means touch the code.

> SMP_WMB, SMP_MB,

I suspect those are defined to some memory barriing code
and only in SMP kernels. 

> "r","=&r","=m",

r means register, = means output and & is early clobber.
=m means address that is written to and in ppc assembler
this means a different notation in the final assembly
in the form 4(%r1) for example.

> "cc" and 1: .

cc is the condition code register and 1: a local label
which can be used for a look like "bne 1b" (branch if not
equal to label 1 backwards).

> 	2) Is it that %0,%2,%3 denote addresses of old,mask,p
> respectively. 

No, they are just labels which are replaced by the compiler
with whatever is defined after the colons.
 
>         4) I think in power PC we can't access
> directly the contents of memory, but we should 
> give addresses of memory in registers then use
> registers in instructions to access memory. But in
> above example he is using %3 in lwarx command
> accessing that memory directly. Is my interpretation
> of above instructions wrong.

Yes, you're wrong. By issuing an "r" (p) the p (which is a
pointer in this case) is assigned to a register which is then
used in the load command as the absolute address.

>         5) Some people use "memory" in place of "cc" ,
> like I want to know what are these things.

Those are other clobbers. memory means that memory has been modified
by the command sequence and cc means that the condition register
is modify and thus has to be saved by the compiler if in doubt.
 
>         6) Finally I want to write a simple programme
> to write the contents of a local variable "xyz" into
> register r33, then store the contents of r33 into
> local variable "abc". Kindly would u give me a sample
> code of doing it.

Negative for two reasons: There is no register 33 (at least)
on 32bit PPC CPUs, and second, you normally don't want to
hardcode registers in inline assembly. If you really want to
then use normal assembly.

But for your example:
long xyz, abc;

__asm__ __volatile__ ("mr %0,%1\n\t": "r" (abc) : "r" (xyz));
 
However this is a really dumb example.

Servus,
       Daniel

