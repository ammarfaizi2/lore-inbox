Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSEZUlw>; Sun, 26 May 2002 16:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSEZUkr>; Sun, 26 May 2002 16:40:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46608 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316393AbSEZUjs>;
	Sun, 26 May 2002 16:39:48 -0400
Message-ID: <3CF148CE.DA4EA320@zip.com.au>
Date: Sun, 26 May 2002 13:42:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 8/18] direct-to-BIO writeback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Multipage BIO writeout from the pagecache.

It's pretty much the same as multipage reads.  It falls back to buffers
if things got complex.

The write case is a little more complex because it handles pages which
have buffers and pages which do not.  If the page didn't have buffers
this code does not add them.


=====================================

--- 2.5.18/fs/mpage.c~mpage-write	Sun May 26 02:51:21 2002
+++ 2.5.18-akpm/fs/mpage.c	Sun May 26 02:51:31 2002
@@ -60,11 +60,31 @@ static void mpage_end_io_read(struct bio
 	bio_put(bio);
 }
 
+static void mpage_end_io_write(struct bio *bio)
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
+		if (!uptodate)
+			SetPageError(page);
+		end_page_writeback(page);
+	} while (bvec >= bio->bi_io_vec);
+	bio_put(bio);
+}
+
 struct bio *mpage_bio_submit(int rw, struct bio *bio)
 {
 	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
 	bio->bi_end_io = mpage_end_io_read;
+	if (rw == WRITE)
+		bio->bi_end_io = mpage_end_io_write;
 	submit_bio(rw, bio);
 	return NULL;
 }
@@ -270,3 +290,258 @@ int mpage_readpage(struct page *page, ge
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
+
+/*
+ * Writing is not so simple.
+ *
+ * If the page has buffers then they will be used for obtaining the disk
+ * mapping.  We only support pages which are fully mapped-and-dirty, with a
+ * special case for pages which are unmapped at the end: end-of-file.
+ *
+ * If the page has no buffers (preferred) then the page is mapped here.
+ *
+ * If all blocks are found to be contiguous then the page can go into the
+ * BIO.  Otherwise fall back to block_write_full_page().
+ * 
+ * FIXME: This code wants an estimate of how many pages are still to be
+ * written, so it can intelligently allocate a suitably-sized BIO.  For now,
+ * just allocate full-size (16-page) BIOs.
+ */
+static /* inline */ struct bio *
+mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
+			sector_t *last_block_in_bio, int *ret)
+{
+	struct inode *inode = page->mapping->host;
+	const unsigned blkbits = inode->i_blkbits;
+	unsigned long end_index;
+	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
+	struct bio_vec *bvec;
+	sector_t last_block;
+	sector_t block_in_file;
+	sector_t blocks[MAX_BUF_PER_PAGE];
+	unsigned page_block;
+	unsigned first_unmapped = blocks_per_page;
+	struct block_device *bdev = NULL;
+	int boundary = 0;
+
+	if (page_has_buffers(page)) {
+		struct buffer_head *head = page_buffers(page);
+		struct buffer_head *bh = head;
+
+		/* If they're all mapped and dirty, do it */
+		page_block = 0;
+		do {
+			BUG_ON(buffer_locked(bh));
+			if (!buffer_mapped(bh)) {
+				/*
+				 * unmapped dirty buffers are created by
+				 * __set_page_dirty_buffers -> mmapped data
+				 */
+				if (buffer_dirty(bh))
+					goto confused;
+				if (first_unmapped == blocks_per_page)
+					first_unmapped = page_block;
+				continue;
+			}
+
+			if (first_unmapped != blocks_per_page)
+				goto confused;	/* hole -> non-hole */
+
+			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
+				goto confused;
+			if (page_block) {
+				if (bh->b_blocknr != blocks[page_block-1] + 1)
+					goto confused;
+			}
+			blocks[page_block++] = bh->b_blocknr;
+			boundary = buffer_boundary(bh);
+			bdev = bh->b_bdev;
+		} while ((bh = bh->b_this_page) != head);
+
+		if (first_unmapped)
+			goto page_is_mapped;
+
+		/*
+		 * Page has buffers, but they are all unmapped. The page was
+		 * created by pagein or read over a hole which was handled by
+		 * block_read_full_page().  If this address_space is also
+		 * using mpage_readpages then this can rarely happen.
+		 */
+		goto confused;
+	}
+
+	/*
+	 * The page has no buffers: map it to disk
+	 */
+	BUG_ON(!PageUptodate(page));
+	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
+	last_block = (inode->i_size - 1) >> blkbits;
+	for (page_block = 0; page_block < blocks_per_page; ) {
+		struct buffer_head map_bh;
+
+		map_bh.b_state = 0;
+		if (get_block(inode, block_in_file, &map_bh, 1))
+			goto confused;
+		if (buffer_new(&map_bh))
+			unmap_underlying_metadata(map_bh.b_bdev,
+						map_bh.b_blocknr);
+		if (page_block) {
+			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
+				goto confused;
+		}
+		blocks[page_block++] = map_bh.b_blocknr;
+		boundary = buffer_boundary(&map_bh);
+		bdev = map_bh.b_bdev;
+		if (block_in_file == last_block)
+			break;
+		block_in_file++;
+	}
+	if (page_block == 0)
+		buffer_error();
+
+	first_unmapped = page_block;
+
+	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	if (page->index >= end_index) {
+		unsigned offset = inode->i_size & (PAGE_CACHE_SIZE - 1);
+
+		if (page->index > end_index || !offset)
+			goto confused;
+		memset(kmap(page) + offset, 0, PAGE_CACHE_SIZE - offset);
+		flush_dcache_page(page);
+		kunmap(page);
+	}
+
+page_is_mapped:
+
+	/*
+	 * This page will go to BIO.  Do we need to send this BIO off first?
+	 */
+	if (bio && (bio->bi_idx == bio->bi_vcnt ||
+				*last_block_in_bio != blocks[0] - 1))
+		bio = mpage_bio_submit(WRITE, bio);
+
+	if (bio == NULL) {
+		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+
+		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
+					nr_bvecs, GFP_NOFS);
+		if (bio == NULL)
+			goto confused;
+	}
+
+	/*
+	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
+	 * sure to only clean buffers which we know we'll be writing.
+	 */
+	if (page_has_buffers(page)) {
+		struct buffer_head *head = page_buffers(page);
+		struct buffer_head *bh = head;
+		unsigned buffer_counter = 0;
+
+		do {
+			if (buffer_counter++ == first_unmapped)
+				break;
+			clear_buffer_dirty(bh);
+			bh = bh->b_this_page;
+		} while (bh != head);
+	}
+
+	bvec = &bio->bi_io_vec[bio->bi_idx++];
+	bvec->bv_page = page;
+	bvec->bv_len = (first_unmapped << blkbits);
+	bvec->bv_offset = 0;
+	bio->bi_size += bvec->bv_len;
+	BUG_ON(PageWriteback(page));
+	SetPageWriteback(page);
+	unlock_page(page);
+	if (boundary || (first_unmapped != blocks_per_page))
+		bio = mpage_bio_submit(WRITE, bio);
+	else
+		*last_block_in_bio = blocks[blocks_per_page - 1];
+	goto out;
+
+confused:
+	if (bio)
+		bio = mpage_bio_submit(WRITE, bio);
+	*ret = block_write_full_page(page, get_block);
+out:
+	return bio;
+}
+
+/*
+ * This is a cut-n-paste of generic_writeback_mapping().  We _could_
+ * generalise that function.  It'd get a bit messy.  We'll see.
+ */
+int
+mpage_writeback_mapping(struct address_space *mapping,
+			int *nr_to_write, get_block_t get_block)
+{
+	struct bio *bio = NULL;
+	sector_t last_block_in_bio = 0;
+	int ret = 0;
+	int done = 0;
+
+	write_lock(&mapping->page_lock);
+
+	list_splice(&mapping->dirty_pages, &mapping->io_pages);
+	INIT_LIST_HEAD(&mapping->dirty_pages);
+
+        while (!list_empty(&mapping->io_pages) && !done) {
+		struct page *page = list_entry(mapping->io_pages.prev,
+					struct page, list);
+		list_del(&page->list);
+		if (PageWriteback(page)) {
+			if (PageDirty(page)) {
+				list_add(&page->list, &mapping->dirty_pages);
+				continue;
+			}
+			list_add(&page->list, &mapping->locked_pages);
+			continue;
+		}
+		if (!PageDirty(page)) {
+			list_add(&page->list, &mapping->clean_pages);
+			continue;
+		}
+		list_add(&page->list, &mapping->locked_pages);
+
+		page_cache_get(page);
+		write_unlock(&mapping->page_lock);
+
+		lock_page(page);
+
+		if (page->mapping && TestClearPageDirty(page) &&
+					!PageWriteback(page)) {
+			/* FIXME: batch this up */
+			if (!PageActive(page) && PageLRU(page)) {
+				spin_lock(&pagemap_lru_lock);
+				if (!PageActive(page) && PageLRU(page)) {
+					list_del(&page->lru);
+					list_add(&page->lru, &inactive_list);
+				}
+				spin_unlock(&pagemap_lru_lock);
+			}
+			bio = mpage_writepage(bio, page, get_block,
+					&last_block_in_bio, &ret);
+			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
+				done = 1;
+		} else {
+			unlock_page(page);
+		}
+
+		page_cache_release(page);
+		write_lock(&mapping->page_lock);
+	}
+	if (!list_empty(&mapping->io_pages)) {
+		/*
+		 * Put the rest back, in the correct order.
+		 */
+		list_splice(&mapping->io_pages, mapping->dirty_pages.prev);
+		INIT_LIST_HEAD(&mapping->io_pages);
+	}
+	write_unlock(&mapping->page_lock);
+	if (bio)
+		mpage_bio_submit(WRITE, bio);
+	return ret;
+}
+EXPORT_SYMBOL(mpage_writeback_mapping);
--- 2.5.18/include/linux/mpage.h~mpage-write	Sun May 26 02:51:21 2002
+++ 2.5.18-akpm/include/linux/mpage.h	Sun May 26 02:51:25 2002
@@ -13,3 +13,6 @@
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
+int mpage_writeback_mapping(struct address_space *mapping,
+		int *nr_to_write, get_block_t get_block);
+
--- 2.5.18/fs/ext2/inode.c~mpage-write	Sun May 26 02:51:21 2002
+++ 2.5.18-akpm/fs/ext2/inode.c	Sun May 26 02:51:25 2002
@@ -622,7 +622,7 @@ ext2_writeback_mapping(struct address_sp
 	int err;
 
 	ret = write_mapping_buffers(mapping);
-	err = generic_writeback_mapping(mapping, nr_to_write);
+	err = mpage_writeback_mapping(mapping, nr_to_write, ext2_get_block);
 	if (!ret)
 		ret = err;
 	return ret;
--- 2.5.18/include/linux/buffer_head.h~mpage-write	Sun May 26 02:51:21 2002
+++ 2.5.18-akpm/include/linux/buffer_head.h	Sun May 26 02:51:25 2002
@@ -162,6 +162,7 @@ int inode_has_buffers(struct inode *);
 void invalidate_inode_buffers(struct inode *);
 int fsync_buffers_list(spinlock_t *lock, struct list_head *);
 int sync_mapping_buffers(struct address_space *mapping);
+void unmap_underlying_metadata(struct block_device *bdev, sector_t block);
 
 void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
--- 2.5.18/fs/buffer.c~mpage-write	Sun May 26 02:51:21 2002
+++ 2.5.18-akpm/fs/buffer.c	Sun May 26 02:51:25 2002
@@ -1448,11 +1448,11 @@ EXPORT_SYMBOL(create_empty_buffers);
  * wait on that I/O in bforget() - it's more efficient to wait on the I/O
  * only if we really need to.  That happens here.
  */
-static void unmap_underlying_metadata(struct buffer_head *bh)
+void unmap_underlying_metadata(struct block_device *bdev, sector_t block)
 {
 	struct buffer_head *old_bh;
 
-	old_bh = __get_hash_table(bh->b_bdev, bh->b_blocknr, 0);
+	old_bh = __get_hash_table(bdev, block, 0);
 	if (old_bh) {
 #if 0	/* This happens.  Later. */
 		if (buffer_dirty(old_bh))
@@ -1548,7 +1548,8 @@ static int __block_write_full_page(struc
 			if (buffer_new(bh)) {
 				/* blockdev mappings never come here */
 				clear_buffer_new(bh);
-				unmap_underlying_metadata(bh);
+				unmap_underlying_metadata(bh->b_bdev,
+							bh->b_blocknr);
 			}
 		}
 		bh = bh->b_this_page;
@@ -1689,7 +1690,8 @@ static int __block_prepare_write(struct 
 				goto out;
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
-				unmap_underlying_metadata(bh);
+				unmap_underlying_metadata(bh->b_bdev,
+							bh->b_blocknr);
 				if (PageUptodate(page)) {
 					if (!buffer_mapped(bh))
 						buffer_error();
@@ -2191,7 +2193,8 @@ int generic_direct_IO(int rw, struct ino
 			}
 		} else {
 			if (buffer_new(&bh))
-				unmap_underlying_metadata(&bh);
+				unmap_underlying_metadata(bh.b_bdev,
+							bh.b_blocknr);
 			if (!buffer_mapped(&bh))
 				BUG();
 		}

-
