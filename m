Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWFOBmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWFOBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFOBmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 21:42:16 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:41810 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932404AbWFOBmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 21:42:16 -0400
Date: Wed, 14 Jun 2006 21:42:02 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ReiserFS Mailing list <reiserfs-list@namesys.com>
Subject: [PATCH 01/04] reiserfs: fix is_reusable bitmap check to not traverse the bitmap info array
Message-ID: <20060615014202.GA8192@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.257-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 There is a check in is_reusable to determine if a particular block is a bitmap
 block. It verifies this by going through the array of bitmap block buffer
 heads and comparing the block number to each one.

 Bitmap blocks are at defined locations on the disk in both old and current
 formats. Simply checking against the known good values is enough.

 This is a trivial optimization for a non-production codepath, but this is the
 first in a series of patches that will ultimately remove the buffer heads
 from that array.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

--
 fs/reiserfs/bitmap.c           |   40 +++++++++++++++++++++++++---------------
 fs/reiserfs/super.c            |    2 ++
 include/linux/reiserfs_fs_sb.h |    1 +
 3 files changed, 28 insertions(+), 15 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c
--- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c	2006-05-01 19:46:07.000000000 -0400
@@ -51,16 +51,15 @@ static inline void get_bit_address(struc
 {
 	/* It is in the bitmap block number equal to the block
 	 * number divided by the number of bits in a block. */
-	*bmap_nr = block / (s->s_blocksize << 3);
+	*bmap_nr = block >> (s->s_blocksize_bits + 3);
 	/* Within that bitmap block it is located at bit offset *offset. */
 	*offset = block & ((s->s_blocksize << 3) - 1);
-	return;
 }
 
 #ifdef CONFIG_REISERFS_CHECK
 int is_reusable(struct super_block *s, b_blocknr_t block, int bit_value)
 {
-	int i, j;
+	int bmap, offset;
 
 	if (block == 0 || block >= SB_BLOCK_COUNT(s)) {
 		reiserfs_warning(s,
@@ -69,34 +68,45 @@ int is_reusable(struct super_block *s, b
 		return 0;
 	}
 
-	/* it can't be one of the bitmap blocks */
-	for (i = 0; i < SB_BMAP_NR(s); i++)
-		if (block == SB_AP_BITMAP(s)[i].bh->b_blocknr) {
+	get_bit_address(s, block, &bmap, &offset);
+
+	/* Old format filesystem? Unlikely, but the bitmaps are all up front so
+	 * we need to account for it. */
+	if (unlikely(test_bit(REISERFS_OLD_FORMAT,
+			      &(REISERFS_SB(s)->s_properties)))) {
+		b_blocknr_t bmap1 = REISERFS_SB(s)->s_sbh->b_blocknr + 1;
+		if (block >= bmap1 && block <= bmap1 + SB_BMAP_NR(s)) {
+			reiserfs_warning(s, "vs: 4019: is_reusable: "
+					 "bitmap block %lu(%u) can't be freed or reused",
+					 block, SB_BMAP_NR(s));
+			return 0;
+		}
+	} else {
+		if (offset == 0) {
 			reiserfs_warning(s, "vs: 4020: is_reusable: "
 					 "bitmap block %lu(%u) can't be freed or reused",
 					 block, SB_BMAP_NR(s));
 			return 0;
 		}
+	}
 
-	get_bit_address(s, block, &i, &j);
-
-	if (i >= SB_BMAP_NR(s)) {
+	if (bmap >= SB_BMAP_NR(s)) {
 		reiserfs_warning(s,
 				 "vs-4030: is_reusable: there is no so many bitmap blocks: "
-				 "block=%lu, bitmap_nr=%d", block, i);
+				 "block=%lu, bitmap_nr=%d", block, bmap);
 		return 0;
 	}
 
 	if ((bit_value == 0 &&
-	     reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i].bh->b_data)) ||
+	     reiserfs_test_le_bit(offset, SB_AP_BITMAP(s)[bmap].bh->b_data)) ||
 	    (bit_value == 1 &&
-	     reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i].bh->b_data) == 0)) {
+	     reiserfs_test_le_bit(offset, SB_AP_BITMAP(s)[bmap].bh->b_data) == 0)) {
 		reiserfs_warning(s,
 				 "vs-4040: is_reusable: corresponding bit of block %lu does not "
-				 "match required value (i==%d, j==%d) test_bit==%d",
-				 block, i, j, reiserfs_test_le_bit(j,
+				 "match required value (bmap==%d, offset==%d) test_bit==%d",
+				 block, bmap, offset, reiserfs_test_le_bit(offset,
 								   SB_AP_BITMAP
-								   (s)[i].bh->
+								   (s)[bmap].bh->
 								   b_data));
 
 		return 0;
diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c
--- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c	2006-05-01 19:45:33.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c	2006-05-01 19:46:07.000000000 -0400
@@ -1832,6 +1832,8 @@ static int reiserfs_fill_super(struct su
 	if (is_reiserfs_3_5(rs)
 	    || (is_reiserfs_jr(rs) && SB_VERSION(s) == REISERFS_VERSION_1))
 		set_bit(REISERFS_3_5, &(sbi->s_properties));
+	else if (old_format)
+		set_bit(REISERFS_OLD_FORMAT, &(sbi->s_properties));
 	else
 		set_bit(REISERFS_3_6, &(sbi->s_properties));
 
diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs_sb.h linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs_sb.h
--- linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs_sb.h	2006-04-05 04:46:00.000000000 -0400
+++ linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs_sb.h	2006-05-01 19:46:07.000000000 -0400
@@ -414,6 +414,7 @@ struct reiserfs_sb_info {
 /* Definitions of reiserfs on-disk properties: */
 #define REISERFS_3_5 0
 #define REISERFS_3_6 1
+#define REISERFS_OLD_FORMAT 2
 
 enum reiserfs_mount_options {
 /* Mount options */
