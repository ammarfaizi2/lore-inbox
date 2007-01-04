Return-Path: <linux-kernel-owner+w=401wt.eu-S932091AbXADRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXADRvP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbXADRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:51:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXADRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:51:14 -0500
Message-ID: <459D3E8E.7000405@redhat.com>
Date: Thu, 04 Jan 2007 11:51:10 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
In-Reply-To: <20070103162643.5c479836.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Al is correct, of course.  But the patch takes bad_inode.o from 280 up to 703
> bytes, which is a bit sad for some cosmetic thing which nobody ever looks
> at or modifies.
>
> Perhaps you can do
>
> static int return_EIO_int(void)
> {
> 	return -EIO;
> }
>
> static int bad_file_release(struct inode * inode, struct file * filp)
> 	__attribute__((alias("return_EIO_int")));
> static int bad_file_fsync(struct inode * inode, struct file * filp)
> 	__attribute__((alias("return_EIO_int")));
>
> etcetera?
Ok, try this on for size.  Even though the gcc manual says alias doesn't work
on all target machines, I assume linux arches are ok since alias is used
in the core module init & exit code...

Also - is it ok to alias a function with one signature to a function with
another signature?

Note... I also realized that there are a couple of file ops which expect unsigned
returns... poll and get_unmapped_area.  The latter seems to be handled just fine by
the caller, which does IS_ERR gyrations to check for errnos.

I'm not so sure about poll; some callers put the return in a signed int, others
unsigned, not sure anyone is really checking for -EIO... I think this op should
probably be returning POLLERR, so that's what I've got in this version.

Anyway, here's the latest stab at this:

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/bad_inode.c
===================================================================
--- linux-2.6.19.orig/fs/bad_inode.c
+++ linux-2.6.19/fs/bad_inode.c
@@ -14,59 +14,255 @@
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
+#include <linux/poll.h>
 
-static int return_EIO(void)
+/* Generic EIO-returners, for different types of return values */
+
+static int return_EIO_int(void)
+{
+	return -EIO;
+}
+
+static ssize_t return_EIO_ssize(void)
+{
+	return -EIO;
+}
+
+static long return_EIO_long(void)
+{
+	return -EIO;
+}
+
+static loff_t return_EIO_loff(void)
 {
 	return -EIO;
 }
 
-#define EIO_ERROR ((void *) (return_EIO))
+static long * return_EIO_ptr(void)
+{
+	return ERR_PTR(-EIO);
+}
+
+/* All the specific file ops, aliased to something with the right retval */
+
+static loff_t bad_file_llseek(struct file *file, loff_t offset, int origin)
+	__attribute__((alias("return_EIO_loff")));
+
+static ssize_t bad_file_read(struct file *filp, char __user *buf,
+			size_t size, loff_t *ppos)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_file_write(struct file *filp, const char __user *buf,
+			size_t siz, loff_t *ppos)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t pos)
+	__attribute__((alias("return_EIO_ssize")));
+
+static int bad_file_readdir(struct file * filp, void * dirent,
+			filldir_t filldir)
+	__attribute__((alias("return_EIO_int")));
+
+static unsigned int bad_file_poll(struct file *filp, poll_table *wait)
+{
+	return POLLERR;
+}
+
+static int bad_file_ioctl (struct inode * inode, struct file * filp,
+			unsigned int cmd, unsigned long arg)
+	__attribute__((alias("return_EIO_int")));
+
+static long bad_file_unlocked_ioctl(struct file *file, unsigned cmd,
+			unsigned long arg)
+	__attribute__((alias("return_EIO_long")));
+
+static long bad_file_compat_ioctl(struct file *file, unsigned int cmd,
+			unsigned long arg)
+	__attribute__((alias("return_EIO_long")));
+
+static int bad_file_mmap(struct file * file, struct vm_area_struct * vma)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_open(struct inode * inode, struct file * filp)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_flush(struct file *file, fl_owner_t id)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_release(struct inode * inode, struct file * filp)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_fsync(struct file * file, struct dentry *dentry,
+			int datasync)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_aio_fsync(struct kiocb *iocb, int datasync)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_fasync(int fd, struct file *filp, int on)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_lock(struct file *file, int cmd, struct file_lock *fl)
+	__attribute__((alias("return_EIO_int")));
+
+static ssize_t bad_file_sendfile(struct file *in_file, loff_t *ppos,
+			size_t count, read_actor_t actor, void *target)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_file_sendpage(struct file *file, struct page *page,
+			int off, size_t len, loff_t *pos, int more)
+	__attribute__((alias("return_EIO_ssize")));
+
+/* caller must use IS_ERR to check for negative error returns */
+static unsigned long bad_file_get_unmapped_area(struct file *file,
+				unsigned long addr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+	__attribute__((alias("return_EIO_long")));
+
+static int bad_file_check_flags(int flags)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_dir_notify(struct file * file, unsigned long arg)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_file_flock(struct file *filp, int cmd, struct file_lock *fl)
+	__attribute__((alias("return_EIO_int")));
+
+static ssize_t bad_file_splice_write(struct pipe_inode_info *pipe,
+			struct file *out, loff_t *ppos, size_t len,
+			unsigned int flags)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_file_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags)
+	__attribute__((alias("return_EIO_ssize")));
 
 static const struct file_operations bad_file_ops =
 {
-	.llseek		= EIO_ERROR,
-	.aio_read	= EIO_ERROR,
-	.read		= EIO_ERROR,
-	.write		= EIO_ERROR,
-	.aio_write	= EIO_ERROR,
-	.readdir	= EIO_ERROR,
-	.poll		= EIO_ERROR,
-	.ioctl		= EIO_ERROR,
-	.mmap		= EIO_ERROR,
-	.open		= EIO_ERROR,
-	.flush		= EIO_ERROR,
-	.release	= EIO_ERROR,
-	.fsync		= EIO_ERROR,
-	.aio_fsync	= EIO_ERROR,
-	.fasync		= EIO_ERROR,
-	.lock		= EIO_ERROR,
-	.sendfile	= EIO_ERROR,
-	.sendpage	= EIO_ERROR,
-	.get_unmapped_area = EIO_ERROR,
+	.llseek		= bad_file_llseek,
+	.read		= bad_file_read,
+	.write		= bad_file_write,
+	.aio_read	= bad_file_aio_read,
+	.aio_write	= bad_file_aio_write,
+	.readdir	= bad_file_readdir,
+	.poll		= bad_file_poll,
+	.ioctl		= bad_file_ioctl,
+	.unlocked_ioctl	= bad_file_unlocked_ioctl,
+	.compat_ioctl	= bad_file_compat_ioctl,
+	.mmap		= bad_file_mmap,
+	.open		= bad_file_open,
+	.flush		= bad_file_flush,
+	.release	= bad_file_release,
+	.fsync		= bad_file_fsync,
+	.aio_fsync	= bad_file_aio_fsync,
+	.fasync		= bad_file_fasync,
+	.lock		= bad_file_lock,
+	.sendfile	= bad_file_sendfile,
+	.sendpage	= bad_file_sendpage,
+	.get_unmapped_area = bad_file_get_unmapped_area,
+	.check_flags	= bad_file_check_flags,
+	.dir_notify	= bad_file_dir_notify,
+	.flock		= bad_file_flock,
+	.splice_write	= bad_file_splice_write,
+	.splice_read	= bad_file_splice_read,
 };
 
+/* All the specific inode ops, aliased to something with the right retval */
+
+static int bad_inode_create (struct inode * dir, struct dentry * dentry,
+		int mode, struct nameidata *nd)
+	__attribute__((alias("return_EIO_int")));
+
+static struct dentry *bad_inode_lookup(struct inode * dir,
+			struct dentry *dentry, struct nameidata *nd)
+	__attribute__((alias("return_EIO_ptr")));
+
+static int bad_inode_link (struct dentry * old_dentry, struct inode * dir,
+		struct dentry *dentry)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_unlink(struct inode * dir, struct dentry *dentry)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_symlink (struct inode * dir, struct dentry *dentry,
+		const char * symname)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_mkdir(struct inode * dir, struct dentry * dentry,
+			int mode)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_rmdir (struct inode * dir, struct dentry *dentry)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_mknod (struct inode * dir, struct dentry *dentry,
+			int mode, dev_t rdev)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_rename (struct inode * old_dir, struct dentry *old_dentry,
+		struct inode * new_dir, struct dentry *new_dentry)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_readlink(struct dentry *dentry, char __user *buffer,
+		int buflen)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_permission(struct inode *inode, int mask,
+			struct nameidata *nd)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_setattr(struct dentry *direntry, struct iattr *attrs)
+	__attribute__((alias("return_EIO_int")));
+
+static int bad_inode_setxattr(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags)
+	__attribute__((alias("return_EIO_int")));
+
+static ssize_t bad_inode_getxattr(struct dentry *dentry, const char *name,
+			void *buffer, size_t size)
+	__attribute__((alias("return_EIO_ssize")));
+
+static ssize_t bad_inode_listxattr(struct dentry *dentry, char *buffer,
+			size_t buffer_size)
+	__attribute__((alias("return_EIO_ssize")));
+
+static int bad_inode_removexattr(struct dentry *dentry, const char *name)
+	__attribute__((alias("return_EIO_int")));
+
 static struct inode_operations bad_inode_ops =
 {
-	.create		= EIO_ERROR,
-	.lookup		= EIO_ERROR,
-	.link		= EIO_ERROR,
-	.unlink		= EIO_ERROR,
-	.symlink	= EIO_ERROR,
-	.mkdir		= EIO_ERROR,
-	.rmdir		= EIO_ERROR,
-	.mknod		= EIO_ERROR,
-	.rename		= EIO_ERROR,
-	.readlink	= EIO_ERROR,
+	.create		= bad_inode_create,
+	.lookup		= bad_inode_lookup,
+	.link		= bad_inode_link,
+	.unlink		= bad_inode_unlink,
+	.symlink	= bad_inode_symlink,
+	.mkdir		= bad_inode_mkdir,
+	.rmdir		= bad_inode_rmdir,
+	.mknod		= bad_inode_mknod,
+	.rename		= bad_inode_rename,
+	.readlink	= bad_inode_readlink,
 	/* follow_link must be no-op, otherwise unmounting this inode
 	   won't work */
-	.truncate	= EIO_ERROR,
-	.permission	= EIO_ERROR,
-	.getattr	= EIO_ERROR,
-	.setattr	= EIO_ERROR,
-	.setxattr	= EIO_ERROR,
-	.getxattr	= EIO_ERROR,
-	.listxattr	= EIO_ERROR,
-	.removexattr	= EIO_ERROR,
+	/* put_link returns void */
+	/* truncate returns void */
+	.permission	= bad_inode_permission,
+	.getattr	= bad_inode_getattr,
+	.setattr	= bad_inode_setattr,
+	.setxattr	= bad_inode_setxattr,
+	.getxattr	= bad_inode_getxattr,
+	.listxattr	= bad_inode_listxattr,
+	.removexattr	= bad_inode_removexattr,
+	/* truncate_range returns void */
 };
 
 

