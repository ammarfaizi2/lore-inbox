Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSITMVZ>; Fri, 20 Sep 2002 08:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSITMVY>; Fri, 20 Sep 2002 08:21:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9091 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262373AbSITMVW>; Fri, 20 Sep 2002 08:21:22 -0400
Date: Fri, 20 Sep 2002 08:27:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Richard Henderson <rth@twiddle.net>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919224613.GA2026@werewolf.able.es>
Message-ID: <Pine.LNX.3.95.1020920081925.19137A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, J.A. Magallon wrote:

> 
> On 2002.09.19 Richard B. Johnson wrote:
> >On Thu, 19 Sep 2002, Richard Henderson wrote:
> >
> [...]
> >> > It's really bad code because it could have done:
> >> > 
> >> > 	incl	$0x04(%esp)
> >> > 	incl	$0x08(%esp)
> >> > 	incl	$0x1c(%esp)
> >> > 	jmp	bar
> >> 
> [...]
> >
> >It's a problem with a 'general purpose' compiler that wants to
> >be "all things" to all people. If somebody made a gcc-compatible
> >compiler, tuned to the ix86 characteristics, I think we could
> >cut the extra instructions by at least 1/2, maybe more.
> >
> 
> Curiosity killed the cat....
> Just tried it with gcc-3.2.
> C code:
> extern void bar(int x, int y, int z);
> void foo(const int a, const int b, const int c)
> {
>         bar(a+1, b+1, c+1);
> }
> 
> - gcc -S -O0:
>         pushl   %ebp
>         movl    %esp, %ebp
>         subl    $8, %esp
>         subl    $4, %esp
>         movl    16(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         movl    12(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         movl    8(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         call    bar
>         addl    $16, %esp
>         leave
>         ret
> 
> - gcc -S -O1:
>         pushl   %ebp
>         movl    %esp, %ebp
>         subl    $12, %esp
>         movl    16(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         movl    12(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         movl    8(%ebp), %eax
>         incl    %eax
>         pushl   %eax
>         call    bar
>         addl    $16, %esp
>         movl    %ebp, %esp
>         popl    %ebp
>         ret
> 
> - gcc -S -O2:
>         movl    12(%esp), %eax
>         incl    %eax
>         movl    %eax, 12(%esp)
>         movl    8(%esp), %eax
>         incl    %eax
>         movl    %eax, 8(%esp)
>         movl    4(%esp), %eax
>         incl    %eax
>         movl    %eax, 4(%esp)
>         jmp     bar
> 
> - gcc -S -O2 -march=[i686,pentium2,pentium3]:
>         incl    4(%esp)
>         movl    8(%esp), %eax
>         incl    %eax
>         movl    %eax, 8(%esp)
>         movl    12(%esp), %eax
>         incl    %eax
>         movl    %eax, 12(%esp)
>         jmp     bar
> 
> - gcc -S -O2 -march=pentium4:
>         movl    8(%esp), %eax
>         addl    $1, 4(%esp)
>         addl    $1, %eax
>         movl    %eax, 8(%esp)
>         movl    12(%esp), %eax
>         addl    $1, %eax
>         movl    %eax, 12(%esp)
>         jmp     bar
> 
> -- 
> J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
> werewolf.able.es                         \           It's better when it's free
> Mandrake Linux release 9.0 (Cooker) for i586
> Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
> 

Notice that it always gets some value from memory, modifies it,
then writes it back. Adding 1 to %eax is plain dumb. Those instructions
have to be fetched! Any instruction that's longer than the constant
long-word in that instruction should be reviewed. Also that 1 is
4 bytes long. It has a single-byte oprand. That means the next instruction
fetch will be at an odd address if it started on even because that
sequence is 5 bytes in length.


.if 0
	 You can assemble this directly .....

You know there are continuous complaints about
ix86 processors being "register starved", but somehow
the 'C' compilers often don't use the capabilities that
are available with the processors. The following is some
'code' that will assemble. It doesn't do anything useful,
but shows some addressing capability that is often ignored.
.endif


foo:	.long	0

bar:	incl	(foo)		# Bump the value of foo directly
	addl	%eax,(foo)	# Add eax to value in foo
	addl	$0x10,(foo)	# Add constant to value in foo
	addl	(foo),%eax	# Add value in foo to eax
	pushl	(foo)		# Put value in foo onto stack
	popl	(foo)		# Pop value on stack into foo
	movl	%eax, foo(%ebx)	# Put eax value into memory at foo + ebx
	incb	(foo)		# This is atomic, no lock required
	movl	14(%esp, %ebx), %eax # Get value from stack at offset
                                     # ESP + EBX (good for local arrays)

.if 0

Most of the gcc code that deals with memory oprands, gets a value
from memory, modifies it, then writes it back. This is a "throw-back"
from processors that only have load and store operations. The ix86
processors can directly modify a single bit, anywhere in memory without
having to put it into a register. Of course, what the hardware 
physically does may be quite another thing altogether. But I suggest
that the CPU/Hardware combination is more capable of doing the right
thing in executing the binary than any compiler that forces a load
into a register, modification of register contents, then a write
back to memory.

Timing tests with rdtsc show many cycles are often wasted with these forced
load and store operations.

.endif

	

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

