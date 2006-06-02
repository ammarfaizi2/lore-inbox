Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWFBIue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFBIue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWFBIud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:50:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:55464 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751334AbWFBIud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:50:33 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45896412:sNHT1127523663"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 01:50:27 -0700
Message-ID: <000401c68621$99ca42d0$0b4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaF+GieWKnv9uneRk+Hdw+4ab8WGAAKE7OQ
In-Reply-To: <200606021355.23671.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Thursday, June 01, 2006 8:55 PM
> On Friday 02 June 2006 12:28, Con Kolivas wrote:
> > Actually looking even further, we only introduced the extra lookup of the
> > next task when we started unlocking the runqueue in schedule(). Since we
> > can get by without locking this_rq in schedule with this approach we can
> > simplify dependent_sleeper even further by doing the dependent sleeper
> > check after we have discovered what next is in schedule and avoid looking
> > it up twice. I'll hack something up to do that soon.
> 
> Something like this (sorry I couldn't help but keep hacking on it).
> ---
> It is not critical to functioning that dependent_sleeper() succeeds every
> time. We can significantly reduce the locking overhead and contention of
> dependent_sleeper by only doing trylock on the smt sibling runqueues. As
> we're only doing trylock it means we do not need to observe the normal
> locking order and we can get away without unlocking this_rq in schedule().
> This provides us with an opportunity to simplify the code further.


Why does dependent_sleeper() has to be so bully that it actively kick off
the poor little guy on the smt sibling? Can't it just wait for the less
fortunate process to finish off its time slice and then it can have more
physical resource to spare?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-06-02 02:37:37.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 02:41:20.000000000 -0700
@@ -2789,7 +2789,7 @@ static int dependent_sleeper(int this_cp
 
 		/* Kernel threads do not participate in dependent sleeping */
 		if (!p->mm || !smt_curr->mm || rt_task(p))
-			goto check_smt_task;
+			continue;
 
 		/*
 		 * If a user task with lower static priority than the
@@ -2812,32 +2812,6 @@ static int dependent_sleeper(int this_cp
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
 				smt_slice(smt_curr, sd) > task_timeslice(p))
 					ret = 1;
-
-check_smt_task:
-		if ((!smt_curr->mm && smt_curr != smt_rq->idle) ||
-			rt_task(smt_curr))
-				continue;
-		if (!p->mm) {
-			wakeup_busy_runqueue(smt_rq);
-			continue;
-		}
-
-		/*
-		 * Reschedule a lower priority task on the SMT sibling for
-		 * it to be put to sleep, or wake it up if it has been put to
-		 * sleep for priority reasons to see if it should run now.
-		 */
-		if (rt_task(p)) {
-			if ((jiffies % DEF_TIMESLICE) >
-				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
-					resched_task(smt_curr);
-		} else {
-			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(p, sd) > task_timeslice(smt_curr))
-					resched_task(smt_curr);
-			else
-				wakeup_busy_runqueue(smt_rq);
-		}
 	}
 
 	for_each_cpu_mask(i, sibling_map)
