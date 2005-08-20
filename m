Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVHTCck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVHTCck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 22:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVHTCck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 22:32:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48351 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932630AbVHTCcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 22:32:39 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508182213100.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 19:32:31 -0700
Message-Id: <1124505151.22195.78.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 02:27 +0200, Roman Zippel wrote:
> On Tue, 16 Aug 2005, john stultz wrote:
> > Maybe to focus this productively, I'll try to step back and outline the
> > goals at a high level and you can address those. 
> > 
> > My Assumptions:
> > 1. adjtimex() sets/gets NTP state values
> > 2. Every tick we adjust those state values
> > 3. Every tick we use those values to make a nanosecond adjustment to
> > time.
> > 4. Those state values are otherwise unused.
> > 
> > Goals:
> > 1. Isolate NTP code to clean up the tick based timekeeping, reducing the
> > spaghetti-like code interactions.
> > 2. Add interfaces to allow for continuous, rather then tick based,
> > adjustments (much how ppc64 does currently, only shareable).
> 
> Cleaning up the code would be nice, but that shouldn't be the priority 
> right now, first we should get the math right.
> I looked a bit more on this aspect of your patch and I think it's overly 
> complex even for continuous time sources. You can reduce the complexity 
> by updating the clock in more regular intervals. 

I feel in some ways I do this (inside the second overflow loop), but
maybe I'm misunderstanding you.


> What basically is needed to update in constant intervals (n cycles) a 
> reference time controlled via NTP and the system time. The difference 
> between those two can be used to adjust the cycle multiplier for the next 
> n cycles to speed up or slow down the system clock.
> Calculating the offset in constant intervals makes the math a lot simpler, 
> basically the current code is just a special case of that, where it 
> directly updates the system time from the reference time at every tick.
> (In the end the differences between tick based and continuous sources may 
> be even smaller than your current patches suggest. :) )

That would be great! So, would you mind helping me scratch out some
pseudo code for your idea?

Currently we have something like: 
===============================================
do_adjtimex():
	set ntp_status/maxerror/esterror/constant values
	set ntp_freq
	set ntp_tick
	if (singleshot_mode):
		set ntp_adjtime_offset
	else:
		set ntp_offset
		if appropriate, adjust ntp_freq


timer_interrupt():
	if (second_overflow):
		adjust ntp_maxerror/status
		/* calculate per tick phase adjustment 
		   using ntp_offset and ntp_freq
		*/
		sub_offset = math(ntp_offset)
		ntp_offset -= sub_offset
		phase_adj = math(sub_offset)		
		phase_adj += math(ntp_freq)

		leapsecond_stuff()

	tick_adjustment = 0;

	/* calculate singleshot adjustment */
	if (ntp_adjtime_offset):
		adj = min(ntp_adjtime_offset, tick_adj)
		ntp_adjtime_offset -= adj
	
		tick_adjustment += adj

	/* calculate the phase adjustment */
	phase += phase_adj
	if (phase > UNIT):
		phase -= UNIT
		tick_adjustment += UNIT


	xtime += ntp_tick + tick_adjustment



gettimeofday():
	return xtime + hardware_offset()




For continuous timesources, I'd like to see something like:
===============================================
do_adjtimex():
	no changes, only the addition of
	ntp_tick_ppm = calulate_ppm(ntp_tick)


timekeeping_perioidic_hook():

	/* get ntp adjusted interval length*/
	interval_length = get_timesource_interval(ppm)

	/* accumulate the NTP adjusted interval */
	xtime += interval_length

	/* inform NTP state machine that we have 
	   applied the last calculated adjustment for 
	   the interval length
	*/

	ntp_interval += interval_length
	while (ntp_interval > SECOND): /* just like second_overflow */
		adjust ntp_maxerror/status
		/* calculate the offset ppm adjustment */
		sub_offset = math(ntp_offset)
		ntp_offset -= sub_offset
		offset_ppm = math(sub_offset)

		/* same thing for single shot ntp_adjtime_offset */
		sub_ss_offset = math(ntp_adjtime_offset)
		ntp_adjtime_offset -= sub_ss_offset
		ss_offset_ppm = math(sub_ss_offset)


	/* sum up the ppm adjustments into a single ntp adjustment */
	ppm = offset_ppm + ntp_freq + ss_offset_ppm + ntp_tick_ppm

	leapsecond_stuff()

do_gettimeofday():
	interval = get_timesource_interval(ppm)
	return xtime + interval



Now could you adapt this to better show me what you're thinking of?

thanks
-john




