Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265884AbSKBGgZ>; Sat, 2 Nov 2002 01:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKBGgY>; Sat, 2 Nov 2002 01:36:24 -0500
Received: from thunk.org ([140.239.227.29]:21147 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265884AbSKBGgF>;
	Sat, 2 Nov 2002 01:36:05 -0500
Date: Sat, 2 Nov 2002 01:42:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Orlov block allocator for ext3
Message-ID: <20021102064222.GB15874@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <3DC1C852.E8DB711E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1C852.E8DB711E@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 04:18:26PM -0800, Andrew Morton wrote:
> This is Al's implementation of the Orlov block allocator for ext2.
> 
> At least doubles the throughput for the traverse-a-kernel-tree
> test and is well tested.
> 
> I still need to do the ext3 version.

Here's the ext3 version.   :-)

						- Ted

fs/ext3/ialloc.c           |  336 ++++++++++++++++++++++++++++++++++-----------
fs/ext3/super.c            |   11 +
include/linux/ext3_fs.h    |    7 
include/linux/ext3_fs_sb.h |    2 
4 files changed, 277 insertions(+), 79 deletions(-)

diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Sat Nov  2 01:32:18 2002
+++ b/fs/ext3/ialloc.c	Sat Nov  2 01:32:18 2002
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
+#include <linux/random.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
@@ -198,6 +199,230 @@
  * the groups with above-average free space, that group with the fewest
  * directories already is chosen.
  *
+ * For other inodes, search forward from the parent directory\'s block
+ * group to find a free inode.
+ */
+static int find_group_dir(struct super_block *sb, struct inode *parent)
+{
+	struct ext3_super_block * es = EXT3_SB(sb)->s_es;
+	int ngroups = EXT3_SB(sb)->s_groups_count;
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	struct ext3_group_desc *desc, *best_desc = NULL;
+	struct buffer_head *bh, *best_bh = NULL;
+	int group, best_group = -1;
+
+	for (group = 0; group < ngroups; group++) {
+		desc = ext3_get_group_desc (sb, group, &bh);
+		if (!desc || !desc->bg_free_inodes_count)
+			continue;
+		if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
+			continue;
+		if (!best_desc || 
+		    (le16_to_cpu(desc->bg_free_blocks_count) >
+		     le16_to_cpu(best_desc->bg_free_blocks_count))) {
+			best_group = group;
+			best_desc = desc;
+			best_bh = bh;
+		}
+	}
+	if (!best_desc)
+		return -1;
+	best_desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
+	best_desc->bg_used_dirs_count =
+		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
+	mark_buffer_dirty(best_bh);
+	return best_group;
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
+static int find_group_orlov(struct super_block *sb, struct inode *parent)
+{
+	int parent_group = EXT3_I(parent)->i_block_group;
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	struct ext3_super_block *es = sbi->s_es;
+	int ngroups = sbi->s_groups_count;
+	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int blocks_per_dir;
+	int ndirs = sbi->s_dir_count;
+	int max_debt, max_dirs, min_blocks, min_inodes;
+	int group = -1, i;
+	struct ext3_group_desc *desc;
+	struct buffer_head *bh;
+
+	if ((parent == sb->s_root->d_inode) ||
+	    (parent->i_flags & EXT3_TOPDIR_FL)) {
+		struct ext3_group_desc *best_desc = NULL;
+		struct buffer_head *best_bh = NULL;
+		int best_ndir = inodes_per_group;
+		int best_group = -1;
+
+		get_random_bytes(&group, sizeof(group));
+		parent_group = (unsigned)group % ngroups;
+		for (i = 0; i < ngroups; i++) {
+			group = (parent_group + i) % ngroups;
+			desc = ext3_get_group_desc (sb, group, &bh);
+			if (!desc || !desc->bg_free_inodes_count)
+				continue;
+			if (le16_to_cpu(desc->bg_used_dirs_count) >= best_ndir)
+				continue;
+			if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
+				continue;
+			if (le16_to_cpu(desc->bg_free_blocks_count) < avefreeb)
+				continue;
+			best_group = group;
+			best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
+			best_desc = desc;
+			best_bh = bh;
+		}
+		if (best_group >= 0) {
+			desc = best_desc;
+			bh = best_bh;
+			group = best_group;
+			goto found;
+		}
+		goto fallback;
+	}
+
+	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) -
+			  le32_to_cpu(es->s_free_blocks_count)) / ndirs;
+
+	max_dirs = ndirs / ngroups + inodes_per_group / 16;
+	min_inodes = avefreei - inodes_per_group / 4;
+	min_blocks = avefreeb - EXT3_BLOCKS_PER_GROUP(sb) / 4;
+
+	max_debt = EXT3_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
+	if (max_debt * INODE_COST > inodes_per_group)
+		max_debt = inodes_per_group / INODE_COST;
+	if (max_debt > 255)
+		max_debt = 255;
+	if (max_debt == 0)
+		max_debt = 1;
+
+	for (i = 0; i < ngroups; i++) {
+		group = (parent_group + i) % ngroups;
+		desc = ext3_get_group_desc (sb, group, &bh);
+		if (!desc || !desc->bg_free_inodes_count)
+			continue;
+		if (sbi->s_debts[group] >= max_debt)
+			continue;
+		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
+			continue;
+		if (le16_to_cpu(desc->bg_free_inodes_count) < min_inodes)
+			continue;
+		if (le16_to_cpu(desc->bg_free_blocks_count) < min_blocks)
+			continue;
+		goto found;
+	}
+
+fallback:
+	for (i = 0; i < ngroups; i++) {
+		group = (parent_group + i) % ngroups;
+		desc = ext3_get_group_desc (sb, group, &bh);
+		if (!desc || !desc->bg_free_inodes_count)
+			continue;
+		if (le16_to_cpu(desc->bg_free_inodes_count) >= avefreei)
+			goto found;
+	}
+
+	return -1;
+
+found:
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
+	desc->bg_used_dirs_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
+	sbi->s_dir_count++;
+	mark_buffer_dirty(bh);
+	return group;
+}
+
+static int find_group_other(struct super_block *sb, struct inode *parent)
+{
+	int parent_group = EXT3_I(parent)->i_block_group;
+	int ngroups = EXT3_SB(sb)->s_groups_count;
+	struct ext3_group_desc *desc;
+	struct buffer_head *bh;
+	int group, i;
+
+	/*
+	 * Try to place the inode in its parent directory
+	 */
+	group = parent_group;
+	desc = ext3_get_group_desc (sb, group, &bh);
+	if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+		goto found;
+
+	/*
+	 * Use a quadratic hash to find a group with a
+	 * free inode
+	 */
+	for (i = 1; i < ngroups; i <<= 1) {
+		group += i;
+		if (group >= ngroups)
+			group -= ngroups;
+		desc = ext3_get_group_desc (sb, group, &bh);
+		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+			goto found;
+	}
+
+	/*
+	 * That failed: try linear search for a free inode
+	 */
+	group = parent_group + 1;
+	for (i = 2; i < ngroups; i++) {
+		if (++group >= ngroups)
+			group = 0;
+		desc = ext3_get_group_desc (sb, group, &bh);
+		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
+			goto found;
+	}
+
+	return -1;
+
+found:
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
+	mark_buffer_dirty(bh);
+	return group;
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
@@ -206,10 +431,10 @@
 	struct super_block *sb;
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *bh2;
-	int i, j, avefreei;
+	int group;
+	ino_t ino;
 	struct inode * inode;
 	struct ext3_group_desc * gdp;
-	struct ext3_group_desc * tmp;
 	struct ext3_super_block * es;
 	struct ext3_inode_info *ei;
 	int err = 0;
@@ -228,93 +453,35 @@
 	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 repeat:
-	gdp = NULL;
-	i = 0;
-
 	if (S_ISDIR(mode)) {
-		avefreei = le32_to_cpu(es->s_free_inodes_count) /
-			EXT3_SB(sb)->s_groups_count;
-		if (!gdp) {
-			for (j = 0; j < EXT3_SB(sb)->s_groups_count; j++) {
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
-		i = EXT3_I(dir)->i_block_group;
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
-			for (j = 1; j < EXT3_SB(sb)->s_groups_count; j <<= 1) {
-				i += j;
-				if (i >= EXT3_SB(sb)->s_groups_count)
-					i -= EXT3_SB(sb)->s_groups_count;
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
-			i = EXT3_I(dir)->i_block_group + 1;
-			for (j = 2; j < EXT3_SB(sb)->s_groups_count; j++) {
-				if (++i >= EXT3_SB(sb)->s_groups_count)
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
+	if (group == -1)
 		goto out;
 
 	err = -EIO;
 	brelse(bitmap_bh);
-	bitmap_bh = read_inode_bitmap(sb, i);
+	bitmap_bh = read_inode_bitmap(sb, group);
 	if (!bitmap_bh)
 		goto fail;
+	gdp = ext3_get_group_desc (sb, group, &bh2);
 
-	if ((j = ext3_find_first_zero_bit((unsigned long *)bitmap_bh->b_data,
+	if ((ino = ext3_find_first_zero_bit((unsigned long *)bitmap_bh->b_data,
 				      EXT3_INODES_PER_GROUP(sb))) <
 	    EXT3_INODES_PER_GROUP(sb)) {
 		BUFFER_TRACE(bitmap_bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, bitmap_bh);
 		if (err) goto fail;
 		
-		if (ext3_set_bit(j, bitmap_bh->b_data)) {
+		if (ext3_set_bit(ino, bitmap_bh->b_data)) {
 			ext3_error (sb, "ext3_new_inode",
-				      "bit already set for inode %d", j);
+				      "bit already set for inode %lu", ino);
 			goto repeat;
 		}
 		BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
@@ -324,7 +491,7 @@
 		if (le16_to_cpu(gdp->bg_free_inodes_count) != 0) {
 			ext3_error (sb, "ext3_new_inode",
 				    "Free inodes count corrupted in group %d",
-				    i);
+				    group);
 			/* Is it really ENOSPC? */
 			err = -ENOSPC;
 			if (sb->s_flags & MS_RDONLY)
@@ -340,11 +507,11 @@
 		}
 		goto repeat;
 	}
-	j += i * EXT3_INODES_PER_GROUP(sb) + 1;
-	if (j < EXT3_FIRST_INO(sb) || j > le32_to_cpu(es->s_inodes_count)) {
+	ino += group * EXT3_INODES_PER_GROUP(sb) + 1;
+	if (ino < EXT3_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
 		ext3_error (sb, "ext3_new_inode",
 			    "reserved inode or inode > inodes count - "
-			    "block_group = %d,inode=%d", i, j);
+			    "block_group = %d, inode=%lu", group, ino);
 		err = -EIO;
 		goto fail;
 	}
@@ -382,7 +549,7 @@
 		inode->i_gid = current->fsgid;
 	inode->i_mode = mode;
 
-	inode->i_ino = j;
+	inode->i_ino = ino;
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
@@ -412,7 +579,7 @@
 	ei->i_prealloc_block = 0;
 	ei->i_prealloc_count = 0;
 #endif
-	ei->i_block_group = i;
+	ei->i_block_group = group;
 	
 	if (ei->i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -560,6 +727,21 @@
 #else
 	return le32_to_cpu(EXT3_SB(sb)->s_es->s_free_inodes_count);
 #endif
+}
+
+/* Called at mount-time, super-block is locked */
+unsigned long ext3_count_dirs (struct super_block * sb)
+{
+	unsigned long count = 0;
+	int i;
+
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
+		struct ext3_group_desc *gdp = ext3_get_group_desc (sb, i, NULL);
+		if (!gdp)
+			continue;
+		count += le16_to_cpu(gdp->bg_used_dirs_count);
+	}
+	return count;
 }
 
 #ifdef CONFIG_EXT3_CHECK
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Sat Nov  2 01:32:18 2002
+++ b/fs/ext3/super.c	Sat Nov  2 01:32:18 2002
@@ -390,6 +390,7 @@
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
+	kfree(sbi->s_debts);
 	brelse(sbi->s_sbh);
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -1221,6 +1222,13 @@
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
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
@@ -1236,6 +1244,7 @@
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
+	sbi->s_dir_count = ext3_count_dirs(sb);
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -1339,6 +1348,8 @@
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
+	if (sbi->s_debts)
+		kfree(sbi->s_debts);
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Sat Nov  2 01:32:18 2002
+++ b/include/linux/ext3_fs.h	Sat Nov  2 01:32:18 2002
@@ -186,10 +186,11 @@
 #define EXT3_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
 #define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define EXT3_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
-#define EXT3_FL_USER_VISIBLE		0x00015FFF /* User visible flags */
-#define EXT3_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
+#define EXT3_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
+#define EXT3_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
 
 /*
  * Inode dynamic state flags
@@ -308,6 +309,7 @@
  * Mount flags
  */
 #define EXT3_MOUNT_CHECK		0x0001	/* Do mount-time checks */
+#define EXT3_MOUNT_OLDALLOC		0x0002  /* Don't use the new Orlov allocator */
 #define EXT3_MOUNT_GRPID		0x0004	/* Create files with directory's group */
 #define EXT3_MOUNT_DEBUG		0x0008	/* Some debugging messages */
 #define EXT3_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
@@ -704,6 +706,7 @@
 extern void ext3_free_inode (handle_t *, struct inode *);
 extern struct inode * ext3_orphan_get (struct super_block *, ino_t);
 extern unsigned long ext3_count_free_inodes (struct super_block *);
+extern unsigned long ext3_count_dirs (struct super_block *);
 extern void ext3_check_inodes_bitmap (struct super_block *);
 extern unsigned long ext3_count_free (struct buffer_head *, unsigned);
 
diff -Nru a/include/linux/ext3_fs_sb.h b/include/linux/ext3_fs_sb.h
--- a/include/linux/ext3_fs_sb.h	Sat Nov  2 01:32:18 2002
+++ b/include/linux/ext3_fs_sb.h	Sat Nov  2 01:32:18 2002
@@ -50,6 +50,8 @@
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
+	unsigned long s_dir_count;
+	u8 *s_debts;
 
 	/* Journaling */
 	struct inode * s_journal_inode;
