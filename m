Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSFVPEd>; Sat, 22 Jun 2002 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSFVPEc>; Sat, 22 Jun 2002 11:04:32 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:21897 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313687AbSFVPEX>; Sat, 22 Jun 2002 11:04:23 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 22 Jun 2002 08:04:17 -0700
Message-Id: <200206221504.IAA00919@baldur.yggdrasil.com>
To: akpm@zip.com.au, axboe@suse.de
Subject: bio_append patch
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Here is a first draft of my bio_append patch.  It includes
a rewrite of most of mpage.c.

	The new mpage routines never punt to the fs/buffer.c routines.
So, it may be possible to rename them to their fs/buffer.c counterparts
and delete the fs/buffer.c versions.  Also, the new mpage routines
notice if you are trying to write PAGE_ZERO to a hole in a file and
will leave the hole in place in that case rather than allocate space
on disk unnecessarily.

	I know the code needs a little some clarification in the
form of documentation and perhaps some symbol renaming.

	Any comments, testing or benchmarking would be appreciated.
(I sure would like to know how much of a benefit if any we get from
building IO bigger requests.)

	Note: I believe I have seen 2.5.24 without these changes lock up
under one process's constant IDE disk activity.  So if you see a "soft
lockup", it would be helpful if you could see if you can repeat it
with this patch and have it not occur without this patch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.24/include/linux/bio.h	2002-06-20 15:53:55.000000000 -0700
+++ linux/include/linux/bio.h	2002-06-20 06:36:16.000000000 -0700
@@ -37,8 +37,7 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_SECTORS	128
-#define BIO_MAX_SIZE	(BIO_MAX_SECTORS << 9)
+#define BIO_MAX_VECS	256
 
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
@@ -78,6 +77,7 @@
 	 * hardware coalescing is performed.
 	 */
 	unsigned short		bi_hw_segments;
+	unsigned int		bi_last_seg_size;
 
 	unsigned int		bi_size;	/* residual I/O count */
 	unsigned int		bi_max;		/* max bvl_vecs we can hold,
@@ -196,11 +196,14 @@
 struct request_queue;
 extern inline int bio_phys_segments(struct request_queue *, struct bio *);
 extern inline int bio_hw_segments(struct request_queue *, struct bio *);
+extern int bio_max_iovecs(struct request_queue *q, int *iovec_size);
 
 extern inline void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, int);
 extern struct bio *bio_copy(struct bio *, int, int);
 
+extern void bio_recycle (struct bio **bio, int gfp_mask);
+extern void bio_append(struct bio **bio_p, struct bio_vec *bv, int gfp_mask);
 extern inline void bio_init(struct bio *);
 
 extern int bio_ioctl(kdev_t, unsigned int, unsigned long);
--- linux-2.5.24/include/linux/blkdev.h	2002-06-20 15:53:47.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-19 03:54:33.000000000 -0700
@@ -266,16 +266,26 @@
 	unsigned block_size_bits;
 };
 
+struct partition_ops {
+	int (*check)(struct gendisk *hd,
+		     struct block_device *bdev,
+		     unsigned long first_sect,
+		     int first_minor);
+	struct partition_ops *next;
+};
+
 /*
  * Used to indicate the default queue for drivers that don't bother
  * to implement multiple queues.  We have this access macro here
  * so as to eliminate the need for each and every block device
  * driver to know about the internal structure of blk_dev[].
  */
-#define BLK_DEFAULT_QUEUE(_MAJOR)  &blk_dev[_MAJOR].request_queue
+#define BLK_DEFAULT_QUEUE(_MAJOR)  (&blk_dev[_MAJOR].request_queue)
 
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
+extern void register_partition_ops(struct partition_ops *ops);
+extern void unregister_partition_ops(struct partition_ops *ops);
 extern void grok_partitions(kdev_t dev, long size);
 extern int wipe_partitions(kdev_t dev);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
@@ -287,6 +297,10 @@
 extern void blk_put_request(struct request *);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);
+struct bio_vec;
+extern void blk_tally_bvecs(request_queue_t *q, struct bio *bio,
+			    struct bio_vec *bvprv,
+			    struct bio_vec *bv, int bv_count);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
 extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
@@ -410,4 +424,6 @@
 	page_cache_release(p.v);
 }
 
+extern int bio_max_iovecs(request_queue_t *q, int *iovec_size);
+
 #endif
--- linux-2.5.24/fs/bio.c	2002-06-20 15:53:43.000000000 -0700
+++ linux/fs/bio.c	2002-06-22 07:30:21.000000000 -0700
@@ -92,6 +92,13 @@
 	return bvl;
 }
 
+/* Must correspond to the switch statement in bvec_alloc. */
+static inline int bi_max_to_size(int bi_max)
+{
+	static unsigned short bi_to_size[] = { 1, 4, 16, 64, 128, 256 };
+	return bi_to_size[bi_max];
+}
+
 /*
  * default destructor for a bio allocated with bio_alloc()
  */
@@ -118,6 +125,7 @@
 	bio->bi_idx = 0;
 	bio->bi_phys_segments = 0;
 	bio->bi_hw_segments = 0;
+	bio->bi_last_seg_size = 0;
 	bio->bi_size = 0;
 	bio->bi_end_io = NULL;
 	atomic_set(&bio->bi_cnt, 1);
@@ -317,6 +325,94 @@
 	return NULL;
 }
 
+void bio_recycle (struct bio **bio, int gfp_mask)
+{
+	struct bio *old = *bio;
+	struct bio *newbio = bio_alloc(gfp_mask, bi_max_to_size(old->bi_max));
+
+	newbio->bi_sector = old->bi_sector + (old->bi_size >> 9);
+
+#define COPY(field)    newbio->bi_ ## field = old->bi_ ## field
+	COPY(bdev);
+	COPY(rw);
+	COPY(end_io);
+	COPY(private);
+#undef COPY
+
+	submit_bio(old->bi_rw, old);
+	*bio = newbio;
+}
+
+
+/* bio_append appends an IO vector to a bio.  If there is no room
+   in the bio, the bio will first be submitted and replaced with an
+   empty one.
+
+   bio_append expects to be called with bio->bi_vcnt indicating the
+   number of IO vectors already loaded.  If the provided bio is
+   already full, bio_append will submit the current bio and allocate
+   a new one. */
+   
+void bio_append(struct bio **bio_p, struct bio_vec *bv, int gfp_mask)
+{
+       struct bio *bio		= *bio_p;
+       request_queue_t *q = bio->bi_bdev->bd_queue;
+
+       BUG_ON(q == NULL);
+       BUG_ON(bio->bi_io_vec == NULL);
+
+       if (bio->bi_vcnt != 0) {
+
+	       if (bio->bi_vcnt < bi_max_to_size(bio->bi_max) &&
+		   ((bio->bi_size + bv->bv_len) >> 9) <= q->max_sectors) {
+
+		       unsigned int phys_segs	= bio->bi_phys_segments;
+		       unsigned int hw_segs	= bio->bi_hw_segments;
+		       unsigned int seg_size	= bio->bi_last_seg_size;
+
+		       blk_tally_bvecs(q, bio, 
+				       &bio->bi_io_vec[bio->bi_vcnt-1], bv, 1);
+
+		       if (bio->bi_phys_segments <= q->max_phys_segments &&
+			   bio->bi_hw_segments <= q->max_hw_segments)
+			       goto goodbio;
+
+		       bio->bi_phys_segments = phys_segs;
+		       bio->bi_hw_segments = hw_segs;
+		       bio->bi_last_seg_size = seg_size;
+
+	       }
+	       bio_recycle(&bio, gfp_mask);
+	       *bio_p = bio;
+       }
+
+       blk_tally_bvecs(q, bio, NULL, bv, 1);
+       bio->bi_flags |= (1 << BIO_SEG_VALID);
+
+ goodbio:
+       bio->bi_io_vec[bio->bi_vcnt++] = *bv;
+       bio->bi_size += bv->bv_len;
+}
+
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
@@ -339,9 +435,10 @@
  **/
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
-	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
-	struct bio_vec *bvec;
+	int offset, size, err, map_i, total_nr_pages, nr_bvecs;
+	struct bio_vec bvec;
 	struct bio *bio;
+	int bytes_per_bvec, max_bvecs;
 
 	err = 0;
 	if ((rw & WRITE) && bdev_read_only(bdev)) {
@@ -367,17 +464,18 @@
 
 	map_i = 0;
 
-next_chunk:
-	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
-	if (nr_pages > total_nr_pages)
-		nr_pages = total_nr_pages;
+	max_bvecs = bio_max_iovecs(bdev->bd_queue, &bytes_per_bvec);
+
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
@@ -387,43 +485,37 @@
 	bio->bi_idx = 0;
 	bio->bi_end_io = bio_end_io_kio;
 	bio->bi_private = kio;
+	bio->bi_rw = rw;
 
-	bvec = bio->bi_io_vec;
-	for (i = 0; i < nr_pages; i++, bvec++, map_i++) {
+	while (total_nr_pages > 0) {
 		int nbytes = PAGE_SIZE - offset;
-
+ 
 		if (nbytes > size)
 			nbytes = size;
+		if (nbytes > bytes_per_bvec)
+			nbytes = bytes_per_bvec;
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
-			goto queue_io;
-
-		bio->bi_vcnt++;
-		bio->bi_size += nbytes;
-
-		bvec->bv_page = kio->maplist[map_i];
-		bvec->bv_len = nbytes;
-		bvec->bv_offset = offset;
-
-		/*
-		 * kiobuf only has an offset into the first page
-		 */
-		offset = 0;
+		bvec.bv_page = kio->maplist[map_i];
+		bvec.bv_offset = offset;
+		bvec.bv_len = nbytes;
+
+		bio_append(&bio, &bvec, GFP_NOIO);
+
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
 
-queue_io:
 	submit_bio(rw, bio);
 
-	if (total_nr_pages)
-		goto next_chunk;
-
 	if (size) {
 		printk("ll_rw_kio: size %d left (kio %d)\n", size, kio->length);
 		BUG();
--- linux-2.5.24/fs/mpage.c	2002-06-20 15:53:47.000000000 -0700
+++ linux/fs/mpage.c	2002-06-22 07:48:57.000000000 -0700
@@ -2,12 +2,19 @@
  * fs/mpage.c
  *
  * Copyright (C) 2002, Linus Torvalds.
+ * Copyright (C) 2001, Jens Axboe
+ * Copyright (C) 2002, Yggdrasil Computing, Inc.
  *
  * Contains functions related to preparing and submitting BIOs which contain
  * multiple pagecache pages.
  *
  * 15May2002	akpm@zip.com.au
  *		Initial version
+ *
+ * 21June2002	adam@yggdrasil.com
+ *		Rewrote at least half of it, in order to safely build
+ *		large IO transfers and to support the cases that
+ *		fs/buffer.c handled.
  */
 
 #include <linux/kernel.h>
@@ -19,12 +26,40 @@
 #include <linux/highmem.h>
 #include <linux/prefetch.h>
 #include <linux/mpage.h>
+#include <linux/slab.h>
+#include <linux/mempool.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+
+struct mpage_private {
+	atomic_t bvec_count;
+	atomic_t uptodate;
+};
 
-/*
- * The largest-sized BIO which this code will assemble, in bytes.  Set this
- * to PAGE_CACHE_SIZE if your drivers are broken.
- */
-#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
+static mempool_t *mpage_priv_pool;
+static kmem_cache_t *mpage_priv_slab;
+
+#define MPAGE_PRIV_POOL_SIZE	100
+
+static void
+bvec_io_error(struct bio_vec *bvec)
+{
+	if (page_has_buffers(bvec->bv_page)) {
+		const int bv_end = bvec->bv_offset + bvec->bv_len;
+		int buf_offset = 0;
+		struct buffer_head *bh = page_buffers(bvec->bv_page);
+
+		while (buf_offset + bh->b_size <= bvec->bv_offset) {
+			buf_offset += bh->b_size;
+			bh = bh->b_this_page;
+		}
+		while (buf_offset < bv_end) {
+			clear_buffer_uptodate(bh);
+			buf_offset += bh->b_size;
+			bh = bh->b_this_page;
+		}
+	}
+}
 
 /*
  * I/O completion handler for multipage BIOs.
@@ -38,81 +73,298 @@
  * status of that page is hard.  See end_buffer_async_read() for the details.
  * There is no point in duplicating all that complexity.
  */
-static void mpage_end_io_read(struct bio *bio)
+static void mpage_end_io(struct bio *bio)
 {
-	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
-	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec;
+	struct mpage_private *priv = bio->bi_private;
+	struct page *prevpage = NULL;
+	int rw;
+
+	if (!uptodate) {
+		int i;
+		bio_for_each_segment(bvec, bio, i) {
+			bvec_io_error(bvec);
+		}
+
+		if (priv != NULL)
+			atomic_set(&priv->uptodate, 0);
+	}
 
+	if (priv != NULL) {
+		if (!atomic_sub_and_test(bio->bi_vcnt, &priv->bvec_count))
+			return;
+		uptodate = atomic_read(&priv->uptodate);
+		mempool_free(priv, mpage_priv_pool);
+	}
+
+	rw = bio->bi_rw;
+	bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
 	do {
 		struct page *page = bvec->bv_page;
 
 		if (--bvec >= bio->bi_io_vec)
 			prefetchw(&bvec->bv_page->flags);
 
-		if (uptodate) {
-			SetPageUptodate(page);
-		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
+		if (page != prevpage) {
+			if (rw == READ) {
+				if (uptodate) {
+					SetPageUptodate(page);
+				} else {
+					ClearPageUptodate(page);
+					SetPageError(page);
+				}
+				unlock_page(page);
+			}
+			else {
+				if (!uptodate)
+					SetPageError(page);
+				end_page_writeback(page);
+			}
 		}
-		unlock_page(page);
 	} while (bvec >= bio->bi_io_vec);
+
 	bio_put(bio);
 }
 
-static void mpage_end_io_write(struct bio *bio)
+static struct bio *
+mpage_alloc(struct address_space *mapping, int nr_pages, int rw)
 {
-	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
-	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+	struct inode *inode = mapping->host;
+	int blocks_per_page;
+	struct bio *bio;
 
-	do {
-		struct page *page = bvec->bv_page;
+	if (inode->i_blkbits >= PAGE_CACHE_SHIFT)
+		blocks_per_page = 1;
+	else
+		blocks_per_page = PAGE_CACHE_SIZE >> inode->i_blkbits;
 
-		if (--bvec >= bio->bi_io_vec)
-			prefetchw(&bvec->bv_page->flags);
+	bio = bio_alloc(GFP_KERNEL,
+			min(nr_pages * blocks_per_page, BIO_MAX_VECS));
 
-		if (!uptodate)
-			SetPageError(page);
-		end_page_writeback(page);
-	} while (bvec >= bio->bi_io_vec);
-	bio_put(bio);
+	/* We rely on bio_alloc clearing bi_idx, bi_vcnt and bi_size. */
+	bio->bi_bdev =
+		S_ISBLK(inode->i_mode) ? inode->i_bdev : inode->i_sb->s_bdev;
+
+	bio->bi_end_io = mpage_end_io;
+	bio->bi_private = NULL;
+	bio->bi_rw = rw;
+
+	return bio;
 }
 
-struct bio *mpage_bio_submit(int rw, struct bio *bio)
+static inline void
+mpage_add_block(struct bio **bio_p,
+		struct bio_vec *bvec,
+		int offset,
+		int length,
+		sector_t sector)
 {
-	bio->bi_vcnt = bio->bi_idx;
-	bio->bi_idx = 0;
-	bio->bi_end_io = mpage_end_io_read;
-	if (rw == WRITE)
-		bio->bi_end_io = mpage_end_io_write;
-	submit_bio(rw, bio);
-	return NULL;
+	struct mpage_private *priv;
+	sector_t contig;
+	struct bio *old = *bio_p;
+
+	/* Deal with empty bvec and empty bio. */
+	if (bvec->bv_len == 0) {
+		bvec->bv_offset = offset;
+		if (old->bi_vcnt == 0)
+			old->bi_sector = sector;
+	}
+
+	contig = old->bi_sector + ((old->bi_size + bvec->bv_len)>>9);
+
+	if (sector == contig &&
+	    bvec->bv_offset + bvec->bv_len == offset &&
+	    (bvec->bv_len + length <=
+	     old->bi_bdev->bd_queue->max_segment_size)) {
+
+		bvec->bv_len += length;
+		return;
+	}
+
+	/* We are definitely going to use multiple bvec's for this
+	   page, which can possibly mean multiple bio's, either due
+	   to bio_append possibly splitting the bio or us explicitly
+	   doing so due to a transfer that is not contiguous on the
+	   block device. */
+
+	priv = old->bi_private;
+
+	if (priv == NULL) {
+
+		/* Send off the transfers for other pages, which
+		   do not need to use old->bi_private (they must not
+		   share ours anyhow).  */
+
+		if (old->bi_vcnt != 0)
+			bio_recycle(bio_p, GFP_KERNEL);
+
+		/* Variable "old" is not valid after this point. */
+
+		priv = mempool_alloc(mpage_priv_pool, GFP_KERNEL);
+		(*bio_p)->bi_private = priv;
+		atomic_set(&priv->uptodate, 1);
+		atomic_set(&priv->bvec_count, 1);
+	}
+
+	if (bvec->bv_len != 0) {
+		atomic_inc(&priv->bvec_count);
+		bio_append(bio_p, bvec, GFP_KERNEL);
+	}
+
+	if (sector != contig) {
+		if ((*bio_p)->bi_vcnt != 0)
+			bio_recycle(bio_p, GFP_KERNEL);
+		(*bio_p)->bi_sector = sector;
+	}
+
+	bvec->bv_offset = offset;
+	bvec->bv_len = length;
 }
 
 static struct bio *
-mpage_alloc(struct block_device *bdev,
-		sector_t first_sector, int nr_vecs, int gfp_flags)
+mpage_xferpage(struct bio *bio, struct page *page, get_block_t *get_block)
 {
-	struct bio *bio;
+	struct inode *inode = page->mapping->host;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocksize = 1 << blkbits;
+	unsigned num_blocks;
+	struct bio_vec bvec;
+	sector_t block_in_file;
+	unsigned offset;
+	struct buffer_head bh_local, *bh;
+	void *page_addr = NULL;
+	int sector_offset, page_within_block, xfer_size, xfer_total;
+	unsigned int stride;
+	int rw = bio->bi_rw;
+	const int create = (rw == WRITE);
+	request_queue_t *q = bio->bi_bdev->bd_queue;
+	sector_t sector;
+
+	if (page_has_buffers(page))
+		bh = page_buffers(page);
+	else {
+		/* Make bh keep pointing to bh_local throughout the loop. */
+		bh = &bh_local;
+		bh_local.b_this_page = &bh_local;
+	}
+
+	page_within_block = page->index & ((blocksize-1) >> PAGE_CACHE_SHIFT);
+	sector_offset = page_within_block << (PAGE_CACHE_SHIFT - 9);
+	
+	if (blkbits <= PAGE_CACHE_SHIFT) {
+		stride = blocksize;
+		num_blocks = PAGE_CACHE_SIZE >> blkbits;
+		block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
+	} else {
+		stride = PAGE_CACHE_SIZE;
+		num_blocks = 1;
+		block_in_file = page->index >> (blkbits - PAGE_CACHE_SHIFT);
+	}
+
+	/* FIXME.  Right now you cannot have a file system on a block
+	   device where the minimum tranfer size (i.e., hardsect_size)
+	   is larger than either the file system block size, or
+	   PAGE_CACHE_SIZE.  However, I think adding such support would
+	   require changing most of the Linux filesystem drivers.
+	   -Adam J. Richter, 2002 June 22, */
+
+	BUG_ON(q->hardsect_size > stride);
+
+	xfer_size = min(q->max_segment_size, stride);
+
+	/* Avoid accidentally extending files and directories. */
+	if (rw == WRITE && !S_ISBLK(inode->i_mode)) {
+		sector_t end_block = (inode->i_size + blocksize - 1)>>blkbits;
+		if (block_in_file + num_blocks > end_block)
+			num_blocks = end_block - block_in_file;
+	}
+
+	bvec.bv_len = 0;
+	bvec.bv_page = page;
+	for (offset = 0; num_blocks--;
+	     offset += stride, block_in_file++, bh = bh->b_this_page) {
+
+		bh_local.b_state = 0;
+
+		if (!buffer_mapped(bh)) {
+
+			/*
+			 * Do not write all zeroes into file holes.
+			 */
+			if (rw == WRITE && page == ZERO_PAGE(NULL) &&
+			    !get_block(inode, block_in_file, bh, 0) &&
+			    !buffer_mapped(bh)) {
+				clear_buffer_dirty(bh);
+				continue;
+			}
+							
 
-	bio = bio_alloc(gfp_flags, nr_vecs);
+			if (get_block(inode, block_in_file, bh, create)) {
+				SetPageError(page);
+				continue;
+			}
+
+			if (!buffer_mapped(bh)) {
+
+				BUG_ON(rw != READ);
+
+				if (page_addr == NULL)
+					page_addr = kmap(page);
+
+				memset(page_addr + offset, 0, stride);
+				set_buffer_uptodate(bh);
+				continue;
+			}
+		}
+
+		sector = (bh->b_blocknr << (blkbits - 9)) + sector_offset;
+
+		for(xfer_total = 0; xfer_total < stride;
+		    xfer_total += xfer_size)
+			mpage_add_block(&bio, &bvec, offset + xfer_total,
+					xfer_size,
+					sector + (xfer_total >> 9));
+
+		if (rw == WRITE)
+			clear_buffer_dirty(bh);
 
-	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
-		while (!bio && (nr_vecs /= 2))
-			bio = bio_alloc(gfp_flags, nr_vecs);
 	}
 
-	if (bio) {
-		bio->bi_bdev = bdev;
-		bio->bi_vcnt = nr_vecs;
-		bio->bi_idx = 0;
-		bio->bi_size = 0;
-		bio->bi_sector = first_sector;
-		bio->bi_io_vec[0].bv_page = NULL;
+	if (bvec.bv_len == 0) {
+		/* A hole in the file covered the entire page.  */
+		SetPageUptodate(page);
+		unlock_page(page);
+
+	} else {
+		if (rw == WRITE) {
+			BUG_ON(PageWriteback(page));
+			SetPageWriteback(page);
+			unlock_page(page);
+		}
+		bio_append(&bio, &bvec, GFP_KERNEL);
+		if (bio->bi_private) {
+			/* Multiple transfer on the same page must not be
+			   merged with transfers for another page, so
+			   submit them now.  Also, this balances out the
+			   initial prev->bvec_count == 1 that was set
+			   by mpage_add_block. */
+
+			bio_recycle(&bio, GFP_KERNEL);
+			bio->bi_private = NULL;
+		}
 	}
+
+	if (page_addr != NULL)
+		kunmap(page);
+
+	if (buffer_boundary(bh) && bio->bi_vcnt != 0)
+		bio_recycle(&bio, GFP_KERNEL);
+
 	return bio;
 }
 
+
 /**
  * mpage_readpages - populate an address space with some pages, and
  *                       start reads against them.
@@ -159,336 +411,97 @@
  *
  * This all causes the disk requests to be issued in the correct order.
  */
-static struct bio *
-do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
-			sector_t *last_block_in_bio, get_block_t get_block)
-{
-	struct inode *inode = page->mapping->host;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
-	const unsigned blocksize = 1 << blkbits;
-	struct bio_vec *bvec;
-	sector_t block_in_file;
-	sector_t last_block;
-	sector_t blocks[MAX_BUF_PER_PAGE];
-	unsigned page_block;
-	unsigned first_hole = blocks_per_page;
-	struct block_device *bdev = NULL;
-	struct buffer_head bh;
-
-	if (page_has_buffers(page))
-		goto confused;
-
-	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (inode->i_size + blocksize - 1) >> blkbits;
-
-	for (page_block = 0; page_block < blocks_per_page;
-				page_block++, block_in_file++) {
-		bh.b_state = 0;
-		if (block_in_file < last_block) {
-			if (get_block(inode, block_in_file, &bh, 0))
-				goto confused;
-		}
-
-		if (!buffer_mapped(&bh)) {
-			if (first_hole == blocks_per_page)
-				first_hole = page_block;
-			continue;
-		}
-	
-		if (first_hole != blocks_per_page)
-			goto confused;		/* hole -> non-hole */
-
-		/* Contiguous blocks? */
-		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
-			goto confused;
-		blocks[page_block] = bh.b_blocknr;
-		bdev = bh.b_bdev;
-	}
-
-	if (first_hole != blocks_per_page) {
-		memset(kmap(page) + (first_hole << blkbits), 0,
-				PAGE_CACHE_SIZE - (first_hole << blkbits));
-		flush_dcache_page(page);
-		kunmap(page);
-		if (first_hole == 0) {
-			SetPageUptodate(page);
-			unlock_page(page);
-			goto out;
-		}
-	}
-
-	/*
-	 * This page will go to BIO.  Do we need to send this BIO off first?
-	 */
-	if (bio && (bio->bi_idx == bio->bi_vcnt ||
-			*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(READ, bio);
-
-	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
-
-		if (nr_bvecs > nr_pages)
-			nr_bvecs = nr_pages;
-		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_bvecs, GFP_KERNEL);
-		if (bio == NULL)
-			goto confused;
-	}
-
-	bvec = &bio->bi_io_vec[bio->bi_idx++];
-	bvec->bv_page = page;
-	bvec->bv_len = (first_hole << blkbits);
-	bvec->bv_offset = 0;
-	bio->bi_size += bvec->bv_len;
-	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
-		bio = mpage_bio_submit(READ, bio);
-	else
-		*last_block_in_bio = blocks[blocks_per_page - 1];
-out:
-	return bio;
-
-confused:
-	if (bio)
-		bio = mpage_bio_submit(READ, bio);
-	block_read_full_page(page, get_block);
-	goto out;
-}
-
 int
 mpage_readpages(struct address_space *mapping, struct list_head *pages,
-				unsigned nr_pages, get_block_t get_block)
+		unsigned nr_pages, get_block_t *get_block)
 {
-	struct bio *bio = NULL;
-	unsigned page_idx;
-	sector_t last_block_in_bio = 0;
+ 	struct bio *bio;
+
+	if (nr_pages == 0)
+		return 0;
 
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+ 	bio = mpage_alloc(mapping, nr_pages, READ);
+	while (nr_pages--) {
 		struct page *page = list_entry(pages->prev, struct page, list);
 
 		prefetchw(&page->flags);
 		list_del(&page->list);
 		if (!add_to_page_cache_unique(page, mapping, page->index))
-			bio = do_mpage_readpage(bio, page,
-					nr_pages - page_idx,
-					&last_block_in_bio, get_block);
+			bio = mpage_xferpage(bio, page, get_block);
 		page_cache_release(page);
 	}
 	BUG_ON(!list_empty(pages));
-	if (bio)
-		mpage_bio_submit(READ, bio);
+
+	if (bio->bi_vcnt)
+		submit_bio(READ, bio);
+	else
+		bio_put(bio);
+
 	return 0;
 }
+
 EXPORT_SYMBOL(mpage_readpages);
 
 /*
  * This isn't called much at all
  */
-int mpage_readpage(struct page *page, get_block_t get_block)
+int mpage_readpage(struct page *page, get_block_t *get_block)
 {
-	struct bio *bio = NULL;
-	sector_t last_block_in_bio = 0;
+	struct bio *bio = mpage_alloc(page->mapping, 1, READ);
+
+	bio = mpage_xferpage(bio, page, get_block);
+
+	if (bio->bi_vcnt)
+		submit_bio(READ, bio);
+	else
+		bio_put(bio);
 
-	bio = do_mpage_readpage(bio, page, 1,
-			&last_block_in_bio, get_block);
-	if (bio)
-		mpage_bio_submit(READ, bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
 
-/*
- * Writing is not so simple.
- *
- * If the page has buffers then they will be used for obtaining the disk
- * mapping.  We only support pages which are fully mapped-and-dirty, with a
- * special case for pages which are unmapped at the end: end-of-file.
- *
- * If the page has no buffers (preferred) then the page is mapped here.
- *
- * If all blocks are found to be contiguous then the page can go into the
- * BIO.  Otherwise fall back to the mapping's writepage().
- * 
- * FIXME: This code wants an estimate of how many pages are still to be
- * written, so it can intelligently allocate a suitably-sized BIO.  For now,
- * just allocate full-size (16-page) BIOs.
- */
-static inline struct bio *
-mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
-			sector_t *last_block_in_bio, int *ret)
-{
-	struct inode *inode = page->mapping->host;
-	const unsigned blkbits = inode->i_blkbits;
-	unsigned long end_index;
-	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
-	struct bio_vec *bvec;
-	sector_t last_block;
-	sector_t block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
-	unsigned page_block;
-	unsigned first_unmapped = blocks_per_page;
-	struct block_device *bdev = NULL;
-	int boundary = 0;
-
-	if (page_has_buffers(page)) {
-		struct buffer_head *head = page_buffers(page);
-		struct buffer_head *bh = head;
-
-		/* If they're all mapped and dirty, do it */
-		page_block = 0;
-		do {
-			BUG_ON(buffer_locked(bh));
-			if (!buffer_mapped(bh)) {
-				/*
-				 * unmapped dirty buffers are created by
-				 * __set_page_dirty_buffers -> mmapped data
-				 */
-				if (buffer_dirty(bh))
-					goto confused;
-				if (first_unmapped == blocks_per_page)
-					first_unmapped = page_block;
-				continue;
-			}
-
-			if (first_unmapped != blocks_per_page)
-				goto confused;	/* hole -> non-hole */
-
-			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
-				goto confused;
-			if (page_block) {
-				if (bh->b_blocknr != blocks[page_block-1] + 1)
-					goto confused;
-			}
-			blocks[page_block++] = bh->b_blocknr;
-			boundary = buffer_boundary(bh);
-			bdev = bh->b_bdev;
-		} while ((bh = bh->b_this_page) != head);
-
-		if (first_unmapped)
-			goto page_is_mapped;
-
-		/*
-		 * Page has buffers, but they are all unmapped. The page was
-		 * created by pagein or read over a hole which was handled by
-		 * block_read_full_page().  If this address_space is also
-		 * using mpage_readpages then this can rarely happen.
-		 */
-		goto confused;
-	}
 
-	/*
-	 * The page has no buffers: map it to disk
-	 */
-	BUG_ON(!PageUptodate(page));
-	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (inode->i_size - 1) >> blkbits;
-	for (page_block = 0; page_block < blocks_per_page; ) {
-		struct buffer_head map_bh;
-
-		map_bh.b_state = 0;
-		if (get_block(inode, block_in_file, &map_bh, 1))
-			goto confused;
-		if (buffer_new(&map_bh))
-			unmap_underlying_metadata(map_bh.b_bdev,
-						map_bh.b_blocknr);
-		if (page_block) {
-			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
-				goto confused;
-		}
-		blocks[page_block++] = map_bh.b_blocknr;
-		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
-		if (block_in_file == last_block)
-			break;
-		block_in_file++;
-	}
-	if (page_block == 0)
-		buffer_error();
-
-	first_unmapped = page_block;
-
-	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
-	if (page->index >= end_index) {
-		unsigned offset = inode->i_size & (PAGE_CACHE_SIZE - 1);
-
-		if (page->index > end_index || !offset)
-			goto confused;
-		memset(kmap(page) + offset, 0, PAGE_CACHE_SIZE - offset);
-		flush_dcache_page(page);
-		kunmap(page);
-	}
-
-page_is_mapped:
-
-	/*
-	 * This page will go to BIO.  Do we need to send this BIO off first?
-	 */
-	if (bio && (bio->bi_idx == bio->bi_vcnt ||
-				*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(WRITE, bio);
-
-	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
-
-		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_bvecs, GFP_NOFS);
-		if (bio == NULL)
-			goto confused;
-	}
-
-	/*
-	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
-	 * sure to only clean buffers which we know we'll be writing.
-	 */
-	if (page_has_buffers(page)) {
-		struct buffer_head *head = page_buffers(page);
-		struct buffer_head *bh = head;
-		unsigned buffer_counter = 0;
-
-		do {
-			if (buffer_counter++ == first_unmapped)
-				break;
-			clear_buffer_dirty(bh);
-			bh = bh->b_this_page;
-		} while (bh != head);
-	}
-
-	bvec = &bio->bi_io_vec[bio->bi_idx++];
-	bvec->bv_page = page;
-	bvec->bv_len = (first_unmapped << blkbits);
-	bvec->bv_offset = 0;
-	bio->bi_size += bvec->bv_len;
-	BUG_ON(PageWriteback(page));
-	SetPageWriteback(page);
-	unlock_page(page);
-	if (boundary || (first_unmapped != blocks_per_page))
-		bio = mpage_bio_submit(WRITE, bio);
-	else
-		*last_block_in_bio = blocks[blocks_per_page - 1];
-	goto out;
-
-confused:
-	if (bio)
-		bio = mpage_bio_submit(WRITE, bio);
-	*ret = page->mapping->a_ops->writepage(page);
-out:
-	return bio;
+static inline int list_len(struct list_head *list)
+{
+	list_t *tmp;
+	int count = 0;
+	list_for_each(tmp, list)
+		count++;
+	return count;
 }
 
 /*
  * This is a cut-n-paste of generic_writepages().  We _could_
  * generalise that function.  It'd get a bit messy.  We'll see.
  */
+
 int
 mpage_writepages(struct address_space *mapping,
 			int *nr_to_write, get_block_t get_block)
 {
-	struct bio *bio = NULL;
-	sector_t last_block_in_bio = 0;
-	int ret = 0;
+	struct bio *bio;
 	int done = 0;
+	int pages_to_write;
 
 	write_lock(&mapping->page_lock);
+	pages_to_write =
+		nr_to_write ? *nr_to_write : list_len(&mapping->io_pages);
+
+	/*
+	 *  FIXME.  The old code would actually do one iteration if
+	 *  page_to_write was 0. Was that necessary?
+	 */
+	if (pages_to_write <= 0)
+		pages_to_write = 1;
+
+#if 0
+	if (pages_to_write == 0) {
+		write_unlock(&mapping->page_lock);
+		return 0;
+	}
+#endif
+
+	bio = mpage_alloc(mapping, pages_to_write, WRITE);
 
 	list_splice(&mapping->dirty_pages, &mapping->io_pages);
 	INIT_LIST_HEAD(&mapping->dirty_pages);
@@ -498,11 +511,9 @@
 					struct page, list);
 		list_del(&page->list);
 		if (PageWriteback(page)) {
-			if (PageDirty(page)) {
-				list_add(&page->list, &mapping->dirty_pages);
-				continue;
-			}
-			list_add(&page->list, &mapping->locked_pages);
+			list_add(&page->list, PageDirty(page) ?
+				 &mapping->dirty_pages :
+				 &mapping->locked_pages);
 			continue;
 		}
 		if (!PageDirty(page)) {
@@ -527,9 +538,8 @@
 				}
 				spin_unlock(&pagemap_lru_lock);
 			}
-			bio = mpage_writepage(bio, page, get_block,
-					&last_block_in_bio, &ret);
-			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
+			bio = mpage_xferpage(bio, page, get_block);
+			if (nr_to_write && --(*nr_to_write) <= 0)
 				done = 1;
 		} else {
 			unlock_page(page);
@@ -546,8 +556,50 @@
 		INIT_LIST_HEAD(&mapping->io_pages);
 	}
 	write_unlock(&mapping->page_lock);
-	if (bio)
-		mpage_bio_submit(WRITE, bio);
-	return ret;
+	if (bio->bi_vcnt)
+		submit_bio(WRITE, bio);
+	else
+		bio_put(bio);
+
+	return 0;
 }
+
 EXPORT_SYMBOL(mpage_writepages);
+
+
+/* Below is copied from bio.c, so I added Jens to the copyright notice.
+   -Adam */
+
+static void *slab_pool_alloc(int gfp_mask, void *data)
+{
+	return kmem_cache_alloc(data, gfp_mask);
+}
+
+static void slab_pool_free(void *ptr, void *data)
+{
+	kmem_cache_free(data, ptr);
+}
+
+static int __init init_mpage(void)
+{
+	mpage_priv_slab = kmem_cache_create("mpage_priv",
+					    sizeof(struct mpage_private), 0,
+					    SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!mpage_priv_slab)
+		panic("mpage: can't create slab cache\n");
+
+	mpage_priv_pool = mempool_create(MPAGE_PRIV_POOL_SIZE,
+					 slab_pool_alloc, slab_pool_free,
+					 mpage_priv_slab);
+	if (!mpage_priv_pool)
+		panic("mpage: can't create mempool\n");
+
+	printk("MPAGE_PRIV: pool of %d setup, %ZuKb (%Zd bytes/mpage_priv)\n",
+	       MPAGE_PRIV_POOL_SIZE,
+	       MPAGE_PRIV_POOL_SIZE * sizeof(struct mpage_private) >> 10,
+	       sizeof(struct mpage_private));
+
+	return 0;
+}
+
+module_init(init_mpage);
