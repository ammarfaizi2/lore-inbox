Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWD0UdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWD0UdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWD0UdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:33:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27613 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750754AbWD0UdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:33:22 -0400
Date: Thu, 27 Apr 2006 22:33:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1144432638.2745.61.camel@leatherman>
Message-ID: <Pine.LNX.4.64.0604270025520.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
 <1144432638.2745.61.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Apr 2006, john stultz wrote:

Sorry about the long delay, I was engrossed in other problems and I had to 
check a few things for a proper reply, which I've put off. Anyway, sorry. :)

> I'm still not convinced for the need of clocksource specific
> get_nsec_offset() functions. I really want to limit the clocksource
> structure to be as stateless as possible and to only provide an
> abstraction to the hardware counter below. 
> 
> But clearly you are pretty concerned about it, so maybe could you share
> the case you have in mind where it would be necessary?

The main point is performance. This is a very important function and your 
approach requires to assume the worst case, e.g. it has to be done in 
64bit, which OTOH can be easily optimized in the driver.
I can understand that you want to keep the clock driver as simple as 
possible, but that's not how Linux works - we usually don't abstract away 
every detail. It's always a compromise between simplicity, flexibility and 
performance. This means sometimes we do leave things to the drivers which 
can simply use some generic functions if they don't have any special 
requirements.
By pushing all the complexity into a middle layer you're running the risk 
of creating a bloated middle layer with a big runtime complexity, which 
has to deal with every little special case. Pushing at least part of this 
complexity into the driver allows us to make some decisions already at 
compile time and thus reducing runtime complexity.
Simply look at the various kernel APIs, middle layers tend to be rather 
light weight, provide _common_ services and leave the real work to the 
drivers, e.g. the fs layer does the path translation and the basic 
locking, but we have no special handling for block vs net fs drivers, 
instead we provide library functions which also deal with such special 
cases as support for holes in files.

I really don't understand your problem with a clocksource specific 
nsec_offset(), the author already has to provide most of the basic 
parameters, it's not that difficult to put them together and for the 
really lazy we can provide a:

my_clock_nsec_offset(struct clocksource *cs)
{
	return generic_nsec_offset(cs, my_get_cycles(), MASK, SHIFT);
}

this is _very_ simple and if some of the parameters are constant you 
already saved a few cycles.

John, we have to find some compromise here, but I think sacrificing 
everything to driver simplicity is IMO a huge mistake. A "simple" driver 
gives you a lot of flexibility on the generic side, but you remove this 
flexibility from the driver side, i.e. if a driver doesn't fit into this 
cycle model (e.g. tick based drivers) it has to do extra work to provide 
this abstraction.
A good abstraction should concentrate on the _common_ properties and I 
don't think that the continous cycle model is a good general abstraction 
for all types of clocks. Tick based clocks are already more complex due 
the extra work needed to emulate the cycle counter. Some clocks may 
already provide a nsec value (e.g. virtual clocks in a virtualized 
environment), where your generic nsec calculation is a complete waste of 
time. A common property of all clocks is that we want a nsec value from 
them, so why not simply ask the clock for some kind of nsec value and 
provide the clock driver with the necessary library routines to convert 
the cycle value to a nsec value, where you actually have the necessary 
information to create efficient code. As long as you try to pull the cycle 
model into the generic model it will seriously suck from a performance 
perspective, as you separate the cycle value from the information how to 
deal with it efficiently.

> > I'm also still interested in opinions about different possibilities to 
> > organize the clocksource infrastructure (although I'd more appreciate 
> > pro/con arguments than outright rejections). One possibility here would be 
> > to also shorten the function names a bit (clocksource_ is a lot to type :) 
> > ), cs_... or clock_... would IMO work too.
> 
> I *much* prefer the clarity of clocksource over the wear and tear typing
> it might take on my fingers. 

What is the special meaning of "clocksource" vs e.g. just "clock"?

> > I also kept it separate from the do_timer() callback and simply created a 
> > new callback function, which archs can use. This makes it less likely to 
> > break any existing setup and even allows to coexists both methods until 
> > archs have been completely converted.
> 
> One of the reasons I did the significant rework of the TOD patches was
> so that we could generically introduce the clocksource abstraction first
> (using jiffies) for all arches. I feel this provides a much smoother
> transition to the generic timekeeping code (and greatly reduces the
> amount of CONFIG_GENERIC_TIME specific code), so I'm not sure I
> understand why you want to go back to separate do_timer() functions. 

Apropos code size: I checked the generated code size of timer.o (default 
i386 config), before it was 3248 bytes, with your patches it goes to 5907 
bytes and by disabling CONFIG_GENERIC_TIME it still is 4554. With my 
patches it's 4767/4347 bytes (removing the old time code saves another 
315 bytes).
In my version I was very careful to keep the common interrupt paths as 
short as possible, so that most of this code is not even executed most of 
the time. You can't just "hope" that gcc does the work for you (especially 
with 64bit math), you actually have to check the code and you would have 
the noticed the bloated code it generates.

Keeping the old time code separate makes it easier to optimize the new 
code and is more flexible, e.g. for a tick based clock source we can 
provide an update function which does something like this:

	clocksource_update_tick();
	clocksource_adjust(0);

This means the loop is gone and the adjustment code becomes simpler due to 
the constant offset.

> Thomas has already commented on this, and maybe we both misunderstand
> what your suggesting here, but I am pretty hesitant to bind the clock
> source / hardware interrupt timer code together. The reason for that is
> in my experience w/ i386 (and I'll take my lumps for my part in the i386
> timekeeping mess) the number of combinations of clock/timers is
> something like: PIT/PIT, TSC/PIT, CYCLONE/PIT, ACPIPM/PIT, HPET/PIT,
> TSC/HPET, HPET/HPET. And with some of Andi's patches x86-64 patches you
> can do them all over /APIC.

I really don't want to hardcode anything, it's not my intention to 
recreate a mess similiar to timer_tsc.c.
My basic idea of clock abstraction would be something you can use to read 
the time and which you can set to generate an interrupt. This doesn't mean 
every clock driver has to provide everything, it should be not that 
difficult to _dynamically_ bind two drivers to provide this functionality 
(where and how this is done is not important here).
In the simple cases clock and timer functionality are provided by the same 
hardware and I really don't understand where the advantage is to 
artifically separate this functionality, _if_ this comes from the same 
hardware. If I want to write a driver for a _simple_ timer chip, I want to 
export its functionality via one interface, so e.g. I can use it as the 
system clock, this means the driver simply registers itself as a clock 
driver and the generic system sets it up as a system clock. This is what I 
need from an arch perspective and I want to keep this as simple as 
possible and splitting this simple thing into different abstractions runs 
contrary to that.

> My goal with the clocksources is to take just the counter aspect of any
> hardware and export it generically so we can use that inside generic
> code. I also would support a similar timer interrupt source abstraction,
> like what Thomas has started in his clockevent patches in his hrt
> patchset. The hope being we can later freely mix and match
> clocksources/clockevents, allowing for some of the features needed for
> dynamic ticks and virtualization.

I have looked at the clockevent code, I can see what I does, but I don't 
really understand why it does it this way, it simply doesn't match my 
expectations/needs from a clock. The code is barely documented and 
there is no explanation of the basic design ideas and requirements it's 
based on. As long as this is missing it's useless to me and my attempts so 
far at getting Thomas to explain his code have been rather fruitless. :(
It's possible it's some ingenious piece of code, but if I have trouble 
understanding the code, I don't think I'm going to be the only one.

Maybe I have a completely different idea of this, which prevents me from 
understanding this, so it would really help if someone would explain the 
advantages of the clocksource/clockevent abstraction and connect the dots 
of how it fits into the general model between clock hardware/driver and 
the generic kernel clock/timer services.

bye, Roman
