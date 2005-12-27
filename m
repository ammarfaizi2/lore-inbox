Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVL0Om6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVL0Om6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVL0Om6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:42:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3973 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932339AbVL0Om5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:42:57 -0500
Date: Tue, 27 Dec 2005 15:42:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051227144242.GA8870@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org> <200512251708.16483.zippel@linux-m68k.org> <20051225150445.0eae9dd7.akpm@osdl.org> <20051225232222.GA11828@elte.hu> <20051226023549.f46add77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226023549.f46add77.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > hm, can you see any easy way for me to test my bold assertion on ext3, 
> > by somehow moving/hacking it back to semaphores?
> 
> Not really.  The problem was most apparent after the lock_kernel() 
> removal patches.  The first thing a CPU hit when it entered the fs was 
> previously lock_kernel().  That became lock_super() and performance 
> went down the tubes.  From memory, the bad kernel was tip-of-tree as 
> of Memorial Weekend 2003 ;)
> 
> I guess you could re-add all the lock_super()s as per 2.5.x's 
> ext3/jbd, check that it sucks running SDET on 8-way then implement the 
> lock_super()s via a mutex.

ok - does the patch below look roughly ok as a really bad (but 
functional) hack to restore that old behavior, for ext2?

	Ingo

 fs/ext2/balloc.c |   19 ++++++++++++++++---
 fs/ext2/ialloc.c |   15 +++++++++++++--
 2 files changed, 30 insertions(+), 6 deletions(-)

Index: linux/fs/ext2/balloc.c
===================================================================
--- linux.orig/fs/ext2/balloc.c
+++ linux/fs/ext2/balloc.c
@@ -139,7 +139,7 @@ static void release_blocks(struct super_
 	}
 }
 
-static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
+static int group_reserve_blocks(struct super_block *sb, struct ext2_sb_info *sbi, int group_no,
 	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
 {
 	unsigned free_blocks;
@@ -147,12 +147,15 @@ static int group_reserve_blocks(struct e
 	if (!desc->bg_free_blocks_count)
 		return 0;
 
+	lock_super(sb);
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 	if (free_blocks < count)
 		count = free_blocks;
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
+	unlock_super(sb);
+
 	mark_buffer_dirty(bh);
 	return count;
 }
@@ -164,10 +167,12 @@ static void group_release_blocks(struct 
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
 		unsigned free_blocks;
 
+		lock_super(sb);
 		spin_lock(sb_bgl_lock(sbi, group_no));
 		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
 		spin_unlock(sb_bgl_lock(sbi, group_no));
+		unlock_super(sb);
 		sb->s_dirt = 1;
 		mark_buffer_dirty(bh);
 	}
@@ -234,6 +239,7 @@ do_more:
 			    "Block = %lu, count = %lu",
 			    block, count);
 
+	lock_super(sb);
 	for (i = 0, group_freed = 0; i < count; i++) {
 		if (!ext2_clear_bit_atomic(sb_bgl_lock(sbi, block_group),
 						bit + i, bitmap_bh->b_data)) {
@@ -243,6 +249,7 @@ do_more:
 			group_freed++;
 		}
 	}
+	unlock_super(sb);
 
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
@@ -377,7 +384,7 @@ int ext2_new_block(struct inode *inode, 
 		goto io_error;
 	}
 
-	group_alloc = group_reserve_blocks(sbi, group_no, desc,
+	group_alloc = group_reserve_blocks(sb, sbi, group_no, desc,
 					gdp_bh, es_alloc);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
@@ -389,8 +396,10 @@ int ext2_new_block(struct inode *inode, 
 		
 		ext2_debug("goal is at %d:%d.\n", group_no, ret_block);
 
+		lock_super(sb);
 		ret_block = grab_block(sb_bgl_lock(sbi, group_no),
 				bitmap_bh->b_data, group_size, ret_block);
+		unlock_super(sb);
 		if (ret_block >= 0)
 			goto got_block;
 		group_release_blocks(sb, group_no, desc, gdp_bh, group_alloc);
@@ -413,7 +422,7 @@ retry:
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(sbi, group_no, desc,
+		group_alloc = group_reserve_blocks(sb, sbi, group_no, desc,
 						gdp_bh, es_alloc);
 	}
 	if (!group_alloc) {
@@ -425,8 +434,10 @@ retry:
 	if (!bitmap_bh)
 		goto io_error;
 
+	lock_super(sb);
 	ret_block = grab_block(sb_bgl_lock(sbi, group_no), bitmap_bh->b_data,
 				group_size, 0);
+	unlock_super(sb);
 	if (ret_block < 0) {
 		/*
 		 * If a free block counter is corrupted we can loop inifintely.
@@ -485,12 +496,14 @@ got_block:
 	if (group_alloc && !*prealloc_count) {
 		unsigned n;
 
+		lock_super(sb);
 		for (n = 0; n < group_alloc && ++ret_block < group_size; n++) {
 			if (ext2_set_bit_atomic(sb_bgl_lock(sbi, group_no),
 						ret_block,
 						(void*) bitmap_bh->b_data))
  				break;
 		}
+		unlock_super(sb);
 		*prealloc_block = block + 1;
 		*prealloc_count = n;
 		es_alloc -= n;
Index: linux/fs/ext2/ialloc.c
===================================================================
--- linux.orig/fs/ext2/ialloc.c
+++ linux/fs/ext2/ialloc.c
@@ -75,6 +75,7 @@ static void ext2_release_inode(struct su
 		return;
 	}
 
+	lock_super(sb);
 	spin_lock(sb_bgl_lock(EXT2_SB(sb), group));
 	desc->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
@@ -82,6 +83,7 @@ static void ext2_release_inode(struct su
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
 	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
+	unlock_super(sb);
 	if (dir)
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	sb->s_dirt = 1;
@@ -148,12 +150,16 @@ void ext2_free_inode (struct inode * ino
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
+	lock_super(sb);
 	if (!ext2_clear_bit_atomic(sb_bgl_lock(EXT2_SB(sb), block_group),
-				bit, (void *) bitmap_bh->b_data))
+				bit, (void *) bitmap_bh->b_data)) {
+		unlock_super(sb);
 		ext2_error (sb, "ext2_free_inode",
 			      "bit already cleared for inode %lu", ino);
-	else
+	} else {
+		unlock_super(sb);
 		ext2_release_inode(sb, block_group, is_directory);
+	}
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
@@ -507,8 +513,10 @@ repeat_in_this_group:
 				group = 0;
 			continue;
 		}
+		lock_super(sb);
 		if (ext2_set_bit_atomic(sb_bgl_lock(sbi, group),
 						ino, bitmap_bh->b_data)) {
+			unlock_super(sb);
 			/* we lost this inode */
 			if (++ino >= EXT2_INODES_PER_GROUP(sb)) {
 				/* this group is exhausted, try next group */
@@ -519,6 +527,7 @@ repeat_in_this_group:
 			/* try to find free inode in the same group */
 			goto repeat_in_this_group;
 		}
+		unlock_super(sb);
 		goto got;
 	}
 
@@ -547,6 +556,7 @@ got:
 	if (S_ISDIR(mode))
 		percpu_counter_inc(&sbi->s_dirs_counter);
 
+	lock_super(sb);
 	spin_lock(sb_bgl_lock(sbi, group));
 	gdp->bg_free_inodes_count =
                 cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
@@ -560,6 +570,7 @@ got:
 			sbi->s_debts[group]--;
 	}
 	spin_unlock(sb_bgl_lock(sbi, group));
+	unlock_super(sb);
 
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh2);
