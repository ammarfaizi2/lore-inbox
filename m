Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCETtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCETtu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVCETqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:46:38 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:23813 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261195AbVCETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] FAT: Rewrite fat_add_entries()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:54:23 +0900
In-Reply-To: <87fyz9q5z7.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:53:48 +0900")
Message-ID: <87br9xq5y8.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order not to write out the same block repeatedly, rewrite the
fat_add_entries().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |  261 ++++++++++++++++++++++++++++++++++-------------
 fs/msdos/namei.c         |   13 --
 fs/vfat/namei.c          |   35 ------
 include/linux/msdos_fs.h |    5 
 4 files changed, 198 insertions(+), 116 deletions(-)

diff -puN fs/fat/dir.c~sync07-fat_dir6 fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~sync07-fat_dir6	2005-03-06 02:36:56.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:56.000000000 +0900
@@ -981,94 +981,211 @@ error:
 
 EXPORT_SYMBOL(fat_alloc_new_dir);
 
-static struct buffer_head *fat_extend_dir(struct inode *inode)
+static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
+			       int *nr_cluster, struct msdos_dir_entry **de,
+			       struct buffer_head **bh, loff_t *i_pos)
 {
-	struct super_block *sb = inode->i_sb;
-	struct buffer_head *bh, *res = NULL;
-	int err, cluster, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
-	sector_t sector, last_sector;
-
-	if (MSDOS_SB(sb)->fat_bits != 32) {
-		if (inode->i_ino == MSDOS_ROOT_INO)
-			return ERR_PTR(-ENOSPC);
-	}
+	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	sector_t blknr, start_blknr, last_blknr;
+	unsigned long size, copy;
+	int err, i, n, offset, cluster[2];
+
+	/*
+	 * The minimum cluster size is 512bytes, and maximum entry
+	 * size is 32*slots (672bytes).  So, iff the cluster size is
+	 * 512bytes, we may need two clusters.
+	 */
+	size = nr_slots * sizeof(struct msdos_dir_entry);
+	*nr_cluster = (size + (sbi->cluster_size - 1)) >> sbi->cluster_bits;
+	BUG_ON(*nr_cluster > 2);
 
-	err = fat_alloc_clusters(inode, &cluster, 1);
+	err = fat_alloc_clusters(dir, cluster, *nr_cluster);
 	if (err)
-		return ERR_PTR(err);
-	err = fat_chain_add(inode, cluster, 1);
-	if (err) {
-		fat_free_clusters(inode, cluster);
-		return ERR_PTR(err);
-	}
+		goto error;
 
-	sector = fat_clus_to_blknr(MSDOS_SB(sb), cluster);
-	last_sector = sector + sec_per_clus;
-	for ( ; sector < last_sector; sector++) {
-		if ((bh = sb_getblk(sb, sector))) {
-			memset(bh->b_data, 0, sb->s_blocksize);
-			set_buffer_uptodate(bh);
-			mark_buffer_dirty(bh);
-			if (sb->s_flags & MS_SYNCHRONOUS)
-				sync_dirty_buffer(bh);
-			if (!res)
-				res = bh;
-			else
-				brelse(bh);
+	/*
+	 * First stage: Fill the directory entry.  NOTE: This cluster
+	 * is not referenced from any inode yet, so updates order is
+	 * not important.
+	 */
+	i = n = copy = 0;
+	do {
+		start_blknr = blknr = fat_clus_to_blknr(sbi, cluster[i]);
+		last_blknr = start_blknr + sbi->sec_per_clus;
+		while (blknr < last_blknr) {
+			bhs[n] = sb_getblk(sb, blknr);
+			if (!bhs[n]) {
+				err = -ENOMEM;
+				goto error_nomem;
+			}
+
+			/* fill the directory entry */
+			copy = min(size, sb->s_blocksize);
+			memcpy(bhs[n]->b_data, slots, copy);
+			slots += copy;
+			size -= copy;
+			set_buffer_uptodate(bhs[n]);
+			mark_buffer_dirty(bhs[n]);
+			if (!size)
+				break;
+			n++;
+			blknr++;
 		}
-	}
-	if (res == NULL)
-		res = ERR_PTR(-EIO);
-	if (inode->i_size & (sb->s_blocksize - 1)) {
-		fat_fs_panic(sb, "Odd directory size");
-		inode->i_size = (inode->i_size + sb->s_blocksize)
-			& ~((loff_t)sb->s_blocksize - 1);
-	}
-	inode->i_size += MSDOS_SB(sb)->cluster_size;
-	MSDOS_I(inode)->mmu_private += MSDOS_SB(sb)->cluster_size;
+	} while (++i < *nr_cluster);
 
-	return res;
-}
+	memset(bhs[n]->b_data + copy, 0, sb->s_blocksize - copy);
+	offset = copy - sizeof(struct msdos_dir_entry);
+	get_bh(bhs[n]);
+	*bh = bhs[n];
+	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
+	*i_pos = ((loff_t)blknr << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
 
-/* This assumes that size of cluster is above the 32*slots */
+	/* Second stage: clear the rest of cluster, and write outs */
+	err = fat_zeroed_cluster(dir, start_blknr, ++n, bhs, MAX_BUF_PER_PAGE);
+	if (err)
+		goto error_free;
 
-int fat_add_entries(struct inode *dir,int slots, struct buffer_head **bh,
-		  struct msdos_dir_entry **de, loff_t *i_pos)
-{
-	struct super_block *sb = dir->i_sb;
-	loff_t offset, curr;
-	int row;
-	struct buffer_head *new_bh;
+	return cluster[0];
 
-	offset = curr = 0;
+error_free:
+	brelse(*bh);
 	*bh = NULL;
-	row = 0;
-	while (fat_get_entry(dir, &curr, bh, de, i_pos) > -1) {
+	n = 0;
+error_nomem:
+	for (i = 0; i < n; i++)
+		bforget(bhs[i]);
+	fat_free_clusters(dir, cluster[0]);
+error:
+	return err;
+}
+
+int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
+		    struct fat_slot_info *sinfo)
+{
+	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
+	struct msdos_dir_entry *de;
+	int err, free_slots, i, nr_bhs;
+	loff_t pos, i_pos;
+
+	sinfo->nr_slots = nr_slots;
+
+	/* First stage: search free direcotry entries */
+	free_slots = nr_bhs = 0;
+	bh = prev = NULL;
+	pos = 0;
+	err = -ENOSPC;
+	while (fat_get_entry(dir, &pos, &bh, &de, &i_pos) > -1) {
 		/* check the maximum size of directory */
-		if (curr >= FAT_MAX_DIR_SIZE) {
-			brelse(*bh);
-			return -ENOSPC;
-		}
+		if (pos >= FAT_MAX_DIR_SIZE)
+			goto error;
 
-		if (IS_FREE((*de)->name)) {
-			if (++row == slots)
-				return offset;
+		if (IS_FREE(de->name)) {
+			if (prev != bh) {
+				get_bh(bh);
+				bhs[nr_bhs] = prev = bh;
+				nr_bhs++;
+			}
+			free_slots++;
+			if (free_slots == nr_slots)
+				goto found;
 		} else {
-			row = 0;
-			offset = curr;
+			for (i = 0; i < nr_bhs; i++)
+				brelse(bhs[i]);
+			prev = NULL;
+			free_slots = nr_bhs = 0;
 		}
 	}
-	if ((dir->i_ino == MSDOS_ROOT_INO) && (MSDOS_SB(sb)->fat_bits != 32))
-		return -ENOSPC;
-	new_bh = fat_extend_dir(dir);
-	if (IS_ERR(new_bh))
-		return PTR_ERR(new_bh);
-	brelse(new_bh);
-	do {
-		fat_get_entry(dir, &curr, bh, de, i_pos);
-	} while (++row < slots);
+	if ((dir->i_ino == MSDOS_ROOT_INO) && (sbi->fat_bits != 32))
+		goto error;
+
+found:
+	err = 0;
+	pos -= free_slots * sizeof(*de);
+	nr_slots -= free_slots;
+	if (free_slots) {
+		/*
+		 * Second stage: filling the free entries with new entries.
+		 * NOTE: If this slots has shortname, first, we write
+		 * the long name slots, then write the short name.
+		 */
+		int size = free_slots * sizeof(*de);
+		int offset = pos & (sb->s_blocksize - 1);
+		int long_bhs = nr_bhs - (nr_slots == 0);
+
+		/* Fill the long name slots. */
+		for (i = 0; i < long_bhs; i++) {
+			int copy = min_t(int, sb->s_blocksize - offset, size);
+			memcpy(bhs[i]->b_data + offset, slots, copy);
+			mark_buffer_dirty(bhs[i]);
+			offset = 0;
+			slots += copy;
+			size -= copy;
+		}
+		if (long_bhs && IS_DIRSYNC(dir))
+			err = fat_sync_bhs(bhs, long_bhs);
+		if (!err && i < nr_bhs) {
+			/* Fill the short name slot. */
+			int copy = min_t(int, sb->s_blocksize - offset, size);
+			memcpy(bhs[i]->b_data + offset, slots, copy);
+			mark_buffer_dirty(bhs[i]);
+			if (IS_DIRSYNC(dir))
+				err = sync_dirty_buffer(bhs[i]);
+		}
+		for (i = 0; i < nr_bhs; i++)
+			brelse(bhs[i]);
+		if (err)
+			goto error_remove;
+	}
+
+	if (nr_slots) {
+		int cluster, nr_cluster;
 
-	return offset;
+		/*
+		 * Third stage: allocate the cluster for new entries.
+		 * And initialize the cluster with new entries, then
+		 * add the cluster to dir.
+		 */
+		cluster = fat_add_new_entries(dir, slots, nr_slots, &nr_cluster,
+					      &de, &bh, &i_pos);
+		if (cluster < 0) {
+			err = cluster;
+			goto error_remove;
+		}
+		err = fat_chain_add(dir, cluster, nr_cluster);
+		if (err) {
+			fat_free_clusters(dir, cluster);
+			goto error_remove;
+		}
+		if (dir->i_size & (sbi->cluster_size - 1)) {
+			fat_fs_panic(sb, "Odd directory size");
+			dir->i_size = (dir->i_size + sbi->cluster_size - 1)
+				& ~((loff_t)sbi->cluster_size - 1);
+		}
+		dir->i_size += nr_cluster << sbi->cluster_bits;
+		MSDOS_I(dir)->mmu_private += nr_cluster << sbi->cluster_bits;
+	}
+	sinfo->slot_off = pos;
+	sinfo->i_pos = i_pos;
+	sinfo->de = de;
+	sinfo->bh = bh;
+
+	return 0;
+
+error:
+	brelse(bh);
+	for (i = 0; i < nr_bhs; i++)
+		brelse(bhs[i]);
+	return err;
+
+error_remove:
+	brelse(bh);
+	if (free_slots)
+		__fat_remove_entries(dir, pos, free_slots);
+	return err;
 }
 
 EXPORT_SYMBOL(fat_add_entries);
diff -puN fs/msdos/namei.c~sync07-fat_dir6 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync07-fat_dir6	2005-03-06 02:36:56.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:36:56.000000000 +0900
@@ -258,7 +258,7 @@ static int msdos_add_entry(struct inode 
 {
 	struct msdos_dir_entry de;
 	__le16 time, date;
-	int offset;
+	int err;
 
 	memcpy(de.name, name, MSDOS_NAME);
 	de.attr = is_dir ? ATTR_DIR : ATTR_ARCH;
@@ -273,14 +273,9 @@ static int msdos_add_entry(struct inode 
 	de.starthi = cpu_to_le16(cluster >> 16);
 	de.size = 0;
 
-	offset = fat_add_entries(dir, 1, &sinfo->bh, &sinfo->de, &sinfo->i_pos);
-	if (offset < 0)
-		return offset;
-	sinfo->slot_off = offset;
-	sinfo->nr_slots = 1;
-
-	memcpy(sinfo->de, &de, sizeof(de));
-	mark_buffer_dirty(sinfo->bh);
+	err = fat_add_entries(dir, &de, 1, sinfo);
+	if (err)
+		return err;
 
 	dir->i_ctime = dir->i_mtime = *ts;
 	mark_inode_dirty(dir);
diff -puN fs/vfat/namei.c~sync07-fat_dir6 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync07-fat_dir6	2005-03-06 02:36:56.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:56.000000000 +0900
@@ -661,14 +661,9 @@ static int vfat_add_entry(struct inode *
 			  int cluster, struct timespec *ts,
 			  struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
 	struct msdos_dir_slot *slots;
 	unsigned int len;
-	int err, i, nr_slots;
-	loff_t offset;
-	struct msdos_dir_entry *de, *dummy_de;
-	struct buffer_head *bh, *dummy_bh;
-	loff_t dummy_i_pos;
+	int err, nr_slots;
 
 	len = vfat_striptail_len(qname);
 	if (len == 0)
@@ -683,37 +678,13 @@ static int vfat_add_entry(struct inode *
 	if (err)
 		goto cleanup;
 
-	/* build the empty directory entry of number of slots */
-	offset =
-	    fat_add_entries(dir, nr_slots, &dummy_bh, &dummy_de, &dummy_i_pos);
-	if (offset < 0) {
-		err = offset;
+	err = fat_add_entries(dir, slots, nr_slots, sinfo);
+	if (err)
 		goto cleanup;
-	}
-	brelse(dummy_bh);
-
-	/* Now create the new entry */
-	bh = NULL;
-	for (i = 0; i < nr_slots; i++) {
-		if (fat_get_entry(dir, &offset, &bh, &de, &sinfo->i_pos) < 0) {
-			err = -EIO;
-			goto cleanup;
-		}
-		memcpy(de, slots + i, sizeof(struct msdos_dir_slot));
-		mark_buffer_dirty(bh);
-		if (sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(bh);
-	}
 
 	/* update timestamp */
 	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
 	mark_inode_dirty(dir);
-
-	/* slots can't be less than 1 */
-	sinfo->slot_off = offset - sizeof(struct msdos_dir_slot) * nr_slots;
-	sinfo->nr_slots = nr_slots;
-	sinfo->de = de;
-	sinfo->bh = bh;
 cleanup:
 	kfree(slots);
 	return err;
diff -puN include/linux/msdos_fs.h~sync07-fat_dir6 include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync07-fat_dir6	2005-03-06 02:36:56.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:56.000000000 +0900
@@ -324,9 +324,6 @@ extern int fat_bmap(struct inode *inode,
 extern struct file_operations fat_dir_operations;
 extern int fat_search_long(struct inode *inode, const unsigned char *name,
 			   int name_len, struct fat_slot_info *sinfo);
-extern int fat_add_entries(struct inode *dir, int slots,
-			   struct buffer_head **bh,
-			   struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
 extern int fat_scan(struct inode *dir, const unsigned char *name,
@@ -334,6 +331,8 @@ extern int fat_scan(struct inode *dir, c
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_alloc_new_dir(struct inode *dir, struct timespec *ts);
+extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
+			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
 
 /* fat/fatent.c */
_
