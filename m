Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129986AbRBVVhY>; Thu, 22 Feb 2001 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbRBVVhQ>; Thu, 22 Feb 2001 16:37:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23330 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129986AbRBVVhI>; Thu, 22 Feb 2001 16:37:08 -0500
Date: Thu, 22 Feb 2001 22:38:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010222223811.A29372@athlon.random>
In-Reply-To: <20010222145642.D17276@suse.de> <Pine.LNX.4.10.10102221052000.8403-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102221052000.8403-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 22, 2001 at 10:59:20AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 10:59:20AM -0800, Linus Torvalds wrote:
> I'd prefer for this check to be a per-queue one.

I'm running this in my tree since a few weeks, however I never had the courage
to post it publically because I didn't benchmarked it carefully yet and I
prefer to finish another thing first. This is actually based on the code I had
in my blkdev tree after I merged last time with Jens the 512K I/O requests and
elevator fixes. I think it won't generate bad numbers and it was running fine
on a 32way SMP (though I didn't stressed the I/O subsystem much there) but
please don't include until somebody benchmarks it carefully with dbench and
tiotest.  (it still applys cleanly against 2.4.2)

diff -urN 2.4.2pre3/drivers/block/DAC960.c x/drivers/block/DAC960.c
--- 2.4.2pre3/drivers/block/DAC960.c	Fri Feb  9 18:35:16 2001
+++ x/drivers/block/DAC960.c	Fri Feb  9 19:00:58 2001
@@ -2827,7 +2827,6 @@
 static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
 						 boolean SuccessfulIO)
 {
-  blk_finished_io(BufferHeader->b_size >> 9);
   BufferHeader->b_end_io(BufferHeader, SuccessfulIO);
 }
 
diff -urN 2.4.2pre3/drivers/block/cciss.c x/drivers/block/cciss.c
--- 2.4.2pre3/drivers/block/cciss.c	Fri Feb  9 18:35:17 2001
+++ x/drivers/block/cciss.c	Fri Feb  9 19:00:59 2001
@@ -1072,7 +1072,6 @@
 	{
 		xbh = bh->b_reqnext; 
 		bh->b_reqnext = NULL; 
-		blk_finished_io(bh->b_size >> 9);
 		bh->b_end_io(bh, status);
 		bh = xbh;
 	}
diff -urN 2.4.2pre3/drivers/block/cpqarray.c x/drivers/block/cpqarray.c
--- 2.4.2pre3/drivers/block/cpqarray.c	Fri Feb  9 18:35:17 2001
+++ x/drivers/block/cpqarray.c	Fri Feb  9 19:00:59 2001
@@ -1031,7 +1031,6 @@
 		xbh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		
-		blk_finished_io(bh->b_size >> 9);
 		bh->b_end_io(bh, ok);
 
 		bh = xbh;
diff -urN 2.4.2pre3/drivers/block/ll_rw_blk.c x/drivers/block/ll_rw_blk.c
--- 2.4.2pre3/drivers/block/ll_rw_blk.c	Fri Feb  9 18:35:17 2001
+++ x/drivers/block/ll_rw_blk.c	Fri Feb  9 19:06:11 2001
@@ -118,17 +118,10 @@
 int * max_sectors[MAX_BLKDEV];
 
 /*
- * queued sectors for all devices, used to make sure we don't fill all
- * of memory with locked buffers
- */
-atomic_t queued_sectors;
-
-/*
  * high and low watermark for above
  */
-static int high_queued_sectors, low_queued_sectors;
+int max_in_flight_sectors;
 static int batch_requests, queue_nr_requests;
-static DECLARE_WAIT_QUEUE_HEAD(blk_buffers_wait);
 
 static inline int get_max_sectors(kdev_t dev)
 {
@@ -397,11 +390,17 @@
 		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
 		memset(rq, 0, sizeof(struct request));
 		rq->rq_status = RQ_INACTIVE;
-		list_add(&rq->table, &q->request_freelist[i & 1]);
+		list_add(&rq->table, &q->request_freelist[i < (queue_nr_requests >> 1) ? READ : WRITE]);
 	}
 
-	init_waitqueue_head(&q->wait_for_request);
+	init_waitqueue_head(&q->wait_for_request[READ]);
+	init_waitqueue_head(&q->wait_for_request[WRITE]);
+
+	init_waitqueue_head(&q->in_flight_wait);
+	q->in_flight_sectors = 0;
+#if 0
 	spin_lock_init(&q->queue_lock);
+#endif
 }
 
 static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
@@ -491,9 +490,9 @@
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue_exclusive(&q->wait_for_request, &wait);
+	add_wait_queue_exclusive(&q->wait_for_request[rw], &wait);
 	for (;;) {
-		__set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
@@ -502,8 +501,8 @@
 		generic_unplug_device(q);
 		schedule();
 	}
-	remove_wait_queue(&q->wait_for_request, &wait);
-	current->state = TASK_RUNNING;
+	remove_wait_queue(&q->wait_for_request[rw], &wait);
+	__set_current_state(TASK_RUNNING);
 	return rq;
 }
 
@@ -590,12 +589,26 @@
 	list_add(&req->queue, insert_here);
 }
 
-void inline blk_refill_freelist(request_queue_t *q, int rw)
+static inline void blk_refill_freelist(request_queue_t *q, int rw)
 {
-	if (q->pending_free[rw]) {
-		list_splice(&q->pending_freelist[rw], &q->request_freelist[rw]);
-		INIT_LIST_HEAD(&q->pending_freelist[rw]);
-		q->pending_free[rw] = 0;
+	list_splice(&q->pending_freelist[rw], &q->request_freelist[rw]);
+	INIT_LIST_HEAD(&q->pending_freelist[rw]);
+	q->pending_free[rw] = 0;
+}
+
+static inline void blk_finished_io(request_queue_t * q, struct request * req)
+{
+	int nsects  = req->in_flight_sectors;
+
+	req->in_flight_sectors = 0;
+	q->in_flight_sectors -= nsects;
+	if (q->in_flight_sectors < 0) {
+		printk("blkdev: in_flight_sectors < 0\n");
+		q->in_flight_sectors = 0;
+	}
+	if (waitqueue_active(&q->in_flight_wait) &&
+	    q->in_flight_sectors < max_in_flight_sectors) {
+		wake_up(&(q)->in_flight_wait);
 	}
 }
 
@@ -612,26 +625,27 @@
 
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
-	 * asumme it has free buffers and check waiters
+	 * assumme it has free buffers and check waiters
 	 */
 	if (q) {
-		/*
-		 * we've released enough buffers to start I/O again
-		 */
-		if (waitqueue_active(&blk_buffers_wait)
-		    && atomic_read(&queued_sectors) < low_queued_sectors)
-			wake_up(&blk_buffers_wait);
-
-		/*
-		 * Add to pending free list and batch wakeups
-		 */
-		list_add(&req->table, &q->pending_freelist[rw]);
-
-		if (++q->pending_free[rw] >= batch_requests) {
-			int wake_up = q->pending_free[rw];
-			blk_refill_freelist(q, rw);
-			wake_up_nr(&q->wait_for_request, wake_up);
+		if (!list_empty(&q->request_freelist[rw])) {
+			if (q->pending_free[rw])
+				BUG();
+			list_add(&req->table, &q->request_freelist[rw]);
+			wake_up(&q->wait_for_request[rw]);
+		} else 	{
+			/*
+			 * Add to pending free list and batch wakeups
+			 */
+			list_add(&req->table, &q->pending_freelist[rw]);
+			if (++q->pending_free[rw] >= batch_requests) {
+				int wake_up = q->pending_free[rw];
+				blk_refill_freelist(q, rw);
+				wake_up_nr(&q->wait_for_request[rw], wake_up);
+			}
 		}
+
+		blk_finished_io(q, req);
 	}
 }
 
@@ -694,6 +708,12 @@
 	attempt_merge(q, blkdev_entry_to_request(prev), max_sectors, max_segments);
 }
 
+#define blk_started_io(q, req, nsects)		\
+do {						\
+	(q)->in_flight_sectors += (nsects);	\
+	(req)->in_flight_sectors += (nsects);	\
+} while(0)
+
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
@@ -753,6 +773,27 @@
 	 */
 	spin_lock_irq(&io_request_lock);
 
+	/*
+	 * don't lock any more buffers if we are above the max
+	 * water mark. instead start I/O on the queued stuff.
+	 */
+	if (q->in_flight_sectors >= max_in_flight_sectors) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		add_wait_queue(&q->in_flight_wait, &wait);
+		for (;;) {
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			__generic_unplug_device(q);
+			spin_unlock_irq(&io_request_lock);
+			schedule();
+			spin_lock_irq(&io_request_lock);
+			if (q->in_flight_sectors < max_in_flight_sectors)
+				break;
+		}
+		remove_wait_queue(&q->in_flight_wait, &wait);
+		__set_current_state(TASK_RUNNING);
+	}
+
 	insert_here = head->prev;
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
@@ -771,7 +812,7 @@
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(count);
+			blk_started_io(q, req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			attempt_back_merge(q, req, max_sectors, max_segments);
 			goto out;
@@ -786,7 +827,7 @@
 			req->current_nr_sectors = count;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(count);
+			blk_started_io(q, req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
 			goto out;
@@ -841,7 +882,7 @@
 	req->bh = bh;
 	req->bhtail = bh;
 	req->rq_dev = bh->b_rdev;
-	blk_started_io(count);
+	blk_started_io(q, req, count);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -1059,16 +1100,6 @@
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
 
-		/*
-		 * don't lock any more buffers if we are above the high
-		 * water mark. instead start I/O on the queued stuff.
-		 */
-		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
-			run_task_queue(&tq_disk);
-			wait_event(blk_buffers_wait,
-			 atomic_read(&queued_sectors) < low_queued_sectors);
-		}
-
 		/* Only one thread can actually submit the I/O. */
 		if (test_and_set_bit(BH_Lock, &bh->b_state))
 			continue;
@@ -1143,7 +1174,6 @@
 
 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
-		blk_finished_io(nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);
@@ -1173,8 +1203,6 @@
 	blkdev_release_request(req);
 }
 
-#define MB(kb)	((kb) << 10)
-
 int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
@@ -1194,30 +1222,19 @@
 	memset(max_readahead, 0, sizeof(max_readahead));
 	memset(max_sectors, 0, sizeof(max_sectors));
 
-	atomic_set(&queued_sectors, 0);
 	total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 
-	/*
-	 * Try to keep 128MB max hysteris. If not possible,
-	 * use half of RAM
-	 */
-	high_queued_sectors = (total_ram * 2) / 3;
-	low_queued_sectors = high_queued_sectors / 3;
-	if (high_queued_sectors - low_queued_sectors > MB(128))
-		low_queued_sectors = high_queued_sectors - MB(128);
-
+	max_in_flight_sectors = total_ram / 3;
 
 	/*
 	 * make it sectors (512b)
 	 */
-	high_queued_sectors <<= 1;
-	low_queued_sectors <<= 1;
+	max_in_flight_sectors <<= 1;
 
 	/*
 	 * Scale free request slots per queue too
 	 */
-	total_ram = (total_ram + MB(32) - 1) & ~(MB(32) - 1);
-	if ((queue_nr_requests = total_ram >> 9) > QUEUE_NR_REQUESTS)
+	if ((queue_nr_requests = total_ram >> 5) > QUEUE_NR_REQUESTS)
 		queue_nr_requests = QUEUE_NR_REQUESTS;
 
 	/*
@@ -1225,11 +1242,12 @@
 	 */
 	if ((batch_requests = queue_nr_requests >> 3) > 32)
 		batch_requests = 32;
+	if (!batch_requests)
+		batch_requests = 1;
 
-	printk("block: queued sectors max/low %dkB/%dkB, %d slots per queue\n",
-						high_queued_sectors / 2,
-						low_queued_sectors / 2,
-						queue_nr_requests);
+	printk("block: queued sectors max %dkB, %d slots per queue, %d batch\n",
+						max_in_flight_sectors / 2,
+						queue_nr_requests, batch_requests);
 
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
@@ -1350,4 +1368,3 @@
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
-EXPORT_SYMBOL(queued_sectors);
diff -urN 2.4.2pre3/drivers/scsi/scsi_lib.c x/drivers/scsi/scsi_lib.c
--- 2.4.2pre3/drivers/scsi/scsi_lib.c	Fri Feb  9 18:35:34 2001
+++ x/drivers/scsi/scsi_lib.c	Fri Feb  9 19:00:59 2001
@@ -375,7 +375,6 @@
 	do {
 		if ((bh = req->bh) != NULL) {
 			nsect = bh->b_size >> 9;
-			blk_finished_io(nsect);
 			req->bh = bh->b_reqnext;
 			req->nr_sectors -= nsect;
 			req->sector += nsect;
diff -urN 2.4.2pre3/fs/buffer.c x/fs/buffer.c
--- 2.4.2pre3/fs/buffer.c	Fri Feb  9 18:35:44 2001
+++ x/fs/buffer.c	Fri Feb  9 19:00:59 2001
@@ -628,7 +628,7 @@
    to do in order to release the ramdisk memory is to destroy dirty buffers.
 
    These are two special cases. Normal usage imply the device driver
-   to issue a sync on the device (without waiting I/O completation) and
+   to issue a sync on the device (without waiting I/O completion) and
    then an invalidate_buffers call that doesn't trash dirty buffers. */
 void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers)
 {
@@ -1027,12 +1027,13 @@
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
 	refill_freelist(size);
+	/* FIXME: getblk should fail if there's no enough memory */
 	goto repeat;
 }
 
 /* -1 -> no need to flush
     0 -> async flush
-    1 -> sync flush (wait for I/O completation) */
+    1 -> sync flush (wait for I/O completion) */
 int balance_dirty_state(kdev_t dev)
 {
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
@@ -1431,6 +1432,7 @@
 {
 	struct buffer_head *bh, *head, *tail;
 
+	/* FIXME: create_buffers should fail if there's no enough memory */
 	head = create_buffers(page, blocksize, 1);
 	if (page->buffers)
 		BUG();
@@ -2367,11 +2369,9 @@
 	spin_lock(&free_list[index].lock);
 	tmp = bh;
 	do {
-		struct buffer_head *p = tmp;
-
-		tmp = tmp->b_this_page;
-		if (buffer_busy(p))
+		if (buffer_busy(tmp))
 			goto busy_buffer_page;
+		tmp = tmp->b_this_page;
 	} while (tmp != bh);
 
 	spin_lock(&unused_list_lock);
diff -urN 2.4.2pre3/include/linux/blkdev.h x/include/linux/blkdev.h
--- 2.4.2pre3/include/linux/blkdev.h	Fri Feb  9 18:34:13 2001
+++ x/include/linux/blkdev.h	Fri Feb  9 21:28:15 2001
@@ -35,7 +35,7 @@
 	int errors;
 	unsigned long sector;
 	unsigned long nr_sectors;
-	unsigned long hard_sector, hard_nr_sectors;
+	unsigned long hard_sector, hard_nr_sectors, in_flight_sectors;
 	unsigned int nr_segments;
 	unsigned int nr_hw_segments;
 	unsigned long current_nr_sectors;
@@ -77,6 +77,7 @@
 	struct list_head	request_freelist[2];
 	struct list_head	pending_freelist[2];
 	int			pending_free[2];
+	int			in_flight_sectors;
 
 	/*
 	 * Together with queue_head for cacheline sharing
@@ -112,16 +113,20 @@
 	 */
 	char			head_active;
 
+	wait_queue_head_t	in_flight_wait;
+
 	/*
-	 * Is meant to protect the queue in the future instead of
-	 * io_request_lock
+	 * Tasks wait here for free request
 	 */
-	spinlock_t		queue_lock;
+	wait_queue_head_t	wait_for_request[2];
 
+#if 0
 	/*
-	 * Tasks wait here for free request
+	 * Is meant to protect the queue in the future instead of
+	 * io_request_lock
 	 */
-	wait_queue_head_t	wait_for_request;
+	spinlock_t		queue_lock;
+#endif
 };
 
 struct blk_dev_struct {
@@ -177,7 +182,7 @@
 
 extern int * max_segments[MAX_BLKDEV];
 
-extern atomic_t queued_sectors;
+extern int max_in_flight_sectors;
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS (MAX_SEGMENTS*8)
@@ -205,15 +210,5 @@
 	else
 		return 512;
 }
-
-#define blk_finished_io(nsects)				\
-	atomic_sub(nsects, &queued_sectors);		\
-	if (atomic_read(&queued_sectors) < 0) {		\
-		printk("block: queued_sectors < 0\n");	\
-		atomic_set(&queued_sectors, 0);		\
-	}
-
-#define blk_started_io(nsects)				\
-	atomic_add(nsects, &queued_sectors);
 
 #endif

Andrea
