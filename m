Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSFMMXY>; Thu, 13 Jun 2002 08:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317595AbSFMMXX>; Thu, 13 Jun 2002 08:23:23 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:19336 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317591AbSFMMXU>; Thu, 13 Jun 2002 08:23:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 13 Jun 2002 05:23:15 -0700
Message-Id: <200206131223.FAA00306@baldur.yggdrasil.com>
To: axboe@suse.de
Subject: Patch (2.5.21): bio size fixes for ll_rw_kio and mpage.c
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

	ll_rw_kio and the mpage.c routines could generate bio's that
are bigger than the device that they are for claims to be able to
handle.  That was actually causing kernel panics for a fellow and
IBM, so this is an actual problem.  This change has ll_rw_kio and
the mpage routines calculate their maximum bio sizes from the
queue parameters rather than some compiled in guesses which are
too big for some devices.

	A nice side effect of this change is that more flexible
I/O devices (including IDE disks, for one) can get their I/O
requests in the larger chunks that they can handle.

	A temporary negative side effect is that pseudo-devices
like /dev/loop and raid currently do not correctly reflect
the I/O limits of the devices that they pass requests to.
The real bug is in /dev/loop and the raid code.  They currently
export the limits set by blk_queue_make_request, which are
about are about twice what mpage.c previously assumed.  So,
while my change eliminates the problem for mounting /dev/disc/...,
it also makes it possible for the problem to happen on a couple
more scsi controllers *if* the file system is mounted via
/dev/loop or raid.

	However, raid has not compiled for a long time under
2.5 and the loop driver quickly crashes under 2.5.21.  I have
a fix for the loop driver to make it constain its queue to the
I/O limits of its underlying device, but not for the existing
problem with /dev/loop crashing.

	I would like to get this patch into 2.5.21.  I will
work on fixing loop.c and the device mapper (raid replacement),
and will keep an eye out for when someone gets the non-device mapper
raid code running if that occurs.

	Jens, do you have any objection to this going into Linus's tree?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.21/include/linux/bio.h	2002-06-08 22:31:17.000000000 -0700
+++ linux/include/linux/bio.h	2002-06-09 01:07:57.000000000 -0700
@@ -35,9 +35,6 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_SECTORS	128
-#define BIO_MAX_SIZE	(BIO_MAX_SECTORS << 9)
-
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
--- linux-2.5.21/include/linux/blkdev.h	2002-06-08 22:28:04.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-09 01:07:50.000000000 -0700
@@ -415,4 +425,6 @@
 	page_cache_release(p.v);
 }
 
+extern int bio_max_iovecs(request_queue_t *q, int *iovec_size);
+
 #endif
--- linux-2.5.21/fs/bio.c	2002-06-08 22:26:53.000000000 -0700
+++ linux/fs/bio.c	2002-06-07 16:24:27.000000000 -0700
@@ -50,8 +50,6 @@
 }; 
 #undef BV
 
-#define BIO_MAX_PAGES	(bvec_array[BIOVEC_NR_POOLS - 1].size)
-
 static void *slab_pool_alloc(int gfp_mask, void *data)
 {
 	return kmem_cache_alloc(data, gfp_mask);
@@ -316,6 +314,25 @@
 	return NULL;
 }
 
+int bio_max_iovecs(request_queue_t *q, int *iovec_size)
+{
+	unsigned max_iovecs = min(q->max_phys_segments, q->max_hw_segments);
+
+	if (q->max_segment_size != 0 && *iovec_size > q->max_segment_size)
+		*iovec_size = q->max_segment_size;
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
@@ -338,10 +355,11 @@
  **/
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
-	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
+	int offset, size, err, map_i, total_nr_pages, nr_bvecs;
 	struct bio_vec *bvec;
 	struct bio *bio;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	int bytes_per_bvec, max_bvecs;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
@@ -367,17 +385,20 @@
 
 	map_i = 0;
 
+	bytes_per_bvec = PAGE_SIZE;
+	max_bvecs = bio_max_iovecs(bdev->bd_queue, &bytes_per_bvec);
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
@@ -389,15 +410,17 @@
 	bio->bi_private = kio;
 
 	bvec = bio->bi_io_vec;
-	for (i = 0; i < nr_pages; i++, bvec++, map_i++) {
+	for (;total_nr_pages > 0; bvec++, nr_bvecs--) {
 		int nbytes = PAGE_SIZE - offset;
 
 		if (nbytes > size)
 			nbytes = size;
+		if (nbytes > bytes_per_bvec)
+			nbytes = bytes_per_bvec;
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
+		if (nr_bvecs == 0)
 			goto queue_io;
 
 		bio->bi_vcnt++;
@@ -407,14 +430,14 @@
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
 
--- linux-2.5.21/fs/mpage.c	2002-06-08 22:28:09.000000000 -0700
+++ linux/fs/mpage.c	2002-06-12 07:12:44.000000000 -0700
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
+		int bvec_size = PAGE_CACHE_SIZE;
+		unsigned nr_bvecs = bio_max_iovecs(bdev->bd_queue,&bvec_size);
 
-		if (nr_bvecs > nr_pages)
+		if (bvec_size != PAGE_CACHE_SIZE)
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
+		int bvec_size = PAGE_CACHE_SIZE;
+		unsigned nr_bvecs = bio_max_iovecs(bdev->bd_queue,&bvec_size);
+
+		if (bvec_size != PAGE_CACHE_SIZE)
+			goto confused;
 
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
 					nr_bvecs, GFP_NOFS);
