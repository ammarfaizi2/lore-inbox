Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316395AbSEZUlu>; Sun, 26 May 2002 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316393AbSEZUlV>; Sun, 26 May 2002 16:41:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316384AbSEZUjB>;
	Sun, 26 May 2002 16:39:01 -0400
Message-ID: <3CF1489D.8293400@zip.com.au>
Date: Sun, 26 May 2002 13:42:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 7/18] direct-to-BIO readahead
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implements BIO-based multipage reads into the pagecache, and turns this
on for ext2.

CPU load for `cat large_file > /dev/null' is reduced by approximately
15%.  Similar reductions for tiobench with a single thread.  (Earlier
claims of 25% were exaggerated - they were measured with slab debug
enabled.  But 15% isn't bad for a load which is dominated by copy_*_user
costs).

With 2, 4 and 8 tiobench threads, throughput is increased as well, which was
unexpected.  It's due to request queue weirdness.  (Generally the
request queueing is doing bad things under certain workloads - that's a
separate issue.)

BIOs of up to 64 kbytes are assembled and submitted for readahead and
for single-page reads.  So the work involved in reading 32 pages has gone
from:

	- allocate and attach 32 buffer_heads
	- submit 32 buffer_heads
	- allocate 32 bios
	- submit 32 bios

to:

	- allocate 2 bios
	- submit 2 bios

These pages never have buffers attached.  Buffers will be attached
later if the application writes to these pages (file overwrite).

The first version of this code (in the "delayed allocation" patches)
tries to handle everything - bios which start mid-page, bios which end
mid-page and pages which are covered by multiple bios.  It is very
complex code and in fact appears to be incorrect: out-of-order BIO
completion could cause a page to come unlocked at the wrong time.

This implementation is much simpler: if things get complex, it just
falls back to the buffer-based block_read_full_page(), which isn't
going away, and which understands all that complexity.  There's no
point in doing this in two places.

This code will bypass the buffer layer for

 - fully-mapped pages which are on-disk contiguous.

 - fully unmapoped pages (holes)

 - partially unmapped pages, where the unmappedness is at the end of
   the page (end-of-file).

and everything else falls back to buffers.

This means that with blocksize == PAGE_CACHE_SIZE, 100% of pages are
handed direct to BIO.  With a heavy 10-minute dbench run on 4k
PAGE_CACHE_SIZE and 1k blocks, 95% of pages were handed direct to BIO. 
Almost all of the other 5% were passed to block_read_full_page()
because they were already partially uptodate from an earlier sub-page
write().  This ratio will fall if PAGE_CACHE_SIZE/blocksize is greater
than four.  But if that's the case, CPU efficiency is far from the main
concern - there are significant seek and bandwidth problems just at 4
blocks per page.

This code will stress out the block layer somewhat - RAID0 doesn't like
multipage BIOs, and there are probably others.  RAID0 seems to struggle
along - readahead fails but read falls back to single-page reads, which
succeed.  Such problems may be worked around by setting MPAGE_BIO_MAX_SIZE
to PAGE_CACHE_SIZE in fs/mpage.c.

It is trivial to enable multipage reads for many other filesystems.  We
can do that after completion of external testing of ext2.


=====================================

--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.18-akpm/fs/mpage.c	Sun May 26 02:50:52 2002
@@ -0,0 +1,272 @@
+/*
+ * fs/mpage.c
+ *
+ * Copyright (C) 2002, Linus Torvalds.
+ *
+ * Contains functions related to preparing and submitting BIOs which contain
+ * multiple pagecache pages.
+ *
+ * 15May2002	akpm@zip.com.au
+ *		Initial version
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bio.h>
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include <linux/blkdev.h>
+#include <linux/highmem.h>
+#include <linux/prefetch.h>
+#include <linux/mpage.h>
+
+/*
+ * The largest-sized BIO which this code will assemble, in bytes.  Set this
+ * to PAGE_CACHE_SIZE if your drivers are broken.
+ */
+#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
+
+/*
+ * I/O completion handler for multipage BIOs.
+ *
+ * The mpage code never puts partial pages into a BIO (except for end-of-file).
+ * If a page does not map to a contiguous run of blocks then it simply falls
+ * back to block_read_full_page().
+ *
+ * Why is this?  If a page's completion depends on a number of different BIOs
+ * which can complete in any order (or at the same time) then determining the
+ * status of that page is hard.  See end_buffer_async_read() for the details.
+ * There is no point in duplicating all that complexity.
+ */
+static void mpage_end_io_read(struct bio *bio)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+
+	do {
+		struct page *page = bvec->bv_page;
+
+		if (--bvec >= bio->bi_io_vec)
+			prefetchw(&bvec->bv_page->flags);
+
+		if (uptodate) {
+			SetPageUptodate(page);
+		} else {
+			ClearPageUptodate(page);
+			SetPageError(page);
+		}
+		unlock_page(page);
+	} while (bvec >= bio->bi_io_vec);
+	bio_put(bio);
+}
+
+struct bio *mpage_bio_submit(int rw, struct bio *bio)
+{
+	bio->bi_vcnt = bio->bi_idx;
+	bio->bi_idx = 0;
+	bio->bi_end_io = mpage_end_io_read;
+	submit_bio(rw, bio);
+	return NULL;
+}
+
+static struct bio *
+mpage_alloc(struct block_device *bdev,
+		sector_t first_sector, int nr_vecs, int gfp_flags)
+{
+	struct bio *bio;
+
+	bio = bio_alloc(gfp_flags, nr_vecs);
+	if (bio) {
+		bio->bi_bdev = bdev;
+		bio->bi_vcnt = nr_vecs;
+		bio->bi_idx = 0;
+		bio->bi_size = 0;
+		bio->bi_sector = first_sector;
+		bio->bi_io_vec[0].bv_page = NULL;
+	}
+	return bio;
+}
+
+/**
+ * mpage_readpages - populate an address space with some pages, and
+ *                       start reads against them.
+ *
+ * @mapping: the address_space
+ * @pages: The address of a list_head which contains the target pages.  These
+ *   pages have their ->index populated and are otherwise uninitialised.
+ *
+ *   The page at @pages->prev has the lowest file offset, and reads should be
+ *   issued in @pages->prev to @pages->next order.
+ *
+ * @nr_pages: The number of pages at *@pages
+ * @get_block: The filesystem's block mapper function.
+ *
+ * This function walks the pages and the blocks within each page, building and
+ * emitting large BIOs.
+ *
+ * If anything unusual happens, such as:
+ *
+ * - encountering a page which has buffers
+ * - encountering a page which has a non-hole after a hole
+ * - encountering a page with non-contiguous blocks
+ *
+ * then this code just gives up and calls the buffer_head-based read function.
+ * It does handle a page which has holes at the end - that is a common case:
+ * the end-of-file on blocksize < PAGE_CACHE_SIZE setups.
+ *
+ * BH_Boundary explanation:
+ *
+ * There is a problem.  The mpage read code assembles several pages, gets all
+ * their disk mappings, and then submits them all.  That's fine, but obtaining
+ * the disk mappings may require I/O.  Reads of indirect blocks, for example.
+ *
+ * So an mpage read of the first 16 blocks of an ext2 file will cause I/O to be
+ * submitted in the following order:
+ * 	12 0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16
+ * because the indirect block has to be read to get the mappings of blocks
+ * 13,14,15,16.  Obviously, this impacts performance.
+ * 
+ * So what we do it to allow the filesystem's get_block() function to set
+ * BH_Boundary when it maps block 11.  BH_Boundary says: mapping of the block
+ * after this one will require I/O against a block which is probably close to
+ * this one.  So you should push what I/O you have currently accumulated.
+ *
+ * This all causes the disk requests to be issued in the correct order.
+ */
+static struct bio *
+do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
+			sector_t *last_block_in_bio, get_block_t get_block)
+{
+	struct inode *inode = page->mapping->host;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
+	const unsigned blocksize = 1 << blkbits;
+	struct bio_vec *bvec;
+	sector_t block_in_file;
+	sector_t last_block;
+	sector_t blocks[MAX_BUF_PER_PAGE];
+	unsigned page_block;
+	unsigned first_hole = blocks_per_page;
+	struct block_device *bdev = NULL;
+	struct buffer_head bh;
+
+	if (page_has_buffers(page))
+		goto confused;
+
+	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
+	last_block = (inode->i_size + blocksize - 1) >> blkbits;
+
+	for (page_block = 0; page_block < blocks_per_page;
+				page_block++, block_in_file++) {
+		bh.b_state = 0;
+		if (block_in_file < last_block) {
+			if (get_block(inode, block_in_file, &bh, 0))
+				goto confused;
+		}
+
+		if (!buffer_mapped(&bh)) {
+			if (first_hole == blocks_per_page)
+				first_hole = page_block;
+			continue;
+		}
+	
+		if (first_hole != blocks_per_page)
+			goto confused;		/* hole -> non-hole */
+
+		/* Contiguous blocks? */
+		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
+			goto confused;
+		blocks[page_block] = bh.b_blocknr;
+		bdev = bh.b_bdev;
+	}
+
+	if (first_hole != blocks_per_page) {
+		memset(kmap(page) + (first_hole << blkbits), 0,
+				PAGE_CACHE_SIZE - (first_hole << blkbits));
+		flush_dcache_page(page);
+		kunmap(page);
+		if (first_hole == 0) {
+			SetPageUptodate(page);
+			unlock_page(page);
+			goto out;
+		}
+	}
+
+	/*
+	 * This page will go to BIO.  Do we need to send this BIO off first?
+	 */
+	if (bio && (bio->bi_idx == bio->bi_vcnt ||
+			*last_block_in_bio != blocks[0] - 1))
+		bio = mpage_bio_submit(READ, bio);
+
+	if (bio == NULL) {
+		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+
+		if (nr_bvecs > nr_pages)
+			nr_bvecs = nr_pages;
+		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
+					nr_bvecs, GFP_KERNEL);
+		if (bio == NULL)
+			goto confused;
+	}
+
+	bvec = &bio->bi_io_vec[bio->bi_idx++];
+	bvec->bv_page = page;
+	bvec->bv_len = (first_hole << blkbits);
+	bvec->bv_offset = 0;
+	bio->bi_size += bvec->bv_len;
+	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
+		bio = mpage_bio_submit(READ, bio);
+	else
+		*last_block_in_bio = blocks[blocks_per_page - 1];
+out:
+	return bio;
+
+confused:
+	if (bio)
+		bio = mpage_bio_submit(READ, bio);
+	block_read_full_page(page, get_block);
+	goto out;
+}
+
+int
+mpage_readpages(struct address_space *mapping, struct list_head *pages,
+				unsigned nr_pages, get_block_t get_block)
+{
+	struct bio *bio = NULL;
+	unsigned page_idx;
+	sector_t last_block_in_bio = 0;
+
+	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+		struct page *page = list_entry(pages->prev, struct page, list);
+
+		prefetchw(&page->flags);
+		list_del(&page->list);
+		if (!add_to_page_cache_unique(page, mapping, page->index))
+			bio = do_mpage_readpage(bio, page,
+					nr_pages - page_idx,
+					&last_block_in_bio, get_block);
+		page_cache_release(page);
+	}
+	BUG_ON(!list_empty(pages));
+	if (bio)
+		mpage_bio_submit(READ, bio);
+	return 0;
+}
+EXPORT_SYMBOL(mpage_readpages);
+
+/*
+ * This isn't called much at all
+ */
+int mpage_readpage(struct page *page, get_block_t get_block)
+{
+	struct bio *bio = NULL;
+	sector_t last_block_in_bio = 0;
+
+	bio = do_mpage_readpage(bio, page, 1,
+			&last_block_in_bio, get_block);
+	if (bio)
+		mpage_bio_submit(READ, bio);
+	return 0;
+}
+EXPORT_SYMBOL(mpage_readpage);
--- 2.5.18/fs/Makefile~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/fs/Makefile	Sun May 26 02:31:25 2002
@@ -7,7 +7,8 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o dquot.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o dquot.o \
+		mpage.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
@@ -15,7 +16,7 @@ obj-y :=	open.o read_write.o devices.o f
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o quota.o
+		fs-writeback.o quota.o mpage.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
--- 2.5.18/include/linux/buffer_head.h~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/include/linux/buffer_head.h	Sun May 26 02:49:58 2002
@@ -24,6 +24,7 @@ enum bh_state_bits {
 	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
 
 	BH_JBD,		/* Has an attached ext3 journal_head */
+	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
@@ -106,6 +107,7 @@ BUFFER_FNS(Mapped, mapped)
 BUFFER_FNS(New, new)
 BUFFER_FNS(Async_Read, async_read)
 BUFFER_FNS(Async_Write, async_write)
+BUFFER_FNS(Boundary, boundary)
 
 /*
  * FIXME: this is used only by bh_kmap, which is used only by RAID5.
--- 2.5.18/fs/ext2/inode.c~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/fs/ext2/inode.c	Sun May 26 02:49:58 2002
@@ -30,6 +30,7 @@
 #include <linux/quotaops.h>
 #include <linux/module.h>
 #include <linux/buffer_head.h>
+#include <linux/mpage.h>
 
 MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
@@ -148,7 +149,8 @@ static inline int verify_chain(Indirect 
  *	@inode: inode in question (we are only interested in its superblock)
  *	@i_block: block number to be parsed
  *	@offsets: array to store the offsets in
- *
+ *      @boundary: set this non-zero if the referred-to block is likely to be
+ *             followed (on disk) by an indirect block.
  *	To store the locations of file's data ext2 uses a data structure common
  *	for UNIX filesystems - tree of pointers anchored in the inode, with
  *	data blocks at leaves and indirect blocks in intermediate nodes.
@@ -172,7 +174,8 @@ static inline int verify_chain(Indirect 
  * get there at all.
  */
 
-static int ext2_block_to_path(struct inode *inode, long i_block, int offsets[4])
+static int ext2_block_to_path(struct inode *inode,
+			long i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT2_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -180,26 +183,33 @@ static int ext2_block_to_path(struct ino
 		indirect_blocks = ptrs,
 		double_blocks = (1 << (ptrs_bits * 2));
 	int n = 0;
+	int final = 0;
 
 	if (i_block < 0) {
 		ext2_warning (inode->i_sb, "ext2_block_to_path", "block < 0");
 	} else if (i_block < direct_blocks) {
 		offsets[n++] = i_block;
+		final = direct_blocks;
 	} else if ( (i_block -= direct_blocks) < indirect_blocks) {
 		offsets[n++] = EXT2_IND_BLOCK;
 		offsets[n++] = i_block;
+		final = ptrs;
 	} else if ((i_block -= indirect_blocks) < double_blocks) {
 		offsets[n++] = EXT2_DIND_BLOCK;
 		offsets[n++] = i_block >> ptrs_bits;
 		offsets[n++] = i_block & (ptrs - 1);
+		final = ptrs;
 	} else if (((i_block -= double_blocks) >> (ptrs_bits * 2)) < ptrs) {
 		offsets[n++] = EXT2_TIND_BLOCK;
 		offsets[n++] = i_block >> (ptrs_bits * 2);
 		offsets[n++] = (i_block >> ptrs_bits) & (ptrs - 1);
 		offsets[n++] = i_block & (ptrs - 1);
+		final = ptrs;
 	} else {
 		ext2_warning (inode->i_sb, "ext2_block_to_path", "block > big");
 	}
+	if (boundary)
+		*boundary = (i_block & (ptrs - 1)) == (final - 1);
 	return n;
 }
 
@@ -506,7 +516,8 @@ static int ext2_get_block(struct inode *
 	Indirect *partial;
 	unsigned long goal;
 	int left;
-	int depth = ext2_block_to_path(inode, iblock, offsets);
+	int boundary = 0;
+	int depth = ext2_block_to_path(inode, iblock, offsets, &boundary);
 
 	if (depth == 0)
 		goto out;
@@ -518,6 +529,8 @@ reread:
 	if (!partial) {
 got_it:
 		map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
+		if (boundary)
+			set_buffer_boundary(bh_result);
 		/* Clean up and exit */
 		partial = chain+depth-1; /* the whole chain */
 		goto cleanup;
@@ -569,21 +582,37 @@ static int ext2_writepage(struct page *p
 {
 	return block_write_full_page(page,ext2_get_block);
 }
+
 static int ext2_readpage(struct file *file, struct page *page)
 {
-	return block_read_full_page(page,ext2_get_block);
+	return mpage_readpage(page, ext2_get_block);
 }
-static int ext2_prepare_write(struct file *file, struct page *page, unsigned from, unsigned to)
+
+static int
+ext2_readpages(struct address_space *mapping,
+		struct list_head *pages, unsigned nr_pages)
+{
+	return mpage_readpages(mapping, pages, nr_pages, ext2_get_block);
+}
+
+static int
+ext2_prepare_write(struct file *file, struct page *page,
+			unsigned from, unsigned to)
 {
 	return block_prepare_write(page,from,to,ext2_get_block);
 }
+
 static int ext2_bmap(struct address_space *mapping, long block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
-static int ext2_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+
+static int
+ext2_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
+			unsigned long blocknr, int blocksize)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext2_get_block);
+	return generic_direct_IO(rw, inode, iobuf, blocknr,
+				blocksize, ext2_get_block);
 }
 
 static int
@@ -600,15 +629,16 @@ ext2_writeback_mapping(struct address_sp
 }
 
 struct address_space_operations ext2_aops = {
-	readpage: ext2_readpage,
-	writepage: ext2_writepage,
-	sync_page: block_sync_page,
-	prepare_write: ext2_prepare_write,
-	commit_write: generic_commit_write,
-	bmap: ext2_bmap,
-	direct_IO: ext2_direct_IO,
-	writeback_mapping: ext2_writeback_mapping,
-	vm_writeback: generic_vm_writeback,
+	readpage:		ext2_readpage,
+	readpages:		ext2_readpages,
+	writepage:		ext2_writepage,
+	sync_page:		block_sync_page,
+	prepare_write:		ext2_prepare_write,
+	commit_write:		generic_commit_write,
+	bmap:			ext2_bmap,
+	direct_IO:		ext2_direct_IO,
+	writeback_mapping:	ext2_writeback_mapping,
+	vm_writeback:		generic_vm_writeback,
 };
 
 /*
@@ -818,7 +848,7 @@ void ext2_truncate (struct inode * inode
 
 	block_truncate_page(inode->i_mapping, inode->i_size, ext2_get_block);
 
-	n = ext2_block_to_path(inode, iblock, offsets);
+	n = ext2_block_to_path(inode, iblock, offsets, NULL);
 	if (n == 0)
 		return;
 
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.18-akpm/include/linux/mpage.h	Sun May 26 02:49:58 2002
@@ -0,0 +1,15 @@
+/*
+ * include/linux/mpage.h
+ *
+ * Contains declarations related to preparing and submitting BIOS which contain
+ * multiple pagecache pages.
+ */
+
+/*
+ * (And no, it doesn't do the #ifdef __MPAGE_H thing, and it doesn't do
+ * nested includes.  Get it right in the .c file).
+ */
+
+int mpage_readpages(struct address_space *mapping, struct list_head *pages,
+				unsigned nr_pages, get_block_t get_block);
+int mpage_readpage(struct page *page, get_block_t get_block);
--- 2.5.18/include/linux/fs.h~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/include/linux/fs.h	Sun May 26 02:41:04 2002
@@ -290,6 +290,9 @@ struct address_space_operations {
 	/* Set a page dirty */
 	int (*set_page_dirty)(struct page *page);
 
+	int (*readpages)(struct address_space *mapping,
+			struct list_head *pages, unsigned nr_pages);
+
 	/*
 	 * ext3 requires that a successful prepare_write() call be followed
 	 * by a commit_write() call - they must be balanced
--- 2.5.18/mm/readahead.c~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/mm/readahead.c	Sun May 26 02:31:25 2002
@@ -31,6 +31,25 @@ static inline unsigned long get_min_read
 	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 }
 
+static int
+read_pages(struct address_space *mapping,
+		struct list_head *pages, unsigned nr_pages)
+{
+	unsigned page_idx;
+
+	if (mapping->a_ops->readpages)
+		return mapping->a_ops->readpages(mapping, pages, nr_pages);
+
+	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+		struct page *page = list_entry(pages->prev, struct page, list);
+		list_del(&page->list);
+		if (!add_to_page_cache_unique(page, mapping, page->index))
+			mapping->a_ops->readpage(NULL, page);
+		page_cache_release(page);
+	}
+	return 0;
+}
+
 /*
  * Readahead design.
  *
@@ -148,24 +167,9 @@ void do_page_cache_readahead(struct file
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	for (page_idx = 0; page_idx < nr_to_really_read; page_idx++) {
-		if (list_empty(&page_pool))
-			BUG();
-		page = list_entry(page_pool.prev, struct page, list);
-		list_del(&page->list);
-		if (!add_to_page_cache_unique(page, mapping, page->index))
-			mapping->a_ops->readpage(file, page);
-		page_cache_release(page);
-	}
-
-	/*
-	 * Do this now, rather than at the next wait_on_page_locked().
-	 */
+	read_pages(mapping, &page_pool, nr_to_really_read);
 	run_task_queue(&tq_disk);
-
-	if (!list_empty(&page_pool))
-		BUG();
-
+	BUG_ON(!list_empty(&page_pool));
 	return;
 }
 
--- 2.5.18/Documentation/filesystems/Locking~mpage-read	Sun May 26 02:31:25 2002
+++ 2.5.18-akpm/Documentation/filesystems/Locking	Sun May 26 02:41:04 2002
@@ -148,6 +148,7 @@ locking rules:
 			BKL	PageLocked(page)
 writepage:		no	yes, unlocks
 readpage:		no	yes, unlocks
+readpages:		no
 sync_page:		no	maybe
 writeback_mapping:	no
 vm_writeback:		no	yes
@@ -164,6 +165,8 @@ may be called from the request handler (
 	->readpage() unlocks the page, either synchronously or via I/O
 completion.
 
+	->readpages() populates the pagecache with the passed pages and starts I/O against them.  They come unlocked upon I/O completion.
+
 	->writepage() unlocks the page synchronously, before returning to
 the caller.  If the page has write I/O underway against it, writepage()
 should run SetPageWriteback() against the page prior to unlocking it.

-
