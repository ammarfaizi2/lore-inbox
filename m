Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSAPSVg>; Wed, 16 Jan 2002 13:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285878AbSAPSV2>; Wed, 16 Jan 2002 13:21:28 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:4103 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S285850AbSAPSVV>; Wed, 16 Jan 2002 13:21:21 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matija Nalis <mnalis-umsdos@voyager.hr>, linux-kernel@vger.kernel.org
Subject: [PATCH] message cleanup of FAT stuff
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 17 Jan 2002 03:20:59 +0900
Message-ID: <87vge2jgxg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Linus, sorry for my previous miss email.]

This patch is message cleanup of fat stuff. By this, the bogus message
shouldn't be outputted at the time of root filesystem detection.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.3-pre1/fs/fat/inode.c linux-fat_message/fs/fat/inode.c
--- linux-2.5.3-pre1/fs/fat/inode.c	Thu Jan 17 00:30:26 2002
+++ linux-fat_message/fs/fat/inode.c	Thu Jan 17 02:05:16 2002
@@ -559,9 +559,9 @@
 	struct buffer_head *bh;
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int logical_sector_size, fat_clusters;
+	int logical_sector_size, fat_clusters, debug, cp;
 	unsigned int total_sectors, rootdir_sectors;
-	int debug, cp;
+	long error = -EIO;
 	char buf[50];
 	int i;
 	char cvf_format[21];
@@ -786,9 +786,8 @@
 	return sb;
 
 out_invalid:
-	if (!silent)
-		printk("VFS: Can't find a valid FAT filesystem on dev %s.\n",
-			sb->s_id);
+	error = 0;
+
 out_fail:
 	if (sbi->nls_io)
 		unload_nls(sbi->nls_io);
@@ -799,8 +798,8 @@
 	if (sbi->private_data)
 		kfree(sbi->private_data);
 	sbi->private_data = NULL;
- 
-	return NULL;
+
+	return ERR_PTR(error);
 }
 
 int fat_statfs(struct super_block *sb,struct statfs *buf)
diff -urN linux-2.5.3-pre1/fs/msdos/msdosfs_syms.c linux-fat_message/fs/msdos/msdosfs_syms.c
--- linux-2.5.3-pre1/fs/msdos/msdosfs_syms.c	Mon Dec 31 09:58:58 2001
+++ linux-fat_message/fs/msdos/msdosfs_syms.c	Thu Jan 17 00:12:51 2002
@@ -23,7 +23,6 @@
 EXPORT_SYMBOL(msdos_rename);
 EXPORT_SYMBOL(msdos_rmdir);
 EXPORT_SYMBOL(msdos_unlink);
-EXPORT_SYMBOL(msdos_read_super);
 EXPORT_SYMBOL(msdos_put_super);
 
 static DECLARE_FSTYPE_DEV(msdos_fs_type, "msdos", msdos_read_super);
diff -urN linux-2.5.3-pre1/fs/msdos/namei.c linux-fat_message/fs/msdos/namei.c
--- linux-2.5.3-pre1/fs/msdos/namei.c	Mon Dec 31 03:53:53 2001
+++ linux-fat_message/fs/msdos/namei.c	Thu Jan 17 00:23:40 2002
@@ -589,7 +589,15 @@
 
 	MSDOS_SB(sb)->options.isvfat = 0;
 	res = fat_read_super(sb, data, silent, &msdos_dir_inode_operations);
-	if (res)
-		sb->s_root->d_op = &msdos_dentry_operations;
+	if (IS_ERR(res))
+		return NULL;
+	if (res == NULL) {
+		if (!silent)
+			printk(KERN_INFO "VFS: Can't find a valid"
+			       " MSDOS filesystem on dev %s.\n", sb->s_id);
+		return NULL;
+	}
+
+	sb->s_root->d_op = &msdos_dentry_operations;
 	return res;
 }
diff -urN linux-2.5.3-pre1/fs/umsdos/inode.c linux-fat_message/fs/umsdos/inode.c
--- linux-2.5.3-pre1/fs/umsdos/inode.c	Wed Jan  2 11:55:00 2002
+++ linux-fat_message/fs/umsdos/inode.c	Thu Jan 17 00:22:15 2002
@@ -363,10 +363,17 @@
 	 * Call msdos-fs to mount the disk.
 	 * Note: this returns res == sb or NULL
 	 */
-	res = msdos_read_super (sb, data, silent);
+	MSDOS_SB(sb)->options.isvfat = 0;
+	res = fat_read_super(sb, data, silent, &umsdos_rdir_inode_operations);
 
-	if (!res)
-		goto out_fail;
+	if (IS_ERR(res))
+		return NULL;
+	if (res == NULL) {
+		if (!silent)
+			printk(KERN_INFO "VFS: Can't find a valid "
+			       "UMSDOS filesystem on dev %s.\n", sb->s_id);
+		return NULL;
+	}
 
 	printk (KERN_INFO "UMSDOS 0.86k "
 		"(compatibility level %d.%d, fast msdos)\n", 
@@ -394,10 +401,6 @@
 		dget (sb->s_root); sb->s_root = dget(new_root);
 	}
 	return sb;
-
-out_fail:
-	printk(KERN_INFO "UMSDOS: msdos_read_super failed, mount aborted.\n");
-	return NULL;
 }
 
 /*
diff -urN linux-2.5.3-pre1/fs/vfat/namei.c linux-fat_message/fs/vfat/namei.c
--- linux-2.5.3-pre1/fs/vfat/namei.c	Thu Jan 17 00:30:26 2002
+++ linux-fat_message/fs/vfat/namei.c	Thu Jan 17 00:25:00 2002
@@ -1266,10 +1266,15 @@
 	struct super_block *res;
   
 	MSDOS_SB(sb)->options.isvfat = 1;
-
 	res = fat_read_super(sb, data, silent, &vfat_dir_inode_operations);
-	if (res == NULL)
+	if (IS_ERR(res))
 		return NULL;
+	if (res == NULL) {
+		if (!silent)
+			printk(KERN_INFO "VFS: Can't find a valid"
+			       " VFAT filesystem on dev %s.\n", sb->s_id);
+		return NULL;
+	}
 
 	if (parse_options((char *) data, &(MSDOS_SB(sb)->options))) {
 		MSDOS_SB(sb)->options.dotsOK = 0;
