Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSLTL7P>; Fri, 20 Dec 2002 06:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSLTL7O>; Fri, 20 Dec 2002 06:59:14 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:33002 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261582AbSLTL7N>;
	Fri, 20 Dec 2002 06:59:13 -0500
Date: Fri, 20 Dec 2002 12:06:56 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021220120656.GA20674@bjl1.asuk.net>
References: <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com> <3E02EC30.8030407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E02EC30.8030407@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a suggestion on a small performance improvement.

Ulrich Drepper wrote:
>   int $0x80  ->  call *%gs:0x18

The calling convention has been (slightly) changed - i.e. 6 argument
calls don't work, so why not go a bit further: allow the vsyscall entry
point to clobber more GPRs?

I see 3 pushes and pops in the vsyscall page (if I've looked at the
correct patch from Linus), to preserve %ecx, %edx and %ebp:

	vsyscall:
		pushl	%ebp
		pushl	%ecx
		pushl	%edx
	0:
		movl	%esp,%ebp
		sysenter
		jmp	0b
		popl	%edx
		popl	%ecx
		popl	%ebp
		ret

The benefit is that this allows Glibc to do a wholesale replacement of
"int $0x80" -> "single call instruction".  Otherwise, those pushes are
completely unnecessary.  It could be this short instead:

	vsyscall:
		movl	%esp,%ebp
		sysenter
		jmp	vsyscall
		ret

It is nice to be able to use the _exact_ same convention in glibc, for
getting a patch out of the door quickly.  But it is just as easy to do
that putting the pushes and pops into the library itself:

Instead of

	int $0x80 ->	call	*%gs:0x18

Write

	int $0x80 ->	pushl	%ebp
			pushl	%ecx
			pushl	%edx
			call	*%gs:0x18
			popl	%edx
			popl	%ecx
			popl	%ebp

It has exactly the same cost as the current patches, but provides
userspace with more optimisation flexibility, using an asm clobber
list instead of explicit instructions for inline syscalls, etc.

Cheers,
-- Jamie
