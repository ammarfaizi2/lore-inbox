Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSK0Toq>; Wed, 27 Nov 2002 14:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbSK0Toq>; Wed, 27 Nov 2002 14:44:46 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:33157 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264702AbSK0Tok>; Wed, 27 Nov 2002 14:44:40 -0500
Date: Wed, 27 Nov 2002 11:49:40 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch/resubmit(2.5.49): Use struct io_restrictions in blkdev.h
Message-ID: <20021127114940.A5693@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On November 3, I wrote:
>Jens Axboe wrote:
>>On Sat, Nov 02 2002, Adam J. Richter wrote:
>>>      This patch makes good on a threat that I posted yesterday
>>> to move struct io_restrictions from <linux/device-mapper.h> to
>>> <linux/blkdev.h>, eliminating duplication of a list of fields in
>>> struct request_queue.
>
>>Adam, I generally think the patch is a good idea. I also think it's a
>>very stupid time to start messing with stuff that is basically trivial
>>but still touches lost of stuff.
>
>        It's pretty much simple string substitution and it doesn't
>touch that many files, but OK.
>
>>Please leave it alone for a few weeks.
>
>>>      Jens, can I persuade you to integrate this change?
>
>>In due time, yes.
>
>        Great.  The only thing I was going to do that might depend
>on this patch is try to port /dev/loop to device mapper, and I may
>be able to eliminate the affected code anyhow.
>
>        I've checked in the change and will continue running it in the
>meantime.  Unless I hear otherwise or run into a problem with this
>patch, I'll plan to resubmit it around November 24.

	Here is an updated version of the patch.  The struct
io_restrictions declaration is in <linux/device-mapper.h> so that the
device-mapper user level utilities compile properly (device-mapper.h
is written to support inclusion by user level programs).  I have hand
edited this patch to exclude unrelated changes in my tree, so some of
the line numbers will be off.  I actually "faked" the changes for
drivers/block/{ll_rw_blk,loop}.c because there was too much
intermingling with my other changes, but I've verified that these
"fake" files compile without warnings related to my changes.  I have
also verified that device-mapper-0.96.07 builds with these changes
present.

	I expect this patch will enable other clean-ups in the future.
For example, I think most block device drivers, including scsi
controller drivers, will be able to just declare a static struct
io_restrictions that can be copied into the corresponding q->limits
record for each detected device.  Eventually, this change may also
help in applying you gather-scatter merging code to other users of DMA
gather/scatter.

	Anyhow, I've done what you asked by waiting a few weeks.  If
this patch looks OK to you, could you please integrate it into your
queue for Linus?  Thanks in advance.
	
-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iorestr.diff"

--- linux-2.5.49/include/linux/blkdev.h	2002-11-22 13:40:23.000000000 -0800
+++ linux/include/linux/blkdev.h	2002-11-23 06:41:35.000000000 -0800
@@ -7,6 +7,7 @@
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/wait.h>
+#include <linux/device-mapper.h>
 
 #include <asm/scatterlist.h>
 
@@ -217,14 +218,9 @@
 	/*
 	 * queue settings
 	 */
-	unsigned short		max_sectors;
-	unsigned short		max_phys_segments;
-	unsigned short		max_hw_segments;
-	unsigned short		hardsect_size;
-	unsigned int		max_segment_size;
+	struct io_restrictions	limits;
 
-	unsigned long		seg_boundary_mask;
 	unsigned int		dma_alignment;
 
 	wait_queue_head_t	queue_wait;
@@ -385,10 +385,10 @@
 {
 	int retval = 512;
 
-	if (q && q->hardsect_size)
-		retval = q->hardsect_size;
+	if (q && q->limits.hardsect_size)
+		retval = q->limits.hardsect_size;
 
 	return retval;
 }
--- linux-2.5.49/include/linux/bio.h	2002-11-22 13:40:55.000000000 -0800
+++ linux/include/linux/bio.h	2002-11-02 18:03:18.000000000 -0800
@@ -165,11 +166,11 @@
 	((((bvec_to_phys((vec1)) + (vec1)->bv_len) | bvec_to_phys((vec2))) & (BIO_VMERGE_BOUNDARY - 1)) == 0)
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
-#define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
-	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, (q)->seg_boundary_mask)
-#define BIO_SEG_BOUNDARY(q, b1, b2) \
-	BIOVEC_SEG_BOUNDARY((q), __BVEC_END((b1)), __BVEC_START((b2)))
+#define BIOVEC_SEG_BOUNDARY(limits, b1, b2) \
+	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, (limits)->seg_boundary_mask)
+#define BIO_SEG_BOUNDARY(limits, b1, b2) \
+	BIOVEC_SEG_BOUNDARY((limits), __BVEC_END((b1)), __BVEC_START((b2)))
 
 #define bio_io_error(bio, bytes) bio_endio((bio), (bytes), -EIO)
 
--- linux-2.5.49/drivers/block/ioctl.c	2002-11-22 13:40:15.000000000 -0800
+++ linux/drivers/block/ioctl.c	2002-11-02 18:03:18.000000000 -0800
@@ -147,8 +147,8 @@
 	case BLKSSZGET: /* get block device hardware sector size */
 		return put_int(arg, bdev_hardsect_size(bdev));
 	case BLKSECTGET:
-		return put_ushort(arg, bdev_get_queue(bdev)->max_sectors);
+		return put_ushort(arg, bdev_get_queue(bdev)->limits.max_sectors);
 	case BLKRASET:
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
--- linux-2.5.49/drivers/md/dm-table.c	2002-11-22 13:41:12.000000000 -0800
+++ linux/drivers/md/dm-table.c	2002-11-27 11:20:47.000000000 -0800
@@ -465,16 +465,17 @@
 	int r = __table_get_device(ti->table, ti, path,
 				   start, len, mode, result);
 	if (!r) {
-		request_queue_t *q = bdev_get_queue((*result)->bdev);
+		struct io_restrictions *qlim =
+			&bdev_get_queue((*result)->bdev)->limits;
 		struct io_restrictions *rs = &ti->limits;
 
 		/* combine the device limits low */
-		__LOW(&rs->max_sectors, q->max_sectors);
-		__LOW(&rs->max_phys_segments, q->max_phys_segments);
-		__LOW(&rs->max_hw_segments, q->max_hw_segments);
-		__HIGH(&rs->hardsect_size, q->hardsect_size);
-		__LOW(&rs->max_segment_size, q->max_segment_size);
-		__LOW(&rs->seg_boundary_mask, q->seg_boundary_mask);
+		__LOW(&rs->max_sectors, qlim->max_sectors);
+		__LOW(&rs->max_phys_segments, qlim->max_phys_segments);
+		__LOW(&rs->max_hw_segments, qlim->max_hw_segments);
+		__HIGH(&rs->hardsect_size, qlim->hardsect_size);
+		__LOW(&rs->max_segment_size, qlim->max_segment_size);
+		__LOW(&rs->seg_boundary_mask, qlim->seg_boundary_mask);
 	}
 
 	return r;
@@ -703,13 +704,8 @@
 	 * Make sure we obey the optimistic sub devices
 	 * restrictions.
 	 */
-	q->max_sectors = t->limits.max_sectors;
-	q->max_phys_segments = t->limits.max_phys_segments;
-	q->max_hw_segments = t->limits.max_hw_segments;
-	q->hardsect_size = t->limits.hardsect_size;
-	q->max_segment_size = t->limits.max_segment_size;
-	q->seg_boundary_mask = t->limits.seg_boundary_mask;
+	q->limits = t->limits;
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
--- linux-2.5.49/fs/bio.c	2002-11-22 13:40:48.000000000 -0800
+++ linux/fs/bio.c	2002-11-02 18:03:18.000000000 -0800
@@ -352,14 +359,14 @@
  */
 int bio_get_nr_vecs(struct block_device *bdev)
 {
-	request_queue_t *q = bdev_get_queue(bdev);
+	struct io_restrictions *limit	= &bdev_get_queue(bdev)->limits;
 	int nr_pages;
 
-	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (nr_pages > q->max_phys_segments)
-		nr_pages = q->max_phys_segments;
-	if (nr_pages > q->max_hw_segments)
-		nr_pages = q->max_hw_segments;
+	nr_pages = ((limit->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (nr_pages > limit->max_phys_segments)
+		nr_pages = limit->max_phys_segments;
+	if (nr_pages > limit->max_hw_segments)
+		nr_pages = limit->max_hw_segments;
 
 	return nr_pages;
 }
@@ -391,7 +398,7 @@
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
 
-	if (((bio->bi_size + len) >> 9) > q->max_sectors)
+	if (((bio->bi_size + len) >> 9) > q->limits.max_sectors)
 		return 0;
 
 	/*
@@ -399,8 +406,8 @@
 	 * make this too complex.
 	 */
 retry_segments:
-	if (bio_phys_segments(q, bio) >= q->max_phys_segments
-	    || bio_hw_segments(q, bio) >= q->max_hw_segments)
+	if (bio_phys_segments(q, bio) >= q->limits.max_phys_segments
+	    || bio_hw_segments(q, bio) >= q->limits.max_hw_segments)
 		fail_segments = 1;
 
 	if (fail_segments) {
@@ -446,4 +453,4 @@
 	return len;
 }
 
--- linux-2.5.49/drivers/block/cciss.c	2002-11-22 13:41:10.000000000 -0800
+++ linux/drivers/block/cciss.c	2002-11-17 22:34:54.000000000 -0800
@@ -764,7 +764,7 @@
 		drive_info_struct *drv = &(hba[ctlr]->drv[i]);
 		if (!drv->nr_blocks)
 			continue;
-		hba[ctlr]->queue.hardsect_size = drv->block_size;
+		blk_queue_hardsect_size(&hba[ctlr]->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -2442,9 +2442,9 @@
 		disk->private_data = drv;
 		if( !(drv->nr_blocks))
 			continue;
-		hba[i]->queue.hardsect_size = drv->block_size;
+		blk_queue_hardsect_size(&hba[i]->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
--- linux-2.5.49/drivers/block/cpqarray.c	2002-11-22 13:40:21.000000000 -0800
+++ linux/drivers/block/cpqarray.c	2002-11-17 22:34:44.000000000 -0800
@@ -410,7 +418,7 @@
 			disk->fops = &ida_fops; 
 			if (!drv->nr_blks)
 				continue;
-			hba[i]->queue.hardsect_size = drv->blk_size;
+			blk_queue_hardsect_size(&hba[i]->queue, drv->blk_size);
 			set_capacity(disk, drv->nr_blks);
 			disk->queue = &hba[i]->queue;
 			disk->private_data = drv;
@@ -1439,7 +1447,7 @@
 		drv_info_t *drv = &hba[ctlr]->drv[i];
 		if (!drv->nr_blks)
 			continue;
-		hba[ctlr]->queue.hardsect_size = drv->blk_size;
+		blk_queue_hardsect_size(&hba[ctlr]->queue, drv->blk_size);
 		set_capacity(disk, drv->nr_blks);
 		disk->queue = &hba[ctlr]->queue;
 		disk->private_data = drv;
--- linux-2.5.49/drivers/block/ll_rw_blk.c	2002-11-22 13:40:19.000000000 -0800
+++ linux/drivers/block/ll_rw_blk.c	2002-11-27 11:16:27.000000000 -0800
@@ -228,8 +228,8 @@
 	/*
 	 * set defaults
 	 */
-	q->max_phys_segments = MAX_PHYS_SEGMENTS;
-	q->max_hw_segments = MAX_HW_SEGMENTS;
+	q->limits.max_phys_segments = MAX_PHYS_SEGMENTS;
+	q->limits.max_hw_segments = MAX_HW_SEGMENTS;
 	q->make_request_fn = mfn;
 	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 	q->backing_dev_info.state = 0;
@@ -308,7 +308,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_sectors);
 	}
 
-	q->max_sectors = max_sectors;
+	q->limits.max_sectors = max_sectors;
 }
 
 /**
@@ -328,7 +328,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_segments);
 	}
 
-	q->max_phys_segments = max_segments;
+	q->limits.max_phys_segments = max_segments;
 }
 
 /**
@@ -349,7 +349,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_segments);
 	}
 
-	q->max_hw_segments = max_segments;
+	q->limits.max_hw_segments = max_segments;
 }
 
 /**
@@ -368,7 +368,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_size);
 	}
 
-	q->max_segment_size = max_size;
+	q->limits.max_segment_size = max_size;
 }
 
 /**
@@ -384,7 +384,7 @@
  **/
 void blk_queue_hardsect_size(request_queue_t *q, unsigned short size)
 {
-	q->hardsect_size = size;
+	q->limits.hardsect_size = size;
 }
 
 /**
@@ -399,7 +399,7 @@
 		printk("%s: set to minimum %lx\n", __FUNCTION__, mask);
 	}
 
-	q->seg_boundary_mask = mask;
+	q->limits.seg_boundary_mask = mask;
 }
 
 /**
@@ -711,11 +711,11 @@
 	seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
 		if (bvprv && cluster) {
-			if (seg_size + bv->bv_len > q->max_segment_size)
+			if (seg_size + bv->bv_len > q->limits.max_segment_size)
 				goto new_segment;
 			if (!BIOVEC_PHYS_MERGEABLE(bvprv, bv))
 				goto new_segment;
-			if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bv))
+			if (!BIOVEC_SEG_BOUNDARY(&q->limits, bvprv, bv))
 				goto new_segment;
 
 			seg_size += bv->bv_len;
@@ -745,14 +745,14 @@
 
 	if (!BIOVEC_PHYS_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
 		return 0;
-	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
+	if (bio->bi_size + nxt->bi_size > q->limits.max_segment_size)
 		return 0;
 
 	/*
 	 * bio and nxt are contigous in memory, check if the queue allows
 	 * these two to be merged into one
 	 */
-	if (BIO_SEG_BOUNDARY(q, bio, nxt))
+	if (BIO_SEG_BOUNDARY(&q->limits, bio, nxt))
 		return 1;
 
 	return 0;
@@ -766,14 +766,14 @@
 
 	if (!BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
 		return 0;
-	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
+	if (bio->bi_size + nxt->bi_size > q->limits.max_segment_size)
 		return 0;
 
 	/*
 	 * bio and nxt are contigous in memory, check if the queue allows
 	 * these two to be merged into one
 	 */
-	if (BIO_SEG_BOUNDARY(q, bio, nxt))
+	if (BIO_SEG_BOUNDARY(&q->limits, bio, nxt))
 		return 1;
 
 	return 0;
@@ -804,12 +804,12 @@
 			int nbytes = bvec->bv_len;
 
 			if (bvprv && cluster) {
-				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
+				if (sg[nsegs - 1].length + nbytes > q->limits.max_segment_size)
 					goto new_segment;
 
 				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
 					goto new_segment;
-				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
+				if (!BIOVEC_SEG_BOUNDARY(&q->limits, bvprv, bvec))
 					goto new_segment;
 
 				sg[nsegs - 1].length += nbytes;
@@ -840,7 +840,7 @@
 {
 	int nr_phys_segs = bio_phys_segments(q, bio);
 
-	if (req->nr_phys_segments + nr_phys_segs > q->max_phys_segments) {
+	if (req->nr_phys_segments + nr_phys_segs > q->limits.max_phys_segments) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -861,8 +861,8 @@
 	int nr_hw_segs = bio_hw_segments(q, bio);
 	int nr_phys_segs = bio_phys_segments(q, bio);
 
-	if (req->nr_hw_segments + nr_hw_segs > q->max_hw_segments
-	    || req->nr_phys_segments + nr_phys_segs > q->max_phys_segments) {
+	if (req->nr_hw_segments + nr_hw_segs > q->limits.max_hw_segments
+	    || req->nr_phys_segments + nr_phys_segs > q->limits.max_phys_segments) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -880,7 +880,7 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	if (req->nr_sectors + bio_sectors(bio) > q->limits.max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -895,7 +895,7 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	if (req->nr_sectors + bio_sectors(bio) > q->limits.max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -923,21 +923,21 @@
 	/*
 	 * Will it become to large?
 	 */
-	if ((req->nr_sectors + next->nr_sectors) > q->max_sectors)
+	if ((req->nr_sectors + next->nr_sectors) > q->limits.max_sectors)
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
 	if (blk_phys_contig_segment(q, req->biotail, next->bio))
 		total_phys_segments--;
 
-	if (total_phys_segments > q->max_phys_segments)
+	if (total_phys_segments > q->limits.max_phys_segments)
 		return 0;
 
 	total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
 	if (blk_hw_contig_segment(q, req->biotail, next->bio))
 		total_hw_segments--;
 
-	if (total_hw_segments > q->max_hw_segments)
+	if (total_hw_segments > q->limits.max_hw_segments)
 		return 0;
 
 	/* Merge is OK... */
@@ -1915,11 +1915,11 @@
 			break;
 		}
 
-		if (unlikely(bio_sectors(bio) > q->max_sectors)) {
+		if (unlikely(bio_sectors(bio) > q->limits.max_sectors)) {
 			printk("bio too big device %s (%u > %u)\n", 
 			       bdevname(bio->bi_bdev),
 			       bio_sectors(bio),
-			       q->max_sectors);
+			       q->limits.max_sectors);
 			goto end_io;
 		}
 
--- linux-2.5.49/drivers/block/loop.c	2002-11-22 13:40:46.000000000 -0800
+++ linux/drivers/block/loop.c	2002-11-27 11:28:52.000000000 -0800
@@ -728,11 +728,7 @@
 	if (S_ISBLK(inode->i_mode)) {
 		request_queue_t *q = bdev_get_queue(lo_device);
 
-		blk_queue_max_sectors(&lo->lo_queue, q->max_sectors);
-		blk_queue_max_phys_segments(&lo->lo_queue,q->max_phys_segments);
-		blk_queue_max_hw_segments(&lo->lo_queue, q->max_hw_segments);
-		blk_queue_max_segment_size(&lo->lo_queue, q->max_segment_size);
-		blk_queue_segment_boundary(&lo->lo_queue, q->seg_boundary_mask);
+		lo->lo_queue.limits = q->limits;
 		blk_queue_merge_bvec(&lo->lo_queue, q->merge_bvec_fn);
 	}
 

--vtzGhvizbBRQ85DL--
