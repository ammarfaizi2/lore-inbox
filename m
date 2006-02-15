Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWBOWjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWBOWjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBOWjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:39:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:16033 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932204AbWBOWjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:39:22 -0500
Subject: Re: [PATCH 0/2] Add support to map multiple blocks in get_block()
	and remove get_blocks()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: cmm@us.ibm.com
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>,
       akpm@osdl.org, mcao@us.ibm.com
In-Reply-To: <1140038951.20936.3.camel@dyn9047017067.beaverton.ibm.com>
References: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
	 <1140038951.20936.3.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-UAo9c3YrZeTEcUR000Ue"
Date: Wed, 15 Feb 2006 14:40:25 -0800
Message-Id: <1140043226.21448.27.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UAo9c3YrZeTEcUR000Ue
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-02-15 at 13:29 -0800, Mingming Cao wrote:
> On Tue, 2006-02-14 at 16:02 -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > Following patches add support to map multiple blocks in ->get_block().
> > This is will allow us to handle mapping of multiple disk blocks for
> > mpage_readpages() and mpage_writepages() etc. Instead of adding new
> > argument, I use "b_size" to indicate the amount of disk mapping needed
> > for get_block().
> > 
> > Now that get_block() can handle multiple blocks, there is no need
> > for ->get_blocks() which was added for DIO. Second patch removes
> > them.
> > 
> > [PATCH 1/2] map multiple blocks in get_block() for mpage_readpages()
> > 
> > [PATCH 2/2] remove ->get_blocks() support
> > 
> > 
> > Andrew, Please let me know if you want to pick these up into -mm
> > tree, since they need to be integrated with Mingming's ext3 multiblock
> > support.
> > 
> 
> Hi Badari,
> 
> Patch looks good.  Did you get a chance to combine your patches with the
> ext3 multiple blocks map/allocation patches, and run some simple
> buffered-IO read tests? It would be nice to see if there is any
> performance or cpu-usage gain (or regression).

Here are the patches against -mm tree, with your ext3 mblock work.
Can you give it a test and see how they do ?

Thanks,
Badari



--=-UAo9c3YrZeTEcUR000Ue
Content-Disposition: attachment; filename=getblocks-readpages.patch
Content-Type: text/x-patch; name=getblocks-readpages.patch; charset=utf-8
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

Index: linux-2.6.16-rc3-mm1/fs/mpage.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/mpage.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/mpage.c	2006-02-15 14:26:14.000000000 -0800
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
Index: linux-2.6.16-rc3-mm1/fs/buffer.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/buffer.c	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/buffer.c	2006-02-15 14:26:14.000000000 -0800
@@ -1788,6 +1788,7 @@ static int __block_write_full_page(struc
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1941,6 +1942,7 @@ static int __block_prepare_write(struct 
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
+			bh->b_size = 1 << inode->i_blkbits;
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
@@ -2096,6 +2098,7 @@ int block_read_full_page(struct page *pa
 
 			fully_mapped = 0;
 			if (iblock < lblock) {
+				bh->b_size = 1 << inode->i_blkbits;
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
 					SetPageError(page);
@@ -2417,6 +2420,7 @@ int nobh_prepare_write(struct page *page
 		create = 1;
 		if (block_start >= to)
 			create = 0;
+		map_bh.b_size = 1 << blkbits;
 		ret = get_block(inode, block_in_file + block_in_page,
 					&map_bh, create);
 		if (ret)
@@ -2677,6 +2681,7 @@ int block_truncate_page(struct address_s
 
 	err = 0;
 	if (!buffer_mapped(bh)) {
+		bh->b_size = 1 << inode->i_blkbits;
 		err = get_block(inode, iblock, bh, 0);
 		if (err)
 			goto unlock;
@@ -2763,6 +2768,7 @@ sector_t generic_block_bmap(struct addre
 	struct inode *inode = mapping->host;
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
+	tmp.b_size = 1 << inode->i_blkbits;
 	get_block(inode, block, &tmp, 0);
 	return tmp.b_blocknr;
 }
Index: linux-2.6.16-rc3-mm1/fs/jfs/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/jfs/inode.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/jfs/inode.c	2006-02-15 14:26:14.000000000 -0800
@@ -257,7 +257,8 @@ jfs_get_blocks(struct inode *ip, sector_
 static int jfs_get_block(struct inode *ip, sector_t lblock,
 			 struct buffer_head *bh_result, int create)
 {
-	return jfs_get_blocks(ip, lblock, 1, bh_result, create);
+	return jfs_get_blocks(ip, lblock, bh_result->b_size >> ip->i_blkbits,
+			bh_result, create);
 }
 
 static int jfs_writepage(struct page *page, struct writeback_control *wbc)
Index: linux-2.6.16-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c	2006-02-15 14:26:14.000000000 -0800
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

--=-UAo9c3YrZeTEcUR000Ue
Content-Disposition: attachment; filename=remove-getblocks.patch
Content-Type: text/x-patch; name=remove-getblocks.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Now that get_block() can handle mapping multiple disk blocks,
no need to have ->get_blocks(). This patch removes fs specific
->get_blocks() added for DIO and makes it users use get_block()
instead.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

 fs/block_dev.c              |    3 ++-
 fs/direct-io.c              |   27 ++++++++++++++-------------
 fs/ext2/inode.c             |   14 +-------------
 fs/ext3/inode.c             |    3 +--
 fs/fat/inode.c              |    2 +-
 fs/hfs/inode.c              |   13 +------------
 fs/hfsplus/inode.c          |   13 +------------
 fs/jfs/inode.c              |    2 +-
 fs/ocfs2/aops.c             |    2 +-
 fs/reiserfs/inode.c         |    1 -
 fs/xfs/linux-2.6/xfs_aops.c |    5 ++---
 include/linux/fs.h          |   17 +++++++----------
 12 files changed, 32 insertions(+), 70 deletions(-)

Index: linux-2.6.16-rc3-mm1/fs/direct-io.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/direct-io.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/direct-io.c	2006-02-15 14:28:06.000000000 -0800
@@ -86,12 +86,12 @@ struct dio {
 	unsigned first_block_in_page;	/* doesn't change, Used only once */
 	int boundary;			/* prev block is at a boundary */
 	int reap_counter;		/* rate limit reaping */
-	get_blocks_t *get_blocks;	/* block mapping function */
+	get_block_t *get_block;		/* block mapping function */
 	dio_iodone_t *end_io;		/* IO completion function */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
 	sector_t next_block_for_io;	/* next block to be put under IO,
 					   in dio_blocks units */
-	struct buffer_head map_bh;	/* last get_blocks() result */
+	struct buffer_head map_bh;	/* last get_block() result */
 
 	/*
 	 * Deferred addition of a page to the dio.  These variables are
@@ -210,9 +210,9 @@ static struct page *dio_get_page(struct 
 
 /*
  * Called when all DIO BIO I/O has been completed - let the filesystem
- * know, if it registered an interest earlier via get_blocks.  Pass the
+ * know, if it registered an interest earlier via get_block.  Pass the
  * private field of the map buffer_head so that filesystems can use it
- * to hold additional state between get_blocks calls and dio_complete.
+ * to hold additional state between get_block calls and dio_complete.
  */
 static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
 {
@@ -488,7 +488,7 @@ static int dio_bio_reap(struct dio *dio)
  * The fs is allowed to map lots of blocks at once.  If it wants to do that,
  * it uses the passed inode-relative block number as the file offset, as usual.
  *
- * get_blocks() is passed the number of i_blkbits-sized blocks which direct_io
+ * get_block() is passed the number of i_blkbits-sized blocks which direct_io
  * has remaining to do.  The fs should not map more than this number of blocks.
  *
  * If the fs has mapped a lot of blocks, it should populate bh->b_size to
@@ -501,7 +501,7 @@ static int dio_bio_reap(struct dio *dio)
  * In the case of filesystem holes: the fs may return an arbitrarily-large
  * hole by returning an appropriate value in b_size and by clearing
  * buffer_mapped().  However the direct-io code will only process holes one
- * block at a time - it will repeatedly call get_blocks() as it walks the hole.
+ * block at a time - it will repeatedly call get_block() as it walks the hole.
  */
 static int get_more_blocks(struct dio *dio)
 {
@@ -543,7 +543,8 @@ static int get_more_blocks(struct dio *d
 		 * at a higher level for inside-i_size block-instantiating
 		 * writes.
 		 */
-		ret = (*dio->get_blocks)(dio->inode, fs_startblk, fs_count,
+		map_bh->b_size = fs_count << dio->blkbits;
+		ret = (*dio->get_block)(dio->inode, fs_startblk,
 						map_bh, create);
 	}
 	return ret;
@@ -778,11 +779,11 @@ static void dio_zero_block(struct dio *d
  * happily perform page-sized but 512-byte aligned IOs.  It is important that
  * blockdev IO be able to have fine alignment and large sizes.
  *
- * So what we do is to permit the ->get_blocks function to populate bh.b_size
+ * So what we do is to permit the ->get_block function to populate bh.b_size
  * with the size of IO which is permitted at this offset and this i_blkbits.
  *
  * For best results, the blockdev should be set up with 512-byte i_blkbits and
- * it should set b_size to PAGE_SIZE or more inside get_blocks().  This gives
+ * it should set b_size to PAGE_SIZE or more inside get_block().  This gives
  * fine alignment but still allows this function to work in PAGE_SIZE units.
  */
 static int do_direct_IO(struct dio *dio)
@@ -942,7 +943,7 @@ out:
 static ssize_t
 direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
-	unsigned blkbits, get_blocks_t get_blocks, dio_iodone_t end_io,
+	unsigned blkbits, get_block_t get_block, dio_iodone_t end_io,
 	struct dio *dio)
 {
 	unsigned long user_addr; 
@@ -964,7 +965,7 @@ direct_io_worker(int rw, struct kiocb *i
 
 	dio->boundary = 0;
 	dio->reap_counter = 0;
-	dio->get_blocks = get_blocks;
+	dio->get_block = get_block;
 	dio->end_io = end_io;
 	dio->map_bh.b_private = NULL;
 	dio->final_block_in_bio = -1;
@@ -1170,7 +1171,7 @@ direct_io_worker(int rw, struct kiocb *i
 ssize_t
 __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
 	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
-	unsigned long nr_segs, get_blocks_t get_blocks, dio_iodone_t end_io,
+	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
 	int dio_lock_type)
 {
 	int seg;
@@ -1266,7 +1267,7 @@ __blockdev_direct_IO(int rw, struct kioc
 		(end > i_size_read(inode)));
 
 	retval = direct_io_worker(rw, iocb, inode, iov, offset,
-				nr_segs, blkbits, get_blocks, end_io, dio);
+				nr_segs, blkbits, get_block, end_io, dio);
 
 	if (rw == READ && dio_lock_type == DIO_LOCKING)
 		reader_with_isem = 0;
Index: linux-2.6.16-rc3-mm1/fs/ext2/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/ext2/inode.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/ext2/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -667,18 +667,6 @@ static sector_t ext2_bmap(struct address
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
 
-static int
-ext2_get_blocks(struct inode *inode, sector_t iblock, unsigned long max_blocks,
-			struct buffer_head *bh_result, int create)
-{
-	int ret;
-
-	ret = ext2_get_block(inode, iblock, bh_result, create);
-	if (ret == 0)
-		bh_result->b_size = (1 << inode->i_blkbits);
-	return ret;
-}
-
 static ssize_t
 ext2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
@@ -687,7 +675,7 @@ ext2_direct_IO(int rw, struct kiocb *ioc
 	struct inode *inode = file->f_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				offset, nr_segs, ext2_get_blocks, NULL);
+				offset, nr_segs, ext2_get_block, NULL);
 }
 
 static int
Index: linux-2.6.16-rc3-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/ext3/inode.c	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/ext3/inode.c	2006-02-15 14:35:15.000000000 -0800
@@ -936,13 +936,12 @@ out:
 
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
-static int
-ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
-		unsigned long max_blocks,
-		struct buffer_head *bh_result, int create)
+static int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
 {
 	handle_t *handle = journal_current_handle();
 	int ret = 0;
+	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 
 	if (!handle)
 		goto get_block;		/* A read */
@@ -987,20 +986,6 @@ get_block:
 	return ret;
 }
 
-static int ext3_get_blocks(struct inode *inode, sector_t iblock,
-		unsigned long maxblocks, struct buffer_head *bh_result,
-		int create)
-{
-	return ext3_direct_io_get_blocks(inode, iblock, maxblocks,
-					bh_result, create);
-}
-
-static int ext3_get_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
-{
-	return ext3_get_blocks(inode, iblock, 1, bh_result, create);
-}
-
 /*
  * `handle' can be NULL if create is zero
  */
@@ -1653,7 +1638,7 @@ static ssize_t ext3_direct_IO(int rw, st
 
 	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov, 
 				 offset, nr_segs,
-				 ext3_direct_io_get_blocks, NULL);
+				 ext3_get_block, NULL);
 
 	/*
 	 * Reacquire the handle: ext3_direct_io_get_block() can restart the
Index: linux-2.6.16-rc3-mm1/fs/fat/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/fat/inode.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/fat/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -101,11 +101,11 @@ static int __fat_get_blocks(struct inode
 }
 
 static int fat_get_blocks(struct inode *inode, sector_t iblock,
-			  unsigned long max_blocks,
 			  struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
 	int err;
+	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 
 	err = __fat_get_blocks(inode, iblock, &max_blocks, bh_result, create);
 	if (err)
Index: linux-2.6.16-rc3-mm1/fs/hfs/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/hfs/inode.c	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/hfs/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -98,17 +98,6 @@ static int hfs_releasepage(struct page *
 	return res ? try_to_free_buffers(page) : 0;
 }
 
-static int hfs_get_blocks(struct inode *inode, sector_t iblock, unsigned long max_blocks,
-			  struct buffer_head *bh_result, int create)
-{
-	int ret;
-
-	ret = hfs_get_block(inode, iblock, bh_result, create);
-	if (!ret)
-		bh_result->b_size = (1 << inode->i_blkbits);
-	return ret;
-}
-
 static ssize_t hfs_direct_IO(int rw, struct kiocb *iocb,
 		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
@@ -116,7 +105,7 @@ static ssize_t hfs_direct_IO(int rw, str
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, hfs_get_blocks, NULL);
+				  offset, nr_segs, hfs_get_block, NULL);
 }
 
 static int hfs_writepages(struct address_space *mapping,
Index: linux-2.6.16-rc3-mm1/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/hfsplus/inode.c	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/hfsplus/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -93,17 +93,6 @@ static int hfsplus_releasepage(struct pa
 	return res ? try_to_free_buffers(page) : 0;
 }
 
-static int hfsplus_get_blocks(struct inode *inode, sector_t iblock, unsigned long max_blocks,
-			      struct buffer_head *bh_result, int create)
-{
-	int ret;
-
-	ret = hfsplus_get_block(inode, iblock, bh_result, create);
-	if (!ret)
-		bh_result->b_size = (1 << inode->i_blkbits);
-	return ret;
-}
-
 static ssize_t hfsplus_direct_IO(int rw, struct kiocb *iocb,
 		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
@@ -111,7 +100,7 @@ static ssize_t hfsplus_direct_IO(int rw,
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, hfsplus_get_blocks, NULL);
+				  offset, nr_segs, hfsplus_get_block, NULL);
 }
 
 static int hfsplus_writepages(struct address_space *mapping,
Index: linux-2.6.16-rc3-mm1/fs/ocfs2/aops.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/ocfs2/aops.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/ocfs2/aops.c	2006-02-15 14:28:06.000000000 -0800
@@ -538,7 +538,6 @@ bail:
  * 					fs_count, map_bh, dio->rw == WRITE);
  */
 static int ocfs2_direct_IO_get_blocks(struct inode *inode, sector_t iblock,
-				     unsigned long max_blocks,
 				     struct buffer_head *bh_result, int create)
 {
 	int ret;
@@ -546,6 +545,7 @@ static int ocfs2_direct_IO_get_blocks(st
 	u64 p_blkno;
 	int contig_blocks;
 	unsigned char blocksize_bits;
+	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 
 	if (!inode || !bh_result) {
 		mlog(ML_ERROR, "inode or bh_result is null\n");
Index: linux-2.6.16-rc3-mm1/fs/reiserfs/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/reiserfs/inode.c	2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/reiserfs/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -466,7 +466,6 @@ static int reiserfs_get_block_create_0(s
    direct_IO request. */
 static int reiserfs_get_blocks_direct_io(struct inode *inode,
 					 sector_t iblock,
-					 unsigned long max_blocks,
 					 struct buffer_head *bh_result,
 					 int create)
 {
Index: linux-2.6.16-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-02-15 14:26:14.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c	2006-02-15 14:28:06.000000000 -0800
@@ -1144,12 +1144,11 @@ STATIC int
 linvfs_get_blocks_direct(
 	struct inode		*inode,
 	sector_t		iblock,
-	unsigned long		max_blocks,
 	struct buffer_head	*bh_result,
 	int			create)
 {
-	return __linvfs_get_block(inode, iblock, max_blocks, bh_result,
-					create, 1, BMAPI_WRITE|BMAPI_DIRECT);
+	return __linvfs_get_block(inode, iblock, bh_result->b_size >> inode->i_blkbits,
+				bh_result, create, 1, BMAPI_WRITE|BMAPI_DIRECT);
 }
 
 STATIC void
Index: linux-2.6.16-rc3-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc3-mm1.orig/include/linux/fs.h	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/include/linux/fs.h	2006-02-15 14:28:06.000000000 -0800
@@ -244,9 +244,6 @@ extern void __init files_init(unsigned l
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create);
-typedef int (get_blocks_t)(struct inode *inode, sector_t iblock,
-			unsigned long max_blocks,
-			struct buffer_head *bh_result, int create);
 typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 			ssize_t bytes, void *private);
 
@@ -1646,7 +1643,7 @@ static inline void do_generic_file_read(
 
 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
 	struct block_device *bdev, const struct iovec *iov, loff_t offset,
-	unsigned long nr_segs, get_blocks_t get_blocks, dio_iodone_t end_io,
+	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
 	int lock_type);
 
 enum {
@@ -1657,29 +1654,29 @@ enum {
 
 static inline ssize_t blockdev_direct_IO(int rw, struct kiocb *iocb,
 	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
+	loff_t offset, unsigned long nr_segs, get_block_t get_block,
 	dio_iodone_t end_io)
 {
 	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_blocks, end_io, DIO_LOCKING);
+				nr_segs, get_block, end_io, DIO_LOCKING);
 }
 
 static inline ssize_t blockdev_direct_IO_no_locking(int rw, struct kiocb *iocb,
 	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
+	loff_t offset, unsigned long nr_segs, get_block_t get_block,
 	dio_iodone_t end_io)
 {
 	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_blocks, end_io, DIO_NO_LOCKING);
+				nr_segs, get_block, end_io, DIO_NO_LOCKING);
 }
 
 static inline ssize_t blockdev_direct_IO_own_locking(int rw, struct kiocb *iocb,
 	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
+	loff_t offset, unsigned long nr_segs, get_block_t get_block,
 	dio_iodone_t end_io)
 {
 	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_blocks, end_io, DIO_OWN_LOCKING);
+				nr_segs, get_block, end_io, DIO_OWN_LOCKING);
 }
 
 extern const struct file_operations generic_ro_fops;
Index: linux-2.6.16-rc3-mm1/fs/block_dev.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/block_dev.c	2006-02-15 14:24:52.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/block_dev.c	2006-02-15 14:28:06.000000000 -0800
@@ -133,9 +133,10 @@ blkdev_get_block(struct inode *inode, se
 
 static int
 blkdev_get_blocks(struct inode *inode, sector_t iblock,
-		unsigned long max_blocks, struct buffer_head *bh, int create)
+		struct buffer_head *bh, int create)
 {
 	sector_t end_block = max_block(I_BDEV(inode));
+	unsigned long max_blocks = bh->b_size >> inode->i_blkbits;
 
 	if ((iblock + max_blocks) > end_block) {
 		max_blocks = end_block - iblock;
Index: linux-2.6.16-rc3-mm1/fs/jfs/inode.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/fs/jfs/inode.c	2006-02-15 14:26:14.000000000 -0800
+++ linux-2.6.16-rc3-mm1/fs/jfs/inode.c	2006-02-15 14:28:06.000000000 -0800
@@ -301,7 +301,7 @@ static ssize_t jfs_direct_IO(int rw, str
 	struct inode *inode = file->f_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				offset, nr_segs, jfs_get_blocks, NULL);
+				offset, nr_segs, jfs_get_block, NULL);
 }
 
 struct address_space_operations jfs_aops = {

--=-UAo9c3YrZeTEcUR000Ue--

