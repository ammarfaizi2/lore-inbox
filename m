Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLVDOz>; Sat, 21 Dec 2002 22:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbSLVDOy>; Sat, 21 Dec 2002 22:14:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264715AbSLVDOy>; Sat, 21 Dec 2002 22:14:54 -0500
Date: Sat, 21 Dec 2002 19:11:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021222021824.GA24485@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212211858240.8783-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Dec 2002, Jamie Lokier wrote:
>
> It is better to use iret with TF.  The penalty of forcing _every_
> system call to pushfl and popfl in user space is quite a lot: I
> measured 30 cycles for "pushfl;popfl" on my 366MHz Celeron.

Jamie, please stop these emails.

The fact is, when a user enters the kernel with TF set using "sysenter",
the kernel doesn't even _know_ that TF is set, because it will take a
debug trap on the very first instruction, and the debug handler has no
real option except to just return with TF cleared before the kernel even
had a chance to save eflags. So at no point in the sysenter/sysexit path
does the code have a chance to even _realize_ that the user called it with
single-stepping on.

So how do you want the code to figure that out, and then (a) set TF on the
stack and (b) do the jump to the slow path? Sure, we could add magic
per-process flags in the debug handler, and then test them in the sysenter
path - but that really is pretty gross.

Saving and restoring eflags in user mode avoids all of these
complications, and means that there are no special cases. None. Zero.
Nada.

Special case code is bad. It's certainly a lot more important to me to
have a straightforward approach that doesn't have any strange cases, and
where debugging "just works", instead of having a lot of magic small
details scattered all over the place.

So if you really care, create all your special case magic tricks, and see
just how ugly it gets. Then see whether it makes any difference at all
except on the very simplest system calls ("getpid" really isn't very
important).

			Linus

