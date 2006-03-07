Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWCGDRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWCGDRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWCGDRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:17:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:54961 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932642AbWCGDRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:17:07 -0500
Subject: Re: [RFC][PATCH] Experimental enhanced NTP error accounting patch
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603041151390.16802@scrub.home>
References: <1141448168.9727.148.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0603041151390.16802@scrub.home>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 19:17:04 -0800
Message-Id: <1141701424.11401.131.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 14:55 +0100, Roman Zippel wrote:
> Hi,
> 
> On Fri, 3 Mar 2006, john stultz wrote:
> 
> > Hey Roman,
> > 	I'm sure you've got a number of things going on, but since I didn't
> > hear anything back from you last time I posted this, I figured I'd try
> > again.
> 
> Sorry about that, I was working on other things. Below are some notes 
> which hopefully help to understand the basic parts.

Quite understandable :) We've all got other things to do.


> > Here is my first pass implementation of your suggested enhanced NTP
> > error accounting for the generic timekeeping code.
> 
> I don't think it's the right way to go. You do a lot of extra work and 
> adding pieces of my code on top of it is going to be error-prone. To help 
> understanding the basics of my patch let me outline the core math
> of it. 

While I do appreciate the overview (it helps verify or correct the
similar proofs I had to do earlier in implementing this patch), I'm not
sure I agree that integrating your ideas with the TOD patches is a bad
thing. While I think the NTP bits will have to be reconciled, I'm not
opposed to your ideas there, so I don't know exactly where the problem
is.

The "extra work" I do should have some purpose (as I'm not doing this
for fun), so either it can be eliminated or I need to justify it. Being
more specific here, like quoting the parts in my patch you don't like
would help.

This is an iterative approach, and while I know its frustrating to walk
me through all of this, I do think we're making progress.


> The ntp code provides the time update per tick:
> 
> 	ntp_update = 1sec + adjustments
> 
> That's all the clock code needs from the ntp code (the details of its 
> calculation is not really important here) and ntp updates are done in tick 
> intervals. For simplicity let's assume HZ=1 so that the clock is updated 
> every tick by:
> 
> 	xtime += freq * mult

Yep, fundamentally this is the same, although I store
(freq/interval)*mult into clocksource.interval_snsecs and use the
current cycle value to sort out how many full intervals have passed
instead of assuming one-interval per tick. Just like your prototype.

> Due to resolution differences this produces an error with every update,
> which we accumulate as:
> 
> 	error += ntp_update - freq * mult

Yep. Same calculation is done in my patch. And we accumulate the error
on a per-interval basis.

> As soon as the error is large we can calculate a new multiplier:
> 
> 	freq * mult_new = freq * mult + error
> 
> which becomes:
> 
> 	mult_adj = mult_new - mult = error / freq
> 
> Implementation note: The adjustment calculation is a bit more complicated
> than this for various reasons, but that's really just an implementation
> detail.

I think I have this covered in the make_ntp_adj and error_approximation
functions. 


> To keep timeofday the same after changing the multiplier we also have to
> change the base xtime:
> 
> 	timeofday = xtime + off * mult = xtime_new + off * mult_new
> 
> so simplified xtime is changed as:
> 
> 	xtime -= off * mult_adj

Again, I believe this is done correctly by the return value of
make_ntp_adj().


> After changing the multiplier this will also reduce the error:
> 
> 	error -= freq * mult - (off * mult + (freq - off) * mult_new)
> 
> This is the difference between the old update and the new update (where
> the new multiplier is only applied for the rest of the tick), simplified
> this becomes:
> 
> 	error -= (freq - off) * mult_adj

This part I'll need to study a bit more as it is not so clear why the
error must be corrected, instead of letting it be corrected in the next
tick. I know it is required, as the error does not get dampened without
it, but the why is less clear. I suspect it has to do with the fact that
xtime was adjusted, and since we accumulate error as we accumulate
xtime, we have to compensate there as well. 


> Finally setting time and changing clock can be done with the same
> mechanism:
> 
> 	xtime = timeofday - off * mult
> 
> timeofday is simply the new time or the current time of the old clock,
> this means that a clock change can be done outside the periodic hook.

This piques my interest, as I still do not quite see how the clocksource
change can occur outside the periodic hook. I'm open to changing this as
the clocksource changing code along with the per-interval accumulation
does make the periodic_hook code a bit long. Breaking it up sounds like
a nice idea, however I'm not following this part.


> This is basically the core part of my prototype to implement a continous
> timeofday, the rest is just an implementation detail (e.g. how mult_adj
> becomes a shift). It's maybe not trivial, but I don't think it's that hard
> to understand (at least using an example) and results in very simple code.

I do agree it is much computationally simpler. However more state must
be maintained and the bit about subtracting from xtime to correct for
the multiplier adjustment is not trivial to understand at first glance.

Now, after I sat down and proved that bit to myself, it is quite
efficient code and I do like the idea of using it. I just want to
maintain the readability while getting the efficiency.


> Maybe the main question I have about your code now is why you want to
> calculate nsec intervals during the update, but as you can see above, it's
> not really necessary, so what do you want to use it for?

Calculate nsec intervals during the update? I'm not sure specifically
which bit you're talking about. Since you didn't really comment
specifically on the code I posted, it makes it hard for me to respond.
Could you point to a line number or a specific variable name?


> Another problem is timeofday_periodic_hook(), while I can understand that
> you want to make it independent of the timer tick, some kind of timer tick
> is still needed at which ntp time and clock time is synchronized. You go
> to great lengths to hide it, but it's needed nevertheless, which makes
> your code harder to read and more complex than needed.

I'm not sure I understand what you're getting at here. The only actual
tick based code is in ntp_advance() where we calculate the singleshot
adjtime adjustment, which is just done to preserve the NTP behavior.
This isn't something I'm hiding. Instead it has the benefit of allowing
the timekeeping code to not need to run every interrupt, which is needed
to handle lost or irregular ticks.


> It would be a lot simpler to keep the updates at first at HZ frequency.
> Later we can still change the update frequency, but ntp time has to be
> updated in fixed intervals if we want precise time keeping. Note that
> error adjustments can still be done asynchronously as shown above, but
> dynamic interval ntp updates are just too complex and error-prone.

I'd be interested if you could be more specific here. What parts of the
NTP state machine has be updated a real fixed intervals and what parts
do not?  

What I'm trying to do w/ ntp_advance() is inform the NTP state machine
that the last total_sppm value calculated was used for the last X nsecs.
So a value for the next period can be calculated. It may be that the
last total_sppm value was applied for too long, but at least it knows
that after the fact rather then not at all.

Really, I'm not so picky about the NTP adjustments as I am about time
not going backwards. So I'm very open to your ideas regarding the NTP
state machine as long as they don't conflict with correct timekeeping.
Running periodic_hook() at HZ frequency is ok by me. However I think
using 50ms intervals is a good default because ticks will be missed on
users machines and we should have correct behavior in those cases. With
the -rt tree, we may only run once a second! I think much like
INITIAL_JIFFIES, using 50ms intervals forces the issue rather then
ignoring it.


> I could give it a try to remove all that extra complexity to get it into
> something mergable, but that would mean dropping quite some bits and
> I'd prefered if we could agree on something. I simply don't have the time
> right now to work on patches, which are rejected again in the end.

I'm not asking you to drop your work, I just want to understand your
objections and try to integrate your ideas. Please also realize that my
time is not infinite as well, so the sooner I can understand your ideas
and we can agree and get this into mainline, the better. :)

thanks
-john


