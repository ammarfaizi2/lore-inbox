Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUJRQbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUJRQbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJRQbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:31:18 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34262 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266833AbUJRQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:31:08 -0400
Subject: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 11:31:00 -0500
Message-Id: <1098117067.2011.64.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of moving some of our scsi timers which do more work
than just a few lines of code into schedule_work() instead.  The problem
is that the workqueue API lacks the equivalent of del_timer_sync(). 
This patch adds it as unschedule_delayed_work() (and also adds the
unschedule_work() API---it's probably much less useful, but
unschedule_delayed_work() is best constructed on top of it).

The idea is that unschedule_delayed_work() will return 0 if the work has
already executed and 1 if it hasn't.  It is guaranteed that either the
work was removed or has been executed by the time
unschedule_delayed_work() returns (and thus it needs process context to
wait for the work function if necessary).

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

James

===== include/linux/workqueue.h 1.9 vs edited =====
--- 1.9/include/linux/workqueue.h	2004-08-23 03:14:58 -05:00
+++ edited/include/linux/workqueue.h	2004-10-18 10:01:54 -05:00
@@ -69,6 +69,11 @@
 extern int current_is_keventd(void);
 extern int keventd_up(void);
 
+extern int remove_work(struct workqueue_struct *wq, struct work_struct *work);
+extern int remove_delayed_work(struct workqueue_struct *wq, struct work_struct *work);
+extern int unschedule_work(struct work_struct *work);
+extern int unschedule_delayed_work(struct work_struct *work);
+
 extern void init_workqueues(void);
 
 /*
===== kernel/workqueue.c 1.28 vs edited =====
--- 1.28/kernel/workqueue.c	2004-09-08 01:33:10 -05:00
+++ edited/kernel/workqueue.c	2004-10-18 09:55:09 -05:00
@@ -81,6 +81,7 @@
 
 	spin_lock_irqsave(&cwq->lock, flags);
 	work->wq_data = cwq;
+	clear_bit(1, &work->pending);
 	list_add_tail(&work->entry, &cwq->worklist);
 	cwq->insert_sequence++;
 	wake_up(&cwq->more_work);
@@ -170,6 +171,7 @@
 		BUG_ON(work->wq_data != cwq);
 		clear_bit(0, &work->pending);
 		f(data);
+		set_bit(1, &work->pending);
 
 		spin_lock_irqsave(&cwq->lock, flags);
 		cwq->remove_sequence++;
@@ -517,13 +519,94 @@
 	BUG_ON(!keventd_wq);
 }
 
+/**
+ * remove_work - try to remove a piece of queued work from a workqueue
+ * @wq:		the workqueue to remove it from
+ * @work:	the item of work queued on the workqueue
+ *
+ * Tries to remove the work before it is executed.  Guarantees that
+ * when it returns either the work is removed or it has been executed.
+ * Requires process context since it may sleep if the work function is
+ * executing.
+ *
+ * Returns 1 if work was successfully removed without executing and 0
+ * if the work was executed.
+ */
+int remove_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	int ret = 1, cpu = get_cpu();
+	struct cpu_workqueue_struct *cwq;
+	unsigned long flags;
+
+	if (unlikely(is_single_threaded(wq)))
+		cpu = 0;
+
+	cwq = &wq->cpu_wq[cpu];
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	list_del_init(&work->entry);
+	if (test_and_clear_bit(0, &work->pending))
+		goto out_unlock;
+	/* work is not pending.  It has either executed or is in the
+	 * process of executing */
+	ret = 0;
+	while (!test_bit(1, &work->pending)) {
+		DEFINE_WAIT(wait);
+		prepare_to_wait(&cwq->work_done, &wait,
+				TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&cwq->lock);
+		schedule();
+		spin_lock_irq(&cwq->lock);
+		finish_wait(&cwq->work_done, &wait);
+	}
+
+ out_unlock:
+	spin_unlock_irqrestore(&cwq->lock, flags);
+
+	put_cpu();
+	return ret;
+}
+
+/**
+ * remove_delayed_work - try to remove a piece of queued work from a workqueue
+ * @wq:		the workqueue to remove it from
+ * @work:	the item of work queued on the workqueue
+ *
+ * Tries to remove the work before it is executed.  Guarantees that
+ * when it returns either the work is removed or it has been executed.
+ * Requires process context since it may sleep if the work function is
+ * executing.
+ *
+ * Returns 1 if work was successfully removed without executing and 0
+ * if the work was executed.
+ */
+int remove_delayed_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	if (del_timer_sync(&work->timer))
+		return 1;
+	return remove_work(wq, work);
+}
+
+int unschedule_work(struct work_struct *work)
+{
+	return remove_work(keventd_wq, work);
+}
+
+int unschedule_delayed_work(struct work_struct *work)
+{
+	return remove_delayed_work(keventd_wq, work);
+}
+
 EXPORT_SYMBOL_GPL(__create_workqueue);
 EXPORT_SYMBOL_GPL(queue_work);
 EXPORT_SYMBOL_GPL(queue_delayed_work);
 EXPORT_SYMBOL_GPL(flush_workqueue);
 EXPORT_SYMBOL_GPL(destroy_workqueue);
+EXPORT_SYMBOL_GPL(remove_work);
 
 EXPORT_SYMBOL(schedule_work);
 EXPORT_SYMBOL(schedule_delayed_work);
 EXPORT_SYMBOL(schedule_delayed_work_on);
 EXPORT_SYMBOL(flush_scheduled_work);
+EXPORT_SYMBOL(unschedule_work);
+EXPORT_SYMBOL(unschedule_delayed_work);

