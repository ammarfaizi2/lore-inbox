Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVCKA11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVCKA11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVCKA01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:26:27 -0500
Received: from fmr23.intel.com ([143.183.121.15]:42172 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S263042AbVCKAYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:24:23 -0500
Message-Id: <200503110024.j2B0OFg06087@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>
Subject: re-inline sched functions
Date: Thu, 10 Mar 2005 16:24:15 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUl0KgE406BeKHRRZO7dUlro5BbAQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could be part of the unknown 2% performance regression with
db transaction processing benchmark.

The four functions in the following patch use to be inline.  They
are un-inlined since 2.6.7.

We measured that by re-inline them back on 2.6.9, it improves performance
for db transaction processing benchmark, +0.2% (on real hardware :-)

The cost is certainly larger kernel size, cost 928 bytes on x86, and
2728 bytes on ia64.  But certainly worth the money for enterprise
customer since they improve performance on enterprise workload.

# size vmlinux.*
   text    data     bss     dec     hex filename
3261844  717184  262020 4241048  40b698 vmlinux.x86.orig
3262772  717488  262020 4242280  40bb68 vmlinux.x86.inline


   text    data     bss     dec     hex filename
5836933  903828  201940 6942701  69efed vmlinux.ia64.orig
5839661  903460  201940 6945061  69f925 vmlinux.ia64.inline

Possible we can introduce them back?

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.11/kernel/sched.c.orig	2005-03-10 15:31:10.000000000 -0800
+++ linux-2.6.11/kernel/sched.c	2005-03-10 15:36:32.000000000 -0800
@@ -164,7 +164,7 @@
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)

-static unsigned int task_timeslice(task_t *p)
+static inline unsigned int task_timeslice(task_t *p)
 {
 	if (p->static_prio < NICE_TO_PRIO(0))
 		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
@@ -302,7 +302,7 @@ static DEFINE_PER_CPU(struct runqueue, r
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
  */
-static runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
+static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 	__acquires(rq->lock)
 {
 	struct runqueue *rq;
@@ -426,7 +426,7 @@ struct file_operations proc_schedstat_op
 /*
  * rq_lock - lock a given runqueue and disable interrupts.
  */
-static runqueue_t *this_rq_lock(void)
+static inline runqueue_t *this_rq_lock(void)
 	__acquires(rq->lock)
 {
 	runqueue_t *rq;
@@ -1323,7 +1323,7 @@ void fastcall sched_exit(task_t * p)
  * with the lock held can cause deadlocks; see schedule() for
  * details.)
  */
-static void finish_task_switch(task_t *prev)
+static inline void finish_task_switch(task_t *prev)
 	__releases(rq->lock)
 {
 	runqueue_t *rq = this_rq();



