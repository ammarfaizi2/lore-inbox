Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUIGMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUIGMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUIGMPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:15:23 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:21161 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267968AbUIGML3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:11:29 -0400
Date: Tue, 7 Sep 2004 14:11:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/4] copyfile: sendfile
Message-ID: <20040907121118.GA27297@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907120908.GB26630@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.

Creates vfs_sendfile(), which can be called from other places within
the kernel.  Such other places include copyfile() and cowlinks.

In principle, this just moves code from do_sendfile() to
vfs_sendfile().  On top of that, it removes the "if (!in_inode)"
check.  The same never existed for out_inode and Christoph Hellweg
confirmed that it is superfluous.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/read_write.c    |  103 +++++++++++++++++++++++++++++------------------------
 include/linux/fs.h |    1 
 2 files changed, 58 insertions(+), 46 deletions(-)


--- linux-2.6.8cow/fs/read_write.c~sendfile	2004-09-05 12:02:46.000000000 +0200
+++ linux-2.6.8cow/fs/read_write.c	2004-09-05 12:06:39.000000000 +0200
@@ -561,12 +561,66 @@
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
 
@@ -579,21 +633,6 @@
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
@@ -608,36 +647,8 @@
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
-
-	if (*ppos > max)
-		retval = -EOVERFLOW;
+	retval = vfs_sendfile(out_file, in_file, ppos, count, max);
 
 fput_out:
 	fput_light(out_file, fput_needed_out);
--- linux-2.6.8cow/include/linux/fs.h~sendfile	2004-09-05 12:02:46.000000000 +0200
+++ linux-2.6.8cow/include/linux/fs.h	2004-09-05 12:06:51.000000000 +0200
@@ -928,6 +928,7 @@
 		unsigned long, loff_t *);
 extern ssize_t vfs_writev(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
+ssize_t vfs_sendfile(struct file *, struct file *, loff_t *, size_t, loff_t);
 
 /*
  * NOTE: write_inode, delete_inode, clear_inode, put_inode can be called
