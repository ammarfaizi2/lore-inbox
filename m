Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSGZGFR>; Fri, 26 Jul 2002 02:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSGZGFR>; Fri, 26 Jul 2002 02:05:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28422 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316928AbSGZGFN>; Fri, 26 Jul 2002 02:05:13 -0400
Message-ID: <3D40E62B.9070202@evision.ag>
Date: Fri, 26 Jul 2002 08:03:23 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000808020202020403090307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808020202020403090307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

1. Remove blkdev_release_request(Request); it was an unnecessary wrapper
    around blk_put_request(Request). Likely some leftover from pre-BIO
    time...

2. Abstract out the fine __scsi_insert_special() function out from
    the SCSI code.

    Now that I have finally managed to kill all those IDE 'specific'
    REQ_BLAH request types, we can do this final step, and it will be
    used soon at least by ATA code as well. The goal is that
    scsi_request_fn and do_ide_request should start to look similar
    like silblings.

    Its called blk_insert_request() now and even documented in code.

3. Change some stuff over from extern inline to static inline in
    blkdev.h. (trivia...)

This patch doesn't change *any* functionality, so its not exposing
SCSI to any danger :-).

Please apply.

Thanks.

--------------000808020202020403090307
Content-Type: text/plain;
 name="blk-2.5.28.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-2.5.28.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h linux-2.5.28/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- linux-2.5.28/drivers/block/DAC960.c	2002-07-24 23:03:30.000000000 +0200
+++ linux/drivers/block/DAC960.c	2002-07-25 23:02:06.000000000 +0200
@@ -2884,7 +2884,7 @@ static boolean DAC960_ProcessRequest(DAC
   Command->BufferHeader = Request->bio;
   Command->RequestBuffer = Request->buffer;
   blkdev_dequeue_request(Request);
-  blkdev_release_request(Request);
+  blk_put_request(Request);
   DAC960_QueueReadWriteCommand(Command);
   return true;
 }
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h linux-2.5.28/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.28/drivers/block/ll_rw_blk.c	2002-07-24 23:03:20.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-07-25 23:02:06.000000000 +0200
@@ -1233,9 +1233,47 @@ struct request *__blk_get_request(reques
 	return rq;
 }
 
-void blk_put_request(struct request *rq)
+/**
+ * blk_insert_request - insert a special request in to a request queue
+ * @q:		request queue where request should be inserted
+ * @rq:		request to be inserted
+ * @at_head:	insert request at head or tail of queue
+ * @data:	private data
+ *
+ * Description:
+ *    Many block devices need to execute commands asynchronously, so they don't
+ *    block the whole kernel from preemption during request execution.  This is
+ *    accomplished normally by inserting aritficial requests tagged as
+ *    REQ_SPECIAL in to the corresponding request queue, and letting them be
+ *    scheduled for actual execution by the request queue.
+ *
+ *    We have the option of inserting the head or the tail of the queue.
+ *    Typically we use the tail for new ioctls and so forth.  We use the head
+ *    of the queue for things like a QUEUE_FULL message from a device, or a
+ *    host that is unable to accept a particular command.
+ */
+void blk_insert_request(request_queue_t *q, struct request *rq,
+		int at_head, void *data)
 {
-	blkdev_release_request(rq);
+	unsigned long flags;
+
+	/*
+	 * tell I/O scheduler that this isn't a regular read/write (ie it
+	 * must not attempt merges on this) and that it acts as a soft
+	 * barrier
+	 */
+	rq->flags &= REQ_QUEUED;
+	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
+
+	rq->special = data;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	/* If command is tagged, release the tag */
+	if(blk_rq_tagged(rq))
+		blk_queue_end_tag(q, rq);
+	_elv_add_request(q, rq, !at_head, 0);
+	q->request_fn(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
 /* RO fail safe mechanism */
@@ -1307,7 +1345,7 @@ static inline void add_request(request_q
 /*
  * Must be called with queue lock held and interrupts disabled
  */
-void blkdev_release_request(struct request *req)
+void blk_put_request(struct request *req)
 {
 	struct request_list *rl = req->rl;
 	request_queue_t *q = req->q;
@@ -1370,7 +1408,7 @@ static void attempt_merge(request_queue_
 
 		req->nr_sectors = req->hard_nr_sectors += next->hard_nr_sectors;
 
-		blkdev_release_request(next);
+		blk_put_request(next);
 	}
 }
 
@@ -1568,7 +1606,7 @@ get_rq:
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
-		blkdev_release_request(freereq);
+		blk_put_request(freereq);
 	spin_unlock_irq(q->queue_lock);
 	return 0;
 
@@ -2003,7 +2041,7 @@ void end_that_request_last(struct reques
 	if (req->waiting)
 		complete(req->waiting);
 
-	blkdev_release_request(req);
+	blk_put_request(req);
 }
 
 #define MB(kb)	((kb) << 10)
@@ -2064,7 +2102,6 @@ EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 EXPORT_SYMBOL(generic_make_request);
-EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(blk_plug_device);
 EXPORT_SYMBOL(blk_remove_plug);
@@ -2088,6 +2125,7 @@ EXPORT_SYMBOL(blk_hw_contig_segment);
 EXPORT_SYMBOL(blk_get_request);
 EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
+EXPORT_SYMBOL(blk_insert_request);
 
 EXPORT_SYMBOL(blk_queue_prep_rq);
 
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h linux-2.5.28/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- linux-2.5.28/drivers/scsi/scsi_lib.c	2002-07-24 23:03:28.000000000 +0200
+++ linux/drivers/scsi/scsi_lib.c	2002-07-25 23:02:07.000000000 +0200
@@ -51,53 +51,6 @@
  */
 
 /*
- * Function:	__scsi_insert_special()
- *
- * Purpose:	worker for scsi_insert_special_*()
- *
- * Arguments:	q - request queue where request should be inserted
- *		rq - request to be inserted
- * 		data - private data
- *		at_head - insert request at head or tail of queue
- *
- * Lock status:	Assumed that queue lock is not held upon entry.
- *
- * Returns:	Nothing
- */
-static void __scsi_insert_special(request_queue_t *q, struct request *rq,
-				  void *data, int at_head)
-{
-	unsigned long flags;
-
-	ASSERT_LOCK(q->queue_lock, 0);
-
-	/*
-	 * tell I/O scheduler that this isn't a regular read/write (ie it
-	 * must not attempt merges on this) and that it acts as a soft
-	 * barrier
-	 */
-	rq->flags &= REQ_QUEUED;
-	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
-
-	rq->special = data;
-
-	/*
-	 * We have the option of inserting the head or the tail of the queue.
-	 * Typically we use the tail for new ioctls and so forth.  We use the
-	 * head of the queue for things like a QUEUE_FULL message from a
-	 * device, or a host that is unable to accept a particular command.
-	 */
-	spin_lock_irqsave(q->queue_lock, flags);
-	/* If command is tagged, release the tag */
-	if(blk_rq_tagged(rq))
-		blk_queue_end_tag(q, rq);
-	_elv_add_request(q, rq, !at_head, 0);
-	q->request_fn(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
-
-/*
  * Function:    scsi_insert_special_cmd()
  *
  * Purpose:     Insert pre-formed command into request queue.
@@ -121,7 +74,7 @@ int scsi_insert_special_cmd(Scsi_Cmnd * 
 {
 	request_queue_t *q = &SCpnt->device->request_queue;
 
-	__scsi_insert_special(q, SCpnt->request, SCpnt, at_head);
+	blk_insert_request(q, SCpnt->request, at_head, SCpnt);
 	return 0;
 }
 
@@ -149,7 +102,7 @@ int scsi_insert_special_req(Scsi_Request
 {
 	request_queue_t *q = &SRpnt->sr_device->request_queue;
 
-	__scsi_insert_special(q, SRpnt->sr_request, SRpnt, at_head);
+	blk_insert_request(q, SRpnt->sr_request, at_head, SRpnt);
 	return 0;
 }
 
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h linux-2.5.28/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.28/include/linux/blkdev.h	2002-07-24 23:03:22.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-07-25 23:02:07.000000000 +0200
@@ -281,12 +281,13 @@ extern int wipe_partitions(kdev_t dev);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void generic_make_request(struct bio *bio);
 extern inline request_queue_t *bdev_get_queue(struct block_device *bdev);
-extern void blkdev_release_request(struct request *);
+extern void blk_put_request(struct request *);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
 extern struct request *__blk_get_request(request_queue_t *, int);
 extern void blk_put_request(struct request *);
+extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
@@ -309,20 +310,21 @@ extern int blk_init_queue(request_queue_
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void blk_queue_bounce_limit(request_queue_t *, u64);
-extern void blk_queue_max_sectors(request_queue_t *q, unsigned short);
-extern void blk_queue_max_phys_segments(request_queue_t *q, unsigned short);
-extern void blk_queue_max_hw_segments(request_queue_t *q, unsigned short);
-extern void blk_queue_max_segment_size(request_queue_t *q, unsigned int);
-extern void blk_queue_hardsect_size(request_queue_t *q, unsigned short);
-extern void blk_queue_segment_boundary(request_queue_t *q, unsigned long);
-extern void blk_queue_assign_lock(request_queue_t *q, spinlock_t *);
-extern void blk_queue_prep_rq(request_queue_t *q, prep_rq_fn *pfn);
+extern void blk_queue_max_sectors(request_queue_t *, unsigned short);
+extern void blk_queue_max_phys_segments(request_queue_t *, unsigned short);
+extern void blk_queue_max_hw_segments(request_queue_t *, unsigned short);
+extern void blk_queue_max_segment_size(request_queue_t *, unsigned int);
+extern void blk_queue_hardsect_size(request_queue_t *, unsigned short);
+extern void blk_queue_segment_boundary(request_queue_t *, unsigned long);
+extern void blk_queue_assign_lock(request_queue_t *, spinlock_t *);
+extern void blk_queue_prep_rq(request_queue_t *, prep_rq_fn *pfn);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
 
+
 /*
  * tag stuff
  */
@@ -348,15 +350,12 @@ extern int * blk_size[MAX_BLKDEV];	/* in
 
 extern void drive_stat_acct(struct request *, int, int);
 
-extern inline void blk_clear(int major)
+static inline void blk_clear(int major)
 {
 	blk_size[major] = NULL;
-#if 0
-	blk_size_in_bytes[major] = NULL;
-#endif
 }
 
-extern inline int queue_hardsect_size(request_queue_t *q)
+static inline int queue_hardsect_size(request_queue_t *q)
 {
 	int retval = 512;
 
@@ -366,7 +365,7 @@ extern inline int queue_hardsect_size(re
 	return retval;
 }
 
-extern inline int bdev_hardsect_size(struct block_device *bdev)
+static inline int bdev_hardsect_size(struct block_device *bdev)
 {
 	return queue_hardsect_size(bdev_get_queue(bdev));
 }
@@ -375,7 +374,7 @@ extern inline int bdev_hardsect_size(str
 #define blk_started_io(nsects)	do { } while (0)
 
 /* assumes size > 256 */
-extern inline unsigned int blksize_bits(unsigned int size)
+static inline unsigned int blksize_bits(unsigned int size)
 {
 	unsigned int bits = 8;
 	do {
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h linux-2.5.28/include/linux/nbd.h linux/include/linux/nbd.h
--- linux-2.5.28/include/linux/nbd.h	2002-07-24 23:03:31.000000000 +0200
+++ linux/include/linux/nbd.h	2002-07-25 23:02:07.000000000 +0200
@@ -61,7 +61,7 @@ nbd_end_request(struct request *req)
 		bio->bi_next = NULL;
 		bio_endio(bio, uptodate);
 	}
-	blkdev_release_request(req);
+	blk_put_request(req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 

--------------000808020202020403090307--

