Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268220AbTCFRj4>; Thu, 6 Mar 2003 12:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTCFRj4>; Thu, 6 Mar 2003 12:39:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41910 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268220AbTCFRjx>;
	Thu, 6 Mar 2003 12:39:53 -0500
Date: Thu, 6 Mar 2003 18:50:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060912370.7206-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061841480.15041-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> this is the part we're "throwing away", because the sleeper had already
> accumulated enough interactivity points.
> 
> 	" + current->sleep_avg"
> 
> this is the part that the waker _already_had_.
> 
> 	if (ticks > MAX_SLEEP_AVG)
> 		ticks = MAX_SLEEP_AVG;
> 
> This just says that the waker, too, will be limited by the "maximum 
> interactivity" thing.

ok. I misread this part. It's actually a 'super boost' for interactive
tasks and tasks related to them.

> 	if (!in_interrupt())
> 		current->sleep_avg = ticks;

this (making a difference in characteristics based on in_interrupt()) was
something i tried before, but got killed due to generic wackyness :-)  
Also, it's not really justified to isolate a process just because it got
woken up by a hw event.

> and this part says "we only give the potential boost to a _synchronous_
> waker" (ie a network packet that comes in and wakes somebody up in
> bottom half processing will _not_ cause an interactivity boost to a
> random process).

how about a keyboard interrupt?

> See? The patch maintains the rule that "interactivity" only gets created
> by sleeping. The only thing it really does is to change how we
> _distribute_ the interactivity we get. It gives some of the
> interactivity to the waker.

yes - i misunderstood this property of it - and this removed most of my
objections.

> Also, note how your "waiting for gcc to finish" is still not true. Sure,
> that "make" will be considered interactive, but it's not going to help
> the waker (gcc) any, since it will be interactive waiting for gcc to
> _die_.

there's also another phenomenon in the 'make -j5 hell': gas getting
boosted due to it waiting on the gcc pipeline. Now gcc will be 'back
boosted'. But we might be lucky and get away with it - testing will show.

>  - "cc1" (slow) writes to a pipe to "as" (fast)
> 
>    "as" is fast, so as ends up waiting most of the time. Thus it ends up 
>    being marked interactive.
> 
>    When cc1 wakes up as, assuming as has been marked "maximally 
>    interactive", cc1 will get an interactivity boost too.
> 
> Is this "wrong"?  Maybe, if you see it from a pure "interactivity"  
> standpoint. But another way of seeing it is to say that it automatically
> tries to _balance_ this kind of pipeline - since "cc1" is much slower
> and actually _wants_ the interactivity that "as" is clearly not ever
> going to actually get any real advantage from, it is actually likely to
> be perfectly fine give "cc1" a priority.

okay.

> In short, it's all about balancing. There are things that are
> "pro-interactive" (real sleeping), and there are things that are
> "anti-interactive" (using up your timeslice). The question is how you
> spread out the bonus points (or the negative points).

yes.

> The current scheduler doesn't spread them out at all. I think that's a
> bug, since pipelines of multiple processes are actually perfectly
> common, and X is only one example of this.

i have tried multiple schemes before to spread out interactivity, none
worked so far - but i have not tried any 'back-boosting' towards a CPU-hog
before, so it's an interesting experiment. If you look at the
child-timeslice thing that is a common vector for interactivity to spread.

> And my patch may spread it out _too_ much. Maybe we shouldn't give _all_
> of the left-over interactivity to the waker. Maybe we should give just
> half of it away..

yes, not spreading out could also make it possible to give it back via
multiple wakeup links, interactivity will 'diffuse' along wakeups.

	Ingo

