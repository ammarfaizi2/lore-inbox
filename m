Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUIDRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUIDRBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUIDRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:01:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:43460 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264389AbUIDQ7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:59:45 -0400
Date: Sat, 4 Sep 2004 18:59:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] copyfile: sendfile
Message-ID: <20040904165938.GD8579@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904165733.GC8579@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See below.

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown

Creates vfs_sendfile(), which can be called from other places within
the kernel.  Such other places include copyfile() and cowlinks.

In principle, this just removes code from do_sendfile() to
vfs_sendfile().  On top of that, it adds a check to out_inode,
identical to the one on in_inode.  True, the check for out_inode was
never needed, maybe that tells you something about the check to
in_inode as well. ;)

 fs/read_write.c          |  107 ++++++++++++++++++++++++++---------------------
 include/linux/fs.h       |    1 
 include/linux/syscalls.h |    2 
 3 files changed, 64 insertions(+), 46 deletions(-)


--- linux-2.6.9-rc1-mm3/fs/read_write.c~sendfile	2004-09-04 18:17:31.000000000 +0200
+++ linux-2.6.9-rc1-mm3/fs/read_write.c	2004-09-04 18:19:07.000000000 +0200
@@ -561,12 +561,70 @@
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
+	else
+		if (!(in_file->f_mode & FMODE_PREAD))
+			return -ESPIPE;
+
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
 
@@ -579,21 +637,6 @@
 		goto out;
 	if (!(in_file->f_mode & FMODE_READ))
 		goto fput_in;
-	retval = -EINVAL;
-	in_inode = in_file->f_dentry->d_inode;
-	if (!in_inode)
-		goto fput_in;
-	if (!in_file->f_op || !in_file->f_op->sendfile)
-		goto fput_in;
-	retval = -ESPIPE;
-	if (!ppos)
-		ppos = &in_file->f_pos;
-	else
-		if (!(in_file->f_mode & FMODE_PREAD))
-			goto fput_in;
-	retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file, *ppos, count);
-	if (retval)
-		goto fput_in;
 
 	retval = security_file_permission (in_file, MAY_READ);
 	if (retval)
@@ -608,36 +651,8 @@
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
--- linux-2.6.9-rc1-mm3/include/linux/fs.h~sendfile	2004-09-03 21:02:58.000000000 +0200
+++ linux-2.6.9-rc1-mm3/include/linux/fs.h	2004-09-04 18:17:14.000000000 +0200
@@ -1018,6 +1018,7 @@
 		unsigned long, loff_t *);
 extern ssize_t vfs_writev(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
+ssize_t vfs_sendfile(struct file *, struct file *, loff_t *, size_t, loff_t);
 
 /*
  * NOTE: write_inode, delete_inode, clear_inode, put_inode can be called
--- linux-2.6.9-rc1-mm3/include/linux/syscalls.h~sendfile	2004-09-03 20:49:16.000000000 +0200
+++ linux-2.6.9-rc1-mm3/include/linux/syscalls.h	2004-09-04 18:17:15.000000000 +0200
@@ -285,6 +285,8 @@
 asmlinkage long sys_unlink(const char __user *pathname);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
+asmlinkage long sys_copyfile(const char __user *from, const char __user *to,
+				umode_t mode);
 asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
 asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
 
