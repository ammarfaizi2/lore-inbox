Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbTCQKjm>; Mon, 17 Mar 2003 05:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbTCQKjm>; Mon, 17 Mar 2003 05:39:42 -0500
Received: from comtv.ru ([217.10.32.4]:10187 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261533AbTCQKjT>;
	Mon, 17 Mar 2003 05:39:19 -0500
X-Comment-To: William Lee Irwin III
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] distributed counters for ext2 to avoid group scaning
References: <m3el5773to.fsf@lexa.home.net>
	<20030317093712.GP20188@holomorphy.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 13:41:41 +0300
In-Reply-To: <20030317093712.GP20188@holomorphy.com>
Message-ID: <m3smtmnul6.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> William Lee Irwin (WLI) writes:

 WLI> On Sun, Mar 16, 2003 at 06:01:55PM +0300, Alex Tomas wrote:
 >> ext2 with concurrent balloc/ialloc doesn't maintain global free
 >> inodes/blocks counters. this is due to badness of spinlocks and
 >> atomic_t from big iron's viewpoint. therefore, to know these
 >> values we should scan all group descriptors.  there are 81 groups
 >> for 10G fs. I believe there is method to avoid scaning and
 >> decrease memory footprint.

 WLI> benching now

here is the patch against virgin 2.5.64 containing:
1) concurrent balloc
2) concurrent ialloc
3) no-space fix
4) distributed counters for free blocks, free inodes and dirs
4) LOTS of Andrew Morton's corrections



diff -uNr linux-2.5.64/fs/ext2/balloc.c linux-2.5.64-ciba/fs/ext2/balloc.c
--- linux-2.5.64/fs/ext2/balloc.c	Thu Feb 20 16:18:53 2003
+++ linux-2.5.64-ciba/fs/ext2/balloc.c	Mon Mar 17 13:26:05 2003
@@ -94,69 +94,71 @@
 	return bh;
 }
 
-static inline int reserve_blocks(struct super_block *sb, int count)
+/*
+ * Set sb->s_dirt here because the superblock was "logically" altered.  We
+ * need to recalculate its free blocks count and flush it out.
+ */
+static int
+group_reserve_blocks(struct super_block *sb, struct ext2_bg_info *bgi, 
+		struct ext2_group_desc *desc, struct buffer_head *bh,
+		int count, int use_reserve)
 {
-	struct ext2_sb_info * sbi = EXT2_SB(sb);
-	struct ext2_super_block * es = sbi->s_es;
-	unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
-	unsigned root_blocks = le32_to_cpu(es->s_r_blocks_count);
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	unsigned free_blocks;
+	unsigned root_blocks;
+
+	spin_lock(&bgi->balloc_lock);
 
+	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 	if (free_blocks < count)
 		count = free_blocks;
+	root_blocks = bgi->reserved;
+
+	if (free_blocks <  bgi->reserved && !use_reserve) {
+		/* don't use reserved blocks */
+		spin_unlock(&bgi->balloc_lock);
+		return 0;
+	}
 
-	if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
-	    sbi->s_resuid != current->fsuid &&
-	    (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+	if (free_blocks <  bgi->reserved + count &&
+			!capable(CAP_SYS_RESOURCE) &&
+			sbi->s_resuid != current->fsuid &&
+			(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
 		/*
 		 * We are too close to reserve and we are not privileged.
 		 * Can we allocate anything at all?
 		 */
-		if (free_blocks > root_blocks)
-			count = free_blocks - root_blocks;
-		else
+		if (free_blocks > bgi->reserved) {
+			count = free_blocks - bgi->reserved;
+		} else {
+			spin_unlock(&bgi->balloc_lock);
 			return 0;
+		}
 	}
+	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
 
-	es->s_free_blocks_count = cpu_to_le32(free_blocks - count);
-	mark_buffer_dirty(sbi->s_sbh);
+	spin_unlock(&bgi->balloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_blocks_dc, -count);
 	sb->s_dirt = 1;
+	mark_buffer_dirty(bh);
 	return count;
 }
 
-static inline void release_blocks(struct super_block *sb, int count)
+static void group_release_blocks(struct super_block *sb,
+	struct ext2_bg_info *bgi, struct ext2_group_desc *desc,
+	struct buffer_head *bh, int count)
 {
 	if (count) {
-		struct ext2_sb_info * sbi = EXT2_SB(sb);
-		struct ext2_super_block * es = sbi->s_es;
-		unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
-		es->s_free_blocks_count = cpu_to_le32(free_blocks + count);
-		mark_buffer_dirty(sbi->s_sbh);
-		sb->s_dirt = 1;
-	}
-}
-
-static inline int group_reserve_blocks(struct ext2_group_desc *desc,
-				    struct buffer_head *bh, int count)
-{
-	unsigned free_blocks;
+		unsigned free_blocks;
 
-	if (!desc->bg_free_blocks_count)
-		return 0;
-
-	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
-	if (free_blocks < count)
-		count = free_blocks;
-	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
-	mark_buffer_dirty(bh);
-	return count;
-}
+		spin_lock(&bgi->balloc_lock);
 
-static inline void group_release_blocks(struct ext2_group_desc *desc,
-				    struct buffer_head *bh, int count)
-{
-	if (count) {
-		unsigned free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
+		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
+
+		spin_unlock(&bgi->balloc_lock);
+		dcounter_add(&EXT2_SB(sb)->free_blocks_dc, count);
+		sb->s_dirt = 1;
 		mark_buffer_dirty(bh);
 	}
 }
@@ -172,12 +174,11 @@
 	unsigned long i;
 	unsigned long overflow;
 	struct super_block * sb = inode->i_sb;
+	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_group_desc * desc;
-	struct ext2_super_block * es;
+	struct ext2_super_block * es = sbi->s_es;
 	unsigned freed = 0, group_freed;
 
-	lock_super (sb);
-	es = EXT2_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
 	    block + count > le32_to_cpu(es->s_blocks_count)) {
@@ -215,16 +216,17 @@
 	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
 	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
 	    in_range (block, le32_to_cpu(desc->bg_inode_table),
-		      EXT2_SB(sb)->s_itb_per_group) ||
+		      sbi->s_itb_per_group) ||
 	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
-		      EXT2_SB(sb)->s_itb_per_group))
+		      sbi->s_itb_per_group))
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks in system zones - "
 			    "Block = %lu, count = %lu",
 			    block, count);
 
 	for (i = 0, group_freed = 0; i < count; i++) {
-		if (!ext2_clear_bit(bit + i, bitmap_bh->b_data))
+		if (!ext2_clear_bit_atomic(&sbi->s_bgi[block_group].balloc_lock,
+					bit + i, (void *) bitmap_bh->b_data))
 			ext2_error (sb, "ext2_free_blocks",
 				      "bit already cleared for block %lu",
 				      block + i);
@@ -236,7 +238,8 @@
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	group_release_blocks(desc, bh2, group_freed);
+	group_release_blocks(sb, &sbi->s_bgi[block_group],
+				desc, bh2, group_freed);
 	freed += group_freed;
 
 	if (overflow) {
@@ -246,18 +249,18 @@
 	}
 error_return:
 	brelse(bitmap_bh);
-	release_blocks(sb, freed);
-	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, freed);
 }
 
-static int grab_block(char *map, unsigned size, int goal)
+static int grab_block(spinlock_t *lock, char *map, unsigned size, int goal)
 {
 	int k;
 	char *p, *r;
 
 	if (!ext2_test_bit(goal, map))
 		goto got_it;
+
+repeat:
 	if (goal) {
 		/*
 		 * The goal was occupied; search forward for a free 
@@ -297,7 +300,8 @@
 	}
 	return -1;
 got_it:
-	ext2_set_bit(goal, map);
+	if (ext2_set_bit_atomic(lock, goal, (void *) map)) 
+		goto repeat;	
 	return goal;
 }
 
@@ -309,17 +313,17 @@
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_block (struct inode * inode, unsigned long goal,
-    u32 * prealloc_count, u32 * prealloc_block, int * err)
+int ext2_new_block(struct inode *inode, unsigned long goal,
+			u32 *prealloc_count, u32 *prealloc_block, int *err)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;	/* bh2 */
 	struct ext2_group_desc *desc;
 	int group_no;			/* i */
 	int ret_block;			/* j */
-	int bit;		/* k */
+	int bit;			/* k */
 	int target_block;		/* tmp */
-	int block = 0;
+	int block = 0, use_reserve = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
@@ -341,14 +345,7 @@
 		prealloc_goal--;
 
 	dq_alloc = prealloc_goal + 1;
-
-	lock_super (sb);
-
-	es_alloc = reserve_blocks(sb, dq_alloc);
-	if (!es_alloc) {
-		*err = -ENOSPC;
-		goto out_unlock;
-	}
+	es_alloc = dq_alloc;
 
 	ext2_debug ("goal=%lu.\n", goal);
 
@@ -360,7 +357,8 @@
 	if (!desc)
 		goto io_error;
 
-	group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+	group_alloc = group_reserve_blocks(sb, &sbi->s_bgi[group_no],
+					desc, gdp_bh, es_alloc, 0);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 					group_size);
@@ -371,11 +369,13 @@
 		
 		ext2_debug("goal is at %d:%d.\n", group_no, ret_block);
 
-		ret_block = grab_block(bitmap_bh->b_data,
+		ret_block = grab_block(&sbi->s_bgi[group_no].balloc_lock,
+				bitmap_bh->b_data,
 				group_size, ret_block);
 		if (ret_block >= 0)
 			goto got_block;
-		group_release_blocks(desc, gdp_bh, group_alloc);
+		group_release_blocks(sb, &sbi->s_bgi[group_no],
+					desc, gdp_bh, group_alloc);
 		group_alloc = 0;
 	}
 
@@ -385,6 +385,7 @@
 	 * Now search the rest of the groups.  We assume that 
 	 * i and desc correctly point to the last group visited.
 	 */
+repeat:
 	for (bit = 0; !group_alloc &&
 			bit < sbi->s_groups_count; bit++) {
 		group_no++;
@@ -393,9 +394,18 @@
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+		group_alloc = group_reserve_blocks(sb, &sbi->s_bgi[group_no],
+					desc, gdp_bh, es_alloc, use_reserve);
 	}
-	if (bit >= sbi->s_groups_count) {
+	if (!use_reserve) {
+		/* first time we did not try to allocate
+		 * reserved blocks. now it looks like
+		 * no more non-reserved blocks left. we
+		 * will try to allocate reserved blocks -bzzz */
+		use_reserve = 1;
+		goto repeat;
+	}
+	if (!group_alloc) {
 		*err = -ENOSPC;
 		goto out_release;
 	}
@@ -404,13 +414,11 @@
 	if (!bitmap_bh)
 		goto io_error;
 
-	ret_block = grab_block(bitmap_bh->b_data, group_size, 0);
+	ret_block = grab_block(&sbi->s_bgi[group_no].balloc_lock,
+			bitmap_bh->b_data, group_size, 0);
 	if (ret_block < 0) {
-		ext2_error (sb, "ext2_new_block",
-			"Free blocks count corrupted for block group %d",
-				group_no);
 		group_alloc = 0;
-		goto io_error;
+		goto repeat;	
 	}
 
 got_block:
@@ -452,7 +460,9 @@
 		unsigned n;
 
 		for (n = 0; n < group_alloc && ++ret_block < group_size; n++) {
-			if (ext2_set_bit(ret_block, bitmap_bh->b_data))
+			if (ext2_set_bit_atomic(&sbi->s_bgi[group_no].balloc_lock,
+						ret_block,
+						(void*) bitmap_bh->b_data))
  				break;
 		}
 		*prealloc_block = block + 1;
@@ -471,10 +481,8 @@
 
 	*err = 0;
 out_release:
-	group_release_blocks(desc, gdp_bh, group_alloc);
-	release_blocks(sb, es_alloc);
-out_unlock:
-	unlock_super (sb);
+	group_release_blocks(sb, &sbi->s_bgi[group_no],
+				desc, gdp_bh, group_alloc);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);
 out:
 	brelse(bitmap_bh);
@@ -485,13 +493,18 @@
 	goto out_release;
 }
 
-unsigned long ext2_count_free_blocks (struct super_block * sb)
+unsigned long ext2_count_free_blocks(struct super_block *sb)
+{
+	return dcounter_value(&EXT2_SB(sb)->free_blocks_dc);
+}
+
+unsigned long ext2_count_free_blocks_old(struct super_block *sb)
 {
-#ifdef EXT2FS_DEBUG
-	struct ext2_super_block * es;
-	unsigned long desc_count, bitmap_count, x;
 	struct ext2_group_desc * desc;
+	unsigned long desc_count = 0;
 	int i;
+#ifdef EXT2FS_DEBUG
+	unsigned long bitmap_count, x;
 	
 	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
@@ -519,13 +532,18 @@
 	unlock_super (sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count);
+        for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
+                desc = ext2_get_group_desc (sb, i, NULL);
+                if (!desc)
+                        continue;
+                desc_count += le16_to_cpu(desc->bg_free_blocks_count);
+	}
+	return desc_count;
 #endif
 }
 
-static inline int block_in_use (unsigned long block,
-				struct super_block * sb,
-				unsigned char * map)
+static inline int
+block_in_use(unsigned long block, struct super_block *sb, unsigned char *map)
 {
 	return ext2_test_bit ((block - le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block)) %
 			 EXT2_BLOCKS_PER_GROUP(sb), map);
diff -uNr linux-2.5.64/fs/ext2/ialloc.c linux-2.5.64-ciba/fs/ext2/ialloc.c
--- linux-2.5.64/fs/ext2/ialloc.c	Fri Mar 14 01:53:36 2003
+++ linux-2.5.64-ciba/fs/ext2/ialloc.c	Mon Mar 17 13:26:05 2003
@@ -64,6 +64,68 @@
 }
 
 /*
+ * Speculatively reserve an inode in a blockgroup which used to have some
+ * spare ones.  Later, when we come to actually claim the inode in the bitmap
+ * it may be that it was taken.  In that case the allocator will undo this
+ * reservation and try again.
+ *
+ * The inode allocator does not physically alter the superblock.  But we still
+ * set sb->s_dirt, because the superblock was "logically" altered - we need to
+ * go and add up the free inodes counts again and flush out the superblock.
+ */
+static void ext2_reserve_inode(struct super_block *sb, int group, int dir)
+{
+	struct ext2_group_desc * desc;
+	struct buffer_head *bh;
+
+	desc = ext2_get_group_desc(sb, group, &bh);
+	if (!desc) {
+		ext2_error(sb, "ext2_reserve_inode",
+			"can't get descriptor for group %d", group);
+		return;
+	}
+
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
+	if (dir) {
+		desc->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
+		dcounter_add(&EXT2_SB(sb)->dirs_dc, 1);
+	}
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, -1);
+	sb->s_dirt = 1;
+	mark_buffer_dirty(bh);
+}
+
+static void ext2_release_inode(struct super_block *sb, int group, int dir)
+{
+	struct ext2_group_desc * desc;
+	struct buffer_head *bh;
+
+	desc = ext2_get_group_desc(sb, group, &bh);
+	if (!desc) {
+		ext2_error(sb, "ext2_release_inode",
+			"can't get descriptor for group %d", group);
+		return;
+	}
+
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	desc->bg_free_inodes_count =
+		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
+	if (dir) {
+		desc->bg_used_dirs_count =
+			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
+		dcounter_add(&EXT2_SB(sb)->dirs_dc, -1);
+	}
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, 1);
+	sb->s_dirt = 1;
+	mark_buffer_dirty(bh);
+}
+
+/*
  * NOTE! When we get the inode, we're the only people
  * that have access to it, and as such there are no
  * race conditions we have to worry about. The inode
@@ -85,10 +147,8 @@
 	int is_directory;
 	unsigned long ino;
 	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *bh2;
 	unsigned long block_group;
 	unsigned long bit;
-	struct ext2_group_desc * desc;
 	struct ext2_super_block * es;
 
 	ino = inode->i_ino;
@@ -105,7 +165,6 @@
 		DQUOT_DROP(inode);
 	}
 
-	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	is_directory = S_ISDIR(inode->i_mode);
 
@@ -126,32 +185,17 @@
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
-	if (!ext2_clear_bit(bit, bitmap_bh->b_data))
+	if (!ext2_clear_bit_atomic(&EXT2_SB(sb)->s_bgi[block_group].ialloc_lock,
+				bit, (void *) bitmap_bh->b_data))
 		ext2_error (sb, "ext2_free_inode",
 			      "bit already cleared for inode %lu", ino);
-	else {
-		desc = ext2_get_group_desc (sb, block_group, &bh2);
-		if (desc) {
-			desc->bg_free_inodes_count =
-				cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
-			if (is_directory) {
-				desc->bg_used_dirs_count =
-					cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
-				EXT2_SB(sb)->s_dir_count--;
-			}
-		}
-		mark_buffer_dirty(bh2);
-		es->s_free_inodes_count =
-			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	}
+	else
+		ext2_release_inode(sb, block_group, is_directory);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
-	sb->s_dirt = 1;
 error_return:
 	brelse(bitmap_bh);
-	unlock_super (sb);
 }
 
 /*
@@ -211,9 +255,8 @@
  */
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
-	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	int ngroups = EXT2_SB(sb)->s_groups_count;
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreei = ext2_count_free_inodes(sb) / ngroups;
 	struct ext2_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh, *best_bh = NULL;
 	int group, best_group = -1;
@@ -234,11 +277,9 @@
 	}
 	if (!best_desc)
 		return -1;
-	best_desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
-	best_desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
-	mark_buffer_dirty(best_bh);
+
+	ext2_reserve_inode(sb, best_group, 1);
+
 	return best_group;
 }
 
@@ -277,10 +318,12 @@
 	struct ext2_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
-	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int freei = ext2_count_free_inodes(sb);
+	int avefreei = freei / ngroups;
+	int free_blocks = ext2_count_free_blocks(sb);
+	int avefreeb = free_blocks / ngroups;
 	int blocks_per_dir;
-	int ndirs = sbi->s_dir_count;
+	int ndirs = dcounter_value(&sbi->dirs_dc);
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext2_group_desc *desc;
@@ -320,8 +363,7 @@
 		goto fallback;
 	}
 
-	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) -
-			  le32_to_cpu(es->s_free_blocks_count)) / ndirs;
+	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) - free_blocks) / ndirs;
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
 	min_inodes = avefreei - inodes_per_group / 4;
@@ -340,7 +382,7 @@
 		desc = ext2_get_group_desc (sb, group, &bh);
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
-		if (sbi->s_debts[group] >= max_debt)
+		if (sbi->s_bgi[group].debts >= max_debt)
 			continue;
 		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
 			continue;
@@ -364,12 +406,8 @@
 	return -1;
 
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
-	sbi->s_dir_count++;
-	mark_buffer_dirty(bh);
+	ext2_reserve_inode(sb, group, 1);
+
 	return group;
 }
 
@@ -431,9 +469,8 @@
 	return -1;
 
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	mark_buffer_dirty(bh);
+	ext2_reserve_inode(sb, group, 0);
+
 	return group;
 }
 
@@ -456,7 +493,6 @@
 		return ERR_PTR(-ENOMEM);
 
 	ei = EXT2_I(inode);
-	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode)) {
@@ -480,7 +516,12 @@
 				      EXT2_INODES_PER_GROUP(sb));
 	if (i >= EXT2_INODES_PER_GROUP(sb))
 		goto bad_count;
-	ext2_set_bit(i, bitmap_bh->b_data);
+	if (ext2_set_bit_atomic(&EXT2_SB(sb)->s_bgi[group].ialloc_lock,
+			i, (void *) bitmap_bh->b_data)) {
+		brelse(bitmap_bh);
+		ext2_release_inode(sb, group, S_ISDIR(mode));
+		goto repeat;
+	}
 
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
@@ -497,19 +538,16 @@
 		goto fail2;
 	}
 
-	es->s_free_inodes_count =
-		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-
+	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
 	if (S_ISDIR(mode)) {
-		if (EXT2_SB(sb)->s_debts[group] < 255)
-			EXT2_SB(sb)->s_debts[group]++;
+		if (EXT2_SB(sb)->s_bgi[group].debts < 255)
+			EXT2_SB(sb)->s_bgi[group].debts++;
 	} else {
-		if (EXT2_SB(sb)->s_debts[group])
-			EXT2_SB(sb)->s_debts[group]--;
+		if (EXT2_SB(sb)->s_bgi[group].debts)
+			EXT2_SB(sb)->s_bgi[group].debts--;
 	}
+	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
 
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
@@ -552,7 +590,6 @@
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 
-	unlock_super(sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
 		goto fail3;
@@ -574,15 +611,8 @@
 	return ERR_PTR(err);
 
 fail2:
-	desc = ext2_get_group_desc (sb, group, &bh2);
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
-	if (S_ISDIR(mode))
-		desc->bg_used_dirs_count =
-			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
-	mark_buffer_dirty(bh2);
+	ext2_release_inode(sb, group, S_ISDIR(mode));
 fail:
-	unlock_super(sb);
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
@@ -603,18 +633,26 @@
 	goto repeat;
 }
 
-unsigned long ext2_count_free_inodes (struct super_block * sb)
+unsigned long ext2_count_free_inodes(struct super_block *sb)
+{
+	return dcounter_value(&EXT2_SB(sb)->free_inodes_dc);
+}
+
+unsigned long ext2_count_free_inodes_old(struct super_block *sb)
 {
+	struct ext2_group_desc *desc;
+	unsigned long desc_count = 0;
+	int i;	
+
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
-	unsigned long desc_count = 0, bitmap_count = 0;
+	unsigned long bitmap_count = 0;
 	struct buffer_head *bitmap_bh = NULL;
 	int i;
 
 	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct ext2_group_desc *desc;
 		unsigned x;
 
 		desc = ext2_get_group_desc (sb, i, NULL);
@@ -637,7 +675,13 @@
 	unlock_super(sb);
 	return desc_count;
 #else
-	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_inodes_count);
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
+		desc = ext2_get_group_desc (sb, i, NULL);
+		if (!desc)
+			continue;
+		desc_count += le16_to_cpu(desc->bg_free_inodes_count);
+	}
+	return desc_count;
 #endif
 }
 
diff -uNr linux-2.5.64/fs/ext2/super.c linux-2.5.64-ciba/fs/ext2/super.c
--- linux-2.5.64/fs/ext2/super.c	Thu Feb 20 16:18:53 2003
+++ linux-2.5.64-ciba/fs/ext2/super.c	Mon Mar 17 13:26:05 2003
@@ -35,6 +35,8 @@
 			    struct ext2_super_block *es);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct super_block * sb, struct statfs * buf);
+unsigned long ext2_count_free_inodes_old(struct super_block *sb);
+unsigned long ext2_count_free_blocks_old (struct super_block * sb);
 
 static char error_buf[1024];
 
@@ -141,7 +143,7 @@
 		if (sbi->s_group_desc[i])
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	kfree(sbi->s_debts);
+	kfree(sbi->s_bgi);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -464,8 +466,11 @@
 	int i;
 	int desc_block = 0;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	struct ext2_super_block * es = sbi->s_es;
+	unsigned long block = le32_to_cpu(es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
+	unsigned int total_free = 0, free;
+	unsigned int reserved = le32_to_cpu(es->s_r_blocks_count);
 
 	ext2_debug ("Checking group descriptors");
 
@@ -504,6 +509,30 @@
 		block += EXT2_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
+	
+	total_free = le32_to_cpu (es->s_free_blocks_count);
+	dcounter_init(&EXT2_SB(sb)->free_blocks_dc, total_free, 0);
+	dcounter_init(&EXT2_SB(sb)->free_inodes_dc,
+			le32_to_cpu (es->s_free_inodes_count), 0);
+	dcounter_init(&EXT2_SB(sb)->dirs_dc, ext2_count_dirs(sb), 1);
+
+	/* distribute reserved blocks over groups -bzzz */
+	for(i = sbi->s_groups_count-1; reserved && total_free && i >= 0; i--) {
+		gdp = ext2_get_group_desc (sb, i, NULL);
+		if (!gdp) {
+			ext2_error (sb, "ext2_check_descriptors",
+					"cant get descriptor for group %d", i);
+			return 0;
+		}
+		
+		free = le16_to_cpu(gdp->bg_free_blocks_count);
+		if (free > reserved)
+			free = reserved;
+		sbi->s_bgi[i].reserved = free;
+		reserved -= free;
+		total_free -= free;
+	}
+	
 	return 1;
 }
 
@@ -768,13 +797,18 @@
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+	sbi->s_bgi = kmalloc(sbi->s_groups_count*sizeof(struct ext2_bg_info),
 			       GFP_KERNEL);
-	if (!sbi->s_debts) {
+	if (!sbi->s_bgi) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount_group_desc;
 	}
-	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
+	for (i = 0; i < sbi->s_groups_count; i++) {
+		sbi->s_bgi[i].debts = 0;
+		sbi->s_bgi[i].reserved = 0;
+		spin_lock_init(&sbi->s_bgi[i].balloc_lock);
+		spin_lock_init(&sbi->s_bgi[i].ialloc_lock);
+	}
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
@@ -820,8 +854,8 @@
 		brelse(sbi->s_group_desc[i]);
 failed_mount_group_desc:
 	kfree(sbi->s_group_desc);
-	if (sbi->s_debts)
-		kfree(sbi->s_debts);
+	if (sbi->s_bgi)
+		kfree(sbi->s_bgi);
 failed_mount:
 	brelse(bh);
 failed_sbi:
@@ -840,6 +874,22 @@
 
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
+	if (dcounter_value(&EXT2_SB(sb)->dirs_dc) != ext2_count_dirs(sb))
+		printk("EXT2-fs: invalid dirs_dc %d (real %d)\n",
+				(int) dcounter_value(&EXT2_SB(sb)->dirs_dc),
+				(int) ext2_count_dirs(sb));
+	if (ext2_count_free_blocks(sb) != ext2_count_free_blocks_old(sb))
+		printk("EXT2-fs: invalid free blocks dcounter %d (real %d)\n",
+				(int) ext2_count_free_blocks(sb),
+				(int) ext2_count_free_blocks_old(sb));
+	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
+
+	if (ext2_count_free_inodes(sb) != ext2_count_free_inodes_old(sb))
+		printk("EXT2-fs: invalid free inodes dcounter %d (real %d)\n",
+			(int) ext2_count_free_inodes(sb),
+			(int) ext2_count_free_inodes_old(sb));
+	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+
 	es->s_wtime = cpu_to_le32(get_seconds());
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
@@ -868,6 +918,25 @@
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
+			if (dcounter_value(&EXT2_SB(sb)->dirs_dc) != ext2_count_dirs(sb))
+				printk("EXT2-fs: invalid dirs_dc %d (real %d)\n",
+					(int) dcounter_value(&EXT2_SB(sb)->dirs_dc),
+					(int) ext2_count_dirs(sb));
+
+			es->s_free_blocks_count =
+				cpu_to_le32(ext2_count_free_blocks(sb));
+			if (ext2_count_free_blocks(sb) != ext2_count_free_blocks_old(sb)) 
+				printk("EXT2-fs: invalid free blocks dcounter %d (real %d)\n",
+					(int)ext2_count_free_blocks(sb),
+					(int)ext2_count_free_blocks_old(sb));
+
+			es->s_free_inodes_count =
+				cpu_to_le32(ext2_count_free_inodes(sb));
+			if (ext2_count_free_inodes(sb) != ext2_count_free_inodes_old(sb))
+				 printk("EXT2-fs: invalid free inodes dcounter %d (real %d)\n",
+					(int)ext2_count_free_inodes(sb),
+					(int)ext2_count_free_inodes_old(sb));
+
 			es->s_mtime = cpu_to_le32(get_seconds());
 			ext2_sync_super(sb, es);
 		} else
@@ -929,7 +998,8 @@
 static int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long overhead;
+	unsigned long overhead, total_free = 0;
+	struct ext2_group_desc *desc;
 	int i;
 
 	if (test_opt (sb, MINIX_DF))
@@ -950,9 +1020,14 @@
 		 * block group descriptors.  If the sparse superblocks
 		 * feature is turned on, then not all groups have this.
 		 */
-		for (i = 0; i < sbi->s_groups_count; i++)
+		for (i = 0; i < sbi->s_groups_count; i++) {
 			overhead += ext2_bg_has_super(sb, i) +
 				ext2_bg_num_gdb(sb, i);
+			
+			/* sum total free blocks -bzzz */
+			desc = ext2_get_group_desc (sb, i, NULL);
+			total_free += le16_to_cpu(desc->bg_free_blocks_count);
+		}
 
 		/*
 		 * Every block group has an inode bitmap, a block
@@ -965,7 +1040,7 @@
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = le32_to_cpu(sbi->s_es->s_blocks_count) - overhead;
-	buf->f_bfree = ext2_count_free_blocks (sb);
+	buf->f_bfree = total_free;
 	buf->f_bavail = buf->f_bfree - le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (buf->f_bfree < le32_to_cpu(sbi->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
diff -uNr linux-2.5.64/include/asm-alpha/bitops.h linux-2.5.64-ciba/include/asm-alpha/bitops.h
--- linux-2.5.64/include/asm-alpha/bitops.h	Fri Mar 14 01:53:36 2003
+++ linux-2.5.64-ciba/include/asm-alpha/bitops.h	Mon Mar 17 13:22:58 2003
@@ -487,7 +487,9 @@
 
 
 #define ext2_set_bit                 __test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
 #define ext2_clear_bit               __test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux-2.5.64/include/asm-arm/bitops.h linux-2.5.64-ciba/include/asm-arm/bitops.h
--- linux-2.5.64/include/asm-arm/bitops.h	Fri Mar 14 01:53:36 2003
+++ linux-2.5.64-ciba/include/asm-arm/bitops.h	Mon Mar 17 13:22:58 2003
@@ -357,8 +357,12 @@
  */
 #define ext2_set_bit(nr,p)			\
 		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define ext2_set_bit_atomic(lock,nr,p)          \
+                test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_clear_bit(nr,p)			\
 		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define ext2_clear_bit_atomic(lock,nr,p)        \
+                test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_test_bit(nr,p)			\
 		__test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_find_first_zero_bit(p,sz)		\
diff -uNr linux-2.5.64/include/asm-cris/bitops.h linux-2.5.64-ciba/include/asm-cris/bitops.h
--- linux-2.5.64/include/asm-cris/bitops.h	Mon Nov 11 06:28:30 2002
+++ linux-2.5.64-ciba/include/asm-cris/bitops.h	Mon Mar 17 13:22:58 2003
@@ -360,7 +360,9 @@
 #define hweight8(x) generic_hweight8(x)
 
 #define ext2_set_bit                 test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
 #define ext2_clear_bit               test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux-2.5.64/include/asm-i386/bitops.h linux-2.5.64-ciba/include/asm-i386/bitops.h
--- linux-2.5.64/include/asm-i386/bitops.h	Wed Dec 25 06:03:08 2002
+++ linux-2.5.64-ciba/include/asm-i386/bitops.h	Mon Mar 17 13:22:58 2003
@@ -479,8 +479,12 @@
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_bit((nr),(unsigned long*)addr)
+#define ext2_set_bit_atomic(lock,nr,addr) \
+        test_and_set_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
 	__test_and_clear_bit((nr),(unsigned long*)addr)
+#define ext2_clear_bit_atomic(lock,nr, addr) \
+	        test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_bit((unsigned long*)addr, size)
diff -uNr linux-2.5.64/include/asm-ia64/bitops.h linux-2.5.64-ciba/include/asm-ia64/bitops.h
--- linux-2.5.64/include/asm-ia64/bitops.h	Thu Feb 20 16:18:21 2003
+++ linux-2.5.64-ciba/include/asm-ia64/bitops.h	Mon Mar 17 13:22:58 2003
@@ -453,7 +453,9 @@
 #define __clear_bit(nr, addr)        clear_bit(nr, addr)
 
 #define ext2_set_bit                 test_and_set_bit
+#define ext2_set_atomic(l,n,a)	     test_and_set_bit(n,a)
 #define ext2_clear_bit               test_and_clear_bit
+#define ext2_clear_atomic(l,n,a)     test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux-2.5.64/include/asm-m68k/bitops.h linux-2.5.64-ciba/include/asm-m68k/bitops.h
--- linux-2.5.64/include/asm-m68k/bitops.h	Mon Nov 11 06:28:33 2002
+++ linux-2.5.64-ciba/include/asm-m68k/bitops.h	Mon Mar 17 13:23:28 2003
@@ -365,6 +365,24 @@
 	return retval;
 }
 
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 extern __inline__ int
 ext2_test_bit (int nr, const volatile void *vaddr)
 {
diff -uNr linux-2.5.64/include/asm-m68knommu/bitops.h linux-2.5.64-ciba/include/asm-m68knommu/bitops.h
--- linux-2.5.64/include/asm-m68knommu/bitops.h	Mon Nov 11 06:28:04 2002
+++ linux-2.5.64-ciba/include/asm-m68knommu/bitops.h	Mon Mar 17 13:23:31 2003
@@ -402,6 +402,24 @@
 	return retval;
 }
 
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 extern __inline__ int ext2_test_bit(int nr, const volatile void * addr)
 {
 	int	mask;
diff -uNr linux-2.5.64/include/asm-mips/bitops.h linux-2.5.64-ciba/include/asm-mips/bitops.h
--- linux-2.5.64/include/asm-mips/bitops.h	Mon Nov 11 06:28:03 2002
+++ linux-2.5.64-ciba/include/asm-mips/bitops.h	Mon Mar 17 13:23:22 2003
@@ -824,6 +824,24 @@
 	return retval;
 }
 
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 extern __inline__ int ext2_test_bit(int nr, const void * addr)
 {
 	int			mask;
@@ -890,7 +908,9 @@
 
 /* Native ext2 byte ordering, just collapse using defines. */
 #define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
+#define ext2_set_bit_atomic(lock, nr, addr) test_and_set_bit((nr), (addr))
 #define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_clear_bit_atomic(lock, nr, addr) test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
diff -uNr linux-2.5.64/include/asm-mips64/bitops.h linux-2.5.64-ciba/include/asm-mips64/bitops.h
--- linux-2.5.64/include/asm-mips64/bitops.h	Mon Nov 11 06:28:29 2002
+++ linux-2.5.64-ciba/include/asm-mips64/bitops.h	Mon Mar 17 13:23:25 2003
@@ -531,6 +531,24 @@
 	return retval;
 }
 
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 extern inline int
 ext2_test_bit(int nr, const void * addr)
 {
@@ -599,7 +617,9 @@
 
 /* Native ext2 byte ordering, just collapse using defines. */
 #define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
+#define ext2_set_bit_atomic(lock, nr, addr) test_and_set_bit((nr), (addr))
 #define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_clear_bit_atomic(lock, nr, addr) test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
diff -uNr linux-2.5.64/include/asm-parisc/bitops.h linux-2.5.64-ciba/include/asm-parisc/bitops.h
--- linux-2.5.64/include/asm-parisc/bitops.h	Thu Feb 20 16:18:21 2003
+++ linux-2.5.64-ciba/include/asm-parisc/bitops.h	Mon Mar 17 13:22:58 2003
@@ -389,10 +389,14 @@
  */
 #ifdef __LP64__
 #define ext2_set_bit(nr, addr)		test_and_set_bit((nr) ^ 0x38, addr)
+#define ext2_set_bit_atomic(l,nr,addr)  test_and_set_bit((nr) ^ 0x38, addr)
 #define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x38, addr)
+#define ext2_clear_bit_atomic(l,nr,addr) test_and_clear_bit((nr) ^ 0x38, addr)
 #else
 #define ext2_set_bit(nr, addr)		test_and_set_bit((nr) ^ 0x18, addr)
+#define ext2_set_bit_atomic(l,nr,addr)  test_and_set_bit((nr) ^ 0x18, addr)
 #define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x18, addr)
+#define ext2_clear_bit_atomic(l,nr,addr) test_and_clear_bit((nr) ^ 0x18, addr)
 #endif
 
 #endif	/* __KERNEL__ */
diff -uNr linux-2.5.64/include/asm-ppc/bitops.h linux-2.5.64-ciba/include/asm-ppc/bitops.h
--- linux-2.5.64/include/asm-ppc/bitops.h	Mon Jan 20 05:23:05 2003
+++ linux-2.5.64-ciba/include/asm-ppc/bitops.h	Mon Mar 17 13:22:58 2003
@@ -392,7 +392,9 @@
 
 
 #define ext2_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_set_bit_atomic(lock, nr, addr)  test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
 #define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_clear_bit_atomic(lock, nr, addr) test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
 
 static __inline__ int ext2_test_bit(int nr, __const__ void * addr)
 {
diff -uNr linux-2.5.64/include/asm-ppc64/bitops.h linux-2.5.64-ciba/include/asm-ppc64/bitops.h
--- linux-2.5.64/include/asm-ppc64/bitops.h	Mon Nov 11 06:28:28 2002
+++ linux-2.5.64-ciba/include/asm-ppc64/bitops.h	Mon Mar 17 13:23:17 2003
@@ -338,6 +338,25 @@
 	__test_and_set_le_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
 	__test_and_clear_le_bit((nr),(unsigned long*)addr)
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 #define ext2_test_bit(nr, addr)      test_le_bit((nr),(unsigned long*)addr)
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_le_bit((unsigned long*)addr, size)
diff -uNr linux-2.5.64/include/asm-s390/bitops.h linux-2.5.64-ciba/include/asm-s390/bitops.h
--- linux-2.5.64/include/asm-s390/bitops.h	Fri Mar 14 01:53:27 2003
+++ linux-2.5.64-ciba/include/asm-s390/bitops.h	Mon Mar 17 13:22:58 2003
@@ -805,8 +805,12 @@
 
 #define ext2_set_bit(nr, addr)       \
 	test_and_set_bit((nr)^24, (unsigned long *)addr)
+#define ext2_set_bit_atomic(lock, nr, addr)       \
+	        test_and_set_bit((nr)^24, (unsigned long *)addr)
 #define ext2_clear_bit(nr, addr)     \
 	test_and_clear_bit((nr)^24, (unsigned long *)addr)
+#define ext2_clear_bit_atomic(lock, nr, addr)     \
+	        test_and_clear_bit((nr)^24, (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
 	test_bit((nr)^24, (unsigned long *)addr)
 
diff -uNr linux-2.5.64/include/asm-s390x/bitops.h linux-2.5.64-ciba/include/asm-s390x/bitops.h
--- linux-2.5.64/include/asm-s390x/bitops.h	Fri Mar 14 01:53:27 2003
+++ linux-2.5.64-ciba/include/asm-s390x/bitops.h	Mon Mar 17 13:22:58 2003
@@ -838,8 +838,12 @@
 
 #define ext2_set_bit(nr, addr)       \
 	test_and_set_bit((nr)^56, (unsigned long *)addr)
+#define ext2_set_bit_atomic(lock, nr, addr)       \
+	        test_and_set_bit((nr)^56, (unsigned long *)addr)
 #define ext2_clear_bit(nr, addr)     \
 	test_and_clear_bit((nr)^56, (unsigned long *)addr)
+#define ext2_clear_bit_atomic(lock, nr, addr)     \
+	        test_and_clear_bit((nr)^56, (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
 	test_bit((nr)^56, (unsigned long *)addr)
 
diff -uNr linux-2.5.64/include/asm-sh/bitops.h linux-2.5.64-ciba/include/asm-sh/bitops.h
--- linux-2.5.64/include/asm-sh/bitops.h	Mon Nov 11 06:28:02 2002
+++ linux-2.5.64-ciba/include/asm-sh/bitops.h	Mon Mar 17 13:23:33 2003
@@ -344,6 +344,24 @@
 }
 #endif
 
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
 #define minix_set_bit(nr,addr) set_bit(nr,addr)
diff -uNr linux-2.5.64/include/asm-sparc/bitops.h linux-2.5.64-ciba/include/asm-sparc/bitops.h
--- linux-2.5.64/include/asm-sparc/bitops.h	Mon Jan 20 05:23:05 2003
+++ linux-2.5.64-ciba/include/asm-sparc/bitops.h	Mon Mar 17 13:23:19 2003
@@ -455,6 +455,25 @@
 
 #define ext2_set_bit			__test_and_set_le_bit
 #define ext2_clear_bit			__test_and_clear_le_bit
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (addr));	\
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
 #define ext2_test_bit			test_le_bit
 #define ext2_find_first_zero_bit	find_first_zero_le_bit
 #define ext2_find_next_zero_bit		find_next_zero_le_bit
diff -uNr linux-2.5.64/include/asm-sparc64/bitops.h linux-2.5.64-ciba/include/asm-sparc64/bitops.h
--- linux-2.5.64/include/asm-sparc64/bitops.h	Mon Nov 11 06:28:05 2002
+++ linux-2.5.64-ciba/include/asm-sparc64/bitops.h	Mon Mar 17 13:22:58 2003
@@ -351,7 +351,9 @@
 #ifdef __KERNEL__
 
 #define ext2_set_bit(nr,addr)		test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define ext2_set_bit_atomic(lock,nr,addr) test_and_set_le_bit((nr),(unsigned long *)(addr))
 #define ext2_clear_bit(nr,addr)		test_and_clear_le_bit((nr),(unsigned long *)(addr))
+#define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_le_bit((nr),(unsigned long *)(addr))
 #define ext2_test_bit(nr,addr)		test_le_bit((nr),(unsigned long *)(addr))
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_le_bit((unsigned long *)(addr), (size))
diff -uNr linux-2.5.64/include/asm-v850/bitops.h linux-2.5.64-ciba/include/asm-v850/bitops.h
--- linux-2.5.64/include/asm-v850/bitops.h	Mon Nov 11 06:28:02 2002
+++ linux-2.5.64-ciba/include/asm-v850/bitops.h	Mon Mar 17 13:22:58 2003
@@ -252,7 +252,9 @@
 #define hweight8(x) 			generic_hweight8 (x)
 
 #define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
 #define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
diff -uNr linux-2.5.64/include/asm-x86_64/bitops.h linux-2.5.64-ciba/include/asm-x86_64/bitops.h
--- linux-2.5.64/include/asm-x86_64/bitops.h	Fri Mar 14 01:53:27 2003
+++ linux-2.5.64-ciba/include/asm-x86_64/bitops.h	Mon Mar 17 13:22:58 2003
@@ -487,8 +487,12 @@
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_bit((nr),(unsigned long*)addr)
+#define ext2_set_bit_atomic(lock,nr,addr) \
+	        test_and_set_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
 	__test_and_clear_bit((nr),(unsigned long*)addr)
+#define ext2_clear_bit_atomic(lock,nr,addr) \
+	        test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_bit((unsigned long*)addr, size)
diff -uNr linux-2.5.64/include/linux/dcounter.h linux-2.5.64-ciba/include/linux/dcounter.h
--- linux-2.5.64/include/linux/dcounter.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.64-ciba/include/linux/dcounter.h	Mon Mar 17 13:26:05 2003
@@ -0,0 +1,85 @@
+#ifndef _DCOUNTER_H_
+#define _DCOUNTER_H_
+/*
+ * Distrubuted counters:
+ * 
+ * Problem:
+ *   1) we have to support global counter for some subsystems
+ *      for example, ext2
+ *   2) we do not want to use spinlocks/atomic_t because of cache ping-pong
+ *   3) counter may have some fluctuation
+ *      for example, number of free blocks in ext2
+ *
+ * Solution:
+ *   1) there is 'base' counter
+ *   2) each CPU supports own 'diff'
+ *   3) global value calculated as sum of base and all diff'es
+ *   4) sometimes diff goes to base in order to prevent int overflow.
+ *      this 'syncronization' uses seqlock
+ *   
+ *
+ *   written by Alex Tomas <bzzz@tmi.comex.ru>
+ */
+
+#include <linux/smp.h>
+#include <linux/seqlock.h>
+#include <linux/string.h>
+
+#define DCOUNTER_MAX_DIFF	((1 << 31) / NR_CPUS - 1000)
+
+struct dcounter_diff {
+	long dd_value; 
+} ____cacheline_aligned_in_smp;
+
+struct dcounter {
+	long dc_base;
+	long dc_min;
+	struct dcounter_diff dc_diff[NR_CPUS];
+	seqlock_t dc_lock;
+};
+
+static inline void dcounter_init(struct dcounter *dc, int value, int min)
+{
+	seqlock_init(&dc->dc_lock);
+	dc->dc_base = value;
+	dc->dc_min = min;
+	memset(dc->dc_diff, 0, sizeof(struct dcounter_diff) * NR_CPUS);
+}
+
+static inline int dcounter_value(struct dcounter *dc)
+{
+	int i;
+	int counter;
+	int seq;
+
+	do {
+		seq = read_seqbegin(&dc->dc_lock);
+		counter = dc->dc_base;
+		for (i = 0; i < NR_CPUS; i++)
+			counter += dc->dc_diff[i].dd_value;
+	} while (read_seqretry(&dc->dc_lock, seq));
+
+	if (counter < dc->dc_min)
+		counter = dc->dc_min;	
+	return counter;
+}
+
+static inline void dcounter_add(struct dcounter *dc, int value)
+{
+	int cpu;
+	
+	preempt_disable();
+	cpu = smp_processor_id();
+	dc->dc_diff[cpu].dd_value += value;
+	if (dc->dc_diff[cpu].dd_value > DCOUNTER_MAX_DIFF ||
+		dc->dc_diff[cpu].dd_value < -DCOUNTER_MAX_DIFF) {
+		write_seqlock(&dc->dc_lock);
+		dc->dc_base += dc->dc_diff[cpu].dd_value;
+		dc->dc_diff[cpu].dd_value = 0;
+		write_sequnlock(&dc->dc_lock);
+	}
+	preempt_enable();
+}
+
+#endif /* _DCOUNTER_H_ */
+
diff -uNr linux-2.5.64/include/linux/ext2_fs_sb.h linux-2.5.64-ciba/include/linux/ext2_fs_sb.h
--- linux-2.5.64/include/linux/ext2_fs_sb.h	Mon Nov 11 06:28:30 2002
+++ linux-2.5.64-ciba/include/linux/ext2_fs_sb.h	Mon Mar 17 13:26:05 2003
@@ -16,6 +16,15 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB
 
+#include <linux/dcounter.h>
+
+struct ext2_bg_info {
+	u8 debts;
+	spinlock_t balloc_lock;
+	spinlock_t ialloc_lock;
+	unsigned int reserved;
+} ____cacheline_aligned_in_smp;
+
 /*
  * second extended-fs super-block data in memory
  */
@@ -44,7 +53,10 @@
 	int s_first_ino;
 	u32 s_next_generation;
 	unsigned long s_dir_count;
-	u8 *s_debts;
+	struct ext2_bg_info *s_bgi;
+	struct dcounter free_blocks_dc;
+	struct dcounter free_inodes_dc;
+	struct dcounter dirs_dc;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */



