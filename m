Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285255AbRLFWoD>; Thu, 6 Dec 2001 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285276AbRLFWoA>; Thu, 6 Dec 2001 17:44:00 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:34275 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285269AbRLFWlr>; Thu, 6 Dec 2001 17:41:47 -0500
Date: Thu, 6 Dec 2001 14:36:49 -0800
From: Jonathan Lahr <lahr@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: [PATCH] 2.4.16:  SCSI concurrent queueing
Message-ID: <20011206143649.F8118@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All,

Included is the latest SCSI io_request_lock patch, siorl-v1.2416.  
It can also be downloaded from http://sourceforge.net/projects/lse/.  
This version further reduces code impact, further separates SCSI i/o from 
generic block i/o functions, and fixes some bugs.  Thanks to Jens for 
comments on the previous patch.

In scsi_make_request, I removed references to ll_*merge*_fn, since 
initialize_merge_fn sets SCSI merge functions.  I also removed head_active 
code, since SCSI always operates with head_active == 0.

Unlike previous iorl patches, this patch releases locks before calling 
scsi_dispatch_cmd, so baseline scsi_dispatch_cmd remains unchanged.

I also fixed some queue locking problems siorl-v0 had introduced into 
scsi_queue_next_request.

To summarize, this patch does the following:

  - Creates scsi_plug_device, scsi_unplug_device, scsi_get_request, 
    scsi_make_request, and scsi_init_queue based on the generic versions
    modified for concurrent queueing

  - Modifies scsi_request_fn, scsi_unplug_device, scsi_get_request_wait, 
    __scsi_insert_special, and scsi_queue_next_request for concurrent queueing 

  - Adds concurrent queue field to request_queue and Scsi_Host_Template 

  - Creates rq_lock macros to conditionally switch locking schemes

  - Exports batch_requests, get_max_sectors, blk_init_free_list, 
    attempt_back_merge, and attempt_front_merge symbols for use by SCSI code

  - Moves blkdev_free_rq definition to blkdev.h so SCSI functions can use it

I have tested this with aic7xxx, lpfc, and IDE disks and CDROM.

Comments, testing results, performance measurements?

Jonathan

--
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

---------------------- siorl-v1.2416 patch ----------------------

--- linux.base/include/linux/blkdev.h	Mon Nov 26 05:29:17 2001
+++ linux.mod/include/linux/blkdev.h	Fri Nov 30 12:27:39 2001
@@ -122,6 +122,8 @@
 	 * Tasks wait here for free request
 	 */
 	wait_queue_head_t	wait_for_request;
+
+	unsigned concurrent:1;
 };
 
 struct blk_dev_struct {
@@ -185,6 +187,7 @@
 #define blkdev_entry_prev_request(entry) blkdev_entry_to_request((entry)->prev)
 #define blkdev_next_request(req) blkdev_entry_to_request((req)->queue.next)
 #define blkdev_prev_request(req) blkdev_entry_to_request((req)->queue.prev)
+#define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
 
 extern void drive_stat_acct (kdev_t dev, int rw,
 					unsigned long nr_sectors, int new_io);
@@ -204,6 +207,20 @@
 
 #define blk_finished_io(nsects)	do { } while (0)
 #define blk_started_io(nsects)	do { } while (0)
+
+#define xrq_lock_irq(q)						\
+	{if (q->concurrent) spin_lock_irq(&q->queue_lock);	\
+		else spin_lock_irq(&io_request_lock);}
+
+#define xrq_unlock_irq(q)					\
+	{if (q->concurrent) spin_unlock_irq(&q->queue_lock);	\
+		else spin_unlock_irq(&io_request_lock);}
+
+#define rq_lock(q)						\
+	{if (q->concurrent) spin_lock(&q->queue_lock);}
+
+#define rq_unlock(q)						\
+	{if (q->concurrent) spin_unlock(&q->queue_lock);}
 
 static inline unsigned int blksize_bits(unsigned int size)
 {
--- linux.base/drivers/block/ll_rw_blk.c	Mon Oct 29 12:11:17 2001
+++ linux.mod/drivers/block/ll_rw_blk.c	Fri Nov 30 12:09:33 2001
@@ -121,9 +121,10 @@
  * How many reqeusts do we allocate per queue,
  * and how many do we "batch" on freeing them?
  */
-static int queue_nr_requests, batch_requests;
+static int queue_nr_requests;
+int batch_requests;
 
-static inline int get_max_sectors(kdev_t dev)
+inline int get_max_sectors(kdev_t dev)
 {
 	if (!max_sectors[MAJOR(dev)])
 		return MAX_SECTORS;
@@ -326,7 +327,7 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
-static void blk_init_free_list(request_queue_t *q)
+void blk_init_free_list(request_queue_t *q)
 {
 	struct request *rq;
 	int i;
@@ -415,7 +416,6 @@
 	q->head_active    	= 1;
 }
 
-#define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
 /*
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.
@@ -600,7 +600,7 @@
 	blkdev_release_request(next);
 }
 
-static inline void attempt_back_merge(request_queue_t * q,
+inline void attempt_back_merge(request_queue_t * q,
 				      struct request *req,
 				      int max_sectors,
 				      int max_segments)
@@ -610,7 +610,7 @@
 	attempt_merge(q, req, max_sectors, max_segments);
 }
 
-static inline void attempt_front_merge(request_queue_t * q,
+inline void attempt_front_merge(request_queue_t * q,
 				       struct list_head * head,
 				       struct request *req,
 				       int max_sectors,
--- linux.base/drivers/scsi/hosts.h	Thu Nov 22 11:49:15 2001
+++ linux.mod/drivers/scsi/hosts.h	Fri Nov 30 12:29:24 2001
@@ -296,6 +296,8 @@
      */
     char *proc_name;
 
+    unsigned concurrent_queue:1;
+
 } Scsi_Host_Template;
 
 /*
--- linux.base/drivers/scsi/scsi.c	Fri Nov  9 14:05:06 2001
+++ linux.mod/drivers/scsi/scsi.c	Fri Nov 30 12:11:38 2001
@@ -187,8 +187,7 @@
  *              to do the dirty deed.
  */
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt) {
-	blk_init_queue(&SDpnt->request_queue, scsi_request_fn);
-        blk_queue_headactive(&SDpnt->request_queue, 0);
+	scsi_init_queue(&SDpnt->request_queue, SHpnt->hostt->concurrent_queue);
         SDpnt->request_queue.queuedata = (void *) SDpnt;
 }
 
--- linux.base/drivers/scsi/scsi_lib.c	Fri Oct 12 15:35:54 2001
+++ linux.mod/drivers/scsi/scsi_lib.c	Fri Nov 30 16:48:25 2001
@@ -84,14 +84,16 @@
 	 * head of the queue for things like a QUEUE_FULL message from a
 	 * device, or a host that is unable to accept a particular command.
 	 */
-	spin_lock_irqsave(&io_request_lock, flags);
 
+	spin_lock_irqsave(&io_request_lock, flags);
+	rq_lock(q);
 	if (at_head)
 		list_add(&rq->queue, &q->queue_head);
 	else
 		list_add_tail(&rq->queue, &q->queue_head);
 
 	q->request_fn(q);
+	rq_unlock(q);
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
@@ -262,13 +264,17 @@
 		 * the bad sector.
 		 */
 		SCpnt->request.special = (void *) SCpnt;
+		rq_lock(q);
 		list_add(&SCpnt->request.queue, &q->queue_head);
+		rq_unlock(q);
 	}
 
 	/*
 	 * Just hit the requeue function for the queue.
 	 */
+	rq_lock(q);
 	q->request_fn(q);
+	rq_unlock(q);
 
 	SDpnt = (Scsi_Device *) q->queuedata;
 	SHpnt = SDpnt->host;
@@ -296,7 +302,9 @@
 				break;
 			}
 			q = &SDpnt->request_queue;
+			rq_lock(q);
 			q->request_fn(q);
+			rq_unlock(q);
 		}
 	}
 
@@ -321,7 +329,9 @@
 				continue;
 			}
 			q = &SDpnt->request_queue;
+			rq_lock(q);
 			q->request_fn(q);
+			rq_unlock(q);
 			all_clear = 0;
 		}
 		if (SDpnt == NULL && all_clear) {
@@ -818,6 +828,236 @@
 	return NULL;
 }
 
+extern int batch_requests;
+extern int get_max_sectors(kdev_t);
+extern void attempt_back_merge(request_queue_t *, struct request *, int, int);
+extern void attempt_front_merge(request_queue_t *, struct list_head *,
+				struct request *, int, int);
+
+static void scsi_plug_device(request_queue_t *q, kdev_t dev)
+{
+	/*
+	 * no need to replug device
+	 */
+	if (!list_empty(&q->queue_head) || q->plugged)
+		return;
+
+	q->plugged = 1;
+	queue_task(&q->plug_tq, &tq_disk);
+}
+
+static void scsi_unplug_device(void *data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	rq_lock(q);
+	if (q->plugged) {
+		q->plugged = 0;
+		if (!list_empty(&q->queue_head))
+			q->request_fn(q);
+	}
+	rq_unlock(q);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
+static inline struct request *scsi_get_request(request_queue_t *q, int rw)
+{
+	struct request *rq = NULL;
+	struct request_list *rl = q->rq + rw;
+
+	if (!list_empty(&rl->free)) {
+		rq = blkdev_free_rq(&rl->free);
+		list_del(&rq->queue);
+		rl->count--;
+		rq->rq_status = RQ_ACTIVE;
+		rq->special = NULL;
+		rq->q = q;
+	}
+
+	return rq;
+}
+
+static struct request *scsi_get_request_wait(request_queue_t *q, int rw)
+{
+	register struct request *rq;
+	DECLARE_WAITQUEUE(wait, current);
+
+	scsi_unplug_device(q);
+	add_wait_queue(&q->wait_for_request, &wait);
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (q->rq[rw].count < batch_requests)
+			schedule();
+		xrq_lock_irq(q);
+		rq = scsi_get_request(q, rw);
+		xrq_unlock_irq(q);
+	} while (rq == NULL);
+	remove_wait_queue(&q->wait_for_request, &wait);
+	current->state = TASK_RUNNING;
+	return rq;
+}
+
+static int scsi_make_request(request_queue_t * q, int rw, 
+				struct buffer_head * bh)
+{
+	unsigned int sector, count;
+	int max_segments = MAX_SEGMENTS;
+	struct request * req, *freereq = NULL;
+	int rw_ahead, max_sectors, el_ret;
+	struct list_head *head, *insert_here;
+	int latency;
+	elevator_t *elevator = &q->elevator;
+
+	count = bh->b_size >> 9;
+	sector = bh->b_rsector;
+
+	rw_ahead = 0;	/* normal case; gets changed below for READA */
+	switch (rw) {
+		case READA:
+			rw_ahead = 1;
+			rw = READ;	/* drop into READ */
+		case READ:
+		case WRITE:
+			latency = elevator_request_latency(elevator, rw);
+			break;
+		default:
+			BUG();
+			goto end_io;
+	}
+
+	/* We'd better have a real physical mapping!
+	   Check this bit only if the buffer was dirty and just locked
+	   down by us so at this point flushpage will block and
+	   won't clear the mapped bit under us. */
+	if (!buffer_mapped(bh))
+		BUG();
+
+	/*
+	 * Temporary solution - in 2.5 this will be done by the lowlevel
+	 * driver. Create a bounce buffer if the buffer data points into
+	 * high memory - keep the original buffer otherwise.
+	 */
+#if CONFIG_HIGHMEM
+	bh = create_bounce(rw, bh);
+#endif
+
+/* look for a free request. */
+	/*
+	 * Try to coalesce the new request with old requests
+	 */
+	max_sectors = get_max_sectors(bh->b_rdev);
+
+again:
+	req = NULL;
+	head = &q->queue_head;
+	/*
+	 * Now we acquire the request spinlock, we have to be mega careful
+	 * not to schedule or do something nonatomic
+	 */
+	xrq_lock_irq(q);
+
+	insert_here = head->prev;
+	if (list_empty(head)) {
+		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
+		goto get_rq;
+	} 
+
+	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,max_sectors);
+	switch (el_ret) {
+
+		case ELEVATOR_BACK_MERGE:
+			if (!q->back_merge_fn(q, req, bh, max_segments))
+				break;
+			elevator->elevator_merge_cleanup_fn(q, req, count);
+			req->bhtail->b_reqnext = bh;
+			req->bhtail = bh;
+			req->nr_sectors = req->hard_nr_sectors += count;
+			blk_started_io(count);
+			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+			attempt_back_merge(q, req, max_sectors, max_segments);
+			goto out;
+
+		case ELEVATOR_FRONT_MERGE:
+			if (!q->front_merge_fn(q, req, bh, max_segments))
+				break;
+			elevator->elevator_merge_cleanup_fn(q, req, count);
+			bh->b_reqnext = req->bh;
+			req->bh = bh;
+			req->buffer = bh->b_data;
+			req->current_nr_sectors = count;
+			req->sector = req->hard_sector = sector;
+			req->nr_sectors = req->hard_nr_sectors += count;
+			blk_started_io(count);
+			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+			attempt_front_merge(q, head, req, max_sectors, max_segments);
+			goto out;
+
+		/*
+		 * elevator says don't/can't merge. get new request
+		 */
+		case ELEVATOR_NO_MERGE:
+			/*
+			 * use elevator hints as to where to insert the
+			 * request. if no hints, just add it to the back
+			 * of the queue
+			 */
+			if (req)
+				insert_here = &req->queue;
+			break;
+
+		default:
+			printk("elevator returned crap (%d)\n", el_ret);
+			BUG();
+	}
+		
+	/*
+	 * Grab a free request from the freelist - if that is empty, check
+	 * if we are doing read ahead and abort instead of blocking for
+	 * a free slot.
+	 */
+get_rq:
+	if (freereq) {
+		req = freereq;
+		freereq = NULL;
+	} else if ((req = scsi_get_request(q, rw)) == NULL) {
+		xrq_unlock_irq(q);
+		if (rw_ahead)
+			goto end_io;
+
+		freereq = scsi_get_request_wait(q, rw);
+		goto again;
+	}
+
+/* fill up the request-info, and add it to the queue */
+	req->elevator_sequence = latency;
+	req->cmd = rw;
+	req->errors = 0;
+	req->hard_sector = req->sector = sector;
+	req->hard_nr_sectors = req->nr_sectors = count;
+	req->current_nr_sectors = count;
+	req->nr_segments = 1; /* Always 1 for a new request. */
+	req->nr_hw_segments = 1; /* Always 1 for a new request. */
+	req->buffer = bh->b_data;
+	req->waiting = NULL;
+	req->bh = bh;
+	req->bhtail = bh;
+	req->rq_dev = bh->b_rdev;
+	blk_started_io(count);
+	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
+	list_add(&req->queue, insert_here);
+
+out:
+	if (freereq)
+		blkdev_release_request(freereq);
+	xrq_unlock_irq(q);
+	return 0;
+end_io:
+	bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+	return 0;
+}
+
 /*
  * Function:    scsi_request_fn()
  *
@@ -913,9 +1153,11 @@
 			 */
 			SDpnt->was_reset = 0;
 			if (SDpnt->removable && !in_interrupt()) {
+				rq_unlock(q);
 				spin_unlock_irq(&io_request_lock);
 				scsi_ioctl(SDpnt, SCSI_IOCTL_DOORLOCK, 0);
 				spin_lock_irq(&io_request_lock);
+				rq_lock(q);
 				continue;
 			}
 		}
@@ -1024,7 +1266,6 @@
 		 * another.  
 		 */
 		req = NULL;
-		spin_unlock_irq(&io_request_lock);
 
 		if (SCpnt->request.cmd != SPECIAL) {
 			/*
@@ -1054,7 +1295,6 @@
 				{
 					panic("Should not have leftover blocks\n");
 				}
-				spin_lock_irq(&io_request_lock);
 				SHpnt->host_busy--;
 				SDpnt->device_busy--;
 				continue;
@@ -1070,7 +1310,6 @@
 				{
 					panic("Should not have leftover blocks\n");
 				}
-				spin_lock_irq(&io_request_lock);
 				SHpnt->host_busy--;
 				SDpnt->device_busy--;
 				continue;
@@ -1085,14 +1324,30 @@
 		/*
 		 * Dispatch the command to the low-level driver.
 		 */
+		rq_unlock(q);
+		spin_unlock_irq(&io_request_lock);
 		scsi_dispatch_cmd(SCpnt);
-
-		/*
-		 * Now we need to grab the lock again.  We are about to mess
-		 * with the request queue and try to find another command.
-		 */
 		spin_lock_irq(&io_request_lock);
+		rq_lock(q);
 	}
+}
+
+extern void blk_init_free_list(request_queue_t *);
+
+void scsi_init_queue(request_queue_t * q, unsigned concurrent_queue)
+{
+	INIT_LIST_HEAD(&q->queue_head);
+	elevator_init(&q->elevator, ELEVATOR_LINUS);
+	blk_init_free_list(q);
+	q->request_fn     	= scsi_request_fn;
+	q->make_request_fn	= scsi_make_request;
+	q->plug_tq.sync		= 0;
+	q->plug_tq.routine	= scsi_unplug_device;
+	q->plug_tq.data		= q;
+	q->plugged        	= 0;
+	q->plug_device_fn 	= scsi_plug_device;
+	q->head_active    	= 0;
+	q->concurrent		= concurrent_queue;		
 }
 
 /*
