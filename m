Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263261AbTCNHR7>; Fri, 14 Mar 2003 02:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263262AbTCNHR7>; Fri, 14 Mar 2003 02:17:59 -0500
Received: from comtv.ru ([217.10.32.4]:19075 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S263261AbTCNHRm>;
	Fri, 14 Mar 2003 02:17:42 -0500
X-Comment-To: Andreas Dilger
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 14 Mar 2003 10:20:24 +0300
Message-ID: <m38yvixvlz.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

>>>>> Andreas Dilger (AD) writes:

 AD> First of all, thanks for this work, Alex.  It's been a long time
 AD> in coming.  One thing I would wonder about is whether we should
 AD> be implementing this in ext2, or in ext3 only.  One of the
 AD> decisions we made in the past is that we shouldn't necessarily
 AD> implement everything in ext2 (especially features that
 AD> complicated the code, and are only useful on high-end systems).

well. ext2 in 2.4 have a lot of BKL. ext2 in 2.5 is almost free from
BKL. I think concurrent balloc is just one more step in this direction.

 AD> I would suggest just hooking the ext2_group_desc (and the
 AD> buffer_head in which it lives) off of the ext2_bg_info array
 AD> instead of passing both around explicitly.  Since we have
 AD> ext2_bg_info as a group_number-indexed array already, this would
 AD> essentially mean that wherever we call ext2_get_group_desc() we
 AD> could just use sbi->bgi[group].desc (or make
 AD> ext2_get_group_desc() do that, if we don't need it to populate
 AD> bgi[group].desc in the first place).

it make sense. what about to make it by separate patch?
just to prevent huge concurrent-balloc.diff


 >> + root_blocks = bgi->reserved;

 AD> I would avoid calling this "root_blocks" and instead just use
 AD> "bgi->reserved" or "reserved_blocks" everywhere.  The original
 AD> intent of these blocks was to reduce fragmentation and not
 AD> necessarily reserved-for-root.

fixed

 >> + if (free_blocks < root_blocks + count &&
 >> !capable(CAP_SYS_RESOURCE) && + sbi->s_resuid != current->fsuid &&
 >> + (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) { + /* + *
 >> We are too close to reserve and we are not privileged.  + * Can we
 >> allocate anything at all?  + */ + if (free_blocks > root_blocks) +
 >> count = free_blocks - root_blocks; + else { +
 >> spin_unlock(&bgi->alloc_lock); + return 0; + }

 AD> Per my other email, if we want to handle large files properly by
 AD> allowing them to fill the entire group, yet we want to keep the
 AD> "reserved blocks" count correct, we could always grab the lock on
 AD> the last group and add reserved blocks there.  Or, we could just
 AD> ignore the reserved blocks count entirely.

hmm. looks I miss something here. reservation is protected by the lock.
what's the problem?

 >> unsigned long ext2_count_free_blocks (struct super_block * sb)
 >> :
 >> - return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_blocks_count); +
 >> for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) { + desc =
 >> ext2_get_group_desc (sb, i, NULL); + if (!desc) + continue; +
 >> desc_count += le16_to_cpu(desc->bg_free_blocks_count); + } +
 >> return desc_count; #endif

this code doesn't use lock. if you mean code under EXT2FS_DEBUG then
Andrew already pointed out that this code is broken and should be fixed.

 AD> In general, this should be safe to do without a lock, since it is
 AD> only used for heuristics (orlov) and statfs (which is out-of-date
 AD> as soon as we call it).  Are there any other users of
 AD> ext2_count_free_blocks() that need a correct value?  I suppose
 AD> mount/unmount to set s_free_blocks_count, but those probably have
 AD> exclusive access to the filesystem anyways.

there is no more user of ext2_count_free_block() who needs precise counter.
find_group_orlov() uses it, but I think this routine doesn't need this
loop is serialized against block reservation.

 AD> PS - it looks like you are using spaces for indents instead of
 AD> tabs here...

I just use vim ;)

 >> + if (le32_to_cpu(es->s_free_blocks_count) != total_free) +
 >> printk(KERN_INFO "EXT2-fs: last umount wasn't clean. correct free
 >> blocks counter\n");

 AD> Probably no need to print this for ext2, since there is already
 AD> an "uncleanly unmounted" flag in the superblock, and e2fsck will
 AD> have otherwise fixed it up.

fixed. in fact. it was 'debug for myself'.

 AD> I'm not sure whether I agree with this or not...  If a group ever
 AD> exceeds the reserved mark for some reason (e.g. full filesystem)
 AD> it will never be able to "improve itself" back to a decent amount
 AD> of reserved blocks.  That said, you may want to only reduce
 AD> "reserved" by "free" in the end, so that the total amount of
 AD> reserved blocks is kept constant.  need to re-calculate
 AD> "per_group" for each loop).

well, I believe reserved blocks may be really _reserved_ at the end of
the fs. simple because of nobody should use them until fs is almost full.

 >> extern __inline__ int +ext2_set_bit_atomic (spinlock_t *lock, int
 >> nr, volatile void *vaddr)

 AD> Please don't use "extern __inline__", as that can cause all sorts
 AD> of grief.  Either "static inline" or just "extern".

fixed

 >> +struct ext2_bg_info { + u8 debts; + spinlock_t alloc_lock; +
 >> unsigned int reserved; +};

 AD> Please rename this "balloc_lock", as it is likely that we will
 AD> get an "ialloc_lock" in the future also.

this makes sense as well.


and corrected patch:



diff -uNr linux/fs/ext2/balloc.c edited/fs/ext2/balloc.c
--- linux/fs/ext2/balloc.c	Thu Feb 20 16:18:53 2003
+++ edited/fs/ext2/balloc.c	Fri Mar 14 09:54:11 2003
@@ -94,69 +94,62 @@
 	return bh;
 }
 
-static inline int reserve_blocks(struct super_block *sb, int count)
+static inline int group_reserve_blocks(struct ext2_sb_info *sbi, struct ext2_bg_info *bgi, 
+					struct ext2_group_desc *desc,
+					struct buffer_head *bh, int count, int use_reserve)
 {
-	struct ext2_sb_info * sbi = EXT2_SB(sb);
-	struct ext2_super_block * es = sbi->s_es;
-	unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
-	unsigned root_blocks = le32_to_cpu(es->s_r_blocks_count);
+	unsigned free_blocks;
+	unsigned root_blocks;
 
+	spin_lock(&bgi->balloc_lock);
+	
+	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 	if (free_blocks < count)
 		count = free_blocks;
+	root_blocks = bgi->reserved;
 
-	if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
-	    sbi->s_resuid != current->fsuid &&
-	    (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
-		/*
-		 * We are too close to reserve and we are not privileged.
-		 * Can we allocate anything at all?
-		 */
-		if (free_blocks > root_blocks)
-			count = free_blocks - root_blocks;
-		else
-			return 0;
+	if (free_blocks <  bgi->reserved && !use_reserve) {
+		/* don't use reserved blocks */
+		spin_unlock(&bgi->balloc_lock);
+		return 0;
 	}
-
-	es->s_free_blocks_count = cpu_to_le32(free_blocks - count);
-	mark_buffer_dirty(sbi->s_sbh);
-	sb->s_dirt = 1;
-	return count;
-}
-
-static inline void release_blocks(struct super_block *sb, int count)
-{
-	if (count) {
-		struct ext2_sb_info * sbi = EXT2_SB(sb);
-		struct ext2_super_block * es = sbi->s_es;
-		unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
-		es->s_free_blocks_count = cpu_to_le32(free_blocks + count);
-		mark_buffer_dirty(sbi->s_sbh);
-		sb->s_dirt = 1;
+	
+        if (free_blocks <  bgi->reserved + count && !capable(CAP_SYS_RESOURCE) &&
+            sbi->s_resuid != current->fsuid &&
+            (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
+                /*
+                 * We are too close to reserve and we are not privileged.
+                 * Can we allocate anything at all?
+                 */
+                if (free_blocks > bgi->reserved)
+                        count = free_blocks - bgi->reserved;
+                else {
+			spin_unlock(&bgi->balloc_lock);
+                        return 0;
+		}
 	}
-}
-
-static inline int group_reserve_blocks(struct ext2_group_desc *desc,
-				    struct buffer_head *bh, int count)
-{
-	unsigned free_blocks;
-
-	if (!desc->bg_free_blocks_count)
-		return 0;
-
-	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
-	if (free_blocks < count)
-		count = free_blocks;
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
+	
+	spin_unlock(&bgi->balloc_lock);
+
 	mark_buffer_dirty(bh);
 	return count;
 }
 
-static inline void group_release_blocks(struct ext2_group_desc *desc,
-				    struct buffer_head *bh, int count)
+static inline void group_release_blocks(struct ext2_bg_info *bgi,
+					struct ext2_group_desc *desc,
+					struct buffer_head *bh, int count)
 {
 	if (count) {
-		unsigned free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
+		unsigned free_blocks;
+		
+		spin_lock(&bgi->balloc_lock);
+		
+		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
+		
+		spin_unlock(&bgi->balloc_lock);
+		
 		mark_buffer_dirty(bh);
 	}
 }
@@ -172,12 +165,11 @@
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
@@ -215,16 +207,17 @@
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
@@ -236,7 +229,7 @@
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	group_release_blocks(desc, bh2, group_freed);
+	group_release_blocks(&sbi->s_bgi[block_group], desc, bh2, group_freed);
 	freed += group_freed;
 
 	if (overflow) {
@@ -246,18 +239,18 @@
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
@@ -297,7 +290,8 @@
 	}
 	return -1;
 got_it:
-	ext2_set_bit(goal, map);
+	if (ext2_set_bit_atomic(lock, goal, (void *) map)) 
+		goto repeat;	
 	return goal;
 }
 
@@ -319,7 +313,7 @@
 	int ret_block;			/* j */
 	int bit;		/* k */
 	int target_block;		/* tmp */
-	int block = 0;
+	int block = 0, use_reserve = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
@@ -341,14 +335,7 @@
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
 
@@ -360,7 +347,8 @@
 	if (!desc)
 		goto io_error;
 
-	group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+	group_alloc = group_reserve_blocks(sbi, &sbi->s_bgi[group_no],
+					desc, gdp_bh, es_alloc, 0);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 					group_size);
@@ -371,11 +359,12 @@
 		
 		ext2_debug("goal is at %d:%d.\n", group_no, ret_block);
 
-		ret_block = grab_block(bitmap_bh->b_data,
+		ret_block = grab_block(&sbi->s_bgi[group_no].balloc_lock,
+				bitmap_bh->b_data,
 				group_size, ret_block);
 		if (ret_block >= 0)
 			goto got_block;
-		group_release_blocks(desc, gdp_bh, group_alloc);
+		group_release_blocks(&sbi->s_bgi[group_no], desc, gdp_bh, group_alloc);
 		group_alloc = 0;
 	}
 
@@ -385,6 +374,7 @@
 	 * Now search the rest of the groups.  We assume that 
 	 * i and desc correctly point to the last group visited.
 	 */
+repeat:
 	for (bit = 0; !group_alloc &&
 			bit < sbi->s_groups_count; bit++) {
 		group_no++;
@@ -393,7 +383,16 @@
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+		group_alloc = group_reserve_blocks(sbi, &sbi->s_bgi[group_no],
+						desc, gdp_bh, es_alloc, use_reserve);
+	}
+	if (!use_reserve) {
+		/* first time we did not try to allocate
+		 * reserved blocks. now it looks like
+		 * no more non-reserved blocks left. we
+		 * will try to allocate reserved blocks -bzzz */
+		use_reserve = 1;
+		goto repeat;
 	}
 	if (bit >= sbi->s_groups_count) {
 		*err = -ENOSPC;
@@ -404,13 +403,11 @@
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
@@ -452,7 +449,8 @@
 		unsigned n;
 
 		for (n = 0; n < group_alloc && ++ret_block < group_size; n++) {
-			if (ext2_set_bit(ret_block, bitmap_bh->b_data))
+			if (ext2_set_bit_atomic(&sbi->s_bgi[group_no].balloc_lock,
+						ret_block, (void*) bitmap_bh->b_data))
  				break;
 		}
 		*prealloc_block = block + 1;
@@ -471,10 +469,7 @@
 
 	*err = 0;
 out_release:
-	group_release_blocks(desc, gdp_bh, group_alloc);
-	release_blocks(sb, es_alloc);
-out_unlock:
-	unlock_super (sb);
+	group_release_blocks(&sbi->s_bgi[group_no], desc, gdp_bh, group_alloc);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);
 out:
 	brelse(bitmap_bh);
@@ -487,11 +482,11 @@
 
 unsigned long ext2_count_free_blocks (struct super_block * sb)
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
@@ -519,7 +514,13 @@
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
 
diff -uNr linux/fs/ext2/ialloc.c edited/fs/ext2/ialloc.c
--- linux/fs/ext2/ialloc.c	Fri Mar 14 01:53:36 2003
+++ edited/fs/ext2/ialloc.c	Thu Mar 13 20:08:58 2003
@@ -278,7 +278,8 @@
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
 	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
-	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int free_blocks = ext2_count_free_blocks(sb);
+	int avefreeb = free_blocks / ngroups;
 	int blocks_per_dir;
 	int ndirs = sbi->s_dir_count;
 	int max_debt, max_dirs, min_blocks, min_inodes;
@@ -320,8 +321,7 @@
 		goto fallback;
 	}
 
-	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) -
-			  le32_to_cpu(es->s_free_blocks_count)) / ndirs;
+	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) - free_blocks) / ndirs;
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
 	min_inodes = avefreei - inodes_per_group / 4;
@@ -340,7 +340,7 @@
 		desc = ext2_get_group_desc (sb, group, &bh);
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
-		if (sbi->s_debts[group] >= max_debt)
+		if (sbi->s_bgi[group].debts >= max_debt)
 			continue;
 		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
 			continue;
@@ -501,11 +501,11 @@
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 
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
 
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
diff -uNr linux/fs/ext2/super.c edited/fs/ext2/super.c
--- linux/fs/ext2/super.c	Thu Feb 20 16:18:53 2003
+++ edited/fs/ext2/super.c	Fri Mar 14 10:10:09 2003
@@ -141,7 +141,7 @@
 		if (sbi->s_group_desc[i])
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	kfree(sbi->s_debts);
+	kfree(sbi->s_bgi);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -464,8 +464,11 @@
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
 
@@ -504,6 +507,27 @@
 		block += EXT2_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
+	
+	/* restore free blocks counter in SB -bzzz */
+	es->s_free_blocks_count = total_free = ext2_count_free_blocks(sb);
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
 
@@ -768,13 +792,17 @@
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
+	}
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
@@ -820,8 +848,8 @@
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
@@ -840,6 +868,7 @@
 
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
+	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
 	es->s_wtime = cpu_to_le32(get_seconds());
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
@@ -868,6 +897,7 @@
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
+			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
 			es->s_mtime = cpu_to_le32(get_seconds());
 			ext2_sync_super(sb, es);
 		} else
@@ -929,7 +959,8 @@
 static int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long overhead;
+	unsigned long overhead, total_free = 0;
+	struct ext2_group_desc *desc;
 	int i;
 
 	if (test_opt (sb, MINIX_DF))
@@ -950,9 +981,14 @@
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
@@ -965,7 +1001,7 @@
 	buf->f_type = EXT2_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = le32_to_cpu(sbi->s_es->s_blocks_count) - overhead;
-	buf->f_bfree = ext2_count_free_blocks (sb);
+	buf->f_bfree = total_free;
 	buf->f_bavail = buf->f_bfree - le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (buf->f_bfree < le32_to_cpu(sbi->s_es->s_r_blocks_count))
 		buf->f_bavail = 0;
diff -uNr linux/include/asm-alpha/bitops.h edited/include/asm-alpha/bitops.h
--- linux/include/asm-alpha/bitops.h	Fri Mar 14 01:53:36 2003
+++ edited/include/asm-alpha/bitops.h	Thu Mar 13 14:10:18 2003
@@ -487,7 +487,9 @@
 
 
 #define ext2_set_bit                 __test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
 #define ext2_clear_bit               __test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux/include/asm-arm/bitops.h edited/include/asm-arm/bitops.h
--- linux/include/asm-arm/bitops.h	Fri Mar 14 01:53:36 2003
+++ edited/include/asm-arm/bitops.h	Thu Mar 13 14:10:46 2003
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
diff -uNr linux/include/asm-cris/bitops.h edited/include/asm-cris/bitops.h
--- linux/include/asm-cris/bitops.h	Mon Nov 11 06:28:30 2002
+++ edited/include/asm-cris/bitops.h	Thu Mar 13 14:11:15 2003
@@ -360,7 +360,9 @@
 #define hweight8(x) generic_hweight8(x)
 
 #define ext2_set_bit                 test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
 #define ext2_clear_bit               test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux/include/asm-i386/bitops.h edited/include/asm-i386/bitops.h
--- linux/include/asm-i386/bitops.h	Wed Dec 25 06:03:08 2002
+++ edited/include/asm-i386/bitops.h	Thu Mar 13 14:11:32 2003
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
diff -uNr linux/include/asm-ia64/bitops.h edited/include/asm-ia64/bitops.h
--- linux/include/asm-ia64/bitops.h	Thu Feb 20 16:18:21 2003
+++ edited/include/asm-ia64/bitops.h	Thu Mar 13 14:12:50 2003
@@ -453,7 +453,9 @@
 #define __clear_bit(nr, addr)        clear_bit(nr, addr)
 
 #define ext2_set_bit                 test_and_set_bit
+#define ext2_set_atomic(l,n,a)	     test_and_set_bit(n,a)
 #define ext2_clear_bit               test_and_clear_bit
+#define ext2_clear_atomic(l,n,a)     test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
diff -uNr linux/include/asm-m68k/bitops.h edited/include/asm-m68k/bitops.h
--- linux/include/asm-m68k/bitops.h	Mon Nov 11 06:28:33 2002
+++ edited/include/asm-m68k/bitops.h	Fri Mar 14 10:00:15 2003
@@ -354,6 +354,16 @@
 	return retval;
 }
 
+static inline int
+ext2_set_bit_atomic (spinlock_t *lock, int nr, volatile void *vaddr)
+{
+	int ret;
+	spin_lock(lock);
+	ret = ext2_set_bit(nr, vaddr);
+	spin_unlock(lock);
+	return ret;
+}
+
 extern __inline__ int
 ext2_clear_bit (int nr, volatile void *vaddr)
 {
@@ -365,6 +375,16 @@
 	return retval;
 }
 
+static inline int
+ext2_clear_bit_atomic (spinlock_t *lock, int nr, volatile void *vaddr)
+{       
+        int ret;
+        spin_lock(lock);
+        ret = ext2_clear_bit(nr, vaddr);
+        spin_unlock(lock);
+        return ret;
+}       
+
 extern __inline__ int
 ext2_test_bit (int nr, const volatile void *vaddr)
 {
diff -uNr linux/include/asm-m68knommu/bitops.h edited/include/asm-m68knommu/bitops.h
--- linux/include/asm-m68knommu/bitops.h	Mon Nov 11 06:28:04 2002
+++ edited/include/asm-m68knommu/bitops.h	Fri Mar 14 10:00:52 2003
@@ -387,6 +387,16 @@
 	return retval;
 }
 
+static inline int ext2_set_bit_atomic(spinlock_t *lock, int nr,
+		volatile void * addr)
+{
+        int ret;
+	spin_lock(lock);
+	ret = ext2_set_bit(nr, addr);
+	spin_unlock(lock);
+	return ret;
+}
+
 extern __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
@@ -402,6 +412,16 @@
 	return retval;
 }
 
+static inline int ext2_clear_bit_atomic(spinlock_t *lock, int nr,
+                volatile void * addr)
+{
+        int ret;
+        spin_lock(lock);
+        ret = ext2_clear_bit(nr, addr);
+        spin_unlock(lock);
+        return ret;
+}
+
 extern __inline__ int ext2_test_bit(int nr, const volatile void * addr)
 {
 	int	mask;
diff -uNr linux/include/asm-mips/bitops.h edited/include/asm-mips/bitops.h
--- linux/include/asm-mips/bitops.h	Mon Nov 11 06:28:03 2002
+++ edited/include/asm-mips/bitops.h	Fri Mar 14 10:01:22 2003
@@ -810,6 +810,15 @@
 	return retval;
 }
 
+static inline int ext2_set_bit_atomic(spinlock_t * lock, int nr, void * addr)
+{
+	int ret;
+	spin_lock(lock);
+	ret = ext2_set_bit(nr, addr);
+	spin_unlock(lock);
+	return ret;
+}
+
 extern __inline__ int ext2_clear_bit(int nr, void * addr)
 {
 	int		mask, retval, flags;
@@ -824,6 +833,15 @@
 	return retval;
 }
 
+static inline int ext2_clear_bit_atomic(spinlock_t * lock, int nr, void * addr)
+{       
+        int ret;
+        spin_lock(lock);
+        ret = ext2_clear_bit(nr, addr);
+        spin_unlock(lock);
+        return ret;
+}
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
diff -uNr linux/include/asm-mips64/bitops.h edited/include/asm-mips64/bitops.h
--- linux/include/asm-mips64/bitops.h	Mon Nov 11 06:28:29 2002
+++ edited/include/asm-mips64/bitops.h	Fri Mar 14 10:01:46 2003
@@ -516,6 +516,16 @@
 	return retval;
 }
 
+static inline int
+ext2_set_bit_atomic(spinlock_t * lock, int nr, void * addr)
+{
+        int ret;
+        spin_lock(lock);
+        ret = ext2_set_bit(nr, addr);
+        spin_unlock(lock);
+        return ret;
+}
+
 extern inline int
 ext2_clear_bit(int nr, void * addr)
 {
@@ -531,6 +541,16 @@
 	return retval;
 }
 
+static inline int
+ext2_clear_bit_atomic(spinlock_t * lock, int nr, void * addr)
+{
+        int ret;
+        spin_lock(lock);
+        ret = ext2_clear_bit(nr, addr);
+        spin_unlock(lock);
+        return ret;
+}
+
 extern inline int
 ext2_test_bit(int nr, const void * addr)
 {
@@ -599,7 +619,9 @@
 
 /* Native ext2 byte ordering, just collapse using defines. */
 #define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
+#define ext2_set_bit_atomic(lock, nr, addr) test_and_set_bit((nr), (addr))
 #define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_clear_bit_atomic(lock, nr, addr) test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
diff -uNr linux/include/asm-parisc/bitops.h edited/include/asm-parisc/bitops.h
--- linux/include/asm-parisc/bitops.h	Thu Feb 20 16:18:21 2003
+++ edited/include/asm-parisc/bitops.h	Thu Mar 13 14:29:47 2003
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
diff -uNr linux/include/asm-ppc/bitops.h edited/include/asm-ppc/bitops.h
--- linux/include/asm-ppc/bitops.h	Mon Jan 20 05:23:05 2003
+++ edited/include/asm-ppc/bitops.h	Thu Mar 13 14:31:00 2003
@@ -392,7 +392,9 @@
 
 
 #define ext2_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_set_bit_atomic(lock, nr, addr)  test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
 #define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_clear_bit_atomic(lock, nr, addr) test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
 
 static __inline__ int ext2_test_bit(int nr, __const__ void * addr)
 {
diff -uNr linux/include/asm-ppc64/bitops.h edited/include/asm-ppc64/bitops.h
--- linux/include/asm-ppc64/bitops.h	Mon Nov 11 06:28:28 2002
+++ edited/include/asm-ppc64/bitops.h	Thu Mar 13 14:32:23 2003
@@ -336,8 +336,12 @@
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_le_bit((nr),(unsigned long*)addr)
+#define ext2_set_bit_atomic(lock, nr,addr) \
+	        test_and_set_le_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
 	__test_and_clear_le_bit((nr),(unsigned long*)addr)
+#define ext2_clear_bit_atomic(lock, nr, addr) \
+	        test_and_clear_le_bit((nr),(unsigned long*)addr)
 #define ext2_test_bit(nr, addr)      test_le_bit((nr),(unsigned long*)addr)
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_le_bit((unsigned long*)addr, size)
diff -uNr linux/include/asm-s390/bitops.h edited/include/asm-s390/bitops.h
--- linux/include/asm-s390/bitops.h	Fri Mar 14 01:53:27 2003
+++ edited/include/asm-s390/bitops.h	Thu Mar 13 14:33:55 2003
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
 
diff -uNr linux/include/asm-s390x/bitops.h edited/include/asm-s390x/bitops.h
--- linux/include/asm-s390x/bitops.h	Fri Mar 14 01:53:27 2003
+++ edited/include/asm-s390x/bitops.h	Thu Mar 13 14:35:22 2003
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
 
diff -uNr linux/include/asm-sh/bitops.h edited/include/asm-sh/bitops.h
--- linux/include/asm-sh/bitops.h	Mon Nov 11 06:28:02 2002
+++ edited/include/asm-sh/bitops.h	Fri Mar 14 10:03:08 2003
@@ -265,6 +265,16 @@
 	return retval;
 }
 
+static inline int ext2_set_bit_atomic(spinlock_t *lock,
+		int nr, volatile void * addr)
+{
+	int ret;
+	spin_lock(lock);
+	ret = ext2_set_bit(nr, addr);
+	spin_unlock(lock);
+	return ret;
+}
+
 static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
@@ -280,6 +290,16 @@
 	return retval;
 }
 
+static inline int ext2_clear_bit_atomic(spinlock_t *lock,
+                int nr, volatile void * addr)
+{       
+        int ret;
+        spin_lock(lock);
+        ret = ext2_clear_bit(nr, addr);
+        spin_unlock(lock);
+        return ret;
+}       
+
 static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
 {
 	int			mask;
diff -uNr linux/include/asm-sparc/bitops.h edited/include/asm-sparc/bitops.h
--- linux/include/asm-sparc/bitops.h	Mon Jan 20 05:23:05 2003
+++ edited/include/asm-sparc/bitops.h	Thu Mar 13 14:38:54 2003
@@ -454,7 +454,9 @@
         find_next_zero_le_bit((addr), (size), 0)
 
 #define ext2_set_bit			__test_and_set_le_bit
+#define ext2_set_bit_atomic(l,n,a)      test_and_set_le_bit(n,a)
 #define ext2_clear_bit			__test_and_clear_le_bit
+#define ext2_clear_bit_atomic(l,n,a)    test_and_clear_le_bit(n,a)
 #define ext2_test_bit			test_le_bit
 #define ext2_find_first_zero_bit	find_first_zero_le_bit
 #define ext2_find_next_zero_bit		find_next_zero_le_bit
diff -uNr linux/include/asm-sparc64/bitops.h edited/include/asm-sparc64/bitops.h
--- linux/include/asm-sparc64/bitops.h	Mon Nov 11 06:28:05 2002
+++ edited/include/asm-sparc64/bitops.h	Thu Mar 13 14:43:49 2003
@@ -351,7 +351,9 @@
 #ifdef __KERNEL__
 
 #define ext2_set_bit(nr,addr)		test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define ext2_set_bit_atomic(lock,nr,addr) test_and_set_le_bit((nr),(unsigned long *)(addr))
 #define ext2_clear_bit(nr,addr)		test_and_clear_le_bit((nr),(unsigned long *)(addr))
+#define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_le_bit((nr),(unsigned long *)(addr))
 #define ext2_test_bit(nr,addr)		test_le_bit((nr),(unsigned long *)(addr))
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_le_bit((unsigned long *)(addr), (size))
diff -uNr linux/include/asm-v850/bitops.h edited/include/asm-v850/bitops.h
--- linux/include/asm-v850/bitops.h	Mon Nov 11 06:28:02 2002
+++ edited/include/asm-v850/bitops.h	Thu Mar 13 14:44:48 2003
@@ -252,7 +252,9 @@
 #define hweight8(x) 			generic_hweight8 (x)
 
 #define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
 #define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
diff -uNr linux/include/asm-x86_64/bitops.h edited/include/asm-x86_64/bitops.h
--- linux/include/asm-x86_64/bitops.h	Fri Mar 14 01:53:27 2003
+++ edited/include/asm-x86_64/bitops.h	Thu Mar 13 14:45:56 2003
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
diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h	Mon Nov 11 06:28:30 2002
+++ edited/include/linux/ext2_fs_sb.h	Fri Mar 14 09:51:10 2003
@@ -16,6 +16,12 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB
 
+struct ext2_bg_info {
+	u8 debts;
+	spinlock_t balloc_lock;
+	unsigned int reserved;
+} ____cacheline_aligned_in_smp;
+
 /*
  * second extended-fs super-block data in memory
  */
@@ -44,7 +50,7 @@
 	int s_first_ino;
 	u32 s_next_generation;
 	unsigned long s_dir_count;
-	u8 *s_debts;
+	struct ext2_bg_info *s_bgi;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */


