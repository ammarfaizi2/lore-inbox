Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUFVUHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUFVUHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUFVTbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:31:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265281AbUFVTYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:00 -0400
To: torvalds@osdl.org
Subject: [PATCH] (4/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xW-K0@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        cases that can simply reuse ext2 helpers (page_follow_link_light()
and page_put_link()).

diff -urN RC7-bk5-trivial/fs/affs/symlink.c RC7-bk5-page/fs/affs/symlink.c
--- RC7-bk5-trivial/fs/affs/symlink.c	Tue Mar 18 02:22:56 2003
+++ RC7-bk5-page/fs/affs/symlink.c	Tue Jun 22 15:13:10 2004
@@ -78,7 +78,8 @@
 };
 
 struct inode_operations affs_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.setattr	= affs_notify_change,
 };
diff -urN RC7-bk5-trivial/fs/coda/cnode.c RC7-bk5-page/fs/coda/cnode.c
--- RC7-bk5-trivial/fs/coda/cnode.c	Sat Sep 27 22:04:56 2003
+++ RC7-bk5-page/fs/coda/cnode.c	Tue Jun 22 15:13:10 2004
@@ -17,8 +17,9 @@
 }
 
 static struct inode_operations coda_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.setattr	= coda_setattr,
 };
 
diff -urN RC7-bk5-trivial/fs/ext3/symlink.c RC7-bk5-page/fs/ext3/symlink.c
--- RC7-bk5-trivial/fs/ext3/symlink.c	Thu Oct  9 17:34:47 2003
+++ RC7-bk5-page/fs/ext3/symlink.c	Tue Jun 22 15:13:10 2004
@@ -20,24 +20,20 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/namei.h>
 #include "xattr.h"
 
-static int
-ext3_readlink(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	struct ext3_inode_info *ei = EXT3_I(dentry->d_inode);
-	return vfs_readlink(dentry, buffer, buflen, (char*)ei->i_data);
-}
-
 static int ext3_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ext3_inode_info *ei = EXT3_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char*)ei->i_data);
+	nd_set_link(nd, (char*)ei->i_data);
+	return 0;
 }
 
 struct inode_operations ext3_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.setxattr	= ext3_setxattr,
 	.getxattr	= ext3_getxattr,
 	.listxattr	= ext3_listxattr,
@@ -45,8 +41,8 @@
 };
 
 struct inode_operations ext3_fast_symlink_inode_operations = {
-	.readlink	= ext3_readlink,	/* BKL not held.  Don't need */
-	.follow_link	= ext3_follow_link,	/* BKL not held.  Don't need */
+	.readlink	= generic_readlink,
+	.follow_link	= ext3_follow_link,
 	.setxattr	= ext3_setxattr,
 	.getxattr	= ext3_getxattr,
 	.listxattr	= ext3_listxattr,
diff -urN RC7-bk5-trivial/fs/minix/inode.c RC7-bk5-page/fs/minix/inode.c
--- RC7-bk5-trivial/fs/minix/inode.c	Mon Nov 24 04:40:02 2003
+++ RC7-bk5-page/fs/minix/inode.c	Tue Jun 22 15:13:10 2004
@@ -343,8 +343,9 @@
 };
 
 static struct inode_operations minix_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.getattr	= minix_getattr,
 };
 
diff -urN RC7-bk5-trivial/fs/reiserfs/namei.c RC7-bk5-page/fs/reiserfs/namei.c
--- RC7-bk5-trivial/fs/reiserfs/namei.c	Wed Jun 16 10:26:24 2004
+++ RC7-bk5-page/fs/reiserfs/namei.c	Tue Jun 22 15:13:10 2004
@@ -1389,8 +1389,9 @@
  * stuff added
  */
 struct inode_operations reiserfs_symlink_inode_operations = {
-    .readlink       = page_readlink,
-    .follow_link    = page_follow_link,
+    .readlink       = generic_readlink,
+    .follow_link    = page_follow_link_light,
+    .put_link       = page_put_link,
     .setattr        = reiserfs_setattr,
     .setxattr       = reiserfs_setxattr,
     .getxattr       = reiserfs_getxattr,
diff -urN RC7-bk5-trivial/fs/sysv/inode.c RC7-bk5-page/fs/sysv/inode.c
--- RC7-bk5-trivial/fs/sysv/inode.c	Mon May 10 00:23:36 2004
+++ RC7-bk5-page/fs/sysv/inode.c	Tue Jun 22 15:13:10 2004
@@ -142,8 +142,9 @@
 }
 
 static struct inode_operations sysv_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+	.put_link	= page_put_link,
 	.getattr	= sysv_getattr,
 };
 
