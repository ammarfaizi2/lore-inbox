Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbTLRXFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTLRXFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:05:42 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:8411
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265376AbTLRXFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:05:37 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O21 for interactivity 2.6.0
Date: Fri, 19 Dec 2003 10:05:33 +1100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9Kj4/3O49sWNp4R"
Message-Id: <200312191005.33861.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9Kj4/3O49sWNp4R
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A non-critical corner case has come up for interactivity that I believe needs 
to be addressed. It is only extensive testing and examination that revealed 
this, as this interactivity work is in maintenance mode.

Description:
-----
It is possible for a highly interactive task (like X) to cause large latencies 
in tasks that are less 'niced' (eg negative nice number compared to X which 
should normally run at nice 0) if they are fully cpu bound. This occurs due 
to expiration of the cpu bound tasks.

This patch addresses this by not reinserting interactive tasks into the active 
array if there is a better static priority task running but has been placed 
on the expired array. This causes a substantial reduction in the maximum 
scheduling latency a task with a less nice value can have.

This also has the positive side effect of maintaining better cpu% proportions 
for tasks of different nice levels.
-----

Testers will only be able to discern a difference with highly cpu bound tasks 
of normal scheduling policy at different nice levels. Test cases are doing 
something cpu intensive relatively -niced in the presence of an interactive 
load (eg capturing and encoding video at nice -10 while using X nice 0, or 
something nice 0 vs nice +10) and so on. Because of the crossover of 10 
'nice' levels of dynamic priorities between interactive and cpu bound tasks 
this patch will have a more noticable effect as the nice difference is 
greater, especially 11 or more. 

Con

Patch against 2.6.0 also available for d/l here:
http://ck.kolivas.org/patches/2.6/2.6.0/patch-2.6.0-O21int

--Boundary-00=_9Kj4/3O49sWNp4R
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.0-O21int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.0-O21int"

--- linux-2.6.0-test11-base/kernel/sched.c	2003-11-24 22:18:56.000000000 +1100
+++ linux-2.6.0-test11-O21/kernel/sched.c	2003-12-17 22:36:00.971506178 +1100
@@ -203,7 +203,7 @@ struct runqueue {
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
-	int prev_cpu_load[NR_CPUS];
+	int best_expired_prio, prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
@@ -1340,12 +1341,14 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  * interactivity of a task if the first expired task had to wait more
  * than a 'reasonable' amount of time. This deadline timeout is
  * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks:
+ * increasing number of running tasks. We also ignore the interactivity
+ * if a better static_prio task has expired:
  */
 #define EXPIRED_STARVING(rq) \
-		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
+	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
+				((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1427,6 +1430,8 @@ void scheduler_tick(int user_ticks, int 
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			enqueue_task(p, rq->expired);
+			if (p->static_prio < rq->best_expired_prio)
+				rq->best_expired_prio = p->static_prio;
 		} else
 			enqueue_task(p, rq->active);
 	} else {
@@ -1553,6 +1558,7 @@ pick_next_task:
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
+		rq->best_expired_prio = MAX_PRIO;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -2814,6 +2820,8 @@ void __init sched_init(void)
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+		rq->best_expired_prio = MAX_PRIO;
+
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);

--Boundary-00=_9Kj4/3O49sWNp4R--

