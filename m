Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCMDLA>; Tue, 12 Mar 2002 22:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSCMDKv>; Tue, 12 Mar 2002 22:10:51 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:9358 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S292229AbSCMDKk>; Tue, 12 Mar 2002 22:10:40 -0500
Message-ID: <3C8EC318.50408@didntduck.org>
Date: Tue, 12 Mar 2002 22:10:16 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] struct super_block cleanup - efs
Content-Type: multipart/mixed;
 boundary="------------080800070903030307010602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800070903030307010602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates efs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------080800070903030307010602
Content-Type: text/plain;
 name="sb-efs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-efs-1"

diff -urN linux-2.5.7-pre1/fs/efs/super.c linux/fs/efs/super.c
--- linux-2.5.7-pre1/fs/efs/super.c	Tue Mar 12 17:35:10 2002
+++ linux/fs/efs/super.c	Tue Mar 12 22:03:48 2002
@@ -70,10 +70,17 @@
 		printk(KERN_INFO "efs_inode_cache: not all structures were freed\n");
 }
 
+void efs_put_super(struct super_block *s)
+{
+	kfree(s->u.generic_sbp);
+	s->u.generic_sbp = NULL;
+}
+
 static struct super_operations efs_superblock_operations = {
 	alloc_inode:	efs_alloc_inode,
 	destroy_inode:	efs_destroy_inode,
 	read_inode:	efs_read_inode,
+	put_super:	efs_put_super,
 	statfs:		efs_statfs,
 };
 
@@ -205,7 +212,11 @@
 	struct efs_sb_info *sb;
 	struct buffer_head *bh;
 
- 	sb = SUPER_INFO(s);
+ 	sb = kmalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
+	if (!sb)
+		return -ENOMEM;
+	s->u.generic_sbp = sb;
+	memset(sb, 0, sizeof(struct efs_sb_info));
  
 	s->s_magic		= EFS_SUPER_MAGIC;
 	sb_set_blocksize(s, EFS_BLOCKSIZE);
@@ -263,6 +274,8 @@
 
 out_no_fs_ul:
 out_no_fs:
+	s->u.generic_sbp = NULL;
+	kfree(sb);
 	return -EINVAL;
 }
 
diff -urN linux-2.5.7-pre1/include/linux/efs_fs.h linux/include/linux/efs_fs.h
--- linux-2.5.7-pre1/include/linux/efs_fs.h	Thu Mar  7 21:18:27 2002
+++ linux/include/linux/efs_fs.h	Tue Mar 12 22:06:27 2002
@@ -29,6 +29,7 @@
 
 #include <linux/fs.h>
 #include <linux/efs_fs_i.h>
+#include <linux/efs_fs_sb.h>
 #include <linux/efs_dir.h>
 
 #ifndef MIN
@@ -42,7 +43,11 @@
 {
 	return list_entry(inode, struct efs_inode_info, vfs_inode);
 }
-#define SUPER_INFO(s)				&((s)->u.efs_sb)
+
+static inline struct efs_sb_info *SUPER_INFO(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 extern struct inode_operations efs_dir_inode_operations;
 extern struct file_operations efs_dir_operations;
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 20:22:02 2002
+++ linux/include/linux/fs.h	Tue Mar 12 22:06:23 2002
@@ -658,7 +658,6 @@
 #include <linux/sysv_fs_sb.h>
 #include <linux/affs_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
-#include <linux/efs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
 #include <linux/smb_fs_sb.h>
 #include <linux/hfs_fs_sb.h>
@@ -714,7 +713,6 @@
 		struct sysv_sb_info	sysv_sb;
 		struct affs_sb_info	affs_sb;
 		struct ufs_sb_info	ufs_sb;
-		struct efs_sb_info	efs_sb;
 		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct smb_sb_info	smbfs_sb;

--------------080800070903030307010602--

