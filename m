Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWFOBmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWFOBmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 21:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFOBmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 21:42:18 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:42322 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932410AbWFOBmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 21:42:16 -0400
Date: Wed, 14 Jun 2006 21:42:03 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ReiserFS Mailing list <reiserfs-list@namesys.com>
Subject: [PATCH 04/04] reiserfs: on-demand bitmap loading
Message-ID: <20060615014203.GA8235@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.257-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 This is the patch the three previous ones have been leading up to.

 It changes the behavior of ReiserFS from loading and caching all the bitmaps
 as special, to treating the bitmaps like any other bit of metadata and just
 letting the system-wide caches figure out what to hang on to.

 Buffer heads are allocated on the fly, so there is no need to retain pointers
 to all of them. The caching of the metadata occurs when the data is read
 and updated, and is considered invalid and uncached until then.

 I needed to remove the vs-4040 check for performing a duplicate operation
 on a particular bit. The reason is that while the other sites for working
 with bitmaps are allowed to schedule, is_reusable() is called from
 do_balance(), which will panic if a schedule occurs in certain places.

 The benefit of on-demand bitmaps clearly outweighs a sanity check that
 depends on a compile-time option that is discouraged.


Signed-off-by: Jeff Mahoney <jeffm@suse.com>

--
 fs/reiserfs/bitmap.c           |   97 ++++++++++++++++++-----------------------
 fs/reiserfs/resize.c           |   24 +++++++---
 fs/reiserfs/super.c            |   29 +-----------
 include/linux/reiserfs_fs_sb.h |    1 
 4 files changed, 64 insertions(+), 87 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c
--- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c	2006-05-01 19:46:11.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c	2006-05-01 19:46:11.000000000 -0400
@@ -61,7 +61,6 @@ static inline void get_bit_address(struc
 int is_reusable(struct super_block *s, b_blocknr_t block, int bit_value)
 {
 	int bmap, offset;
-	struct buffer_head *bh;
 
 	if (block == 0 || block >= SB_BLOCK_COUNT(s)) {
 		reiserfs_warning(s,
@@ -99,22 +98,6 @@ int is_reusable(struct super_block *s, b
 		return 0;
 	}
 
-	bh = SB_AP_BITMAP(s)[bmap].bh;
-	get_bh(bh);
-
-	if ((bit_value == 0 && reiserfs_test_le_bit(offset, bh->b_data)) ||
-	    (bit_value == 1 && reiserfs_test_le_bit(offset, bh->b_data) == 0)) {
-		reiserfs_warning(s,
-				 "vs-4040: is_reusable: corresponding bit of block %lu does not "
-				 "match required value (bmap==%d, offset==%d) test_bit==%d",
-				 block, bmap, offset,
-				 reiserfs_test_le_bit(offset, bh->b_data));
-
-		brelse(bh);
-		return 0;
-	}
-	brelse(bh);
-
 	if (bit_value == 0 && block == SB_ROOT_BLOCK(s)) {
 		reiserfs_warning(s,
 				 "vs-4050: is_reusable: this is root block (%u), "
@@ -174,13 +157,10 @@ static int scan_bitmap_block(struct reis
 				 bmap_n);
 		return 0;
 	}
-	bh = bi->bh;
-	get_bh(bh);
 
-	if (buffer_locked(bh)) {
-		PROC_INFO_INC(s, scan_bitmap.wait);
-		__wait_on_buffer(bh);
-	}
+	bh = reiserfs_read_bitmap_block(s, bmap_n);
+	if (bh == NULL)
+		return 0;
 
 	while (1) {
 	      cont:
@@ -286,9 +266,20 @@ static int bmap_hash_id(struct super_blo
  */
 static inline int block_group_used(struct super_block *s, u32 id)
 {
-	int bm;
-	bm = bmap_hash_id(s, id);
-	if (SB_AP_BITMAP(s)[bm].free_count > ((s->s_blocksize << 3) * 60 / 100)) {
+	int bm = bmap_hash_id(s, id);
+	struct reiserfs_bitmap_info *info = &SB_AP_BITMAP(s)[bm];
+
+	/* If we don't have cached information on this bitmap block, we're
+	 * going to have to load it later anyway. Loading it here allows us
+	 * to make a better decision. This favors long-term performace gain
+	 * with a better on-disk layout vs. a short term gain of skipping the
+	 * read and potentially having a bad placement. */
+	if (info->first_zero_hint == 0) {
+		struct buffer_head *bh = reiserfs_read_bitmap_block(s, bm);
+		brelse(bh);
+	}
+
+	if (info->free_count > ((s->s_blocksize << 3) * 60 / 100)) {
 		return 0;
 	}
 	return 1;
@@ -414,8 +405,9 @@ static void _reiserfs_free_block(struct 
 		return;
 	}
 
-	bmbh = apbi[nr].bh;
-	get_bh(bmbh);
+	bmbh = reiserfs_read_bitmap_block(s, nr);
+	if (!bmbh)
+		return;
 
 	reiserfs_prepare_for_journal(s, bmbh, 1);
 
@@ -1319,6 +1311,7 @@ struct buffer_head *reiserfs_read_bitmap
                                                unsigned int bitmap)
 {
 	b_blocknr_t block = (sb->s_blocksize << 3) * bitmap;
+	struct reiserfs_bitmap_info *info = SB_AP_BITMAP(sb) + bitmap;
 	struct buffer_head *bh;
 
 	/* Way old format filesystems had the bitmaps packed up front.
@@ -1329,9 +1322,21 @@ struct buffer_head *reiserfs_read_bitmap
 	else if (bitmap == 0)
 		block = (REISERFS_DISK_OFFSET_IN_BYTES >> sb->s_blocksize_bits) + 1;
 
-	bh = sb_getblk(sb, block);
-	if (!buffer_uptodate(bh))
-		ll_rw_block(READ, 1, &bh);
+	bh = sb_bread(sb, block);
+	if (bh == NULL)
+		reiserfs_warning(sb, "sh-2029: %s: bitmap block (#%lu) "
+		                 "reading failed", __FUNCTION__, bh->b_blocknr);
+	else {
+		if (buffer_locked(bh)) {
+			PROC_INFO_INC(sb, scan_bitmap.wait);
+			__wait_on_buffer(bh);
+		}
+		BUG_ON(!buffer_uptodate(bh));
+		BUG_ON(atomic_read(&bh->b_count) == 0);
+		
+		if (info->first_zero_hint == 0)
+			reiserfs_cache_bitmap_metadata(sb, bh, info);
+	}
 
 	return bh;
 }
@@ -1339,7 +1344,6 @@ struct buffer_head *reiserfs_read_bitmap
 int reiserfs_init_bitmap_cache(struct super_block *sb)
 {
 	struct reiserfs_bitmap_info *bitmap;
-	int i;
 
 	bitmap = vmalloc(sizeof (*bitmap) * SB_BMAP_NR(sb));
 	if (bitmap == NULL)
@@ -1347,28 +1351,15 @@ int reiserfs_init_bitmap_cache(struct su
 
 	memset(bitmap, 0, sizeof (*bitmap) * SB_BMAP_NR(sb));
 
-	for (i = 0; i < SB_BMAP_NR(sb); i++)
-		bitmap[i].bh = reiserfs_read_bitmap_block(sb, i);
-
-	/* make sure we have them all */
-	for (i = 0; i < SB_BMAP_NR(sb); i++) {
-		wait_on_buffer(bitmap[i].bh);
-		if (!buffer_uptodate(bitmap[i].bh)) {
-			reiserfs_warning(sb, "sh-2029: %s: "
-					 "bitmap block (#%lu) reading failed",
-			                 __FUNCTION__, bitmap[i].bh->b_blocknr);
-			for (i = 0; i < SB_BMAP_NR(sb); i++)
-				brelse(bitmap[i].bh);
-			vfree(bitmap);
-			return -EIO;
-		}
-	}
-
-	/* Cache the info on the bitmaps before we get rolling */
-	for (i = 0; i < SB_BMAP_NR(sb); i++)
-		reiserfs_cache_bitmap_metadata(sb, bitmap[i].bh, &bitmap[i]);
-
 	SB_AP_BITMAP(sb) = bitmap;
 
 	return 0;
 }
+
+void reiserfs_free_bitmap_cache(struct super_block *sb)
+{
+	if (SB_AP_BITMAP(sb)) {
+		vfree(SB_AP_BITMAP(sb));
+		SB_AP_BITMAP(sb) = NULL;
+	}
+}
diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/resize.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/resize.c
--- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/resize.c	2006-05-01 19:46:11.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/resize.c	2006-05-01 19:46:11.000000000 -0400
@@ -128,8 +128,9 @@ int reiserfs_resize(struct super_block *
 		 * transaction begins, and the new bitmaps don't matter if the
 		 * transaction fails. */
 		for (i = bmap_nr; i < bmap_nr_new; i++) {
-			bh = sb_getblk(s, i * s->s_blocksize * 8);
-			get_bh(bh);
+			/* don't use read_bitmap_block since it will cache
+			 * the uninitialized bitmap */
+			bh = sb_bread(s, i * s->s_blocksize * 8);
 			memset(bh->b_data, 0, sb_blocksize(sb));
 			reiserfs_test_and_set_le_bit(0, bh->b_data);
 			reiserfs_cache_bitmap_metadata(s, bh, bitmap + i);
@@ -140,7 +141,6 @@ int reiserfs_resize(struct super_block *
 			// update bitmap_info stuff
 			bitmap[i].first_zero_hint = 1;
 			bitmap[i].free_count = sb_blocksize(sb) * 8 - 1;
-			bitmap[i].bh = bh;
 			brelse(bh);
 		}
 		/* free old bitmap blocks array */
@@ -157,8 +157,13 @@ int reiserfs_resize(struct super_block *
 
 	/* Extend old last bitmap block - new blocks have been made available */
 	info = SB_AP_BITMAP(s) + bmap_nr - 1;
-	bh = info->bh;
-	get_bh(bh);
+	bh = reiserfs_read_bitmap_block(s, bmap_nr - 1);
+	if (!bh) {
+		int jerr = journal_end(&th, s, 10);
+		if (jerr)
+			return jerr;
+		return -EIO;
+	}
 
 	reiserfs_prepare_for_journal(s, bh, 1);
 	for (i = block_r; i < s->s_blocksize * 8; i++)
@@ -172,8 +177,13 @@ int reiserfs_resize(struct super_block *
 
 	/* Correct new last bitmap block - It may not be full */
 	info = SB_AP_BITMAP(s) + bmap_nr_new - 1;
-	bh = info->bh;
-	get_bh(bh);
+	bh = reiserfs_read_bitmap_block(s, bmap_nr_new - 1);
+	if (!bh) {
+		int jerr = journal_end(&th, s, 10);
+		if (jerr)
+			return jerr;
+		return -EIO;
+	}
 
 	reiserfs_prepare_for_journal(s, bh, 1);
 	for (i = block_r_new; i < s->s_blocksize * 8; i++)
diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c
--- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c	2006-05-01 19:46:11.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c	2006-05-01 19:46:11.000000000 -0400
@@ -433,7 +433,6 @@ int remove_save_link(struct inode *inode
 
 static void reiserfs_put_super(struct super_block *s)
 {
-	int i;
 	struct reiserfs_transaction_handle th;
 	th.t_trans_id = 0;
 
@@ -463,10 +462,7 @@ static void reiserfs_put_super(struct su
 	 */
 	journal_release(&th, s);
 
-	for (i = 0; i < SB_BMAP_NR(s); i++)
-		brelse(SB_AP_BITMAP(s)[i].bh);
-
-	vfree(SB_AP_BITMAP(s));
+	reiserfs_free_bitmap_cache(s);
 
 	brelse(SB_BUFFER_WITH_SB(s));
 
@@ -1358,7 +1354,6 @@ static int read_super_block(struct super
 /* after journal replay, reread all bitmap and super blocks */
 static int reread_meta_blocks(struct super_block *s)
 {
-	int i;
 	ll_rw_block(READ, 1, &(SB_BUFFER_WITH_SB(s)));
 	wait_on_buffer(SB_BUFFER_WITH_SB(s));
 	if (!buffer_uptodate(SB_BUFFER_WITH_SB(s))) {
@@ -1367,20 +1362,7 @@ static int reread_meta_blocks(struct sup
 		return 1;
 	}
 
-	for (i = 0; i < SB_BMAP_NR(s); i++) {
-		ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i].bh));
-		wait_on_buffer(SB_AP_BITMAP(s)[i].bh);
-		if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
-			reiserfs_warning(s,
-					 "reread_meta_blocks, error reading bitmap block number %d at %llu",
-					 i,
-					 (unsigned long long)SB_AP_BITMAP(s)[i].
-					 bh->b_blocknr);
-			return 1;
-		}
-	}
 	return 0;
-
 }
 
 /////////////////////////////////////////////////////
@@ -1807,13 +1789,8 @@ static int reiserfs_fill_super(struct su
 	if (jinit_done) {	/* kill the commit thread, free journal ram */
 		journal_release_error(NULL, s);
 	}
-	if (SB_DISK_SUPER_BLOCK(s)) {
-		for (j = 0; j < SB_BMAP_NR(s); j++) {
-			if (SB_AP_BITMAP(s))
-				brelse(SB_AP_BITMAP(s)[j].bh);
-		}
-		vfree(SB_AP_BITMAP(s));
-	}
+
+	reiserfs_free_bitmap_cache(s);
 	if (SB_BUFFER_WITH_SB(s))
 		brelse(SB_BUFFER_WITH_SB(s));
 #ifdef CONFIG_QUOTA
diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs_sb.h linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs_sb.h
--- linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs_sb.h	2006-05-01 19:46:08.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs_sb.h	2006-05-01 19:46:11.000000000 -0400
@@ -267,7 +267,6 @@ struct reiserfs_bitmap_info {
 	// FIXME: Won't work with block sizes > 8K
 	__u16 first_zero_hint;
 	__u16 free_count;
-	struct buffer_head *bh;	/* the actual bitmap */
 };
 
 struct proc_dir_entry;
