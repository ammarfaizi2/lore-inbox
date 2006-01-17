Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWAQU3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWAQU3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWAQU3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:29:55 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:25185 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964815AbWAQU3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:29:54 -0500
Date: Tue, 17 Jan 2006 15:29:53 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] reiserfs: fix is_reusable bitmap check to not traverse the bitmap info array
Message-ID: <20060117202952.GA24871@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
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

 fs/reiserfs/bitmap.c           |   18 +++++++++++++++---
 fs/reiserfs/super.c            |    2 ++
 include/linux/reiserfs_fs_sb.h |    1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.15.staging1/fs/reiserfs/bitmap.c linux-2.6.15.staging2/fs/reiserfs/bitmap.c
--- linux-2.6.15.staging1/fs/reiserfs/bitmap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.staging2/fs/reiserfs/bitmap.c	2006-01-16 16:53:27.330585904 -0500
@@ -61,6 +61,7 @@ static inline void get_bit_address(struc
 int is_reusable(struct super_block *s, b_blocknr_t block, int bit_value)
 {
 	int i, j;
+	unsigned int bmap = block >> s->s_blocksize_bits;
 
 	if (block == 0 || block >= SB_BLOCK_COUNT(s)) {
 		reiserfs_warning(s,
@@ -69,14 +70,25 @@ int is_reusable(struct super_block *s, b
 		return 0;
 	}
 
-	/* it can't be one of the bitmap blocks */
-	for (i = 0; i < SB_BMAP_NR(s); i++)
-		if (block == SB_AP_BITMAP(s)[i].bh->b_blocknr) {
+	/* Old format filesystem? Unlikely, but the bitmaps are all up front so
+	 * we need to account for it. */
+	if (unlikely(test_bit(REISERFS_OLD_FORMAT,
+			      &(REISERFS_SB(s)->s_properties)))) {
+		b_blocknr_t bmap1 = REISERFS_SB(s)->s_sbh->b_blocknr + 1;
+		if (block >= bmap1 + bmap && block <= bmap1 + SB_BMAP_NR(s)) {
+			reiserfs_warning(s, "vs: 4019: is_reusable: "
+					 "bitmap block %lu(%u) can't be freed or reused",
+					 block, SB_BMAP_NR(s));
+			return 0;
+		}
+	} else {
+		if ((block & ((s->s_blocksize << 3) - 1)) == 0) {
 			reiserfs_warning(s, "vs: 4020: is_reusable: "
 					 "bitmap block %lu(%u) can't be freed or reused",
 					 block, SB_BMAP_NR(s));
 			return 0;
 		}
+	}
 
 	get_bit_address(s, block, &i, &j);
 
diff -ruNpX ../dontdiff linux-2.6.15.staging1/fs/reiserfs/super.c linux-2.6.15.staging2/fs/reiserfs/super.c
--- linux-2.6.15.staging1/fs/reiserfs/super.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.staging2/fs/reiserfs/super.c	2006-01-16 16:53:27.331585752 -0500
@@ -1839,6 +1839,8 @@ static int reiserfs_fill_super(struct su
 	if (is_reiserfs_3_5(rs)
 	    || (is_reiserfs_jr(rs) && SB_VERSION(s) == REISERFS_VERSION_1))
 		set_bit(REISERFS_3_5, &(sbi->s_properties));
+	else if (old_format)
+		set_bit(REISERFS_OLD_FORMAT, &(sbi->s_properties));
 	else
 		set_bit(REISERFS_3_6, &(sbi->s_properties));
 
diff -ruNpX ../dontdiff linux-2.6.15.staging1/include/linux/reiserfs_fs_sb.h linux-2.6.15.staging2/include/linux/reiserfs_fs_sb.h
--- linux-2.6.15.staging1/include/linux/reiserfs_fs_sb.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.staging2/include/linux/reiserfs_fs_sb.h	2006-01-16 16:53:27.387577240 -0500
@@ -415,6 +415,7 @@ struct reiserfs_sb_info {
 /* Definitions of reiserfs on-disk properties: */
 #define REISERFS_3_5 0
 #define REISERFS_3_6 1
+#define REISERFS_OLD_FORMAT 2
 
 enum reiserfs_mount_options {
 /* Mount options */
-- 
Jeff Mahoney
SuSE Labs
