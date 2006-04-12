Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWDLGVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWDLGVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWDLGVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:21:06 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:62853 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750977AbWDLGVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:21:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 16:22:01 +1000
User-Agent: KMail/1.8.3
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604120856.15983.kernel@kolivas.org> <200604120841.43459.a1426z@gawab.com>
In-Reply-To: <200604120841.43459.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604121622.02341.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 03:41 pm, Al Boldi wrote:
> Con Kolivas wrote:
> > Which is fine because sched_compute isn't designed for heavily
> > multithreaded usage.
>
> What's it good for?

Single heavily cpu bound computationally intensive tasks (think rendering 
etc).

> > Oh that's good because staircase14.2_test3 is basically staircase15 which
> > is in the current plugsched (ie newer than the staircase you tested in
> > plugsched-2.6.16 above). So it tolerates a load of up to 500 on single
> > cpu? That seems very robust to me.
>
> Yes, better than the default 2.6 scheduler.
>
> > > Your scheduler seems to be tuned for single-user multi-tasking, i.e.
> > > concurrent tasks around 10, where its aggressive nature is sustained by
> > > a short run-queue.  Once you go above 50, this aggressiveness starts to
> > > express itself as very jumpy.
> >
> > Oh no it's nothing like "tuned for single-user multi tasking". It seems a
> > common misconception because interactivity is a prime concern for
> > staircase but the idea is that we should be able to do interactivity
> > without sacrificing fairness.
>
> Agreed.
>
> > The same mechanism that is responsible for
> > maintaining fairness is also responsible for creating its interactivity.
> > That's what I mean by "interactive by design", and what makes it
> > different from extracting interactivity out of other designs that have
> > some form of estimator to add unfairness to create that interactivity.
>
> Yes, but staircase isn't really fair, and it's definitely not smooth.  You
> are trying to get ia by aggressively attacking priority which kills
> smoothness, and is only fair with a short run-queue.

Sorry I don't understand what you mean. Why do you say it's not fair (got a 
testcase?). What do you mean by "definitely not smooth". What is smoothness 
and on what workloads is it not smooth? Also by ia you mean what? 

> > I know you're _very_ keen on the idea of some autotuning but I think this
> > is the wrong thing to autotune. The whole point of staircase is it's a
> > simple design without any interactivity estimator. It uses pure cpu
> > accounting to change priority and that is a percentage which is
> > effectively already tuned to the underlying cpu. Any
> > benchmarking/aggressiveness "tuning" would undo the (effectively) very
> > simple design.
>
> I like simple designs.  They tend to keep things to the point and aid
> efficiency.  But staircase doesn't look efficient to me under heavy load,
> and I would think this may be easily improved.

Again I don't understand. Just how heavy a load is heavy? Your testcases are 
already in what I would call stratospheric range. I don't personally think a 
cpu scheduler should be optimised for load infinity. And how are you defining 
efficient? You say it doesn't "look" efficient? What "looks" inefficient 
about it?

> > Feel free to look at the code. Sleep for time Y, increase priority by
> > Y/RR_INTERVAL. Run for time X, drop priority by X/RR_INTERVAL. If it
> > drops to lowest priority it then jumps back up to best priority again (to
> > prevent it being "batch starved").
>
> Looks simple enough, and should work for short run'q's, but this looks
> unsustainable for long run'q's, due to the unconditional jump from lowest
> to best prio.

Looks? How? You've shown what I consider very long runqueues work fine 
already.

> Making it conditional and maybe moderating X,Y,RR_INTERVAL 
> could be helpful.

I think over all meaningful loads, and into absurdly high load ranges it 
works. I don't think undoing the incredible simplicity that works over all 
that range should be done to optimise for loads even greater than that.

> Also, can you export  lowest/best prio as well as timeslice and friends to
> procfs/sysfs?

You want tunables? The only tunable in staircase is rr_interval which (in -ck) 
has an on/off for big/small (sched_compute) since most other numbers in 
between (in my experience) are pretty meaningless. I could export rr_interval 
directly instead... I've not seen a good argument for doing that. Got one? 
However there are no other tunables at all (just look at the code). All tasks 
of any nice level have available the whole priority range from 100-139 which 
appears as PRIO 0-39 on top. Limiting that (again) changes the semantics.

> > Thanks very much for testing :)
>
> Thank you!

And another round of thanks :) But many more questions.

--
-ck
