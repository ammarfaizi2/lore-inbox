Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSGXQgD>; Wed, 24 Jul 2002 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSGXQgD>; Wed, 24 Jul 2002 12:36:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317393AbSGXQgC>; Wed, 24 Jul 2002 12:36:02 -0400
Date: Wed, 24 Jul 2002 09:40:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
In-Reply-To: <3D3E5E80.EA769517@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207240927370.15114-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, Andrew Morton wrote:
>
> But there is no bug in slab.  The bug is that spin_unlock() is
> scheduling inside local_irq_disable().

I disagree.

There is no reason to believe that you can mix irq disables and
spinlocking willy nilly. The two have commonalities, and thinking that you
can build up your own special irq-safe spinlocks by hand just isn't
_true_.

The bug is conceptually definitely in slab.c - although we can't blame it
too much since we've modified some behaviour.

Just as an example, in the not too distant future what _will_ happen is
that

	spin_lock_irqsave()
	..
	spin_unlock_irqrestore()

will not necessarily increment the preemtion count. Why should they?
They've disabled local interrupts, so there's no preemption to protect
against. That's just an _obvious_ optimization.

But that optimization also means that you _have_ to pair the things
properly. It is incorrect and buggy to play pairing games. The same way
you could not pair the global irq lock with a local unlock, you cannot
play games with local_irq_disable() and spinlocks, and expect it to "just
work".

Normal code should always pair these primitives. And, in fact, 99% of all
code _does_ pair them properly, and people would consider anything else
strange.

The 1% (or less) of code that thinks it wants to be clever will have to
live with that decision. We will have code that does the preemption
regions by hand, and some day you will need to do

	spin_lock_irqsave(..)
	...
	...
	preempt_disable();
	spin_unlock(..);
	...
	...
	local_irq_restore(..);
	preempt_enable();

if you want to do what slab apparently wants to do right now.

In short, you should _always_ write out what you actually expect of the
environment. Making the assumption that "spin_lock_irqsave" is 100% the
same as "local_irq_save + preempt_disable + __spin_lock" is a BUG, simply
because it assumes something that has never been guaranteed, and is
nothign but an implementation detail.

> Are you implying that all code which does spin_unlock() inside
> local_irq_disable() needs to be converted to use _raw_spin_unlock()?
> If so then, umm, ugh.  I hope that the debug check is working
> for CONFIG_PREEMPT=n.

I'm saying that preempt will have the irq check (for safety and debugging,
and it will scream if somebody does something bad), and I'm saying
outright that if you expect to not be scheduled, you should _tell_ the
kernel so, instead of just thinking that it's implied by something else.

You can nest spinlocks any amount you want, but no, you cannot just assume
that nesting irq disables and spinlocks gives you the same thing as using
the irq-safe spinlocks.

We can easily add a debugging check to spin_unlock() that says:

	/* Somebody messed up, doesn't hold any other preemption thing
	 * than this lock that is now getting released, and has interrupts
	 * disabled
	 */
	BUG_ON(preempt_count() == 1 && interrupts_enabled())

No?

		Linus

