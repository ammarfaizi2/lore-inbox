Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWDUEXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWDUEXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWDUEXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:23:00 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:28535 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932191AbWDUEXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:23:00 -0400
Message-ID: <44485E21.6070801@bigpond.net.au>
Date: Fri, 21 Apr 2006 14:22:57 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [PATCH] sched: Avoid unnecessarily moving highest priority task move_tasks()
Content-Type: multipart/mixed;
 boundary="------------030300090200050400000101"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 21 Apr 2006 04:22:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030300090200050400000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

To help distribute high priority tasks evenly across the available CPUs 
move_tasks() does not, under some circumstances, skip tasks whose load 
weight is bigger than the designated amount.  Because the highest 
priority task on the busiest queue may be on the expired array it may be 
moved as a result of this mechanism.  Apart from not being the most 
desirable way to redistribute the high priority tasks (we'd rather move 
the second highest priority task), there is a risk that this could set 
up a loop with this task bouncing backwards and forwards between the two 
queues.  (This latter possibility can be demonstrated by running a 
nice==-20 CPU bound task on an otherwise quiet 2 CPU system.)

Solution:

Modify the mechanism so that it does not override skip for the highest 
priority task on the CPU.  Of course, if there are more than one tasks 
at the highest priority then it will allow the override for one of them 
as this is a desirable redistribution of high priority tasks.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------030300090200050400000101
Content-Type: text/plain;
 name="smpnice-avoid-moving-highest"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-avoid-moving-highest"

Index: MM-2.6.17-rc1-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-21 12:19:30.000000000 +1000
+++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-21 12:26:54.000000000 +1000
@@ -2029,6 +2029,7 @@ int can_migrate_task(task_t *p, runqueue
 	return 1;
 }
 
+#define rq_best_prio(rq) min((rq)->curr->prio, (rq)->best_expired_prio)
 /*
  * move_tasks tries to move up to max_nr_move tasks and max_load_move weighted
  * load from busiest to this_rq, as part of a balancing operation within
@@ -2043,7 +2044,9 @@ static int move_tasks(runqueue_t *this_r
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0, pinned = 0, this_min_prio;
+	int idx, pulled = 0, pinned = 0, this_best_prio, busiest_best_prio;
+	int busiest_best_prio_seen;
+	int skip_for_load; /* skip the task based on weighted load issues */
 	long rem_load_move;
 	task_t *tmp;
 
@@ -2052,7 +2055,13 @@ static int move_tasks(runqueue_t *this_r
 
 	rem_load_move = max_load_move;
 	pinned = 1;
-	this_min_prio = this_rq->curr->prio;
+	this_best_prio = rq_best_prio(this_rq);
+	busiest_best_prio = rq_best_prio(busiest);
+	/*
+	 * Enable handling of the case where there is more than one task
+	 * with the best priority.
+	 */
+	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -2097,7 +2106,10 @@ skip_queue:
 	 * skip a task if it will be the highest priority task (i.e. smallest
 	 * prio value) on its new queue regardless of its load weight
 	 */
-	if ((idx >= this_min_prio && tmp->load_weight > rem_load_move) ||
+	skip_for_load = tmp->load_weight > rem_load_move;
+	if (skip_for_load && idx < this_best_prio)
+		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
+	if (skip_for_load ||
 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
@@ -2119,8 +2131,10 @@ skip_queue:
 	 * and the prescribed amount of weighted load.
 	 */
 	if (pulled < max_nr_move && rem_load_move > 0) {
-		if (idx < this_min_prio)
-			this_min_prio = idx;
+		if (idx < this_best_prio)
+			this_best_prio = idx;
+		if (idx == busiest_best_prio)
+			busiest_best_prio_seen = 1;
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------030300090200050400000101--
