Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbSLETmc>; Thu, 5 Dec 2002 14:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbSLETmb>; Thu, 5 Dec 2002 14:42:31 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19891 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267402AbSLETmN>; Thu, 5 Dec 2002 14:42:13 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.20-aa1] Readlatency-2
Date: Thu, 5 Dec 2002 20:49:10 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200212052047.36094.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YDWNDV4DL6I2N2526MV2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YDWNDV4DL6I2N2526MV2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

as requested by GrandMasterLee (does he have a realname? ;) here goes=20
readlatency2 for 2.4.20aa1. Apply ontop of it.

Note: This patch rippes out the elevator-lowlatency hack.

ciao, Marc
--------------Boundary-00=_YDWNDV4DL6I2N2526MV2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="read-latency2-2.4.20-aa1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="read-latency2-2.4.20-aa1.patch"

diff -urN linux-2.4.20-aa1/drivers/block/cciss.c linux-2.4.20-aa1-rl2/drivers/block/cciss.c
--- linux-2.4.20-aa1/drivers/block/cciss.c	2002-12-05 20:44:02.000000000 +0100
+++ linux-2.4.20-aa1-rl2/drivers/block/cciss.c	2002-12-05 20:41:09.000000000 +0100
@@ -1147,7 +1147,7 @@
 	}
 }
 
-static inline void complete_buffers(struct request * req, struct buffer_head *bh, int status)
+static inline void complete_buffers( struct buffer_head *bh, int status)
 {
 	struct buffer_head *xbh;
 	
@@ -1155,7 +1155,7 @@
 	{
 		xbh = bh->b_reqnext; 
 		bh->b_reqnext = NULL; 
-		blk_finished_io(req, bh->b_size >> 9);
+		blk_finished_io(bh->b_size >> 9);
 		bh->b_end_io(bh, status);
 		bh = xbh;
 	}
@@ -1267,7 +1267,7 @@
 				status=0;
 		}
 	}
-	complete_buffers(cmd->rq, cmd->rq->bh, status);
+	complete_buffers(cmd->rq->bh, status);
 
 #ifdef CCISS_DEBUG
 	printk("Done with %p\n", cmd->rq);
@@ -1352,7 +1352,7 @@
                 printk(KERN_WARNING "doreq cmd for %d, %x at %p\n",
                                 h->ctlr, creq->rq_dev, creq);
                 blkdev_dequeue_request(creq);
-                complete_buffers(creq, creq->bh, 0);
+                complete_buffers(creq->bh, 0);
 		end_that_request_last(creq);
 		goto startio;
         }
diff -urN linux-2.4.20-aa1/drivers/block/cpqarray.c linux-2.4.20-aa1-rl2/drivers/block/cpqarray.c
--- linux-2.4.20-aa1/drivers/block/cpqarray.c	2002-12-05 20:44:02.000000000 +0100
+++ linux-2.4.20-aa1-rl2/drivers/block/cpqarray.c	2002-12-05 20:41:09.000000000 +0100
@@ -168,7 +168,7 @@
 
 static inline void addQ(cmdlist_t **Qptr, cmdlist_t *c);
 static inline cmdlist_t *removeQ(cmdlist_t **Qptr, cmdlist_t *c);
-static inline void complete_buffers(struct request * req, struct buffer_head *bh, int ok);
+static inline void complete_buffers(struct buffer_head *bh, int ok);
 static inline void complete_command(cmdlist_t *cmd, int timeout);
 
 static void do_ida_intr(int irq, void *dev_id, struct pt_regs * regs);
@@ -990,7 +990,7 @@
 		printk(KERN_WARNING "doreq cmd for %d, %x at %p\n",
 				h->ctlr, creq->rq_dev, creq);
 		blkdev_dequeue_request(creq);
-		complete_buffers(creq, creq->bh, 0);
+		complete_buffers(creq->bh, 0);
 		end_that_request_last(creq);
 		goto startio;
 	}
@@ -1092,14 +1092,14 @@
 	}
 }
 
-static inline void complete_buffers(struct request * req, struct buffer_head *bh, int ok)
+static inline void complete_buffers(struct buffer_head *bh, int ok)
 {
 	struct buffer_head *xbh;
 	while(bh) {
 		xbh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		
-		blk_finished_io(req, bh->b_size >> 9);
+		blk_finished_io(bh->b_size >> 9);
 		bh->b_end_io(bh, ok);
 
 		bh = xbh;
@@ -1140,7 +1140,7 @@
                         (cmd->req.hdr.cmd == IDA_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
         }
 
-	complete_buffers(cmd->rq, cmd->rq->bh, ok);
+	complete_buffers(cmd->rq->bh, ok);
 	DBGPX(printk("Done with %p\n", cmd->rq););
 	req_finished_io(cmd->rq);
 	end_that_request_last(cmd->rq);
diff -urN linux-2.4.20-aa1/drivers/block/elevator.c linux-2.4.20-aa1-rl2/drivers/block/elevator.c
--- linux-2.4.20-aa1/drivers/block/elevator.c	2002-12-05 20:44:02.000000000 +0100
+++ linux-2.4.20-aa1-rl2/drivers/block/elevator.c	2002-12-05 20:42:36.000000000 +0100
@@ -80,26 +80,38 @@
 			 struct buffer_head *bh, int rw,
 			 int max_sectors)
 {
-	struct list_head *entry = &q->queue_head;
-	unsigned int count = bh->b_size >> 9, ret = ELEVATOR_NO_MERGE;
+	struct list_head *entry;
+	unsigned int count = bh->b_size >> 9;
+	unsigned int ret = ELEVATOR_NO_MERGE;
+	int merge_only = 0;
+	const int max_bomb_segments = q->elevator.max_bomb_segments;
 	struct request *__rq;
-	int backmerge_only = 0;
+	int passed_a_read = 0;
+
+	entry = &q->queue_head;
 
-	while (!backmerge_only && (entry = entry->prev) != head) {
+	while ((entry = entry->prev) != head) {
 		__rq = blkdev_entry_to_request(entry);
 
-		/*
-		 * we can't insert beyond a zero sequence point
-		 */
-		if (__rq->elevator_sequence <= 0)
-			backmerge_only = 1;
+		if (__rq->elevator_sequence-- <= 0) {
+			/*
+			 * OK, we've exceeded someone's latency limit.
+			 * But we still continue to look for merges,
+			 * because they're so much better than seeks.
+			 */
+			merge_only = 1;
+		}
 
 		if (__rq->waiting)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)
 			continue;
-		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head) && !backmerge_only)
+		if (!*req && !merge_only &&
+				bh_rq_in_between(bh, __rq, &q->queue_head)) {
 			*req = __rq;
+		}
+		if (__rq->cmd != WRITE)
+			passed_a_read = 1;
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
@@ -108,7 +120,7 @@
 			ret = ELEVATOR_BACK_MERGE;
 			*req = __rq;
 			break;
-		} else if (__rq->sector - count == bh->b_rsector && !backmerge_only) {
+		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
 			__rq->elevator_sequence--;
 			*req = __rq;
@@ -130,6 +142,57 @@
 		}
 	}
 
+	/*
+	 * If we failed to merge a read anywhere in the request
+	 * queue, we really don't want to place it at the end
+	 * of the list, behind lots of writes.  So place it near
+	 * the front.
+	 *
+	 * We don't want to place it in front of _all_ writes: that
+	 * would create lots of seeking, and isn't tunable.
+	 * We try to avoid promoting this read in front of existing
+	 * reads.
+	 *
+	 * max_bomb_segments becomes the maximum number of write
+	 * requests which we allow to remain in place in front of
+	 * a newly introduced read.  We weight things a little bit,
+	 * so large writes are more expensive than small ones, but it's
+	 * requests which count, not sectors.
+	 */
+	if (max_bomb_segments && rw == READ && !passed_a_read &&
+				ret == ELEVATOR_NO_MERGE) {
+		int cur_latency = 0;
+		struct request * const cur_request = *req;
+
+		entry = head->next;
+		while (entry != &q->queue_head) {
+			struct request *__rq;
+
+			if (entry == &q->queue_head)
+				BUG();
+			if (entry == q->queue_head.next &&
+					q->head_active && !q->plugged)
+				BUG();
+			__rq = blkdev_entry_to_request(entry);
+
+			if (__rq == cur_request) {
+				/*
+				 * This is where the old algorithm placed it.
+				 * There's no point pushing it further back,
+				 * so leave it here, in sorted order.
+				 */
+				break;
+			}
+			if (__rq->cmd == WRITE) {
+				cur_latency += 1 + __rq->nr_sectors / 64;
+				if (cur_latency >= max_bomb_segments) {
+					*req = __rq;
+					break;
+				}
+			}
+			entry = entry->next;
+		}
+	}
 	return ret;
 }
 
@@ -187,7 +250,7 @@
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
+	output.max_bomb_segments	= elevator->max_bomb_segments;
 
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
@@ -206,9 +269,12 @@
 		return -EINVAL;
 	if (input.write_latency < 0)
 		return -EINVAL;
+	if (input.max_bomb_segments < 0)
+		return -EINVAL;
 
 	elevator->read_latency		= input.read_latency;
 	elevator->write_latency		= input.write_latency;
+	elevator->max_bomb_segments	= input.max_bomb_segments;
 	return 0;
 }
 
diff -urN linux-2.4.20-aa1/drivers/block/ll_rw_blk.c linux-2.4.20-aa1-rl2/drivers/block/ll_rw_blk.c
--- linux-2.4.20-aa1/drivers/block/ll_rw_blk.c	2002-12-05 20:44:02.000000000 +0100
+++ linux-2.4.20-aa1-rl2/drivers/block/ll_rw_blk.c	2002-12-05 20:42:36.000000000 +0100
@@ -183,12 +183,11 @@
 {
 	int count = q->nr_requests;
 
-	count -= __blk_cleanup_queue(&q->rq);
+	count -= __blk_cleanup_queue(&q->rq[READ]);
+	count -= __blk_cleanup_queue(&q->rq[WRITE]);
 
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
-	if (atomic_read(&q->nr_sectors))
-		printk("blk_cleanup_queue: leaked sectors (%d)\n", atomic_read(&q->nr_sectors));
 
 	memset(q, 0, sizeof(*q));
 }
@@ -397,7 +396,7 @@
  *
  * Returns the (new) number of requests which the queue has available.
  */
-int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors)
+int blk_grow_request_list(request_queue_t *q, int nr_requests)
 {
 	unsigned long flags;
 	/* Several broken drivers assume that this function doesn't sleep,
@@ -415,15 +414,13 @@
 		memset(rq, 0, sizeof(*rq));
 		rq->rq_status = RQ_INACTIVE;
 		rw = q->nr_requests & 1;
-		list_add(&rq->queue, &q->rq.free);
-		q->rq.count++;
+		list_add(&rq->queue, &q->rq[rw].free);
+		q->rq[rw].count++;
 		q->nr_requests++;
 	}
-	q->batch_requests = q->nr_requests;
-	q->max_queue_sectors = max_queue_sectors;
-	q->batch_sectors = max_queue_sectors / 2;
-	BUG_ON(!q->batch_sectors);
-	atomic_set(&q->nr_sectors, 0);
+	q->batch_requests = q->nr_requests / 4;
+	if (q->batch_requests > 32)
+		q->batch_requests = 32;
 	spin_unlock_irqrestore(q->queue_lock, flags);
 	return q->nr_requests;
 }
@@ -432,26 +429,25 @@
 {
 	struct sysinfo si;
 	int megs;		/* Total memory, in megabytes */
-	int nr_requests, max_queue_sectors = MAX_QUEUE_SECTORS;
+	int nr_requests;
 
-	INIT_LIST_HEAD(&q->rq.free);
-	q->rq.count = 0;
+	INIT_LIST_HEAD(&q->rq[READ].free);
+	INIT_LIST_HEAD(&q->rq[WRITE].free);
+	q->rq[READ].count = 0;
+	q->rq[WRITE].count = 0;
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = MAX_NR_REQUESTS;
-	if (megs < 30) {
-		nr_requests /= 2;
-		max_queue_sectors /= 2;
-	}
-	/* notice early if anybody screwed the defaults */
-	BUG_ON(!nr_requests);
-	BUG_ON(!max_queue_sectors);
-
-	blk_grow_request_list(q, nr_requests, max_queue_sectors);
+	nr_requests = (megs * 2) & ~15;	/* One per half-megabyte */
+	if (nr_requests < 32)
+		nr_requests = 32;
+	if (nr_requests > 1024)
+		nr_requests = 1024;
+	blk_grow_request_list(q, nr_requests);
 
-	init_waitqueue_head(&q->wait_for_requests);
+	init_waitqueue_head(&q->wait_for_requests[0]);
+	init_waitqueue_head(&q->wait_for_requests[1]);
 }
 
 static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
@@ -520,16 +516,11 @@
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static struct request * FASTCALL(get_request(request_queue_t *q, int rw));
 static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl;
-
-	if (blk_oversized_queue(q))
-		goto out;
+	struct request_list *rl = q->rq + rw;
 
-	rl = &q->rq;
 	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
@@ -540,7 +531,6 @@
 		rq->q = q;
 	}
 
- out:
 	return rq;
 }
 
@@ -608,10 +598,10 @@
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq.count == 0 || blk_oversized_queue(q)) {
+		if (q->rq[rw].count == 0) {
 			/*
 			 * All we care about is not to stall if any request
 			 * is been released after we set TASK_UNINTERRUPTIBLE.
@@ -626,7 +616,7 @@
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
 	} while (rq == NULL);
-	remove_wait_queue(&q->wait_for_requests, &wait);
+	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
 	return rq;
 }
@@ -638,8 +628,8 @@
 	 * generic_unplug_device while our __get_request_wait was running
 	 * w/o the queue_lock held and w/ our request out of the queue.
 	 */
-	if (waitqueue_active(&q->wait_for_requests))
-		wake_up(&q->wait_for_requests);
+	if (waitqueue_active(&q->wait_for_requests[rw]))
+		wake_up(&q->wait_for_requests[rw]);
 }
 
 /* RO fail safe mechanism */
@@ -855,6 +845,7 @@
 void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
+	int rw = req->cmd;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
@@ -864,11 +855,11 @@
 	 * assume it has free buffers and check waiters
 	 */
 	if (q) {
-		list_add(&req->queue, &q->rq.free);
-		if (++q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
+		list_add(&req->queue, &q->rq[rw].free);
+		if (++q->rq[rw].count >= q->batch_requests) {
 			smp_mb();
-			if (waitqueue_active(&q->wait_for_requests))
-				wake_up(&q->wait_for_requests);
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
 		}
 	}
 }
@@ -1014,7 +1005,7 @@
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(req, count);
+			blk_started_io(count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_back_merge(q, req, max_sectors, max_segments);
@@ -1036,7 +1027,7 @@
 			req->current_nr_sectors = req->hard_cur_sectors = count;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(req, count);
+			blk_started_io(count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
@@ -1069,7 +1060,7 @@
 		 * See description above __get_request_wait()
 		 */
 		if (rw_ahead) {
-			if (q->rq.count < q->batch_requests || blk_oversized_queue_batch(q)) {
+			if (q->rq[rw].count < q->batch_requests) {
 				spin_unlock_irq(q->queue_lock);
 				goto end_io;
 			}
@@ -1105,7 +1096,7 @@
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
-	blk_started_io(req, count);
+	blk_started_io(count);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -1398,7 +1389,7 @@
 
 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
-		blk_finished_io(req, nsect);
+		blk_finished_io(nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);
diff -urN linux-2.4.20-aa1/drivers/scsi/scsi_lib.c linux-2.4.20-aa1-rl2/drivers/scsi/scsi_lib.c
--- linux-2.4.20-aa1/drivers/scsi/scsi_lib.c	2002-12-05 20:44:03.000000000 +0100
+++ linux-2.4.20-aa1-rl2/drivers/scsi/scsi_lib.c	2002-12-05 20:41:09.000000000 +0100
@@ -384,7 +384,7 @@
 	do {
 		if ((bh = req->bh) != NULL) {
 			nsect = bh->b_size >> 9;
-			blk_finished_io(req, nsect);
+			blk_finished_io(nsect);
 			req->bh = bh->b_reqnext;
 			bh->b_reqnext = NULL;
 			sectors -= nsect;
diff -urN linux-2.4.20-aa1/include/linux/blkdev.h linux-2.4.20-aa1-rl2/include/linux/blkdev.h
--- linux-2.4.20-aa1/include/linux/blkdev.h	2002-12-05 20:44:04.000000000 +0100
+++ linux-2.4.20-aa1-rl2/include/linux/blkdev.h	2002-12-05 20:41:09.000000000 +0100
@@ -80,7 +80,7 @@
 	/*
 	 * the queue request freelist, one for reads and one for writes
 	 */
-	struct request_list	rq;
+	struct request_list	rq[2];
 
 	/*
 	 * The total number of requests on each queue
@@ -93,21 +93,6 @@
 	int batch_requests;
 
 	/*
-	 * The total number of 512byte blocks on each queue
-	 */
-	atomic_t nr_sectors;
-
-	/*
-	 * Batching threshold for sleep/wakeup decisions
-	 */
-	int batch_sectors;
-
-	/*
-	 * The max number of 512byte blocks on each queue
-	 */
-	int max_queue_sectors;
-
-	/*
 	 * Together with queue_head for cacheline sharing
 	 */
 	struct list_head	queue_head;
@@ -152,7 +137,7 @@
 	/*
 	 * Tasks wait here for free read and write requests
 	 */
-	wait_queue_head_t	wait_for_requests;
+	wait_queue_head_t	wait_for_requests[2];
 };
 
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
@@ -220,7 +205,7 @@
 /*
  * Access functions for manipulating queue properties
  */
-extern int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors);
+extern int blk_grow_request_list(request_queue_t *q, int nr_requests);
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
@@ -244,8 +229,6 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
-#define MAX_QUEUE_SECTORS (2 << (20 - 9)) /* 2 mbytes when full sized */
-#define MAX_NR_REQUESTS (MAX_QUEUE_SECTORS >> (10 - 9)) /* 1mbyte queue when all requests are 1k */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
 
@@ -272,40 +255,8 @@
 	return retval;
 }
 
-static inline int blk_oversized_queue(request_queue_t * q)
-{
-	return atomic_read(&q->nr_sectors) > q->max_queue_sectors;
-}
-
-static inline int blk_oversized_queue_batch(request_queue_t * q)
-{
-	return atomic_read(&q->nr_sectors) > q->max_queue_sectors - q->batch_sectors;
-}
-
-static inline void blk_started_io(struct request * req, int nsects)
-{
-	request_queue_t * q = req->q;
-
-	if (q)
-		atomic_add(nsects, &q->nr_sectors);
-	BUG_ON(atomic_read(&q->nr_sectors) < 0);
-}
-
-static inline void blk_finished_io(struct request * req, int nsects)
-{
-	request_queue_t * q = req->q;
-
-	/* special requests belongs to a null queue */
-	if (q) {
-		atomic_sub(nsects, &q->nr_sectors);
-		if (q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
-			smp_mb();
-			if (waitqueue_active(&q->wait_for_requests))
-				wake_up(&q->wait_for_requests);
-		}
-	}
-	BUG_ON(atomic_read(&q->nr_sectors) < 0);
-}
+#define blk_finished_io(nsects)	do { } while (0)
+#define blk_started_io(nsects)	do { } while (0)
 
 static inline unsigned int blksize_bits(unsigned int size)
 {
diff -urN linux-2.4.20-aa1/include/linux/elevator.h linux-2.4.20-aa1-rl2/include/linux/elevator.h
--- linux-2.4.20-aa1/include/linux/elevator.h	2002-12-05 20:44:04.000000000 +0100
+++ linux-2.4.20-aa1-rl2/include/linux/elevator.h	2002-12-05 20:42:36.000000000 +0100
@@ -1,12 +1,9 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
-typedef void (elevator_fn) (struct request *, elevator_t *,
-			    struct list_head *,
-			    struct list_head *, int);
-
-typedef int (elevator_merge_fn) (request_queue_t *, struct request **, struct list_head *,
-				 struct buffer_head *, int, int);
+typedef int (elevator_merge_fn)(request_queue_t *, struct request **,
+				struct list_head *, struct buffer_head *bh,
+				int rw, int max_sectors);
 
 typedef void (elevator_merge_cleanup_fn) (request_queue_t *, struct request *, int);
 
@@ -16,6 +13,7 @@
 {
 	int read_latency;
 	int write_latency;
+	int max_bomb_segments;
 
 	elevator_merge_fn *elevator_merge_fn;
 	elevator_merge_req_fn *elevator_merge_req_fn;
@@ -23,13 +21,13 @@
 	unsigned int queue_ID;
 };
 
-int elevator_noop_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_noop_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_noop_merge_req(struct request *, struct request *);
-
-int elevator_linus_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
-void elevator_linus_merge_cleanup(request_queue_t *, struct request *, int);
-void elevator_linus_merge_req(struct request *, struct request *);
+elevator_merge_fn		elevator_noop_merge;
+elevator_merge_cleanup_fn	elevator_noop_merge_cleanup;
+elevator_merge_req_fn		elevator_noop_merge_req;
+
+elevator_merge_fn		elevator_linus_merge;
+elevator_merge_cleanup_fn	elevator_linus_merge_cleanup;
+elevator_merge_req_fn		elevator_linus_merge_req;
 
 typedef struct blkelv_ioctl_arg_s {
 	int queue_ID;
@@ -53,22 +51,6 @@
 #define ELEVATOR_FRONT_MERGE	1
 #define ELEVATOR_BACK_MERGE	2
 
-/*
- * This is used in the elevator algorithm.  We don't prioritise reads
- * over writes any more --- although reads are more time-critical than
- * writes, by treating them equally we increase filesystem throughput.
- * This turns out to give better overall performance.  -- sct
- */
-#define IN_ORDER(s1,s2)				\
-	((((s1)->rq_dev == (s2)->rq_dev &&	\
-	   (s1)->sector < (s2)->sector)) ||	\
-	 (s1)->rq_dev < (s2)->rq_dev)
-
-#define BHRQ_IN_ORDER(bh, rq)			\
-	((((bh)->b_rdev == (rq)->rq_dev &&	\
-	   (bh)->b_rsector < (rq)->sector)) ||	\
-	 (bh)->b_rdev < (rq)->rq_dev)
-
 static inline int elevator_request_latency(elevator_t * elevator, int rw)
 {
 	int latency;
@@ -80,22 +62,22 @@
 	return latency;
 }
 
-#define ELV_LINUS_SEEK_COST	1
+#define ELV_LINUS_SEEK_COST	16
 
 #define ELEVATOR_NOOP							\
 ((elevator_t) {								\
 	0,				/* read_latency */		\
 	0,				/* write_latency */		\
-									\
+	0,				/* max_bomb_segments */		\
 	elevator_noop_merge,		/* elevator_merge_fn */		\
 	elevator_noop_merge_req,	/* elevator_merge_req_fn */	\
 	})
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	128,				/* read passovers */		\
-	512,				/* write passovers */		\
-									\
+	2048,				/* read passovers */		\
+	8192,				/* write passovers */		\
++ 	6,				/* max_bomb_segments */		\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
 	})
diff -urN linux-2.4.20-aa1/include/linux/nbd.h linux-2.4.20-aa1-rl2/include/linux/nbd.h
--- linux-2.4.20-aa1/include/linux/nbd.h	2002-12-05 20:44:04.000000000 +0100
+++ linux-2.4.20-aa1-rl2/include/linux/nbd.h	2002-12-05 20:41:09.000000000 +0100
@@ -48,7 +48,7 @@
 	spin_lock_irqsave(&io_request_lock, flags);
 	while((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
-		blk_finished_io(req, nsect);
+		blk_finished_io(nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);

--------------Boundary-00=_YDWNDV4DL6I2N2526MV2--

