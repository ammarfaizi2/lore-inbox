Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVIWCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIWCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 22:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVIWCZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 22:25:09 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53670 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751124AbVIWCZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 22:25:06 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509221816030.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 19:25:01 -0700
Message-Id: <1127442302.8195.121.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 01:09 +0200, Roman Zippel wrote:
> On Thu, 22 Sep 2005, Thomas Gleixner wrote:
> > > It also doesn't explain how it will interact with Johns work,
> > 
> > "The following add on patches are not provided for ad hoc inclusion as
> > they contain third party patches. The reason for providing this series
> > is to demonstrate the future use of ktimers and the simple extensibility
> > for the impelemtation of high resolution timers. Especially John Stultz
> > timeofday patch is a complete seperate issue
> > and just used due to the ability to provide high resolution timers in a
> > simple and non intrusive way."
> > 
> > Isn't this clear enough ?
> 
> No and I explained why I think that these are not separate issues at all.

You had a long response, and some of the terminology is confusing, so
I'm not sure exactly how to help address your concern. 

You did accurately summarized that in my patches I introduced two major
generic concepts:
1. The time source abstraction of a free-running counter to be used for
timekeeping. (Note: not "timer source" - timers generate interrupts,
time sources do not necessarilly)
2. Allowing the wall-clock (as well as a monotonic system clock) to run
independent of timer ticks, via the time source abstraction.

Your complaint was that in making these change the NTP model has been
changed, although I'm not sure if I agree, but hopefully the patches I
sent out today can continue that discussion. :) 

It is my claim that these two concepts allow for correct and robust
timekeeping, and additionally give some flexibility so larger change
(such as dynamic ticks) can be made without worrying too much about
their effect on timekeeping. However, it does not provide anything
interface wise that is not currently exist, it just merely cleans some
of the interfaces up.

So, ignoring correctness in the face of lost ticks and other timekeeping
problems, my patch is not strictly necessary for what Thomas is doing.
It just so happens that my do_monotonic_clock() interface provided a
correct monotonic system time in nanoseconds and that meshed very well
with Thomas' work.


> > > Ok, so what's missing? From a basic design overview I would expect some 
> > > information about types of time within the kernel and their relationship. 
> > > We basically have three types:
> > > - scheduler time
> > > - wallclock time
> > > - process time


My clarity in writing is sometimes an issue, but let me take a shot at
it(Thomas, or anyone, feel free to correct me).

Currently we have two main domains of time in the kernel: xtime and
jiffies.

jiffies:
	jiffies is a simple HZ frequency software maintained (interrupt based)
counter. Since it is fairly low-res, it easily fits in a single long
int(well, a reasonable portion of it does), and requires no locking to
atomically access, making it very easy and fast to use. It is used for
almost all in-kernel time accounting, from scheduler and processes
accounting to soft-timers. Since it is not exported to userspace, the
counter is less robust on some arches in the face of things like lost
ticks. It is not NTP corrected, has a limited range on some arches (in
it's single long int form) and discrepancies between the requested HZ
value and the actual tick frequency (ACTHZ)can cause additional
confusion when mapping jiffies to actual time.


xtime:
	xtime provides nsec resolution software maintained NTP adjusted wall
clock which is exported to userspace.  Along with wall_to_monotonic we
get a NTP adjusted monotonic clock. This is expected to be very robust
and accurate, however since it is so finely grained it requires 64 bits
(or a timepsec) to store it, which can cause performance concerns in the
cases where nsec resolution is unnecessary.


Now that the time domains are covered, how do we use them?

Soft-timers / Timeouts (aka: In kernel software maintained timers):
	Soft-timers provide a internal kernel mechanism for running code at a
later specified time. Soft timers use jiffies for expiration, so they
are fast to use, but are limited to HZ resolution. As Thomas already
discussed (as well as LWN's article) they are very frequently used for
timeouts that are removed before they expire. Additionally, since they
are jiffies based, they have problems when mapping back and forth with
wall time, and do not robustly handle lost ticks (however due to their
common use, this is not normally an issue).


	When userspace requests for action at a future time are made to the
kernel, they are made using some form of human time unit (flat usecs or
timespecs, whatever). Currently inside the kernel, we must convert these
requests to jiffies and use the soft-timer subsystem. This limits both
the range and low resolution of the request. Additionally, the
discrepancies between HZ, ACTHZ, NTP adjustments and lost ticks can
cause for additional inaccuracies in the conversion.


ktimers (From my understanding, again Thomas, correct me as needed):
	ktimers provide a completely separate soft-timer list, which can use
either the wall-clock or the monotonic-clock as its domain for addition
and expiration. Since users may specify nanosecond resolution requests,
ktimers preserve the request in a nanosecond form. This eliminates any
discrepancies between jiffies and wall or monotonic time, and allows for
future sub-HZ latencies for expiration (in combination with a high-res
hardware-timer interrupt source). Additionally, in-kernel users who
desire high-precision wall/monotonic clock based timers could find
ktimers useful. 


So the existing fast interface remains with the same jiffies time
domain. ktimers just add a secondary high-resolution interface that maps
to the wall/monotonic_clock domain.

> > > The existence of the timer source abstraction is a major requirement for 
> > > further improvements (in this regard it's already suspicious, that you put 
> > > major changes before Johns patch). 
> > 
> > Whats suspicious on that ? Seperating the "timeout" API and the "timer"
> > API has nothing to do with Johns patches.
> 
> Related changes should be done in a logical order, which I'm obviously 
> disagree about with you.

However, in this case the ktimer patch Thomas mailed out is really
independent from my change. I believe my change helps insure his
interfaces behave properly (you don't want your monotonic clock jumping
backwards occasionally!), but they do not affect his code's logic.


The fact that I make wall time update independent of timer ticks is
really just for simplicity and correctness. It is in no way a
requirement for wall/monotonic domain based timers or high-res timers
(my code does not provide any higher resolution interface then what is
already there). 

Maybe if you were talking about the dynamic tick changes, would it make
sense to wait and do my changes first, and Thomas is not proposing that
at this moment.


> > > The next major change would be to add the possibility to reprogram a 
> > > timer source, the scheduler can use this to 
> > > skip timer ticks and e.g. itimer can offer higher resolution timers. The 
> > > main point here is before we get to any API decisions, we need to develop 
> > > a model how a single time source can drive multiple users. Your split 
> > > between user timers and kernel timeouts leaves this question completely 
> > > open.
> > 
> > Did I claim, that ktimers solve this problem?
> > 
> > No. 
> > 
> > The patches are related but address different aspects of the overall
> > problem without conflicting with each other. Quite the contrary: they
> > complement each other.
> > 
> > I clearly stated that the reprogramming of timer events, which are not
> > addressed by ktimers and I never claimed ktimers does, is a completely
> > different problem.
> 
> No, it's part of the same problem, how are scheduler and your ktimers 
> supposed to share the same time source?

They don't share a time source.

ktimers are in the xtime domain, the scheduler is in the jiffies domain.


Sorry, this was really much longer then I wanted it to be. Hopefully it
wasn't too repetitious, and  reasonably clear. 

thanks
-john

