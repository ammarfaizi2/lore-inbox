Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTDWR1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTDWR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:27:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5585 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264152AbTDWR06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:26:58 -0400
Date: Wed, 23 Apr 2003 19:38:40 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (1/4)
In-Reply-To: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304231937390.10502-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Enhance bio_(un)map_user() and add blk_rq_bio_prep().
#
# Detailed changelog:
# - add blk_rq_bio_prep() helper for preparing non-fs bio based requests
# - bio_(un)map_user() -> __bio_(un)map_user()
# - add bio_(un)map_user() wrappers for __bio_(un)map_user(),
#   bio_map_user() checks size of bio returned by __bio_map_user()
#   and gets additional reference to bio (see comment inside)
# - update sg_io() to use new bio_(un)map_user() and blk_rq_bio_prep()
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac2-tf4/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.67-ac2-tf4/drivers/block/ll_rw_blk.c	Wed Apr 23 15:14:11 2003
+++ linux/drivers/block/ll_rw_blk.c	Wed Apr 23 15:19:27 2003
@@ -2274,6 +2274,21 @@
 	return 1;
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
+	rq->hard_bio = rq->bio = rq->biotail = bio;
+}
+
 int __init blk_dev_init(void)
 {
 	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
@@ -2363,3 +2378,5 @@
 EXPORT_SYMBOL(__blk_stop_queue);
 EXPORT_SYMBOL(__blk_run_queue);
 EXPORT_SYMBOL(blk_run_queues);
+
+EXPORT_SYMBOL(blk_rq_bio_prep);
diff -uNr linux-2.5.67-ac2-tf4/drivers/block/scsi_ioctl.c linux/drivers/block/scsi_ioctl.c
--- linux-2.5.67-ac2-tf4/drivers/block/scsi_ioctl.c	Sun Apr 13 00:07:39 2003
+++ linux/drivers/block/scsi_ioctl.c	Tue Apr 22 17:57:22 2003
@@ -193,18 +193,8 @@
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
+		if (bio && writing)
+			bio->bi_rw |= (1 << BIO_RW);

 		/*
 		 * if bio setup failed, fall back to slow approach
@@ -243,21 +233,10 @@
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
+	rq->hard_bio = rq->bio = rq->biotail = bio;

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
@@ -268,8 +247,6 @@
 	if (!rq->timeout)
 		rq->timeout = BLK_DEFAULT_TIMEOUT;

-	rq->bio = rq->biotail = bio;
-
 	start_time = jiffies;

 	/* ignore return value. All information is passed back to caller
@@ -277,11 +254,9 @@
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
diff -uNr linux-2.5.67-ac2-tf4/fs/bio.c linux/fs/bio.c
--- linux-2.5.67-ac2-tf4/fs/bio.c	Thu Apr 17 17:46:02 2003
+++ linux/fs/bio.c	Tue Apr 22 17:55:03 2003
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
@@ -521,17 +511,42 @@
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
@@ -561,6 +576,23 @@
 	bio_put(bio);
 }

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
+	bio_put(bio);
+}
+
 /*
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
  * for performing direct-IO in BIOs.
diff -uNr linux-2.5.67-ac2-tf4/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.67-ac2-tf4/include/linux/blkdev.h	Fri Apr 18 02:03:38 2003
+++ linux/include/linux/blkdev.h	Tue Apr 22 17:48:52 2003
@@ -432,6 +432,8 @@
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);

+extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
+
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
 #define MAX_SECTORS 255

