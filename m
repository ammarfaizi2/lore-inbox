Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVFWAbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVFWAbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVFWAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:31:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52368 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261764AbVFWA36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:29:58 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506221739510.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
	 <1119311734.9947.143.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506211542580.3728@scrub.home>
	 <1119401841.9947.255.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506221739510.3728@scrub.home>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 17:29:47 -0700
Message-Id: <1119486592.9947.354.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 21:45 +0200, Roman Zippel wrote:
> On Tue, 21 Jun 2005, john stultz wrote:
> 
> > Briefly the big issues are: 
> 
> That's interesting, but it mainly describes your design goals, but I'm 
> more interested why you did certain design decisions.
> The main problem is that you try to fix all these issues with a single 
> patch and I'd like to know why you don't pick a single issue and fix it 
> first.

I've actually spent quite a bit of time working to fix these single
issues, and that is why I'm proposing this. The best example is the lost
tick compensation. There I have added code in the i386 arch that
attempts to notice when a tick has been lost (two or more ticks worth of
time passed without an interrupt) and add in the appropriate number of
jiffies. This helped for systems that were losing ticks due to BIOS SMIs
or interrupt starvation. However that broke some VM systems because they
effectively disable interrupts for a period of time, and then re-play
interrupts to try to catch up. The first interrupt would trigger the
lost tick detection code bringing us up to the current time, then the
following catch-up interrupts would advance time again, causing the
system to go too far forward.

Some other architectures try to handle these situations as well. One
good example is PPC64 (which has greatly influenced my design). For
correctness PPC64 goes as far as not using interpolation by avoiding
almost all of the arch generic time code. It even has its own NTP
adjustment code! 

I have come to believe the current arch generic tick based timekeeping
is not sustainable. It seems to me in order to avoid bugs that customers
are seeing, arches are going to have to avoid the current tick based
arch generic code and implement their own non-interpolated based
timekeeping code. So that is why I've created this proposal and
implementation instead of just "fixing one issue".

So the question becomes: in order to achieve correctness, should every
architecture implement a full timeofday subsystem of its own? I designed
a system that would work, but instead of making it i386 and copying it
for x86-64 and whatever else I end up working on, I propose we make it a
common implementation.

Now, my proposal might not currently satisfy everyone's needs for
flexibility and performance in the timekeeping subsystem. But I'd like
to try, and letting me know your issues (such as the use of 64bit math)
helps me work to resolve them, so I really appreciate your feedback. I
really do want this to be something that every arch can use.

Although I hope it doesn't, but if it comes down to there being no
reasonable way for every arch to share the my proposed common
infrastructure, them maybe I need to add some code so those arches can
opt out and maintain their own timekeeping code. Does that sound
reasonable?


> > o Delayed, or lost ticks caused by interrupt starvation, drivers
> > disabling interrupts for too long, BIOS SMIs
> 
> These are actually different error sources. Ticks lost due to disabled 
> interrupt can't be detected unless you have a second timer source and the 
> generic code doesn't really know about this. If an arch has a second time 
> source this is fixable, but I would consider this optional, that means 
> adjustments are only done, iff this source is available.
> The current concept of lost ticks simply means delayed soft interrupt 
> handling. IMO this could be a good starting point to fix the timer code, 
> by making it possible to call update_wall_time() with a reduced frequency.
> If you move in a _later_ step from ticks to 32bit nanoseconds, that would 
> give you still a 4 second window, which should be more than enough, so 
> e.g. I don't see any reason to use any 64bit math here.
> 
> > The biggest improvement with my rework is for correctness. Timekeeping
> > is no longer tick based, so there is no interpolation (or interpolation
> > error) in the core algorithm.
> 
> AFAICS the interpolation is needed because some arch use different time 
> sources for the scheduler and timeofday, but I don't see why fixing the 
> timer code immediately requires a generic timer source infrastructure.
> You have to be more explicit why it's not possible to fix the generic 
> timer code first.

No, I don't believe high res time interpolation does not have anything
to do with the scheduler. It is used by gettimeofday() to give better
then tick-granular time resolution. In fact, the current generic
timekeeping code doesn't even acknowledge interpolation goes on. It just
believes time is incremented in tick units. Every tick, xtime gets
incremented one ticks worth of time. 

So if we were going to fix that, we would have to change the code so
that every tick the amount of time that has passed since the last tick
was added to xtime. In order for this to occur, we need some arch
specific accessor to find out how much time actually passed. This is
very similar what the timesource drivers provide. And once you have that
it is almost the same as my new code. 

> > > For machines where it actually matters, I can only see that calculations 
> > > have gotten more complex and thus slower. You need to provide a little 
> > > more detailed information, why this necessary.
> > 
> > Indeed, the periodic timekeeping function is likely more computationally
> > costly (although I don't have hard numbers on that yet, I will soon),
> > however we run it less frequently (50x actually) and we do it outside of
> > the interrupt context. I do not believe the periodic timekeeping path is
> > going to be a performance concern.
> 
> Please give me _some_ concrete information, why this code has to be more 
> complex than the current code.

Honestly it isn't that much more complex. It is however consistent. We
increment the timekeeping variables in the exact same way we generate
gettimeofday(). This is what avoids time inconsistencies. Additionally,
NTP adjustments are integrated into how we calculate gettimeofday() so
there is not inconsistencies caused by only applying NTP correction at
the tick.


> > > I don't need any practical numbers, I can already see from the code, that 
> > > it's much worse and unless you eliminate the 64bit calculations from the 
> > > fast path, I don't know what you are trying to optimize.
> > 
> > That's exactly what I'm trying to optimize. By precalculating some of
> > the 64 bit manipulations, we can remove them from the fast path.
> 
> I want to remove all that, why do you need 64bit calculations in there? 
> What's wrong with a base xtime + 32bit nanosecond offset?


I'm actually doing almost just that! I've cut the cycle_t down to an
unsigned long, and while nanoseconds are still 64bits (in order to have
a precise cyc2ns conversion), we only use 32bits of them for the most
part. 

> > Ok, from my initial tests on my i686 laptop (@600Mhz), using the
> > cheapest timesource available (the TSC), the unoptimized B3 version of
> > the code I sent out shows a 17% performance hit in gettimeofday(). That
> > ratio will be even smaller if you use a more expensive timesource. So
> > starting there, let me see how much I can shave off.
> 
> That's hardly a fair comparison, you cannot use an expensive timesource to 
> make your time code look cheap.

That was not my intent. The numbers I'm using are using the fastest
timesource available (the TSC). I'm just saying that the 17% performance
impact was as bad as it gets. And currently I'm down to just 2% using
the same timesource with some of the optimizations I mentioned above.


> > It is my feeling that the current interpolated based timekeeping is not
> > easily fixable. In order to move to a non-interpolated method of
> > timekeeping, first each architecture has to provide some timesource like
> > interface that will give us a free running counter.
> 
> Why is not possible to fix the generic time code first, so you can later 
> drop the interpolation and use time sources instead?

It is my opinion that dropping interpolation is what is needed in order
to fix the generic timekeeping code. 

> For all archs where timeofday and tick has the same source you can easily 
> upgrade to the new code, only the rest needs to do a bit more to update 
> xtime from a different source. This way you break much less code and give 
> arch maintainers much less headache.
> If you think this is not possible, please give me some more concrete 
> information.

I'm not sure I exactly follow what you're proposing. It may be possible
that there is a way to implement my design in a more piecemeal fashion,
and I would very much welcome specific suggestions on how to do so. So
please do explain in a bit more detail.

Once again, thanks again for your feedback. Its not my intention for
giving arch maintainers a headache (it is my hope that the new subsystem
will lessen the impact of future changes on arch specific code).

thanks
-john

