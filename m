Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWEZEUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWEZEUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWEZEUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:20:34 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:28051 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030338AbWEZEUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:20:33 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Fri, 26 May 2006 14:20:31 +1000
Message-Id: <20060526042031.2886.82052.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Subject: [RFC 1/5] sched: Fix priority inheritence before CPU rate soft caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

The advent of priority inheritance (PI) (in -mm kernels) means that the
prio field for non real time tasks can no longer be guaranteed to be
greater than or equal to MAX_RT_PRIO.  This, in turn, means that the
rt_task() macro is no longer a reliable test for determining if the
scheduler policy of a task is one of the real time policies.

Redefining rt_task() is not a good solution as the majority places
where it is used within sched.c the current definition is what is
required. However, this is not the case in the functions
set_load_weight() and set_user_nice() (and perhaps elsewhere in the
kernel).

Solution:

Define a new macro, has_rt_policy(), that returns true if the task given
as an argument has a policy of SCHED_RR or SCHED_FIFO and use this
inside set_load_weight() and set_user_nice().  The definition is made in
sched.h so that it is generally available should it be needed elsewhere
in the kernel.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
 include/linux/sched.h |    2 ++
 kernel/sched.c        |   15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

Index: MM-2.6.17-rc4-mm3/include/linux/sched.h
===================================================================
--- MM-2.6.17-rc4-mm3.orig/include/linux/sched.h	2006-05-26 10:39:59.000000000 +1000
+++ MM-2.6.17-rc4-mm3/include/linux/sched.h	2006-05-26 10:43:21.000000000 +1000
@@ -491,6 +491,8 @@ struct signal_struct {
 #define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
 #define rt_task(p)		rt_prio((p)->prio)
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
+#define has_rt_policy(p) \
+	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: MM-2.6.17-rc4-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc4-mm3.orig/kernel/sched.c	2006-05-26 10:39:59.000000000 +1000
+++ MM-2.6.17-rc4-mm3/kernel/sched.c	2006-05-26 10:44:51.000000000 +1000
@@ -786,7 +786,7 @@ static inline int expired_starving(runqu
 
 static void set_load_weight(task_t *p)
 {
-	if (rt_task(p)) {
+	if (has_rt_policy(p)) {
 #ifdef CONFIG_SMP
 		if (p == task_rq(p)->migration_thread)
 			/*
@@ -835,7 +835,7 @@ static inline int normal_prio(task_t *p)
 {
 	int prio;
 
-	if (p->policy != SCHED_NORMAL && p->policy != SCHED_BATCH)
+	if (has_rt_policy(p))
 		prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		prio = __normal_prio(p);
@@ -3831,7 +3831,7 @@ void set_user_nice(task_t *p, long nice)
 	unsigned long flags;
 	prio_array_t *array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int old_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -3846,7 +3846,7 @@ void set_user_nice(task_t *p, long nice)
 	 * it wont have any effect on scheduling until the task is
 	 * not SCHED_NORMAL/SCHED_BATCH:
 	 */
-	if (rt_task(p)) {
+	if (has_rt_policy(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
@@ -3856,12 +3856,11 @@ void set_user_nice(task_t *p, long nice)
 		dec_raw_weighted_load(rq, p);
 	}
 
-	old_prio = p->prio;
-	new_prio = NICE_TO_PRIO(nice);
-	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
 	set_load_weight(p);
-	p->prio += delta;
+	old_prio = p->prio;
+	p->prio = effective_prio(p);
+	delta = p->prio - old_prio;
 
 	if (array) {
 		enqueue_task(p, array);

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
