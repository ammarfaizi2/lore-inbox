Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSAFB6I>; Sat, 5 Jan 2002 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSAFB56>; Sat, 5 Jan 2002 20:57:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2964 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286871AbSAFB5x>;
	Sat, 5 Jan 2002 20:57:53 -0500
Date: Sun, 6 Jan 2002 04:55:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201051740220.1607-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201060441540.4730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Davide Libenzi wrote:

> Can you send me a link, there're different things to be fixed IMHO.

my latest stuff is at:

   http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B1.patch

> The load estimator can easily use the current dyn_prio/time_slice by
> simplyfing things a _lot_

i have experimented with a very high number of variants. I estimated sleep
times, i estimated run times, i estimated runqueue times. Note that the
current estimator measures time spent on the *runqueue*, not time spent on
the CPU. This means that in an overload spike we have an automatically
increasing penalization of tasks that want to run. While i'm not too
emotional about eg. the RT bits, this part of the scheduler is pretty
critical to handle high load smoothly.

the integration effect of the estimator was written to be fast, and it's
fast. Also note that in most of the time we do not even call the
estimator:

        if (p->run_timestamp == jiffies)
                goto enqueue;

ie. in high frequency wakeup situations we'll call into the estimator only
once every jiffy.

> I would suggest a lower number of queues, 32 is way more than necessary.

the reason i used more queues is the 'penalizing' effect of the per-task
load-average estimator. We want to have some priority room these CPU-bound
tasks can escape into, without hurting some of the interactive jobs that
might get a few penalties here and there but still dont reach the maximum
where all the CPU hogs live. (this is p->prio == 63 right now.)

also, i wanted to map all the 39 nice values straight into the priority
space, just to be sure. Some people *might* rely on finegrained priorities
still.

there is one additional thing i wanted to do to reduce the effect of the
64 queues: instead of using a straight doubly-linked list a'la list_t, we
can do a head-pointer that cuts the queue size into half, and reduces
cache footprint of the scheduler data structures as well. But i did not
want to add this until all bugs are fixed, this is an invariant
cache-footprint optimization.

> The rt code _must_ be better, it can be easily done by a smartest
> wakeup. There's no need to acquire the whole lock set, at least w/out
> a checkpoint solution ( look at BMQS ) that prevents multiple failing
> lookups inside the RT queue.

regarding SCHED_OTHER, i have intentionally avoided smart wakeups, pushed
the balancing logic more into the load balancer.

load spikes and big statistical fluctuations of runqueue lengths we should
not care much about - they are spikes we cannot flatten anyway, they can
be gone before the task has finished flushing over its data set to the
other CPU.

regarding RT tasks, i did not want to add something that i know is broken,
even if rt_lock() is arguably heavyweight. I've seen the 'IPI in flight
misses the real picture' situation a number of times and if we want to do
RT scheduling seriously and accurately on SMP then we should give a
perfect solution to it. Would you like me to explain the 'IPI in flight'
problem in detail, or do you agree that it's a problem?

	Ingo

