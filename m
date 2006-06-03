Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWFCAIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWFCAIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWFCAIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:08:40 -0400
Received: from mga03.intel.com ([143.182.124.21]:41590 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751589AbWFCAIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:08:39 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45326191:sNHT45199021"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 17:08:39 -0700
Message-ID: <000601c686a1$de148060$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGoRhcB9coO7ciRnW2LOmLMV+ULwAAD1ng
In-Reply-To: <200606031002.51199.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 5:03 PM
> On Saturday 03 June 2006 08:58, Chen, Kenneth W wrote:
> > You haven't answered my question either.  What is the benefit of special
> > casing the initial stage of cpu resource competition?  Is it quantitatively
> > measurable?  If so, how much and with what workload?
> 
> Ah you mean what the whole point of smt nice is? Yes it's simple enough to do. 
> Take the single hyperthreaded cpu with two cpu bound workloads. Let's say I 
> run a cpu bound task nice 0 by itself and it completes in time X. If I boot 
> it with hyperthread disabled and run a nice 0 and nice 19 task, the nice 0 
> task gets 95% of the cpu and completes in time X*0.95. If I boot with 
> hyperthread enabled and run the nice 0 and nice 19 tasks, the nice 0 task 
> gets 100% of one sibling and the nice 19 task 100% of the other sibling. The 
> nice 0 task completes in X*0.6. With the smt nice code added it completed in 
> X*0.95. The ratios here are dependent on the workload but that was the 
> average I could determine from comparing mprime workloads at differing nice 
> and kernel compiles. There is no explicit way on the Intel smt cpus to tell 
> it which sibling is running lower priority tasks (sprinkling mwaits around at 
> regular intervals is not a realistic option for example).


I know what smt nice is doing, and it is fine to have.  I'm simply proposing
the following patch, on top of last roll up patch.


diff -u ./kernel/sched.c ./kernel/sched.c
--- ./kernel/sched.c	2006-06-02 16:05:13.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 17:03:55.000000000 -0700
@@ -2782,7 +2782,7 @@
 
 		/* Kernel threads do not participate in dependent sleeping */
 		if (!p->mm || !smt_curr->mm || rt_task(p))
-			goto check_smt_task;
+			continue;
 
 		/*
 		 * If a user task with lower static priority than the
@@ -2806,32 +2806,6 @@
 				smt_slice(smt_curr, sd) > task_timeslice(p))
 					ret = 1;
 
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
-
 		spin_unlock(&smt_rq->lock);
 	}
 	return ret;
