Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCETUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCETUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVCETUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:20:42 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:35332 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261190AbVCESpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:45:06 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/29] FAT: Rewrite the FAT (File Allocation Table) access
 stuff
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:44:40 +0900
In-Reply-To: <878y52rl17.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:43:16 +0900")
Message-ID: <87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order not to write the same block repeatedly, rewrite the FAT entry
access stuff.

And this separates the "allocate the cluster" and "link to cluster
chain" operations for expanding the file/dir safely.
(fat_alloc_clusters() allocates the cluster, and fat_chain_add() links
allocated cluster to the chain which inode has.)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/Makefile          |    2 
 fs/fat/cache.c           |  145 +----------
 fs/fat/dir.c             |   15 -
 fs/fat/fatent.c          |  590 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/file.c            |   69 ++---
 fs/fat/inode.c           |   60 ++--
 fs/fat/misc.c            |  122 ++++-----
 include/linux/msdos_fs.h |   57 +++-
 8 files changed, 781 insertions(+), 279 deletions(-)

diff -puN fs/fat/Makefile~sync05-fat_dep-fatent fs/fat/Makefile
--- linux-2.6.11/fs/fat/Makefile~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/Makefile	2005-03-06 02:36:12.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := cache.o dir.o file.o inode.o misc.o
+fat-objs := cache.o dir.o fatent.o file.o inode.o misc.o
diff -puN fs/fat/cache.c~sync05-fat_dep-fatent fs/fat/cache.c
--- linux-2.6.11/fs/fat/cache.c~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/cache.c	2005-03-06 02:36:12.000000000 +0900
@@ -203,132 +203,6 @@ void fat_cache_inval_inode(struct inode 
 	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 }
 
-static int __fat_access(struct super_block *sb, int nr, int new_value)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
-	unsigned char *p_first, *p_last;
-	int copy, first, last, next, b;
-
-	if (sbi->fat_bits == 32) {
-		first = last = nr*4;
-	} else if (sbi->fat_bits == 16) {
-		first = last = nr*2;
-	} else {
-		first = nr*3/2;
-		last = first+1;
-	}
-	b = sbi->fat_start + (first >> sb->s_blocksize_bits);
-	if (!(bh = sb_bread(sb, b))) {
-		printk(KERN_ERR "FAT: bread(block %d) in"
-		       " fat_access failed\n", b);
-		return -EIO;
-	}
-	if ((first >> sb->s_blocksize_bits) == (last >> sb->s_blocksize_bits)) {
-		bh2 = bh;
-	} else {
-		if (!(bh2 = sb_bread(sb, b + 1))) {
-			brelse(bh);
-			printk(KERN_ERR "FAT: bread(block %d) in"
-			       " fat_access failed\n", b + 1);
-			return -EIO;
-		}
-	}
-	if (sbi->fat_bits == 32) {
-		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = le32_to_cpu(((__le32 *) bh->b_data)[(first &
-		    (sb->s_blocksize - 1)) >> 2]);
-		/* Fscking Microsoft marketing department. Their "32" is 28. */
-		next &= 0x0fffffff;
-	} else if (sbi->fat_bits == 16) {
-		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = le16_to_cpu(((__le16 *) bh->b_data)[(first &
-		    (sb->s_blocksize - 1)) >> 1]);
-	} else {
-		p_first = &((__u8 *)bh->b_data)[first & (sb->s_blocksize - 1)];
-		p_last = &((__u8 *)bh2->b_data)[(first + 1) & (sb->s_blocksize - 1)];
-		if (nr & 1)
-			next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
-		else
-			next = (*p_first+(*p_last << 8)) & 0xfff;
-	}
-	if (new_value != -1) {
-		if (sbi->fat_bits == 32) {
-			((__le32 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 2]
-				= cpu_to_le32(new_value);
-		} else if (sbi->fat_bits == 16) {
-			((__le16 *)bh->b_data)[(first & (sb->s_blocksize - 1)) >> 1]
-				= cpu_to_le16(new_value);
-		} else {
-			if (nr & 1) {
-				*p_first = (*p_first & 0xf) | (new_value << 4);
-				*p_last = new_value >> 4;
-			}
-			else {
-				*p_first = new_value & 0xff;
-				*p_last = (*p_last & 0xf0) | (new_value >> 8);
-			}
-			mark_buffer_dirty(bh2);
-			if (sb->s_flags & MS_SYNCHRONOUS)
-				sync_dirty_buffer(bh2);
-		}
-		mark_buffer_dirty(bh);
-		if (sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(bh);
-		for (copy = 1; copy < sbi->fats; copy++) {
-			b = sbi->fat_start + (first >> sb->s_blocksize_bits)
-				+ sbi->fat_length * copy;
-			if (!(c_bh = sb_bread(sb, b)))
-				break;
-			if (bh != bh2) {
-				if (!(c_bh2 = sb_bread(sb, b+1))) {
-					brelse(c_bh);
-					break;
-				}
-				memcpy(c_bh2->b_data, bh2->b_data, sb->s_blocksize);
-				mark_buffer_dirty(c_bh2);
-				if (sb->s_flags & MS_SYNCHRONOUS)
-					sync_dirty_buffer(c_bh2);
-				brelse(c_bh2);
-			}
-			memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
-			mark_buffer_dirty(c_bh);
-			if (sb->s_flags & MS_SYNCHRONOUS)
-				sync_dirty_buffer(c_bh);
-			brelse(c_bh);
-		}
-	}
-	brelse(bh);
-	if (bh != bh2)
-		brelse(bh2);
-	return next;
-}
-
-/*
- * Returns the this'th FAT entry, -1 if it is an end-of-file entry. If
- * new_value is != -1, that FAT entry is replaced by it.
- */
-int fat_access(struct super_block *sb, int nr, int new_value)
-{
-	int next;
-
-	next = -EIO;
-	if (nr < FAT_START_ENT || MSDOS_SB(sb)->max_cluster <= nr) {
-		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", nr);
-		goto out;
-	}
-	if (new_value == FAT_ENT_EOF)
-		new_value = EOF_FAT(sb);
-
-	next = __fat_access(sb, nr, new_value);
-	if (next < 0)
-		goto out;
-	if (next >= BAD_FAT(sb))
-		next = FAT_ENT_EOF;
-out:
-	return next;
-}
-
 static inline int cache_contiguous(struct fat_cache_id *cid, int dclus)
 {
 	cid->nr_contig++;
@@ -347,6 +221,7 @@ int fat_get_cluster(struct inode *inode,
 {
 	struct super_block *sb = inode->i_sb;
 	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
+	struct fat_entry fatent;
 	struct fat_cache_id cid;
 	int nr;
 
@@ -365,34 +240,40 @@ int fat_get_cluster(struct inode *inode,
 		cache_init(&cid, -1, -1);
 	}
 
+	fatent_init(&fatent);
 	while (*fclus < cluster) {
 		/* prevent the infinite loop of cluster chain */
 		if (*fclus > limit) {
 			fat_fs_panic(sb, "%s: detected the cluster chain loop"
 				     " (i_pos %lld)", __FUNCTION__,
 				     MSDOS_I(inode)->i_pos);
-			return -EIO;
+			nr = -EIO;
+			goto out;
 		}
 
-		nr = fat_access(sb, *dclus, -1);
+		nr = fat_ent_read(inode, &fatent, *dclus);
 		if (nr < 0)
-			return nr;
+			goto out;
 		else if (nr == FAT_ENT_FREE) {
 			fat_fs_panic(sb, "%s: invalid cluster chain"
 				     " (i_pos %lld)", __FUNCTION__,
 				     MSDOS_I(inode)->i_pos);
-			return -EIO;
+			nr = -EIO;
+			goto out;
 		} else if (nr == FAT_ENT_EOF) {
 			fat_cache_add(inode, &cid);
-			return FAT_ENT_EOF;
+			goto out;
 		}
 		(*fclus)++;
 		*dclus = nr;
 		if (!cache_contiguous(&cid, *dclus))
 			cache_init(&cid, *fclus, *dclus);
 	}
+	nr = 0;
 	fat_cache_add(inode, &cid);
-	return 0;
+out:
+	fatent_brelse(&fatent);
+	return nr;
 }
 
 static int fat_bmap_cluster(struct inode *inode, int cluster)
diff -puN fs/fat/dir.c~sync05-fat_dep-fatent fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:12.000000000 +0900
@@ -759,7 +759,7 @@ static struct buffer_head *fat_extend_di
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *res = NULL;
-	int nr, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
+	int err, cluster, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
 	sector_t sector, last_sector;
 
 	if (MSDOS_SB(sb)->fat_bits != 32) {
@@ -767,11 +767,16 @@ static struct buffer_head *fat_extend_di
 			return ERR_PTR(-ENOSPC);
 	}
 
-	nr = fat_add_cluster(inode);
-	if (nr < 0)
-		return ERR_PTR(nr);
+	err = fat_alloc_clusters(inode, &cluster, 1);
+	if (err)
+		return ERR_PTR(err);
+	err = fat_chain_add(inode, cluster, 1);
+	if (err) {
+		fat_free_clusters(inode, cluster);
+		return ERR_PTR(err);
+	}
 
-	sector = fat_clus_to_blknr(MSDOS_SB(sb), nr);
+	sector = fat_clus_to_blknr(MSDOS_SB(sb), cluster);
 	last_sector = sector + sec_per_clus;
 	for ( ; sector < last_sector; sector++) {
 		if ((bh = sb_getblk(sb, sector))) {
diff -puN /dev/null fs/fat/fatent.c
--- /dev/null	2004-09-13 22:36:32.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/fatent.c	2005-03-06 02:36:12.000000000 +0900
@@ -0,0 +1,590 @@
+/*
+ * Copyright (C) 2004, OGAWA Hirofumi
+ * Released under GPL v2.
+ */
+
+#include <linux/fs.h>
+#include <linux/msdos_fs.h>
+
+struct fatent_operations {
+	void (*ent_blocknr)(struct super_block *, int, int *, sector_t *);
+	void (*ent_set_ptr)(struct fat_entry *, int);
+	int (*ent_bread)(struct super_block *, struct fat_entry *,
+			 int, sector_t);
+	int (*ent_get)(struct fat_entry *);
+	void (*ent_put)(struct fat_entry *, int);
+	int (*ent_next)(struct fat_entry *);
+};
+
+static void fat12_ent_blocknr(struct super_block *sb, int entry,
+			      int *offset, sector_t *blocknr)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int bytes = entry + (entry >> 1);
+	*offset = bytes & (sb->s_blocksize - 1);
+	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
+}
+
+static void fat_ent_blocknr(struct super_block *sb, int entry,
+			    int *offset, sector_t *blocknr)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int bytes = (entry << sbi->fatent_shift);
+	*offset = bytes & (sb->s_blocksize - 1);
+	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
+}
+
+static void fat12_ent_set_ptr(struct fat_entry *fatent, int offset)
+{
+	struct buffer_head **bhs = fatent->bhs;
+	if (fatent->nr_bhs == 1) {
+		fatent->u.ent12_p[0] = bhs[0]->b_data + offset;
+		fatent->u.ent12_p[1] = bhs[0]->b_data + (offset + 1);
+	} else {
+		fatent->u.ent12_p[0] = bhs[0]->b_data + offset;
+		fatent->u.ent12_p[1] = bhs[1]->b_data;
+	}
+}
+
+static void fat16_ent_set_ptr(struct fat_entry *fatent, int offset)
+{
+	fatent->u.ent16_p = (__le16 *)(fatent->bhs[0]->b_data + offset);
+}
+
+static void fat32_ent_set_ptr(struct fat_entry *fatent, int offset)
+{
+	fatent->u.ent32_p = (__le32 *)(fatent->bhs[0]->b_data + offset);
+}
+
+static int fat12_ent_bread(struct super_block *sb, struct fat_entry *fatent,
+			   int offset, sector_t blocknr)
+{
+	struct buffer_head **bhs = fatent->bhs;
+
+	bhs[0] = sb_bread(sb, blocknr);
+	if (!bhs[0])
+		goto err;
+
+	if ((offset + 1) < sb->s_blocksize)
+		fatent->nr_bhs = 1;
+	else {
+		/* This entry is block boundary, it needs the next block */
+		blocknr++;
+		bhs[1] = sb_bread(sb, blocknr);
+		if (!bhs[1])
+			goto err_brelse;
+		fatent->nr_bhs = 2;
+	}
+	fat12_ent_set_ptr(fatent, offset);
+	return 0;
+
+err_brelse:
+	brelse(bhs[0]);
+err:
+	printk(KERN_ERR "FAT: FAT read failed (blocknr %llu)\n",
+	       (unsigned long long)blocknr);
+	return -EIO;
+}
+
+static int fat_ent_bread(struct super_block *sb, struct fat_entry *fatent,
+			 int offset, sector_t blocknr)
+{
+	struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
+
+	fatent->bhs[0] = sb_bread(sb, blocknr);
+	if (!fatent->bhs[0]) {
+		printk(KERN_ERR "FAT: FAT read failed (blocknr %llu)\n",
+		       (unsigned long long)blocknr);
+		return -EIO;
+	}
+	fatent->nr_bhs = 1;
+	ops->ent_set_ptr(fatent, offset);
+	return 0;
+}
+
+static int fat12_ent_get(struct fat_entry *fatent)
+{
+	u8 **ent12_p = fatent->u.ent12_p;
+	int next;
+
+	if (fatent->entry & 1)
+		next = (*ent12_p[0] >> 4) | (*ent12_p[1] << 4);
+	else
+		next = (*ent12_p[1] << 8) | *ent12_p[0];
+	next &= 0x0fff;
+	if (next >= BAD_FAT12)
+		next = FAT_ENT_EOF;
+	return next;
+}
+
+static int fat16_ent_get(struct fat_entry *fatent)
+{
+	int next = le16_to_cpu(*fatent->u.ent16_p);
+	if (next >= BAD_FAT16)
+		next = FAT_ENT_EOF;
+	return next;
+}
+
+static int fat32_ent_get(struct fat_entry *fatent)
+{
+	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
+	if (next >= BAD_FAT32)
+		next = FAT_ENT_EOF;
+	return next;
+}
+
+static void fat12_ent_put(struct fat_entry *fatent, int new)
+{
+	u8 **ent12_p = fatent->u.ent12_p;
+
+	if (new == FAT_ENT_EOF)
+		new = EOF_FAT12;
+
+	if (fatent->entry & 1) {
+		*ent12_p[0] = (new << 4) | (*ent12_p[0] & 0x0f);
+		*ent12_p[1] = new >> 4;
+	} else {
+		*ent12_p[0] = new & 0xff;
+		*ent12_p[1] = (*ent12_p[1] & 0xf0) | (new >> 8);
+	}
+
+	mark_buffer_dirty(fatent->bhs[0]);
+	if (fatent->nr_bhs == 2)
+		mark_buffer_dirty(fatent->bhs[1]);
+}
+
+static void fat16_ent_put(struct fat_entry *fatent, int new)
+{
+	if (new == FAT_ENT_EOF)
+		new = EOF_FAT16;
+
+	*fatent->u.ent16_p = cpu_to_le16(new);
+	mark_buffer_dirty(fatent->bhs[0]);
+}
+
+static void fat32_ent_put(struct fat_entry *fatent, int new)
+{
+	if (new == FAT_ENT_EOF)
+		new = EOF_FAT32;
+
+	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
+	*fatent->u.ent32_p = cpu_to_le32(new);
+	mark_buffer_dirty(fatent->bhs[0]);
+}
+
+static int fat12_ent_next(struct fat_entry *fatent)
+{
+	u8 **ent12_p = fatent->u.ent12_p;
+	struct buffer_head **bhs = fatent->bhs;
+	u8 *nextp = ent12_p[1] + 1 + (fatent->entry & 1);
+
+	fatent->entry++;
+	if (fatent->nr_bhs == 1) {
+		if (nextp < (u8 *)(bhs[0]->b_data + (bhs[0]->b_size - 1))) {
+			ent12_p[0] = nextp - 1;
+			ent12_p[1] = nextp;
+			return 1;
+		}
+	} else {
+		ent12_p[0] = nextp - 1;
+		ent12_p[1] = nextp;
+		brelse(bhs[0]);
+		bhs[0] = bhs[1];
+		fatent->nr_bhs = 1;
+		return 1;
+	}
+	return 0;
+}
+
+static int fat16_ent_next(struct fat_entry *fatent)
+{
+	const struct buffer_head *bh = fatent->bhs[0];
+	fatent->entry++;
+	if (fatent->u.ent16_p < (__le16 *)(bh->b_data + (bh->b_size - 2))) {
+		fatent->u.ent16_p++;
+		return 1;
+	}
+	return 0;
+}
+
+static int fat32_ent_next(struct fat_entry *fatent)
+{
+	const struct buffer_head *bh = fatent->bhs[0];
+	fatent->entry++;
+	if (fatent->u.ent32_p < (__le32 *)(bh->b_data + (bh->b_size - 4))) {
+		fatent->u.ent32_p++;
+		return 1;
+	}
+	return 0;
+}
+
+static struct fatent_operations fat12_ops = {
+	.ent_blocknr	= fat12_ent_blocknr,
+	.ent_set_ptr	= fat12_ent_set_ptr,
+	.ent_bread	= fat12_ent_bread,
+	.ent_get	= fat12_ent_get,
+	.ent_put	= fat12_ent_put,
+	.ent_next	= fat12_ent_next,
+};
+
+static struct fatent_operations fat16_ops = {
+	.ent_blocknr	= fat_ent_blocknr,
+	.ent_set_ptr	= fat16_ent_set_ptr,
+	.ent_bread	= fat_ent_bread,
+	.ent_get	= fat16_ent_get,
+	.ent_put	= fat16_ent_put,
+	.ent_next	= fat16_ent_next,
+};
+
+static struct fatent_operations fat32_ops = {
+	.ent_blocknr	= fat_ent_blocknr,
+	.ent_set_ptr	= fat32_ent_set_ptr,
+	.ent_bread	= fat_ent_bread,
+	.ent_get	= fat32_ent_get,
+	.ent_put	= fat32_ent_put,
+	.ent_next	= fat32_ent_next,
+};
+
+static inline void lock_fat(struct msdos_sb_info *sbi)
+{
+	down(&sbi->fat_lock);
+}
+
+static inline void unlock_fat(struct msdos_sb_info *sbi)
+{
+	up(&sbi->fat_lock);
+}
+
+void fat_ent_access_init(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	init_MUTEX(&sbi->fat_lock);
+
+	switch (sbi->fat_bits) {
+	case 32:
+		sbi->fatent_shift = 2;
+		sbi->fatent_ops = &fat32_ops;
+		break;
+	case 16:
+		sbi->fatent_shift = 1;
+		sbi->fatent_ops = &fat16_ops;
+		break;
+	case 12:
+		sbi->fatent_shift = -1;
+		sbi->fatent_ops = &fat12_ops;
+		break;
+	}
+}
+
+static inline int fat_ent_update_ptr(struct super_block *sb,
+				     struct fat_entry *fatent,
+				     int offset, sector_t blocknr)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fatent_operations *ops = sbi->fatent_ops;
+	struct buffer_head **bhs = fatent->bhs;
+
+	/* Is this fatent's blocks including this entry? */
+	if (!fatent->nr_bhs || bhs[0]->b_blocknr != blocknr)
+		return 0;
+	/* Does this entry need the next block? */
+	if (sbi->fat_bits == 12 && (offset + 1) >= sb->s_blocksize) {
+		if (fatent->nr_bhs != 2 || bhs[1]->b_blocknr != (blocknr + 1))
+			return 0;
+	}
+	ops->ent_set_ptr(fatent, offset);
+	return 1;
+}
+
+int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct fatent_operations *ops = sbi->fatent_ops;
+	int err, offset;
+	sector_t blocknr;
+
+	if (entry < FAT_START_ENT || sbi->max_cluster <= entry) {
+		fatent_brelse(fatent);
+		fat_fs_panic(sb, "invalid access to FAT (entry 0x%08x)", entry);
+		return -EIO;
+	}
+
+	fatent_set_entry(fatent, entry);
+	ops->ent_blocknr(sb, entry, &offset, &blocknr);
+
+	if (!fat_ent_update_ptr(sb, fatent, offset, blocknr)) {
+		fatent_brelse(fatent);
+		err = ops->ent_bread(sb, fatent, offset, blocknr);
+		if (err)
+			return err;
+	}
+	return ops->ent_get(fatent);
+}
+
+static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
+			  int nr_bhs)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *c_bh;
+	int err, n, copy;
+
+	err = 0;
+	for (copy = 1; copy < sbi->fats; copy++) {
+		sector_t backup_fat = sbi->fat_length * copy;
+
+		for (n = 0; n < nr_bhs; n++) {
+			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
+			if (!c_bh) {
+				err = -ENOMEM;
+				goto error;
+			}
+			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
+			set_buffer_uptodate(c_bh);
+			mark_buffer_dirty(c_bh);
+			if (sb->s_flags & MS_SYNCHRONOUS)
+				err = sync_dirty_buffer(c_bh);
+			brelse(c_bh);
+			if (err)
+				goto error;
+		}
+	}
+error:
+	return err;
+}
+
+int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
+		  int new, int wait)
+{
+	struct super_block *sb = inode->i_sb;
+	struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
+	int err;
+
+	ops->ent_put(fatent, new);
+	if (wait) {
+		err = fat_sync_bhs(fatent->bhs, fatent->nr_bhs);
+		if (err)
+			return err;
+	}
+	return fat_mirror_bhs(sb, fatent->bhs, fatent->nr_bhs);
+}
+
+static inline int fat_ent_next(struct msdos_sb_info *sbi,
+			       struct fat_entry *fatent)
+{
+	if (sbi->fatent_ops->ent_next(fatent)) {
+		if (fatent->entry < sbi->max_cluster)
+			return 1;
+	}
+	return 0;
+}
+
+static inline int fat_ent_read_block(struct super_block *sb,
+				     struct fat_entry *fatent)
+{
+	struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
+	sector_t blocknr;
+	int offset;
+
+	fatent_brelse(fatent);
+	ops->ent_blocknr(sb, fatent->entry, &offset, &blocknr);
+	return ops->ent_bread(sb, fatent, offset, blocknr);
+}
+
+static void fat_collect_bhs(struct buffer_head **bhs, int *nr_bhs,
+			    struct fat_entry *fatent)
+{
+	int n, i;
+
+	for (n = 0; n < fatent->nr_bhs; n++) {
+		for (i = 0; i < *nr_bhs; i++) {
+			if (fatent->bhs[n] == bhs[i])
+				break;
+		}
+		if (i == *nr_bhs) {
+			get_bh(fatent->bhs[n]);
+			bhs[i] = fatent->bhs[n];
+			(*nr_bhs)++;
+		}
+	}
+}
+
+int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fatent_operations *ops = sbi->fatent_ops;
+	struct fat_entry fatent, prev_ent;
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	int i, count, err, nr_bhs, idx_clus;
+
+	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
+
+	lock_fat(sbi);
+	if (sbi->free_clusters != -1 && sbi->free_clusters < nr_cluster) {
+		unlock_fat(sbi);
+		return -ENOSPC;
+	}
+
+	err = nr_bhs = idx_clus = 0;
+	count = FAT_START_ENT;
+	fatent_init(&prev_ent);
+	fatent_init(&fatent);
+	fatent_set_entry(&fatent, sbi->prev_free + 1);
+	while (count < sbi->max_cluster) {
+		fatent.entry %= sbi->max_cluster;
+		if (fatent.entry < FAT_START_ENT)
+			fatent.entry = FAT_START_ENT;
+		fatent_set_entry(&fatent, fatent.entry);
+		err = fat_ent_read_block(sb, &fatent);
+		if (err)
+			goto out;
+
+		/* Find the free entries in a block */
+		do {
+			if (ops->ent_get(&fatent) == FAT_ENT_FREE) {
+				int entry = fatent.entry;
+
+				/* make the cluster chain */
+				ops->ent_put(&fatent, FAT_ENT_EOF);
+				if (prev_ent.nr_bhs)
+					ops->ent_put(&prev_ent, entry);
+
+				fat_collect_bhs(bhs, &nr_bhs, &fatent);
+
+				sbi->prev_free = entry;
+				if (sbi->free_clusters != -1)
+					sbi->free_clusters--;
+
+				cluster[idx_clus] = entry;
+				idx_clus++;
+				if (idx_clus == nr_cluster)
+					goto out;
+
+				/*
+				 * fat_collect_bhs() gets ref-count of bhs,
+				 * so we can still use the prev_ent.
+				 */
+				prev_ent = fatent;
+			}
+			count++;
+			if (count == sbi->max_cluster)
+				break;
+		} while (fat_ent_next(sbi, &fatent));
+	}
+
+	/* Couldn't allocate the free entries */
+	sbi->free_clusters = 0;
+	err = -ENOSPC;
+
+out:
+	unlock_fat(sbi);
+	fatent_brelse(&fatent);
+	if (!err) {
+		if (inode_needs_sync(inode))
+			err = fat_sync_bhs(bhs, nr_bhs);
+		if (!err)
+			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+	}
+	for (i = 0; i < nr_bhs; i++)
+		brelse(bhs[i]);
+	fat_clusters_flush(sb);
+
+	if (err && idx_clus)
+		fat_free_clusters(inode, cluster[0]);
+
+	return err;
+}
+
+int fat_free_clusters(struct inode *inode, int cluster)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fatent_operations *ops = sbi->fatent_ops;
+	struct fat_entry fatent;
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	int i, err, nr_bhs;
+
+	nr_bhs = 0;
+	fatent_init(&fatent);
+	lock_fat(sbi);
+	do {
+		cluster = fat_ent_read(inode, &fatent, cluster);
+		if (cluster < 0) {
+			err = cluster;
+			goto error;
+		} else if (cluster == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: deleting FAT entry beyond EOF",
+				     __FUNCTION__);
+			err = -EIO;
+			goto error;
+		}
+
+		ops->ent_put(&fatent, FAT_ENT_FREE);
+		if (sbi->free_clusters != -1)
+			sbi->free_clusters++;
+
+		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
+			if (sb->s_flags & MS_SYNCHRONOUS) {
+				err = fat_sync_bhs(bhs, nr_bhs);
+				if (err)
+					goto error;
+			}
+			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+			if (err)
+				goto error;
+			for (i = 0; i < nr_bhs; i++)
+				brelse(bhs[i]);
+			nr_bhs = 0;
+		}
+		fat_collect_bhs(bhs, &nr_bhs, &fatent);
+	} while (cluster != FAT_ENT_EOF);
+
+	if (sb->s_flags & MS_SYNCHRONOUS) {
+		err = fat_sync_bhs(bhs, nr_bhs);
+		if (err)
+			goto error;
+	}
+	err = fat_mirror_bhs(sb, bhs, nr_bhs);
+error:
+	fatent_brelse(&fatent);
+	for (i = 0; i < nr_bhs; i++)
+		brelse(bhs[i]);
+	unlock_fat(sbi);
+
+	fat_clusters_flush(sb);
+
+	return err;
+}
+
+int fat_count_free_clusters(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fatent_operations *ops = sbi->fatent_ops;
+	struct fat_entry fatent;
+	int err = 0, free;
+
+	lock_fat(sbi);
+	if (sbi->free_clusters != -1)
+		goto out;
+
+	free = 0;
+	fatent_init(&fatent);
+	fatent_set_entry(&fatent, FAT_START_ENT);
+	while (fatent.entry < sbi->max_cluster) {
+		err = fat_ent_read_block(sb, &fatent);
+		if (err)
+			goto out;
+
+		do {
+			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
+				free++;
+		} while (fat_ent_next(sbi, &fatent));
+	}
+	sbi->free_clusters = free;
+	fatent_brelse(&fatent);
+out:
+	unlock_fat(sbi);
+	return err;
+}
diff -puN fs/fat/file.c~sync05-fat_dep-fatent fs/fat/file.c
--- linux-2.6.11/fs/fat/file.c~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/file.c	2005-03-06 02:36:12.000000000 +0900
@@ -212,62 +212,63 @@ EXPORT_SYMBOL(fat_notify_change);
 static int fat_free(struct inode *inode, int skip)
 {
 	struct super_block *sb = inode->i_sb;
-	int nr, ret, fclus, dclus;
+	int ret, wait;
 
 	if (MSDOS_I(inode)->i_start == 0)
 		return 0;
 
+	/*
+	 * Write a new EOF, and get the remaining cluster chain for freeing.
+	 */
+	wait = IS_DIRSYNC(inode);
 	if (skip) {
+		struct fat_entry fatent;
+		int fclus, dclus;
+
 		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
 		if (ret < 0)
 			return ret;
 		else if (ret == FAT_ENT_EOF)
 			return 0;
 
-		nr = fat_access(sb, dclus, -1);
-		if (nr == FAT_ENT_EOF)
+		fatent_init(&fatent);
+		ret = fat_ent_read(inode, &fatent, dclus);
+		if (ret == FAT_ENT_EOF) {
+			fatent_brelse(&fatent);
 			return 0;
-		else if (nr > 0) {
-			/*
-			 * write a new EOF, and get the remaining cluster
-			 * chain for freeing.
-			 */
-			nr = fat_access(sb, dclus, FAT_ENT_EOF);
+		} else if (ret == FAT_ENT_FREE) {
+			fat_fs_panic(sb,
+				     "%s: invalid cluster chain (i_pos %lld)",
+				     __FUNCTION__, MSDOS_I(inode)->i_pos);
+			ret = -EIO;
+		} else if (ret > 0) {
+			int err = fat_ent_write(inode, &fatent, FAT_ENT_EOF,
+						wait);
+			if (err)
+				ret = err;
 		}
-		if (nr < 0)
-			return nr;
+		fatent_brelse(&fatent);
+		if (ret < 0)
+			return ret;
 
 		fat_cache_inval_inode(inode);
 	} else {
 		fat_cache_inval_inode(inode);
 
-		nr = MSDOS_I(inode)->i_start;
+		ret = MSDOS_I(inode)->i_start;
 		MSDOS_I(inode)->i_start = 0;
 		MSDOS_I(inode)->i_logstart = 0;
-		mark_inode_dirty(inode);
+		if (wait) {
+			int err = fat_sync_inode(inode);
+			if (err)
+				return err;
+		} else
+			mark_inode_dirty(inode);
 	}
+	inode->i_blocks = skip << (MSDOS_SB(sb)->cluster_bits - 9);
 
-	lock_fat(sb);
-	do {
-		nr = fat_access(sb, nr, FAT_ENT_FREE);
-		if (nr < 0)
-			goto error;
-		else if (nr == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "%s: deleting beyond EOF (i_pos %lld)",
-				     __FUNCTION__, MSDOS_I(inode)->i_pos);
-			nr = -EIO;
-			goto error;
-		}
-		if (MSDOS_SB(sb)->free_clusters != -1)
-			MSDOS_SB(sb)->free_clusters++;
-		inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
-	} while (nr != FAT_ENT_EOF);
-	fat_clusters_flush(sb);
-	nr = 0;
-error:
-	unlock_fat(sb);
-
-	return nr;
+	/* Freeing the remained cluster chain */
+	return fat_free_clusters(inode, ret);
 }
 
 void fat_truncate(struct inode *inode)
diff -puN fs/fat/inode.c~sync05-fat_dep-fatent fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:12.000000000 +0900
@@ -33,6 +33,21 @@ static int fat_default_codepage = CONFIG
 static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
 
 
+static int fat_add_cluster(struct inode *inode)
+{
+	int err, cluster;
+
+	err = fat_alloc_clusters(inode, &cluster, 1);
+	if (err)
+		return err;
+	/* FIXME: this cluster should be added after data of this
+	 * cluster is writed */
+	err = fat_chain_add(inode, cluster, 1);
+	if (err)
+		fat_free_clusters(inode, cluster);
+	return err;
+}
+
 static int fat_get_block(struct inode *inode, sector_t iblock,
 			 struct buffer_head *bh_result, int create)
 {
@@ -55,11 +70,9 @@ static int fat_get_block(struct inode *i
 		return -EIO;
 	}
 	if (!((unsigned long)iblock & (MSDOS_SB(sb)->sec_per_clus - 1))) {
-		int error;
-
-		error = fat_add_cluster(inode);
-		if (error < 0)
-			return error;
+		err = fat_add_cluster(inode);
+		if (err)
+			return err;
 	}
 	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
 	err = fat_bmap(inode, iblock, &phys);
@@ -423,34 +436,19 @@ static int fat_remount(struct super_bloc
 static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int free, nr, ret;
 
-	if (sbi->free_clusters != -1)
-		free = sbi->free_clusters;
-	else {
-		lock_fat(sb);
-		if (sbi->free_clusters != -1)
-			free = sbi->free_clusters;
-		else {
-			free = 0;
-			for (nr = FAT_START_ENT; nr < sbi->max_cluster; nr++) {
-				ret = fat_access(sb, nr, -1);
-				if (ret < 0) {
-					unlock_fat(sb);
-					return ret;
-				} else if (ret == FAT_ENT_FREE)
-					free++;
-			}
-			sbi->free_clusters = free;
-		}
-		unlock_fat(sb);
+	/* If the count of free cluster is still unknown, counts it here. */
+	if (sbi->free_clusters == -1) {
+		int err = fat_count_free_clusters(sb);
+		if (err)
+			return err;
 	}
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sbi->cluster_size;
 	buf->f_blocks = sbi->max_cluster - FAT_START_ENT;
-	buf->f_bfree = free;
-	buf->f_bavail = free;
+	buf->f_bfree = sbi->free_clusters;
+	buf->f_bavail = sbi->free_clusters;
 	buf->f_namelen = sbi->options.isvfat ? 260 : 12;
 
 	return 0;
@@ -1076,10 +1074,6 @@ int fat_fill_super(struct super_block *s
 	if (error)
 		goto out_fail;
 
-	/* set up enough so that it can read an inode */
-	fat_hash_init(sb);
-	init_MUTEX(&sbi->fat_lock);
-
 	error = -EIO;
 	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
@@ -1256,6 +1250,10 @@ int fat_fill_super(struct super_block *s
 
 	brelse(bh);
 
+	/* set up enough so that it can read an inode */
+	fat_hash_init(sb);
+	fat_ent_access_init(sb);
+
 	/*
 	 * The low byte of FAT's first entry must have same value with
 	 * media-field.  But in real world, too many devices is
diff -puN fs/fat/misc.c~sync05-fat_dep-fatent fs/fat/misc.c
--- linux-2.6.11/fs/fat/misc.c~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/misc.c	2005-03-06 02:36:12.000000000 +0900
@@ -33,16 +33,6 @@ void fat_fs_panic(struct super_block *s,
 	}
 }
 
-void lock_fat(struct super_block *sb)
-{
-	down(&(MSDOS_SB(sb)->fat_lock));
-}
-
-void unlock_fat(struct super_block *sb)
-{
-	up(&(MSDOS_SB(sb)->fat_lock));
-}
-
 /* Flushes the number of free clusters on FAT32 */
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 */
 void fat_clusters_flush(struct super_block *sb)
@@ -82,26 +72,22 @@ void fat_clusters_flush(struct super_blo
 }
 
 /*
- * fat_add_cluster tries to allocate a new cluster and adds it to the
- * file represented by inode.
+ * fat_chain_add() adds a new cluster to the chain of clusters represented
+ * by inode.
  */
-int fat_add_cluster(struct inode *inode)
+int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int ret, count, limit, new_dclus, new_fclus, last;
-	int cluster_bits = sbi->cluster_bits;
+	int ret, new_fclus, last;
 
 	/*
 	 * We must locate the last cluster of the file to add this new
 	 * one (new_dclus) to the end of the link list (the FAT).
-	 *
-	 * In order to confirm that the cluster chain is valid, we
-	 * find out EOF first.
 	 */
 	last = new_fclus = 0;
 	if (MSDOS_I(inode)->i_start) {
-		int ret, fclus, dclus;
+		int fclus, dclus;
 
 		ret = fat_get_cluster(inode, FAT_ENT_EOF, &fclus, &dclus);
 		if (ret < 0)
@@ -110,66 +96,42 @@ int fat_add_cluster(struct inode *inode)
 		last = dclus;
 	}
 
-	/* find free FAT entry */
-	lock_fat(sb);
-
-	if (sbi->free_clusters == 0) {
-		unlock_fat(sb);
-		return -ENOSPC;
-	}
-
-	limit = sbi->max_cluster;
-	new_dclus = sbi->prev_free + 1;
-	for (count = FAT_START_ENT; count < limit; count++, new_dclus++) {
-		new_dclus = new_dclus % limit;
-		if (new_dclus < FAT_START_ENT)
-			new_dclus = FAT_START_ENT;
-
-		ret = fat_access(sb, new_dclus, -1);
-		if (ret < 0) {
-			unlock_fat(sb);
-			return ret;
-		} else if (ret == FAT_ENT_FREE)
-			break;
-	}
-	if (count >= limit) {
-		sbi->free_clusters = 0;
-		unlock_fat(sb);
-		return -ENOSPC;
-	}
-
-	ret = fat_access(sb, new_dclus, FAT_ENT_EOF);
-	if (ret < 0) {
-		unlock_fat(sb);
-		return ret;
-	}
-
-	sbi->prev_free = new_dclus;
-	if (sbi->free_clusters != -1)
-		sbi->free_clusters--;
-	fat_clusters_flush(sb);
-
-	unlock_fat(sb);
-
 	/* add new one to the last of the cluster chain */
 	if (last) {
-		ret = fat_access(sb, last, new_dclus);
+		struct fat_entry fatent;
+
+		fatent_init(&fatent);
+		ret = fat_ent_read(inode, &fatent, last);
+		if (ret >= 0) {
+			int wait = inode_needs_sync(inode);
+			ret = fat_ent_write(inode, &fatent, new_dclus, wait);
+			fatent_brelse(&fatent);
+		}
 		if (ret < 0)
 			return ret;
 //		fat_cache_add(inode, new_fclus, new_dclus);
 	} else {
 		MSDOS_I(inode)->i_start = new_dclus;
 		MSDOS_I(inode)->i_logstart = new_dclus;
-		mark_inode_dirty(inode);
+		/*
+		 * Since generic_osync_inode() synchronize later if
+		 * this is not directory, we don't here.
+		 */
+		if (S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode)) {
+			ret = fat_sync_inode(inode);
+			if (ret)
+				return ret;
+		} else
+			mark_inode_dirty(inode);
 	}
-	if (new_fclus != (inode->i_blocks >> (cluster_bits - 9))) {
+	if (new_fclus != (inode->i_blocks >> (sbi->cluster_bits - 9))) {
 		fat_fs_panic(sb, "clusters badly computed (%d != %lu)",
-			new_fclus, inode->i_blocks >> (cluster_bits - 9));
+			new_fclus, inode->i_blocks >> (sbi->cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
-	inode->i_blocks += sbi->cluster_size >> 9;
+	inode->i_blocks += nr_cluster << (sbi->cluster_bits - 9);
 
-	return new_dclus;
+	return 0;
 }
 
 extern struct timezone sys_tz;
@@ -281,3 +243,31 @@ next:
 }
 
 EXPORT_SYMBOL(fat__get_entry);
+
+int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
+{
+	int i, e, err = 0;
+
+	for (i = 0; i < nr_bhs; i++) {
+		lock_buffer(bhs[i]);
+		if (test_clear_buffer_dirty(bhs[i])) {
+			get_bh(bhs[i]);
+			bhs[i]->b_end_io = end_buffer_write_sync;
+			e = submit_bh(WRITE, bhs[i]);
+			if (!err && e)
+				err = e;
+		} else
+			unlock_buffer(bhs[i]);
+	}
+	for (i = 0; i < nr_bhs; i++) {
+		wait_on_buffer(bhs[i]);
+		if (buffer_eopnotsupp(bhs[i])) {
+			clear_buffer_eopnotsupp(bhs[i]);
+			err = -EOPNOTSUPP;
+		} else if (!err && !buffer_uptodate(bhs[i]))
+			err = -EIO;
+	}
+	return err;
+}
+
+EXPORT_SYMBOL(fat_sync_bhs);
diff -puN include/linux/msdos_fs.h~sync05-fat_dep-fatent include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync05-fat_dep-fatent	2005-03-06 02:36:12.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:12.000000000 +0900
@@ -76,15 +76,11 @@
 #define BAD_FAT12	0xFF7
 #define BAD_FAT16	0xFFF7
 #define BAD_FAT32	0x0FFFFFF7
-#define BAD_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? BAD_FAT32 : \
-	MSDOS_SB(s)->fat_bits == 16 ? BAD_FAT16 : BAD_FAT12)
 
 /* standard EOF */
 #define EOF_FAT12	0xFFF
 #define EOF_FAT16	0xFFFF
 #define EOF_FAT32	0x0FFFFFFF
-#define EOF_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
-	MSDOS_SB(s)->fat_bits == 16 ? EOF_FAT16 : EOF_FAT12)
 
 #define FAT_ENT_FREE	(0)
 #define FAT_ENT_BAD	(BAD_FAT32)
@@ -238,6 +234,9 @@ struct msdos_sb_info {
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
 
+	int fatent_shift;
+	struct fatent_operations *fatent_ops;
+
 	spinlock_t inode_hash_lock;
 	struct hlist_head inode_hashtable[FAT_HASH_SIZE];
 };
@@ -315,7 +314,6 @@ static inline void fatwchar_to16(__u8 *d
 
 /* fat/cache.c */
 extern void fat_cache_inval_inode(struct inode *inode);
-extern int fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_get_cluster(struct inode *inode, int cluster,
 			   int *fclus, int *dclus);
 extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
@@ -335,6 +333,46 @@ extern int fat_scan(struct inode *dir, c
 		    struct buffer_head **res_bh,
 		    struct msdos_dir_entry **res_de, loff_t *i_pos);
 
+/* fat/fatent.c */
+struct fat_entry {
+	int entry;
+	union {
+		u8 *ent12_p[2];
+		__le16 *ent16_p;
+		__le32 *ent32_p;
+	} u;
+	int nr_bhs;
+	struct buffer_head *bhs[2];
+};
+
+static inline void fatent_init(struct fat_entry *fatent)
+{
+	fatent->nr_bhs = 0;
+}
+
+static inline void fatent_set_entry(struct fat_entry *fatent, int entry)
+{
+	fatent->entry = entry;
+}
+
+static inline void fatent_brelse(struct fat_entry *fatent)
+{
+	int i;
+	for (i = 0; i < fatent->nr_bhs; i++)
+		brelse(fatent->bhs[i]);
+	fatent->nr_bhs = 0;
+}
+
+extern void fat_ent_access_init(struct super_block *sb);
+extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
+			int entry);
+extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
+			 int new, int wait);
+extern int fat_alloc_clusters(struct inode *inode, int *cluster,
+			      int nr_cluster);
+extern int fat_free_clusters(struct inode *inode, int cluster);
+extern int fat_count_free_clusters(struct super_block *sb);
+
 /* fat/file.c */
 extern int fat_generic_ioctl(struct inode *inode, struct file *filp,
 			     unsigned int cmd, unsigned long arg);
@@ -350,15 +388,13 @@ extern struct inode *fat_iget(struct sup
 extern struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos, int *res);
 extern int fat_sync_inode(struct inode *inode);
-int fat_fill_super(struct super_block *sb, void *data, int silent,
-		   struct inode_operations *fs_dir_inode_ops, int isvfat);
+extern int fat_fill_super(struct super_block *sb, void *data, int silent,
+			struct inode_operations *fs_dir_inode_ops, int isvfat);
 
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
-extern void lock_fat(struct super_block *sb);
-extern void unlock_fat(struct super_block *sb);
 extern void fat_clusters_flush(struct super_block *sb);
-extern int fat_add_cluster(struct inode *inode);
+extern int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster);
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat__get_entry(struct inode *dir, loff_t *pos,
@@ -378,6 +414,7 @@ static __inline__ int fat_get_entry(stru
 	}
 	return fat__get_entry(dir, pos, bh, de, i_pos);
 }
+extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
 #endif /* __KERNEL__ */
 
_
