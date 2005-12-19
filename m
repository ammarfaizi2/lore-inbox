Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVLSOun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVLSOun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVLSOun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:50:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20381 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932136AbVLSOum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:50:42 -0500
Date: Mon, 19 Dec 2005 15:50:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <1134599444.2542.76.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512191233120.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512120007010.1609@scrub.home>  <1134405768.4205.190.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512140101410.1609@scrub.home> <1134599444.2542.76.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Dec 2005, Thomas Gleixner wrote:

> The current -hrt queue contains the removal patch of the list_head
> already and you interrupted my attempt to send out the patch for -mm :)

Ok.

> > > The state field is not removed because I'm not a big fan of those
> > > overloaded fields and I prefer to pay the 4 byte penalty for the
> > > seperation.
> > > Of course if there is the absolute requirement to reduce the size, I'm
> > > not insisting on keeping it.
> > 
> > Well, I'm not a big fan of redundant state information, e.g. the pending 
> > information can be included in the rb_node (it's not as quite simple as 
> > with the timer_list, but it's the same thing). 
> 
> I do not consider this as redundant information. It's a design decision
> whether to use a state variable for state information and the rbnode for
> rbtree handling or to overload the meaning of the rbnode with
> information which is not the natural associated content. 
> 
> I'm well aware of those optimization and space saving tricks. I did
> microcontroller programming long enough, but - and out of the experience
> - I want to avoid it for new designs where ever it is possible for
> clarity and extensibility reasons.

It's not just about optimization tricks, it's about redundant information. 
Right now the primary function of the state is to tell whether the timer 
node is in the tree or now, so I prefer to add this information directly 
to the rbnode, similiar to what we do with normal lists.
The other problem is that such "simple" state variables quickly become 
inadequate as the state machine becomes more complex, especially if 
multiple processes run at the same time (e.g. a timer can be "running" 
and/or "active"). So for me it's also for clarity and extensibility 
reasons, that I want to avoid overloaded state machines and rather keep 
it as simple as possible.

> > The expired information 
> > (together with the data field) is an optimization for simple sleeps that 
> > AFAICT only makes a difference in the rt kernel (the saved context switch 
> > you mentioned above). What makes me more uncomfortable is that this is a 
> > special case optimization and other callbacks are probably fast as well 
> > (e.g. wakeup + timer restart).
> 
> Not only in a -rt kernel, it also saves the context switch for a high
> resolution timer enabled kernel, where you actually can execute the
> callback in hard interrupt context. We can solve it differently, but we
> should carefully think about the extensiblity issues. The wakeup +
> restart szenario is a good reason to reconsider this.

I don't think executing something in the soft or hard interrupt context 
makes a big difference on a normal kernel (at least I wouldn't call it a 
context switch).

> > I can understand you want to keep the difference to the rt kernel small, 
> > but for me it's more about immediate benefits against uncertain long term 
> > benefits.
> 
> If you have a clear target and the experience of having implemented the
> extensions, you have to carefully weigh up the consequences of such
> decisions. I'm not talking about "might be implemented by somebody
> sometimes features", I'm talking about existing proof of concept
> implementations. There is no real justification to ignore well known
> consequences.
> 
> Of course if you consider the possibility of including high resolution
> timers (I'm not talking about -rt) as  zero, your requests make sense. 

Thomas, please don't treat me like an idiot, you may have more experiance 
with hrtimer, but after working on it for a while I also know what I'm 
talking about. Please accept that I have different focus on this, I want 
to keep things as simple as possible. New features should stand on his 
own and this includes the complexity they add to the kernel. The new 
hrtimer especially cleans up greatly the posix timer stuff, this and 
keeping all other users working is my primary focus now.

New features add new complexity and I want to see and evaluate it at the 
time it's added to the kernel, primarily to find solutions to avoid the 
(runtime) complexity for clocks which don't want to or can't support such 
high resolutions, so they don't have to pay the price for these new 
features. I want to keep things flexible and keeping things simple is IMO 
a much better starting point.

> I disagree because I'm convinced that the problems "high res timers",
> "dynamic ticks", "timekeeping", "clock event abstraction" are closely
> related and we have high demands to get those solved in a clean way. So
> providing some jiffies bound minimal solution in the first place is more
> than shortsighted IMO.

You're misunderstanding me, I don't want "some jiffies bound minimal 
solution", I want to solve one problem at a time and fixing the jiffies 
problem requires solving problems in the clock abstraction first, 
otherwise you produce a crutch which works in most cases, but leaves a few 
problem cases behind.

> Goerge said explicitely:
> 
> > My $0.02 worth: It is clear (from the standard) that the initial time 
> > is to be ABS_TIME.  It is also clear that the interval is to be added 
> > to that time.  IMHO then, the result should have the same property, 
> > i.e. ABS_TIME. 
> 
> I dont find a way to read out that the interval should not have the
> ABSTIME property.

That's not what you wrote earlier: "I agree, that the restriction to the 
initial it_value is definitely something you can read out of the spec."

clock_settime says: "..., these time services shall expire when the 
requested relative interval elapses, independently of the new or old value 
of the clock." it_interval is a relative interval and otherwise the spec 
only talks about "an initial expiration time, again either relative or 
absolute," I can't really find a direct connection that TIMER_ABSTIME 
should apply to the interval as well.

> > > > Since you don't do any rounding at all anymore, your timer may now expire 
> > > > early with low resolution clocks (the old jiffies + 1 problem I explained 
> > > > in my ktime_t patch).
> > > 
> > > It does not expire early. The timer->expires field is still compared
> > > against now. 
> > 
> > I don't think that's enough (unless I missed something). Steven maybe 
> > explained it better than I did in
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113047529313935
> 
> Steven said:
> 
> > Interesting though, I tried to force this scenario, by changing the
> > base->get_time to return jiffies.  I have a jitter test and ran this
> > several times, and I could never get it to expire early.
> [..]
> Please elaborate how the timer can expire early.

At this time you still did the rounding of the values, so it actually 
worked.
When reading a time t from a clock with resolution r, the real time can be 
anything from t to t+r-1. Assuming it's currently t+r-1 and you try to set 
a relative timer to r-1, you will read t from the clock and arm the timer 
for t+r-1, which will cause the timer to expire at t+r, where it must not 
expire before t+r-1+r-1.
It currently only works because latencies are usually larger than the 
clock resolution, but if I want to configure hrtimer with a low resolution 
clock, the problem can become visible.

> > > > But this is now exactly the bevhaviour your timer has, why is not 
> > > > "surprising" anymore?
> > > 
> > > Yes, we wrote that before. After reconsidering the results we came to
> > > the conclusion, that we actually dont need the rounding at all because
> > > the uneven distance is equally surprising as the summing up errors
> > > introduced by rounding.
> > 
> > I don't think that the summing up error is surprising at all, the spec is 
> > quite clear that the time values have to be rounded up to the resolution 
> > of the timer and it's also the behaviour of the current timer.
> 
> No, the spec is not clear at all about this.
> 
> I pointed this out before and I still think that the part of the
> RATIONALE section is the key to this decision.
> 
> "Also note that some implementations may choose to adjust time and/or
> interval values to exactly match the ticks of the underlying clock"

You basically use this sentence as loophole to take the whole resolution 
rounding rule ad absurdum and I disagree that this sentence means 
"ignore everything above and do whatever you want".

> You decide to do the adjustment. I prefer not to do so and I dont buy
> any argument which says, that the current behaviour is the yardstick for
> everything. It can't be. Otherwise we would not be able to introduce
> high resolution timers at all. Every application which relies on some
> behaviour of the kernel which is not explicitely required by the
> specification is broken by definition. 

The problem is that you force this behaviour also on other hrtimer users
(itimers and nanosleep) and we should be very careful with such behaviour 
changes. My proposal keeps the current behaviour and is less likely to 
break anything. As I said before I'm not against changing the behaviour, 
but it should be done carefully.

> I vote strongly against introducing private, special purpose APIs and I
> consider CLOCK_XXX_HR as such. The proposed hrtimer solution does not
> introduce any penalties for people who do not enable a future high
> resolution extension. It gives us the benefit of a clean code base which
> is capable to be switched simply and non intrusive to the high
> resolution mode. We have done extensive tests on the impact of
> converting all users unconditionally to high resolution mode once it is
> switched on and the penalty is within the noise range. 
> 
> You are explicitely asking for increased complexity with your approach. 

Which in this case it would be good thing. Right now we don't have much 
choice in clock source, but that will change soon and I think it would be 
a good to be able to map a timer to specific clock source. The gained 
flexibility outweighs the required complexity greatly.

> > > While my focus is a clean merging of high resolution timers without
> > > breaking the non hrt case, I still believe that we can find a solution,
> > > where we can have the base implementation without any reference to
> > > jiffies.
> > 
> > This is what I think requires the better clock abstraction, most of it is 
> > related to the clock resolution, the generic timer code currently has no 
> > idea of the real resolution of the underlying clock, so I assumed a worst 
> > case of TICK_NSEC everywhere.
> 
> Well, can you please show where the current hrtimer implementation  is
> doing something which requires a better clock abstraction ?

1. clock resolution is unknown (see above).
2. reprogrammable timer interrupts.

> The clock abstraction layer is relevant if you actuallly want to switch
> to high resolution mode and until then the coarse interface is
> sufficient.

Right and until then it's also not really avoidable, that you find a few 
references to jiffies. I'm not saying that we have to keep them, but 
please only one step at a time.

> > What I'd like to avoid is that we have to commit ourselves to only one 
> > solution right now. I think the first solution is better suited to the low 
> > resolution timer, that we have right now. The second solution requires a 
> > better clock framework - this includes better time keeping and 
> > reprogrammable timer interrupts.
> 
> We have to choose one. Everything else is a bad compromise. There is
> nothing worse than making no decision when you are at a point where a
> decision is required.

Do you really have so little trust in your own code, that we can't afford 
the flexibility and have to hardcode the timer resolution now?

bye, Roman
