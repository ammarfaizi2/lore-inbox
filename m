Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWJWUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWJWUCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWJWUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:02:50 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:49092 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030193AbWJWUCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:02:48 -0400
Date: Mon, 23 Oct 2006 14:02:42 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061023200242.GA5015@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023164416.GM3509@schatzie.adilger.int>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 23, 2006  10:44 -0600, Andreas Dilger wrote:
> Hmm, this would appear to be a buglet in error handling.  If the block just
> allocated above is in the system zone it should be marked in-use in the
> bitmap but otherwise ignored.  We definitely should NOT be freeing it on
> error.
> 
> Yikes!  It seems a patch I submitted to 2.4 that fixed the behaviour
> of ext3_new_block() so that if we detect this block shouldn't be
> allocated it is skipped instead of corrupting the filesystem if it
> is running with errors=continue...
> 
> It looks like ext3_free_blocks() needs a similar fix - i.e. report an
> error and don't actually free those blocks.

I found a URL for the 2.4 version of this patch, if some kind soul would
update it for 2.6 it might save someone's data in the future.  It looks
at the time I wasn't working on 2.5 kernels and nobody else took it on.

http://lkml.org/lkml/2003/4/7/252

[patch is pasted, may not be free of whitespace munging, but then it will
 need to be applied to 2.6 by hand anyways]
======================= ext2-2.4.18-badalloc.diff ===========================
--- linux-2.4.18.orig/fs/ext3/balloc.c	Wed Feb 27 10:31:59 2002
+++ linux-2.4.18-aed/fs/ext3/balloc.c	Mon Mar 18 17:15:46 2002
@@ -276,7 +273,8 @@ void ext3_free_blocks
 	}
 	lock_super (sb);
 	es = sb->u.ext3_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
+	if (block < le32_to_cpu(es->s_first_data_block) ||
+	    block + count < block ||
 	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
@@ -309,17 +307,6 @@ void ext3_free_blocks
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
@@ -345,14 +332,24 @@ void ext3_free_blocks
 	if (err)
 		goto error_return;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++, block++) {
+		if (block == le32_to_cpu(gdp->bg_block_bitmap) ||
+		    block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+		    in_range(block, le32_to_cpu(gdp->bg_inode_table),
+			     EXT3_SB(sb)->s_itb_per_group)) {
+			ext3_error(sb, __FUNCTION__,
+				   "Freeing block in system zone - block =
%lu",
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
@@ -365,9 +362,8 @@ void ext3_free_blocks
 #endif
 		BUFFER_TRACE(bitmap_bh, "clear bit");
 		if (!ext3_clear_bit (bit + i, bitmap_bh->b_data)) {
-			ext3_error (sb, __FUNCTION__,
-				      "bit already cleared for block %lu", 
-				      block + i);
+			ext3_error(sb, __FUNCTION__,
+				   "bit already cleared for block %lu",
block);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
 			dquot_freed_blocks++;
@@ -415,7 +411,6 @@ void ext3_free_blocks
 	if (!err) err = ret;
 
 	if (overflow && !err) {
-		block += count;
 		count = overflow;
 		goto do_more;
 	}
@@ -575,6 +574,7 @@ int ext3_new_block
 
 	ext3_debug ("goal=%lu.\n", goal);
 
+repeat:
 	/*
 	 * First, test whether the goal block is free.
 	 */
@@ -684,10 +684,21 @@ int ext3_new_block
 	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext3_sb.s_itb_per_group))
-		ext3_error (sb, "ext3_new_block",
-			    "Allocating block in system zone - "
-			    "block = %u", tmp);
+		      EXT3_SB(sb)->s_itb_per_group)) {
+		ext3_error(sb, __FUNCTION__,
+			   "Allocating block in system zone - block = %u",
tmp);
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

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

