Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313762AbSDQH6V>; Wed, 17 Apr 2002 03:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDQH6U>; Wed, 17 Apr 2002 03:58:20 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7674 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313762AbSDQH6R>; Wed, 17 Apr 2002 03:58:17 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 17 Apr 2002 01:56:37 -0600
To: Frank Krauss <fmfkrauss@mindspring.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
Message-ID: <20020417075637.GJ20464@turbolinux.com>
Mail-Followup-To: Frank Krauss <fmfkrauss@mindspring.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net> <02041112492500.01786@sevencardstud.cable.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2002  12:40 -0400, Frank Krauss wrote:
> I have a problem in the area of EXT2 File System Corruption.
> 
> My problem came up yesterday in the following manner:
> My Root Partition, /dev/hdc1 went 100% full.
> Even though I erased various files from it which should have brought
> it down to 97% usage, it remained at the 100% level.
> I believe that this is another, known, separate problem from mine.
> 
> The Copy worked but I got the following 10 Error Messages:
> 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)):
>    ext2_new_block: Allocating block in system zone - block = 835885 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)):
>    ext2_new_block: Allocating block in system zone - block = 835886 

OK, here is my updated patch for fixing the SYMPTOM of this problem and
not the root CAUSE of the problem.  The symptom is that ext2/ext3 will
happily free and allocate blocks that are supposed to be filesystem
metadata if there is an error in the block bitmaps.  Errors could
previously crop up in the block bitmaps if, say, an inode had corrupt
block numbers, or an indirect block had garbage in it.

The patch changes the code so that it still complains about trying to
allocate or free such a block, but then it "does the right thing" by
keeping the block allocated for (what it thinks is) filesystem metadata.
If, in some future revision of ext2, we change the location of some
metadata, at worst we will have a few blocks which cannot be allocated
by an older kernel, but e2fsck will clean up at a later time.  That is
far preferrable to corrupting the superblock or bitmaps or inode table,
which will, in turn, lead to more filesystem corruption.

The patch has been in my kernel tree for a long time, but is relatively
untested as it only handles error situations.  It seems pretty obvious,
however, so it should go into the kernel proper.  Patch is against 2.4.18,
but does not intersect with Andrew's recent fixes to filesystem-full
handling in ext3_new_block() in 2.4.19-pre7.  It also includes the checks
for block free overflows that have been in 2.5-dj for a good while.

Cheers, Andreas
====================== ext2-2.4.18-badalloc.diff =====================
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
@@ -522,8 +520,12 @@
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
 		      sb->u.ext2_sb.s_itb_per_group))
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
+			     sb->u.ext2_sb.s_itb_per_group)) {
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
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

