Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVLGMSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVLGMSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVLGMSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:18:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3489 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750920AbVLGMSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:18:51 -0500
Date: Wed, 7 Dec 2005 13:18:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <1133908082.16302.93.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512070347450.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 6 Dec 2005, Thomas Gleixner wrote:

> > It looks better, but could you please explain, what these extras are 
> > good for?
> 
> One extra we kept is the list and the state field, which are useful for
> the high resolution implementation. We wanted to keep as much as
> possible common code [shared between the current low-resolution clock
> based hrtimer code and future high-resolution clock based hrtimercode]
> to avoid the big #ifdeffery all over the place.
> 
> It might turn out in the rework of the hrt bits that the list can go
> away, but this is a nobrainer to do. (The very first unpublished version
> of ktimers had no list, it got introduced during the hrt addon and
> stayed there to make the hrt patch less intrusive.)

If it's such a nobrainer to remove it, why don't you add it later? As it 
is right now, it's not needed and nobody but you knows what it's good for. 
This way yoy make it only harder to review the code, if one stumbles over 
these pieces all the time.

> > Nice, that you finally also come to that conclusion, after I said that 
> > already for ages. (It's also interesting how you do that without 
> > giving me any credit for it.)
> 
> Sorry if it was previously your idea and if we didnt credit you for it.
> I did not keep track of each word said in these endless mail threads. We
> credited every suggestion and idea which we picked up from you, see our
> previous emails. If we missed one, it was definitely not intentional.

http://marc.theaimsgroup.com/?l=linux-kernel&m=112755827327101
http://marc.theaimsgroup.com/?l=linux-kernel&m=112760582427537

A bit later ktime_t looked pretty much like the 64bit part of my ktimespec.
I don't won't to imply any intention, but please try to see this from my 
perspective, after this happens a number of times.

> Setting up a periodic timer leads to a summing-up error versus the
> expected timeline. This applies both to vanilla, ktimers and ptimers.
> The difference is how this error is showing up:
> 
> The vanilla 2.6.15-rc5 kernel has an rather constant error which is in
> the range of roughly 1ms per interval mostly independent of the given
> interval and the system load. This is roughly 1 sec per 1000 intervals.
> 
> Ktimers had a contant summing error which is exactly the delta of the
> rounded interval to the real interval. The error is number of intervals
> * delta. The error could be deduced by the application, but thats not a
> really good idea. For a 50ms interval it is 2sec / 1000 intervals, which
> is exactly the 2ms delta between the 50ms requested and the 52ms real
> interval on a system with HZ=250
> 
> Ptimers have a rounding error which depends on the delta to the jiffy
> resolution and the system load. So it gets rather unpredicitble what
> happens. The basic error is roughly the same as with ktimers, but the
> addon component due to system load is not. For a 50ms interval a summing
> error between 2sec and 7sec per 1000 intervals was measured.
> 
> So while vanilla and ktimers have a systematic error, ptimer introduces
> random Brownean motion!

Thomas, you unfortunately don't provide enough context for these numbers 
for me to reproduce them.
I don't want to guess, so please provide an example to demonstrate this.

> > Nevertheless, if you read my explanation of the rounding carefully and 
> > look at my implementation, you may notice that I still disagree with 
> > the actual implementation.
> 
> I started to read it, but your explanation seems to be completely
> detached from the testing results and the code.

Thomas, if you don't ask me, I can't help you to understand any issues, 
there might have been.

> You define that absolute interval timers on clock realtime change their
> behaviour when the initial time value is expired into relative timers
> which are not affected by time settings. I have no idea how you came to
> that interpretation of the spec. I completely disagree [but if you would
> like I can go into more detail why I think it's wrong.]

Please do. I explained it in one of my patches:

[PATCH 5/9] remove relative timer from abs_list

When an absolute timer expires, it becomes a relative timer, so remove
it from the abs_list.  The TIMER_ABSTIME flag for timer_settime()
changes the interpretation of the it_value member, but it_interval is
always a relative value and clock_settime() only affects absolute time
services.

> Beside of that, the implementation is also completely broken. (You
> rebase the timer from the realtime base to the monotonic base inside of
> the timer callback function. On return you lock the realtime base and
> enqueue the timer into the realtime queue, but the base field of the
> timer points to the monotonic queue. It needs not much phantasy to get
> this exploited into a crash.)

If you provide the wrong parameters, you can crash a lot of stuff in the 
kernel. "exploited" usually implies it can be abused from userspace, which 
is not the case here.

> Furthermore, your implementation is calculating the next expiry value
> based on the current time of the expiration rather than on the previous
> expected expiry time, which would be the natural thing to do. This
> detail also explains the system-load dependent random drifting of
> ptimers quite well.

Is this conclusion based on actual testing? The behaviour of ptimer should 
be quite close to the old jiffie based timer, so I'm a bit at a loss here, 
how you get to this conclusion. Please provide more details.

> The changes you did to the timer locking code (also in timer.c) are racy
> and simply exposable. Oleg's locking implementation is there for a good
> reason.

Thomas, bringing up this issue is really weak. With Oleg's help it's 
already solved, you don't have to warm it up. :(

> Neither do I understand the jiffie boundness you re-introduced all over
> the place. The softirq code is called once per jiffy and the expiry is
> checked versus the current time. Basing a new design on jiffies, where
> the design intends to be easily extensible to high resolution clocks, is
> wrong IMNSHO. Doing a high resolution extension on top of it is just
> introducing a lot of #ifdef mess in places where none has to be. We had
> that before, and dont want to go back there.

I don't understand where you get this from, I explicitely said that higher 
resolution requires a better clock abstraction, bascially any place which 
mentions TICK_NSEC has to be cleaned up like this. I'm at loss why you 
think this requires "a lot of #ifdef mess".

> One of your main, often repeated arguments was the complexity of
> ktimers. While ktimers held a lot of complex functionality, the "simple"
> ptimers .text size is larger than the ktimers one! I know that you claim
> that .text size is not a criteria, but Andrew seriously asked what he
> gets for the increase of .text.

Sorry, but I didn't had as much time as you to finetune my implementation. 
I did some quick tests by also deinlining some stuff, which quickly 
brought it down to the ktimer size, integrating some more cleanups should 
do the rest.
Thomas, this is hardly an argument against my implementation, I never 
claimed it to be complete. It was meant as sanely mergable version 
compared to your large ktimers patch.

Anyway, thanks for finally responding, there seem have to piled up a 
number of misconceptions, please give it some time to clear up.

bye, Roman
