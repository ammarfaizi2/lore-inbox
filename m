Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVJJUrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVJJUrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVJJUrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:47:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35497 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751219AbVJJUrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:47:00 -0400
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0510100051230.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
	 <1127419198.8195.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509271809460.3728@scrub.home>
	 <1127852362.8195.215.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509291658130.3728@scrub.home>
	 <1128022423.8195.302.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0510100051230.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 13:46:46 -0700
Message-Id: <1128977206.21918.35.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 14:39 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 29 Sep 2005, john stultz wrote:
> 
> > timekeeping_periodic_hook():
> > 	now = timesource_read(ts)
> > 	delta_cycle = now - last
> > 	while (delta_cycle > interval_cycle):
> > 		delta_cycle -= interval_cycle
> > 		system_time += interval_nsec
> > 		ntp_advance(interval_nsec)
> 
> I'm concerned about the clock stability of your code. By rounding it to 
> nsec you throwing away a few bits of resolution (unless I'm missing 
> something).

Nope, you're right. That's very much an issue that I glossed over in
this example. In fact, in the B6 release, I added a remainder field to
the interval structure, but I didn't get to implementing the details. I
do have the code implemented for B7, which I hope to release later this
week.


> At http://www.xs4all.nl/~zippel/ntp/ there are a few patches to cleanup 
> the kernel ntp calculations. I extracted the first two patches from your 
> patches, the other patches precompute as much as possible so that the 
> interrupt functions become quite simple and also fix a few rounding 
> problems. What might be useful for you how second_overflow() calculates 
> the advancement for the next HZ ticks. This means ntp_advance() isn't 
> really needed at all, but instead second_overflow() precalculates 
> everything for next second.

Great! I think having more minds working at cleaning up this code will
really help. Hopefully having concrete code implementations to compare
will give us additional common ground to work from. 

I think calculating all the adjustments into second overflow doesn't
sound objectionable, although it does seemingly bind us to second
intervals. Having the ntp_advance interface allows the implementation
internally to be flexible for whatever interval. But it doesn't sound
like a major issue at the moment.


> (The patches aren't documented yet and only for 2.6.13, I'll fix this 
> soon).

Let me know when they've been updated. I've looked over them and have a
few questions that probably would be easily answered with a small
comment.


> I also included the modification for old ntp reference implementation to 
> match this behaviour, so I could verify and test my changes in a 
> simulator. I'd really like to have something like this for your 
> implementation, so it's easier to look at its behaviour.

I'll take a look at this and see if I can do similar. Its a little more
difficult because moving from tick based to continuous adds some
complexity to the simulation.


> I started looking through the nanokernel implementation to see how it can 
> be applied to Linux.

Nice.


> > > The basic idea of gettimeofday is of course always the same: "base + 
> > > get_offset() * mult". I can understand the temptation to unify the 
> > > implementation, but please accept the current reality that we have 
> > > different gettimeofday implementations (for whatever reasons), so unifying 
> > > them would be a premature change. If the situation changes later we can 
> > > still do that unification.
> > 
> > I'm sorta going at it from the other way (call me optimistic :), where
> > I'm trying to unify what I can until I hit the exception. Then I'll
> > happily break out an arch specific gettimeofday implementation.
> 
> That's fine as long as doesn't change too much, but OTOH a little code 
> duplication doesn't hurt. Concentration on introducing the time source 
> abstraction is IMO currently more important, having more than one ntp 
> implemenation is not such a big problem during development, so the need 
> for a config option disappears and people can quickly switch between 
> implementations, if there should be a problem.

I'm not too worried about needing separate NTP implementations, as
fundamentally all we do is take a number of adjustment values, merge
them into one adjustment value and apply that as we maintain time. If
the output is a flat per-tick nanosecond adjustment or a continuous
shifted ppm adjustment, the core state machine management will be the
same.

> In the end we actually may have slightly different NTP implementations, as 
> each timesource may have different requirements of what needs to be 
> precalculated for an efficient timer implementation. The unification 
> should really be the last step, first we need to get the basic stuff 
> right, then we can look at what can and should be optimized and only then 
> should we cleanup the common things.

Again, with my smaller set of changes and with your new changes I don't
think fully separate implementations will be required (and even more so
WRT per-timesource ntp implementations). But I think working this from
multiple approaches will better clarify the specific needs we both have.

thanks
-john

