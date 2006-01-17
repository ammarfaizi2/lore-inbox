Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWAQUaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWAQUaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWAQUae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:30:34 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:27489 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964823AbWAQUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:30:31 -0500
Date: Tue, 17 Jan 2006 15:30:30 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] reiserfs: move bitmap loading to bitmap.c
Message-ID: <20060117203029.GA24913@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch moves the bitmap loading code from super.c to bitmap.c

 The code is also restructured somewhat. The only difference between new
 format bitmaps and old format bitmaps is where they are. That's a two liner
 before loading the block to use the correct one. There's no need for
 an entirely separate code path.

 The load path is generally the same, with the pattern being to throw out a
 bunch of requests and then wait for them, then cache the metadata from
 the contents.

 Again, like the previous patches, the purpose is to set up for later ones.

 fs/reiserfs/bitmap.c        |   83 ++++++++++++++++++++++++++++++++
 fs/reiserfs/resize.c        |    1 
 fs/reiserfs/super.c         |  114 --------------------------------------------
 include/linux/reiserfs_fs.h |    3 +
 4 files changed, 88 insertions(+), 113 deletions(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/bitmap.c	2006-01-16 16:53:31.512950088 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/bitmap.c	2006-01-16 16:53:31.516949480 -0500
@@ -10,6 +10,7 @@
 #include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/vmalloc.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/quotaops.h>
@@ -1286,3 +1287,85 @@ int reiserfs_can_fit_pages(struct super_
 
 	return space > 0 ? space : 0;
 }
+
+void reiserfs_cache_bitmap_metadata(struct super_block *sb,
+                                    struct buffer_head *bh,
+                                    struct reiserfs_bitmap_info *info)
+{
+	unsigned long *cur = (unsigned long *)bh->b_data;
+	int i;
+
+	for (i = sb->s_blocksize / sizeof (*cur); i > 0; i--, cur++) {
+		/* 0 and ~0 are special, we can optimize for them */
+		if (*cur == 0) {
+			info->first_zero_hint = i << 3;
+			info->free_count += sizeof (*cur) << 3;
+		} else if (*cur != ~0L) {       /* A mix, investigate */
+			int b;
+			for (b = sizeof (*cur) << 3; b >= 0; b--) {
+				if (!reiserfs_test_le_bit(b, cur)) {
+					info->first_zero_hint = (i << 3) + b;
+					info->free_count++;
+				}
+			}
+		}
+	}
+
+	/* The first bit must ALWAYS be 1 */
+	BUG_ON(info->first_zero_hint == 0);
+}
+
+struct buffer_head *reiserfs_read_bitmap_block(struct super_block *sb,
+                                               unsigned int bitmap)
+{
+	unsigned int block = (sb->s_blocksize << 3) * bitmap;
+	struct buffer_head *bh;
+
+	/* Way old format filesystems had the bitmaps packed up front.
+	 * I doubt there are any of these left, but just in case... */
+	if (test_bit(REISERFS_OLD_FORMAT, &(REISERFS_SB(sb)->s_properties)))
+		block = REISERFS_SB(sb)->s_sbh->b_blocknr + 1 + bitmap;
+
+	bh = sb_getblk(sb, block);
+	if (!buffer_uptodate(bh))
+		ll_rw_block(READ, 1, &bh);
+
+	return bh;
+}
+
+int reiserfs_init_bitmap_cache(struct super_block *sb)
+{
+	struct reiserfs_bitmap_info *bitmap;
+	int i;
+
+	bitmap = vmalloc(sizeof (*bitmap) * SB_BMAP_NR(sb));
+	if (bitmap == NULL)
+		return 1;
+
+	memset(bitmap, 0, sizeof (*bitmap) * SB_BMAP_NR(sb));
+
+	for (i = 0; i < SB_BMAP_NR(sb); i++)
+		bitmap[i].bh = reiserfs_read_bitmap_block(sb, i);
+
+	/* make sure we have them all */
+	for (i = 0; i < SB_BMAP_NR(sb); i++) {
+		wait_on_buffer(bitmap[i].bh);
+		if (!buffer_uptodate(bitmap[i].bh)) {
+			reiserfs_warning(sb, "sh-2029: reiserfs read_bitmaps: "
+					 "bitmap block (#%lu) reading failed",
+					 bitmap[i].bh->b_blocknr);
+			for (i = 0; i < SB_BMAP_NR(sb); i++)
+				brelse(bitmap[i].bh);
+			vfree(bitmap);
+			return 1;
+		}
+	}
+
+	/* Cache the info on the bitmaps before we get rolling */
+	for (i = 0; i < SB_BMAP_NR(sb); i++)
+		reiserfs_cache_bitmap_metadata(sb, bitmap[i].bh, &bitmap[i]);
+
+	SB_AP_BITMAP(sb) = bitmap;
+
+	return 0;
+}
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/resize.c linux-2.6.15.orig.staging2/fs/reiserfs/resize.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/resize.c	2006-01-16 16:53:31.513949936 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/resize.c	2006-01-16 16:53:31.520948872 -0500
@@ -132,6 +132,7 @@ int reiserfs_resize(struct super_block *
 			get_bh(bh);
 			memset(bh->b_data, 0, sb_blocksize(sb));
 			reiserfs_test_and_set_le_bit(0, bh->b_data);
+			reiserfs_cache_bitmap_metadata(s, bh, bitmap + i);
 
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/fs/reiserfs/super.c linux-2.6.15.orig.staging2/fs/reiserfs/super.c
--- linux-2.6.15.orig.staging1/fs/reiserfs/super.c	2006-01-16 16:53:29.452263360 -0500
+++ linux-2.6.15.orig.staging2/fs/reiserfs/super.c	2006-01-16 16:53:31.518949176 -0500
@@ -1264,118 +1264,6 @@ static int reiserfs_remount(struct super
 	return 0;
 }
 
-/* load_bitmap_info_data - Sets up the reiserfs_bitmap_info structure from disk.
- * @sb - superblock for this filesystem
- * @bi - the bitmap info to be loaded. Requires that bi->bh is valid.
- *
- * This routine counts how many free bits there are, finding the first zero
- * as a side effect. Could also be implemented as a loop of test_bit() calls, or
- * a loop of find_first_zero_bit() calls. This implementation is similar to
- * find_first_zero_bit(), but doesn't return after it finds the first bit.
- * Should only be called on fs mount, but should be fairly efficient anyways.
- *
- * bi->first_zero_hint is considered unset if it == 0, since the bitmap itself
- * will * invariably occupt block 0 represented in the bitmap. The only
- * exception to this is when free_count also == 0, since there will be no
- * free blocks at all.
- */
-
-static void load_bitmap_info_data(struct super_block *sb,
-				  struct reiserfs_bitmap_info *bi)
-{
-	unsigned long *cur = (unsigned long *)bi->bh->b_data;
-
-	while ((char *)cur < (bi->bh->b_data + sb->s_blocksize)) {
-
-		/* No need to scan if all 0's or all 1's.
-		 * Since we're only counting 0's, we can simply ignore all 1's */
-		if (*cur == 0) {
-			if (bi->first_zero_hint == 0) {
-				bi->first_zero_hint =
-				    ((char *)cur - bi->bh->b_data) << 3;
-			}
-			bi->free_count += sizeof(unsigned long) * 8;
-		} else if (*cur != ~0L) {
-			int b;
-			for (b = 0; b < sizeof(unsigned long) * 8; b++) {
-				if (!reiserfs_test_le_bit(b, cur)) {
-					bi->free_count++;
-					if (bi->first_zero_hint == 0)
-						bi->first_zero_hint =
-						    (((char *)cur -
-						      bi->bh->b_data) << 3) + b;
-				}
-			}
-		}
-		cur++;
-	}
-
-#ifdef CONFIG_REISERFS_CHECK
-// This outputs a lot of unneded info on big FSes
-//    reiserfs_warning ("bitmap loaded from block %d: %d free blocks",
-//                    bi->bh->b_blocknr, bi->free_count);
-#endif
-}
-
-static int read_bitmaps(struct super_block *s)
-{
-	int i, bmap_nr;
-
-	SB_AP_BITMAP(s) =
-	    vmalloc(sizeof(struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
-	if (SB_AP_BITMAP(s) == 0)
-		return 1;
-	memset(SB_AP_BITMAP(s), 0,
-	       sizeof(struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
-	for (i = 0, bmap_nr =
-	     REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
-	     i < SB_BMAP_NR(s); i++, bmap_nr = s->s_blocksize * 8 * i) {
-		SB_AP_BITMAP(s)[i].bh = sb_getblk(s, bmap_nr);
-		if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh))
-			ll_rw_block(READ, 1, &SB_AP_BITMAP(s)[i].bh);
-	}
-	for (i = 0; i < SB_BMAP_NR(s); i++) {
-		wait_on_buffer(SB_AP_BITMAP(s)[i].bh);
-		if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
-			reiserfs_warning(s, "sh-2029: reiserfs read_bitmaps: "
-					 "bitmap block (#%lu) reading failed",
-					 SB_AP_BITMAP(s)[i].bh->b_blocknr);
-			for (i = 0; i < SB_BMAP_NR(s); i++)
-				brelse(SB_AP_BITMAP(s)[i].bh);
-			vfree(SB_AP_BITMAP(s));
-			SB_AP_BITMAP(s) = NULL;
-			return 1;
-		}
-		load_bitmap_info_data(s, SB_AP_BITMAP(s) + i);
-	}
-	return 0;
-}
-
-static int read_old_bitmaps(struct super_block *s)
-{
-	int i;
-	struct reiserfs_super_block *rs = SB_DISK_SUPER_BLOCK(s);
-	int bmp1 = (REISERFS_OLD_DISK_OFFSET_IN_BYTES / s->s_blocksize) + 1;	/* first of bitmap blocks */
-
-	/* read true bitmap */
-	SB_AP_BITMAP(s) =
-	    vmalloc(sizeof(struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
-	if (SB_AP_BITMAP(s) == 0)
-		return 1;
-
-	memset(SB_AP_BITMAP(s), 0,
-	       sizeof(struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
-
-	for (i = 0; i < sb_bmap_nr(rs); i++) {
-		SB_AP_BITMAP(s)[i].bh = sb_bread(s, bmp1 + i);
-		if (!SB_AP_BITMAP(s)[i].bh)
-			return 1;
-		load_bitmap_info_data(s, SB_AP_BITMAP(s) + i);
-	}
-
-	return 0;
-}
-
 static int read_super_block(struct super_block *s, int offset)
 {
 	struct buffer_head *bh;
@@ -1757,7 +1645,7 @@ static int reiserfs_fill_super(struct su
 	sbi->s_mount_state = SB_REISERFS_STATE(s);
 	sbi->s_mount_state = REISERFS_VALID_FS;
 
-	if (old_format ? read_old_bitmaps(s) : read_bitmaps(s)) {
+	if (reiserfs_init_bitmap_cache(s)) {
 		SWARN(silent, s,
 		      "jmacd-8: reiserfs_fill_super: unable to read bitmap");
 		goto error;
diff -ruNpX ../dontdiff linux-2.6.15.orig.staging1/include/linux/reiserfs_fs.h linux-2.6.15.orig.staging2/include/linux/reiserfs_fs.h
--- linux-2.6.15.orig.staging1/include/linux/reiserfs_fs.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.orig.staging2/include/linux/reiserfs_fs.h	2006-01-16 16:53:31.520948872 -0500
@@ -2092,6 +2092,9 @@ void reiserfs_init_alloc_options(struct 
  */
 __le32 reiserfs_choose_packing(struct inode *dir);
 
+int reiserfs_init_bitmap_cache(struct super_block *sb);
+void reiserfs_cache_bitmap_metadata(struct super_block *sb, struct buffer_head *bh, struct reiserfs_bitmap_info *info);
+struct buffer_head *reiserfs_read_bitmap_block(struct super_block *sb, unsigned int bitmap);
 int is_reusable(struct super_block *s, b_blocknr_t block, int bit_value);
 void reiserfs_free_block(struct reiserfs_transaction_handle *th, struct inode *,
 			 b_blocknr_t, int for_unformatted);
-- 
Jeff Mahoney
SuSE Labs
