Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTDXILd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDXILd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:11:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261717AbTDXIL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:11:26 -0400
Date: Thu, 24 Apr 2003 10:23:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (1/4)
Message-ID: <20030424082331.GE8775@suse.de>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl> <Pine.SOL.4.30.0304231937390.10502-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304231937390.10502-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23 2003, Bartlomiej Zolnierkiewicz wrote:
>  		bio = bio_map_user(bdev, uaddr, hdr.dxfer_len, reading);
> -		if (bio) {
> -			if (writing)
> -				bio->bi_rw |= (1 << BIO_RW);
> -
> -			nr_sectors = (bio->bi_size + 511) >> 9;
> -
> -			if (bio->bi_size < hdr.dxfer_len) {
> -				bio_endio(bio, bio->bi_size, 0);
> -				bio_unmap_user(bio, 0);
> -				bio = NULL;
> -			}
> -		}
> +		if (bio && writing)
> +			bio->bi_rw |= (1 << BIO_RW);

I think it's cleaner to have bio_map_user() set the direction bit,
instead of having every user do it. It also uncovered an old bug where
blk_queue_bounce() is called without the direction bit set in the bio,
uh oh...

Here's my preferred version. You also had the incremental bio processing
as a prereq for this bio addition, I removed that for now as well.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1216  -> 1.1217 
#	drivers/block/ll_rw_blk.c	1.167   -> 1.168  
#	include/linux/blkdev.h	1.100   -> 1.101  
#	            fs/bio.c	1.41    -> 1.42   
#	drivers/block/scsi_ioctl.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/24	axboe@smithers.home.kernel.dk	1.1217
# - Abstract out bio request preparation
# - Have bio_map_user() set data direction (fixes bug where blk_queue_bounce()
#   is called without it set)
# - Split bio_map_user() in two
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Thu Apr 24 10:23:09 2003
+++ b/drivers/block/ll_rw_blk.c	Thu Apr 24 10:23:09 2003
@@ -2196,6 +2196,21 @@
 	}
 }
 
+void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct bio *bio)
+{
+	/* first three bits are identical in rq->flags and bio->bi_rw */
+	rq->flags |= (bio->bi_rw & 7);
+
+	rq->nr_phys_segments = bio_phys_segments(q, bio);
+	rq->nr_hw_segments = bio_hw_segments(q, bio);
+	rq->current_nr_sectors = bio_cur_sectors(bio);
+	rq->hard_cur_sectors = rq->current_nr_sectors;
+	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
+	rq->buffer = bio_data(bio);
+
+	rq->bio = rq->biotail = bio;
+}
+
 int __init blk_dev_init(void)
 {
 	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
@@ -2285,3 +2300,5 @@
 EXPORT_SYMBOL(__blk_stop_queue);
 EXPORT_SYMBOL(blk_run_queue);
 EXPORT_SYMBOL(blk_run_queues);
+
+EXPORT_SYMBOL(blk_rq_bio_prep);
diff -Nru a/drivers/block/scsi_ioctl.c b/drivers/block/scsi_ioctl.c
--- a/drivers/block/scsi_ioctl.c	Thu Apr 24 10:23:09 2003
+++ b/drivers/block/scsi_ioctl.c	Thu Apr 24 10:23:09 2003
@@ -193,18 +193,6 @@
 		 * be a write to vm.
 		 */
 		bio = bio_map_user(bdev, uaddr, hdr.dxfer_len, reading);
-		if (bio) {
-			if (writing)
-				bio->bi_rw |= (1 << BIO_RW);
-
-			nr_sectors = (bio->bi_size + 511) >> 9;
-
-			if (bio->bi_size < hdr.dxfer_len) {
-				bio_endio(bio, bio->bi_size, 0);
-				bio_unmap_user(bio, 0);
-				bio = NULL;
-			}
-		}
 
 		/*
 		 * if bio setup failed, fall back to slow approach
@@ -243,21 +231,10 @@
 	rq->hard_nr_sectors = rq->nr_sectors = nr_sectors;
 	rq->hard_cur_sectors = rq->current_nr_sectors = nr_sectors;
 
-	if (bio) {
-		/*
-		 * subtle -- if bio_map_user() ended up bouncing a bio, it
-		 * would normally disappear when its bi_end_io is run.
-		 * however, we need it for the unmap, so grab an extra
-		 * reference to it
-		 */
-		bio_get(bio);
+	rq->bio = rq->biotail = bio;
 
-		rq->nr_phys_segments = bio_phys_segments(q, bio);
-		rq->nr_hw_segments = bio_hw_segments(q, bio);
-		rq->current_nr_sectors = bio_cur_sectors(bio);
-		rq->hard_cur_sectors = rq->current_nr_sectors;
-		rq->buffer = bio_data(bio);
-	}
+	if (bio)
+		blk_rq_bio_prep(q, rq, bio);
 
 	rq->data_len = hdr.dxfer_len;
 	rq->data = buffer;
@@ -268,8 +245,6 @@
 	if (!rq->timeout)
 		rq->timeout = BLK_DEFAULT_TIMEOUT;
 
-	rq->bio = rq->biotail = bio;
-
 	start_time = jiffies;
 
 	/* ignore return value. All information is passed back to caller
@@ -277,11 +252,9 @@
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
 	blk_do_rq(q, bdev, rq);
-	
-	if (bio) {
+
+	if (bio)
 		bio_unmap_user(bio, reading);
-		bio_put(bio);
-	}
 
 	/* write to all output members */
 	hdr.status = rq->errors;	
diff -Nru a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c	Thu Apr 24 10:23:09 2003
+++ b/fs/bio.c	Thu Apr 24 10:23:09 2003
@@ -434,19 +434,9 @@
 	return len;
 }
 
-/**
- *	bio_map_user	-	map user address into bio
- *	@bdev: destination block device
- *	@uaddr: start of user address
- *	@len: length in bytes
- *	@write_to_vm: bool indicating writing to pages or not
- *
- *	Map the user space address into a bio suitable for io to a block
- *	device. Caller should check the size of the returned bio, we might
- *	not have mapped the entire range specified.
- */
-struct bio *bio_map_user(struct block_device *bdev, unsigned long uaddr,
-			 unsigned int len, int write_to_vm)
+static struct bio *__bio_map_user(struct block_device *bdev,
+				  unsigned long uaddr, unsigned int len,
+				  int write_to_vm)
 {
 	unsigned long end = (uaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = uaddr >> PAGE_SHIFT;
@@ -510,8 +500,11 @@
 	kfree(pages);
 
 	/*
-	 * check if the mapped pages need bouncing for an isa host.
+	 * set data direction, and check if mapped pages need bouncing
 	 */
+	if (!write_to_vm)
+		bio->bi_rw |= (1 << BIO_RW);
+
 	blk_queue_bounce(q, &bio);
 	return bio;
 out:
@@ -521,17 +514,42 @@
 }
 
 /**
- *	bio_unmap_user	-	unmap a bio
- *	@bio:		the bio being unmapped
- *	@write_to_vm:	bool indicating whether pages were written to
- *
- *	Unmap a bio previously mapped by bio_map_user(). The @write_to_vm
- *	must be the same as passed into bio_map_user(). Must be called with
- *	a process context.
+ *	bio_map_user	-	map user address into bio
+ *	@bdev: destination block device
+ *	@uaddr: start of user address
+ *	@len: length in bytes
+ *	@write_to_vm: bool indicating writing to pages or not
  *
- *	bio_unmap_user() may sleep.
+ *	Map the user space address into a bio suitable for io to a block
+ *	device.
  */
-void bio_unmap_user(struct bio *bio, int write_to_vm)
+struct bio *bio_map_user(struct block_device *bdev, unsigned long uaddr,
+			 unsigned int len, int write_to_vm)
+{
+	struct bio *bio;
+
+	bio = __bio_map_user(bdev, uaddr, len, write_to_vm);
+
+	if (bio) {
+		if (bio->bi_size < len) {
+			bio_endio(bio, bio->bi_size, 0);
+			bio_unmap_user(bio, 0);
+			return NULL;
+		}
+
+		/*
+		 * subtle -- if __bio_map_user() ended up bouncing a bio,
+		 * it would normally disappear when its bi_end_io is run.
+		 * however, we need it for the unmap, so grab an extra
+		 * reference to it
+		 */
+		bio_get(bio);
+	}
+
+	return bio;
+}
+
+static void __bio_unmap_user(struct bio *bio, int write_to_vm)
 {
 	struct bio_vec *bvec;
 	int i;
@@ -558,6 +576,23 @@
 		page_cache_release(bvec->bv_page);
 	}
 
+	bio_put(bio);
+}
+
+/**
+ *	bio_unmap_user	-	unmap a bio
+ *	@bio:		the bio being unmapped
+ *	@write_to_vm:	bool indicating whether pages were written to
+ *
+ *	Unmap a bio previously mapped by bio_map_user(). The @write_to_vm
+ *	must be the same as passed into bio_map_user(). Must be called with
+ *	a process context.
+ *
+ *	bio_unmap_user() may sleep.
+ */
+void bio_unmap_user(struct bio *bio, int write_to_vm)
+{
+	__bio_unmap_user(bio, write_to_vm);
 	bio_put(bio);
 }
 
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Thu Apr 24 10:23:09 2003
+++ b/include/linux/blkdev.h	Thu Apr 24 10:23:09 2003
@@ -391,6 +391,8 @@
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);
 
+extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
+
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
 #define MAX_SECTORS 255

-- 
Jens Axboe

