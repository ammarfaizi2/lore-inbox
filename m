Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263598AbUDZJVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUDZJVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUDZJVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:21:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:21453 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263598AbUDZJUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:20:42 -0400
Date: Mon, 26 Apr 2004 11:20:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH COW] sys_copyfile
Message-ID: <20040426092045.GC895@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a fun patch.  With warm cache, copyfile() is about 10%
faster than the usual reas/write loop on my notebook.  Not that I
really cared about such an optimization, the real point is that
in-kernel file copying is finally possible.

Depends on the generic sendpage patch I sent earlier.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike


Adds a new syscall, copyfile() which does as the name sais.

This syscall is a preparation for real cowlinks, but it might make sense on
it's own as well.  For cowlinks, the real copy is not done until the first
write (or similar operation) occurs, but at that point, both operations
should be the same.

 arch/i386/kernel/entry.S |    1 
 fs/namei.c               |  113 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/read_write.c          |   99 +++++++++++++++++++++++------------------
 include/linux/fs.h       |    1 
 include/linux/syscalls.h |    2 
 5 files changed, 174 insertions(+), 42 deletions(-)


--- linux-2.6.5cow/arch/i386/kernel/entry.S~copyfile	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/arch/i386/kernel/entry.S	2004-04-25 16:03:36.000000000 +0200
@@ -882,5 +882,6 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_copyfile
 
 syscall_table_size=(.-sys_call_table)
--- linux-2.6.5cow/fs/namei.c~copyfile	2004-04-14 16:22:24.000000000 +0200
+++ linux-2.6.5cow/fs/namei.c	2004-04-25 16:03:58.000000000 +0200
@@ -2213,6 +2213,119 @@
 	return error;
 }
 
+/* note how we open() two struct file *, just to do the sendfile().  this
+ * should not be necessary, only nfs, smbfs and cifs depend on the struct
+ * file *, while afs and all local filesystems can do without.
+ * but changing all interfaces and fixing up three filesystems is a little
+ * too much work for now.
+ */
+#include <linux/file.h> /* for fput */
+static int copy_data(struct dentry *old_dentry, struct vfsmount *old_mnt,
+		     struct dentry *new_dentry, struct vfsmount *new_mnt)
+{
+	int ret;
+	loff_t size;
+	ssize_t n;
+	struct file *old_file;
+	struct file *new_file;
+
+	old_file = dentry_open(old_dentry, old_mnt, FMODE_READ);
+	if (IS_ERR(old_file))
+		return PTR_ERR(old_file);
+
+	new_file = dentry_open(new_dentry, new_mnt, FMODE_WRITE);
+	ret = PTR_ERR(new_file);
+	if (IS_ERR(new_file))
+		goto out1;
+
+	size = i_size_read(old_file->f_dentry->d_inode);
+	if (((size_t)size != size) || ((ssize_t)size != size)) {
+		ret = -EFBIG;
+		goto out2;
+	}
+	n = vfs_sendfile(new_file, old_file, NULL, size, 0);
+	if (n == size)
+		ret = 0;
+	else if (n < 0)
+		ret = n;
+	else
+		ret = -ENOSPC;
+
+out2:
+	fput(new_file);
+out1:
+	fput(old_file);
+	return ret;
+}
+
+int do_copyfile(struct nameidata *old_nd, struct nameidata *new_nd,
+		struct dentry *new_dentry, umode_t mode)
+{
+	int ret;
+
+	if (!old_nd->dentry->d_inode)
+		return -ENOENT;
+	if (!S_ISREG(old_nd->dentry->d_inode->i_mode))
+		return -EINVAL;
+	/* FIXME: replace with proper permission check */
+	if (new_dentry->d_inode)
+		return -EEXIST;
+
+	ret = vfs_create(new_nd->dentry->d_inode, new_dentry, mode, new_nd);
+	if (ret)
+		return ret;
+
+	ret = copy_data(old_nd->dentry, old_nd->mnt, new_dentry, new_nd->mnt);
+
+	if (ret) {
+		int error = vfs_unlink(new_nd->dentry->d_inode, new_dentry);
+		BUG_ON(error);
+		/* FIXME: not sure if there are return value we should not BUG()
+		 * on */
+	}
+	return ret;
+}
+
+/* copyfile() - create a new file and copy the old one's contents into it, all
+ * inside the kernel
+ *
+ * TODO:
+ * quota
+ * notification
+ * security
+ * unlock directory during data copy
+ * loop for data copy
+ */
+int sys_copyfile(const char __user *from, const char __user *to, umode_t mode)
+{
+	int ret;
+	struct dentry *new_dentry;
+	struct nameidata old_nd, new_nd;
+
+	ret = __user_walk(from, 0, &old_nd);
+	if (ret)
+		return ret;
+
+	ret = __user_walk(to, LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, &new_nd);
+	if (ret)
+		goto out1;
+
+	new_dentry = lookup_create(&new_nd, 0);
+	ret = PTR_ERR(new_dentry);
+	if (IS_ERR(new_dentry))
+		goto out2;
+
+	ret = do_copyfile(&old_nd, &new_nd, new_dentry, mode);
+
+	dput(new_dentry);
+	up(&new_nd.dentry->d_inode->i_sem);
+out2:
+	path_release(&new_nd);
+out1:
+	path_release(&old_nd);
+	return ret;
+}
+
 int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
 {
 	int len;
--- linux-2.6.5cow/fs/read_write.c~copyfile	2004-04-06 18:50:59.000000000 +0200
+++ linux-2.6.5cow/fs/read_write.c	2004-04-25 03:21:41.000000000 +0200
@@ -537,12 +537,66 @@
 	return ret;
 }
 
+ssize_t vfs_sendfile(struct file *out_file, struct file *in_file, loff_t *ppos,
+		     size_t count, loff_t max)
+{
+	struct inode * in_inode, * out_inode;
+	loff_t pos;
+	ssize_t ret;
+
+	/* verify in_file */
+	in_inode = in_file->f_dentry->d_inode;
+	if (!in_inode)
+		return -EINVAL;
+	if (!in_file->f_op || !in_file->f_op->sendfile)
+		return -EINVAL;
+
+	if (!ppos)
+		ppos = &in_file->f_pos;
+	ret = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, *ppos, count);
+	if (ret)
+		return ret;
+
+	/* verify out_file */
+	out_inode = out_file->f_dentry->d_inode;
+	if (!out_inode)
+		return -EINVAL;
+	if (!out_file->f_op || !out_file->f_op->sendpage)
+		return -EINVAL;
+
+	ret = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
+	if (ret)
+		return ret;
+
+	ret = security_file_permission (out_file, MAY_WRITE);
+	if (ret)
+		return ret;
+
+	if (!max)
+		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
+
+	pos = *ppos;
+	if (unlikely(pos < 0))
+		return -EINVAL;
+	if (unlikely(pos + count > max)) {
+		if (pos >= max)
+			return -EOVERFLOW;
+		count = max - pos;
+	}
+
+	ret = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
+
+	if (*ppos > max)
+		return -EOVERFLOW;
+	return ret;
+}
+
+EXPORT_SYMBOL(vfs_sendfile);
+
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			   size_t count, loff_t max)
 {
 	struct file * in_file, * out_file;
-	struct inode * in_inode, * out_inode;
-	loff_t pos;
 	ssize_t retval;
 	int fput_needed_in, fput_needed_out;
 
@@ -555,17 +609,6 @@
 		goto out;
 	if (!(in_file->f_mode & FMODE_READ))
 		goto fput_in;
-	retval = -EINVAL;
-	in_inode = in_file->f_dentry->d_inode;
-	if (!in_inode)
-		goto fput_in;
-	if (!in_file->f_op || !in_file->f_op->sendfile)
-		goto fput_in;
-	if (!ppos)
-		ppos = &in_file->f_pos;
-	retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, *ppos, count);
-	if (retval)
-		goto fput_in;
 
 	retval = security_file_permission (in_file, MAY_READ);
 	if (retval)
@@ -580,36 +623,8 @@
 		goto fput_in;
 	if (!(out_file->f_mode & FMODE_WRITE))
 		goto fput_out;
-	retval = -EINVAL;
-	if (!out_file->f_op || !out_file->f_op->sendpage)
-		goto fput_out;
-	out_inode = out_file->f_dentry->d_inode;
-	retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
-	if (retval)
-		goto fput_out;
-
-	retval = security_file_permission (out_file, MAY_WRITE);
-	if (retval)
-		goto fput_out;
-
-	if (!max)
-		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
-
-	pos = *ppos;
-	retval = -EINVAL;
-	if (unlikely(pos < 0))
-		goto fput_out;
-	if (unlikely(pos + count > max)) {
-		retval = -EOVERFLOW;
-		if (pos >= max)
-			goto fput_out;
-		count = max - pos;
-	}
-
-	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
 
-	if (*ppos > max)
-		retval = -EOVERFLOW;
+	retval = vfs_sendfile(out_file, in_file, ppos, count, max);
 
 fput_out:
 	fput_light(out_file, fput_needed_out);
--- linux-2.6.5cow/include/linux/fs.h~copyfile	2004-04-20 16:20:21.000000000 +0200
+++ linux-2.6.5cow/include/linux/fs.h	2004-04-24 17:02:31.000000000 +0200
@@ -877,6 +877,7 @@
 		unsigned long, loff_t *);
 extern ssize_t vfs_writev(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
+ssize_t vfs_sendfile(struct file *, struct file *, loff_t *, size_t, loff_t);
 
 /*
  * NOTE: write_inode, delete_inode, clear_inode, put_inode can be called
--- linux-2.6.5cow/include/linux/syscalls.h~copyfile	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/include/linux/syscalls.h	2004-04-25 16:03:36.000000000 +0200
@@ -278,6 +278,8 @@
 asmlinkage long sys_unlink(const char __user *pathname);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
+asmlinkage long sys_copyfile(const char __user *from, const char __user *to,
+				umode_t mode);
 asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
 asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
 
