Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934202AbWKTOah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934202AbWKTOah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934193AbWKTOab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:30:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934192AbWKTO36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:29:58 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/4] WorkStruct: Merge the pending bit into the wq_data pointer
Date: Mon, 20 Nov 2006 14:27:20 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061120142720.12685.79394.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaim a word from the size of the work_struct by folding the pending bit and
the wq_data pointer together.  This shouldn't cause misalignment problems as
all pointers should be at least 4-byte aligned.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/block/floppy.c    |    4 ++--
 include/linux/workqueue.h |   19 +++++++++++++++----
 kernel/workqueue.c        |   41 ++++++++++++++++++++++++++++++++---------
 3 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 5a14fac..aa1eb44 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1868,7 +1868,7 @@ #endif
 	printk("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		printk("do_floppy=%p\n", do_floppy);
-	if (floppy_work.pending)
+	if (work_pending(&floppy_work))
 		printk("floppy_work.func=%p\n", floppy_work.func);
 	if (timer_pending(&fd_timer))
 		printk("fd_timer.function=%p\n", fd_timer.function);
@@ -4498,7 +4498,7 @@ #endif
 		printk("floppy timer still active:%s\n", timeout_message);
 	if (timer_pending(&fd_timer))
 		printk("auxiliary floppy timer still active\n");
-	if (floppy_work.pending)
+	if (work_pending(&floppy_work))
 		printk("work still pending\n");
 #endif
 	old_fdc = fdc;
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0d5bbd4..67e6a7f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -14,11 +14,15 @@ struct workqueue_struct;
 typedef void (*work_func_t)(void *data);
 
 struct work_struct {
-	unsigned long pending;
+	/* the first word is the work queue pointer and the pending flag
+	 * rolled into one */
+	unsigned long management;
+#define WORK_STRUCT_PENDING 0		/* T if work item pending execution */
+#define WORK_STRUCT_FLAG_MASK (3UL)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
 	struct list_head entry;
 	work_func_t func;
 	void *data;
-	void *wq_data;
 };
 
 struct dwork_struct {
@@ -65,7 +69,7 @@ #define PREPARE_DELAYABLE_WORK(_work, _f
 #define INIT_WORK(_work, _func, _data)				\
 	do {							\
 		INIT_LIST_HEAD(&(_work)->entry);		\
-		(_work)->pending = 0;				\
+		(_work)->management = 0;			\
 		PREPARE_WORK((_work), (_func), (_data));	\
 	} while (0)
 
@@ -75,6 +79,13 @@ #define INIT_DELAYABLE_WORK(_work, _func
 		init_timer(&(_work)->timer);			\
 	} while (0)
 
+/**
+ * work_pending - Find out whether a work item is currently pending
+ * @work: The work item in question
+ */
+#define work_pending(work) \
+	test_bit(WORK_STRUCT_PENDING, &(work)->management)
+
 extern struct workqueue_struct *__create_workqueue(const char *name,
 						    int singlethread);
 #define create_workqueue(name) __create_workqueue((name), 0)
@@ -124,7 +135,7 @@ static inline int cancel_delayed_work(st
 
 	ret = del_timer_sync(&dwork->timer);
 	if (ret)
-		clear_bit(0, &dwork->work.pending);
+		clear_bit(WORK_STRUCT_PENDING, &dwork->work.management);
 	return ret;
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb2b6a7..a81d151 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -80,6 +80,29 @@ static inline int is_single_threaded(str
 	return list_empty(&wq->list);
 }
 
+static inline void set_wq_data(struct work_struct *work, void *wq)
+{
+	unsigned long new, old, res;
+
+	/* assume the pending flag is already set and that the task has already
+	 * been queued on this workqueue */
+	new = (unsigned long) wq | (1UL << WORK_STRUCT_PENDING);
+	res = work->management;
+	if (res != new) {
+		do {
+			old = res;
+			new = (unsigned long) wq;
+			new |= (old & WORK_STRUCT_FLAG_MASK);
+			res = cmpxchg(&work->management, old, new);
+		} while (res != old);
+	}
+}
+
+static inline void *get_wq_data(struct work_struct *work)
+{
+	return (void *) (work->management & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 /* Preempt must be disabled. */
 static void __queue_work(struct cpu_workqueue_struct *cwq,
 			 struct work_struct *work)
@@ -87,7 +110,7 @@ static void __queue_work(struct cpu_work
 	unsigned long flags;
 
 	spin_lock_irqsave(&cwq->lock, flags);
-	work->wq_data = cwq;
+	set_wq_data(work, cwq);
 	list_add_tail(&work->entry, &cwq->worklist);
 	cwq->insert_sequence++;
 	wake_up(&cwq->more_work);
@@ -108,7 +131,7 @@ int fastcall queue_work(struct workqueue
 {
 	int ret = 0, cpu = get_cpu();
 
-	if (!test_and_set_bit(0, &work->pending)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
 		if (unlikely(is_single_threaded(wq)))
 			cpu = singlethread_cpu;
 		BUG_ON(!list_empty(&work->entry));
@@ -123,7 +146,7 @@ EXPORT_SYMBOL_GPL(queue_work);
 static void delayed_work_timer_fn(unsigned long __data)
 {
 	struct dwork_struct *dwork = (struct dwork_struct *)__data;
-	struct workqueue_struct *wq = dwork->work.wq_data;
+	struct workqueue_struct *wq = get_wq_data(&dwork->work);
 	int cpu = smp_processor_id();
 
 	if (unlikely(is_single_threaded(wq)))
@@ -147,12 +170,12 @@ int fastcall queue_delayed_work(struct w
 	struct timer_list *timer = &dwork->timer;
 	struct work_struct *work = &dwork->work;
 
-	if (!test_and_set_bit(0, &work->pending)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
 		/* This stores wq for the moment, for the timer_fn */
-		work->wq_data = wq;
+		set_wq_data(work, wq);
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)dwork;
 		timer->function = delayed_work_timer_fn;
@@ -179,12 +202,12 @@ int queue_delayed_work_on(int cpu, struc
 	struct timer_list *timer = &dwork->timer;
 	struct work_struct *work = &dwork->work;
 
-	if (!test_and_set_bit(0, &work->pending)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
 		/* This stores wq for the moment, for the timer_fn */
-		work->wq_data = wq;
+		set_wq_data(work, wq);
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)dwork;
 		timer->function = delayed_work_timer_fn;
@@ -220,8 +243,8 @@ static void run_workqueue(struct cpu_wor
 		list_del_init(cwq->worklist.next);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
-		BUG_ON(work->wq_data != cwq);
-		clear_bit(0, &work->pending);
+		BUG_ON(get_wq_data(work) != cwq);
+		clear_bit(WORK_STRUCT_PENDING, &work->management);
 		f(data);
 
 		spin_lock_irqsave(&cwq->lock, flags);
