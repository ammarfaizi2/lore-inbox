Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLVCKm>; Sat, 21 Dec 2002 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLVCKm>; Sat, 21 Dec 2002 21:10:42 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:1153 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264702AbSLVCKl>;
	Sat, 21 Dec 2002 21:10:41 -0500
Date: Sun, 22 Dec 2002 02:18:24 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021222021824.GA24485@bjl1.asuk.net>
References: <20021221171808.GA23577@bjl1.asuk.net> <Pine.LNX.4.44.0212211127240.2168-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212211127240.2168-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  - eflags (kernel has no sane way to restore things like TF in it
>    atomically with a sysexit)

It is better to use iret with TF.  The penalty of forcing _every_
system call to pushfl and popfl in user space is quite a lot: I
measured 30 cycles for "pushfl;popfl" on my 366MHz Celeron.

("sysenter, setup segments, call a function in kernel space, restore
segments, sysexit" takes 82 cycles on the same Celeron, so 30 cycles
is quite a significant proportion to add to that.  Btw, _82_, not 200
or so).

>  - ebp (kernel has to reload it with arg-6)
>  - ecx/edx (kernel _cannot_ restore them).

These are only needed when delivering a signal.

> Your games with looking at %eip are fragile as hell.

Like we don't play %eip games anywhere else... (the page fault fixup
table comes to mind).

> because you have a political agenda that you want to support, that
> is not really supportable.

And there was me thinking I was performance-tuning some code.
Politics, it gets everywhere, like curry gets onto anything white.

> Saving and restoring the two registers
> means that they get easier and more efficient to use from inline asms for
> example, and means that the code is simpler.

They are not more efficient from inline asms, though marginally
simpler to write (shorter clobber list).  You just moved the cost from
the asm itself, where it is usually optimised away, to the trampoline
where it is always present (and cast in stone).

> Your suggestion has _zero_ advantages. Doing two register pop's takes a
> cycle, and means that the calling sequence is simple and has no special
> cases.

(Plus another cycle for the two pushes...)

> Th eexample code you posted is fragile as hell. Looking at "eip" means
> that the different system call entry points now have to be extra careful
> not to have the same return points, which is just _bad_ programming.

We are talking about a _very_ small trampoline, which is simplicity
itself compared with entry.S in general.  You're right about the extra
care (so write a comment!), although it does just work for _all_ entry
points.  Is this really worse than your own "wonderful hack"?

<shrug> You're the executive decision maker.  I just know how to
write fast code.  Thanks for listening.

-- Jamie
