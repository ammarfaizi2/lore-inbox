Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266927AbUAXMU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266931AbUAXMTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:19:16 -0500
Received: from dp.samba.org ([66.70.73.150]:22691 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266930AbUAXMSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:18:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] Minor workqueue.c cleanup
Date: Sat, 24 Jan 2004 23:12:59 +1100
Message-Id: <20040124121909.8C9DB2C135@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

	This is a minor change to workqueue.c, extracted from the
hotplug CPU patch.

Fairly straightforward, and makes the code smaller and simpler.

Move duplicated code to __queue_work(), and don't set the CPU for
queue_delayed_work() until the timer goes off.  The second one
only has an effect on CONFIG_HOTPLUG_CPU where the CPU goes down
and the timer goes off on a different CPU than it was scheduled on.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: workqueue.c Refactor: __queue_work and timer CPU assumption
Author: Rusty Russell
Status: Experimental

D: Move duplicated code to __queue_work(), and don't set the CPU for
D: queue_delayed_work() until the timer goes off.  The second one
D: only has an effect on CONFIG_HOTPLUG_CPU where the CPU goes down
D: and the timer goes off on a different CPU than it was scheduled on.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22816-linux-2.6.2-rc1-bk1/kernel/workqueue.c .22816-linux-2.6.2-rc1-bk1.updated/kernel/workqueue.c
--- .22816-linux-2.6.2-rc1-bk1/kernel/workqueue.c	2004-01-21 16:19:08.000000000 +1100
+++ .22816-linux-2.6.2-rc1-bk1.updated/kernel/workqueue.c	2004-01-24 19:19:54.000000000 +1100
@@ -57,6 +57,20 @@ struct workqueue_struct {
 	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
 };
 
+/* Preempt must be disabled. */
+static void __queue_work(struct cpu_workqueue_struct *cwq,
+			 struct work_struct *work)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	work->wq_data = cwq;
+	list_add_tail(&work->entry, &cwq->worklist);
+	cwq->insert_sequence++;
+	wake_up(&cwq->more_work);
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
 /*
  * Queue work on a workqueue. Return non-zero if it was successfully
  * added.
@@ -66,19 +80,11 @@ struct workqueue_struct {
  */
 int queue_work(struct workqueue_struct *wq, struct work_struct *work)
 {
-	unsigned long flags;
 	int ret = 0, cpu = get_cpu();
-	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(!list_empty(&work->entry));
-		work->wq_data = cwq;
-
-		spin_lock_irqsave(&cwq->lock, flags);
-		list_add_tail(&work->entry, &cwq->worklist);
-		cwq->insert_sequence++;
-		wake_up(&cwq->more_work);
-		spin_unlock_irqrestore(&cwq->lock, flags);
+		__queue_work(wq->cpu_wq + cpu, work);
 		ret = 1;
 	}
 	put_cpu();
@@ -88,39 +94,29 @@ int queue_work(struct workqueue_struct *
 static void delayed_work_timer_fn(unsigned long __data)
 {
 	struct work_struct *work = (struct work_struct *)__data;
-	struct cpu_workqueue_struct *cwq = work->wq_data;
-	unsigned long flags;
+	struct workqueue_struct *wq = work->wq_data;
 
-	/*
-	 * Do the wakeup within the spinlock, so that flushing
-	 * can be done in a guaranteed way.
-	 */
-	spin_lock_irqsave(&cwq->lock, flags);
-	list_add_tail(&work->entry, &cwq->worklist);
-	cwq->insert_sequence++;
-	wake_up(&cwq->more_work);
-	spin_unlock_irqrestore(&cwq->lock, flags);
+	__queue_work(wq->cpu_wq + smp_processor_id(), work);
 }
 
 int queue_delayed_work(struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)
 {
-	int ret = 0, cpu = get_cpu();
+	int ret = 0;
 	struct timer_list *timer = &work->timer;
-	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
-		work->wq_data = cwq;
+		/* This stores wq for the moment, for the timer_fn */
+		work->wq_data = wq;
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
 		add_timer(timer);
 		ret = 1;
 	}
-	put_cpu();
 	return ret;
 }
 
