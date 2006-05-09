Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWEIA30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWEIA30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEIA3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:29:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:64140 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750977AbWEIA3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:29:25 -0400
Subject: Re: [PATCH 0/5] clocksource patches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605082108570.17704@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
	 <1144432638.2745.61.camel@leatherman>
	 <Pine.LNX.4.64.0604270025520.32445@scrub.home>
	 <1146881053.12414.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0605061448420.32445@scrub.home>
	 <1147113212.13441.44.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605082108570.17704@scrub.home>
Content-Type: text/plain
Date: Mon, 08 May 2006 17:29:14 -0700
Message-Id: <1147134554.2914.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 23:15 +0200, Roman Zippel wrote:
> The point is to give the _clock_ control over this kind of stuff, only the 
> clock driver knows how to deal with this efficiently, so as long as you 
> try to create a "dumb" clock driver you're going to make things only 
> worse. Now the archs have most control over it, but creating a single 
> bloated and slow blop instead will not be an improvement.
> It's not about moving everything into the clock driver here, it's about 
> creating a _powerful_ API, which leaves control in the hands of the clock 
> driver, but at the same time keeps them as _simple_ (and not as dumb) as 
> possible.

Part of my concern here is keeping the code manageable and hackable.
What you're suggesting sounds very similar to what we have for the i386
timer_opts code, which I don't want to duplicate.

Maybe it would help here if you would better define the API for this
abstraction. As it stands, it appears incomplete. Define the state
values stored, and list what interfaces modify which state values, etc.

	ie: clock->get_nsec_offset():
		What exactly does this measure? Is this strictly defined by the state
stored in the clocksource? If not, how will this interact w/ dynamic
ticks? What is the maximum time we can delay interrupts before the clock
wraps? How do we know if its tick based? 

Another issue: if get_nsec_offset() is clock specific in its
implementation, but the state values it uses in at least the common case
are modified by generic code, how can we implement something like the
ppc lock free read? That will affect both the generic code and the clock
specific code.

> > What arch specific optimizations for continuous clocks do you have in
> > mind? In other words, what would be an example of an architecture
> > specific optimization for generating time from a continuous counter?
> 
> The best example is the powerpc gettimeofday.
> 
> > For the sake of this discussion, I claim that optimizations made on
> > converting a continuous cycle based clock to an NTP adjusted time can be
> > made to all arches, and pushing the nanosecond conversion into the
> > driver is messy and needless.  What are examples contrary to this claim?
> 
> What kind of NTP adjustments are you talking about? A nsec_offset function 
> could look like this:
> 
> unsigned long nsec_offset(cs)
> {
> 	return ((cs->xtime_nsec + get_cycles() - cs->last_offset) * cs->mult) >> SHIFT;
> }
> 
> This is fucking simple, what about this is "messy"? There is no NTP 
> adjustment here, this is all happening somewhere else. 

That's my point. if nsec_offset is opaque, then what is the interface
for making NTP adjustments to that function? Are all nsec_offset
functions required to use the xtime_nsec, last_offset, and mult values?


> Keeping it in the 
> driver allows to make parameter constant, skip unnecessary steps and 
> allows to do it within 32bit. This is something you can _never_ do in a 
> generic centralized way without making it truly messy. I'd be happy to be 
> proven otherwise, but I simply don't see it.

Well, my issue w/ you desire to have a 32bit continuous clock is that I
don't know how useful it would be. 

For a 1Mhz clock, 
	You've got 1,000 ns per cycle and the algorithm looks something like
say:
	get_nsec_offset: cycles * 1,000 >> 0
which gives you ~4 seconds of leeway, which is pretty good.
However, the short term jitter is 1000ppm.

So lets bump up the SHIFT value,
	get_nsec_offset: cycles * 1,024,000 >> 10

The short term jitter: <1ppm, so that's good.
But the max cycles is then ~4,000 (4ms), which is too short.

You can wiggle around here and maybe come up with something that works,
but it only gets worse for clocks that are faster. 

For robust timekeeping using continuous cycles, I think the 64bit mult
in gettimeofday is going to be necessary in the majority of cases (we
can wrap it in some sort of arch optimized macro for a mul_lxl_ll or
something if possible).


> > > The first step would be to keep it separate from the current 
> > > update_wall_time() code. I just got rid of clock read in the hrtimer 
> > > interrupt code you are about to introduce it again here. Many clocks don't 
> > > need that much precision, and especially if it's an expensive operation 
> > > it's a complete waste of time.
> > 
> > With continuous cycle based counters, the clock read is *necessary* when
> > updating xtime for robust timekeeping. We can move update_wall_time so
> > we don't run it every timer interrupt, but we cannot keep correct time
> > by just guessing how much time has passed and adding it in.
> 
> It has almost nothing to do with continuous cycles. On an UP system only 
> anything running with a higher priority than the timer interrupt or if the 
> cycle adjustment happens asynchron to the timer interrupt (e.g. TSC) can 
> see the adjustment. Again it depends on the clock whether the common 
> adjustment is significant bigger than the time needed to read the clock, 
> otherwise it's just a waste of time.

Eh? I didn't understand that. Mind clarifying/expanding here?

thanks
-john

