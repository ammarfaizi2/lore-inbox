Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbSJGWyV>; Mon, 7 Oct 2002 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJGWyR>; Mon, 7 Oct 2002 18:54:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:39356 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262748AbSJGWxc>;
	Mon, 7 Oct 2002 18:53:32 -0400
Message-ID: <3DA211B8.325C32BA@digeo.com>
Date: Mon, 07 Oct 2002 15:59:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>
Subject: [patch] 512-byte alignment for O_DIRECT I/O
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 22:59:04.0799 (UTC) FILETIME=[226316F0:01C26E55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch from Badari is passing all testing now.

Traditionally we have only supported O_DIRECT I/O at an
alignment and granularity which matches the underlying filesystem.
That typically means that all IO must be 4k-aligned and a multiple
of 4k in size.

Here, we relax that so that direct I/O happens with (typically)
512-byte alignment and multiple-of-512-byte size.

The tricky part is when a write starts and/or ends partway through
a filesystem block which has just been added.  We need to zero out
the parts of that block which lie outside the written region.

We handle that by putting appropriately-sized parts of the ZERO_PAGE
into sepatate BIOs.

The generic_direct_IO() function has been changed so that the
filesystem must pass in the address of the block_device against
which the IO is to be performed.  I'd have preferred to not do
this, but we do need that info at that time so that alignment
checks can be performed.

If the filesystem passes in a NULL block_device pointer then we
fall back to the old behaviour - must align with the fs blocksize.

There is no trivial way for userspace to know what the minimum alignment
is - it depends on what bdev_hardsect_size() says about the device.
It is _usually_ 512 bytes, but not always.   This introduces the risk
that someone will develop and test applications which work fine on
their hardware, but will fail on someone else's hardware.

It is possible to query the hardsect size using the BLKSSZGET ioctl
against the backing block device.  This can be performed at runtime
or at application installation time.

The XFS patch has not yet been tested.



 fs/block_dev.c          |    2 
 fs/direct-io.c          |  124 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/ext2/inode.c         |    2 
 fs/ext3/inode.c         |    2 
 fs/jfs/inode.c          |    2 
 fs/xfs/linux/xfs_aops.c |    4 -
 include/linux/fs.h      |    4 -
 7 files changed, 120 insertions(+), 20 deletions(-)

--- 2.5.41/fs/block_dev.c~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/fs/block_dev.c	Mon Oct  7 15:49:34 2002
@@ -121,7 +121,7 @@ blkdev_direct_IO(int rw, struct file *fi
 {
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, iov, offset,
+	return generic_direct_IO(rw, inode, inode->i_bdev, iov, offset,
 				nr_segs, blkdev_get_blocks);
 }
 
--- 2.5.41/fs/direct-io.c~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/fs/direct-io.c	Mon Oct  7 15:49:34 2002
@@ -7,6 +7,12 @@
  *
  * 04Jul2002	akpm@zip.com.au
  *		Initial version
+ * 11Sep2002 	janetinc@us.ibm.com
+ *		added readv/writev support.
+ * 25Sep2002 	pbadari@us.ibm.com
+ *		use bio_add_page() to build bio's just the right size.
+ * 02Oct2002	pbadari@us.ibm.com
+ *		added support for non-aligned IO.
  */
 
 #include <linux/kernel.h>
@@ -35,6 +41,9 @@ struct dio {
 	struct inode *inode;
 	int rw;
 	unsigned blkbits;		/* doesn't change */
+	unsigned blkfactor;		/* doesn't change */
+	unsigned blkadjust;		/* flag: sub-blocksize zeroing has
+					   been performed */
 	sector_t block_in_file;		/* changes */
 	unsigned blocks_available;	/* At block_in_file.  changes */
 	sector_t final_block_in_request;/* doesn't change */
@@ -325,6 +334,10 @@ static int get_more_blocks(struct dio *d
 {
 	int ret;
 	struct buffer_head *map_bh = &dio->map_bh;
+	sector_t startblk;
+	unsigned long count;
+	unsigned long tmp;
+	unsigned blkmask;
 
 	if (dio->blocks_available)
 		return 0;
@@ -341,8 +354,15 @@ static int get_more_blocks(struct dio *d
 	map_bh->b_state = 0;
 	map_bh->b_size = 0;
 	BUG_ON(dio->block_in_file >= dio->final_block_in_request);
-	ret = (*dio->get_blocks)(dio->inode, dio->block_in_file,
-			dio->final_block_in_request - dio->block_in_file,
+
+	startblk = dio->block_in_file >> dio->blkfactor;
+	tmp = dio->final_block_in_request - dio->block_in_file;
+	count = tmp >> dio->blkfactor;
+	blkmask = (1 << dio->blkfactor) - 1;
+	if (tmp & blkmask)
+		count++;
+
+	ret = (*dio->get_blocks)(dio->inode, startblk, count,
 			map_bh, dio->rw == WRITE);
 	if (ret)
 		goto out;
@@ -368,6 +388,13 @@ static int get_more_blocks(struct dio *d
 			dio_bio_submit(dio);
 	}
 	dio->next_block_in_bio = map_bh->b_blocknr;
+	if (dio->blkfactor) {
+		count = (dio->block_in_file & blkmask);
+		dio->next_block_in_bio = (map_bh->b_blocknr << dio->blkfactor);
+		if (!buffer_new(map_bh))
+			dio->next_block_in_bio += count;
+		dio->blocks_available -= count;
+	}
 out:
 	return ret;
 }
@@ -430,6 +457,47 @@ out:
 	return ret;
 }
 
+/*
+ * If we are not writing the entire block and get_block() allocated
+ * the block for us, we need to fill-in the unused portion of the
+ * block with zeros. This happens only if user-buffer, fileoffset or
+ * io length is not filesystem block-size multiple.
+ *
+ * `end' is zero if we're doing the start of the IO, 1 at the end of the
+ * IO.
+ */
+static void dio_zero_block(struct dio *dio, int end)
+{
+	unsigned bmask, blkbits;
+	unsigned this_chunk_bytes, this_chunk_blocks;
+	struct page *page;
+
+	dio->blkadjust = 1;
+	if (!dio->blkfactor || !buffer_new(&dio->map_bh))
+		return;
+
+	bmask = (1 << dio->blkfactor) - 1;
+	blkbits = dio->blkbits;
+
+	this_chunk_blocks = dio->block_in_file & bmask;
+
+	if (!this_chunk_blocks)
+		return;
+
+	this_chunk_bytes = this_chunk_blocks << blkbits;
+	if (end) {
+		this_chunk_bytes = PAGE_SIZE - this_chunk_bytes;
+		this_chunk_blocks = this_chunk_bytes >> blkbits;
+	} 
+
+	page = ZERO_PAGE(dio->cur_user_address);
+	page_cache_get(page);
+	if (dio_bio_add_page(dio, page, this_chunk_bytes, 0)) 
+		return;
+
+	dio->next_block_in_bio += this_chunk_blocks;
+	dio->last_block_in_bio = dio->next_block_in_bio - 1;
+}
 
 /*
  * Walk the user pages, and the file, mapping blocks to disk and emitting BIOs.
@@ -500,6 +568,14 @@ int do_direct_IO(struct dio *dio)
 				new_page = 1;
 			}
 
+			/*
+			 * If we're performing IO which has an alignment which
+			 * is finer than the underlying fs, go check to see if
+			 * we must zero out the start of this block.
+			 */
+			if (dio->blkfactor && !dio->blkadjust)
+				dio_zero_block(dio, 0);
+
 			if (new_page) {
 				bv_len = 0;
 				bv_offset = block_in_page << blkbits;
@@ -541,9 +617,9 @@ out:
 
 int
 direct_io_worker(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
+	loff_t offset, unsigned long nr_segs, unsigned blkbits,
+	get_blocks_t get_blocks)
 {
-	const unsigned blkbits = inode->i_blkbits;
 	unsigned long user_addr; 
 	int seg, ret2, ret = 0;
 	struct dio dio;
@@ -553,6 +629,8 @@ direct_io_worker(int rw, struct inode *i
 	dio.inode = inode;
 	dio.rw = rw;
 	dio.blkbits = blkbits;
+	dio.blkfactor = inode->i_blkbits - blkbits;
+	dio.blkadjust = 0;
 	dio.block_in_file = offset >> blkbits;
 	dio.blocks_available = 0;
 
@@ -606,6 +684,7 @@ direct_io_worker(int rw, struct inode *i
 
 	} /* end iovec loop */
 
+	dio_zero_block(&dio, 1);
 	ret2 = dio_await_completion(&dio);
 	if (ret == 0)
 		ret = ret2;
@@ -619,29 +698,50 @@ direct_io_worker(int rw, struct inode *i
 
 /*
  * This is a library function for use by filesystem drivers.
+ *
+ * If the filesystem wishes to permit sub-blocksize aligned IO then it must
+ * pass in the address of its backing block_device.  If `bdev' is NULL then
+ * we only permit IO with ->i_blkbits alignment and size.
  */
 int
-generic_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
+generic_direct_IO(int rw, struct inode *inode, struct block_device *bdev,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	get_blocks_t get_blocks)
 {
 	int seg;
 	size_t size;
 	unsigned long addr;
-	unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
+	unsigned blkbits = inode->i_blkbits;
+	unsigned bdev_blkbits = 0;
+	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
 
-	if (offset & blocksize_mask)
-		goto out;
+	if (bdev)
+		bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
+
+	if (offset & blocksize_mask) {
+		if (bdev)
+			blkbits = bdev_blkbits;
+		blocksize_mask = (1 << blkbits) - 1;
+		if (offset & blocksize_mask)
+			goto out;
+	}
 
 	/* Check the memory alignment.  Blocks cannot straddle pages */
 	for (seg = 0; seg < nr_segs; seg++) {
 		addr = (unsigned long)iov[seg].iov_base;
 		size = iov[seg].iov_len;
-		if ((addr & blocksize_mask) || (size & blocksize_mask)) 
-			goto out;	
+		if ((addr & blocksize_mask) || (size & blocksize_mask)) {
+			if (bdev)
+				blkbits = bdev_blkbits;
+			blocksize_mask = (1 << blkbits) - 1;
+			if ((addr & blocksize_mask) || (size & blocksize_mask)) 
+				goto out;	
+		}
 	}
 
-	retval = direct_io_worker(rw, inode, iov, offset, nr_segs, get_blocks);
+	retval = direct_io_worker(rw, inode, iov, offset,
+				nr_segs, blkbits, get_blocks);
 out:
 	return retval;
 }
--- 2.5.41/fs/ext2/inode.c~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/fs/ext2/inode.c	Mon Oct  7 15:49:34 2002
@@ -624,7 +624,7 @@ ext2_direct_IO(int rw, struct file *file
 {
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, iov,
+	return generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov,
 				offset, nr_segs, ext2_get_blocks);
 }
 
--- 2.5.41/fs/ext3/inode.c~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/fs/ext3/inode.c	Mon Oct  7 15:49:34 2002
@@ -1431,7 +1431,7 @@ static int ext3_direct_IO(int rw, struct
 		}
 	}
 
-	ret = generic_direct_IO(rw, inode, iov, offset,
+	ret = generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov, offset,
 				nr_segs, ext3_direct_io_get_blocks);
 
 out_stop:
--- 2.5.41/fs/jfs/inode.c~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/fs/jfs/inode.c	Mon Oct  7 15:49:34 2002
@@ -315,7 +315,7 @@ static int jfs_direct_IO(int rw, struct 
 {
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, iov,
+	return generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov,
 				offset, nr_segs, jfs_get_blocks);
 }
 
--- 2.5.41/include/linux/fs.h~dio-fine-alignment	Mon Oct  7 15:49:34 2002
+++ 2.5.41-akpm/include/linux/fs.h	Mon Oct  7 15:49:34 2002
@@ -1245,8 +1245,8 @@ extern ssize_t generic_file_sendfile(str
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
 extern ssize_t generic_file_direct_IO(int rw, struct file *file,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
-extern int generic_direct_IO(int rw, struct inode *inode, const struct iovec 
-	*iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
+extern int generic_direct_IO(int rw, struct inode *inode, struct block_device *bdev,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
 	unsigned long nr_segs, loff_t *ppos);
 ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
--- 2.5.41/fs/xfs/linux/xfs_aops.c~dio-fine-alignment	Mon Oct  7 15:49:45 2002
+++ 2.5.41-akpm/fs/xfs/linux/xfs_aops.c	Mon Oct  7 15:50:21 2002
@@ -688,8 +688,8 @@ linvfs_direct_IO(
 {
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-        return generic_direct_IO(rw, inode, iov, offset, nr_segs,
-					linvfs_get_blocks_direct);
+        return generic_direct_IO(rw, inode, inode->i_sb->s_bdev,
+			iov, offset, nr_segs, linvfs_get_blocks_direct);
 }
 
 STATIC int

.
