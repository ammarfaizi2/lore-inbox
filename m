Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270393AbUJUIoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270393AbUJUIoB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270706AbUJUIaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:30:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28602 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270699AbUJUIXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:23:54 -0400
Date: Thu, 21 Oct 2004 10:23:23 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH] softirq block request completion
Message-ID: <20041021082322.GW10531@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to play with this after the io completion latency talks started
some time ago. So I got an hour to do so this morning, this is what I
came up with. It's only lightly tested, but it does boot and survives a
dbench on IDE and SCSI.

This is just an RFC, not a call for inclusion (as if the above should
not be enough of a warning :-)

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/ll_rw_blk.c 1.274 vs edited =====
--- 1.274/drivers/block/ll_rw_blk.c	2004-10-20 10:37:07 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-10-21 10:21:57 +02:00
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/interrupt.h>
+#include <linux/hash.h>
 
 /*
  * for max sense size
@@ -60,13 +62,27 @@
 /*
  * Controlling structure to kblockd
  */
-static struct workqueue_struct *kblockd_workqueue; 
+static struct workqueue_struct *kblockd_workqueue;
 
 unsigned long blk_max_low_pfn, blk_max_pfn;
 
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
 
+/*
+ * per-cpu completion stuff. try to ammortize the cost of getting the
+ * queue_lock by collecting queues in different lists. this should be related
+ * to NR_CPUS as well, no point in making BLK_NR_COMP_QUEUES bigger than the
+ * number of cpus in the system.
+ */
+#define BLK_NR_COMP_SHIFT	2
+#define BLK_NR_COMP_QUEUES	(1 << BLK_NR_COMP_SHIFT)
+
+struct blk_completion_queue {
+	struct list_head done_list[BLK_NR_COMP_QUEUES];
+};
+static DEFINE_PER_CPU(struct blk_completion_queue, blk_cpu_done);
+
 /* Amount of time in which a process may batch requests */
 #define BLK_BATCH_TIME	(HZ/50UL)
 
@@ -2968,6 +2984,113 @@
 EXPORT_SYMBOL(end_that_request_chunk);
 
 /*
+ * end io completely on this list of requests. operation is split into two
+ * parts - one that can run without the queue lock held, and one which
+ * requires it.
+ */
+#define list_entry_done(entry) list_entry((entry), struct request, donelist)
+static void process_completion_queue(struct list_head *list)
+{
+	LIST_HEAD(local_list);
+	request_queue_t *q;
+	static int max;
+	int i = 0;
+
+	while (!list_empty(list)) {
+		struct request *rq = list_entry_done(list->next);
+		unsigned int bytes_done;
+		int uptodate;
+
+		list_move(&rq->donelist, &local_list);
+		i++;
+
+		/*
+		 * fs or pc request
+		 */
+		if (blk_fs_request(rq))
+			bytes_done = rq->hard_nr_sectors << 9;
+		else
+			bytes_done = rq->data_len;
+
+		uptodate = 1;
+		if (rq->errors)
+			uptodate = rq->errors;
+
+		end_that_request_chunk(rq, uptodate, bytes_done);
+		add_disk_randomness(rq->rq_disk);
+	}
+
+	q = NULL;
+	list = &local_list;
+	while (!list_empty(list)) {
+		struct request *rq = list_entry_done(list->next);
+
+		list_del_init(&rq->donelist);
+
+		if (q != rq->q) {
+			if (q)
+				spin_unlock_irq(q->queue_lock);
+
+			q = rq->q;
+			spin_lock_irq(q->queue_lock);
+		}
+
+		if (blk_rq_tagged(rq))
+			blk_queue_end_tag(q, rq);
+
+		end_that_request_last(rq);
+	}
+
+	if (q)
+		spin_unlock_irq(q->queue_lock);
+}
+
+/*
+ * splice the completion data to a local structure and hand off to
+ * process_completion_queue() to complete the requests
+ */
+static void blk_done_softirq(struct softirq_action *h)
+{
+	struct blk_completion_queue local_bcq;
+	struct blk_completion_queue *bcq;
+	int i;
+
+	for (i = 0; i < BLK_NR_COMP_QUEUES; i++)
+		INIT_LIST_HEAD(&local_bcq.done_list[i]);
+
+	local_irq_disable();
+	bcq = &__get_cpu_var(blk_cpu_done);
+
+	for (i = 0; i < BLK_NR_COMP_QUEUES; i++)
+		list_splice_init(&bcq->done_list[i], &local_bcq.done_list[i]);
+
+	local_irq_enable();
+
+	for (i = 0; i < BLK_NR_COMP_QUEUES; i++)
+		process_completion_queue(&local_bcq.done_list[i]);
+}
+
+void end_that_request_completely(struct request *req)
+{
+	long index = hash_ptr(req->q, BLK_NR_COMP_SHIFT);
+	struct blk_completion_queue *bcq;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&req->donelist);
+	BUG_ON(!blk_pc_request(req) && !blk_fs_request(req));
+
+	local_irq_save(flags);
+
+	bcq = &__get_cpu_var(blk_cpu_done);
+	list_add_tail(&req->donelist, &bcq->done_list[index]);
+	raise_softirq_irqoff(BLOCK_SOFTIRQ);
+
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(end_that_request_completely);
+	
+/*
  * queue lock must be held
  */
 void end_that_request_last(struct request *req)
@@ -3064,6 +3187,8 @@
 
 int __init blk_dev_init(void)
 {
+	int i, j;
+
 	kblockd_workqueue = create_workqueue("kblockd");
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
@@ -3076,6 +3201,15 @@
 
 	iocontext_cachep = kmem_cache_create("blkdev_ioc",
 			sizeof(struct io_context), 0, SLAB_PANIC, NULL, NULL);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		struct blk_completion_queue *bcq = &per_cpu(blk_cpu_done, i);
+
+		for (j = 0; j < BLK_NR_COMP_QUEUES; j++)
+			INIT_LIST_HEAD(&bcq->done_list[j]);
+	}
+
+	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq, NULL);
 
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
===== drivers/ide/ide-io.c 1.32 vs edited =====
--- 1.32/drivers/ide/ide-io.c	2004-10-20 18:52:21 +02:00
+++ edited/drivers/ide/ide-io.c	2004-10-21 09:02:12 +02:00
@@ -135,6 +135,12 @@
 		HWGROUP(drive)->hwif->ide_dma_on(drive);
 	}
 
+	if (rq_all_done(rq, nr_sectors << 9)) {
+		blkdev_dequeue_request(rq);
+		end_that_request_completely(rq);
+		goto next;
+	}
+
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
 		add_disk_randomness(rq->rq_disk);
 
@@ -142,8 +148,9 @@
 			blk_queue_end_tag(drive->queue, rq);
 
 		blkdev_dequeue_request(rq);
-		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
+next:
+		HWGROUP(drive)->rq = NULL;
 		ret = 0;
 	}
 	return ret;
===== drivers/scsi/scsi_lib.c 1.137 vs edited =====
--- 1.137/drivers/scsi/scsi_lib.c	2004-10-19 08:06:58 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2004-10-21 08:45:15 +02:00
@@ -522,6 +522,11 @@
 	struct request *req = cmd->request;
 	unsigned long flags;
 
+	if (rq_all_done(req, bytes)) {
+		end_that_request_completely(req);
+		goto next;
+	}
+
 	/*
 	 * If there are blocks left over at the end, set up the command
 	 * to queue the remainder of them.
@@ -560,6 +565,7 @@
 	 * This will goose the queue request function at the end, so we don't
 	 * need to worry about launching another command.
 	 */
+next:
 	scsi_next_command(cmd);
 	return NULL;
 }
===== include/linux/blkdev.h 1.154 vs edited =====
--- 1.154/include/linux/blkdev.h	2004-10-19 11:40:18 +02:00
+++ edited/include/linux/blkdev.h	2004-10-21 10:06:44 +02:00
@@ -106,9 +106,8 @@
  * try to put the fields that are referenced together in the same cacheline
  */
 struct request {
-	struct list_head queuelist; /* looking for ->queue? you must _not_
-				     * access it directly, use
-				     * blkdev_dequeue_request! */
+	struct list_head queuelist;
+	struct list_head donelist;
 	unsigned long flags;		/* see REQ_ bits below */
 
 	/* Maintain bio traversal state for part by part I/O submission.
@@ -591,6 +590,16 @@
 extern void end_that_request_last(struct request *);
 extern int process_that_request_first(struct request *, unsigned int);
 extern void end_request(struct request *req, int uptodate);
+extern void end_that_request_completely(struct request *);
+
+static inline int rq_all_done(struct request *rq, unsigned int nr_bytes)
+{
+	if ((blk_fs_request(rq) && nr_bytes >= (rq->hard_nr_sectors << 9)) ||
+	    (blk_pc_request(rq) && nr_bytes >= rq->data_len))
+		return 1;
+
+	return 0;
+}
 
 /*
  * end_that_request_first/chunk() takes an uptodate argument. we account
===== include/linux/interrupt.h 1.31 vs edited =====
--- 1.31/include/linux/interrupt.h	2004-10-19 07:26:39 +02:00
+++ edited/include/linux/interrupt.h	2004-10-21 08:45:15 +02:00
@@ -89,6 +89,7 @@
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	SCSI_SOFTIRQ,
+	BLOCK_SOFTIRQ,
 	TASKLET_SOFTIRQ
 };
 

-- 
Jens Axboe

