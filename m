Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268238AbTCFRWI>; Thu, 6 Mar 2003 12:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268239AbTCFRWI>; Thu, 6 Mar 2003 12:22:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56582 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268238AbTCFRWF>; Thu, 6 Mar 2003 12:22:05 -0500
Date: Thu, 6 Mar 2003 09:30:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060857380.4511-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303060912370.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> interesting approach,

Ahh.. After five emails on the subject, you finally took a look at the 
patch? Good.

>		 but it has one problem which so far i tried to
> avoid: it makes it too easy for a process to gain a bonus.

Yes and no. It actually follows your rules:

>							 Until now
> pretty much the only way to get an interactive bonus was to actually
> sleep.

And that is still true. _Somebody_ has to sleep, and the bonus is still 
entirely based on how long that somebody slept.


>  Another rule was that interactivity is kept constant, ie. the only
> 'source' of interactivity was passing time, not some artificial activity
> performed by any process.

And this is also still true. Again, the only _source_ of interactivity is 
the fact that the woken-up process slept for a noticeable time. There is 
no "artificial source" there.

Do the math: the patch uses the exact same source as the current algorithm 
does - it only changes the _cutoff_.

The current algorithm just throws away "interactivity bonus" points when 
the sleeper has gotten to some maximum value. 

The new one doesn't throw them away when it hits the maximum - it gives 
them to the person who woke it up.

>		 Even the timeslice passing across fork()/exit()  
> is controlled carefully to maintain the total sum of timeslices.

But my patch DID NOT CHANGE THE TOTAL SUM! Read the patch again. 

See:

+                       int ticks = p->sleep_avg - MAX_SLEEP_AVG + current->sleep_avg;
			p->sleep_avg = MAX_SLEEP_AVG;

Note how this breaks down:

	"p->sleep_avg - MAX_SLEEP_AVG"

this is the part we're "throwing away", because the sleeper had already 
accumulated enough interactivity points.

	" + current->sleep_avg"

this is the part that the waker _already_had_.

	if (ticks > MAX_SLEEP_AVG)
		ticks = MAX_SLEEP_AVG;

This just says that the waker, too, will be limited by the "maximum 
interactivity" thing.

	if (!in_interrupt())
		current->sleep_avg = ticks;

and this part says "we only give the potential boost to a _synchronous_ 
waker" (ie a network packet that comes in and wakes somebody up in 
bottom half processing will _not_ cause an interactivity boost to a random 
process).

See? The patch maintains the rule that "interactivity" only gets created 
by sleeping. The only thing it really does is to change how we 
_distribute_ the interactivity we get. It gives some of the interactivity 
to the waker.

> With the above code it's enough to keep a single helper thread around
> which blocks on a pipe, to create an almost endless source of
> interactivity bonus.

No. You do not get to "create" interactivity. All the CPU cycles you win 
from interactivity you must have lost by having one of your processes wait 
for it.

Sure - it changes the balance of who gets to be considered interactive. 
But that's the whole _point_ of it.

>		 And does not even have to be 'deliberate' - there's
> tons of code that just waits for a CPU-bound task to finish (eg. 'make'
> waiting for gcc to finish), and which processes/threads have a maximum
> boost already, in which case the interactivity boost is not justified.

And if they already have the maximum boost, they won't get any more. Look 
at the five lines of actual code added.

Also, note how your "waiting for gcc to finish" is still not true. Sure, 
that "make" will be considered interactive, but it's not going to help the 
waker (gcc) any, since it will be interactive waiting for gcc to _die_.

I can come up with better (ie "real") examples of where this changes
behaviour:

 - "cc1" (slow) writes to a pipe to "as" (fast)

   "as" is fast, so as ends up waiting most of the time. Thus it ends up 
   being marked interactive.

   When cc1 wakes up as, assuming as has been marked "maximally 
   interactive", cc1 will get an interactivity boost too.

Is this "wrong"?  Maybe, if you see it from a pure "interactivity"  
standpoint. But another way of seeing it is to say that it automatically
tries to _balance_ this kind of pipeline - since "cc1" is much slower and
actually _wants_ the interactivity that "as" is clearly not ever going to
actually get any real advantage from, it is actually likely to be
perfectly fine give "cc1" a priority.

Also, note that if cc1 is _really_ slow (which it is) and really doesn't 
wake up as very often, you won't see this effect, since the 
"anti-interactive" code will balance things out.

In short, it's all about balancing. There are things that are
"pro-interactive" (real sleeping), and there are things that are
"anti-interactive" (using up your timeslice). The question is how you 
spread out the bonus points (or the negative points).

The current scheduler doesn't spread them out at all. I think that's a
bug, since pipelines of multiple processes are actually perfectly common,
and X is only one example of this.

And my patch may spread it out _too_ much. Maybe we shouldn't give _all_ 
of the left-over interactivity to the waker. Maybe we should give just 
half of it away..

See?

		Linus

