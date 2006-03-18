Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752293AbWCRH2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbWCRH2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 02:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbWCRH2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 02:28:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:932 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752278AbWCRH2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 02:28:03 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060317222203.06d7f450.akpm@osdl.org>
References: <1142658480.8262.38.camel@homer>
	 <20060317211529.26969a16.akpm@osdl.org> <1142661030.8937.7.camel@homer>
	 <20060317222203.06d7f450.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 08:29:45 +0100
Message-Id: <1142666985.7881.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 22:22 -0800, Andrew Morton wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> >
> > > Does this have to be a macro?
> > > 
> > 
> > I suppose not, now inlined.
> > 
> 
> It would be nice to uninline the function and then to modify it in a
> followup patch.  That way, we get to see what changed, which is one of the
> reasons to not use megamacros (sorry).

Ok, take 3 below, with updated main comment as well.


> The function returns a boolean, so we should short-circuit the evaluation
> where possible.

Done.

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-rc6/kernel/sched.c.org	2006-03-17 14:48:35.000000000 +0100
+++ linux-2.6.16-rc6/kernel/sched.c	2006-03-18 08:03:34.000000000 +0100
@@ -662,11 +662,56 @@
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
+static int expired_starving(runqueue_t *rq)
+{
+	int limit;
+
+	/*
+	 * Arrays were recently switched, all is well.
+	 */
+	if (!rq->expired_timestamp)
+		return 0;
+
+	limit = STARVATION_LIMIT * rq->nr_running;
+
+	/*
+	 * It's time to switch arrays.
+	 */
+	if (jiffies - rq->expired_timestamp >= limit)
+		return 1;
+
+	/*
+	 * There's a better selection in the expired array.
+	 */
+	if (rq->curr->static_prio > rq->best_expired_prio)
+		return 1;
+
+	/*
+	 * All is well.
+	 */
+	return 0;
+}
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	prio_array_t *array = rq->active;
+	if (unlikely(expired_starving(rq)))
+		array = rq->expired;
+	enqueue_task(p, array);
 	rq->nr_running++;
 }
 
@@ -2461,22 +2506,6 @@
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
@@ -2611,7 +2640,7 @@
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;


