Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270160AbTGUPhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270172AbTGUPhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:37:51 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:3593 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270160AbTGUPgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:36:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_cluster_flush() fixes (2/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:51:40 +0900
Message-ID: <87k7abx4hf.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds forgotten check of MS_RDONLY flag to fat_put_super(), and
adds sanity check of ->free_clusters and ->prev_free to fat_cluster_flush().


 fs/fat/inode.c |    4 +++-
 fs/fat/misc.c  |   15 ++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff -puN fs/fat/inode.c~fat_clusters_flush-fix fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_clusters_flush-fix	2003-07-21 02:48:11.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:11.000000000 +0900
@@ -159,7 +159,9 @@ void fat_put_super(struct super_block *s
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	fat_clusters_flush(sb);
+	if (!(sb->s_flags & MS_RDONLY))
+		fat_clusters_flush(sb);
+
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
 		sbi->nls_disk = NULL;
diff -puN fs/fat/misc.c~fat_clusters_flush-fix fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_clusters_flush-fix	2003-07-21 02:48:11.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:11.000000000 +0900
@@ -50,15 +50,14 @@ void unlock_fat(struct super_block *sb)
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 */
 void fat_clusters_flush(struct super_block *sb)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
 
-	if (MSDOS_SB(sb)->fat_bits != 32)
-		return;
-	if (MSDOS_SB(sb)->free_clusters == -1)
+	if (sbi->fat_bits != 32)
 		return;
 
-	bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
+	bh = sb_bread(sb, sbi->fsinfo_sector);
 	if (bh == NULL) {
 		printk(KERN_ERR "FAT bread failed in fat_clusters_flush\n");
 		return;
@@ -71,10 +70,12 @@ void fat_clusters_flush(struct super_blo
 		       "     Found signature1 0x%08x signature2 0x%08x"
 		       " (sector = %lu)\n",
 		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
-		       MSDOS_SB(sb)->fsinfo_sector);
+		       sbi->fsinfo_sector);
 	} else {
-		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
-		fsinfo->next_cluster = CF_LE_L(MSDOS_SB(sb)->prev_free);
+		if (sbi->free_clusters != -1)
+			fsinfo->free_clusters = CF_LE_L(sbi->free_clusters);
+		if (sbi->prev_free)
+			fsinfo->next_cluster = CF_LE_L(sbi->prev_free);
 		mark_buffer_dirty(bh);
 	}
 	brelse(bh);

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
