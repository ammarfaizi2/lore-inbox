Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTEVS4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTEVS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:56:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46756 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263131AbTEVS4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:56:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 22 May 2003 21:09:43 +0200 (MEST)
Message-Id: <UTC200305221909.h4MJ9h903738.aeb@smtp.cwi.nl>
To: linux-fs@cwi.nl, linux-kernel@vger.kernel.org
Subject: [patch?] truncate and timestamps
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Investigating why some SuSE init script no longer works, I find:
The shell command
    > file
does not update the time stamp of file in case it existed and had size 0.
The corresponding system call is
    open(file, O_WRONLY | O_TRUNC);

Time stamp here is st_mtime, and the behaviour is not unreasonable:
after all, the contents do not change.

And indeed, in do_truncate() we have
    newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
that is, ATTR_MTIME is not mentioned.

Older Linux systems did update st_mtime, old FreeBSD systems did not,
SunOS 5.7 does, SunOS 5.8 does not. There is no uniform Unix behaviour.

Remains the question what POSIX says.
For opening with O_TRUNC, and for the ftruncate system call
POSIX has always said and still says: st_ctime and st_mtime
are updated.
For the truncate call POSIX.1-2001 says: st_ctime and st_mtime
are updated if the size changed.

If we want to follow this, then do_truncate() needs an additional
parameter indicating what kind of call we have.
A little bit ugly. A possible patch follows.

Andries

------------------
diff -u --recursive --new-file -X /linux/dontdiff a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu May 22 13:17:02 2003
+++ b/fs/exec.c	Thu May 22 20:14:02 2003
@@ -1352,7 +1352,7 @@
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0) != 0)
+	if (do_truncate(file->f_dentry, 0, 1) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Thu May 22 13:17:02 2003
+++ b/fs/namei.c	Thu May 22 20:13:41 2003
@@ -1178,7 +1178,7 @@
 		if (!error) {
 			DQUOT_INIT(inode);
 			
-			error = do_truncate(dentry, 0);
+			error = do_truncate(dentry, 0, 1);
 		}
 		put_write_access(inode);
 		if (error)
diff -u --recursive --new-file -X /linux/dontdiff a/fs/open.c b/fs/open.c
--- a/fs/open.c	Thu May 22 13:17:02 2003
+++ b/fs/open.c	Thu May 22 20:15:25 2003
@@ -75,7 +75,7 @@
 	return error;
 }
 
-int do_truncate(struct dentry *dentry, loff_t length)
+int do_truncate(struct dentry *dentry, loff_t length, int update_timestamp)
 {
 	int err;
 	struct iattr newattrs;
@@ -85,7 +85,9 @@
 		return -EINVAL;
 
 	newattrs.ia_size = length;
-	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+	newattrs.ia_valid = ATTR_SIZE;
+	if (update_timestamp || length != dentry->d_inode->i_size)
+		newattrs.ia_valid |= ATTR_CTIME | ATTR_MTIME;
 	down(&dentry->d_inode->i_sem);
 	err = notify_change(dentry, &newattrs);
 	up(&dentry->d_inode->i_sem);
@@ -142,7 +144,7 @@
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_truncate(nd.dentry, length, 0);
 	}
 	put_write_access(inode);
 
@@ -194,7 +196,7 @@
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_truncate(dentry, length, 1);
 out_putf:
 	fput(file);
 out:
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu May 22 13:17:05 2003
+++ b/include/linux/fs.h	Thu May 22 20:14:39 2003
@@ -1019,7 +1019,7 @@
 
 asmlinkage long sys_open(const char __user *, int, int);
 asmlinkage long sys_close(unsigned int);	/* yes, it's really unsigned */
-extern int do_truncate(struct dentry *, loff_t start);
+extern int do_truncate(struct dentry *, loff_t start, int update_timestamp);
 
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
