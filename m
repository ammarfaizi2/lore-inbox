Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLUTcu>; Sat, 21 Dec 2002 14:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSLUTcu>; Sat, 21 Dec 2002 14:32:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29447 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263899AbSLUTcs>; Sat, 21 Dec 2002 14:32:48 -0500
Date: Sat, 21 Dec 2002 11:39:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021221171808.GA23577@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212211127240.2168-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Dec 2002, Jamie Lokier wrote:
>
> Linus Torvalds wrote:
> > Yes, you can make the "clobbers %eax/%edx/%ecx" argument, but the fact is,
> > we quite fundamentally need to save %edx/%ecx _anyway_.
>
> On the kernel side, yes.  In the userspace trampoline, it's not required.

No, it _is_ required.

There are a few registers that _have_ to be saved on the user side,
because the kernel will trash them. Those registers are:

 - eflags (kernel has no sane way to restore things like TF in it
   atomically with a sysexit)
 - ebp (kernel has to reload it with arg-6)
 - ecx/edx (kernel _cannot_ restore them).

Your games with looking at %eip are fragile as hell.

> You're optimising the _rare_ case.

NO. I'm making it WORK.

> This is accompanied by changing this line in arch/i386/kernel/signal.c:
>
> 	regs->eip -= 2;

You're full of it.

You're adding fundamental complexity and special cases, because you have
a political agenda that you want to support, that is not really
supportable.

The fact is, system calls have a special calling convention anyway, and
doing them the way we're doing them now is a hell of a lot saner than
making much more complex code. Saving and restoring the two registers
means that they get easier and more efficient to use from inline asms for
example, and means that the code is simpler.

Your suggestion has _zero_ advantages. Doing two register pop's takes a
cycle, and means that the calling sequence is simple and has no special
cases.

Th eexample code you posted is fragile as hell. Looking at "eip" means
that the different system call entry points now have to be extra careful
not to have the same return points, which is just _bad_ programming.

		Linus


