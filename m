Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266324AbSKGDxP>; Wed, 6 Nov 2002 22:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbSKGDxK>; Wed, 6 Nov 2002 22:53:10 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:45697 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266324AbSKGDwt>;
	Wed, 6 Nov 2002 22:52:49 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 5/6: Fix meta_bg compatibility with e2fsprogs
From: tytso@mit.edu
Message-Id: <E189dpH-0007Gi-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:59:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix meta_bg compatibility with e2fsprogs 1.30.

The algorithm for finding the block group descriptor blocks for the 
future on-line resizable ext2/3 format change got out of sync with 
what was actually shipped in e2fsprogs 1.30.  (And what is in e2fsprogs
1.30 is better since it avoids a free block fragmentation at the
beginning of the block group.)  This change is safe, since no one is 
actually using the new meta_bg block group layout just yet.

fs/ext2/super.c         |    5 ++++-
fs/ext3/super.c         |    5 ++++-
include/linux/ext3_fs.h |    5 ++---
3 files changed, 10 insertions(+), 5 deletions(-)

diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Wed Nov  6 22:26:51 2002
+++ b/fs/ext2/super.c	Wed Nov  6 22:26:51 2002
@@ -529,6 +529,7 @@
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned long bg, first_data_block, first_meta_bg;
+	int has_super = 0;
 	
 	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
@@ -537,7 +538,9 @@
 	    nr < first_meta_bg)
 		return (logic_sb_block + nr + 1);
 	bg = sbi->s_desc_per_block * nr;
-	return (first_data_block + 1 + (bg * sbi->s_blocks_per_group));
+	if (ext2_bg_has_super(sb, bg))
+		has_super = 1;
+	return (first_data_block + has_super + (bg * sbi->s_blocks_per_group));
 }
 
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Wed Nov  6 22:26:51 2002
+++ b/fs/ext3/super.c	Wed Nov  6 22:26:51 2002
@@ -979,6 +979,7 @@
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	unsigned long bg, first_data_block, first_meta_bg;
+	int has_super = 0;
 	
 	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
@@ -987,7 +988,9 @@
 	    nr < first_meta_bg)
 		return (logic_sb_block + nr + 1);
 	bg = sbi->s_desc_per_block * nr;
-	return (first_data_block + 1 + (bg * sbi->s_blocks_per_group));
+	if (ext3_bg_has_super(sb, bg))
+		has_super = 1;
+	return (first_data_block + has_super + (bg * sbi->s_blocks_per_group));
 }
 
 
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Wed Nov  6 22:26:51 2002
+++ b/include/linux/ext3_fs.h	Wed Nov  6 22:26:51 2002
@@ -513,10 +513,9 @@
 #define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
 
 #define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
-#define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT2_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT3_FEATURE_INCOMPAT_RECOVER)
+					 EXT3_FEATURE_INCOMPAT_RECOVER| \
+					 EXT3_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
