Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287463AbRLaFcs>; Mon, 31 Dec 2001 00:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287460AbRLaFca>; Mon, 31 Dec 2001 00:32:30 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:7181 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287459AbRLaFcT>;
	Mon, 31 Dec 2001 00:32:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [WIP] Unbork fs.h, 3 of 3
Date: Mon, 31 Dec 2001 06:36:08 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-fsdevel@vger.kernel.org
Message-Id: <E16Kv7J-0003CW-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third patch of a series that will eventually remove the
filesystem-specific includes, the struct inode union and the struct 
super_block union from linux/fs.h.  See part 1 of this series for a 
description of the approach.

This patch changes the ext2 filesystem declaration, giving ext2 its own 
private inode cache.  The <ext2_fs_i> include is removed from linus/fs.h and 
moved to ext2_fs.h.  The ext2_inode_info member of the fs.h inode union is 
removed.  With the union out of the picture, ext2 inodes are somewhat 
smaller, 
so the practical effect of this is a small saving of cache memory.

If this approach meets with general approval, I will procede with the removal
of the ext2 member of the super_block union.

To apply this patch:

  cd /your/source/tree
  cat this/patch | patch -p0

I strongly recommended that this patch not be tested on a system containing
valuable data - user mode linux is the way to go.

--
Daniel

--- ../2.4.16.uml.clean/fs/ext2/super.c	Sun Dec 30 10:15:56 2001
+++ ./fs/ext2/super.c	Mon Dec 31 02:37:17 2001
@@ -798,7 +798,9 @@
 	return 0;
 }
 
-static DECLARE_FSTYPE_DEV(ext2_fs_type, "ext2", ext2_read_super);
+static FILESYSTEM(ext2_fs_type, "ext2", ext2_read_super,
+	sizeof (struct ext2_sb_info),
+	sizeof (struct ext2_inode_info));
 
 static int __init init_ext2_fs(void)
 {
--- ../2.4.16.uml.clean/include/linux/ext2_fs.h	Mon Dec 31 02:51:14 2001
+++ ./include/linux/ext2_fs.h	Mon Dec 31 02:38:25 2001
@@ -17,6 +17,7 @@
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/ext2_fs_i.h>
 
 /*
  * The second extended filesystem constants/structures
--- ../2.4.16.uml.clean/include/linux/fs.h	Mon Dec 31 02:51:14 2001
+++ ./include/linux/fs.h	Mon Dec 31 02:39:51 2001
@@ -288,7 +288,6 @@
 
 #include <linux/pipe_fs_i.h>
 #include <linux/minix_fs_i.h>
-#include <linux/ext2_fs_i.h>
 #include <linux/ext3_fs_i.h>
 #include <linux/hpfs_fs_i.h>
 #include <linux/ntfs_fs_i.h>
@@ -479,7 +478,6 @@
 	__u32			i_generation;
 	union {
 		struct minix_inode_info		minix_i;
-		struct ext2_inode_info		ext2_inode_info;
 		struct ext3_inode_info		ext3_i;
 		struct hpfs_inode_info		hpfs_i;
 		struct ntfs_inode_info		ntfs_i;

