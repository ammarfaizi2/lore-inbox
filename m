Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVGNSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVGNSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVGNSdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:45 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:23231 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263080AbVGNSbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:33 -0400
Message-Id: <200507141830.j6EIUiRZ023607@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:47 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 2/7] v9fs: VFS file, dentry, and directory operations (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [2/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2

This part of the patch contains the VFS file, dentry, & directory interface
changes related to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 fs/9p/vfs_file.c   |   35 +++++++----------------------------
 fs/9p/vfs_dentry.c |   21 +++------------------
 fs/9p/vfs_dir.c    |   21 +++------------------
 3 files changed, 13 insertions(+), 64 deletions(-)

 ----------

--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -32,9 +32,9 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -82,12 +82,7 @@ static int v9fs_dir_readdir(struct file 
 
 	dprintk(DEBUG_VFS, "name %s\n", filp->f_dentry->d_name.name);
 
-	if (!file)
-		return -EBADF;
-
 	fid = file->fid;
-	if (fid < 0)
-		return -EBADF;
 
 	mi = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	if (!mi)
@@ -194,13 +189,6 @@ int v9fs_dir_release(struct inode *inode
 	struct v9fs_fid *fid = filp->private_data;
 	int fidnum = -1;
 
-	if (!fid) {
-		dprintk(DEBUG_ERROR,
-			"can't happen: no private data (ino %lu) (filp %p)\n",
-			inode->i_ino, filp);
-		return -EBADF;
-	}
-
 	dprintk(DEBUG_VFS, "inode: %p filp: %p fid: %d\n", inode, filp,
 		fid->fid);
 	fidnum = fid->fid;
@@ -220,11 +208,8 @@ int v9fs_dir_release(struct inode *inode
 			v9fs_put_idpool(fid->fid, &v9ses->fidpool);
 		}
 
-		if (fid->rdir_fcall) {
-			kfree(fid->rdir_fcall);
-			fid->rdir_fcall = NULL;
-		}
-
+		kfree(fid->rdir_fcall);
+		
 		filp->private_data = NULL;
 		v9fs_fid_destroy(fid);
 	}
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -35,9 +35,9 @@
 #include <linux/version.h>
 #include <linux/list.h>
 #include <asm/uaccess.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -165,13 +165,11 @@ int v9fs_file_open(struct inode *inode, 
 		kfree(fcall);
 	}
 
-	if (file) {
-		file->private_data = v9fid;
 
-		v9fid->rdir_pos = 0;
-		v9fid->rdir_fcall = NULL;
-	}
+	file->private_data = v9fid;
 
+	v9fid->rdir_pos = 0;
+	v9fid->rdir_fcall = NULL;
 	v9fid->fidopen = 1;
 	v9fid->filp = file;
 	v9fid->iounit = iounit;
@@ -194,8 +192,6 @@ static int v9fs_file_lock(struct file *f
 	struct inode *inode = filp->f_dentry->d_inode;
 
 	dprintk(DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
-	if (!inode)
-		return -EINVAL;
 
 	/* No mandatory locks */
 	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
@@ -383,9 +379,10 @@ v9fs_file_write(struct file *filp, const
 		return -ENOMEM;
 
 	ret = copy_from_user(buffer, data, count);
-	if (ret)
+	if (ret) {
 		dprintk(DEBUG_ERROR, "Problem copying from user\n");
-	else
+		return -EFAULT;
+	} else
 		ret = v9fs_write(filp, buffer, count, offset);
 
 	kfree(buffer);
@@ -393,28 +390,10 @@ v9fs_file_write(struct file *filp, const
 	return ret;
 }
 
-/**
- * v9fs_file_mmap - initiate an mmap on a file
- *
- * @filep - file pointer to write
- * @vmarea - vm area struct
- *
- * v9fs doesn't support this right now in mainline branch
- *
- */
-
-static int v9fs_file_mmap(struct file *filp, struct vm_area_struct *vm)
-{
-	dprintk(DEBUG_VFS, " filp: %p - NOT IMPLEMENTED\n", filp);
-
-	return -ENOSYS;
-}
-
 struct file_operations v9fs_file_operations = {
 	.llseek = generic_file_llseek,
 	.read = v9fs_file_read,
 	.write = v9fs_file_write,
-	.mmap = v9fs_file_mmap,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -34,9 +34,9 @@
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
 #include <linux/namei.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -88,18 +88,6 @@ static int v9fs_dentry_validate(struct d
 }
 
 /**
- * v9fs_dentry_delete - called when dentry refcount reaches 0
- * @dentry:  dentry that is being deleted
- *
- */
-
-static int v9fs_dentry_delete(struct dentry *dentry)
-{
-	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
-	return 1;
-}
-
-/**
  * v9fs_dentry_release - called when dentry is going to be freed
  * @dentry:  dentry that is being release
  *
@@ -111,13 +99,11 @@ void v9fs_dentry_release(struct dentry *
 
 	if (dentry->d_fsdata != NULL) {
 		struct list_head *fid_list = dentry->d_fsdata;
-		struct list_head *temp;
+		struct v9fs_fid *temp = NULL;
 		struct v9fs_fid *current_fid = NULL;
-		struct list_head *p;
 		struct v9fs_fcall *fcall = NULL;
 
-		list_for_each_safe(p, temp, fid_list) {
-			current_fid = list_entry(p, struct v9fs_fid, list);
+		list_for_each_entry_safe(current_fid, temp, fid_list, list) {			
 			if (v9fs_t_clunk
 			    (current_fid->v9ses, current_fid->fid, &fcall))
 				dprintk(DEBUG_ERROR, "clunk failed: %s\n",
@@ -136,6 +122,5 @@ void v9fs_dentry_release(struct dentry *
 
 struct dentry_operations v9fs_dentry_operations = {
 	.d_revalidate = v9fs_dentry_validate,
-	.d_delete = v9fs_dentry_delete,
 	.d_release = v9fs_dentry_release,
 };
