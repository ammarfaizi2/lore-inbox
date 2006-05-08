Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWEHSdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWEHSdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEHSdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:33:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:30145 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751254AbWEHSdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:33:35 -0400
Subject: Re: [PATCH 0/5] clocksource patches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605061448420.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
	 <1144432638.2745.61.camel@leatherman>
	 <Pine.LNX.4.64.0604270025520.32445@scrub.home>
	 <1146881053.12414.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0605061448420.32445@scrub.home>
Content-Type: text/plain
Date: Mon, 08 May 2006 11:33:32 -0700
Message-Id: <1147113212.13441.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-06 at 18:25 +0200, Roman Zippel wrote:
> On Fri, 5 May 2006, john stultz wrote:
> 
> > > A good abstraction should concentrate on the _common_ properties and I 
> > > don't think that the continous cycle model is a good general abstraction 
> > > for all types of clocks. Tick based clocks are already more complex due 
> > > the extra work needed to emulate the cycle counter. Some clocks may 
> > > already provide a nsec value (e.g. virtual clocks in a virtualized 
> > > environment), where your generic nsec calculation is a complete waste of 
> > > time. A common property of all clocks is that we want a nsec value from 
> > > them, so why not simply ask the clock for some kind of nsec value and 
> > > provide the clock driver with the necessary library routines to convert 
> > > the cycle value to a nsec value, where you actually have the necessary 
> > > information to create efficient code. As long as you try to pull the cycle 
> > > model into the generic model it will seriously suck from a performance 
> > > perspective, as you separate the cycle value from the information how to 
> > > deal with it efficiently.
> > 
> > 
> > For features like robust timekeeping in the face of lost ticks (needed
> > for virtualization, and realtime), as well as high-res timers and
> > dynamic/no-idle ticks, we *NEED* a continuous clock. 
> 
> Let's concentrate on the core issue.
> I do agree that we need a continuous clock, but why has this clock to be 
> cycle based? As I tried to explain above the cycle based abstraction hurts 
> performance, as it cuts us off from further optimizations.


First of all, you didn't reply specifically, but I hope we're in
agreement w/ the tick based clocks being not part of this specific
discussion. I'm fine letting systems w/ tick based clocks have an
get_nsec_offset() that is fully arch specific. And I don't love it, but
I can deal w/ having two update_wall_time() paths so tick based systems
can get some extra constant based optimizations.

Now, on to the continuous clocksource discussion :)

What arch specific optimizations for continuous clocks do you have in
mind? In other words, what would be an example of an architecture
specific optimization for generating time from a continuous counter?

For the sake of this discussion, I claim that optimizations made on
converting a continuous cycle based clock to an NTP adjusted time can be
made to all arches, and pushing the nanosecond conversion into the
driver is messy and needless.  What are examples contrary to this claim?


> What we want in the end is continous _nanosecond_ value, so why not let 
> the abstraction base on this? Why is the cycle value so important?

Because doing the NTP adjustment correctly on a cycle based clock is
difficult with the current code (I think ppc is the only one that does
it correctly, in my mind, by changing the frequency multiplier).

It can be done generically, and I do not see what sort of optimizations
you're imagining, so why keep it arch specific?


> Of these archs ppc has a higly optimized lock and condition free 
> gettimeofday implementation, which you simply throw away. I'm afraid that 
> archs which care about performance have to work around your slow generic 
> implementation. I have a big problem seeing progress in this.

The ppc's lockfree implementation is interesting (putting aside for a
moment the fact that the current ppc vsyscall-gtod added locks back to
the code).

However I don't see how its an arch specific optimization! Its simply
doing atomic updates via pointer switches between two structures. This
doesn't need to be ppc specific, yet because of the current mess it is.
This is a great example of why the generic code would be useful.


> > This isn't really a fair comparison (yet atleast), as your patches don't
> > appear to handle suspend/resume correctly. Nor did your patches even
> > boot on my laptop. :(
> 
> Why didn't you mentioned this earlier? :(

I apologize for not trying to run your patches earlier, but being time
constrained as well, I have been trying to focus understand the
algorithmic differences.

> > Lets make it fast too, but just in steps.
> 
> The first step would be to keep it separate from the current 
> update_wall_time() code. I just got rid of clock read in the hrtimer 
> interrupt code you are about to introduce it again here. Many clocks don't 
> need that much precision, and especially if it's an expensive operation 
> it's a complete waste of time.

With continuous cycle based counters, the clock read is *necessary* when
updating xtime for robust timekeeping. We can move update_wall_time so
we don't run it every timer interrupt, but we cannot keep correct time
by just guessing how much time has passed and adding it in.

On tick based systems, the code in -mm, would just be reading jiffies
which is equivalent to how its done in mainline. But I'll grant you we
probably miss out on some of the optimizations where we could use
constants, so I'll add in a tick based update_wall_time path soon.

thanks
-john


