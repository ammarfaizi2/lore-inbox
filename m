Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSAFWN6>; Sun, 6 Jan 2002 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSAFWNr>; Sun, 6 Jan 2002 17:13:47 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:11530 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284985AbSAFWNb>;
	Sun, 6 Jan 2002 17:13:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC] Unbork fs.h, 4 of 4
Date: Sun, 6 Jan 2002 23:17:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NLbd-0001LT-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last of a set of 4 patches aimed at removing the ext2-specific 
inode and super block includes from include/linux/fs.h, with a view to 
establishing a pattern for updating all the filesystems in the source tree 
to remove the union entirely.  Please see the first posting in this series
for details.

This patch removes the two ext2-specific includes from /include/linux/fs.h,
moves them to ext2_fs.h, removes the two ext2-specific members from the 
fs.h unions, and enables the new variable size per-filesystem functionality
for inodes and super blocks.

To apply:

    cd /your/2.4.17/tree
    cat this/patch | patch -p1

--
Daniel

--- 2.4.17.clean/fs/ext2/super.c	Sun Jan  6 17:40:24 2002
+++ 2.4.17/fs/ext2/super.c	Sun Jan  6 17:40:40 2002
@@ -806,16 +806,23 @@
 	return 0;
 }
 
-static DECLARE_FSTYPE_DEV(ext2_fs_type, "ext2", ext2_read_super);
-
+static struct file_system_type ext2_fs = {
+	owner:		THIS_MODULE,
+	fs_flags:	FS_REQUIRES_DEV,
+	name:		"ext2",
+	read_super:	ext2_read_super,
+	super_size:	sizeof(struct ext2_sb_info),
+	inode_size:	sizeof(struct ext2_inode_info)
+};
+ 
 static int __init init_ext2_fs(void)
 {
-        return register_filesystem(&ext2_fs_type);
+        return register_filesystem(&ext2_fs);
 }
 
 static void __exit exit_ext2_fs(void)
 {
-	unregister_filesystem(&ext2_fs_type);
+	unregister_filesystem(&ext2_fs);
 }
 
 EXPORT_NO_SYMBOLS;
--- 2.4.17.clean/include/linux/ext2_fs.h	Sun Jan  6 17:40:24 2002
+++ 2.4.17/include/linux/ext2_fs.h	Sun Jan  6 17:40:40 2002
@@ -17,6 +17,8 @@
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/ext2_fs_i.h>
+#include <linux/ext2_fs_sb.h>
 
 /*
  * The second extended filesystem constants/structures
--- 2.4.17.clean/include/linux/fs.h	Sun Jan  6 17:35:40 2002
+++ 2.4.17/include/linux/fs.h	Sun Jan  6 17:40:40 2002
@@ -288,7 +288,6 @@
 
 #include <linux/pipe_fs_i.h>
 #include <linux/minix_fs_i.h>
-#include <linux/ext2_fs_i.h>
 #include <linux/ext3_fs_i.h>
 #include <linux/hpfs_fs_i.h>
 #include <linux/ntfs_fs_i.h>
@@ -478,7 +477,6 @@
 	__u32			i_generation;
 	union {
 		struct minix_inode_info		minix_i;
-		struct ext2_inode_info		ext2_i;
 		struct ext3_inode_info		ext3_i;
 		struct hpfs_inode_info		hpfs_i;
 		struct ntfs_inode_info		ntfs_i;
@@ -667,7 +665,6 @@
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
 #include <linux/minix_fs_sb.h>
-#include <linux/ext2_fs_sb.h>
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
@@ -742,7 +739,6 @@
 
 	union {
 		struct minix_sb_info	minix_sb;
-		struct ext2_sb_info	ext2_sb;
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
