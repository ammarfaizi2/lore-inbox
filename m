Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWBOACx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWBOACx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbWBOACw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:02:52 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:13293 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422890AbWBOACv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:02:51 -0500
Subject: [PATCH 1/2] map multiple blocks in get_block() for
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>, akpm@osdl.org,
       mcao@us.ibm.com
In-Reply-To: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
References: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-yEfH0SdLyE1dOG0gY5/L"
Date: Tue, 14 Feb 2006 16:03:53 -0800
Message-Id: <1139961838.4762.45.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yEfH0SdLyE1dOG0gY5/L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes mpage_readpages() and get_block() to
get the disk mapping information for multiple blocks at the
same time.

Instead of adding new get_blocks() and pass it around every
where, I overload b_size of bufferhead to pass in how much
disk mapping we are requesting. Only the filesystems who
care to use this information and provide multiple disk
blocks at a time can choose to do so.

No changes are needed for the filesystems who wants to ignore this.

Thanks,
Badari



--=-yEfH0SdLyE1dOG0gY5/L
Content-Disposition: attachment; filename=getblocks-readpages.patch
Content-Type: text/x-patch; name=getblocks-readpages.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch changes mpage_readpages() and get_block() to
get the disk mapping information for multiple blocks at the 
same time. 

Instead of adding new get_blocks() and pass it around every
where, I overload b_size of bufferhead to pass in how much
disk mapping we are requesting. Only the filesystems who
care to use this information and provide multiple disk
blocks at a time can choose to do so. 

No changes are needed for the filesystems who wants to ignore this.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

 fs/buffer.c                 |    6 ++
 fs/jfs/inode.c              |    3 -
 fs/mpage.c                  |   91 +++++++++++++++++++++++++++++++++++---------
 fs/xfs/linux-2.6/xfs_aops.c |    4 -
 4 files changed, 84 insertions(+), 20 deletions(-)

Index: linux-2.6.16-rc3/fs/mpage.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/mpage.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3/fs/mpage.c	2006-02-14 15:57:15.000000000 -0800
@@ -165,7 +165,9 @@ map_buffer_to_page(struct page *page, st
 
 static struct bio *
 do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
-			sector_t *last_block_in_bio, get_block_t get_block)
+			sector_t *last_block_in_bio, struct buffer_head *map_bh,
+			unsigned long *first_logical_block, int *map_valid,
+			get_block_t get_block)
 {
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
@@ -177,29 +179,64 @@ do_mpage_readpage(struct bio *bio, struc
 	unsigned page_block;
 	unsigned first_hole = blocks_per_page;
 	struct block_device *bdev = NULL;
-	struct buffer_head bh;
 	int length;
 	int fully_mapped = 1;
+	unsigned nblocks, i;
 
 	if (page_has_buffers(page))
 		goto confused;
 
 	block_in_file = (sector_t)page->index << (PAGE_CACHE_SHIFT - blkbits);
 	last_block = (i_size_read(inode) + blocksize - 1) >> blkbits;
+	page_block = 0;
+
+	/*
+	 * Map blocks using the result from the last get_blocks call first.
+	 */
+	nblocks = map_bh->b_size >> blkbits;
+	if (*map_valid &&
+	    block_in_file > *first_logical_block &&
+	    block_in_file < (*first_logical_block + nblocks)) {
+		unsigned map_offset = block_in_file - *first_logical_block;
+		unsigned last = nblocks - map_offset;
+
+		for (i = 0; ; i++) {
+			if (i == last) {
+				*map_valid = 0;
+				break;
+			}
+			if (page_block == blocks_per_page)
+				break;
+			blocks[page_block] = map_bh->b_blocknr + map_offset + i;
+			page_block++;
+			block_in_file++;
+		}
+		bdev = map_bh->b_bdev;
+	}
+
+	/*
+	 * Then do more get_blocks calls until we are done with this page.
+	 */
+	map_bh->b_page = page;
+	while (page_block < blocks_per_page) {
+		map_bh->b_state = 0;
+		map_bh->b_size = 0;
 
-	bh.b_page = page;
-	for (page_block = 0; page_block < blocks_per_page;
-				page_block++, block_in_file++) {
-		bh.b_state = 0;
 		if (block_in_file < last_block) {
-			if (get_block(inode, block_in_file, &bh, 0))
+			map_bh->b_size = (last_block - block_in_file) << blkbits;
+			if (get_block(inode, block_in_file, map_bh, 0))
 				goto confused;
+			*first_logical_block = block_in_file;
+			*map_valid  = 1;
 		}
 
-		if (!buffer_mapped(&bh)) {
+		if (!buffer_mapped(map_bh)) {
 			fully_mapped = 0;
 			if (first_hole == blocks_per_page)
 				first_hole = page_block;
+			page_block++;
+			block_in_file++;
+			*map_valid = 0;
 			continue;
 		}
 
@@ -209,8 +246,8 @@ do_mpage_readpage(struct bio *bio, struc
 		 * we just collected from get_block into the page's buffers
 		 * so readpage doesn't have to repeat the get_block call
 		 */
-		if (buffer_uptodate(&bh)) {
-			map_buffer_to_page(page, &bh, page_block);
+		if (buffer_uptodate(map_bh)) {
+			map_buffer_to_page(page, map_bh, page_block);
 			goto confused;
 		}
 	
@@ -218,10 +255,20 @@ do_mpage_readpage(struct bio *bio, struc
 			goto confused;		/* hole -> non-hole */
 
 		/* Contiguous blocks? */
-		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
+		if (page_block && blocks[page_block-1] != map_bh->b_blocknr-1)
 			goto confused;
-		blocks[page_block] = bh.b_blocknr;
-		bdev = bh.b_bdev;
+		nblocks = map_bh->b_size >> blkbits;
+		for (i = 0; ; i++) {
+			if (i == nblocks) {
+				*map_valid = 0;
+				break;
+			} else if (page_block == blocks_per_page)
+				break;
+			blocks[page_block] = map_bh->b_blocknr + i;
+			page_block++;
+			block_in_file++;
+		}
+		bdev = map_bh->b_bdev;
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -260,7 +307,7 @@ alloc_new:
 		goto alloc_new;
 	}
 
-	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
+	if (buffer_boundary(map_bh) || (first_hole != blocks_per_page))
 		bio = mpage_bio_submit(READ, bio);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
@@ -331,6 +378,9 @@ mpage_readpages(struct address_space *ma
 	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
 	struct pagevec lru_pvec;
+	struct buffer_head map_bh;
+	unsigned long first_logical_block = 0;
+	int map_valid = 0;
 
 	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
@@ -342,7 +392,9 @@ mpage_readpages(struct address_space *ma
 					page->index, GFP_KERNEL)) {
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
-					&last_block_in_bio, get_block);
+					&last_block_in_bio, &map_bh,
+					&first_logical_block,
+					&map_valid, get_block);
 			if (!pagevec_add(&lru_pvec, page))
 				__pagevec_lru_add(&lru_pvec);
 		} else {
@@ -364,9 +416,14 @@ int mpage_readpage(struct page *page, ge
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
+	struct buffer_head map_bh;
+	unsigned long first_logical_block = 0;
+	int map_valid = 0;
+
 
-	bio = do_mpage_readpage(bio, page, 1,
-			&last_block_in_bio, get_block);
+	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
+			&map_bh, &first_logical_block, &map_valid,
+			get_block);
 	if (bio)
 		mpage_bio_submit(READ, bio);
 	return 0;
@@ -472,6 +529,7 @@ __mpage_writepage(struct bio *bio, struc
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
 		map_bh.b_state = 0;
+		map_bh.b_size = 1 << blkbits;
 		if (get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
 		if (buffer_new(&map_bh))
Index: linux-2.6.16-rc3/fs/buffer.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/buffer.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3/fs/buffer.c	2006-02-14 08:40:21.000000000 -0800
@@ -1785,6 +1785,7 @@ static int __block_write_full_page(struc
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1938,6 +1939,7 @@ static int __block_prepare_write(struct 
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
@@ -2093,6 +2095,7 @@ int block_read_full_page(struct page *pa
 
 			fully_mapped = 0;
 			if (iblock < lblock) {
+				bh->b_size = 1 << inode->i_blkbits;
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
 					SetPageError(page);
@@ -2414,6 +2417,7 @@ int nobh_prepare_write(struct page *page
 		create = 1;
 		if (block_start >= to)
 			create = 0;
+		map_bh.b_size = 1 << blkbits;
 		ret = get_block(inode, block_in_file + block_in_page,
 					&map_bh, create);
 		if (ret)
@@ -2674,6 +2678,7 @@ int block_truncate_page(struct address_s
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
+		bh->b_size = 1 << inode->i_blkbits;
 		err = get_block(inode, iblock, bh, 0);
 		if (err)
 			goto unlock;
@@ -2760,6 +2765,7 @@ sector_t generic_block_bmap(struct addre
 	struct inode *inode = mapping->host;
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
+	tmp.b_size = 1 << inode->i_blkbits;
 	get_block(inode, block, &tmp, 0);
 	return tmp.b_blocknr;
 }
Index: linux-2.6.16-rc3/fs/jfs/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/jfs/inode.c	2006-02-14 09:43:06.000000000 -0800
+++ linux-2.6.16-rc3/fs/jfs/inode.c	2006-02-14 15:54:12.000000000 -0800
@@ -257,7 +257,8 @@ jfs_get_blocks(struct inode *ip, sector_
 static int jfs_get_block(struct inode *ip, sector_t lblock,
 			 struct buffer_head *bh_result, int create)
 {
-	return jfs_get_blocks(ip, lblock, 1, bh_result, create);
+	return jfs_get_blocks(ip, lblock, bh_result->b_size >> ip->i_blkbits,
+			bh_result, create);
 }
 
 static int jfs_writepage(struct page *page, struct writeback_control *wbc)
Index: linux-2.6.16-rc3/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-02-14 09:43:06.000000000 -0800
+++ linux-2.6.16-rc3/fs/xfs/linux-2.6/xfs_aops.c	2006-02-14 15:54:12.000000000 -0800
@@ -1136,8 +1136,8 @@ linvfs_get_block(
 	struct buffer_head	*bh_result,
 	int			create)
 {
-	return __linvfs_get_block(inode, iblock, 0, bh_result,
-					create, 0, BMAPI_WRITE);
+	return __linvfs_get_block(inode, iblock, bh_result->b_size >> inode->i_blkbits,
+				bh_result, create, 0, BMAPI_WRITE);
 }
 
 STATIC int

--=-yEfH0SdLyE1dOG0gY5/L--

