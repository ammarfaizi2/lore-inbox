Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSFFIuI>; Thu, 6 Jun 2002 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSFFIuH>; Thu, 6 Jun 2002 04:50:07 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:22154 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316897AbSFFIuC>; Thu, 6 Jun 2002 04:50:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 6 Jun 2002 01:49:51 -0700
Message-Id: <200206060849.BAA00355@baldur.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Moreton wrote:
>It looks like BIO_MAX_FOO needs to become an API function.
>Question is: what should it return? Number of sectors, number
>of bytes or number of pages?
>
>For my purposes, I'd prefer number of pages.  ie: the vector
>count which gets passed into bio_alloc:
>
>        unsigned bio_max_iovecs(struct block_device *bdev);
>
>        nr_iovecs = bio_max_iovecs(bdev);
>        bio = bio_alloc(GFP_KERNEL, nr_iovecs);
>
>would suit.
>
>And if, via this, we can submit BIOs which are larger than 64k
>for the common "it's just a disk" case then that is icing.


	Here is my attempt at implimenting your idea.  I am composing
this email on a machine that has this code compiled into the kernel,
but I do not know if any of the effected code paths have ever been
executed.

	The interface to the routine is:

	int bio_max_iovecs(request_queue_t *q, int *iovec_size)

	iovec_size is both an input and output variable.  You give it
the desired number of bytes you want to stuff in each iovec, and the
number may come back chopped it exceeds q->max_sectors * 512.  It
returns the number of iovecs of that size that you can safely stuff
into a single bio for the underlying block device driver.

	Notes on these changes:

	      1. BIO_MAX_SECTORS et al are gone.  Nothing uses them
	         anymore.

	      2. I changed do_mpage_readpage and mpage_writepage to
		 precompute bdev = inode->i_sb->s_bdev, rather than
		 repeatedly getting it from a data returned from
		 the get_block function.  This allow bio_max_iovecs()
		 to be called once in each routine, rather than repeatedly
		 within a loop.  If bdev really could have some other
		 value, then my optimization needs to be undone.

	      3. I assume that "goto confused" in these routines causes
	         a safer but slower approach to be used.  I added jumps
		 to these labels for the case where the underlying queue
		 could not handle enough sectors in a single bio to cover
		 even one page.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/include/linux/bio.h	2002-06-02 18:44:52.000000000 -0700
+++ linux/include/linux/bio.h	2002-06-05 20:09:34.000000000 -0700
@@ -34,9 +34,6 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_SECTORS	128
-#define BIO_MAX_SIZE	(BIO_MAX_SECTORS << 9)
-
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
--- linux-2.5.20/include/linux/blkdev.h	2002-06-02 18:44:44.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-05 23:05:37.000000000 -0700
@@ -191,9 +191,9 @@
 	 * queue settings
 	 */
 	unsigned short		max_sectors;
-	unsigned short		max_phys_segments;
-	unsigned short		max_hw_segments;
+	unsigned short		max_phys_segments; 	/* <= max_sectors */
+	unsigned short		max_hw_segments; 	/* <= max_sectors */
 	unsigned short		hardsect_size;
 	unsigned int		max_segment_size;
 
@@ -418,5 +428,7 @@
 	page_cache_release(p.v);
 }
 
+extern int bio_max_iovecs(request_queue_t *q, int *iovec_size);
+
 #endif
--- linux-2.5.20/fs/bio.c	2002-06-02 18:44:40.000000000 -0700
+++ linux/fs/bio.c	2002-06-06 00:56:37.000000000 -0700
@@ -316,6 +316,23 @@
 	return NULL;
 }
 
+int bio_max_iovecs(request_queue_t *q, int *iovec_size)
+{
+	const int max_bytes = q->max_sectors << 9;
+	int max_iovecs;
+
+	if (*iovec_size > max_bytes) {
+		*iovec_size = max_bytes;
+		return 1;
+	}
+	max_iovecs = max_bytes / *iovec_size;
+	if (max_iovecs > q->max_phys_segments)
+		max_iovecs = q->max_phys_segments;
+	if (max_iovecs > q->max_hw_segments)
+		max_iovecs = q->max_hw_segments;
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
+	int bytes_per_iovec, max_pages;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
@@ -367,17 +385,20 @@
 
 	map_i = 0;
 
+	bytes_per_iovec = PAGE_SIZE;
+	max_pages = bio_max_iovecs(bdev->bd_queue, &bytes_per_iovec);
+
 next_chunk:
-	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
-	if (nr_pages > total_nr_pages)
-		nr_pages = total_nr_pages;
+	nr_bvecs = max_pages;
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
+		if (nbytes > bytes_per_iovec)
+			nbytes = bytes_per_iovec;
 
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
 
--- linux-2.5.20/fs/mpage.c	2002-06-02 18:44:44.000000000 -0700
+++ linux/fs/mpage.c	2002-06-06 00:56:39.000000000 -0700
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
@@ -167,8 +161,13 @@
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
 	unsigned first_hole = blocks_per_page;
-	struct block_device *bdev = NULL;
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	struct buffer_head bh;
+	int bvec_size = PAGE_SIZE;
+	const unsigned max_bvecs = bio_max_iovecs(bdev->bd_queue, &bvec_size);
+
+	if (bvec_size != PAGE_SIZE)
+		goto confused;
 
 	if (page_has_buffers(page))
 		goto confused;
@@ -197,7 +196,6 @@
 		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
 			goto confused;
 		blocks[page_block] = bh.b_blocknr;
-		bdev = bh.b_bdev;
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -220,7 +218,7 @@
 		bio = mpage_bio_submit(READ, bio);
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		unsigned int nr_bvecs = max_bvecs;
 
 		if (nr_bvecs > nr_pages)
 			nr_bvecs = nr_pages;
@@ -321,8 +319,13 @@
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
 	unsigned first_unmapped = blocks_per_page;
-	struct block_device *bdev = NULL;
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	int boundary = 0;
+	int bvec_size = PAGE_SIZE;
+	const unsigned max_bvecs = bio_max_iovecs(bdev->bd_queue, &bvec_size);
+
+	if (bvec_size != PAGE_SIZE)
+		goto confused;
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -355,7 +358,6 @@
 			}
 			blocks[page_block++] = bh->b_blocknr;
 			boundary = buffer_boundary(bh);
-			bdev = bh->b_bdev;
 		} while ((bh = bh->b_this_page) != head);
 
 		if (first_unmapped)
@@ -391,7 +393,6 @@
 		}
 		blocks[page_block++] = map_bh.b_blocknr;
 		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
 		if (block_in_file == last_block)
 			break;
 		block_in_file++;
@@ -422,10 +423,8 @@
 		bio = mpage_bio_submit(WRITE, bio);
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
-
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_bvecs, GFP_NOFS);
+					max_bvecs, GFP_NOFS);
 		if (bio == NULL)
 			goto confused;
 	}
