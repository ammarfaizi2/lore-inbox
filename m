Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270415AbTGUPl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbTGUPl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:41:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:15113 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270415AbTGUPkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:40:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] adds fat_get_cluster (7/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:55:38 +0900
Message-ID: <87wuebvpqd.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the fat_get_cluster() for generic reads of FAT
cluster-chains, and old fat_get_cluster() is renamed to
fat_bmap_cluster().


 fs/fat/cache.c           |   46 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/msdos_fs.h |    2 ++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff -puN fs/fat/cache.c~fat_add-get_cluster fs/fat/cache.c
--- linux-2.6.0-test1/fs/fat/cache.c~fat_add-get_cluster	2003-07-21 02:48:24.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/cache.c	2003-07-21 02:48:24.000000000 +0900
@@ -287,7 +287,49 @@ out:
 	spin_unlock(&sbi->cache_lock);
 }
 
-static int fat_get_cluster(struct inode *inode, int cluster)
+int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
+{
+	struct super_block *sb = inode->i_sb;
+	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
+	int nr;
+
+	BUG_ON(MSDOS_I(inode)->i_start == 0);
+	
+	*fclus = 0;
+	*dclus = MSDOS_I(inode)->i_start;
+	if (cluster == 0)
+		return 0;
+
+	fat_cache_lookup(inode, cluster, fclus, dclus);
+	while (*fclus < cluster) {
+		/* prevent the infinite loop of cluster chain */
+		if (*fclus > limit) {
+			fat_fs_panic(sb, "%s: detected the cluster chain loop"
+				     " (i_pos %llu)", __FUNCTION__,
+				     MSDOS_I(inode)->i_pos);
+			return -EIO;
+		}
+
+		nr = fat_access(sb, *dclus, -1);
+		if (nr < 0)
+ 			return nr;
+		else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: invalid cluster chain"
+				     " (i_pos %llu)", __FUNCTION__,
+				     MSDOS_I(inode)->i_pos);
+			return -EIO;
+		} else if (nr == FAT_ENT_EOF) {
+			fat_cache_add(inode, *fclus, *dclus);
+			return FAT_ENT_EOF;
+		}
+		(*fclus)++;
+		*dclus = nr;
+	}
+	fat_cache_add(inode, *fclus, *dclus);
+	return 0;
+}
+
+static int fat_bmap_cluster(struct inode *inode, int cluster)
 {
 	struct super_block *sb = inode->i_sb;
 	int nr,count;
@@ -336,7 +378,7 @@ int fat_bmap(struct inode *inode, sector
 
 	cluster = sector >> (sbi->cluster_bits - sb->s_blocksize_bits);
 	offset  = sector & (sbi->cluster_size - 1);
-	cluster = fat_get_cluster(inode, cluster);
+	cluster = fat_bmap_cluster(inode, cluster);
 	if (cluster < 0)
 		return cluster;
 	else if (cluster) {
diff -puN include/linux/msdos_fs.h~fat_add-get_cluster include/linux/msdos_fs.h
--- linux-2.6.0-test1/include/linux/msdos_fs.h~fat_add-get_cluster	2003-07-21 02:48:24.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/include/linux/msdos_fs.h	2003-07-21 02:48:24.000000000 +0900
@@ -237,6 +237,8 @@ extern void fat_cache_lookup(struct inod
 			     int *d_clu);
 extern void fat_cache_add(struct inode *inode, int f_clu, int d_clu);
 extern void fat_cache_inval_inode(struct inode *inode);
+extern int fat_get_cluster(struct inode *inode, int cluster,
+			   int *fclus, int *dclus);
 extern int fat_free(struct inode *inode, int skip);
 
 /* fat/dir.c */

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
