Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWFPXNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWFPXNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFPXMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31908 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751560AbWFPXM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:27 -0400
Subject: [RFC][PATCH 12/20] tricky: elevate write count files are open()ed
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:22 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231222.2B9C4BA4@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first really tricky patch in the series.  It
elevates the writer count on a mount each time a
non-special file is opened for write.

This is not completely apparent in the patch because the
two if() conditions in may_open() above the
mnt_want_write() call are, combined, equivalent to
special_file().

There is also an elevated count around the vfs_create()
call in open_namei().  The count needs to be kept elevated
all the way into the may_open() call.  Otherwise, when the
write is dropped, a ro->rw transisition could occur.  This
would lead to having rw access on the newly created file,
while the vfsmount is ro.  That is bad.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/file_table.c |    5 ++++-
 lxc-dave/fs/namei.c      |   22 ++++++++++++++++++----
 lxc-dave/ipc/mqueue.c    |    3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff -puN fs/file_table.c~C-elevate-writers-opens-part1 fs/file_table.c
--- lxc/fs/file_table.c~C-elevate-writers-opens-part1	2006-06-16 15:58:06.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-06-16 15:58:06.000000000 -0700
@@ -180,8 +180,11 @@ void fastcall __fput(struct file *file)
 	if (unlikely(inode->i_cdev != NULL))
 		cdev_put(inode->i_cdev);
 	fops_put(file->f_op);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
 		put_write_access(inode);
+		if(!special_file(inode->i_mode))
+			mnt_drop_write(mnt);
+	}
 	file_kill(file);
 	file->f_dentry = NULL;
 	file->f_vfsmnt = NULL;
diff -puN fs/namei.c~C-elevate-writers-opens-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-opens-part1	2006-06-16 15:58:06.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:06.000000000 -0700
@@ -1512,8 +1512,17 @@ int may_open(struct nameidata *nd, int a
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
-		return -EROFS;
+	} else if (flag & FMODE_WRITE) {
+		/*
+		 * effectively: !special_file()
+		 * balanced by __fput()
+		 */
+		error = mnt_want_write(nd->mnt);
+		if (error)
+			return error;
+		if (IS_RDONLY(inode))
+			return -EROFS;
+	}
 	/*
 	 * An append-only file must be opened in append mode for writing.
 	 */
@@ -1652,14 +1661,17 @@ do_last:
 	}
 
 	if (IS_ERR(nd->intent.open.file)) {
-		mutex_unlock(&dir->d_inode->i_mutex);
 		error = PTR_ERR(nd->intent.open.file);
-		goto exit_dput;
+		goto exit_mutex_unlock;
 	}
 
 	/* Negative dentry, just create the file */
 	if (!path.dentry->d_inode) {
+		error = mnt_want_write(nd->mnt);
+		if (error)
+			goto exit_mutex_unlock;
 		error = open_namei_create(nd, &path, flag, mode);
+		mnt_drop_write(nd->mnt);
 		if (error)
 			goto exit;
 		return 0;
@@ -1695,6 +1707,8 @@ ok:
 		goto exit;
 	return 0;
 
+exit_mutex_unlock:
+	mutex_unlock(&dir->d_inode->i_mutex);
 exit_dput:
 	dput_path(&path, nd);
 exit:
diff -puN ipc/mqueue.c~C-elevate-writers-opens-part1 ipc/mqueue.c
--- lxc/ipc/mqueue.c~C-elevate-writers-opens-part1	2006-06-16 15:58:06.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-06-16 15:58:06.000000000 -0700
@@ -679,6 +679,9 @@ asmlinkage long sys_mq_open(const char _
 				goto out;
 			filp = do_open(dentry, oflag);
 		} else {
+			error = mnt_want_write(mqueue_mnt);
+			if (error)
+				goto out;
 			filp = do_create(mqueue_mnt->mnt_root, dentry,
 						oflag, mode, u_attr);
 		}
diff -L fs/namei.c. -puN /dev/null /dev/null
_
