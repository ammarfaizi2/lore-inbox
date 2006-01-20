Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWATEBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWATEBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWATEBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:01:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:31211 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161483AbWATEBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:01:53 -0500
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512252154.09253.zippel@linux-m68k.org>
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
	 <1135219395.5873.96.camel@leatherman>
	 <200512252154.09253.zippel@linux-m68k.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 20:01:34 -0800
Message-Id: <1137729694.27699.250.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Roman,
	Finally getting around continuing this discussion. Sorry for the long
wait.

On Sun, 2005-12-25 at 21:54 +0100, Roman Zippel wrote:
> On Thursday 22 December 2005 03:43, john stultz wrote:
> > Your design seems to suggest keeping an NTP calculated reference time
> > that the timekeeping code uses to correct itself from (again, let me
> > know if I'm mis-understanding you).  In my view this is a little
> > redundant, because fundamentally this is what the ntp daemon and
> > adjtimex is already doing. The daemon uses the server's reference time
> > and figures out how far off it is from the OS's system time. It does
> > some filtering and feeds that offset into adjtimex where it is dampened
> > and used to modify a frequency adjustment.
> 
> Indeed, the main part here is really the long term stability, my code corrects 
> small errors immediately, where you leave this to the next ntp 
> synchronisation step.

After re-reading your code a bit I think I do finally understand this
bit. Just to be sure (and for anyone else who cares to follow along),
I'll restate it.

So the aproximation of my current code is as follows:

/* Ignore sub-nanosecond remainder accounting.
 * Also ignore dealing with switching clocksources 
 * or clocksources that change freq.
 */

/* global state values */
u64 system_time

/* clocksource specific values */
u64 last
u32 mult, shift
s32 adj

u64 interval_cycles
u64 interval_nsecs


u64 cyc2ns(u64 cycles):
	return (cycles*(mult+adj))>>shift

u64 monotonic_clock():
	u64 now = read_cycles()
	u64 delta = now - last
	return system_time + cyc2ns(delta)


u64 cyc2ns_fixed(u64* cycles):
	u64 delta_nsec = 0;
	while (*cycles > interval_cycles):
		*cycles -= interval_cycles
		delta_nsec += interval_nsecs
	return delta_nsec

s32 ppm2adj(s32 ppm):
	int ret_adj
	u64 mult_adj = abs(ppm);

	/* convert from shifted ppm to clocksource mult units */
	mult_adj = signed_shift_right((mult_adj * mult),SHIFT_USEC)
	do_div(mult_adj, 1000000)
	ret_adj = (int)mult_adj
	return ret_adj;

periodic_hook():
	static int last_ppm;
	/* calculate interval, and accumulate time */
	u64 now = read_cycles()
	u64 delta_cycles = now - last
	u64 delta_nsec = cyc2ns_fixed(&delta_cycles)
	last = now - delta_cycles

	system_time += delta_nsec

	ntp_advance(delta_nsec)
	ppm = get_ntp_ppm()
	if (last_ppm != ppm):
		last_ppm = ppm
		/* accumulate left-over delta_cycles */
		delta_nsec = cyc2ns(delta_cycles)
		system_time += delta_nsec
		ntp_advance(delta_nsec)

		/* calculate new adj value & interval*/
		adj = ppm2adj(ppm)
		interval_nsecs = cyc2ns(interval_cycles)


The problem being: I take a high-resolution value from NTP (shifted ppm
value) and convert it to a fairly course multiplier adjustment. Thus any
small adjustment (smaller then a multiplier unit) from NTP is ignored
until the error grows large enough for the NTP daemon to notice and
correct back. 

Your suggested solution accumulates the adjustment error and
compensates, allowing for cumulative adjustments of fractional
multiplier units (for example,  three intervals w/ adj=0, then for one
interval adj=1 allowing for a multiplier adjustments of 1/4th).


So, we're in sync with the above....


My issue is, that your code to implement this, while computationally
very efficient, is very hard to read and understand. So I've tried to
re-implement it in logical chunks that are a bit easier to digest. So
using most of the above code:


u64 cyc2ns_fixed(u64* cycles, u64 ideal_interval, u64* errror):
	u64 delta_nsec = 0;
	while (*cycles > interval_cycles):
		*cycles -= interval_cycles
		delta_nsec += interval_nsecs
		*error += ideal_interval - interval_nsecs 
	return delta_nsec

int calculate_adj_factor(u64 error, u32 length):
	static int saved_error_adj
	int current_adj = saved_error_adj

	/* this is basically binary approximation */
	u64 adjusted_interval = (u64)length << current_adj
	if (ntp_error > (adjusted_interval * 2)):
		/* large error, so increment the adjustment factor */
		saved_error_adj++
		current_adj++
	else if (ntp_error > adjusted_interval):
		/* just right, don't touch it */
	else if (current_adj):
		/* small error, so drop the adjustment factor */
		saved_error_adj--
		current_adj = 0
	return current_adj


periodic_hook():
	static u64 adj_error;

	/* calculate interval, and accumulate time */
	u64 now = read_cycles()
	u64 delta_cycles = now - last
	u64 ntp_interval = ntp_get_interval()
	u64 delta_nsec = cyc2ns_fixed(&delta_cycles, ntp_interval,
					&adj_error)
	last = now - delta_cycles

	system_time += delta_nsec

	ntp_advance(delta_nsec)

	/* check if NTP adjutment error is too large */
	if (abs(adj_error) > interval_cycles/2):
		u32 adj_factor = calculate_adj_factor(abs(adj_error),
							interval_cycles)

		/* Before changing adj, accumulate the left over
		 * delta_cycles:
		 *
		 * XXX - You do this differently, avoiding the mult
		 * but to limit the discussion, here's the inefficient
		 * method:
		 */
		delta_nsec = cyc2ns(delta_cycles)
		system_time += delta_nsec
		ntp_advance(delta_nsec)

		/* change adj */
		if(adj_error > 0):
			adj += 1<<adj_factor
		else:
			adj -= 1<<adj_factor

		/* we can avoid the mult here using
		 * +/-(interval_cycles<<adj_factor), but for
		 * the sake of understandability:
		 */
		interval_nsecs = cyc2ns(interval_cycles)
		


Does this basically jive w/ what you are suggesting with regard to the
NTP error accumulation and adjustment?

thanks
-john

