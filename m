Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVLLNj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVLLNj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 08:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLLNj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 08:39:28 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58572 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750882AbVLLNj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 08:39:27 -0500
Date: Mon, 12 Dec 2005 14:39:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <1134148980.16302.409.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512120007010.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home> <1134148980.16302.409.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Dec 2005, Thomas Gleixner wrote:

> Actually the change adds more code lines and removes one field of the
> hrtimer structure, but it has exactly the same functionality: Fast
> access to the first expiring timer without walking the rb_tree.

Together with the state field this would save 12 bytes, which is IMO very 
well worth considering.
You seem to have some plans for it, the best hint I've found for it is:

+ (This seperate list is also useful for high-resolution timers where we
+ need seperate pending and expired queues while keeping the time-order
+ intact.)"

Could you please elaborate on this?

> > [PATCH 5/9] remove relative timer from abs_list
> > 
> > When an absolute timer expires, it becomes a relative timer, so remove
> > it from the abs_list.  The TIMER_ABSTIME flag for timer_settime()
> > changes the interpretation of the it_value member, but it_interval is
> > always a relative value and clock_settime() only affects absolute time
> > services.
> 
> This is your interpretation and I disagree.
> 
> If I set up a timer with a 24 hour interval, which should go off
> everyday at 6:00 AM, then I expect that this timer does this even when
> the clock is set e.g. by daylight saving. I think, that this is a
> completely valid interpretation and makes a lot of sense from a
> practical point of view. The existing implementation does it that way
> already, so why do we want to change this ?

I don't know whether this behaviour was intentional and why it was done 
this way, so I did this patch to initiate a discussion about this.

I wouldn't say a 1 day interval timer is a very realistic example and the 
old timer wouldn't be very precise for this.
The rationale for example talks about "a periodic timer with an absolute 
_initial_ expiration time", so I could also construct a valid example with 
this expectation. The more I read the spec the more I think the current 
behaviour is not correct, e.g. that ABS_TIME is only relevant for 
it_value.
So I'm interested in specific interpretations of the spec which support 
the current behaviour.

> Also you treat the interval relative to the current time of the callback
> function:
> 
> timer->expires = ktime_add(timer->base->last_expired,
> 					   timr->it.real.incr);
> 
> This leads to a summing up error and even if the result is similar to
> the summing up error of the current vanilla implementation I prefer a
> solution which adds the interval to the previous set expiry time
> 
> timer->expires = ktime_add(timer->expires,
> 	        		   timr->it.real.incr);
> 
> The spec says:
> "Also note that some implementations may choose to adjust time and/or
> interval values to exactly match the ticks of the underlying clock."
> 
> So there is no requirement to do so. Of course you may, but this takes
> simply the name "precision" ad absurdum.

Your current implementation contradicts the requirement that values should 
be rounded up to the resolution of the timer, that's exactly what my 
implementation does. The resolution of the timer is currently TICK_NSEC 
(+- ntp correction) and one expiry of it should only cause at most one 
expiry of all pending timer. If I set a 1msec timer in your implementation 
(with HZ=250), I automatically get 3 overruns, even though the timer 
really did only expire once.

Since you don't do any rounding at all anymore, your timer may now expire 
early with low resolution clocks (the old jiffies + 1 problem I explained 
in my ktime_t patch).

Also in the ktimer patch you wrote:

+- also, there is an application surprise factor, the 'do not round
+  intervals' technique can lead to the following sample sequence of
+  events:
+
+    Interval:   1.7ms
+    Resolution: 1ms
+
+    Event timeline:
+
+     2ms - 4ms - 6ms - 7ms - 9ms - 11ms - 12ms - 14ms - 16ms - 17ms ...
+
+  this 2,2,1,2,2,1...msec 'unpredictable and uneven' relative distance
+  of events could surprise applications.

But this is now exactly the bevhaviour your timer has, why is not 
"surprising" anymore?

> > > Beside of that, the implementation is also completely broken. (You
> > > rebase the timer from the realtime base to the monotonic base inside of
> > > the timer callback function. On return you lock the realtime base and
> > > enqueue the timer into the realtime queue, but the base field of the
> > > timer points to the monotonic queue. It needs not much phantasy to get
> > > this exploited into a crash.)
> > 
> > If you provide the wrong parameters, you can crash a lot of stuff in the 
> > kernel. "exploited" usually implies it can be abused from userspace, which 
> > is not the case here.
> 
> Thanks for teaching me what an "exploit" usally means! 
> 
> I intentionally wrote "exploited into a crash".
> 
> How do you think I got this to crash ? By hacking up some complex kernel
> code ? No, simply by running my unmodified test scripts from user space
> with completely valid and correct parameters. Of course its also
> possible to write a program which actually exploits this.
> 
> The implementation is simply broken. Can you just accept this ?

I can accept that you found bug, but for "simply broken" I'm not convinced 
yet.
Sorry, I have not been specific enough, I disagree with your analysis 
above. On return the timer isn't requeued into the realtime queue at all, 
so this can't be the reason for the crash. I guess it's more likely you 
managed to trigger the locking bug.

> > > Furthermore, your implementation is calculating the next expiry value
> > > based on the current time of the expiration rather than on the previous
> > > expected expiry time, which would be the natural thing to do. This
> > > detail also explains the system-load dependent random drifting of
> > > ptimers quite well.
> > 
> > Is this conclusion based on actual testing? The behaviour of ptimer should 
> > be quite close to the old jiffie based timer, so I'm a bit at a loss here, 
> > how you get to this conclusion. Please provide more details.
> 
> It is based on testing. Do you think I pulled numbers out of my nose ? 

Jeez, sorry for asking. :(
You didn't specify anywhere how you got to this conclusion, so I could 
reproduce it myself. Could you please elaborate on this "system-load 
dependent random drifting"?

> > I don't understand where you get this from, I explicitely said that higher 
> > resolution requires a better clock abstraction, bascially any place which 
> > mentions TICK_NSEC has to be cleaned up like this. I'm at loss why you 
> > think this requires "a lot of #ifdef mess".
> 
> Why do you need all this jiffie stuff in the first place? It is not
> necessary at all. The hrtimer code does not contain a single reference
> of jiffies and therefor it does not need anything to clean up. I
> consider even a single high resolution timer related #ifdef outside of
> hrtimer.c and the clock event abstraction as an unnecessary mess. Sure
> you can replace the TICK_NSEC and ktime_to_jiffie stuff completely, but
> I still do not see the point why it is necessary to put it there first.
> It just makes it overly complex to review and understand :)

In this regard I had two major goals: a) keep it as simple as possible, b) 
preserve the current behaviour and I still think I found the best 
compromise so far. This would allow to first merge the basic 
infrastructure, while reducing the risk of breaking anything.

I don't mind changing the behaviour, but I would prefer to do this in a 
separate step and with an analysis of the possible consequences. This is 
not just about posix-timers, but it also affects itimers, nanosleep and 
possibly other systems in the future. Actually my main focus is not on HR 
posix timer, my main interest is that everythings else keeps working and 
doesn't has to pay the price for it.

It's rather likely that if there is a subtle change in behaviour, which 
causes something to break, it's not noticed until it hits a release 
kernel, so I think it's very well worth it to understand and document the 
differences between the implementations.

> Please stop your absurd schoolmasterly attempts to teach me stuff which
> I'm well aware off. Can you please accept, that I exactly know what I'm
> talking about?

Sure, I can. I'm sorry I tried to explain things you already know, but if 
you know these things already, then please show it. At this point I'm 
mostly still trying to understand, why you did certain things and 
sometimes I explain things from my perspective in the hopes you would fill 
in the holes from your perspective.

You mostly just post your patches and only explain the conclusion, you're 
make it rather short on how you get to these conclusions, e.g. what other 
alternatives you've already considered. This makes it hard for me to 
figure out what you know exactly from what you're talking about.

> But I seriously will ignore you completely, if you keep this tone and
> attitude with me.

Jeez, cut me some slack, would you? Especially in the last mail I mostly 
just asked for more information. You read something into my mails, that is 
simply not there.

bye, Roman
