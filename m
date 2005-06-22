Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVFVA5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVFVA5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVFVA5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:57:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5351 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262419AbVFVA50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:57:26 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506211542580.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
	 <1119311734.9947.143.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506211542580.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 17:57:21 -0700
Message-Id: <1119401841.9947.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 17:08 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 20 Jun 2005, john stultz wrote:
> 
> > > You don't really answer the core question, why do you change everything to 
> > > nanoseconds and 64bit values?
> > 
> > 
> > Well, for a reasonable range of timesource frequencies and interval
> > lengths, the cycle values needs to be 64 bits wide and the mult/shift
> > operation to convert cycles to time is going to need to done with 64
> > bits.
> > 
> > Since xtime is currently a timespec, we already keep nanosecond
> > precision using 64 bits. It was then just a question of how complicated
> > is it to do the manipulations with timespecs vs flat 64 bits worth of
> > nanoseconds.  Nanoseconds made the design cleaner, so I went with them
> > keeping the option to optimize in the future when real issues arose. 
> 
> That might be the case, but your patch makes it very hard to verify.
> You don't fix the old code, you just drop in a complete new 
> implementation, so you have to explain it a bit more.
> What's exactly wrong with old design and why wasn't possible to fix it 
> incrementally? How exactly is your new design superior?

That's a fair criticism. Early in the design phase I spent a lot more
time explaining the reasons for doing this, but more recently I've been
focused on the code issues and haven't maintained that documentation.
Since I'm doing an OLS talk on this work, I need to refresh the
documents anyway, so I'll include that with my next submission.

Briefly the big issues are: 

Correctness: The current timekeeping code is tick based with
interpolation for high res granularity. There are many causes of
interpolation error which can cause either time inconsistencies or NTP
skew:
o tick/timesource calibration errors
o NTP adjustments are not done consistently, only at interrupt time
o Delayed, or lost ticks caused by interrupt starvation, drivers
disabling interrupts for too long, BIOS SMIs
o Fixes like lost tick compensation break virtualized systems

Flexibility: The various tick-less system (Dynamic ticks, NO_IDLE_HZ,
VST) projects are continually needed to add hacks to avoid breaking the
time subsystem. George's HRT patches needed to rework a good chunk of
the timeofday subsystem as well. When HZ was changed time was affected,
when interrupt routing changes time is affected. It just goes on and on.
Having a timeofday subsystem that is somewhat isolated and doesn't break
when someone sneezes near it will help allow for other improvements.

Maintainability:  Most arches do basically the same thing for their
timeofday code, time bugs are frequently only fixed in a few arches,
leaving other arches prone to the problems. Also the collection of
global variables used to keep time and ntp adjustments are getting
unmanageable and are not well understood by everyone resulting in bugs
when folks access them directly. There is a need for some opaqueness to
those variables.  Additionally, The number of timesources is increasing
as is the number of different architectures that share them. Some cross-
architecture method for sharing timesources is needed. 

The biggest improvement with my rework is for correctness. Timekeeping
is no longer tick based, so there is no interpolation (or interpolation
error) in the core algorithm. Delayed, or lost timer interrupt do not
affect timekeeping with my code. This also allows tick-less system
projects or any other projects that deal with timers to not worry about
affecting time with their changes.  It also makes NTP adjustments
smoothly across intervals to avoid time inconsistencies.

My rework also provides an arch generic timeofday framework, which
manages arch specific timesource drivers. Using the existing interfaces
as well as a few new functions, it provides full coverage for the
existing users of the timeofday code, keeping the internal timekeeping
variables opaque.


> > > With -mm you can now choose the HZ value, so that's not really the 
> > > problem anymore. A lot of archs even never changed to a higher HZ value. 
> > > So now I still like to know how does the complexity change compared to the 
> > > old code?
> > 
> > Well, even if it is less of a concern with lower HZ values, my code
> > should still reduce the interrupt overhead for those who would like to
> > have higher HZ values to improve latency. (Although until I have
> > numbers, its all just talk. :)
> 
> For machines where it actually matters, I can only see that calculations 
> have gotten more complex and thus slower. You need to provide a little 
> more detailed information, why this necessary.

Indeed, the periodic timekeeping function is likely more computationally
costly (although I don't have hard numbers on that yet, I will soon),
however we run it less frequently (50x actually) and we do it outside of
the interrupt context. I do not believe the periodic timekeeping path is
going to be a performance concern.


> > Well, I think the only overhead to be worried with is just in
> > gettimeofday(), but let me get some hard numbers to show that. I've
> > already implemented some optimized caching for x86-64's vsyscall-gtod
> > implementation, so let me also try to make an arch generic version and
> > see if I cannot settle your concerns.
> 
> I don't need any practical numbers, I can already see from the code, that 
> it's much worse and unless you eliminate the 64bit calculations from the 
> fast path, I don't know what you are trying to optimize.

That's exactly what I'm trying to optimize. By precalculating some of
the 64 bit manipulations, we can remove them from the fast path.

Ok, from my initial tests on my i686 laptop (@600Mhz), using the
cheapest timesource available (the TSC), the unoptimized B3 version of
the code I sent out shows a 17% performance hit in gettimeofday(). That
ratio will be even smaller if you use a more expensive timesource. So
starting there, let me see how much I can shave off.

> > > I like the concept of the a time source in your patch. m68k already uses a 
> > > number of timer related callbacks into machine specific code. If I could 
> > > replace that with a timer driver, I'd be really happy. OTOH if it requires 
> > > several expensive conversion between different time formats, I rather keep 
> > > the current code.
> > 
> > Thanks, I really appreciate your review and feedback. I very much want
> > this to be a solution everyone can be happy (or at least indifferent)
> > with.
> 
> I would seriously suggest you rework the first patch and fix the existing 
> code instead or you have to explain why the current code is unfixable, but 
> that would require to actually replace the old code. 

Forgive me for not communicating this well enough, I guess I've been
just a bit too stuck in the code to realize others aren't seeing the
problems I am.

It is my feeling that the current interpolated based timekeeping is not
easily fixable. In order to move to a non-interpolated method of
timekeeping, first each architecture has to provide some timesource like
interface that will give us a free running counter. So we provide some
form of timesource interface, and some form of generic timeofday code
and since all the arches won't switch on the same day we'll have to
stage it and then we're almost to where I am today.

The only other option I see is to let each arch sort it out for itself,
some using interpolation, and some not, maybe using a method similar to
what PPC64 does. Then we still have the duplicated effort having to work
on each arch and the unique bugs in each. Future changes like the tick-
less projects will have to conditionally work based on which arch has
which method.

> Having two 
> alternative implementations is really the worst solution.

It is not my intention to have two alternative implementations. I am
just trying to stage the transition so every arch doesn't have to move
all at once.


> John, you are _very_ vague here, could you please go into more detail, why 
> you did certain design decisions? "Simplicity" can't be the only reason, 
> good perfomance is far more important.

Performance is more important then simplicity, however correctness and
flexibility are necessary as well. Hopefully the discussion above will
answer some of your questions. I'll try to make a more thorough writeup
and include it with my next submission.

I really appreciate the feedback and questions. 

thanks
-john

