Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWEHVPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWEHVPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWEHVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:15:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21458 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750810AbWEHVPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:15:47 -0400
Date: Mon, 8 May 2006 23:15:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1147113212.13441.44.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605082108570.17704@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home> 
 <1144432638.2745.61.camel@leatherman>  <Pine.LNX.4.64.0604270025520.32445@scrub.home>
  <1146881053.12414.22.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.64.0605061448420.32445@scrub.home> <1147113212.13441.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 May 2006, john stultz wrote:

> > Let's concentrate on the core issue.
> > I do agree that we need a continuous clock, but why has this clock to be 
> > cycle based? As I tried to explain above the cycle based abstraction hurts 
> > performance, as it cuts us off from further optimizations.
> 
> 
> First of all, you didn't reply specifically, but I hope we're in
> agreement w/ the tick based clocks being not part of this specific
> discussion. I'm fine letting systems w/ tick based clocks have an
> get_nsec_offset() that is fully arch specific. And I don't love it, but
> I can deal w/ having two update_wall_time() paths so tick based systems
> can get some extra constant based optimizations.

Please leave the tick based stuff out of this completely. We want to get 
rid of the arch specific hooks and not add them back.
The point is to give the _clock_ control over this kind of stuff, only the 
clock driver knows how to deal with this efficiently, so as long as you 
try to create a "dumb" clock driver you're going to make things only 
worse. Now the archs have most control over it, but creating a single 
bloated and slow blop instead will not be an improvement.
It's not about moving everything into the clock driver here, it's about 
creating a _powerful_ API, which leaves control in the hands of the clock 
driver, but at the same time keeps them as _simple_ (and not as dumb) as 
possible.

> What arch specific optimizations for continuous clocks do you have in
> mind? In other words, what would be an example of an architecture
> specific optimization for generating time from a continuous counter?

The best example is the powerpc gettimeofday.

> For the sake of this discussion, I claim that optimizations made on
> converting a continuous cycle based clock to an NTP adjusted time can be
> made to all arches, and pushing the nanosecond conversion into the
> driver is messy and needless.  What are examples contrary to this claim?

What kind of NTP adjustments are you talking about? A nsec_offset function 
could look like this:

unsigned long nsec_offset(cs)
{
	return ((cs->xtime_nsec + get_cycles() - cs->last_offset) * cs->mult) >> SHIFT;
}

This is fucking simple, what about this is "messy"? There is no NTP 
adjustment here, this is all happening somewhere else. Keeping it in the 
driver allows to make parameter constant, skip unnecessary steps and 
allows to do it within 32bit. This is something you can _never_ do in a 
generic centralized way without making it truly messy. I'd be happy to be 
proven otherwise, but I simply don't see it.

> > What we want in the end is continous _nanosecond_ value, so why not let 
> > the abstraction base on this? Why is the cycle value so important?
> 
> Because doing the NTP adjustment correctly on a cycle based clock is
> difficult with the current code (I think ppc is the only one that does
> it correctly, in my mind, by changing the frequency multiplier).

I was talking about the nsec offset (see above), which is outside of the 
NTP business. What is your fascination with the cycle counter, that you 
want to make it so generic?

> It can be done generically, and I do not see what sort of optimizations
> you're imagining, so why keep it arch specific?

John, it's _clock_ specific.

> > Of these archs ppc has a higly optimized lock and condition free 
> > gettimeofday implementation, which you simply throw away. I'm afraid that 
> > archs which care about performance have to work around your slow generic 
> > implementation. I have a big problem seeing progress in this.
> 
> The ppc's lockfree implementation is interesting (putting aside for a
> moment the fact that the current ppc vsyscall-gtod added locks back to
> the code).
> 
> However I don't see how its an arch specific optimization! Its simply
> doing atomic updates via pointer switches between two structures. This
> doesn't need to be ppc specific, yet because of the current mess it is.
> This is a great example of why the generic code would be useful.

Part of this can be done generically and I'd like to see it implemented, 
but not all the optimizations can be done generically, e.g. not every arch 
has a convenient mulhdu instruction like ppc64.
The arch can provide some base optimizations, but in the end it's the 
clock which knows best (e.g. 32bit vs. 64bit resolution). Only the clock 
driver knows the basic clock parameters at _compile_ time and can generate 
an efficient implementation. With the help of some library functions we 
can keep the amount of source needed in the driver to a minimum and 
simple. Where is the problem with this?

> > The first step would be to keep it separate from the current 
> > update_wall_time() code. I just got rid of clock read in the hrtimer 
> > interrupt code you are about to introduce it again here. Many clocks don't 
> > need that much precision, and especially if it's an expensive operation 
> > it's a complete waste of time.
> 
> With continuous cycle based counters, the clock read is *necessary* when
> updating xtime for robust timekeeping. We can move update_wall_time so
> we don't run it every timer interrupt, but we cannot keep correct time
> by just guessing how much time has passed and adding it in.

It has almost nothing to do with continuous cycles. On an UP system only 
anything running with a higher priority than the timer interrupt or if the 
cycle adjustment happens asynchron to the timer interrupt (e.g. TSC) can 
see the adjustment. Again it depends on the clock whether the common 
adjustment is significant bigger than the time needed to read the clock, 
otherwise it's just a waste of time.

> On tick based systems, the code in -mm, would just be reading jiffies
> which is equivalent to how its done in mainline. But I'll grant you we
> probably miss out on some of the optimizations where we could use
> constants, so I'll add in a tick based update_wall_time path soon.

John, again, it's not about tick based systems, you'll get it wrong as 
long as you think it's about special exceptions for tick based systems. 
It's about creating a flexible system, which can handle about anything and 
only the clock driver really knows what this is, otherwise you create a 
bloated and slow generic system.

bye, Roman
