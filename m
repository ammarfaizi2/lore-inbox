Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265216AbSIWJFn>; Mon, 23 Sep 2002 05:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbSIWJFn>; Mon, 23 Sep 2002 05:05:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265216AbSIWJFm>;
	Mon, 23 Sep 2002 05:05:42 -0400
Date: Mon, 23 Sep 2002 11:10:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 broke the floppy driver
Message-ID: <20020923091041.GC15479@suse.de>
References: <200209212301.BAA08451@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209212301.BAA08451@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22 2002, Mikael Pettersson wrote:
> With 2.5.37, doing a write to floppy makes the kernel print
> "blk: request botched" and a few seconds later instantly reboot
> the machine (w/o any further messages). 2.5.36 works fine.
> 
> "dd bs=8k if=bzImage of=/dev/fd0" triggers this every time.

Attached patch should fix the partial completion thing for floppy.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.601   -> 1.602  
#	drivers/block/ll_rw_blk.c	1.107   -> 1.108  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/23	axboe@burns.home.kernel.dk	1.602
# cleanup end_that_request_first() end_io handling, and fix bug where
# partial completes didn't get accounted right wrt blk_recalc_rq_sectors()
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Sep 23 11:10:18 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Sep 23 11:10:18 2002
@@ -1904,18 +1904,19 @@
 
 int end_that_request_first(struct request *req, int uptodate, int nr_sectors)
 {
-	int nsect, total_nsect;
+	int total_nsect = 0, error = 0;
 	struct bio *bio;
 
 	req->errors = 0;
-	if (!uptodate)
+	if (!uptodate) {
 		printk("end_request: I/O error, dev %s, sector %lu\n",
 			kdevname(req->rq_dev), req->sector);
+		error = -EIO;
+	}
 
-	total_nsect = 0;
 	while ((bio = req->bio)) {
-		nsect = bio_iovec(bio)->bv_len >> 9;
-		total_nsect += nsect;
+		const int nsect = bio_iovec(bio)->bv_len >> 9;
+		int new_bio = 0;
 
 		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
 
@@ -1927,36 +1928,52 @@
 
 			bio_iovec(bio)->bv_offset += partial;
 			bio_iovec(bio)->bv_len -= partial;
-			blk_recalc_rq_sectors(req, total_nsect);
-			blk_recalc_rq_segments(req);
-			bio_endio(bio, partial, !uptodate ? -EIO : 0);
-			return 1;
+			bio_endio(bio, partial, error);
+			total_nsect += nr_sectors;
+			break;
 		}
 
 		/*
-		 * if bio->bi_end_io returns 0, this bio is done. move on
+		 * we are ending the last part of the bio, advance req pointer
 		 */
-		req->bio = bio->bi_next;
-		if (bio_endio(bio, nsect << 9, !uptodate ? -EIO : 0)) {
-			bio->bi_idx++;
-			req->bio = bio;
+		if ((nsect << 9) >= bio->bi_size) {
+			req->bio = bio->bi_next;
+			new_bio = 1;
 		}
 
+		bio_endio(bio, nsect << 9, error);
+
+		total_nsect += nsect;
 		nr_sectors -= nsect;
 
+		/*
+		 * if we didn't advance the req->bio pointer, advance bi_idx
+		 * to indicate we are now on the next bio_vec
+		 */
+		if (!new_bio)
+			bio->bi_idx++;
+
 		if ((bio = req->bio)) {
 			/*
 			 * end more in this run, or just return 'not-done'
 			 */
-			if (unlikely(nr_sectors <= 0)) {
-				blk_recalc_rq_sectors(req, total_nsect);
-				blk_recalc_rq_segments(req);
-				return 1;
-			}
+			if (unlikely(nr_sectors <= 0))
+				break;
 		}
 	}
 
-	return 0;
+	/*
+	 * completely done
+	 */
+	if (!req->bio)
+		return 0;
+
+	/*
+	 * if the request wasn't completed, update state
+	 */
+	blk_recalc_rq_sectors(req, total_nsect);
+	blk_recalc_rq_segments(req);
+	return 1;
 }
 
 void end_that_request_last(struct request *req)

-- 
Jens Axboe

