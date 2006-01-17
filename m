Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWAQUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWAQUaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAQUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:30:15 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:26209 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964813AbWAQUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:30:11 -0500
Date: Tue, 17 Jan 2006 15:30:11 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] reiserfs: clean up bitmap block buffer head references
Message-ID: <20060117203009.GA24895@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Similar to the SB_JOURNAL cleanup that was accepted a while ago, this patch
 uses a temporary variable for buffer head references from the bitmap info
 array.

 This makes the code much more readable in some areas.

 It also uses proper reference counting, doing a get_bh() after using the
 pointer from the array and brelse()'ing it later. This may seem silly,
 but a later patch will replace the simple temporary variables with an
 actual read, so the reference freeing will be used then.

 fs/reiserfs/bitmap.c |   60 ++++++++++++++++++++++++++++---------------------
 fs/reiserfs/resize.c |   62 +++++++++++++++++++++++++++++----------------------
 2 files changed, 71 insertions(+), 51 deletions(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c	2006-01-16 16:53:29.451263512 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c	2006-01-16 16:53:29.457262600 -0500
@@ -62,6 +62,7 @@ int is_reusable(struct super_block *s, b
 {
 	int i, j;
 	unsigned int bmap = block >> s->s_blocksize_bits;
+	struct buffer_head *bh;
 
 	if (block == 0 || block >= SB_BLOCK_COUNT(s)) {
 		reiserfs_warning(s,
@@ -99,20 +100,20 @@ int is_reusable(struct super_block *s, b
 		return 0;
 	}
 
-	if ((bit_value == 0 &&
-	     reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i].bh->b_data)) ||
-	    (bit_value == 1 &&
-	     reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i].bh->b_data) == 0)) {
+	bh = SB_AP_BITMAP(s)[i].bh;
+	get_bh(bh);
+
+	if ((bit_value == 0 && reiserfs_test_le_bit(j, bh->b_data)) ||
+	    (bit_value == 1 && reiserfs_test_le_bit(j, bh->b_data) == 0)) {
 		reiserfs_warning(s,
 				 "vs-4040: is_reusable: corresponding bit of block %lu does not "
 				 "match required value (i==%d, j==%d) test_bit==%d",
-				 block, i, j, reiserfs_test_le_bit(j,
-								   SB_AP_BITMAP
-								   (s)[i].bh->
-								   b_data));
+				 block, i, j, reiserfs_test_le_bit(j, bh->b_data));
 
+		brelse(bh);
 		return 0;
 	}
+	brelse(bh);
 
 	if (bit_value == 0 && block == SB_ROOT_BLOCK(s)) {
 		reiserfs_warning(s,
@@ -154,6 +155,7 @@ static int scan_bitmap_block(struct reis
 {
 	struct super_block *s = th->t_super;
 	struct reiserfs_bitmap_info *bi = &SB_AP_BITMAP(s)[bmap_n];
+	struct buffer_head *bh;
 	int end, next;
 	int org = *beg;
 
@@ -172,22 +174,27 @@ static int scan_bitmap_block(struct reis
 				 bmap_n);
 		return 0;
 	}
+	bh = bi->bh;
+	get_bh(bh);
+
 	if (buffer_locked(bi->bh)) {
 		PROC_INFO_INC(s, scan_bitmap.wait);
-		__wait_on_buffer(bi->bh);
+		__wait_on_buffer(bh);
 	}
 
 	while (1) {
-	      cont:
-		if (bi->free_count < min)
+		if (bi->free_count < min) {
+			brelse(bh);
 			return 0;	// No free blocks in this bitmap
+		}
 
 		/* search for a first zero bit -- beggining of a window */
 		*beg = reiserfs_find_next_zero_le_bit
-		    ((unsigned long *)(bi->bh->b_data), boundary, *beg);
+		    ((unsigned long *)(bh->b_data), boundary, *beg);
 
 		if (*beg + min > boundary) {	/* search for a zero bit fails or the rest of bitmap block
 						 * cannot contain a zero window of minimum size */
+			brelse(bh);
 			return 0;
 		}
 
@@ -196,7 +203,7 @@ static int scan_bitmap_block(struct reis
 		/* first zero bit found; we check next bits */
 		for (end = *beg + 1;; end++) {
 			if (end >= *beg + max || end >= boundary
-			    || reiserfs_test_le_bit(end, bi->bh->b_data)) {
+			    || reiserfs_test_le_bit(end, bh->b_data)) {
 				next = end;
 				break;
 			}
@@ -210,12 +217,12 @@ static int scan_bitmap_block(struct reis
 		 * (end) points to one bit after the window end */
 		if (end - *beg >= min) {	/* it seems we have found window of proper size */
 			int i;
-			reiserfs_prepare_for_journal(s, bi->bh, 1);
+			reiserfs_prepare_for_journal(s, bh, 1);
 			/* try to set all blocks used checking are they still free */
 			for (i = *beg; i < end; i++) {
 				/* It seems that we should not check in journal again. */
 				if (reiserfs_test_and_set_le_bit
-				    (i, bi->bh->b_data)) {
+				    (i, bh->b_data)) {
 					/* bit was set by another process
 					 * while we slept in prepare_for_journal() */
 					PROC_INFO_INC(s, scan_bitmap.stolen);
@@ -227,17 +234,15 @@ static int scan_bitmap_block(struct reis
 					/* otherwise we clear all bit were set ... */
 					while (--i >= *beg)
 						reiserfs_test_and_clear_le_bit
-						    (i, bi->bh->b_data);
-					reiserfs_restore_prepared_buffer(s,
-									 bi->
-									 bh);
+						    (i, bh->b_data);
+					reiserfs_restore_prepared_buffer(s, bh);
 					*beg = org;
 					/* ... and search again in current block from beginning */
-					goto cont;
+					continue;
 				}
 			}
 			bi->free_count -= (end - *beg);
-			journal_mark_dirty(th, s, bi->bh);
+			journal_mark_dirty(th, s, bh);
 
 			/* free block count calculation */
 			reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s),
@@ -245,6 +250,7 @@ static int scan_bitmap_block(struct reis
 			PUT_SB_FREE_BLOCKS(s, SB_FREE_BLOCKS(s) - (end - *beg));
 			journal_mark_dirty(th, s, SB_BUFFER_WITH_SB(s));
 
+			brelse(bh);
 			return end - (*beg);
 		} else {
 			*beg = next;
@@ -386,7 +392,7 @@ static void _reiserfs_free_block(struct 
 {
 	struct super_block *s = th->t_super;
 	struct reiserfs_super_block *rs;
-	struct buffer_head *sbh;
+	struct buffer_head *sbh, *bmbh;
 	struct reiserfs_bitmap_info *apbi;
 	int nr, offset;
 
@@ -407,16 +413,20 @@ static void _reiserfs_free_block(struct 
 		return;
 	}
 
-	reiserfs_prepare_for_journal(s, apbi[nr].bh, 1);
+	bmbh = apbi[nr].bh;
+	get_bh(bmbh);
+
+	reiserfs_prepare_for_journal(s, bmbh, 1);
 
 	/* clear bit for the given block in bit map */
-	if (!reiserfs_test_and_clear_le_bit(offset, apbi[nr].bh->b_data)) {
+	if (!reiserfs_test_and_clear_le_bit(offset, bmbh->b_data)) {
 		reiserfs_warning(s, "vs-4080: reiserfs_free_block: "
 				 "free_block (%s:%lu)[dev:blocknr]: bit already cleared",
 				 reiserfs_bdevname(s), block);
 	}
 	apbi[nr].free_count++;
-	journal_mark_dirty(th, s, apbi[nr].bh);
+	journal_mark_dirty(th, s, bmbh);
+	brelse(bmbh);
 
 	reiserfs_prepare_for_journal(s, sbh, 1);
 	/* update super block */
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/resize.c linux-2.6.15.orig.staging2/fs/reiserfs/resize.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/resize.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/resize.c	2006-01-16 16:53:29.471260472 -0500
@@ -22,6 +22,7 @@ int reiserfs_resize(struct super_block *
 	int err = 0;
 	struct reiserfs_super_block *sb;
 	struct reiserfs_bitmap_info *bitmap;
+	struct reiserfs_bitmap_info *info;
 	struct reiserfs_bitmap_info *old_bitmap = SB_AP_BITMAP(s);
 	struct buffer_head *bh;
 	struct reiserfs_transaction_handle th;
@@ -127,16 +128,19 @@ int reiserfs_resize(struct super_block *
 		 * transaction begins, and the new bitmaps don't matter if the
 		 * transaction fails. */
 		for (i = bmap_nr; i < bmap_nr_new; i++) {
-			bitmap[i].bh = sb_getblk(s, i * s->s_blocksize * 8);
-			memset(bitmap[i].bh->b_data, 0, sb_blocksize(sb));
-			reiserfs_test_and_set_le_bit(0, bitmap[i].bh->b_data);
-
-			set_buffer_uptodate(bitmap[i].bh);
-			mark_buffer_dirty(bitmap[i].bh);
-			sync_dirty_buffer(bitmap[i].bh);
+			bh = sb_getblk(s, i * s->s_blocksize * 8);
+			get_bh(bh);
+			memset(bh->b_data, 0, sb_blocksize(sb));
+			reiserfs_test_and_set_le_bit(0, bh->b_data);
+
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			sync_dirty_buffer(bh);
 			// update bitmap_info stuff
 			bitmap[i].first_zero_hint = 1;
 			bitmap[i].free_count = sb_blocksize(sb) * 8 - 1;
+			bitmap[i].bh = bh;
+			brelse(bh);
 		}
 		/* free old bitmap blocks array */
 		SB_AP_BITMAP(s) = bitmap;
@@ -150,30 +154,36 @@ int reiserfs_resize(struct super_block *
 	if (err)
 		return err;
 
-	/* correct last bitmap blocks in old and new disk layout */
-	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr - 1].bh, 1);
-	for (i = block_r; i < s->s_blocksize * 8; i++)
-		reiserfs_test_and_clear_le_bit(i,
-					       SB_AP_BITMAP(s)[bmap_nr -
-							       1].bh->b_data);
-	SB_AP_BITMAP(s)[bmap_nr - 1].free_count += s->s_blocksize * 8 - block_r;
-	if (!SB_AP_BITMAP(s)[bmap_nr - 1].first_zero_hint)
-		SB_AP_BITMAP(s)[bmap_nr - 1].first_zero_hint = block_r;
+	/* Extend old last bitmap block - new blocks have been made available */
+	info = SB_AP_BITMAP(s) + bmap_nr - 1;
+	bh = info->bh;
+	get_bh(bh);
 
-	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr - 1].bh);
+	reiserfs_prepare_for_journal(s, bh, 1);
+	for (i = block_r; i < s->s_blocksize * 8; i++)
+		reiserfs_test_and_clear_le_bit(i, bh->b_data);
+	info->free_count += s->s_blocksize * 8 - block_r;
+	if (!info->first_zero_hint)
+		info->first_zero_hint = block_r;
+
+	journal_mark_dirty(&th, s, bh);
+	brelse(bh);
+
+	/* Correct new last bitmap block - It may not be full */
+	info = SB_AP_BITMAP(s) + bmap_nr_new - 1;
+	bh = info->bh;
+	get_bh(bh);
 
-	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr_new - 1].bh, 1);
+	reiserfs_prepare_for_journal(s, bh, 1);
 	for (i = block_r_new; i < s->s_blocksize * 8; i++)
-		reiserfs_test_and_set_le_bit(i,
-					     SB_AP_BITMAP(s)[bmap_nr_new -
-							     1].bh->b_data);
-	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr_new - 1].bh);
+		reiserfs_test_and_set_le_bit(i, bh->b_data);
+	journal_mark_dirty(&th, s, bh);
+	brelse(bh);
 
-	SB_AP_BITMAP(s)[bmap_nr_new - 1].free_count -=
-	    s->s_blocksize * 8 - block_r_new;
+	info->free_count -= s->s_blocksize * 8 - block_r_new;
 	/* Extreme case where last bitmap is the only valid block in itself. */
-	if (!SB_AP_BITMAP(s)[bmap_nr_new - 1].free_count)
-		SB_AP_BITMAP(s)[bmap_nr_new - 1].first_zero_hint = 0;
+	if (!info->free_count)
+		info->first_zero_hint = 0;
 	/* update super */
 	reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
 	free_blocks = SB_FREE_BLOCKS(s);
-- 
Jeff Mahoney
SuSE Labs
