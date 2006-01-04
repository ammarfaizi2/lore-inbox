Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWADT6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWADT6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWADT5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:57:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:22775 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965279AbWADT5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:32 -0500
Message-Id: <20060104194501.210484000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:27 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 07/13] spufs: fix spufs_fill_dir error path
Content-Disposition: inline; filename=spufs-fill-dir-leak.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If creating one entry failed in spufs_fill_dir,
we never cleaned up the freshly created entries.
Fix this by calling the cleanup function on error.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -134,47 +134,18 @@ spufs_delete_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
-static int
-spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
-		int mode, struct spu_context *ctx)
-{
-	struct dentry *dentry;
-	int ret;
-
-	while (files->name && files->name[0]) {
-		ret = -ENOMEM;
-		dentry = d_alloc_name(dir, files->name);
-		if (!dentry)
-			goto out;
-		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
-					files->mode & mode, ctx);
-		if (ret)
-			goto out;
-		files++;
-	}
-	return 0;
-out:
-	// FIXME: remove all files that are left
-
-	return ret;
-}
-
-static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+static void spufs_prune_dir(struct dentry *dir)
 {
 	struct dentry *dentry, *tmp;
-	struct spu_context *ctx;
-
-	/* remove all entries */
-	down(&root->i_sem);
-	down(&dir_dentry->d_inode->i_sem);
-	list_for_each_entry_safe(dentry, tmp, &dir_dentry->d_subdirs, d_child) {
+	down(&dir->d_inode->i_sem);
+	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_child) {
 		spin_lock(&dcache_lock);
 		spin_lock(&dentry->d_lock);
 		if (!(d_unhashed(dentry)) && dentry->d_inode) {
 			dget_locked(dentry);
 			__d_drop(dentry);
 			spin_unlock(&dentry->d_lock);
-			simple_unlink(dir_dentry->d_inode, dentry);
+			simple_unlink(dir->d_inode, dentry);
 			spin_unlock(&dcache_lock);
 			dput(dentry);
 		} else {
@@ -182,8 +153,17 @@ static int spufs_rmdir(struct inode *roo
 			spin_unlock(&dcache_lock);
 		}
 	}
-	shrink_dcache_parent(dir_dentry);
-	up(&dir_dentry->d_inode->i_sem);
+	shrink_dcache_parent(dir);
+	up(&dir->d_inode->i_sem);
+}
+
+static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+{
+	struct spu_context *ctx;
+
+	/* remove all entries */
+	down(&root->i_sem);
+	spufs_prune_dir(dir_dentry);
 	up(&root->i_sem);
 
 	/* We have to give up the mm_struct */
@@ -194,6 +174,29 @@ static int spufs_rmdir(struct inode *roo
 	return simple_rmdir(root, dir_dentry);
 }
 
+static int spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
+			  int mode, struct spu_context *ctx)
+{
+	struct dentry *dentry;
+	int ret;
+
+	while (files->name && files->name[0]) {
+		ret = -ENOMEM;
+		dentry = d_alloc_name(dir, files->name);
+		if (!dentry)
+			goto out;
+		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
+					files->mode & mode, ctx);
+		if (ret)
+			goto out;
+		files++;
+	}
+	return 0;
+out:
+	spufs_prune_dir(dir);
+	return ret;
+}
+
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
 	struct inode *dir;

--

