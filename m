Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUCRODU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUCRODU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:03:20 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:6663 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262650AbUCROCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:02:52 -0500
Message-ID: <4059AC04.3060109@cs.wisc.edu>
Date: Thu, 18 Mar 2004 06:02:44 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2][RFC] add detailed error values to block layer
Content-Type: multipart/mixed;
 boundary="------------070505040702060302020908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505040702060302020908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

01-ec-core.patch defines new block error values, and modifies the request
completion functions. Right now they just convert the uptodate status to
an error value.

diffstat

drivers/block/ll_rw_blk.c |   25 +++++++++++++------------
fs/bio.c                  |    8 ++++----
include/linux/bio.h       |    2 +-
include/linux/blkdev.h    |   16 ++++++++++++++++
4 files changed, 34 insertions(+), 17 deletions(-)


Mike Chrisite


--------------070505040702060302020908
Content-Type: text/plain;
 name="01-ec-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-ec-core.patch"

diff -aurp linux-2.6.5-rc1-orig/drivers/block/ll_rw_blk.c linux-2.6.5-rc1-ec/drivers/block/ll_rw_blk.c
--- linux-2.6.5-rc1-orig/drivers/block/ll_rw_blk.c	2004-03-15 21:45:33.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/ll_rw_blk.c	2004-03-18 04:44:39.000000000 -0800
@@ -2597,10 +2597,10 @@ void blk_recalc_rq_sectors(struct reques
 	}
 }
 
-static int __end_that_request_first(struct request *req, int uptodate,
+static int __end_that_request_first(struct request *req, int error,
 				    int nr_bytes)
 {
-	int total_bytes, bio_nbytes, error = 0, next_idx = 0;
+	int total_bytes, bio_nbytes, next_idx = 0;
 	struct bio *bio;
 
 	/*
@@ -2610,13 +2610,10 @@ static int __end_that_request_first(stru
 	if (!blk_pc_request(req))
 		req->errors = 0;
 
-	if (!uptodate) {
-		error = -EIO;
-		if (blk_fs_request(req) && !(req->flags & REQ_QUIET))
-			printk("end_request: I/O error, dev %s, sector %llu\n",
-				req->rq_disk ? req->rq_disk->disk_name : "?",
-				(unsigned long long)req->sector);
-	}
+	if (error && blk_fs_request(req) && !(req->flags & REQ_QUIET))
+		printk("end_request: I/O error num %d, dev %s, sector %llu\n",
+		       error, req->rq_disk ? req->rq_disk->disk_name : "?",
+		       (unsigned long long)req->sector);
 
 	total_bytes = bio_nbytes = 0;
 	while ((bio = req->bio)) {
@@ -2707,7 +2704,8 @@ static int __end_that_request_first(stru
  **/
 int end_that_request_first(struct request *req, int uptodate, int nr_sectors)
 {
-	return __end_that_request_first(req, uptodate, nr_sectors << 9);
+	int err = uptodate ? BLK_SUCCESS : BLK_ERR;
+	return __end_that_request_first(req, err, nr_sectors << 9);
 }
 
 EXPORT_SYMBOL(end_that_request_first);
@@ -2729,7 +2727,8 @@ EXPORT_SYMBOL(end_that_request_first);
  **/
 int end_that_request_chunk(struct request *req, int uptodate, int nr_bytes)
 {
-	return __end_that_request_first(req, uptodate, nr_bytes);
+	int err = uptodate ? BLK_SUCCESS : BLK_ERR;
+	return __end_that_request_first(req, err, nr_bytes);
 }
 
 EXPORT_SYMBOL(end_that_request_chunk);
@@ -2767,7 +2766,9 @@ EXPORT_SYMBOL(end_that_request_last);
 
 void end_request(struct request *req, int uptodate)
 {
-	if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
+	int err = uptodate ? BLK_SUCCESS : BLK_ERR;
+
+	if (!end_that_request_first(req, err, req->hard_cur_sectors)) {
 		add_disk_randomness(req->rq_disk);
 		blkdev_dequeue_request(req);
 		end_that_request_last(req);
diff -aurp linux-2.6.5-rc1-orig/fs/bio.c linux-2.6.5-rc1-ec/fs/bio.c
--- linux-2.6.5-rc1-orig/fs/bio.c	2004-03-15 21:46:44.000000000 -0800
+++ linux-2.6.5-rc1-ec/fs/bio.c	2004-03-18 04:44:39.000000000 -0800
@@ -664,10 +664,10 @@ void bio_check_pages_dirty(struct bio *b
  *   bio_endio() will end I/O on @bytes_done number of bytes. This may be
  *   just a partial part of the bio, or it may be the whole bio. bio_endio()
  *   is the preferred way to end I/O on a bio, it takes care of decrementing
- *   bi_size and clearing BIO_UPTODATE on error. @error is 0 on success, and
- *   and one of the established -Exxxx (-EIO, for instance) error values in
- *   case something went wrong. Noone should call bi_end_io() directly on
- *   a bio unless they own it and thus know that it has an end_io function.
+ *   bi_size and clearing BIO_UPTODATE on error. @error is one of the
+ *   established BLK_xxx error values defined in blkdev.h. Noone should
+ *   call bi_end_io() directly on a bio unless they own it and thus know
+ *   that it has an end_io function.
  **/
 void bio_endio(struct bio *bio, unsigned int bytes_done, int error)
 {
diff -aurp linux-2.6.5-rc1-orig/include/linux/bio.h linux-2.6.5-rc1-ec/include/linux/bio.h
--- linux-2.6.5-rc1-orig/include/linux/bio.h	2004-03-15 21:47:17.000000000 -0800
+++ linux-2.6.5-rc1-ec/include/linux/bio.h	2004-03-18 03:13:29.000000000 -0800
@@ -174,7 +174,7 @@ struct bio {
 #define BIO_SEG_BOUNDARY(q, b1, b2) \
 	BIOVEC_SEG_BOUNDARY((q), __BVEC_END((b1)), __BVEC_START((b2)))
 
-#define bio_io_error(bio, bytes) bio_endio((bio), (bytes), -EIO)
+#define bio_io_error(bio, bytes) bio_endio((bio), (bytes), BLK_ERR)
 
 /*
  * drivers should not use the __ version unless they _really_ want to
diff -aurp linux-2.6.5-rc1-orig/include/linux/blkdev.h linux-2.6.5-rc1-ec/include/linux/blkdev.h
--- linux-2.6.5-rc1-orig/include/linux/blkdev.h	2004-03-15 21:45:49.000000000 -0800
+++ linux-2.6.5-rc1-ec/include/linux/blkdev.h	2004-03-18 04:46:23.000000000 -0800
@@ -527,6 +527,22 @@ static inline request_queue_t *bdev_get_
 }
 
 /*
+ * Error values that users of end_that_request_first/chunk,
+ * end_request and bio_endio should use to indicate IO
+ * completion status.
+ */
+enum {
+	BLK_SUCCESS,
+	BLK_ERR,		/* Generic error like -EIO */
+	BLK_FATAL_DEV,		/* Fatal driver error */
+	BLK_FATAL_TRNSPT,	/* Fatal transport error */
+	BLK_FATAL_DRV,		/* Fatal driver error */
+	BLK_RETRY_DEV,		/* Device error, I/O may be retried */
+	BLK_RETRY_TRNSPT,	/* Transport error, I/O may retried */
+	BLK_RETRY_DRV,		/* Driver error, I/O may be retried */
+};
+
+/*
  * end_request() and friends. Must be called with the request queue spinlock
  * acquired. All functions called within end_request() _must_be_ atomic.
  *

--------------070505040702060302020908--

