Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTKAEqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 23:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTKAEqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 23:46:36 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:20745 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263715AbTKAEqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 23:46:32 -0500
Date: Sat, 1 Nov 2003 15:46:19 +1100
To: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BIO] Bounce queue in bio_add_page
Message-ID: <20031101044619.GA15628@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Currently bio_add_page will allow segments to be counted as merged
before they've been bounced.  This can create bio's that exceed
limits set by the driver/hardware.  This bug can be triggered on
HIGHMEM machines as well as ISA block devices such as AHA1542.

Here is a hack that works around it by bouncing the queue before
recounting the segments.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/include/linux/bio.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/include/linux/bio.h,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 bio.h
--- kernel-source-2.5/include/linux/bio.h	28 Sep 2003 04:44:21 -0000	1.1.1.8
+++ kernel-source-2.5/include/linux/bio.h	1 Nov 2003 04:36:28 -0000
@@ -239,7 +239,8 @@
 
 extern inline void bio_init(struct bio *);
 
-extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
+extern int bio_add_page(struct bio **, struct page *, unsigned int,
+			unsigned int);
 extern int bio_get_nr_vecs(struct block_device *);
 extern struct bio *bio_map_user(struct block_device *, unsigned long,
 				unsigned int, int);
Index: kernel-source-2.5/fs/bio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/bio.c,v
retrieving revision 1.1.1.13
diff -u -r1.1.1.13 bio.c
--- kernel-source-2.5/fs/bio.c	28 Sep 2003 04:44:16 -0000	1.1.1.13
+++ kernel-source-2.5/fs/bio.c	1 Nov 2003 04:36:00 -0000
@@ -292,9 +292,10 @@
  *	number of reasons, such as the bio being full or target block
  *	device limitations.
  */
-int bio_add_page(struct bio *bio, struct page *page, unsigned int len,
+int bio_add_page(struct bio **bio_orig, struct page *page, unsigned int len,
 		 unsigned int offset)
 {
+	struct bio *bio = *bio_orig;
 	request_queue_t *q = bdev_get_queue(bio->bi_bdev);
 	int retried_segments = 0;
 	struct bio_vec *bvec;
@@ -324,6 +325,8 @@
 
 		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 		retried_segments = 1;
+		blk_queue_bounce(q, &bio);
+		*bio_orig = bio;
 	}
 
 	/*
@@ -410,7 +413,7 @@
 		/*
 		 * sorry...
 		 */
-		if (bio_add_page(bio, pages[i], bytes, offset) < bytes)
+		if (bio_add_page(&bio, pages[i], bytes, offset) < bytes)
 			break;
 
 		len -= bytes;
Index: kernel-source-2.5/fs/direct-io.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/direct-io.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 direct-io.c
--- kernel-source-2.5/fs/direct-io.c	8 Oct 2003 19:24:14 -0000	1.1.1.9
+++ kernel-source-2.5/fs/direct-io.c	1 Nov 2003 04:36:59 -0000
@@ -503,7 +503,7 @@
 {
 	int ret;
 
-	ret = bio_add_page(dio->bio, dio->cur_page,
+	ret = bio_add_page(&dio->bio, dio->cur_page,
 			dio->cur_page_len, dio->cur_page_offset);
 	if (ret == dio->cur_page_len) {
 		dio->pages_in_io--;
Index: kernel-source-2.5/fs/mpage.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/mpage.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 mpage.c
--- kernel-source-2.5/fs/mpage.c	22 Aug 2003 23:53:13 -0000	1.1.1.8
+++ kernel-source-2.5/fs/mpage.c	1 Nov 2003 04:37:27 -0000
@@ -296,7 +296,7 @@
 	}
 
 	length = first_hole << blkbits;
-	if (bio_add_page(bio, page, length, 0) < length) {
+	if (bio_add_page(&bio, page, length, 0) < length) {
 		bio = mpage_bio_submit(READ, bio);
 		goto alloc_new;
 	}
@@ -540,7 +540,7 @@
 	}
 
 	length = first_unmapped << blkbits;
-	if (bio_add_page(bio, page, length, 0) < length) {
+	if (bio_add_page(&bio, page, length, 0) < length) {
 		bio = mpage_bio_submit(WRITE, bio);
 		goto alloc_new;
 	}
Index: kernel-source-2.5/fs/xfs/pagebuf/page_buf.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/xfs/pagebuf/page_buf.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 page_buf.c
--- kernel-source-2.5/fs/xfs/pagebuf/page_buf.c	8 Oct 2003 19:24:01 -0000	1.1.1.15
+++ kernel-source-2.5/fs/xfs/pagebuf/page_buf.c	1 Nov 2003 04:40:46 -0000
@@ -1346,7 +1346,7 @@
 		bio->bi_end_io = bio_end_io_pagebuf;
 		bio->bi_private = pb;
 
-		bio_add_page(bio, pb->pb_pages[0], PAGE_CACHE_SIZE, 0);
+		bio_add_page(&bio, pb->pb_pages[0], PAGE_CACHE_SIZE, 0);
 		size = 0;
 
 		atomic_inc(&pb->pb_io_remaining);
@@ -1390,7 +1390,7 @@
 		if (nbytes > size)
 			nbytes = size;
 
-		if (bio_add_page(bio, pb->pb_pages[map_i],
+		if (bio_add_page(&bio, pb->pb_pages[map_i],
 					nbytes, offset) < nbytes)
 			break;
 
Index: kernel-source-2.5/drivers/mtd/devices/blkmtd.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/mtd/devices/blkmtd.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 blkmtd.c
--- kernel-source-2.5/drivers/mtd/devices/blkmtd.c	22 Aug 2003 23:51:04 -0000	1.1.1.9
+++ kernel-source-2.5/drivers/mtd/devices/blkmtd.c	1 Nov 2003 04:45:27 -0000
@@ -146,7 +146,7 @@
 		bio->bi_sector = page->index << (PAGE_SHIFT-9);
 		bio->bi_private = &event;
 		bio->bi_end_io = bi_read_complete;
-		if(bio_add_page(bio, page, PAGE_SIZE, 0) == PAGE_SIZE) {
+		if(bio_add_page(&bio, page, PAGE_SIZE, 0) == PAGE_SIZE) {
 			submit_bio(READ, bio);
 			blk_run_queues();
 			wait_for_completion(&event);
@@ -213,7 +213,7 @@
 		bio->bi_bdev = blkdev;
 	}
 
-	if(bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
+	if(bio_add_page(&bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 		blkmtd_write_out(bio);
 		bio = NULL;
 		goto retry;

--GvXjxJ+pjyke8COw--
