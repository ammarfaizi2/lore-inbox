Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDLFnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDLFnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWDLFnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:43:25 -0400
Received: from dial169-217.awalnet.net ([213.184.169.217]:20229 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1750808AbWDLFnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:43:24 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 08:41:43 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604112003.24517.a1426z@gawab.com> <200604120856.15983.kernel@kolivas.org>
In-Reply-To: <200604120856.15983.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604120841.43459.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wednesday 12 April 2006 03:03, Al Boldi wrote:
> > With plugsched-2.6.16 your staircase sched reaches about 40 then slows
> > down, maxing around 100.  Setting sched_compute=1 causes console
> > lock-ups.
>
> Which is fine because sched_compute isn't designed for heavily
> multithreaded usage.

What's it good for?

> > With staircase14.2-test3 it reaches around 300 then slows down, halting
> > at around 500.
>
> Oh that's good because staircase14.2_test3 is basically staircase15 which
> is in the current plugsched (ie newer than the staircase you tested in
> plugsched-2.6.16 above). So it tolerates a load of up to 500 on single
> cpu? That seems very robust to me.

Yes, better than the default 2.6 scheduler.

> > Your scheduler seems to be tuned for single-user multi-tasking, i.e.
> > concurrent tasks around 10, where its aggressive nature is sustained by
> > a short run-queue.  Once you go above 50, this aggressiveness starts to
> > express itself as very jumpy.
>
> Oh no it's nothing like "tuned for single-user multi tasking". It seems a
> common misconception because interactivity is a prime concern for
> staircase but the idea is that we should be able to do interactivity
> without sacrificing fairness.

Agreed.

> The same mechanism that is responsible for
> maintaining fairness is also responsible for creating its interactivity.
> That's what I mean by "interactive by design", and what makes it different
> from extracting interactivity out of other designs that have some form of
> estimator to add unfairness to create that interactivity.

Yes, but staircase isn't really fair, and it's definitely not smooth.  You 
are trying to get ia by aggressively attacking priority which kills 
smoothness, and is only fair with a short run-queue.

> > This is of course very cpu/mem/ctxt dependent and it would be great, if
> > your scheduler could maybe do some simple on-the-fly benchmarking as it
> > reschedules, thus adjusting this aggressiveness depending on its
> > sustainability.
>
> I know you're _very_ keen on the idea of some autotuning but I think this
> is the wrong thing to autotune. The whole point of staircase is it's a
> simple design without any interactivity estimator. It uses pure cpu
> accounting to change priority and that is a percentage which is
> effectively already tuned to the underlying cpu. Any
> benchmarking/aggressiveness "tuning" would undo the (effectively) very
> simple design.

I like simple designs.  They tend to keep things to the point and aid 
efficiency.  But staircase doesn't look efficient to me under heavy load, 
and I would think this may be easily improved.

> Feel free to look at the code. Sleep for time Y, increase priority by
> Y/RR_INTERVAL. Run for time X, drop priority by X/RR_INTERVAL. If it drops
> to lowest priority it then jumps back up to best priority again (to
> prevent it being "batch starved").

Looks simple enough, and should work for short run'q's, but this looks 
unsustainable for long run'q's, due to the unconditional jump from lowest to 
best prio.  Making it conditional and maybe moderating X,Y,RR_INTERVAL could 
be helpful.

Also, can you export  lowest/best prio as well as timeslice and friends to 
procfs/sysfs?

> Thanks very much for testing :)

Thank you!

--
Al

