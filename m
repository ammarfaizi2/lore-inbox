Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUFVUHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUFVUHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUFVTbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:31:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15515 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265482AbUFVTYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:00 -0400
To: torvalds@osdl.org
Subject: [PATCH] (6/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xd-QK@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        xfs switched to new scheme; leaks plugged.

diff -urN RC7-bk5-smb/fs/xfs/linux-2.6/xfs_iops.c RC7-bk5-xfs/fs/xfs/linux-2.6/xfs_iops.c
--- RC7-bk5-smb/fs/xfs/linux-2.6/xfs_iops.c	Wed Jun 16 10:26:24 2004
+++ RC7-bk5-xfs/fs/xfs/linux-2.6/xfs_iops.c	Tue Jun 22 15:13:11 2004
@@ -67,6 +67,7 @@
 #include "xfs_utils.h"
 
 #include <linux/xattr.h>
+#include <linux/namei.h>
 
 
 /*
@@ -419,13 +420,16 @@
 	ASSERT(nd);
 
 	link = (char *)kmalloc(MAXNAMELEN+1, GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
+	if (!link) {
+		nd_set_link(nd, ERR_PTR(-ENOMEM));
+		return 0;
+	}
 
 	uio = (uio_t *)kmalloc(sizeof(uio_t), GFP_KERNEL);
 	if (!uio) {
 		kfree(link);
-		return -ENOMEM;
+		nd_set_link(nd, ERR_PTR(-ENOMEM));
+		return 0;
 	}
 
 	vp = LINVFS_GET_VP(dentry->d_inode);
@@ -441,18 +445,22 @@
 
 	VOP_READLINK(vp, uio, 0, NULL, error);
 	if (error) {
-		kfree(uio);
 		kfree(link);
-		return -error;
+		link = ERR_PTR(-error);
+	} else {
+		link[MAXNAMELEN - uio->uio_resid] = '\0';
 	}
-
-	link[MAXNAMELEN - uio->uio_resid] = '\0';
 	kfree(uio);
 
-	/* vfs_follow_link returns (-) errors */
-	error = vfs_follow_link(nd, link);
-	kfree(link);
-	return error;
+	nd_set_link(nd, link);
+	return 0;
+}
+
+static void linvfs_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+	if (!IS_ERR(s))
+		kfree(s);
 }
 
 #ifdef CONFIG_XFS_POSIX_ACL
@@ -692,6 +700,7 @@
 struct inode_operations linvfs_symlink_inode_operations = {
 	.readlink		= linvfs_readlink,
 	.follow_link		= linvfs_follow_link,
+	.put_link		= linvfs_put_link,
 	.permission		= linvfs_permission,
 	.getattr		= linvfs_getattr,
 	.setattr		= linvfs_setattr,
