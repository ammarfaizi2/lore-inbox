Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSIDHsb>; Wed, 4 Sep 2002 03:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319099AbSIDHsb>; Wed, 4 Sep 2002 03:48:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2992 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319097AbSIDHsM>;
	Wed, 4 Sep 2002 03:48:12 -0400
Date: Wed, 4 Sep 2002 13:22:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Bio traversal patches - update for 2.5.33 (sans ide changes)
Message-ID: <20020904132226.A10941@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> BIO traversal enhancements
> --------------------------
> - Pre-req for full BIO splitting infrastructure [Splits
>   in the middle of a segment can also share the same vec]
> - Pre-req for attaching a pre-built vector (not owned by block)
>   to a bio (e.g for aio)  [Avoids certain subtle side-effects in special
>   cases like partial segment completion]
> - Pre-req for IDE mult-count PIO write fixes w/o request copy
>   [Ability to traverse a bio partially for i/o submission without
>   effecting bio completion]
> 
> Introduces some new fields in the bio and request to help maintain
> traversal state and handle partial segment bio clones, and comes with a
> corresponding set of helpers to enable clean separation of traversal for
> i/o submission vs i/o completion.
> 

Latest patch for 2.5.33 (dropped the ide, ide-scsi changes for now as 
mentioned in my last mail). This is a rollup patch combining the core 
and fs changes and some initial compatibility modifications to certain 
drivers.  Its fairly easy to split these as before (as they affect 
different files), so let me know if that would be useful.

The biodoc update patch has not changed since the last posting, 
so not including it in this rollup, but can resend if required
along with the introductory mail about specific changes made and
things drivers might need to take care of.

Regards
Suparna

diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/elevator.c linux-2.5.33-bio/drivers/block/elevator.c
--- linux-2.5.33/drivers/block/elevator.c	Sun Sep  1 03:35:31 2002
+++ linux-2.5.33-bio/drivers/block/elevator.c	Wed Sep  4 10:50:51 2002
@@ -236,6 +236,9 @@
 	if (!insert_here)
 		insert_here = q->queue_head.prev;
 
+	if (rq->bio) 
+		BIO_BUG_ON(!bio_consistent(rq->bio)); /* debug only */
+
 	if (!(rq->flags & REQ_BARRIER))
 		lat = latency[rq_data_dir(rq)];
 
@@ -309,6 +312,9 @@
 void elevator_noop_add_request(request_queue_t *q, struct request *rq,
 			       struct list_head *insert_here)
 {
+	if (rq->bio) 
+		BIO_BUG_ON(!bio_consistent(rq->bio)); /* debug only */
+
 	list_add_tail(&rq->queuelist, &q->queue_head);
 
 	/*
@@ -389,6 +395,9 @@
 void __elv_add_request(request_queue_t *q, struct request *rq,
 			  struct list_head *insert_here)
 {
+	if (rq->bio) 
+		BIO_BUG_ON(!bio_consistent(rq->bio)); /* debug only */
+
 	q->elevator.elevator_add_req_fn(q, rq, insert_here);
 }
 
@@ -412,7 +421,19 @@
 
 		/*
 		 * all ok, break and return it
+		 * after presetting some fields (e.g. the req might
+		 * have been restarted)
 		 */
+		if ((rq->bio = rq->hard_bio)) {
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+			rq->hard_cur_sectors = bio_segsize(rq->bio) >> 9;
+			rq->buffer = bio_data(rq->bio);
+		}
+		rq->sector = rq->hard_sector;
+		rq->nr_sectors = rq->hard_nr_sectors;
+		rq->current_nr_sectors = rq->hard_cur_sectors;
+
 		if (!q->prep_rq_fn(q, rq))
 			break;
 
@@ -426,6 +447,9 @@
 		end_that_request_last(rq);
 	}
 
+	if (rq->bio) 
+		BIO_BUG_ON(!bio_consistent(rq->bio)); /* debug only */
+
 	return rq;
 }
 
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/floppy.c linux-2.5.33-bio/drivers/block/floppy.c
--- linux-2.5.33/drivers/block/floppy.c	Sun Sep  1 03:34:50 2002
+++ linux-2.5.33-bio/drivers/block/floppy.c	Wed Sep  4 10:50:58 2002
@@ -2480,6 +2480,9 @@
 	size = 0;
 
 	rq_for_each_bio(bio, CURRENT) {
+		/* Can't handle arbitrary split bio pieces */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
 		bio_for_each_segment(bv, bio, i) {
 			if (page_address(bv->bv_page) + bv->bv_offset != base + size)
 				break;
@@ -2547,6 +2550,9 @@
 	size = CURRENT->current_nr_sectors << 9;
 
 	rq_for_each_bio(bio, CURRENT) {
+		/* Can't handle arbitrary bio pieces as yet */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
 		bio_for_each_segment(bv, bio, i) {
 			if (!remaining)
 				break;
@@ -3899,6 +3905,9 @@
 	bio.bi_vcnt = 1;
 	bio.bi_idx = 0;
 	bio.bi_size = size;
+	bio.bi_voffset = __BVEC_START(&bio)->bv_offset;
+	bio.bi_endvoffset = __BVEC_END(&bio)->bv_offset +
+		__BVEC_END(&bio)->bv_len;
 	bio.bi_bdev = bdev;
 	bio.bi_sector = 0;
 	init_completion(&complete);
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/ll_rw_blk.c linux-2.5.33-bio/drivers/block/ll_rw_blk.c
--- linux-2.5.33/drivers/block/ll_rw_blk.c	Sun Sep  1 03:34:49 2002
+++ linux-2.5.33-bio/drivers/block/ll_rw_blk.c	Wed Sep  4 10:50:51 2002
@@ -569,10 +569,21 @@
 {
 	struct bio_vec *bv, *bvprv = NULL;
 	int i, nr_phys_segs, nr_hw_segs, seg_size, cluster;
+	int offset;
 
 	if (unlikely(!bio->bi_io_vec))
 		return;
 
+	if (unlikely(bio->bi_idx >= bio->bi_vcnt))
+		return;
+
+	/*
+	 * Relative offset into the first bvec where the data for
+	 * this bio starts (may be non-zero for cloned bio split off
+	 * in the middle of a segment)
+	 */
+	offset = bio_startoffset(bio);
+
 	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
 	seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
@@ -580,8 +591,12 @@
 			int phys, seg;
 
 			if (seg_size + bv->bv_len > q->max_segment_size) {
-				nr_phys_segs++;
-				goto new_segment;
+				if ((i != bio->bi_vcnt - 1) ||
+				(seg_size + bio->bi_endvoffset - bv->bv_offset
+				 > q->max_segment_size)) {
+					nr_phys_segs++;
+					goto new_segment;
+				}
 			}
 
 			phys = BIOVEC_PHYS_MERGEABLE(bvprv, bv);
@@ -599,11 +614,17 @@
 			continue;
 		} else {
 			nr_phys_segs++;
+			nr_hw_segs++;
+			seg_size = bv->bv_len - offset;
+			bvprv = bv;
+			offset = 0; /* for all except the first bv */
+			continue;
 		}
 new_segment:
 		nr_hw_segs++;
 		bvprv = bv;
 		seg_size = bv->bv_len;
+		offset = 0; /* for all except the first bv */
 	}
 
 	bio->bi_phys_segments = nr_phys_segs;
@@ -618,7 +639,8 @@
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
 		return 0;
 
-	if (!BIOVEC_PHYS_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
+	if (!BIOVEC_PHYS_MERGEABLE_PARTIAL(__BVEC_END(bio), bio->bi_endvoffset,
+			__BVEC_START(nxt), nxt->bi_voffset))
 		return 0;
 	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
 		return 0;
@@ -639,7 +661,8 @@
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
 		return 0;
 
-	if (!BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
+	if (!BIOVEC_VIRT_MERGEABLE_PARTIAL(__BVEC_END(bio), bio->bi_endvoffset,
+				__BVEC_START(nxt), nxt->bi_voffset))
 		return 0;
 	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
 		return 0;
@@ -663,6 +686,7 @@
 	struct bio_vec *bvec, *bvprv;
 	struct bio *bio;
 	int nsegs, i, cluster;
+	int offset, endoffset;
 
 	nsegs = 0;
 	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
@@ -671,20 +695,27 @@
 	 * for each bio in rq
 	 */
 	bvprv = NULL;
+	endoffset = 0;
 	rq_for_each_bio(bio, rq) {
 		/*
 		 * for each segment in bio
 		 */
+		offset = bio_startoffset(bio);
 		bio_for_each_segment(bvec, bio, i) {
-			int nbytes = bvec->bv_len;
+			int nbytes = bvec->bv_len - offset;
+			int start = bvec->bv_offset + offset;
 
 			if (bvprv && cluster) {
+				int end = bvprv->bv_offset + bvprv->bv_len - 
+					endoffset;
 				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
 					goto new_segment;
 
-				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
+				if (!BIOVEC_PHYS_MERGEABLE_PARTIAL(bvprv, 
+					end, bvec, start))
 					goto new_segment;
-				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
+				if (!BIOVEC_SEG_BOUNDARY_PARTIAL(q, bvprv, 
+					end, bvec, start))
 					goto new_segment;
 
 				sg[nsegs - 1].length += nbytes;
@@ -693,12 +724,16 @@
 				memset(&sg[nsegs],0,sizeof(struct scatterlist));
 				sg[nsegs].page = bvec->bv_page;
 				sg[nsegs].length = nbytes;
-				sg[nsegs].offset = bvec->bv_offset;
+				sg[nsegs].offset = bvec->bv_offset + offset;
 
 				nsegs++;
 			}
 			bvprv = bvec;
+			offset = 0;
+			endoffset = 0;
 		} /* segments in bio */
+		sg[nsegs - 1].length -= bio_endoffset(bio);
+		endoffset = bio_endoffset(bio);
 	} /* bios in rq */
 
 	return nsegs;
@@ -761,7 +796,9 @@
 		return 0;
 	}
 
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(req->biotail), __BVEC_START(bio)))
+	if (BIOVEC_VIRT_MERGEABLE_PARTIAL(__BVEC_END(req->biotail),
+				req->biotail->bi_endvoffset,
+				__BVEC_START(bio), bio->bi_voffset))
 		return ll_new_mergeable(q, req, bio);
 
 	return ll_new_hw_segment(q, req, bio);
@@ -776,7 +813,8 @@
 		return 0;
 	}
 
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(req->bio)))
+	if (BIOVEC_VIRT_MERGEABLE_PARTIAL(__BVEC_END(bio), bio->bi_endvoffset,
+				__BVEC_START(req->bio), req->bio->bi_voffset))
 		return ll_new_mergeable(q, req, bio);
 
 	return ll_new_hw_segment(q, req, bio);
@@ -1470,7 +1508,8 @@
 
 	sector = bio->bi_sector;
 	nr_sectors = bio_sectors(bio);
-	cur_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+	cur_nr_sectors = bio_segsize(bio) >> 9;
+
 	rw = bio_data_dir(bio);
 
 	/*
@@ -1520,8 +1559,12 @@
 				break;
 			}
 
+
 			bio->bi_next = req->bio;
-			req->bio = bio;
+			req->hard_bio = req->bio = bio;
+			req->nr_bio_segments = bio_segments(req->bio);
+			req->nr_bio_sectors = bio_sectors(req->bio);
+
 			/*
 			 * may not be valid. if the low level driver said
 			 * it didn't need a bounce buffer then it better
@@ -1600,7 +1643,9 @@
 	req->nr_hw_segments = bio_hw_segments(q, bio);
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
-	req->bio = req->biotail = bio;
+ 	req->hard_bio = req->bio = req->biotail = bio;
+ 	req->nr_bio_segments = bio_segments(req->bio);
+ 	req->nr_bio_sectors = bio_sectors(req->bio);
 	req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
 	add_request(q, req, insert_here);
 out:
@@ -1749,6 +1794,10 @@
 
 	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
+	BIO_BUG_ON(bio->bi_idx >= bio->bi_vcnt);
+
+	/* This is in now for debugging purposes */
+	BIO_BUG_ON(!bio_consistent(bio));
 
 	bio->bi_rw = rw;
 
@@ -1799,6 +1848,8 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = bh->b_size;
+	bio->bi_voffset = bio->bi_io_vec[0].bv_offset;
+	bio->bi_endvoffset = bio->bi_voffset + bio->bi_size;
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
@@ -1921,10 +1972,8 @@
 	struct bio *bio;
 	int nr_phys_segs, nr_hw_segs;
 
-	rq->buffer = bio_data(rq->bio);
-
 	nr_phys_segs = nr_hw_segs = 0;
-	rq_for_each_bio(bio, rq) {
+	rq_for_each_unfin_bio(bio, rq) {
 		/* Force bio hw/phys segs to be recalculated. */
 		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 
@@ -1936,15 +1985,27 @@
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
-inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
+void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (rq->flags & REQ_CMD) {
+
 		rq->hard_sector += nsect;
-		rq->nr_sectors = rq->hard_nr_sectors -= nsect;
-		rq->sector = rq->hard_sector;
+		rq->hard_nr_sectors -= nsect;
 
-		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-		rq->hard_cur_sectors = rq->current_nr_sectors;
+		/* Move the i/o submission pointers ahead if required  */
+		/* (i.e. if the driver doesn't update them) */
+		if ((rq->nr_sectors >= rq->hard_nr_sectors) &&
+		(rq->sector <= rq->hard_sector)){
+			rq->sector = rq->hard_sector;
+			rq->nr_sectors = rq->hard_nr_sectors;
+			rq->bio = rq->hard_bio;
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+			rq->hard_cur_sectors = bio_segsize(rq->bio) >> 9;
+			rq->current_nr_sectors = rq->hard_cur_sectors;
+
+			rq->buffer = bio_data(rq->bio);
+		}
 
 		/*
 		 * if total number of sectors is less than the first segment
@@ -1977,27 +2038,35 @@
 	int nsect, total_nsect;
 	struct bio *bio;
 
+
 	req->errors = 0;
 	if (!uptodate)
 		printk("end_request: I/O error, dev %s, sector %lu\n",
 			kdevname(req->rq_dev), req->sector);
 
 	total_nsect = 0;
-	while ((bio = req->bio)) {
-		nsect = bio_iovec(bio)->bv_len >> 9;
 
-		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
+	/* our starting point may be in the middle of a segment */
+	while ((bio = req->hard_bio)) {
+
+		/* For debugging - Verify consistency */
+		BIO_BUG_ON(!bio_consistent(bio));
+
+		nsect = bio_segsize(bio) >> 9;
 
 		/*
 		 * not a complete bvec done
 		 */
 		if (unlikely(nsect > nr_sectors)) {
-			int residual = (nsect - nr_sectors) << 9;
 
-			bio->bi_size -= residual;
-			bio_iovec(bio)->bv_offset += residual;
-			bio_iovec(bio)->bv_len -= residual;
+			bio->bi_size -= nr_sectors << 9;
+			bio->bi_voffset += nr_sectors << 9;
 			blk_recalc_rq_sectors(req, nr_sectors);
+
+			/*
+			 * TBD: Could we just do without recalc segments ?
+			 * (or a better way to achieve it)
+			 */
 			blk_recalc_rq_segments(req);
 			return 1;
 		}
@@ -2005,28 +2074,34 @@
 		/*
 		 * account transfer
 		 */
-		bio->bi_size -= bio_iovec(bio)->bv_len;
+		bio->bi_size -= nsect << 9;
 		bio->bi_idx++;
 
 		nr_sectors -= nsect;
 		total_nsect += nsect;
 
 		if (!bio->bi_size) {
-			req->bio = bio->bi_next;
-
+			req->hard_bio = bio->bi_next;
 			bio_endio(bio, uptodate);
-
 			total_nsect = 0;
+		} else {
+			bio->bi_voffset = bio_iovec(bio)->bv_offset;
 		}
 
-		if ((bio = req->bio)) {
+		if ((bio = req->hard_bio)) {
+			BIO_BUG_ON(bio_segments(bio) <= 0);
 			blk_recalc_rq_sectors(req, nsect);
 
 			/*
 			 * end more in this run, or just return 'not-done'
 			 */
 			if (unlikely(nr_sectors <= 0)) {
-				blk_recalc_rq_segments(req);
+				/*
+				 *TBD:Could we just do without recalc segments ?
+				 * (or a better way to achieve it)
+				 */
+				 blk_recalc_rq_segments(req);
+
 				return 1;
 			}
 		}
@@ -2043,6 +2118,81 @@
 	blk_put_request(req);
 }
 
+/*
+ * blk_rq_next_segment
+ * @req:      the request being processed
+ * 
+ * Points to the next segment in the request if the current segment
+ * is complete. Leaves things unchanged if this segment is not over or
+ * if no more segments are left in this request.
+ *
+ * Meant to be used for bio traversal during i/o submission
+ * Does not effect any i/o completions or update completion state in
+ * the request, and does not modify any bio fields
+ *
+ * Decrementing rq->nr_sectors, rq->current_nr_sectors, and
+ * rq->nr_bio_sectors as data is transferred is the caller's 
+ * responsibility and should be done before calling this routine.
+ */
+void blk_rq_next_segment(struct request *rq)
+{
+	if (rq->current_nr_sectors > 0) 
+		return;
+	
+	if (rq->nr_bio_sectors > 0) {
+		--rq->nr_bio_segments;
+		/* a clone bio could end in the middle of a segment */
+		rq->current_nr_sectors = min(
+			(unsigned long)blk_rq_vec(rq)->bv_len >> 9,
+			rq->nr_bio_sectors);
+ 	} else {
+		if ((rq->bio = rq->bio->bi_next)) {
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+ 			rq->current_nr_sectors = bio_segsize(rq->bio) >> 9;
+		}
+ 	}
+
+	/* remember the size of this segment before we start i/o */
+	rq->hard_cur_sectors = rq->current_nr_sectors;
+}
+
+/*
+ * process_that_request_first: process partial request submission
+ * @req:      the request being processed
+ * @nr_sectors: number of sectors i/o has been submitted on
+ *
+ * Description:
+ *   May be used for processing bio's while submitting i/o without
+ *   signalling completion. Fails if more data is requested than is
+ *   available in the request in which case it doesn't advance any
+ *   pointers.
+ *
+ * Assumes a request is correctly set up. No sanity checks)
+ *
+ * Return:
+ *     0 - no more data left to submit (not processed)
+ *     1 - data available to submit for this request (processed)
+ */
+int process_that_request_first(struct request *req, unsigned int nr_sectors)
+{
+	int nsect;
+
+	if (req->nr_sectors < nr_sectors)
+		return 0;
+
+	req->nr_sectors -= nr_sectors;
+	req->sector += nr_sectors;
+	while (nr_sectors) {
+		nsect = min(req->current_nr_sectors, nr_sectors);
+		req->current_nr_sectors -= nsect;
+		req->nr_bio_sectors -= nsect;
+		nr_sectors -= nsect;
+		blk_rq_next_segment(req);
+	}
+	return 1;
+}
+
 #define MB(kb)	((kb) << 10)
 
 int __init blk_dev_init(void)
@@ -2095,6 +2245,7 @@
 
 EXPORT_SYMBOL(end_that_request_first);
 EXPORT_SYMBOL(end_that_request_last);
+EXPORT_SYMBOL(process_that_request_first);
 EXPORT_SYMBOL(blk_init_queue);
 EXPORT_SYMBOL(bdev_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/loop.c linux-2.5.33-bio/drivers/block/loop.c
--- linux-2.5.33/drivers/block/loop.c	Sun Sep  1 03:35:27 2002
+++ linux-2.5.33-bio/drivers/block/loop.c	Wed Sep  4 10:50:58 2002
@@ -180,7 +180,8 @@
 }
 
 static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
+do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos,
+		int startoff, int endoff)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
@@ -195,8 +196,8 @@
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
+	data = kmap(bvec->bv_page) + bvec->bv_offset + startoff;
+	len = bvec->bv_len - startoff - endoff;
 	while (len > 0) {
 		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		int transfer_result;
@@ -253,14 +254,19 @@
 {
 	unsigned vecnr;
 	int ret = 0;
+	int startoff = bio_startoffset(bio), endoff = 0;
 
 	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
+		/* FIXME: Could be more efficient */
+		if (vecnr == bio->bi_vcnt - 1) 
+			endoff = bio_endoffset(bio);
 		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
 
-		ret = do_lo_send(lo, bvec, bsize, pos);
+		ret = do_lo_send(lo, bvec, bsize, pos, startoff, endoff);
 		if (ret < 0)
 			break;
-		pos += bvec->bv_len;
+		pos += bvec->bv_len - startoff - endoff;
+		startoff = 0;
 	}
 	return ret;
 }
@@ -298,17 +304,17 @@
 
 static int
 do_lo_receive(struct loop_device *lo,
-		struct bio_vec *bvec, int bsize, loff_t pos)
+	struct bio_vec *bvec, int bsize, loff_t pos, int startoff, int endoff)
 {
 	struct lo_read_data cookie;
 	read_descriptor_t desc;
 	struct file *file;
 
 	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
+	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset + startoff;
 	cookie.bsize = bsize;
 	desc.written = 0;
-	desc.count = bvec->bv_len;
+	desc.count = bvec->bv_len - startoff - endoff;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
 	spin_lock_irq(&lo->lo_lock);
@@ -324,14 +330,20 @@
 {
 	unsigned vecnr;
 	int ret = 0;
+	int startoff = bio_startoffset(bio), endoff = 0;
 
 	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
 		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
+		/* FIXME: Could be more efficient */
+		if (vecnr == bio->bi_vcnt - 1) 
+			endoff = bio_endoffset(bio);
+
+		ret = do_lo_receive(lo, bvec, bsize, pos, startoff, endoff);
 		if (ret < 0)
 			break;
-		pos += bvec->bv_len;
+		pos += bvec->bv_len - startoff - endoff;
+		startoff = 0;
 	}
 	return ret;
 }
@@ -479,18 +491,29 @@
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret = 0, i;
+	int from_start, from_len, to_start;
 
+	from_start = bio_offset(from_bio);
+	to_start = bio_offset(to_bio);
 	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
 		to_bvec = &to_bio->bi_io_vec[i];
+		from_len = from_bvec->bv_len;
+
+		/* FIXME: Could be more efficient */
+		if (i == from_bio->bi_vcnt - 1)
+			from_len -= bio_endoffset(from_bio);
 
 		kmap(from_bvec->bv_page);
 		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
+		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset
+			+ from_start;
+		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset +
+			to_start;
 		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
+					from_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		from_start = to_start = 0;
 	}
 
 	return ret;
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/nbd.c linux-2.5.33-bio/drivers/block/nbd.c
--- linux-2.5.33/drivers/block/nbd.c	Sun Sep  1 03:34:52 2002
+++ linux-2.5.33-bio/drivers/block/nbd.c	Wed Sep  4 10:50:58 2002
@@ -180,6 +180,9 @@
 		 * whether to set MSG_MORE or not...
 		 */
 		rq_for_each_bio(bio, req) {
+			/* Can't handle arbitrary bio pieces yet */
+			BIO_BUG_ON(bio_startoffset(bio) != 0);
+			BIO_BUG_ON(bio_endoffset(bio) != 0);
 			struct bio_vec *bvec;
 			bio_for_each_segment(bvec, bio, i) {
 				flags = 0;
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/rd.c linux-2.5.33-bio/drivers/block/rd.c
--- linux-2.5.33/drivers/block/rd.c	Sun Sep  1 03:35:28 2002
+++ linux-2.5.33-bio/drivers/block/rd.c	Wed Sep  4 10:50:58 2002
@@ -227,6 +227,9 @@
 
 	sector = bio->bi_sector;
 	rw = bio_data_dir(bio);
+	/* Can't handle a bio split in the middle of a segment */
+	BIO_BUG_ON(bio_startoffset(bio) > 0);
+	BIO_BUG_ON(bio_offset(bio) > 0);
 	bio_for_each_segment(bvec, bio, i) {
 		ret |= rd_blkdev_pagecache_IO(rw, bvec, sector, minor);
 		sector += bvec->bv_len >> 9;
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/block/umem.c linux-2.5.33-bio/drivers/block/umem.c
--- linux-2.5.33/drivers/block/umem.c	Sun Sep  1 03:35:36 2002
+++ linux-2.5.33-bio/drivers/block/umem.c	Wed Sep  4 10:50:58 2002
@@ -417,7 +417,7 @@
 	if (card->mm_pages[card->Ready].cnt >= DESC_PER_PAGE)
 		return 0;
 
-	len = bio_iovec(bio)->bv_len;
+	len = bio_segsize(bio);
 	dma_handle = pci_map_page(card->dev, 
 				  bio_page(bio),
 				  bio_offset(bio),
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/md/raid1.c linux-2.5.33-bio/drivers/md/raid1.c
--- linux-2.5.33/drivers/md/raid1.c	Sun Sep  1 03:34:46 2002
+++ linux-2.5.33-bio/drivers/md/raid1.c	Wed Sep  4 10:50:58 2002
@@ -90,6 +90,9 @@
 	bio->bi_vcnt = RESYNC_PAGES;
 	bio->bi_idx = 0;
 	bio->bi_size = RESYNC_BLOCK_SIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_end_io = NULL;
 	atomic_set(&bio->bi_cnt, 1);
 
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/md/raid5.c linux-2.5.33-bio/drivers/md/raid5.c
--- linux-2.5.33/drivers/md/raid5.c	Sun Sep  1 03:34:52 2002
+++ linux-2.5.33-bio/drivers/md/raid5.c	Wed Sep  4 10:50:58 2002
@@ -431,6 +431,8 @@
 	dev->vec.bv_page = dev->page;
 	dev->vec.bv_len = STRIPE_SIZE;
 	dev->vec.bv_offset = 0;
+	dev->req.bi_voffset = 0;
+	dev->req.bi_endvoffset = STRIPE_SIZE;
 
 	dev->req.bi_sector = sh->sector;
 	dev->req.bi_private = sh;
@@ -592,6 +594,11 @@
 	for (;bio && bio->bi_sector < sector+STRIPE_SECTORS;
 		bio = bio->bi_next) {
 		int page_offset;
+
+		/* Can't handle arbitrary bio pieces yet */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
+
 		if (bio->bi_sector >= sector)
 			page_offset = (signed)(bio->bi_sector - sector) * 512;
 		else 
diff -ur -X /home/suparna/dontdiff linux-2.5.33/drivers/scsi/scsi_lib.c linux-2.5.33-bio/drivers/scsi/scsi_lib.c
--- linux-2.5.33/drivers/scsi/scsi_lib.c	Sun Sep  1 03:35:17 2002
+++ linux-2.5.33-bio/drivers/scsi/scsi_lib.c	Wed Sep  4 10:50:58 2002
@@ -481,10 +481,11 @@
 		if (SCpnt->buffer != req->buffer) {
 			if (rq_data_dir(req) == READ) {
 				unsigned long flags;
-				char *to = bio_kmap_irq(req->bio, &flags);
+				/* Todo: check if this is all we need to do */
+				char *to = rq_map_buffer(req, &flags);
 
 				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
-				bio_kunmap_irq(to, &flags);
+				rq_unmap_buffer(to, &flags);
 			}
 			kfree(SCpnt->buffer);
 		}
diff -ur -X /home/suparna/dontdiff linux-2.5.33/fs/bio.c linux-2.5.33-bio/fs/bio.c
--- linux-2.5.33/fs/bio.c	Sun Sep  1 03:35:27 2002
+++ linux-2.5.33-bio/fs/bio.c	Wed Sep  4 10:50:51 2002
@@ -178,6 +178,28 @@
 	}
 }
 
+/* Perform some sanity checks on the bio vectors, size and offsets */
+int bio_consistent(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	int i;
+	int size = 0;
+
+	/* Verify that the size is consistent with sigma vec len */
+	bio_for_each_segment(bvec, bio, i)
+		size += bvec->bv_len;
+
+	/* Adjust for both ends */
+	size -= bio_startoffset(bio) + bio_endoffset(bio);
+
+	if (size != bio->bi_size)
+		return 0; /* size mismatch */
+
+	/* Place any other checks here */
+
+	return 1;
+}
+
 inline int bio_phys_segments(request_queue_t *q, struct bio *bio)
 {
 	if (unlikely(!(bio->bi_flags & (1 << BIO_SEG_VALID))))
@@ -225,6 +247,8 @@
 	}
 	bio->bi_size = bio_src->bi_size;
 	bio->bi_max = bio_src->bi_max;
+	bio->bi_voffset = bio_src->bi_voffset;
+	bio->bi_endvoffset = bio_src->bi_endvoffset;
 }
 
 /**
@@ -312,6 +336,9 @@
 	b->bi_vcnt = bio->bi_vcnt;
 	b->bi_size = bio->bi_size;
 
+	b->bi_voffset = bio->bi_voffset;
+	b->bi_endvoffset = bio->bi_endvoffset;
+
 	return b;
 
 oom:
@@ -424,6 +451,9 @@
 	}
 
 queue_io:
+	bio->bi_voffset = bio_iovec(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	submit_bio(rw, bio);
 
 	if (total_nr_pages)
diff -ur -X /home/suparna/dontdiff linux-2.5.33/fs/direct-io.c linux-2.5.33-bio/fs/direct-io.c
--- linux-2.5.33/fs/direct-io.c	Sun Sep  1 03:35:27 2002
+++ linux-2.5.33-bio/fs/direct-io.c	Wed Sep  4 10:50:54 2002
@@ -193,6 +193,9 @@
 
 	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_private = dio;
 	atomic_inc(&dio->bio_count);
 	submit_bio(dio->rw, bio);
diff -ur -X /home/suparna/dontdiff linux-2.5.33/fs/jfs/jfs_logmgr.c linux-2.5.33-bio/fs/jfs/jfs_logmgr.c
--- linux-2.5.33/fs/jfs/jfs_logmgr.c	Sun Sep  1 03:35:23 2002
+++ linux-2.5.33-bio/fs/jfs/jfs_logmgr.c	Wed Sep  4 10:50:54 2002
@@ -1775,6 +1775,9 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = LOGPSIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
@@ -1917,6 +1920,9 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = LOGPSIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
diff -ur -X /home/suparna/dontdiff linux-2.5.33/fs/mpage.c linux-2.5.33-bio/fs/mpage.c
--- linux-2.5.33/fs/mpage.c	Sun Sep  1 03:34:52 2002
+++ linux-2.5.33-bio/fs/mpage.c	Wed Sep  4 10:50:54 2002
@@ -84,6 +84,9 @@
 {
 	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_end_io = mpage_end_io_read;
 	if (rw == WRITE)
 		bio->bi_end_io = mpage_end_io_write;
diff -ur -X /home/suparna/dontdiff linux-2.5.33/include/linux/bio.h linux-2.5.33-bio/include/linux/bio.h
--- linux-2.5.33/include/linux/bio.h	Sun Sep  1 03:35:31 2002
+++ linux-2.5.33-bio/include/linux/bio.h	Wed Sep  4 10:50:51 2002
@@ -67,7 +67,22 @@
 						 */
 
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
+
+	/*
+	 * Residual section - portion on which i/o hasn't finished as yet
+	 * (i/o may already have been submitted and in progress for some
+	 * of these segments if this is an active bio)
+	 */
 	unsigned short		bi_idx;		/* current index into bvl_vec */
+	unsigned short		bi_voffset;	/* current vec offset -
+						 * relative to start of bvec
+						 * page
+						 */
+	unsigned short		bi_endvoffset;	/* offset into the last bvec
+						 * page that marks the end of
+						 * this buffer
+						 */
+	unsigned int		bi_size;	/* residual I/O count */
 
 	/* Number of segments in this BIO after
 	 * physical address coalescing is performed.
@@ -79,7 +94,6 @@
 	 */
 	unsigned short		bi_hw_segments;
 
-	unsigned int		bi_size;	/* residual I/O count */
 	unsigned int		bi_max;		/* max bvl_vecs we can hold,
 						   used as index into pool */
 
@@ -120,11 +134,13 @@
 #define bio_iovec_idx(bio, idx)	(&((bio)->bi_io_vec[(idx)]))
 #define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
 #define bio_page(bio)		bio_iovec((bio))->bv_page
-#define bio_offset(bio)		bio_iovec((bio))->bv_offset
+#define bio_offset(bio)		(bio)->bi_voffset
+#define bio_segments(bio)	((bio)->bi_vcnt - (bio)->bi_idx)
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_BARRIER))
 
+
 /*
  * will die
  */
@@ -150,16 +166,38 @@
 #define __BVEC_START(bio)	bio_iovec_idx((bio), 0)
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
+#define BIOVEC_PHYS_MERGEABLE_PARTIAL(vec1, end, vec2, start)	\
+	((page_to_phys((vec1)->bv_page) + (end)) == \
+	 (page_to_phys((vec2)->bv_page) + (start)))
 #define BIOVEC_VIRT_MERGEABLE(vec1, vec2)	\
 	((((bvec_to_phys((vec1)) + (vec1)->bv_len) | bvec_to_phys((vec2))) & (BIO_VMERGE_BOUNDARY - 1)) == 0)
+#define BIOVEC_VIRT_MERGEABLE_PARTIAL(vec1, end, vec2, start)	\
+	((((page_to_phys((vec1)->bv_page) + (end)) | (page_to_phys((vec2)->bv_page) + (start))) & (BIO_VMERGE_BOUNDARY - 1)) == 0)
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
 #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
 	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, (q)->seg_boundary_mask)
+#define BIOVEC_SEG_BOUNDARY_PARTIAL(q, b1, start, b2, end) \
+	__BIO_SEG_BOUNDARY(page_to_phys((b1)->bv_page) + (start), page_to_phys((b2)->bv_page) + (end), (q)->seg_boundary_mask)
 #define BIO_SEG_BOUNDARY(q, b1, b2) \
-	BIOVEC_SEG_BOUNDARY((q), __BVEC_END((b1)), __BVEC_START((b2)))
+	BIOVEC_SEG_BOUNDARY_PARTIAL((q), __BVEC_END((b1)),(b1)->bi_voffset, \
+	__BVEC_START((b2)), (b2)->bi_endvoffset)
 
 #define bio_io_error(bio) bio_endio((bio), 0)
+#define bio_startoffset(bio)	(bio_offset(bio) - bio_iovec(bio)->bv_offset)
+#define bio_endoffset(bio)	(__BVEC_END(bio)->bv_offset + \
+		__BVEC_END(bio)->bv_len - (bio)->bi_endvoffset)
+
+/* adjusts for clones which may start or end in the middle of a segment */
+static inline unsigned int bio_segsize(struct bio *bio)
+{
+	unsigned int len = bio_iovec(bio)->bv_len - bio_startoffset(bio);
+
+	if (len > bio->bi_size)
+		len = bio->bi_size;
+
+	return len;
+}
 
 /*
  * drivers should not use the __ version unless they _really_ want to
@@ -203,6 +241,8 @@
 
 extern inline void bio_init(struct bio *);
 
+extern int bio_consistent(struct bio *bio);
+
 #ifdef CONFIG_HIGHMEM
 /*
  * remember to add offset! and never ever reenable interrupts between a
@@ -211,7 +251,7 @@
  * This function MUST be inlined - it plays with the CPU interrupt flags.
  * Hence the `extern inline'.
  */
-extern inline char *bio_kmap_irq(struct bio *bio, unsigned long *flags)
+extern inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
 {
 	unsigned long addr;
 
@@ -220,22 +260,23 @@
 	/*
 	 * could be low
 	 */
-	if (!PageHighMem(bio_page(bio)))
-		return bio_data(bio);
+	if (!PageHighMem(bvec->bv_page))
+		return page_address(bvec->bv_page) + bvec->bv_offset;
 
 	/*
 	 * it's a highmem page
 	 */
 	local_irq_disable();
-	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
+	addr = (unsigned long) kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ);
 
 	if (addr & ~PAGE_MASK)
 		BUG();
 
-	return (char *) addr + bio_offset(bio);
+	return (char *) addr + bvec->bv_offset;
 }
 
-extern inline void bio_kunmap_irq(char *buffer, unsigned long *flags)
+
+extern inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 {
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
@@ -244,8 +285,19 @@
 }
 
 #else
-#define bio_kmap_irq(bio, flags)	(bio_data(bio))
-#define bio_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
+#define bvec_kmap_irq(bvec, flags)	(page_address((bvec)->bv_page) + ((bvec)->bv_offset))
+#define bvec_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
 #endif
 
+
+/* TBD: Could this be made more efficient ? */
+extern inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
+		unsigned long *flags)
+{
+	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags) +
+		((idx == bio->bi_idx) ? bio_startoffset(bio): 0);
+}
+
+#define __bio_kunmap_irq bvec_kunmap_irq
+
 #endif /* __LINUX_BIO_H */
diff -ur -X /home/suparna/dontdiff linux-2.5.33/include/linux/blk.h linux-2.5.33-bio/include/linux/blk.h
--- linux-2.5.33/include/linux/blk.h	Sun Sep  1 03:35:31 2002
+++ linux-2.5.33-bio/include/linux/blk.h	Wed Sep  4 10:50:51 2002
@@ -40,6 +40,7 @@
 
 extern int end_that_request_first(struct request *, int, int);
 extern void end_that_request_last(struct request *);
+extern int process_that_request_first(struct request *, unsigned int);
 struct request *elv_next_request(request_queue_t *q);
 
 static inline void blkdev_dequeue_request(struct request *req)
@@ -50,11 +51,14 @@
 		elv_remove_request(req->q, req);
 }
 
+
+
 #define _elv_add_request_core(q, rq, where, plug)			\
 	do {								\
 		if ((plug))						\
 			blk_plug_device((q));				\
 		(q)->elevator.elevator_add_req_fn((q), (rq), (where));	\
+		if ((rq)->bio) BIO_BUG_ON(!bio_consistent((rq)->bio)); \
 	} while (0)
 
 #define _elv_add_request(q, rq, back, p) do {				      \
diff -ur -X /home/suparna/dontdiff linux-2.5.33/include/linux/blkdev.h linux-2.5.33-bio/include/linux/blkdev.h
--- linux-2.5.33/include/linux/blkdev.h	Sun Sep  1 03:34:52 2002
+++ linux-2.5.33-bio/include/linux/blkdev.h	Wed Sep  4 10:50:51 2002
@@ -10,6 +10,7 @@
 #include <linux/backing-dev.h>
 
 #include <asm/scatterlist.h>
+#include <linux/bio.h>
 
 struct request_queue;
 typedef struct request_queue request_queue_t;
@@ -35,13 +36,13 @@
 	int rq_status;	/* should split this into a few status bits */
 	kdev_t rq_dev;
 	int errors;
-	sector_t sector;
-	unsigned long nr_sectors;
-	unsigned long hard_sector;	/* the hard_* are block layer
-					 * internals, no driver should
-					 * touch them
-					 */
-	unsigned long hard_nr_sectors;
+	sector_t sector;		/* next sector to submit */
+	unsigned long nr_sectors;	/* no of sectors left to submit */
+
+	/* the hard_* are block layer internals, no driver should
+	   touch them */
+	unsigned long hard_sector;	/* next sector to complete */
+	unsigned long hard_nr_sectors;  /* no. of sectors left to complete */
 
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
@@ -55,13 +56,26 @@
 	 */
 	unsigned short nr_hw_segments;
 
+	/* Maintain bio traversal state for part by part io submission */
+	/* "current" refers to an element currently being submitted for io */
+
+	/* no. of segments left to submit in the current bio */
+	unsigned short nr_bio_segments;
+	/* no. of sectors left to submit in the current bio */
+	unsigned long nr_bio_sectors;
+	/* no. of sectors left to submit in the current segment */
 	unsigned int current_nr_sectors;
+	/* no. of sectors left to complete in the current segment */
 	unsigned int hard_cur_sectors;
+
+	struct bio *bio; /* next bio to submit */
+	struct bio *hard_bio; /* next unfinished bio to complete */
+	struct bio *biotail;
+
 	int tag;
 	void *special;
 	char *buffer;
 	struct completion *waiting;
-	struct bio *bio, *biotail;
 	request_queue_t *q;
 	struct request_list *rl;
 };
@@ -237,6 +251,33 @@
  */
 #define blk_queue_headactive(q, head_active)
 
+
+/*
+ * temporarily mapping a (possible) highmem bio for typically for PIO transfer
+ */
+
+/* current offset with respect to start of the segment being submitted */
+#define blk_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+/* current index into bio being processed for submission */
+#define blk_rq_idx(rq) ((rq)->bio->bi_vcnt - (rq)->nr_bio_segments)
+
+/* current vector being processed */
+#define blk_rq_vec(rq)	(bio_iovec_idx((rq)->bio, blk_rq_idx(rq)))
+
+/* Assumes rq->bio != NULL */
+static inline char *rq_map_buffer(struct request *rq, unsigned long *flags)
+{
+	return (__bio_kmap_irq(rq->bio, blk_rq_idx(rq), flags) 
+			+ blk_rq_offset(rq));
+}
+
+static inline void rq_unmap_buffer(char *buffer, unsigned long *flags)
+{
+	__bio_kunmap_irq(buffer, flags);
+}
+
+
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 /*
@@ -257,6 +298,10 @@
 	if ((rq->bio))			\
 		for (bio = (rq)->bio; bio; bio = bio->bi_next)
 
+#define rq_for_each_unfin_bio(bio, rq)	\
+	if ((rq->hard_bio))			\
+		for (bio = (rq)->hard_bio; bio; bio = bio->bi_next)
+
 struct blk_dev_struct {
 	/*
 	 * queue_proc has to be atomic
diff -ur -X /home/suparna/dontdiff linux-2.5.33/mm/highmem.c linux-2.5.33-bio/mm/highmem.c
--- linux-2.5.33/mm/highmem.c	Sun Sep  1 03:34:48 2002
+++ linux-2.5.33-bio/mm/highmem.c	Wed Sep  4 10:50:51 2002
@@ -432,8 +432,10 @@
 	bio->bi_rw = (*bio_orig)->bi_rw;
 
 	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
-	bio->bi_idx = 0;
+	bio->bi_idx = (*bio_orig)->bi_idx;
 	bio->bi_size = (*bio_orig)->bi_size;
+	bio->bi_voffset = (*bio_orig)->bi_voffset;
+	bio->bi_endvoffset = (*bio_orig)->bi_endvoffset;
 
 	if (pool == page_pool) {
 		if (rw & WRITE)
@@ -447,6 +449,8 @@
 			bio->bi_end_io = bounce_end_io_read_isa;
 	}
 
+	BIO_BUG_ON(!bio_consistent(bio)); /* debug only */
+
 	bio->bi_private = *bio_orig;
 	*bio_orig = bio;
 }
diff -ur -X /home/suparna/dontdiff linux-2.5.33/mm/page_io.c linux-2.5.33-bio/mm/page_io.c
--- linux-2.5.33/mm/page_io.c	Sun Sep  1 03:34:49 2002
+++ linux-2.5.33-bio/mm/page_io.c	Wed Sep  4 10:50:54 2002
@@ -42,6 +42,9 @@
 		bio->bi_vcnt = 1;
 		bio->bi_idx = 0;
 		bio->bi_size = PAGE_SIZE;
+		bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+		bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 		bio->bi_end_io = end_io;
 	}
 	return bio;

