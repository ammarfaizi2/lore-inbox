Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSLTQuE>; Fri, 20 Dec 2002 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLTQuE>; Fri, 20 Dec 2002 11:50:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262620AbSLTQuC>; Fri, 20 Dec 2002 11:50:02 -0500
Date: Fri, 20 Dec 2002 08:47:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021220120656.GA20674@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212200834590.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Jamie Lokier wrote:
>
> Ulrich Drepper wrote:
> >   int $0x80  ->  call *%gs:0x18
>
> The calling convention has been (slightly) changed - i.e. 6 argument
> calls don't work, so why not go a bit further: allow the vsyscall entry
> point to clobber more GPRs?

Actually, six-argument syscalls _do_ work. I admit that the way to make
them work is "interesting", but it's also extremely simple.

> The benefit is that this allows Glibc to do a wholesale replacement of
> "int $0x80" -> "single call instruction".  Otherwise, those pushes are
> completely unnecessary.  It could be this short instead:
>
> 	vsyscall:
> 		movl	%esp,%ebp
> 		sysenter
> 		jmp	vsyscall
> 		ret

Yes, we could have changed the implementation to clobber more registers,
but if we want to support all system calls it would still have to save
%ebp, so the minimal approach would have been

	vsyscall:
		pushl %ebp
	0:
		movl %esp,%ebp
		sysenter
		jmp 0b	/* only done for restarting */
		popl %ebp
		ret

which is all of 4 (simple) instructions cheaper than the one we have now.

And if the caller cannot depend on registers being saved, the caller may
actually end up being more complicated. For example, with the current
setup, you can have

	getpid():
		movl $__NR_getpid,%eax
		jmp *%gs:0x18

but if system calls clobber registers, the caller needs to be

	getpid():
		pushl %ebx
		pushl %esi
		pushl %edi
		pushl %ebp
		movl $__NR_getpid,%eax
		call *%gs:0x18
		popl %ebp
		popl %edi
		popl %esi
		popl %ebx
		ret

and notice how the _real_ code sequence actually got much _worse_ from the
fact that you tried to save time by not saving registers.


> It is nice to be able to use the _exact_ same convention in glibc, for
> getting a patch out of the door quickly.  But it is just as easy to do
> that putting the pushes and pops into the library itself:
>
> Instead of
>
> 	int $0x80 ->	call	*%gs:0x18
>
> Write
>
> 	int $0x80 ->	pushl	%ebp
> 			pushl	%ecx
> 			pushl	%edx
> 			call	*%gs:0x18
> 			popl	%edx
> 			popl	%ecx
> 			popl	%ebp

But where's the advantage then? You use the same number of instructions
dynamically, and you use _more_ icache space than if you have the pushes
and pops in just one place?

> It has exactly the same cost as the current patches, but provides
> userspace with more optimisation flexibility, using an asm clobber
> list instead of explicit instructions for inline syscalls, etc.

In practice, there is nothing around the call. And you have to realize
that the pushes and pops you added in your version are _wasted_ for other
cases. If the system call ends up being int 0x80, you just wasted time. If
the system call ended up being AMD's x86-64 version of syscall, you just
wsted time.

The advantage of putting all the register save in the trampoline is that
user mode literally doesn't have to _know_ what it is calling. It only
needs to know two simple rules:

 - registers are preserved (except for %eax which is the return value, of
   course)
 - it should fill in arguments in %ebx, %ecx ... (but the things that
   aren't arguments can just be left untouched)

And then depending on what the real low-level calling convention is, the
trampoline will save the _minimum_ number of registers (ie some calling
conventions might clobber different registers than %ecx/%edx - you have to
remember that "sysenter" is just _one_ out of at least three calling
conventions available).

			Linus

