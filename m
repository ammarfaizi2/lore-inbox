Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVFVTpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVFVTpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFVTpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:45:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5556 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261906AbVFVTpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:45:17 -0400
Date: Wed, 22 Jun 2005 21:45:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119401841.9947.255.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506221739510.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0506181344000.3743@scrub.home>  <1119287354.9947.22.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506202231070.3728@scrub.home>  <1119311734.9947.143.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506211542580.3728@scrub.home> <1119401841.9947.255.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Jun 2005, john stultz wrote:

> Briefly the big issues are: 

That's interesting, but it mainly describes your design goals, but I'm 
more interested why you did certain design decisions.
The main problem is that you try to fix all these issues with a single 
patch and I'd like to know why you don't pick a single issue and fix it 
first.

> o Delayed, or lost ticks caused by interrupt starvation, drivers
> disabling interrupts for too long, BIOS SMIs

These are actually different error sources. Ticks lost due to disabled 
interrupt can't be detected unless you have a second timer source and the 
generic code doesn't really know about this. If an arch has a second time 
source this is fixable, but I would consider this optional, that means 
adjustments are only done, iff this source is available.
The current concept of lost ticks simply means delayed soft interrupt 
handling. IMO this could be a good starting point to fix the timer code, 
by making it possible to call update_wall_time() with a reduced frequency.
If you move in a _later_ step from ticks to 32bit nanoseconds, that would 
give you still a 4 second window, which should be more than enough, so 
e.g. I don't see any reason to use any 64bit math here.

> The biggest improvement with my rework is for correctness. Timekeeping
> is no longer tick based, so there is no interpolation (or interpolation
> error) in the core algorithm.

AFAICS the interpolation is needed because some arch use different time 
sources for the scheduler and timeofday, but I don't see why fixing the 
timer code immediately requires a generic timer source infrastructure.
You have to be more explicit why it's not possible to fix the generic 
timer code first.

> > For machines where it actually matters, I can only see that calculations 
> > have gotten more complex and thus slower. You need to provide a little 
> > more detailed information, why this necessary.
> 
> Indeed, the periodic timekeeping function is likely more computationally
> costly (although I don't have hard numbers on that yet, I will soon),
> however we run it less frequently (50x actually) and we do it outside of
> the interrupt context. I do not believe the periodic timekeeping path is
> going to be a performance concern.

Please give me _some_ concrete information, why this code has to be more 
complex than the current code.

> > I don't need any practical numbers, I can already see from the code, that 
> > it's much worse and unless you eliminate the 64bit calculations from the 
> > fast path, I don't know what you are trying to optimize.
> 
> That's exactly what I'm trying to optimize. By precalculating some of
> the 64 bit manipulations, we can remove them from the fast path.

I want to remove all that, why do you need 64bit calculations in there? 
What's wrong with a base xtime + 32bit nanosecond offset?

> Ok, from my initial tests on my i686 laptop (@600Mhz), using the
> cheapest timesource available (the TSC), the unoptimized B3 version of
> the code I sent out shows a 17% performance hit in gettimeofday(). That
> ratio will be even smaller if you use a more expensive timesource. So
> starting there, let me see how much I can shave off.

That's hardly a fair comparison, you cannot use an expensive timesource to 
make your time code look cheap.

> It is my feeling that the current interpolated based timekeeping is not
> easily fixable. In order to move to a non-interpolated method of
> timekeeping, first each architecture has to provide some timesource like
> interface that will give us a free running counter.

Why is not possible to fix the generic time code first, so you can later 
drop the interpolation and use time sources instead?
For all archs where timeofday and tick has the same source you can easily 
upgrade to the new code, only the rest needs to do a bit more to update 
xtime from a different source. This way you break much less code and give 
arch maintainers much less headache.
If you think this is not possible, please give me some more concrete 
information.

bye, Roman
