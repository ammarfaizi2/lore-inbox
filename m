Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263503AbSJGWHC>; Mon, 7 Oct 2002 18:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbSJGWHC>; Mon, 7 Oct 2002 18:07:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:16059 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263503AbSJGWGs>;
	Mon, 7 Oct 2002 18:06:48 -0400
Message-ID: <3DA206C3.9AD2941A@digeo.com>
Date: Mon, 07 Oct 2002 15:12:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <Pine.LNX.4.33.0210071455070.1337-100000@penguin.transmeta.com> <E17yfxq-0003vd-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 22:12:19.0929 (UTC) FILETIME=[9A8DE490:01C26E4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 07 October 2002 23:55, Linus Torvalds wrote:
> > On Mon, 7 Oct 2002, Daniel Phillips wrote:
> > > >
> > > > Sure. The mey is:
> > >             ^^^ <---- "bet" ?
> >
> > Yeah. What the heck happened to my fingers?
> 
> Apparently, one of them missed the key it was aiming for and the other one
> changed hands.
> 

They don't call him Kubys for nothing.

I dug out and dusted off Al's Orlov allocator patch.  And found
a comment which rather helps explain how it works.

I performance tested this back in November.  See
http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0281.html

Bottom line: it's as good as the use-first-fit-everywhere
approach, and appears to have better long-term antifragmentation
characteristics.

I shall test it.


 fs/ext2/ext2.h             |    1 
 fs/ext2/ialloc.c           |  164 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext2/super.c            |    8 ++
 include/linux/ext2_fs_sb.h |    2 
 4 files changed, 172 insertions(+), 3 deletions(-)

--- 2.5.41/fs/ext2/ialloc.c~orlov-allocator	Mon Oct  7 14:31:50 2002
+++ 2.5.41-akpm/fs/ext2/ialloc.c	Mon Oct  7 15:04:09 2002
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/random.h>
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
@@ -205,6 +206,7 @@ static void ext2_preread_inode(struct in
  * For other inodes, search forward from the parent directory\'s block
  * group to find a free inode.
  */
+#if 0
 
 static int find_group_dir(struct super_block *sb, int parent_group)
 {
@@ -238,9 +240,141 @@ static int find_group_dir(struct super_b
 	mark_buffer_dirty(best_bh);
 	return best_group;
 }
+#endif
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
+	int parent_group = EXT2_I(parent)->i_block_group;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = sbi->s_es;
+	int ngroups = sbi->s_groups_count;
+	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
+	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int blocks_per_dir;
+	int ndirs = sbi->s_dir_count;
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
+		if (sbi->debts[group] >= max_debt)
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
+	sbi->s_dir_count++;
+	mark_buffer_dirty(bh);
+	return group;
+}
 
-static int find_group_other(struct super_block *sb, int parent_group)
+static int find_group_other(struct super_block *sb, struct inode *parent)
 {
+	int parent_group = EXT2_I(parent)->i_block_group;
 	int ngroups = EXT2_SB(sb)->s_groups_count;
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
@@ -312,9 +446,9 @@ struct inode * ext2_new_inode(struct ino
 	es = EXT2_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode))
-		group = find_group_dir(sb, EXT2_I(dir)->i_block_group);
+		group = find_group_orlov(sb, dir);
 	else 
-		group = find_group_other(sb, EXT2_I(dir)->i_block_group);
+		group = find_group_other(sb, dir);
 
 	err = -ENOSPC;
 	if (group == -1)
@@ -349,6 +483,15 @@ repeat:
 
 	es->s_free_inodes_count =
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
+
+	if (S_ISDIR(mode)) {
+		if (EXT2_SB(sb)->debts[i] < 255)
+			EXT2_SB(sb)->debts[i]++;
+	} else {
+		if (EXT2_SB(sb)->debts[i])
+			EXT2_SB(sb)->debts[i]--;
+	}
+
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
@@ -478,6 +621,21 @@ unsigned long ext2_count_free_inodes (st
 #endif
 }
 
+/* Called at mount-time, super-block is locked */
+unsigned long ext2_count_dirs (struct super_block * sb)
+{
+	unsigned long count = 0;
+	int i;
+
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
+		struct ext2_group_desc *gdp = ext2_get_group_desc (sb, i, NULL);
+		if (!gdp)
+			continue;
+		count += le16_to_cpu(gdp->bg_used_dirs_count);
+	}
+	return count;
+}
+
 #ifdef CONFIG_EXT2_CHECK
 /* Called at mount-time, super-block is locked */
 void ext2_check_inodes_bitmap (struct super_block * sb)
--- 2.5.41/fs/ext2/super.c~orlov-allocator	Mon Oct  7 14:31:58 2002
+++ 2.5.41-akpm/fs/ext2/super.c	Mon Oct  7 14:52:38 2002
@@ -665,6 +665,12 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
+	sbi->debts = kmalloc(sbi->s_groups_count, GFP_KERNEL);
+	if (!sbi->debts) {
+		printk ("EXT2-fs: not enough memory\n");
+		goto failed_mount_group_desc;
+	}
+	memset(sbi->debts, 0, sbi->s_groups_count);
 	for (i = 0; i < db_count; i++) {
 		sbi->s_group_desc[i] = sb_bread(sb, logic_sb_block + i + 1);
 		if (!sbi->s_group_desc[i]) {
@@ -681,6 +687,7 @@ static int ext2_fill_super(struct super_
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
+	sbi->s_dir_count = ext2_count_dirs(sb);
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	/*
 	 * set up enough so that it can read an inode
@@ -706,6 +713,7 @@ static int ext2_fill_super(struct super_
 failed_mount2:
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
+failed_mount_group_desc:
 	kfree(sbi->s_group_desc);
 failed_mount:
 	brelse(bh);
--- 2.5.41/include/linux/ext2_fs_sb.h~orlov-allocator	Mon Oct  7 14:32:07 2002
+++ 2.5.41-akpm/include/linux/ext2_fs_sb.h	Mon Oct  7 14:38:23 2002
@@ -43,6 +43,8 @@ struct ext2_sb_info {
 	int s_inode_size;
 	int s_first_ino;
 	u32 s_next_generation;
+	unsigned long s_dir_count;
+	u8 *debts;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */
--- 2.5.41/fs/ext2/ext2.h~orlov-allocator	Mon Oct  7 14:37:36 2002
+++ 2.5.41-akpm/fs/ext2/ext2.h	Mon Oct  7 14:37:51 2002
@@ -45,6 +45,7 @@ extern int ext2_new_block (struct inode 
 extern void ext2_free_blocks (struct inode *, unsigned long,
 			      unsigned long);
 extern unsigned long ext2_count_free_blocks (struct super_block *);
+extern unsigned long ext2_count_dirs (struct super_block *);
 extern void ext2_check_blocks_bitmap (struct super_block *);
 extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,

.
