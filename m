Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWGGSQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWGGSQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWGGSQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:16:20 -0400
Received: from khc.piap.pl ([195.187.100.11]:24790 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932223AbWGGSQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:16:19 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <arjan@infradead.org>
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
	<Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 07 Jul 2006 20:16:16 +0200
In-Reply-To: <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com> (linux-os@analogic.com's message of "Thu, 6 Jul 2006 13:52:25 -0400")
Message-ID: <m34pxt8emn.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> extern int spinner;
>
> funct(){
>      while(spinner)
>          ;
>
> The 'C' compiler has no choice but to actually make that memory access
> and read the variable because the variable is in another module (a.k.a.
> file).

defiant:/tmp/khc$ gcc --version
gcc (GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)
defiant:/tmp/khc$ cat test.c 
extern int spinner;

void funct(void)
{
     while(spinner)
         ;
}
defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
defiant:/tmp/khc$ objdump -d test.o 

test.o:     file format elf32-i386

Disassembly of section .text:

00000000 <funct>:
   0:   a1 00 00 00 00          mov    0x0,%eax
   5:   55                      push   %ebp
   6:   89 e5                   mov    %esp,%ebp
   8:   85 c0                   test   %eax,%eax
   a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
  10:   75 fe                   jne    10 <funct+0x10>
  12:   5d                      pop    %ebp
  13:   c3                      ret    

"0x0" is, of course, for relocation.

> However, if I have the same code, but the variable is visible during
> compile time, i.e.,
>
> int spinner=0;
>
> funct(){
>      while(spinner)
>          ;
>
> ... the compiler may eliminate that code altogether because it
> 'knows' that spinner is FALSE, having initialized it to zero
> itself.

defiant:/tmp/khc$ cat test.c 
int spinner = 0;

void funct(void)
{
     while(spinner)
         ;
}
defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
defiant:/tmp/khc$ objdump -d test.o 

00000000 <funct>:
   0:   a1 00 00 00 00          mov    0x0,%eax
   5:   55                      push   %ebp
   6:   89 e5                   mov    %esp,%ebp
   8:   85 c0                   test   %eax,%eax
   a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
  10:   75 fe                   jne    10 <funct+0x10>
  12:   5d                      pop    %ebp
  13:   c3                      ret    

> Since spinner is global in scope, somebody surely could have
> changed it before funct() was even called, but the current gcc
> 'C' compiler doesn't care and may optimize it away entirely.

Personally I don't think such C compiler even existed. HISOFT C
on ZX Spectrum could be a good candidate but I think it didn't
have any optimizer :-)

> To
> prevent this, you must declare the variable volatile. To do
> otherwise is a bug.

Nope. Volatile just means that every read (and write) must actually
access the variable. Note that the compiler optimized out accesses
to the variable in the loop - while it has to check at the beginning
of funct(), it knows that the variable is constant through funct().

Note that "volatile" is not exactly what we usually want, but it
does the job (i.e., the program doesn't crash, but the code is
probably suboptimal).

> That said, I think that the current
> implementation of 'volatile' is broken because the compiler
> seems to believe that the variable has moved! It recalculates
> the address of the variable as well as accessing its value.
> This is what makes the code generation problematical.

You must be using a heavily broken compiler:

defiant:/tmp/khc$ cat test.c 
volatile int spinner = 0;

void funct(void)
{
     while(spinner)
         ;
}
defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
defiant:/tmp/khc$ objdump -d test.o 

00000000 <funct>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   a1 00 00 00 00          mov    0x0,%eax
   8:   85 c0                   test   %eax,%eax
   a:   75 f7                   jne    3 <funct+0x3>
   c:   5d                      pop    %ebp
   d:   c3                      ret    
-- 
Krzysztof Halasa
