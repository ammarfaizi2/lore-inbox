Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVJTI4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJTI4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 04:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJTI4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 04:56:44 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27388 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750740AbVJTI4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 04:56:44 -0400
Date: Thu, 20 Oct 2005 04:56:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <20051020080107.GA31342@elte.hu>
Message-ID: <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu>
 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Slightly different issue.

I just ran hackbench as a high priority process (higher than the tasklets)
and it once again has sys_gettimeofday going backwards.  It runs for 30
seconds, hogging the CPU from all other processes, and the gettimeofday
once again overflows.  This time it's more complex than then last time
because of the changes (I guess John) made.

Following the code into sys_gettimeofday, I end up at __get_nsec_offset.

static inline nsec_t __get_nsec_offset(void)
{
	cycle_t cycle_now, cycle_delta;
	nsec_t ns_offset;

	/* read clocksource */
	cycle_now = read_clocksource(clock);

	/* calculate the delta since the last timeofday_periodic_hook */
	cycle_delta = (cycle_now - cycle_last) & clock->mask;

	/* convert to nanoseconds */
	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);

	/* Special case for jiffies tick/offset based systems
	 * add arch specific offset
	 */
	ns_offset += arch_getoffset();

	return ns_offset;
}

cycle_now is 32 bits.  If the clocksource overflows (which it can in 30
seconds) the cyclec_delta will be wrong.

Not only this, but pretty much all places cycle_last is updated will be
wrong.

I'm not sure of a good fix around this. Please don't say (well, don't run
with priority above timers tasklet ;-)

Would it be OK to move some of the accounting to the sched_tick code. Or
someplace that only happens periodically.  Or is this too much of a
latency.  But then again, if we don't do something, a high priority
process can screw up the time keeping for all others.

-- Steve

