Return-Path: <linux-kernel-owner+w=401wt.eu-S1751768AbXAUX0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbXAUX0K (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXAUX0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:26:10 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:47380 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768AbXAUX0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:26:06 -0500
Message-ID: <45B3F64C.3030805@panasas.com>
Date: Mon, 22 Jan 2007 01:25:00 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 3/6] bidi support: bidirectional request
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:24:38.0787 (UTC) FILETIME=[52055530:01C73DB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Instantiate another request_io_part in request for bidi_read.
- Define & Implement new API for accessing bidi parts.
- API to Build bidi requests and map to sglists.
- Define new end_that_request_block() function to end a complete request.

Signed-off-by: Benny Halevy <bhalevy@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

---
 block/elevator.c       |    7 +---
 block/ll_rw_blk.c      |  113 ++++++++++++++++++++++++++++++++++++++++++------
 include/linux/blkdev.h |   49 ++++++++++++++++++++-
 3 files changed, 149 insertions(+), 20 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 0e9ea69..53b552e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -741,14 +741,9 @@ struct request *elv_next_request(request
 			rq = NULL;
 			break;
 		} else if (ret == BLKPREP_KILL) {
-			int nr_bytes = rq_uni(rq)->hard_nr_sectors << 9;
-
-			if (!nr_bytes)
-				nr_bytes = rq_uni(rq)->data_len;
-
 			blkdev_dequeue_request(rq);
 			rq->cmd_flags |= REQ_QUIET;
-			end_that_request_chunk(rq, 0, nr_bytes);
+			end_that_request_block(rq, 0);
 			end_that_request_last(rq, 0);
 		} else {
 			printk(KERN_ERR "%s: bad return=%d\n", __FUNCTION__,
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 7d46f6a..1358b35 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -261,6 +261,7 @@ static void rq_init(request_queue_t *q,
 	rq->end_io_data = NULL;
 	rq->completion_data = NULL;
 	rq_init_io_part(&rq->uni);
+	rq_init_io_part(&rq->bidi_read);
 }

 /**
@@ -1312,15 +1313,16 @@ static int blk_hw_contig_segment(request
 }

 /*
- * map a request to scatterlist, return number of sg entries setup. Caller
- * must make sure sg can hold rq->nr_phys_segments entries
+ * map a request_io_part to scatterlist, return number of sg entries setup.
+ * Caller must make sure sg can hold rq_io(rq, dir)->nr_phys_segments entries
  */
-int blk_rq_map_sg(request_queue_t *q, struct request *rq, struct scatterlist *sg)
+int blk_rq_map_sg_bidi(request_queue_t *q, struct request *rq,
+	struct scatterlist *sg, enum dma_data_direction dir)
 {
 	struct bio_vec *bvec, *bvprv;
 	struct bio *bio;
 	int nsegs, i, cluster;
-	struct request_io_part* req_io = rq_uni(rq);
+	struct request_io_part* req_io = rq_io(rq, dir);

 	nsegs = 0;
 	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
@@ -1362,6 +1364,17 @@ new_segment:
 	return nsegs;
 }

+EXPORT_SYMBOL(blk_rq_map_sg_bidi);
+
+/*
+ * map a request to scatterlist, return number of sg entries setup. Caller
+ * must make sure sg can hold rq->nr_phys_segments entries
+ */
+int blk_rq_map_sg(request_queue_t *q, struct request *rq, struct scatterlist *sg)
+{
+	return blk_rq_map_sg_bidi(q, rq, sg, rq->data_dir);
+}
+
 EXPORT_SYMBOL(blk_rq_map_sg);

 /*
@@ -2561,15 +2574,18 @@ int blk_rq_unmap_user(struct bio *bio)
 EXPORT_SYMBOL(blk_rq_unmap_user);

 /**
- * blk_rq_map_kern - map kernel data to a request, for REQ_BLOCK_PC usage
+ * blk_rq_map_kern_bidi - maps kernel data to a request_io_part, for BIDI usage
  * @q:		request queue where request should be inserted
  * @rq:		request to fill
  * @kbuf:	the kernel buffer
  * @len:	length of user data
  * @gfp_mask:	memory allocation flags
+ * @dir:        if it is a BIDIRECTIONAL request than DMA_TO_DEVICE to prepare
+ *              the bidi_write side or DMA_FROM_DEVICE to prepare the bidi_read
+ *              side, else it should be same as req->data_dir
  */
-int blk_rq_map_kern(request_queue_t *q, struct request *rq, void *kbuf,
-		    unsigned int len, gfp_t gfp_mask)
+int blk_rq_map_kern_bidi(request_queue_t *q, struct request *rq, void *kbuf,
+	unsigned int len, gfp_t gfp_mask, enum dma_data_direction dir)
 {
 	struct bio *bio;

@@ -2582,14 +2598,30 @@ int blk_rq_map_kern(request_queue_t *q,
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);

-	if (rq_uni_write_dir(rq) == WRITE)
+	if (dma_write_dir(dir))
 		bio->bi_rw |= (1 << BIO_RW);

-	blk_rq_bio_prep(q, rq, bio);
+	blk_rq_bio_prep_bidi(q, rq, bio ,dir);
 	rq->buffer = rq->data = NULL;
 	return 0;
 }

+EXPORT_SYMBOL(blk_rq_map_kern_bidi);
+
+/**
+ * blk_rq_map_kern - map kernel data to a request, for REQ_BLOCK_PC usage
+ * @q:		request queue where request should be inserted
+ * @rq:		request to fill
+ * @kbuf:	the kernel buffer
+ * @len:	length of user data
+ * @gfp_mask:	memory allocation flags
+ */
+int blk_rq_map_kern(request_queue_t *q, struct request *rq, void *kbuf,
+		    unsigned int len, gfp_t gfp_mask)
+{
+	return blk_rq_map_kern_bidi( q, rq, kbuf, len, gfp_mask, rq->data_dir);
+}
+
 EXPORT_SYMBOL(blk_rq_map_kern);

 /**
@@ -3353,11 +3385,11 @@ static void blk_recalc_rq_sectors(struct
 }

 static int __end_that_request_first(struct request *req, int uptodate,
-				    int nr_bytes)
+				    int nr_bytes, enum dma_data_direction dir)
 {
 	int total_bytes, bio_nbytes, error, next_idx = 0;
 	struct bio *bio;
-	struct request_io_part* req_io = rq_uni(req);
+	struct request_io_part* req_io = rq_io(req, dir);

 	blk_add_trace_rq(req->q, req, BLK_TA_COMPLETE);

@@ -3447,6 +3479,8 @@ static int __end_that_request_first(stru
 	if (!req_io->bio)
 		return 0;

+	WARN_ON(rq_bidi_dir(req));
+
 	/*
 	 * if the request wasn't completed, update state
 	 */
@@ -3479,7 +3513,7 @@ static int __end_that_request_first(stru
  **/
 int end_that_request_first(struct request *req, int uptodate, int nr_sectors)
 {
-	return __end_that_request_first(req, uptodate, nr_sectors << 9);
+	return end_that_request_chunk(req, uptodate, nr_sectors << 9);
 }

 EXPORT_SYMBOL(end_that_request_first);
@@ -3501,11 +3535,55 @@ EXPORT_SYMBOL(end_that_request_first);
  **/
 int end_that_request_chunk(struct request *req, int uptodate, int nr_bytes)
 {
-	return __end_that_request_first(req, uptodate, nr_bytes);
+	WARN_ON_BIDI_FLAG(req);
+	WARN_ON(!rq_uni_dir(req));
+	return __end_that_request_first(req, uptodate, nr_bytes,
+		rq_uni_dir(req) ? rq_dma_dir(req) : DMA_TO_DEVICE);
 }

 EXPORT_SYMBOL(end_that_request_chunk);

+static void __end_req_io_block(struct request_io_part *req_io, int error)
+{
+	struct bio *next, *bio = req_io->bio;
+	req_io->bio = NULL;
+
+	for (; bio; bio = next) {
+		next = bio->bi_next;
+		bio_endio(bio, bio->bi_size, error);
+	}
+}
+
+/**
+ * end_that_request_block - end ALL I/O on a request in one "shloop",
+ * including the bidi part.
+ * @req:      the request being processed
+ * @uptodate: 1 for success, 0 for I/O error, < 0 for specific error
+ *
+ * Description:
+ *     Ends ALL I/O on @req, both read/write or bidi. frees all bio resources.
+ **/
+void end_that_request_block(struct request *req, int uptodate)
+{
+	if (blk_pc_request(req)) {
+		int error = 0;
+		if (end_io_error(uptodate))
+			error = !uptodate ? -EIO : uptodate;
+		blk_add_trace_rq(req->q, req, BLK_TA_COMPLETE);
+
+		__end_req_io_block(&req->uni, error);
+		if (rq_bidi_dir(req))
+			__end_req_io_block(&req->bidi_read, 0);
+	} else { /* needs elevator bookeeping */
+		int nr_bytes = req->uni.hard_nr_sectors << 9;
+		if (!nr_bytes)
+			nr_bytes = req->uni.data_len;
+		end_that_request_chunk(req, uptodate, nr_bytes);
+	}
+}
+
+EXPORT_SYMBOL(end_that_request_block);
+
 /*
  * splice the completion data to a local structure and hand off to
  * process_completion_queue() to complete the requests
@@ -3633,6 +3711,15 @@ void end_request(struct request *req, in

 EXPORT_SYMBOL(end_request);

+void blk_rq_bio_prep_bidi(request_queue_t *q, struct request *rq,
+	struct bio *bio, enum dma_data_direction dir)
+{
+	init_req_io_part_from_bio(q, rq_io(rq, dir), bio);
+	rq->buffer = NULL;
+}
+
+EXPORT_SYMBOL(blk_rq_bio_prep_bidi);
+
 void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct bio *bio)
 {
 	rq->data_dir = bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3cabbaf..eff3960 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -323,6 +323,7 @@ struct request {
 	void *end_io_data;
 	
 	struct request_io_part uni;
+	struct request_io_part bidi_read;
 };

 /*
@@ -599,6 +600,27 @@ static inline struct request_io_part* rq
 	return &req->uni;
 }

+static inline struct request_io_part* rq_in(struct request* req)
+{
+	WARN_ON_BIDI_FLAG(req);
+	if (likely(rq_dma_dir(req) != DMA_BIDIRECTIONAL))
+		return &req->uni;
+
+	if (likely(req->cmd_flags & REQ_BIDI))
+		return &req->bidi_read;	
+
+	return &req->uni;
+}
+
+static inline struct request_io_part* rq_io(struct request* req, enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE)
+		return rq_in(req);
+
+	WARN_ON( (dir != DMA_TO_DEVICE) && (dir != DMA_NONE) );
+	return &req->uni;
+}
+
 /*
  * We regard a request as sync, if it's a READ or a SYNC write.
  */
@@ -636,7 +658,8 @@ static inline void blk_clear_queue_full(
 #define RQ_NOMERGE_FLAGS	\
 	(REQ_NOMERGE | REQ_STARTED | REQ_HARDBARRIER | REQ_SOFTBARRIER)
 #define rq_mergeable(rq)	\
-	(!((rq)->cmd_flags & RQ_NOMERGE_FLAGS) && blk_fs_request((rq)))
+	(!((rq)->cmd_flags & RQ_NOMERGE_FLAGS) && blk_fs_request((rq)) && \
+	((rq)->data_dir != DMA_BIDIRECTIONAL))

 /*
  * q->prep_rq_fn return values
@@ -767,6 +790,15 @@ extern void end_request(struct request *
 extern void blk_complete_request(struct request *);

 /*
+ * end_request_block will complete and free all bio resources held
+ * by the request in one call. User will still need to call
+ * end_that_request_last(..).
+ * It is the only one that can deal with BIDI.
+ * can be called for parial bidi allocation and cleanup.
+ */
+extern void end_that_request_block(struct request *req, int uptodate);
+
+/*
  * end_that_request_first/chunk() takes an uptodate argument. we account
  * any value <= as an io error. 0 means -EIO for compatability reasons,
  * any other < 0 value is the direct error type. An uptodate value of
@@ -845,6 +877,21 @@ static inline struct request *blk_map_qu
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);

+/* BIDI API
+ * build a request. for bidi requests must be called twice to map/prepare
+ * the data-in and data-out buffers, one at a time according to
+ * the given dma_data_direction.
+ */
+extern void blk_rq_bio_prep_bidi(request_queue_t *, struct request *,
+	struct bio *, enum dma_data_direction);
+extern int blk_rq_map_kern_bidi(request_queue_t *, struct request *,
+	void *, unsigned int, gfp_t, enum dma_data_direction);
+/* retrieve the mapped pages for bidi according to
+ * the given dma_data_direction
+ */
+extern int blk_rq_map_sg_bidi(request_queue_t *, struct request *,
+	struct scatterlist *, enum dma_data_direction);
+
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
 #define SAFE_MAX_SECTORS 255
-- 
