Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUJVToa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUJVToa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUJVTlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:41:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21204 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267298AbUJVTjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:39:13 -0400
Date: Fri, 22 Oct 2004 12:38:50 -0700 (PDT)
From: John Hawkes <hawkes@google.engr.sgi.com>
Message-Id: <200410221938.MAA52152@google.engr.sgi.com>
To: John Hawkes <hawkes@oss.sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
Cc: Ingo Molnar <mingo@elte.hu>, hawkes@sgi.com, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200410201936.i9KJa4FF026174@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> John and I also discussed a slightly more sophisticated algorithm
> for this that would try to be a bit smarter about the reason for
> balance failures (described in the changelog).
> 
> John, this works quite well here, would you have any objections
> using it instead? Does it cure your problems there?

No, your variation doesn't solve the problem.  This variation of your
patch does, however, solve the problem.  The difference is in
move_tasks():

Signed-off-by: John Hawkes <hawkes@sgi.com>


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
