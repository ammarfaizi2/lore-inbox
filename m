Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWBOAEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWBOAEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWBOAEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:04:13 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27265 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422808AbWBOAEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:04:11 -0500
Subject: [PATCH 2/2] remove ->get_blocks() support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>, akpm@osdl.org,
       mcao@us.ibm.com
In-Reply-To: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
References: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-o12Kn2aK/6hKMKFYd8cT"
Date: Tue, 14 Feb 2006 16:05:18 -0800
Message-Id: <1139961918.4762.48.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o12Kn2aK/6hKMKFYd8cT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Now that get_block() can handle mapping multiple disk blocks,
no need to have ->get_blocks(). This patch removes fs specific
->get_blocks() added for DIO and makes it users use get_block()
instead.

Thanks,
Badari



--=-o12Kn2aK/6hKMKFYd8cT
Content-Disposition: attachment; filename=remove-getblocks.patch
Content-Type: text/x-patch; name=remove-getblocks.patch; charset=UTF-8
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

Index: linux-2.6.16-rc3/fs/direct-io.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/direct-io.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/direct-io.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/ext2/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/ext2/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/ext2/inode.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/ext3/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/ext3/inode.c	2006-02-14 15:57:27.000000000 -0800
@@ -806,8 +806,7 @@ static int ext3_get_block(struct inode *
 
 static int
 ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
-		unsigned long max_blocks, struct buffer_head *bh_result,
-		int create)
+		struct buffer_head *bh_result, int create)
 {
 	handle_t *handle = journal_current_handle();
 	int ret = 0;
Index: linux-2.6.16-rc3/fs/fat/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/fat/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/fat/inode.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/hfs/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/hfs/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/hfs/inode.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/hfsplus/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/hfsplus/inode.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/ocfs2/aops.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/ocfs2/aops.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/ocfs2/aops.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/fs/reiserfs/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/reiserfs/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/reiserfs/inode.c	2006-02-14 15:57:27.000000000 -0800
@@ -466,7 +466,6 @@ static int reiserfs_get_block_create_0(s
    direct_IO request. */
 static int reiserfs_get_blocks_direct_io(struct inode *inode,
 					 sector_t iblock,
-					 unsigned long max_blocks,
 					 struct buffer_head *bh_result,
 					 int create)
 {
Index: linux-2.6.16-rc3/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/xfs/linux-2.6/xfs_aops.c	2006-02-14 15:57:27.000000000 -0800
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
Index: linux-2.6.16-rc3/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc3.orig/include/linux/fs.h	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/include/linux/fs.h	2006-02-14 15:57:27.000000000 -0800
@@ -240,9 +240,6 @@ extern void __init files_init(unsigned l
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create);
-typedef int (get_blocks_t)(struct inode *inode, sector_t iblock,
-			unsigned long max_blocks,
-			struct buffer_head *bh_result, int create);
 typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 			ssize_t bytes, void *private);
 
@@ -1621,7 +1618,7 @@ static inline void do_generic_file_read(
 
 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
 	struct block_device *bdev, const struct iovec *iov, loff_t offset,
-	unsigned long nr_segs, get_blocks_t get_blocks, dio_iodone_t end_io,
+	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
 	int lock_type);
 
 enum {
@@ -1632,29 +1629,29 @@ enum {
 
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
 
 extern struct file_operations generic_ro_fops;
Index: linux-2.6.16-rc3/fs/block_dev.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/block_dev.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/block_dev.c	2006-02-14 15:57:27.000000000 -0800
@@ -135,9 +135,10 @@ blkdev_get_block(struct inode *inode, se
 
 static int
 blkdev_get_blocks(struct inode *inode, sector_t iblock,
-		unsigned long max_blocks, struct buffer_head *bh, int create)
+		struct buffer_head *bh, int create)
 {
 	sector_t end_block = max_block(I_BDEV(inode));
+	unsigned long max_blocks = bh->b_size >> inode->i_blkbits;
 
 	if ((iblock + max_blocks) > end_block) {
 		max_blocks = end_block - iblock;
Index: linux-2.6.16-rc3/fs/jfs/inode.c
===================================================================
--- linux-2.6.16-rc3.orig/fs/jfs/inode.c	2006-02-14 15:54:12.000000000 -0800
+++ linux-2.6.16-rc3/fs/jfs/inode.c	2006-02-14 15:57:27.000000000 -0800
@@ -301,7 +301,7 @@ static ssize_t jfs_direct_IO(int rw, str
 	struct inode *inode = file->f_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				offset, nr_segs, jfs_get_blocks, NULL);
+				offset, nr_segs, jfs_get_block, NULL);
 }
 
 struct address_space_operations jfs_aops = {

--=-o12Kn2aK/6hKMKFYd8cT--

