Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRASPsV>; Fri, 19 Jan 2001 10:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRASPsL>; Fri, 19 Jan 2001 10:48:11 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:44489 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132700AbRASPsD>;
	Fri, 19 Jan 2001 10:48:03 -0500
Importance: Normal
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: "Pratap Pattnaik" <pratap@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF3A9EC7B6.EEDB9FBC-ON852569D9.0052DC7C@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 19 Jan 2001 10:47:06 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/19/2001 10:47:59 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Indeed, Andi,  we tried that  priority==tablebased scheduler approach. If
you check the call for participation again, what
we are trying to do is to get to the bottom of what actually impacts
scheduler performance and subsequently
come up with a combined best bread (i.e. satisfies the highend and low
end). Since this is still work in progress, here
are a few numbers that I got from running the 2.4.0-test12 kernels for
vanilla and priority based complementing Mike's numbers.
I add this as an extra columns to Mikes table. Our Machine is 8-way 700 MHZ
Pentium 2MB caches, though I don't think
for the sched_yield test it makes a difference. I ran with 50 seconds
runtime per test to get by the FRC problem.

                           microseconds/yield
#threads 2.2.16-22      2.4        2.4-MQ          2.4.0-test12
2.4.0-test12-Prio
------   ---------    --------     ----------      ------------
-----------------
16         18.740      4.603        1.455           4.51          4.39
32         17.702      5.134        1.456           5.01          4.06
64         23.300      5.586        1.466           5.70          3.99
128        47.273     18.812        1.480          12.06 %        3.99
256        105.701    71.147        1.517          60.2           4.05
512        FRC       143.500        1.661         132.5           4.19
1024       FRC       196.425        6.166         295.4 #         4.57
2048       FRC         FRC         23.291         460.4           5.34
4096       FRC         FRC         47.117         631.3           5.91

*FRC = failed to reach confidence level

Some comments to some numbers:
#) Mike measure 196, I measured 295 ?? Somebody has a typo here I assume.
%) This actually varied between 8 and 14 on multiple runs averaging 12.
Bill Hartner suggests that these might be cache issues (OT).

What you can see from these numbers is that MQ does an awesome job up to
1024 threads. When measuring in the future, we will take from now on the
general concern about low number of threads into account. Your points are
well taken. I m pretty confident our MQ scheduler will be in reasonable
ballpark of the current scheduler. To go on, the priority==tablebased
scheduler does better for very high number of processes. It actually beats
the vanilla version throughout (>= 16). It stays stable, because we stop
immediately when we found a process that run last on the invoking cpu. Only
way we could do better is to continue searching for a affinity boost due to
<mm>. Here the discussions might start. The next version of the tablebased
scheduler will take into account whether the table index only covers one
goodness range or multiple (e.g. RT). This could give some better
performance for the general case.

The roadmap ahead for Mike and I and the rest of the crew is to combine
these methods. In our first attempt we first wanted to demonstrate that the
MQ does a great job while emulating current scheduler semantics. Now if we
relax these semantics just a bit, e.g. we would be tolerating a bit more
priority inversion (which any scheduler does that deploys affinity boosts),
we probably can do even better.

These are the things we are currently doing and soon should have some
results now:

(1) We are preparing for LWE with a full  measurement of the latest kernel.
For this purpose we have frozen to 2.4.1-pre8.
Unless ofcourse you are telling us this is not a good kernel to run on.
(2) We will measure 1-4096 threads for vanilla, priority and MQ for two
tests (both provided by Bill Hartner in Austin).
     (a) sched_yield          although not a meaningful benchmark, it
really exposes the raw overhead of scheduling
                    the problem here it artificially generates lock
contention at a rate we would not see in
                    general applications.
     (b) chatroom        similar to VolanoBenchmark, but easier to use and
measure. This gives a better idea what
                    the impact would be for real applications

On the progress side. Now that we already have a good idea what the MQ and
the table==priority based scheduler can do, we
want to combine them and see how that impacts performance. Next we still
have the open issues whether keeping queues in priority order makes sense
or not. That exercise should be done for both MQ and table based scheduler.

Next, we have started looking into breaking up the CPU set. Right now we
scan all CPUs to find an appropriate CPU to preempt.
For large number of CPUs that can cost particular with very few number
(1-4) of threads.
We are currently experimenting with breaking up the CPUs into smaller sets
and just schedule with in their set, i.e. we don't look beyond the set to
balance (e.g. priorities etc). Occasionally (1HZ) we run a load balancing
mechanism to redistribute work.
We have a simple prototype running demonstrating the idea.This could be
also useful for NUMA systems as well. We will post this patch over the MQ
soon on the site.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Andi Kleen <ak@suse.de>@lists.sourceforge.net on 01/18/2001 07:51:01 PM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   Andrea Arcangeli <andrea@suse.de>
cc:   Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
      linux-kernel@vger.kernel.org
Subject:  Re: [Lse-tech] Re: multi-queue scheduler update



On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> I remeber the O(1) scheduler from Davide Libenzi was beating the mainline
O(N)
> scheduler with over 7 tasks in the runqueue (actually I'm not sure if the
> number was 7 but certainly it was under 10). So if you also use a O(1)
> scheduler too as I guess (since you have a chance to run fast on the lots
of
> tasks running case) the most interesting thing is how you score with
2/4/8
> tasks in the runqueue (I think the tests on the O(1) scheduler patch was
done
> at max on a 2-way SMP btw). (the argument for which Davide's patch wasn't
> included is that most machines have less than 4/5 tasks in the runqueue
at the
> same time)

They seem to have tried that in a separate patch:
http://lse.sourceforge.net/scheduling/PrioScheduler.html

Very nice literate programming style btw @-)


-Andi

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
