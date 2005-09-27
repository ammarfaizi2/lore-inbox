Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVI0UTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVI0UTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVI0UTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:19:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:24497 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932384AbVI0UTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:19:33 -0400
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0509271809460.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
	 <1127419198.8195.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509271809460.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 13:19:21 -0700
Message-Id: <1127852362.8195.215.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 18:37 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 22 Sep 2005, john stultz wrote:
> 
> > +
> > +	/* calculate the total continuous ppm adjustment */
> > +	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
> > +	total_sppm += offset_adj_ppm << SHIFT_USEC;
> > +	total_sppm += tick_adj_ppm << SHIFT_USEC;
> > +	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
> >  }
> 
> I'm not sure, why you still need this.
> As I already said, I don't think you need to change the kernel NTP model. 
> This means in particular that the NTP time is still incremented in fixed 
> intervals (although it's not necessary to do it at HZ frequency).
> I showed you how to do most of the calculation, so I'm a little confused, 
> why the above is still used.

Yea. I had spent some time implementing your idea about having a
reference xtime that is only NTP adjusted, then timesource based
system_time which adjusts the frequency of time timesource when
system_time and the ntp adjusted xtime drift apart. 

The biggest concern was having duplicate timekeeping subsystems in play
at once. 

With the approach I was taking earlier, I didn't like the idea of having
2 duplicate generic timekeeping systems that are different on different
arches, but I figured it would be be an improvement, since a number of
arches would then not need any arch specific timekeeping code (which is
not the case now).

However, with you idea, on some arches we have to keep two timekeeping
subsystems running at once, with code trying to smoothly synchronize
them. I got a little frustrated trying to generate a clean
implementation and decided to skip that idea for now. I'm not ruling it
out, but I wanted to explore some other ideas I have.

So I started playing with a few different approaches in the short term,
trying to adapt some of your ideas (such as using fixed interval time
accumulation to avoid the multiply at tick time) to my existing code.

Further I'm trying to slowly manipulate both the current tick based
update_wall_clock() and my timekeeping_periodic_hook() functions so that
they begin to resemble each other. This way I can begin to show
equivalence between the two. 


The idea being:

update_wall_clock():
	ticks = jiffies - wall_jiffies
	while (ticks):
		ticks--
		xtime += tick_nsec + ntp_adjustment


isn't that different from:

timekeeping_periodic_hook():
	now = timesource_read(ts)
	delta_cycle = now - last
	while (delta_cycle > interval_cycle):
		delta_cycle -= interval_cycle
		system_time += interval_nsec


Where ts is the jiffies timesource and the interval_nsec is a
precomputed equivalent to (tick_nsec + ntp_adjustment). 

The only difference between continuous and tick based systems would then
be in gettimeofday() (which really could be the same with a simple
#define)

continuous_gettimeofday():
	now = timesource_read(ts)
	delta_cycle = now - last
	delta_nsec = cyc2ns(timesource, delta_cycle)
	return system_time + delta_nsec

tick_gettime():
	now = timesource_read(jiffes_timesource)
	delta_cycle = now - last
	delta_nsec = cyc2ns(timesource, delta_cycle)
	delta_nsec += arch_get_offset()
	return system_time + delta_nsec


Which isn't all that different from the existing:
	usec = mach_gettimeoffset();
	lost = jiffies - wall_jiffies;
	/*
	 * If time_adjust is negative then NTP is slowing the clock
	 * so make sure not to go into next possible interval.
	 * Better to lose some accuracy than have time go backwards..
	 */
	if (unlikely(time_adjust < 0)) {
		usec = min(usec, max_ntp_tick);
		if (lost)
			usec += lost * max_ntp_tick;
	}
	else if (unlikely(lost))
		usec += lost * tick_usec;

	sec = xtime.tv_sec;
	usec += xtime.tv_nsec/1000;

Logic seen in the m68k time.c

With luck I'll have something more then just pseudo code to review soon.

thanks
-john


