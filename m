Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVLFWV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVLFWV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLFWV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:21:56 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10457
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030284AbVLFWVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:21:54 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0512061628050.1610@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 06 Dec 2005 23:28:02 +0100
Message-Id: <1133908082.16302.93.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tue, 2005-12-06 at 18:32 +0100, Roman Zippel wrote:

> > We worked through the subsystem and its users and further reduced the 
> > implementation to the basic required infrastructure and generally 
> > streamlined it. (We did this with easy extensibility for the high 
> > resolution clock support still in mind, so we kept some small extras 
> > around.)
> 
> It looks better, but could you please explain, what these extras are 
> good for?

One extra we kept is the list and the state field, which are useful for
the high resolution implementation. We wanted to keep as much as
possible common code [shared between the current low-resolution clock
based hrtimer code and future high-resolution clock based hrtimercode]
to avoid the big #ifdeffery all over the place.

It might turn out in the rework of the hrt bits that the list can go
away, but this is a nobrainer to do. (The very first unpublished version
of ktimers had no list, it got introduced during the hrt addon and
stayed there to make the hrt patch less intrusive.)

> > After reading the Posix specification again, we came to the conclusion 
> > that it is possible to do no rounding at all for the ktime_t values, and 
> > to still ensure that the timer is not delivered early.
> 
> Nice, that you finally also come to that conclusion, after I said that 
> already for ages. (It's also interesting how you do that without 
> giving me any credit for it.)

Sorry if it was previously your idea and if we didnt credit you for it.
I did not keep track of each word said in these endless mail threads. We
credited every suggestion and idea which we picked up from you, see our
previous emails. If we missed one, it was definitely not intentional.

The decision to change the rounding implementation was not made based on
reading old mail threads. It was made by doing tests and analysis and it
differs a lot from your implementation.

Setting up a periodic timer leads to a summing-up error versus the
expected timeline. This applies both to vanilla, ktimers and ptimers.
The difference is how this error is showing up:

The vanilla 2.6.15-rc5 kernel has an rather constant error which is in
the range of roughly 1ms per interval mostly independent of the given
interval and the system load. This is roughly 1 sec per 1000 intervals.

Ktimers had a contant summing error which is exactly the delta of the
rounded interval to the real interval. The error is number of intervals
* delta. The error could be deduced by the application, but thats not a
really good idea. For a 50ms interval it is 2sec / 1000 intervals, which
is exactly the 2ms delta between the 50ms requested and the 52ms real
interval on a system with HZ=250

Ptimers have a rounding error which depends on the delta to the jiffy
resolution and the system load. So it gets rather unpredicitble what
happens. The basic error is roughly the same as with ktimers, but the
addon component due to system load is not. For a 50ms interval a summing
error between 2sec and 7sec per 1000 intervals was measured.

So while vanilla and ktimers have a systematic error, ptimer introduces
random Brownean motion!

We analysed the problem again and went through the spec and came to the
conclusion that rounding can be completely omitted. We changed the code
accordingly and did the same tests. The result is systematic deviation
of the timeline which wanders between 0 and resolution - 1 [i.e. 0-4msec
with HZ=250], but does not introduce a summing error. This behaviour
will be the same when high resolution bits are put on top. Of course the
error then will be significantly smaller.

To sum up the effects of various implementations (and
non-implementations in our hrtimers case) of rounding, a 50 msec
interval timer accumulates the following timeline error (precision
error) over 1000 periods (50 seconds):

 vanilla:        1000 msecs
 ktimers:        2000 msecs
 ptimers:   2000-7000 msecs
 hrtimers:          4 msecs

In the interim low-res ktimers version we were concentrating on the
'multiples of exposed resolution case. E.g. with 40 msec intervals
(which is 10x 4msec jiffy) you'd only get 0-4msecs longterm error:

 vanilla:        1000 msecs
 ktimers:           4 msecs
 ptimers:      8-2000 msecs
 hrtimers:          4 msecs

> Nevertheless, if you read my explanation of the rounding carefully and 
> look at my implementation, you may notice that I still disagree with 
> the actual implementation.

I started to read it, but your explanation seems to be completely
detached from the testing results and the code.

I can imagine that you dont agree, but you might also elaborate why. I
definitely disagree with your implementation for the following reasons:

You define that absolute interval timers on clock realtime change their
behaviour when the initial time value is expired into relative timers
which are not affected by time settings. I have no idea how you came to
that interpretation of the spec. I completely disagree [but if you would
like I can go into more detail why I think it's wrong.]

Beside of that, the implementation is also completely broken. (You
rebase the timer from the realtime base to the monotonic base inside of
the timer callback function. On return you lock the realtime base and
enqueue the timer into the realtime queue, but the base field of the
timer points to the monotonic queue. It needs not much phantasy to get
this exploited into a crash.)

Furthermore, your implementation is calculating the next expiry value
based on the current time of the expiration rather than on the previous
expected expiry time, which would be the natural thing to do. This
detail also explains the system-load dependent random drifting of
ptimers quite well.

The changes you did to the timer locking code (also in timer.c) are racy
and simply exposable. Oleg's locking implementation is there for a good
reason.

Neither do I understand the jiffie boundness you re-introduced all over
the place. The softirq code is called once per jiffy and the expiry is
checked versus the current time. Basing a new design on jiffies, where
the design intends to be easily extensible to high resolution clocks, is
wrong IMNSHO. Doing a high resolution extension on top of it is just
introducing a lot of #ifdef mess in places where none has to be. We had
that before, and dont want to go back there.

One of your main, often repeated arguments was the complexity of
ktimers. While ktimers held a lot of complex functionality, the "simple"
ptimers .text size is larger than the ktimers one! I know that you claim
that .text size is not a criteria, but Andrew seriously asked what he
gets for the increase of .text.

> BTW there is one thing I'm currently curious about. Why did you rename 
> the timer from high-precision timer to high-resolution timer? hrtimer 
> was just a suggestion from Andrew and ptimer would have been fine as 
> well.

We decided to rename 'ktimer' because Andrew pretty much vetoed the
'ktimeout' queue, and "timer_list" plus "ktimer" looked and sounded
confusing (as we've explained it before). Of the possible target names,
we decided against "ptimer" because it could be confused with "process
timers" and "posix timers". hrtimers is a clear term that indicates what
those timers do, so we picked up Andrew's suggestion as a way out the
endless naming discussion. Does this satisfy your curiosity?

   tglx


