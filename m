Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSFFNcH>; Thu, 6 Jun 2002 09:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFFNby>; Thu, 6 Jun 2002 09:31:54 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:46777 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316972AbSFFNbX>; Thu, 6 Jun 2002 09:31:23 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 6 Jun 2002 06:31:13 -0700
Message-Id: <200206061331.GAA00287@baldur.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is version 3 of my changes to ll_rw_kio in fs/bio.c and fs/mpage.c.
The differences from the previous version are that do_mpage_readpage
and mpage_writepage now precompute bdev differently, and I have
tried to factor out a little bit of common code between bio.c and
mpage.c in the form of a routine bio_append().

I now know that I am actually running the mpage.c code, because I
screwed up one of my changes and got to see the resulting kernel
panic.  On the other hand, I do not think that I have caused ll_rw_kio
to be executed.  So, I beileve my ll_rw_kio changes are completely
untested.

For what it's worth, I am composing this email on a machine running
the patch that I have attached below.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/include/linux/bio.h	2002-06-02 18:44:52.000000000 -0700
+++ linux/include/linux/bio.h	2002-06-06 06:30:04.000000000 -0700
@@ -34,9 +34,6 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_SECTORS	128
-#define BIO_MAX_SIZE	(BIO_MAX_SECTORS << 9)
-
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
@@ -201,6 +198,8 @@
 extern struct bio *bio_clone(struct bio *, int);
 extern struct bio *bio_copy(struct bio *, int, int);
 
+extern int bio_append(struct bio **bio_p,
+		      struct page *page, int len, int offset);
 extern inline void bio_init(struct bio *);
 
 extern int bio_ioctl(kdev_t, unsigned int, unsigned long);
--- linux-2.5.20/include/linux/blkdev.h	2002-06-02 18:44:44.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-06 04:40:25.000000000 -0700
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
+++ linux/fs/bio.c	2002-06-06 06:13:52.000000000 -0700
@@ -316,6 +316,64 @@
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
+/* bio_append appends an IO vector to a bio.  bio_append expects to be
+   called with bio->bi_idx indicating the maximum number of IO vectors
+   that this bio can hold, and with bio->bi_vcnt indicating the number
+   of IO vectors already loaded.  If the provided bio is already full,
+   bio_append will submit the current bio and allocate a new one. */
+   
+int bio_append(struct bio **bio_p, struct page *page, int len, int offset)
+{
+	struct bio *bio = *bio_p;
+	struct bio_vec *vec;
+	if (bio->bi_idx == bio->bi_vcnt) {
+		struct bio *old = bio; 
+		*bio_p = bio = bio_alloc(GFP_KERNEL, old->bi_vcnt);
+		if (bio != NULL) {
+			bio->bi_sector =
+				old->bi_sector + (old->bi_size >> 9);
+
+#define COPY(field)	bio->bi_ ## field = old->bi_ ## field
+			COPY(bdev);
+			COPY(flags);
+			COPY(idx);
+			COPY(rw);
+			COPY(end_io);
+			COPY(private);
+#undef COPY
+		}
+		old->bi_idx = 0;
+		submit_bio(old->bi_rw, old);
+		if (bio == NULL)
+			return -ENOMEM;
+	}
+	vec = &bio->bi_io_vec[bio->bi_vcnt++];
+	vec->bv_page = page;
+	vec->bv_len = len;
+	vec->bv_offset = offset;
+
+	bio->bi_size += len;
+	return 0;
+}
+
+
 static void bio_end_io_kio(struct bio *bio)
 {
 	struct kiobuf *kio = (struct kiobuf *) bio->bi_private;
@@ -338,10 +396,10 @@
  **/
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
-	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
-	struct bio_vec *bvec;
+	int offset, size, err, map_i, total_nr_pages, nr_bvecs;
 	struct bio *bio;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	int bytes_per_iovec, max_pages;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
@@ -367,63 +425,58 @@
 
 	map_i = 0;
 
-next_chunk:
-	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
-	if (nr_pages > total_nr_pages)
-		nr_pages = total_nr_pages;
+	bytes_per_iovec = PAGE_SIZE;
+	max_pages = bio_max_iovecs(bdev->bd_queue, &bytes_per_iovec);
+
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
 
+	bio->bi_idx = nr_bvecs;		/* for bio_append */
+	bio->bi_rw = rw;
+
 	bio->bi_sector = sector;
 	bio->bi_bdev = bdev;
-	bio->bi_idx = 0;
 	bio->bi_end_io = bio_end_io_kio;
 	bio->bi_private = kio;
 
-	bvec = bio->bi_io_vec;
-	for (i = 0; i < nr_pages; i++, bvec++, map_i++) {
+	while (total_nr_pages > 0) {
 		int nbytes = PAGE_SIZE - offset;
 
 		if (nbytes > size)
 			nbytes = size;
+		if (nbytes > bytes_per_iovec)
+			nbytes = bytes_per_iovec;
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
-			goto queue_io;
-
-		bio->bi_vcnt++;
-		bio->bi_size += nbytes;
+		err = bio_append(&bio, kio->maplist[map_i], nbytes, offset);
+		if (err)
+			goto out;
+
+		offset = (offset + nbytes) & PAGE_MASK;
+		if (offset == 0) {
+			total_nr_pages--;
+			map_i++;
+		}
 
-		bvec->bv_page = kio->maplist[map_i];
-		bvec->bv_len = nbytes;
-		bvec->bv_offset = offset;
-
-		/*
-		 * kiobuf only has an offset into the first page
-		 */
-		offset = 0;
-
-		sector += nbytes >> 9;
 		size -= nbytes;
-		total_nr_pages--;
 		kio->offset += nbytes;
 	}
 
-queue_io:
+	bio->bi_idx = 0;
 	submit_bio(rw, bio);
 
-	if (total_nr_pages)
-		goto next_chunk;
-
 	if (size) {
 		printk("ll_rw_kio: size %d left (kio %d)\n", size, kio->length);
 		BUG();
--- linux-2.5.20/fs/mpage.c	2002-06-02 18:44:44.000000000 -0700
+++ linux/fs/mpage.c	2002-06-06 06:14:13.000000000 -0700
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
@@ -78,19 +72,15 @@
 	bio_put(bio);
 }
 
-struct bio *mpage_bio_submit(int rw, struct bio *bio)
+struct bio *mpage_bio_submit(struct bio *bio)
 {
-	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
-	bio->bi_end_io = mpage_end_io_read;
-	if (rw == WRITE)
-		bio->bi_end_io = mpage_end_io_write;
-	submit_bio(rw, bio);
+	submit_bio(bio->bi_rw, bio);
 	return NULL;
 }
 
 static struct bio *
-mpage_alloc(struct block_device *bdev,
+mpage_alloc(struct block_device *bdev, int rw,
 		sector_t first_sector, int nr_vecs, int gfp_flags)
 {
 	struct bio *bio;
@@ -98,11 +88,14 @@
 	bio = bio_alloc(gfp_flags, nr_vecs);
 	if (bio) {
 		bio->bi_bdev = bdev;
-		bio->bi_vcnt = nr_vecs;
-		bio->bi_idx = 0;
+		bio->bi_vcnt = 0;
+		bio->bi_idx = nr_vecs;
 		bio->bi_size = 0;
 		bio->bi_sector = first_sector;
-		bio->bi_io_vec[0].bv_page = NULL;
+		bio->bi_rw = rw;
+		bio->bi_end_io = mpage_end_io_read;
+		if (rw == WRITE)
+			bio->bi_end_io = mpage_end_io_write;
 	}
 	return bio;
 }
@@ -161,14 +154,19 @@
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
-	struct bio_vec *bvec;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
 	unsigned first_hole = blocks_per_page;
-	struct block_device *bdev = NULL;
+	struct block_device *bdev =
+		S_ISBLK(inode->i_mode) ? inode->i_bdev : inode->i_sb->s_bdev;
 	struct buffer_head bh;
+	int bvec_size = PAGE_SIZE;
+	const unsigned max_bvecs = bio_max_iovecs(bdev->bd_queue, &bvec_size);
+
+	if (bvec_size != PAGE_SIZE)
+		goto confused;
 
 	if (page_has_buffers(page))
 		goto confused;
@@ -197,7 +195,6 @@
 		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
 			goto confused;
 		blocks[page_block] = bh.b_blocknr;
-		bdev = bh.b_bdev;
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -215,28 +212,28 @@
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
-	if (bio && (bio->bi_idx == bio->bi_vcnt ||
-			*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(READ, bio);
-
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		unsigned int nr_bvecs = max_bvecs;
 
 		if (nr_bvecs > nr_pages)
 			nr_bvecs = nr_pages;
-		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
+		bio = mpage_alloc(bdev, READ, blocks[0] << (blkbits - 9),
 					nr_bvecs, GFP_KERNEL);
 		if (bio == NULL)
 			goto confused;
 	}
+	else if (*last_block_in_bio != blocks[0] - 1)
+		bio->bi_idx = bio->bi_vcnt; /* force bio_append to
+					       allocate a new bio. */
+
+	if (bio_append(&bio, page, first_hole << blkbits, 0) != 0)
+		goto confused;
+
+	if (bio->bi_vcnt == 1)
+		bio->bi_sector = blocks[0] << (blkbits - 9);
 
-	bvec = &bio->bi_io_vec[bio->bi_idx++];
-	bvec->bv_page = page;
-	bvec->bv_len = (first_hole << blkbits);
-	bvec->bv_offset = 0;
-	bio->bi_size += bvec->bv_len;
 	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
-		bio = mpage_bio_submit(READ, bio);
+		bio->bi_idx = bio->bi_vcnt;
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -244,7 +241,7 @@
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(bio);
 	block_read_full_page(page, get_block);
 	goto out;
 }
@@ -270,7 +267,7 @@
 	}
 	BUG_ON(!list_empty(pages));
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpages);
@@ -286,7 +283,7 @@
 	bio = do_mpage_readpage(bio, page, 1,
 			&last_block_in_bio, get_block);
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
@@ -315,14 +312,19 @@
 	const unsigned blkbits = inode->i_blkbits;
 	unsigned long end_index;
 	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
-	struct bio_vec *bvec;
 	sector_t last_block;
 	sector_t block_in_file;
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
 	unsigned first_unmapped = blocks_per_page;
-	struct block_device *bdev = NULL;
+	struct block_device *bdev =
+		S_ISBLK(inode->i_mode) ? inode->i_bdev : inode->i_sb->s_bdev;
 	int boundary = 0;
+	int bvec_size = PAGE_SIZE;
+	const unsigned max_bvecs = bio_max_iovecs(bdev->bd_queue, &bvec_size);
+
+	if (bvec_size != PAGE_SIZE)
+		goto confused;
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -355,7 +357,6 @@
 			}
 			blocks[page_block++] = bh->b_blocknr;
 			boundary = buffer_boundary(bh);
-			bdev = bh->b_bdev;
 		} while ((bh = bh->b_this_page) != head);
 
 		if (first_unmapped)
@@ -391,7 +392,6 @@
 		}
 		blocks[page_block++] = map_bh.b_blocknr;
 		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
 		if (block_in_file == last_block)
 			break;
 		block_in_file++;
@@ -417,18 +417,14 @@
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
-	if (bio && (bio->bi_idx == bio->bi_vcnt ||
-				*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(WRITE, bio);
-
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
-
-		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_bvecs, GFP_NOFS);
+		bio = mpage_alloc(bdev, WRITE, blocks[0] << (blkbits - 9),
+					max_bvecs, GFP_NOFS);
 		if (bio == NULL)
 			goto confused;
 	}
+	else if (*last_block_in_bio != blocks[0] - 1)
+		bio->bi_idx = bio->bi_vcnt;
 
 	/*
 	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
@@ -447,23 +443,21 @@
 		} while (bh != head);
 	}
 
-	bvec = &bio->bi_io_vec[bio->bi_idx++];
-	bvec->bv_page = page;
-	bvec->bv_len = (first_unmapped << blkbits);
-	bvec->bv_offset = 0;
-	bio->bi_size += bvec->bv_len;
+	bio_append(&bio, page, first_unmapped << blkbits, 0);
+	if (bio->bi_vcnt == 1)
+		bio->bi_sector = blocks[0] << (blkbits - 9);
 	BUG_ON(PageWriteback(page));
 	SetPageWriteback(page);
 	unlock_page(page);
 	if (boundary || (first_unmapped != blocks_per_page))
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(bio);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
 	goto out;
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(bio);
 	*ret = block_write_full_page(page, get_block);
 out:
 	return bio;
@@ -541,7 +535,7 @@
 	}
 	write_unlock(&mapping->page_lock);
 	if (bio)
-		mpage_bio_submit(WRITE, bio);
+		mpage_bio_submit(bio);
 	return ret;
 }
 EXPORT_SYMBOL(mpage_writepages);
