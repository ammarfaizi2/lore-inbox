Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270434AbTGUPpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270427AbTGUPnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:43:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:16649 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270434AbTGUPll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:41:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use new fat_get_cluster (8/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:56:36 +0900
Message-ID: <87smozvpor.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This uses new fat_get_cluster() in fat_bmap_cluster().
Another part removes unneeded error check of fat_get_entry() by using
fat_get_cluster().


 fs/fat/cache.c |   32 ++++++++++++--------------------
 fs/fat/misc.c  |    8 --------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff -puN fs/fat/cache.c~fat_use-get_cluster1 fs/fat/cache.c
--- linux-2.6.0-test1/fs/fat/cache.c~fat_use-get_cluster1	2003-07-21 02:48:27.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/cache.c	2003-07-21 02:48:27.000000000 +0900
@@ -332,28 +332,20 @@ int fat_get_cluster(struct inode *inode,
 static int fat_bmap_cluster(struct inode *inode, int cluster)
 {
 	struct super_block *sb = inode->i_sb;
-	int nr,count;
+	int ret, fclus, dclus;
 
-	if (!(nr = MSDOS_I(inode)->i_start)) return 0;
-	if (!cluster) return nr;
-	count = 0;
-	for (fat_cache_lookup(inode, cluster, &count, &nr);
-	     count < cluster;
-	     count++) {
-		nr = fat_access(sb, nr, -1);
-		if (nr == FAT_ENT_EOF) {
-			fat_fs_panic(sb, "%s: request beyond EOF (ino %lu)",
-				     __FUNCTION__, inode->i_ino);
-			return -EIO;
-		} else if (nr == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "%s: invalid cluster chain (ino %lu)",
-				     __FUNCTION__, inode->i_ino);
-			return -EIO;
-		} else if (nr < 0)
-			return nr;
+	if (MSDOS_I(inode)->i_start == 0)
+		return 0;
+
+	ret = fat_get_cluster(inode, cluster, &fclus, &dclus);
+	if (ret < 0)
+		return ret;
+	else if (ret == FAT_ENT_EOF) {
+		fat_fs_panic(sb, "%s: request beyond EOF (i_pos %llu)",
+			     __FUNCTION__, MSDOS_I(inode)->i_pos);
+		return -EIO;
 	}
-	fat_cache_add(inode, cluster, nr);
-	return nr;
+	return dclus;
 }
 
 int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys)
diff -puN fs/fat/misc.c~fat_use-get_cluster1 fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_use-get_cluster1	2003-07-21 02:48:27.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:27.000000000 +0900
@@ -330,15 +330,7 @@ static int fat_get_short_entry(struct in
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de, loff_t *i_pos)
 {
-	struct super_block *sb = dir->i_sb;
-
 	while (fat_get_entry(dir, pos, bh, de, i_pos) >= 0) {
-		if (*pos >= FAT_MAX_DIR_SIZE) {
-			fat_fs_panic(sb, "Directory %llu: "
-				     "exceeded the maximum size of directory",
-				     MSDOS_I(dir)->i_pos);
-			return -EIO;
-		}
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
