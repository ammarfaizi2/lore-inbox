Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSJMANL>; Sat, 12 Oct 2002 20:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJMANL>; Sat, 12 Oct 2002 20:13:11 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:50697 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261382AbSJMANJ>; Sat, 12 Oct 2002 20:13:09 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix error code which fat_fill_super() returns (1/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Oct 2002 09:18:36 +0900
Message-ID: <87fzvbb38j.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes the error code which fat_fill_super() returns.
Please apply.


 fs/fat/inode.c   |   10 ++++++++--
 fs/msdos/namei.c |    6 +-----
 fs/vfat/namei.c  |    6 +-----
 3 files changed, 10 insertions(+), 12 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urNp linux-2.5.42/fs/fat/inode.c fat_super_err_fix/fs/fat/inode.c
--- linux-2.5.42/fs/fat/inode.c	2002-10-12 13:22:07.000000000 +0900
+++ fat_super_err_fix/fs/fat/inode.c	2002-10-13 03:18:25.000000000 +0900
@@ -639,7 +639,7 @@ int fat_fill_super(struct super_block *s
 	int logical_sector_size, fat_clusters, debug, cp, first;
 	unsigned int total_sectors, rootdir_sectors;
 	unsigned char media;
-	long error = -EIO;
+	long error;
 	char buf[50];
 	int i;
 	char cvf_format[21];
@@ -662,6 +662,7 @@ int fat_fill_super(struct super_block *s
 	sbi->dir_ops = fs_dir_inode_ops;
 	sbi->cvf_format = &default_cvf;
 
+	error = -EINVAL;
 	if (!parse_options((char *)data, &debug, &sbi->options,
 			   cvf_format, cvf_options))
 		goto out_fail;
@@ -670,6 +671,7 @@ int fat_fill_super(struct super_block *s
 	/* set up enough so that it can read an inode */
 	init_MUTEX(&sbi->fat_lock);
 
+	error = -EIO;
 	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
 	if (bh == NULL) {
@@ -848,13 +850,14 @@ int fat_fill_super(struct super_block *s
 		goto out_invalid;
 	}
 
+	error = -EINVAL;
 	if (!strcmp(cvf_format, "none"))
 		i = -1;
 	else
 		i = detect_cvf(sb, cvf_format);
 	if (i >= 0) {
 		if (cvf_formats[i]->mount_cvf(sb, cvf_options))
-			goto out_invalid;
+			goto out_fail;
 	}
 
 	cp = sbi->options.codepage ? sbi->options.codepage : 437;
@@ -912,6 +915,9 @@ int fat_fill_super(struct super_block *s
 
 out_invalid:
 	error = -EINVAL;
+	if (!silent)
+		printk(KERN_INFO "VFS: Can't find a valid FAT filesystem"
+		       " on dev %s.\n", sb->s_id);
 
 out_fail:
 	if (root_inode)
diff -urNp linux-2.5.42/fs/msdos/namei.c fat_super_err_fix/fs/msdos/namei.c
--- linux-2.5.42/fs/msdos/namei.c	2002-10-12 13:22:08.000000000 +0900
+++ fat_super_err_fix/fs/msdos/namei.c	2002-10-13 03:18:25.000000000 +0900
@@ -604,12 +604,8 @@ int msdos_fill_super(struct super_block 
 	int res;
 
 	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
-	if (res) {
-		if (res == -EINVAL && !silent)
-			printk(KERN_INFO "VFS: Can't find a valid"
-			       " MSDOS filesystem on dev %s.\n", sb->s_id);
+	if (res)
 		return res;
-	}
 
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
diff -urNp linux-2.5.42/fs/vfat/namei.c fat_super_err_fix/fs/vfat/namei.c
--- linux-2.5.42/fs/vfat/namei.c	2002-10-12 13:22:11.000000000 +0900
+++ fat_super_err_fix/fs/vfat/namei.c	2002-10-13 03:18:25.000000000 +0900
@@ -1284,12 +1284,8 @@ int vfat_fill_super(struct super_block *
 	struct msdos_sb_info *sbi;
   
 	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
-	if (res) {
-		if (res == -EINVAL && !silent)
-			printk(KERN_INFO "VFS: Can't find a valid"
-			       " VFAT filesystem on dev %s.\n", sb->s_id);
+	if (res)
 		return res;
-	}
 
 	sbi = MSDOS_SB(sb);
 
