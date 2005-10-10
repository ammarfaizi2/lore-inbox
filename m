Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVJJMja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJJMja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVJJMja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 08:39:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8673 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750760AbVJJMj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 08:39:29 -0400
Date: Mon, 10 Oct 2005 14:39:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
In-Reply-To: <1128022423.8195.302.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0510100051230.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com> 
 <1127419198.8195.10.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0509271809460.3728@scrub.home>
  <1127852362.8195.215.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0509291658130.3728@scrub.home> <1128022423.8195.302.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Sep 2005, john stultz wrote:

> timekeeping_periodic_hook():
> 	now = timesource_read(ts)
> 	delta_cycle = now - last
> 	while (delta_cycle > interval_cycle):
> 		delta_cycle -= interval_cycle
> 		system_time += interval_nsec
> 		ntp_advance(interval_nsec)

I'm concerned about the clock stability of your code. By rounding it to 
nsec you throwing away a few bits of resolution (unless I'm missing 
something).

At http://www.xs4all.nl/~zippel/ntp/ there are a few patches to cleanup 
the kernel ntp calculations. I extracted the first two patches from your 
patches, the other patches precompute as much as possible so that the 
interrupt functions become quite simple and also fix a few rounding 
problems. What might be useful for you how second_overflow() calculates 
the advancement for the next HZ ticks. This means ntp_advance() isn't 
really needed at all, but instead second_overflow() precalculates 
everything for next second.

(The patches aren't documented yet and only for 2.6.13, I'll fix this 
soon).

I also included the modification for old ntp reference implementation to 
match this behaviour, so I could verify and test my changes in a 
simulator. I'd really like to have something like this for your 
implementation, so it's easier to look at its behaviour.

I started looking through the nanokernel implementation to see how it can 
be applied to Linux.

> > The basic idea of gettimeofday is of course always the same: "base + 
> > get_offset() * mult". I can understand the temptation to unify the 
> > implementation, but please accept the current reality that we have 
> > different gettimeofday implementations (for whatever reasons), so unifying 
> > them would be a premature change. If the situation changes later we can 
> > still do that unification.
> 
> I'm sorta going at it from the other way (call me optimistic :), where
> I'm trying to unify what I can until I hit the exception. Then I'll
> happily break out an arch specific gettimeofday implementation.

That's fine as long as doesn't change too much, but OTOH a little code 
duplication doesn't hurt. Concentration on introducing the time source 
abstraction is IMO currently more important, having more than one ntp 
implemenation is not such a big problem during development, so the need 
for a config option disappears and people can quickly switch between 
implementations, if there should be a problem.
In the end we actually may have slightly different NTP implementations, as 
each timesource may have different requirements of what needs to be 
precalculated for an efficient timer implementation. The unification 
should really be the last step, first we need to get the basic stuff 
right, then we can look at what can and should be optimized and only then 
should we cleanup the common things.

bye, Roman
