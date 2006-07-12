Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWGLSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWGLSSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWGLSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35013 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932374AbWGLSR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:28 -0400
Subject: [RFC][PATCH 18/27] tricky: elevate write count files are open()ed
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:22 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181722.1C9CB538@localhost.localdomain>
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
--- lxc/fs/file_table.c~C-elevate-writers-opens-part1	2006-07-12 11:09:24.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-07-12 11:09:34.000000000 -0700
@@ -179,8 +179,11 @@ void fastcall __fput(struct file *file)
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL))
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
--- lxc/fs/namei.c~C-elevate-writers-opens-part1	2006-07-12 11:09:34.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:34.000000000 -0700
@@ -1532,8 +1532,17 @@ int may_open(struct nameidata *nd, int a
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
@@ -1672,14 +1681,17 @@ do_last:
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
@@ -1715,6 +1727,8 @@ ok:
 		goto exit;
 	return 0;
 
+exit_mutex_unlock:
+	mutex_unlock(&dir->d_inode->i_mutex);
 exit_dput:
 	dput_path(&path, nd);
 exit:
diff -puN ipc/mqueue.c~C-elevate-writers-opens-part1 ipc/mqueue.c
--- lxc/ipc/mqueue.c~C-elevate-writers-opens-part1	2006-07-12 11:09:19.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-07-12 11:09:34.000000000 -0700
@@ -685,6 +685,9 @@ asmlinkage long sys_mq_open(const char _
 				goto out;
 			filp = do_open(dentry, oflag);
 		} else {
+			error = mnt_want_write(mqueue_mnt);
+			if (error)
+				goto out;
 			filp = do_create(mqueue_mnt->mnt_root, dentry,
 						oflag, mode, u_attr);
 		}
_
