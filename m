Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbTCMIwj>; Thu, 13 Mar 2003 03:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbTCMIwj>; Thu, 13 Mar 2003 03:52:39 -0500
Received: from comtv.ru ([217.10.32.4]:62943 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262198AbTCMIwf>;
	Thu, 13 Mar 2003 03:52:35 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>,
       Alex Tomas <bzzz@tmi.comex.ru>
Subject: [PATCH] concurrent block allocation for ext2 against 2.5.64
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 13 Mar 2003 11:55:32 +0300
Message-ID: <m3el5bmyrf.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

as Andrew said, concurrent balloc for ext3 is useless because of BKL.
and I saw it in benchmarks. but it may be useful for ext2.

Results:
         9/100000   9/500000   16/100000  16/500000  32/100000  32/500000
ext2:    0m9.260s   0m46.160s  0m18.133s  1m33.553s  0m35.958s  3m4.164s
ext2-ca: 0m8.578s   0m42.712s  0m17.412s  1m28.637s  0m33.736s  2m53.824s

in those benchmarks, I run 2 process, each of them writes N blocks 
(9, 16, 32), truncates file and repeat these steps M times (100000, 500000).




diff -uNr linux/fs/ext2/balloc.c edited/fs/ext2/balloc.c
--- linux/fs/ext2/balloc.c	Thu Feb 20 16:18:53 2003
+++ edited/fs/ext2/balloc.c	Thu Mar 13 10:54:50 2003
@@ -98,9 +98,13 @@
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es = sbi->s_es;
-	unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
-	unsigned root_blocks = le32_to_cpu(es->s_r_blocks_count);
+	unsigned free_blocks;
+	unsigned root_blocks;
 
+	spin_lock(&sbi->s_alloc_lock);
+	
+	free_blocks = le32_to_cpu(es->s_free_blocks_count);
+	root_blocks = le32_to_cpu(es->s_r_blocks_count);	
 	if (free_blocks < count)
 		count = free_blocks;
 
@@ -113,11 +117,16 @@
 		 */
 		if (free_blocks > root_blocks)
 			count = free_blocks - root_blocks;
-		else
+		else {
+			spin_unlock(&sbi->s_alloc_lock);
 			return 0;
+		}
 	}
 
 	es->s_free_blocks_count = cpu_to_le32(free_blocks - count);
+	
+	spin_unlock(&sbi->s_alloc_lock);
+	
 	mark_buffer_dirty(sbi->s_sbh);
 	sb->s_dirt = 1;
 	return count;
@@ -128,35 +137,54 @@
 	if (count) {
 		struct ext2_sb_info * sbi = EXT2_SB(sb);
 		struct ext2_super_block * es = sbi->s_es;
-		unsigned free_blocks = le32_to_cpu(es->s_free_blocks_count);
+		unsigned free_blocks;
+		
+		spin_lock(&sbi->s_alloc_lock);
+		free_blocks = le32_to_cpu(es->s_free_blocks_count);
 		es->s_free_blocks_count = cpu_to_le32(free_blocks + count);
+		spin_unlock(&sbi->s_alloc_lock);
+		
 		mark_buffer_dirty(sbi->s_sbh);
 		sb->s_dirt = 1;
 	}
 }
 
-static inline int group_reserve_blocks(struct ext2_group_desc *desc,
+static inline int group_reserve_blocks(struct ext2_sb_info *sbi, struct ext2_group_desc *desc,
 				    struct buffer_head *bh, int count)
 {
 	unsigned free_blocks;
 
-	if (!desc->bg_free_blocks_count)
+	spin_lock(&sbi->s_alloc_lock);
+	
+	if (!desc->bg_free_blocks_count) {
+		 spin_unlock(&sbi->s_alloc_lock);
 		return 0;
+	}
 
 	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 	if (free_blocks < count)
 		count = free_blocks;
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
+	
+	spin_unlock(&sbi->s_alloc_lock);
+
 	mark_buffer_dirty(bh);
 	return count;
 }
 
-static inline void group_release_blocks(struct ext2_group_desc *desc,
+static inline void group_release_blocks(struct ext2_sb_info *sbi, struct ext2_group_desc *desc,
 				    struct buffer_head *bh, int count)
 {
 	if (count) {
-		unsigned free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
+		unsigned free_blocks;
+		
+		spin_lock(&sbi->s_alloc_lock);
+		
+		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
+		
+		spin_unlock(&sbi->s_alloc_lock);
+		
 		mark_buffer_dirty(bh);
 	}
 }
@@ -176,7 +204,6 @@
 	struct ext2_super_block * es;
 	unsigned freed = 0, group_freed;
 
-	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
@@ -224,7 +251,7 @@
 			    block, count);
 
 	for (i = 0, group_freed = 0; i < count; i++) {
-		if (!ext2_clear_bit(bit + i, bitmap_bh->b_data))
+		if (!test_and_clear_bit(bit + i, (void *) bitmap_bh->b_data))
 			ext2_error (sb, "ext2_free_blocks",
 				      "bit already cleared for block %lu",
 				      block + i);
@@ -236,7 +263,7 @@
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	group_release_blocks(desc, bh2, group_freed);
+	group_release_blocks(EXT2_SB(sb), desc, bh2, group_freed);
 	freed += group_freed;
 
 	if (overflow) {
@@ -247,7 +274,6 @@
 error_return:
 	brelse(bitmap_bh);
 	release_blocks(sb, freed);
-	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, freed);
 }
 
@@ -258,6 +284,8 @@
 
 	if (!ext2_test_bit(goal, map))
 		goto got_it;
+
+repeat:
 	if (goal) {
 		/*
 		 * The goal was occupied; search forward for a free 
@@ -297,7 +325,8 @@
 	}
 	return -1;
 got_it:
-	ext2_set_bit(goal, map);
+	if (test_and_set_bit(goal, (void *) map)) 
+		goto repeat;	
 	return goal;
 }
 
@@ -342,8 +371,6 @@
 
 	dq_alloc = prealloc_goal + 1;
 
-	lock_super (sb);
-
 	es_alloc = reserve_blocks(sb, dq_alloc);
 	if (!es_alloc) {
 		*err = -ENOSPC;
@@ -360,7 +387,7 @@
 	if (!desc)
 		goto io_error;
 
-	group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+	group_alloc = group_reserve_blocks(sbi, desc, gdp_bh, es_alloc);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 					group_size);
@@ -375,7 +402,7 @@
 				group_size, ret_block);
 		if (ret_block >= 0)
 			goto got_block;
-		group_release_blocks(desc, gdp_bh, group_alloc);
+		group_release_blocks(sbi, desc, gdp_bh, group_alloc);
 		group_alloc = 0;
 	}
 
@@ -393,7 +420,7 @@
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
+		group_alloc = group_reserve_blocks(sbi, desc, gdp_bh, es_alloc);
 	}
 	if (bit >= sbi->s_groups_count) {
 		*err = -ENOSPC;
@@ -452,7 +479,7 @@
 		unsigned n;
 
 		for (n = 0; n < group_alloc && ++ret_block < group_size; n++) {
-			if (ext2_set_bit(ret_block, bitmap_bh->b_data))
+			if (test_and_set_bit(ret_block, (void *) bitmap_bh->b_data))
  				break;
 		}
 		*prealloc_block = block + 1;
@@ -471,10 +498,9 @@
 
 	*err = 0;
 out_release:
-	group_release_blocks(desc, gdp_bh, group_alloc);
+	group_release_blocks(sbi, desc, gdp_bh, group_alloc);
 	release_blocks(sb, es_alloc);
 out_unlock:
-	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);
 out:
 	brelse(bitmap_bh);
diff -uNr linux/fs/ext2/super.c edited/fs/ext2/super.c
--- linux/fs/ext2/super.c	Thu Feb 20 16:18:53 2003
+++ edited/fs/ext2/super.c	Wed Mar 12 23:29:53 2003
@@ -564,6 +564,7 @@
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
+	spin_lock_init(&sbi->s_alloc_lock);
 
 	/*
 	 * See what the current blocksize for the device is, and
diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h	Mon Nov 11 06:28:30 2002
+++ edited/include/linux/ext2_fs_sb.h	Wed Mar 12 22:57:30 2003
@@ -45,6 +45,7 @@
 	u32 s_next_generation;
 	unsigned long s_dir_count;
 	u8 *s_debts;
+	spinlock_t s_alloc_lock;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */

