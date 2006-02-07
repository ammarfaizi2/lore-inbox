Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWBGUA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWBGUA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWBGUA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:00:28 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:64434 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964903AbWBGUA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:00:27 -0500
Subject: [PATCH] add execute_in_process_context() API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 14:00:19 -0600
Message-Id: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI needs this for our scheme to avoid executing generic device release
calls from interrupt context (SCSI patch using this to follow).

If no-one objects, I'd like to slide this into the scsi-rc-fixes-2.6
tree for 2.6.16.

James

--

[PATCH] add execute_in_process_context() API

We have several points in the SCSI stack (primarily for our device
functions) where we need to guarantee process context, but (given the
place where the last reference was released) we cannot guarantee this.

This API gets around the issue by executing the function directly if
the caller has process context, but scheduling a workqueue to execute
in process context if the caller doesn't have it.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/include/linux/workqueue.h
===================================================================
--- BUILD-2.6.orig/include/linux/workqueue.h	2006-02-07 09:22:30.000000000 -0600
+++ BUILD-2.6/include/linux/workqueue.h	2006-02-07 10:22:29.000000000 -0600
@@ -74,6 +74,7 @@
 void cancel_rearming_delayed_work(struct work_struct *work);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
 				       struct work_struct *);
+int execute_in_process_context(void (*fn)(void *), void *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
Index: BUILD-2.6/kernel/workqueue.c
===================================================================
--- BUILD-2.6.orig/kernel/workqueue.c	2006-02-07 09:22:30.000000000 -0600
+++ BUILD-2.6/kernel/workqueue.c	2006-02-07 11:07:47.000000000 -0600
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/kthread.h>
+#include <linux/hardirq.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -476,6 +477,63 @@
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_work);
 
+struct work_queue_work {
+	struct work_struct	work;
+	void			(*fn)(void *);
+	void			*data;
+};
+
+static void execute_in_process_context_work(void *data)
+{
+	void (*fn)(void *data);
+	struct work_queue_work *wqw = data;
+
+	fn = wqw->fn;
+	data = wqw->data;
+
+	kfree(wqw);
+
+	fn(data);
+}
+
+/**
+ * execute_in_process_context - reliably execute the routine with user context
+ * @fn:		the function to execute
+ * @data:	data to pass to the function
+ *
+ * Executes the function immediately if process context is available,
+ * otherwise schedules the function for delayed execution.
+ *
+ * Returns:	0 - function was executed
+ *		1 - function was scheduled for execution
+ *		<0 - error
+ */
+int execute_in_process_context(void (*fn)(void *data), void *data)
+{
+	struct work_queue_work *wqw;
+
+	if (!in_interrupt()) {
+		fn(data);
+		return 0;
+	}
+
+	wqw = kmalloc(sizeof(struct work_queue_work), GFP_ATOMIC);
+
+	if (unlikely(!wqw)) {
+		printk(KERN_ERR "Failed to allocate memory\n");
+		WARN_ON(1);
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&wqw->work, execute_in_process_context_work, wqw);
+	wqw->fn = fn;
+	wqw->data = data;
+	schedule_work(&wqw->work);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(execute_in_process_context);
+
 int keventd_up(void)
 {
 	return keventd_wq != NULL;


