Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269322AbUIHTe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269322AbUIHTe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUIHTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:33:14 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:20439 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269322AbUIHT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:33 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][9/9] block: remove bio walking
Date: Wed, 8 Sep 2004 21:27:04 +0200
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082127.04331.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] block: remove bio walking

IDE driver was the only user of bio walking code.

I now think that block drivers shouldn't use bios directly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/block/ll_rw_blk.c |  114 ----------------
 linux-2.6.9-rc1-bk10-bzolnier/include/linux/blkdev.h    |   36 -----
 2 files changed, 5 insertions(+), 145 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~bio_walking drivers/block/ll_rw_blk.c
--- linux-2.6.9-rc1-bk10/drivers/block/ll_rw_blk.c~bio_walking	2004-09-08 19:59:00.551496200 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/block/ll_rw_blk.c	2004-09-08 19:59:00.566493920 +0200
@@ -2383,9 +2383,7 @@ again:
 				break;
 
 			bio->bi_next = req->bio;
-			req->cbio = req->bio = bio;
-			req->nr_cbio_segments = bio_segments(bio);
-			req->nr_cbio_sectors = bio_sectors(bio);
+			req->bio = bio;
 
 			/*
 			 * may not be valid. if the low level driver said
@@ -2457,11 +2455,9 @@ get_rq:
 	req->current_nr_sectors = req->hard_cur_sectors = cur_nr_sectors;
 	req->nr_phys_segments = bio_phys_segments(q, bio);
 	req->nr_hw_segments = bio_hw_segments(q, bio);
-	req->nr_cbio_segments = bio_segments(bio);
-	req->nr_cbio_sectors = bio_sectors(bio);
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
-	req->cbio = req->bio = req->biotail = bio;
+	req->bio = req->biotail = bio;
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
@@ -2642,83 +2638,6 @@ void submit_bio(int rw, struct bio *bio)
 
 EXPORT_SYMBOL(submit_bio);
 
-/**
- * blk_rq_next_segment
- * @rq:		the request being processed
- *
- * Description:
- *	Points to the next segment in the request if the current segment
- *	is complete. Leaves things unchanged if this segment is not over
- *	or if no more segments are left in this request.
- *
- *	Meant to be used for bio traversal during I/O submission
- *	Does not affect any I/O completions or update completion state
- *	in the request, and does not modify any bio fields.
- *
- *	Decrementing rq->nr_sectors, rq->current_nr_sectors and
- *	rq->nr_cbio_sectors as data is transferred is the caller's
- *	responsibility and should be done before calling this routine.
- **/
-void blk_rq_next_segment(struct request *rq)
-{
-	if (rq->current_nr_sectors > 0)
-		return;
-
-	if (rq->nr_cbio_sectors > 0) {
-		--rq->nr_cbio_segments;
-		rq->current_nr_sectors = blk_rq_vec(rq)->bv_len >> 9;
-	} else {
-		if ((rq->cbio = rq->cbio->bi_next)) {
-			rq->nr_cbio_segments = bio_segments(rq->cbio);
-			rq->nr_cbio_sectors = bio_sectors(rq->cbio);
- 			rq->current_nr_sectors = bio_cur_sectors(rq->cbio);
-		}
- 	}
-
-	/* remember the size of this segment before we start I/O */
-	rq->hard_cur_sectors = rq->current_nr_sectors;
-}
-
-/**
- * process_that_request_first	-	process partial request submission
- * @req:	the request being processed
- * @nr_sectors:	number of sectors I/O has been submitted on
- *
- * Description:
- *	May be used for processing bio's while submitting I/O without
- *	signalling completion. Fails if more data is requested than is
- *	available in the request in which case it doesn't advance any
- *	pointers.
- *
- *	Assumes a request is correctly set up. No sanity checks.
- *
- * Return:
- *	0 - no more data left to submit (not processed)
- *	1 - data available to submit for this request (processed)
- **/
-int process_that_request_first(struct request *req, unsigned int nr_sectors)
-{
-	unsigned int nsect;
-
-	if (req->nr_sectors < nr_sectors)
-		return 0;
-
-	req->nr_sectors -= nr_sectors;
-	req->sector += nr_sectors;
-	while (nr_sectors) {
-		nsect = min_t(unsigned, req->current_nr_sectors, nr_sectors);
-		req->current_nr_sectors -= nsect;
-		nr_sectors -= nsect;
-		if (req->cbio) {
-			req->nr_cbio_sectors -= nsect;
-			blk_rq_next_segment(req);
-		}
-	}
-	return 1;
-}
-
-EXPORT_SYMBOL(process_that_request_first);
-
 void blk_recalc_rq_segments(struct request *rq)
 {
 	struct bio *bio, *prevbio = NULL;
@@ -2754,8 +2673,7 @@ void blk_recalc_rq_sectors(struct reques
 		rq->hard_nr_sectors -= nsect;
 
 		/*
-		 * Move the I/O submission pointers ahead if required,
-		 * i.e. for drivers not aware of rq->cbio.
+		 * Move the I/O submission pointers ahead if required.
 		 */
 		if ((rq->nr_sectors >= rq->hard_nr_sectors) &&
 		    (rq->sector <= rq->hard_sector)) {
@@ -2763,11 +2681,7 @@ void blk_recalc_rq_sectors(struct reques
 			rq->nr_sectors = rq->hard_nr_sectors;
 			rq->hard_cur_sectors = bio_cur_sectors(rq->bio);
 			rq->current_nr_sectors = rq->hard_cur_sectors;
-			rq->nr_cbio_segments = bio_segments(rq->bio);
-			rq->nr_cbio_sectors = bio_sectors(rq->bio);
 			rq->buffer = bio_data(rq->bio);
-
-			rq->cbio = rq->bio;
 		}
 
 		/*
@@ -2979,33 +2893,13 @@ void blk_rq_bio_prep(request_queue_t *q,
 	rq->current_nr_sectors = bio_cur_sectors(bio);
 	rq->hard_cur_sectors = rq->current_nr_sectors;
 	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
-	rq->nr_cbio_segments = bio_segments(bio);
-	rq->nr_cbio_sectors = bio_sectors(bio);
 	rq->buffer = bio_data(bio);
 
-	rq->cbio = rq->bio = rq->biotail = bio;
+	rq->bio = rq->biotail = bio;
 }
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
 
-void blk_rq_prep_restart(struct request *rq)
-{
-	struct bio *bio;
-
-	bio = rq->cbio = rq->bio;
-	if (bio) {
-		rq->nr_cbio_segments = bio_segments(bio);
-		rq->nr_cbio_sectors = bio_sectors(bio);
-		rq->hard_cur_sectors = bio_cur_sectors(bio);
-		rq->buffer = bio_data(bio);
-	}
-	rq->sector = rq->hard_sector;
-	rq->nr_sectors = rq->hard_nr_sectors;
-	rq->current_nr_sectors = rq->hard_cur_sectors;
-}
-
-EXPORT_SYMBOL(blk_rq_prep_restart);
-
 int kblockd_schedule_work(struct work_struct *work)
 {
 	return queue_work(kblockd_workqueue, work);
diff -puN include/linux/blkdev.h~bio_walking include/linux/blkdev.h
--- linux-2.6.9-rc1-bk10/include/linux/blkdev.h~bio_walking	2004-09-08 19:59:00.553495896 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/include/linux/blkdev.h	2004-09-08 19:59:00.567493768 +0200
@@ -107,13 +107,7 @@ struct request {
 	/* no. of sectors left to complete in the current segment */
 	unsigned int hard_cur_sectors;
 
-	/* no. of segments left to submit in the current bio */
-	unsigned short nr_cbio_segments;
-	/* no. of sectors left to submit in the current bio */
-	unsigned long nr_cbio_sectors;
-
-	struct bio *cbio;		/* next bio to submit */
-	struct bio *bio;		/* next unfinished bio to complete */
+	struct bio *bio;
 	struct bio *biotail;
 
 	void *elevator_private;
@@ -444,32 +438,6 @@ static inline void blk_clear_queue_full(
  */
 #define blk_queue_headactive(q, head_active)
 
-/* current index into bio being processed for submission */
-#define blk_rq_idx(rq)	((rq)->cbio->bi_vcnt - (rq)->nr_cbio_segments)
-
-/* current bio vector being processed */
-#define blk_rq_vec(rq)	(bio_iovec_idx((rq)->cbio, blk_rq_idx(rq)))
-
-/* current offset with respect to start of the segment being submitted */
-#define blk_rq_offset(rq) \
-	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
-
-/*
- * temporarily mapping a (possible) highmem bio (typically for PIO transfer)
- */
-
-/* Assumes rq->cbio != NULL */
-static inline char * rq_map_buffer(struct request *rq, unsigned long *flags)
-{
-	return (__bio_kmap_irq(rq->cbio, blk_rq_idx(rq), flags)
-		+ blk_rq_offset(rq));
-}
-
-static inline void rq_unmap_buffer(char *buffer, unsigned long *flags)
-{
-	__bio_kunmap_irq(buffer, flags);
-}
-
 /*
  * q->prep_rq_fn return values
  */
@@ -568,7 +536,6 @@ static inline void blk_run_address_space
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *);
-extern int process_that_request_first(struct request *, unsigned int);
 extern void end_request(struct request *req, int uptodate);
 
 /*
@@ -637,7 +604,6 @@ extern void blk_queue_invalidate_tags(re
 extern long blk_congestion_wait(int rw, long timeout);
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
-extern void blk_rq_prep_restart(struct request *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);
 
 #define MAX_PHYS_SEGMENTS 128
_
