Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWAQUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWAQUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWAQUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:30:56 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:28513 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964820AbWAQUaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:30:55 -0500
Date: Tue, 17 Jan 2006 15:30:54 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] reiserfs: on-demand bitmap loading
Message-ID: <20060117203053.GA24935@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
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

 fs/reiserfs/bitmap.c           |   76 ++++++++++++++++++++---------------------
 fs/reiserfs/resize.c           |   24 +++++++++---
 fs/reiserfs/super.c            |   25 -------------
 include/linux/reiserfs_fs_sb.h |    1 
 4 files changed, 56 insertions(+), 70 deletions(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c	2006-01-16 16:53:33.626628760 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c	2006-01-16 16:53:33.634627544 -0500
@@ -101,8 +101,9 @@ int is_reusable(struct super_block *s, b
 		return 0;
 	}
 
-	bh = SB_AP_BITMAP(s)[i].bh;
-	get_bh(bh);
+	bh = reiserfs_read_bitmap_block(s, bmap);
+	if (bh == NULL)
+		return 0;
 
 	if ((bit_value == 0 && reiserfs_test_le_bit(j, bh->b_data)) ||
 	    (bit_value == 1 && reiserfs_test_le_bit(j, bh->b_data) == 0)) {
@@ -175,13 +176,10 @@ static int scan_bitmap_block(struct reis
 				 bmap_n);
 		return 0;
 	}
-	bh = bi->bh;
-	get_bh(bh);
 
-	if (buffer_locked(bi->bh)) {
-		PROC_INFO_INC(s, scan_bitmap.wait);
-		__wait_on_buffer(bh);
-	}
+	bh = reiserfs_read_bitmap_block(s, bmap_n);
+	if (bh == NULL)
+		return 0;
 
 	while (1) {
 		if (bi->free_count < min) {
@@ -286,9 +284,20 @@ static int bmap_hash_id(struct super_blo
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
@@ -414,8 +423,9 @@ static void _reiserfs_free_block(struct 
 		return;
 	}
 
-	bmbh = apbi[nr].bh;
-	get_bh(bmbh);
+	bmbh = reiserfs_read_bitmap_block(s, nr);
+	if (!bmbh)
+		return;
 
 	reiserfs_prepare_for_journal(s, bmbh, 1);
 
@@ -1319,6 +1329,7 @@ struct buffer_head *reiserfs_read_bitmap
                                                unsigned int bitmap)
 {
 	unsigned int block = (sb->s_blocksize << 3) * bitmap;
+	struct reiserfs_bitmap_info *info = SB_AP_BITMAP(sb) + bitmap;
 	struct buffer_head *bh;
 
 	/* Way old format filesystems had the bitmaps packed up front.
@@ -1326,9 +1337,20 @@ struct buffer_head *reiserfs_read_bitmap
 	if (test_bit(REISERFS_OLD_FORMAT, &(REISERFS_SB(sb)->s_properties)))
 		block = REISERFS_SB(sb)->s_sbh->b_blocknr + 1 + bitmap;
 
-	bh = sb_getblk(sb, block);
-	if (!buffer_uptodate(bh))
-		ll_rw_block(READ, 1, &bh);
+	bh = sb_bread(sb, block);
+	if (bh == NULL)
+		reiserfs_warning(sb, "sh-2029: reiserfs read_bitmaps: "
+				 "bitmap block (#%lu) reading failed",
+				 bh->b_blocknr);
+	else {
+		if (buffer_locked(bh)) {
+			PROC_INFO_INC(s, scan_bitmap.wait);
+			__wait_on_buffer(bh);
+		}
+		
+		if (info->first_zero_hint == 0)
+			reiserfs_cache_bitmap_metadata(sb, bh, info);
+	}
 
 	return bh;
 }
@@ -1336,7 +1358,6 @@ struct buffer_head *reiserfs_read_bitmap
 int reiserfs_init_bitmap_cache(struct super_block *sb)
 {
 	struct reiserfs_bitmap_info *bitmap;
-	int i;
 
 	bitmap = vmalloc(sizeof (*bitmap) * SB_BMAP_NR(sb));
 	if (bitmap == NULL)
@@ -1344,27 +1365,6 @@ int reiserfs_init_bitmap_cache(struct su
 
 	memset(bitmap, 0, sizeof (*bitmap) * SB_BMAP_NR(sb));
 
-	for (i = 0; i < SB_BMAP_NR(sb); i++)
-		bitmap[i].bh = reiserfs_read_bitmap_block(sb, i);
-
-	/* make sure we have them all */
-	for (i = 0; i < SB_BMAP_NR(sb); i++) {
-		wait_on_buffer(bitmap[i].bh);
-		if (!buffer_uptodate(bitmap[i].bh)) {
-			reiserfs_warning(sb, "sh-2029: reiserfs read_bitmaps: "
-					 "bitmap block (#%lu) reading failed",
-					 bitmap[i].bh->b_blocknr);
-			for (i = 0; i < SB_BMAP_NR(sb); i++)
-				brelse(bitmap[i].bh);
-			vfree(bitmap);
-			return 1;
-		}
-	}
-
-	/* Cache the info on the bitmaps before we get rolling */
-	for (i = 0; i < SB_BMAP_NR(sb); i++)
-		reiserfs_cache_bitmap_metadata(sb, bitmap[i].bh, &bitmap[i]);
-
 	SB_AP_BITMAP(sb) = bitmap;
 
 	return 0;
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/resize.c linux-2.6.15.orig.staging2/fs/reiserfs/resize.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/resize.c	2006-01-16 16:53:33.626628760 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/resize.c	2006-01-16 16:53:33.636627240 -0500
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
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/super.c linux-2.6.15.orig.staging2/fs/reiserfs/super.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/super.c	2006-01-16 16:53:33.628628456 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/super.c	2006-01-16 16:53:33.637627088 -0500
@@ -433,7 +433,6 @@ int remove_save_link(struct inode *inode
 
 static void reiserfs_put_super(struct super_block *s)
 {
-	int i;
 	struct reiserfs_transaction_handle th;
 	th.t_trans_id = 0;
 
@@ -463,9 +462,6 @@ static void reiserfs_put_super(struct su
 	 */
 	journal_release(&th, s);
 
-	for (i = 0; i < SB_BMAP_NR(s); i++)
-		brelse(SB_AP_BITMAP(s)[i].bh);
-
 	vfree(SB_AP_BITMAP(s));
 
 	brelse(SB_BUFFER_WITH_SB(s));
@@ -1365,7 +1361,6 @@ static int read_super_block(struct super
 /* after journal replay, reread all bitmap and super blocks */
 static int reread_meta_blocks(struct super_block *s)
 {
-	int i;
 	ll_rw_block(READ, 1, &(SB_BUFFER_WITH_SB(s)));
 	wait_on_buffer(SB_BUFFER_WITH_SB(s));
 	if (!buffer_uptodate(SB_BUFFER_WITH_SB(s))) {
@@ -1374,20 +1369,7 @@ static int reread_meta_blocks(struct sup
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
@@ -1814,13 +1796,8 @@ static int reiserfs_fill_super(struct su
 	if (jinit_done) {	/* kill the commit thread, free journal ram */
 		journal_release_error(NULL, s);
 	}
-	if (SB_DISK_SUPER_BLOCK(s)) {
-		for (j = 0; j < SB_BMAP_NR(s); j++) {
-			if (SB_AP_BITMAP(s))
-				brelse(SB_AP_BITMAP(s)[j].bh);
-		}
+	if (SB_DISK_SUPER_BLOCK(s))
 		vfree(SB_AP_BITMAP(s));
-	}
 	if (SB_BUFFER_WITH_SB(s))
 		brelse(SB_BUFFER_WITH_SB(s));
 #ifdef CONFIG_QUOTA
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/include/linux/reiserfs_fs_sb.h linux-2.6.15.orig.staging2/include/linux/reiserfs_fs_sb.h
--- linux-2.6.15.orig.staging1/include/linux/reiserfs_fs_sb.h	2006-01-16 16:53:29.453263208 -0500
+++ linux-2.6.15.orig.staging2/include/linux/reiserfs_fs_sb.h	2006-01-16 16:53:33.638626936 -0500
@@ -267,7 +267,6 @@ struct reiserfs_bitmap_info {
 	// FIXME: Won't work with block sizes > 8K
 	__u16 first_zero_hint;
 	__u16 free_count;
-	struct buffer_head *bh;	/* the actual bitmap */
 };
 
 struct proc_dir_entry;
-- 
Jeff Mahoney
SuSE Labs
