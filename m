Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbSJOTNv>; Tue, 15 Oct 2002 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSJOTNv>; Tue, 15 Oct 2002 15:13:51 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:1421 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264725AbSJOTNg>;
	Tue, 15 Oct 2002 15:13:36 -0400
Date: Tue, 15 Oct 2002 22:33:15 -0400
From: Christoph Hellwig <hch@sgi.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: [RFC] iovec in ->aio_read/->aio_write
Message-ID: <20021015223315.A21139@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, bcrl@redhat.com,
	akpm@digeo.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently looked into implementing the aio read and write
methods for XFS.  Although all of read/write readv/writev
and aio_read/aio_write end up calling the exactly same code
in filemap.c (for the generic filesystem I/O code).  Filesystems
like XFS that need additional code before calling the generic
functionality have to duplicated it though.

I don't think it makes sense to keep all those interfaces.  As
the read/write entry points are used by most drivers I suggest
starting with the other two, that have far less users.  The
patch below (compiled but not booted!) changes the aio_read/
aio_write interface to take the same array of iovec like
readv/write and updates all users.  Note that we don't support
vectored I/O for the aio interface yet, but it seems like a
logical addition to me.

Proposed next steps:  Convert over all readv/writev users
to aio_read/aio_write and remove the methods.  Implement
aio_read/aio_write in all filesystems using the generic
pagecache code and kill the "normal" generic_file_read
and generic_file_write.

Comments?

--- 1.22/fs/aio.c	Sun Oct 13 17:39:40 2002
+++ edited/fs/aio.c	Tue Oct 15 20:45:37 2002
@@ -987,6 +987,28 @@
 	return -EINVAL;
 }
 
+ssize_t aio_read_single(struct kiocb *iocb, char *buf,
+			size_t count, loff_t pos)
+{
+	struct file *file = iocb->ki_filp;
+
+	iocb->ki_single.iov_base = buf;
+	iocb->ki_single.iov_len = count;
+
+	return file->f_op->aio_read(iocb, &iocb->ki_single, 1, iocb->ki_pos);
+}
+
+ssize_t aio_write_single(struct kiocb *iocb, const char *buf,
+			 size_t count, loff_t pos)
+{
+	struct file *file = iocb->ki_filp;
+
+	iocb->ki_single.iov_base = (void *)buf;
+	iocb->ki_single.iov_len = count;
+
+	return file->f_op->aio_write(iocb, &iocb->ki_single, 1, iocb->ki_pos);
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -1048,7 +1070,7 @@
 			goto out_put_req;
 		ret = -EINVAL;
 		if (file->f_op->aio_read)
-			ret = file->f_op->aio_read(req, buf,
+			ret = aio_read_single(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
 		break;
 	case IOCB_CMD_PWRITE:
@@ -1060,7 +1082,7 @@
 			goto out_put_req;
 		ret = -EINVAL;
 		if (file->f_op->aio_write)
-			ret = file->f_op->aio_write(req, buf,
+			ret = aio_write_single(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
 		break;
 	case IOCB_CMD_FDSYNC:
--- 1.19/fs/read_write.c	Thu Oct 10 23:36:26 2002
+++ edited/fs/read_write.c	Tue Oct 15 20:44:24 2002
@@ -184,7 +184,7 @@
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos);
+	ret = aio_read_single(&kiocb, buf, len, kiocb.ki_pos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	*ppos = kiocb.ki_pos;
@@ -224,7 +224,7 @@
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos);
+	ret = aio_write_single(&kiocb, buf, len, kiocb.ki_pos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	*ppos = kiocb.ki_pos;
@@ -340,6 +340,37 @@
 	}
 	return seg;
 }
+
+ssize_t do_sync_writev(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	kiocb.ki_pos = *ppos;
+	ret = filp->f_op->aio_write(&kiocb, iov, nr_segs, kiocb.ki_pos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+
+ssize_t do_sync_readv(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	kiocb.ki_pos = *ppos;
+	ret = filp->f_op->aio_write(&kiocb, iov, nr_segs, kiocb.ki_pos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+
 
 static ssize_t do_readv_writev(int type, struct file *file,
 			       const struct iovec * vector,
--- 1.9/fs/ext3/file.c	Wed Oct  9 20:32:29 2002
+++ edited/fs/ext3/file.c	Tue Oct 15 20:46:54 2002
@@ -61,7 +61,8 @@
  */
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
+ext3_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
@@ -76,15 +77,15 @@
 	if (IS_SYNC(inode) || (file->f_flags & O_SYNC))
 		mark_inode_dirty(inode);
 
-	return generic_file_aio_write(iocb, buf, count, pos);
+	return generic_file_aio_write(iocb, iov, nr_segs, pos);
 }
 
 struct file_operations ext3_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.aio_read		= generic_file_aio_read,
-	.aio_write		= ext3_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= ext3_file_aio_write,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
--- 1.21/fs/nfs/file.c	Tue Oct  8 23:37:02 2002
+++ edited/fs/nfs/file.c	Tue Oct 15 20:55:56 2002
@@ -35,8 +35,10 @@
 #define NFSDBG_FACILITY		NFSDBG_FILE
 
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
-static ssize_t nfs_file_read(struct kiocb *, char *, size_t, loff_t);
-static ssize_t nfs_file_write(struct kiocb *, const char *, size_t, loff_t);
+static ssize_t nfs_file_aio_read(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t);
+static ssize_t nfs_file_aio_write(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 
@@ -44,8 +46,8 @@
 	.llseek		= remote_llseek,
 	.read		= do_sync_read,
 	.write		= do_sync_write,
-	.aio_read		= nfs_file_read,
-	.aio_write		= nfs_file_write,
+	.aio_read	= nfs_file_aio_read,
+	.aio_write	= nfs_file_aio_write,
 	.mmap		= nfs_file_mmap,
 	.open		= nfs_open,
 	.flush		= nfs_file_flush,
@@ -91,19 +93,20 @@
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char * buf, size_t count, loff_t pos)
+nfs_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
-	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
+	dfprintk(VFS, "nfs: read(%s/%s, %lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		(unsigned long) count, (unsigned long) pos);
+		(unsigned long)pos);
 
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (!result)
-		result = generic_file_aio_read(iocb, buf, count, pos);
+		result = generic_file_aio_read(iocb, iov, nr_segs, pos);
 	return result;
 }
 
@@ -211,15 +214,16 @@
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
+nfs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		   unsigned long nr_segs, loff_t pos)
 {
 	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
-	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
+	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (unsigned long) pos);
+		inode->i_ino, (unsigned long) pos);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -228,11 +232,7 @@
 	if (result)
 		goto out;
 
-	result = count;
-	if (!count)
-		goto out;
-
-	result = generic_file_aio_write(iocb, buf, count, pos);
+	result = generic_file_aio_write(iocb, iov, nr_segs, pos);
 out:
 	return result;
 
--- 1.6/include/linux/aio.h	Thu Oct  3 22:19:27 2002
+++ edited/include/linux/aio.h	Tue Oct 15 20:38:00 2002
@@ -2,6 +2,7 @@
 #define __LINUX__AIO_H
 
 #include <linux/list.h>
+#include <linux/uio.h>
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
 
@@ -60,6 +61,7 @@
 						 * for cancellation */
 
 	void			*ki_user_obj;	/* pointer to userland's iocb */
+	struct iovec		ki_single;	/* iovec for non-vectored I/O */
 	__u64			ki_user_data;	/* user's data for completion */
 	loff_t			ki_pos;
 
@@ -145,6 +147,10 @@
 extern void FASTCALL(kick_iocb(struct kiocb *iocb));
 extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
 extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
+extern ssize_t aio_read_single(struct kiocb *iocb, char *buf,
+			size_t count, loff_t pos);
+extern ssize_t aio_write_single(struct kiocb *iocb, const char *buf,
+			size_t count, loff_t pos);
 struct mm_struct;
 extern void FASTCALL(exit_aio(struct mm_struct *mm));
 
--- 1.170/include/linux/fs.h	Fri Oct 11 10:49:46 2002
+++ edited/include/linux/fs.h	Tue Oct 15 20:37:27 2002
@@ -744,9 +744,11 @@
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, char *, size_t, loff_t);
+	ssize_t (*aio_read) (struct kiocb *, const struct iovec *,
+			unsigned long, loff_t);
 	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, const char *, size_t, loff_t);
+	ssize_t (*aio_write) (struct kiocb *, const struct iovec *,
+			unsigned long, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1242,8 +1244,10 @@
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
-extern ssize_t generic_file_aio_read(struct kiocb *, char *, size_t, loff_t);
-extern ssize_t generic_file_aio_write(struct kiocb *, const char *, size_t, loff_t);
+extern ssize_t generic_file_aio_read(struct kiocb *, const struct iovec *,
+				unsigned long, loff_t);
+extern ssize_t generic_file_aio_write(struct kiocb *, const struct iovec *,
+				unsigned long, loff_t);
 extern ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
--- 1.23/include/net/sock.h	Fri Oct 11 01:14:45 2002
+++ edited/include/net/sock.h	Tue Oct 15 20:06:13 2002
@@ -303,7 +303,6 @@
 	struct socket		*sock;
 	struct sock		*sk;
 	struct msghdr		*msg, async_msg;
-	struct iovec		async_iov;
 	struct scm_cookie	*scm, async_scm;
 };
 
--- 1.147/mm/filemap.c	Sun Oct 13 17:39:40 2002
+++ edited/mm/filemap.c	Tue Oct 15 20:41:07 2002
@@ -884,12 +884,11 @@
 }
 
 ssize_t
-generic_file_aio_read(struct kiocb *iocb, char *buf, size_t count, loff_t pos)
+generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-
 	BUG_ON(iocb->ki_pos != pos);
-	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
+	return __generic_file_aio_read(iocb, iov, nr_segs, &iocb->ki_pos);
 }
 
 ssize_t
@@ -1645,10 +1644,10 @@
 	return err;
 }
 
-ssize_t generic_file_aio_write(struct kiocb *iocb, const char *buf,
-			       size_t count, loff_t pos)
+ssize_t generic_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos)
 {
-	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
+	return generic_file_writev(iocb->ki_filp, iov, nr_segs, &iocb->ki_pos);
 }
 
 ssize_t generic_file_write(struct file *file, const char *buf,
--- 1.30/net/socket.c	Sat Oct 12 09:37:17 2002
+++ edited/net/socket.c	Tue Oct 15 21:03:19 2002
@@ -90,10 +90,10 @@
 #include <linux/netfilter.h>
 
 static int sock_no_open(struct inode *irrelevant, struct file *dontcare);
-static ssize_t sock_aio_read(struct kiocb *iocb, char *buf,
-			 size_t size, loff_t pos);
-static ssize_t sock_aio_write(struct kiocb *iocb, const char *buf,
-			  size_t size, loff_t pos);
+static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			     unsigned long nr_segs, loff_t pos);
+static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t pos);
 static int sock_mmap(struct file *file, struct vm_area_struct * vma);
 
 static int sock_close(struct inode *inode, struct file *file);
@@ -586,31 +586,31 @@
  *	area ubuf...ubuf+size-1 is writable before asking the protocol.
  */
 
-static ssize_t sock_aio_read(struct kiocb *iocb, char *ubuf,
-			 size_t size, loff_t pos)
+static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			     unsigned long nr_segs, loff_t pos)
 {
 	struct sock_iocb *x = kiocb_to_siocb(iocb);
 	struct socket *sock;
 	int flags;
+	size_t tot_len = 0;
+	int i;
 
 	if (pos != 0)
 		return -ESPIPE;
-	if (size==0)		/* Match SYS5 behaviour */
-		return 0;
 
 	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
 	x->async_msg.msg_namelen = 0;
-	x->async_msg.msg_iov = &x->async_iov;
-	x->async_msg.msg_iovlen = 1;
+	x->async_msg.msg_iov = (struct iovec *)iov;
+	x->async_msg.msg_iovlen = nr_segs;
 	x->async_msg.msg_control = NULL;
 	x->async_msg.msg_controllen = 0;
-	x->async_iov.iov_base = ubuf;
-	x->async_iov.iov_len = size;
 	flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
 
-	return __sock_recvmsg(iocb, sock, &x->async_msg, size, flags);
+        for (i = 0 ; i < nr_segs ; i++)
+                tot_len += iov[i].iov_len;
+	return __sock_recvmsg(iocb, sock, &x->async_msg, flags, tot_len);
 }
 
 
@@ -619,32 +619,32 @@
  *	is readable by the user process.
  */
 
-static ssize_t sock_aio_write(struct kiocb *iocb, const char *ubuf,
-			  size_t size, loff_t pos)
+static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t pos)
 {
 	struct sock_iocb *x = kiocb_to_siocb(iocb);
 	struct socket *sock;
+	size_t tot_len = 0;
+	int i;
 	
 	if (pos != 0)
 		return -ESPIPE;
-	if(size==0)		/* Match SYS5 behaviour */
-		return 0;
 
 	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
 	x->async_msg.msg_namelen = 0;
-	x->async_msg.msg_iov = &x->async_iov;
-	x->async_msg.msg_iovlen = 1;
+	x->async_msg.msg_iov = (struct iovec *)iov;
+	x->async_msg.msg_iovlen = nr_segs;
 	x->async_msg.msg_control = NULL;
 	x->async_msg.msg_controllen = 0;
 	x->async_msg.msg_flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
 	if (sock->type == SOCK_SEQPACKET)
 		x->async_msg.msg_flags |= MSG_EOR;
-	x->async_iov.iov_base = (void *)ubuf;
-	x->async_iov.iov_len = size;
 	
-	return __sock_sendmsg(iocb, sock, &x->async_msg, size);
+        for (i = 0 ; i < nr_segs ; i++)
+                tot_len += iov[i].iov_len;
+	return __sock_sendmsg(iocb, sock, &x->async_msg, tot_len);
 }
 
 ssize_t sock_sendpage(struct file *file, struct page *page,
