Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWGTJoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWGTJoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 05:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWGTJoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 05:44:07 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:31959 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030235AbWGTJoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 05:44:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Martin Waitz <tali@admingilde.org>
Subject: [PATCH][kernel-doc] Add DocBook documentation for workqueue functions
Date: Thu, 20 Jul 2006 11:45:18 +0200
User-Agent: KMail/1.9.3
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607201145.19147.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/workqueue.c was omitted from generating kernel documentation. This
adds a new section "Workqueues and Kevents" and adds documentation for
some of the functions.

Some functions in this file already had DocBook-style comments, now they 
finally become visible

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
author Rolf Eike Beer <eike-kernel@sf-tec.de> Thu, 20 Jul 2006 11:38:50 +0200

 Documentation/DocBook/kernel-api.tmpl |    3 ++
 kernel/workqueue.c                    |   66 +++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 1ae4dc0..2d0cc38 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -59,6 +59,9 @@
 !Iinclude/linux/hrtimer.h
 !Ekernel/hrtimer.c
      </sect1>
+     <sect1><title>Workqueues and Kevents</title>
+!Ekernel/workqueue.c
+     </sect1>
      <sect1><title>Internal Functions</title>
 !Ikernel/exit.c
 !Ikernel/signal.c
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7fada82..8f1086e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -93,9 +93,13 @@ static void __queue_work(struct cpu_work
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
-/*
- * Queue work on a workqueue. Return non-zero if it was successfully
- * added.
+/**
+ * queue_work - queue work on a workqueue
+ *
+ * @wq: workqueue to use
+ * @work: work to queue
+ *
+ * Returns non-zero if it was successfully added.
  *
  * We queue the work to the CPU it was submitted, but there is no
  * guarantee that it will be processed by that CPU.
@@ -128,6 +132,15 @@ static void delayed_work_timer_fn(unsign
 	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
 
+/**
+ * queue_delayed_work - queue work on a workqueue after delay
+ *
+ * @wq: workqueue to use
+ * @work: work to queue
+ * @delay: number of jiffies to wait before queueing
+ *
+ * Returns non-zero if it was successfully added.
+ */
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)
 {
@@ -150,6 +163,16 @@ int fastcall queue_delayed_work(struct w
 }
 EXPORT_SYMBOL_GPL(queue_delayed_work);
 
+/**
+ * queue_delayed_work_on - queue work on specific CPU after delay
+ *
+ * @cpu: CPU number to execute work on
+ * @wq: workqueue to use
+ * @work: work to queue
+ * @delay: number of jiffies to wait before queueing
+ *
+ * Returns non-zero if it was successfully added.
+ */
 int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)
 {
@@ -275,9 +298,11 @@ static void flush_cpu_workqueue(struct c
 	}
 }
 
-/*
+/**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  *
+ * @wq: workqueue to flush
+ *
  * Forces execution of the workqueue and blocks until its completion.
  * This is typically used in driver shutdown handlers.
  *
@@ -400,6 +425,13 @@ static void cleanup_workqueue_thread(str
 		kthread_stop(p);
 }
 
+/**
+ * destroy_workqueue - safely terminate a workqueue
+ *
+ * @wq: target workqueue
+ *
+ * Safely destroy a workqueue. All work currently pending will be done first.
+ */
 void destroy_workqueue(struct workqueue_struct *wq)
 {
 	int cpu;
@@ -425,18 +457,44 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
 
 static struct workqueue_struct *keventd_wq;
 
+/**
+ * schedule_work - put work task in global workqueue
+ *
+ * @work: job to be done
+ *
+ * This puts a job in the kernel-global workqueue.
+ */
 int fastcall schedule_work(struct work_struct *work)
 {
 	return queue_work(keventd_wq, work);
 }
 EXPORT_SYMBOL(schedule_work);
 
+/**
+ * schedule_work - put work task in global workqueue after delay
+ *
+ * @work: job to be done
+ * @delay: number of jiffies to wait
+ *
+ * After waiting for a given time this puts a job in the kernel-global
+ * workqueue.
+ */
 int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
 {
 	return queue_delayed_work(keventd_wq, work, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work);
 
+/**
+ * schedule_work - queue work in global workqueue on specific CPU after delay
+ *
+ * @cpu: cpu to use
+ * @work: job to be done
+ * @delay: number of jiffies to wait
+ *
+ * After waiting for a given time this puts a job in the kernel-global
+ * workqueue.
+ */
 int schedule_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
