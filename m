Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUEFNVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUEFNVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUEFNVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:21:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:39859 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262138AbUEFNTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:19:38 -0400
Date: Thu, 6 May 2004 15:19:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH COW] copyfile
Message-ID: <20040506131940.GD7930@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 

Adds a new syscall, copyfile() which does as the name sais.

This syscall is a preparation for real cowlinks, but it might make sense on
it's own as well.  For cowlinks, the real copy is not done until the first
write (or similar operation) occurs, but at that point, both operations
should be the same.

 arch/i386/kernel/entry.S |    1 
 fs/namei.c               |  140 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)


--- linux-2.6.5cow/arch/i386/kernel/entry.S~copyfile	2004-04-27 16:34:32.000000000 +0200
+++ linux-2.6.5cow/arch/i386/kernel/entry.S	2004-04-30 08:40:04.000000000 +0200
@@ -882,5 +882,6 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_copyfile
 
 syscall_table_size=(.-sys_call_table)
--- linux-2.6.5cow/fs/namei.c~copyfile	2004-04-27 16:48:55.000000000 +0200
+++ linux-2.6.5cow/fs/namei.c	2004-05-06 01:08:53.000000000 +0200
@@ -2139,6 +2139,146 @@
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
+	old_file = dentry_open(old_dentry, old_mnt, O_RDONLY);
+	if (IS_ERR(old_file))
+		return PTR_ERR(old_file);
+
+	new_file = dentry_open(new_dentry, new_mnt, O_WRONLY);
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
+	dget(new_file->f_dentry); /* fput calls dput */
+	fput(new_file);
+out1:
+	dget(old_file->f_dentry); /* fput calls dput */
+	fput(old_file);
+	return ret;
+}
+
+int vfs_copyfile(struct nameidata *old_nd, struct nameidata *new_nd,
+		 struct dentry *new_dentry, int mode)
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
+	if (mode == -1)
+		mode = old_nd->dentry->d_inode->i_mode;
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
+int do_copyfile(const char *from, const char *to, int mode)
+{
+	int ret;
+	struct dentry *new_dentry;
+	struct nameidata old_nd, new_nd;
+
+	ret = path_lookup(from, 0, &old_nd);
+	if (ret)
+		return ret;
+
+	ret = path_lookup(to, LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, &new_nd);
+	if (ret)
+		goto out1;
+
+	new_dentry = lookup_create(&new_nd, 0);
+	ret = PTR_ERR(new_dentry);
+	if (IS_ERR(new_dentry))
+		goto out2;
+
+	ret = vfs_copyfile(&old_nd, &new_nd, new_dentry, mode);
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
+int sys_copyfile(const char __user *ufrom, const char __user *uto, umode_t mode)
+{
+	char *from, *to;
+	int ret;
+
+	from = getname(ufrom);
+	if (IS_ERR(from))
+		return PTR_ERR(from);
+
+	to = getname(uto);
+	ret = PTR_ERR(to);
+	if (IS_ERR(to))
+		goto err;
+
+	ret = do_copyfile(from, to, mode);
+
+	putname(to);
+err:
+	putname(from);
+	return ret;
+}
+
 int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
 {
 	int len;
