Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWGJLPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWGJLPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGJLPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:15:32 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:15311 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751353AbWGJLPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:15:02 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 6/9] -Wshadow: 'map_bh' and 'wbc' shadow fixes
Date: Mon, 10 Jul 2006 13:13:08 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101313.08607.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fixes for the following -Wshadow warnings :

  fs/buffer.c:2377: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/mpage.c:177: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/mpage.c:393: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/mpage.c:431: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/mpage.c:479: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/mpage.c:706: warning: declaration of 'wbc' shadows a parameter
  fs/mpage.c:699: warning: shadowed declaration is here
  fs/direct-io.c:515: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here
  fs/direct-io.c:802: warning: declaration of 'map_bh' shadows a global declaration
  include/linux/buffer_head.h:279: warning: shadowed declaration is here


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/buffer.c    |   28 +++++++--------
 fs/direct-io.c |   24 ++++++-------
 fs/mpage.c     |   84 +++++++++++++++++++++++------------------------
 3 files changed, 68 insertions(+), 68 deletions(-)

--- linux-2.6.18-rc1-orig/fs/buffer.c	2006-07-06 19:39:47.000000000 +0200
+++ linux-2.6.18-rc1/fs/buffer.c	2006-07-09 20:53:26.000000000 +0200
@@ -2374,7 +2374,7 @@ int nobh_prepare_write(struct page *page
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocksize = 1 << blkbits;
-	struct buffer_head map_bh;
+	struct buffer_head bh_map;
 	struct buffer_head *read_bh[MAX_BUF_PER_PAGE];
 	unsigned block_in_page;
 	unsigned block_start;
@@ -2390,7 +2390,7 @@ int nobh_prepare_write(struct page *page
 		return 0;
 
 	block_in_file = (sector_t)page->index << (PAGE_CACHE_SHIFT - blkbits);
-	map_bh.b_page = page;
+	bh_map.b_page = page;
 
 	/*
 	 * We loop across all blocks in the page, whether or not they are
@@ -2403,23 +2403,23 @@ int nobh_prepare_write(struct page *page
 		unsigned block_end = block_start + blocksize;
 		int create;
 
-		map_bh.b_state = 0;
+		bh_map.b_state = 0;
 		create = 1;
 		if (block_start >= to)
 			create = 0;
-		map_bh.b_size = blocksize;
+		bh_map.b_size = blocksize;
 		ret = get_block(inode, block_in_file + block_in_page,
-					&map_bh, create);
+					&bh_map, create);
 		if (ret)
 			goto failed;
-		if (!buffer_mapped(&map_bh))
+		if (!buffer_mapped(&bh_map))
 			is_mapped_to_disk = 0;
-		if (buffer_new(&map_bh))
-			unmap_underlying_metadata(map_bh.b_bdev,
-							map_bh.b_blocknr);
+		if (buffer_new(&bh_map))
+			unmap_underlying_metadata(bh_map.b_bdev,
+							bh_map.b_blocknr);
 		if (PageUptodate(page))
 			continue;
-		if (buffer_new(&map_bh) || !buffer_mapped(&map_bh)) {
+		if (buffer_new(&bh_map) || !buffer_mapped(&bh_map)) {
 			kaddr = kmap_atomic(page, KM_USER0);
 			if (block_start < from) {
 				memset(kaddr+block_start, 0, from-block_start);
@@ -2433,7 +2433,7 @@ int nobh_prepare_write(struct page *page
 			kunmap_atomic(kaddr, KM_USER0);
 			continue;
 		}
-		if (buffer_uptodate(&map_bh))
+		if (buffer_uptodate(&bh_map))
 			continue;	/* reiserfs does this */
 		if (block_start < from || block_end > to) {
 			struct buffer_head *bh = alloc_buffer_head(GFP_NOFS);
@@ -2442,14 +2442,14 @@ int nobh_prepare_write(struct page *page
 				ret = -ENOMEM;
 				goto failed;
 			}
-			bh->b_state = map_bh.b_state;
+			bh->b_state = bh_map.b_state;
 			atomic_set(&bh->b_count, 0);
 			bh->b_this_page = NULL;
 			bh->b_page = page;
-			bh->b_blocknr = map_bh.b_blocknr;
+			bh->b_blocknr = bh_map.b_blocknr;
 			bh->b_size = blocksize;
 			bh->b_data = (char *)(long)block_start;
-			bh->b_bdev = map_bh.b_bdev;
+			bh->b_bdev = bh_map.b_bdev;
 			bh->b_private = NULL;
 			read_bh[nr_reads++] = bh;
 		}
--- linux-2.6.18-rc1-orig/fs/mpage.c	2006-07-06 19:39:47.000000000 +0200
+++ linux-2.6.18-rc1/fs/mpage.c	2006-07-09 20:54:33.000000000 +0200
@@ -174,7 +174,7 @@ map_buffer_to_page(struct page *page, st
  */
 static struct bio *
 do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
-		sector_t *last_block_in_bio, struct buffer_head *map_bh,
+		sector_t *last_block_in_bio, struct buffer_head *bh_map,
 		unsigned long *first_logical_block, get_block_t get_block)
 {
 	struct inode *inode = page->mapping->host;
@@ -206,49 +206,49 @@ do_mpage_readpage(struct bio *bio, struc
 	/*
 	 * Map blocks using the result from the previous get_blocks call first.
 	 */
-	nblocks = map_bh->b_size >> blkbits;
-	if (buffer_mapped(map_bh) && block_in_file > *first_logical_block &&
+	nblocks = bh_map->b_size >> blkbits;
+	if (buffer_mapped(bh_map) && block_in_file > *first_logical_block &&
 			block_in_file < (*first_logical_block + nblocks)) {
 		unsigned map_offset = block_in_file - *first_logical_block;
 		unsigned last = nblocks - map_offset;
 
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == last) {
-				clear_buffer_mapped(map_bh);
+				clear_buffer_mapped(bh_map);
 				break;
 			}
 			if (page_block == blocks_per_page)
 				break;
-			blocks[page_block] = map_bh->b_blocknr + map_offset +
+			blocks[page_block] = bh_map->b_blocknr + map_offset +
 						relative_block;
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_map->b_bdev;
 	}
 
 	/*
 	 * Then do more get_blocks calls until we are done with this page.
 	 */
-	map_bh->b_page = page;
+	bh_map->b_page = page;
 	while (page_block < blocks_per_page) {
-		map_bh->b_state = 0;
-		map_bh->b_size = 0;
+		bh_map->b_state = 0;
+		bh_map->b_size = 0;
 
 		if (block_in_file < last_block) {
-			map_bh->b_size = (last_block-block_in_file) << blkbits;
-			if (get_block(inode, block_in_file, map_bh, 0))
+			bh_map->b_size = (last_block-block_in_file) << blkbits;
+			if (get_block(inode, block_in_file, bh_map, 0))
 				goto confused;
 			*first_logical_block = block_in_file;
 		}
 
-		if (!buffer_mapped(map_bh)) {
+		if (!buffer_mapped(bh_map)) {
 			fully_mapped = 0;
 			if (first_hole == blocks_per_page)
 				first_hole = page_block;
 			page_block++;
 			block_in_file++;
-			clear_buffer_mapped(map_bh);
+			clear_buffer_mapped(bh_map);
 			continue;
 		}
 
@@ -258,8 +258,8 @@ do_mpage_readpage(struct bio *bio, struc
 		 * we just collected from get_block into the page's buffers
 		 * so readpage doesn't have to repeat the get_block call
 		 */
-		if (buffer_uptodate(map_bh)) {
-			map_buffer_to_page(page, map_bh, page_block);
+		if (buffer_uptodate(bh_map)) {
+			map_buffer_to_page(page, bh_map, page_block);
 			goto confused;
 		}
 	
@@ -267,20 +267,20 @@ do_mpage_readpage(struct bio *bio, struc
 			goto confused;		/* hole -> non-hole */
 
 		/* Contiguous blocks? */
-		if (page_block && blocks[page_block-1] != map_bh->b_blocknr-1)
+		if (page_block && blocks[page_block-1] != bh_map->b_blocknr-1)
 			goto confused;
-		nblocks = map_bh->b_size >> blkbits;
+		nblocks = bh_map->b_size >> blkbits;
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == nblocks) {
-				clear_buffer_mapped(map_bh);
+				clear_buffer_mapped(bh_map);
 				break;
 			} else if (page_block == blocks_per_page)
 				break;
-			blocks[page_block] = map_bh->b_blocknr+relative_block;
+			blocks[page_block] = bh_map->b_blocknr+relative_block;
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_map->b_bdev;
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -319,7 +319,7 @@ alloc_new:
 		goto alloc_new;
 	}
 
-	if (buffer_boundary(map_bh) || (first_hole != blocks_per_page))
+	if (buffer_boundary(bh_map) || (first_hole != blocks_per_page))
 		bio = mpage_bio_submit(READ, bio);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
@@ -390,10 +390,10 @@ mpage_readpages(struct address_space *ma
 	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
 	struct pagevec lru_pvec;
-	struct buffer_head map_bh;
+	struct buffer_head bh_map;
 	unsigned long first_logical_block = 0;
 
-	clear_buffer_mapped(&map_bh);
+	clear_buffer_mapped(&bh_map);
 	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, lru);
@@ -404,7 +404,7 @@ mpage_readpages(struct address_space *ma
 					page->index, GFP_KERNEL)) {
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
-					&last_block_in_bio, &map_bh,
+					&last_block_in_bio, &bh_map,
 					&first_logical_block,
 					get_block);
 			if (!pagevec_add(&lru_pvec, page))
@@ -428,12 +428,12 @@ int mpage_readpage(struct page *page, ge
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
-	struct buffer_head map_bh;
+	struct buffer_head bh_map;
 	unsigned long first_logical_block = 0;
 
-	clear_buffer_mapped(&map_bh);
+	clear_buffer_mapped(&bh_map);
 	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
-			&map_bh, &first_logical_block, get_block);
+			&bh_map, &first_logical_block, get_block);
 	if (bio)
 		mpage_bio_submit(READ, bio);
 	return 0;
@@ -476,7 +476,7 @@ __mpage_writepage(struct bio *bio, struc
 	sector_t boundary_block = 0;
 	struct block_device *boundary_bdev = NULL;
 	int length;
-	struct buffer_head map_bh;
+	struct buffer_head bh_map;
 	loff_t i_size = i_size_read(inode);
 
 	if (page_has_buffers(page)) {
@@ -535,27 +535,27 @@ __mpage_writepage(struct bio *bio, struc
 	BUG_ON(!PageUptodate(page));
 	block_in_file = (sector_t)page->index << (PAGE_CACHE_SHIFT - blkbits);
 	last_block = (i_size - 1) >> blkbits;
-	map_bh.b_page = page;
+	bh_map.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
-		map_bh.b_state = 0;
-		map_bh.b_size = 1 << blkbits;
-		if (get_block(inode, block_in_file, &map_bh, 1))
+		bh_map.b_state = 0;
+		bh_map.b_size = 1 << blkbits;
+		if (get_block(inode, block_in_file, &bh_map, 1))
 			goto confused;
-		if (buffer_new(&map_bh))
-			unmap_underlying_metadata(map_bh.b_bdev,
-						map_bh.b_blocknr);
-		if (buffer_boundary(&map_bh)) {
-			boundary_block = map_bh.b_blocknr;
-			boundary_bdev = map_bh.b_bdev;
+		if (buffer_new(&bh_map))
+			unmap_underlying_metadata(bh_map.b_bdev,
+						bh_map.b_blocknr);
+		if (buffer_boundary(&bh_map)) {
+			boundary_block = bh_map.b_blocknr;
+			boundary_bdev = bh_map.b_bdev;
 		}
 		if (page_block) {
-			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
+			if (bh_map.b_blocknr != blocks[page_block-1] + 1)
 				goto confused;
 		}
-		blocks[page_block++] = map_bh.b_blocknr;
-		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
+		blocks[page_block++] = bh_map.b_blocknr;
+		boundary = buffer_boundary(&bh_map);
+		bdev = bh_map.b_bdev;
 		if (block_in_file == last_block)
 			break;
 		block_in_file++;
--- linux-2.6.18-rc1-orig/fs/direct-io.c	2006-07-06 19:39:47.000000000 +0200
+++ linux-2.6.18-rc1/fs/direct-io.c	2006-07-09 20:57:53.000000000 +0200
@@ -512,7 +512,7 @@ static int dio_bio_reap(struct dio *dio)
 static int get_more_blocks(struct dio *dio)
 {
 	int ret;
-	struct buffer_head *map_bh = &dio->map_bh;
+	struct buffer_head *bh_map = &dio->map_bh;
 	sector_t fs_startblk;	/* Into file, in filesystem-sized blocks */
 	unsigned long fs_count;	/* Number of filesystem-sized blocks */
 	unsigned long dio_count;/* Number of dio_block-sized blocks */
@@ -533,8 +533,8 @@ static int get_more_blocks(struct dio *d
 		if (dio_count & blkmask)	
 			fs_count++;
 
-		map_bh->b_state = 0;
-		map_bh->b_size = fs_count << dio->inode->i_blkbits;
+		bh_map->b_state = 0;
+		bh_map->b_size = fs_count << dio->inode->i_blkbits;
 
 		create = dio->rw & WRITE;
 		if (dio->lock_type == DIO_LOCKING) {
@@ -552,7 +552,7 @@ static int get_more_blocks(struct dio *d
 		 * writes.
 		 */
 		ret = (*dio->get_block)(dio->inode, fs_startblk,
-						map_bh, create);
+						bh_map, create);
 	}
 	return ret;
 }
@@ -799,7 +799,7 @@ static int do_direct_IO(struct dio *dio)
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	struct page *page;
 	unsigned block_in_page;
-	struct buffer_head *map_bh = &dio->map_bh;
+	struct buffer_head *bh_map = &dio->map_bh;
 	int ret = 0;
 
 	/* The I/O can start at any block offset within the first page */
@@ -830,14 +830,14 @@ static int do_direct_IO(struct dio *dio)
 					page_cache_release(page);
 					goto out;
 				}
-				if (!buffer_mapped(map_bh))
+				if (!buffer_mapped(bh_map))
 					goto do_holes;
 
 				dio->blocks_available =
-						map_bh->b_size >> dio->blkbits;
+						bh_map->b_size >> dio->blkbits;
 				dio->next_block_for_io =
-					map_bh->b_blocknr << dio->blkfactor;
-				if (buffer_new(map_bh))
+					bh_map->b_blocknr << dio->blkfactor;
+				if (buffer_new(bh_map))
 					clean_blockdev_aliases(dio);
 
 				if (!dio->blkfactor)
@@ -857,13 +857,13 @@ static int do_direct_IO(struct dio *dio)
 				 * the start of the fs block must be zeroed out
 				 * on-disk
 				 */
-				if (!buffer_new(map_bh))
+				if (!buffer_new(bh_map))
 					dio->next_block_for_io += dio_remainder;
 				dio->blocks_available -= dio_remainder;
 			}
 do_holes:
 			/* Handle holes */
-			if (!buffer_mapped(map_bh)) {
+			if (!buffer_mapped(bh_map)) {
 				char *kaddr;
 				loff_t i_size_aligned;
 
@@ -917,7 +917,7 @@ do_holes:
 			this_chunk_bytes = this_chunk_blocks << blkbits;
 			BUG_ON(this_chunk_bytes == 0);
 
-			dio->boundary = buffer_boundary(map_bh);
+			dio->boundary = buffer_boundary(bh_map);
 			ret = submit_page_section(dio, page, offset_in_page,
 				this_chunk_bytes, dio->next_block_for_io);
 			if (ret) {



