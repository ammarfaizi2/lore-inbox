Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161656AbWAMDXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161656AbWAMDXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161661AbWAMDTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61058 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161656AbWAMDT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:28 -0500
Message-Id: <20060113032243.154673000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ntl@pobox.com
Subject: [PATCH 07/17] [PATCH] fix workqueue oops during cpu offline
Content-Disposition: inline; filename=fix-workqueue-oops-during-cpu-offline.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Use first_cpu(cpu_possible_map) for the single-thread workqueue case.  We
used to hardcode 0, but that broke on systems where !cpu_possible(0) when
workqueue_struct->cpu_workqueue_struct was changed from a static array to
alloc_percpu.

Commit id bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded cpu=0 in
workqueue for per_cpu_ptr() calls") fixed that for Ben's funky sparc64
system, but it regressed my Power5.  Offlining cpu 0 oopses upon the next
call to queue_work for a single-thread workqueue, because now we try to
manipulate per_cpu_ptr(wq->cpu_wq, 1), which is uninitialized.

So we need to establish an unchanging "slot" for single-thread workqueues
which will have a valid percpu allocation.  Since alloc_percpu keys off of
cpu_possible_map, which must not change after initialization, make this
slot == first_cpu(cpu_possible_map).

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/workqueue.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.15.y/kernel/workqueue.c
===================================================================
--- linux-2.6.15.y.orig/kernel/workqueue.c
+++ linux-2.6.15.y/kernel/workqueue.c
@@ -29,7 +29,8 @@
 #include <linux/kthread.h>
 
 /*
- * The per-CPU workqueue (if single thread, we always use cpu 0's).
+ * The per-CPU workqueue (if single thread, we always use the first
+ * possible cpu).
  *
  * The sequence counters are for flush_scheduled_work().  It wants to wait
  * until until all currently-scheduled works are completed, but it doesn't
@@ -69,6 +70,8 @@ struct workqueue_struct {
 static DEFINE_SPINLOCK(workqueue_lock);
 static LIST_HEAD(workqueues);
 
+static int singlethread_cpu;
+
 /* If it's single threaded, it isn't in the list of workqueues. */
 static inline int is_single_threaded(struct workqueue_struct *wq)
 {
@@ -102,7 +105,7 @@ int fastcall queue_work(struct workqueue
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		if (unlikely(is_single_threaded(wq)))
-			cpu = any_online_cpu(cpu_online_map);
+			cpu = singlethread_cpu;
 		BUG_ON(!list_empty(&work->entry));
 		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 		ret = 1;
@@ -118,7 +121,7 @@ static void delayed_work_timer_fn(unsign
 	int cpu = smp_processor_id();
 
 	if (unlikely(is_single_threaded(wq)))
-		cpu = any_online_cpu(cpu_online_map);
+		cpu = singlethread_cpu;
 
 	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
@@ -267,7 +270,7 @@ void fastcall flush_workqueue(struct wor
 
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
-		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, any_online_cpu(cpu_online_map)));
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
 	} else {
 		int cpu;
 
@@ -320,7 +323,7 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, any_online_cpu(cpu_online_map));
+		p = create_workqueue_thread(wq, singlethread_cpu);
 		if (!p)
 			destroy = 1;
 		else
@@ -374,7 +377,7 @@ void destroy_workqueue(struct workqueue_
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
 	if (is_single_threaded(wq))
-		cleanup_workqueue_thread(wq, any_online_cpu(cpu_online_map));
+		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
 		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);
@@ -543,6 +546,7 @@ static int __devinit workqueue_cpu_callb
 
 void init_workqueues(void)
 {
+	singlethread_cpu = first_cpu(cpu_possible_map);
 	hotcpu_notifier(workqueue_cpu_callback, 0);
 	keventd_wq = create_workqueue("events");
 	BUG_ON(!keventd_wq);

--
