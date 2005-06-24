Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVFXAeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVFXAeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVFXAeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:34:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52892 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262916AbVFXAdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:33:18 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506231157180.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
	 <1119311734.9947.143.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506211542580.3728@scrub.home>
	 <1119401841.9947.255.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506221739510.3728@scrub.home>
	 <1119486592.9947.354.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506231157180.3728@scrub.home>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 17:33:11 -0700
Message-Id: <1119573191.24889.110.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 23:59 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 22 Jun 2005, john stultz wrote:
> 
> > Some other architectures try to handle these situations as well. One
> > good example is PPC64 (which has greatly influenced my design). For
> > correctness PPC64 goes as far as not using interpolation by avoiding
> > almost all of the arch generic time code. It even has its own NTP
> > adjustment code! 
> > 
> > I have come to believe the current arch generic tick based timekeeping
> > is not sustainable. It seems to me in order to avoid bugs that customers
> > are seeing, arches are going to have to avoid the current tick based
> > arch generic code and implement their own non-interpolated based
> > timekeeping code. So that is why I've created this proposal and
> > implementation instead of just "fixing one issue".
> 
> I agree with you that the current time code is a problem for machines like 
> ppc64, which basically use two different time sources.
> 
> We basically have two timer architectures: timer tick and continuous 
> timer. The latter currently has to emulate the timer tick. Your patch 
> completely reverses the rolls and forces everybody to produce a continuous 
> timer, which I think is equally bad, as some simple computations become a 
> lot more complex. Why should it not be possible to support both equally?

Yep, I think this is really the core contention. 

In my design I've reworked the time subsystem to assume time flows
continuously as provided by the timesource. On systems that do not have
a continuous counters like the PPC timebase, they can use a similar tick
based interpolation method to provide continuous time. However this
interpolation is done in the timesource driver instead of in the generic
code.

I do feel my design is more flexible then the current tick based code as
it can accommodate both methods equally and correctly. However your
complaint is that it is more computationally expensive for the tick
based systems, and that is a fair criticism.

So what I'm working on now is to get some more detailed numbers and
analysis of the code paths so we can be more specific in our discussion.
Hopefully this will help narrow the concern so I can properly address
it.


> > So the question becomes: in order to achieve correctness, should every
> > architecture implement a full timeofday subsystem of its own? I designed
> > a system that would work, but instead of making it i386 and copying it
> > for x86-64 and whatever else I end up working on, I propose we make it a
> > common implementation.
> 
> That might result in the worst of both worlds. If I look at the ppc64 
> implementation of gettimeofday, it's really nice and your (current) code 
> would make this worse again. 

Could you be more specific about how you feel the ppc64 is nice and how
my code is worse? My code is actually quite influenced by the ppc64
code, so specific details might help me respond.

> So why not leave it to the timer source, if 
> it wants to manage a cycle counter or a xtime+offset? The common code can 
> provide some helper functions to manage either of this. Converting 
> everything to nanoseconds looks like a really bad compromise.
> 
> In the ppc64 example the main problem is that the generic tries to adjust 
> for the wrong for the time source - the scheduler tick, which is derived 
> from the cycle counter, so it has to redo all the work. Your code now 
> introduces an abstract concept of nanosecond which adds extra overhead to 
> either timer concept. Why not integrating what ppc64 does into the current 
> timer code instead of replacing the current code with something else?

I'm not sure I followed that paragraph. Would you clarify a bit?

Also I'd not consider the concept of a nanosecond to be abstract at
all. :) In fact one of the reasons I worked around nanoseconds is
because it is very clear and understandable as to what it means. Now,I
agree that performance should override clarity, but clarity should be a
goal. A complaint I've dealt with is that the current time subsystem is
too fragile and confusing, so some cleanups are in order.

That said, I also agree that if possible cleanups and functional changes
should be separated. I'm looking to see how this might be possible.

> For tick based timer sources there is not much to do than incrementing 
> xtime by precomputed constant. If I take ppc64 as an example for 
> continuous time sources it does a lot less than your 
> timeofday_periodic_hook(). Why is all this needed?

timeofday_periodic_hook() does the following every 50ms:
	o read the timesource, save it as now
	o calculate the amount of NTP adjusted time that has past
	o calculate the amount of raw time that has past
	o Increment the system_time by the calculated NTP adjusted time
	o advance the NTP state machine by the raw time interval
	o do leapsecond processing
	o syncs the persistent clock (if appropriate)
	o do a bit of timesource management
	o calculate NTP adjustment for the current timesource
	o update legacy time variables (xtime, wall_to_monotonic)
	o update vsyscall info (if used)
	o reprogram soft-timer


ppc64's timer_interrupt code does the following each tick.
	o reads the timebase
	o calculates the amount of time that has past
	o saves the current offset
	o calls do_timer 
		o increments xtime by one tick
		o increments the generic NTP state machine
			o Does leapsecond processing
	o overwrites xtime (to avoids interpolation)
	o sync the persistent clock (if appropriate)
	o Calls into their internal NTP code
		o calculates the NTP adjustment for their timebase

Just logically (as opposed to computationally), my code isn't all that
more complex. I'm a little more explicit with my NTP adjustments because
I wanted to be very careful to do them properly and insure we do not get
time inconsistencies. And the timesource management is new but is
reasonably cheap. Maybe you can point to a specific component of the
above that you dislike?

Computationally, there are two 64bit mult/shifts (in the interval
calculations) and a 64 bit divide that occurs in my code. However this
is only done every 50ms instead of every tick, so I don't believe there
is much of a performance impact.


> John, what I'd really like to see here is some math or code examples, 
> which demonstrate how your new code is better compared to the old code. 
> Your code makes a _huge_ transformation jump and I'd like you to explain 
> some of the steps inbetween.

This discussion is difficult to have with the current large patch. I'm
trying to see where I can split it up into components that will help
narrow the discussion.  First up, I'm going to try to make the NTP
cleanups on their own. Then I can see what else can be moved in.

Thanks again, I'll look forward to your feedback on future releases.
-john




