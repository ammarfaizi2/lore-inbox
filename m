Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268618AbRGYTdp>; Wed, 25 Jul 2001 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268619AbRGYTdf>; Wed, 25 Jul 2001 15:33:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22624 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268618AbRGYTdQ>; Wed, 25 Jul 2001 15:33:16 -0400
Date: Wed, 25 Jul 2001 21:33:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010725213351.A32148@athlon.random>
In-Reply-To: <20010723162909.D822@athlon.random> <m15Oyat-000CD5C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15Oyat-000CD5C@localhost>; from rusty@rustcorp.com.au on Tue, Jul 24, 2001 at 07:35:10PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 07:35:10PM +1000, Rusty Russell wrote:
> In message <20010723162909.D822@athlon.random> you write:
> > > Why not fix all the cases?  Why have this wierd secret rule that
> > > cpu_raise_softirq() should not be called with irqs disabled?
> > 
> > cpu_raise_softirq _can_ be called with irq disabled too just now, irq
> > enabled or disabled has no influence at all on cpu_raise_softirq.
> 
> No, you are wrong.  If I do (NOT in a hw interrupt handler):
> 
> 	local_irq_save(flags);
> 	...
> 	cpu_raise_softirq(smp_processor_id(), FOO_SOFTIRQ);
> 	...
> 	local_irq_restore(flags);
> 
> ksoftirqd won't get woken, and the FOO soft irq won't get run until

You are wrong, please check again all the code involved.

inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
{
	__cpu_raise_softirq(cpu, nr);

	/*
	 * If we're in an interrupt or bh, we're done
	 * (this also catches bh-disabled code). We will
	 * actually run the softirq once we return from
	 * the irq or bh.
	 *
	 * Otherwise we wake up ksoftirqd to make sure we
	 * schedule the softirq soon.
	 */
	if (!(local_irq_count(cpu) | local_bh_count(cpu)))
		wakeup_softirqd(cpu);
}

If you are not in hw interrupt local_irq_count is zero so you will run
wakeup_softirqd().

The fact irq are enabled or disabled has no influence on the logic.

> the next interrupt comes in.  You solved (horribly) the analagous case
> for local_bh_disable/enable, but not this one.

I didn't changed at all local_bh_enable (except a fix for a missing
barrier()), local_bh_enable/disable was solved by Ingo in 2.4.6.

> Below as suggested in my previous email (x86 only, untested).  I also

It seems you're duplicating the local_irq_count functionalty plus you
break local_bh_enable, from local_bh_enable you want to run the softirq
immediatly.

> added a couple of comments.  There's still the issue of stack
> overflows if you get hit hard enough with interrupts (do_softirq is
> exposed to reentry for short periods), but that's separate.

do_softirq can be re-entered but on re-entry it will return immediatly
because local_bh_count will be non zero in such case, so the only stack
overhead of a re-entry is a few words so it cannot harm (if stack
overflows it cannot be because of do_softirq re-entry).

Andrea
