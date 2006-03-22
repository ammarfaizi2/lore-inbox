Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWCVKnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWCVKnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWCVKnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:43:43 -0500
Received: from ozlabs.org ([203.10.76.45]:20411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750706AbWCVKnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:43:42 -0500
Date: Wed, 22 Mar 2006 21:41:43 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, akpm@osdl.org
Subject: [PATCH] possible scheduler deadlock in 2.6.16
Message-ID: <20060322104143.GC30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have noticed lockups during boot when stress testing kexec on ppc64.
Two cpus would deadlock in scheduler code trying to grab already taken
spinlocks.

The double_rq_lock code uses the address of the runqueue to order the
taking of multiple locks. This address is a per cpu variable:

	if (rq1 < rq2) {
		spin_lock(&rq1->lock);
		spin_lock(&rq2->lock);
	} else {
		spin_lock(&rq2->lock);
		spin_lock(&rq1->lock);
	}

On the other hand, the code in wake_sleeping_dependent uses the cpu id
order to grab locks:

	for_each_cpu_mask(i, sibling_map)
		spin_lock(&cpu_rq(i)->lock);

This means we rely on the address of per cpu data increasing as cpu ids
increase. While this will be true for the generic percpu implementation
it may not be true for arch specific implementations.

One way to solve this is to always take runqueues in cpu id order. To do
this we add a cpu variable to the runqueue and check it in the
double runqueue locking functions.

Thoughts?

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/kernel/sched.c
===================================================================
--- build.orig/kernel/sched.c	2006-03-22 18:46:53.000000000 +1100
+++ build/kernel/sched.c	2006-03-22 20:44:20.000000000 +1100
@@ -237,6 +237,7 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
+	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1660,6 +1661,9 @@ unsigned long nr_iowait(void)
 /*
  * double_rq_lock - safely lock two runqueues
  *
+ * We must take them in cpu order to match code in
+ * dependent_sleeper and wake_dependent_sleeper.
+ *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
  */
@@ -1671,7 +1675,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
+		if (rq1->cpu < rq2->cpu) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1707,7 +1711,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
+		if (busiest->cpu < this_rq->cpu) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -6035,6 +6039,7 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 
