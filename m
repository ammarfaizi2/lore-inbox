Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030686AbWAJX05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030686AbWAJX05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWAJX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:26:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:41924 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030688AbWAJX0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:40 -0500
Subject: [PATCH 4/5] ext3-get-blocks: Adjust accounting info in
	ext3-new-blocks()
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:38 -0800
Message-Id: <1136935598.4901.45.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part three of the multiple block allocation patch: Properly updating
accounting information (quota, boundary checks, free blocks number etc)
in ext3_new_blocks().

Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.15-ming/fs/ext3/balloc.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-new-blocks-accounting fs/ext3/balloc.c
--- linux-2.6.15/fs/ext3/balloc.c~ext3-new-blocks-accounting	2006-01-10 14:25:38.220167728 -0800
+++ linux-2.6.15-ming/fs/ext3/balloc.c	2006-01-10 14:25:38.225167146 -0800
@@ -1207,7 +1207,7 @@ int ext3_new_blocks(handle_t *handle, st
 	/*
 	 * Check quota for allocation of this block.
 	 */
-	if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+	if (DQUOT_ALLOC_BLOCK(inode, num)) {
 		*errp = -EDQUOT;
 		return 0;
 	}
@@ -1334,13 +1334,15 @@ allocated:
 	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
 				+ le32_to_cpu(es->s_first_data_block);
 
-	if (target_block == le32_to_cpu(gdp->bg_block_bitmap) ||
-	    target_block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), target_block, num) ||
+	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), target_block, num) ||
 	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
+		      EXT3_SB(sb)->s_itb_per_group) ||
+	    in_range(target_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
 		      EXT3_SB(sb)->s_itb_per_group))
 		ext3_error(sb, "ext3_new_block",
 			    "Allocating block in system zone - "
-			    "block = %u", target_block);
+			    "blocks from %u, length %lu", target_block, num);
 
 	performed_allocation = 1;
 
@@ -1359,10 +1361,12 @@ allocated:
 	jbd_lock_bh_state(bitmap_bh);
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	if (buffer_jbd(bitmap_bh) && bh2jh(bitmap_bh)->b_committed_data) {
-		if (ext3_test_bit(ret_block,
-				bh2jh(bitmap_bh)->b_committed_data)) {
-			printk("%s: block was unexpectedly set in "
-				"b_committed_data\n", __FUNCTION__);
+		for (int i = 0; i < num; i++) {
+			if (ext3_test_bit(ret_block,
+					bh2jh(bitmap_bh)->b_committed_data)) {
+				printk("%s: block was unexpectedly set in "
+					"b_committed_data\n", __FUNCTION__);
+			}
 		}
 	}
 	ext3_debug("found bit %d\n", ret_block);
@@ -1373,7 +1377,7 @@ allocated:
 	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
 	ret_block = target_block;
 
-	if (ret_block >= le32_to_cpu(es->s_blocks_count)) {
+	if (ret_block + num -1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
 			    "block(%d) >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
@@ -1391,9 +1395,9 @@ allocated:
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	gdp->bg_free_blocks_count =
-			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
+			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - num);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -1);
+	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
@@ -1407,6 +1411,7 @@ allocated:
 	*errp = 0;
 	brelse(bitmap_bh);
 	*count = num;
+	DQUOT_FREE_BLOCK(inode, *count-num);
 	return ret_block;
 
 io_error:
@@ -1420,7 +1425,7 @@ out:
 	 * Undo the block allocation
 	 */
 	if (!performed_allocation)
-		DQUOT_FREE_BLOCK(inode, 1);
+		DQUOT_FREE_BLOCK(inode, *count);
 	brelse(bitmap_bh);
 	return 0;
 }

_


