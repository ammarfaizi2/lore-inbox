Return-Path: <linux-kernel-owner+w=401wt.eu-S932348AbXAPCFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXAPCFG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXAPCD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:56 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932231AbXAPCDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:31 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
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
Message-Id: <20070116015450.9764.80972.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 10/10][RFC] aio: convert file aio to file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:41.0773 (UTC) FILETIME=[6D80BFD0:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the file_operation function prototypes to the new file_endio_t
approach.  This doesn't change much code in the file systems, just some
straightforward conversions in mm/filemap.c.  It also fixes up callers of
the f_op interface, including some code restructuring in fs/read_write.c,
fs/compat.c, and fs/aio.c.  Other than that and removing ntfs's redundant
readv_writev thing, this should be pure callsite fixes.

---

 Documentation/filesystems/Locking |    6 -
 Documentation/filesystems/vfs.txt |    6 -
 arch/s390/hypfs/inode.c           |   16 +-
 drivers/net/tun.c                 |   13 +-
 fs/aio.c                          |   15 +-
 fs/bad_inode.c                    |   10 +
 fs/cifs/cifsfs.c                  |   10 +
 fs/compat.c                       |   56 ---------
 fs/ecryptfs/file.c                |   16 +-
 fs/ext3/file.c                    |    9 -
 fs/ext4/file.c                    |    9 -
 fs/fuse/dev.c                     |   13 +-
 fs/nfs/file.c                     |   56 +++++----
 fs/ntfs/file.c                    |   71 ++---------
 fs/ocfs2/file.c                   |   22 ++-
 fs/pipe.c                         |   12 +-
 fs/read_write.c                   |  225 ++++++++++++--------------------------
 fs/read_write.h                   |    8 -
 fs/smbfs/file.c                   |   22 ++-
 fs/udf/file.c                     |   11 +
 fs/xfs/linux-2.6/xfs_file.c       |   58 +++++----
 fs/xfs/linux-2.6/xfs_lrw.c        |   25 +---
 fs/xfs/linux-2.6/xfs_lrw.h        |   10 +
 fs/xfs/linux-2.6/xfs_vnode.h      |   20 ++-
 include/linux/fs.h                |   27 ++--
 mm/filemap.c                      |   75 ++++++------
 net/socket.c                      |   32 +++--
 sound/core/pcm_native.c           |   15 +-
 28 files changed, 377 insertions(+), 491 deletions(-)

---

diff -urpN -X dontdiff a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
--- a/arch/s390/hypfs/inode.c	2007-01-12 20:25:40.935112866 -0800
+++ b/arch/s390/hypfs/inode.c	2007-01-13 19:40:25.044918589 -0800
@@ -134,12 +134,13 @@ static int hypfs_open(struct inode *inod
 	return 0;
 }
 
-static ssize_t hypfs_aio_read(struct kiocb *iocb, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t offset)
+static ssize_t hypfs_aio_read(struct file *filp, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *ppos,
+			      file_endio_t *endio, void *endio_data)
 {
 	char *data;
 	size_t len;
-	struct file *filp = iocb->ki_filp;
+	loff_t offset = *ppos;
 	/* XXX: temporary */
 	char __user *buf = iov[0].iov_base;
 	size_t count = iov[0].iov_len;
@@ -161,20 +162,21 @@ static ssize_t hypfs_aio_read(struct kio
 		count = -EFAULT;
 		goto out;
 	}
-	iocb->ki_pos += count;
+	*ppos += count;
 	file_accessed(filp);
 out:
 	return count;
 }
-static ssize_t hypfs_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t offset)
+static ssize_t hypfs_aio_write(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *ppos,
+			      file_endio_t *endio, void *endio_data)
 {
 	int rc;
 	struct super_block *sb;
 	struct hypfs_sb_info *fs_info;
 	size_t count = iov_length(iov, nr_segs);
 
-	sb = iocb->ki_filp->f_path.dentry->d_inode->i_sb;
+	sb = file->f_path.dentry->d_inode->i_sb;
 	fs_info = sb->s_fs_info;
 	/*
 	 * Currently we only allow one update per second for two reasons:
diff -urpN -X dontdiff a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	2007-01-12 21:01:00.309877970 -0800
+++ b/Documentation/filesystems/Locking	2007-01-13 19:40:25.086904233 -0800
@@ -366,8 +366,10 @@ prototypes:
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
-	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_read) (struct file *, const struct iovec *,
+			unsigned long, loff_t, file_endio_t *, void *);
+	ssize_t (*aio_write) (struct file *, const struct iovec *,
+			unsigned long, loff_t, file_endio_t *, void *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int,
diff -urpN -X dontdiff a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
--- a/Documentation/filesystems/vfs.txt	2007-01-12 21:01:00.319874553 -0800
+++ b/Documentation/filesystems/vfs.txt	2007-01-13 19:40:25.100899447 -0800
@@ -701,8 +701,10 @@ struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
-	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_read) (struct file *, const struct iovec *,
+			unsigned long, loff_t, file_endio_t *, void *);
+	ssize_t (*aio_write) (struct file *, const struct iovec *,
+			unsigned long, loff_t, file_endio_t *, void *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
diff -urpN -X dontdiff a/drivers/net/tun.c b/drivers/net/tun.c
--- a/drivers/net/tun.c	2007-01-12 20:25:40.954106374 -0800
+++ b/drivers/net/tun.c	2007-01-13 19:40:25.118893295 -0800
@@ -288,10 +288,11 @@ static inline size_t iov_total(const str
 	return len;
 }
 
-static ssize_t tun_chr_aio_write(struct kiocb *iocb, const struct iovec *iv,
-			      unsigned long count, loff_t pos)
+static ssize_t tun_chr_aio_write(struct file *file, const struct iovec *iv,
+			      unsigned long count, loff_t *ppos,
+			      file_endio_t *endio, void *data)
 {
-	struct tun_struct *tun = iocb->ki_filp->private_data;
+	struct tun_struct *tun = file->private_data;
 
 	if (!tun)
 		return -EBADFD;
@@ -334,10 +335,10 @@ static __inline__ ssize_t tun_put_user(s
 	return total;
 }
 
-static ssize_t tun_chr_aio_read(struct kiocb *iocb, const struct iovec *iv,
-			    unsigned long count, loff_t pos)
+static ssize_t tun_chr_aio_read(struct file *file, const struct iovec *iv,
+			    unsigned long count, loff_t *ppos,
+			    file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct tun_struct *tun = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	struct sk_buff *skb;
diff -urpN -X dontdiff a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	2007-01-12 20:25:25.333445836 -0800
+++ b/fs/aio.c	2007-01-15 14:01:29.896558897 -0800
@@ -1317,8 +1317,8 @@ static int aio_rw_vect_retry(struct kioc
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	ssize_t (*rw_op)(struct kiocb *, const struct iovec *,
-			 unsigned long, loff_t);
+	ssize_t (*rw_op)(struct file *, const struct iovec *,
+			 unsigned long, loff_t *, file_endio_t *, void *);
 	ssize_t ret = 0;
 	unsigned short opcode;
 
@@ -1332,9 +1332,9 @@ static int aio_rw_vect_retry(struct kioc
 	}
 
 	do {
-		ret = rw_op(iocb, &iocb->ki_iovec[iocb->ki_cur_seg],
+		ret = rw_op(file, &iocb->ki_iovec[iocb->ki_cur_seg],
 			    iocb->ki_nr_segs - iocb->ki_cur_seg,
-			    iocb->ki_pos);
+			    &iocb->ki_pos, aio_complete, iocb);
 		if (ret > 0)
 			aio_advance_iovec(iocb, ret);
 
@@ -1376,9 +1376,12 @@ static ssize_t aio_setup_vectored_rw(int
 {
 	ssize_t ret;
 
+	ret = iov_check_alloc(kiocb->ki_nbytes, 1, &kiocb->ki_iovec);
+	if (ret < 0)
+		goto out;
+
 	ret = rw_copy_check_uvector(type, (struct iovec __user *)kiocb->ki_buf,
-				    kiocb->ki_nbytes, 1,
-				    &kiocb->ki_inline_vec, &kiocb->ki_iovec);
+				    kiocb->ki_nbytes, kiocb->ki_iovec);
 	if (ret < 0)
 		goto out;
 
diff -urpN -X dontdiff a/fs/bad_inode.c b/fs/bad_inode.c
--- a/fs/bad_inode.c	2007-01-12 20:25:25.345441736 -0800
+++ b/fs/bad_inode.c	2007-01-13 19:40:57.729742591 -0800
@@ -34,14 +34,16 @@ static ssize_t bad_file_write(struct fil
         return -EIO;
 }
 
-static ssize_t bad_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-			unsigned long nr_segs, loff_t pos)
+static ssize_t bad_file_aio_read(struct file *file, const struct iovec *iov,
+			unsigned long nr_segs, loff_t *ppos,
+			file_endio_t *endio, void *endio_data)
 {
 	return -EIO;
 }
 
-static ssize_t bad_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			unsigned long nr_segs, loff_t pos)
+static ssize_t bad_file_aio_write(struct file *file, const struct iovec *iov,
+			unsigned long nr_segs, loff_t *ppos,
+			file_endio_t *endio, void *endio_data)
 {
 	return -EIO;
 }
diff -urpN -X dontdiff a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	2007-01-12 20:25:34.663256715 -0800
+++ b/fs/cifs/cifsfs.c	2007-01-15 14:04:03.132189370 -0800
@@ -495,13 +495,15 @@ cifs_get_sb(struct file_system_type *fs_
 	return simple_set_mnt(mnt, sb);
 }
 
-static ssize_t cifs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-				   unsigned long nr_segs, loff_t pos)
+static ssize_t cifs_file_aio_write(struct file *file, const struct iovec *iov,
+				   unsigned long nr_segs, loff_t *ppos,
+				   file_endio_t *endio, void *endio_data)
 {
-	struct inode *inode = iocb->ki_filp->f_path.dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	ssize_t written;
 
-	written = generic_file_aio_write(iocb, iov, nr_segs, pos);
+	written = generic_file_aio_write(file, iov, nr_segs, ppos,
+					 endio, endio_data);
 	if (!CIFS_I(inode)->clientCanCacheAll)
 		filemap_fdatawrite(inode->i_mapping);
 	return written;
diff -urpN -X dontdiff a/fs/compat.c b/fs/compat.c
--- a/fs/compat.c	2007-01-12 20:25:18.270859974 -0800
+++ b/fs/compat.c	2007-01-15 13:50:40.019640964 -0800
@@ -1166,33 +1166,15 @@ static ssize_t compat_do_readv_writev(in
 	struct iovec *iov=iovstack, *vector;
 	ssize_t ret;
 	int seg;
-	io_fn_t fn;
-	iov_fn_t fnv;
 
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	ret = 0;
-	if (nr_segs == 0)
+	ret = iov_check_alloc(nr_segs, UIO_FASTIOV, &iov);
+	if (ret <= 0)
 		goto out;
 
 	/*
 	 * First get the "struct iovec" from user memory and
 	 * verify all the pointers
 	 */
-	ret = -EINVAL;
-	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
-		goto out;
-	if (!file->f_op)
-		goto out;
-	if (nr_segs > UIO_FASTIOV) {
-		ret = -ENOMEM;
-		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			goto out;
-	}
 	ret = -EFAULT;
 	if (!access_ok(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
 		goto out;
@@ -1227,44 +1209,12 @@ static ssize_t compat_do_readv_writev(in
 		uvector++;
 		vector++;
 	}
-	if (tot_len == 0) {
-		ret = 0;
-		goto out;
-	}
-
-	ret = rw_verify_area(type, file, pos, tot_len);
-	if (ret < 0)
-		goto out;
-
-	ret = security_file_permission(file, type == READ ? MAY_READ:MAY_WRITE);
-	if (ret)
-		goto out;
-
-	fnv = NULL;
-	if (type == READ) {
-		fn = file->f_op->read;
-		fnv = file->f_op->aio_read;
-	} else {
-		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->aio_write;
-	}
 
-	if (fnv)
-		ret = do_sync_readv_writev(file, iov, nr_segs, tot_len,
-						pos, fnv);
-	else
-		ret = do_loop_readv_writev(file, iov, nr_segs, pos, fn);
+	ret = do_loop_readv_writev(type, file, iov, nr_segs, pos, tot_len);
 
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0) {
-		struct dentry *dentry = file->f_path.dentry;
-		if (type == READ)
-			fsnotify_access(dentry);
-		else
-			fsnotify_modify(dentry);
-	}
 	return ret;
 }
 
diff -urpN -X dontdiff a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
--- a/fs/ecryptfs/file.c	2007-01-12 20:25:40.984096123 -0800
+++ b/fs/ecryptfs/file.c	2007-01-13 19:17:04.574709230 -0800
@@ -100,27 +100,29 @@ out:
  * returns without any errors. This is to be used only for file reads.
  * The function to be used for directory reads is ecryptfs_read.
  */
-static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
+static ssize_t ecryptfs_read_update_atime(struct file *file,
 				const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos)
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data)
 {
 	int rc;
 	struct dentry *lower_dentry;
 	struct vfsmount *lower_vfsmount;
-	struct file *file = iocb->ki_filp;
 
-	rc = generic_file_aio_read(iocb, iov, nr_segs, pos);
 	/*
 	 * Even though this is a async interface, we need to wait
 	 * for IO to finish to update atime
 	 */
-	if (-EIOCBQUEUED == rc)
-		rc = wait_on_sync_kiocb(iocb);
+	rc = generic_file_aio_read(file, iov, nr_segs, ppos, NULL, NULL);
 	if (rc >= 0) {
 		lower_dentry = ecryptfs_dentry_to_lower(file->f_path.dentry);
 		lower_vfsmount = ecryptfs_dentry_to_lower_mnt(file->f_path.dentry);
 		touch_atime(lower_vfsmount, lower_dentry);
-	}
+		if (endio)
+			endio(endio_data, rc, 0);
+	} else if (endio)
+		endio(endio_data, 0, rc);
+
 	return rc;
 }
 
diff -urpN -X dontdiff a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	2007-01-12 20:25:34.687248514 -0800
+++ b/fs/ext3/file.c	2007-01-13 19:40:25.144884407 -0800
@@ -48,15 +48,16 @@ static int ext3_release_file (struct ino
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+ext3_file_write(struct file *file, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_path.dentry->d_inode;
 	ssize_t ret;
 	int err;
 
-	ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
+	ret = generic_file_aio_write(file, iov, nr_segs, ppos,
+				     endio, endio_data);
 
 	/*
 	 * Skip flushing if there was an error, or if nothing was written.
diff -urpN -X dontdiff a/fs/ext4/file.c b/fs/ext4/file.c
--- a/fs/ext4/file.c	2007-01-12 20:25:34.713239630 -0800
+++ b/fs/ext4/file.c	2007-01-13 19:40:25.165877229 -0800
@@ -48,15 +48,16 @@ static int ext4_release_file (struct ino
 }
 
 static ssize_t
-ext4_file_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+ext4_file_write(struct file *file, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_path.dentry->d_inode;
 	ssize_t ret;
 	int err;
 
-	ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
+	ret = generic_file_aio_write(file, iov, nr_segs, ppos,
+				     endio, endio_data);
 
 	/*
 	 * Skip flushing if there was an error, or if nothing was written.
diff -urpN -X dontdiff a/fs/fuse/dev.c b/fs/fuse/dev.c
--- a/fs/fuse/dev.c	2007-01-12 20:25:40.991093731 -0800
+++ b/fs/fuse/dev.c	2007-01-13 19:40:25.185870393 -0800
@@ -680,15 +680,15 @@ static int fuse_read_interrupt(struct fu
  * request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
-static ssize_t fuse_dev_read(struct kiocb *iocb, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t pos)
+static ssize_t fuse_dev_read(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *ppos,
+			      file_endio_t *endio, void *endio_data)
 {
 	int err;
 	struct fuse_req *req;
 	struct fuse_in *in;
 	struct fuse_copy_state cs;
 	unsigned reqsize;
-	struct file *file = iocb->ki_filp;
 	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
 		return -EPERM;
@@ -806,15 +806,16 @@ static int copy_out_args(struct fuse_cop
  * it from the list and copy the rest of the buffer to the request.
  * The request is finished by calling request_end()
  */
-static ssize_t fuse_dev_write(struct kiocb *iocb, const struct iovec *iov,
-			       unsigned long nr_segs, loff_t pos)
+static ssize_t fuse_dev_write(struct file *file, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t *ppos,
+			       file_endio_t *endio, void *endio_data)
 {
 	int err;
 	unsigned nbytes = iov_length(iov, nr_segs);
 	struct fuse_req *req;
 	struct fuse_out_header oh;
 	struct fuse_copy_state cs;
-	struct fuse_conn *fc = fuse_get_conn(iocb->ki_filp);
+	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
 		return -EPERM;
 
diff -urpN -X dontdiff a/fs/nfs/file.c b/fs/nfs/file.c
--- a/fs/nfs/file.c	2007-01-12 20:29:14.876994716 -0800
+++ b/fs/nfs/file.c	2007-01-13 19:40:25.207862873 -0800
@@ -41,10 +41,12 @@ static int nfs_file_release(struct inode
 static loff_t nfs_file_llseek(struct file *file, loff_t offset, int origin);
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
-static ssize_t nfs_file_read(struct kiocb *, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos);
-static ssize_t nfs_file_write(struct kiocb *, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos);
+static ssize_t nfs_file_read(struct file *, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data);
+static ssize_t nfs_file_write(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data);
 static int  nfs_file_flush(struct file *, fl_owner_t id);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 static int nfs_check_flags(int flags);
@@ -198,28 +200,30 @@ nfs_file_flush(struct file *file, fl_own
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+nfs_file_read(struct file *file, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos,
+		file_endio_t *endio, void *endio_data)
 {
-	struct dentry * dentry = iocb->ki_filp->f_path.dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 	size_t count = iov_length(iov, nr_segs);
 
 #ifdef CONFIG_NFS_DIRECTIO
-	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_read(iocb->ki_filp, iov, nr_segs,
-					    &iocb->ki_pos, aio_complete, iocb);
+	if (file->f_flags & O_DIRECT)
+		return nfs_file_direct_read(file, iov, nr_segs,
+					    ppos, endio, endio_data);
 #endif
 
 	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		(unsigned long) count, (unsigned long) pos);
+		(unsigned long) count, (unsigned long) *ppos);
 
-	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
+	result = nfs_revalidate_mapping(inode, file->f_mapping);
 	nfs_add_stats(inode, NFSIOS_NORMALREADBYTES, count);
 	if (!result)
-		result = generic_file_aio_read(iocb, iov, nr_segs, pos);
+		result = generic_file_aio_read(file, iov, nr_segs, ppos,
+					       endio, endio_data);
 	return result;
 }
 
@@ -341,23 +345,24 @@ const struct address_space_operations nf
 	.launder_page = nfs_launder_page,
 };
 
-static ssize_t nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos)
+static ssize_t nfs_file_write(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data)
 {
-	struct dentry * dentry = iocb->ki_filp->f_path.dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 	size_t count = iov_length(iov, nr_segs);
 
 #ifdef CONFIG_NFS_DIRECTIO
-	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_write(iocb->ki_filp, iov, nr_segs,
-					     &iocb->ki_pos, aio_complete, iocb);
+	if (file->f_flags & O_DIRECT)
+		return nfs_file_direct_write(file, iov, nr_segs,
+					     ppos, endio, endio_data);
 #endif
 
 	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%Ld)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (long long) pos);
+		inode->i_ino, (unsigned long) count, (long long) *ppos);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -365,8 +370,8 @@ static ssize_t nfs_file_write(struct kio
 	/*
 	 * O_APPEND implies that we must revalidate the file length.
 	 */
-	if (iocb->ki_filp->f_flags & O_APPEND) {
-		result = nfs_revalidate_file_size(inode, iocb->ki_filp);
+	if (file->f_flags & O_APPEND) {
+		result = nfs_revalidate_file_size(inode, file);
 		if (result)
 			goto out;
 	}
@@ -376,10 +381,11 @@ static ssize_t nfs_file_write(struct kio
 		goto out;
 
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, count);
-	result = generic_file_aio_write(iocb, iov, nr_segs, pos);
+	result = generic_file_aio_write(file, iov, nr_segs, ppos,
+					endio, endio_data);
 	/* Return error values for O_SYNC and IS_SYNC() */
-	if (result >= 0 && (IS_SYNC(inode) || (iocb->ki_filp->f_flags & O_SYNC))) {
-		int err = nfs_fsync(iocb->ki_filp, dentry, 1);
+	if (result >= 0 && (IS_SYNC(inode) || (file->f_flags & O_SYNC))) {
+		int err = nfs_fsync(file, dentry, 1);
 		if (err < 0)
 			result = err;
 	}
diff -urpN -X dontdiff a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2007-01-12 20:25:34.804208535 -0800
+++ b/fs/ntfs/file.c	2007-01-13 19:40:25.229855353 -0800
@@ -1808,11 +1808,11 @@ err_out:
  *
  * Locking: The vfs is holding ->i_mutex on the inode.
  */
-static ssize_t ntfs_file_buffered_write(struct kiocb *iocb,
+static ssize_t ntfs_file_buffered_write(struct file *file,
 		const struct iovec *iov, unsigned long nr_segs,
-		loff_t pos, loff_t *ppos, size_t count)
+		loff_t pos, loff_t *ppos, size_t count,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *vi = mapping->host;
 	ntfs_inode *ni = NTFS_I(vi);
@@ -2108,7 +2108,7 @@ err_out:
 	/* For now, when the user asks for O_SYNC, we actually give O_DSYNC. */
 	if (likely(!status)) {
 		if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(vi))) {
-			if (!mapping->a_ops->writepage || !is_sync_kiocb(iocb))
+			if (!mapping->a_ops->writepage || endio)
 				status = generic_osync_inode(vi, mapping,
 						OSYNC_METADATA|OSYNC_DATA);
 		}
@@ -2123,10 +2123,10 @@ err_out:
 /**
  * ntfs_file_aio_write_nolock -
  */
-static ssize_t ntfs_file_aio_write_nolock(struct kiocb *iocb,
-		const struct iovec *iov, unsigned long nr_segs, loff_t *ppos)
+static ssize_t ntfs_file_aio_write_nolock(struct file *file,
+		const struct iovec *iov, unsigned long nr_segs, loff_t *ppos,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	loff_t pos;
@@ -2166,8 +2166,8 @@ static ssize_t ntfs_file_aio_write_noloc
 	if (err)
 		goto out;
 	file_update_time(file);
-	written = ntfs_file_buffered_write(iocb, iov, nr_segs, pos, ppos,
-			count);
+	written = ntfs_file_buffered_write(file, iov, nr_segs, pos, ppos,
+			count, endio, endio_data);
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
@@ -2176,46 +2176,17 @@ out:
 /**
  * ntfs_file_aio_write -
  */
-static ssize_t ntfs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+static ssize_t ntfs_file_aio_write(struct file *file, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, file_endio_t *endio,
+		void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
 
-	BUG_ON(iocb->ki_pos != pos);
-
-	mutex_lock(&inode->i_mutex);
-	ret = ntfs_file_aio_write_nolock(iocb, iov, nr_segs, &iocb->ki_pos);
-	mutex_unlock(&inode->i_mutex);
-	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		int err = sync_page_range(inode, mapping, pos, ret);
-		if (err < 0)
-			ret = err;
-	}
-	return ret;
-}
-
-/**
- * ntfs_file_writev -
- *
- * Basically the same as generic_file_writev() except that it ends up calling
- * ntfs_file_aio_write_nolock() instead of __generic_file_aio_write_nolock().
- */
-static ssize_t ntfs_file_writev(struct file *file, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	struct kiocb kiocb;
-	ssize_t ret;
-
 	mutex_lock(&inode->i_mutex);
-	init_sync_kiocb(&kiocb, file);
-	ret = ntfs_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (ret == -EIOCBQUEUED)
-		ret = wait_on_sync_kiocb(&kiocb);
+	ret = ntfs_file_aio_write_nolock(file, iov, nr_segs, ppos,
+					 endio, endio_data);
 	mutex_unlock(&inode->i_mutex);
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		int err = sync_page_range(inode, mapping, *ppos - ret, ret);
@@ -2226,18 +2197,6 @@ static ssize_t ntfs_file_writev(struct f
 }
 
 /**
- * ntfs_file_write - simple wrapper for ntfs_file_writev()
- */
-static ssize_t ntfs_file_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
-
-	return ntfs_file_writev(file, &local_iov, 1, ppos);
-}
-
-/**
  * ntfs_file_fsync - sync a file to disk
  * @filp:	file to be synced
  * @dentry:	dentry describing the file to sync
@@ -2299,7 +2258,7 @@ const struct file_operations ntfs_file_o
 	.read		= do_sync_read,		 /* Read from file. */
 	.aio_read	= generic_file_aio_read, /* Async read from file. */
 #ifdef NTFS_RW
-	.write		= ntfs_file_write,	 /* Write to file. */
+	.write		= do_sync_write,	 /* Write to file. */
 	.aio_write	= ntfs_file_aio_write,	 /* Async write to file. */
 	/*.release	= ,*/			 /* Last file is closed.  See
 						    fs/ext2/file.c::
diff -urpN -X dontdiff a/fs/ocfs2/file.c b/fs/ocfs2/file.c
--- a/fs/ocfs2/file.c	2007-01-12 20:57:42.316535054 -0800
+++ b/fs/ocfs2/file.c	2007-01-15 14:05:56.482450568 -0800
@@ -1141,13 +1141,14 @@ out:
 	return ret;
 }
 
-static ssize_t ocfs2_file_aio_write(struct kiocb *iocb,
+static ssize_t ocfs2_file_aio_write(struct file *filp,
 				    const struct iovec *iov,
 				    unsigned long nr_segs,
-				    loff_t pos)
+				    loff_t *ppos,
+				    file_endio_t *endio,
+				    void *endio_data)
 {
 	int ret, rw_level, have_alloc_sem = 0;
-	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_path.dentry->d_inode;
 	int appending = filp->f_flags & O_APPEND ? 1 : 0;
 
@@ -1176,14 +1177,15 @@ static ssize_t ocfs2_file_aio_write(stru
 		goto out;
 	}
 
-	ret = ocfs2_prepare_inode_for_write(filp->f_path.dentry, &iocb->ki_pos,
+	ret = ocfs2_prepare_inode_for_write(filp->f_path.dentry, ppos,
 					iov_length(iov, nr_segs), appending);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out;
 	}
 
-	ret = generic_file_aio_write_nolock(iocb, iov, nr_segs, iocb->ki_pos);
+	ret = generic_file_aio_write_nolock(filp, iov, nr_segs, ppos,
+					    endio, endio_data);
 
 	/* buffered aio wouldn't have proper lock coverage today */
 	BUG_ON(ret == -EIOCBQUEUED && !(filp->f_flags & O_DIRECT));
@@ -1286,13 +1288,14 @@ bail:
 	return ret;
 }
 
-static ssize_t ocfs2_file_aio_read(struct kiocb *iocb,
+static ssize_t ocfs2_file_aio_read(struct file *filp,
 				   const struct iovec *iov,
 				   unsigned long nr_segs,
-				   loff_t pos)
+				   loff_t *ppos,
+				   file_endio_t *endio,
+				   void *endio_data)
 {
 	int ret = 0, rw_level = -1, have_alloc_sem = 0, lock_level = 0;
-	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_path.dentry->d_inode;
 
 	mlog_entry("(0x%p, %u, '%.*s')\n", filp,
@@ -1338,7 +1341,8 @@ static ssize_t ocfs2_file_aio_read(struc
 	}
 	ocfs2_meta_unlock(inode, lock_level);
 
-	ret = generic_file_aio_read(iocb, iov, nr_segs, iocb->ki_pos);
+	ret = generic_file_aio_read(filp, iov, nr_segs, ppos,
+				    endio, endio_data);
 	if (ret == -EINVAL)
 		mlog(ML_ERROR, "generic_file_aio_read returned -EINVAL\n");
 
diff -urpN -X dontdiff a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	2007-01-12 20:25:41.014085872 -0800
+++ b/fs/pipe.c	2007-01-13 19:40:25.273840313 -0800
@@ -218,10 +218,10 @@ static const struct pipe_buf_operations 
 };
 
 static ssize_t
-pipe_read(struct kiocb *iocb, const struct iovec *_iov,
-	   unsigned long nr_segs, loff_t pos)
+pipe_read(struct file *filp, const struct iovec *_iov,
+	   unsigned long nr_segs, loff_t *ppos,
+	   file_endio_t *endio, void *endio_data)
 {
-	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	int do_wakeup;
@@ -331,10 +331,10 @@ redo:
 }
 
 static ssize_t
-pipe_write(struct kiocb *iocb, const struct iovec *_iov,
-	    unsigned long nr_segs, loff_t ppos)
+pipe_write(struct file *filp, const struct iovec *_iov,
+	    unsigned long nr_segs, loff_t *ppos,
+	    file_endio_t *endio, void *endio_data)
 {
-	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	ssize_t ret;
diff -urpN -X dontdiff a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	2007-01-12 20:25:18.297850748 -0800
+++ b/fs/read_write.c	2007-01-15 14:01:11.288918160 -0800
@@ -217,37 +217,11 @@ Einval:
 	return -EINVAL;
 }
 
-static void wait_on_retry_sync_kiocb(struct kiocb *iocb)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (!kiocbIsKicked(iocb))
-		schedule();
-	else
-		kiocbClearKicked(iocb);
-	__set_current_state(TASK_RUNNING);
-}
-
 ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
-	struct kiocb kiocb;
-	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
-	kiocb.ki_left = len;
-
-	for (;;) {
-		ret = filp->f_op->aio_read(&kiocb, &iov, 1, kiocb.ki_pos);
-		if (ret != -EIOCBRETRY)
-			break;
-		wait_on_retry_sync_kiocb(&kiocb);
-	}
-
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
-	return ret;
+	return filp->f_op->aio_read(filp, &iov, 1, ppos, NULL, NULL);
 }
 
 EXPORT_SYMBOL(do_sync_read);
@@ -288,24 +262,8 @@ EXPORT_SYMBOL(vfs_read);
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
-	kiocb.ki_left = len;
-
-	for (;;) {
-		ret = filp->f_op->aio_write(&kiocb, &iov, 1, kiocb.ki_pos);
-		if (ret != -EIOCBRETRY)
-			break;
-		wait_on_retry_sync_kiocb(&kiocb);
-	}
 
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
-	return ret;
+	return filp->f_op->aio_write(filp, &iov, 1, ppos, NULL, NULL);
 }
 
 EXPORT_SYMBOL(do_sync_write);
@@ -450,37 +408,41 @@ unsigned long iov_shorten(struct iovec *
 	return seg;
 }
 
-ssize_t do_sync_readv_writev(struct file *filp, const struct iovec *iov,
-		unsigned long nr_segs, size_t len, loff_t *ppos, iov_fn_t fn)
+ssize_t do_loop_readv_writev(int type, struct file *filp, struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, size_t count)
 {
-	struct kiocb kiocb;
-	ssize_t ret;
+	struct iovec *vector = iov;
+	io_fn_t fn = NULL;
+	ssize_t ret = 0;
 
-	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
-	kiocb.ki_left = len;
-	kiocb.ki_nbytes = len;
-
-	for (;;) {
-		ret = fn(&kiocb, iov, nr_segs, kiocb.ki_pos);
-		if (ret != -EIOCBRETRY)
-			break;
-		wait_on_retry_sync_kiocb(&kiocb);
-	}
+	if (count == 0)
+		goto out;
 
-	if (ret == -EIOCBQUEUED)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
-	return ret;
-}
+	ret = rw_verify_area(type, filp, ppos, count);
+	if (ret < 0)
+		goto out;
 
-/* Do it by hand, with file-ops */
-ssize_t do_loop_readv_writev(struct file *filp, struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos, io_fn_t fn)
-{
-	struct iovec *vector = iov;
-	ssize_t ret = 0;
+	ret = security_file_permission(filp, type == READ ? MAY_READ : MAY_WRITE);
+	if (ret)
+		goto out;
+
+	if (type == READ) {
+		if (filp->f_op->aio_read)
+			ret = filp->f_op->aio_read(filp, iov, nr_segs, ppos,
+						    NULL, NULL);
+		fn = filp->f_op->read;
+	} else {
+		if (filp->f_op->aio_write)
+			ret = filp->f_op->aio_write(filp, iov, nr_segs, ppos,
+						     NULL, NULL);
+		fn = filp->f_op->write;
+	}
 
+	if (!fn)
+		goto out;
+	/*
+	 * There's no aio_* function, so do each vector by hand
+	 */
 	while (nr_segs > 0) {
 		void __user *base;
 		size_t len;
@@ -502,51 +464,54 @@ ssize_t do_loop_readv_writev(struct file
 		if (nr != len)
 			break;
 	}
-
+out:
+	if ((ret + (type == READ)) > 0) {
+		if (type == READ)
+			fsnotify_access(filp->f_path.dentry);
+		else
+			fsnotify_modify(filp->f_path.dentry);
+	}
 	return ret;
 }
 
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
-ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
-			      unsigned long nr_segs, unsigned long fast_segs,
-			      struct iovec *fast_pointer,
-			      struct iovec **ret_pointer)
-  {
-	unsigned long seg;
-  	ssize_t ret;
-	struct iovec *iov = fast_pointer;
+ssize_t iov_check_alloc(unsigned long nr_segs, unsigned long fast_segs,
+			struct iovec **ret_ptr)
+{
+	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned zero for zero segments, so...
+	 */
+	if (nr_segs == 0)
+		return 0;
 
-  	/*
-  	 * SuS says "The readv() function *may* fail if the iovcnt argument
-  	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-  	 * traditionally returned zero for zero segments, so...
-  	 */
-	if (nr_segs == 0) {
-		ret = 0;
-  		goto out;
+	if (nr_segs > UIO_MAXIOV)
+		return -EINVAL;
+
+	if (nr_segs > fast_segs) {
+		*ret_ptr = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+		if (*ret_ptr == NULL)
+			return -ENOMEM;
 	}
+  	return 0;
+}
+
+
+ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
+			      unsigned long nr_segs, struct iovec *iov)
+{
+	unsigned long seg;
+	ssize_t ret = 0;
 
   	/*
   	 * First get the "struct iovec" from user memory and
   	 * verify all the pointers
   	 */
-	if (nr_segs > UIO_MAXIOV) {
-		ret = -EINVAL;
-  		goto out;
-	}
-	if (nr_segs > fast_segs) {
-  		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
-		if (iov == NULL) {
-			ret = -ENOMEM;
-  			goto out;
-		}
-  	}
-	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector))) {
-		ret = -EFAULT;
-  		goto out;
-	}
+	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector)))
+		return -EFAULT;
 
   	/*
 	 * According to the Single Unix Specification we should return EINVAL
@@ -554,26 +519,20 @@ ssize_t rw_copy_check_uvector(int type, 
 	 * total length would overflow the ssize_t return value of the
 	 * system call.
   	 */
-	ret = 0;
   	for (seg = 0; seg < nr_segs; seg++) {
   		void __user *buf = iov[seg].iov_base;
   		ssize_t len = (ssize_t)iov[seg].iov_len;
 
 		/* see if we we're about to use an invalid len or if
 		 * it's about to overflow ssize_t */
-		if (len < 0 || (ret + len < ret)) {
-			ret = -EINVAL;
-  			goto out;
-		}
-		if (unlikely(!access_ok(vrfy_dir(type), buf, len))) {
-			ret = -EFAULT;
-  			goto out;
-		}
+		if (len < 0 || (ret + len < ret))
+			return -EINVAL;
+
+		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
+			return -EFAULT;
 
 		ret += len;
   	}
-out:
-	*ret_pointer = iov;
 	return ret;
 }
 
@@ -581,55 +540,23 @@ static ssize_t do_readv_writev(int type,
 			       const struct iovec __user * uvector,
 			       unsigned long nr_segs, loff_t *pos)
 {
-	size_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	ssize_t ret;
-	io_fn_t fn;
-	iov_fn_t fnv;
 
-	if (!file->f_op) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = rw_copy_check_uvector(type, uvector, nr_segs,
-			ARRAY_SIZE(iovstack), iovstack, &iov);
+	ret = iov_check_alloc(nr_segs, UIO_FASTIOV, &iov);
 	if (ret <= 0)
 		goto out;
 
-	tot_len = ret;
-	ret = rw_verify_area(type, file, pos, tot_len);
-	if (ret < 0)
-		goto out;
-	ret = security_file_permission(file, type == READ ? MAY_READ : MAY_WRITE);
-	if (ret)
+	ret = rw_copy_check_uvector(type, uvector, nr_segs, iov);
+	if (ret <= 0)
 		goto out;
 
-	fnv = NULL;
-	if (type == READ) {
-		fn = file->f_op->read;
-		fnv = file->f_op->aio_read;
-	} else {
-		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->aio_write;
-	}
-
-	if (fnv)
-		ret = do_sync_readv_writev(file, iov, nr_segs, tot_len,
-						pos, fnv);
-	else
-		ret = do_loop_readv_writev(file, iov, nr_segs, pos, fn);
+	ret = do_loop_readv_writev(type, file, iov, nr_segs, pos, ret);
 
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0) {
-		if (type == READ)
-			fsnotify_access(file->f_path.dentry);
-		else
-			fsnotify_modify(file->f_path.dentry);
-	}
 	return ret;
 }
 
diff -urpN -X dontdiff a/fs/read_write.h b/fs/read_write.h
--- a/fs/read_write.h	2007-01-12 20:25:18.320842889 -0800
+++ b/fs/read_write.h	2007-01-15 13:55:49.408920229 -0800
@@ -5,10 +5,6 @@
 
 
 typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
-typedef ssize_t (*iov_fn_t)(struct kiocb *, const struct iovec *,
-		unsigned long, loff_t);
 
-ssize_t do_sync_readv_writev(struct file *filp, const struct iovec *iov,
-		unsigned long nr_segs, size_t len, loff_t *ppos, iov_fn_t fn);
-ssize_t do_loop_readv_writev(struct file *filp, struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos, io_fn_t fn);
+ssize_t do_loop_readv_writev(int type, struct file *filp, struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, size_t count);
diff -urpN -X dontdiff a/fs/smbfs/file.c b/fs/smbfs/file.c
--- a/fs/smbfs/file.c	2007-01-12 20:25:41.022083138 -0800
+++ b/fs/smbfs/file.c	2007-01-13 19:40:25.285836211 -0800
@@ -214,15 +214,15 @@ smb_updatepage(struct file *file, struct
 }
 
 static ssize_t
-smb_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-			unsigned long nr_segs, loff_t pos)
+smb_file_aio_read(struct file *file, const struct iovec *iov,
+			unsigned long nr_segs, loff_t *ppos,
+			file_endio_t *endio, void *endio_data)
 {
-	struct file * file = iocb->ki_filp;
 	struct dentry * dentry = file->f_path.dentry;
 	ssize_t	status;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n", DENTRY_PATH(dentry),
-		(unsigned long) iov_length(iov, nr_segs), (unsigned long) pos);
+		(unsigned long) iov_length(iov, nr_segs), (unsigned long) *ppos);
 
 	status = smb_revalidate_inode(dentry);
 	if (status) {
@@ -235,7 +235,8 @@ smb_file_aio_read(struct kiocb *iocb, co
 		(long)dentry->d_inode->i_size,
 		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
 
-	status = generic_file_aio_read(iocb, iov, nr_segs, pos);
+	status = generic_file_aio_read(file, iov, nr_segs, ppos,
+				       endio, endio_data);
 out:
 	return status;
 }
@@ -319,16 +320,16 @@ const struct address_space_operations sm
  * Write to a file (through the page cache).
  */
 static ssize_t
-smb_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			       unsigned long nr_segs, loff_t pos)
+smb_file_aio_write(struct file *file, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t *ppos,
+			       file_endio_t *endio, void *endio_data)
 {
-	struct file * file = iocb->ki_filp;
 	struct dentry * dentry = file->f_path.dentry;
 	ssize_t	result;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n",
 		DENTRY_PATH(dentry),
-		(unsigned long) iov_length(iov, nr_segs), (unsigned long) pos);
+		(unsigned long) iov_length(iov, nr_segs), (unsigned long) *ppos);
 
 	result = smb_revalidate_inode(dentry);
 	if (result) {
@@ -342,7 +343,8 @@ smb_file_aio_write(struct kiocb *iocb, c
 		goto out;
 
 	if (iov_length(iov, nr_segs) > 0) {
-		result = generic_file_aio_write(iocb, iov, nr_segs, pos);
+		result = generic_file_aio_write(file, iov, nr_segs, ppos,
+						endio, endio_data);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
 			dentry->d_inode->i_mtime, dentry->d_inode->i_atime);
diff -urpN -X dontdiff a/fs/udf/file.c b/fs/udf/file.c
--- a/fs/udf/file.c	2007-01-12 20:25:34.897176756 -0800
+++ b/fs/udf/file.c	2007-01-13 19:40:25.307828691 -0800
@@ -102,11 +102,11 @@ const struct address_space_operations ud
 	.commit_write		= udf_adinicb_commit_write,
 };
 
-static ssize_t udf_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t ppos)
+static ssize_t udf_file_aio_write(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *ppos,
+			      file_endio_t *endio, void *endio_data)
 {
 	ssize_t retval;
-	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_path.dentry->d_inode;
 	int err, pos;
 	size_t count = iov_length(iov, nr_segs);
@@ -116,7 +116,7 @@ static ssize_t udf_file_aio_write(struct
 		if (file->f_flags & O_APPEND)
 			pos = inode->i_size;
 		else
-			pos = ppos;
+			pos = *ppos;
 
 		if (inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 			pos + count))
@@ -137,7 +137,8 @@ static ssize_t udf_file_aio_write(struct
 		}
 	}
 
-	retval = generic_file_aio_write(iocb, iov, nr_segs, ppos);
+	retval = generic_file_aio_write(file, iov, nr_segs, ppos,
+					endio, endio_data);
 
 	if (retval > 0)
 		mark_inode_dirty(inode);
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_file.c b/fs/xfs/linux-2.6/xfs_file.c
--- a/fs/xfs/linux-2.6/xfs_file.c	2007-01-12 20:25:41.029080746 -0800
+++ b/fs/xfs/linux-2.6/xfs_file.c	2007-01-13 19:40:25.321823906 -0800
@@ -48,79 +48,91 @@ static struct vm_operations_struct xfs_d
 
 STATIC inline ssize_t
 __xfs_file_read(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
 	int			ioflags,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	struct file		*file = iocb->ki_filp;
 	bhv_vnode_t		*vp = vn_from_inode(file->f_path.dentry->d_inode);
 
-	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	return bhv_vop_read(vp, iocb, iov, nr_segs, &iocb->ki_pos,
+	return bhv_vop_read(vp, file, iov, nr_segs, ppos, endio, endio_data,
 				ioflags, NULL);
 }
 
 STATIC ssize_t
 xfs_file_aio_read(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	return __xfs_file_read(iocb, iov, nr_segs, IO_ISAIO, pos);
+	return __xfs_file_read(file, iov, nr_segs, IO_ISAIO, ppos,
+				endio, endio_data);
 }
 
 STATIC ssize_t
 xfs_file_aio_read_invis(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	return __xfs_file_read(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
+	return __xfs_file_read(file, iov, nr_segs, IO_ISAIO|IO_INVIS, ppos,
+				endio, endio_data);
 }
 
 STATIC inline ssize_t
 __xfs_file_write(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
 	int			ioflags,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	struct file	*file = iocb->ki_filp;
 	struct inode	*inode = file->f_mapping->host;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 
-	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	return bhv_vop_write(vp, iocb, iov, nr_segs, &iocb->ki_pos,
-				ioflags, NULL);
+	return bhv_vop_write(vp, file, iov, nr_segs, ppos,
+				endio, endio_data, ioflags, NULL);
 }
 
 STATIC ssize_t
 xfs_file_aio_write(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	return __xfs_file_write(iocb, iov, nr_segs, IO_ISAIO, pos);
+	return __xfs_file_write(file, iov, nr_segs, IO_ISAIO, ppos,
+				endio, endio_data);
 }
 
 STATIC ssize_t
 xfs_file_aio_write_invis(
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iov,
 	unsigned long		nr_segs,
-	loff_t			pos)
+	loff_t			*ppos,
+	file_endio_t		*endio,
+	void			*endio_data)
 {
-	return __xfs_file_write(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
+	return __xfs_file_write(file, iov, nr_segs, IO_ISAIO|IO_INVIS, ppos,
+				endio, endio_data);
 }
 
 STATIC ssize_t
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_lrw.c b/fs/xfs/linux-2.6/xfs_lrw.c
--- a/fs/xfs/linux-2.6/xfs_lrw.c	2007-01-12 21:01:00.605776824 -0800
+++ b/fs/xfs/linux-2.6/xfs_lrw.c	2007-01-13 19:40:25.336818779 -0800
@@ -190,14 +190,15 @@ unlock:
 ssize_t			/* bytes read, or (-)  error */
 xfs_read(
 	bhv_desc_t		*bdp,
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iovp,
 	unsigned int		segs,
 	loff_t			*offset,
+	file_endio_t		*endio,
+	void			*endio_data,
 	int			ioflags,
 	cred_t			*credp)
 {
-	struct file		*file = iocb->ki_filp;
 	struct inode		*inode = file->f_mapping->host;
 	size_t			size = 0;
 	ssize_t			ret;
@@ -280,10 +281,8 @@ xfs_read(
 	xfs_rw_enter_trace(XFS_READ_ENTER, &ip->i_iocore,
 				(void *)iovp, segs, *offset, ioflags);
 
-	iocb->ki_pos = *offset;
-	ret = generic_file_aio_read(iocb, iovp, segs, *offset);
-	if (ret == -EIOCBQUEUED && !(ioflags & IO_ISAIO))
-		ret = wait_on_sync_kiocb(iocb);
+	ret = generic_file_aio_read(file, iovp, segs, *offset,
+				    endio, endio_data);
 	if (ret > 0)
 		XFS_STATS_ADD(xs_read_bytes, ret);
 
@@ -627,14 +626,15 @@ out_lock:
 ssize_t				/* bytes written, or (-) error */
 xfs_write(
 	bhv_desc_t		*bdp,
-	struct kiocb		*iocb,
+	struct file		*file,
 	const struct iovec	*iovp,
 	unsigned int		nsegs,
 	loff_t			*offset,
+	file_endio_t		*endio,
+	void			*endio_data,
 	int			ioflags,
 	cred_t			*credp)
 {
-	struct file		*file = iocb->ki_filp;
 	struct address_space	*mapping = file->f_mapping;
 	struct inode		*inode = mapping->host;
 	unsigned long		segs = nsegs;
@@ -837,7 +837,7 @@ retry:
  		xfs_rw_enter_trace(XFS_DIOWR_ENTER, io, (void *)iovp, segs,
 				*offset, ioflags);
 		ret = generic_file_direct_write(file, iovp, &segs, pos,
-				offset, count, ocount, aio_complete, iocb);
+				offset, count, ocount, endio, endio_data);
 
 		/*
 		 * direct-io write to a hole: fall through to buffered I/O
@@ -857,15 +857,12 @@ retry:
 	} else {
 		xfs_rw_enter_trace(XFS_WRITE_ENTER, io, (void *)iovp, segs,
 				*offset, ioflags);
-		ret = generic_file_buffered_write(iocb, iovp, segs,
-				pos, offset, count, ret);
+		ret = generic_file_buffered_write(file, iovp, segs,
+				pos, offset, endio, endio_data, count, ret);
 	}
 
 	current->backing_dev_info = NULL;
 
-	if (ret == -EIOCBQUEUED && !(ioflags & IO_ISAIO))
-		ret = wait_on_sync_kiocb(iocb);
-
 	if ((ret == -ENOSPC) &&
 	    DM_EVENT_ENABLED(vp->v_vfsp, xip, DM_EVENT_NOSPACE) &&
 	    !(ioflags & IO_INVIS)) {
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_lrw.h b/fs/xfs/linux-2.6/xfs_lrw.h
--- a/fs/xfs/linux-2.6/xfs_lrw.h	2007-01-12 20:25:41.042076304 -0800
+++ b/fs/xfs/linux-2.6/xfs_lrw.h	2007-01-13 19:40:25.346815361 -0800
@@ -84,12 +84,14 @@ extern int xfs_dev_is_read_only(struct x
 
 extern int xfs_zero_eof(struct bhv_vnode *, struct xfs_iocore *, xfs_off_t,
 				xfs_fsize_t, xfs_fsize_t);
-extern ssize_t xfs_read(struct bhv_desc *, struct kiocb *,
+extern ssize_t xfs_read(struct bhv_desc *, struct file *,
 				const struct iovec *, unsigned int,
-				loff_t *, int, struct cred *);
-extern ssize_t xfs_write(struct bhv_desc *, struct kiocb *,
+				loff_t *, file_endio_t *, void *, int,
+				struct cred *);
+extern ssize_t xfs_write(struct bhv_desc *, struct file *,
 				const struct iovec *, unsigned int,
-				loff_t *, int, struct cred *);
+				loff_t *, file_endio_t *, void *, int,
+				struct cred *);
 extern ssize_t xfs_sendfile(struct bhv_desc *, struct file *,
 				loff_t *, int, size_t, read_actor_t,
 				void *, struct cred *);
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_vnode.h b/fs/xfs/linux-2.6/xfs_vnode.h
--- a/fs/xfs/linux-2.6/xfs_vnode.h	2007-01-12 20:25:41.051073229 -0800
+++ b/fs/xfs/linux-2.6/xfs_vnode.h	2007-01-15 14:11:03.544506727 -0800
@@ -133,12 +133,14 @@ typedef enum { L_FALSE, L_TRUE } lastclo
 
 typedef int	(*vop_open_t)(bhv_desc_t *, struct cred *);
 typedef int	(*vop_close_t)(bhv_desc_t *, int, lastclose_t, struct cred *);
-typedef ssize_t (*vop_read_t)(bhv_desc_t *, struct kiocb *,
+typedef ssize_t (*vop_read_t)(bhv_desc_t *, struct file *,
 				const struct iovec *, unsigned int,
-				loff_t *, int, struct cred *);
-typedef ssize_t (*vop_write_t)(bhv_desc_t *, struct kiocb *,
+				loff_t *, file_endio_t *, void *, int,
+				struct cred *);
+typedef ssize_t (*vop_write_t)(bhv_desc_t *, struct file *,
 				const struct iovec *, unsigned int,
-				loff_t *, int, struct cred *);
+				loff_t *, file_endio_t *, void *, int,
+				struct cred *);
 typedef ssize_t (*vop_sendfile_t)(bhv_desc_t *, struct file *,
 				loff_t *, int, size_t, read_actor_t,
 				void *, struct cred *);
@@ -250,10 +252,12 @@ typedef struct bhv_vnodeops {
 #define VOP(op, vp)	(*((bhv_vnodeops_t *)VNHEAD(vp)->bd_ops)->op)
 #define bhv_vop_open(vp, cr)		VOP(vop_open, vp)(VNHEAD(vp),cr)
 #define bhv_vop_close(vp, f,last,cr)	VOP(vop_close, vp)(VNHEAD(vp),f,last,cr)
-#define bhv_vop_read(vp,file,iov,segs,offset,ioflags,cr)		\
-		VOP(vop_read, vp)(VNHEAD(vp),file,iov,segs,offset,ioflags,cr)
-#define bhv_vop_write(vp,file,iov,segs,offset,ioflags,cr)		\
-		VOP(vop_write, vp)(VNHEAD(vp),file,iov,segs,offset,ioflags,cr)
+#define bhv_vop_read(vp,file,iov,segs,offset,endio,endio_data,ioflags,cr) \
+		VOP(vop_read, vp)(VNHEAD(vp),file,iov,segs,offset,	\
+				endio,endio_data,ioflags,cr)
+#define bhv_vop_write(vp,file,iov,segs,offset,endio,endio_data,ioflags,cr) \
+		VOP(vop_write, vp)(VNHEAD(vp),file,iov,segs,offset,	\
+				endio,endio_data,ioflags,cr)
 #define bhv_vop_sendfile(vp,f,off,ioflags,cnt,act,targ,cr)		\
 		VOP(vop_sendfile, vp)(VNHEAD(vp),f,off,ioflags,cnt,act,targ,cr)
 #define bhv_vop_splice_read(vp,f,o,pipe,cnt,fl,iofl,cr)			\
diff -urpN -X dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2007-01-12 21:01:00.619772040 -0800
+++ b/include/linux/fs.h	2007-01-15 13:56:21.746869412 -0800
@@ -1122,8 +1122,10 @@ struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
-	ssize_t (*aio_write) (struct kiocb *, const struct iovec *, unsigned long, loff_t);
+	ssize_t (*aio_read) (struct file *, const struct iovec *,
+			     unsigned long, loff_t *, file_endio_t *, void *);
+	ssize_t (*aio_write) (struct file *, const struct iovec *,
+			      unsigned long, loff_t *, file_endio_t *, void *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1174,10 +1176,10 @@ struct inode_operations {
 
 struct seq_file;
 
+ssize_t iov_check_alloc(unsigned long nr_segs, unsigned long fast_segs,
+			struct iovec **ret_ptr);
 ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
-				unsigned long nr_segs, unsigned long fast_segs,
-				struct iovec *fast_pointer,
-				struct iovec **ret_pointer);
+				unsigned long nr_segs, struct iovec *iov);
 
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
@@ -1769,15 +1771,18 @@ extern int generic_file_readonly_mmap(st
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
-extern ssize_t generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t);
-extern ssize_t generic_file_aio_write(struct kiocb *, const struct iovec *, unsigned long, loff_t);
-extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
-		unsigned long, loff_t);
+extern ssize_t generic_file_aio_read(struct file *, const struct iovec *,
+			unsigned long, loff_t *, file_endio_t *, void *);
+extern ssize_t generic_file_aio_write(struct file *, const struct iovec *,
+			unsigned long, loff_t *, file_endio_t *, void *);
+extern ssize_t generic_file_aio_write_nolock(struct file *, const struct iovec *,
+		unsigned long, loff_t *, file_endio_t *, void *);
 extern ssize_t generic_file_direct_write(struct file *, const struct iovec *,
 					unsigned long *, loff_t, loff_t *,
 					size_t, size_t, file_endio_t, void *);
-extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
-		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern ssize_t generic_file_buffered_write(struct file *, const struct iovec *,
+		unsigned long, loff_t, loff_t *, size_t, ssize_t,
+		file_endio_t *, void *);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
diff -urpN -X dontdiff a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2007-01-15 13:30:26.467363895 -0800
+++ b/mm/filemap.c	2007-01-15 13:40:44.752036575 -0800
@@ -1173,23 +1173,24 @@ success:
 
 /**
  * generic_file_aio_read - generic filesystem read routine
- * @iocb:	kernel I/O control block
+ * @filp:	file to read
  * @iov:	io vector request
  * @nr_segs:	number of segments in the iovec
- * @pos:	current file position
+ * @ppos:	current file position
+ * @endio:	async end I/O function
+ * @endio_data:	endio private data
  *
  * This is the "read()" routine for all filesystems
  * that can use the page cache directly.
  */
 ssize_t
-generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+generic_file_aio_read(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, file_endio_t *endio,
+		void *endio_data)
 {
-	struct file *filp = iocb->ki_filp;
 	ssize_t retval;
 	unsigned long seg;
 	size_t count;
-	loff_t *ppos = &iocb->ki_pos;
 
 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
@@ -1223,11 +1224,11 @@ generic_file_aio_read(struct kiocb *iocb
 		if (!count)
 			goto out; /* skip atime */
 		size = i_size_read(inode);
-		if (pos < size) {
-			retval = generic_file_direct_IO(READ, filp, iov, pos,
-						nr_segs, aio_complete, iocb);
+		if (*ppos < size) {
+			retval = generic_file_direct_IO(READ, filp, iov, *ppos,
+						nr_segs, endio, endio_data);
 			if (retval > 0)
-				*ppos = pos + retval;
+				*ppos += retval;
 		}
 		if (likely(retval != 0)) {
 			file_accessed(filp);
@@ -2118,11 +2119,11 @@ generic_file_direct_write(struct file *f
 EXPORT_SYMBOL(generic_file_direct_write);
 
 ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
+generic_file_buffered_write(struct file *file, const struct iovec *iov,
 		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+		size_t count, ssize_t written, file_endio_t *endio,
+		void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space * mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	struct inode 	*inode = mapping->host;
@@ -2281,10 +2282,10 @@ zero_length_segment:
 EXPORT_SYMBOL(generic_file_buffered_write);
 
 static ssize_t
-__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
+__generic_file_aio_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space * mapping = file->f_mapping;
 	size_t ocount;		/* original count */
 	size_t count;		/* after file limit checks */
@@ -2346,7 +2347,7 @@ __generic_file_aio_write_nolock(struct k
 
 		written = generic_file_direct_write(file, iov, &nr_segs, pos,
 							ppos, count, ocount,
-							aio_complete, iocb);
+							endio, endio_data);
 		if (written < 0 || written == count)
 			goto out;
 		/*
@@ -2355,9 +2356,9 @@ __generic_file_aio_write_nolock(struct k
 		 */
 		pos += written;
 		count -= written;
-		written_buffered = generic_file_buffered_write(iocb, iov,
+		written_buffered = generic_file_buffered_write(file, iov,
 						nr_segs, pos, ppos, count,
-						written);
+						written, endio, endio_data);
 		/*
 		 * If generic_file_buffered_write() retuned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -2392,62 +2393,58 @@ __generic_file_aio_write_nolock(struct k
 			 */
 		}
 	} else {
-		written = generic_file_buffered_write(iocb, iov, nr_segs,
-				pos, ppos, count, written);
+		written = generic_file_buffered_write(file, iov, nr_segs,
+				pos, ppos, count, written, endio, endio_data);
 	}
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
 
-ssize_t generic_file_aio_write_nolock(struct kiocb *iocb,
-		const struct iovec *iov, unsigned long nr_segs, loff_t pos)
+ssize_t generic_file_aio_write_nolock(struct file *file,
+		const struct iovec *iov, unsigned long nr_segs, loff_t *ppos,
+		file_endio_t *endio, void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
 
-	BUG_ON(iocb->ki_pos != pos);
-
-	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
-			&iocb->ki_pos);
+	ret = __generic_file_aio_write_nolock(file, iov, nr_segs, ppos,
+			endio, endio_data);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ssize_t err;
 
-		err = sync_page_range_nolock(inode, mapping, pos, ret);
+		err = sync_page_range_nolock(inode, mapping, *ppos - ret, ret);
 		if (err < 0) {
+			*ppos -= ret;
 			ret = err;
-			iocb->ki_pos = pos;
 		}
 	}
 	return ret;
 }
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
-ssize_t generic_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos)
+ssize_t generic_file_aio_write(struct file *file, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, file_endio_t *endio,
+		void *endio_data)
 {
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
 
-	BUG_ON(iocb->ki_pos != pos);
-
 	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
-			&iocb->ki_pos);
+	ret = __generic_file_aio_write_nolock(file, iov, nr_segs, ppos,
+			endio, endio_data);
 	mutex_unlock(&inode->i_mutex);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ssize_t err;
 
-		err = sync_page_range(inode, mapping, pos, ret);
+		err = sync_page_range(inode, mapping, *ppos - ret, ret);
 		if (err < 0) {
+			*ppos -= ret;
 			ret = err;
-			iocb->ki_pos = pos;
 		}
 	}
 	return ret;
diff -urpN -X dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	2007-01-12 20:25:41.069067078 -0800
+++ b/net/socket.c	2007-01-15 13:24:42.254021081 -0800
@@ -94,10 +94,12 @@
 #include <linux/netfilter.h>
 
 static int sock_no_open(struct inode *irrelevant, struct file *dontcare);
-static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
-			 unsigned long nr_segs, loff_t pos);
-static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			  unsigned long nr_segs, loff_t pos);
+static ssize_t sock_aio_read(struct file *file, const struct iovec *iov,
+			 unsigned long nr_segs, loff_t *ppos,
+			 file_endio_t *endio, void *endio_data);
+static ssize_t sock_aio_write(struct file *file, const struct iovec *iov,
+			  unsigned long nr_segs, loff_t *ppos,
+			  file_endio_t *endio, void *endio_data);
 static int sock_mmap(struct file *file, struct vm_area_struct *vma);
 
 static int sock_close(struct inode *inode, struct file *file);
@@ -621,15 +623,16 @@ static ssize_t sock_sendpage(struct file
 	return sock->ops->sendpage(sock, page, offset, size, flags);
 }
 
-static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos)
+static ssize_t sock_aio_read(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos,
+				file_endio_t *endio, void *endio_data)
 {
 	struct msghdr msg;
-	struct socket *sock = iocb->ki_filp->private_data;
+	struct socket *sock = file->private_data;
 	size_t size = 0;
 	int i;
 
-	if (pos != 0)
+	if (ppos != 0)
 		return -ESPIPE;
 
 	if (iov_length(iov, nr_segs) == 0)	/* Match SYS5 behaviour */
@@ -644,20 +647,21 @@ static ssize_t sock_aio_read(struct kioc
 	msg.msg_controllen = 0;
 	msg.msg_iov = (struct iovec *)iov;
 	msg.msg_iovlen = nr_segs;
-	msg.msg_flags = (iocb->ki_filp->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	msg.msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
 
 	return sock_recvmsg(sock, &msg, size, msg.msg_flags);
 }
 
-static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			  unsigned long nr_segs, loff_t pos)
+static ssize_t sock_aio_write(struct file *file, const struct iovec *iov,
+			  unsigned long nr_segs, loff_t *ppos,
+			  file_endio_t _endio, void *endio_data)
 {
 	struct msghdr msg;
-	struct socket *sock = iocb->ki_filp->private_data;
+	struct socket *sock = file->private_data;
 	size_t size = 0;
 	int i;
 
-	if (pos != 0)
+	if (ppos != 0)
 		return -ESPIPE;
 
 	if (iov_length(iov, nr_segs) == 0)	/* Match SYS5 behaviour */
@@ -672,7 +676,7 @@ static ssize_t sock_aio_write(struct kio
 	msg.msg_controllen = 0;
 	msg.msg_iov = (struct iovec *)iov;
 	msg.msg_iovlen = nr_segs;
-	msg.msg_flags = (iocb->ki_filp->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	msg.msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
diff -urpN -X dontdiff a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	2007-01-12 20:25:41.079063661 -0800
+++ b/sound/core/pcm_native.c	2007-01-13 19:40:25.467774001 -0800
@@ -2854,11 +2854,12 @@ static ssize_t snd_pcm_write(struct file
 	return result;
 }
 
-static ssize_t snd_pcm_aio_read(struct kiocb *iocb, const struct iovec *iov,
-			     unsigned long nr_segs, loff_t pos)
+static ssize_t snd_pcm_aio_read(struct file *file, const struct iovec *iov,
+			     unsigned long nr_segs, loff_t *ppos,
+			     file_endio_t *endio, void *endio_data)
 
 {
-	struct snd_pcm_file *pcm_file;
+	struct snd_pcm_file *pcm_file = file->private_data;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
 	snd_pcm_sframes_t result;
@@ -2866,7 +2867,6 @@ static ssize_t snd_pcm_aio_read(struct k
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
-	pcm_file = iocb->ki_filp->private_data;
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, return -ENXIO);
 	runtime = substream->runtime;
@@ -2889,8 +2889,9 @@ static ssize_t snd_pcm_aio_read(struct k
 	return result;
 }
 
-static ssize_t snd_pcm_aio_write(struct kiocb *iocb, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t pos)
+static ssize_t snd_pcm_aio_write(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *ppos,
+			      file_endio_t *endio, void *endio_data)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
@@ -2900,7 +2901,7 @@ static ssize_t snd_pcm_aio_write(struct 
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
-	pcm_file = iocb->ki_filp->private_data;
+	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
 	runtime = substream->runtime;
