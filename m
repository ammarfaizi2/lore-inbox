Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWEIWs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWEIWs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWEIWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:48:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38365 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751339AbWEIWs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:48:56 -0400
Date: Wed, 10 May 2006 00:48:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1147134554.2914.40.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605091247420.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home> 
 <1144432638.2745.61.camel@leatherman>  <Pine.LNX.4.64.0604270025520.32445@scrub.home>
  <1146881053.12414.22.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.64.0605061448420.32445@scrub.home>  <1147113212.13441.44.camel@localhost.localdomain>
  <Pine.LNX.4.64.0605082108570.17704@scrub.home> <1147134554.2914.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 May 2006, john stultz wrote:

> On Mon, 2006-05-08 at 23:15 +0200, Roman Zippel wrote:
> > The point is to give the _clock_ control over this kind of stuff, only the 
> > clock driver knows how to deal with this efficiently, so as long as you 
> > try to create a "dumb" clock driver you're going to make things only 
> > worse. Now the archs have most control over it, but creating a single 
> > bloated and slow blop instead will not be an improvement.
> > It's not about moving everything into the clock driver here, it's about 
> > creating a _powerful_ API, which leaves control in the hands of the clock 
> > driver, but at the same time keeps them as _simple_ (and not as dumb) as 
> > possible.
> 
> Part of my concern here is keeping the code manageable and hackable.
> What you're suggesting sounds very similar to what we have for the i386
> timer_opts code, which I don't want to duplicate.

What are you talking about???

Let's take a simple example: 

static cycle_t read_tsc(void)
{       
	cycle_t ret;

	rdtscll(ret);

	return ret;
}

which could become:

static unsigned long tsc_nsec_offset(struct clocksource *cs)
{
	cycle_t cyc;

	rdtscll(cyc);

	return generic_cont_cycle2nsec_offset(cs, cyc, 22, (cycle_t)-1);
}

Please tell me what kind of problem you have with this? Even in this 
simple case it will already be faster due to the constant parameters.
What is wrong with a little extra performance?

> Maybe it would help here if you would better define the API for this
> abstraction. As it stands, it appears incomplete. Define the state
> values stored, and list what interfaces modify which state values, etc.
> 
> 	ie: clock->get_nsec_offset():
> 		What exactly does this measure? Is this strictly defined by the state
> stored in the clocksource? If not, how will this interact w/ dynamic
> ticks? What is the maximum time we can delay interrupts before the clock
> wraps? How do we know if its tick based? 

I explained this already at the start of this thread and please read the 
patch. I'm truly baffled, that you actually have to ask these questions.

> Another issue: if get_nsec_offset() is clock specific in its
> implementation, but the state values it uses in at least the common case
> are modified by generic code, how can we implement something like the
> ppc lock free read? That will affect both the generic code and the clock
> specific code.

You basically have two copies of the time parameters, for 
get_nsec_offset() this only means it gets a different structure argument, 
the rest is the same. The pointer switch between these two copies can be 
done generically.

> > What kind of NTP adjustments are you talking about? A nsec_offset function 
> > could look like this:
> > 
> > unsigned long nsec_offset(cs)
> > {
> > 	return ((cs->xtime_nsec + get_cycles() - cs->last_offset) * cs->mult) >> SHIFT;
> > }
> > 
> > This is fucking simple, what about this is "messy"? There is no NTP 
> > adjustment here, this is all happening somewhere else. 
> 
> That's my point. if nsec_offset is opaque, then what is the interface
> for making NTP adjustments to that function? Are all nsec_offset
> functions required to use the xtime_nsec, last_offset, and mult values?

These values are not opaque, from an average kernel hacker I would at 
least expect to understand what these values mean, but he doesn't has to 
know how they are adjusted (or even calculated) and for this function it's 
also not really important.

> > Keeping it in the 
> > driver allows to make parameter constant, skip unnecessary steps and 
> > allows to do it within 32bit. This is something you can _never_ do in a 
> > generic centralized way without making it truly messy. I'd be happy to be 
> > proven otherwise, but I simply don't see it.
> 
> Well, my issue w/ you desire to have a 32bit continuous clock is that I
> don't know how useful it would be. 
> 
> For a 1Mhz clock, 
> 	You've got 1,000 ns per cycle and the algorithm looks something like
> say:
> 	get_nsec_offset: cycles * 1,000 >> 0
> which gives you ~4 seconds of leeway, which is pretty good.
> However, the short term jitter is 1000ppm.

I think you mean 1000ppb or 1ppm. 
Anyway, it's still not entirely correct. The short term jitter (for a 
continuous clock) is defined by two parameters. First you have the base 
jitter defined by the clock frequency of 1/freq seconds (which is also 
independent of the used shift), so even with a perfectly synchronized 
signal there is a jitter of +-0.5ppm. The second parameter is defined by 
the size of the adjustment steps, which depends on the shift and HZ: 
freq/2^shift/HZ nsec. This means in this case with HZ=1000 adjustment adds 
a jitter of +-0.5ppm or with HZ=100 it's +-5ppm.

> So lets bump up the SHIFT value,
> 	get_nsec_offset: cycles * 1,024,000 >> 10
> 
> The short term jitter: <1ppm, so that's good.
> But the max cycles is then ~4,000 (4ms), which is too short.
> 
> You can wiggle around here and maybe come up with something that works,
> but it only gets worse for clocks that are faster. 

You don't have to "wiggle" around anything. Using log2(freq^2/10^9/HZ) you 
can calculate a shift value with an adjustment step which matches the 
clock resolution, so with HZ=100 and a shift of 4 the adjustment step is 
+-0.3125ppm and with a shift of 5 it's +-0.15625ppm, which is good enough 
and wraps around after 134msec (If you lose that many update ticks you 
have other problems already and with a tick based clock you wouldn't 
notice it anyway). So if the clock resolution is only around 1usec anyway,  
a 32bit calculation of the offset is perfectly usable.

I don't really expect to know these details from many people, but if you 
want to maintain the clock system, you have to know this, you have to know 
what is possible and what isn't and why. I'm really scared if you create 
your code by "wiggling" around with it until it somehow fits.

> For robust timekeeping using continuous cycles, I think the 64bit mult
> in gettimeofday is going to be necessary in the majority of cases (we
> can wrap it in some sort of arch optimized macro for a mul_lxl_ll or
> something if possible).

Actually currently you use a mul_llxl_ll, which is considerably more 
expensive on many archs. With current GHz clocks and the possible delays 
of the timer interrupt in the rt kernel we are currently pushing the 
limits and a mul_llxl_ll may be needed, which is perfectly fine. What is 
not ok, is forcing it onto everyone by design. If something is not 
generally true, you cannot make it generic!
What makes this worse that you don't optimize for the majority of cases, 
but that you have to do it for the worst case, this is the reason it's a
mul_llxl_ll not mul_lxl_ll. Giving the clock control over this you could 
register two different clock and have a choice whether you want the slow, 
low priority clock, which can go a few seconds without updates, or the 
fast clock, which needs updates a few times a second. With your cycle 
based design you'll never have this kind of flexibility, are you really 
sure nobody ever needs that?

> > > With continuous cycle based counters, the clock read is *necessary* when
> > > updating xtime for robust timekeeping. We can move update_wall_time so
> > > we don't run it every timer interrupt, but we cannot keep correct time
> > > by just guessing how much time has passed and adding it in.
> > 
> > It has almost nothing to do with continuous cycles. On an UP system only 
> > anything running with a higher priority than the timer interrupt or if the 
> > cycle adjustment happens asynchron to the timer interrupt (e.g. TSC) can 
> > see the adjustment. Again it depends on the clock whether the common 
> > adjustment is significant bigger than the time needed to read the clock, 
> > otherwise it's just a waste of time.
> 
> Eh? I didn't understand that. Mind clarifying/expanding here?

If the clock is updated at exactly every freq/HZ cycles, you won't see a 
jump due to the clock adjustment. This means only if you delay the timer 
interrupt can you cause a time jump and this delay has to be large enough 
to produce a large enough jump to be noticable (without correcting for 
it).
The nsec offset is adjusted by (offset >> (shift - mult_adj)) nsec, this 
means IOW the correction is adjustment_offset*delay, e.g. if the clock is 
adjusted by 1msec/sec and the delay is 1msec (one tick!), the correction 
is 1usec. IOW you already need quite large adjustments and delay to 
produce a significant adjustment for the delay, so for slow clocks it's 
pretty much guaranteed to be a complete waste of time.

bye, Roman
