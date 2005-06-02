Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFBC7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFBC7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVFBC7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:59:51 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:16319 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261263AbVFBC7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:59:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: steve.rotolo@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 13:01:49 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com, mingo@elte.hu
References: <1117561608.1439.168.camel@whiz> <200506020737.20098.kernel@kolivas.org> <1117663292.22879.99.camel@bonefish>
In-Reply-To: <1117663292.22879.99.camel@bonefish>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dannCrDAEu8Bryb"
Message-Id: <200506021301.49836.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dannCrDAEu8Bryb
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 2 Jun 2005 08:01 am, Steve Rotolo wrote:
> On Wed, 2005-06-01 at 17:37, Con Kolivas wrote:
> > I'll work on something.
>
> Great!  I'd be happy to test a patch for you.  Thanks!!!

Ok this patch is only compile tested I'm sorry to say (without a real HT 
testing environment at the moment) but it uses jiffies and DEF_TIMESLICE to 
allow SCHED_NORMAL tasks to run per_cpu_gain % of DEF_TIMESLICE at a time. 
Thus it is not tied to timeslices at all for real time tasks which is 
appropriate. Can you try it please? It should apply to any recent kernel.

Cheers,
Con

P.S. cc'ed Ingo

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--Boundary-00=_dannCrDAEu8Bryb
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="sched-run_normal_with_rt_on_sibling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sched-run_normal_with_rt_on_sibling.diff"

Index: linux-2.6.12-rc5-mm2/kernel/sched.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/kernel/sched.c	2005-06-02 10:13:26.000000000 +1000
+++ linux-2.6.12-rc5-mm2/kernel/sched.c	2005-06-02 12:54:39.000000000 +1000
@@ -2656,6 +2656,13 @@ out:
 }
 
 #ifdef CONFIG_SCHED_SMT
+static inline void wakeup_busy_runqueue(runqueue_t *rq)
+{
+	/* If an SMT runqueue is sleeping due to priority reasons wake it up */
+	if (rq->curr == rq->idle && rq->nr_running)
+		resched_task(rq->idle);
+}
+
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
@@ -2689,12 +2696,7 @@ static inline void wake_sleeping_depende
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
 
-		/*
-		 * If an SMT sibling task is sleeping due to priority
-		 * reasons wake it up now.
-		 */
-		if (smt_rq->curr == smt_rq->idle && smt_rq->nr_running)
-			resched_task(smt_rq->idle);
+		wakeup_busy_runqueue(smt_rq);
 	}
 
 	for_each_cpu_mask(i, sibling_map)
@@ -2748,6 +2750,10 @@ static inline int dependent_sleeper(int 
 		runqueue_t *smt_rq = cpu_rq(i);
 		task_t *smt_curr = smt_rq->curr;
 
+		/* Kernel threads do not participate in dependent sleeping */ 
+		if (!p->mm || !smt_curr->mm || rt_task(p))
+			goto check_smt_task;
+
 		/*
 		 * If a user task with lower static priority than the
 		 * running task on the SMT sibling is trying to schedule,
@@ -2756,21 +2762,44 @@ static inline int dependent_sleeper(int 
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(p) || rt_task(smt_curr)) &&
-			p->mm && smt_curr->mm && !rt_task(p))
-				ret = 1;
+		if (rt_task(smt_curr)) {
+			/*
+			 * With real time tasks we run non-rt tasks only 
+			 * per_cpu_gain% of the time.
+			 */
+			if ((jiffies % DEF_TIMESLICE) >
+				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
+					ret = 1;
+		} else
+			if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
+				100) > task_timeslice(p)))
+					ret = 1;
+
+check_smt_task:
+		if ((!smt_curr->mm && smt_curr != smt_rq->idle) ||
+			rt_task(smt_curr))
+				continue;
+		if (!p->mm) {
+			wakeup_busy_runqueue(smt_rq);
+			continue;
+		}
 
 		/*
 		 * Reschedule a lower priority task on the SMT sibling,
 		 * or wake it up if it has been put to sleep for priority
-		 * reasons.
+		 * reasons to see if it should run now.
 		 */
-		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(smt_curr) || rt_task(p)) &&
-			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
-			(smt_curr == smt_rq->idle && smt_rq->nr_running))
-				resched_task(smt_curr);
+		if (rt_task(p)) {
+			if ((jiffies % DEF_TIMESLICE) >
+				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
+					resched_task(smt_curr);
+		} else {
+			if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
+				task_timeslice(smt_curr))
+					resched_task(smt_curr);
+			else
+				wakeup_busy_runqueue(smt_rq);
+		}
 	}
 out_unlock:
 	for_each_cpu_mask(i, sibling_map)

--Boundary-00=_dannCrDAEu8Bryb--
