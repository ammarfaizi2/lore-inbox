Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVBXHR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVBXHR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVBXHRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:17:52 -0500
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:5022 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261890AbVBXHRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:17:04 -0500
Subject: [PATCH 2/13] improve pinned task handling
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229362.5177.67.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-4LSmu1e8oSG/24DwdtY7"
Date: Thu, 24 Feb 2005 18:16:55 +1100
Message-Id: <1109229415.5177.68.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4LSmu1e8oSG/24DwdtY7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

2/13


--=-4LSmu1e8oSG/24DwdtY7
Content-Disposition: attachment; filename=sched-lb-pinned.patch
Content-Type: text/x-patch; name=sched-lb-pinned.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

John Hawkes explained the problem best:
	A large number of processes that are pinned to a single CPU results
	in every other CPU's load_balance() seeing this overloaded CPU as
	"busiest", yet move_tasks() never finds a task to pull-migrate.  This
	condition occurs during module unload, but can also occur as a
	denial-of-service using sys_sched_setaffinity().  Several hundred
	CPUs performing this fruitless load_balance() will livelock on the
	busiest CPU's runqueue lock.  A smaller number of CPUs will livelock
	if the pinned task count gets high.
	
Expanding slightly on John's patch, this one attempts to work out
whether the balancing failure has been due to too many tasks pinned
on the runqueue. This allows it to be basically invisible to the
regular blancing paths (ie. when there are no pinned tasks). We can
use this extra knowledge to shut down the balancing faster, and ensure
the migration threads don't start running which is another problem
observed in the wild.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:27.042781371 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:39.180401105 +1100
@@ -1650,7 +1650,7 @@
  */
 static inline
 int can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
-		     struct sched_domain *sd, enum idle_type idle)
+		     struct sched_domain *sd, enum idle_type idle, int *pinned)
 {
 	/*
 	 * We do not migrate tasks that are:
@@ -1660,8 +1660,10 @@
 	 */
 	if (task_running(rq, p))
 		return 0;
-	if (!cpu_isset(this_cpu, p->cpus_allowed))
+	if (!cpu_isset(this_cpu, p->cpus_allowed)) {
+		*pinned++;
 		return 0;
+	}
 
 	/*
 	 * Aggressive migration if:
@@ -1687,11 +1689,11 @@
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
 		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle)
+		      enum idle_type idle, int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0;
+	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
@@ -1735,7 +1737,7 @@
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle)) {
+	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1761,6 +1763,9 @@
 		goto skip_bitmap;
 	}
 out:
+	*all_pinned = 0;
+	if (unlikely(pinned >= max_nr_move) && pulled == 0)
+		*all_pinned = 1;
 	return pulled;
 }
 
@@ -1935,7 +1940,7 @@
 	struct sched_group *group;
 	runqueue_t *busiest;
 	unsigned long imbalance;
-	int nr_moved;
+	int nr_moved, all_pinned;
 
 	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -1974,9 +1979,14 @@
 		 */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-						imbalance, sd, idle);
+						imbalance, sd, idle,
+						&all_pinned);
 		spin_unlock(&busiest->lock);
 	}
+	/* All tasks on this runqueue were pinned by CPU affinity */
+	if (unlikely(all_pinned))
+		goto out_balanced;
+
 	spin_unlock(&this_rq->lock);
 
 	if (!nr_moved) {
@@ -2041,7 +2051,7 @@
 	struct sched_group *group;
 	runqueue_t *busiest = NULL;
 	unsigned long imbalance;
-	int nr_moved = 0;
+	int nr_moved = 0, all_pinned;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
@@ -2061,7 +2071,7 @@
 
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					imbalance, sd, NEWLY_IDLE);
+			imbalance, sd, NEWLY_IDLE, &all_pinned);
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 
@@ -2119,6 +2129,7 @@
 		cpu_group = sd->groups;
 		do {
 			for_each_cpu_mask(cpu, cpu_group->cpumask) {
+				int all_pinned;
 				if (busiest_rq->nr_running <= 1)
 					/* no more tasks left to move */
 					return;
@@ -2139,7 +2150,7 @@
 				/* move a task from busiest_rq to target_rq */
 				double_lock_balance(busiest_rq, target_rq);
 				if (move_tasks(target_rq, cpu, busiest_rq,
-						1, sd, SCHED_IDLE)) {
+					1, sd, SCHED_IDLE, &all_pinned)) {
 					schedstat_inc(busiest_rq, alb_lost);
 					schedstat_inc(target_rq, alb_gained);
 				} else {

--=-4LSmu1e8oSG/24DwdtY7--


