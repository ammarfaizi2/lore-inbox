Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWCRFGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWCRFGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCRFGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:06:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:48837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751300AbWCRFGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:06:19 -0500
X-Authenticated: #14349625
Subject: [2.6.16-rc6 patch] fix interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 06:08:00 +0100
Message-Id: <1142658480.8262.38.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The patch below fixes a starvation problem that occurs when a stream of
highly interactive tasks delay an array switch for extended periods
despite EXPIRED_STARVING(rq) being true.  AFAIKT, the only choice is to
enqueue awakening tasks on the expired array in this case.

Without this patch, it can be nearly impossible to remotely login to a
busy server, and interactive shell commands can starve for minutes.

This has not been verified by anyone.  Comments?

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-rc6/kernel/sched.c.org	2006-03-17 14:48:35.000000000 +0100
+++ linux-2.6.16-rc6/kernel/sched.c	2006-03-17 17:41:25.000000000 +0100
@@ -662,11 +662,30 @@
 }
 
 /*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks. We also ignore the interactivity
+ * if a better static_prio task has expired:
+ */
+#define EXPIRED_STARVING(rq) \
+	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+		(jiffies - (rq)->expired_timestamp >= \
+			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
+			((rq)->curr->static_prio > (rq)->best_expired_prio))
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	prio_array_t *array = rq->active;
+	if (unlikely(EXPIRED_STARVING(rq)))
+		array = rq->expired;
+	enqueue_task(p, array);
 	rq->nr_running++;
 }
 
@@ -2461,22 +2480,6 @@
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


