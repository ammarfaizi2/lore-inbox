Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263690AbTDGWL2 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbTDGWL2 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:11:28 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:61424 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263690AbTDGWLY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:11:24 -0400
Date: Mon, 7 Apr 2003 16:21:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: ext2-devel@lists.sourceforge.net,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't allocate/free blocks in system areas
Message-ID: <20030407162133.F1422@schatzie.adilger.int>
Mail-Followup-To: ext2-devel@lists.sourceforge.net,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case of on-disk corruption, the current ext2/3 code will happily reallocate
or mark free blocks in the system area (bitmaps, inode table, etc) instead of
ignoring the bad alloc/free and leaving the system blocks alone.  This will
cause further corruption of the filesystem as metadata gets overwritten by
file data and in turn causes more bad alloc/free requests.

This patch was (I thought at least) in -ac and scheduled to go into mainline
a long time ago (over a year ago, looking at the dates in the diff), but it
seems to have been lost.  The patch still applies to 2.4.21-pre7.

A similar patch is needed for 2.5, but there are subtle differences in the
2.5 ext2 code and I haven't been using 2.5...

Cheers, Andreas
======================= ext2-2.4.18-badalloc.diff ===========================
diff -ru linux-2.4.18.orig/fs/ext2/balloc.c linux-2.4.18-aed/fs/ext2/balloc.c
--- linux-2.4.18.orig/fs/ext2/balloc.c	Wed Feb 27 10:31:58 2002
+++ linux-2.4.18-aed/fs/ext2/balloc.c	Mon Mar 18 17:07:55 2002
@@ -269,7 +269,8 @@
 	}
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
+	if (block < le32_to_cpu(es->s_first_data_block) ||
+	    block + count < block ||
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks not in datazone - "
@@ -302,22 +303,20 @@
 	if (!gdp)
 		goto error_return;
 
-	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
-		ext2_error (sb, "ext2_free_blocks",
-			    "Freeing blocks in system zones - "
-			    "Block = %lu, count = %lu",
-			    block, count);
+	for (i = 0; i < count; i++, block++) {
+		if (block == le32_to_cpu(gdp->bg_block_bitmap) ||
+		    block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+		    in_range(block, le32_to_cpu(gdp->bg_inode_table),
+			     EXT2_SB(sb)->s_itb_per_group)) {
+			ext2_error(sb, __FUNCTION__,
+				   "Freeing block in system zone - block = %lu",
+				   block);
+			continue;
+		}
 
-	for (i = 0; i < count; i++) {
 		if (!ext2_clear_bit (bit + i, bh->b_data))
-			ext2_error (sb, "ext2_free_blocks",
-				      "bit already cleared for block %lu",
-				      block + i);
+			ext2_error(sb, __FUNCTION__,
+				   "bit already cleared for block %lu", block);
 		else {
 			DQUOT_FREE_BLOCK(inode, 1);
 			gdp->bg_free_blocks_count =
@@ -336,7 +335,6 @@
 		wait_on_buffer (bh);
 	}
 	if (overflow) {
-		block += count;
 		count = overflow;
 		goto do_more;
 	}
@@ -522,10 +522,14 @@
	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      EXT2_SB(sb)->s_itb_per_group)) {
 		ext2_error (sb, "ext2_new_block",
-			    "Allocating block in system zone - "
-			    "block = %u", tmp);
+			    "Allocating block in system zone - block = %lu",
+			    tmp);
+		ext2_set_bit(j, bh->b_data);
+		DQUOT_FREE_BLOCK(inode, 1);
+		goto repeat;
+	}
 
 	if (ext2_set_bit (j, bh->b_data)) {
 		ext2_warning (sb, "ext2_new_block",
--- linux-2.4.18.orig/fs/ext3/balloc.c	Wed Feb 27 10:31:59 2002
+++ linux-2.4.18-aed/fs/ext3/balloc.c	Mon Mar 18 17:15:46 2002
@@ -276,7 +273,8 @@
 	}
 	lock_super (sb);
 	es = sb->u.ext3_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
+	if (block < le32_to_cpu(es->s_first_data_block) ||
+	    block + count < block ||
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
@@ -309,17 +307,6 @@
 	if (!gdp)
 		goto error_return;
 
-	if (in_range (le32_to_cpu(gdp->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(gdp->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group))
-		ext3_error (sb, "ext3_free_blocks",
-			    "Freeing blocks in system zones - "
-			    "Block = %lu, count = %lu",
-			    block, count);
-
 	/*
 	 * We are about to start releasing blocks in the bitmap,
 	 * so we need undo access.
@@ -345,14 +332,24 @@
 	if (err)
 		goto error_return;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++, block++) {
+		if (block == le32_to_cpu(gdp->bg_block_bitmap) ||
+		    block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+		    in_range(block, le32_to_cpu(gdp->bg_inode_table),
+			     EXT3_SB(sb)->s_itb_per_group)) {
+			ext3_error(sb, __FUNCTION__,
+				   "Freeing block in system zone - block = %lu",
+				   block);
+			continue;
+		}
+
 		/*
 		 * An HJ special.  This is expensive...
 		 */
 #ifdef CONFIG_JBD_DEBUG
 		{
 			struct buffer_head *debug_bh;
-			debug_bh = sb_get_hash_table(sb, block + i);
+			debug_bh = sb_get_hash_table(sb, block);
 			if (debug_bh) {
 				BUFFER_TRACE(debug_bh, "Deleted!");
 				if (!bh2jh(bitmap_bh)->b_committed_data)
@@ -365,9 +362,8 @@
 #endif
 		BUFFER_TRACE(bitmap_bh, "clear bit");
 		if (!ext3_clear_bit (bit + i, bitmap_bh->b_data)) {
-			ext3_error (sb, __FUNCTION__,
-				      "bit already cleared for block %lu", 
-				      block + i);
+			ext3_error(sb, __FUNCTION__,
+				   "bit already cleared for block %lu", block);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
 			dquot_freed_blocks++;
@@ -415,7 +411,6 @@
 	if (!err) err = ret;
 
 	if (overflow && !err) {
-		block += count;
 		count = overflow;
 		goto do_more;
 	}
@@ -575,6 +574,7 @@
 
 	ext3_debug ("goal=%lu.\n", goal);
 
+repeat:
 	/*
 	 * First, test whether the goal block is free.
 	 */
@@ -684,10 +684,21 @@
 	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group))
-		ext3_error (sb, "ext3_new_block",
-			    "Allocating block in system zone - "
-			    "block = %u", tmp);
+		      EXT3_SB(sb)->s_itb_per_group)) {
+		ext3_error(sb, __FUNCTION__,
+			   "Allocating block in system zone - block = %u", tmp);
+
+		/* Note: This will potentially use up one of the handle's
+		 * buffer credits.  Normally we have way too many credits,
+		 * so that is OK.  In _very_ rare cases it might not be OK.
+		 * We will trigger an assertion if we run out of credits,
+		 * and we will have to do a full fsck of the filesystem -
+		 * better than randomly corrupting filesystem metadata.
+		 */
+		ext3_set_bit(j, bh->b_data);
+		goto repeat;
+	}
+
 
 	/* The superblock lock should guard against anybody else beating
 	 * us to this point! */
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

