Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWADUAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWADUAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWADT6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63479 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965288AbWADT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:38 -0500
Message-Id: <20060104194501.041011000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:26 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 06/13] spufs: dont leak directories in failed spu_create
Content-Disposition: inline; filename=spufs-create-fix-leak.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If get_unused_fd failed in sys_spu_create, we never cleaned
up the created directory. Fix that by restructuring the
error path.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/poll.h>
@@ -251,6 +252,7 @@ spufs_mkdir(struct inode *dir, struct de
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	dir->i_nlink++;
+	dentry->d_inode->i_nlink++;
 	goto out;
 
 out_free_ctx:
@@ -261,18 +263,44 @@ out:
 	return ret;
 }
 
+static int spufs_context_open(struct dentry *dentry, struct vfsmount *mnt)
+{
+	int ret;
+	struct file *filp;
+
+	ret = get_unused_fd();
+	if (ret < 0) {
+		dput(dentry);
+		mntput(mnt);
+		goto out;
+	}
+
+	filp = dentry_open(dentry, mnt, O_RDONLY);
+	if (IS_ERR(filp)) {
+		put_unused_fd(ret);
+		ret = PTR_ERR(filp);
+		goto out;
+	}
+
+	filp->f_op = &spufs_context_fops;
+	fd_install(ret, filp);
+out:
+	return ret;
+}
+
+static struct file_system_type spufs_type;
+
 long
 spufs_create_thread(struct nameidata *nd, const char *name,
 			unsigned int flags, mode_t mode)
 {
 	struct dentry *dentry;
-	struct file *filp;
 	int ret;
 
 	/* need to be at the root of spufs */
 	ret = -EINVAL;
-	if (nd->dentry->d_sb->s_magic != SPUFS_MAGIC ||
-		nd->dentry != nd->dentry->d_sb->s_root)
+	if (nd->dentry->d_sb->s_type != &spufs_type ||
+	    nd->dentry != nd->dentry->d_sb->s_root)
 		goto out;
 
 	dentry = lookup_create(nd, 1);
@@ -289,21 +317,13 @@ spufs_create_thread(struct nameidata *nd
 	if (ret)
 		goto out_dput;
 
-	ret = get_unused_fd();
+	/*
+	 * get references for dget and mntget, will be released
+	 * in error path of *_open().
+	 */
+	ret = spufs_context_open(dget(dentry), mntget(nd->mnt));
 	if (ret < 0)
-		goto out_dput;
-
-	dentry->d_inode->i_nlink++;
-
-	filp = filp_open(name, O_RDONLY, mode);
-	if (IS_ERR(filp)) {
-		// FIXME: remove directory again
-		put_unused_fd(ret);
-		ret = PTR_ERR(filp);
-	} else {
-		filp->f_op = &spufs_context_fops;
-		fd_install(ret, filp);
-	}
+		spufs_rmdir(nd->dentry->d_inode, dentry);
 
 out_dput:
 	dput(dentry);

--

