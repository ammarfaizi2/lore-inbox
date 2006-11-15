Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030750AbWKORgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030750AbWKORgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWKORgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:36:06 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25092 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1030750AbWKORgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:36:02 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat: add fat_getattr()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 16 Nov 2006 02:35:54 +0900
Message-ID: <87odr8a9z9.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds fat_getattr() for setting stat->blksize. (FAT uses the size
of cluster for proper I/O)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c            |   10 ++++++++++
 fs/msdos/namei.c         |    1 +
 fs/vfat/namei.c          |    1 +
 include/linux/msdos_fs.h |    2 ++
 4 files changed, 14 insertions(+)

diff -puN fs/fat/file.c~fat_getattr fs/fat/file.c
--- linux-2.6/fs/fat/file.c~fat_getattr	2006-11-08 00:35:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/file.c	2006-11-08 00:48:07.000000000 +0900
@@ -303,7 +303,17 @@ void fat_truncate(struct inode *inode)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
+int fat_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	generic_fillattr(inode, stat);
+	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_getattr);
+
 struct inode_operations fat_file_inode_operations = {
 	.truncate	= fat_truncate,
 	.setattr	= fat_notify_change,
+	.getattr	= fat_getattr,
 };
diff -puN include/linux/msdos_fs.h~fat_getattr include/linux/msdos_fs.h
--- linux-2.6/include/linux/msdos_fs.h~fat_getattr	2006-11-08 00:35:16.000000000 +0900
+++ linux-2.6-hirofumi/include/linux/msdos_fs.h	2006-11-08 00:35:16.000000000 +0900
@@ -402,6 +402,8 @@ extern const struct file_operations fat_
 extern struct inode_operations fat_file_inode_operations;
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 extern void fat_truncate(struct inode *inode);
+extern int fat_getattr(struct vfsmount *mnt, struct dentry *dentry,
+		       struct kstat *stat);
 
 /* fat/inode.c */
 extern void fat_attach(struct inode *inode, loff_t i_pos);
diff -puN fs/msdos/namei.c~fat_getattr fs/msdos/namei.c
--- linux-2.6/fs/msdos/namei.c~fat_getattr	2006-11-08 00:35:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/msdos/namei.c	2006-11-08 00:35:16.000000000 +0900
@@ -654,6 +654,7 @@ static struct inode_operations msdos_dir
 	.rmdir		= msdos_rmdir,
 	.rename		= msdos_rename,
 	.setattr	= fat_notify_change,
+	.getattr	= fat_getattr,
 };
 
 static int msdos_fill_super(struct super_block *sb, void *data, int silent)
diff -puN fs/vfat/namei.c~fat_getattr fs/vfat/namei.c
--- linux-2.6/fs/vfat/namei.c~fat_getattr	2006-11-08 00:35:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/vfat/namei.c	2006-11-08 00:35:16.000000000 +0900
@@ -1004,6 +1004,7 @@ static struct inode_operations vfat_dir_
 	.rmdir		= vfat_rmdir,
 	.rename		= vfat_rename,
 	.setattr	= fat_notify_change,
+	.getattr	= fat_getattr,
 };
 
 static int vfat_fill_super(struct super_block *sb, void *data, int silent)
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
