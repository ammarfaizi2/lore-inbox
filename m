Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSJYVFU>; Fri, 25 Oct 2002 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJYVFU>; Fri, 25 Oct 2002 17:05:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59567 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261594AbSJYVFO>;
	Fri, 25 Oct 2002 17:05:14 -0400
Date: Fri, 25 Oct 2002 23:11:07 +0200
From: Jens Axboe <axboe@suse.de>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025211107.GG1203@suse.de>
References: <45B36A38D959B44CB032DA427A6E10640167D070@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167D070@cceexc18.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Cameron, Steve wrote:
> Jens Axboe wrote:
> > On Fri, Oct 25 2002, Stephen Cameron wrote:
> > > 
> > > Add blk_rq_map_sg_one_by_one function to ll_rw_blk.c in order to allow a low 
> > > level driver to map scatter gather elements from the block subsystem one 
> > > at a time 
> [...]
> > I have to say that I think this patch is ugly, and a complete 
> > duplicate of existing code. This is always bad, especially in the case of
> > something not really straight forward (like blk_rq_map_sg()). A hack.
> 
> Yes, I sort of figured you'd say that.  I was just trying to get the 
> ball rolling.

I was hoping that was the case and you weren't really serious :-). I've
cut a draft version of this, it's not tested at all though to be
careful... It should do what you want, yes? I'm not too happy with this
one, need a bit more time to ponder.

> Well, it doesn't look like cpqfc, at least.

Well thank god. :)

===== drivers/block/cciss.c 1.63 vs edited =====
--- 1.63/drivers/block/cciss.c	Fri Oct 18 12:55:58 2002
+++ edited/drivers/block/cciss.c	Fri Oct 25 23:07:21 2002
@@ -1681,6 +1681,28 @@
 	end_that_request_last(cmd->rq);
 }
 
+struct cciss_map_state {
+	CommandList_struct *command;
+	int data_dir;
+};
+
+static void cciss_map_sg(request_queue_t *q, struct scatterlist *sg, int nseg,
+			 void *map_cookie)
+{
+	struct cciss_map_state *s = map_cookie;
+	CommandList_struct *c = s->command;
+	ctlr_info_t *h= q->queuedata;
+	u64bit temp64;
+
+	c->SG[nseg].Len = sg->length;
+	temp64.val = (__u64) pci_map_page(h->pdev, sg->page, sg->offset,
+					  sg->length, s->data_dir);
+
+	c->SG[nseg].Addr.lower = temp64.val32.lower;
+	c->SG[nseg].Addr.upper = temp64.val32.upper;
+	c->SG[nseg].Ext = 0;  // we are not chaining
+}
+
 /* 
  * Get a request and submit it to the controller. 
  */
@@ -1690,10 +1712,8 @@
 	CommandList_struct *c;
 	int start_blk, seg;
 	struct request *creq;
-	u64bit temp64;
-	struct scatterlist tmp_sg[MAXSGENTRIES];
+	struct cciss_map_state map_state;
 	drive_info_struct *drv;
-	int i, dir;
 
 	if (blk_queue_plugged(q))
 		goto startio;
@@ -1735,24 +1755,16 @@
 		(int) creq->nr_sectors);	
 #endif /* CCISS_DEBUG */
 
-	seg = blk_rq_map_sg(q, creq, tmp_sg);
-
 	/* get the DMA records for the setup */ 
 	if (c->Request.Type.Direction == XFER_READ)
-		dir = PCI_DMA_FROMDEVICE;
+		map_state.data_dir = PCI_DMA_FROMDEVICE;
 	else
-		dir = PCI_DMA_TODEVICE;
+		map_state.data_dir = PCI_DMA_TODEVICE;
+
+	map_state.command = c;
+
+	seg = blk_rq_map_callback(q, creq, cciss_map_sg, &map_state);
 
-	for (i=0; i<seg; i++)
-	{
-		c->SG[i].Len = tmp_sg[i].length;
-		temp64.val = (__u64) pci_map_page(h->pdev, tmp_sg[i].page,
-			 		  tmp_sg[i].offset, tmp_sg[i].length,
-					  dir);
-		c->SG[i].Addr.lower = temp64.val32.lower;
-                c->SG[i].Addr.upper = temp64.val32.upper;
-                c->SG[i].Ext = 0;  // we are not chaining
-	}
 	/* track how many SG entries we are using */ 
 	if( seg > h->maxSG)
 		h->maxSG = seg; 
===== drivers/block/ll_rw_blk.c 1.123 vs edited =====
--- 1.123/drivers/block/ll_rw_blk.c	Fri Oct 18 19:41:37 2002
+++ edited/drivers/block/ll_rw_blk.c	Fri Oct 25 23:00:55 2002
@@ -765,13 +793,11 @@
 	return 0;
 }
 
-/*
- * map a request to scatterlist, return number of sg entries setup. Caller
- * must make sure sg can hold rq->nr_phys_segments entries
- */
-int blk_rq_map_sg(request_queue_t *q, struct request *rq, struct scatterlist *sg)
+int __blk_rq_map(request_queue_t *q, struct request *rq,
+		 struct scatterlist *sglist, map_sg_fn *map, void *map_cookie)
 {
 	struct bio_vec *bvec, *bvprv;
+	struct scatterlist *sg, sgstat;
 	struct bio *bio;
 	int nsegs, i, cluster;
 
@@ -782,6 +808,7 @@
 	 * for each bio in rq
 	 */
 	bvprv = NULL;
+	sg = NULL;
 	rq_for_each_bio(bio, rq) {
 		/*
 		 * for each segment in bio
@@ -790,7 +817,7 @@
 			int nbytes = bvec->bv_len;
 
 			if (bvprv && cluster) {
-				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
+				if (sg->length + nbytes > q->max_segment_size)
 					goto new_segment;
 
 				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
@@ -798,13 +825,21 @@
 				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
 					goto new_segment;
 
-				sg[nsegs - 1].length += nbytes;
+				sg->length += nbytes;
 			} else {
 new_segment:
-				memset(&sg[nsegs],0,sizeof(struct scatterlist));
-				sg[nsegs].page = bvec->bv_page;
-				sg[nsegs].length = nbytes;
-				sg[nsegs].offset = bvec->bv_offset;
+				if (sglist) {
+					sg = &sglist[nsegs];
+					sg->page = bvec->bv_page;
+					sg->length = nbytes;
+					sg->offset = bvec->bv_offset;
+				} else {
+					sg = &sgstat;
+					sg->page = bvec->bv_page;
+					sg->length = nbytes;
+					sg->offset = bvec->bv_offset;
+					map(q, sg, nsegs, map_cookie);
+				}
 
 				nsegs++;
 			}
@@ -816,10 +851,27 @@
 }
 
 /*
+ * map a request to scatterlist, return number of sg entries setup. Caller
+ * must make sure sg can hold rq->nr_phys_segments entries
+ */
+int blk_rq_map_sg(request_queue_t *q, struct request *rq,struct scatterlist *sg)
+{
+	return __blk_rq_map(q, rq, sg, NULL, NULL);
+}
+
+/*
+ * map a request to scatterlist, calling the map function for each segment
+ */
+int blk_rq_map_callback(request_queue_t *q, struct request *rq, map_sg_fn *map,
+			void *map_cookie)
+{
+	return __blk_rq_map(q, rq, NULL, map, map_cookie);
+}
+
+/*
  * the standard queue merge functions, can be overridden with device
  * specific ones if so desired
  */
-
 static inline int ll_new_mergeable(request_queue_t *q,
 				   struct request *req,
 				   struct bio *bio)
===== include/linux/blkdev.h 1.76 vs edited =====
--- 1.76/include/linux/blkdev.h	Fri Oct 18 19:50:43 2002
+++ edited/include/linux/blkdev.h	Fri Oct 25 23:06:51 2002
@@ -131,6 +136,8 @@
 typedef int (prep_rq_fn) (request_queue_t *, struct request *);
 typedef void (unplug_fn) (void *q);
 
+typedef void (map_sg_fn) (request_queue_t *q, struct scatterlist *,int, void *);
+
 struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
 
@@ -339,9 +348,11 @@
 extern void blk_queue_assign_lock(request_queue_t *, spinlock_t *);
 extern void blk_queue_prep_rq(request_queue_t *, prep_rq_fn *pfn);
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
+extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
+extern int blk_rq_map_callback(request_queue_t *, struct request *, map_sg_fn *, void *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
 extern long nr_blockdev_pages(void);

-- 
Jens Axboe

