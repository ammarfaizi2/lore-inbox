Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSKZMys>; Tue, 26 Nov 2002 07:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSKZMys>; Tue, 26 Nov 2002 07:54:48 -0500
Received: from [211.167.76.68] ([211.167.76.68]:32156 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S264936AbSKZMyl>;
	Tue, 26 Nov 2002 07:54:41 -0500
Date: Tue, 26 Nov 2002 21:00:50 +0800
From: hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: orlov-allocator.patch-2.4.19
Message-Id: <20021126210050.05edaf3f.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.5claws126 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

backport orlov-alloctor ext3 to 2.4.19. works in my 2.4.19.
--
Index: fs/ext3/ialloc.c
===================================================================
RCS file: /home/hugang/local/cvs/2.4.X/fs/ext3/ialloc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ialloc.c
--- fs/ext3/ialloc.c	17 Nov 2002 05:27:45 -0000	1.1.1.1
+++ fs/ext3/ialloc.c	22 Nov 2002 13:48:37 -0000
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
+#include <linux/random.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
@@ -262,9 +263,11 @@
 		if (gdp) {
 			gdp->bg_free_inodes_count = cpu_to_le16(
 				le16_to_cpu(gdp->bg_free_inodes_count) + 1);
-			if (is_directory)
+			if (is_directory) {
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
+				EXT3_SB(sb)->s_dir_count--;
+			}
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, bh2);
@@ -293,20 +296,228 @@
  * the groups with above-average free space, that group with the fewest
  * directories already is chosen.
  *
+ * For other inodes, search forward from the parent directory\'s block
+ * group to find a free inode.
+ */
+static int find_group_dir(struct super_block *sb, struct inode *parent)
+{
+   struct ext3_super_block * es = EXT3_SB(sb)->s_es;
+   int ngroups = EXT3_SB(sb)->s_groups_count;
+   int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+   struct ext3_group_desc *desc, *best_desc = NULL;
+   struct buffer_head *bh, *best_bh = NULL;
+   int group, best_group = -1;
+
+   for (group = 0; group < ngroups; group++) {
+       desc = ext3_get_group_desc (sb, group, &bh);
+       if (!desc || !desc->bg_free_inodes_count)
+           continue;
+       if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
+           continue;
+       if (!best_desc || 
+           (le16_to_cpu(desc->bg_free_blocks_count) >
+            le16_to_cpu(best_desc->bg_free_blocks_count))) {
+           best_group = group;
+           best_desc = desc;
+           best_bh = bh;
+       }
+   }
+   if (!best_desc)
+       return -1;
+   return best_group;
+}
+
+/* 
+ * Orlov's allocator for directories.
+ * 
+ * We always try to spread first-level directories.
+ * 
+ * If there are blockgroups with both free inodes and free blocks counts
+ * not worse than average we return one with smallest directory count.
+ * Otherwise we simply return a random group.
+ * 
+ * For the rest rules look so:
+ * 
+ * It's OK to put directory into a group unless 
+ * it has too many directories already (max_dirs) or
+ * it has too few free inodes left (min_inodes) or
+ * it has too few free blocks left (min_blocks) or
+ * it's already running too large debt (max_debt).
+ * Parent's group is prefered, if it doesn't satisfy these
+ * conditions we search cyclically through the rest. If none
+ * of the groups look good we just look for a group with more
+ * free inodes than average (starting at parent's group).
+ *
+ * Debt is incremented each time we allocate a directory and decremented
+ * when we allocate an inode, within 0--255.
+ */
+
+#define INODE_COST 64
+#define BLOCK_COST 256
+
+static int find_group_orlov(struct super_block *sb, const struct inode *parent)
+{
+   int parent_group = EXT3_I(parent)->i_block_group;
+   struct ext3_sb_info *sbi = EXT3_SB(sb);
+   struct ext3_super_block *es = sbi->s_es;
+   int ngroups = sbi->s_groups_count;
+   int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
+   int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+   int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+   int blocks_per_dir;
+   int ndirs = sbi->s_dir_count;
+   int max_debt, max_dirs, min_blocks, min_inodes;
+   int group = -1, i;
+   struct ext3_group_desc *desc;
+   struct buffer_head *bh;
+
+   if ((parent == sb->s_root->d_inode) ||
+       (parent->i_flags & EXT3_TOPDIR_FL)) {
+       struct ext3_group_desc *best_desc = NULL;
+       struct buffer_head *best_bh = NULL;
+       int best_ndir = inodes_per_group;
+       int best_group = -1;
+
+       get_random_bytes(&group, sizeof(group));
+       parent_group = (unsigned)group % ngroups;
+       for (i = 0; i < ngroups; i++) {
+           group = (parent_group + i) % ngroups;
+           desc = ext3_get_group_desc (sb, group, &bh);
+           if (!desc || !desc->bg_free_inodes_count)
+               continue;
+           if (le16_to_cpu(desc->bg_used_dirs_count) >= best_ndir)
+               continue;
+           if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
+               continue;
+           if (le16_to_cpu(desc->bg_free_blocks_count) < avefreeb)
+               continue;
+           best_group = group;
+           best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
+           best_desc = desc;
+           best_bh = bh;
+       }
+       if (best_group >= 0) {
+           desc = best_desc;
+           bh = best_bh;
+           group = best_group;
+           goto found;
+       }
+       goto fallback;
+   }
+
+   blocks_per_dir = (le32_to_cpu(es->s_blocks_count) -
+             le32_to_cpu(es->s_free_blocks_count)) / ndirs;
+
+   max_dirs = ndirs / ngroups + inodes_per_group / 16;
+   min_inodes = avefreei - inodes_per_group / 4;
+   min_blocks = avefreeb - EXT3_BLOCKS_PER_GROUP(sb) / 4;
+
+   max_debt = EXT3_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
+   if (max_debt * INODE_COST > inodes_per_group)
+       max_debt = inodes_per_group / INODE_COST;
+   if (max_debt > 255)
+       max_debt = 255;
+   if (max_debt == 0)
+       max_debt = 1;
+
+   for (i = 0; i < ngroups; i++) {
+       group = (parent_group + i) % ngroups;
+       desc = ext3_get_group_desc (sb, group, &bh);
+       if (!desc || !desc->bg_free_inodes_count)
+           continue;
+       if (sbi->s_debts[group] >= max_debt)
+           continue;
+       if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
+           continue;
+       if (le16_to_cpu(desc->bg_free_inodes_count) < min_inodes)
+           continue;
+       if (le16_to_cpu(desc->bg_free_blocks_count) < min_blocks)
+           continue;
+       goto found;
+   }
+
+fallback:
+   for (i = 0; i < ngroups; i++) {
+       group = (parent_group + i) % ngroups;
+       desc = ext3_get_group_desc (sb, group, &bh);
+       if (!desc || !desc->bg_free_inodes_count)
+           continue;
+       if (le16_to_cpu(desc->bg_free_inodes_count) >= avefreei)
+           goto found;
+   }
+
+   return -1;
+found:
+   return group;
+}
+
+static int find_group_other(struct super_block *sb, struct inode *parent)
+{
+   int parent_group = EXT3_I(parent)->i_block_group;
+   int ngroups = EXT3_SB(sb)->s_groups_count;
+   struct ext3_group_desc *desc;
+   struct buffer_head *bh;
+   int group, i;
+
+   /*
+    * Try to place the inode in its parent directory
+    */
+   group = parent_group;
+   desc = ext3_get_group_desc (sb, group, &bh);
+   if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+       goto found;
+
+   /*
+    * Use a quadratic hash to find a group with a
+    * free inode
+    */
+   for (i = 1; i < ngroups; i <<= 1) {
+       group += i;
+       if (group >= ngroups)
+           group -= ngroups;
+       desc = ext3_get_group_desc (sb, group, &bh);
+       if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+           goto found;
+   }
+
+   /*
+    * That failed: try linear search for a free inode
+    */
+   group = parent_group + 1;
+   for (i = 2; i < ngroups; i++) {
+       if (++group >= ngroups)
+           group = 0;
+       desc = ext3_get_group_desc (sb, group, &bh);
+       if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+           goto found;
+   }
+
+   return -1;
+
+found:
+   return group;
+}
+
+/*
+ * There are two policies for allocating an inode.  If the new inode is
+ * a directory, then a forward search is made for a block group with both
+ * free space and a low directory-to-inode ratio; if that fails, then of
+ * the groups with above-average free space, that group with the fewest
+ * directories already is chosen.
+ *
  * For other inodes, search forward from the parent directory's block
  * group to find a free inode.
  */
-struct inode * ext3_new_inode (handle_t *handle,
-				const struct inode * dir, int mode)
+struct inode * ext3_new_inode (handle_t *handle, struct inode * dir, int mode)
 {
 	struct super_block * sb;
 	struct buffer_head * bh;
 	struct buffer_head * bh2;
-	int i, j, avefreei;
-	struct inode * inode;
+	int group;
+	ino_t ino;
 	int bitmap_nr;
+	struct inode * inode;
 	struct ext3_group_desc * gdp;
-	struct ext3_group_desc * tmp;
 	struct ext3_super_block * es;
 	int err = 0;
 
@@ -323,94 +534,36 @@
 	lock_super (sb);
 	es = sb->u.ext3_sb.s_es;
 repeat:
-	gdp = NULL;
-	i = 0;
-
 	if (S_ISDIR(mode)) {
-		avefreei = le32_to_cpu(es->s_free_inodes_count) /
-			sb->u.ext3_sb.s_groups_count;
-		if (!gdp) {
-			for (j = 0; j < sb->u.ext3_sb.s_groups_count; j++) {
-				struct buffer_head *temp_buffer;
-				tmp = ext3_get_group_desc (sb, j, &temp_buffer);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count) &&
-				    le16_to_cpu(tmp->bg_free_inodes_count) >=
-							avefreei) {
-					if (!gdp || (le16_to_cpu(tmp->bg_free_blocks_count) >
-						le16_to_cpu(gdp->bg_free_blocks_count))) {
-						i = j;
-						gdp = tmp;
-						bh2 = temp_buffer;
-					}
-				}
-			}
-		}
-	} else {
-		/*
-		 * Try to place the inode in its parent directory
-		 */
-		i = dir->u.ext3_i.i_block_group;
-		tmp = ext3_get_group_desc (sb, i, &bh2);
-		if (tmp && le16_to_cpu(tmp->bg_free_inodes_count))
-			gdp = tmp;
+		if (test_opt (sb, OLDALLOC))
+			group = find_group_dir(sb, dir);
 		else
-		{
-			/*
-			 * Use a quadratic hash to find a group with a
-			 * free inode
-			 */
-			for (j = 1; j < sb->u.ext3_sb.s_groups_count; j <<= 1) {
-				i += j;
-				if (i >= sb->u.ext3_sb.s_groups_count)
-					i -= sb->u.ext3_sb.s_groups_count;
-				tmp = ext3_get_group_desc (sb, i, &bh2);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count)) {
-					gdp = tmp;
-					break;
-				}
-			}
-		}
-		if (!gdp) {
-			/*
-			 * That failed: try linear search for a free inode
-			 */
-			i = dir->u.ext3_i.i_block_group + 1;
-			for (j = 2; j < sb->u.ext3_sb.s_groups_count; j++) {
-				if (++i >= sb->u.ext3_sb.s_groups_count)
-					i = 0;
-				tmp = ext3_get_group_desc (sb, i, &bh2);
-				if (tmp &&
-				    le16_to_cpu(tmp->bg_free_inodes_count)) {
-					gdp = tmp;
-					break;
-				}
-			}
-		}
-	}
+			group = find_group_orlov(sb, dir);
+	} else 
+		group = find_group_other(sb, dir);
 
 	err = -ENOSPC;
-	if (!gdp)
+	if (gdp == -1)
 		goto fail;
 
 	err = -EIO;
-	bitmap_nr = load_inode_bitmap (sb, i);
+	bitmap_nr = load_inode_bitmap (sb, group);
 	if (bitmap_nr < 0)
 		goto fail;
 
+	gdp = ext3_get_group_desc (sb, group, &bh2);
 	bh = sb->u.ext3_sb.s_inode_bitmap[bitmap_nr];
 
-	if ((j = ext3_find_first_zero_bit ((unsigned long *) bh->b_data,
+	if ((ino = ext3_find_first_zero_bit ((unsigned long *) bh->b_data,
 				      EXT3_INODES_PER_GROUP(sb))) <
 	    EXT3_INODES_PER_GROUP(sb)) {
 		BUFFER_TRACE(bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, bh);
 		if (err) goto fail;
 		
-		if (ext3_set_bit (j, bh->b_data)) {
+		if (ext3_set_bit (ino, bh->b_data)) {
 			ext3_error (sb, "ext3_new_inode",
-				      "bit already set for inode %d", j);
+				      "bit already set for inode %lu", ino);
 			goto repeat;
 		}
 		BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
@@ -420,7 +573,7 @@
 		if (le16_to_cpu(gdp->bg_free_inodes_count) != 0) {
 			ext3_error (sb, "ext3_new_inode",
 				    "Free inodes count corrupted in group %d",
-				    i);
+				    group);
 			/* Is it really ENOSPC? */
 			err = -ENOSPC;
 			if (sb->s_flags & MS_RDONLY)
@@ -436,11 +589,11 @@
 		}
 		goto repeat;
 	}
-	j += i * EXT3_INODES_PER_GROUP(sb) + 1;
-	if (j < EXT3_FIRST_INO(sb) || j > le32_to_cpu(es->s_inodes_count)) {
+		ino += group * EXT3_INODES_PER_GROUP(sb) + 1;
+		if (ino < EXT3_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
 		ext3_error (sb, "ext3_new_inode",
 			    "reserved inode or inode > inodes count - "
-			    "block_group = %d,inode=%d", i, j);
+			    "block_group = %d,inode=%lu", group, ino);
 		err = -EIO;
 		goto fail;
 	}
@@ -450,9 +603,11 @@
 	if (err) goto fail;
 	gdp->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
-	if (S_ISDIR(mode))
+	if (S_ISDIR(mode)) {
 		gdp->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
+		sb->u.ext3_sb.s_dir_count++;
+	}
 	BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
@@ -478,7 +633,7 @@
 		inode->i_gid = current->fsgid;
 	inode->i_mode = mode;
 
-	inode->i_ino = j;
+	inode->i_ino = ino;
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
@@ -498,7 +653,7 @@
 #ifdef EXT3_PREALLOCATE
 	inode->u.ext3_i.i_prealloc_count = 0;
 #endif
-	inode->u.ext3_i.i_block_group = i;
+	inode->u.ext3_i.i_block_group = group;
 	
 	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -619,6 +774,21 @@
 #else
 	return le32_to_cpu(sb->u.ext3_sb.s_es->s_free_inodes_count);
 #endif
+}
+
+/* Called at mount-time, super-block is locked */
+unsigned long ext3_count_dirs (struct super_block * sb)
+{
+   unsigned long count = 0;
+   int i;
+
+   for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
+       struct ext3_group_desc *gdp = ext3_get_group_desc (sb, i, NULL);
+       if (!gdp)
+           continue;
+       count += le16_to_cpu(gdp->bg_used_dirs_count);
+   }
+   return count;
 }
 
 #ifdef CONFIG_EXT3_CHECK
Index: fs/ext3/super.c
===================================================================
RCS file: /home/hugang/local/cvs/2.4.X/fs/ext3/super.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 super.c
--- fs/ext3/super.c	17 Nov 2002 05:27:45 -0000	1.1.1.1
+++ fs/ext3/super.c	22 Nov 2002 13:22:13 -0000
@@ -416,6 +416,7 @@
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
+	kfree(sbi->s_debts);
 	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++)
 		brelse(sbi->s_inode_bitmap[i]);
 	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++)
@@ -1094,6 +1095,13 @@
 		printk (KERN_ERR "EXT3-fs: not enough memory\n");
 		goto failed_mount;
 	}
+	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+			GFP_KERNEL);
+	if (!sbi->s_debts) {
+		printk ("EXT3-fs: not enough memory\n");
+		goto failed_mount2;
+	}
+	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
 	for (i = 0; i < db_count; i++) {
 		sbi->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
 		if (!sbi->s_group_desc[i]) {
@@ -1116,6 +1124,7 @@
 	sbi->s_loaded_inode_bitmaps = 0;
 	sbi->s_loaded_block_bitmaps = 0;
 	sbi->s_gdb_count = db_count;
+	sbi->s_dir_count = ext3_count_dirs(sb);
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	/*
 	 * set up enough so that it can read an inode
@@ -1219,6 +1228,8 @@
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
+	if (sbi->s_debts)
+		kfree(sbi->s_debts);
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
Index: include/linux/ext3_fs.h
===================================================================
RCS file: /home/hugang/local/cvs/2.4.X/include/linux/ext3_fs.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ext3_fs.h
--- include/linux/ext3_fs.h	17 Nov 2002 05:27:45 -0000	1.1.1.1
+++ include/linux/ext3_fs.h	22 Nov 2002 12:06:26 -0000
@@ -203,11 +203,11 @@
 #define EXT3_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define EXT3_IMAGIC_FL			0x00002000 /* AFS directory */
 #define EXT3_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
+#define EXT3_TOPDIR_FL         0x00020000 /* Top of directory hierarchies*/
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
-#define EXT3_FL_USER_VISIBLE		0x00005FFF /* User visible flags */
-#define EXT3_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
-
+#define EXT3_FL_USER_VISIBLE       0x0003DFFF /* User visible flags */
+#define EXT3_FL_USER_MODIFIABLE        0x000380FF /* User modifiable flags */
 /*
  * Inode dynamic state flags
  */
@@ -325,6 +325,7 @@
  * Mount flags
  */
 #define EXT3_MOUNT_CHECK		0x0001	/* Do mount-time checks */
+#define EXT3_MOUNT_OLDALLOC        0x0002  /* Don't use the new Orlov allocator */
 #define EXT3_MOUNT_GRPID		0x0004	/* Create files with directory's group */
 #define EXT3_MOUNT_DEBUG		0x0008	/* Some debugging messages */
 #define EXT3_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
@@ -607,6 +608,7 @@
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern unsigned long ext3_count_free_blocks (struct super_block *);
+extern unsigned long ext3_count_dirs (struct super_block *);
 extern void ext3_check_blocks_bitmap (struct super_block *);
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
@@ -620,7 +622,7 @@
 extern int ext3_sync_file (struct file *, struct dentry *, int);
 
 /* ialloc.c */
-extern struct inode * ext3_new_inode (handle_t *, const struct inode *, int);
+extern struct inode * ext3_new_inode (handle_t *, struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
 extern struct inode * ext3_orphan_get (struct super_block *, ino_t);
 extern unsigned long ext3_count_free_inodes (struct super_block *);
Index: include/linux/ext3_fs_sb.h
===================================================================
RCS file: /home/hugang/local/cvs/2.4.X/include/linux/ext3_fs_sb.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ext3_fs_sb.h
--- include/linux/ext3_fs_sb.h	17 Nov 2002 05:27:45 -0000	1.1.1.1
+++ include/linux/ext3_fs_sb.h	22 Nov 2002 12:06:26 -0000
@@ -62,6 +62,8 @@
 	int s_inode_size;
 	int s_first_ino;
 	u32 s_next_generation;
+	unsigned long s_dir_count;
+	u8 *s_debts;
 
 	/* Journaling */
 	struct inode * s_journal_inode;


-- 
		- Hu Gang
