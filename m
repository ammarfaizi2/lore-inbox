Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVLNWYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVLNWYB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVLNWYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:24:00 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42167
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965025AbVLNWYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:24:00 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0512140101410.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>
	 <1134405768.4205.190.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512140101410.1609@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 14 Dec 2005 23:30:44 +0100
Message-Id: <1134599444.2542.76.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-12-14 at 21:48 +0100, Roman Zippel wrote:
> > 
> > This way the list head is only necessary for the high resolution case.
> 
> Thanks for the explanation. If it's just for reprogramming the interrupt, 
> it should be cheaper to just check the rbtree than walk the list to find 
> the next expiration time (at least theoretically). This leaves only 
> optimizations for rt kernel and from the base kernel point of view I 
> prefer the immediate space savings.

The current -hrt queue contains the removal patch of the list_head
already and you interrupted my attempt to send out the patch for -mm :)

> > The state field is not removed because I'm not a big fan of those
> > overloaded fields and I prefer to pay the 4 byte penalty for the
> > seperation.
> > Of course if there is the absolute requirement to reduce the size, I'm
> > not insisting on keeping it.
> 
> Well, I'm not a big fan of redundant state information, e.g. the pending 
> information can be included in the rb_node (it's not as quite simple as 
> with the timer_list, but it's the same thing). 

I do not consider this as redundant information. It's a design decision
whether to use a state variable for state information and the rbnode for
rbtree handling or to overload the meaning of the rbnode with
information which is not the natural associated content. 

I'm well aware of those optimization and space saving tricks. I did
microcontroller programming long enough, but - and out of the experience
- I want to avoid it for new designs where ever it is possible for
clarity and extensibility reasons.

> The expired information 
> (together with the data field) is an optimization for simple sleeps that 
> AFAICT only makes a difference in the rt kernel (the saved context switch 
> you mentioned above). What makes me more uncomfortable is that this is a 
> special case optimization and other callbacks are probably fast as well 
> (e.g. wakeup + timer restart).

Not only in a -rt kernel, it also saves the context switch for a high
resolution timer enabled kernel, where you actually can execute the
callback in hard interrupt context. We can solve it differently, but we
should carefully think about the extensiblity issues. The wakeup +
restart szenario is a good reason to reconsider this.

> I can understand you want to keep the difference to the rt kernel small, 
> but for me it's more about immediate benefits against uncertain long term 
> benefits.

If you have a clear target and the experience of having implemented the
extensions, you have to carefully weigh up the consequences of such
decisions. I'm not talking about "might be implemented by somebody
sometimes features", I'm talking about existing proof of concept
implementations. There is no real justification to ignore well known
consequences.

Of course if you consider the possibility of including high resolution
timers (I'm not talking about -rt) as  zero, your requests make sense. 

I disagree because I'm convinced that the problems "high res timers",
"dynamic ticks", "timekeeping", "clock event abstraction" are closely
related and we have high demands to get those solved in a clean way. So
providing some jiffies bound minimal solution in the first place is more
than shortsighted IMO.

> > > The rationale for example talks about "a periodic timer with an absolute 
> > > _initial_ expiration time", so I could also construct a valid example with 
> > > this expectation. The more I read the spec the more I think the current 
> > > behaviour is not correct, e.g. that ABS_TIME is only relevant for 
> > > it_value.
> > > So I'm interested in specific interpretations of the spec which support 
> > > the current behaviour.
> > 
> > Unfortunately you find just the spec all over the place. I fear we have
> > to find and agree on an interpretation ourself.
> > 
> > I agree, that the restriction to the initial it_value is definitely
> > something you can read out of the spec. But it does not make a lot of
> > sense for me. Also the restriction to TIMER_ABSTIME is somehow strange
> > as it converts an CLOCK_REALTIME timer to a CLOCK_MONOTONIC timer. I
> > never understood the rationale behind that.
> 
> As George already said, it's easier to keep these clocks separate. I think 
> the spec rationale is also more clear about the intended usage. About 
> timers it says: 
> 
> "Two timer types are required for a system to support realtime 
> applications:
> 
> 1. One-shot
> ...
> 
> 2. Periodic
> ..."
> 
> Basically you have two independent timer types. It's quite explicit about 
> that only the "initial timer expiration" can be relative or absolute. It 
> doesn't say anywhere that there are relative and absolute periodic timer, 
> all references to "absolute" or "relative" are only in connection with the 
> initial expiration time and after the initial expiration, it becomes a 
> periodic timer. At every timer expiration the timer is reloaded with a 
> relative time interval.
> I can understand that you find this behaviour useful (although other 
> people may disagree) and the spec doesn't explicitely say that you must 
> not do this, but I really can't convince myself that this is the 
> _intendend_ behaviour.

Goerge said explicitely:

> My $0.02 worth: It is clear (from the standard) that the initial time 
> is to be ABS_TIME.  It is also clear that the interval is to be added 
> to that time.  IMHO then, the result should have the same property, 
> i.e. ABS_TIME. 

I dont find a way to read out that the interval should not have the
ABSTIME property.


> > > Since you don't do any rounding at all anymore, your timer may now expire 
> > > early with low resolution clocks (the old jiffies + 1 problem I explained 
> > > in my ktime_t patch).
> > 
> > It does not expire early. The timer->expires field is still compared
> > against now. 
> 
> I don't think that's enough (unless I missed something). Steven maybe 
> explained it better than I did in
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113047529313935

Steven said:

> Interesting though, I tried to force this scenario, by changing the
> base->get_time to return jiffies.  I have a jitter test and ran this
> several times, and I could never get it to expire early.  I even changed
> HZ back to 100.
> 
> Then I looked at run_ktimer_queue.  And here we have the compare:
> 
> 		timer = list_entry(base->pending.next, struct ktimer, list);
> 		if (ktime_cmp(now, <=, timer->expires))
> 			break;
> 
> So, the timer does _not_ get processed if it is after or _equal_ to the
> current time.  So although the timer may go off early, the expired queue
> does not get executed.  So the above example would not go off at 3.2,
> but some time in the 4 category

Again, I'm not able to find the problem. 

while(timers_pending()) {
	timer = getnext_timer();
	if (timer->expires > now)
		break;
	execute_callback();
}

Please elaborate how the timer can expire early.

> Even if you set the timer resolution to 1 nsec, there is still the 
> resolution of the actual hardware clock and it has to be taken into 
> account somewhere when you start a relative timer. Even if the clock 
> resolution is usually higher than the normal latency, so the problem won't 
> be visible for most people, the general timer code should take this into 
> account. If someone doesn't care about high resolution timer, he can still 
> use it with a low resolution clock (e.g. jiffies) and then this becomes a 
> problem.

I'm completely lost on this.
Can you please make up a simple example with numbers?

If you disable high resolution timers then the resolution is jiffies.
The simple comparision which determines whether the timer is expired or
not is still valid.

> > > But this is now exactly the bevhaviour your timer has, why is not 
> > > "surprising" anymore?
> > 
> > Yes, we wrote that before. After reconsidering the results we came to
> > the conclusion, that we actually dont need the rounding at all because
> > the uneven distance is equally surprising as the summing up errors
> > introduced by rounding.
> 
> I don't think that the summing up error is surprising at all, the spec is 
> quite clear that the time values have to be rounded up to the resolution 
> of the timer and it's also the behaviour of the current timer.

No, the spec is not clear at all about this.

I pointed this out before and I still think that the part of the
RATIONALE section is the key to this decision.

"Also note that some implementations may choose to adjust time and/or
interval values to exactly match the ticks of the underlying clock"

You decide to do the adjustment. I prefer not to do so and I dont buy
any argument which says, that the current behaviour is the yardstick for
everything. It can't be. Otherwise we would not be able to introduce
high resolution timers at all. Every application which relies on some
behaviour of the kernel which is not explicitely required by the
specification is broken by definition. 

The compliance requirement is the yardstick, not some random
implementation detail which happens to be compliant.

> This error is actually the expected behaviour for any timer with a 
> resolution different from 1 nsec. I don't want to say that we can't have 
> such a timer, but I'm not so sure whether this should be the default 
> behaviour. I actually prefer George's earlier suggestion of CLOCK_REALTIME 
> and CLOCK_REALTIME_HR, where one is possibly faster and the other is more 
> precise. Even within the kernel I would prefer to map itimer and nanosleep 
> to the first clock (maybe also based on arch/kconfig defaults).
> OTOH if the hardware allows it, both clocks can do the same thing, but I 
> really would like to have the possibility to give higher (and thus 
> possibly more expensive) resolution only to those asking for it.

Thats an rather odd approach for me. If we drag this further then we
might consider that only some users (i.e. applications) of -rt patches
are using the enhanced functionalities, which introduces interesting
computational problems (e.g when to treat a mutex as a concurrency
control which is capable of priority inversion or not). 

I vote strongly against introducing private, special purpose APIs and I
consider CLOCK_XXX_HR as such. The proposed hrtimer solution does not
introduce any penalties for people who do not enable a future high
resolution extension. It gives us the benefit of a clean code base which
is capable to be switched simply and non intrusive to the high
resolution mode. We have done extensive tests on the impact of
converting all users unconditionally to high resolution mode once it is
switched on and the penalty is within the noise range. 

You are explicitely asking for increased complexity with your approach. 

> > > I don't mind changing the behaviour, but I would prefer to do this in a 
> > > separate step and with an analysis of the possible consequences. This is 
> > > not just about posix-timers, but it also affects itimers, nanosleep and 
> > > possibly other systems in the future. Actually my main focus is not on HR 
> > > posix timer, my main interest is that everythings else keeps working and 
> > > doesn't has to pay the price for it.
> > 
> > While my focus is a clean merging of high resolution timers without
> > breaking the non hrt case, I still believe that we can find a solution,
> > where we can have the base implementation without any reference to
> > jiffies.
> 
> This is what I think requires the better clock abstraction, most of it is 
> related to the clock resolution, the generic timer code currently has no 
> idea of the real resolution of the underlying clock, so I assumed a worst 
> case of TICK_NSEC everywhere.

Well, can you please show where the current hrtimer implementation  is
doing something which requires a better clock abstraction ?

The clock abstraction layer is relevant if you actuallly want to switch
to high resolution mode and until then the coarse interface is
sufficient.

> > I try to compare and contrast the two possible solutions:
> > 
> > Rounding the initial expiry time and the interval results in a summing
> > up error, which depends on the delta of the interval and the
> > resolution. 
> > 
> > The non rounding solution results in a summing up error for intervals
> > which are less than the resolution. For intervals >= resolution no
> > summing up error is happening, but for intervals, which are not a
> > multiple of the resolution, an uneven interval as close as possible to
> > the timeline is delivered.
> > 
> > In both cases the timers never expire early and I think both variants
> > are compliant with the specification.
> 
> What I'd like to avoid is that we have to commit ourselves to only one 
> solution right now. I think the first solution is better suited to the low 
> resolution timer, that we have right now. The second solution requires a 
> better clock framework - this includes better time keeping and 
> reprogrammable timer interrupts.

We have to choose one. Everything else is a bad compromise. There is
nothing worse than making no decision when you are at a point where a
decision is required.

Please provide one reproducable scenario why a better time keeping and a
reprogrammable timer interrupt is required. The current hrtimer code
does not need this at all. Only if you want to have higher resolution
you need this and we use it in the high resolution timer queue - both
the timekeeping and the reprogamming abstraction layer.

> At this point I wouldn't like to settle on just one solution, I had to 
> see more of the infrastructure integrated before doing this. At this point 
> I see more advantages in having a choice (may it be as Kconfig or even a 
> runtime option).

Well, I do not see a point why we want to have Kconfig, runtime or
whatever choices for a non existant problem at all.

	tglx



