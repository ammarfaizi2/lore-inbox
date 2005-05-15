Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVEOPxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVEOPxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 11:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEOPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 11:53:38 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:52190 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261672AbVEOPxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 11:53:33 -0400
Message-ID: <42877245.DD23EBB4@tv-sign.ru>
Date: Sun, 15 May 2005 20:01:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] factor out common code in sys_fsync/sys_fdatasync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch consolidates sys_fsync and sys_fdatasync. The only
difference between them is a 'datasync' parameter of ->fsync().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc4/fs/buffer.c~	2005-05-09 16:37:16.000000000 +0400
+++ 2.6.12-rc4/fs/buffer.c	2005-05-15 22:38:42.000000000 +0400
@@ -331,7 +331,7 @@ int file_fsync(struct file *filp, struct
 	return ret;
 }
 
-asmlinkage long sys_fsync(unsigned int fd)
+static long do_fsync(unsigned int fd, int datasync)
 {
 	struct file * file;
 	struct address_space *mapping;
@@ -342,14 +342,14 @@ asmlinkage long sys_fsync(unsigned int f
 	if (!file)
 		goto out;
 
-	mapping = file->f_mapping;
-
 	ret = -EINVAL;
 	if (!file->f_op || !file->f_op->fsync) {
 		/* Why?  We can still call filemap_fdatawrite */
 		goto out_putf;
 	}
 
+	mapping = file->f_mapping;
+
 	current->flags |= PF_SYNCWRITE;
 	ret = filemap_fdatawrite(mapping);
 
@@ -358,7 +358,7 @@ asmlinkage long sys_fsync(unsigned int f
 	 * which could cause livelocks in fsync_buffers_list
 	 */
 	down(&mapping->host->i_sem);
-	err = file->f_op->fsync(file, file->f_dentry, 0);
+	err = file->f_op->fsync(file, file->f_dentry, datasync);
 	if (!ret)
 		ret = err;
 	up(&mapping->host->i_sem);
@@ -373,39 +373,14 @@ out:
 	return ret;
 }
 
-asmlinkage long sys_fdatasync(unsigned int fd)
+asmlinkage long sys_fsync(unsigned int fd)
 {
-	struct file * file;
-	struct address_space *mapping;
-	int ret, err;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto out;
-
-	ret = -EINVAL;
-	if (!file->f_op || !file->f_op->fsync)
-		goto out_putf;
-
-	mapping = file->f_mapping;
-
-	current->flags |= PF_SYNCWRITE;
-	ret = filemap_fdatawrite(mapping);
-	down(&mapping->host->i_sem);
-	err = file->f_op->fsync(file, file->f_dentry, 1);
-	if (!ret)
-		ret = err;
-	up(&mapping->host->i_sem);
-	err = filemap_fdatawait(mapping);
-	if (!ret)
-		ret = err;
-	current->flags &= ~PF_SYNCWRITE;
+	return do_fsync(fd, 0);
+}
 
-out_putf:
-	fput(file);
-out:
-	return ret;
+asmlinkage long sys_fdatasync(unsigned int fd)
+{
+	return do_fsync(fd, 1);
 }
 
 /*
