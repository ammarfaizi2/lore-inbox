Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSDYOxb>; Thu, 25 Apr 2002 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSDYOxa>; Thu, 25 Apr 2002 10:53:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:497 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313179AbSDYOx1>;
	Thu, 25 Apr 2002 10:53:27 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_clusters_flush() cleanup (4/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Apr 2002 23:51:12 +0900
Message-ID: <87vgafn867.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch are cleanup of fat_clusters_flush().

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_misc_cleanup-2.5.9/fs/fat/cache.c fat_cluster_flush_cleanup-2.5.9/fs/fat/cache.c
--- fat_misc_cleanup-2.5.9/fs/fat/cache.c	Thu Apr 25 01:42:17 2002
+++ fat_cluster_flush_cleanup-2.5.9/fs/fat/cache.c	Thu Apr 25 01:45:38 2002
@@ -388,14 +388,11 @@
 			nr = -EIO;
 			goto error;
 		}
-		if (MSDOS_SB(sb)->free_clusters != -1) {
+		if (MSDOS_SB(sb)->free_clusters != -1)
 			MSDOS_SB(sb)->free_clusters++;
-			if (MSDOS_SB(sb)->fat_bits == 32) {
-				fat_clusters_flush(sb);
-			}
-		}
-		inode->i_blocks -= (1 << MSDOS_SB(sb)->cluster_bits) >> 9 ;
+		inode->i_blocks -= (1 << MSDOS_SB(sb)->cluster_bits) >> 9;
 	}
+	fat_clusters_flush(sb);
 	nr = 0;
 error:
 	unlock_fat(sb);
diff -urN fat_misc_cleanup-2.5.9/fs/fat/inode.c fat_cluster_flush_cleanup-2.5.9/fs/fat/inode.c
--- fat_misc_cleanup-2.5.9/fs/fat/inode.c	Thu Apr 25 01:42:17 2002
+++ fat_cluster_flush_cleanup-2.5.9/fs/fat/inode.c	Thu Apr 25 01:45:38 2002
@@ -178,9 +178,7 @@
 		dec_cvf_format_use_count_by_version(sbi->cvf_format->cvf_version);
 		sbi->cvf_format->unmount_cvf(sb);
 	}
-	if (sbi->fat_bits == 32) {
-		fat_clusters_flush(sb);
-	}
+	fat_clusters_flush(sb);
 	fat_cache_inval_dev(sb);
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
diff -urN fat_misc_cleanup-2.5.9/fs/fat/misc.c fat_cluster_flush_cleanup-2.5.9/fs/fat/misc.c
--- fat_misc_cleanup-2.5.9/fs/fat/misc.c	Thu Apr 25 01:33:58 2002
+++ fat_cluster_flush_cleanup-2.5.9/fs/fat/misc.c	Thu Apr 25 01:45:38 2002
@@ -97,6 +97,11 @@
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
 
+	if (MSDOS_SB(sb)->fat_bits != 32)
+		return;
+	if (MSDOS_SB(sb)->free_clusters == -1)
+		return;
+
 	bh = fat_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
 	if (bh == NULL) {
 		printk("FAT bread failed in fat_clusters_flush\n");
@@ -185,8 +190,7 @@
 	fat_access(sb, nr, FAT_ENT_EOF);
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		MSDOS_SB(sb)->free_clusters--;
-	if (MSDOS_SB(sb)->fat_bits == 32)
-		fat_clusters_flush(sb);
+	fat_clusters_flush(sb);
 	
 	unlock_fat(sb);
 
