Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUCIEan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUCIEan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:30:43 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:47755 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261533AbUCIEaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:30:00 -0500
Subject: [PATCH] add the concept of an IOMMU maximum segment size to bio
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Mar 2004 23:29:51 -0500
Message-Id: <1078806593.1990.76.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that some IOMMU implementations have a maximum limit to
the size of the number of contiguously mappable pages (admittedly, this
limit is mostly in the resource management algorithms rather than the
IOMMUs themselves).

This patch adds this concept to the bio layer via the parameter

BIO_VMERGE_MAX_SIZE

which architectures can define in asm/io.h (if undefined, we assume it
to be infinite, which is current behaviour).

While adding this, I noticed several places where bio was making
incorrect assumptions about virtual mergeability (none of which was a
bug: bio was overestimating rather than underestimating).

- The worst offender was bio_add_page(), which seemed never to check for
virtual mergeability
- I also fixed blk_hw_contig_segments() not to check the QUEUE_CLUSTER
flag, and not to check the phys segment boundary.

In order to track the hw segment size across bios, I had to introduce
two extra bio parameters: bi_hw_front_size and bi_hw_back_size which
store the sizes of the front and back hw contiguous segments (and which
will be equal if there's only one hw segment).  When the bio is merged
into a request, these fields are updated with the total hw contig size
so they can always be used to assess if the merger would violate the
BIO_VMERGE_MAX_SIZE parameter.

James

===== drivers/block/ll_rw_blk.c 1.228 vs edited =====
--- 1.228/drivers/block/ll_rw_blk.c	Sun Feb  1 12:09:12 2004
+++ edited/drivers/block/ll_rw_blk.c	Mon Mar  8 22:24:07 2004
@@ -817,14 +817,14 @@
 void blk_recount_segments(request_queue_t *q, struct bio *bio)
 {
 	struct bio_vec *bv, *bvprv = NULL;
-	int i, nr_phys_segs, nr_hw_segs, seg_size, cluster;
+	int i, nr_phys_segs, nr_hw_segs, seg_size, hw_seg_size, cluster;
 	int high, highprv = 1;
 
 	if (unlikely(!bio->bi_io_vec))
 		return;
 
 	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
-	seg_size = nr_phys_segs = nr_hw_segs = 0;
+	hw_seg_size = seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
 		/*
 		 * the trick here is making sure that a high page is never
@@ -841,22 +841,35 @@
 				goto new_segment;
 			if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bv))
 				goto new_segment;
+			if (BIOVEC_VIRT_OVERSIZE(hw_seg_size + bv->bv_len))
+				goto new_hw_segment;
 
 			seg_size += bv->bv_len;
+			hw_seg_size += bv->bv_len;
 			bvprv = bv;
 			continue;
 		}
 new_segment:
-		if (!BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+		if (BIOVEC_VIRT_MERGEABLE(bvprv, bv) &&
+		    !BIOVEC_VIRT_OVERSIZE(hw_seg_size + bv->bv_len)) {
+			hw_seg_size += bv->bv_len;
+		} else {
 new_hw_segment:
+			if(hw_seg_size > bio->bi_hw_front_size)
+				bio->bi_hw_front_size = hw_seg_size;
+			hw_seg_size = BIOVEC_VIRT_START_SIZE(bv) + bv->bv_len;
 			nr_hw_segs++;
+		}
 
 		nr_phys_segs++;
 		bvprv = bv;
 		seg_size = bv->bv_len;
 		highprv = high;
 	}
-
+	if(hw_seg_size > bio->bi_hw_back_size)
+		bio->bi_hw_back_size = hw_seg_size;
+	if(nr_hw_segs == 1 && hw_seg_size > bio->bi_hw_front_size)
+		bio->bi_hw_front_size = hw_seg_size;
 	bio->bi_phys_segments = nr_phys_segs;
 	bio->bi_hw_segments = nr_hw_segs;
 	bio->bi_flags |= (1 << BIO_SEG_VALID);
@@ -889,22 +902,17 @@
 int blk_hw_contig_segment(request_queue_t *q, struct bio *bio,
 				 struct bio *nxt)
 {
-	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
-		return 0;
-
-	if (!BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
+	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
+		blk_recount_segments(q, bio);
+	if (unlikely(!bio_flagged(nxt, BIO_SEG_VALID)))
+		blk_recount_segments(q, nxt);
+	if (!BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)) ||
+	    BIOVEC_VIRT_OVERSIZE(bio->bi_hw_front_size + bio->bi_hw_back_size))
 		return 0;
 	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
 		return 0;
 
-	/*
-	 * bio and nxt are contigous in memory, check if the queue allows
-	 * these two to be merged into one
-	 */
-	if (BIO_SEG_BOUNDARY(q, bio, nxt))
-		return 1;
-
-	return 0;
+	return 1;
 }
 
 EXPORT_SYMBOL(blk_hw_contig_segment);
@@ -1012,14 +1020,29 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct bio *bio)
 {
+	int len;
+
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
 	}
-
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(req->biotail), __BVEC_START(bio)))
-		return ll_new_mergeable(q, req, bio);
+	if (unlikely(!bio_flagged(req->biotail, BIO_SEG_VALID)))
+		blk_recount_segments(q, req->biotail);
+	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
+		blk_recount_segments(q, bio);
+	len = req->biotail->bi_hw_back_size + bio->bi_hw_front_size;
+	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(req->biotail), __BVEC_START(bio)) &&
+	    !BIOVEC_VIRT_OVERSIZE(len)) {
+		int mergeable =  ll_new_mergeable(q, req, bio);
+		if(mergeable) {
+			if(req->nr_hw_segments == 1)
+				req->bio->bi_hw_front_size = len;
+			if(bio->bi_hw_segments == 1)
+				bio->bi_hw_back_size = len;
+		}
+		return mergeable;
+	}
 
 	return ll_new_hw_segment(q, req, bio);
 }
@@ -1027,14 +1050,30 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct bio *bio)
 {
+	int len;
+
 	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
 	}
-
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(req->bio)))
-		return ll_new_mergeable(q, req, bio);
+	len = bio->bi_hw_back_size + req->bio->bi_hw_front_size;
+	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
+		blk_recount_segments(q, bio);
+	if (unlikely(!bio_flagged(req->bio, BIO_SEG_VALID)))
+		blk_recount_segments(q, req->bio);
+	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(req->bio)) &&
+	    !BIOVEC_VIRT_OVERSIZE(len)) {
+		int mergeable =  ll_new_mergeable(q, req, bio);
+
+		if(mergeable) {
+			if(bio->bi_hw_segments == 1)
+				bio->bi_hw_front_size = len;
+			if(req->nr_hw_segments == 1)
+				req->biotail->bi_hw_back_size = len;
+		}
+		return mergeable;
+	}
 
 	return ll_new_hw_segment(q, req, bio);
 }
@@ -1066,8 +1105,16 @@
 		return 0;
 
 	total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
-	if (blk_hw_contig_segment(q, req->biotail, next->bio))
+	if (blk_hw_contig_segment(q, req->biotail, next->bio)) {
+		int len = req->biotail->bi_hw_back_size + next->bio->bi_hw_front_size;
+		/* propagate the combined length to the end of the requests
+		 * if necessary */
+		if(req->nr_hw_segments == 1)
+			req->bio->bi_hw_front_size = len;
+		if(next->nr_hw_segments == 1)
+			next->biotail->bi_hw_back_size = len;
 		total_hw_segments--;
+	}
 
 	if (total_hw_segments > q->max_hw_segments)
 		return 0;
@@ -2390,7 +2437,7 @@
 
 void blk_recalc_rq_segments(struct request *rq)
 {
-	struct bio *bio;
+	struct bio *bio, *prevbio = NULL;
 	int nr_phys_segs, nr_hw_segs;
 
 	if (!rq->bio)
@@ -2403,6 +2450,13 @@
 
 		nr_phys_segs += bio_phys_segments(rq->q, bio);
 		nr_hw_segs += bio_hw_segments(rq->q, bio);
+		if(prevbio) {
+			if (blk_phys_contig_segment(rq->q, prevbio, bio))
+				nr_phys_segs--;
+			if (blk_hw_contig_segment(rq->q, prevbio, bio))
+				nr_hw_segs--;
+		}
+		prevbio = bio;
 	}
 
 	rq->nr_phys_segments = nr_phys_segs;
===== fs/bio.c 1.57 vs edited =====
--- 1.57/fs/bio.c	Sun Feb  1 05:55:27 2004
+++ edited/fs/bio.c	Mon Mar  8 19:23:05 2004
@@ -116,6 +116,8 @@
 	bio->bi_idx = 0;
 	bio->bi_phys_segments = 0;
 	bio->bi_hw_segments = 0;
+	bio->bi_hw_front_size = 0;
+	bio->bi_hw_back_size = 0;
 	bio->bi_size = 0;
 	bio->bi_max_vecs = 0;
 	bio->bi_end_io = NULL;
@@ -304,14 +306,15 @@
 	 * make this too complex.
 	 */
 
-	while (bio_phys_segments(q, bio) >= q->max_phys_segments
-	    || bio_hw_segments(q, bio) >= q->max_hw_segments) {
+	while (bio->bi_phys_segments >= q->max_phys_segments
+	       || bio->bi_hw_segments >= q->max_hw_segments
+	       || BIOVEC_VIRT_OVERSIZE(bio->bi_size)) {
 
 		if (retried_segments)
 			return 0;
 
-		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 		retried_segments = 1;
+		blk_recount_segments(q, bio);
 	}
 
 	/*
@@ -340,6 +343,11 @@
 			return 0;
 		}
 	}
+
+	/* If we may be able to merge these biovecs, force a recount */
+	if(BIOVEC_PHYS_MERGEABLE(bvec-1, bvec) ||
+	   BIOVEC_VIRT_MERGEABLE(bvec-1, bvec))
+		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 
 	bio->bi_vcnt++;
 	bio->bi_phys_segments++;
===== include/linux/bio.h 1.38 vs edited =====
--- 1.38/include/linux/bio.h	Wed Feb  4 13:20:06 2004
+++ edited/include/linux/bio.h	Mon Mar  8 17:43:44 2004
@@ -25,6 +25,15 @@
 
 /* Platforms may set this to teach the BIO layer about IOMMU hardware. */
 #include <asm/io.h>
+
+#if defined(BIO_VMERGE_MAX_SIZE) && defined(BIO_VMERGE_BOUNDARY)
+#define BIOVEC_VIRT_START_SIZE(x) (bvec_to_phys(x) & (BIO_VMERGE_BOUNDARY - 1))
+#define	BIOVEC_VIRT_OVERSIZE(x)	((x) > BIO_VMERGE_MAX_SIZE)
+#else
+#define BIOVEC_VIRT_START_SIZE(x)	0
+#define	BIOVEC_VIRT_OVERSIZE(x)	0
+#endif
+
 #ifndef BIO_VMERGE_BOUNDARY
 #define BIO_VMERGE_BOUNDARY	0
 #endif
@@ -81,6 +90,13 @@
 	unsigned short		bi_hw_segments;
 
 	unsigned int		bi_size;	/* residual I/O count */
+
+	/* To keep track of the max hw size, we account for the
+	 * sizes of the first and last virtually mergeable segments
+	 * in this bio */
+	unsigned int		bi_hw_front_size;
+	unsigned int		bi_hw_back_size;
+
 	unsigned int		bi_max_vecs;	/* max bvl_vecs we can hold */
 
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */


