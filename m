Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265428AbUEUHZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265428AbUEUHZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUEUHZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:25:42 -0400
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:62643 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265428AbUEUHZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:25:05 -0400
Subject: [2.6.6-mm4-ff1] I/O context isolation
From: FabF <Fabian.Frederick@skynet.be>
To: axboe@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-sI8nJEVeHGfMl1PUkCdT"
Message-Id: <1085124268.8064.15.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 09:24:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sI8nJEVeHGfMl1PUkCdT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Jens,

	Here's ff1 patchset to have generic I/O context.
ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
ff2 : Make io_context generic plateform by importing IO stuff from
as_io.

	AFAICS, cfq_queue for instance could disappear when using io_context
but I think elv_data should remain elevator side....
I don't want to go in the wild here so if you've got suggestions, don't
hesitate ;)

Regards,
FabF

--=-sI8nJEVeHGfMl1PUkCdT
Content-Disposition: attachment; filename=2.6.6mm4ff1.diff
Content-Type: text/x-patch; name=2.6.6mm4ff1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.6mm4/Changelog linux-2.6.6mm4ff1/Changelog
--- linux-2.6.6mm4/Changelog	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6mm4ff1/Changelog	2004-05-20 17:35:40.000000000 +0200
@@ -0,0 +1,5 @@
+2.6.6-mm4-ff1
+-------------
+Guideline : io/scheduler redesign
+
+> Extract io_context operations & ds from blkdev (FabF)
diff -Naur linux-2.6.6mm4/Makefile linux-2.6.6mm4ff1/Makefile
--- linux-2.6.6mm4/Makefile	2004-05-19 23:30:25.000000000 +0200
+++ linux-2.6.6mm4ff1/Makefile	2004-05-20 17:30:28.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 6
-EXTRAVERSION = -mm4
+EXTRAVERSION = -mm4ff1
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
diff -Naur linux-2.6.6mm4/Todo linux-2.6.6mm4ff1/Todo
--- linux-2.6.6mm4/Todo	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6mm4ff1/Todo	2004-05-20 17:36:14.000000000 +0200
@@ -0,0 +1,4 @@
+
+< Extract as_io_context from blkdev.h
+< Documentation synch
+
diff -Naur linux-2.6.6mm4/drivers/block/Makefile linux-2.6.6mm4ff1/drivers/block/Makefile
--- linux-2.6.6mm4/drivers/block/Makefile	2004-05-10 04:33:13.000000000 +0200
+++ linux-2.6.6mm4ff1/drivers/block/Makefile	2004-05-20 12:45:55.000000000 +0200
@@ -13,7 +13,7 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o io_context.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff -Naur linux-2.6.6mm4/drivers/block/as-iosched.c linux-2.6.6mm4ff1/drivers/block/as-iosched.c
--- linux-2.6.6mm4/drivers/block/as-iosched.c	2004-05-19 23:30:07.000000000 +0200
+++ linux-2.6.6mm4ff1/drivers/block/as-iosched.c	2004-05-20 13:08:42.000000000 +0200
@@ -9,6 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/io_context.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
 #include <linux/bio.h>
diff -Naur linux-2.6.6mm4/drivers/block/io_context.c linux-2.6.6mm4ff1/drivers/block/io_context.c
--- linux-2.6.6mm4/drivers/block/io_context.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6mm4ff1/drivers/block/io_context.c	2004-05-20 17:25:23.000000000 +0200
@@ -0,0 +1,114 @@
+/*
+ *  linux/drivers/block/io_context.c
+ *
+ * io_context isolation, FabF - may 2004
+ */
+
+#include <linux/io_context.h>
+
+kmem_cache_t *iocontext_cachep;
+
+/*
+ * ioc_set_batching sets ioc to be a new "batcher" if it is not one. This
+ * will cause the process to be a "batcher" on all queues in the system. This
+ * is the behaviour we want though - once it gets a wakeup it should be given
+ * a nice run.
+ */
+void ioc_set_batching(struct io_context *ioc)
+{
+	if (!ioc || ioc_batching(ioc))
+		return;
+
+	ioc->nr_batch_requests = BLK_BATCH_REQ;
+	ioc->last_waited = jiffies;
+}
+
+/*
+ * IO Context helper functions
+ */
+void put_io_context(struct io_context *ioc)
+{
+	if (ioc == NULL)
+		return;
+
+	BUG_ON(atomic_read(&ioc->refcount) == 0);
+
+	if (atomic_dec_and_test(&ioc->refcount)) {
+		if (ioc->aic && ioc->aic->dtor)
+			ioc->aic->dtor(ioc->aic);
+		kmem_cache_free(iocontext_cachep, ioc);
+	}
+}
+
+/* Called by the exitting task */
+void exit_io_context(void)
+{
+	unsigned long flags;
+	struct io_context *ioc;
+
+	local_irq_save(flags);
+	ioc = current->io_context;
+	if (ioc) {
+		if (ioc->aic && ioc->aic->exit)
+			ioc->aic->exit(ioc->aic);
+		put_io_context(ioc);
+		current->io_context = NULL;
+	} else
+		WARN_ON(1);
+	local_irq_restore(flags);
+}
+
+/*
+ * If the current task has no IO context then create one and initialise it.
+ * If it does have a context, take a ref on it.
+ *
+ * This is always called in the context of the task which submitted the I/O.
+ * But weird things happen, so we disable local interrupts to ensure exclusive
+ * access to *current.
+ */
+struct io_context *get_io_context(int gfp_flags)
+{
+	struct task_struct *tsk = current;
+	unsigned long flags;
+	struct io_context *ret;
+
+	local_irq_save(flags);
+	ret = tsk->io_context;
+	if (ret == NULL) {
+		ret = kmem_cache_alloc(iocontext_cachep, GFP_ATOMIC);
+		if (ret) {
+			atomic_set(&ret->refcount, 1);
+			ret->pid = tsk->pid;
+			ret->last_waited = jiffies; /* doesn't matter... */
+			ret->nr_batch_requests = 0; /* because this is 0 */
+			ret->aic = NULL;
+			tsk->io_context = ret;
+		}
+	}
+	if (ret)
+		atomic_inc(&ret->refcount);
+	local_irq_restore(flags);
+	return ret;
+}
+
+void copy_io_context(struct io_context **pdst, struct io_context **psrc)
+{
+	struct io_context *src = *psrc;
+	struct io_context *dst = *pdst;
+
+	if (src) {
+		BUG_ON(atomic_read(&src->refcount) == 0);
+		atomic_inc(&src->refcount);
+		put_io_context(dst);
+		*pdst = src;
+	}
+}
+
+void swap_io_context(struct io_context **ioc1, struct io_context **ioc2)
+{
+	struct io_context *temp;
+	temp = *ioc1;
+	*ioc1 = *ioc2;
+	*ioc2 = temp;
+}
+
diff -Naur linux-2.6.6mm4/drivers/block/ll_rw_blk.c linux-2.6.6mm4ff1/drivers/block/ll_rw_blk.c
--- linux-2.6.6mm4/drivers/block/ll_rw_blk.c	2004-05-19 23:30:07.000000000 +0200
+++ linux-2.6.6mm4ff1/drivers/block/ll_rw_blk.c	2004-05-20 13:03:47.000000000 +0200
@@ -7,6 +7,7 @@
  * Queue request tables / lock, selectable elevator, Jens Axboe <axboe@suse.de>
  * kernel-doc documentation started by NeilBrown <neilb@cse.unsw.edu.au> -  July2000
  * bio rewrite, highmem i/o, etc, Jens Axboe <axboe@suse.de> - may 2001
+ * io_context isolation, FabF - may 2004
  */
 
 /*
@@ -28,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/io_context.h>
 
 /*
  * for max sense size
@@ -47,11 +49,6 @@
  */
 static kmem_cache_t *requestq_cachep;
 
-/*
- * For io context allocations
- */
-static kmem_cache_t *iocontext_cachep;
-
 static wait_queue_head_t congestion_wqh[2] = {
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
@@ -67,12 +64,6 @@
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
 
-/* Amount of time in which a process may batch requests */
-#define BLK_BATCH_TIME	(HZ/50UL)
-
-/* Number of requests a "batching" process may submit */
-#define BLK_BATCH_REQ	32
-
 /*
  * Return the threshold (number of used requests) at which the queue is
  * considered to be congested.  It include a little hysteresis to keep the
@@ -1482,40 +1473,6 @@
 }
 
 /*
- * ioc_batching returns true if the ioc is a valid batching request and
- * should be given priority access to a request.
- */
-static inline int ioc_batching(struct io_context *ioc)
-{
-	if (!ioc)
-		return 0;
-
-	/*
-	 * Make sure the process is able to allocate at least 1 request
-	 * even if the batch times out, otherwise we could theoretically
-	 * lose wakeups.
-	 */
-	return ioc->nr_batch_requests == BLK_BATCH_REQ ||
-		(ioc->nr_batch_requests > 0
-		&& time_before(jiffies, ioc->last_waited + BLK_BATCH_TIME));
-}
-
-/*
- * ioc_set_batching sets ioc to be a new "batcher" if it is not one. This
- * will cause the process to be a "batcher" on all queues in the system. This
- * is the behaviour we want though - once it gets a wakeup it should be given
- * a nice run.
- */
-void ioc_set_batching(struct io_context *ioc)
-{
-	if (!ioc || ioc_batching(ioc))
-		return;
-
-	ioc->nr_batch_requests = BLK_BATCH_REQ;
-	ioc->last_waited = jiffies;
-}
-
-/*
  * A request has just been released.  Account for it, update the full and
  * congestion status, wake up any waiters.   Called under q->queue_lock.
  */
@@ -2845,96 +2802,6 @@
 }
 
 /*
- * IO Context helper functions
- */
-void put_io_context(struct io_context *ioc)
-{
-	if (ioc == NULL)
-		return;
-
-	BUG_ON(atomic_read(&ioc->refcount) == 0);
-
-	if (atomic_dec_and_test(&ioc->refcount)) {
-		if (ioc->aic && ioc->aic->dtor)
-			ioc->aic->dtor(ioc->aic);
-		kmem_cache_free(iocontext_cachep, ioc);
-	}
-}
-
-/* Called by the exitting task */
-void exit_io_context(void)
-{
-	unsigned long flags;
-	struct io_context *ioc;
-
-	local_irq_save(flags);
-	ioc = current->io_context;
-	if (ioc) {
-		if (ioc->aic && ioc->aic->exit)
-			ioc->aic->exit(ioc->aic);
-		put_io_context(ioc);
-		current->io_context = NULL;
-	} else
-		WARN_ON(1);
-	local_irq_restore(flags);
-}
-
-/*
- * If the current task has no IO context then create one and initialise it.
- * If it does have a context, take a ref on it.
- *
- * This is always called in the context of the task which submitted the I/O.
- * But weird things happen, so we disable local interrupts to ensure exclusive
- * access to *current.
- */
-struct io_context *get_io_context(int gfp_flags)
-{
-	struct task_struct *tsk = current;
-	unsigned long flags;
-	struct io_context *ret;
-
-	local_irq_save(flags);
-	ret = tsk->io_context;
-	if (ret == NULL) {
-		ret = kmem_cache_alloc(iocontext_cachep, GFP_ATOMIC);
-		if (ret) {
-			atomic_set(&ret->refcount, 1);
-			ret->pid = tsk->pid;
-			ret->last_waited = jiffies; /* doesn't matter... */
-			ret->nr_batch_requests = 0; /* because this is 0 */
-			ret->aic = NULL;
-			tsk->io_context = ret;
-		}
-	}
-	if (ret)
-		atomic_inc(&ret->refcount);
-	local_irq_restore(flags);
-	return ret;
-}
-
-void copy_io_context(struct io_context **pdst, struct io_context **psrc)
-{
-	struct io_context *src = *psrc;
-	struct io_context *dst = *pdst;
-
-	if (src) {
-		BUG_ON(atomic_read(&src->refcount) == 0);
-		atomic_inc(&src->refcount);
-		put_io_context(dst);
-		*pdst = src;
-	}
-}
-
-void swap_io_context(struct io_context **ioc1, struct io_context **ioc2)
-{
-	struct io_context *temp;
-	temp = *ioc1;
-	*ioc1 = *ioc2;
-	*ioc2 = temp;
-}
-
-
-/*
  * sysfs parts below
  */
 struct queue_sysfs_entry {
diff -Naur linux-2.6.6mm4/include/linux/blkdev.h linux-2.6.6mm4ff1/include/linux/blkdev.h
--- linux-2.6.6mm4/include/linux/blkdev.h	2004-05-19 23:30:24.000000000 +0200
+++ linux-2.6.6mm4ff1/include/linux/blkdev.h	2004-05-20 17:25:03.000000000 +0200
@@ -25,56 +25,8 @@
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
-
-/*
- * This is the per-process anticipatory I/O scheduler state.
- */
-struct as_io_context {
-	spinlock_t lock;
-
-	void (*dtor)(struct as_io_context *aic); /* destructor */
-	void (*exit)(struct as_io_context *aic); /* called on task exit */
-
-	unsigned long state;
-	atomic_t nr_queued; /* queued reads & sync writes */
-	atomic_t nr_dispatched; /* number of requests gone to the drivers */
-
-	/* IO History tracking */
-	/* Thinktime */
-	unsigned long last_end_request;
-	unsigned long ttime_total;
-	unsigned long ttime_samples;
-	unsigned long ttime_mean;
-	/* Layout pattern */
-	unsigned int seek_samples;
-	sector_t last_request_pos;
-	u64 seek_total;
-	sector_t seek_mean;
-};
-
-/*
- * This is the per-process I/O subsystem state.  It is refcounted and
- * kmalloc'ed. Currently all fields are modified in process io context
- * (apart from the atomic refcount), so require no locking.
- */
-struct io_context {
-	atomic_t refcount;
-	pid_t pid;
-
-	/*
-	 * For request batching
-	 */
-	unsigned long last_waited; /* Time last woken after wait for request */
-	int nr_batch_requests;     /* Number of requests left in the batch */
-
-	struct as_io_context *aic;
-};
-
-void put_io_context(struct io_context *ioc);
-void exit_io_context(void);
-struct io_context *get_io_context(int gfp_flags);
-void copy_io_context(struct io_context **pdst, struct io_context **psrc);
-void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
+#define BLK_BATCH_TIME  (HZ/50UL) /*Amount of time in which a process may batch requests */
+#define BLK_BATCH_REQ   32 /* Number of requests a "batching" process may submit */
 
 struct request_list {
 	int count[2];
diff -Naur linux-2.6.6mm4/include/linux/io_context.h linux-2.6.6mm4ff1/include/linux/io_context.h
--- linux-2.6.6mm4/include/linux/io_context.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6mm4ff1/include/linux/io_context.h	2004-05-20 17:25:01.000000000 +0200
@@ -0,0 +1,84 @@
+#ifndef _LINUX_IO_CONTEXT_H
+#define _LINUX_IO_CONTEXT_H
+
+#include <linux/timer.h>
+#include <linux/blkdev.h>
+
+/*
+ * This is the per-process anticipatory I/O scheduler state.
+ */
+
+struct as_io_context {
+	spinlock_t lock;
+
+	void (*dtor)(struct as_io_context *aic); /* destructor */
+	void (*exit)(struct as_io_context *aic); /* called on task exit */
+
+	unsigned long state;
+	atomic_t nr_queued; /* queued reads & sync writes */
+	atomic_t nr_dispatched; /* number of requests gone to the drivers */
+
+	/* IO History tracking */
+	/* Thinktime */
+	unsigned long last_end_request;
+	unsigned long ttime_total;
+	unsigned long ttime_samples;
+	unsigned long ttime_mean;
+	/* Layout pattern */
+	unsigned int seek_samples;
+	sector_t last_request_pos;
+	u64 seek_total;
+	sector_t seek_mean;
+};
+
+/*
+ * This is the per-process I/O subsystem state.  It is refcounted and
+ * kmalloc'ed. Currently all fields are modified in process io context
+ * (apart from the atomic refcount), so require no locking.
+ */
+struct io_context {
+	atomic_t refcount;
+	pid_t pid;
+
+	/*
+	 * For request batching
+	 */
+	unsigned long last_waited; /* Time last woken after wait for request */
+	int nr_batch_requests;     /* Number of requests left in the batch */
+
+	struct as_io_context *aic;
+};
+
+extern kmem_cache_t *iocontext_cachep;
+
+/*
+ * For io context allocations
+ */
+static inline int ioc_batching(struct io_context *ioc);
+void ioc_set_batching(struct io_context *ioc);
+void put_io_context(struct io_context *ioc);
+void exit_io_context(void);
+struct io_context *get_io_context(int gfp_flags);
+void copy_io_context(struct io_context **pdst, struct io_context **psrc);
+void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
+
+/*
+ * ioc_batching returns true if the ioc is a valid batching request and
+ * should be given priority access to a request.
+ */
+static inline int ioc_batching(struct io_context *ioc)
+{
+	if (!ioc)
+		return 0;
+
+	/*
+	 * Make sure the process is able to allocate at least 1 request
+	 * even if the batch times out, otherwise we could theoretically
+	 * lose wakeups.
+	 */
+	return ioc->nr_batch_requests == BLK_BATCH_REQ ||
+		(ioc->nr_batch_requests > 0
+		&& time_before(jiffies, ioc->last_waited + BLK_BATCH_TIME));
+}
+
+#endif

--=-sI8nJEVeHGfMl1PUkCdT--

