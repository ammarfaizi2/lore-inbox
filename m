Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311443AbSCNAYO>; Wed, 13 Mar 2002 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311446AbSCNAYH>; Wed, 13 Mar 2002 19:24:07 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:3566 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S311444AbSCNAX5>; Wed, 13 Mar 2002 19:23:57 -0500
Message-ID: <3C8FE8E3.2040204@didntduck.org>
Date: Wed, 13 Mar 2002 19:03:47 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - msdos/vfat
Content-Type: multipart/mixed;
 boundary="------------070700080207030607030607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070700080207030607030607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates msdos_sb_info from struct super_block for msdos and vfat. 
Umsdos is terminally broken and is not included.

-- 

						Brian Gerst

--------------070700080207030607030607
Content-Type: text/plain;
 name="sb-fat-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-fat-1"

diff -urN linux-2.5.7-pre1/fs/fat/fatfs_syms.c linux/fs/fat/fatfs_syms.c
--- linux-2.5.7-pre1/fs/fat/fatfs_syms.c	Thu Mar  7 21:18:15 2002
+++ linux/fs/fat/fatfs_syms.c	Wed Mar 13 09:28:06 2002
@@ -24,7 +24,7 @@
 EXPORT_SYMBOL(fat_attach);
 EXPORT_SYMBOL(fat_detach);
 EXPORT_SYMBOL(fat_build_inode);
-EXPORT_SYMBOL(fat_read_super);
+EXPORT_SYMBOL(fat_fill_super);
 EXPORT_SYMBOL(fat_search_long);
 EXPORT_SYMBOL(fat_readdir);
 EXPORT_SYMBOL(fat_scan);
diff -urN linux-2.5.7-pre1/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.7-pre1/fs/fat/inode.c	Thu Mar  7 21:18:29 2002
+++ linux/fs/fat/inode.c	Wed Mar 13 08:20:12 2002
@@ -167,32 +167,36 @@
 
 void fat_put_super(struct super_block *sb)
 {
-	if (MSDOS_SB(sb)->cvf_format->cvf_version) {
-		dec_cvf_format_use_count_by_version(MSDOS_SB(sb)->cvf_format->cvf_version);
-		MSDOS_SB(sb)->cvf_format->unmount_cvf(sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	if (sbi->cvf_format->cvf_version) {
+		dec_cvf_format_use_count_by_version(sbi->cvf_format->cvf_version);
+		sbi->cvf_format->unmount_cvf(sb);
 	}
-	if (MSDOS_SB(sb)->fat_bits == 32) {
+	if (sbi->fat_bits == 32) {
 		fat_clusters_flush(sb);
 	}
 	fat_cache_inval_dev(sb);
 	set_blocksize (sb->s_dev,BLOCK_SIZE);
-	if (MSDOS_SB(sb)->nls_disk) {
-		unload_nls(MSDOS_SB(sb)->nls_disk);
-		MSDOS_SB(sb)->nls_disk = NULL;
-		MSDOS_SB(sb)->options.codepage = 0;
-	}
-	if (MSDOS_SB(sb)->nls_io) {
-		unload_nls(MSDOS_SB(sb)->nls_io);
-		MSDOS_SB(sb)->nls_io = NULL;
+	if (sbi->nls_disk) {
+		unload_nls(sbi->nls_disk);
+		sbi->nls_disk = NULL;
+		sbi->options.codepage = 0;
+	}
+	if (sbi->nls_io) {
+		unload_nls(sbi->nls_io);
+		sbi->nls_io = NULL;
 	}
 	/*
 	 * Note: the iocharset option might have been specified
 	 * without enabling nls_io, so check for it here.
 	 */
-	if (MSDOS_SB(sb)->options.iocharset) {
-		kfree(MSDOS_SB(sb)->options.iocharset);
-		MSDOS_SB(sb)->options.iocharset = NULL;
+	if (sbi->options.iocharset) {
+		kfree(sbi->options.iocharset);
+		sbi->options.iocharset = NULL;
 	}
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 }
 
 
@@ -582,18 +586,14 @@
 
 /*
  * Read the super block of an MS-DOS FS.
- *
- * Note that this may be called from vfat_read_super
- * with some fields already initialized.
  */
-struct super_block *
-fat_read_super(struct super_block *sb, void *data, int silent,
-		struct inode_operations *fs_dir_inode_ops)
+int fat_fill_super(struct super_block *sb, void *data, int silent,
+		   struct inode_operations *fs_dir_inode_ops, int isvfat)
 {
 	struct inode *root_inode;
 	struct buffer_head *bh;
 	struct fat_boot_sector *b;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct msdos_sb_info *sbi;
 	int logical_sector_size, fat_clusters, debug, cp;
 	unsigned int total_sectors, rootdir_sectors;
 	long error = -EIO;
@@ -602,12 +602,19 @@
 	char cvf_format[21];
 	char cvf_options[101];
 
+	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct msdos_sb_info));
+
 	cvf_format[0] = '\0';
 	cvf_options[0] = '\0';
 	sbi->private_data = NULL;
 
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
+	sbi->options.isvfat = isvfat;
 	sbi->dir_ops = fs_dir_inode_ops;
 	sbi->cvf_format = &default_cvf;
 
@@ -830,10 +837,10 @@
 		sbi->cvf_format = cvf_formats[i];
 		++cvf_format_use_count[i];
 	}
-	return sb;
+	return 0;
 
 out_invalid:
-	error = 0;
+	error = -EINVAL;
 
 out_fail:
 	if (sbi->nls_io)
@@ -845,8 +852,10 @@
 	if (sbi->private_data)
 		kfree(sbi->private_data);
 	sbi->private_data = NULL;
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 
-	return ERR_PTR(error);
+	return error;
 }
 
 int fat_statfs(struct super_block *sb,struct statfs *buf)
diff -urN linux-2.5.7-pre1/fs/msdos/namei.c linux/fs/msdos/namei.c
--- linux-2.5.7-pre1/fs/msdos/namei.c	Thu Mar  7 21:18:32 2002
+++ linux/fs/msdos/namei.c	Wed Mar 13 08:20:12 2002
@@ -603,17 +603,14 @@
 
 int msdos_fill_super(struct super_block *sb,void *data, int silent)
 {
-	struct super_block *res;
+	int res;
 
-	MSDOS_SB(sb)->options.isvfat = 0;
-	res = fat_read_super(sb, data, silent, &msdos_dir_inode_operations);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
-	if (res == NULL) {
+	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
+	if (res) {
 		if (!silent)
 			printk(KERN_INFO "VFS: Can't find a valid"
 			       " MSDOS filesystem on dev %s.\n", sb->s_id);
-		return -EINVAL;
+		return res;
 	}
 
 	sb->s_root->d_op = &msdos_dentry_operations;
diff -urN linux-2.5.7-pre1/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux-2.5.7-pre1/fs/vfat/namei.c	Thu Mar  7 21:18:11 2002
+++ linux/fs/vfat/namei.c	Wed Mar 13 08:20:12 2002
@@ -1285,25 +1285,25 @@
 
 int vfat_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct super_block *res;
+	int res;
+	struct msdos_sb_info *sbi;
   
-	MSDOS_SB(sb)->options.isvfat = 1;
-	res = fat_read_super(sb, data, silent, &vfat_dir_inode_operations);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
-	if (res == NULL) {
+	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
+	if (res) {
 		if (!silent)
 			printk(KERN_INFO "VFS: Can't find a valid"
 			       " VFAT filesystem on dev %s.\n", sb->s_id);
-		return -EINVAL;
+		return res;
 	}
 
-	if (parse_options((char *) data, &(MSDOS_SB(sb)->options))) {
-		MSDOS_SB(sb)->options.dotsOK = 0;
-		if (MSDOS_SB(sb)->options.posixfs) {
-			MSDOS_SB(sb)->options.name_check = 's';
+	sbi = MSDOS_SB(sb);
+
+	if (parse_options((char *) data, &(sbi->options))) {
+		sbi->options.dotsOK = 0;
+		if (sbi->options.posixfs) {
+			sbi->options.name_check = 's';
 		}
-		if (MSDOS_SB(sb)->options.name_check != 's') {
+		if (sbi->options.name_check != 's') {
 			sb->s_root->d_op = &vfat_dentry_ops[0];
 		} else {
 			sb->s_root->d_op = &vfat_dentry_ops[2];
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 22:44:13 2002
+++ linux/include/linux/fs.h	Wed Mar 13 09:24:44 2002
@@ -652,7 +652,6 @@
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
-#include <linux/msdos_fs_sb.h>
 #include <linux/iso_fs_sb.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/sysv_fs_sb.h>
@@ -708,7 +707,6 @@
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
-		struct msdos_sb_info	msdos_sb;
 		struct isofs_sb_info	isofs_sb;
 		struct nfs_sb_info	nfs_sb;
 		struct sysv_sb_info	sysv_sb;
diff -urN linux-2.5.7-pre1/include/linux/msdos_fs.h linux/include/linux/msdos_fs.h
--- linux-2.5.7-pre1/include/linux/msdos_fs.h	Thu Mar  7 21:18:56 2002
+++ linux/include/linux/msdos_fs.h	Wed Mar 13 09:27:13 2002
@@ -5,6 +5,7 @@
  * The MS-DOS filesystem constants/structures
  */
 #include <linux/msdos_fs_i.h>
+#include <linux/msdos_fs_sb.h>
 
 #include <asm/byteorder.h>
 
@@ -53,7 +54,11 @@
 #define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
 	/* valid file mode bits */
 
-#define MSDOS_SB(s) (&((s)->u.msdos_sb))
+static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
 {
 	return list_entry(inode, struct msdos_inode_info, vfs_inode);
@@ -282,9 +287,8 @@
 extern void fat_delete_inode(struct inode *inode);
 extern void fat_clear_inode(struct inode *inode);
 extern void fat_put_super(struct super_block *sb);
-extern struct super_block *
-fat_read_super(struct super_block *sb, void *data, int silent,
-	       struct inode_operations *fs_dir_inode_ops);
+int fat_fill_super(struct super_block *sb, void *data, int silent,
+		   struct inode_operations *fs_dir_inode_ops, int isvfat);
 extern int fat_statfs(struct super_block *sb, struct statfs *buf);
 extern void fat_write_inode(struct inode *inode, int wait);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);

--------------070700080207030607030607--


