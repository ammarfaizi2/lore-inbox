Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUKIV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUKIV6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKIV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:58:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261716AbUKIV53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:57:29 -0500
Date: Tue, 9 Nov 2004 22:57:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.10-rc1-mm4
Message-ID: <20041109215717.GA13742@suse.de>
References: <20041109074909.3f287966.akpm@osdl.org> <20041109161112.GA3921@suse.de> <20041109115338.59d195ec.akpm@osdl.org> <20041109211409.GB3921@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109211409.GB3921@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09 2004, Jens Axboe wrote:
> On Tue, Nov 09 2004, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > On Tue, Nov 09 2004, Andrew Morton wrote:
> > > > +blk_sync_queue-updates.patch
> > > > 
> > > >  update an update to the md updates
> > > 
> > > I still don't think this is a good general export, it has very
> > > specialized use. For example, from the description it looks like this
> > > can be generally used on any block device and when it returns, we have
> > > synced the queue. This simply isn't true, there are absolutely no
> > > guarentees of that nature unless the block driver itself implements the
> > > __make_request() functionality and has taken proper precautions to
> > > prevent this already.
> > 
> > True.   So what do we do?  Grit our teeth and move it into MD?
> 
> That, or just comment it appropriately instead. Or, perhaps better, make
> a real interface that works for both types of devices. It's even
> confusing that the final queue cleanup and md can use the same
> blk_sync_queue function, it's more by 'chance' than by design because
> the driver queue is already in a known and shut down state. So I don't
> like it at all.
> 
> The blk_freeze_queue() stuff I suggested should work, I'll try and make
> a patch.

This is in the nature of what I had in mind. Just test compiled it,
haven't run a test on it yet. I know of at least one problem - the
queue_lock is not necesarily defined for md-type drivers. The drain and
undrain routines need to check for non-NULL q->queue_lock, which is a
bit ugly, but...

I'll fix that and really test it tomorrow. This is just an RFC until
then.

--- /opt/kernel/linux-2.6.10-rc1-mm4/drivers/block/ll_rw_blk.c	2004-11-09 22:48:47.578252278 +0100
+++ linux-2.6.10-rc1-mm4/drivers/block/ll_rw_blk.c	2004-11-09 22:53:55.641082927 +0100
@@ -229,6 +229,13 @@
  **/
 void blk_queue_make_request(request_queue_t * q, make_request_fn * mfn)
 {
+	struct request_list *rl = &q->rq;
+
+	rl->count[READ] = rl->count[WRITE] = 0;
+	init_waitqueue_head(&rl->wait[READ]);
+	init_waitqueue_head(&rl->wait[WRITE]);
+	init_waitqueue_head(&rl->drain);
+
 	/*
 	 * set defaults
 	 */
@@ -1311,6 +1318,45 @@
 	kblockd_schedule_work(&q->unplug_work);
 }
 
+/*
+ * make sure plugging is idled for this queue
+ */
+static void blk_sync_queue(struct request_queue *q)
+{
+	del_timer_sync(&q->unplug_timer);
+	kblockd_flush();
+}
+
+/**
+ * blk_freeze_queue - freeze a request queue
+ * @q:    The &request_queue_t in question
+ *
+ * Description:
+ *   A frozen queue will have no pending unplugs left and will not have
+ *   its ->make_request_fn invoked for processing of new requests before
+ *   a matching call to blk_unfreeze_queue has been made.
+ **/
+void blk_freeze_queue(request_queue_t *q)
+{
+	blk_wait_queue_drained(q, 1);
+	blk_sync_queue(q);
+}
+EXPORT_SYMBOL(blk_freeze_queue);
+
+/**
+ * blk_unfreeze_queue - freeze a request queue
+ * @q:    The &request_queue_t in question
+ *
+ * Description:
+ *   Unfreeze the queue again and wake up anybody that might be waiting to
+ *   queue IO to it.
+ **/
+void blk_unfreeze_queue(request_queue_t *q)
+{
+	blk_finish_queue_drain(q);
+}
+EXPORT_SYMBOL(blk_unfreeze_queue);
+
 /**
  * blk_start_queue - restart a previously stopped queue
  * @q:    The &request_queue_t in question
@@ -1361,25 +1407,6 @@
 EXPORT_SYMBOL(blk_stop_queue);
 
 /**
- * blk_sync_queue - cancel any pending callbacks a queue
- * @q: the queue
- *
- * Description:
- *     The block layer may perform asynchronous callback activity
- *     on a queue, such as calling the unplug function after a timeout.
- *     A block device may call blk_sync_queue to ensure that any
- *     such activity is cancelled, thus allowing it to release resources
- *     the the callbacks might use.
- *
- */
-void blk_sync_queue(struct request_queue *q)
-{
-	del_timer_sync(&q->unplug_timer);
-	kblockd_flush();
-}
-EXPORT_SYMBOL(blk_sync_queue);
-
-/**
  * blk_run_queue - run a single device queue
  * @q:	The queue to run
  */
@@ -1436,11 +1463,6 @@
 {
 	struct request_list *rl = &q->rq;
 
-	rl->count[READ] = rl->count[WRITE] = 0;
-	init_waitqueue_head(&rl->wait[READ]);
-	init_waitqueue_head(&rl->wait[WRITE]);
-	init_waitqueue_head(&rl->drain);
-
 	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
 
 	if (!rl->rq_pool)
@@ -1508,6 +1530,8 @@
 	if (!q)
 		return NULL;
 
+	blk_queue_make_request(q, __make_request);
+
 	if (blk_init_free_list(q))
 		goto out_init;
 
@@ -1522,7 +1546,6 @@
 
 	blk_queue_segment_boundary(q, 0xffffffff);
 
-	blk_queue_make_request(q, __make_request);
 	blk_queue_max_segment_size(q, MAX_SEGMENT_SIZE);
 
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
--- /opt/kernel/linux-2.6.10-rc1-mm4/include/linux/blkdev.h	2004-11-09 22:48:53.904571107 +0100
+++ linux-2.6.10-rc1-mm4/include/linux/blkdev.h	2004-11-09 22:50:00.404410930 +0100
@@ -522,9 +522,10 @@
 extern int scsi_cmd_ioctl(struct file *, struct gendisk *, unsigned int, void __user *);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
-extern void blk_sync_queue(struct request_queue *q);
 extern void __blk_stop_queue(request_queue_t *q);
 extern void blk_run_queue(request_queue_t *);
+extern void blk_freeze_queue(request_queue_t *);
+extern void blk_unfreeze_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
 extern int blk_rq_unmap_user(struct request *, struct bio *, unsigned int);



-- 
Jens Axboe

