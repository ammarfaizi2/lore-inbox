Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265440AbUFVTcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbUFVTcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUFVTc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:32:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265502AbUFVTYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:00 -0400
To: torvalds@osdl.org
Subject: [PATCH] (9/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xm-Sq@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        jffs2 switched; leaks plugged.

diff -urN RC7-bk5-befs/fs/jffs2/symlink.c RC7-bk5-jffs2/fs/jffs2/symlink.c
--- RC7-bk5-befs/fs/jffs2/symlink.c	Sat Oct 18 13:09:53 2003
+++ RC7-bk5-jffs2/fs/jffs2/symlink.c	Tue Jun 22 15:13:12 2004
@@ -15,43 +15,31 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include "nodelist.h"
 
-int jffs2_readlink(struct dentry *dentry, char *buffer, int buflen);
-int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
+static int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
+static void jffs2_put_link(struct dentry *dentry, struct nameidata *nd);
 
 struct inode_operations jffs2_symlink_inode_operations =
 {	
-	.readlink =	jffs2_readlink,
+	.readlink =	generic_readlink,
 	.follow_link =	jffs2_follow_link,
+	.put_link =	jffs2_put_link,
 	.setattr =	jffs2_setattr
 };
 
-int jffs2_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	unsigned char *kbuf;
-	int ret;
-
-	kbuf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb), JFFS2_INODE_INFO(dentry->d_inode));
-	if (IS_ERR(kbuf))
-		return PTR_ERR(kbuf);
-
-	ret = vfs_readlink(dentry, buffer, buflen, kbuf);
-	kfree(kbuf);
-	return ret;
-}
-
-int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	unsigned char *buf;
-	int ret;
-
 	buf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb), JFFS2_INODE_INFO(dentry->d_inode));
+	nd_set_link(nd, buf);
+	return 0;
+}
 
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	ret = vfs_follow_link(nd, buf);
-	kfree(buf);
-	return ret;
+static void jffs2_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+	if (!IS_ERR(s))
+		kfree(s);
 }
