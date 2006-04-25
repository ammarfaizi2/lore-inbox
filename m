Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWDYDIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDYDIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDYDIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:08:04 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:29048 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932089AbWDYDID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:08:03 -0400
Message-ID: <444D9290.6070706@bigpond.net.au>
Date: Tue, 25 Apr 2006 13:08:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [PATCH] sched: fix evaluation of skip_for_load in move_tasks()
Content-Type: multipart/mixed;
 boundary="------------010301060601030904030609"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Apr 2006 03:08:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301060601030904030609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

In the patch 
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
I got a the sense of a boolean expression wrong when assigning a value 
to skip_for_load.  The expression should have been negated before being 
assigned.

Additionally, busiest_best_prio_seen is being set when tasks are moved 
instead of when they are skipped which will cause problems when the 
current task does not have prio=busiest_best_prio.

Solution:

Negate the expression and apply de Marcos rule to simplify it and move 
the setting of busiest_best_prio_seen.

This patch is on top of 
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------010301060601030904030609
Content-Type: text/plain;
 name="smpnice-fix-busiest_best_prio_seen"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-fix-busiest_best_prio_seen"

Index: MM-2.6.17-rc1-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-25 12:53:39.000000000 +1000
+++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 12:56:14.000000000 +1000
@@ -2059,7 +2059,10 @@ static int move_tasks(runqueue_t *this_r
 	busiest_best_prio = rq_best_prio(busiest);
 	/*
 	 * Enable handling of the case where there is more than one task
-	 * with the best priority.
+	 * with the best priority.   If the current running task is one
+	 * of those with prio==busiest_best_prio we know it won't be moved
+	 * and therefore it's safe to override the skip (based on load) of
+	 * any task we find with that prio.
 	 */
 	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
 
@@ -2108,9 +2111,10 @@ skip_queue:
 	 */
 	skip_for_load = tmp->load_weight > rem_load_move;
 	if (skip_for_load && idx < this_best_prio)
-		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
+		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
 	if (skip_for_load ||
 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+		busiest_best_prio_seen |= idx == busiest_best_prio;
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2133,8 +2137,6 @@ skip_queue:
 	if (pulled < max_nr_move && rem_load_move > 0) {
 		if (idx < this_best_prio)
 			this_best_prio = idx;
-		if (idx == busiest_best_prio)
-			busiest_best_prio_seen = 1;
 		if (curr != head)
 			goto skip_queue;
 		idx++;

--------------010301060601030904030609--
