Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281893AbRLKQy6>; Tue, 11 Dec 2001 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281908AbRLKQyu>; Tue, 11 Dec 2001 11:54:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35088 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281893AbRLKQyg>;
	Tue, 11 Dec 2001 11:54:36 -0500
Date: Tue, 11 Dec 2001 17:54:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211165426.GD13498@suse.de>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com> <20011211164744.GC13498@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011211164744.GC13498@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Jens Axboe wrote:
> On Tue, Dec 11 2001, Paul Larson wrote:
> > My hardware is a dual proc PII-300.  I was running LTP runalltests.sh
> > and it was on one of the growfiles tests when this problem occurred. 
> > The test hung, and I couldn't telnet into the machine or login to it,
> > but I could switch between VC's.  On the console, I had screenfulls of
> > errors like this:
> > 
> > Incorrect number of segments after building list
> > counted 11, received 7
> 
> Attached patch should fix it.

Aghr, here it is. Linus, please apply to 2.5.1-pre9.

(and yes note how the differences between the stock and scsi merge
functons are getting smaller -- in fact, we can complete merge the two
now)

diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.1-pre9/drivers/block/ll_rw_blk.c	Tue Dec 11 05:01:50 2001
+++ linux/drivers/block/ll_rw_blk.c	Tue Dec 11 11:48:43 2001
@@ -358,6 +358,8 @@
 
 	if (!BIO_CONTIG(bio, nxt))
 		return 0;
+	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
+		return 0;
 
 	/*
 	 * bio and nxt are contigous in memory, check if the queue allows
@@ -429,8 +431,10 @@
  * specific ones if so desired
  */
 static inline int ll_new_segment(request_queue_t *q, struct request *req,
-				 struct bio *bio, int nr_segs)
+				 struct bio *bio)
 {
+	int nr_segs = bio_hw_segments(q, bio);
+
 	if (req->nr_segments + nr_segs <= q->max_segments) {
 		req->nr_segments += nr_segs;
 		return 1;
@@ -443,41 +447,23 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct bio *bio)
 {
-	int bio_segs;
-
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		return 0;
 	}
 
-	bio_segs = bio_hw_segments(q, bio);
-	if (blk_contig_segment(q, req->biotail, bio))
-		bio_segs--;
-
-	if (!bio_segs)
-		return 1;
-
-	return ll_new_segment(q, req, bio, bio_segs);
+	return ll_new_segment(q, req, bio);
 }
 
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct bio *bio)
 {
-	int bio_segs;
-
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		return 0;
 	}
 
-	bio_segs = bio_hw_segments(q, bio);
-	if (blk_contig_segment(q, bio, req->bio))
-		bio_segs--;
-
-	if (!bio_segs)
-		return 1;
-
-	return ll_new_segment(q, req, bio, bio_segs);
+	return ll_new_segment(q, req, bio);
 }
 
 static int ll_merge_requests_fn(request_queue_t *q, struct request *req,
@@ -1235,11 +1221,6 @@
 			break;
 		}
 
-		/*
-		 * this needs to be handled by q->make_request_fn, to just
-		 * setup a part of the bio in the request to enable easy
-		 * multiple passing
-		 */
 		BUG_ON(bio_sectors(bio) > q->max_sectors);
 
 		/*
@@ -1497,6 +1478,7 @@
 	while ((bio = req->bio)) {
 		nsect = bio_iovec(bio)->bv_len >> 9;
 
+		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
 
 		/*
 		 * not a complete bvec done
@@ -1515,11 +1497,12 @@
 		 * account transfer
 		 */
 		bio->bi_size -= bio_iovec(bio)->bv_len;
+		bio->bi_idx++;
 
 		nr_sectors -= nsect;
 		total_nsect += nsect;
 
-		if (++bio->bi_idx >= bio->bi_vcnt) {
+		if (!bio->bi_size) {
 			req->bio = bio->bi_next;
 
 			if (unlikely(bio_endio(bio, uptodate, total_nsect)))
@@ -1619,7 +1602,9 @@
 EXPORT_SYMBOL(blk_queue_max_segments);
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 EXPORT_SYMBOL(blk_queue_hardsect_size);
+EXPORT_SYMBOL(blk_queue_segment_boundary);
 EXPORT_SYMBOL(blk_rq_map_sg);
 EXPORT_SYMBOL(blk_nohighio);
 EXPORT_SYMBOL(blk_dump_rq_flags);
 EXPORT_SYMBOL(submit_bio);
+EXPORT_SYMBOL(blk_contig_segment);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- /opt/kernel/linux-2.5.1-pre9/drivers/scsi/ide-scsi.c	Tue Dec 11 05:01:51 2001
+++ linux/drivers/scsi/ide-scsi.c	Tue Dec 11 09:24:14 2001
@@ -261,7 +261,7 @@
 	ide_drive_t *drive = hwgroup->drive;
 	idescsi_scsi_t *scsi = drive->driver_data;
 	struct request *rq = hwgroup->rq;
-	idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
+	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	struct Scsi_Host *host;
 	u8 *scsi_buf;
@@ -464,7 +464,7 @@
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->flags & REQ_SPECIAL) {
-		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->buffer);
+		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->special);
 	}
 	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
 	idescsi_end_request (0,HWGROUP (drive));
@@ -662,6 +662,7 @@
 	if ((first_bh = bhp = bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
 		goto abort;
 	bio_init(bh);
+	bh->bi_vcnt = 1;
 	while (--count) {
 		if ((bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
 			goto abort;
@@ -802,7 +803,7 @@
 	}
 
 	ide_init_drive_cmd (rq);
-	rq->buffer = (char *) pc;
+	rq->special = (char *) pc;
 	rq->bio = idescsi_dma_bio (drive, pc);
 	rq->flags = REQ_SPECIAL;
 	spin_unlock(&cmd->host->host_lock);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/drivers/scsi/scsi_merge.c linux/drivers/scsi/scsi_merge.c
--- /opt/kernel/linux-2.5.1-pre9/drivers/scsi/scsi_merge.c	Tue Dec 11 05:01:51 2001
+++ linux/drivers/scsi/scsi_merge.c	Tue Dec 11 11:44:03 2001
@@ -205,8 +205,10 @@
 
 static inline int scsi_new_mergeable(request_queue_t * q,
 				     struct request * req,
-				     int nr_segs)
+				     struct bio *bio)
 {
+	int nr_segs = bio_hw_segments(q, bio);
+
 	/*
 	 * pci_map_sg will be able to merge these two
 	 * into a single hardware sg entry, check if
@@ -223,8 +225,9 @@
 
 static inline int scsi_new_segment(request_queue_t * q,
 				   struct request * req,
-				   struct bio *bio, int nr_segs)
+				   struct bio *bio)
 {
+	int nr_segs = bio_hw_segments(q, bio);
 	/*
 	 * pci_map_sg won't be able to map these two
 	 * into a single hardware sg entry, so we have to
@@ -244,8 +247,10 @@
 
 static inline int scsi_new_segment(request_queue_t * q,
 				   struct request * req,
-				   struct bio *bio, int nr_segs)
+				   struct bio *bio)
 {
+	int nr_segs = bio_hw_segments(q, bio);
+
 	if (req->nr_segments + nr_segs > q->max_segments) {
 		req->flags |= REQ_NOMERGE;
 		return 0;
@@ -296,45 +301,33 @@
 					 struct request *req,
 					 struct bio *bio)
 {
-	int bio_segs;
-
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		return 0;
 	}
 
-	bio_segs = bio_hw_segments(q, bio);
-	if (blk_contig_segment(q, req->biotail, bio))
-		bio_segs--;
-
 #ifdef DMA_CHUNK_SIZE
 	if (MERGEABLE_BUFFERS(bio, req->bio))
-		return scsi_new_mergeable(q, req, bio_segs);
+		return scsi_new_mergeable(q, req, bio);
 #endif
 
-	return scsi_new_segment(q, req, bio, bio_segs);
+	return scsi_new_segment(q, req, bio);
 }
 
 __inline static int __scsi_front_merge_fn(request_queue_t * q,
 					  struct request *req,
 					  struct bio *bio)
 {
-	int bio_segs;
-
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		return 0;
 	}
 
-	bio_segs = bio_hw_segments(q, bio);
-	if (blk_contig_segment(q, req->biotail, bio))
-		bio_segs--;
-
 #ifdef DMA_CHUNK_SIZE
 	if (MERGEABLE_BUFFERS(bio, req->bio))
-		return scsi_new_mergeable(q, req, bio_segs);
+		return scsi_new_mergeable(q, req, bio);
 #endif
-	return scsi_new_segment(q, req, bio, bio_segs);
+	return scsi_new_segment(q, req, bio);
 }
 
 /*
@@ -370,32 +363,23 @@
 MERGEFCT(scsi_front_merge_fn, front)
 
 /*
- * Function:    __scsi_merge_requests_fn()
+ * Function:    scsi_merge_requests_fn_()
  *
- * Purpose:     Prototype for queue merge function.
+ * Purpose:     queue merge function.
  *
  * Arguments:   q       - Queue for which we are merging request.
  *              req     - request into which we wish to merge.
- *              next    - 2nd request that we might want to combine with req
- *              dma_host - 1 if this host has ISA DMA issues (bus doesn't
- *                      expose all of the address lines, so that DMA cannot
- *                      be done from an arbitrary address).
+ *              next    - Block which we may wish to merge into request
  *
- * Returns:     1 if it is OK to merge the two requests.  0
+ * Returns:     1 if it is OK to merge the block into the request.  0
  *              if it is not OK.
  *
  * Lock status: queue lock is assumed to be held here.
  *
- * Notes:       Some drivers have limited scatter-gather table sizes, and
- *              thus they cannot queue an infinitely large command.  This
- *              function is called from ll_rw_blk before it attempts to merge
- *              a new block into a request to make sure that the request will
- *              not become too large.
  */
-__inline static int __scsi_merge_requests_fn(request_queue_t * q,
-					     struct request *req,
-					     struct request *next,
-					     int dma_host)
+inline static int scsi_merge_requests_fn(request_queue_t * q,
+					 struct request *req,
+					 struct request *next)
 {
 	int bio_segs;
 
@@ -446,35 +430,6 @@
 }
 
 /*
- * Function:    scsi_merge_requests_fn_()
- *
- * Purpose:     queue merge function.
- *
- * Arguments:   q       - Queue for which we are merging request.
- *              req     - request into which we wish to merge.
- *              bio     - Block which we may wish to merge into request
- *
- * Returns:     1 if it is OK to merge the block into the request.  0
- *              if it is not OK.
- *
- * Lock status: queue lock is assumed to be held here.
- *
- * Notes:       Optimized for different cases depending upon whether
- *              ISA DMA is in use and whether clustering should be used.
- */
-#define MERGEREQFCT(_FUNCTION, _DMA)			\
-static int _FUNCTION(request_queue_t * q,		\
-		     struct request * req,		\
-		     struct request * next)		\
-{							\
-    int ret;						\
-    ret =  __scsi_merge_requests_fn(q, req, next, _DMA); \
-    return ret;						\
-}
-
-MERGEREQFCT(scsi_merge_requests_fn_, 0)
-MERGEREQFCT(scsi_merge_requests_fn_d, 1)
-/*
  * Function:    __init_io()
  *
  * Purpose:     Prototype for io initialize function.
@@ -811,15 +766,13 @@
 	 * is simply easier to do it ourselves with our own functions
 	 * rather than rely upon the default behavior of ll_rw_blk.
 	 */
+	q->back_merge_fn = scsi_back_merge_fn;
+	q->front_merge_fn = scsi_front_merge_fn;
+	q->merge_requests_fn = scsi_merge_requests_fn;
+
 	if (SHpnt->unchecked_isa_dma == 0) {
-		q->back_merge_fn = scsi_back_merge_fn;
-		q->front_merge_fn = scsi_front_merge_fn;
-		q->merge_requests_fn = scsi_merge_requests_fn_;
 		SDpnt->scsi_init_io_fn = scsi_init_io_v;
 	} else {
-		q->back_merge_fn = scsi_back_merge_fn;
-		q->front_merge_fn = scsi_front_merge_fn;
-		q->merge_requests_fn = scsi_merge_requests_fn_d;
 		SDpnt->scsi_init_io_fn = scsi_init_io_vd;
 	}
 
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/fs/bio.c linux/fs/bio.c
--- /opt/kernel/linux-2.5.1-pre9/fs/bio.c	Tue Dec 11 05:01:51 2001
+++ linux/fs/bio.c	Tue Dec 11 05:31:25 2001
@@ -481,32 +481,6 @@
 	return 0;
 }
 
-/*
- * obviously doesn't work for stacking drivers, but ll_rw_blk will split
- * bio for those
- */
-int get_max_segments(kdev_t dev)
-{
-	int segments = MAX_SEGMENTS;
-	request_queue_t *q;
-
-	if ((q = blk_get_queue(dev)))
-		segments = q->max_segments;
-
-	return segments;
-}
-
-int get_max_sectors(kdev_t dev)
-{
-	int sectors = MAX_SECTORS;
-	request_queue_t *q;
-
-	if ((q = blk_get_queue(dev)))
-		sectors = q->max_sectors;
-
-	return sectors;
-}
-
 /**
  * ll_rw_kio - submit a &struct kiobuf for I/O
  * @rw:   %READ or %WRITE
@@ -522,7 +496,6 @@
 void ll_rw_kio(int rw, struct kiobuf *kio, kdev_t dev, sector_t sector)
 {
 	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
-	int max_bytes, max_segments;
 	struct bio_vec *bvec;
 	struct bio *bio;
 
@@ -539,19 +512,6 @@
 	}
 
 	/*
-	 * rudimentary max sectors/segments checks and setup. once we are
-	 * sure that drivers can handle requests that cannot be completed in
-	 * one go this will die
-	 */
-	max_bytes = get_max_sectors(dev) << 9;
-	max_segments = get_max_segments(dev);
-	if ((max_bytes >> PAGE_SHIFT) < (max_segments + 1))
-		max_segments = (max_bytes >> PAGE_SHIFT);
-
-	if (max_segments > BIO_MAX_PAGES)
-		max_segments = BIO_MAX_PAGES;
-
-	/*
 	 * maybe kio is bigger than the max we can easily map into a bio.
 	 * if so, split it up in appropriately sized chunks.
 	 */
@@ -564,9 +524,11 @@
 	map_i = 0;
 
 next_chunk:
+	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
+	if (nr_pages > total_nr_pages)
+		nr_pages = total_nr_pages;
+
 	atomic_inc(&kio->io_count);
-	if ((nr_pages = total_nr_pages) > max_segments)
-		nr_pages = max_segments;
 
 	/*
 	 * allocate bio and do initial setup
@@ -591,7 +553,7 @@
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > max_bytes)
+		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
 			goto queue_io;
 
 		bio->bi_vcnt++;
@@ -714,3 +676,4 @@
 EXPORT_SYMBOL(bio_copy);
 EXPORT_SYMBOL(__bio_clone);
 EXPORT_SYMBOL(bio_clone);
+EXPORT_SYMBOL(bio_hw_segments);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/fs/partitions/acorn.c linux/fs/partitions/acorn.c
--- /opt/kernel/linux-2.5.1-pre9/fs/partitions/acorn.c	Mon Oct  1 23:03:26 2001
+++ linux/fs/partitions/acorn.c	Tue Dec 11 06:39:47 2001
@@ -162,12 +162,12 @@
 		struct adfs_discrecord *dr;
 		unsigned int nr_sects;
 
-		if (!(minor & mask))
-			break;
-
 		data = read_dev_sector(bdev, start_blk * 2 + 6, &sect);
 		if (!data)
 			return -1;
+
+		if (!(minor & mask))
+			break;
 
 		dr = adfs_partition(hd, name, data, first_sector, minor++);
 		if (!dr)
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/fs/partitions/check.h linux/fs/partitions/check.h
--- /opt/kernel/linux-2.5.1-pre9/fs/partitions/check.h	Tue Dec 11 05:01:51 2001
+++ linux/fs/partitions/check.h	Tue Dec 11 06:43:31 2001
@@ -1,3 +1,5 @@
+#include <linux/pagemap.h>
+
 /*
  * add_gd_partition adds a partitions details to the devices partition
  * description.
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre9/include/linux/bio.h linux/include/linux/bio.h
--- /opt/kernel/linux-2.5.1-pre9/include/linux/bio.h	Tue Dec 11 05:01:51 2001
+++ linux/include/linux/bio.h	Tue Dec 11 05:50:25 2001
@@ -28,6 +28,8 @@
 #define BIO_BUG_ON
 #endif
 
+#define BIO_MAX_SECTORS	128
+
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
@@ -60,7 +62,7 @@
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 	unsigned short		bi_idx;		/* current index into bvl_vec */
 	unsigned short		bi_hw_seg;	/* actual mapped segments */
-	unsigned int		bi_size;	/* total size in bytes */
+	unsigned int		bi_size;	/* residual I/O count */
 	unsigned int		bi_max;		/* max bvl_vecs we can hold,
 						   used as index into pool */
 

-- 
Jens Axboe

