Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266835AbRGKWay>; Wed, 11 Jul 2001 18:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266834AbRGKWao>; Wed, 11 Jul 2001 18:30:44 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:60151 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266827AbRGKWaf>; Wed, 11 Jul 2001 18:30:35 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112229.f6BMT5ls009821@webber.adilger.int>
Subject: [PATCH] ext2 cleanups
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Jul 2001 16:29:05 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the ext2 code in various places.  It is mostly cosmetic
changes to comments, avoiding lines > 80 columns, removing redundant #ifdef
lines, etc.  It also adds the new COMPAT flags from the current e2fsprogs
into include/linux/ext2_fs.h.

It removes the "not_used_1" field from struct ext2_inode_info, which is
an in-memory only struct, so there is no need to keep this for "compatibility
reasons", unlike unused fields in the on-disk data structs.

It removes the inclusion of <linux/ext2_fs.h> and <linux/minix.h> from
ksyms.c, because these filesystems do not export any symbols, and they
can do it themselves now anyways.

Cheers, Andreas
==========================================================================
diff -ru linux-2.4.6.orig/Documentation/filesystems/ext2.txt linux-2.4.6-aed/Documentation/filesystems/ext2.txt
--- linux-2.4.6.orig/Documentation/filesystems/ext2.txt	Tue May  8 17:15:26 2001
+++ linux-2.4.6-aed/Documentation/filesystems/ext2.txt	Tue May  1 15:42:23 2001
@@ -299,6 +299,8 @@
 so 8kB blocks are only allowed on Alpha systems (and other architectures
 which support larger pages).
 
+There is an upper limit of 32768 subdirectories in a single directory.
+
 There is a "soft" upper limit of about 10-15k files in a single directory
 with the current linear linked-list directory implementation.  This limit
 stems from performance problems when creating and deleting (and also
diff -ru linux-2.4.6.orig/fs/ext2/balloc.c linux-2.4.6-aed/fs/ext2/balloc.c
--- linux-2.4.6.orig/fs/ext2/balloc.c	Fri Dec 29 15:36:44 2000
+++ linux-2.4.6-aed/fs/ext2/balloc.c	Thu Jun  7 01:13:47 2001
@@ -174,7 +174,7 @@
 			sb->u.ext2_sb.s_loaded_block_bitmaps++;
 		else
 			brelse (sb->u.ext2_sb.s_block_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext2_sb.s_loaded_block_bitmaps - 1; j > 0;  j--) {
+		for (j = sb->u.ext2_sb.s_loaded_block_bitmaps - 1; j > 0; j--) {
 			sb->u.ext2_sb.s_block_bitmap_number[j] =
 				sb->u.ext2_sb.s_block_bitmap_number[j - 1];
 			sb->u.ext2_sb.s_block_bitmap[j] =
@@ -276,7 +274,7 @@
 		goto error_return;
 	}
 
-	ext2_debug ("freeing block %lu\n", block);
+	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
 
 do_more:
 	overflow = 0;
@@ -315,8 +313,8 @@
 	for (i = 0; i < count; i++) {
 		if (!ext2_clear_bit (bit + i, bh->b_data))
 			ext2_error (sb, "ext2_free_blocks",
-				      "bit already cleared for block %lu", 
-				      block);
+				      "bit already cleared for block %lu",
+				      block + i);
 		else {
 			DQUOT_FREE_BLOCK(sb, inode, 1);
 			gdp->bg_free_blocks_count =
@@ -411,10 +409,7 @@
 		ext2_debug ("goal is at %d:%d.\n", i, j);
 
 		if (!ext2_test_bit(j, bh->b_data)) {
-#ifdef EXT2FS_DEBUG
-			goal_hits++;
-			ext2_debug ("goal bit allocated.\n");
-#endif
+			ext2_debug("goal bit allocated, %d hits\n",++goal_hits);
 			goto got_block;
 		}
 		if (j) {
@@ -471,10 +466,8 @@
 		if (i >= sb->u.ext2_sb.s_groups_count)
 			i = 0;
 		gdp = ext2_get_group_desc (sb, i, &bh2);
-		if (!gdp) {
-			*err = -EIO;
-			goto out;
-		}
+		if (!gdp)
+			goto io_error;
 		if (le16_to_cpu(gdp->bg_free_blocks_count) > 0)
 			break;
 	}
@@ -766,7 +759,7 @@
 		for (j = 0; j < sb->u.ext2_sb.s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j, sb, bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
-					    "Block #%d of the inode table in "
+					    "Block #%ld of the inode table in "
 					    "group %d is marked free", j, i);
 
 		x = ext2_count_free (bh, sb->s_blocksize);
diff -ru linux-2.4.6.orig/fs/ext2/file.c linux-2.4.6-aed/fs/ext2/file.c
--- linux-2.4.6.orig/fs/ext2/file.c	Wed Sep 27 14:41:33 2000
+++ linux-2.4.6-aed/fs/ext2/file.c	Thu Jun  7 00:01:28 2001
@@ -69,7 +69,7 @@
 
 /*
  * Called when an inode is released. Note that this is different
- * from ext2_file_open: open gets called at every open, but release
+ * from ext2_open_file: open gets called at every open, but release
  * gets called only when /all/ the files are closed.
  */
 static int ext2_release_file (struct inode * inode, struct file * filp)
diff -ru linux-2.4.6.orig/fs/ext2/inode.c linux-2.4.6-aed/fs/ext2/inode.c
--- linux-2.4.6.orig/fs/ext2/inode.c	Thu Jun 28 14:28:24 2001
+++ linux-2.4.6-aed/fs/ext2/inode.c	Thu Jun 28 14:27:24 2001
@@ -99,16 +99,12 @@
 		result = inode->u.ext2_i.i_prealloc_block++;
 		inode->u.ext2_i.i_prealloc_count--;
 		/* Writer: end */
-#ifdef EXT2FS_DEBUG
 		ext2_debug ("preallocation hit (%lu/%lu).\n",
 			    ++alloc_hits, ++alloc_attempts);
-#endif
 	} else {
 		ext2_discard_prealloc (inode);
-#ifdef EXT2FS_DEBUG
 		ext2_debug ("preallocation miss (%lu/%lu).\n",
 			    alloc_hits, ++alloc_attempts);
-#endif
 		if (S_ISREG(inode->i_mode))
 			result = ext2_new_block (inode, goal, 
 				 &inode->u.ext2_i.i_prealloc_count,
@@ -367,7 +364,7 @@
  *	be placed into *branch->p to fill that gap.
  *
  *	If allocation fails we free all blocks we've allocated (and forget
- *	ther buffer_heads) and return the error value the from failed
+ *	their buffer_heads) and return the error value the from failed
  *	ext2_alloc_block() (normally -ENOSPC). Otherwise we set the chain
  *	as described above and return 0.
  */
@@ -603,7 +598,7 @@
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1)/
 		   EXT2_DESC_PER_BLOCK(sb);
 	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
 	if (sb->u.ext2_sb.s_group_desc == NULL) {
diff -ru linux-2.4.6.orig/fs/ext2/super.c linux-2.4.6-aed/fs/ext2/super.c
--- linux-2.4.6.orig/fs/ext2/super.c	Tue May 29 13:13:19 2001
+++ linux-2.4.6-aed/fs/ext2/super.c	Thu Jun 28 15:04:34 2001
@@ -446,8 +446,8 @@
 		return NULL;
 	}
 	/*
-	 * Note: s_es must be initialized s_es as soon as possible because
-	 * some ext2 macro-instructions depend on its value
+	 * Note: s_es must be initialized as soon as possible because
+	 *       some ext2 macro-instructions depend on its value
 	 */
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
 	sb->u.ext2_sb.s_es = es;
@@ -603,7 +603,7 @@
 				        le32_to_cpu(es->s_first_data_block) +
 				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
 				       EXT2_BLOCKS_PER_GROUP(sb);
-	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
+	db_count = (sb->u.ext2_sb.s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1)/
 		   EXT2_DESC_PER_BLOCK(sb);
 	sb->u.ext2_sb.s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
 	if (sb->u.ext2_sb.s_group_desc == NULL) {
diff -ru linux-2.4.6.orig/include/linux/ext2_fs.h linux-2.4.6-aed/include/linux/ext2_fs.h
--- linux-2.4.6.orig/include/linux/ext2_fs.h	Thu Jun 28 14:28:36 2001
+++ linux-2.4.6-aed/include/linux/ext2_fs.h	Thu Jun 28 14:28:09 2001
@@ -53,7 +53,7 @@
 #endif
 
 /*
- * Special inodes numbers
+ * Special inode numbers
  */
 #define	EXT2_BAD_INO		 1	/* Bad blocks inode */
 #define EXT2_ROOT_INO		 2	/* Root inode */
@@ -448,19 +448,31 @@
 	EXT2_SB(sb)->s_es->s_feature_incompat &= ~cpu_to_le32(mask)
 
 #define EXT2_FEATURE_COMPAT_DIR_PREALLOC	0x0001
+#define EXT2_FEATURE_COMPAT_IMAGIC_INODES	0x0002
+#define EXT3_FEATURE_COMPAT_HAS_JOURNAL		0x0004
+#define EXT2_FEATURE_COMPAT_EXT_ATTR		0x0008
+#define EXT2_FEATURE_COMPAT_RESIZE_INO		0x0010
+#define EXT2_FEATURE_COMPAT_DIR_INDEX		0x0020
+#define EXT2_FEATURE_COMPAT_ANY			0xffffffff
 
 #define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT2_FEATURE_RO_COMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
+#define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
+#define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
+#define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
 #define EXT2_FEATURE_INCOMPAT_SUPP	EXT2_FEATURE_INCOMPAT_FILETYPE
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT2_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT2_FEATURE_RO_COMPAT_BTREE_DIR)
+#define EXT2_FEATURE_RO_COMPAT_UNSUPPORTED	~EXT2_FEATURE_RO_COMPAT_SUPP
+#define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
 
 /*
  * Default values for user and/or group using reserved blocks
diff -ru linux-2.4.6.orig/include/linux/ext2_fs_i.h linux-2.4.6-aed/include/linux/ext2_fs_i.h
--- linux-2.4.6.orig/include/linux/ext2_fs_i.h	Tue May 11 15:37:47 1999
+++ linux-2.4.6-aed/include/linux/ext2_fs_i.h	Thu May  3 16:08:29 2001
@@ -29,7 +29,6 @@
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
-	__u32	not_used_1;	/* FIX: not used/ 2.2 placeholder */
 	__u32	i_block_group;
 	__u32	i_next_alloc_block;
 	__u32	i_next_alloc_goal;
diff -ru linux-2.4.6.orig/kernel/ksyms.c linux-2.4.6-aed/kernel/ksyms.c
--- linux-2.4.6.orig/kernel/ksyms.c	Thu Jun 28 14:28:39 2001
+++ linux-2.4.6-aed/kernel/ksyms.c	Thu Jun 28 15:49:44 2001
@@ -23,8 +23,6 @@
 #include <linux/serial.h>
 #include <linux/locks.h>
 #include <linux/delay.h>
-#include <linux/minix_fs.h>
-#include <linux/ext2_fs.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/pagemap.h>
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
