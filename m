Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSFQHLA>; Mon, 17 Jun 2002 03:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316778AbSFQHK1>; Mon, 17 Jun 2002 03:10:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55054 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316836AbSFQHJc>;
	Mon, 17 Jun 2002 03:09:32 -0400
Message-ID: <3D0D8C1B.D14F5171@zip.com.au>
Date: Mon, 17 Jun 2002 00:13:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 10/19] direct-to-BIO I/O for swapcache pages
References: <3D0D873A.405ED0BB@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ..
> I have an
> additional patch which converts swap to use mpage_writepages(), so we swap
> out in 16-page BIOs.  It works fine, but I don't intend to submit that.
> There just doesn't seem to be any significant advantage to it.
> 

Just for the record, here is the patch which converts swap writeout to
use large BIOs (via mpage_writepages):


--- 2.5.21/fs/buffer.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/fs/buffer.c	Sat Jun 15 17:15:02 2002
@@ -397,7 +397,7 @@ __get_hash_table(struct block_device *bd
 	struct buffer_head *head;
 	struct page *page;
 
-	index = block >> (PAGE_CACHE_SHIFT - bd_inode->i_blkbits);
+	index = block >> (mapping_page_shift(bd_mapping) - bd_inode->i_blkbits);
 	page = find_get_page(bd_mapping, index);
 	if (!page)
 		goto out;
@@ -1667,7 +1667,7 @@ static int __block_write_full_page(struc
 	 * handle that here by just cleaning them.
 	 */
 
-	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	block = page->index << (page_shift(page) - inode->i_blkbits);
 	head = page_buffers(page);
 	bh = head;
 
@@ -1811,8 +1811,8 @@ static int __block_prepare_write(struct 
 	char *kaddr = kmap(page);
 
 	BUG_ON(!PageLocked(page));
-	BUG_ON(from > PAGE_CACHE_SIZE);
-	BUG_ON(to > PAGE_CACHE_SIZE);
+	BUG_ON(from > page_size(page));
+	BUG_ON(to > page_size(page));
 	BUG_ON(from > to);
 
 	blocksize = 1 << inode->i_blkbits;
@@ -1821,7 +1821,7 @@ static int __block_prepare_write(struct 
 	head = page_buffers(page);
 
 	bbits = inode->i_blkbits;
-	block = page->index << (PAGE_CACHE_SHIFT - bbits);
+	block = page->index << (page_shift(page) - bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
@@ -1966,8 +1966,8 @@ int block_read_full_page(struct page *pa
 		create_empty_buffers(page, blocksize, 0);
 	head = page_buffers(page);
 
-	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	blocks = page_size(page) >> inode->i_blkbits;
+	iblock = page->index << (page_shift(page) - inode->i_blkbits);
 	lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
 	bh = head;
 	nr = 0;
@@ -2054,7 +2054,7 @@ int generic_cont_expand(struct inode *in
 	if (size > inode->i_sb->s_maxbytes)
 		goto out;
 
-	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
+	offset = (size & (mapping_page_size(mapping) - 1)); /* Within page */
 
 	/* ugh.  in prepare/commit_write, if from==to==start of block, we 
 	** skip the prepare.  make sure we never send an offset for the start
@@ -2063,7 +2063,7 @@ int generic_cont_expand(struct inode *in
 	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
 		offset++;
 	}
-	index = size >> PAGE_CACHE_SHIFT;
+	index = size >> mapping_page_shift(mapping);
 	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
 	if (!page)
@@ -2097,31 +2097,31 @@ int cont_prepare_write(struct page *page
 	unsigned blocksize = 1 << inode->i_blkbits;
 	char *kaddr;
 
-	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {
+	while(page->index > (pgpos = *bytes>>page_shift(page))) {
 		status = -ENOMEM;
 		new_page = grab_cache_page(mapping, pgpos);
 		if (!new_page)
 			goto out;
 		/* we might sleep */
-		if (*bytes>>PAGE_CACHE_SHIFT != pgpos) {
+		if (*bytes>>page_shift(page) != pgpos) {
 			unlock_page(new_page);
 			page_cache_release(new_page);
 			continue;
 		}
-		zerofrom = *bytes & ~PAGE_CACHE_MASK;
+		zerofrom = *bytes & ~page_mask(page);
 		if (zerofrom & (blocksize-1)) {
 			*bytes |= (blocksize-1);
 			(*bytes)++;
 		}
 		status = __block_prepare_write(inode, new_page, zerofrom,
-						PAGE_CACHE_SIZE, get_block);
+						page_size(new_page), get_block);
 		if (status)
 			goto out_unmap;
 		kaddr = page_address(new_page);
-		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
+		memset(kaddr+zerofrom, 0, page_size(new_page)-zerofrom);
 		flush_dcache_page(new_page);
 		__block_commit_write(inode, new_page,
-				zerofrom, PAGE_CACHE_SIZE);
+				zerofrom, page_size(new_page));
 		kunmap(new_page);
 		unlock_page(new_page);
 		page_cache_release(new_page);
@@ -2132,7 +2132,7 @@ int cont_prepare_write(struct page *page
 		zerofrom = offset;
 	} else {
 		/* page covers the boundary, find the boundary offset */
-		zerofrom = *bytes & ~PAGE_CACHE_MASK;
+		zerofrom = *bytes & ~page_mask(page);
 
 		/* if we will expand the thing last block will be filled */
 		if (to > zerofrom && (zerofrom & (blocksize-1))) {
@@ -2192,7 +2192,7 @@ int generic_commit_write(struct file *fi
 		unsigned from, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
-	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+	loff_t pos = ((loff_t)page->index << page_shift(page)) + to;
 	__block_commit_write(inode,page,from,to);
 	kunmap(page);
 	if (pos > inode->i_size) {
@@ -2205,8 +2205,8 @@ int generic_commit_write(struct file *fi
 int block_truncate_page(struct address_space *mapping,
 			loff_t from, get_block_t *get_block)
 {
-	unsigned long index = from >> PAGE_CACHE_SHIFT;
-	unsigned offset = from & (PAGE_CACHE_SIZE-1);
+	unsigned long index = from >> mapping_page_shift(mapping);
+	unsigned offset = from & (mapping_page_size(mapping) - 1);
 	unsigned blocksize, iblock, length, pos;
 	struct inode *inode = mapping->host;
 	struct page *page;
@@ -2221,7 +2221,7 @@ int block_truncate_page(struct address_s
 		return 0;
 
 	length = blocksize - length;
-	iblock = index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	iblock = index << (mapping_page_shift(mapping) - inode->i_blkbits);
 	
 	page = grab_cache_page(mapping, index);
 	err = -ENOMEM;
@@ -2283,7 +2283,7 @@ out:
 int block_write_full_page(struct page *page, get_block_t *get_block)
 {
 	struct inode * const inode = page->mapping->host;
-	const unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	const unsigned long end_index = inode->i_size >> page_shift(page);
 	unsigned offset;
 	char *kaddr;
 
@@ -2292,7 +2292,7 @@ int block_write_full_page(struct page *p
 		return __block_write_full_page(inode, page, get_block);
 
 	/* Is the page fully outside i_size? (truncate in progress) */
-	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
+	offset = inode->i_size & (page_size(page) - 1);
 	if (page->index >= end_index+1 || !offset) {
 		unlock_page(page);
 		return -EIO;
@@ -2300,7 +2300,7 @@ int block_write_full_page(struct page *p
 
 	/* The page straddles i_size */
 	kaddr = kmap(page);
-	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
+	memset(kaddr + offset, 0, page_size(page) - offset);
 	flush_dcache_page(page);
 	kunmap(page);
 	return __block_write_full_page(inode, page, get_block);
--- 2.5.21/fs/mpage.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/fs/mpage.c	Sat Jun 15 17:15:02 2002
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/highmem.h>
@@ -22,7 +23,7 @@
 
 /*
  * The largest-sized BIO which this code will assemble, in bytes.  Set this
- * to PAGE_CACHE_SIZE if your drivers are broken.
+ * to PAGE_SIZE_MAX if your drivers are broken.
  */
 #define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
 
@@ -165,7 +166,7 @@ do_mpage_readpage(struct bio *bio, struc
 {
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
+	const unsigned blocks_per_page = page_size(page) >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	struct bio_vec *bvec;
 	sector_t block_in_file;
@@ -175,23 +176,24 @@ do_mpage_readpage(struct bio *bio, struc
 	unsigned page_block;
 	unsigned first_hole = blocks_per_page;
 	struct block_device *bdev = NULL;
-	struct buffer_head bh;
+	struct buffer_head map_bh;
 
 	if (page_has_buffers(page))
 		goto confused;
 
-	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
+	block_in_file = page->index << (page_shift(page) - blkbits);
 	last_file_block = (inode->i_size + blocksize - 1) >> blkbits;
+	map_bh.b_page = page;
 
 	for (page_block = 0; page_block < blocks_per_page;
 				page_block++, block_in_file++) {
-		bh.b_state = 0;
+		map_bh.b_state = 0;
 		if (block_in_file < last_file_block) {
-			if (get_block(inode, block_in_file, &bh, 0))
+			if (get_block(inode, block_in_file, &map_bh, 0))
 				goto confused;
 		}
 
-		if (!buffer_mapped(&bh)) {
+		if (!buffer_mapped(&map_bh)) {
 			if (first_hole == blocks_per_page)
 				first_hole = page_block;
 			continue;
@@ -202,18 +204,18 @@ do_mpage_readpage(struct bio *bio, struc
 
 		if (page_block) {
 			/* Contiguous blocks? */
-			if (bh.b_blocknr != last_page_block + 1)
+			if (map_bh.b_blocknr != last_page_block + 1)
 				goto confused;
 		} else {
-			first_page_block = bh.b_blocknr;
+			first_page_block = map_bh.b_blocknr;
 		}
-		last_page_block = bh.b_blocknr;
-		bdev = bh.b_bdev;
+		last_page_block = map_bh.b_blocknr;
+		bdev = map_bh.b_bdev;
 	}
 
 	if (first_hole != blocks_per_page) {
 		memset(kmap(page) + (first_hole << blkbits), 0,
-				PAGE_CACHE_SIZE - (first_hole << blkbits));
+				page_size(page) - (first_hole << blkbits));
 		flush_dcache_page(page);
 		kunmap(page);
 		if (first_hole == 0) {
@@ -231,7 +233,7 @@ do_mpage_readpage(struct bio *bio, struc
 		bio = mpage_bio_submit(READ, bio);
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / page_size(page);
 
 		if (nr_bvecs > nr_pages)
 			nr_bvecs = nr_pages;
@@ -246,7 +248,7 @@ do_mpage_readpage(struct bio *bio, struc
 	bvec->bv_len = (first_hole << blkbits);
 	bvec->bv_offset = 0;
 	bio->bi_size += bvec->bv_len;
-	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
+	if (buffer_boundary(&map_bh) || (first_hole != blocks_per_page))
 		bio = mpage_bio_submit(READ, bio);
 	else
 		*last_block_in_bio = last_page_block;
@@ -324,7 +326,7 @@ mpage_writepage(struct bio *bio, struct 
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
 	unsigned long end_index;
-	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
+	const unsigned blocks_per_page = page_size(page) >> blkbits;
 	struct bio_vec *bvec;
 	sector_t last_file_block;
 	sector_t block_in_file;
@@ -387,13 +389,14 @@ mpage_writepage(struct bio *bio, struct 
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!PageUptodate(page));
-	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
+	block_in_file = page->index << (page_shift(page) - blkbits);
 	last_file_block = (inode->i_size - 1) >> blkbits;
 	for (page_block = 0; page_block < blocks_per_page;
 				page_block++, block_in_file++) {
 		struct buffer_head map_bh;
 
 		map_bh.b_state = 0;
+		map_bh.b_page = page;
 		if (get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
 		if (buffer_new(&map_bh))
@@ -416,13 +419,13 @@ mpage_writepage(struct bio *bio, struct 
 
 	first_unmapped = page_block;
 
-	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	end_index = inode->i_size >> page_shift(page);
 	if (page->index >= end_index) {
-		unsigned offset = inode->i_size & (PAGE_CACHE_SIZE - 1);
+		unsigned offset = inode->i_size & (page_size(page) - 1);
 
 		if (page->index > end_index || !offset)
 			goto confused;
-		memset(kmap(page) + offset, 0, PAGE_CACHE_SIZE - offset);
+		memset(kmap(page) + offset, 0, page_size(page) - offset);
 		flush_dcache_page(page);
 		kunmap(page);
 	}
@@ -431,13 +434,17 @@ page_is_mapped:
 
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
+	 * Check for changed bdev - swapper_space striping does this.
 	 */
-	if (bio && (bio->bi_idx == bio->bi_vcnt ||
-				*last_block_in_bio != first_page_block - 1))
-		bio = mpage_bio_submit(WRITE, bio);
+	if (bio) {
+		if ((bio->bi_idx == bio->bi_vcnt) ||
+				(*last_block_in_bio != first_page_block - 1) ||
+				(bio->bi_bdev != bdev))
+			bio = mpage_bio_submit(WRITE, bio);
+	}
 
 	if (bio == NULL) {
-		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
+		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / page_size(page);
 
 		bio = mpage_alloc(bdev, first_page_block << (blkbits - 9),
 					nr_bvecs, GFP_NOFS);
--- 2.5.21/include/linux/pagemap.h~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/include/linux/pagemap.h	Sat Jun 15 17:15:02 2002
@@ -22,6 +22,12 @@
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
+#if PAGE_SIZE > PAGE_CACHE_SIZE
+#define PAGE_SIZE_MAX PAGE_SIZE
+#else
+#define PAGE_SIZE_MAX PAGE_CACHE_SIZE
+#endif
+
 #define page_cache_get(x)	get_page(x)
 extern void page_cache_release(struct page *);
 
@@ -97,5 +103,35 @@ static inline void wait_on_page_writebac
 		wait_on_page_bit(page, PG_writeback);
 }
 
+static inline unsigned mapping_page_size(struct address_space *mapping)
+{
+	return (mapping == &swapper_space) ? PAGE_SIZE : PAGE_CACHE_SIZE;
+}
+
+static inline unsigned mapping_page_shift(struct address_space *mapping)
+{
+	return (mapping == &swapper_space) ? PAGE_SHIFT : PAGE_CACHE_SHIFT;
+}
+
+static inline unsigned mapping_page_mask(struct address_space *mapping)
+{
+	return (mapping == &swapper_space) ? PAGE_MASK : PAGE_CACHE_MASK;
+}
+
+static inline unsigned page_size(struct page *page)
+{
+	return mapping_page_size(page->mapping);
+}
+
+static inline unsigned page_shift(struct page *page)
+{
+	return mapping_page_shift(page->mapping);
+}
+
+static inline unsigned page_mask(struct page *page)
+{
+	return mapping_page_mask(page->mapping);
+}
+
 extern void end_page_writeback(struct page *page);
 #endif /* _LINUX_PAGEMAP_H */
--- 2.5.21/mm/page_io.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/mm/page_io.c	Sat Jun 15 17:15:03 2002
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/bio.h>
+#include <linux/mpage.h>
 #include <linux/buffer_head.h>
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -35,6 +36,32 @@ swap_get_block(struct inode *inode, sect
 	return 0;
 }
 
+/*
+ * swap_write_get_block() is for use by mpage_writepages().  If it sees a stale
+ * swapcache page (which doesn't need writing), swap_write_get_block() will
+ * return "failure".  This causes mpage_writepages() to send off its current
+ * BIO and to fall back to swap_writepage().  Which can simply unlock the page.
+ */
+static int
+swap_write_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh_result, int create)
+{
+	if (remove_exclusive_swap_page(bh_result->b_page))
+		return -1;
+	return swap_get_block(inode, iblock, bh_result, create);
+}
+
+/*
+ * We may have stale swap cache pages in memory: notice them here and get
+ * rid of the unnecessary final write.
+ */
+static int swap_writepage(struct page *page)
+{
+	printk("swap_writepage\n");
+	unlock_page(page);
+	return 0;
+}
+
 static struct bio *
 get_swap_bio(int gfp_flags, struct page *page, bio_end_io_t end_io)
 {
@@ -57,17 +84,6 @@ get_swap_bio(int gfp_flags, struct page 
 	return bio;
 }
 
-static void end_swap_bio_write(struct bio *bio)
-{
-	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
-	struct page *page = bio->bi_io_vec[0].bv_page;
-
-	if (!uptodate)
-		SetPageError(page);
-	end_page_writeback(page);
-	bio_put(bio);
-}
-
 static void end_swap_bio_read(struct bio *bio)
 {
 	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
@@ -83,32 +99,6 @@ static void end_swap_bio_read(struct bio
 	bio_put(bio);
 }
 
-/*
- * We may have stale swap cache pages in memory: notice
- * them here and get rid of the unnecessary final write.
- */
-static int swap_writepage(struct page *page)
-{
-	struct bio *bio;
-	int ret = 0;
-
-	if (remove_exclusive_swap_page(page)) {
-		unlock_page(page);
-		goto out;
-	}
-	bio = get_swap_bio(GFP_NOFS, page, end_swap_bio_write);
-	if (bio == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	kstat.pswpout++;
-	SetPageWriteback(page);
-	unlock_page(page);
-	submit_bio(WRITE, bio);
-out:
-	return ret;
-}
-
 int swap_readpage(struct file *file, struct page *page)
 {
 	struct bio *bio;
@@ -125,30 +115,75 @@ int swap_readpage(struct file *file, str
 out:
 	return ret;
 }
+
+static int swap_writepages(struct address_space *mapping, int *nr_to_write)
+{
+	int to_write = *nr_to_write;
+	int ret;
+
+	ret = mpage_writepages(mapping, nr_to_write, swap_write_get_block);
+	kstat.pswpout += to_write - *nr_to_write;
+	return ret;
+}
+
 /*
  * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
  * so we don't need swap special cases in generic_vm_writeback().
  *
- * Swap pages are PageLocked and PageWriteback while under writeout so that
- * memory allocators will throttle against them.
+ * Swap pages are PageWriteback while under writeout so that memory allocators
+ * will throttle against them.
  */
 static int swap_vm_writeback(struct page *page, int *nr_to_write)
 {
-	struct address_space *mapping = page->mapping;
-
 	unlock_page(page);
-	return generic_writepages(mapping, nr_to_write);
+	return swap_writepages(page->mapping, nr_to_write);
 }
 
 struct address_space_operations swap_aops = {
 	vm_writeback:	swap_vm_writeback,
 	writepage:	swap_writepage,
+	writepages:	swap_writepages,
 	readpage:	swap_readpage,
 	sync_page:	block_sync_page,
 	set_page_dirty:	__set_page_dirty_nobuffers,
 };
 
 /*
+ * Primitive swap readahead code. We simply read an aligned block of
+ * (1 << page_cluster) entries in the swap area. This method is chosen
+ * because it doesn't cost us any seek time.  We also make sure to queue
+ * the 'original' request together with the readahead ones...
+ *
+ * Readahead is performed against a single device.  Which is perhaps suboptimal
+ * when striped swap is being used.  But given that swap uses a one meg chunk
+ * size for striping, chances are that readahead is reading the right pages.
+ *
+ * It would be possible to use mpage and the generic readahead code here.
+ * We'd have to clone mpage_readpages because add_to_swap_cache() does special
+ * things.  Doubtful if all this would help much, really.
+ */
+void swapin_readahead(swp_entry_t entry)
+{
+	int i, num;
+	unsigned long offset;
+
+	/*
+	 * Get the number of handles we should do readahead io to.
+	 */
+	num = valid_swaphandles(entry, &offset);
+	for (i = 0; i < num; offset++, i++) {
+		struct page *new_page;
+		swp_entry_t ra_entry;
+
+		ra_entry = swp_entry(swp_type(entry), offset);
+		new_page = read_swap_cache_async(ra_entry);
+		if (!new_page)
+			break;
+		page_cache_release(new_page);
+	}
+}
+
+/*
  * A scruffy utility function to read or write an arbitrary swap page
  * and wait on the I/O.
  */
--- 2.5.21/mm/swap_state.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/mm/swap_state.c	Sat Jun 15 17:15:03 2002
@@ -8,13 +8,11 @@
  */
 
 #include <linux/mm.h>
-#include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>	/* block_sync_page() */
 
 #include <asm/pgtable.h>
 
@@ -124,7 +122,7 @@ void delete_from_swap_cache(struct page 
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	BUG_ON(page_has_buffers(page));
+	BUG_ON(PagePrivate(page));
   
 	entry.val = page->index;
 
@@ -192,7 +190,7 @@ int move_from_swap_cache(struct page *pa
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	BUG_ON(page_has_buffers(page));
+	BUG_ON(PagePrivate(page));
 
 	write_lock(&swapper_space.page_lock);
 	write_lock(&mapping->page_lock);
--- 2.5.21/mm/swapfile.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/mm/swapfile.c	Sat Jun 15 17:15:03 2002
@@ -37,6 +37,11 @@ struct swap_info_struct swap_info[MAX_SW
 
 #define SWAPFILE_CLUSTER 256
 
+/*
+ * Switch to a new device after this many pages
+ */
+#define SWAP_STRIPE_PAGES	((1024*1024)/PAGE_SIZE)
+
 static inline int scan_swap_map(struct swap_info_struct *si)
 {
 	unsigned long offset;
@@ -47,7 +52,8 @@ static inline int scan_swap_map(struct s
 	 * first-free allocation, starting a new cluster.  This
 	 * prevents us from scattering swap pages all over the entire
 	 * swap partition, so that we reduce overall disk seek times
-	 * between swap pages.  -- sct */
+	 * between swap pages.  -- sct
+	 */
 	if (si->cluster_nr) {
 		while (si->cluster_next <= si->highest_bit) {
 			offset = si->cluster_next++;
@@ -59,29 +65,35 @@ static inline int scan_swap_map(struct s
 	}
 	si->cluster_nr = SWAPFILE_CLUSTER;
 
-	/* try to find an empty (even not aligned) cluster. */
+	/*
+	 * Try to find an empty (even not aligned) cluster
+	 */
 	offset = si->lowest_bit;
- check_next_cluster:
-	if (offset+SWAPFILE_CLUSTER-1 <= si->highest_bit)
-	{
+
+check_next_cluster:
+	if (offset + SWAPFILE_CLUSTER - 1 <= si->highest_bit) {
 		int nr;
-		for (nr = offset; nr < offset+SWAPFILE_CLUSTER; nr++)
-			if (si->swap_map[nr])
-			{
-				offset = nr+1;
+
+		for (nr = offset; nr < offset + SWAPFILE_CLUSTER; nr++) {
+			if (si->swap_map[nr]) {
+				offset = nr + 1;
 				goto check_next_cluster;
 			}
-		/* We found a completly empty cluster, so start
-		 * using it.
+		}
+
+		/*
+		 * We found a completly empty cluster, so start using it.
 		 */
 		goto got_page;
 	}
-	/* No luck, so now go finegrined as usual. -Andrea */
-	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
+	/*
+	 * No luck, so now go finegrained as usual. -Andrea
+	 */
+	for (offset = si->lowest_bit; offset <= si->highest_bit; offset++) {
 		if (si->swap_map[offset])
 			continue;
 		si->lowest_bit = offset+1;
-	got_page:
+got_page:
 		if (offset == si->lowest_bit)
 			si->lowest_bit++;
 		if (offset == si->highest_bit)
@@ -92,7 +104,7 @@ static inline int scan_swap_map(struct s
 		}
 		si->swap_map[offset] = 1;
 		nr_swap_pages--;
-		si->cluster_next = offset+1;
+		si->cluster_next = offset + 1;
 		return offset;
 	}
 	si->lowest_bit = si->max;
@@ -100,9 +112,11 @@ static inline int scan_swap_map(struct s
 	return 0;
 }
 
+int akpm;
+
 swp_entry_t get_swap_page(void)
 {
-	struct swap_info_struct * p;
+	struct swap_info_struct *p;
 	unsigned long offset;
 	swp_entry_t entry;
 	int type, wrapped = 0;
@@ -122,11 +136,27 @@ swp_entry_t get_swap_page(void)
 			offset = scan_swap_map(p);
 			swap_device_unlock(p);
 			if (offset) {
-				entry = swp_entry(type,offset);
+				static int stripe;
+
+				entry = swp_entry(type, offset);
+
+				/*
+				 * Keep using the same device for a decent
+				 * number of pages so that we can build nice
+				 * big BIOs against it.
+				 */
+				if (stripe++ < SWAP_STRIPE_PAGES)
+					goto out;
+				stripe = 0;
+
+				/*
+				 * Select the next swapdevice.  Stripe across
+				 * devices if the priorities are equal.
+				 */
 				type = swap_info[type].next;
 				if (type < 0 ||
 					p->prio != swap_info[type].prio) {
-						swap_list.next = swap_list.head;
+					swap_list.next = swap_list.head;
 				} else {
 					swap_list.next = type;
 				}
@@ -139,12 +169,15 @@ swp_entry_t get_swap_page(void)
 				type = swap_list.head;
 				wrapped = 1;
 			}
-		} else
+		} else {
 			if (type < 0)
 				goto out;	/* out of swap space */
+		}
 	}
 out:
 	swap_list_unlock();
+	if (akpm)
+		printk("%d:%lu\n", swp_type(entry), swp_offset(entry));
 	return entry;
 }
 
--- 2.5.21/mm/memory.c~swap-mpage-write	Sat Jun 15 17:15:02 2002
+++ 2.5.21-akpm/mm/memory.c	Sat Jun 15 17:15:03 2002
@@ -1112,32 +1112,6 @@ out:
 	return 0;
 }
 
-/* 
- * Primitive swap readahead code. We simply read an aligned block of
- * (1 << page_cluster) entries in the swap area. This method is chosen
- * because it doesn't cost us any seek time.  We also make sure to queue
- * the 'original' request together with the readahead ones...  
- */
-void swapin_readahead(swp_entry_t entry)
-{
-	int i, num;
-	struct page *new_page;
-	unsigned long offset;
-
-	/*
-	 * Get the number of handles we should do readahead io to.
-	 */
-	num = valid_swaphandles(entry, &offset);
-	for (i = 0; i < num; offset++, i++) {
-		/* Ok, do the async read-ahead now */
-		new_page = read_swap_cache_async(swp_entry(swp_type(entry), offset));
-		if (!new_page)
-			break;
-		page_cache_release(new_page);
-	}
-	return;
-}
-
 /*
  * We hold the mm semaphore and the page_table_lock on entry and
  * should release the pagetable lock on exit..

-
