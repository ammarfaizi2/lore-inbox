Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWEWPFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWEWPFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWEWPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:05:20 -0400
Received: from ihug-mail.icp-qv1-irony6.iinet.net.au ([203.59.1.224]:16417
	"EHLO mail-ihug.icp-qv1-irony6.iinet.net.au") by vger.kernel.org
	with ESMTP id S1751187AbWEWPFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:05:19 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,161,1146412800"; 
   d="scan'208"; a="307655752:sNHT285570876"
Subject: Re: [PATCH 2/4] Remove readv/writev methods and
	use	aio_read/aio_write instead
From: Ian Kent <raven@themaw.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu,
       Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4472C7E1.3060004@themaw.net>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
	 <20060521180037.3c8f2847.akpm@osdl.org>
	 <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>
	 <20060522100640.0710f7da.akpm@osdl.org>
	 <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>
	 <4472C7E1.3060004@themaw.net>
Content-Type: text/plain
Date: Tue, 23 May 2006 22:35:14 +0800
Message-Id: <1148394915.8788.4.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 16:29 +0800, Ian Kent wrote:
> Badari Pulavarty wrote:
> > On Mon, 2006-05-22 at 10:06 -0700, Andrew Morton wrote:
> >> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >>> On Sun, 2006-05-21 at 18:00 -0700, Andrew Morton wrote:
> >>>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >>>>> This patch removes readv() and writev() methods and replaces
> >>>>>  them with aio_read()/aio_write() methods.
> >>>> And it breaks autofs4
> >>>>
> >>>> autofs: pipe file descriptor does not contain proper ops
> >>>>
> >>> Any easy test case to reproduce the problem ?
> >>>
> >> Grab an FC5 setup, copy RH's .config into your tree.
> > 
> > Will do. 
> > 
> > Like I mentioned, I am travelling this week. I would really
> > appreciate if someone could test my updated patch (I sent out
> > in my earlier mail).
> 
> Doesn't seem to apply to 2.6.17-rc4.
> 
> [raven@raven linux-2.6.16]$ patch -p1 < 
> ~/remove-readv_writev-methods-and-use-aio_read_aio_write.patch
> patching file drivers/char/raw.c
> Hunk #1 succeeded at 270 (offset 12 lines).
> patching file drivers/net/tun.c
> patching file fs/bad_inode.c
> patching file fs/block_dev.c
> Hunk #1 succeeded at 1101 (offset 8 lines).
> patching file fs/cifs/cifsfs.c
> Hunk #1 FAILED at 484.
> 1 out of 3 hunks FAILED -- saving rejects to file fs/cifs/cifsfs.c.rej

Function cifs_file_writev appears to be already present.

> patching file fs/compat.c
> patching file fs/ext2/file.c
> patching file fs/ext3/file.c
> Hunk #1 succeeded at 111 (offset -1 lines).
> patching file fs/fat/file.c
> patching file fs/fuse/dev.c
> patching file fs/hostfs/hostfs_kern.c
> patching file fs/jfs/file.c
> patching file fs/ntfs/file.c
> Hunk #1 succeeded at 2298 (offset 2 lines).
> patching file fs/pipe.c
> patching file fs/read_write.c
> Hunk #2 succeeded at 439 (offset -12 lines).
> Hunk #4 succeeded at 574 (offset -12 lines).
> Hunk #6 succeeded at 619 (offset -12 lines).
> patching file fs/read_write.h
> patching file fs/xfs/linux-2.6/xfs_file.c
> Hunk #1 succeeded at 131 with fuzz 1 (offset 2 lines).
> Hunk #3 succeeded at 513 (offset 2 lines).
> patching file include/linux/fs.h
> patching file mm/filemap.c
> Hunk #1 succeeded at 2300 (offset 2 lines).
> patching file net/socket.c
> Hunk #3 FAILED at 732.
> Hunk #4 FAILED at 774.
> 2 out of 4 hunks FAILED -- saving rejects to file net/socket.c.rej

And similarly sock_readv and sock_writev.

> patching file sound/core/pcm_native.c
> [raven@raven linux-2.6.16]$
> 

At a glance they look the same as the ones in the patch.

In case it's helpful for comparison here is a patch made after the
above.

--- linux-2.6.16/drivers/char/raw.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:21.000000000 +0800
+++ linux-2.6.16/drivers/char/raw.c	2006-05-23 22:07:29.000000000 +0800
@@ -270,8 +270,6 @@ static struct file_operations raw_fops =
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
-	.readv	= 	generic_file_readv,
-	.writev	= 	generic_file_writev,
 	.owner	=	THIS_MODULE,
 };
 
--- linux-2.6.16/net/socket.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:33.000000000 +0800
+++ linux-2.6.16/net/socket.c	2006-05-23 22:07:29.000000000 +0800
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
--- linux-2.6.16/mm/filemap.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:32.000000000 +0800
+++ linux-2.6.16/mm/filemap.c	2006-05-23 22:07:29.000000000 +0800
@@ -2300,42 +2300,6 @@ ssize_t generic_file_write(struct file *
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
--- linux-2.6.16/fs/xfs/linux-2.6/xfs_file.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:30.000000000 +0800
+++ linux-2.6.16/fs/xfs/linux-2.6/xfs_file.c	2006-05-23 22:07:29.000000000 +0800
@@ -131,94 +131,6 @@ xfs_file_aio_write_invis(
 	return __xfs_file_write(iocb, buf, IO_ISAIO|IO_INVIS, count, pos);
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
@@ -579,8 +491,6 @@ const struct file_operations xfs_file_op
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.readv		= xfs_file_readv,
-	.writev		= xfs_file_writev,
 	.aio_read	= xfs_file_aio_read,
 	.aio_write	= xfs_file_aio_write,
 	.sendfile	= xfs_file_sendfile,
@@ -603,8 +513,6 @@ const struct file_operations xfs_invis_f
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.readv		= xfs_file_readv_invis,
-	.writev		= xfs_file_writev_invis,
 	.aio_read	= xfs_file_aio_read_invis,
 	.aio_write	= xfs_file_aio_write_invis,
 	.sendfile	= xfs_file_sendfile_invis,
--- linux-2.6.16/fs/read_write.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:30.000000000 +0800
+++ linux-2.6.16/fs/read_write.c	2006-05-23 22:07:29.000000000 +0800
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include "read_write.h"
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -438,6 +439,62 @@ unsigned long iov_shorten(struct iovec *
 
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
+	while (nr_segs > 0) {
+		void __user *base;
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
 
@@ -445,12 +502,9 @@ static ssize_t do_readv_writev(int type,
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
@@ -520,39 +574,18 @@ static ssize_t do_readv_writev(int type,
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
@@ -573,7 +606,7 @@ ssize_t vfs_readv(struct file *file, con
 {
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
+	if (!file->f_op || (!file->f_op->aio_read && !file->f_op->read))
 		return -EINVAL;
 
 	return do_readv_writev(READ, file, vec, vlen, pos);
@@ -586,7 +619,7 @@ ssize_t vfs_writev(struct file *file, co
 {
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
+	if (!file->f_op || (!file->f_op->aio_write && !file->f_op->write))
 		return -EINVAL;
 
 	return do_readv_writev(WRITE, file, vec, vlen, pos);
--- linux-2.6.16/fs/cifs/cifsfs.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:28.000000000 +0800
+++ linux-2.6.16/fs/cifs/cifsfs.c	2006-05-23 22:07:29.000000000 +0800
@@ -581,8 +581,6 @@ struct inode_operations cifs_symlink_ino
 const struct file_operations cifs_file_ops = {
 	.read = do_sync_read,
 	.write = do_sync_write,
-	.readv = generic_file_readv,
-	.writev = cifs_file_writev,
 	.aio_read = generic_file_aio_read,
 	.aio_write = cifs_file_aio_write,
 	.open = cifs_open,
@@ -624,8 +622,6 @@ const struct file_operations cifs_file_d
 const struct file_operations cifs_file_nobrl_ops = {
 	.read = do_sync_read,
 	.write = do_sync_write,
-	.readv = generic_file_readv,
-	.writev = cifs_file_writev,
 	.aio_read = generic_file_aio_read,
 	.aio_write = cifs_file_aio_write,
 	.open = cifs_open,
--- linux-2.6.16/fs/block_dev.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:28.000000000 +0800
+++ linux-2.6.16/fs/block_dev.c	2006-05-23 22:07:29.000000000 +0800
@@ -1101,8 +1101,6 @@ const struct file_operations def_blk_fop
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.readv		= generic_file_readv,
-	.writev		= generic_file_write_nolock,
 	.sendfile	= generic_file_sendfile,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= generic_file_splice_write,
--- linux-2.6.16/fs/ntfs/file.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:29.000000000 +0800
+++ linux-2.6.16/fs/ntfs/file.c	2006-05-23 22:07:29.000000000 +0800
@@ -2298,11 +2298,9 @@ const struct file_operations ntfs_file_o
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
--- linux-2.6.16/fs/ext3/file.cremove-readv_writev-methods-and-use-aio_read_aio_write	2006-05-23 22:06:28.000000000 +0800
+++ linux-2.6.16/fs/ext3/file.c	2006-05-23 22:07:29.000000000 +0800
@@ -111,8 +111,6 @@ const struct file_operations ext3_file_o
 	.write		= do_sync_write,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= ext3_file_write,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,

