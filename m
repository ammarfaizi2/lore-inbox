Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTIHNvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTIHNvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:51:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15492 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262433AbTIHNvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:51:32 -0400
Date: Mon, 8 Sep 2003 09:53:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
In-Reply-To: <3F5C7009.4030004@softhome.net>
Message-ID: <Pine.LNX.4.53.0309080924440.32483@chaos>
References: <rZQN.83u.21@gated-at.bofh.it> <saVL.7lR.1@gated-at.bofh.it>
 <soFo.16a.1@gated-at.bofh.it> <ssJa.6M6.25@gated-at.bofh.it>
 <tcVB.rs.3@gated-at.bofh.it> <3F5C7009.4030004@softhome.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-192936207-1063029193=:32483"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-192936207-1063029193=:32483
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 8 Sep 2003, Ihar 'Philips' Filipau wrote:

> Eric W. Biederman wrote:
> > insecure <insecure@mail.od.ua> writes:
> >>        movl    $0, 20(%esp)
> >>        movl    $1000000, %edi      <----
> >>        movl    $1000000, 16(%esp)  <----
> >>        movl    $0, 12(%esp)
> >>
> >>No sane human will do that.
> >>main:
> >>        movl    $1000000, %edi
> >>        movl    %edi, 16(%esp)	<-- save 4 bytes
> >>        movl    %ebp, 12(%esp)  <-- save 4 bytes
> >>        movl    $.LC27, 8(%esp)
> >>
> >>And this is only from a cursory examination.
> >
> > Actually it is no as simple as that.  With the instruction that uses
> > %edi following immediately after the instruction that populates it you
> > cannot
> > execute those two instructions in parallel.

With a single-CPU ix86, the only instructions that operate in
parallel are the instructions that calculate the next address, and
this only if you use 'leal'. However, there is an instruction
pipe-line so many memory accesses may seem to be unrelated to the
current execution context and therfore assumed to be 'parallel'.

> >  So the code may be slower.  The
> > exact rules depend on the architecture of the cpu.
> >
>
>    It will depend on arch CPU only in case if you have unlimited i$ size.
>    Servers with 8MB of cache - yes it is faster.
>    Celeron with 128k of cache - +4bytes == higher probability of i$ miss
> == lower performance.
>
> >
> >>What gives you an impression that anyone is going to rewrite linux in asm?
> >>I _only_ saying that compiler-generated asm is not 'good'. It's mediocre.
> >>Nothing more. I am not asm zealot.
> >
> >
> > I think I would agree with that statement most compiler-generated assembly
> > code is mediocre in general.  At the same time I would add most human
> > generated assembly is poor, and a pain to maintain.
> >

The compiler-generated assembly is, by design, "universal" so that
any legal 'C' statement may follow any other legal 'C' statement.
This means that, at each sequence-point, the assembly generation
is complete. This results in a lot of code duplication, etc. A
really good optimizer could, perform a fix-up that, based upon
the current 'C' code context, remove a lot of redundancy. Currently,
some such optimization is done by gcc such as loop-unrolling, etc.

A really good project would be an assembly-optimizer operated
like:

	gcc -O2 -S -o -  prog.c | optimizer | as -o prog.o -

Just make that optimizer and away you go!  I hate parser and
other text-based stuff so I'm not a candidate to make one of
these things.

> > If you concentrate on those handful of places where you need to
> > optimize that is reasonable.  Beyond that there simply are not the
> > developer resources to do good assembly.  And things like algorithmic
> > transformations in assembly are an absolute nightmare.  Where they are
> > quite simple in C.
> >
> > And if the average generated code quality bothers you enough with C
> > the compiler can be fixed, or another compiler can be written that
> > does a better job, and the benefit applies to a lot more code.
> >
>
>    e.g. C-- project: something like C, where you can operate with
> registers just like another variables. Under DOS was producing .com
> files witout any overhead: program with only 'int main() { return 0; }'
> was optimized to one byte 'ret' ;-) But sure it was not complete C
> implementation.
>
>    Sure I would prefere to have nasm used for kernel asm parts - but
> obviously gas already became standard.
>
> P.S. Add having good macroprocessor for assembler is a must: CPP is
> terribly stupid by design. I beleive gas has no preprocessor comparable
> to masm's one? I bet they are using C's cpp. This is degradation: macros
> is the major feature of any translator I was working with. They can save
> you a lot of time and make code much more cleaner/readable/mantainable.
> CPP is just too dumb for asm...
> Good old times, when people were responsible to _every_ byte of their
> programmes... Yeh... Memory/programmers are cheap nowadays...


This is for information only. I certainly don't advocate
writing everything in assembly language.

Attached is a tar file containing source and a Makefile.
It generates two tiny programs, "hello" and "world".
Both write "Hello world!" to standard-output. One is
written in assembly and the other is written in 'C'.
The one written in 'C' uses your installed shared
runtime library as is normal for such programs. Even
then, it is 2,948 bytes in length. The one written
in assembly results in a complete executable that
doesn't require any runtime support, i.e., static.
It is only 456 bytes in length.

gcc -Wall -O4 -o hello hello.c
strip hello
as -o world.o world.S
ld -o world world.o
strip world
ls -la hello world
-rwxr-xr-x   1 root     root         2948 Sep  8 08:34 hello
-rwxr-xr-x   1 root     root          456 Sep  8 08:34 world

The point is that if you really need to save some application
size, in many cases you can do the work in assembly. It is
a very useful tool. Also, if you have critical sections of
code you need to pipe-line for speed, you can do it in assembly
and make sure the optimization doesn't disappear the next
time somebody updates (improves) your tools. What you write
in assembly is what you get.

I don't like "in-line" assembly. Sometimes you don't have
much choice because you can't call some assembly-language
function to perform the work. However, when you can afford
the overhead of calling a function written in assembly, the
following applies.

Assume you have:

 extern int funct(int one, int two, int three);

Your assembly would obtain parameters as:

one   = 0x04
two   = 0x08
three = 0x0c

funct:	movl	one(%esp), %eax		# Get first passed parameter
	movl	two(%esp), %ebx		# Get second parameter
	movl	three(%esp), %ecx	# Get third parameter
	...etc

Now, gcc requires that your function not destroy any index
registers, %ebp, or any segment registers so, in the case
above, we need to save %ebx (an index register) before we
modify its value. To do this, we push it onto the stack.
This will alter the stack offsets where we obtain our input
parameters.


one   = 0x08
two   = 0x0c
three = 0x10

funct:	pushl	%ebx			# Save index register
	movl	one(%esp), %eax		# Get first passed parameter
	movl	two(%esp), %ebx		# Get second parameter
	movl	three(%esp), %ecx	# Get third parameter
	...etc
	popl	%ebx			# Restore index register

So, we could define macro that allows us to adjust the offsets
based upon the number of registers saved. I won't bother
here.

In most all cases, any value returned from the function is returned
in the %eax register. If you need to return a 'long long' both
%edx and %eax are used. Some functions may return values in the
floating-point unit so, when replacing existing 'C' code, you
need to see what the convention was.

When I write assembly-language functions I usually do it to
replace 'C' functions that (usually) somebody else has written.
Those 'C' functions are known to work. In other words, they
perform the correct mathematics. However, they need to be
speeded up or they need to be parred down to a more reasonable
size to fit in some embedded system.

Recently we had a function that calculated the RMS value of
an array of floating-point (double) numbers. With a particular
array size, the time necessary was something like 300 milliseconds.
By rewriting in assembly, and using the knowledge that the
array will never be less that 512 doubles in length, plus always
a power-of-two, the execution time went way down to 40 milliseconds.
Also, you can't "cheat" with a FP unit. There are always memory-
accesses that eat valuable CPU time. You can't put temporary float
values in registers.

I strongly suggest that if you have an interest in assembly, you
cultivate that interest. Soon most all mundane coding will be
performed by machine from a specification written by "Sales".
The only "real" programming will be done by those who can make
the interface between the hardware and the "coding machine". That's
assembly!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-192936207-1063029193=:32483
Content-Type: APPLICATION/octet-stream; name="hello-world.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0309080953130.32483@chaos>
Content-Description: 
Content-Disposition: attachment; filename="hello-world.tar.gz"

H4sIABB6XD8AA+2WbW/TMBDH+9b+FEc3pBbRkKR5QOFBSGOIF7BJdKh9gTRl
idtGc5MpcdZMiO+O7SRLh4BKSBlM3O+Ne76/fWc753qb5Tx+NugVcEzfdWEA
CvOHtjHA923f9B3f8wAs07bcAbj9plVTFiLMAQZ5lonf6fb5Hyhbff4fw0u2
TDjrJ4Zlmp7j/Pr8p359/p7lep49ledv+bY9ALOfdO7yn58/DTkPCFkzzjPQ
HwPE5WZzQynVbUAJ4QVMeAg7Gkp1Y2QBqX/MpCyUssZvtO2sUcoQjUPNF98K
oestRJ5ctdPrWG1eRiTdqyiCyVxmC5NTR42v0+kE9XhtUxpxFqYq93wDk2UT
qx7xREaj9G/v+79CXf/NLvYUY1/9W7bT3v+275iq/l3bwfq/D+hBkka8jBm8
LEScZMb6NU1SAZswSUfXWRKPX3T2mH6l6sByJso8hatSFKPhe11Vc/UdPRpK
9TesrQdEXf/NZd1TjH31702795/nu7r+nSnW/31ATz6dsyoRAK/AUsY2TwST
hkNnZ29PP59B7TEKFokkS8HIszgUIV1YATHUf266InfugC/pkC7sgH44PpEj
FzZMYLE7XrBKUGPFs4uQk3O1+9IUN1esMd4sy1RLaW0HZJNdc3K4sJ7CYxZV
tLHl/Kojrgg5gJlOBDhLV2LdKuoFKNGFFr2TL1yIWRHJh4LIcmh17aqVMtTK
ud6E20SIvAHJoVk9N4nyHqlXiFgzuGR5yricp5IrJypMF0xt6sgc78RQPV2I
Y7XpP4lADZbG+D5BEARBEARBEARBEARBEARBEARB/ozv5R4zVwAoAAA=

--1678434306-192936207-1063029193=:32483--
