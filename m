Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265155AbUFVTct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUFVTct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUFVTcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:32:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265454AbUFVTYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:00 -0400
To: torvalds@osdl.org
Subject: [PATCH] (8/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xj-S8@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        befs switched; leaks plugged.

diff -urN RC7-bk5-shm/fs/befs/linuxvfs.c RC7-bk5-befs/fs/befs/linuxvfs.c
--- RC7-bk5-shm/fs/befs/linuxvfs.c	Wed Jun 16 10:26:22 2004
+++ RC7-bk5-befs/fs/befs/linuxvfs.c	Tue Jun 22 15:13:11 2004
@@ -14,6 +14,7 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/parser.h>
+#include <linux/namei.h>
 
 #include "befs.h"
 #include "btree.h"
@@ -40,8 +41,8 @@
 static void befs_destroy_inode(struct inode *inode);
 static int befs_init_inodecache(void);
 static void befs_destroy_inodecache(void);
-static int befs_readlink(struct dentry *, char __user *, int);
-static int befs_follow_link(struct dentry *, struct nameidata *nd);
+static int befs_follow_link(struct dentry *, struct nameidata *);
+static void befs_put_link(struct dentry *, struct nameidata *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
@@ -85,8 +86,9 @@
 };
 
 static struct inode_operations befs_symlink_inode_operations = {
-	.readlink	= befs_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= befs_follow_link,
+	.put_link	= befs_put_link,
 };
 
 /* 
@@ -462,71 +464,40 @@
 static int
 befs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct super_block *sb = dentry->d_sb;
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
 	char *link;
-	int res;
 
 	if (befs_ino->i_flags & BEFS_LONG_SYMLINK) {
+		struct super_block *sb = dentry->d_sb;
 		befs_data_stream *data = &befs_ino->i_data.ds;
-		befs_off_t linklen = data->size;
+		befs_off_t len = data->size;
 
 		befs_debug(sb, "Follow long symlink");
 
-		link = kmalloc(linklen, GFP_NOFS);
-		if (link == NULL)
-			return -ENOMEM;
-
-		if (befs_read_lsymlink(sb, data, link, linklen) != linklen) {
+		link = kmalloc(len, GFP_NOFS);
+		if (!link) {
+			link = ERR_PTR(-ENOMEM);
+		} else if (befs_read_lsymlink(sb, data, link, len) != len) {
 			kfree(link);
 			befs_error(sb, "Failed to read entire long symlink");
-			return -EIO;
+			link = ERR_PTR(-EIO);
 		}
-
-		res = vfs_follow_link(nd, link);
-
-		kfree(link);
 	} else {
 		link = befs_ino->i_data.symlink;
-		res = vfs_follow_link(nd, link);
 	}
 
-	return res;
+	nd_set_link(nd, link);
+	return 0;
 }
 
-static int
-befs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+static void befs_put_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct super_block *sb = dentry->d_sb;
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
-	char *link;
-	int res;
-
 	if (befs_ino->i_flags & BEFS_LONG_SYMLINK) {
-		befs_data_stream *data = &befs_ino->i_data.ds;
-		befs_off_t linklen = data->size;
-
-		befs_debug(sb, "Read long symlink");
-
-		link = kmalloc(linklen, GFP_NOFS);
-		if (link == NULL)
-			return -ENOMEM;
-
-		if (befs_read_lsymlink(sb, data, link, linklen) != linklen) {
-			kfree(link);
-			befs_error(sb, "Failed to read entire long symlink");
-			return -EIO;
-		}
-
-		res = vfs_readlink(dentry, buffer, buflen, link);
-
-		kfree(link);
-	} else {
-		link = befs_ino->i_data.symlink;
-		res = vfs_readlink(dentry, buffer, buflen, link);
+		char *p = nd_get_link(nd);
+		if (!IS_ERR(p))
+			kfree(p);
 	}
-
-	return res;
 }
 
 /*
