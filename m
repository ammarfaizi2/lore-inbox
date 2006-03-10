Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752106AbWCJCQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWCJCQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWCJCQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:16:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38123 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1752106AbWCJCQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:16:58 -0500
Date: Fri, 10 Mar 2006 03:16:40 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Experimental enhanced NTP error accounting patch
In-Reply-To: <1141701424.11401.131.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0603081430480.16802@scrub.home>
References: <1141448168.9727.148.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.64.0603041151390.16802@scrub.home> <1141701424.11401.131.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Mar 2006, john stultz wrote:

> While I do appreciate the overview (it helps verify or correct the
> similar proofs I had to do earlier in implementing this patch), I'm not
> sure I agree that integrating your ideas with the TOD patches is a bad
> thing. While I think the NTP bits will have to be reconciled, I'm not
> opposed to your ideas there, so I don't know exactly where the problem
> is.
> 
> The "extra work" I do should have some purpose (as I'm not doing this
> for fun), so either it can be eliminated or I need to justify it. Being
> more specific here, like quoting the parts in my patch you don't like
> would help.

The point is that it practically completely changes the NTP specific 
parts, so it should be part of the initial patches.

> This is an iterative approach, and while I know its frustrating to walk
> me through all of this, I do think we're making progress.

I'm not worried about making progress, I'm worried that this gets merged 
before it's ready and the NTP bits are not ready yet.

> > After changing the multiplier this will also reduce the error:
> > 
> > 	error -= freq * mult - (off * mult + (freq - off) * mult_new)
> > 
> > This is the difference between the old update and the new update (where
> > the new multiplier is only applied for the rest of the tick), simplified
> > this becomes:
> > 
> > 	error -= (freq - off) * mult_adj
> 
> This part I'll need to study a bit more as it is not so clear why the
> error must be corrected, instead of letting it be corrected in the next
> tick. I know it is required, as the error does not get dampened without
> it, but the why is less clear. I suspect it has to do with the fact that
> xtime was adjusted, and since we accumulate error as we accumulate
> xtime, we have to compensate there as well. 

This is the error of the next tick, we look ahead to the next tick, so we 
have reduced the error at the time we reach it.
So if we update the error with (ntp_update - mult * freq) we use the 
values for the current tick and if we change the multiplier we also have 
to correct the error for the remainder of the current tick. This way we 
keep the error within the limits and keep it from oscillating.

> > Finally setting time and changing clock can be done with the same
> > mechanism:
> > 
> > 	xtime = timeofday - off * mult
> > 
> > timeofday is simply the new time or the current time of the old clock,
> > this means that a clock change can be done outside the periodic hook.
> 
> This piques my interest, as I still do not quite see how the clocksource
> change can occur outside the periodic hook. I'm open to changing this as
> the clocksource changing code along with the per-interval accumulation
> does make the periodic_hook code a bit long. Breaking it up sounds like
> a nice idea, however I'm not following this part.

The basic idea is really simple:

	lock();
	new_clock->set_time(current_clock->get_time());
	current_clock = new_clock;
	unlock();

I don't quite understand the problem you see with this, only some 
currently static state has to become per clock state (which is actually a 
more general problem - too much clock state is global right now).

> > This is basically the core part of my prototype to implement a continous
> > timeofday, the rest is just an implementation detail (e.g. how mult_adj
> > becomes a shift). It's maybe not trivial, but I don't think it's that hard
> > to understand (at least using an example) and results in very simple code.
> 
> I do agree it is much computationally simpler. However more state must
> be maintained and the bit about subtracting from xtime to correct for
> the multiplier adjustment is not trivial to understand at first glance.

The only really new state is the error value, which you didn't maintain 
before.

> Now, after I sat down and proved that bit to myself, it is quite
> efficient code and I do like the idea of using it. I just want to
> maintain the readability while getting the efficiency.

I guess it's in the eye of the beholder. :)
While I do agree, it's not immediately obvious what the code does, I 
really would prefer to add the complementing information via 
documentation.

> > Maybe the main question I have about your code now is why you want to
> > calculate nsec intervals during the update, but as you can see above, it's
> > not really necessary, so what do you want to use it for?
> 
> Calculate nsec intervals during the update? I'm not sure specifically
> which bit you're talking about. Since you didn't really comment
> specifically on the code I posted, it makes it hard for me to respond.
> Could you point to a line number or a specific variable name?

For example you still calculate a delta_nsec and ppm values.
It also would really help to concentrate first on the current time 
services and add new time services (which e.g. return ktime_t) in a second 
patch. I think it's possible that the extra state information for it is 
updated once a second, in any way a separate patch would be easier to 
review and improve.

> > It would be a lot simpler to keep the updates at first at HZ frequency.
> > Later we can still change the update frequency, but ntp time has to be
> > updated in fixed intervals if we want precise time keeping. Note that
> > error adjustments can still be done asynchronously as shown above, but
> > dynamic interval ntp updates are just too complex and error-prone.
> 
> I'd be interested if you could be more specific here. What parts of the
> NTP state machine has be updated a real fixed intervals and what parts
> do not?  

I think it's better to give an example of what I have in mind.
A lot is already possible without my NTP patches, the periodic function 
could look something like this:

	off = cycles - cycles_offset;
	while (off >= update_cycles) {
		off -= update_cycles;
		cycles_offset += update_cycles;
		jiffies_64++;
		xtime_nsec += xtime_update;
		if (xtime_nsec >= (u64)NSEC_PER_SEC << 22) {
			xtime_nsec -= (u64)NSEC_PER_SEC << 22;
			xtime.tv_sec++;
			second_overflow();
		}
		xtime.tv_nsec = xtime_nsec >> 22;
		xtime_error += current_tick_length() - xtime_update;
		time_adjust_step = adjtime_adjustment();
		if (time_adjust_step)
			time_adjust -= time_adjust_step;
	}
	[error adjustment]

My patches would move the time_adjust stuff into second_overflow() and 
make it easier to change the tick length for current_tick_length().
Anyway, this loop does the fixed interval updates (and also basically 
does the same work as update_times()) and the error adjustment uses "off" 
for the asynchronous updates and please don't split the loop into multiple 
loops all over the place.
Most of the NTP work is still done in second_overflow(), there is no need 
to calculate any ppm values and no need to separate the leapsecond 
handling (at least initially) - IOW the two NTP rework patches become 
unnecessary.

> What I'm trying to do w/ ntp_advance() is inform the NTP state machine
> that the last total_sppm value calculated was used for the last X nsecs.
> So a value for the next period can be calculated. It may be that the
> last total_sppm value was applied for too long, but at least it knows
> that after the fact rather then not at all.

What should it do with this knowledge?

> Really, I'm not so picky about the NTP adjustments as I am about time
> not going backwards. So I'm very open to your ideas regarding the NTP
> state machine as long as they don't conflict with correct timekeeping.

Correct timekeeping has two aspects - short-term and long-term 
correctness. The old code maintains long-term stability by simply jumping 
to the correct time at every tick. Your code now lets the clock run 
free loosely controlled via NTP. I would really to like see to keep both 
aspects correct and preferably before it gets merged.

> Running periodic_hook() at HZ frequency is ok by me. However I think
> using 50ms intervals is a good default because ticks will be missed on
> users machines and we should have correct behavior in those cases. With
> the -rt tree, we may only run once a second! I think much like
> INITIAL_JIFFIES, using 50ms intervals forces the issue rather then
> ignoring it.

The point is that you try to fix too many things at once. The current NTP 
code is very much HZ based and correct timekeeping is also possible at HZ 
frequency, so let's concentrate first on this and I'm certain it will be 
simpler than what you have right now.
The update interval can still be changed, but that requires the functional 
cleanup my NTP patches provide.

> > I could give it a try to remove all that extra complexity to get it into
> > something mergable, but that would mean dropping quite some bits and
> > I'd prefered if we could agree on something. I simply don't have the time
> > right now to work on patches, which are rejected again in the end.
> 
> I'm not asking you to drop your work, I just want to understand your
> objections and try to integrate your ideas. Please also realize that my
> time is not infinite as well, so the sooner I can understand your ideas
> and we can agree and get this into mainline, the better. :)

That wouldn't be a problem, if there wasn't the pressure to get this 
merged as soon as possible. It seems lately it has been more important to 
get new features merged, than taking the time to do the necessary 
groundwork thoroughly.

bye, Roman
