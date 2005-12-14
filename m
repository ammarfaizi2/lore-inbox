Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVLNUtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVLNUtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVLNUtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:49:24 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46817 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964959AbVLNUtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:49:23 -0500
Date: Wed, 14 Dec 2005 21:48:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <1134405768.4205.190.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512140101410.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Dec 2005, Thomas Gleixner wrote:

> For the high resolution implementation we have to move the expired
> timers to a seperate list, as we do not want to do complex callback
> functions from the event interrupt itself. But we have to reprogramm the
> next event interrupt, so we need simple access to the timer which
> expires first.
> 
> The initial implementation did simply move the timer from the pending
> list to the expired list without doing the rb_tree removal inside of the
> event interrupt handler. That way the next event for reprogramming was
> the first event in the pending list.
> 
> The new rebased version with the pending list removed does the rb_tree
> removal inside the event interrupt and enqueues the timer, for which the
> callback function has to be executed in the softirq, to the expired
> list. One exception are simple wakeup callback functions, as they are
> reasonably fast and we save two context switches. The next event for
> reprogramming the event interrupt is retrieved by the pointer in the
> base structure.
> 
> This way the list head is only necessary for the high resolution case.

Thanks for the explanation. If it's just for reprogramming the interrupt, 
it should be cheaper to just check the rbtree than walk the list to find 
the next expiration time (at least theoretically). This leaves only 
optimizations for rt kernel and from the base kernel point of view I 
prefer the immediate space savings.

> The state field is not removed because I'm not a big fan of those
> overloaded fields and I prefer to pay the 4 byte penalty for the
> seperation.
> Of course if there is the absolute requirement to reduce the size, I'm
> not insisting on keeping it.

Well, I'm not a big fan of redundant state information, e.g. the pending 
information can be included in the rb_node (it's not as quite simple as 
with the timer_list, but it's the same thing). The expired information 
(together with the data field) is an optimization for simple sleeps that 
AFAICT only makes a difference in the rt kernel (the saved context switch 
you mentioned above). What makes me more uncomfortable is that this is a 
special case optimization and other callbacks are probably fast as well 
(e.g. wakeup + timer restart).

I can understand you want to keep the difference to the rt kernel small, 
but for me it's more about immediate benefits against uncertain long term 
benefits.

> > The rationale for example talks about "a periodic timer with an absolute 
> > _initial_ expiration time", so I could also construct a valid example with 
> > this expectation. The more I read the spec the more I think the current 
> > behaviour is not correct, e.g. that ABS_TIME is only relevant for 
> > it_value.
> > So I'm interested in specific interpretations of the spec which support 
> > the current behaviour.
> 
> Unfortunately you find just the spec all over the place. I fear we have
> to find and agree on an interpretation ourself.
> 
> I agree, that the restriction to the initial it_value is definitely
> something you can read out of the spec. But it does not make a lot of
> sense for me. Also the restriction to TIMER_ABSTIME is somehow strange
> as it converts an CLOCK_REALTIME timer to a CLOCK_MONOTONIC timer. I
> never understood the rationale behind that.

As George already said, it's easier to keep these clocks separate. I think 
the spec rationale is also more clear about the intended usage. About 
timers it says: 

"Two timer types are required for a system to support realtime 
applications:

1. One-shot
...

2. Periodic
..."

Basically you have two independent timer types. It's quite explicit about 
that only the "initial timer expiration" can be relative or absolute. It 
doesn't say anywhere that there are relative and absolute periodic timer, 
all references to "absolute" or "relative" are only in connection with the 
initial expiration time and after the initial expiration, it becomes a 
periodic timer. At every timer expiration the timer is reloaded with a 
relative time interval.
I can understand that you find this behaviour useful (although other 
people may disagree) and the spec doesn't explicitely say that you must 
not do this, but I really can't convince myself that this is the 
_intendend_ behaviour.

> > Since you don't do any rounding at all anymore, your timer may now expire 
> > early with low resolution clocks (the old jiffies + 1 problem I explained 
> > in my ktime_t patch).
> 
> It does not expire early. The timer->expires field is still compared
> against now. 

I don't think that's enough (unless I missed something). Steven maybe 
explained it better than I did in
http://marc.theaimsgroup.com/?l=linux-kernel&m=113047529313935

Even if you set the timer resolution to 1 nsec, there is still the 
resolution of the actual hardware clock and it has to be taken into 
account somewhere when you start a relative timer. Even if the clock 
resolution is usually higher than the normal latency, so the problem won't 
be visible for most people, the general timer code should take this into 
account. If someone doesn't care about high resolution timer, he can still 
use it with a low resolution clock (e.g. jiffies) and then this becomes a 
problem.

> > But this is now exactly the bevhaviour your timer has, why is not 
> > "surprising" anymore?
> 
> Yes, we wrote that before. After reconsidering the results we came to
> the conclusion, that we actually dont need the rounding at all because
> the uneven distance is equally surprising as the summing up errors
> introduced by rounding.

I don't think that the summing up error is surprising at all, the spec is 
quite clear that the time values have to be rounded up to the resolution 
of the timer and it's also the behaviour of the current timer.
This error is actually the expected behaviour for any timer with a 
resolution different from 1 nsec. I don't want to say that we can't have 
such a timer, but I'm not so sure whether this should be the default 
behaviour. I actually prefer George's earlier suggestion of CLOCK_REALTIME 
and CLOCK_REALTIME_HR, where one is possibly faster and the other is more 
precise. Even within the kernel I would prefer to map itimer and nanosleep 
to the first clock (maybe also based on arch/kconfig defaults).
OTOH if the hardware allows it, both clocks can do the same thing, but I 
really would like to have the possibility to give higher (and thus 
possibly more expensive) resolution only to those asking for it.

> > I don't mind changing the behaviour, but I would prefer to do this in a 
> > separate step and with an analysis of the possible consequences. This is 
> > not just about posix-timers, but it also affects itimers, nanosleep and 
> > possibly other systems in the future. Actually my main focus is not on HR 
> > posix timer, my main interest is that everythings else keeps working and 
> > doesn't has to pay the price for it.
> 
> While my focus is a clean merging of high resolution timers without
> breaking the non hrt case, I still believe that we can find a solution,
> where we can have the base implementation without any reference to
> jiffies.

This is what I think requires the better clock abstraction, most of it is 
related to the clock resolution, the generic timer code currently has no 
idea of the real resolution of the underlying clock, so I assumed a worst 
case of TICK_NSEC everywhere.

> I try to compare and contrast the two possible solutions:
> 
> Rounding the initial expiry time and the interval results in a summing
> up error, which depends on the delta of the interval and the
> resolution. 
> 
> The non rounding solution results in a summing up error for intervals
> which are less than the resolution. For intervals >= resolution no
> summing up error is happening, but for intervals, which are not a
> multiple of the resolution, an uneven interval as close as possible to
> the timeline is delivered.
> 
> In both cases the timers never expire early and I think both variants
> are compliant with the specification.

What I'd like to avoid is that we have to commit ourselves to only one 
solution right now. I think the first solution is better suited to the low 
resolution timer, that we have right now. The second solution requires a 
better clock framework - this includes better time keeping and 
reprogrammable timer interrupts.
At this point I wouldn't like to settle on just one solution, I had to 
see more of the infrastructure integrated before doing this. At this point 
I see more advantages in having a choice (may it be as Kconfig or even a 
runtime option).

bye, Roman
