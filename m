Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWDGR5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWDGR5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWDGR5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:57:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62671 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964833AbWDGR5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:57:45 -0400
Subject: Re: [PATCH 0/5] clocksource patches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 10:57:17 -0700
Message-Id: <1144432638.2745.61.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 21:54 +0200, Roman Zippel wrote:
> Some more notes about the patches:

Hey Roman,
	I'll reply to more specifics to the patches themselves, but I'll try to
get some general clarifications here.

> 1. generic clocksource updates:
> The most important change is probably clocksource_get_nsec_offset(), it 
> returns the nsec part of the realtime clock and is adjusted once a second. 
> Other time services can be built on top of this and also only have to be 
> updated once a second via second_overflow(). I changed the return value to 
> an unsigned long which gives us a 3 second window, which should be more 
> than enough (anyone not allowing the timer interrupt for that long gets 
> what he is asking for). This function should become clocksource specific 
> so arch/clocks can optimize this function themselves (e.g. changing 
> resolution, making some parameters constant). The generic clocksource 
> currently still deals a bit too much with cycles, more of this should be 
> moved into the clocksource drivers (using library functions).

I'm still not convinced for the need of clocksource specific
get_nsec_offset() functions. I really want to limit the clocksource
structure to be as stateless as possible and to only provide an
abstraction to the hardware counter below. 

But clearly you are pretty concerned about it, so maybe could you share
the case you have in mind where it would be necessary?


> I'm also still interested in opinions about different possibilities to 
> organize the clocksource infrastructure (although I'd more appreciate 
> pro/con arguments than outright rejections). One possibility here would be 
> to also shorten the function names a bit (clocksource_ is a lot to type :) 
> ), cs_... or clock_... would IMO work too.

I *much* prefer the clarity of clocksource over the wear and tear typing
it might take on my fingers. 


> 2. periodic clocksource update
> I updated the error adjustment algorithm to be more robust and optimized 
> it a bit for the more common cases. It does everything in 64bit right now, 
> which is fine for 64bit archs and it allows resolutions of less then 
> 1nsec, but as long as e.g. gettimeofday() takes longer than 1nsec that's 
> a little wasteful and nobody will see a difference if we "restrict" the 
> resolution to 1nsec, which would allow to keep parts of it in 32bit.
> 
> I also kept it separate from the do_timer() callback and simply created a 
> new callback function, which archs can use. This makes it less likely to 
> break any existing setup and even allows to coexists both methods until 
> archs have been completely converted.

One of the reasons I did the significant rework of the TOD patches was
so that we could generically introduce the clocksource abstraction first
(using jiffies) for all arches. I feel this provides a much smoother
transition to the generic timekeeping code (and greatly reduces the
amount of CONFIG_GENERIC_TIME specific code), so I'm not sure I
understand why you want to go back to separate do_timer() functions. 

I guess what I'm asking for is what was wrong with the way my code did
it? What breakage are you concerned about?

> Another general comment from an arch/driver specific perspective: right 
> now everything is rather concentrated on getting the time, but AFAICT it's 
> more common that the subsystem which is used to read the time is also used 
> as timer (i.e. for the scheduler tick), this means the clocksource driver 
> should also include the interrupt setup. Consequently this means the 
> update callback isn't sufficient anymore and we need at least something 
> like start/stop callbacks. This also means the jiffie clocksource becomes 
> basically obsolete, since every arch already needs at least a basic 
> clocksource to provide the scheduler tick (which is setup via 
> time_init()).
> i386 is currently rather hardcoded to use the i8253 timer, but AFAIK it 
> would be desirable to e.g. use HPET for that (especially for hrtimer). 
> Something like TSC should internally use another clocksource to provide 
> the timer interrupt. Anyway, i386 is quite a mess here right now and I can 
> understand that you wanted to stay away from it with the generic 
> gettimeofday infrastructure. :-)
> This is not important right now, but I wanted to mention it, it's IMO
> something to keep in mind for the next steps and what at least I'll 
> look out for.


Thomas has already commented on this, and maybe we both misunderstand
what your suggesting here, but I am pretty hesitant to bind the clock
source / hardware interrupt timer code together. The reason for that is
in my experience w/ i386 (and I'll take my lumps for my part in the i386
timekeeping mess) the number of combinations of clock/timers is
something like: PIT/PIT, TSC/PIT, CYCLONE/PIT, ACPIPM/PIT, HPET/PIT,
TSC/HPET, HPET/HPET. And with some of Andi's patches x86-64 patches you
can do them all over /APIC.

My goal with the clocksources is to take just the counter aspect of any
hardware and export it generically so we can use that inside generic
code. I also would support a similar timer interrupt source abstraction,
like what Thomas has started in his clockevent patches in his hrt
patchset. The hope being we can later freely mix and match
clocksources/clockevents, allowing for some of the features needed for
dynamic ticks and virtualization.

Do these concerns make sense to you? Or was it something else you were
suggesting?

thanks
-john

