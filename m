Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVLLQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVLLQgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVLLQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:36:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58270
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751246AbVLLQgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:36:15 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0512120007010.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 12 Dec 2005 17:42:48 +0100
Message-Id: <1134405768.4205.190.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-12-12 at 14:39 +0100, Roman Zippel wrote:
> > Actually the change adds more code lines and removes one field of the
> > hrtimer structure, but it has exactly the same functionality: Fast
> > access to the first expiring timer without walking the rb_tree.
> 
> Together with the state field this would save 12 bytes, which is IMO very 
> well worth considering.
> You seem to have some plans for it, the best hint I've found for it is:
> 
> + (This seperate list is also useful for high-resolution timers where we
> + need seperate pending and expired queues while keeping the time-order
> + intact.)"
> 
> Could you please elaborate on this?

Sure. I have already removed the list_head for the non high resolution
case as it turned out that it does not hurt the high resolution
implementation.

For the high resolution implementation we have to move the expired
timers to a seperate list, as we do not want to do complex callback
functions from the event interrupt itself. But we have to reprogramm the
next event interrupt, so we need simple access to the timer which
expires first.

The initial implementation did simply move the timer from the pending
list to the expired list without doing the rb_tree removal inside of the
event interrupt handler. That way the next event for reprogramming was
the first event in the pending list.

The new rebased version with the pending list removed does the rb_tree
removal inside the event interrupt and enqueues the timer, for which the
callback function has to be executed in the softirq, to the expired
list. One exception are simple wakeup callback functions, as they are
reasonably fast and we save two context switches. The next event for
reprogramming the event interrupt is retrieved by the pointer in the
base structure.

This way the list head is only necessary for the high resolution case.

The state field is not removed

> > > [PATCH 5/9] remove relative timer from abs_list
> > > 
> > > When an absolute timer expires, it becomes a relative timer, so remove
> > > it from the abs_list.  The TIMER_ABSTIME flag for timer_settime()
> > > changes the interpretation of the it_value member, but it_interval is
> > > always a relative value and clock_settime() only affects absolute time
> > > services.
> > 
> > This is your interpretation and I disagree.
> > 
> > If I set up a timer with a 24 hour interval, which should go off
> > everyday at 6:00 AM, then I expect that this timer does this even when
> > the clock is set e.g. by daylight saving. I think, that this is a
> > completely valid interpretation and makes a lot of sense from a
> > practical point of view. The existing implementation does it that way
> > already, so why do we want to change this ?
> 
> I don't know whether this behaviour was intentional and why it was done 
> this way, so I did this patch to initiate a discussion about this.

Ok.

> I wouldn't say a 1 day interval timer is a very realistic example and the 
> old timer wouldn't be very precise for this.

Sure, as all comparisons are flawed. I just used a simple example to
illustrate my POV.

> The rationale for example talks about "a periodic timer with an absolute 
> _initial_ expiration time", so I could also construct a valid example with 
> this expectation. The more I read the spec the more I think the current 
> behaviour is not correct, e.g. that ABS_TIME is only relevant for 
> it_value.
> So I'm interested in specific interpretations of the spec which support 
> the current behaviour.

Unfortunately you find just the spec all over the place. I fear we have
to find and agree on an interpretation ourself.

I agree, that the restriction to the initial it_value is definitely
something you can read out of the spec. But it does not make a lot of
sense for me. Also the restriction to TIMER_ABSTIME is somehow strange
as it converts an CLOCK_REALTIME timer to a CLOCK_MONOTONIC timer. I
never understood the rationale behind that.

> > The spec says:
> > "Also note that some implementations may choose to adjust time and/or
> > interval values to exactly match the ticks of the underlying clock."
> > 
> > So there is no requirement to do so. Of course you may, but this takes
> > simply the name "precision" ad absurdum.
> 
> Your current implementation contradicts the requirement that values should 
> be rounded up to the resolution of the timer, that's exactly what my 
> implementation does. The resolution of the timer is currently TICK_NSEC 
> (+- ntp correction) and one expiry of it should only cause at most one 
> expiry of all pending timer. If I set a 1msec timer in your implementation 
> (with HZ=250), I automatically get 3 overruns, even though the timer 
> really did only expire once.

Damn, you are right. We did not take this into account.

> Since you don't do any rounding at all anymore, your timer may now expire 
> early with low resolution clocks (the old jiffies + 1 problem I explained 
> in my ktime_t patch).

It does not expire early. The timer->expires field is still compared
against now. 

> Also in the ktimer patch you wrote:
> 
> +- also, there is an application surprise factor, the 'do not round
> +  intervals' technique can lead to the following sample sequence of
> +  events:
> +
> +    Interval:   1.7ms
> +    Resolution: 1ms
> +
> +    Event timeline:
> +
> +     2ms - 4ms - 6ms - 7ms - 9ms - 11ms - 12ms - 14ms - 16ms - 17ms ...
> +
> +  this 2,2,1,2,2,1...msec 'unpredictable and uneven' relative distance
> +  of events could surprise applications.
> 
> But this is now exactly the bevhaviour your timer has, why is not 
> "surprising" anymore?

Yes, we wrote that before. After reconsidering the results we came to
the conclusion, that we actually dont need the rounding at all because
the uneven distance is equally surprising as the summing up errors
introduced by rounding.

> I can accept that you found bug, but for "simply broken" I'm not convinced 
> yet. Sorry, I have not been specific enough, I disagree with your analysis 
> above. On return the timer isn't requeued into the realtime queue at all, 
> so this can't be the reason for the crash. I guess it's more likely you 
> managed to trigger the locking bug.

Ok. Maybe I did not understand the code at this point.

> You didn't specify anywhere how you got to this conclusion, so I could 
> reproduce it myself. Could you please elaborate on this "system-load 
> dependent random drifting"?

As I said already, my conclusion was wrong. This showed up on a SMP
machine not on UP, when the system load was high. (The timeline was
randomly off)

> > > I don't understand where you get this from, I explicitely said that higher 
> > > resolution requires a better clock abstraction, bascially any place which 
> > > mentions TICK_NSEC has to be cleaned up like this. I'm at loss why you 
> > > think this requires "a lot of #ifdef mess".
> > 
> > Why do you need all this jiffie stuff in the first place? It is not
> > necessary at all. The hrtimer code does not contain a single reference
> > of jiffies and therefor it does not need anything to clean up. I
> > consider even a single high resolution timer related #ifdef outside of
> > hrtimer.c and the clock event abstraction as an unnecessary mess. Sure
> > you can replace the TICK_NSEC and ktime_to_jiffie stuff completely, but
> > I still do not see the point why it is necessary to put it there first.
> > It just makes it overly complex to review and understand :)
> 
> In this regard I had two major goals: a) keep it as simple as possible, b) 
> preserve the current behaviour and I still think I found the best 
> compromise so far. This would allow to first merge the basic 
> infrastructure, while reducing the risk of breaking anything.
>
> I don't mind changing the behaviour, but I would prefer to do this in a 
> separate step and with an analysis of the possible consequences. This is 
> not just about posix-timers, but it also affects itimers, nanosleep and 
> possibly other systems in the future. Actually my main focus is not on HR 
> posix timer, my main interest is that everythings else keeps working and 
> doesn't has to pay the price for it.

While my focus is a clean merging of high resolution timers without
breaking the non hrt case, I still believe that we can find a solution,
where we can have the base implementation without any reference to
jiffies.

> It's rather likely that if there is a subtle change in behaviour, which 
> causes something to break, it's not noticed until it hits a release 
> kernel, so I think it's very well worth it to understand and document the 
> differences between the implementations.

Sure.

Our goal was to keep the code almost identical independend of the
driving clock source.

I try to compare and contrast the two possible solutions:

Rounding the initial expiry time and the interval results in a summing
up error, which depends on the delta of the interval and the
resolution. 

The non rounding solution results in a summing up error for intervals
which are less than the resolution. For intervals >= resolution no
summing up error is happening, but for intervals, which are not a
multiple of the resolution, an uneven interval as close as possible to
the timeline is delivered.

In both cases the timers never expire early and I think both variants
are compliant with the specification.

> Sure, I can. I'm sorry I tried to explain things you already know, but if 
> you know these things already, then please show it. At this point I'm 
> mostly still trying to understand, why you did certain things and 
> sometimes I explain things from my perspective in the hopes you would fill 
> in the holes from your perspective.
>
> You mostly just post your patches and only explain the conclusion, you're 
> make it rather short on how you get to these conclusions, e.g. what other 
> alternatives you've already considered. This makes it hard for me to 
> figure out what you know exactly from what you're talking about.

Ok. Will try to get this better.

	tglx


