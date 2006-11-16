Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030736AbWKPIWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbWKPIWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030753AbWKPIWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:22:22 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58764 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030736AbWKPIWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:22:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/2] Support for freezeable workqueues
Date: Thu, 16 Nov 2006 09:15:06 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <200611160912.51226.rjw@sisk.pl>
In-Reply-To: <200611160912.51226.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160915.07135.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to create a workqueue the worker thread of which will be
frozen during suspend, along with other kernel threads.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/workqueue.h |    8 +++++---
 kernel/workqueue.c        |   20 ++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

Index: linux-2.6.19-rc5-mm2/include/linux/workqueue.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/workqueue.h
+++ linux-2.6.19-rc5-mm2/include/linux/workqueue.h
@@ -55,9 +55,11 @@ struct execute_work {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread,
+						    int freezeable);
+#define create_workqueue(name) __create_workqueue((name), 0, 0)
+#define create_freezeable_workqueue(name) __create_workqueue((name), 0, 1)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
Index: linux-2.6.19-rc5-mm2/kernel/workqueue.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/workqueue.c
+++ linux-2.6.19-rc5-mm2/kernel/workqueue.c
@@ -31,6 +31,7 @@
 #include <linux/mempolicy.h>
 #include <linux/kallsyms.h>
 #include <linux/debug_locks.h>
+#include <linux/freezer.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -57,6 +58,8 @@ struct cpu_workqueue_struct {
 	struct task_struct *thread;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
+
+	int freezeable;		/* Freeze the thread during suspend */
 } ____cacheline_aligned;
 
 /*
@@ -251,7 +254,8 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
+	if (!cwq->freezeable)
+		current->flags |= PF_NOFREEZE;
 
 	set_user_nice(current, -5);
 
@@ -274,6 +278,9 @@ static int worker_thread(void *__cwq)
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
+		if (cwq->freezeable)
+			try_to_freeze();
+
 		add_wait_queue(&cwq->more_work, &wait);
 		if (list_empty(&cwq->worklist))
 			schedule();
@@ -350,7 +357,7 @@ void fastcall flush_workqueue(struct wor
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu, int freezeable)
 {
 	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
 	struct task_struct *p;
@@ -360,6 +367,7 @@ static struct task_struct *create_workqu
 	cwq->thread = NULL;
 	cwq->insert_sequence = 0;
 	cwq->remove_sequence = 0;
+	cwq->freezeable = freezeable;
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
@@ -375,7 +383,7 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread, int freezeable)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -395,7 +403,7 @@ struct workqueue_struct *__create_workqu
 	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, singlethread_cpu);
+		p = create_workqueue_thread(wq, singlethread_cpu, freezeable);
 		if (!p)
 			destroy = 1;
 		else
@@ -403,7 +411,7 @@ struct workqueue_struct *__create_workqu
 	} else {
 		list_add(&wq->list, &workqueues);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezeable);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -657,7 +665,7 @@ static int __devinit workqueue_cpu_callb
 		mutex_lock(&workqueue_mutex);
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu)) {
+			if (!create_workqueue_thread(wq, hotcpu, 0)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}

