Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbWADT6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbWADT6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWADT6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:504 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965289AbWADT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:38 -0500
Message-Id: <20060104194500.352612000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:22 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 02/13] spufs: dont hold root->isem in spu_forget
Content-Disposition: inline; filename=spufs-final-iput.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spu_forget will do mmput on the DMA address space,
which can lead to lots of other stuff getting triggered.
We better not hold a semaphore here that we might
need in the process.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-cg/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-cg.orig/arch/powerpc/platforms/cell/spufs/inode.c	2005-12-22 12:26:03.000000000 +0000
+++ linux-cg/arch/powerpc/platforms/cell/spufs/inode.c	2005-12-22 13:25:19.000000000 +0000
@@ -162,10 +162,10 @@
 {
 	struct dentry *dentry, *tmp;
 	struct spu_context *ctx;
-	int err;
 
 	/* remove all entries */
-	err = 0;
+	down(&root->i_sem);
+	down(&dir_dentry->d_inode->i_sem);
 	list_for_each_entry_safe(dentry, tmp, &dir_dentry->d_subdirs, d_child) {
 		spin_lock(&dcache_lock);
 		spin_lock(&dentry->d_lock);
@@ -181,16 +181,16 @@
 			spin_unlock(&dcache_lock);
 		}
 	}
+	shrink_dcache_parent(dir_dentry);
+	up(&dir_dentry->d_inode->i_sem);
+	up(&root->i_sem);
 
 	/* We have to give up the mm_struct */
 	ctx = SPUFS_I(dir_dentry->d_inode)->i_ctx;
 	spu_forget(ctx);
 
-	if (!err) {
-		shrink_dcache_parent(dir_dentry);
-		err = simple_rmdir(root, dir_dentry);
-	}
-	return err;
+	/* XXX Do we need to hold i_sem here ? */
+	return simple_rmdir(root, dir_dentry);
 }
 
 static int spufs_dir_close(struct inode *inode, struct file *file)
@@ -201,10 +201,10 @@
 
 	dentry = file->f_dentry;
 	dir = dentry->d_parent->d_inode;
-	down(&dir->i_sem);
-	ret = spufs_rmdir(dir, file->f_dentry);
+
+	ret = spufs_rmdir(dir, dentry);
 	WARN_ON(ret);
-	up(&dir->i_sem);
+
 	return dcache_dir_close(inode, file);
 }
 

--

