Return-Path: <linux-kernel-owner+w=401wt.eu-S1750858AbXACSm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXACSm4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXACSm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:42:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41613 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXACSmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:42:54 -0500
Message-ID: <459BF927.2020108@sandeen.net>
Date: Wed, 03 Jan 2007 12:42:47 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fix memory corruption from misinterpreted bad_inode_ops return
 values
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CVE-2006-5753 is for a case where an inode can be marked bad, switching 
the ops to bad_inode_ops, which are all connected as:

static int return_EIO(void)
{
        return -EIO;
}

#define EIO_ERROR ((void *) (return_EIO))

static struct inode_operations bad_inode_ops =
{
        .create         = bad_inode_create
...etc...

The problem here is that the void cast causes return types to not be 
promoted, and for ops such as listxattr which expect more than 32 bits of
return value, the 32-bit -EIO is interpreted as a large positive 64-bit 
number, i.e. 0x00000000fffffffa instead of 0xfffffffa.

This goes particularly badly when the return value is taken as a number of
bytes to copy into, say, a user's buffer for example...

I originally had coded up the fix by creating a return_EIO_<TYPE> macro
for each return type, like this:

static int return_EIO_int(void)
{
	return -EIO;
}
#define EIO_ERROR_INT ((void *) (return_EIO_int))

static struct inode_operations bad_inode_ops =
{
	.create		= EIO_ERROR_INT,
...etc...

but Al felt that it was probably better to create an EIO-returner for each 
actual op signature.  Since so few ops share a signature, I just went ahead 
& created an EIO function for each individual file & inode op that returns
a value.

So here's the first stab at fixing it.  I'm sure there are style points
to be hashed out.  Putting all the functions as static inlines in a header
was just to avoid hundreds of lines of simple function declarations before 
we get to the meat of bad_inode.c, but it's probably technically wrong to 
put it in a header.  Also if putting a copyright on that trivial header file
is going overboard, just let me know.  Or if anyone has a less verbose
but still correct way to address this problem, I'm all ears.

Thanks,

-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.20-rc3/fs/bad_inode.h
===================================================================
--- /dev/null
+++ linux-2.6.20-rc3/fs/bad_inode.h
@@ -0,0 +1,266 @@
+/* fs/bad_inode.h
+ * bad_inode / bad_file internal definitions
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by Eric Sandeen (sandeen@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* Bad file ops */
+
+static inline loff_t bad_file_llseek(struct file *file, loff_t offset,
+			int origin)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_read(struct file *filp, char __user *buf,
+			size_t size, loff_t *ppos)
+{
+        return -EIO;
+}
+
+static inline ssize_t bad_file_write(struct file *filp, const char __user *buf,
+		size_t siz, loff_t *ppos)
+{
+        return -EIO;
+}
+
+static inline ssize_t bad_file_aio_read(struct kiocb *iocb,
+		const struct iovec *iov, unsigned long nr_segs, loff_t pos)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_aio_write(struct kiocb *iocb,
+		const struct iovec *iov, unsigned long nr_segs, loff_t pos)
+{
+	return -EIO;
+}
+
+static inline int bad_file_readdir(struct file * filp, void * dirent,
+			filldir_t filldir)
+{
+	return -EIO;
+}
+
+static inline unsigned int bad_file_poll(struct file *filp, poll_table *wait)
+{
+	return -EIO;
+}
+
+static inline int bad_file_ioctl (struct inode * inode, struct file * filp,
+			unsigned int cmd, unsigned long arg)
+{
+	return -EIO;
+}
+
+static inline long bad_file_unlocked_ioctl(struct file *file, unsigned cmd,
+			unsigned long arg)
+{
+	return -EIO;
+}
+
+static inline long bad_file_compat_ioctl(struct file *file, unsigned int cmd,
+			unsigned long arg)
+{
+	return -EIO;
+}
+
+static inline int bad_file_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	return -EIO;
+}
+
+static inline int bad_file_open(struct inode * inode, struct file * filp)
+{
+	return -EIO;
+}
+
+static inline int bad_file_flush(struct file *file, fl_owner_t id)
+{
+	return -EIO;
+}
+
+static inline int bad_file_release(struct inode * inode, struct file * filp)
+{
+	return -EIO;
+}
+
+static inline int bad_file_fsync(struct file * file, struct dentry *dentry,
+			int datasync)
+{
+	return -EIO;
+}
+
+static inline int bad_file_aio_fsync(struct kiocb *iocb, int datasync)
+{
+	return -EIO;
+}
+
+static inline int bad_file_fasync(int fd, struct file *filp, int on)
+{
+	return -EIO;
+}
+
+static inline int bad_file_lock(struct file *file, int cmd,
+			struct file_lock *fl)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_sendfile(struct file *in_file, loff_t *ppos,
+			size_t count, read_actor_t actor, void *target)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_sendpage(struct file *file, struct page *page,
+			int off, size_t len, loff_t *pos, int more)
+{
+	return -EIO;
+}
+
+static inline unsigned long bad_file_get_unmapped_area(struct file *file,
+				unsigned long addr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	return -EIO;
+}
+
+static inline int bad_file_check_flags(int flags)
+{
+	return -EIO;
+}
+
+static inline int bad_file_dir_notify(struct file * file, unsigned long arg)
+{
+	return -EIO;
+}
+
+static inline int bad_file_flock(struct file *filp, int cmd,
+			struct file_lock *fl)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_splice_write(struct pipe_inode_info *pipe,
+			struct file *out, loff_t *ppos, size_t len,
+			unsigned int flags)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_file_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags)
+{
+	return -EIO;
+}
+
+/* Bad inode ops */
+
+static inline int bad_inode_create (struct inode * dir,
+			struct dentry * dentry, int mode, struct nameidata *nd)
+{
+	return -EIO;
+}
+
+static inline struct dentry *bad_inode_lookup(struct inode * dir,
+				struct dentry *dentry, struct nameidata *nd)
+{
+	return ERR_PTR(-EIO);
+}
+
+static inline int bad_inode_link (struct dentry * old_dentry,
+			struct inode * dir, struct dentry *dentry)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_unlink(struct inode * dir, struct dentry *dentry)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_symlink (struct inode * dir,
+			struct dentry *dentry, const char * symname)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_mkdir(struct inode * dir, struct dentry * dentry,
+			int mode)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_rmdir (struct inode * dir, struct dentry *dentry)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_mknod (struct inode * dir, struct dentry *dentry,
+			int mode, dev_t rdev)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_rename (struct inode * old_dir,
+			struct dentry *old_dentry, struct inode * new_dir,
+			struct dentry *new_dentry)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_readlink(struct dentry *dentry,
+			char __user *buffer, int buflen)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_permission(struct inode *inode, int mask,
+			struct nameidata *nd)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_setattr(struct dentry *direntry,
+			struct iattr *attrs)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_setxattr(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_inode_getxattr(struct dentry *dentry,
+			const char *name, void *buffer, size_t size)
+{
+	return -EIO;
+}
+
+static inline ssize_t bad_inode_listxattr(struct dentry *dentry, char *buffer,
+		size_t buffer_size)
+{
+	return -EIO;
+}
+
+static inline int bad_inode_removexattr(struct dentry *dentry, const char *name)
+{
+	return -EIO;
+}
+

Index: linux-2.6.20-rc3/fs/bad_inode.c
===================================================================
--- linux-2.6.20-rc3.orig/fs/bad_inode.c
+++ linux-2.6.20-rc3/fs/bad_inode.c
@@ -14,59 +14,64 @@
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
+#include <linux/poll.h>
+#include "bad_inode.h"
 
-static int return_EIO(void)
-{
-	return -EIO;
-}
-
-#define EIO_ERROR ((void *) (return_EIO))
 
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
+	/* put_link is a void function */
+	/* truncate is a void function */
+	.permission	= bad_inode_permission,
+	.getattr	= bad_inode_getattr,
+	.setattr	= bad_inode_setattr,
+	.setxattr	= bad_inode_setxattr,
+	.getxattr	= bad_inode_getxattr,
+	.listxattr	= bad_inode_listxattr,
+	.removexattr	= bad_inode_removexattr,
+	/* truncate_range is a void function */
 };
 



