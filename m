Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270187AbTGUPrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGUPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:45:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:23561 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270187AbTGUPnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:43:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ->cluster_size cleanup (11/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:58:42 +0900
Message-ID: <87fzkzvpl9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This renames ->cluster_size to ->sec_per_clus. Old ->cluster_size was
"sectors per cluster". And adds really ->cluster_size.


 fs/fat/cache.c              |    6 +++---
 fs/fat/file.c               |   11 +++++++----
 fs/fat/inode.c              |   29 +++++++++++++++--------------
 fs/fat/misc.c               |   12 ++++++------
 include/linux/msdos_fs.h    |    2 +-
 include/linux/msdos_fs_sb.h |    5 +++--
 6 files changed, 35 insertions(+), 30 deletions(-)

diff -puN fs/fat/cache.c~fat_cluster_size-cleanup fs/fat/cache.c
--- linux-2.6.0-test1/fs/fat/cache.c~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/cache.c	2003-07-21 02:48:35.000000000 +0900
@@ -371,12 +371,12 @@ int fat_bmap(struct inode *inode, sector
 		return 0;
 
 	cluster = sector >> (sbi->cluster_bits - sb->s_blocksize_bits);
-	offset  = sector & (sbi->cluster_size - 1);
+	offset  = sector & (sbi->sec_per_clus - 1);
 	cluster = fat_bmap_cluster(inode, cluster);
 	if (cluster < 0)
 		return cluster;
 	else if (cluster) {
-		*phys = ((sector_t)cluster - 2) * sbi->cluster_size
+		*phys = ((sector_t)cluster - 2) * sbi->sec_per_clus
 			+ sbi->data_start + offset;
 	}
 	return 0;
@@ -434,7 +434,7 @@ int fat_free(struct inode *inode, int sk
 		}
 		if (MSDOS_SB(sb)->free_clusters != -1)
 			MSDOS_SB(sb)->free_clusters++;
-		inode->i_blocks -= (1 << MSDOS_SB(sb)->cluster_bits) >> 9;
+		inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
 	} while (nr != FAT_ENT_EOF);
 	fat_clusters_flush(sb);
 	nr = 0;
diff -puN fs/fat/file.c~fat_cluster_size-cleanup fs/fat/file.c
--- linux-2.6.0-test1/fs/fat/file.c~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/file.c	2003-07-21 02:48:35.000000000 +0900
@@ -48,7 +48,7 @@ int fat_get_block(struct inode *inode, s
 		BUG();
 		return -EIO;
 	}
-	if (!((unsigned long)iblock % MSDOS_SB(sb)->cluster_size)) {
+	if (!((unsigned long)iblock % MSDOS_SB(sb)->sec_per_clus)) {
 		int error;
 
 		error = fat_add_cluster(inode);
@@ -84,14 +84,15 @@ static ssize_t fat_file_write(struct fil
 void fat_truncate(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	int cluster;
+	const unsigned int cluster_size = sbi->cluster_size;
+	int nr_clusters;
 
 	/* Why no return value?  Surely the disk could fail... */
 	if (IS_RDONLY (inode))
 		return /* -EPERM */;
 	if (IS_IMMUTABLE(inode))
 		return /* -EPERM */;
-	cluster = 1 << sbi->cluster_bits;
+
 	/* 
 	 * This protects against truncating a file bigger than it was then
 	 * trying to write into the hole.
@@ -99,8 +100,10 @@ void fat_truncate(struct inode *inode)
 	if (MSDOS_I(inode)->mmu_private > inode->i_size)
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
+	nr_clusters = (inode->i_size + (cluster_size - 1)) >> sbi->cluster_bits;
+
 	lock_kernel();
-	fat_free(inode, (inode->i_size + (cluster - 1)) >> sbi->cluster_bits);
+	fat_free(inode, nr_clusters);
 	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
diff -puN fs/fat/inode.c~fat_cluster_size-cleanup fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:35.000000000 +0900
@@ -504,9 +504,9 @@ static int fat_read_root(struct inode *i
 		MSDOS_I(inode)->i_start = 0;
 		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
 	}
-	inode->i_blksize = 1 << sbi->cluster_bits;
-	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
+	inode->i_blksize = sbi->cluster_size;
+	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
+			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -810,12 +810,12 @@ int fat_fill_super(struct super_block *s
 		brelse(bh);
 		goto out_invalid;
 	}
-	sbi->cluster_size = b->cluster_size;
-	if (!sbi->cluster_size
-	    || (sbi->cluster_size & (sbi->cluster_size - 1))) {
+	sbi->sec_per_clus = b->sec_per_clus;
+	if (!sbi->sec_per_clus
+	    || (sbi->sec_per_clus & (sbi->sec_per_clus - 1))) {
 		if (!silent)
-			printk(KERN_ERR "FAT: bogus cluster size %d\n",
-			       sbi->cluster_size);
+			printk(KERN_ERR "FAT: bogus sectors per cluster %d\n",
+			       sbi->sec_per_clus);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -844,7 +844,8 @@ int fat_fill_super(struct super_block *s
 		b = (struct fat_boot_sector *) bh->b_data;
 	}
 
-	sbi->cluster_bits = ffs(sb->s_blocksize * sbi->cluster_size) - 1;
+	sbi->cluster_size = sb->s_blocksize * sbi->sec_per_clus;
+	sbi->cluster_bits = ffs(sbi->cluster_size) - 1;
 	sbi->fats = b->fats;
 	sbi->fat_bits = 0;		/* Don't know yet */
 	sbi->fat_start = CF_LE_W(b->reserved);
@@ -912,7 +913,7 @@ int fat_fill_super(struct super_block *s
 	total_sectors = CF_LE_W(get_unaligned((unsigned short *)&b->sectors));
 	if (total_sectors == 0)
 		total_sectors = CF_LE_L(b->total_sect);
-	sbi->clusters = (total_sectors - sbi->data_start) / sbi->cluster_size;
+	sbi->clusters = (total_sectors - sbi->data_start) / sbi->sec_per_clus;
 
 	if (sbi->fat_bits != 32)
 		sbi->fat_bits = (sbi->clusters > MSDOS_FAT12) ? 16 : 12;
@@ -1028,7 +1029,7 @@ int fat_statfs(struct super_block *sb, s
 	}
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = 1 << MSDOS_SB(sb)->cluster_bits;
+	buf->f_bsize = MSDOS_SB(sb)->cluster_size;
 	buf->f_blocks = MSDOS_SB(sb)->clusters;
 	buf->f_bfree = free;
 	buf->f_bavail = free;
@@ -1141,9 +1142,9 @@ static int fat_fill_inode(struct inode *
 			inode->i_flags |= S_IMMUTABLE;
 	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
 	/* this is as close to the truth as we can get ... */
-	inode->i_blksize = 1 << sbi->cluster_bits;
-	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
+	inode->i_blksize = sbi->cluster_size;
+	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
+			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
diff -puN fs/fat/misc.c~fat_cluster_size-cleanup fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:35.000000000 +0900
@@ -154,7 +154,7 @@ int fat_add_cluster(struct inode *inode)
 			new_fclus, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
-	inode->i_blocks += (1 << cluster_bits) >> 9;
+	inode->i_blocks += MSDOS_SB(sb)->cluster_size >> 9;
 
 	return new_dclus;
 }
@@ -163,7 +163,7 @@ struct buffer_head *fat_extend_dir(struc
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *res = NULL;
-	int nr, cluster_size = MSDOS_SB(sb)->cluster_size;
+	int nr, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
 	sector_t sector, last_sector;
 
 	if (MSDOS_SB(sb)->fat_bits != 32) {
@@ -175,8 +175,8 @@ struct buffer_head *fat_extend_dir(struc
 	if (nr < 0)
 		return ERR_PTR(nr);
 	
-	sector = ((sector_t)nr - 2) * cluster_size + MSDOS_SB(sb)->data_start;
-	last_sector = sector + cluster_size;
+	sector = ((sector_t)nr - 2) * sec_per_clus + MSDOS_SB(sb)->data_start;
+	last_sector = sector + sec_per_clus;
 	for ( ; sector < last_sector; sector++) {
 		if ((bh = sb_getblk(sb, sector))) {
 			memset(bh->b_data, 0, sb->s_blocksize);
@@ -195,8 +195,8 @@ struct buffer_head *fat_extend_dir(struc
 		inode->i_size = (inode->i_size + sb->s_blocksize)
 			& ~(sb->s_blocksize - 1);
 	}
-	inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
-	MSDOS_I(inode)->mmu_private += 1 << MSDOS_SB(sb)->cluster_bits;
+	inode->i_size += MSDOS_SB(sb)->cluster_size;
+	MSDOS_I(inode)->mmu_private += MSDOS_SB(sb)->cluster_size;
 
 	return res;
 }
diff -puN include/linux/msdos_fs.h~fat_cluster_size-cleanup include/linux/msdos_fs.h
--- linux-2.6.0-test1/include/linux/msdos_fs.h~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/include/linux/msdos_fs.h	2003-07-21 02:48:35.000000000 +0900
@@ -117,7 +117,7 @@ struct fat_boot_sector {
 	__u8	system_id[8];	/* Name - can be used to special case
 				   partition manager volumes */
 	__u8	sector_size[2];	/* bytes per logical sector */
-	__u8	cluster_size;	/* sectors/cluster */
+	__u8	sec_per_clus;	/* sectors/cluster */
 	__u16	reserved;	/* reserved sectors */
 	__u8	fats;		/* number of FATs */
 	__u8	dir_entries[2];	/* root directory entries */
diff -puN include/linux/msdos_fs_sb.h~fat_cluster_size-cleanup include/linux/msdos_fs_sb.h
--- linux-2.6.0-test1/include/linux/msdos_fs_sb.h~fat_cluster_size-cleanup	2003-07-21 02:48:35.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/include/linux/msdos_fs_sb.h	2003-07-21 02:48:35.000000000 +0900
@@ -36,8 +36,9 @@ struct fat_cache {
 };
 
 struct msdos_sb_info {
-	unsigned short cluster_size; /* sectors/cluster */
-	unsigned short cluster_bits; /* sectors/cluster */
+	unsigned short sec_per_clus; /* sectors/cluster */
+	unsigned short cluster_bits; /* log2(cluster_size) */
+	unsigned int cluster_size;   /* cluster size */
 	unsigned char fats,fat_bits; /* number of FATs, FAT bits (12 or 16) */
 	unsigned short fat_start;
 	unsigned long fat_length;    /* FAT start & length (sec.) */

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
