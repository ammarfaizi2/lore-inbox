Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSJYT5k>; Fri, 25 Oct 2002 15:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJYT5k>; Fri, 25 Oct 2002 15:57:40 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:28434 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S261570AbSJYT46>; Fri, 25 Oct 2002 15:56:58 -0400
Date: Fri, 25 Oct 2002 13:59:14 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025135914.A1224@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add blk_rq_map_sg_one_by_one function to ll_rw_blk.c in order to allow a low 
level driver to map scatter gather elements from the block subsystem one 
at a time into device specific data structures instead of having to take 
a copy of all of them all at once and then afterwards copy them into a device 
specific format. 

To follow, a patch to the cciss driver using this interface which
allows up to 256 scatter gather elements (current limit is 31). 

-- steve

 drivers/block/ll_rw_blk.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h    |    4 +++
 2 files changed, 63 insertions

--- lx2544ac3/drivers/block/ll_rw_blk.c~blkdev_sg	Fri Oct 25 13:46:08 2002
+++ lx2544ac3-scameron/drivers/block/ll_rw_blk.c	Fri Oct 25 13:46:08 2002
@@ -766,6 +766,64 @@ inline int blk_hw_contig_segment(request
 }
 
 /*
+ * Map a request to a single scatterlist, one by one.  As each scatterlist is
+ * constructed consume_sg is called so the scattlerlist may be used.  The idea
+ * is the caller won't have to allocate all the space needed for a potentially
+ * large number of sg elements, instead the consume_sg callback function
+ * consumes each element as it's made.  sg_state is a pointer meant to be
+ * used by consume_sg to remember its state between calls.
+ */
+int blk_rq_map_sg_one_by_one(request_queue_t *q, struct request *rq,
+		consume_sg_callback consume_sg, void *sg_state)
+{
+	struct scatterlist sg;
+	struct bio_vec *bvec, *bvprv;
+	struct bio *bio;
+	int nsegs, i, cluster;
+
+	nsegs = 0;
+	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
+
+	/*
+	 * for each bio in rq
+	 */
+	bvprv = NULL;
+	rq_for_each_bio(bio, rq) {
+		/*
+		 * for each segment in bio
+		 */
+		bio_for_each_segment(bvec, bio, i) {
+			int nbytes = bvec->bv_len;
+
+			if (bvprv && cluster) {
+				if (sg.length + nbytes > q->max_segment_size)
+					goto new_segment;
+
+				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
+					goto new_segment;
+				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
+					goto new_segment;
+
+				sg.length += nbytes;
+			} else {
+new_segment:
+				if (bvprv) consume_sg(&sg, sg_state);
+				memset(&sg,0,sizeof(struct scatterlist));
+				sg.page = bvec->bv_page;
+				sg.length = nbytes;
+				sg.offset = bvec->bv_offset;
+				nsegs++;
+			}
+			bvprv = bvec;
+		} /* segments in bio */
+	} /* bios in rq */
+
+	if (bvprv) consume_sg(&sg, sg_state);
+
+	return nsegs;
+}
+
+/*
  * map a request to scatterlist, return number of sg entries setup. Caller
  * must make sure sg can hold rq->nr_phys_segments entries
  */
@@ -2112,6 +2170,7 @@ EXPORT_SYMBOL(blk_queue_max_hw_segments)
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 EXPORT_SYMBOL(blk_queue_hardsect_size);
 EXPORT_SYMBOL(blk_queue_segment_boundary);
+EXPORT_SYMBOL(blk_rq_map_sg_one_by_one);
 EXPORT_SYMBOL(blk_rq_map_sg);
 EXPORT_SYMBOL(blk_nohighio);
 EXPORT_SYMBOL(blk_dump_rq_flags);
--- lx2544ac3/include/linux/blkdev.h~blkdev_sg	Fri Oct 25 13:46:08 2002
+++ lx2544ac3-scameron/include/linux/blkdev.h	Fri Oct 25 13:46:08 2002
@@ -341,6 +341,10 @@ extern void blk_queue_prep_rq(request_qu
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
+typedef void (*consume_sg_callback)(struct scatterlist *, void *);
+extern int blk_rq_map_sg_one_by_one(request_queue_t *, struct request *,
+	consume_sg_callback consume_sg, void * sg_state);
+
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);

.
