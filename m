Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVDMBaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVDMBaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDMB2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:28:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262148AbVDMBWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:22:55 -0400
Date: Wed, 13 Apr 2005 03:22:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/ll_rw_blk.c: cleanups
Message-ID: <20050413012251.GL3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- remove the following unused global functions:
  - blkdev_scsi_issue_flush_fn
  - __blk_attempt_remerge
- remove the following unused EXPORT_SYMBOL's:
  - blk_phys_contig_segment
  - blk_hw_contig_segment
  - blkdev_scsi_issue_flush_fn
  - __blk_attempt_remerge

This patch was already ACK'ed by Jens Axboe.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 drivers/block/ll_rw_blk.c |   67 ++++----------------------------------
 include/linux/blkdev.h    |    6 ---
 2 files changed, 8 insertions(+), 65 deletions(-)

--- linux-2.6.12-rc2-mm2-full/include/linux/blkdev.h.old	2005-04-10 01:55:03.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/include/linux/blkdev.h	2005-04-10 01:57:11.000000000 +0200
@@ -548,15 +548,12 @@
 extern void blk_put_request(struct request *);
 extern void blk_end_sync_rq(struct request *rq);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
-extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *, int);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
-extern int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
-extern int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int scsi_cmd_ioctl(struct file *, struct gendisk *, unsigned int, void __user *);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
@@ -638,7 +635,6 @@
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);
-extern int blkdev_scsi_issue_flush_fn(request_queue_t *, struct gendisk *, sector_t *);
 extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
 extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
 extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
@@ -681,8 +677,6 @@
 
 #define blkdev_entry_to_request(entry) list_entry((entry), struct request, queuelist)
 
-extern void drive_stat_acct(struct request *, int, int);
-
 static inline int queue_hardsect_size(request_queue_t *q)
 {
 	int retval = 512;
--- linux-2.6.12-rc2-mm2-full/drivers/block/ll_rw_blk.c.old	2005-04-10 01:55:17.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/block/ll_rw_blk.c	2005-04-10 01:57:49.000000000 +0200
@@ -36,6 +36,7 @@
 
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
+static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
 
 /*
  * For the allocated request tables
@@ -1149,7 +1150,7 @@
 }
 
 
-int blk_phys_contig_segment(request_queue_t *q, struct bio *bio,
+static int blk_phys_contig_segment(request_queue_t *q, struct bio *bio,
 				   struct bio *nxt)
 {
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
@@ -1170,9 +1171,7 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(blk_phys_contig_segment);
-
-int blk_hw_contig_segment(request_queue_t *q, struct bio *bio,
+static int blk_hw_contig_segment(request_queue_t *q, struct bio *bio,
 				 struct bio *nxt)
 {
 	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
@@ -1188,8 +1187,6 @@
 	return 1;
 }
 
-EXPORT_SYMBOL(blk_hw_contig_segment);
-
 /*
  * map a request to scatterlist, return number of sg entries setup. Caller
  * must make sure sg can hold rq->nr_phys_segments entries
@@ -1810,7 +1807,7 @@
  * is the behaviour we want though - once it gets a wakeup it should be given
  * a nice run.
  */
-void ioc_set_batching(request_queue_t *q, struct io_context *ioc)
+static void ioc_set_batching(request_queue_t *q, struct io_context *ioc)
 {
 	if (!ioc || ioc_batching(q, ioc))
 		return;
@@ -2250,45 +2247,7 @@
 
 EXPORT_SYMBOL(blkdev_issue_flush);
 
-/**
- * blkdev_scsi_issue_flush_fn - issue flush for SCSI devices
- * @q:		device queue
- * @disk:	gendisk
- * @error_sector:	error offset
- *
- * Description:
- *    Devices understanding the SCSI command set, can use this function as
- *    a helper for issuing a cache flush. Note: driver is required to store
- *    the error offset (in case of error flushing) in ->sector of struct
- *    request.
- */
-int blkdev_scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
-			       sector_t *error_sector)
-{
-	struct request *rq = blk_get_request(q, WRITE, __GFP_WAIT);
-	int ret;
-
-	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
-	rq->sector = 0;
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-	rq->cmd[0] = 0x35;
-	rq->cmd_len = 12;
-	rq->data = NULL;
-	rq->data_len = 0;
-	rq->timeout = 60 * HZ;
-
-	ret = blk_execute_rq(q, disk, rq);
-
-	if (ret && error_sector)
-		*error_sector = rq->sector;
-
-	blk_put_request(rq);
-	return ret;
-}
-
-EXPORT_SYMBOL(blkdev_scsi_issue_flush_fn);
-
-void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
+static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
 	int rw = rq_data_dir(rq);
 
@@ -2548,16 +2507,6 @@
 
 EXPORT_SYMBOL(blk_attempt_remerge);
 
-/*
- * Non-locking blk_attempt_remerge variant.
- */
-void __blk_attempt_remerge(request_queue_t *q, struct request *rq)
-{
-	attempt_back_merge(q, rq);
-}
-
-EXPORT_SYMBOL(__blk_attempt_remerge);
-
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
@@ -2978,7 +2927,7 @@
 
 EXPORT_SYMBOL(submit_bio);
 
-void blk_recalc_rq_segments(struct request *rq)
+static void blk_recalc_rq_segments(struct request *rq)
 {
 	struct bio *bio, *prevbio = NULL;
 	int nr_phys_segs, nr_hw_segs;
@@ -3020,7 +2969,7 @@
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
-void blk_recalc_rq_sectors(struct request *rq, int nsect)
+static void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (blk_fs_request(rq)) {
 		rq->hard_sector += nsect;
@@ -3611,7 +3560,7 @@
 	.store	= queue_attr_store,
 };
 
-struct kobj_type queue_ktype = {
+static struct kobj_type queue_ktype = {
 	.sysfs_ops	= &queue_sysfs_ops,
 	.default_attrs	= default_attrs,
 };

