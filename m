Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316380AbSEZUi4>; Sun, 26 May 2002 16:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316383AbSEZUhm>; Sun, 26 May 2002 16:37:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316374AbSEZUg2>;
	Sun, 26 May 2002 16:36:28 -0400
Message-ID: <3CF14808.B2CFA91A@zip.com.au>
Date: Sun, 26 May 2002 13:39:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 4/18] fix loop driver for large BIOs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix bug in the loop driver.

When presented with a multipage BIO, loop is overindexing the first
page in the BIO rather than advancing to the second page.  It scribbles
on the backing file and/or on kernel memory.

This happens with multipage BIO-based pagecache I/O and presumably with
O_DIRECT also.

The fix is much-needed with the multipage-BIO patches - using that code
on loop-backed filesystems has rather messy results.


=====================================

--- 2.5.18/drivers/block/loop.c~loop-large-bio	Sat May 25 23:26:45 2002
+++ 2.5.18-akpm/drivers/block/loop.c	Sat May 25 23:26:45 2002
@@ -168,7 +168,8 @@ static void figure_loop_size(struct loop
 					
 }
 
-static int lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+static int
+do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
@@ -178,12 +179,13 @@ static int lo_send(struct loop_device *l
 	unsigned long index;
 	unsigned size, offset;
 	int len;
+	int ret = 0;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
-	len = bio->bi_size;
-	data = bio_data(bio);
+	data = kmap(bvec->bv_page) + bvec->bv_offset;
+	len = bvec->bv_len;
 	while (len > 0) {
 		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		int transfer_result;
@@ -221,14 +223,34 @@ static int lo_send(struct loop_device *l
 		page_cache_release(page);
 	}
 	up(&mapping->host->i_sem);
-	return 0;
+out:
+	kunmap(bvec->bv_page);
+	return ret;
 
 unlock:
 	unlock_page(page);
 	page_cache_release(page);
 fail:
 	up(&mapping->host->i_sem);
-	return -1;
+	ret = -1;
+	goto out;
+}
+
+static int
+lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+{
+	unsigned vecnr;
+	int ret = 0;
+
+	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
+		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+
+		ret = do_lo_send(lo, bvec, bsize, pos);
+		if (ret < 0)
+			break;
+		pos += bvec->bv_len;
+	}
+	return ret;
 }
 
 struct lo_read_data {
@@ -262,26 +284,46 @@ static int lo_read_actor(read_descriptor
 	return size;
 }
 
-static int lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+static int
+do_lo_receive(struct loop_device *lo,
+		struct bio_vec *bvec, int bsize, loff_t pos)
 {
 	struct lo_read_data cookie;
 	read_descriptor_t desc;
 	struct file *file;
 
 	cookie.lo = lo;
-	cookie.data = bio_data(bio);
+	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
 	cookie.bsize = bsize;
 	desc.written = 0;
-	desc.count = bio->bi_size;
+	desc.count = bvec->bv_len;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
 	spin_lock_irq(&lo->lo_lock);
 	file = lo->lo_backing_file;
 	spin_unlock_irq(&lo->lo_lock);
 	do_generic_file_read(file, &pos, &desc, lo_read_actor);
+	kunmap(bvec->bv_page);
 	return desc.error;
 }
 
+static int
+lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+{
+	unsigned vecnr;
+	int ret = 0;
+
+	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
+		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+
+		ret = do_lo_receive(lo, bvec, bsize, pos);
+		if (ret < 0)
+			break;
+		pos += bvec->bv_len;
+	}
+	return ret;
+}
+
 static inline int loop_get_bs(struct loop_device *lo)
 {
 	return block_size(lo->lo_device);


-
