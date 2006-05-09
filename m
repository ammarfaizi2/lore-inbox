Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWEISGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWEISGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWEISGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:06:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:1982 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750864AbWEISGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:06:43 -0400
Subject: [PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
	instead
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu
In-Reply-To: <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 11:07:41 -0700
Message-Id: <1147198061.28388.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes readv() and writev() methods and replaces
them with aio_read()/aio_write() methods.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>

 drivers/char/raw.c          |    2 
 drivers/net/tun.c           |   35 +++------------
 fs/bad_inode.c              |    2 
 fs/block_dev.c              |    2 
 fs/cifs/cifsfs.c            |   16 ------
 fs/compat.c                 |   44 ++++---------------
 fs/ext2/file.c              |    2 
 fs/ext3/file.c              |    2 
 fs/fat/file.c               |    2 
 fs/fuse/dev.c               |   35 +++------------
 fs/hostfs/hostfs_kern.c     |    2 
 fs/jfs/file.c               |    2 
 fs/ntfs/file.c              |    2 
 fs/pipe.c                   |   49 +++++----------------
 fs/read_write.c             |  101 +++++++++++++++++++++++++++++---------------
 fs/read_write.h             |   14 ++++++
 fs/xfs/linux-2.6/xfs_file.c |   92 ----------------------------------------
 include/linux/fs.h          |    6 --
 mm/filemap.c                |   36 ---------------
 net/socket.c                |   40 -----------------
 sound/core/pcm_native.c     |   40 ++++++++---------
 21 files changed, 141 insertions(+), 385 deletions(-)

Index: linux-2.6.17-rc3.save/drivers/char/raw.c
===================================================================
--- linux-2.6.17-rc3.save.orig/drivers/char/raw.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/drivers/char/raw.c	2006-05-09 08:08:28.000000000 -0700
@@ -258,8 +258,6 @@ static struct file_operations raw_fops =
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
-	.readv	= 	generic_file_readv,
-	.writev	= 	generic_file_writev,
 	.owner	=	THIS_MODULE,
 };
 
Index: linux-2.6.17-rc3.save/drivers/net/tun.c
===================================================================
--- linux-2.6.17-rc3.save.orig/drivers/net/tun.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/drivers/net/tun.c	2006-05-09 08:08:28.000000000 -0700
@@ -289,11 +289,10 @@ static inline size_t iov_total(const str
 	return len;
 }
 
-/* Writev */
-static ssize_t tun_chr_writev(struct file * file, const struct iovec *iv, 
-			      unsigned long count, loff_t *pos)
+static ssize_t tun_chr_aio_write(struct kiocb *iocb, const struct iovec *iv,
+			      unsigned long count, loff_t pos)
 {
-	struct tun_struct *tun = file->private_data;
+	struct tun_struct *tun = iocb->ki_filp->private_data;
 
 	if (!tun)
 		return -EBADFD;
@@ -303,14 +302,6 @@ static ssize_t tun_chr_writev(struct fil
 	return tun_get_user(tun, (struct iovec *) iv, iov_total(iv, count));
 }
 
-/* Write */
-static ssize_t tun_chr_write(struct file * file, const char __user * buf, 
-			     size_t count, loff_t *pos)
-{
-	struct iovec iv = { (void __user *) buf, count };
-	return tun_chr_writev(file, &iv, 1, pos);
-}
-
 /* Put packet to the user space buffer */
 static __inline__ ssize_t tun_put_user(struct tun_struct *tun,
 				       struct sk_buff *skb,
@@ -344,10 +335,10 @@ static __inline__ ssize_t tun_put_user(s
 	return total;
 }
 
-/* Readv */
-static ssize_t tun_chr_readv(struct file *file, const struct iovec *iv,
-			    unsigned long count, loff_t *pos)
+static ssize_t tun_chr_aio_read(struct kiocb *iocb, const struct iovec *iv,
+			    unsigned long count, loff_t pos)
 {
+	struct file *file = iocb->ki_filp;
 	struct tun_struct *tun = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	struct sk_buff *skb;
@@ -427,14 +418,6 @@ static ssize_t tun_chr_readv(struct file
 	return ret;
 }
 
-/* Read */
-static ssize_t tun_chr_read(struct file * file, char __user * buf, 
-			    size_t count, loff_t *pos)
-{
-	struct iovec iv = { buf, count };
-	return tun_chr_readv(file, &iv, 1, pos);
-}
-
 static void tun_setup(struct net_device *dev)
 {
 	struct tun_struct *tun = netdev_priv(dev);
@@ -762,10 +745,8 @@ static int tun_chr_close(struct inode *i
 static struct file_operations tun_fops = {
 	.owner	= THIS_MODULE,	
 	.llseek = no_llseek,
-	.read	= tun_chr_read,
-	.readv	= tun_chr_readv,
-	.write	= tun_chr_write,
-	.writev = tun_chr_writev,
+	.aio_read  = tun_chr_aio_read,
+	.aio_write = tun_chr_aio_write,
 	.poll	= tun_chr_poll,
 	.ioctl	= tun_chr_ioctl,
 	.open	= tun_chr_open,
Index: linux-2.6.17-rc3.save/fs/bad_inode.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/bad_inode.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/bad_inode.c	2006-05-09 08:08:28.000000000 -0700
@@ -40,8 +40,6 @@ static const struct file_operations bad_
 	.aio_fsync	= EIO_ERROR,
 	.fasync		= EIO_ERROR,
 	.lock		= EIO_ERROR,
-	.readv		= EIO_ERROR,
-	.writev		= EIO_ERROR,
 	.sendfile	= EIO_ERROR,
 	.sendpage	= EIO_ERROR,
 	.get_unmapped_area = EIO_ERROR,
Index: linux-2.6.17-rc3.save/fs/block_dev.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/block_dev.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/block_dev.c	2006-05-09 08:08:28.000000000 -0700
@@ -1093,8 +1093,6 @@ const struct file_operations def_blk_fop
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.readv		= generic_file_readv,
-	.writev		= generic_file_write_nolock,
 	.sendfile	= generic_file_sendfile,
 };
 
Index: linux-2.6.17-rc3.save/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/cifs/cifsfs.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/cifs/cifsfs.c	2006-05-09 08:08:28.000000000 -0700
@@ -484,18 +484,6 @@ cifs_get_sb(struct file_system_type *fs_
 	return sb;
 }
 
-static ssize_t cifs_file_writev(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	ssize_t written;
-
-	written = generic_file_writev(file, iov, nr_segs, ppos);
-	if (!CIFS_I(inode)->clientCanCacheAll)
-		filemap_fdatawrite(inode->i_mapping);
-	return written;
-}
-
 static ssize_t cifs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
 				   unsigned long nr_segs, loff_t pos)
 {
@@ -581,8 +569,6 @@ struct inode_operations cifs_symlink_ino
 const struct file_operations cifs_file_ops = {
 	.read = do_sync_read,
 	.write = do_sync_write,
-	.readv = generic_file_readv,
-	.writev = cifs_file_writev,
 	.aio_read = generic_file_aio_read,
 	.aio_write = cifs_file_aio_write,
 	.open = cifs_open,
@@ -624,8 +610,6 @@ const struct file_operations cifs_file_d
 const struct file_operations cifs_file_nobrl_ops = {
 	.read = do_sync_read,
 	.write = do_sync_write,
-	.readv = generic_file_readv,
-	.writev = cifs_file_writev,
 	.aio_read = generic_file_aio_read,
 	.aio_write = cifs_file_aio_write,
 	.open = cifs_open,
Index: linux-2.6.17-rc3.save/fs/compat.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/compat.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/compat.c	2006-05-09 08:08:28.000000000 -0700
@@ -55,6 +55,8 @@
 
 extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
+#include "read_write.h"
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
@@ -1139,9 +1141,6 @@ static ssize_t compat_do_readv_writev(in
 			       const struct compat_iovec __user *uvector,
 			       unsigned long nr_segs, loff_t *pos)
 {
-	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
-	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
-
 	compat_ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack, *vector;
@@ -1224,39 +1223,18 @@ static ssize_t compat_do_readv_writev(in
 	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
-		fnv = file->f_op->readv;
+		fnv = file->f_op->aio_read;
 	} else {
 		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->writev;
-	}
-	if (fnv) {
-		ret = fnv(file, iov, nr_segs, pos);
-		goto out;
+		fnv = file->f_op->aio_write;
 	}
 
-	/* Do it by hand, with file-ops */
-	ret = 0;
-	vector = iov;
-	while (nr_segs > 0) {
-		void __user * base;
-		size_t len;
-		ssize_t nr;
-
-		base = vector->iov_base;
-		len = vector->iov_len;
-		vector++;
-		nr_segs--;
-
-		nr = fn(file, base, len, pos);
+	if (fnv)
+		ret = do_sync_readv_writev(file, iov, nr_segs, tot_len,
+						pos, fnv);
+	else
+		ret = do_loop_readv_writev(file, iov, nr_segs, pos, fn);
 
-		if (nr < 0) {
-			if (!ret) ret = nr;
-			break;
-		}
-		ret += nr;
-		if (nr != len)
-			break;
-	}
 out:
 	if (iov != iovstack)
 		kfree(iov);
@@ -1284,7 +1262,7 @@ compat_sys_readv(unsigned long fd, const
 		goto out;
 
 	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
+	if (!file->f_op || (!file->f_op->aio_read && !file->f_op->read))
 		goto out;
 
 	ret = compat_do_readv_writev(READ, file, vec, vlen, &file->f_pos);
@@ -1307,7 +1285,7 @@ compat_sys_writev(unsigned long fd, cons
 		goto out;
 
 	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
+	if (!file->f_op || (!file->f_op->aio_write && !file->f_op->write))
 		goto out;
 
 	ret = compat_do_readv_writev(WRITE, file, vec, vlen, &file->f_pos);
Index: linux-2.6.17-rc3.save/fs/ext2/file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/ext2/file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/ext2/file.c	2006-05-09 08:08:28.000000000 -0700
@@ -50,8 +50,6 @@ const struct file_operations ext2_file_o
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_sync_file,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= generic_file_splice_write,
Index: linux-2.6.17-rc3.save/fs/ext3/file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/ext3/file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/ext3/file.c	2006-05-09 08:08:28.000000000 -0700
@@ -112,8 +112,6 @@ const struct file_operations ext3_file_o
 	.write		= do_sync_write,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= ext3_file_write,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
Index: linux-2.6.17-rc3.save/fs/fat/file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/fat/file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/fat/file.c	2006-05-09 08:08:28.000000000 -0700
@@ -116,8 +116,6 @@ const struct file_operations fat_file_op
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
Index: linux-2.6.17-rc3.save/fs/fuse/dev.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/fuse/dev.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/fuse/dev.c	2006-05-09 08:08:28.000000000 -0700
@@ -585,14 +585,15 @@ static void request_wait(struct fuse_con
  * request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
-static ssize_t fuse_dev_readv(struct file *file, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t *off)
+static ssize_t fuse_dev_read(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t pos)
 {
 	int err;
 	struct fuse_req *req;
 	struct fuse_in *in;
 	struct fuse_copy_state cs;
 	unsigned reqsize;
+	struct file *file = iocb->ki_filp;
 	struct fuse_conn *fc = fuse_get_conn(file);
 	if (!fc)
 		return -EPERM;
@@ -658,15 +659,6 @@ static ssize_t fuse_dev_readv(struct fil
 	return err;
 }
 
-static ssize_t fuse_dev_read(struct file *file, char __user *buf,
-			     size_t nbytes, loff_t *off)
-{
-	struct iovec iov;
-	iov.iov_len = nbytes;
-	iov.iov_base = buf;
-	return fuse_dev_readv(file, &iov, 1, off);
-}
-
 /* Look up request on processing list by unique ID */
 static struct fuse_req *request_find(struct fuse_conn *fc, u64 unique)
 {
@@ -711,15 +703,15 @@ static int copy_out_args(struct fuse_cop
  * it from the list and copy the rest of the buffer to the request.
  * The request is finished by calling request_end()
  */
-static ssize_t fuse_dev_writev(struct file *file, const struct iovec *iov,
-			       unsigned long nr_segs, loff_t *off)
+static ssize_t fuse_dev_write(struct kiocb *iocb, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t pos)
 {
 	int err;
 	unsigned nbytes = iov_length(iov, nr_segs);
 	struct fuse_req *req;
 	struct fuse_out_header oh;
 	struct fuse_copy_state cs;
-	struct fuse_conn *fc = fuse_get_conn(file);
+	struct fuse_conn *fc = fuse_get_conn(iocb->ki_filp);
 	if (!fc)
 		return -EPERM;
 
@@ -779,15 +771,6 @@ static ssize_t fuse_dev_writev(struct fi
 	return err;
 }
 
-static ssize_t fuse_dev_write(struct file *file, const char __user *buf,
-			      size_t nbytes, loff_t *off)
-{
-	struct iovec iov;
-	iov.iov_len = nbytes;
-	iov.iov_base = (char __user *) buf;
-	return fuse_dev_writev(file, &iov, 1, off);
-}
-
 static unsigned fuse_dev_poll(struct file *file, poll_table *wait)
 {
 	unsigned mask = POLLOUT | POLLWRNORM;
@@ -921,10 +904,8 @@ static int fuse_dev_fasync(int fd, struc
 const struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= fuse_dev_read,
-	.readv		= fuse_dev_readv,
-	.write		= fuse_dev_write,
-	.writev		= fuse_dev_writev,
+	.aio_read	= fuse_dev_read,
+	.aio_write	= fuse_dev_write,
 	.poll		= fuse_dev_poll,
 	.release	= fuse_dev_release,
 	.fasync		= fuse_dev_fasync,
Index: linux-2.6.17-rc3.save/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/hostfs/hostfs_kern.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/hostfs/hostfs_kern.c	2006-05-09 08:08:28.000000000 -0700
@@ -390,8 +390,6 @@ static const struct file_operations host
 	.sendfile	= generic_file_sendfile,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
Index: linux-2.6.17-rc3.save/fs/jfs/file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/jfs/file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/jfs/file.c	2006-05-09 08:08:28.000000000 -0700
@@ -108,8 +108,6 @@ const struct file_operations jfs_file_op
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
  	.sendfile	= generic_file_sendfile,
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
Index: linux-2.6.17-rc3.save/fs/ntfs/file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/ntfs/file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/ntfs/file.c	2006-05-09 08:08:28.000000000 -0700
@@ -2296,11 +2296,9 @@ const struct file_operations ntfs_file_o
 	.llseek		= generic_file_llseek,	 /* Seek inside file. */
 	.read		= generic_file_read,	 /* Read from file. */
 	.aio_read	= generic_file_aio_read, /* Async read from file. */
-	.readv		= generic_file_readv,	 /* Read from file. */
 #ifdef NTFS_RW
 	.write		= ntfs_file_write,	 /* Write to file. */
 	.aio_write	= ntfs_file_aio_write,	 /* Async write to file. */
-	.writev		= ntfs_file_writev,	 /* Write to file. */
 	/*.release	= ,*/			 /* Last file is closed.  See
 						    fs/ext2/file.c::
 						    ext2_release_file() for
Index: linux-2.6.17-rc3.save/fs/pipe.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/pipe.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/pipe.c	2006-05-09 08:08:28.000000000 -0700
@@ -147,9 +147,10 @@ static struct pipe_buf_operations anon_p
 };
 
 static ssize_t
-pipe_readv(struct file *filp, const struct iovec *_iov,
-	   unsigned long nr_segs, loff_t *ppos)
+pipe_read(struct kiocb *iocb, const struct iovec *_iov,
+	   unsigned long nr_segs, loff_t pos)
 {
+	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	int do_wakeup;
@@ -248,17 +249,10 @@ pipe_readv(struct file *filp, const stru
 }
 
 static ssize_t
-pipe_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
-{
-	struct iovec iov = { .iov_base = buf, .iov_len = count };
-
-	return pipe_readv(filp, &iov, 1, ppos);
-}
-
-static ssize_t
-pipe_writev(struct file *filp, const struct iovec *_iov,
+pipe_write(struct kiocb *iocb, const struct iovec *_iov,
 	    unsigned long nr_segs, loff_t *ppos)
 {
+	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	ssize_t ret;
@@ -404,15 +398,6 @@ out:
 }
 
 static ssize_t
-pipe_write(struct file *filp, const char __user *buf,
-	   size_t count, loff_t *ppos)
-{
-	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = count };
-
-	return pipe_writev(filp, &iov, 1, ppos);
-}
-
-static ssize_t
 bad_pipe_r(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 {
 	return -EBADF;
@@ -630,8 +615,7 @@ pipe_rdwr_open(struct inode *inode, stru
  */
 const struct file_operations read_fifo_fops = {
 	.llseek		= no_llseek,
-	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.aio_read	= pipe_read,
 	.write		= bad_pipe_w,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
@@ -643,8 +627,7 @@ const struct file_operations read_fifo_f
 const struct file_operations write_fifo_fops = {
 	.llseek		= no_llseek,
 	.read		= bad_pipe_r,
-	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.aio_write	= pipe_write,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
@@ -654,10 +637,8 @@ const struct file_operations write_fifo_
 
 const struct file_operations rdwr_fifo_fops = {
 	.llseek		= no_llseek,
-	.read		= pipe_read,
-	.readv		= pipe_readv,
-	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.aio_read	= pipe_read,
+	.aio_write	= pipe_write,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
@@ -667,8 +648,7 @@ const struct file_operations rdwr_fifo_f
 
 static struct file_operations read_pipe_fops = {
 	.llseek		= no_llseek,
-	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.aio_read	= pipe_read,
 	.write		= bad_pipe_w,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
@@ -680,8 +660,7 @@ static struct file_operations read_pipe_
 static struct file_operations write_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= bad_pipe_r,
-	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.aio_write	= pipe_write,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
@@ -691,10 +670,8 @@ static struct file_operations write_pipe
 
 static struct file_operations rdwr_pipe_fops = {
 	.llseek		= no_llseek,
-	.read		= pipe_read,
-	.readv		= pipe_readv,
-	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.aio_read	= pipe_read,
+	.aio_write	= pipe_write,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
Index: linux-2.6.17-rc3.save/fs/read_write.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/read_write.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/read_write.c	2006-05-09 10:58:53.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include "read_write.h"
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -450,6 +451,63 @@ unsigned long iov_shorten(struct iovec *
 
 EXPORT_SYMBOL(iov_shorten);
 
+ssize_t do_sync_readv_writev(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, size_t len, loff_t *ppos, iov_fn_t fn)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	kiocb.ki_pos = *ppos;
+	kiocb.ki_left = len;
+	kiocb.ki_nbytes = len;
+
+	for (;;) {
+		ret = fn(&kiocb, iov, nr_segs, kiocb.ki_pos);
+		if (ret != -EIOCBRETRY)
+			break;
+		wait_on_retry_sync_kiocb(&kiocb);
+	}
+
+	if (ret == -EIOCBQUEUED)
+		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+
+/* Do it by hand, with file-ops */
+ssize_t do_loop_readv_writev(struct file *filp, struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, io_fn_t fn)
+{
+	struct iovec *vector = iov;
+	ssize_t ret = 0;
+
+
+	while (nr_segs > 0) {
+		void __user * base;
+		size_t len;
+		ssize_t nr;
+
+		base = vector->iov_base;
+		len = vector->iov_len;
+		vector++;
+		nr_segs--;
+
+		nr = fn(filp, base, len, ppos);
+
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
+		}
+		ret += nr;
+		if (nr != len)
+			break;
+	}
+
+	return ret;
+}
+
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
@@ -457,12 +515,9 @@ static ssize_t do_readv_writev(int type,
 			       const struct iovec __user * uvector,
 			       unsigned long nr_segs, loff_t *pos)
 {
-	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
-	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
-
 	size_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *vector;
+	struct iovec *iov = iovstack;
 	ssize_t ret;
 	int seg;
 	io_fn_t fn;
@@ -532,39 +587,17 @@ static ssize_t do_readv_writev(int type,
 	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
-		fnv = file->f_op->readv;
+		fnv = file->f_op->aio_read;
 	} else {
 		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->writev;
-	}
-	if (fnv) {
-		ret = fnv(file, iov, nr_segs, pos);
-		goto out;
+		fnv = file->f_op->aio_write;
 	}
 
-	/* Do it by hand, with file-ops */
-	ret = 0;
-	vector = iov;
-	while (nr_segs > 0) {
-		void __user * base;
-		size_t len;
-		ssize_t nr;
-
-		base = vector->iov_base;
-		len = vector->iov_len;
-		vector++;
-		nr_segs--;
-
-		nr = fn(file, base, len, pos);
+	if (fnv)
+		ret = do_sync_readv_writev(file, iov, nr_segs, tot_len, pos, fnv);
+	else
+		ret = do_loop_readv_writev(file, iov, nr_segs, pos, fn);
 
-		if (nr < 0) {
-			if (!ret) ret = nr;
-			break;
-		}
-		ret += nr;
-		if (nr != len)
-			break;
-	}
 out:
 	if (iov != iovstack)
 		kfree(iov);
@@ -585,7 +618,7 @@ ssize_t vfs_readv(struct file *file, con
 {
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
+	if (!file->f_op || (!file->f_op->aio_read && !file->f_op->read))
 		return -EINVAL;
 
 	return do_readv_writev(READ, file, vec, vlen, pos);
@@ -598,7 +631,7 @@ ssize_t vfs_writev(struct file *file, co
 {
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
+	if (!file->f_op || (!file->f_op->aio_write && !file->f_op->write))
 		return -EINVAL;
 
 	return do_readv_writev(WRITE, file, vec, vlen, pos);
Index: linux-2.6.17-rc3.save/fs/read_write.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3.save/fs/read_write.h	2006-05-09 08:08:28.000000000 -0700
@@ -0,0 +1,14 @@
+/*
+ * This file is only for sharing some helpers from read_write.c with compat.c.
+ * Don't use anywhere else.
+ */
+
+
+typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
+typedef ssize_t (*iov_fn_t)(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t);
+
+ssize_t do_sync_readv_writev(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, size_t len, loff_t *ppos, iov_fn_t fn);
+ssize_t do_loop_readv_writev(struct file *filp, struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, io_fn_t fn);
Index: linux-2.6.17-rc3.save/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.17-rc3.save.orig/fs/xfs/linux-2.6/xfs_file.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/xfs/linux-2.6/xfs_file.c	2006-05-09 08:08:28.000000000 -0700
@@ -129,94 +129,6 @@ xfs_file_aio_write_invis(
 	return __xfs_file_write(iocb, iov, nr_segs, IO_ISAIO|IO_INVIS, pos);
 }
 
-STATIC inline ssize_t
-__xfs_file_readv(
-	struct file		*file,
-	const struct iovec 	*iov,
-	int			ioflags,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	struct inode	*inode = file->f_mapping->host;
-	vnode_t		*vp = vn_from_inode(inode);
-	struct kiocb	kiocb;
-	ssize_t		rval;
-
-	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *ppos;
-
-	if (unlikely(file->f_flags & O_DIRECT))
-		ioflags |= IO_ISDIRECT;
-	VOP_READ(vp, &kiocb, iov, nr_segs, &kiocb.ki_pos, ioflags, NULL, rval);
-
-	*ppos = kiocb.ki_pos;
-	return rval;
-}
-
-STATIC ssize_t
-xfs_file_readv(
-	struct file		*file,
-	const struct iovec 	*iov,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	return __xfs_file_readv(file, iov, 0, nr_segs, ppos);
-}
-
-STATIC ssize_t
-xfs_file_readv_invis(
-	struct file		*file,
-	const struct iovec 	*iov,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	return __xfs_file_readv(file, iov, IO_INVIS, nr_segs, ppos);
-}
-
-STATIC inline ssize_t
-__xfs_file_writev(
-	struct file		*file,
-	const struct iovec 	*iov,
-	int			ioflags,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	struct inode	*inode = file->f_mapping->host;
-	vnode_t		*vp = vn_from_inode(inode);
-	struct kiocb	kiocb;
-	ssize_t		rval;
-
-	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *ppos;
-	if (unlikely(file->f_flags & O_DIRECT))
-		ioflags |= IO_ISDIRECT;
-
-	VOP_WRITE(vp, &kiocb, iov, nr_segs, &kiocb.ki_pos, ioflags, NULL, rval);
-
-	*ppos = kiocb.ki_pos;
-	return rval;
-}
-
-STATIC ssize_t
-xfs_file_writev(
-	struct file		*file,
-	const struct iovec 	*iov,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	return __xfs_file_writev(file, iov, 0, nr_segs, ppos);
-}
-
-STATIC ssize_t
-xfs_file_writev_invis(
-	struct file		*file,
-	const struct iovec 	*iov,
-	unsigned long		nr_segs,
-	loff_t			*ppos)
-{
-	return __xfs_file_writev(file, iov, IO_INVIS, nr_segs, ppos);
-}
-
 STATIC ssize_t
 xfs_file_sendfile(
 	struct file		*filp,
@@ -577,8 +489,6 @@ const struct file_operations xfs_file_op
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.readv		= xfs_file_readv,
-	.writev		= xfs_file_writev,
 	.aio_read	= xfs_file_aio_read,
 	.aio_write	= xfs_file_aio_write,
 	.sendfile	= xfs_file_sendfile,
@@ -601,8 +511,6 @@ const struct file_operations xfs_invis_f
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.readv		= xfs_file_readv_invis,
-	.writev		= xfs_file_writev_invis,
 	.aio_read	= xfs_file_aio_read_invis,
 	.aio_write	= xfs_file_aio_write_invis,
 	.sendfile	= xfs_file_sendfile_invis,
Index: linux-2.6.17-rc3.save/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc3.save.orig/include/linux/fs.h	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/include/linux/fs.h	2006-05-09 10:58:53.000000000 -0700
@@ -1031,8 +1031,6 @@ struct file_operations {
 	int (*aio_fsync) (struct kiocb *, int datasync);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
-	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
 	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, void *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
@@ -1624,10 +1622,6 @@ extern long do_splice_direct(struct file
 
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
-	unsigned long nr_segs, loff_t *ppos);
-ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
-			unsigned long nr_segs, loff_t *ppos);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
Index: linux-2.6.17-rc3.save/mm/filemap.c
===================================================================
--- linux-2.6.17-rc3.save.orig/mm/filemap.c	2006-05-08 15:04:57.000000000 -0700
+++ linux-2.6.17-rc3.save/mm/filemap.c	2006-05-09 08:08:28.000000000 -0700
@@ -2266,42 +2266,6 @@ ssize_t generic_file_write(struct file *
 }
 EXPORT_SYMBOL(generic_file_write);
 
-ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
-			unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	ret = __generic_file_aio_read(&kiocb, iov, nr_segs, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-EXPORT_SYMBOL(generic_file_readv);
-
-ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
-			unsigned long nr_segs, loff_t *ppos)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	ssize_t ret;
-
-	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_write_nolock(file, iov, nr_segs, ppos);
-	mutex_unlock(&inode->i_mutex);
-
-	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		int err;
-
-		err = sync_page_range(inode, mapping, *ppos - ret, ret);
-		if (err < 0)
-			ret = err;
-	}
-	return ret;
-}
-EXPORT_SYMBOL(generic_file_writev);
-
 /*
  * Called under i_mutex for writes to S_ISREG files.   Returns -EIO if something
  * went wrong during pagecache shootdown.
Index: linux-2.6.17-rc3.save/net/socket.c
===================================================================
--- linux-2.6.17-rc3.save.orig/net/socket.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/net/socket.c	2006-05-09 08:08:28.000000000 -0700
@@ -112,10 +112,6 @@ static long compat_sock_ioctl(struct fil
 		      unsigned int cmd, unsigned long arg);
 #endif
 static int sock_fasync(int fd, struct file *filp, int on);
-static ssize_t sock_readv(struct file *file, const struct iovec *vector,
-			  unsigned long count, loff_t *ppos);
-static ssize_t sock_writev(struct file *file, const struct iovec *vector,
-			  unsigned long count, loff_t *ppos);
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more);
 
@@ -138,8 +134,6 @@ static struct file_operations socket_fil
 	.open =		sock_no_open,	/* special open code to disallow open via /proc */
 	.release =	sock_close,
 	.fasync =	sock_fasync,
-	.readv =	sock_readv,
-	.writev =	sock_writev,
 	.sendpage =	sock_sendpage,
 	.splice_write = generic_splice_sendpage,
 };
@@ -736,23 +730,6 @@ static ssize_t do_sock_read(struct msghd
 	return __sock_recvmsg(iocb, sock, msg, size, msg->msg_flags);
 }
 
-static ssize_t sock_readv(struct file *file, const struct iovec *iov,
-			  unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb iocb;
-	struct sock_iocb siocb;
-	struct msghdr msg;
-	int ret;
-
-        init_sync_kiocb(&iocb, NULL);
-	iocb.private = &siocb;
-
-	ret = do_sock_read(&msg, &iocb, file, iov, nr_segs);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
-	return ret;
-}
-
 static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
 			 unsigned long nr_segs, loff_t pos)
 {
@@ -795,23 +772,6 @@ static ssize_t do_sock_write(struct msgh
 	return __sock_sendmsg(iocb, sock, msg, size);
 }
 
-static ssize_t sock_writev(struct file *file, const struct iovec *iov,
-			   unsigned long nr_segs, loff_t *ppos)
-{
-	struct msghdr msg;
-	struct kiocb iocb;
-	struct sock_iocb siocb;
-	int ret;
-
-	init_sync_kiocb(&iocb, NULL);
-	iocb.private = &siocb;
-
-	ret = do_sock_write(&msg, &iocb, file, iov, nr_segs);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
-	return ret;
-}
-
 static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
 			  unsigned long nr_segs, loff_t pos)
 {
Index: linux-2.6.17-rc3.save/sound/core/pcm_native.c
===================================================================
--- linux-2.6.17-rc3.save.orig/sound/core/pcm_native.c	2006-05-05 13:53:05.000000000 -0700
+++ linux-2.6.17-rc3.save/sound/core/pcm_native.c	2006-05-09 08:08:28.000000000 -0700
@@ -2819,8 +2819,8 @@ static ssize_t snd_pcm_write(struct file
 	return result;
 }
 
-static ssize_t snd_pcm_readv(struct file *file, const struct iovec *_vector,
-			     unsigned long count, loff_t * offset)
+static ssize_t snd_pcm_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			     unsigned long nr_segs, loff_t pos)
 
 {
 	struct snd_pcm_file *pcm_file;
@@ -2831,22 +2831,22 @@ static ssize_t snd_pcm_readv(struct file
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
-	pcm_file = file->private_data;
+	pcm_file = iocb->ki_filp->private_data;
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, return -ENXIO);
 	runtime = substream->runtime;
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
-	if (count > 1024 || count != runtime->channels)
+	if (nr_segs > 1024 || nr_segs != runtime->channels)
 		return -EINVAL;
-	if (!frame_aligned(runtime, _vector->iov_len))
+	if (!frame_aligned(runtime, iov->iov_len))
 		return -EINVAL;
-	frames = bytes_to_samples(runtime, _vector->iov_len);
-	bufs = kmalloc(sizeof(void *) * count, GFP_KERNEL);
+	frames = bytes_to_samples(runtime, iov->iov_len);
+	bufs = kmalloc(sizeof(void *) * nr_segs, GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
-	for (i = 0; i < count; ++i)
-		bufs[i] = _vector[i].iov_base;
+	for (i = 0; i < nr_segs; ++i)
+		bufs[i] = iov[i].iov_base;
 	result = snd_pcm_lib_readv(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
@@ -2854,8 +2854,8 @@ static ssize_t snd_pcm_readv(struct file
 	return result;
 }
 
-static ssize_t snd_pcm_writev(struct file *file, const struct iovec *_vector,
-			      unsigned long count, loff_t * offset)
+static ssize_t snd_pcm_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t pos)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
@@ -2865,7 +2865,7 @@ static ssize_t snd_pcm_writev(struct fil
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
-	pcm_file = file->private_data;
+	pcm_file = iocb->ki_filp->private_data;
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
 	runtime = substream->runtime;
@@ -2873,17 +2873,17 @@ static ssize_t snd_pcm_writev(struct fil
 		result = -EBADFD;
 		goto end;
 	}
-	if (count > 128 || count != runtime->channels ||
-	    !frame_aligned(runtime, _vector->iov_len)) {
+	if (nr_segs > 128 || nr_segs != runtime->channels ||
+	    !frame_aligned(runtime, iov->iov_len)) {
 		result = -EINVAL;
 		goto end;
 	}
-	frames = bytes_to_samples(runtime, _vector->iov_len);
-	bufs = kmalloc(sizeof(void *) * count, GFP_KERNEL);
+	frames = bytes_to_samples(runtime, iov->iov_len);
+	bufs = kmalloc(sizeof(void *) * nr_segs, GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
-	for (i = 0; i < count; ++i)
-		bufs[i] = _vector[i].iov_base;
+	for (i = 0; i < nr_segs; ++i)
+		bufs[i] = iov[i].iov_base;
 	result = snd_pcm_lib_writev(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
@@ -3389,7 +3389,7 @@ struct file_operations snd_pcm_f_ops[2] 
 	{
 		.owner =		THIS_MODULE,
 		.write =		snd_pcm_write,
-		.writev =		snd_pcm_writev,
+		.aio_write =		snd_pcm_aio_write,
 		.open =			snd_pcm_playback_open,
 		.release =		snd_pcm_release,
 		.poll =			snd_pcm_playback_poll,
@@ -3401,7 +3401,7 @@ struct file_operations snd_pcm_f_ops[2] 
 	{
 		.owner =		THIS_MODULE,
 		.read =			snd_pcm_read,
-		.readv =		snd_pcm_readv,
+		.aio_read =		snd_pcm_aio_read,
 		.open =			snd_pcm_capture_open,
 		.release =		snd_pcm_release,
 		.poll =			snd_pcm_capture_poll,


