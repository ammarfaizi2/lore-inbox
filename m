Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbSJaIXt>; Thu, 31 Oct 2002 03:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265227AbSJaIWs>; Thu, 31 Oct 2002 03:22:48 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:54243 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S264868AbSJaIWM>;
	Thu, 31 Oct 2002 03:22:12 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 2/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E187Agv-0003bD-00@snap.thunk.org>
Date: Thu, 31 Oct 2002 03:28:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext2/3 forward compatibility: on-line resizing

This patch allows forward compatibility with future filesystems which
are dynamically grown by using an alternate algorithm for storing the
block group descriptors.  It's also a bit more efficient, in that it
uses just a little bit less disk space.  Currently, the ext2 filesystem
format requires either relocating the inode table, or reserving space in
before doing the on-line resize.  The new scheme, which is documented in
"Planned Extensions to the Ext2/3 Filesystem", by Stephen Tweedie and I 
(see: http://e2fsprogs.sourceforge.net/extensions-ext23)

 fs/ext2/super.c         |   22 ++++++++++++++++++++--
 fs/ext3/super.c         |   22 ++++++++++++++++++++--
 include/linux/ext2_fs.h |    7 +++++--
 include/linux/ext3_fs.h |    6 +++++-
 4 files changed, 50 insertions(+), 7 deletions(-)

diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Oct 31 02:38:59 2002
+++ b/fs/ext2/super.c	Thu Oct 31 02:38:59 2002
@@ -476,12 +476,29 @@
 	return res;
 }
 
+static unsigned long descriptor_loc(struct super_block *sb,
+				    unsigned long logic_sb_block,
+				    int nr)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	unsigned long bg, first_data_block, first_meta_bg;
+	
+	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
+
+	if (!EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_META_BG) ||
+	    nr < first_meta_bg)
+		return (logic_sb_block + nr + 1);
+	bg = sbi->s_desc_per_block * nr;
+	return (first_data_block + 1 + (bg * sbi->s_blocks_per_group));
+}
+
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct buffer_head * bh;
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
-	unsigned long sb_block = 1;
+	unsigned long block, sb_block = 1;
 	unsigned long logic_sb_block = get_sb_block(&data);
 	unsigned long offset = 0;
 	unsigned long def_mount_opts;
@@ -689,7 +706,8 @@
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sbi->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
+		block = descriptor_loc(sb, logic_sb_block, i);
+		sbi->s_group_desc[i] = sb_bread(sb, block);
 		if (!sbi->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
 				brelse (sbi->s_group_desc[j]);
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Thu Oct 31 02:38:59 2002
+++ b/fs/ext3/super.c	Thu Oct 31 02:38:59 2002
@@ -929,6 +929,23 @@
 	return res;
 }
 
+static unsigned long descriptor_loc(struct super_block *sb,
+				    unsigned long logic_sb_block,
+				    int nr)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	unsigned long bg, first_data_block, first_meta_bg;
+	
+	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
+
+	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_META_BG) ||
+	    nr < first_meta_bg)
+		return (logic_sb_block + nr + 1);
+	bg = sbi->s_desc_per_block * nr;
+	return (first_data_block + 1 + (bg * sbi->s_blocks_per_group));
+}
+
 
 static int ext3_fill_super (struct super_block *sb, void *data, int silent)
 {
@@ -936,7 +953,7 @@
 	struct ext3_super_block *es = 0;
 	struct ext3_sb_info *sbi;
 	unsigned long sb_block = get_sb_block(&data);
-	unsigned long logic_sb_block = 1;
+	unsigned long block, logic_sb_block = 1;
 	unsigned long offset = 0;
 	unsigned long journal_inum = 0;
 	unsigned long def_mount_opts;
@@ -1154,7 +1171,8 @@
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sbi->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
+		block = descriptor_loc(sb, logic_sb_block, i);
+		sbi->s_group_desc[i] = sb_bread(sb, block);
 		if (!sbi->s_group_desc[i]) {
 			printk (KERN_ERR "EXT3-fs: "
 				"can't read group descriptor %d\n", i);
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Thu Oct 31 02:38:59 2002
+++ b/include/linux/ext2_fs.h	Thu Oct 31 02:38:59 2002
@@ -422,7 +422,8 @@
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
 	__u32	s_default_mount_opts;
-	__u32	s_reserved[191];	/* Padding to the end of the block */
+ 	__u32	s_first_meta_bg; 	/* First metablock block group */
+	__u32	s_reserved[190];	/* Padding to the end of the block */
 };
 
 /*
@@ -485,10 +486,12 @@
 #define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
+#define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
-#define EXT2_FEATURE_INCOMPAT_SUPP	EXT2_FEATURE_INCOMPAT_FILETYPE
+#define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
+					 EXT2_FEATURE_INCOMPAT_META_BG)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Thu Oct 31 02:38:59 2002
+++ b/include/linux/ext3_fs.h	Thu Oct 31 02:38:59 2002
@@ -450,7 +450,8 @@
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
 	__u32	s_default_mount_opts;
-	__u32	s_reserved[191];	/* Padding to the end of the block */
+	__u32	s_first_meta_bg; 	/* First metablock block group */
+	__u32	s_reserved[190];	/* Padding to the end of the block */
 };
 
 #ifdef __KERNEL__
@@ -529,8 +530,11 @@
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
+#define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
 
 #define EXT3_FEATURE_COMPAT_SUPP	0
+#define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
+					 EXT2_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
