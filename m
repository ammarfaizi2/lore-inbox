Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUIGOtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUIGOtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUIGOqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:46:24 -0400
Received: from verein.lst.de ([213.95.11.210]:46489 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268129AbUIGOoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:44:00 -0400
Date: Tue, 7 Sep 2004 16:43:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead exports from fs/fat/
Message-ID: <20040907144355.GB8717@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, hirofumi@mail.parknet.co.jp,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These were used by the defunct umsdos code only.


--- 1.22/fs/fat/dir.c	2004-09-05 01:04:43 +02:00
+++ edited/fs/fat/dir.c	2004-09-07 13:37:51 +02:00
@@ -22,6 +22,10 @@
 
 #include <asm/uaccess.h>
 
+static int fat_dir_ioctl(struct inode * inode, struct file * filp,
+		  unsigned int cmd, unsigned long arg);
+static int fat_readdir(struct file *filp, void *dirent, filldir_t filldir);
+
 struct file_operations fat_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= fat_readdir,
@@ -586,7 +590,7 @@
 	return ret;
 }
 
-int fat_readdir(struct file *filp, void *dirent, filldir_t filldir)
+static int fat_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	return fat_readdirx(inode, filp, dirent, filldir, 0, 0);
@@ -643,7 +647,7 @@
 	return -EFAULT;
 }
 
-int fat_dir_ioctl(struct inode * inode, struct file * filp,
+static int fat_dir_ioctl(struct inode * inode, struct file * filp,
 		  unsigned int cmd, unsigned long arg)
 {
 	struct fat_ioctl_filldir_callback buf;
--- 1.9/fs/fat/fatfs_syms.c	2002-10-23 17:14:05 +02:00
+++ edited/fs/fat/fatfs_syms.c	2004-09-07 13:39:22 +02:00
@@ -12,26 +12,17 @@
 #include <linux/msdos_fs.h>
 
 EXPORT_SYMBOL(fat_new_dir);
-EXPORT_SYMBOL(fat_get_block);
-EXPORT_SYMBOL(fat_clear_inode);
 EXPORT_SYMBOL(fat_date_unix2dos);
-EXPORT_SYMBOL(fat_delete_inode);
 EXPORT_SYMBOL(fat__get_entry);
 EXPORT_SYMBOL(fat_notify_change);
-EXPORT_SYMBOL(fat_put_super);
 EXPORT_SYMBOL(fat_attach);
 EXPORT_SYMBOL(fat_detach);
 EXPORT_SYMBOL(fat_build_inode);
 EXPORT_SYMBOL(fat_fill_super);
 EXPORT_SYMBOL(fat_search_long);
-EXPORT_SYMBOL(fat_readdir);
 EXPORT_SYMBOL(fat_scan);
-EXPORT_SYMBOL(fat_statfs);
-EXPORT_SYMBOL(fat_write_inode);
-EXPORT_SYMBOL(fat_dir_ioctl);
 EXPORT_SYMBOL(fat_add_entries);
 EXPORT_SYMBOL(fat_dir_empty);
-EXPORT_SYMBOL(fat_truncate);
 
 int __init fat_init_inodecache(void);
 void __exit fat_destroy_inodecache(void);
--- 1.100/fs/fat/inode.c	2004-09-05 01:04:54 +02:00
+++ edited/fs/fat/inode.c	2004-09-07 13:39:42 +02:00
@@ -31,6 +31,9 @@
 static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
 static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
 
+static int fat_statfs(struct super_block *sb, struct kstatfs *buf);
+static void fat_write_inode(struct inode *inode, int wait);
+
 /*
  * New FAT inode stuff. We do the following:
  *	a) i_ino is constant and has nothing with on-disk location.
@@ -143,7 +146,7 @@
 	return inode;
 }
 
-void fat_delete_inode(struct inode *inode)
+static void fat_delete_inode(struct inode *inode)
 {
 	if (!is_bad_inode(inode)) {
 		inode->i_size = 0;
@@ -152,7 +155,7 @@
 	clear_inode(inode);
 }
 
-void fat_clear_inode(struct inode *inode)
+static void fat_clear_inode(struct inode *inode)
 {
 	if (is_bad_inode(inode))
 		return;
@@ -164,7 +167,7 @@
 	unlock_kernel();
 }
 
-void fat_put_super(struct super_block *sb)
+static void fat_put_super(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
@@ -1072,7 +1075,7 @@
 	return error;
 }
 
-int fat_statfs(struct super_block *sb, struct kstatfs *buf)
+static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int free, nr, ret;
        
@@ -1227,7 +1230,7 @@
 	return 0;
 }
 
-void fat_write_inode(struct inode *inode, int wait)
+static void fat_write_inode(struct inode *inode, int wait)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
--- 1.36/include/linux/msdos_fs.h	2004-09-04 23:51:33 +02:00
+++ edited/include/linux/msdos_fs.h	2004-09-07 13:39:20 +02:00
@@ -244,9 +244,6 @@
 extern int fat_search_long(struct inode *inode, const unsigned char *name,
 			   int name_len, int anycase,
 			   loff_t *spos, loff_t *lpos);
-extern int fat_readdir(struct file *filp, void *dirent, filldir_t filldir);
-extern int fat_dir_ioctl(struct inode * inode, struct file * filp,
-			 unsigned int cmd, unsigned long arg);
 extern int fat_add_entries(struct inode *dir, int slots, struct buffer_head **bh,
 			struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat);
@@ -270,13 +267,8 @@
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos, int *res);
-extern void fat_delete_inode(struct inode *inode);
-extern void fat_clear_inode(struct inode *inode);
-extern void fat_put_super(struct super_block *sb);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
-extern int fat_statfs(struct super_block *sb, struct kstatfs *buf);
-extern void fat_write_inode(struct inode *inode, int wait);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
 /* fat/misc.c */
