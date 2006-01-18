Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWARHX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWARHX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWARHX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:23:26 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:13509 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S964953AbWARHXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:23:18 -0500
Date: Wed, 18 Jan 2006 15:22:41 +0800
Message-Id: <200601180722.k0I7MfDC006128@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 2/13] autofs4 - use libfs routines for readdir
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes readdir routines to use the cursor based routines
in libfs.c. This removes reliance on old readdir code from 2.4 and
should improve efficiency of readdir in autofs4.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.16-rc1/fs/autofs4/root.c.readdir-cleanup	2006-01-18 09:24:03.000000000 +0800
+++ linux-2.6.16-rc1/fs/autofs4/root.c	2006-01-18 09:25:15.000000000 +0800
@@ -30,7 +30,6 @@ static int autofs4_dir_close(struct inod
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
-static int autofs4_dcache_readdir(struct file *, void *, filldir_t);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -82,7 +81,7 @@ static int autofs4_root_readdir(struct f
 
 	DPRINTK("needs_reghost = %d", sbi->needs_reghost);
 
-	return autofs4_dcache_readdir(file, dirent, filldir);
+	return dcache_readdir(file, dirent, filldir);
 }
 
 /* Update usage from here to top of tree, so that scan of
@@ -103,75 +102,21 @@ static void autofs4_update_usage(struct 
 	spin_unlock(&dcache_lock);
 }
 
-/*
- * From 2.4 kernel readdir.c
- */
-static int autofs4_dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
-{
-	int i;
-	struct dentry *dentry = filp->f_dentry;
-
-	i = filp->f_pos;
-	switch (i) {
-		case 0:
-			if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
-				break;
-			i++;
-			filp->f_pos++;
-			/* fallthrough */
-		case 1:
-			if (filldir(dirent, "..", 2, i, dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
-				break;
-			i++;
-			filp->f_pos++;
-			/* fallthrough */
-		default: {
-			struct list_head *list;
-			int j = i-2;
-
-			spin_lock(&dcache_lock);
-			list = dentry->d_subdirs.next;
-
-			for (;;) {
-				if (list == &dentry->d_subdirs) {
-					spin_unlock(&dcache_lock);
-					return 0;
-				}
-				if (!j)
-					break;
-				j--;
-				list = list->next;
-			}
-
-			while(1) {
-				struct dentry *de = list_entry(list,
-						struct dentry, d_u.d_child);
-
-				if (!d_unhashed(de) && de->d_inode) {
-					spin_unlock(&dcache_lock);
-					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
-						break;
-					spin_lock(&dcache_lock);
-				}
-				filp->f_pos++;
-				list = list->next;
-				if (list != &dentry->d_subdirs)
-					continue;
-				spin_unlock(&dcache_lock);
-				break;
-			}
-		}
-	}
-	return 0;
-}
-
 static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_dentry;
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor;
 	int status;
 
+	status = dcache_dir_open(inode, file);
+	if (status)
+		goto out;
+
+	cursor = file->private_data;
+	cursor->d_fsdata = NULL;
+
 	DPRINTK("file=%p dentry=%p %.*s",
 		file, dentry, dentry->d_name.len, dentry->d_name.name);
 
@@ -180,12 +125,15 @@ static int autofs4_dir_open(struct inode
 
 	if (autofs4_ispending(dentry)) {
 		DPRINTK("dentry busy");
-		return -EBUSY;
+		dcache_dir_close(inode, file);
+		status = -EBUSY;
+		goto out;
 	}
 
+	status = -ENOENT;
 	if (!d_mountpoint(dentry) && dentry->d_op && dentry->d_op->d_revalidate) {
 		struct nameidata nd;
-		int empty;
+		int empty, ret;
 
 		/* In case there are stale directory dentrys from a failed mount */
 		spin_lock(&dcache_lock);
@@ -195,13 +143,13 @@ static int autofs4_dir_open(struct inode
 		if (!empty)
 			d_invalidate(dentry);
 
-		nd.dentry = dentry;
-		nd.mnt = mnt;
 		nd.flags = LOOKUP_DIRECTORY;
-		status = (dentry->d_op->d_revalidate)(dentry, &nd);
+		ret = (dentry->d_op->d_revalidate)(dentry, &nd);
 
-		if (!status)
-			return -ENOENT;
+		if (!ret) {
+			dcache_dir_close(inode, file);
+			goto out;
+		}
 	}
 
 	if (d_mountpoint(dentry)) {
@@ -212,25 +160,29 @@ static int autofs4_dir_open(struct inode
 		if (!autofs4_follow_mount(&fp_mnt, &fp_dentry)) {
 			dput(fp_dentry);
 			mntput(fp_mnt);
-			return -ENOENT;
+			dcache_dir_close(inode, file);
+			goto out;
 		}
 
 		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
 		status = PTR_ERR(fp);
 		if (IS_ERR(fp)) {
-			file->private_data = NULL;
-			return status;
+			dcache_dir_close(inode, file);
+			goto out;
 		}
-		file->private_data = fp;
+		cursor->d_fsdata = fp;
 	}
-out:
 	return 0;
+out:
+	return status;
 }
 
 static int autofs4_dir_close(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor = file->private_data;
+	int status = 0;
 
 	DPRINTK("file=%p dentry=%p %.*s",
 		file, dentry, dentry->d_name.len, dentry->d_name.name);
@@ -240,26 +192,28 @@ static int autofs4_dir_close(struct inod
 
 	if (autofs4_ispending(dentry)) {
 		DPRINTK("dentry busy");
-		return -EBUSY;
+		status = -EBUSY;
+		goto out;
 	}
 
 	if (d_mountpoint(dentry)) {
-		struct file *fp = file->private_data;
-
-		if (!fp)
-			return -ENOENT;
-
+		struct file *fp = cursor->d_fsdata;
+		if (!fp) {
+			status = -ENOENT;
+			goto out;
+		}
 		filp_close(fp, current->files);
-		file->private_data = NULL;
 	}
 out:
-	return 0;
+	dcache_dir_close(inode, file);
+	return status;
 }
 
 static int autofs4_dir_readdir(struct file *file, void *dirent, filldir_t filldir)
 {
 	struct dentry *dentry = file->f_dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor = file->private_data;
 	int status;
 
 	DPRINTK("file=%p dentry=%p %.*s",
@@ -274,7 +228,7 @@ static int autofs4_dir_readdir(struct fi
 	}
 
 	if (d_mountpoint(dentry)) {
-		struct file *fp = file->private_data;
+		struct file *fp = cursor->d_fsdata;
 
 		if (!fp)
 			return -ENOENT;
@@ -289,7 +243,7 @@ static int autofs4_dir_readdir(struct fi
 		return status;
 	}
 out:
-	return autofs4_dcache_readdir(file, dirent, filldir);
+	return dcache_readdir(file, dirent, filldir);
 }
 
 static int try_to_fill_dentry(struct vfsmount *mnt, struct dentry *dentry, int flags)
