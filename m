Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270460AbTGUPpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGUPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:44:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:18953 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270437AbTGUPmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:42:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more use new fat_get_cluster (9/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:57:11 +0900
Message-ID: <87oeznvpns.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This uses new fat_get_cluster() in fat_free(), fat_calc_dir_size() and
fat_add_cluster().


 fs/fat/cache.c |   50 +++++++++++++++++++++++-----------------
 fs/fat/inode.c |   27 ++++-----------------
 fs/fat/misc.c  |   71 +++++++++++++++++++++------------------------------------
 3 files changed, 62 insertions(+), 86 deletions(-)

diff -puN fs/fat/cache.c~fat_use-get_cluster2 fs/fat/cache.c
--- linux-2.6.0-test1/fs/fat/cache.c~fat_use-get_cluster2	2003-07-21 02:48:29.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/cache.c	2003-07-21 02:48:29.000000000 +0900
@@ -232,6 +232,8 @@ void fat_cache_add(struct inode *inode, 
 	struct fat_cache *walk, *last;
 	int first, prev_f_clu, prev_d_clu;
 
+	if (f_clu == 0)
+		return;
 	first = MSDOS_I(inode)->i_start;
 	if (!first)
 		return;
@@ -380,41 +382,47 @@ int fat_bmap(struct inode *inode, sector
 	return 0;
 }
 
-
-/* Free all clusters after the skip'th cluster. Doesn't use the cache,
-   because this way we get an additional sanity check. */
-
-int fat_free(struct inode *inode,int skip)
+/* Free all clusters after the skip'th cluster. */
+int fat_free(struct inode *inode, int skip)
 {
 	struct super_block *sb = inode->i_sb;
-	int nr,last;
+	int nr, ret, fclus, dclus;
 
-	if (!(nr = MSDOS_I(inode)->i_start)) return 0;
-	last = 0;
-	while (skip--) {
-		last = nr;
-		nr = fat_access(sb, nr, -1);
+	if (MSDOS_I(inode)->i_start == 0)
+		return 0;
+
+	if (skip) {
+		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
+		if (ret < 0)
+			return ret;
+		else if (ret == FAT_ENT_EOF)
+			return 0;
+
+		nr = fat_access(sb, dclus, -1);
 		if (nr == FAT_ENT_EOF)
 			return 0;
-		else if (nr == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "%s: invalid cluster chain (ino %lu)",
-				     __FUNCTION__, inode->i_ino);
-			return -EIO;
-		} else if (nr < 0)
+		else if (nr > 0) {
+			/*
+			 * write a new EOF, and get the remaining cluster
+			 * chain for freeing.
+			 */
+			nr = fat_access(sb, dclus, FAT_ENT_EOF);
+		}
+		if (nr < 0)
 			return nr;
-	}
-	if (last) {
-		fat_access(sb, last, FAT_ENT_EOF);
+
 		fat_cache_inval_inode(inode);
 	} else {
 		fat_cache_inval_inode(inode);
+
+		nr = MSDOS_I(inode)->i_start;
 		MSDOS_I(inode)->i_start = 0;
 		MSDOS_I(inode)->i_logstart = 0;
 		mark_inode_dirty(inode);
 	}
 
 	lock_fat(sb);
-	while (nr != FAT_ENT_EOF) {
+	do {
 		nr = fat_access(sb, nr, FAT_ENT_FREE);
 		if (nr < 0)
 			goto error;
@@ -427,7 +435,7 @@ int fat_free(struct inode *inode,int ski
 		if (MSDOS_SB(sb)->free_clusters != -1)
 			MSDOS_SB(sb)->free_clusters++;
 		inode->i_blocks -= (1 << MSDOS_SB(sb)->cluster_bits) >> 9;
-	}
+	} while (nr != FAT_ENT_EOF);
 	fat_clusters_flush(sb);
 	nr = 0;
 error:
diff -puN fs/fat/inode.c~fat_use-get_cluster2 fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_use-get_cluster2	2003-07-21 02:48:29.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:29.000000000 +0900
@@ -465,32 +465,17 @@ out:
 
 static int fat_calc_dir_size(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
-	int nr;
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	int ret, fclus, dclus;
 
 	inode->i_size = 0;
 	if (MSDOS_I(inode)->i_start == 0)
 		return 0;
 
-	nr = MSDOS_I(inode)->i_start;
-	do {
-		inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
-		nr = fat_access(sb, nr, -1);
-		if (nr < 0)
-			return nr;
-		else if (nr == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "Directory %lu: invalid cluster chain",
-				     inode->i_ino);
-			return -EIO;
-		}
-		if (inode->i_size > FAT_MAX_DIR_SIZE) {
-			fat_fs_panic(sb, "Directory %lu: "
-				     "exceeded the maximum size of directory",
-				     inode->i_ino);
-			inode->i_size = FAT_MAX_DIR_SIZE;
-			break;
-		}
-	} while (nr != FAT_ENT_EOF);
+	ret = fat_get_cluster(inode, FAT_ENT_EOF, &fclus, &dclus);
+	if (ret < 0)
+		return ret;
+	inode->i_size = (fclus + 1) << sbi->cluster_bits;
 
 	return 0;
 }
diff -puN fs/fat/misc.c~fat_use-get_cluster2 fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_use-get_cluster2	2003-07-21 02:48:29.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:29.000000000 +0900
@@ -88,41 +88,25 @@ void fat_clusters_flush(struct super_blo
 int fat_add_cluster(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
-	int count, nr, limit, last, curr, file_cluster;
+	int count, limit, new_dclus, new_fclus, last;
 	int cluster_bits = MSDOS_SB(sb)->cluster_bits;
 	
 	/* 
 	 * We must locate the last cluster of the file to add this new
-	 * one (nr) to the end of the link list (the FAT).
+	 * one (new_dclus) to the end of the link list (the FAT).
 	 *
 	 * In order to confirm that the cluster chain is valid, we
 	 * find out EOF first.
 	 */
-	nr = -EIO;
-	last = file_cluster = 0;
-	if ((curr = MSDOS_I(inode)->i_start) != 0) {
-		int max_cluster = MSDOS_I(inode)->mmu_private >> cluster_bits;
-
-		fat_cache_lookup(inode, INT_MAX, &last, &curr);
-		file_cluster = last;
-		while (curr && curr != FAT_ENT_EOF) {
-			file_cluster++;
-			curr = fat_access(sb, last = curr, -1);
-			if (curr < 0)
-				return curr;
-			else if (curr == FAT_ENT_FREE) {
-				fat_fs_panic(sb, "%s: invalid cluster chain"
-					     " (ino %lu)",
-					     __FUNCTION__, inode->i_ino);
-				goto out;
-			}
-			if (file_cluster > max_cluster) {
-				fat_fs_panic(sb, "%s: bad cluster counts"
-					     " (ino %lu)",
-					     __FUNCTION__, inode->i_ino);
-				goto out;
-			}
-		}
+	last = new_fclus = 0;
+	if (MSDOS_I(inode)->i_start) {
+		int ret, fclus, dclus;
+
+		ret = fat_get_cluster(inode, FAT_ENT_EOF, &fclus, &dclus);
+		if (ret < 0)
+			return ret;
+		new_fclus = fclus + 1;
+		last = dclus;
 	}
 
 	/* find free FAT entry */
@@ -134,12 +118,12 @@ int fat_add_cluster(struct inode *inode)
 	}
 
 	limit = MSDOS_SB(sb)->clusters + 2;
-	nr = MSDOS_SB(sb)->prev_free + 1;
-	for (count = 0; count < MSDOS_SB(sb)->clusters; count++, nr++) {
-		nr = nr % limit;
-		if (nr < 2)
-			nr = 2;
-		if (fat_access(sb, nr, -1) == FAT_ENT_FREE)
+	new_dclus = MSDOS_SB(sb)->prev_free + 1;
+	for (count = 0; count < MSDOS_SB(sb)->clusters; count++, new_dclus++) {
+		new_dclus = new_dclus % limit;
+		if (new_dclus < 2)
+			new_dclus = 2;
+		if (fat_access(sb, new_dclus, -1) == FAT_ENT_FREE)
 			break;
 	}
 	if (count >= MSDOS_SB(sb)->clusters) {
@@ -147,9 +131,9 @@ int fat_add_cluster(struct inode *inode)
 		unlock_fat(sb);
 		return -ENOSPC;
 	}
-	MSDOS_SB(sb)->prev_free = nr;
+	MSDOS_SB(sb)->prev_free = new_dclus;
 
-	fat_access(sb, nr, FAT_ENT_EOF);
+	fat_access(sb, new_dclus, FAT_ENT_EOF);
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		MSDOS_SB(sb)->free_clusters--;
 	fat_clusters_flush(sb);
@@ -158,22 +142,21 @@ int fat_add_cluster(struct inode *inode)
 
 	/* add new one to the last of the cluster chain */
 	if (last) {
-		fat_access(sb, last, nr);
-		fat_cache_add(inode, file_cluster, nr);
+		fat_access(sb, last, new_dclus);
+		fat_cache_add(inode, new_fclus, new_dclus);
 	} else {
-		MSDOS_I(inode)->i_start = nr;
-		MSDOS_I(inode)->i_logstart = nr;
+		MSDOS_I(inode)->i_start = new_dclus;
+		MSDOS_I(inode)->i_logstart = new_dclus;
 		mark_inode_dirty(inode);
 	}
-	if (file_cluster != (inode->i_blocks >> (cluster_bits - 9))) {
-		printk (KERN_ERR "file_cluster badly computed!!! %d <> %ld\n",
-			file_cluster, inode->i_blocks >> (cluster_bits - 9));
+	if (new_fclus != (inode->i_blocks >> (cluster_bits - 9))) {
+		fat_fs_panic(sb, "clusters badly computed (%d != %ld)",
+			new_fclus, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
 	inode->i_blocks += (1 << cluster_bits) >> 9;
 
-out:
-	return nr;
+	return new_dclus;
 }
 
 struct buffer_head *fat_extend_dir(struct inode *inode)

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
