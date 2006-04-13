Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWDMG5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWDMG5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWDMG5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:57:18 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:2931 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964804AbWDMG5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:57:17 -0400
Message-ID: <443DF64B.5060305@bigpond.net.au>
Date: Thu, 13 Apr 2006 16:57:15 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: modify move_tasks() to improve load balancing outcomes
Content-Type: multipart/mixed;
 boundary="------------040009050303090203090900"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 13 Apr 2006 06:57:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009050303090203090900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

The move_tasks() function is designed to move UP TO the amount of load 
it is asked to move and in doing this it skips over tasks looking for 
ones whose load weights are less than or equal to the remaining load to 
be moved.  This is (in general) a good thing but it has the unfortunate 
result of breaking one of the original load balancer's good points: 
namely, that (within the limits imposed by the active/expired array 
model and the fact the expired is processed first) it moves high 
priority tasks before low priority ones and this means there's a good 
chance (see active/expired problem for why it's only a chance) that the 
highest priority task on the queue but not actually on the CPU will be 
moved to the other CPU where (as a high priority task) it may preempt 
the current task.

Solution:

Modify move_tasks() so that high priority tasks are not skipped when 
moving them will make them the highest priority task on their new run queue.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040009050303090203090900
Content-Type: text/plain;
 name="smpnice-modify-move_tasks"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-modify-move_tasks"

Index: MM-2.6.17-rc1-mm2/kernel/sched.c
===================================================================
--- MM-2.6.17-rc1-mm2.orig/kernel/sched.c	2006-04-13 10:53:32.000000000 +1000
+++ MM-2.6.17-rc1-mm2/kernel/sched.c	2006-04-13 11:08:45.000000000 +1000
@@ -2043,7 +2043,7 @@ static int move_tasks(runqueue_t *this_r
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0, pinned = 0;
+	int idx, pulled = 0, pinned = 0, this_min_prio;
 	long rem_load_move;
 	task_t *tmp;
 
@@ -2052,6 +2052,7 @@ static int move_tasks(runqueue_t *this_r
 
 	rem_load_move = max_load_move;
 	pinned = 1;
+	this_min_prio = this_rq->curr->prio;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -2091,7 +2092,12 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (tmp->load_weight > rem_load_move ||
+	/*
+	 * To help distribute high priority tasks accross CPUs we don't
+	 * skip a task if it will be the highest priority task (i.e. smallest
+	 * prio value) on its new queue regardless of its load weight
+	 */
+	if ((idx >= this_min_prio && tmp->load_weight > rem_load_move) ||
 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
@@ -2113,6 +2119,8 @@ skip_queue:
 	 * and the prescribed amount of weighted load.
 	 */
 	if (pulled < max_nr_move && rem_load_move > 0) {
+		if (idx < this_min_prio)
+			this_min_prio = idx;
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------040009050303090203090900--
