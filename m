Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTFERlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTFERlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:41:09 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:35341 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264766AbTFERlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:41:06 -0400
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Fwd: VFAT performance.
References: <20030605141840.C22252@bitwizard.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 06 Jun 2003 02:54:23 +0900
In-Reply-To: <20030605141840.C22252@bitwizard.nl>
Message-ID: <87ptlso1f4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Rogier Wolff <R.E.Wolff@BitWizard.nl> writes:

> The way to fix this would be to be able to assign a higher cache
> priority (*) to the blocks in the FAT, and to read more than just 4k
> per seek to the FAT.

I tried it by attached *stupid* patch.

copying 500M data

	root@devron (x)[1014]# time dd if=/dev/hda6 bs=1M count=500 > /dev/null
	500+0 records in
	500+0 records out
	524288000 bytes transferred in 44.988916 seconds (11653715 bytes/sec)
	
	real    0m45.011s
	user    0m0.008s
	sys     0m8.723s

2.5.70-bk9
	root@devron (a)[1032]# time dd if=file bs=1M count=500 > /dev/null
	500+0 records in
	500+0 records out
	524288000 bytes transferred in 75.510951 seconds (6943205 bytes/sec)
	
	real    1m15.538s
	user    0m0.015s
	sys     0m16.493s

2.5.70-bk9+patch
	root@devron (a)[1024]# time dd if=file bs=1M count=500 > /dev/null
	500+0 records in
	500+0 records out
	524288000 bytes transferred in 52.034399 seconds (10075796 bytes/sec)
	
	real    0m52.041s
	user    0m0.006s
	sys     0m17.594s

You're right. It seems that that optimization has sufficient effect to
non fragment file. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=fat_test.patch

 fs/fat/cache.c              |   22 +++++++++++++++++-----
 fs/fat/inode.c              |    4 +++-
 include/linux/msdos_fs_sb.h |    1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff -puN fs/fat/cache.c~fat_test fs/fat/cache.c
--- linux-2.5.70/fs/fat/cache.c~fat_test	2003-06-06 01:51:46.000000000 +0900
+++ linux-2.5.70-hirofumi/fs/fat/cache.c	2003-06-06 02:14:49.000000000 +0900
@@ -17,7 +17,7 @@ int __fat_access(struct super_block *sb,
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
 	unsigned char *p_first, *p_last;
-	int copy, first, last, next, b;
+	int copy, first, last, next, b, i;
 
 	if (sbi->fat_bits == 32) {
 		first = last = nr*4;
@@ -28,10 +28,22 @@ int __fat_access(struct super_block *sb,
 		last = first+1;
 	}
 	b = sbi->fat_start + (first >> sb->s_blocksize_bits);
-	if (!(bh = sb_bread(sb, b))) {
-		printk(KERN_ERR "FAT: bread(block %d) in"
-		       " fat_access failed\n", b);
-		return -EIO;
+	bh = NULL;
+	for (i = 0; i < 16; i++) {
+		if (sbi->fat_bh[i]->b_blocknr == b) {
+			bh = sbi->fat_bh[i];
+			break;
+		}
+	}
+	if (bh == NULL) {
+		for (i = 0; i < 16; i++) {
+			brelse(sbi->fat_bh[i]);
+			sbi->fat_bh[i] = sb_bread(sb, b + i);
+			if (sbi->fat_bh[i] == NULL)
+				return -EIO;
+			get_bh(sbi->fat_bh[i]);
+		}
+		bh = sbi->fat_bh[0];
 	}
 	if ((first >> sb->s_blocksize_bits) == (last >> sb->s_blocksize_bits)) {
 		bh2 = bh;
diff -puN fs/fat/inode.c~fat_test fs/fat/inode.c
--- linux-2.5.70/fs/fat/inode.c~fat_test	2003-06-06 01:52:44.000000000 +0900
+++ linux-2.5.70-hirofumi/fs/fat/inode.c	2003-06-06 02:12:45.000000000 +0900
@@ -158,7 +158,9 @@ void fat_clear_inode(struct inode *inode
 void fat_put_super(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-
+	int i;
+	for (i = 0; i < 16; i++)
+		brelse(sbi->fat_bh[i]);
 	fat_clusters_flush(sb);
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
diff -puN include/linux/msdos_fs_sb.h~fat_test include/linux/msdos_fs_sb.h
--- linux-2.5.70/include/linux/msdos_fs_sb.h~fat_test	2003-06-06 01:53:11.000000000 +0900
+++ linux-2.5.70-hirofumi/include/linux/msdos_fs_sb.h	2003-06-06 02:01:55.000000000 +0900
@@ -59,6 +59,7 @@ struct msdos_sb_info {
 
 	spinlock_t cache_lock;
 	struct fat_cache cache_array[FAT_CACHE_NR], *cache;
+	struct buffer_head *fat_bh[16];
 };
 
 #endif

_

--=-=-=--
