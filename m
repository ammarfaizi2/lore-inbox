Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVDQVr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVDQVr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDQVr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 17:47:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:2954 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261496AbVDQVrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 17:47:39 -0400
Date: Sun, 17 Apr 2005 23:50:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rename rw_verify_area() to rw_access_ok()
Message-ID: <Pine.LNX.4.62.0504172346120.2586@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

verify_area() will soon be dead and gone, replaced by access_ok(), thus 
the function named rw_verify_area() is badly named and should be renamed. 
This patch renames rw_verify_area to rw_access_ok which seems more 
appropriate (it also updates all callers of the functions as well as 
references to it in comments).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/mips/kernel/linux32.c |    4 ++--
 fs/compat.c                |    2 +-
 fs/locks.c                 |    2 +-
 fs/read_write.c            |   12 ++++++------
 include/linux/fs.h         |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/fs/read_write.c	2005-04-11 21:20:51.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/read_write.c	2005-04-17 23:39:14.000000000 +0200
@@ -183,7 +183,7 @@ bad:
 #endif
 
 
-int rw_verify_area(int read_write, struct file *file, loff_t *ppos, size_t count)
+int rw_access_ok(int read_write, struct file *file, loff_t *ppos, size_t count)
 {
 	struct inode *inode;
 	loff_t pos;
@@ -230,7 +230,7 @@ ssize_t vfs_read(struct file *file, char
 	if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
 		return -EFAULT;
 
-	ret = rw_verify_area(READ, file, pos, count);
+	ret = rw_access_ok(READ, file, pos, count);
 	if (!ret) {
 		ret = security_file_permission (file, MAY_READ);
 		if (!ret) {
@@ -278,7 +278,7 @@ ssize_t vfs_write(struct file *file, con
 	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
 
-	ret = rw_verify_area(WRITE, file, pos, count);
+	ret = rw_access_ok(WRITE, file, pos, count);
 	if (!ret) {
 		ret = security_file_permission (file, MAY_WRITE);
 		if (!ret) {
@@ -480,7 +480,7 @@ static ssize_t do_readv_writev(int type,
 		goto out;
 	}
 
-	ret = rw_verify_area(type, file, pos, tot_len);
+	ret = rw_access_ok(type, file, pos, tot_len);
 	if (ret)
 		goto out;
 
@@ -633,7 +633,7 @@ static ssize_t do_sendfile(int out_fd, i
 	else
 		if (!(in_file->f_mode & FMODE_PREAD))
 			goto fput_in;
-	retval = rw_verify_area(READ, in_file, ppos, count);
+	retval = rw_access_ok(READ, in_file, ppos, count);
 	if (retval)
 		goto fput_in;
 
@@ -654,7 +654,7 @@ static ssize_t do_sendfile(int out_fd, i
 	if (!out_file->f_op || !out_file->f_op->sendpage)
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
-	retval = rw_verify_area(WRITE, out_file, &out_file->f_pos, count);
+	retval = rw_access_ok(WRITE, out_file, &out_file->f_pos, count);
 	if (retval)
 		goto fput_out;
 
--- linux-2.6.12-rc2-mm3-orig/fs/compat.c	2005-04-11 21:20:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/compat.c	2005-04-17 23:41:32.000000000 +0200
@@ -1190,7 +1190,7 @@ static ssize_t compat_do_readv_writev(in
 		goto out;
 	}
 
-	ret = rw_verify_area(type, file, pos, tot_len);
+	ret = rw_access_ok(type, file, pos, tot_len);
 	if (ret)
 		goto out;
 
--- linux-2.6.12-rc2-mm3-orig/fs/locks.c	2005-04-05 21:21:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/locks.c	2005-04-17 23:41:47.000000000 +0200
@@ -1018,7 +1018,7 @@ int locks_mandatory_locked(struct inode 
  * @count:      length of area to check
  *
  * Searches the inode's list of locks to find any POSIX locks which conflict.
- * This function is called from rw_verify_area() and
+ * This function is called from rw_access_ok() and
  * locks_verify_truncate().
  */
 int locks_mandatory_area(int read_write, struct inode *inode,
--- linux-2.6.12-rc2-mm3-orig/arch/mips/kernel/linux32.c	2005-04-05 21:21:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/mips/kernel/linux32.c	2005-04-17 23:42:03.000000000 +0200
@@ -468,7 +468,7 @@ asmlinkage ssize_t sys32_pread(unsigned 
 	if (!(file->f_mode & FMODE_READ))
 		goto out;
 	pos = merge_64(a4, a5);
-	ret = rw_verify_area(READ, file, &pos, count);
+	ret = rw_access_ok(READ, file, &pos, count);
 	if (ret)
 		goto out;
 	ret = -EINVAL;
@@ -503,7 +503,7 @@ asmlinkage ssize_t sys32_pwrite(unsigned
 	if (!(file->f_mode & FMODE_WRITE))
 		goto out;
 	pos = merge_64(a4, a5);
-	ret = rw_verify_area(WRITE, file, &pos, count);
+	ret = rw_access_ok(WRITE, file, &pos, count);
 	if (ret)
 		goto out;
 	ret = -EINVAL;
--- linux-2.6.12-rc2-mm3-orig/include/linux/fs.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/linux/fs.h	2005-04-17 23:42:13.000000000 +0200
@@ -1260,7 +1260,7 @@ static inline int locks_verify_locked(st
 	return 0;
 }
 
-extern int rw_verify_area(int, struct file *, loff_t *, size_t);
+extern int rw_access_ok(int, struct file *, loff_t *, size_t);
 
 static inline int locks_verify_truncate(struct inode *inode,
 				    struct file *filp,



