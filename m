Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSKBSpM>; Sat, 2 Nov 2002 13:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSKBSpM>; Sat, 2 Nov 2002 13:45:12 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:56545 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261360AbSKBSoz>; Sat, 2 Nov 2002 13:44:55 -0500
Date: Sat, 2 Nov 2002 10:51:19 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de, thornber@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch(2.5.45): move io_restrictions to blkdev.h
Message-ID: <20021102105119.A6865@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	This patch makes good on a threat that I posted yesterday
to move struct io_restrictions from <linux/device-mapper.h> to
<linux/blkdev.h>, eliminating duplication of a list of fields in
struct request_queue.

	This change makes it easier to manipulate these parameters as
a group, which should allow simplification of a number of drivers that
currently manipulate a subset of these parameters.  I believe it will
enable a number of clean-ups, but I have deliberately not make most of
those clean-ups in this version, because I would like to first get
this infrastructure adjustment done as reliably as possible, hopefully
for 2.5.46.

	By the way, eventually, this change should also make it easier
to lift the mergability tests out of the block layer and make them
work on gather-scatter DMA in general.

	I am running this patch now.  Well, actually, the ll_rw_blk.c
that I'm including here is different from the one that I use, because
I have a bunch of other changes in the version of that file that I
actually use, but the version in this patch compiles without warnings
and the changes are trivial.

	Jens, can I persuade you to integrate this change?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bio.diff"

--- linux-2.5.45/include/linux/device-mapper.h	2002-10-30 16:43:07.000000000 -0800
+++ linux/include/linux/device-mapper.h	2002-11-02 04:11:20.000000000 -0800
@@ -7,6 +7,8 @@
 #ifndef _LINUX_DEVICE_MAPPER_H
 #define _LINUX_DEVICE_MAPPER_H
 
+#include <linux/blkdev.h>
+
 #define DM_DIR "mapper"	/* Slashes not supported */
 #define DM_MAX_TYPE_NAME 16
 #define DM_NAME_LEN 128
@@ -65,15 +67,6 @@
 	dm_status_fn status;
 };
 
-struct io_restrictions {
-	unsigned short		max_sectors;
-	unsigned short		max_phys_segments;
-	unsigned short		max_hw_segments;
-	unsigned short		hardsect_size;
-	unsigned int		max_segment_size;
-	unsigned long		seg_boundary_mask;
-};
-
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
--- linux-2.5.45/include/linux/blkdev.h	2002-10-30 16:42:20.000000000 -0800
+++ linux/include/linux/blkdev.h	2002-11-02 04:57:54.000000000 -0800
@@ -16,6 +16,15 @@
 struct elevator_s;
 typedef struct elevator_s elevator_t;
 
+struct io_restrictions {
+	unsigned short		max_sectors;
+	unsigned short		max_phys_segments;
+	unsigned short		max_hw_segments;
+	unsigned short		hardsect_size;
+	unsigned int		max_segment_size;
+	unsigned long		seg_boundary_mask;
+};
+
 struct request_list {
 	unsigned int count;
 	struct list_head free;
@@ -216,14 +225,9 @@
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
@@ -382,10 +390,10 @@
 {
 	int retval = 512;
 
-	if (q && q->hardsect_size)
-		retval = q->hardsect_size;
+	if (q && q->limits.hardsect_size)
+		retval = q->limits.hardsect_size;
 
 	return retval;
 }
--- linux-2.5.45/include/linux/bio.h	2002-10-30 16:43:36.000000000 -0800
+++ linux/include/linux/bio.h	2002-11-02 05:33:02.000000000 -0800
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
 
--- linux-2.5.45/drivers/block/ioctl.c	2002-10-30 16:41:39.000000000 -0800
+++ linux/drivers/block/ioctl.c	2002-11-02 05:02:30.000000000 -0800
@@ -147,7 +147,7 @@
 	case BLKSSZGET: /* get block device hardware sector size */
 		return put_int(arg, bdev_hardsect_size(bdev));
 	case BLKSECTGET:
-		return put_ushort(arg, bdev_get_queue(bdev)->max_sectors);
+		return put_ushort(arg, bdev_get_queue(bdev)->limits.max_sectors);
 	case BLKRASET:
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
--- linux-2.5.45/drivers/block/ll_rw_blk.c	2002-10-30 16:41:55.000000000 -0800
+++ linux/drivers/block/ll_rw_blk.c	2002-11-02 07:34:52.000000000 -0800
@@ -213,8 +213,8 @@
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
@@ -293,7 +293,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_sectors);
 	}
 
-	q->max_sectors = max_sectors;
+	q->limits.max_sectors = max_sectors;
 }
 
 /**
@@ -313,7 +313,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_segments);
 	}
 
-	q->max_phys_segments = max_segments;
+	q->limits.max_phys_segments = max_segments;
 }
 
 /**
@@ -334,7 +334,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_segments);
 	}
 
-	q->max_hw_segments = max_segments;
+	q->limits.max_hw_segments = max_segments;
 }
 
 /**
@@ -353,7 +353,7 @@
 		printk("%s: set to minimum %d\n", __FUNCTION__, max_size);
 	}
 
-	q->max_segment_size = max_size;
+	q->limits.max_segment_size = max_size;
 }
 
 /**
@@ -369,7 +369,7 @@
  **/
 void blk_queue_hardsect_size(request_queue_t *q, unsigned short size)
 {
-	q->hardsect_size = size;
+	q->limits.hardsect_size = size;
 }
 
 /**
@@ -384,7 +384,7 @@
 		printk("%s: set to minimum %lx\n", __FUNCTION__, mask);
 	}
 
-	q->seg_boundary_mask = mask;
+	q->limits.seg_boundary_mask = mask;
 }
 
 /**
@@ -696,13 +696,13 @@
 		if (bvprv && cluster) {
 			int phys, seg;
 
-			if (seg_size + bv->bv_len > q->max_segment_size) {
+			if (seg_size + bv->bv_len > q->limits.max_segment_size) {
 				nr_phys_segs++;
 				goto new_segment;
 			}
 
 			phys = BIOVEC_PHYS_MERGEABLE(bvprv, bv);
-			seg = BIOVEC_SEG_BOUNDARY(q, bvprv, bv);
+			seg = BIOVEC_SEG_BOUNDARY(&q->limits, bvprv, bv);
 			if (!phys || !seg)
 				nr_phys_segs++;
 			if (!seg)
@@ -737,14 +737,14 @@
 
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
@@ -758,14 +758,14 @@
 
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
@@ -796,12 +796,12 @@
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
@@ -832,7 +832,7 @@
 {
 	int nr_phys_segs = bio_phys_segments(q, bio);
 
-	if (req->nr_phys_segments + nr_phys_segs > q->max_phys_segments) {
+	if (req->nr_phys_segments + nr_phys_segs > q->limits.max_phys_segments) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -853,8 +853,8 @@
 	int nr_hw_segs = bio_hw_segments(q, bio);
 	int nr_phys_segs = bio_phys_segments(q, bio);
 
-	if (req->nr_hw_segments + nr_hw_segs > q->max_hw_segments
-	    || req->nr_phys_segments + nr_phys_segs > q->max_phys_segments) {
+	if (req->nr_hw_segments + nr_hw_segs > q->limits.max_hw_segments
+	    || req->nr_phys_segments + nr_phys_segs > q->limits.max_phys_segments) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -872,7 +872,7 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	if (req->nr_sectors + bio_sectors(bio) > q->limits.max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -887,7 +887,7 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	if (req->nr_sectors + bio_sectors(bio) > q->limits.max_sectors) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -915,21 +915,21 @@
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
@@ -1910,11 +1910,11 @@
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
 
--- linux-2.5.45/drivers/md/dm-table.c	2002-10-30 16:42:54.000000000 -0800
+++ linux/drivers/md/dm-table.c	2002-11-02 04:44:06.000000000 -0800
@@ -465,16 +465,17 @@
 	int r = __table_get_device(ti->table, ti, path,
 				   start, len, mode, result);
 	if (!r) {
-		request_queue_t *q = bdev_get_queue((*result)->bdev);
+		request_queue_t *qlim =
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
--- linux-2.5.45/fs/bio.c	2002-10-30 16:43:00.000000000 -0800
+++ linux/fs/bio.c	2002-11-02 07:50:30.000000000 -0800
@@ -352,14 +352,14 @@
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
@@ -391,7 +391,7 @@
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
 
-	if (((bio->bi_size + len) >> 9) > q->max_sectors)
+	if (((bio->bi_size + len) >> 9) > q->limits.max_sectors)
 		return 0;
 
 	/*
@@ -399,9 +399,9 @@
 	 * make this too complex.
 	 */
 retry_segments:
-	if (bio_phys_segments(q, bio) >= q->max_phys_segments
-	    || bio_hw_segments(q, bio) >= q->max_hw_segments)
+	if (bio_phys_segments(q, bio) >= q->limits.max_phys_segments
+	    || bio_hw_segments(q, bio) >= q->limits.max_hw_segments)
 		fail_segments = 1;
 
 	if (fail_segments) {
--- linux-2.5.45/drivers/block/cciss.c	2002-10-30 16:43:44.000000000 -0800
+++ linux/drivers/block/cciss.c	2002-11-02 10:45:50.000000000 -0800
@@ -763,7 +763,7 @@
 		drive_info_struct *drv = &(hba[ctlr]->drv[i]);
 		if (!drv->nr_blocks)
 			continue;
-		hba[ctlr]->queue.hardsect_size = drv->block_size;
+		blk_queue_hardsect_size(&hba[ctlr]->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -2441,7 +2441,7 @@
 		disk->private_data = drv;
 		if( !(drv->nr_blocks))
 			continue;
-		hba[i]->queue.hardsect_size = drv->block_size;
+		blk_queue_hardsect_size(&hba[i]->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
--- linux-2.5.45/drivers/block/cpqarray.c	2002-10-30 16:41:56.000000000 -0800
+++ linux/drivers/block/cpqarray.c	2002-11-02 10:48:56.000000000 -0800
@@ -409,7 +409,7 @@
 			disk->fops = &ida_fops; 
 			if (!drv->nr_blks)
 				continue;
-			hba[i]->queue.hardsect_size = drv->blk_size;
+			blk_queue_hardsect_size(&hba[i]->queue, drv->blk_size);
 			set_capacity(disk, drv->nr_blks);
 			disk->queue = &hba[i]->queue;
 			disk->private_data = drv;
@@ -1438,7 +1438,7 @@
 		drv_info_t *drv = &hba[ctlr]->drv[i];
 		if (!drv->nr_blks)
 			continue;
-		hba[ctlr]->queue.hardsect_size = drv->blk_size;
+		blk_queue_hardsect_size(&hba[ctlr]->queue, drv->blk_size);
 		set_capacity(disk, drv->nr_blks);
 		disk->queue = &hba[ctlr]->queue;
 		disk->private_data = drv;

--d6Gm4EdcadzBjdND--
