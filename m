Return-Path: <linux-kernel-owner+w=401wt.eu-S965221AbXAJWvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbXAJWvG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbXAJWvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:51:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965147AbXAJWvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:51:02 -0500
Date: Wed, 10 Jan 2007 18:08:14 -0500 (EST)
Message-Id: <20070110.180814.104026676.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Cc: dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 2/3] blk_end_request: full completion handler
 implementation
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding blk_end_io() as a full completion handler for I/Os other than
sync/barrier.
Completion handlers for sync/barrier I/Os are also updated to full
completion handler.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
---
 block/ll_rw_blk.c       |   93 +++++++++++++++++++++++++++++++++++++-----------
 drivers/scsi/scsi_lib.c |    9 ++++
 include/linux/blkdev.h  |   31 ++++++++++++++--
 3 files changed, 109 insertions(+), 24 deletions(-)

diff -rupN 1-blk-end-request-helper/block/ll_rw_blk.c 2-helper-implementation/block/ll_rw_blk.c
--- 1-blk-end-request-helper/block/ll_rw_blk.c	2007-01-10 11:02:46.000000000 -0500
+++ 2-helper-implementation/block/ll_rw_blk.c	2007-01-10 11:17:08.000000000 -0500
@@ -380,22 +380,65 @@ void blk_ordered_complete_seq(request_qu
 	end_that_request_last(rq, uptodate);
 }
 
-static void pre_flush_end_io(struct request *rq, int error)
+static int blk_uptodate_to_error(int uptodate)
 {
+	int error = 0;
+
+	/*
+	 * extend uptodate bool to allow < 0 value to be direct io error
+	 */
+	if (end_io_error(uptodate))
+		error = !uptodate ? -EIO : uptodate;
+
+	return error;
+}
+
+static int pre_flush_end_io(struct request *rq, int uptodate, int nr_bytes,
+			    int locked, int (callback)(void *), void *arg)
+{
+	int error;
+
+	BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg);
+
+	error = blk_uptodate_to_error(uptodate);
 	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_PREFLUSH, error);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
 }
 
-static void bar_end_io(struct request *rq, int error)
+static int bar_end_io(struct request *rq, int uptodate, int nr_bytes,
+		      int locked, int (callback)(void *), void *arg)
 {
+	int error;
+
+	BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg);
+
+	error = blk_uptodate_to_error(uptodate);
 	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_BAR, error);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
 }
 
-static void post_flush_end_io(struct request *rq, int error)
+static int post_flush_end_io(struct request *rq, int uptodate, int nr_bytes,
+			     int locked, int (callback)(void *), void *arg)
 {
+	int error;
+
+	BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg);
+
+	error = blk_uptodate_to_error(uptodate);
 	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_POSTFLUSH, error);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
 }
 
 static void queue_flush(request_queue_t *q, unsigned which)
@@ -2704,10 +2747,13 @@ EXPORT_SYMBOL(blk_put_request);
  * @rq: request to complete
  * @error: end io status of the request
  */
-void blk_end_sync_rq(struct request *rq, int error)
+int blk_end_sync_rq(struct request *rq, int uptodate, int nr_bytes,
+		    int locked, int (callback)(void *), void *arg)
 {
 	struct completion *waiting = rq->end_io_data;
 
+	BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg);
+
 	rq->end_io_data = NULL;
 	__blk_put_request(rq->q, rq);
 
@@ -2716,6 +2762,10 @@ void blk_end_sync_rq(struct request *rq,
 	 * the rq pointer) could be invalid right after this complete()
 	 */
 	complete(waiting);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
 }
 EXPORT_SYMBOL(blk_end_sync_rq);
 
@@ -2829,6 +2879,18 @@ static void init_request_from_bio(struct
 	req->start_time = jiffies;
 }
 
+static int blk_end_io(struct request *rq, int uptodate, int nr_bytes,
+		      int locked, int (callback)(void *), void *arg)
+{
+	BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg);
+
+	__blk_put_request(rq->q, rq);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
+}
+
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req;
@@ -2921,6 +2983,7 @@ get_rq:
 	 * often, and the elevators are able to handle it.
 	 */
 	init_request_from_bio(req, bio);
+	req->end_io = blk_end_io;
 
 	spin_lock_irq(q->queue_lock);
 	if (elv_queue_empty(q))
@@ -3436,17 +3499,9 @@ EXPORT_SYMBOL(blk_complete_request);
 /*
  * queue lock must be held
  */
-void end_that_request_last(struct request *req, int uptodate)
+void end_that_request_last(struct request *req)
 {
 	struct gendisk *disk = req->rq_disk;
-	int error;
-
-	/*
-	 * extend uptodate bool to allow < 0 value to be direct io error
-	 */
-	error = 0;
-	if (end_io_error(uptodate))
-		error = !uptodate ? -EIO : uptodate;
 
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
@@ -3465,10 +3520,6 @@ void end_that_request_last(struct reques
 		disk_round_stats(disk);
 		disk->in_flight--;
 	}
-	if (req->end_io)
-		req->end_io(req, error);
-	else
-		__blk_put_request(req->q, req);
 }
 
 EXPORT_SYMBOL(end_that_request_last);
@@ -3498,12 +3549,12 @@ EXPORT_SYMBOL(end_request);
  * @arg:      argument for @callback
  *
  * Description:
- *     Ends I/O on a number of bytes attached to @rq.
- *     If @rq has leftover, sets it up for the next range of segments.
+ *	Ends I/O on a number of bytes attached to @rq.
+ *      If @rq has leftover, sets it up for the next range of segments.
  *
  * Return:
- *     0 - we are done with this request
- *     1 - still buffers pending for this request
+ *	0 - we are done with this request
+ *	1 - still buffers pending for this request
  */
 int blk_end_request(struct request *rq, int uptodate, int nr_bytes,
 		    int locked, int (callback)(void *), void *arg)
diff -rupN 1-blk-end-request-helper/drivers/scsi/scsi_lib.c 2-helper-implementation/drivers/scsi/scsi_lib.c
--- 1-blk-end-request-helper/drivers/scsi/scsi_lib.c	2006-12-11 14:32:53.000000000 -0500
+++ 2-helper-implementation/drivers/scsi/scsi_lib.c	2007-01-10 11:19:00.000000000 -0500
@@ -243,15 +243,22 @@ struct scsi_io_context {
 
 static kmem_cache_t *scsi_io_context_cache;
 
-static void scsi_end_async(struct request *req, int uptodate)
+static int scsi_end_async(struct request *req, int uptodate, int nr_bytes,
+			  int locked, int (callback)(void *), void *arg)
 {
 	struct scsi_io_context *sioc = req->end_io_data;
 
+	BLK_ENDIO_PRE(req, uptodate, nr_bytes, locked, callback, arg);
+
 	if (sioc->done)
 		sioc->done(sioc->data, sioc->sense, req->errors, req->data_len);
 
 	kmem_cache_free(scsi_io_context_cache, sioc);
 	__blk_put_request(req->q, req);
+
+	BLK_ENDIO_POST(locked);
+
+	return 0;
 }
 
 static int scsi_merge_bio(struct request *rq, struct bio *bio)
diff -rupN 1-blk-end-request-helper/include/linux/blkdev.h 2-helper-implementation/include/linux/blkdev.h
--- 1-blk-end-request-helper/include/linux/blkdev.h	2007-01-10 11:05:51.000000000 -0500
+++ 2-helper-implementation/include/linux/blkdev.h	2007-01-10 11:09:32.000000000 -0500
@@ -642,7 +642,8 @@ extern void register_disk(struct gendisk
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(request_queue_t *, struct request *);
-extern void blk_end_sync_rq(struct request *rq, int error);
+extern int blk_end_sync_rq(struct request *rq, int, int, int, int (void *),
+			   void *);
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
@@ -718,11 +719,37 @@ extern int blk_end_request(struct reques
 			   void *);
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
-extern void end_that_request_last(struct request *, int);
+extern void end_that_request_last(struct request *);
 extern void end_request(struct request *req, int uptodate);
 extern void blk_complete_request(struct request *);
 
 /*
+ * BLK_ENDIO_PRE()/BLK_ENDIO_POST() macros may be useful for rq->end_io
+ * hook functions to duplicate codes like below:
+ *    BLK_ENDIO_PRE();
+ *    Their own codes with using the request.
+ *    BLK_ENDIO_POST();
+ */
+#define BLK_ENDIO_PRE(rq, uptodate, nr_bytes, locked, callback, arg)	\
+	struct request_queue *q = (rq)->q;				\
+	unsigned long flags = 0UL;					\
+									\
+	if (end_that_request_chunk(rq, uptodate, nr_bytes))		\
+		return 1;						\
+									\
+	if (callback && callback(arg))					\
+		return 1;						\
+									\
+	if (!locked)							\
+		spin_lock_irqsave(q->queue_lock, flags);		\
+									\
+	end_that_request_last(rq)
+
+#define BLK_ENDIO_POST(locked)						\
+	if (!locked)							\
+		spin_unlock_irqrestore(q->queue_lock, flags)
+
+/*
  * end_that_request_first/chunk() takes an uptodate argument. we account
  * any value <= as an io error. 0 means -EIO for compatability reasons,
  * any other < 0 value is the direct error type. An uptodate value of

