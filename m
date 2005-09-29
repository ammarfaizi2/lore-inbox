Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVI2SoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVI2SoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVI2SoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:44:06 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30082 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932349AbVI2SoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:44:05 -0400
Date: Thu, 29 Sep 2005 20:43:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
In-Reply-To: <1127852362.8195.215.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0509291658130.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com> 
 <1127419198.8195.10.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0509271809460.3728@scrub.home>
 <1127852362.8195.215.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Sep 2005, john stultz wrote:

> However, with you idea, on some arches we have to keep two timekeeping
> subsystems running at once, with code trying to smoothly synchronize
> them. I got a little frustrated trying to generate a clean
> implementation and decided to skip that idea for now. I'm not ruling it
> out, but I wanted to explore some other ideas I have.
> 
> So I started playing with a few different approaches in the short term,
> trying to adapt some of your ideas (such as using fixed interval time
> accumulation to avoid the multiply at tick time) to my existing code.

I don't want to keep you from playing with different ideas, but I would 
strongly suggest you do it first with an userspace simulator. If you 
change too much, be prepared to do some sort of analysis of these changes. 
A simulator would be one way, but plain math would be fine too.
It's really important that you get the math right first and then develop 
the kernel model from that. It would also be ok if you do a first 
prototype using nsec, but it's important to also look at the long term 
stability of the clock and how well it works together with the NTP daemon.

> The idea being:
> 
> update_wall_clock():
> 	ticks = jiffies - wall_jiffies
> 	while (ticks):
> 		ticks--
> 		xtime += tick_nsec + ntp_adjustment
> 
> 
> isn't that different from:
> 
> timekeeping_periodic_hook():
> 	now = timesource_read(ts)
> 	delta_cycle = now - last
> 	while (delta_cycle > interval_cycle):
> 		delta_cycle -= interval_cycle
> 		system_time += interval_nsec

BTW that's not what you do in the first part of the patch:

+static void ntp_advance(unsigned long interval_ns)

I'm quite sure that the interval_ns is wrong, it's important to advance 
the ntp state in constant intervals (i.e. interval_cycle). Your patch 
already includes time adjustments and e.g. the "while (interval_ns >= 
tick_nsec)" loop is not executed anymore, once time_adjust_step becomes 
negative.
In general I would prefer it if we could finalize the basic design first, 
before doing such changes, otherwise I'm afraid we need a cleanup of the 
cleanup.

> The only difference between continuous and tick based systems would then
> be in gettimeofday() (which really could be the same with a simple
> #define)
> 
> continuous_gettimeofday():
> 	now = timesource_read(ts)
> 	delta_cycle = now - last
> 	delta_nsec = cyc2ns(timesource, delta_cycle)
> 	return system_time + delta_nsec
> 
> tick_gettime():
> 	now = timesource_read(jiffes_timesource)
> 	delta_cycle = now - last
> 	delta_nsec = cyc2ns(timesource, delta_cycle)
> 	delta_nsec += arch_get_offset()
> 	return system_time + delta_nsec

The basic idea of gettimeofday is of course always the same: "base + 
get_offset() * mult". I can understand the temptation to unify the 
implementation, but please accept the current reality that we have 
different gettimeofday implementations (for whatever reasons), so unifying 
them would be a premature change. If the situation changes later we can 
still do that unification.

> Logic seen in the m68k time.c

I know that code and I really want to replace it with something better. :) 
Unfortunately I didn't catch the crap introduced by nsec conversion.

bye, Roman
