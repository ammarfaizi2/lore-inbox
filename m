Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWIZWKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIZWKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWIZWKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:10:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:1241 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932440AbWIZWKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:10:13 -0400
Date: Tue, 26 Sep 2006 15:10:10 -0700
From: malahal@us.ibm.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] event based work queues
Message-ID: <20060926221010.GA14112@us.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a driver that handles events by queuing them to a work queue.
As the events should be executed in the order they were generated, it
creates a single threaded work queue. The driver has a work structure
per each type of "event".  So it actually can't queue an event if the
same type of event is already in the queue. Let me be more specific. The
event types are "link up", "link down" etc.  We have a work structure
for "link up" event and another work structure for "link down" event. If
we were to receive "link up", "link down" followed by "link up" events
in a quick succession, we end up processing "link up" and then "link
down" in that order. We really would like to process "link down" and
then "link up" rather. There does NOT seem to be a way to re-order work
structures once queued! I could implement a remove_work() interface, but
chose to implement an "event" based work queue and the same queue_work()
interface will move the work structure as needed by the driver. The
existing interface will remain unchanged for non-event based work
queues. I could combine __requeue_work and __queue_work if needed. Your
comments are very welcome! Here is a patch:


diff -r ffb8b5eb8309 include/linux/workqueue.h
--- a/include/linux/workqueue.h	Tue Sep 26 11:51:26 2006 -0700
+++ b/include/linux/workqueue.h	Tue Sep 26 12:59:19 2006 -0700
@@ -55,9 +55,11 @@ struct execute_work {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						   int singlethread,
+						   int requeueable);
+#define create_workqueue(name) __create_workqueue((name), 0, 0)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
+#define create_event_workqueue(name) __create_workqueue((name), 1, 1)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
diff -r ffb8b5eb8309 kernel/workqueue.c
--- a/kernel/workqueue.c	Tue Sep 26 11:51:26 2006 -0700
+++ b/kernel/workqueue.c	Tue Sep 26 13:26:00 2006 -0700
@@ -64,6 +64,7 @@ struct workqueue_struct {
 	struct cpu_workqueue_struct *cpu_wq;
 	const char *name;
 	struct list_head list; 	/* Empty if single thread */
+	int requeueable;	/* must be single threaded if set */
 };
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
@@ -77,6 +78,11 @@ static inline int is_single_threaded(str
 static inline int is_single_threaded(struct workqueue_struct *wq)
 {
 	return list_empty(&wq->list);
+}
+
+static inline int is_requeueable(struct workqueue_struct *wq)
+{
+	return wq->requeueable;
 }
 
 /* Preempt must be disabled. */
@@ -93,6 +99,21 @@ static void __queue_work(struct cpu_work
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
+/* Preempt must be disabled. */
+static void __requeue_work(struct cpu_workqueue_struct *cwq,
+			   struct work_struct *work, int pending)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	work->wq_data = cwq;
+	list_move_tail(&work->entry, &cwq->worklist);
+	if (!pending)
+		cwq->insert_sequence++;
+	wake_up(&cwq->more_work);
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
 /**
  * queue_work - queue work on a workqueue
  * @wq: workqueue to use
@@ -105,14 +126,21 @@ static void __queue_work(struct cpu_work
  */
 int fastcall queue_work(struct workqueue_struct *wq, struct work_struct *work)
 {
-	int ret = 0, cpu = get_cpu();
-
-	if (!test_and_set_bit(0, &work->pending)) {
-		if (unlikely(is_single_threaded(wq)))
-			cpu = singlethread_cpu;
-		BUG_ON(!list_empty(&work->entry));
-		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+	int ret = 0, cpu = get_cpu(), pending;
+
+	if (unlikely(is_requeueable(wq))) {
+		cpu = singlethread_cpu;
+		pending = test_and_set_bit(0, &work->pending);
+		__requeue_work(per_cpu_ptr(wq->cpu_wq, cpu), work, pending);
 		ret = 1;
+	} else {
+		if (!test_and_set_bit(0, &work->pending)) {
+			if (unlikely(is_single_threaded(wq)))
+				cpu = singlethread_cpu;
+			BUG_ON(!list_empty(&work->entry));
+			__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+			ret = 1;
+		}
 	}
 	put_cpu();
 	return ret;
@@ -354,7 +382,8 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    int requeueable)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -371,6 +400,8 @@ struct workqueue_struct *__create_workqu
 	}
 
 	wq->name = name;
+	wq->requeueable = requeueable;
+	BUG_ON(requeueable && !singlethread);
 	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
