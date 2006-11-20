Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934191AbWKTO3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934191AbWKTO3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934193AbWKTO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:29:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21128 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934191AbWKTO3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:29:54 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] WorkStruct: Typedef the work function prototype
Date: Mon, 20 Nov 2006 14:27:18 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a type for the work function prototype.  It's not only kept in the
work_struct struct, it's also passed as an argument to several functions.

This makes it easier to change it.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/block/floppy.c    |    4 ++--
 include/linux/workqueue.h |    8 +++++---
 kernel/workqueue.c        |    6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 9e6d3a8..5a14fac 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -996,7 +996,7 @@ static DECLARE_WORK(floppy_work, NULL, N
 
 static void schedule_bh(void (*handler) (void))
 {
-	PREPARE_WORK(&floppy_work, (void (*)(void *))handler, NULL);
+	PREPARE_WORK(&floppy_work, (work_func_t)handler, NULL);
 	schedule_work(&floppy_work);
 }
 
@@ -1008,7 +1008,7 @@ static void cancel_activity(void)
 
 	spin_lock_irqsave(&floppy_lock, flags);
 	do_floppy = NULL;
-	PREPARE_WORK(&floppy_work, (void *)empty, NULL);
+	PREPARE_WORK(&floppy_work, (work_func_t)empty, NULL);
 	del_timer(&fd_timer);
 	spin_unlock_irqrestore(&floppy_lock, flags);
 }
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 6df8388..0d5bbd4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -11,10 +11,12 @@ #include <linux/bitops.h>
 
 struct workqueue_struct;
 
+typedef void (*work_func_t)(void *data);
+
 struct work_struct {
 	unsigned long pending;
 	struct list_head entry;
-	void (*func)(void *);
+	work_func_t func;
 	void *data;
 	void *wq_data;
 };
@@ -99,7 +101,7 @@ static inline int schedule_dwork(struct 
 extern int FASTCALL(schedule_delayed_work(struct dwork_struct *dwork, unsigned long delay));
 
 extern int schedule_delayed_work_on(int cpu, struct dwork_struct *dwork, unsigned long delay);
-extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
+extern int schedule_on_each_cpu(work_func_t func, void *info);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
@@ -108,7 +110,7 @@ extern void init_workqueues(void);
 void cancel_rearming_delayed_work(struct dwork_struct *dwork);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
 				       struct dwork_struct *);
-int execute_in_process_context(void (*fn)(void *), void *,
+int execute_in_process_context(work_func_t fn, void *,
 			       struct execute_work *);
 
 /*
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfd1888..bb2b6a7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -214,7 +214,7 @@ static void run_workqueue(struct cpu_wor
 	while (!list_empty(&cwq->worklist)) {
 		struct work_struct *work = list_entry(cwq->worklist.next,
 						struct work_struct, entry);
-		void (*f) (void *) = work->func;
+		work_func_t f = work->func;
 		void *data = work->data;
 
 		list_del_init(cwq->worklist.next);
@@ -510,7 +510,7 @@ EXPORT_SYMBOL(schedule_delayed_work_on);
  *
  * schedule_on_each_cpu() is very slow.
  */
-int schedule_on_each_cpu(void (*func)(void *info), void *info)
+int schedule_on_each_cpu(work_func_t func, void *info)
 {
 	int cpu;
 	struct work_struct *works;
@@ -575,7 +575,7 @@ EXPORT_SYMBOL(cancel_rearming_delayed_wo
  * Returns:	0 - function was executed
  *		1 - function was scheduled for execution
  */
-int execute_in_process_context(void (*fn)(void *data), void *data,
+int execute_in_process_context(work_func_t fn, void *data,
 			       struct execute_work *ew)
 {
 	if (!in_interrupt()) {
