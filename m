Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbTCJPhr>; Mon, 10 Mar 2003 10:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTCJPhq>; Mon, 10 Mar 2003 10:37:46 -0500
Received: from comtv.ru ([217.10.32.4]:8161 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261329AbTCJPho>;
	Mon, 10 Mar 2003 10:37:44 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>
Subject: [PATCH] concurrent block allocation for ext3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 10 Mar 2003 18:41:04 +0300
Message-ID: <m3zno3grfz.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Here is the small patch which implements concurrent block allocation
for ext3. It removes lock_super() in ext3_new_block() and ext3_free_blocks().
Modifications of counters in superblock and group descriptors are protected
by spinlock. Tested on SMP for several hours.


--- linux/fs/ext3/balloc.c	Thu Feb 20 16:19:06 2003
+++ balloc.c	Mon Mar 10 16:00:49 2003
@@ -118,7 +118,6 @@
 		printk ("ext3_free_blocks: nonexistent device");
 		return;
 	}
-	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
@@ -214,11 +213,13 @@
 				      block + i);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
+			spin_lock(&EXT3_SB(sb)->s_alloc_lock);
 			dquot_freed_blocks++;
 			gdp->bg_free_blocks_count =
 			  cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
 			es->s_free_blocks_count =
 			  cpu_to_le32(le32_to_cpu(es->s_free_blocks_count)+1);
+			spin_unlock(&EXT3_SB(sb)->s_alloc_lock);
 		}
 		/* @@@ This prevents newly-allocated data from being
 		 * freed and then reallocated within the same
@@ -267,7 +268,6 @@
 error_return:
 	brelse(bitmap_bh);
 	ext3_std_error(sb, err);
-	unlock_super(sb);
 	if (dquot_freed_blocks)
 		DQUOT_FREE_BLOCK(inode, dquot_freed_blocks);
 	return;
@@ -408,7 +408,6 @@
 		return 0;
 	}
 
-	lock_super(sb);
 	es = EXT3_SB(sb)->s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
@@ -461,6 +460,7 @@
 
 	ext3_debug("Bit not found in block group %d.\n", group_no);
 
+repeat:
 	/*
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
@@ -538,9 +538,9 @@
 
 	/* The superblock lock should guard against anybody else beating
 	 * us to this point! */
-	J_ASSERT_BH(bitmap_bh, !ext3_test_bit(ret_block, bitmap_bh->b_data));
 	BUFFER_TRACE(bitmap_bh, "setting bitmap bit");
-	ext3_set_bit(ret_block, bitmap_bh->b_data);
+	if (ext3_set_bit(ret_block, bitmap_bh->b_data)) 
+		goto repeat;
 	performed_allocation = 1;
 
 #ifdef CONFIG_JBD_DEBUG
@@ -586,11 +586,13 @@
 	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
 			ret_block, goal_hits, goal_attempts);
 
+	spin_lock(&EXT3_SB(sb)->s_alloc_lock);
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	es->s_free_blocks_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) - 1);
-
+	spin_unlock(&EXT3_SB(sb)->s_alloc_lock);
+	
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
 	if (!fatal)
@@ -606,7 +608,6 @@
 	if (fatal)
 		goto out;
 
-	unlock_super(sb);
 	*errp = 0;
 	brelse(bitmap_bh);
 	return ret_block;
@@ -618,7 +619,6 @@
 		*errp = fatal;
 		ext3_std_error(sb, fatal);
 	}
-	unlock_super(sb);
 	/*
 	 * Undo the block allocation
 	 */

