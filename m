Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280950AbRKLTrE>; Mon, 12 Nov 2001 14:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLTqz>; Mon, 12 Nov 2001 14:46:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26379 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280949AbRKLTqm>; Mon, 12 Nov 2001 14:46:42 -0500
Message-ID: <3BF02702.34C21E75@zip.com.au>
Date: Mon, 12 Nov 2001 11:46:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Israel <ben@genesis-one.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Israel wrote:
> 
> Andrew
> 
>  Thank you very much for your response. I would like to know what ever I can
> about File Systems that achieve near Raw Disk Transfer Speeds on large file
> system modifications.

This is very filesystem-dependent.   Probably the XFS mailing list
linux-xfs@oss.sgi.com is the place to ask for XFS.

> What does the "Orlov allocator" do differently?

The problem which ext2 experiences with your particular workload
is that it attempts to balance the creation of new directories
across the filesystem's various "block groups".  There are tens
or hundreds of these.  ext2 also tries to place files in the same
block group as their parent directory.

Consequently, when you untar (or just copy) a directory tree,
it gets placed all over the partition.  So both reading it and
writing it requires a lot of seeking.

That's a fast-growth workload.  A slow-growth workload is
the normal sort of day-to-day activity where you reqularly
create and delete files.  The occupancy of the fs grows slowly.

We are seeing some degradation in performance in the slow-growth
case with the Orlov algorithm.  But fast-growth is increased a lot.

The Orlov algorithm (or at least Al's version of it) tries to
spread top-level directories evenly across the partition, under
the assumption that these contain unrelated information.  But for
directories at a lower level, it is more aggressive about placing
directories in the same block group as their parent.   It _will_
move into a different block group, but only when it sees that the
current one is filling up.

> All File Systems I've used have this problem. XFS is
> just supposedly high performance. It offers some improvement, but is still
> off by a factor of 4.

Yup.  Which places all of our little two-instructions-here and
one-cacheline-there optimisations into an ironic context, no?

Here's Al's current allocator.  It's against 2.4.15-pre3 or -pre4.
The comments are informative.  Please, see if it helps with your
workloads.



diff -urN S15-pre3/fs/ext2/ialloc.c S15-pre3-ext2/fs/ext2/ialloc.c
--- S15-pre3/fs/ext2/ialloc.c	Sun Nov 11 15:24:12 2001
+++ S15-pre3-ext2/fs/ext2/ialloc.c	Mon Nov 12 02:22:20 2001
@@ -17,6 +17,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
+#include <linux/random.h>
 
 
 /*
@@ -230,7 +231,7 @@
  * group to find a free inode.
  */
 
-static int find_group_dir(struct super_block *sb, int parent_group)
+static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
 	int ngroups = sb->u.ext2_sb.s_groups_count;
@@ -263,8 +264,113 @@
 	return best_group;
 }
 
-static int find_group_other(struct super_block *sb, int parent_group)
+#define INODE_COST 64
+#define BLOCK_COST 256
+
+static int find_group_orlov(struct super_block *sb, const struct inode *parent)
+{
+	int parent_group = parent->u.ext2_i.i_block_group;
+	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
+	int ngroups = sb->u.ext2_sb.s_groups_count;
+	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int blocks_per_dir;
+	int ndirs = sb->u.ext2_sb.s_dir_count;
+	int max_debt, max_dirs, min_blocks, min_inodes;
+	int group = -1, i;
+	struct ext2_group_desc *desc;
+	struct buffer_head *bh;
+
+	if (parent == sb->s_root->d_inode) {
+		struct ext2_group_desc *best_desc = NULL;
+		struct buffer_head *best_bh = NULL;
+		int best_ndir = inodes_per_group;
+		int best_group = -1;
+
+		get_random_bytes(&group, sizeof(group));
+		parent_group = (unsigned)group % ngroups;
+		for (i = 0; i < ngroups; i++) {
+			group = (parent_group + i) % ngroups;
+			desc = ext2_get_group_desc (sb, group, &bh);
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
+	min_blocks = avefreeb - EXT2_BLOCKS_PER_GROUP(sb) / 4;
+
+	max_debt = EXT2_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
+	if (max_debt * INODE_COST > inodes_per_group)
+		max_debt = inodes_per_group / INODE_COST;
+	if (max_debt > 255)
+		max_debt = 255;
+	if (max_debt == 0)
+		max_debt = 1;
+
+	for (i = 0; i < ngroups; i++) {
+		group = (parent_group + i) % ngroups;
+		desc = ext2_get_group_desc (sb, group, &bh);
+		if (!desc || !desc->bg_free_inodes_count)
+			continue;
+		if (sb->u.ext2_sb.debts[group] >= max_debt)
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
+		desc = ext2_get_group_desc (sb, group, &bh);
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
+	sb->u.ext2_sb.s_dir_count++;
+	mark_buffer_dirty(bh);
+	return group;
+}
+
+static int find_group_other(struct super_block *sb, struct inode *parent)
 {
+	int parent_group = parent->u.ext2_i.i_block_group;
 	int ngroups = sb->u.ext2_sb.s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
@@ -333,9 +439,9 @@
 	es = sb->u.ext2_sb.s_es;
 repeat:
 	if (S_ISDIR(mode))
-		group = find_group_dir(sb, dir->u.ext2_i.i_block_group);
+		group = find_group_orlov(sb, dir);
 	else 
-		group = find_group_other(sb, dir->u.ext2_i.i_block_group);
+		group = find_group_other(sb, dir);
 
 	err = -ENOSPC;
 	if (group == -1)
@@ -369,6 +475,15 @@
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
+
+	if (S_ISDIR(mode)) {
+		if (sb->u.ext2_sb.debts[i] < 255)
+			sb->u.ext2_sb.debts[i]++;
+	} else {
+		if (sb->u.ext2_sb.debts[i])
+			sb->u.ext2_sb.debts[i]--;
+	}
+
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
@@ -470,6 +585,21 @@
 #else
 	return le32_to_cpu(sb->u.ext2_sb.s_es->s_free_inodes_count);
 #endif
+}
+
+/* Called at mount-time, super-block is locked */
+unsigned long ext2_count_dirs (struct super_block * sb)
+{
+	unsigned long count = 0;
+	int i;
+
+	for (i = 0; i < sb->u.ext2_sb.s_groups_count; i++) {
+		struct ext2_group_desc *gdp = ext2_get_group_desc (sb, i, NULL);
+		if (!gdp)
+			continue;
+		count += le16_to_cpu(gdp->bg_used_dirs_count);
+	}
+	return count;
 }
 
 #ifdef CONFIG_EXT2_CHECK
diff -urN S15-pre3/fs/ext2/super.c S15-pre3-ext2/fs/ext2/super.c
--- S15-pre3/fs/ext2/super.c	Tue Oct  9 21:47:26 2001
+++ S15-pre3-ext2/fs/ext2/super.c	Mon Nov 12 02:03:02 2001
@@ -605,6 +605,12 @@
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
+	sb->u.ext2_sb.debts = kmalloc(sb->u.ext2_sb.s_groups_count, GFP_KERNEL);
+	if (!sb->u.ext2_sb.debts) {
+		printk ("EXT2-fs: not enough memory\n");
+		goto failed_mount;
+	}
+	memset(sb->u.ext2_sb.debts, 0, sb->u.ext2_sb.s_groups_count);
 	for (i = 0; i < db_count; i++) {
 		sb->u.ext2_sb.s_group_desc[i] = bread (dev, logic_sb_block + i + 1,
 						       sb->s_blocksize);
@@ -621,6 +627,7 @@
 		db_count = i;
 		goto failed_mount2;
 	}
+	sb->u.ext2_sb.s_dir_count = ext2_count_dirs(sb);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
 		sb->u.ext2_sb.s_inode_bitmap_number[i] = 0;
 		sb->u.ext2_sb.s_inode_bitmap[i] = NULL;
diff -urN S15-pre3/include/linux/ext2_fs.h S15-pre3-ext2/include/linux/ext2_fs.h
--- S15-pre3/include/linux/ext2_fs.h	Sun Nov 11 00:46:41 2001
+++ S15-pre3-ext2/include/linux/ext2_fs.h	Mon Nov 12 02:03:02 2001
@@ -578,6 +578,7 @@
 extern unsigned long ext2_count_free_inodes (struct super_block *);
 extern void ext2_check_inodes_bitmap (struct super_block *);
 extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
+extern unsigned long ext2_count_dirs (struct super_block *);
 
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
diff -urN S15-pre3/include/linux/ext2_fs_sb.h S15-pre3-ext2/include/linux/ext2_fs_sb.h
--- S15-pre3/include/linux/ext2_fs_sb.h	Fri Feb 16 21:29:52 2001
+++ S15-pre3-ext2/include/linux/ext2_fs_sb.h	Mon Nov 12 02:03:02 2001
@@ -56,6 +56,8 @@
 	int s_desc_per_block_bits;
 	int s_inode_size;
 	int s_first_ino;
+	unsigned long s_dir_count;
+	u8 *debts;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */
