Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSFQGvv>; Mon, 17 Jun 2002 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSFQGvH>; Mon, 17 Jun 2002 02:51:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25614 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316789AbSFQGst>;
	Mon, 17 Jun 2002 02:48:49 -0400
Message-ID: <3D0D8743.9B732D3@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 11/19] fix loop driver for large BIOs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix the loop driver for loop-on-blockdev setups.

When presented with a multipage BIO, loop_make_request overindexes the
first page and corrupts kernel memory.  Fix it to walk the individual
pages.

BTW, I suspect the IV handling in loop may be incorrect for multipage
BIOs.  Should we not be recalculating the IV for each page in the BIOs,
or incrementing the offset by the size of the preceding pages, or such?



--- 2.5.22/drivers/block/loop.c~lo_do_transfer	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/drivers/block/loop.c	Sun Jun 16 23:22:46 2002
@@ -168,6 +168,15 @@ static void figure_loop_size(struct loop
 					
 }
 
+static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
+				 char *lbuf, int size, int rblock)
+{
+	if (!lo->transfer)
+		return 0;
+
+	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+}
+
 static int
 do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
 {
@@ -454,20 +463,43 @@ static struct bio *loop_get_buffer(struc
 out_bh:
 	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
 	bio->bi_rw = rbh->bi_rw;
-	spin_lock_irq(&lo->lo_lock);
 	bio->bi_bdev = lo->lo_device;
-	spin_unlock_irq(&lo->lo_lock);
 
 	return bio;
 }
 
-static int loop_make_request(request_queue_t *q, struct bio *rbh)
+static int
+bio_transfer(struct loop_device *lo, struct bio *to_bio,
+			      struct bio *from_bio)
+{
+	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
+	struct bio_vec *from_bvec, *to_bvec;
+	char *vto, *vfrom;
+	int ret = 0, i;
+
+	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
+		to_bvec = &to_bio->bi_io_vec[i];
+
+		kmap(from_bvec->bv_page);
+		kmap(to_bvec->bv_page);
+		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
+		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
+		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
+					from_bvec->bv_len, IV);
+		kunmap(from_bvec->bv_page);
+		kunmap(to_bvec->bv_page);
+	}
+
+	return ret;
+}
+		
+static int loop_make_request(request_queue_t *q, struct bio *old_bio)
 {
-	struct bio *bh = NULL;
+	struct bio *new_bio = NULL;
 	struct loop_device *lo;
 	unsigned long IV;
-	int rw = bio_rw(rbh);
-	int unit = minor(to_kdev_t(rbh->bi_bdev->bd_dev));
+	int rw = bio_rw(old_bio);
+	int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
 
 	if (unit >= max_loop)
 		goto out;
@@ -489,60 +521,41 @@ static int loop_make_request(request_que
 		goto err;
 	}
 
-	blk_queue_bounce(q, &rbh);
+	blk_queue_bounce(q, &old_bio);
 
 	/*
 	 * file backed, queue for loop_thread to handle
 	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		loop_add_bio(lo, rbh);
+		loop_add_bio(lo, old_bio);
 		return 0;
 	}
 
 	/*
 	 * piggy old buffer on original, and submit for I/O
 	 */
-	bh = loop_get_buffer(lo, rbh);
-	IV = loop_get_iv(lo, rbh->bi_sector);
+	new_bio = loop_get_buffer(lo, old_bio);
+	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
-		if (lo_do_transfer(lo, WRITE, bio_data(bh), bio_data(rbh),
-				   bh->bi_size, IV))
+		if (bio_transfer(lo, new_bio, old_bio))
 			goto err;
 	}
 
-	generic_make_request(bh);
+	generic_make_request(new_bio);
 	return 0;
 
 err:
 	if (atomic_dec_and_test(&lo->lo_pending))
 		up(&lo->lo_bh_mutex);
-	loop_put_buffer(bh);
+	loop_put_buffer(new_bio);
 out:
-	bio_io_error(rbh);
+	bio_io_error(old_bio);
 	return 0;
 inactive:
 	spin_unlock_irq(&lo->lo_lock);
 	goto out;
 }
 
-static int do_bio_blockbacked(struct loop_device *lo, struct bio *bio,
-			      struct bio *rbh)
-{
-	unsigned long IV = loop_get_iv(lo, rbh->bi_sector);
-	struct bio_vec *from;
-	char *vto, *vfrom;
-	int ret = 0, i;
-
-	bio_for_each_segment(from, rbh, i) {
-		vfrom = page_address(from->bv_page) + from->bv_offset;
-		vto = page_address(bio->bi_io_vec[i].bv_page) + bio->bi_io_vec[i].bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(bio), vto, vfrom,
-					from->bv_len, IV);
-	}
-
-	return ret;
-}
-
 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
 {
 	int ret;
@@ -556,7 +569,7 @@ static inline void loop_handle_bio(struc
 	} else {
 		struct bio *rbh = bio->bi_private;
 
-		ret = do_bio_blockbacked(lo, bio, rbh);
+		ret = bio_transfer(lo, bio, rbh);
 
 		bio_endio(rbh, !ret);
 		loop_put_buffer(bio);
@@ -588,10 +601,8 @@ static int loop_thread(void *data)
 
 	set_user_nice(current, -20);
 
-	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_bound;
 	atomic_inc(&lo->lo_pending);
-	spin_unlock_irq(&lo->lo_lock);
 
 	/*
 	 * up sem, we are running
--- 2.5.22/include/linux/loop.h~lo_do_transfer	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/include/linux/loop.h	Sun Jun 16 22:50:18 2002
@@ -62,14 +62,6 @@ typedef	int (* transfer_proc_t)(struct l
 				char *raw_buf, char *loop_buf, int size,
 				int real_block);
 
-static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, int rblock)
-{
-	if (!lo->transfer)
-		return 0;
-
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
-}
 #endif /* __KERNEL__ */
 
 /*

-
