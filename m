Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312195AbSCRELx>; Sun, 17 Mar 2002 23:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSCRELj>; Sun, 17 Mar 2002 23:11:39 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:30880 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312193AbSCRELY>; Sun, 17 Mar 2002 23:11:24 -0500
Message-ID: <3C9568C0.3040409@didntduck.org>
Date: Sun, 17 Mar 2002 23:10:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - affs
Content-Type: multipart/mixed;
 boundary="------------010203050907070003050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203050907070003050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates affs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------010203050907070003050101
Content-Type: text/plain;
 name="sb-affs-a1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-affs-a1"

diff -urN linux-2.5.7-pre2/fs/affs/amigaffs.c linux/fs/affs/amigaffs.c
--- linux-2.5.7-pre2/fs/affs/amigaffs.c	Thu Mar  7 21:18:18 2002
+++ linux/fs/affs/amigaffs.c	Sun Mar 17 19:20:24 2002
@@ -246,7 +246,7 @@
 		goto done;
 
 	retval = -ENOTEMPTY;
-	for (size = AFFS_SB->s_hashsize - 1; size >= 0; size--)
+	for (size = AFFS_SB(sb)->s_hashsize - 1; size >= 0; size--)
 		if (AFFS_HEAD(bh)->table[size])
 			goto not_empty;
 	retval = 0;
@@ -458,7 +458,7 @@
 	if (!(sb->s_flags & MS_RDONLY))
 		printk(KERN_WARNING "AFFS: Remounting filesystem read-only\n");
 	sb->s_flags |= MS_RDONLY;
-	AFFS_SB->s_flags |= SF_READONLY;	/* Don't allow to remount rw */
+	AFFS_SB(sb)->s_flags |= SF_READONLY;	/* Don't allow to remount rw */
 }
 
 void
diff -urN linux-2.5.7-pre2/fs/affs/bitmap.c linux/fs/affs/bitmap.c
--- linux-2.5.7-pre2/fs/affs/bitmap.c	Thu Mar  7 21:18:28 2002
+++ linux/fs/affs/bitmap.c	Sun Mar 17 19:25:03 2002
@@ -53,14 +53,14 @@
 	if (sb->s_flags & MS_RDONLY)
 		return 0;
 
-	down(&AFFS_SB->s_bmlock);
+	down(&AFFS_SB(sb)->s_bmlock);
 
-	bm = AFFS_SB->s_bitmap;
+	bm = AFFS_SB(sb)->s_bitmap;
 	free = 0;
-	for (i = AFFS_SB->s_bmap_count; i > 0; bm++, i--)
+	for (i = AFFS_SB(sb)->s_bmap_count; i > 0; bm++, i--)
 		free += bm->bm_free;
 
-	up(&AFFS_SB->s_bmlock);
+	up(&AFFS_SB(sb)->s_bmlock);
 
 	return free;
 }
@@ -68,6 +68,7 @@
 void
 affs_free_block(struct super_block *sb, u32 block)
 {
+	struct affs_sb_info *sbi = AFFS_SB(sb);
 	struct affs_bm_info *bm;
 	struct buffer_head *bh;
 	u32 blk, bmap, bit, mask, tmp;
@@ -75,24 +76,24 @@
 
 	pr_debug("AFFS: free_block(%u)\n", block);
 
-	if (block > AFFS_SB->s_partition_size)
+	if (block > sbi->s_partition_size)
 		goto err_range;
 
-	blk     = block - AFFS_SB->s_reserved;
-	bmap    = blk / AFFS_SB->s_bmap_bits;
-	bit     = blk % AFFS_SB->s_bmap_bits;
-	bm      = &AFFS_SB->s_bitmap[bmap];
+	blk     = block - sbi->s_reserved;
+	bmap    = blk / sbi->s_bmap_bits;
+	bit     = blk % sbi->s_bmap_bits;
+	bm      = &sbi->s_bitmap[bmap];
 
-	down(&AFFS_SB->s_bmlock);
+	down(&sbi->s_bmlock);
 
-	bh = AFFS_SB->s_bmap_bh;
-	if (AFFS_SB->s_last_bmap != bmap) {
+	bh = sbi->s_bmap_bh;
+	if (sbi->s_last_bmap != bmap) {
 		affs_brelse(bh);
 		bh = affs_bread(sb, bm->bm_key);
 		if (!bh)
 			goto err_bh_read;
-		AFFS_SB->s_bmap_bh = bh;
-		AFFS_SB->s_last_bmap = bmap;
+		sbi->s_bmap_bh = bh;
+		sbi->s_last_bmap = bmap;
 	}
 
 	mask = 1 << (bit & 31);
@@ -112,19 +113,19 @@
 	sb->s_dirt = 1;
 	bm->bm_free++;
 
-	up(&AFFS_SB->s_bmlock);
+	up(&sbi->s_bmlock);
 	return;
 
 err_free:
 	affs_warning(sb,"affs_free_block","Trying to free block %u which is already free", block);
-	up(&AFFS_SB->s_bmlock);
+	up(&sbi->s_bmlock);
 	return;
 
 err_bh_read:
 	affs_error(sb,"affs_free_block","Cannot read bitmap block %u", bm->bm_key);
-	AFFS_SB->s_bmap_bh = NULL;
-	AFFS_SB->s_last_bmap = ~0;
-	up(&AFFS_SB->s_bmlock);
+	sbi->s_bmap_bh = NULL;
+	sbi->s_last_bmap = ~0;
+	up(&sbi->s_bmlock);
 	return;
 
 err_range:
@@ -145,6 +146,7 @@
 affs_alloc_block(struct inode *inode, u32 goal)
 {
 	struct super_block *sb;
+	struct affs_sb_info *sbi;
 	struct affs_bm_info *bm;
 	struct buffer_head *bh;
 	u32 *data, *enddata;
@@ -152,6 +154,7 @@
 	int i;
 
 	sb = inode->i_sb;
+	sbi = AFFS_SB(sb);
 
 	pr_debug("AFFS: balloc(inode=%lu,goal=%u): ", inode->i_ino, goal);
 
@@ -161,53 +164,53 @@
 		return ++AFFS_I(inode)->i_lastalloc;
 	}
 
-	if (!goal || goal > AFFS_SB->s_partition_size) {
+	if (!goal || goal > sbi->s_partition_size) {
 		if (goal)
 			affs_warning(sb, "affs_balloc", "invalid goal %d", goal);
 		//if (!AFFS_I(inode)->i_last_block)
 		//	affs_warning(sb, "affs_balloc", "no last alloc block");
-		goal = AFFS_SB->s_reserved;
+		goal = sbi->s_reserved;
 	}
 
-	blk = goal - AFFS_SB->s_reserved;
-	bmap = blk / AFFS_SB->s_bmap_bits;
-	bm = &AFFS_SB->s_bitmap[bmap];
+	blk = goal - sbi->s_reserved;
+	bmap = blk / sbi->s_bmap_bits;
+	bm = &sbi->s_bitmap[bmap];
 
-	down(&AFFS_SB->s_bmlock);
+	down(&sbi->s_bmlock);
 
 	if (bm->bm_free)
 		goto find_bmap_bit;
 
 find_bmap:
 	/* search for the next bmap buffer with free bits */
-	i = AFFS_SB->s_bmap_count;
+	i = sbi->s_bmap_count;
 	do {
 		bmap++;
 		bm++;
-		if (bmap < AFFS_SB->s_bmap_count)
+		if (bmap < sbi->s_bmap_count)
 			continue;
 		/* restart search at zero */
 		bmap = 0;
-		bm = AFFS_SB->s_bitmap;
+		bm = sbi->s_bitmap;
 		if (--i <= 0)
 			goto err_full;
 	} while (!bm->bm_free);
-	blk = bmap * AFFS_SB->s_bmap_bits;
+	blk = bmap * sbi->s_bmap_bits;
 
 find_bmap_bit:
 
-	bh = AFFS_SB->s_bmap_bh;
-	if (AFFS_SB->s_last_bmap != bmap) {
+	bh = sbi->s_bmap_bh;
+	if (sbi->s_last_bmap != bmap) {
 		affs_brelse(bh);
 		bh = affs_bread(sb, bm->bm_key);
 		if (!bh)
 			goto err_bh_read;
-		AFFS_SB->s_bmap_bh = bh;
-		AFFS_SB->s_last_bmap = bmap;
+		sbi->s_bmap_bh = bh;
+		sbi->s_last_bmap = bmap;
 	}
 
 	/* find an unused block in this bitmap block */
-	bit = blk % AFFS_SB->s_bmap_bits;
+	bit = blk % sbi->s_bmap_bits;
 	data = (u32 *)bh->b_data + bit / 32 + 1;
 	enddata = (u32 *)((u8 *)bh->b_data + sb->s_blocksize);
 	mask = ~0UL << (bit & 31);
@@ -231,7 +234,7 @@
 find_bit:
 	/* finally look for a free bit in the word */
 	bit = ffs(tmp) - 1;
-	blk += bit + AFFS_SB->s_reserved;
+	blk += bit + sbi->s_reserved;
 	mask2 = mask = 1 << (bit & 31);
 	AFFS_I(inode)->i_lastalloc = blk;
 
@@ -253,18 +256,18 @@
 	mark_buffer_dirty(bh);
 	sb->s_dirt = 1;
 
-	up(&AFFS_SB->s_bmlock);
+	up(&sbi->s_bmlock);
 
 	pr_debug("%d\n", blk);
 	return blk;
 
 err_bh_read:
 	affs_error(sb,"affs_read_block","Cannot read bitmap block %u", bm->bm_key);
-	AFFS_SB->s_bmap_bh = NULL;
-	AFFS_SB->s_last_bmap = ~0;
+	sbi->s_bmap_bh = NULL;
+	sbi->s_last_bmap = ~0;
 err_full:
 	pr_debug("failed\n");
-	up(&AFFS_SB->s_bmlock);
+	up(&sbi->s_bmlock);
 	return 0;
 }
 
@@ -276,35 +279,36 @@
 	u32 *bmap_blk;
 	u32 size, blk, end, offset, mask;
 	int i, res = 0;
+	struct affs_sb_info *sbi = AFFS_SB(sb);
 
 	if (sb->s_flags & MS_RDONLY)
 		return 0;
 
-	if (!AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->bm_flag) {
+	if (!AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->bm_flag) {
 		printk(KERN_NOTICE "AFFS: Bitmap invalid - mounting %s read only\n",
 			sb->s_id);
 		sb->s_flags |= MS_RDONLY;
 		return 0;
 	}
 
-	AFFS_SB->s_last_bmap = ~0;
-	AFFS_SB->s_bmap_bh = NULL;
-	AFFS_SB->s_bmap_bits = sb->s_blocksize * 8 - 32;
-	AFFS_SB->s_bmap_count = (AFFS_SB->s_partition_size - AFFS_SB->s_reserved +
-				 AFFS_SB->s_bmap_bits - 1) / AFFS_SB->s_bmap_bits;
-	size = AFFS_SB->s_bmap_count * sizeof(struct affs_bm_info);
-	bm = AFFS_SB->s_bitmap = kmalloc(size, GFP_KERNEL);
-	if (!AFFS_SB->s_bitmap) {
+	sbi->s_last_bmap = ~0;
+	sbi->s_bmap_bh = NULL;
+	sbi->s_bmap_bits = sb->s_blocksize * 8 - 32;
+	sbi->s_bmap_count = (sbi->s_partition_size - sbi->s_reserved +
+				 sbi->s_bmap_bits - 1) / sbi->s_bmap_bits;
+	size = sbi->s_bmap_count * sizeof(struct affs_bm_info);
+	bm = sbi->s_bitmap = kmalloc(size, GFP_KERNEL);
+	if (!sbi->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
 		return 1;
 	}
-	memset(AFFS_SB->s_bitmap, 0, size);
+	memset(sbi->s_bitmap, 0, size);
 
-	bmap_blk = (u32 *)AFFS_SB->s_root_bh->b_data;
+	bmap_blk = (u32 *)sbi->s_root_bh->b_data;
 	blk = sb->s_blocksize / 4 - 49;
 	end = blk + 25;
 
-	for (i = AFFS_SB->s_bmap_count; i > 0; bm++, i--) {
+	for (i = sbi->s_bmap_count; i > 0; bm++, i--) {
 		affs_brelse(bh);
 
 		bm->bm_key = be32_to_cpu(bmap_blk[blk]);
@@ -341,7 +345,7 @@
 		end = sb->s_blocksize / 4 - 1;
 	}
 
-	offset = (AFFS_SB->s_partition_size - AFFS_SB->s_reserved) % AFFS_SB->s_bmap_bits;
+	offset = (sbi->s_partition_size - sbi->s_reserved) % sbi->s_bmap_bits;
 	mask = ~(0xFFFFFFFFU << (offset & 31));
 	pr_debug("last word: %d %d %d\n", offset, offset / 32 + 1, mask);
 	offset = offset / 32 + 1;
diff -urN linux-2.5.7-pre2/fs/affs/dir.c linux/fs/affs/dir.c
--- linux-2.5.7-pre2/fs/affs/dir.c	Thu Mar  7 21:18:19 2002
+++ linux/fs/affs/dir.c	Sun Mar 17 19:20:24 2002
@@ -122,7 +122,7 @@
 		goto inside;
 	hash_pos++;
 
-	for (; hash_pos < AFFS_SB->s_hashsize; hash_pos++) {
+	for (; hash_pos < AFFS_SB(sb)->s_hashsize; hash_pos++) {
 		ino = be32_to_cpu(AFFS_HEAD(dir_bh)->table[hash_pos]);
 		if (!ino)
 			continue;
diff -urN linux-2.5.7-pre2/fs/affs/file.c linux/fs/affs/file.c
--- linux-2.5.7-pre2/fs/affs/file.c	Thu Mar  7 21:18:30 2002
+++ linux/fs/affs/file.c	Sun Mar 17 19:20:24 2002
@@ -350,8 +350,8 @@
 	//lock cache
 	affs_lock_ext(inode);
 
-	ext = block / AFFS_SB->s_hashsize;
-	block -= ext * AFFS_SB->s_hashsize;
+	ext = block / AFFS_SB(sb)->s_hashsize;
+	block -= ext * AFFS_SB(sb)->s_hashsize;
 	ext_bh = affs_get_extblock(inode, ext);
 	if (IS_ERR(ext_bh))
 		goto err_ext;
@@ -362,7 +362,7 @@
 		if (!blocknr)
 			goto err_alloc;
 		bh_result->b_state |= (1UL << BH_New);
-		AFFS_I(inode)->mmu_private += AFFS_SB->s_data_blksize;
+		AFFS_I(inode)->mmu_private += AFFS_SB(sb)->s_data_blksize;
 		AFFS_I(inode)->i_blkcnt++;
 
 		/* store new block */
@@ -516,7 +516,7 @@
 
 	pr_debug("AFFS: read_page(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
 	data = page_address(page);
-	bsize = AFFS_SB->s_data_blksize;
+	bsize = AFFS_SB(sb)->s_data_blksize;
 	tmp = (page->index << PAGE_CACHE_SHIFT) + from;
 	bidx = tmp / bsize;
 	boff = tmp % bsize;
@@ -546,7 +546,7 @@
 	u32 tmp;
 
 	pr_debug("AFFS: extent_file(%u, %d)\n", (u32)inode->i_ino, newsize);
-	bsize = AFFS_SB->s_data_blksize;
+	bsize = AFFS_SB(sb)->s_data_blksize;
 	bh = NULL;
 	size = inode->i_size;
 	bidx = size / bsize;
@@ -670,7 +670,7 @@
 	int written;
 
 	pr_debug("AFFS: commit_write(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
-	bsize = AFFS_SB->s_data_blksize;
+	bsize = AFFS_SB(sb)->s_data_blksize;
 	data = page_address(page);
 
 	bh = NULL;
@@ -811,8 +811,8 @@
 	last_blk = 0;
 	ext = 0;
 	if (inode->i_size) {
-		last_blk = ((u32)inode->i_size - 1) / AFFS_SB->s_data_blksize;
-		ext = last_blk / AFFS_SB->s_hashsize;
+		last_blk = ((u32)inode->i_size - 1) / AFFS_SB(sb)->s_data_blksize;
+		ext = last_blk / AFFS_SB(sb)->s_hashsize;
 	}
 
 	if (inode->i_size > AFFS_I(inode)->mmu_private) {
@@ -857,11 +857,11 @@
 	i = 0;
 	blk = last_blk;
 	if (inode->i_size) {
-		i = last_blk % AFFS_SB->s_hashsize + 1;
+		i = last_blk % AFFS_SB(sb)->s_hashsize + 1;
 		blk++;
 	} else
 		AFFS_HEAD(ext_bh)->first_data = 0;
-	size = AFFS_SB->s_hashsize;
+	size = AFFS_SB(sb)->s_hashsize;
 	if (size > blkcnt - blk + i)
 		size = blkcnt - blk + i;
 	for (; i < size; i++, blk++) {
@@ -885,7 +885,7 @@
 
 	while (ext_key) {
 		ext_bh = affs_bread(sb, ext_key);
-		size = AFFS_SB->s_hashsize;
+		size = AFFS_SB(sb)->s_hashsize;
 		if (size > blkcnt - blk)
 			size = blkcnt - blk;
 		for (i = 0; i < size; i++, blk++)
diff -urN linux-2.5.7-pre2/fs/affs/inode.c linux/fs/affs/inode.c
--- linux-2.5.7-pre2/fs/affs/inode.c	Thu Mar  7 21:18:29 2002
+++ linux/fs/affs/inode.c	Sun Mar 17 19:40:43 2002
@@ -38,6 +38,7 @@
 affs_read_inode(struct inode *inode)
 {
 	struct super_block	*sb = inode->i_sb;
+	struct affs_sb_info	*sbi = AFFS_SB(sb);
 	struct buffer_head	*bh;
 	struct affs_head	*head;
 	struct affs_tail	*tail;
@@ -83,35 +84,35 @@
 	AFFS_I(inode)->i_lastalloc = 0;
 	AFFS_I(inode)->i_pa_cnt = 0;
 
-	if (AFFS_SB->s_flags & SF_SETMODE)
-		inode->i_mode = AFFS_SB->s_mode;
+	if (sbi->s_flags & SF_SETMODE)
+		inode->i_mode = sbi->s_mode;
 	else
 		inode->i_mode = prot_to_mode(prot);
 
 	id = be16_to_cpu(tail->uid);
-	if (id == 0 || AFFS_SB->s_flags & SF_SETUID)
-		inode->i_uid = AFFS_SB->s_uid;
-	else if (id == 0xFFFF && AFFS_SB->s_flags & SF_MUFS)
+	if (id == 0 || sbi->s_flags & SF_SETUID)
+		inode->i_uid = sbi->s_uid;
+	else if (id == 0xFFFF && sbi->s_flags & SF_MUFS)
 		inode->i_uid = 0;
 	else
 		inode->i_uid = id;
 
 	id = be16_to_cpu(tail->gid);
-	if (id == 0 || AFFS_SB->s_flags & SF_SETGID)
-		inode->i_gid = AFFS_SB->s_gid;
-	else if (id == 0xFFFF && AFFS_SB->s_flags & SF_MUFS)
+	if (id == 0 || sbi->s_flags & SF_SETGID)
+		inode->i_gid = sbi->s_gid;
+	else if (id == 0xFFFF && sbi->s_flags & SF_MUFS)
 		inode->i_gid = 0;
 	else
 		inode->i_gid = id;
 
 	switch (be32_to_cpu(tail->stype)) {
 	case ST_ROOT:
-		inode->i_uid = AFFS_SB->s_uid;
-		inode->i_gid = AFFS_SB->s_gid;
+		inode->i_uid = sbi->s_uid;
+		inode->i_gid = sbi->s_gid;
 		/* fall through */
 	case ST_USERDIR:
 		if (be32_to_cpu(tail->stype) == ST_USERDIR ||
-		    AFFS_SB->s_flags & SF_SETMODE) {
+		    sbi->s_flags & SF_SETMODE) {
 			if (inode->i_mode & S_IRUSR)
 				inode->i_mode |= S_IXUSR;
 			if (inode->i_mode & S_IRGRP)
@@ -147,13 +148,13 @@
 		AFFS_I(inode)->mmu_private = inode->i_size = size;
 		if (inode->i_size) {
 			AFFS_I(inode)->i_blkcnt = (size - 1) /
-					       AFFS_SB->s_data_blksize + 1;
+					       sbi->s_data_blksize + 1;
 			AFFS_I(inode)->i_extcnt = (AFFS_I(inode)->i_blkcnt - 1) /
-					       AFFS_SB->s_hashsize + 1;
+					       sbi->s_hashsize + 1;
 		}
 		if (tail->link_chain)
 			inode->i_nlink = 2;
-		inode->i_mapping->a_ops = (AFFS_SB->s_flags & SF_OFS) ? &affs_aops_ofs : &affs_aops;
+		inode->i_mapping->a_ops = (sbi->s_flags & SF_OFS) ? &affs_aops_ofs : &affs_aops;
 		inode->i_op = &affs_file_inode_operations;
 		inode->i_fop = &affs_file_operations;
 		break;
@@ -207,18 +208,18 @@
 		tail->protect = cpu_to_be32(AFFS_I(inode)->i_protect);
 		tail->size = cpu_to_be32(inode->i_size);
 		secs_to_datestamp(inode->i_mtime,&tail->change);
-		if (!(inode->i_ino == AFFS_SB->s_root_block)) {
+		if (!(inode->i_ino == AFFS_SB(sb)->s_root_block)) {
 			uid = inode->i_uid;
 			gid = inode->i_gid;
-			if (sb->u.affs_sb.s_flags & SF_MUFS) {
+			if (AFFS_SB(sb)->s_flags & SF_MUFS) {
 				if (inode->i_uid == 0 || inode->i_uid == 0xFFFF)
 					uid = inode->i_uid ^ ~0;
 				if (inode->i_gid == 0 || inode->i_gid == 0xFFFF)
 					gid = inode->i_gid ^ ~0;
 			}
-			if (!(sb->u.affs_sb.s_flags & SF_SETUID))
+			if (!(AFFS_SB(sb)->s_flags & SF_SETUID))
 				tail->uid = cpu_to_be16(uid);
-			if (!(sb->u.affs_sb.s_flags & SF_SETGID))
+			if (!(AFFS_SB(sb)->s_flags & SF_SETGID))
 				tail->gid = cpu_to_be16(gid);
 		}
 	}
@@ -240,11 +241,11 @@
 	if (error)
 		goto out;
 
-	if (((attr->ia_valid & ATTR_UID) && (inode->i_sb->u.affs_sb.s_flags & SF_SETUID)) ||
-	    ((attr->ia_valid & ATTR_GID) && (inode->i_sb->u.affs_sb.s_flags & SF_SETGID)) ||
+	if (((attr->ia_valid & ATTR_UID) && (AFFS_SB(inode->i_sb)->s_flags & SF_SETUID)) ||
+	    ((attr->ia_valid & ATTR_GID) && (AFFS_SB(inode->i_sb)->s_flags & SF_SETGID)) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
-	     (inode->i_sb->u.affs_sb.s_flags & (SF_SETMODE | SF_IMMUTABLE)))) {
-		if (!(inode->i_sb->u.affs_sb.s_flags & SF_QUIET))
+	     (AFFS_SB(inode->i_sb)->s_flags & (SF_SETMODE | SF_IMMUTABLE)))) {
+		if (!(AFFS_SB(inode->i_sb)->s_flags & SF_QUIET))
 			error = -EPERM;
 		goto out;
 	}
diff -urN linux-2.5.7-pre2/fs/affs/namei.c linux/fs/affs/namei.c
--- linux-2.5.7-pre2/fs/affs/namei.c	Thu Mar  7 21:18:22 2002
+++ linux/fs/affs/namei.c	Sun Mar 17 19:20:24 2002
@@ -64,7 +64,7 @@
 static inline toupper_t
 affs_get_toupper(struct super_block *sb)
 {
-	return AFFS_SB->s_flags & SF_INTL ? affs_intl_toupper : affs_toupper;
+	return AFFS_SB(sb)->s_flags & SF_INTL ? affs_intl_toupper : affs_toupper;
 }
 
 /*
@@ -177,7 +177,7 @@
 	for (; len > 0; len--)
 		hash = (hash * 13 + toupper(*name++)) & 0x7ff;
 
-	return hash % AFFS_SB->s_hashsize;
+	return hash % AFFS_SB(sb)->s_hashsize;
 }
 
 static struct buffer_head *
@@ -244,7 +244,7 @@
 			return ERR_PTR(-EACCES);
 		}
 	}
-	dentry->d_op = AFFS_SB->s_flags & SF_INTL ? &affs_intl_dentry_operations : &affs_dentry_operations;
+	dentry->d_op = AFFS_SB(sb)->s_flags & SF_INTL ? &affs_intl_dentry_operations : &affs_dentry_operations;
 	unlock_kernel();
 	d_add(dentry, inode);
 	return NULL;
@@ -289,7 +289,7 @@
 
 	inode->i_op = &affs_file_inode_operations;
 	inode->i_fop = &affs_file_operations;
-	inode->i_mapping->a_ops = (AFFS_SB->s_flags & SF_OFS) ? &affs_aops_ofs : &affs_aops;
+	inode->i_mapping->a_ops = (AFFS_SB(sb)->s_flags & SF_OFS) ? &affs_aops_ofs : &affs_aops;
 	error = affs_add_entry(dir, inode, dentry, ST_FILE);
 	if (error) {
 		inode->i_nlink = 0;
@@ -367,7 +367,7 @@
 		 (int)dentry->d_name.len,dentry->d_name.name,symname);
 
 	lock_kernel();
-	maxlen = AFFS_SB->s_hashsize * sizeof(u32) - 1;
+	maxlen = AFFS_SB(sb)->s_hashsize * sizeof(u32) - 1;
 	error = -ENOSPC;
 	inode  = affs_new_inode(dir);
 	if (!inode) {
@@ -390,8 +390,8 @@
 	if (*symname == '/') {
 		while (*symname == '/')
 			symname++;
-		while (AFFS_SB->s_volume[i])	/* Cannot overflow */
-			*p++ = AFFS_SB->s_volume[i++];
+		while (AFFS_SB(sb)->s_volume[i])	/* Cannot overflow */
+			*p++ = AFFS_SB(sb)->s_volume[i++];
 	}
 	while (i < maxlen && (c = *symname++)) {
 		if (c == '.' && lc == '/' && *symname == '.' && symname[1] == '/') {
diff -urN linux-2.5.7-pre2/fs/affs/super.c linux/fs/affs/super.c
--- linux-2.5.7-pre2/fs/affs/super.c	Sat Mar 16 00:17:32 2002
+++ linux/fs/affs/super.c	Sun Mar 17 19:34:56 2002
@@ -38,21 +38,25 @@
 static void
 affs_put_super(struct super_block *sb)
 {
+	struct affs_sb_info *sbi = AFFS_SB(sb);
+
 	pr_debug("AFFS: put_super()\n");
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->bm_flag = be32_to_cpu(1);
+		AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->bm_flag = be32_to_cpu(1);
 		secs_to_datestamp(CURRENT_TIME,
-				  &AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->disk_change);
-		affs_fix_checksum(sb, AFFS_SB->s_root_bh);
-		mark_buffer_dirty(AFFS_SB->s_root_bh);
+				  &AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->disk_change);
+		affs_fix_checksum(sb, sbi->s_root_bh);
+		mark_buffer_dirty(sbi->s_root_bh);
 	}
 
-	affs_brelse(AFFS_SB->s_bmap_bh);
-	if (AFFS_SB->s_prefix)
-		kfree(AFFS_SB->s_prefix);
-	kfree(AFFS_SB->s_bitmap);
-	affs_brelse(AFFS_SB->s_root_bh);
+	affs_brelse(sbi->s_bmap_bh);
+	if (sbi->s_prefix)
+		kfree(sbi->s_prefix);
+	kfree(sbi->s_bitmap);
+	affs_brelse(sbi->s_root_bh);
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 
 	return;
 }
@@ -61,16 +65,17 @@
 affs_write_super(struct super_block *sb)
 {
 	int clean = 2;
+	struct affs_sb_info *sbi = AFFS_SB(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		//	if (AFFS_SB->s_bitmap[i].bm_bh) {
-		//		if (buffer_dirty(AFFS_SB->s_bitmap[i].bm_bh)) {
+		//	if (sbi->s_bitmap[i].bm_bh) {
+		//		if (buffer_dirty(sbi->s_bitmap[i].bm_bh)) {
 		//			clean = 0;
-		AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->bm_flag = be32_to_cpu(clean);
+		AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->bm_flag = be32_to_cpu(clean);
 		secs_to_datestamp(CURRENT_TIME,
-				  &AFFS_ROOT_TAIL(sb, AFFS_SB->s_root_bh)->disk_change);
-		affs_fix_checksum(sb, AFFS_SB->s_root_bh);
-		mark_buffer_dirty(AFFS_SB->s_root_bh);
+				  &AFFS_ROOT_TAIL(sb, sbi->s_root_bh)->disk_change);
+		affs_fix_checksum(sb, sbi->s_root_bh);
+		mark_buffer_dirty(sbi->s_root_bh);
 		sb->s_dirt = !clean;	/* redo until bitmap synced */
 	} else
 		sb->s_dirt = 0;
@@ -267,6 +272,7 @@
 
 static int affs_fill_super(struct super_block *sb, void *data, int silent)
 {
+	struct affs_sb_info	*sbi;
 	struct buffer_head	*root_bh = NULL;
 	struct buffer_head	*boot_bh;
 	struct inode		*root_inode = NULL;
@@ -285,22 +291,27 @@
 
 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
-	memset(AFFS_SB, 0, sizeof(struct affs_sb_info));
-	init_MUTEX(&AFFS_SB->s_bmlock);
+	
+	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct affs_sb_info));
+	init_MUTEX(&sbi->s_bmlock);
 
 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
-				&blocksize,&AFFS_SB->s_prefix,
-				AFFS_SB->s_volume, &mount_flags)) {
+				&blocksize,&sbi->s_prefix,
+				sbi->s_volume, &mount_flags)) {
 		printk(KERN_ERR "AFFS: Error parsing options\n");
 		return -EINVAL;
 	}
 	/* N.B. after this point s_prefix must be released */
 
-	AFFS_SB->s_flags   = mount_flags;
-	AFFS_SB->s_mode    = i;
-	AFFS_SB->s_uid     = uid;
-	AFFS_SB->s_gid     = gid;
-	AFFS_SB->s_reserved= reserved;
+	sbi->s_flags   = mount_flags;
+	sbi->s_mode    = i;
+	sbi->s_uid     = uid;
+	sbi->s_gid     = gid;
+	sbi->s_reserved= reserved;
 
 	/* Get the size of the device in 512-byte blocks.
 	 * If we later see that the partition uses bigger
@@ -320,12 +331,12 @@
 		size = size / (blocksize / 512);
 	}
 	for (blocksize = i, key = 0; blocksize <= j; blocksize <<= 1, size >>= 1) {
-		AFFS_SB->s_root_block = root_block;
+		sbi->s_root_block = root_block;
 		if (root_block < 0)
-			AFFS_SB->s_root_block = (reserved + size - 1) / 2;
+			sbi->s_root_block = (reserved + size - 1) / 2;
 		pr_debug("AFFS: setting blocksize to %d\n", blocksize);
 		affs_set_blocksize(sb, blocksize);
-		AFFS_SB->s_partition_size = size;
+		sbi->s_partition_size = size;
 
 		/* The root block location that was calculated above is not
 		 * correct if the partition size is an odd number of 512-
@@ -341,16 +352,16 @@
 			pr_debug("AFFS: Dev %s, trying root=%u, bs=%d, "
 				"size=%d, reserved=%d\n",
 				sb->s_id,
-				AFFS_SB->s_root_block + num_bm,
+				sbi->s_root_block + num_bm,
 				blocksize, size, reserved);
-			root_bh = affs_bread(sb, AFFS_SB->s_root_block + num_bm);
+			root_bh = affs_bread(sb, sbi->s_root_block + num_bm);
 			if (!root_bh)
 				continue;
 			if (!affs_checksum_block(sb, root_bh) &&
 			    be32_to_cpu(AFFS_ROOT_HEAD(root_bh)->ptype) == T_SHORT &&
 			    be32_to_cpu(AFFS_ROOT_TAIL(sb, root_bh)->stype) == ST_ROOT) {
-				AFFS_SB->s_hashsize    = blocksize / 4 - 56;
-				AFFS_SB->s_root_block += num_bm;
+				sbi->s_hashsize    = blocksize / 4 - 56;
+				sbi->s_root_block += num_bm;
 				key                        = 1;
 				goto got_root;
 			}
@@ -365,7 +376,7 @@
 
 	/* N.B. after this point bh must be released */
 got_root:
-	root_block = AFFS_SB->s_root_block;
+	root_block = sbi->s_root_block;
 
 	/* Find out which kind of FS we have */
 	boot_bh = sb_bread(sb, 0);
@@ -385,36 +396,36 @@
 		printk(KERN_NOTICE "AFFS: Dircache FS - mounting %s read only\n",
 			sb->s_id);
 		sb->s_flags |= MS_RDONLY;
-		AFFS_SB->s_flags |= SF_READONLY;
+		sbi->s_flags |= SF_READONLY;
 	}
 	switch (chksum) {
 		case MUFS_FS:
 		case MUFS_INTLFFS:
 		case MUFS_DCFFS:
-			AFFS_SB->s_flags |= SF_MUFS;
+			sbi->s_flags |= SF_MUFS;
 			/* fall thru */
 		case FS_INTLFFS:
 		case FS_DCFFS:
-			AFFS_SB->s_flags |= SF_INTL;
+			sbi->s_flags |= SF_INTL;
 			break;
 		case MUFS_FFS:
-			AFFS_SB->s_flags |= SF_MUFS;
+			sbi->s_flags |= SF_MUFS;
 			break;
 		case FS_FFS:
 			break;
 		case MUFS_OFS:
-			AFFS_SB->s_flags |= SF_MUFS;
+			sbi->s_flags |= SF_MUFS;
 			/* fall thru */
 		case FS_OFS:
-			AFFS_SB->s_flags |= SF_OFS;
+			sbi->s_flags |= SF_OFS;
 			sb->s_flags |= MS_NOEXEC;
 			break;
 		case MUFS_DCOFS:
 		case MUFS_INTLOFS:
-			AFFS_SB->s_flags |= SF_MUFS;
+			sbi->s_flags |= SF_MUFS;
 		case FS_DCOFS:
 		case FS_INTLOFS:
-			AFFS_SB->s_flags |= SF_INTL | SF_OFS;
+			sbi->s_flags |= SF_INTL | SF_OFS;
 			sb->s_flags |= MS_NOEXEC;
 			break;
 		default:
@@ -433,12 +444,12 @@
 
 	sb->s_flags |= MS_NODEV | MS_NOSUID;
 
-	AFFS_SB->s_data_blksize = sb->s_blocksize;
-	if (AFFS_SB->s_flags & SF_OFS)
-		AFFS_SB->s_data_blksize -= 24;
+	sbi->s_data_blksize = sb->s_blocksize;
+	if (sbi->s_flags & SF_OFS)
+		sbi->s_data_blksize -= 24;
 
 	/* Keep super block in cache */
-	AFFS_SB->s_root_bh = root_bh;
+	sbi->s_root_bh = root_bh;
 	/* N.B. after this point s_root_bh must be released */
 
 	if (affs_init_bitmap(sb))
@@ -463,17 +474,20 @@
 out_error:
 	if (root_inode)
 		iput(root_inode);
-	if (AFFS_SB->s_bitmap)
-		kfree(AFFS_SB->s_bitmap);
+	if (sbi->s_bitmap)
+		kfree(sbi->s_bitmap);
 	affs_brelse(root_bh);
-	if (AFFS_SB->s_prefix)
-		kfree(AFFS_SB->s_prefix);
+	if (sbi->s_prefix)
+		kfree(sbi->s_prefix);
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
 static int
 affs_remount(struct super_block *sb, int *flags, char *data)
 {
+	struct affs_sb_info	*sbi = AFFS_SB(sb);
 	int			 blocksize;
 	uid_t			 uid;
 	gid_t			 gid;
@@ -481,17 +495,17 @@
 	int			 reserved;
 	int			 root_block;
 	unsigned long		 mount_flags;
-	unsigned long		 read_only = AFFS_SB->s_flags & SF_READONLY;
+	unsigned long		 read_only = sbi->s_flags & SF_READONLY;
 
 	pr_debug("AFFS: remount(flags=0x%x,opts=\"%s\")\n",*flags,data);
 
 	if (!parse_options(data,&uid,&gid,&mode,&reserved,&root_block,
-	    &blocksize,&AFFS_SB->s_prefix,AFFS_SB->s_volume,&mount_flags))
+	    &blocksize,&sbi->s_prefix,sbi->s_volume,&mount_flags))
 		return -EINVAL;
-	AFFS_SB->s_flags = mount_flags | read_only;
-	AFFS_SB->s_mode  = mode;
-	AFFS_SB->s_uid   = uid;
-	AFFS_SB->s_gid   = gid;
+	sbi->s_flags = mount_flags | read_only;
+	sbi->s_mode  = mode;
+	sbi->s_uid   = uid;
+	sbi->s_gid   = gid;
 
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
@@ -500,7 +514,7 @@
 		while (sb->s_dirt)
 			affs_write_super(sb);
 		sb->s_flags |= MS_RDONLY;
-	} else if (!(AFFS_SB->s_flags & SF_READONLY)) {
+	} else if (!(sbi->s_flags & SF_READONLY)) {
 		sb->s_flags &= ~MS_RDONLY;
 	} else {
 		affs_warning(sb,"remount","Cannot remount fs read/write because of errors");
@@ -514,13 +528,13 @@
 {
 	int		 free;
 
-	pr_debug("AFFS: statfs() partsize=%d, reserved=%d\n",AFFS_SB->s_partition_size,
-	     AFFS_SB->s_reserved);
+	pr_debug("AFFS: statfs() partsize=%d, reserved=%d\n",AFFS_SB(sb)->s_partition_size,
+	     AFFS_SB(sb)->s_reserved);
 
 	free          = affs_count_free_blocks(sb);
 	buf->f_type    = AFFS_SUPER_MAGIC;
 	buf->f_bsize   = sb->s_blocksize;
-	buf->f_blocks  = AFFS_SB->s_partition_size - AFFS_SB->s_reserved;
+	buf->f_blocks  = AFFS_SB(sb)->s_partition_size - AFFS_SB(sb)->s_reserved;
 	buf->f_bfree   = free;
 	buf->f_bavail  = free;
 	return 0;
diff -urN linux-2.5.7-pre2/fs/affs/symlink.c linux/fs/affs/symlink.c
--- linux-2.5.7-pre2/fs/affs/symlink.c	Thu Mar  7 21:18:16 2002
+++ linux/fs/affs/symlink.c	Sun Mar 17 19:20:24 2002
@@ -40,7 +40,7 @@
 	j  = 0;
 	lf = (struct slink_front *)bh->b_data;
 	lc = 0;
-	pf = inode->i_sb->u.affs_sb.s_prefix ? inode->i_sb->u.affs_sb.s_prefix : "/";
+	pf = AFFS_SB(inode->i_sb)->s_prefix ? AFFS_SB(inode->i_sb)->s_prefix : "/";
 
 	if (strchr(lf->symname,':')) {	/* Handle assign or volume name */
 		while (i < 1023 && (c = pf[i]))
diff -urN linux-2.5.7-pre2/include/linux/affs_fs.h linux/include/linux/affs_fs.h
--- linux-2.5.7-pre2/include/linux/affs_fs.h	Thu Mar  7 21:18:04 2002
+++ linux/include/linux/affs_fs.h	Sun Mar 17 19:38:14 2002
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 
 #include <linux/affs_fs_i.h>
+#include <linux/affs_fs_sb.h>
 
 #define AFFS_SUPER_MAGIC 0xadff
 
diff -urN linux-2.5.7-pre2/include/linux/affs_fs_sb.h linux/include/linux/affs_fs_sb.h
--- linux-2.5.7-pre2/include/linux/affs_fs_sb.h	Thu Mar  7 21:18:15 2002
+++ linux/include/linux/affs_fs_sb.h	Sun Mar 17 19:11:04 2002
@@ -50,6 +50,9 @@
 #define SF_READONLY	0x1000		/* Don't allow to remount rw */
 
 /* short cut to get to the affs specific sb data */
-#define AFFS_SB		(&sb->u.affs_sb)
+static inline struct affs_sb_info *AFFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 #endif
diff -urN linux-2.5.7-pre2/include/linux/amigaffs.h linux/include/linux/amigaffs.h
--- linux-2.5.7-pre2/include/linux/amigaffs.h	Thu Mar  7 21:18:15 2002
+++ linux/include/linux/amigaffs.h	Sun Mar 17 19:38:14 2002
@@ -18,7 +18,7 @@
 
 #define GET_END_PTR(st,p,sz)		 ((st *)((char *)(p)+((sz)-sizeof(st))))
 #define AFFS_GET_HASHENTRY(data,hashkey) be32_to_cpu(((struct dir_front *)data)->hashtable[hashkey])
-#define AFFS_BLOCK(sb, bh, blk)		(AFFS_HEAD(bh)->table[(sb)->u.affs_sb.s_hashsize-1-(blk)])
+#define AFFS_BLOCK(sb, bh, blk)		(AFFS_HEAD(bh)->table[AFFS_SB(sb)->s_hashsize-1-(blk)])
 
 static inline void
 affs_set_blocksize(struct super_block *sb, int size)
@@ -29,7 +29,7 @@
 affs_bread(struct super_block *sb, int block)
 {
 	pr_debug(KERN_DEBUG "affs_bread: %d\n", block);
-	if (block >= AFFS_SB->s_reserved && block < AFFS_SB->s_partition_size)
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
 		return sb_bread(sb, block);
 	return NULL;
 }
@@ -37,7 +37,7 @@
 affs_getblk(struct super_block *sb, int block)
 {
 	pr_debug(KERN_DEBUG "affs_getblk: %d\n", block);
-	if (block >= AFFS_SB->s_reserved && block < AFFS_SB->s_partition_size)
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
 		return sb_getblk(sb, block);
 	return NULL;
 }
@@ -46,7 +46,7 @@
 {
 	struct buffer_head *bh;
 	pr_debug(KERN_DEBUG "affs_getzeroblk: %d\n", block);
-	if (block >= AFFS_SB->s_reserved && block < AFFS_SB->s_partition_size) {
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
 		bh = sb_getblk(sb, block);
 		lock_buffer(bh);
 		memset(bh->b_data, 0 , sb->s_blocksize);
@@ -61,7 +61,7 @@
 {
 	struct buffer_head *bh;
 	pr_debug(KERN_DEBUG "affs_getemptyblk: %d\n", block);
-	if (block >= AFFS_SB->s_reserved && block < AFFS_SB->s_partition_size) {
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
 		bh = sb_getblk(sb, block);
 		wait_on_buffer(bh);
 		mark_buffer_uptodate(bh, 1);
diff -urN linux-2.5.7-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre2/include/linux/fs.h	Sat Mar 16 00:17:34 2002
+++ linux/include/linux/fs.h	Sun Mar 17 19:38:14 2002
@@ -650,7 +650,6 @@
 #include <linux/ntfs_fs_sb.h>
 #include <linux/iso_fs_sb.h>
 #include <linux/sysv_fs_sb.h>
-#include <linux/affs_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
 #include <linux/hfs_fs_sb.h>
@@ -699,7 +698,6 @@
 		struct ntfs_sb_info	ntfs_sb;
 		struct isofs_sb_info	isofs_sb;
 		struct sysv_sb_info	sysv_sb;
-		struct affs_sb_info	affs_sb;
 		struct ufs_sb_info	ufs_sb;
 		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;

--------------010203050907070003050101--

