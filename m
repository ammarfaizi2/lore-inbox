Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSGWXwg>; Tue, 23 Jul 2002 19:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSGWXwf>; Tue, 23 Jul 2002 19:52:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315631AbSGWXwd>; Tue, 23 Jul 2002 19:52:33 -0400
Date: Tue, 23 Jul 2002 16:56:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: george anzinger <george@mvista.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in
 2.5.27?]
In-Reply-To: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207231650200.6537-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, Ingo Molnar wrote:
>
>  - slab.c needs to spin_unlock_no_resched(), instead of spin_unlock(). (It
>    also has to check for preemption in the right spot.) This should fix
>    the memory corruption.

That cannot be right.

If we want to drop a spinlock but remain non-preemptible, we should
comment that a _lot_, and not just say "xxxx_no_resched()".

In fact, I personally think that every "spin_unlock_no_resched()" is an
outright BUG. Either the spin_unlock() makes us preemptible (in which case
it doesn't matter from a correctness point whether we schedule
immediately, or whether something else like a vmalloc fault might force us
to schedule soon afterwards), or the spin_unlock is doing something
magical, and we depend on the preemptability to not change.

In the latter case (which should be very very rare indeed), we should just
use

	/* BIG comment about what we're doing. */
	/* We're dropping the spinlock, but we remain non-preemptable */
	__raw_spin_unlock(..);

and then later on, when preemptability is over, we do

	local_irq_enable();
	preempt_enable();

so that we _clearly_ mark out the region where we must not re-schedule.

It is simply not acceptable to just play games with disabling interrupts,
and magically "knowing" that we're not preemptable without making that
clear some way.

Please get rid of spin_unlock_no_schedule() and friends, ok?

			Linus

