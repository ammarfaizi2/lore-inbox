Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSJ1PVM>; Mon, 28 Oct 2002 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSJ1PVM>; Mon, 28 Oct 2002 10:21:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42139 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261329AbSJ1PVG>;
	Mon, 28 Oct 2002 10:21:06 -0500
Date: Mon, 28 Oct 2002 16:24:33 +0100
From: Jens Axboe <axboe@suse.de>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021028152433.GG2937@suse.de>
References: <45B36A38D959B44CB032DA427A6E1064045132C1@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B36A38D959B44CB032DA427A6E1064045132C1@cceexc18.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Cameron, Steve wrote:
> > 
> > On Fri, Oct 25 2002, Jens Axboe wrote:
> [...] 
> > of course, and likewise for the cluster check. I'll cut a 
> > clean version
> > tomorrow, I'm out for today..
> > 
> Ok, Thanks. I'm out 'til Monday.
> 
> What originally drove me down this road was not wanting to 
> have:
> 
> 	struct scatterlist tmpsg[XXX]; /* 8 kbytes */
> 
> on the stack for every command when XXX might be 512, which 
> was what I was expecting when I started writing this patch.  
> Once I got it working, empirically I saw the most I ever 
> get is 64 SGs.  I don't know if that's a kernel limit, or 
> if I just haven't beat on the system hard enough.

It's not a kernel limit. If you queue limits are all beyond 64 entries,
what you typically see is that you just hit what mpage will fill in for
you. One thing that should give you max number of sg entries is plain
and simple:

	dd if=/dev/zero of=some_file bs=4096k

Besides, if you put 8kb on the stack you are already seriously in
trouble. 64 entries is already 1280 bytes on stack for pae x86. On
64-bit archs you are hitting the 2kb limit. I like your idea of having a
consume function, so I think we should just stick with that.

> In hindsight, perhaps it would have been better for me to just put
> it on the stack like before, only moreso, and just change the 
> driver to use more SGs, and only later tackle the stack problem, 
> if necessary.  As you noted, it's not clear that the overhead of 
> the function call per scatter gather element isn't worse than 
> just reformatting the entire scatter gather list in a separate 
> pass, as is currently done (before my patch).  

Well that's hard to say, needs to be profile. For reference, here's my
current patch. This one has even been booted, seems to work :-). Don't
mind the dma_alignment bits, that's just polution from my tree.

===== drivers/block/cciss.c 1.63 vs edited =====
--- 1.63/drivers/block/cciss.c	Fri Oct 18 12:55:58 2002
+++ edited/drivers/block/cciss.c	Sun Oct 27 15:35:37 2002
@@ -1681,6 +1681,28 @@
 	end_that_request_last(cmd->rq);
 }
 
+struct cciss_map_state {
+	CommandList_struct *command;
+	int data_dir;
+};
+
+static void cciss_map_sg(request_queue_t *q, struct scatterlist *sg, int nseg,
+			 void *cookie)
+{
+	struct cciss_map_state *s = cookie;
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
+	seg = blk_rq_map_consume(q, creq, cciss_map_sg, &map_state);
 
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
+++ edited/drivers/block/ll_rw_blk.c	Mon Oct 28 11:43:27 2002
@@ -765,61 +793,123 @@
 	return 0;
 }
 
-/*
- * map a request to scatterlist, return number of sg entries setup. Caller
- * must make sure sg can hold rq->nr_phys_segments entries
- */
-int blk_rq_map_sg(request_queue_t *q, struct request *rq, struct scatterlist *sg)
+static int __blk_rq_map(request_queue_t *q, struct request *rq,
+			consume_sg_fn *consume_fn, void *cookie)
 {
 	struct bio_vec *bvec, *bvprv;
+	struct scatterlist sg;
 	struct bio *bio;
-	int nsegs, i, cluster;
-
-	nsegs = 0;
-	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
+	int nsegs, i;
+	const int cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
+	const int max_seg = q->max_segment_size;
 
 	/*
 	 * for each bio in rq
 	 */
-	bvprv = NULL;
+	nsegs = 0;
 	rq_for_each_bio(bio, rq) {
 		/*
 		 * for each segment in bio
 		 */
+		bvprv = NULL;
 		bio_for_each_segment(bvec, bio, i) {
-			int nbytes = bvec->bv_len;
-
-			if (bvprv && cluster) {
-				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
-					goto new_segment;
-
-				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
-					goto new_segment;
-				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
-					goto new_segment;
-
-				sg[nsegs - 1].length += nbytes;
-			} else {
-new_segment:
-				memset(&sg[nsegs],0,sizeof(struct scatterlist));
-				sg[nsegs].page = bvec->bv_page;
-				sg[nsegs].length = nbytes;
-				sg[nsegs].offset = bvec->bv_offset;
+			/*
+			 * if length does not exceed max segment size
+			 * and does not straddle a physical memory
+			 * boundary and does not start a new physical
+			 * segment, cluster on to previous one
+			 */
+			if ((bvprv && cluster)
+			    && (sg.length + bvec->bv_len <= max_seg)
+			    && BIOVEC_PHYS_MERGEABLE(bvprv, bvec)
+			    && BIOVEC_SEG_BOUNDARY(q, bvprv, bvec)) {
+				sg.length += bvec->bv_len;
+				continue;
+			}
 
+			/*
+			 * could/must not cluster, start a new segment making
+			 * sure to consume the previous one first
+			 */
+			if (bvprv) {
+				consume_fn(q, &sg, nsegs, cookie);
 				nsegs++;
 			}
+
+			sg.page = bvec->bv_page;
+			sg.offset = bvec->bv_offset;
+			sg.length = bvec->bv_len;
 			bvprv = bvec;
+
 		} /* segments in bio */
+
+		/*
+		 * consume leftover segment, if any
+		 */
+		if (bvprv) {
+			consume_fn(q, &sg, nsegs, cookie);
+			nsegs++;
+		}
+
 	} /* bios in rq */
 
 	return nsegs;
 }
 
+static void blk_consume_sg(request_queue_t *q, struct scatterlist *sg,
+			  int segment, void *cookie)
+{
+	struct scatterlist *sglist = cookie;
+
+	sglist[segment].page = sg->page;
+	sglist[segment].offset = sg->offset;
+	sglist[segment].length = sg->length;
+}
+
+/**
+ * blk_rq_map_sg - map a request to a scatterlist
+ * @q:    The &request_queue_t the request belongs to
+ * @rq:   The request
+ * @sg:   The scatterlist to map to
+ *
+ * Description:
+ *
+ *   Map a request to a scatterlist, returning the number of sg entries
+ *   setup. Caller must make sure that @sg can hold ->nr_phys_segment
+ *   worth of entries.
+ **/
+int blk_rq_map_sg(request_queue_t *q, struct request *rq,struct scatterlist *sg)
+{
+	return __blk_rq_map(q, rq, blk_consume_sg, sg);
+}
+
+/**
+ * blk_rq_map_consume - map a request, calling a consume function for each entry
+ * @q:          The &request_queue_t the request belongs to
+ * @rq:         The request
+ * @consume_fn: Function to call for each sg mapping
+ * @cookie:     Per-mapping cookie
+ *
+ * Description:
+ *
+ *   Like blk_rq_map_sg(), but call the @consume_fn for each sg entry
+ *   prepared. Some drivers find this more handy if their internal
+ *   scatterlist is different from the Linux scatterlist since they then
+ *   don't have to allocate (on stack or dynamically) a large dummy scatterlist
+ *   just for the intermediate request mapping. Drivers can use @cookie to
+ *   separate various mappings from each other, typically by passing the actual
+ *   hardware command here.
+ **/
+int blk_rq_map_consume(request_queue_t *q, struct request *rq,
+		       consume_sg_fn *consume_fn, void *cookie)
+{
+	return __blk_rq_map(q, rq, consume_fn, cookie);
+}
+
 /*
  * the standard queue merge functions, can be overridden with device
  * specific ones if so desired
  */
-
 static inline int ll_new_mergeable(request_queue_t *q,
 				   struct request *req,
 				   struct bio *bio)
@@ -2112,7 +2266,9 @@
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 EXPORT_SYMBOL(blk_queue_hardsect_size);
 EXPORT_SYMBOL(blk_queue_segment_boundary);
+EXPORT_SYMBOL(blk_queue_dma_alignment);
 EXPORT_SYMBOL(blk_rq_map_sg);
+EXPORT_SYMBOL(blk_rq_map_consume);
 EXPORT_SYMBOL(blk_nohighio);
 EXPORT_SYMBOL(blk_dump_rq_flags);
 EXPORT_SYMBOL(submit_bio);
===== include/linux/blkdev.h 1.76 vs edited =====
--- 1.76/include/linux/blkdev.h	Fri Oct 18 19:50:43 2002
+++ edited/include/linux/blkdev.h	Sun Oct 27 22:06:19 2002
@@ -339,9 +353,14 @@
 extern void blk_queue_assign_lock(request_queue_t *, spinlock_t *);
 extern void blk_queue_prep_rq(request_queue_t *, prep_rq_fn *pfn);
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
+extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
+
+typedef void (consume_sg_fn) (request_queue_t *q, struct scatterlist *, int, void *);
+extern int blk_rq_map_consume(request_queue_t *, struct request *, consume_sg_fn *, void *);
+
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
 extern long nr_blockdev_pages(void);

-- 
Jens Axboe

