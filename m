Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWFSSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWFSSwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWFSSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:52:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50888 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932530AbWFSSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:21 -0400
Message-Id: <20060619183404.966781000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:22 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 07/20] spufs: fix deadlock in spu_create error path
Content-Disposition: inline; filename=spufs-rmdir-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <michael@ellerman.id.au>

spufs_rmdir tries to acquire the spufs root
i_mutex, which is already held by spufs_create_thread.

This was tracked as Bug #H9512.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
@@ -157,20 +157,12 @@ static void spufs_prune_dir(struct dentr
 	mutex_unlock(&dir->d_inode->i_mutex);
 }
 
+/* Caller must hold root->i_mutex */
 static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
 {
-	struct spu_context *ctx;
-
 	/* remove all entries */
-	mutex_lock(&root->i_mutex);
 	spufs_prune_dir(dir_dentry);
-	mutex_unlock(&root->i_mutex);
 
-	/* We have to give up the mm_struct */
-	ctx = SPUFS_I(dir_dentry->d_inode)->i_ctx;
-	spu_forget(ctx);
-
-	/* XXX Do we need to hold i_mutex here ? */
 	return simple_rmdir(root, dir_dentry);
 }
 
@@ -199,16 +191,23 @@ out:
 
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
+	struct spu_context *ctx;
 	struct inode *dir;
 	struct dentry *dentry;
 	int ret;
 
 	dentry = file->f_dentry;
 	dir = dentry->d_parent->d_inode;
+	ctx = SPUFS_I(dentry->d_inode)->i_ctx;
 
+	mutex_lock(&dir->i_mutex);
 	ret = spufs_rmdir(dir, dentry);
+	mutex_unlock(&dir->i_mutex);
 	WARN_ON(ret);
 
+	/* We have to give up the mm_struct */
+	spu_forget(ctx);
+
 	return dcache_dir_close(inode, file);
 }
 
@@ -324,8 +323,13 @@ long spufs_create_thread(struct nameidat
 	 * in error path of *_open().
 	 */
 	ret = spufs_context_open(dget(dentry), mntget(nd->mnt));
-	if (ret < 0)
-		spufs_rmdir(nd->dentry->d_inode, dentry);
+	if (ret < 0) {
+		WARN_ON(spufs_rmdir(nd->dentry->d_inode, dentry));
+		mutex_unlock(&nd->dentry->d_inode->i_mutex);
+		spu_forget(SPUFS_I(dentry->d_inode)->i_ctx);
+		dput(dentry);
+		goto out;
+	}
 
 out_dput:
 	dput(dentry);

--

