Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbUAAWHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUAAV7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:59:38 -0500
Received: from thunk.org ([140.239.227.29]:64418 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265423AbUAAVv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:51:26 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 3/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAic-0000LX-Rl@thunk.org>
Date: Thu, 01 Jan 2004 16:51:02 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1358  -> 1.1359 
#	include/linux/ext3_fs.h	1.7     -> 1.8    
#	include/linux/ext2_fs.h	1.7     -> 1.8    
#	     fs/ext2/super.c	1.9     -> 1.10   
#	     fs/ext3/super.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	tytso@think.thunk.org	1.1359
# Apply 4105-tytso-resize-compat-6.patch
# 
# Ext2/3 forward compatibility: on-line resizing
# 
# This patch allows forward compatibility with future filesystems which
# are dynamically grown by using an alternate algorithm for storing the
# block group descriptors.  It's also a bit more efficient, in that it
# uses just a little bit less disk space.  Currently, the ext2 filesystem
# format requires either relocating the inode table, or reserving space in
# before doing the on-line resize.  The new scheme, which is documented in
# "Planned Extensions to the Ext2/3 Filesystem", by Stephen Tweedie and I
# (see: http://e2fsprogs.sourceforge.net/extensions-ext23)
# --------------------------------------------
#
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Jan  1 16:29:17 2004
+++ b/fs/ext2/super.c	Thu Jan  1 16:29:17 2004
@@ -397,14 +397,36 @@
 	return res;
 }
 
+static unsigned long descriptor_loc(struct super_block *sb,
+				    unsigned long logic_sb_block,
+				    int nr)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	unsigned long bg, first_data_block, first_meta_bg;
+	int has_super = 0;
+	
+	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
+
+	if (!EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_META_BG) ||
+	    nr < first_meta_bg)
+		return (logic_sb_block + nr + 1);
+	bg = sbi->s_desc_per_block * nr;
+	if (ext2_bg_has_super(sb, bg))
+		has_super = 1;
+	return (first_data_block + has_super + (bg * sbi->s_blocks_per_group));
+}
+
 struct super_block * ext2_read_super (struct super_block * sb, void * data,
 				      int silent)
 {
 	struct buffer_head * bh;
+  	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
 	unsigned long sb_block = 1;
 	unsigned short resuid = EXT2_DEF_RESUID;
 	unsigned short resgid = EXT2_DEF_RESGID;
+	unsigned long block;
 	unsigned long logic_sb_block = 1;
 	unsigned long offset = 0;
 	kdev_t dev = sb->s_dev;
@@ -611,11 +633,12 @@
 		goto failed_mount;
 	}
 	for (i = 0; i < db_count; i++) {
-		sb->u.ext2_sb.s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
-		if (!sb->u.ext2_sb.s_group_desc[i]) {
+		block = descriptor_loc(sb, logic_sb_block, i);
+		sbi->s_group_desc[i] = sb_bread(sb, block);
+		if (!sbi->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sb->u.ext2_sb.s_group_desc[j]);
-			kfree(sb->u.ext2_sb.s_group_desc);
+				brelse (sbi->s_group_desc[j]);
+			kfree(sbi->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
 			goto failed_mount;
 		}
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Thu Jan  1 16:29:17 2004
+++ b/fs/ext3/super.c	Thu Jan  1 16:29:17 2004
@@ -794,6 +794,26 @@
 	return 1;
 }
 
+static unsigned long descriptor_loc(struct super_block *sb,
+				    unsigned long logic_sb_block,
+				    int nr)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	unsigned long bg, first_data_block, first_meta_bg;
+	int has_super = 0;
+	
+	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
+
+	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_META_BG) ||
+	    nr < first_meta_bg)
+		return (logic_sb_block + nr + 1);
+	bg = sbi->s_desc_per_block * nr;
+	if (ext3_bg_has_super(sb, bg))
+		has_super = 1;
+	return (first_data_block + has_super + (bg * sbi->s_blocks_per_group));
+}
+
 
 /* ext3_orphan_cleanup() walks a singly-linked list of inodes (starting at
  * the superblock) which were deleted from all directories, but held open by
@@ -901,6 +921,7 @@
 	struct buffer_head * bh;
 	struct ext3_super_block *es = 0;
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	unsigned long block;
 	unsigned long sb_block = 1;
 	unsigned long logic_sb_block = 1;
 	unsigned long offset = 0;
@@ -1104,7 +1125,8 @@
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
--- a/include/linux/ext2_fs.h	Thu Jan  1 16:29:17 2004
+++ b/include/linux/ext2_fs.h	Thu Jan  1 16:29:17 2004
@@ -392,7 +392,20 @@
 	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
 	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
 	__u16	s_padding1;
-	__u32	s_reserved[204];	/* Padding to the end of the block */
+	/*
+	 * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
+	 */
+	__u8	s_journal_uuid[16];	/* uuid of journal superblock */
+	__u32	s_journal_inum;		/* inode number of journal file */
+	__u32	s_journal_dev;		/* device number of journal file */
+	__u32	s_last_orphan;		/* start of list of inodes to delete */
+	__u32	s_hash_seed[4];		/* HTREE hash seed */
+	__u8	s_def_hash_version;	/* Default hash version to use */
+	__u8	s_reserved_char_pad;
+	__u16	s_reserved_word_pad;
+	__u32	s_default_mount_opts;
+ 	__u32	s_first_meta_bg; 	/* First metablock block group */
+	__u32	s_reserved[190];	/* Padding to the end of the block */
 };
 
 #ifdef __KERNEL__
@@ -464,10 +477,12 @@
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
@@ -475,10 +490,21 @@
 #define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
 
 /*
- * Default values for user and/or group using reserved blocks
+ * Default mount options
  */
-#define	EXT2_DEF_RESUID		0
-#define	EXT2_DEF_RESGID		0
+#define EXT2_DEFM_DEBUG		0x0001
+#define EXT2_DEFM_BSDGROUPS	0x0002
+#define EXT2_DEFM_XATTR_USER	0x0004
+#define EXT2_DEFM_ACL		0x0008
+#define EXT2_DEFM_UID16		0x0010
+    /* Not used by ext2, but reserved for use by ext3 */
+#define EXT3_DEFM_JMODE		0x0060 
+#define EXT3_DEFM_JMODE_DATA	0x0020
+#define EXT3_DEFM_JMODE_ORDERED	0x0040
+#define EXT3_DEFM_JMODE_WBACK	0x0060
+
+#define        EXT2_DEF_RESUID         0
+#define        EXT2_DEF_RESGID         0
 
 /*
  * Structure of a directory entry
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Thu Jan  1 16:29:17 2004
+++ b/include/linux/ext3_fs.h	Thu Jan  1 16:29:17 2004
@@ -438,8 +438,13 @@
 /*E0*/	__u32	s_journal_inum;		/* inode number of journal file */
 	__u32	s_journal_dev;		/* device number of journal file */
 	__u32	s_last_orphan;		/* start of list of inodes to delete */
-
-/*EC*/	__u32	s_reserved[197];	/* Padding to the end of the block */
+	__u32	s_hash_seed[4];		/* HTREE hash seed */
+	__u8	s_def_hash_version;	/* Default hash version to use */
+	__u8	s_reserved_char_pad;
+	__u16	s_reserved_word_pad;
+	__u32	s_default_mount_opts;
+	__u32	s_first_meta_bg; 	/* First metablock block group */
+	__u32	s_reserved[190];	/* Padding to the end of the block */
 };
 
 #ifdef __KERNEL__
@@ -512,19 +517,31 @@
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
+#define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
 
 #define EXT3_FEATURE_COMPAT_SUPP	0
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
-					 EXT3_FEATURE_INCOMPAT_RECOVER)
+					 EXT3_FEATURE_INCOMPAT_RECOVER| \
+					 EXT3_FEATURE_INCOMPAT_META_BG)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
 
 /*
- * Default values for user and/or group using reserved blocks
+ * Default mount options
  */
-#define	EXT3_DEF_RESUID		0
-#define	EXT3_DEF_RESGID		0
+#define EXT3_DEFM_DEBUG		0x0001
+#define EXT3_DEFM_BSDGROUPS	0x0002
+#define EXT3_DEFM_XATTR_USER	0x0004
+#define EXT3_DEFM_ACL		0x0008
+#define EXT3_DEFM_UID16		0x0010
+#define EXT3_DEFM_JMODE		0x0060
+#define EXT3_DEFM_JMODE_DATA	0x0020
+#define EXT3_DEFM_JMODE_ORDERED	0x0040
+#define EXT3_DEFM_JMODE_WBACK	0x0060
+
+#define        EXT3_DEF_RESUID         0
+#define        EXT3_DEF_RESGID         0
 
 /*
  * Structure of a directory entry
