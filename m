Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVAQSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVAQSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAQSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:08:44 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:21769 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262742AbVAQRw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:52:58 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] FAT: reserved clusters cleanup
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
	<873bx0ndze.fsf_-_@devron.myhome.or.jp>
	<87y8eslzdq.fsf_-_@devron.myhome.or.jp>
	<87u0pglzbf.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:52:50 +0900
In-Reply-To: <87u0pglzbf.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:50:44 +0900")
Message-ID: <87pt04lz7x.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Replaces the "number of reserved clusters" by FAT_START_ENT.

- The ->clusters is total number of clusters. Instead of it, use the
  maximum cluster number (->max_cluster).

  By this change, removes the some "->clusters + 2" calculation.

- Adds inline function for cluster to block number conversion. And
  replaces the open-coding for it.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c           |    8 +++-----
 fs/fat/dir.c             |    2 +-
 fs/fat/inode.c           |   25 +++++++++++++------------
 fs/fat/misc.c            |   27 ++++++++++++++-------------
 include/linux/msdos_fs.h |   11 ++++++++++-
 5 files changed, 41 insertions(+), 32 deletions(-)

diff -puN fs/fat/cache.c~fat_max-clusters-cleanup fs/fat/cache.c
--- linux-2.6.11-rc1/fs/fat/cache.c~fat_max-clusters-cleanup	2005-01-15 16:49:08.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/fat/cache.c	2005-01-15 16:49:08.000000000 +0900
@@ -305,7 +305,7 @@ int fat_access(struct super_block *sb, i
 	int next;
 
 	next = -EIO;
-	if (nr < 2 || MSDOS_SB(sb)->clusters + 2 <= nr) {
+	if (nr < FAT_START_ENT || MSDOS_SB(sb)->max_cluster <= nr) {
 		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", nr);
 		goto out;
 	}
@@ -431,9 +431,7 @@ int fat_bmap(struct inode *inode, sector
 	cluster = fat_bmap_cluster(inode, cluster);
 	if (cluster < 0)
 		return cluster;
-	else if (cluster) {
-		*phys = ((sector_t)cluster - 2) * sbi->sec_per_clus
-			+ sbi->data_start + offset;
-	}
+	else if (cluster)
+		*phys = fat_clus_to_blknr(sbi, cluster) + offset;
 	return 0;
 }
diff -puN fs/fat/dir.c~fat_max-clusters-cleanup fs/fat/dir.c
--- linux-2.6.11-rc1/fs/fat/dir.c~fat_max-clusters-cleanup	2005-01-15 16:49:08.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/fat/dir.c	2005-01-15 16:49:08.000000000 +0900
@@ -767,7 +767,7 @@ static struct buffer_head *fat_extend_di
 	if (nr < 0)
 		return ERR_PTR(nr);
 
-	sector = ((sector_t)nr - 2) * sec_per_clus + MSDOS_SB(sb)->data_start;
+	sector = fat_clus_to_blknr(MSDOS_SB(sb), nr);
 	last_sector = sector + sec_per_clus;
 	for ( ; sector < last_sector; sector++) {
 		if ((bh = sb_getblk(sb, sector))) {
diff -puN fs/fat/inode.c~fat_max-clusters-cleanup fs/fat/inode.c
--- linux-2.6.11-rc1/fs/fat/inode.c~fat_max-clusters-cleanup	2005-01-15 16:49:08.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/fat/inode.c	2005-01-15 16:49:08.000000000 +0900
@@ -419,17 +419,18 @@ static int fat_remount(struct super_bloc
 
 static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int free, nr, ret;
 
-	if (MSDOS_SB(sb)->free_clusters != -1)
-		free = MSDOS_SB(sb)->free_clusters;
+	if (sbi->free_clusters != -1)
+		free = sbi->free_clusters;
 	else {
 		lock_fat(sb);
-		if (MSDOS_SB(sb)->free_clusters != -1)
-			free = MSDOS_SB(sb)->free_clusters;
+		if (sbi->free_clusters != -1)
+			free = sbi->free_clusters;
 		else {
 			free = 0;
-			for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++) {
+			for (nr = FAT_START_ENT; nr < sbi->max_cluster; nr++) {
 				ret = fat_access(sb, nr, -1);
 				if (ret < 0) {
 					unlock_fat(sb);
@@ -437,17 +438,17 @@ static int fat_statfs(struct super_block
 				} else if (ret == FAT_ENT_FREE)
 					free++;
 			}
-			MSDOS_SB(sb)->free_clusters = free;
+			sbi->free_clusters = free;
 		}
 		unlock_fat(sb);
 	}
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = MSDOS_SB(sb)->cluster_size;
-	buf->f_blocks = MSDOS_SB(sb)->clusters;
+	buf->f_bsize = sbi->cluster_size;
+	buf->f_blocks = sbi->max_cluster - FAT_START_ENT;
 	buf->f_bfree = free;
 	buf->f_bavail = free;
-	buf->f_namelen = MSDOS_SB(sb)->options.isvfat ? 260 : 12;
+	buf->f_namelen = sbi->options.isvfat ? 260 : 12;
 
 	return 0;
 }
@@ -1232,7 +1233,7 @@ int fat_fill_super(struct super_block *s
 
 	/* check that FAT table does not overflow */
 	fat_clusters = sbi->fat_length * sb->s_blocksize * 8 / sbi->fat_bits;
-	total_clusters = min(total_clusters, fat_clusters - 2);
+	total_clusters = min(total_clusters, fat_clusters - FAT_START_ENT);
 	if (total_clusters > MAX_FAT(sb)) {
 		if (!silent)
 			printk(KERN_ERR "FAT: count of clusters too big (%u)\n",
@@ -1241,9 +1242,9 @@ int fat_fill_super(struct super_block *s
 		goto out_invalid;
 	}
 
-	sbi->clusters = total_clusters;
+	sbi->max_cluster = total_clusters + FAT_START_ENT;
 	/* check the free_clusters, it's not necessarily correct */
-	if (sbi->free_clusters != -1 && sbi->free_clusters > sbi->clusters)
+	if (sbi->free_clusters != -1 && sbi->free_clusters > total_clusters)
 		sbi->free_clusters = -1;
 
 	brelse(bh);
diff -puN fs/fat/misc.c~fat_max-clusters-cleanup fs/fat/misc.c
--- linux-2.6.11-rc1/fs/fat/misc.c~fat_max-clusters-cleanup	2005-01-15 16:49:08.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/fat/misc.c	2005-01-15 16:49:08.000000000 +0900
@@ -86,8 +86,9 @@ void fat_clusters_flush(struct super_blo
 int fat_add_cluster(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int ret, count, limit, new_dclus, new_fclus, last;
-	int cluster_bits = MSDOS_SB(sb)->cluster_bits;
+	int cluster_bits = sbi->cluster_bits;
 
 	/*
 	 * We must locate the last cluster of the file to add this new
@@ -110,17 +111,17 @@ int fat_add_cluster(struct inode *inode)
 	/* find free FAT entry */
 	lock_fat(sb);
 
-	if (MSDOS_SB(sb)->free_clusters == 0) {
+	if (sbi->free_clusters == 0) {
 		unlock_fat(sb);
 		return -ENOSPC;
 	}
 
-	limit = MSDOS_SB(sb)->clusters + 2;
-	new_dclus = MSDOS_SB(sb)->prev_free + 1;
-	for (count = 0; count < MSDOS_SB(sb)->clusters; count++, new_dclus++) {
+	limit = sbi->max_cluster;
+	new_dclus = sbi->prev_free + 1;
+	for (count = FAT_START_ENT; count < limit; count++, new_dclus++) {
 		new_dclus = new_dclus % limit;
-		if (new_dclus < 2)
-			new_dclus = 2;
+		if (new_dclus < FAT_START_ENT)
+			new_dclus = FAT_START_ENT;
 
 		ret = fat_access(sb, new_dclus, -1);
 		if (ret < 0) {
@@ -129,8 +130,8 @@ int fat_add_cluster(struct inode *inode)
 		} else if (ret == FAT_ENT_FREE)
 			break;
 	}
-	if (count >= MSDOS_SB(sb)->clusters) {
-		MSDOS_SB(sb)->free_clusters = 0;
+	if (count >= limit) {
+		sbi->free_clusters = 0;
 		unlock_fat(sb);
 		return -ENOSPC;
 	}
@@ -141,9 +142,9 @@ int fat_add_cluster(struct inode *inode)
 		return ret;
 	}
 
-	MSDOS_SB(sb)->prev_free = new_dclus;
-	if (MSDOS_SB(sb)->free_clusters != -1)
-		MSDOS_SB(sb)->free_clusters--;
+	sbi->prev_free = new_dclus;
+	if (sbi->free_clusters != -1)
+		sbi->free_clusters--;
 	fat_clusters_flush(sb);
 
 	unlock_fat(sb);
@@ -164,7 +165,7 @@ int fat_add_cluster(struct inode *inode)
 			new_fclus, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
-	inode->i_blocks += MSDOS_SB(sb)->cluster_size >> 9;
+	inode->i_blocks += sbi->cluster_size >> 9;
 
 	return new_dclus;
 }
diff -puN include/linux/msdos_fs.h~fat_max-clusters-cleanup include/linux/msdos_fs.h
--- linux-2.6.11-rc1/include/linux/msdos_fs.h~fat_max-clusters-cleanup	2005-01-15 16:49:08.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/include/linux/msdos_fs.h	2005-01-15 16:49:08.000000000 +0900
@@ -64,6 +64,9 @@
 #define FAT_FIRST_ENT(s, x)	((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
 	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
 
+/* start of data cluster's entry (number of reserved clusters) */
+#define FAT_START_ENT	2
+
 /* maximum number of clusters */
 #define MAX_FAT12	0xFF4
 #define MAX_FAT16	0xFFF4
@@ -221,7 +224,7 @@ struct msdos_sb_info {
 	unsigned long dir_start;
 	unsigned short dir_entries;  /* root dir start & entries */
 	unsigned long data_start;    /* first data sector */
-	unsigned long clusters;      /* number of clusters */
+	unsigned long max_cluster;   /* maximum cluster number */
 	unsigned long root_cluster;  /* first cluster of the root directory */
 	unsigned long fsinfo_sector; /* sector number of FAT32 fsinfo */
 	struct semaphore fat_lock;
@@ -270,6 +273,12 @@ static inline struct msdos_inode_info *M
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
 }
 
+static inline sector_t fat_clus_to_blknr(struct msdos_sb_info *sbi, int clus)
+{
+	return ((sector_t)clus - FAT_START_ENT) * sbi->sec_per_clus
+		+ sbi->data_start;
+}
+
 static inline void fat16_towchar(wchar_t *dst, const __u8 *src, size_t len)
 {
 #ifdef __BIG_ENDIAN
_
