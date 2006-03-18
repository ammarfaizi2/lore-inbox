Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752308AbWCRIIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbWCRIIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbWCRIIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:08:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752301AbWCRIIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:08:46 -0500
Date: Sat, 18 Mar 2006 00:05:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-Id: <20060318000549.4bb35800.akpm@osdl.org>
In-Reply-To: <1142658480.8262.38.camel@homer>
References: <1142658480.8262.38.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> The patch below fixes a starvation problem that occurs when a stream of
>  highly interactive tasks delay an array switch for extended periods
>  despite EXPIRED_STARVING(rq) being true.  AFAIKT, the only choice is to
>  enqueue awakening tasks on the expired array in this case.
> 
>  Without this patch, it can be nearly impossible to remotely login to a
>  busy server, and interactive shell commands can starve for minutes.
> 
>  This has not been verified by anyone.  Comments?

What does that question mean, btw?


-mm is looking like linux-2.6.38 at present so of course things got tangled
up - sched-activate-sched-batch-expired.patch modifies __activate_task().

I ended up with the below.  

Which do we think is more likely to be true - batch_task(p) or
expired_starving(rq)?  batch_task() looks cheaper to evaluate so I put that
first.  But I guess it's less likely to be true.  hmm.


diff -puN kernel/sched.c~sched-fix-interactive-task-starvation kernel/sched.c
--- devel/kernel/sched.c~sched-fix-interactive-task-starvation	2006-03-17 23:55:12.000000000 -0800
+++ devel-akpm/kernel/sched.c	2006-03-17 23:59:03.000000000 -0800
@@ -733,14 +733,56 @@ static inline void dec_nr_running(task_t
 }
 
 /*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks. We also ignore the interactivity
+ * if a better static_prio task has expired, and switch periodically
+ * regardless, to ensure that highly interactive tasks do not starve
+ * the less fortunate for unreasonably long periods.
+ */
+static inline int expired_starving(runqueue_t *rq)
+{
+	int limit;
+
+	/*
+	 * Arrays were recently switched, all is well
+	 */
+	if (!rq->expired_timestamp)
+		return 0;
+
+	limit = STARVATION_LIMIT * rq->nr_running;
+
+	/*
+	 * It's time to switch arrays
+	 */
+	if (jiffies - rq->expired_timestamp >= limit)
+		return 1;
+
+	/*
+	 * There's a better selection in the expired array
+	 */
+	if (rq->curr->static_prio > rq->best_expired_prio)
+		return 1;
+
+	/*
+	 * All is well
+	 */
+	return 0;
+}
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static void __activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *target = rq->active;
 
-	if (batch_task(p))
-		target = rq->expired;
+	if (unlikely(batch_task(p) || expired_starving(rq)))
+		target = rq->expired;
 	enqueue_task(p, target);
 	inc_nr_running(p, rq);
 }
@@ -2614,22 +2656,6 @@ unsigned long long current_sched_time(co
 }
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks. We also ignore the interactivity
- * if a better static_prio task has expired:
- */
-#define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
-
-/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2764,7 +2790,7 @@ void scheduler_tick(void)
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;
_

