Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVI2TeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVI2TeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVI2Tdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26851 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964816AbVI2Tdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:46 -0400
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0509291658130.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
	 <1127419198.8195.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509271809460.3728@scrub.home>
	 <1127852362.8195.215.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509291658130.3728@scrub.home>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 12:33:42 -0700
Message-Id: <1128022423.8195.302.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 20:43 +0200, Roman Zippel wrote:
> On Tue, 27 Sep 2005, john stultz wrote:
> > The idea being:
> > 
> > update_wall_clock():
> > 	ticks = jiffies - wall_jiffies
> > 	while (ticks):
> > 		ticks--
> > 		xtime += tick_nsec + ntp_adjustment
> > 
> > 
> > isn't that different from:
> > 
> > timekeeping_periodic_hook():
> > 	now = timesource_read(ts)
> > 	delta_cycle = now - last
> > 	while (delta_cycle > interval_cycle):
> > 		delta_cycle -= interval_cycle
> > 		system_time += interval_nsec
> 
> BTW that's not what you do in the first part of the patch:
> 
> +static void ntp_advance(unsigned long interval_ns)

Well, I was trying to describe what I am going to follow the NTP patches
with. 

So yes, the reduced NTP rework patches are not discussed in the above
(but ntp_advance() does have a place in the above, I just left it out to
shorten the comparison), but they allow the two examples above to look
similar. 

For clarity here's the ntp details included

update_wall_clock():
	ticks = jiffies - wall_jiffies
	while (ticks):
		ticks--
		xtime += tick_nsec + ntp_adjustment
		ntp_advance(tick_nsec)


timekeeping_periodic_hook():
	now = timesource_read(ts)
	delta_cycle = now - last
	while (delta_cycle > interval_cycle):
		delta_cycle -= interval_cycle
		system_time += interval_nsec
		ntp_advance(interval_nsec)


> I'm quite sure that the interval_ns is wrong, it's important to advance 
> the ntp state in constant intervals (i.e. interval_cycle). Your patch 
> already includes time adjustments and e.g. the "while (interval_ns >= 
> tick_nsec)" loop is not executed anymore, once time_adjust_step becomes 
> negative.

Commenting the specific code would help clarify this. If I'm
understanding you, you're talking about the following logic:

static void ntp_advance(unsigned long interval_ns):
	static unsigned long interval_sum;

	/* increment the interval sum */
	interval_sum += interval_ns

	/* calculate the per tick singleshot adjtime adjustment step */
	while (interval_ns >= tick_nsec):
		time_adjust_step = time_adjust
		if (time_adjust_step):
			time_adjust_step = min(time_adjust_step, tickadj)
			time_adjust_step = max(time_adjust_step, -tickadj)
			time_adjust -= time_adjust_step
		interval_ns -= tick_nsec

I'm not sure I understand the problem if time_adjust_step becomes
negative.

> In general I would prefer it if we could finalize the basic design first, 
> before doing such changes, otherwise I'm afraid we need a cleanup of the 
> cleanup.

Well, that's evolution. :)  But really, the reduced ntp rework stuff
isn't a cleanup. Its just the bare minimum changes to NTP that I'm
needing for my generic timeofday code. Hopefully the reduced changes
will clarify what exactly I need (or think I need ;) from the NTP
subsystem to get my timekeeping code to function properly. Then maybe
you (or anyone else - don't let Roman have all the fun) can point to a
better way. 


> > The only difference between continuous and tick based systems would then
> > be in gettimeofday() (which really could be the same with a simple
> > #define)
> > 
> > continuous_gettimeofday():
> > 	now = timesource_read(ts)
> > 	delta_cycle = now - last
> > 	delta_nsec = cyc2ns(timesource, delta_cycle)
> > 	return system_time + delta_nsec
> > 
> > tick_gettime():
> > 	now = timesource_read(jiffes_timesource)
> > 	delta_cycle = now - last
> > 	delta_nsec = cyc2ns(timesource, delta_cycle)
> > 	delta_nsec += arch_get_offset()
> > 	return system_time + delta_nsec
> 
> The basic idea of gettimeofday is of course always the same: "base + 
> get_offset() * mult". I can understand the temptation to unify the 
> implementation, but please accept the current reality that we have 
> different gettimeofday implementations (for whatever reasons), so unifying 
> them would be a premature change. If the situation changes later we can 
> still do that unification.

I'm sorta going at it from the other way (call me optimistic :), where
I'm trying to unify what I can until I hit the exception. Then I'll
happily break out an arch specific gettimeofday implementation.

Once again, I do appreciate your feedback. Hopefully I'll have patches
out later today for you to look at.

thanks
-john



