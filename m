Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJVTYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJVTYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUJVTWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:22:43 -0400
Received: from oss.sgi.com ([192.48.159.27]:44741 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id S264113AbUJVTUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:20:31 -0400
Date: Fri, 22 Oct 2004 12:20:40 -0700
From: John Hawkes <hawkes@oss.sgi.com>
Message-Id: <200410221920.i9MJKeHm024118@oss.sgi.com>
To: nickpiggin@yahoo.com.au
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
Cc: akpm@osdl.org, jbarnes@sgi.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, your patch doesn't work on my 128p to solve the problem.
This variation, however, does work.  It's a patch against 2.6.9.
The difference is in move_tasks().






 linux-2.6-npiggin/kernel/sched.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-10-22 09:11:12.000000000 -0700
+++ linux/kernel/sched.c	2004-10-22 11:45:10.000000000 -0700
@@ -1770,7 +1770,7 @@
  */
 static inline
 int can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
-		     struct sched_domain *sd, enum idle_type idle)
+		     struct sched_domain *sd, enum idle_type idle, int *pinned)
 {
 	/*
 	 * We do not migrate tasks that are:
@@ -1780,8 +1780,10 @@
 	 */
 	if (task_running(rq, p))
 		return 0;
-	if (!cpu_isset(this_cpu, p->cpus_allowed))
+	if (!cpu_isset(this_cpu, p->cpus_allowed)) {
+		*pinned++;
 		return 0;
+	}
 
 	/* Aggressive migration if we've failed balancing */
 	if (idle == NEWLY_IDLE ||
@@ -1802,11 +1804,11 @@
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
 		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle)
+		      enum idle_type idle, int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0;
+	int idx, examined = 0, pulled = 0, pinned = 0;
 	task_t *tmp;
 
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
@@ -1850,7 +1852,8 @@
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle)) {
+	examined++;
+	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1876,6 +1879,8 @@
 		goto skip_bitmap;
 	}
 out:
+	if (unlikely(examined && examined == pinned))
+		*all_pinned = 1;
 	return pulled;
 }
 
@@ -2056,7 +2061,7 @@
 	struct sched_group *group;
 	runqueue_t *busiest;
 	unsigned long imbalance;
-	int nr_moved;
+	int nr_moved, all_pinned;
 
 	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -2095,11 +2100,16 @@
 		 */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-						imbalance, sd, idle);
+						imbalance, sd, idle,
+						&all_pinned);
 		spin_unlock(&busiest->lock);
 	}
-	spin_unlock(&this_rq->lock);
+	/* All tasks on this runqueue were pinned by CPU affinity */
+	if (unlikely(all_pinned))
+		goto out_balanced;
 
+	spin_unlock(&this_rq->lock);
+	
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[idle]);
 		sd->nr_balance_failed++;
@@ -2154,7 +2164,7 @@
 	struct sched_group *group;
 	runqueue_t *busiest = NULL;
 	unsigned long imbalance;
-	int nr_moved = 0;
+	int nr_moved = 0, all_pinned;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
@@ -2174,7 +2184,7 @@
 
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					imbalance, sd, NEWLY_IDLE);
+			imbalance, sd, NEWLY_IDLE, &all_pinned);
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 
@@ -2236,6 +2246,7 @@
 		cpumask_t tmp;
 		runqueue_t *rq;
 		int push_cpu = 0;
+		int all_pinned;
 
 		if (group == busy_group)
 			goto next_group;
@@ -2261,7 +2272,8 @@
 		if (unlikely(busiest == rq))
 			goto next_group;
 		double_lock_balance(busiest, rq);
-		if (move_tasks(rq, push_cpu, busiest, 1, sd, IDLE)) {
+		if (move_tasks(rq, push_cpu, busiest, 1,
+				sd, IDLE, &all_pinned)) {
 			schedstat_inc(busiest, alb_lost);
 			schedstat_inc(rq, alb_gained);
 		} else {
