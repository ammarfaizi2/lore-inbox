Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWGTMVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWGTMVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWGTMVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 08:21:21 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:55764 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932565AbWGTMVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 08:21:20 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH][kernel-doc] Add DocBook documentation for workqueue functions
Date: Thu, 20 Jul 2006 14:22:32 +0200
User-Agent: KMail/1.9.3
Cc: Martin Waitz <tali@admingilde.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200607201145.19147.eike-kernel@sf-tec.de> <44BF6DC5.4030708@s5r6.in-berlin.de>
In-Reply-To: <44BF6DC5.4030708@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607201422.32798.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[kernel-doc] Add DocBook documentation for workqueue functions

kernel/workqueue.c was omitted from generating kernel documentation. This
adds a new section "Workqueues and Kevents" and adds documentation for
some of the functions.

Some functions in this file already had DocBook-style comments, now they
finally become visible.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 35687dd5b77d8dede736e7d622e1359f6c25b8f8
tree bbdd1cf655fb5ac9cd2a1205cd428fa0d6a21be8
parent a050dbf5ec50ebb71ebb455fac68dfd0a9e21bb6
author Rolf Eike Beer <eike-kernel@sf-tec.de> Thu, 20 Jul 2006 14:19:44 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Thu, 20 Jul 2006 14:19:44 +0200

 Documentation/DocBook/kernel-api.tmpl |    3 ++
 kernel/workqueue.c                    |   66 +++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 4 deletions(-)

Version 2 of patch: fixed two copy&waste errors found by Stefan Richter. Also 
added comment on CPU to description of schedule_delayed_work_on.

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
index 7fada82..f7777b8 100644
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
+ * schedule_delayed_work - put work task in global workqueue after delay
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
+ * schedule_delayed_work_on - queue work in global workqueue on CPU after delay
+ *
+ * @cpu: cpu to use
+ * @work: job to be done
+ * @delay: number of jiffies to wait
+ *
+ * After waiting for a given time this puts a job in the kernel-global
+ * workqueue on the specified CPU.
+ */
 int schedule_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
