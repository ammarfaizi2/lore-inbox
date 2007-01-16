Return-Path: <linux-kernel-owner+w=401wt.eu-S1751326AbXAPChv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAPChv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXAPChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:37:51 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:28254 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751100AbXAPCht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:37:49 -0500
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.55919.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 8/10][RFC] aio: make direct_IO aops use file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:31.0616 (UTC) FILETIME=[6772EA00:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the _locking variant of blockdev_direct_IO to use a generic
endio function, and updates all the FS callsites.

---

 Documentation/filesystems/Locking |    5 +++--
 Documentation/filesystems/vfs.txt |    5 +++--
 fs/block_dev.c                    |    9 ++++-----
 fs/ext2/inode.c                   |   12 +++++-------
 fs/ext3/inode.c                   |   11 +++++------
 fs/ext4/inode.c                   |   11 +++++------
 fs/fat/inode.c                    |   12 ++++++------
 fs/gfs2/ops_address.c             |    8 ++++----
 fs/hfs/inode.c                    |   13 ++++++-------
 fs/hfsplus/inode.c                |   13 ++++++-------
 fs/jfs/inode.c                    |   12 +++++-------
 fs/nfs/direct.c                   |    8 +++++---
 fs/ocfs2/aops.c                   |    9 +++++----
 fs/reiserfs/inode.c               |   13 +++++--------
 fs/xfs/linux-2.6/xfs_aops.c       |   11 ++++++-----
 fs/xfs/linux-2.6/xfs_lrw.c        |    4 ++--
 include/linux/fs.h                |   28 +++++++++++++---------------
 include/linux/nfs_fs.h            |    4 ++--
 mm/filemap.c                      |   34 ++++++++++++++++++----------------
 19 files changed, 108 insertions(+), 114 deletions(-)

---

diff -urpN -X dontdiff a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	2007-01-12 20:26:06.000000000 -0800
+++ b/Documentation/filesystems/Locking	2007-01-12 20:42:37.000000000 -0800
@@ -169,8 +169,9 @@ prototypes:
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs);
+	int (*direct_IO)(int, struct file *, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs,
+			file_endio_t *endio, void *endio_data);
 	int (*launder_page) (struct page *);
 
 locking rules:
diff -urpN -X dontdiff a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
--- a/Documentation/filesystems/vfs.txt	2007-01-12 20:26:06.000000000 -0800
+++ b/Documentation/filesystems/vfs.txt	2007-01-12 20:42:37.000000000 -0800
@@ -537,8 +537,9 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs);
+	ssize_t (*direct_IO)(int, struct file *, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs,
+			file_endio_t *endio, void *endio_data);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
 	/* migrate the contents of a page to the specified target */
diff -urpN -X dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	2007-01-12 20:29:02.000000000 -0800
+++ b/fs/block_dev.c	2007-01-12 20:42:37.000000000 -0800
@@ -222,10 +222,11 @@ static void blk_unget_page(struct page *
 }
 
 static ssize_t
-blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
-		 loff_t pos, unsigned long nr_segs)
+blkdev_direct_IO(int rw, struct file *file, const struct iovec *iov,
+		 loff_t pos, unsigned long nr_segs, file_endio_t *endio,
+		 void *endio_data)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	struct inode *inode = file->f_mapping->host;
 	unsigned blkbits = blksize_bits(bdev_hardsect_size(I_BDEV(inode)));
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	unsigned long seg = 0;	/* iov segment iterator */
@@ -239,8 +240,6 @@ blkdev_direct_IO(int rw, struct kiocb *i
 	loff_t size;		/* size of block device */
 	struct bio *bio;
 	struct bdev_aio stack_io, *io;
-	file_endio_t *endio = aio_complete;
-	void *endio_data = iocb;
 	struct page *page;
 	struct pvec pvec;
 
diff -urpN -X dontdiff a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/ext2/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -752,14 +752,12 @@ static sector_t ext2_bmap(struct address
 }
 
 static ssize_t
-ext2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+ext2_direct_IO(int rw, struct file *file, const struct iovec *iov,
+	       loff_t offset, unsigned long nr_segs, file_endio_t *endio,
+	       void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				offset, nr_segs, ext2_get_block, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				  ext2_get_block, endio, endio_data);
 }
 
 static int
diff -urpN -X dontdiff a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/ext3/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -1681,11 +1681,11 @@ static int ext3_releasepage(struct page 
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static ssize_t ext3_direct_IO(int rw, struct kiocb *iocb,
+static ssize_t ext3_direct_IO(int rw, struct file *file,
 			const struct iovec *iov, loff_t offset,
-			unsigned long nr_segs)
+			unsigned long nr_segs, file_endio_t *endio,
+			void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
@@ -1710,9 +1710,8 @@ static ssize_t ext3_direct_IO(int rw, st
 		}
 	}
 
-	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				 offset, nr_segs,
-				 ext3_get_block, NULL);
+	ret = blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				 ext3_get_block, endio, endio_data);
 
 	/*
 	 * Reacquire the handle: ext3_get_block() can restart the transaction
diff -urpN -X dontdiff a/fs/ext4/inode.c b/fs/ext4/inode.c
--- a/fs/ext4/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/ext4/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -1680,11 +1680,11 @@ static int ext4_releasepage(struct page 
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static ssize_t ext4_direct_IO(int rw, struct kiocb *iocb,
+static ssize_t ext4_direct_IO(int rw, struct file *file,
 			const struct iovec *iov, loff_t offset,
-			unsigned long nr_segs)
+			unsigned long nr_segs, file_endio_t *endio,
+			void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	handle_t *handle = NULL;
@@ -1709,9 +1709,8 @@ static ssize_t ext4_direct_IO(int rw, st
 		}
 	}
 
-	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				 offset, nr_segs,
-				 ext4_get_block, NULL);
+	ret = blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				 ext4_get_block, endio, endio_data);
 
 	/*
 	 * Reacquire the handle: ext4_get_block() can restart the transaction
diff -urpN -X dontdiff a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/fat/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -159,11 +159,11 @@ static int fat_commit_write(struct file 
 	return err;
 }
 
-static ssize_t fat_direct_IO(int rw, struct kiocb *iocb,
-			     const struct iovec *iov,
-			     loff_t offset, unsigned long nr_segs)
+static ssize_t fat_direct_IO(int rw, struct file *file,
+			     const struct iovec *iov, loff_t offset,
+			     unsigned long nr_segs, file_endio_t *endio,
+			     void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 
 	if (rw == WRITE) {
@@ -183,8 +183,8 @@ static ssize_t fat_direct_IO(int rw, str
 	 * FAT need to use the DIO_LOCKING for avoiding the race
 	 * condition of fat_get_block() and ->truncate().
 	 */
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, fat_get_block, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				  fat_get_block, endio, endio_data);
 }
 
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
diff -urpN -X dontdiff a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
--- a/fs/gfs2/ops_address.c	2007-01-12 20:57:42.000000000 -0800
+++ b/fs/gfs2/ops_address.c	2007-01-12 20:42:37.000000000 -0800
@@ -602,11 +602,11 @@ static int gfs2_ok_for_dio(struct gfs2_i
 
 
 
-static ssize_t gfs2_direct_IO(int rw, struct kiocb *iocb,
+static ssize_t gfs2_direct_IO(int rw, struct file *file,
 			      const struct iovec *iov, loff_t offset,
-			      unsigned long nr_segs)
+			      unsigned long nr_segs, file_endio_t *endio,
+			      void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
@@ -630,7 +630,7 @@ static ssize_t gfs2_direct_IO(int rw, st
 
 	rv = blockdev_direct_IO_no_locking(rw, file, iov, offset, nr_segs,
 					   gfs2_get_block_direct, NULL, NULL,
-					   aio_complete, iocb);
+					   endio, endio_data);
 out:
 	gfs2_glock_dq_m(1, &gh);
 	gfs2_holder_uninit(&gh);
diff -urpN -X dontdiff a/fs/hfs/inode.c b/fs/hfs/inode.c
--- a/fs/hfs/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/hfs/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -98,14 +98,13 @@ static int hfs_releasepage(struct page *
 	return res ? try_to_free_buffers(page) : 0;
 }
 
-static ssize_t hfs_direct_IO(int rw, struct kiocb *iocb,
-		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
+static ssize_t hfs_direct_IO(int rw, struct file *file,
+			     const struct iovec *iov, loff_t offset,
+			     unsigned long nr_segs, file_endio_t *endio,
+			     void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_path.dentry->d_inode->i_mapping->host;
-
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, hfs_get_block, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				  hfs_get_block, endio, endio_data);
 }
 
 static int hfs_writepages(struct address_space *mapping,
diff -urpN -X dontdiff a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
--- a/fs/hfsplus/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/hfsplus/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -93,14 +93,13 @@ static int hfsplus_releasepage(struct pa
 	return res ? try_to_free_buffers(page) : 0;
 }
 
-static ssize_t hfsplus_direct_IO(int rw, struct kiocb *iocb,
-		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
+static ssize_t hfsplus_direct_IO(int rw, struct file *file,
+				 const struct iovec *iov,
+				 loff_t offset, unsigned long nr_segs,
+				 file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_path.dentry->d_inode->i_mapping->host;
-
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, hfsplus_get_block, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				  hfsplus_get_block, endio, endio_data);
 }
 
 static int hfsplus_writepages(struct address_space *mapping,
diff -urpN -X dontdiff a/fs/jfs/inode.c b/fs/jfs/inode.c
--- a/fs/jfs/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/jfs/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -287,14 +287,12 @@ static sector_t jfs_bmap(struct address_
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static ssize_t jfs_direct_IO(int rw, struct kiocb *iocb,
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs)
+static ssize_t jfs_direct_IO(int rw, struct file *file,
+		const struct iovec *iov, loff_t offset, unsigned long nr_segs,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				offset, nr_segs, jfs_get_block, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+				  jfs_get_block, endio, endio_data);
 }
 
 const struct address_space_operations jfs_aops = {
diff -urpN -X dontdiff a/fs/nfs/direct.c b/fs/nfs/direct.c
--- a/fs/nfs/direct.c	2007-01-12 20:29:14.000000000 -0800
+++ b/fs/nfs/direct.c	2007-01-12 20:55:00.000000000 -0800
@@ -104,7 +104,7 @@ static inline int put_dreq(struct nfs_di
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
  * @rw: direction (read or write)
- * @iocb: target I/O control block
+ * @file: target file
  * @iov: array of vectors that define I/O buffer
  * @pos: offset in file to begin the operation
  * @nr_segs: size of iovec array
@@ -114,10 +114,12 @@ static inline int put_dreq(struct nfs_di
  * read and write requests before the VFS gets them, so this method
  * should never be called.
  */
-ssize_t nfs_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov, loff_t pos, unsigned long nr_segs)
+ssize_t nfs_direct_IO(int rw, struct file *file, const struct iovec *iov,
+		      loff_t pos, unsigned long nr_segs,
+		      file_endio_t *endio, void *endio_data)
 {
 	dprintk("NFS: nfs_direct_IO (%s) off/no(%Ld/%lu) EINVAL\n",
-			iocb->ki_filp->f_path.dentry->d_name.name,
+			file->f_path.dentry->d_name.name,
 			(long long) pos, nr_segs);
 
 	return -EINVAL;
diff -urpN -X dontdiff a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
--- a/fs/ocfs2/aops.c	2007-01-12 20:57:42.000000000 -0800
+++ b/fs/ocfs2/aops.c	2007-01-12 20:42:37.000000000 -0800
@@ -611,12 +611,13 @@ static void ocfs2_dio_end_io(void *destr
 }
 
 static ssize_t ocfs2_direct_IO(int rw,
-			       struct kiocb *iocb,
+			       struct file *file,
 			       const struct iovec *iov,
 			       loff_t offset,
-			       unsigned long nr_segs)
+			       unsigned long nr_segs,
+			       file_endio_t *endio,
+			       void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_path.dentry->d_inode->i_mapping->host;
 	int ret;
 
@@ -643,7 +644,7 @@ static ssize_t ocfs2_direct_IO(int rw,
 	ret = blockdev_direct_IO_no_locking(rw, file, iov, offset, nr_segs,
 					    ocfs2_direct_IO_get_blocks,
 					    ocfs2_dio_end_io, inode,
-					    aio_complete, iocb);
+					    endio, endio_data);
 out:
 	mlog_exit(ret);
 	return ret;
diff -urpN -X dontdiff a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	2007-01-12 20:26:06.000000000 -0800
+++ b/fs/reiserfs/inode.c	2007-01-12 20:42:37.000000000 -0800
@@ -2888,16 +2888,13 @@ static int reiserfs_releasepage(struct p
 
 /* We thank Mingming Cao for helping us understand in great detail what
    to do in this section of the code. */
-static ssize_t reiserfs_direct_IO(int rw, struct kiocb *iocb,
+static ssize_t reiserfs_direct_IO(int rw, struct file *file,
 				  const struct iovec *iov, loff_t offset,
-				  unsigned long nr_segs)
+				  unsigned long nr_segs, file_endio_t *endio,
+				  void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs,
-				  reiserfs_get_blocks_direct_io, NULL);
+	return blockdev_direct_IO(rw, file, iov, offset, nr_segs,
+			reiserfs_get_blocks_direct_io, endio, endio_data);
 }
 
 int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
--- a/fs/xfs/linux-2.6/xfs_aops.c	2007-01-12 20:57:42.000000000 -0800
+++ b/fs/xfs/linux-2.6/xfs_aops.c	2007-01-12 20:42:38.000000000 -0800
@@ -1361,12 +1361,13 @@ xfs_end_io_direct(
 STATIC ssize_t
 xfs_vm_direct_IO(
 	int			rw,
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	loff_t			offset,
-	unsigned long		nr_segs)
+	unsigned long		nr_segs,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	struct file	*file = iocb->ki_filp;
 	struct inode	*inode = file->f_mapping->host;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 	xfs_iomap_t	iomap;
@@ -1387,13 +1388,13 @@ xfs_vm_direct_IO(
 			iov, offset, nr_segs,
 			xfs_get_blocks_direct,
 			xfs_end_io_direct, ioend,
-			aio_complete, iocb);
+			endio, endio_data);
 	} else {
 		ret = blockdev_direct_IO_no_locking(rw, file,
 			iov, offset, nr_segs,
 			xfs_get_blocks_direct,
 			xfs_end_io_direct, ioend,
-			aio_complete, iocb);
+			endio, endio_data);
 	}
 
 	if (unlikely(ret < 0 && ret != -EIOCBQUEUED))
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_lrw.c b/fs/xfs/linux-2.6/xfs_lrw.c
--- a/fs/xfs/linux-2.6/xfs_lrw.c	2007-01-12 20:26:07.000000000 -0800
+++ b/fs/xfs/linux-2.6/xfs_lrw.c	2007-01-12 20:42:38.000000000 -0800
@@ -836,8 +836,8 @@ retry:
 
  		xfs_rw_enter_trace(XFS_DIOWR_ENTER, io, (void *)iovp, segs,
 				*offset, ioflags);
-		ret = generic_file_direct_write(iocb, iovp,
-				&segs, pos, offset, count, ocount);
+		ret = generic_file_direct_write(file, iovp, &segs, pos,
+				offset, count, ocount, aio_complete, iocb);
 
 		/*
 		 * direct-io write to a hole: fall through to buffered I/O
diff -urpN -X dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2007-01-12 20:57:42.000000000 -0800
+++ b/include/linux/fs.h	2007-01-12 20:42:38.000000000 -0800
@@ -309,6 +309,8 @@ typedef int (get_block_t)(struct inode *
 typedef void (dio_iodone_t)(void *destructor_data, ssize_t bytes,
 			void *private);
 
+typedef void (file_endio_t)(void *endio_data, ssize_t count, int err);
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -421,8 +423,9 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, gfp_t);
-	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs);
+	ssize_t (*direct_IO)(int rw, struct file *file, const struct iovec *iov,
+			     loff_t offset, unsigned long nr_segs,
+			     file_endio_t *endio, void *endio_data);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
 	/* migrate the contents of a page to the specified target */
@@ -1109,8 +1112,6 @@ typedef int (*read_actor_t)(read_descrip
 #define HAVE_COMPAT_IOCTL 1
 #define HAVE_UNLOCKED_IOCTL 1
 
-typedef void (file_endio_t)(void *endio_data, ssize_t count, int err);
-
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev, unlocked_ioctl and compat_ioctl
@@ -1772,8 +1773,9 @@ extern ssize_t generic_file_aio_read(str
 extern ssize_t generic_file_aio_write(struct kiocb *, const struct iovec *, unsigned long, loff_t);
 extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t);
-extern ssize_t generic_file_direct_write(struct kiocb *, const struct iovec *,
-		unsigned long *, loff_t, loff_t *, size_t, size_t);
+extern ssize_t generic_file_direct_write(struct file *, const struct iovec *,
+					unsigned long *, loff_t, loff_t *,
+					size_t, size_t, file_endio_t, void *);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
@@ -1844,16 +1846,12 @@ enum {
 	DIO_OWN_LOCKING, /* filesystem locks buffered and direct internally */
 };
 
-static inline ssize_t blockdev_direct_IO(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_block_t get_block,
-	dio_iodone_t end_io)
-{
-	struct file *file = iocb->ki_filp;
-	file_endio_t *file_endio = &aio_complete;
-	void *endio_data = iocb;
+static inline ssize_t blockdev_direct_IO(int rw, struct file *file,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs,
+	get_block_t get_block, file_endio_t file_endio, void *endio_data)
+{
 	return __blockdev_direct_IO(rw, file, iov, offset, nr_segs, get_block,
-			end_io, NULL, file_endio, endio_data, DIO_LOCKING);
+			NULL, NULL, file_endio, endio_data, DIO_LOCKING);
 }
 
 static inline ssize_t blockdev_direct_IO_no_locking(int rw, struct file *file,
diff -urpN -X dontdiff a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
--- a/include/linux/nfs_fs.h	2007-01-12 20:29:14.000000000 -0800
+++ b/include/linux/nfs_fs.h	2007-01-12 20:42:38.000000000 -0800
@@ -367,8 +367,8 @@ extern int nfs3_removexattr (struct dent
 /*
  * linux/fs/nfs/direct.c
  */
-extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
-			unsigned long);
+extern ssize_t nfs_direct_IO(int, struct file *, const struct iovec *, loff_t,
+			unsigned long, file_endio_t, void *);
 extern ssize_t nfs_file_direct_read(struct file *file,
 			const struct iovec *iov, unsigned long nr_segs,
 			loff_t *pos, file_endio_t *endio, void *endio_data);
diff -urpN -X dontdiff a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2007-01-12 20:26:07.000000000 -0800
+++ b/mm/filemap.c	2007-01-12 20:42:38.000000000 -0800
@@ -41,8 +41,9 @@
 #include <asm/mman.h>
 
 static ssize_t
-generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs);
+generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs,
+			file_endio_t *endio, void *endio_data);
 
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
@@ -1223,8 +1224,8 @@ generic_file_aio_read(struct kiocb *iocb
 			goto out; /* skip atime */
 		size = i_size_read(inode);
 		if (pos < size) {
-			retval = generic_file_direct_IO(READ, iocb,
-						iov, pos, nr_segs);
+			retval = generic_file_direct_IO(READ, filp, iov, pos,
+						nr_segs, aio_complete, iocb);
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
@@ -2078,11 +2079,10 @@ inline int generic_write_checks(struct f
 EXPORT_SYMBOL(generic_write_checks);
 
 ssize_t
-generic_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long *nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, size_t ocount)
+generic_file_direct_write(struct file *file, const struct iovec *iov,
+		unsigned long *nr_segs, loff_t pos, loff_t *ppos, size_t count,
+		size_t ocount, file_endio_t *endio, void *endio_data)
 {
-	struct file	*file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode	*inode = mapping->host;
 	ssize_t		written;
@@ -2090,7 +2090,8 @@ generic_file_direct_write(struct kiocb *
 	if (count != ocount)
 		*nr_segs = iov_shorten((struct iovec *)iov, *nr_segs, count);
 
-	written = generic_file_direct_IO(WRITE, iocb, iov, pos, *nr_segs);
+	written = generic_file_direct_IO(WRITE, file, iov, pos,
+					 *nr_segs, endio, endio_data);
 	if (written > 0) {
 		loff_t end = pos + written;
 		if (end > i_size_read(inode) && !S_ISBLK(inode->i_mode)) {
@@ -2343,8 +2344,9 @@ __generic_file_aio_write_nolock(struct k
 		loff_t endbyte;
 		ssize_t written_buffered;
 
-		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
-							ppos, count, ocount);
+		written = generic_file_direct_write(file, iov, &nr_segs, pos,
+							ppos, count, ocount,
+							aio_complete, iocb);
 		if (written < 0 || written == count)
 			goto out;
 		/*
@@ -2457,10 +2459,10 @@ EXPORT_SYMBOL(generic_file_aio_write);
  * went wrong during pagecache shootdown.
  */
 static ssize_t
-generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs)
+generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
+	loff_t offset, unsigned long nr_segs,
+	file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	ssize_t retval;
 	size_t write_len = 0;
@@ -2478,8 +2480,8 @@ generic_file_direct_IO(int rw, struct ki
 
 	retval = filemap_write_and_wait(mapping);
 	if (retval == 0) {
-		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
-						offset, nr_segs);
+		retval = mapping->a_ops->direct_IO(rw, file, iov, offset,
+						nr_segs, endio, endio_data);
 		if (rw == WRITE && mapping->nrpages) {
 			pgoff_t end = (offset + write_len - 1)
 						>> PAGE_CACHE_SHIFT;
