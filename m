Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVD3UIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVD3UIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVD3UIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:08:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2575 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261388AbVD3UHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:07:42 -0400
Date: Sat, 30 Apr 2005 22:07:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] ext2: make ext2_count_free a static inline
Message-ID: <20050430200737.GJ3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2_count_free is a small function that is only used
#ifdef EXT2FS_DEBUG.

We could offer the function itself only #ifdef EXT2FS_DEBUG, but what 
about this patch to change ot to a static inline?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2005

 fs/ext2/Makefile |    2 +-
 fs/ext2/bitmap.c |   25 -------------------------
 fs/ext2/ext2.h   |   18 +++++++++++++++++-
 3 files changed, 18 insertions(+), 27 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h.old	2005-04-20 23:08:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h	2005-04-20 23:14:21.000000000 +0200
@@ -1,5 +1,6 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/buffer_head.h>
 
 /*
  * second extended file system inode data in memory
@@ -79,6 +80,22 @@
 	return container_of(inode, struct ext2_inode_info, vfs_inode);
 }
 
+static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
+
+static inline unsigned long ext2_count_free (struct buffer_head * map,
+					     unsigned int numchars)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	
+	if (!map) 
+		return (0);
+	for (i = 0; i < numchars; i++)
+		sum += nibblemap[map->b_data[i] & 0xf] +
+			nibblemap[(map->b_data[i] >> 4) & 0xf];
+	return (sum);
+}
+
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
@@ -111,7 +128,6 @@
 extern void ext2_free_inode (struct inode *);
 extern unsigned long ext2_count_free_inodes (struct super_block *);
 extern void ext2_check_inodes_bitmap (struct super_block *);
-extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
--- linux-2.6.12-rc2-mm3-full/fs/ext2/Makefile.old	2005-04-20 23:14:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/ext2/Makefile	2005-04-20 23:14:45.000000000 +0200
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
-ext2-y := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+ext2-y := balloc.o dir.o file.o fsync.o ialloc.o inode.o \
 	  ioctl.o namei.o super.o symlink.o
 
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
--- linux-2.6.12-rc2-mm3-full/fs/ext2/bitmap.c	2005-03-02 08:38:08.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,25 +0,0 @@
-/*
- *  linux/fs/ext2/bitmap.c
- *
- * Copyright (C) 1992, 1993, 1994, 1995
- * Remy Card (card@masi.ibp.fr)
- * Laboratoire MASI - Institut Blaise Pascal
- * Universite Pierre et Marie Curie (Paris VI)
- */
-
-#include <linux/buffer_head.h>
-
-static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
-
-unsigned long ext2_count_free (struct buffer_head * map, unsigned int numchars)
-{
-	unsigned int i;
-	unsigned long sum = 0;
-	
-	if (!map) 
-		return (0);
-	for (i = 0; i < numchars; i++)
-		sum += nibblemap[map->b_data[i] & 0xf] +
-			nibblemap[(map->b_data[i] >> 4) & 0xf];
-	return (sum);
-}


