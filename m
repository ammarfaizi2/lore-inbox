Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUIGMTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUIGMTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUIGMTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:19:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:46505 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267968AbUIGMPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:15:44 -0400
Date: Tue, 7 Sep 2004 14:15:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Steve French <smfltc@us.ibm.com>
Subject: [PATCH 4/4] copyfile: copyfile
Message-ID: <20040907121520.GC27297@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de> <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907121235.GB27297@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, the syscall itself may be a stupid idea, but Steve indicated
interest for cifs.  I'll hide behind his back and let him fight for
it. ;)

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu

Adds a new syscall, copyfile() which does as the name sais.

This syscall is a preparation for real cowlinks, but it might make sense on
it's own as well.  For cowlinks, the real copy is not done until the first
write (or similar operation) occurs, but at that point, both operations
should be the same.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 arch/i386/kernel/entry.S |    1 
 fs/namei.c               |  142 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h |    2 
 3 files changed, 145 insertions(+)


--- linux-2.6.8cow/arch/i386/kernel/entry.S~copyfile	2004-09-05 11:57:15.000000000 +0200
+++ linux-2.6.8cow/arch/i386/kernel/entry.S	2004-09-05 11:58:00.000000000 +0200
@@ -886,5 +886,6 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_copyfile
 
 syscall_table_size=(.-sys_call_table)
--- linux-2.6.8cow/fs/namei.c~copyfile	2004-09-05 11:57:15.000000000 +0200
+++ linux-2.6.8cow/fs/namei.c	2004-09-05 11:58:15.000000000 +0200
@@ -2220,6 +2220,148 @@
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
+	dget(old_dentry);
+	mntget(old_mnt);
+	old_file = dentry_open(old_dentry, old_mnt, O_RDONLY);
+	if (IS_ERR(old_file))
+		return PTR_ERR(old_file);
+
+	dget(new_dentry);
+	mntget(new_mnt);
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
+	fput(new_file);
+out1:
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
--- linux-2.6.8cow/include/linux/syscalls.h~copyfile	2004-09-05 11:57:15.000000000 +0200
+++ linux-2.6.8cow/include/linux/syscalls.h	2004-09-05 11:58:00.000000000 +0200
@@ -283,6 +283,8 @@
 asmlinkage long sys_unlink(const char __user *pathname);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
+asmlinkage long sys_copyfile(const char __user *from, const char __user *to,
+				umode_t mode);
 asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
 asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
 
