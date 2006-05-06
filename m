Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWEFQZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWEFQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWEFQZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:25:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16575 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750734AbWEFQZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:25:27 -0400
Date: Sat, 6 May 2006 18:25:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1146881053.12414.22.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0605061448420.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home> 
 <1144432638.2745.61.camel@leatherman>  <Pine.LNX.4.64.0604270025520.32445@scrub.home>
 <1146881053.12414.22.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 May 2006, john stultz wrote:

> > A good abstraction should concentrate on the _common_ properties and I 
> > don't think that the continous cycle model is a good general abstraction 
> > for all types of clocks. Tick based clocks are already more complex due 
> > the extra work needed to emulate the cycle counter. Some clocks may 
> > already provide a nsec value (e.g. virtual clocks in a virtualized 
> > environment), where your generic nsec calculation is a complete waste of 
> > time. A common property of all clocks is that we want a nsec value from 
> > them, so why not simply ask the clock for some kind of nsec value and 
> > provide the clock driver with the necessary library routines to convert 
> > the cycle value to a nsec value, where you actually have the necessary 
> > information to create efficient code. As long as you try to pull the cycle 
> > model into the generic model it will seriously suck from a performance 
> > perspective, as you separate the cycle value from the information how to 
> > deal with it efficiently.
> 
> 
> For features like robust timekeeping in the face of lost ticks (needed
> for virtualization, and realtime), as well as high-res timers and
> dynamic/no-idle ticks, we *NEED* a continuous clock. 

Let's concentrate on the core issue.
I do agree that we need a continuous clock, but why has this clock to be 
cycle based? As I tried to explain above the cycle based abstraction hurts 
performance, as it cuts us off from further optimizations.
What we want in the end is continous _nanosecond_ value, so why not let 
the abstraction base on this? Why is the cycle value so important?

> I made a quick audit of the arches to see what the breakdown was for
> continuous vs tick clocks: 
> 
> Continuous:
> i386,x86-64, ia64, powerpc, ppc, sparc, alpha, mips, parisc, s390,
> xtensa, and arm (pxa, sa1100, plat-omap) 
> 
> Tick:
> arm (other), cris, m32, m68k, sh
> 
> xtime/no intertick resolution:
> frv, h8300, v850
> 
> I'll admit, the continuos cycle model doesn't fit tick based clocks, but
> we shouldn't limit the abstraction to the lowest common denominator. By
> providing what I suggested above (w/ the two __get_nsec_offset()
> implementations), we reduce code for both models, and allow progress for
> systems w/ continuous clocks in a generic fashion.

Why can't we reach the same goal by providing library functions to the 
drivers, which would allow far better optimizations?
Of these archs ppc has a higly optimized lock and condition free 
gettimeofday implementation, which you simply throw away. I'm afraid that 
archs which care about performance have to work around your slow generic 
implementation. I have a big problem seeing progress in this.

John, I see three options:
1. I'm missing the point in your design which allows for further 
optimizations in a generic way.
2. Something is wrong with your cycle based design.
3. Performance isn't important anymore.

> > > I *much* prefer the clarity of clocksource over the wear and tear typing
> > > it might take on my fingers. 
> > 
> > What is the special meaning of "clocksource" vs e.g. just "clock"?
> 
> 
> "clock" is already overloaded. We have the
> CLOCK_MONOTONIC/CLOCK_REALTIME clocks, we have the RTC clocks... Its a
> cycle counter we're using to accumulate time, thus clocksource seemed
> understandable and unique.

The first would actually be my reason for calling it "clock", i.e. if this 
is going to be _the_ central abstraction for further time based services, 
it deserves the shorter and concise "clock" name.

> This isn't really a fair comparison (yet atleast), as your patches don't
> appear to handle suspend/resume correctly. Nor did your patches even
> boot on my laptop. :(

Why didn't you mentioned this earlier? :(

> I'll admit that my code could use more low-level optimization, and I
> welcome patches against my code to improve it. My code has already
> gotten a good amount of testing in both -mm and -rt, so I know it works.

Andrew immediately drops my patches, so they don't even get a chance to 
get any testing. This is a complete unfair argument, I don't even get the 
chance to prove that my code might be better. :-(

> Lets make it fast too, but just in steps.

The first step would be to keep it separate from the current 
update_wall_time() code. I just got rid of clock read in the hrtimer 
interrupt code you are about to introduce it again here. Many clocks don't 
need that much precision, and especially if it's an expensive operation 
it's a complete waste of time.

bye, Roman
