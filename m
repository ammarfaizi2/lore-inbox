Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSFFX0L>; Thu, 6 Jun 2002 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSFFX0K>; Thu, 6 Jun 2002 19:26:10 -0400
Received: from h-64-105-137-63.SNVACAID.covad.net ([64.105.137.63]:64384 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S311871AbSFFX0I>; Thu, 6 Jun 2002 19:26:08 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 6 Jun 2002 16:26:02 -0700
Message-Id: <200206062326.QAA00602@baldur.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is version 4 of my changes to fs/bio.c (ll_rw_kio) and
fs/mpage.c.  Andrew, I believe it this accomodates all of your
requests.  Please let me know if I missed anything.  If it looks
good, I would apperciate your recommendation on how to proceed with
getting this into Linus's tree.

	The one new behavior in this version is that bio_max_iovecs()
will treat q->max_sectors == 0 as meaning that there is no limit.
This should accomodate any drivers that set max_sectors == 0.

	We might want to keep the max_sectors == 0 behavior anyhow.
It is useful to have a way for drivers to indicate that they
don't care about the total number of sectors, rather than require
drivers that have no inherent limit to pick something arbitrarily.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/include/linux/bio.h	2002-06-02 18:44:52.000000000 -0700
+++ linux/include/linux/bio.h	2002-06-06 15:52:29.000000000 -0700
@@ -34,11 +34,8 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_SECTORS	128
-#define BIO_MAX_SIZE	(BIO_MAX_SECTORS << 9)
-
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
--- linux-2.5.20/include/linux/blkdev.h	2002-06-02 18:44:44.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-06 15:52:50.000000000 -0700
@@ -418,5 +428,7 @@
 	page_cache_release(p.v);
 }
 
+extern int bio_max_iovecs(request_queue_t *q, int *iovec_size);
+
 #endif
--- linux-2.5.20/fs/bio.c	2002-06-02 18:44:40.000000000 -0700
+++ linux/fs/bio.c	2002-06-06 16:17:03.000000000 -0700
@@ -50,8 +50,6 @@
 }; 
 #undef BV
 
-#define BIO_MAX_PAGES	(bvec_array[BIOVEC_NR_POOLS - 1].size)
-
 static void *slab_pool_alloc(int gfp_mask, void *data)
 {
 	return kmem_cache_alloc(data, gfp_mask);
@@ -316,6 +314,22 @@
 	return NULL;
 }
 
+int bio_max_iovecs(request_queue_t *q, int *iovec_size)
+{
+	unsigned max_iovecs = min(q->max_phys_segments, q->max_hw_segments);
+
+	if (q->max_sectors != 0) {
+		unsigned int max_bytes = q->max_sectors << 9;
+		if (*iovec_size > max_bytes) {
+			*iovec_size = max_bytes;
+			return 1;
+		}
+		max_iovecs = min(max_iovecs, max_bytes / *iovec_size);
+	}
+
+	return max_iovecs;
+}
+
 static void bio_end_io_kio(struct bio *bio)
 {
 	struct kiobuf *kio = (struct kiobuf *) bio->bi_private;
@@ -338,10 +352,11 @@
  **/
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
-	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
+	int offset, size, err, map_i, total_nr_pages, nr_bvecs;
 	struct bio_vec *bvec;
 	struct bio *bio;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	int bytes_per_iovec, max_bvecs;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
@@ -367,17 +382,20 @@
 
 	map_i = 0;
 
+	bytes_per_iovec = PAGE_SIZE;
+	max_bvecs = bio_max_iovecs(bdev->bd_queue, &bytes_per_iovec);
+
 next_chunk:
-	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
-	if (nr_pages > total_nr_pages)
-		nr_pages = total_nr_pages;
+	nr_bvecs = max_bvecs;
+	if (nr_bvecs > total_nr_pages)
+		nr_bvecs = total_nr_pages;
 
 	atomic_inc(&kio->io_count);
 
 	/*
 	 * allocate bio and do initial setup
 	 */
-	if ((bio = bio_alloc(GFP_NOIO, nr_pages)) == NULL) {
+	if ((bio = bio_alloc(GFP_NOIO, nr_bvecs)) == NULL) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -389,15 +407,17 @@
 	bio->bi_private = kio;
 
 	bvec = bio->bi_io_vec;
-	for (i = 0; i < nr_pages; i++, bvec++, map_i++) {
+	for (;total_nr_pages > 0; bvec++, nr_bvecs--) {
 		int nbytes = PAGE_SIZE - offset;
 
 		if (nbytes > size)
 			nbytes = size;
+		if (nbytes > bytes_per_iovec)
+			nbytes = bytes_per_iovec;
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
+		if (nr_bvecs == 0)
 			goto queue_io;
 
 		bio->bi_vcnt++;
@@ -407,14 +427,14 @@
 		bvec->bv_len = nbytes;
 		bvec->bv_offset = offset;
 
-		/*
-		 * kiobuf only has an offset into the first page
-		 */
-		offset = 0;
+		offset = (offset + nbytes) & PAGE_MASK;
+		if (offset == 0) {
+			total_nr_pages--;
+			map_i++;
+		}
 
 		sector += nbytes >> 9;
 		size -= nbytes;
-		total_nr_pages--;
 		kio->offset += nbytes;
 	}
 
--- linux-2.5.20/fs/mpage.c	2002-06-06 12:30:14.000000000 -0700
+++ linux/fs/mpage.c	2002-06-06 15:44:24.000000000 -0700
@@ -21,12 +21,6 @@
 #include <linux/mpage.h>
 
 /*
- * The largest-sized BIO which this code will assemble, in bytes.  Set this
- * to PAGE_CACHE_SIZE if your drivers are broken.
- */
-#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
-
-/*
  * I/O completion handler for multipage BIOs.
  *
  * The mpage code never puts partial pages into a BIO (except for end-of-file).
@@ -220,9 +214,13 @@
 		bio = mpage_bio_submit(READ, bio);
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		int bvec_size = PAGE_SIZE;
+		unsigned nr_bvecs = bio_max_iovecs(bdev->bd_queue,&bvec_size);
 
-		if (nr_bvecs > nr_pages)
+		if (bvec_size != PAGE_SIZE)
+			goto confused;
+
+ 		if (nr_bvecs > nr_pages)
 			nr_bvecs = nr_pages;
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
 					nr_bvecs, GFP_KERNEL);
@@ -422,7 +420,11 @@
 		bio = mpage_bio_submit(WRITE, bio);
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		int bvec_size = PAGE_SIZE;
+		unsigned nr_bvecs = bio_max_iovecs(bdev->bd_queue,&bvec_size);
+
+		if (bvec_size != PAGE_SIZE)
+			goto confused;
 
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
 					nr_bvecs, GFP_NOFS);
