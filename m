Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSLQS4R>; Tue, 17 Dec 2002 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLQS4R>; Tue, 17 Dec 2002 13:56:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265285AbSLQS4Q>; Tue, 17 Dec 2002 13:56:16 -0500
Date: Tue, 17 Dec 2002 11:04:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF6D4B.3060107@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171050470.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ulrich Drepper wrote:
>
> But it will eliminate the problem.  Remember: the x86 (unlike x86-64)
> has no PC-relative data addressing mode.  I.e., in a DSO to find a
> memory location with an address I need a base register which isn't
> available anymore at the time the call is made.

Actually, I see a more serious problem with the current "syscall"
interface: it doesn't allow six-argument system calls AT ALL, since it
needed %ebp to keep the stack pointer.

So a six-argument system call _has_ to use "int $0x80" anyway, which to
some degree simplifies your problem: you can only use the indirect call
approach for things where %ebp will be free for use anyway.

So then you can use %ebp as the indirection, and the code will look
something like

games, since that is guaranteed not to be ever used by a system call (it
wasn't guaranteed before, but since the sysenter really needs something to
hold the stack pointer I made %ebp do that, so there's no way we can ever
use %ebp for system calls on x86).

So you _can_ do something like this:

	syscall_with_5_args:
		pushl %ebx
		pushl %esi
		pushl %edi
		pushl %ebp
		movl syscall_ptr + GOT,%ebp	// uses DSO ptr in %ebx or whatever
		movl $__NR_xxxxxx,%eax
		movl 20(%esp),%ebx
		movl 24(%esp),%ecx
		movl 28(%esp),%edx
		movl 32(%esp),%esi
		movl 36(%esp),%edi
		call *%ebp
		.. test for errno if needed ..
		popl %ebp
		popl %edi
		popl %esi
		popl %ebx
		ret

> You have to assume that all the registers, including %ebp, are used at
> the time of the call.

See why this isn't possible right now anyway.

Hmm.. Which system calls have all six parameters? I'll have to see if I
can find any way to make those use the new interface too.

In the meantime, I do agree with you that the TLS approach should work
too, and might be better. It will allow all six arguments to be used if we
just find a good calling conventions (too bad sysenter is such a pig of an
instruction, it's really not very well designed since it loses
information).

			Linus

