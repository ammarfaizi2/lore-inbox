Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315039AbSD2KlQ>; Mon, 29 Apr 2002 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSD2KlP>; Mon, 29 Apr 2002 06:41:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:44552 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315039AbSD2KkZ>; Mon, 29 Apr 2002 06:40:25 -0400
Date: Mon, 29 Apr 2002 11:40:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysvfs updates
Message-ID: <20020429114010.A3546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.548, 2002-04-29 13:03:14+02:00, hch@sb.bsdonline.org
  Merge 2.5.11 into sysvfs development tree

ChangeSet@1.531.7.2, 2002-04-19 17:34:40+02:00, hch@sb.bsdonline.org
  sysvfs: V7 uses 512 byte blocks, not 1Kb.

ChangeSet@1.531.7.1, 2002-04-18 21:08:51+02:00, hch@sb.bsdonline.org
  Merge sb.bsdonline.org://repo/linux-2.5
  into sb.bsdonline.org:/repo/linux-2.5-sysvfs

ChangeSet@1.456.6.1, 2002-04-10 21:47:01+02:00, hch@sb.bsdonline.org
  Merge sb.bsdonline.org:/repo/linux-2.5
  into sb.bsdonline.org:/repo/linux-2.5-sysvfs

ChangeSet@1.369.130.1, 2002-04-08 18:14:21+02:00, hch@sb.bsdonline.org
  Merge hkernel@hkernel.bkbits.net:linux-2.5-sysvfs
  into sb.bsdonline.org:/repo/linux-2.5-sysvfs

ChangeSet@1.369.115.1, 2002-04-04 18:43:00+02:00, hch@sb.bsdonline.org
  Merge sb.bsdonline.org:/repo/linux-2.5
  into sb.bsdonline.org:/repo/linux-2.5-sysvfs

ChangeSet@1.369.97.5, 2002-04-03 20:25:37+02:00, hch@sb.bsdonline.org
  Replace BKL for chain locking with sysvfs-private rwlock. 

ChangeSet@1.369.97.4, 2002-04-03 15:56:37+02:00, hch@sb.bsdonline.org
  Sanitize definition of sysvfs dinode.

ChangeSet@1.369.97.3, 2002-04-03 15:50:44+02:00, hch@sb.bsdonline.org
  Move sysvfs incore data from include/linux/sysv_fs.h to fs/sysv/sysv.h.

ChangeSet@1.369.97.2, 2002-04-03 15:17:25+02:00, hch@sb.bsdonline.org
  Make sysvfs use sb->u.generic_sbp.

ChangeSet@1.369.97.1, 2002-04-03 14:20:55+02:00, hch@sb.bsdonline.org
  Access sysvfs superblock fields through SYSV_SB() abstraction.



 b/fs/sysv/balloc.c         |   76 +++++-----
 b/fs/sysv/dir.c            |   19 +-
 b/fs/sysv/file.c           |    3 
 b/fs/sysv/ialloc.c         |   70 +++++----
 b/fs/sysv/inode.c          |  116 ++++++++-------
 b/fs/sysv/itree.c          |   54 ++++---
 b/fs/sysv/namei.c          |    9 -
 b/fs/sysv/super.c          |  327 +++++++++++++++++++++++----------------------
 b/fs/sysv/symlink.c        |    3 
 b/fs/sysv/sysv.h           |  236 ++++++++++++++++++++++++++++++++
 b/include/linux/fs.h       |    2 
 b/include/linux/sysv_fs.h  |  228 +------------------------------
 include/linux/sysv_fs_i.h  |   18 --
 include/linux/sysv_fs_sb.h |   89 ------------
 14 files changed, 608 insertions, 642 deletions


diff -Nru a/fs/sysv/balloc.c b/fs/sysv/balloc.c
--- a/fs/sysv/balloc.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/balloc.c	Mon Apr 29 13:12:01 2002
@@ -19,9 +19,8 @@
  *  This file contains code for allocating/freeing blocks.
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/locks.h>
+#include "sysv.h"
 
 /* We don't trust the value of
    sb->sv_sbd2->s_tfree = *sb->sv_free_blocks
@@ -31,7 +30,7 @@
 {
 	char *bh_data = bh->b_data;
 
-	if (sb->sv_type == FSTYPE_SYSV4)
+	if (SYSV_SB(sb)->s_type == FSTYPE_SYSV4)
 		return (u32*)(bh_data+4);
 	else
 		return (u32*)(bh_data+2);
@@ -41,28 +40,29 @@
 
 void sysv_free_block(struct super_block * sb, u32 nr)
 {
+	struct sysv_sb_info * sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
-	u32 *blocks = sb->sv_bcache;
+	u32 *blocks = sbi->s_bcache;
 	unsigned count;
-	unsigned block = fs32_to_cpu(sb, nr);
+	unsigned block = fs32_to_cpu(sbi, nr);
 
 	/*
 	 * This code does not work at all for AFS (it has a bitmap
 	 * free list).  As AFS is supposed to be read-only no one
 	 * should call this for an AFS filesystem anyway...
 	 */
-	if (sb->sv_type == FSTYPE_AFS)
+	if (sbi->s_type == FSTYPE_AFS)
 		return;
 
-	if (block < sb->sv_firstdatazone || block >= sb->sv_nzones) {
+	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
 		printk("sysv_free_block: trying to free block not in datazone\n");
 		return;
 	}
 
 	lock_super(sb);
-	count = fs16_to_cpu(sb, *sb->sv_bcache_count);
+	count = fs16_to_cpu(sbi, *sbi->s_bcache_count);
 
-	if (count > sb->sv_flc_size) {
+	if (count > sbi->s_flc_size) {
 		printk("sysv_free_block: flc_count > flc_size\n");
 		unlock_super(sb);
 		return;
@@ -71,8 +71,8 @@
 	 * into this block being freed, ditto if it's completely empty
 	 * (applies only on Coherent).
 	 */
-	if (count == sb->sv_flc_size || count == 0) {
-		block += sb->sv_block_base;
+	if (count == sbi->s_flc_size || count == 0) {
+		block += sbi->s_block_base;
 		bh = sb_getblk(sb, block);
 		if (!bh) {
 			printk("sysv_free_block: getblk() failed\n");
@@ -80,42 +80,43 @@
 			return;
 		}
 		memset(bh->b_data, 0, sb->s_blocksize);
-		*(u16*)bh->b_data = cpu_to_fs16(sb, count);
+		*(u16*)bh->b_data = cpu_to_fs16(sbi, count);
 		memcpy(get_chunk(sb,bh), blocks, count * sizeof(sysv_zone_t));
 		mark_buffer_dirty(bh);
 		mark_buffer_uptodate(bh, 1);
 		brelse(bh);
 		count = 0;
 	}
-	sb->sv_bcache[count++] = nr;
+	sbi->s_bcache[count++] = nr;
 
-	*sb->sv_bcache_count = cpu_to_fs16(sb, count);
-	fs32_add(sb, sb->sv_free_blocks, 1);
+	*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
+	fs32_add(sbi, sbi->s_free_blocks, 1);
 	dirty_sb(sb);
 	unlock_super(sb);
 }
 
 u32 sysv_new_block(struct super_block * sb)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	unsigned int block;
 	u32 nr;
 	struct buffer_head * bh;
 	unsigned count;
 
 	lock_super(sb);
-	count = fs16_to_cpu(sb, *sb->sv_bcache_count);
+	count = fs16_to_cpu(sbi, *sbi->s_bcache_count);
 
 	if (count == 0) /* Applies only to Coherent FS */
 		goto Enospc;
-	nr = sb->sv_bcache[--count];
+	nr = sbi->s_bcache[--count];
 	if (nr == 0)  /* Applies only to Xenix FS, SystemV FS */
 		goto Enospc;
 
-	block = fs32_to_cpu(sb, nr);
+	block = fs32_to_cpu(sbi, nr);
 
-	*sb->sv_bcache_count = cpu_to_fs16(sb, count);
+	*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
 
-	if (block < sb->sv_firstdatazone || block >= sb->sv_nzones) {
+	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
 		printk("sysv_new_block: new block %d is not in data zone\n",
 			block);
 		goto Enospc;
@@ -124,26 +125,26 @@
 	if (count == 0) { /* the last block continues the free list */
 		unsigned count;
 
-		block += sb->sv_block_base;
+		block += sbi->s_block_base;
 		if (!(bh = sb_bread(sb, block))) {
 			printk("sysv_new_block: cannot read free-list block\n");
 			/* retry this same block next time */
-			*sb->sv_bcache_count = cpu_to_fs16(sb, 1);
+			*sbi->s_bcache_count = cpu_to_fs16(sbi, 1);
 			goto Enospc;
 		}
-		count = fs16_to_cpu(sb, *(u16*)bh->b_data);
-		if (count > sb->sv_flc_size) {
+		count = fs16_to_cpu(sbi, *(u16*)bh->b_data);
+		if (count > sbi->s_flc_size) {
 			printk("sysv_new_block: free-list block with >flc_size entries\n");
 			brelse(bh);
 			goto Enospc;
 		}
-		*sb->sv_bcache_count = cpu_to_fs16(sb, count);
-		memcpy(sb->sv_bcache, get_chunk(sb, bh),
+		*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
+		memcpy(sbi->s_bcache, get_chunk(sb, bh),
 				count * sizeof(sysv_zone_t));
 		brelse(bh);
 	}
 	/* Now the free list head in the superblock is valid again. */
-	fs32_add(sb, sb->sv_free_blocks, -1);
+	fs32_add(sbi, sbi->s_free_blocks, -1);
 	dirty_sb(sb);
 	unlock_super(sb);
 	return nr;
@@ -155,6 +156,7 @@
 
 unsigned long sysv_count_free_blocks(struct super_block * sb)
 {
+	struct sysv_sb_info * sbi = SYSV_SB(sb);
 	int sb_count;
 	int count;
 	struct buffer_head * bh = NULL;
@@ -167,21 +169,21 @@
 	 * free list).  As AFS is supposed to be read-only we just
 	 * lie and say it has no free block at all.
 	 */
-	if (sb->sv_type == FSTYPE_AFS)
+	if (sbi->s_type == FSTYPE_AFS)
 		return 0;
 
 	lock_super(sb);
-	sb_count = fs32_to_cpu(sb, *sb->sv_free_blocks);
+	sb_count = fs32_to_cpu(sbi, *sbi->s_free_blocks);
 
 	if (0)
 		goto trust_sb;
 
 	/* this causes a lot of disk traffic ... */
 	count = 0;
-	n = fs16_to_cpu(sb, *sb->sv_bcache_count);
-	blocks = sb->sv_bcache;
+	n = fs16_to_cpu(sbi, *sbi->s_bcache_count);
+	blocks = sbi->s_bcache;
 	while (1) {
-		if (n > sb->sv_flc_size)
+		if (n > sbi->s_flc_size)
 			goto E2big;
 		block = 0;
 		while (n && (block = blocks[--n]) != 0)
@@ -189,17 +191,17 @@
 		if (block == 0)
 			break;
 
-		block = fs32_to_cpu(sb, block);
+		block = fs32_to_cpu(sbi, block);
 		if (bh)
 			brelse(bh);
 
-		if (block < sb->sv_firstdatazone || block >= sb->sv_nzones)
+		if (block < sbi->s_firstdatazone || block >= sbi->s_nzones)
 			goto Einval;
-		block += sb->sv_block_base;
+		block += sbi->s_block_base;
 		bh = sb_bread(sb, block);
 		if (!bh)
 			goto Eio;
-		n = fs16_to_cpu(sb, *(u16*)bh->b_data);
+		n = fs16_to_cpu(sbi, *(u16*)bh->b_data);
 		blocks = get_chunk(sb, bh);
 	}
 	if (bh)
@@ -228,7 +230,7 @@
 	printk("sysv_count_free_blocks: free block count was %d, "
 		"correcting to %d\n", sb_count, count);
 	if (!(sb->s_flags & MS_RDONLY)) {
-		*sb->sv_free_blocks = cpu_to_fs32(sb, count);
+		*sbi->s_free_blocks = cpu_to_fs32(sbi, count);
 		dirty_sb(sb);
 	}
 	goto done;
diff -Nru a/fs/sysv/dir.c b/fs/sysv/dir.c
--- a/fs/sysv/dir.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/dir.c	Mon Apr 29 13:12:01 2002
@@ -13,9 +13,8 @@
  *  SystemV/Coherent directory handling functions
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/pagemap.h>
+#include "sysv.h"
 
 static int sysv_readdir(struct file *, void *, filldir_t);
 
@@ -104,7 +103,8 @@
 
 			over = filldir(dirent, name, strnlen(name,SYSV_NAMELEN),
 					(n<<PAGE_CACHE_SHIFT) | offset,
-					fs16_to_cpu(sb, de->inode), DT_UNKNOWN);
+					fs16_to_cpu(SYSV_SB(sb), de->inode),
+					DT_UNKNOWN);
 			if (over) {
 				dir_put_page(page);
 				goto done;
@@ -228,7 +228,7 @@
 		goto out_unlock;
 	memcpy (de->name, name, namelen);
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
-	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -280,10 +280,10 @@
 	memset(base, 0, PAGE_CACHE_SIZE);
 
 	de = (struct sysv_dir_entry *) base;
-	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	strcpy(de->name,".");
 	de++;
-	de->inode = cpu_to_fs16(inode->i_sb, dir->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
 
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
@@ -321,7 +321,8 @@
 			if (de->name[0] != '.')
 				goto not_empty;
 			if (!de->name[1]) {
-				if (de->inode == cpu_to_fs16(sb, inode->i_ino))
+				if (de->inode == cpu_to_fs16(SYSV_SB(sb),
+							inode->i_ino))
 					continue;
 				goto not_empty;
 			}
@@ -350,7 +351,7 @@
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		BUG();
-	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
 	UnlockPage(page);
 	dir_put_page(page);
@@ -377,7 +378,7 @@
 	ino_t res = 0;
 	
 	if (de) {
-		res = fs16_to_cpu(dentry->d_sb, de->inode);
+		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
 		dir_put_page(page);
 	}
 	return res;
diff -Nru a/fs/sysv/file.c b/fs/sysv/file.c
--- a/fs/sysv/file.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/file.c	Mon Apr 29 13:12:01 2002
@@ -13,8 +13,7 @@
  *  SystemV/Coherent regular file handling primitives
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
+#include "sysv.h"
 
 /*
  * We have mostly NULLs here: the current defaults are OK for
diff -Nru a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
--- a/fs/sysv/ialloc.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/ialloc.c	Mon Apr 29 13:12:01 2002
@@ -20,12 +20,11 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/stddef.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include "sysv.h"
 
 /* We don't trust the value of
    sb->sv_sbd2->s_tinode = *sb->sv_sb_total_free_inodes
@@ -37,33 +36,38 @@
 static inline sysv_ino_t *
 sv_sb_fic_inode(struct super_block * sb, unsigned int i)
 {
-	if (sb->sv_bh1 == sb->sv_bh2)
-		return &sb->sv_sb_fic_inodes[i];
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+
+	if (sbi->s_bh1 == sbi->s_bh2)
+		return &sbi->s_sb_fic_inodes[i];
 	else {
 		/* 512 byte Xenix FS */
 		unsigned int offset = offsetof(struct xenix_super_block, s_inode[i]);
 		if (offset < 512)
-			return (sysv_ino_t*)(sb->sv_sbd1 + offset);
+			return (sysv_ino_t*)(sbi->s_sbd1 + offset);
 		else
-			return (sysv_ino_t*)(sb->sv_sbd2 + offset);
+			return (sysv_ino_t*)(sbi->s_sbd2 + offset);
 	}
 }
 
 struct sysv_inode *
 sysv_raw_inode(struct super_block *sb, unsigned ino, struct buffer_head **bh)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	struct sysv_inode *res;
-	int block = sb->sv_firstinodezone + sb->sv_block_base;
-	block += (ino-1) >> sb->sv_inodes_per_block_bits;
+	int block = sbi->s_firstinodezone + sbi->s_block_base;
+
+	block += (ino-1) >> sbi->s_inodes_per_block_bits;
 	*bh = sb_bread(sb, block);
 	if (!*bh)
 		return NULL;
-	res = (struct sysv_inode *) (*bh)->b_data;
-	return res + ((ino-1) & sb->sv_inodes_per_block_1);
+	res = (struct sysv_inode *)(*bh)->b_data;
+	return res + ((ino-1) & sbi->s_inodes_per_block_1);
 }
 
 static int refill_free_cache(struct super_block *sb)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
 	int i = 0, ino;
@@ -72,13 +76,13 @@
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
 	if (!raw_inode)
 		goto out;
-	while (ino <= sb->sv_ninodes) {
+	while (ino <= sbi->s_ninodes) {
 		if (raw_inode->i_mode == 0 && raw_inode->i_nlink == 0) {
-			*sv_sb_fic_inode(sb,i++) = cpu_to_fs16(sb, ino);
-			if (i == sb->sv_fic_size)
+			*sv_sb_fic_inode(sb,i++) = cpu_to_fs16(SYSV_SB(sb), ino);
+			if (i == sbi->s_fic_size)
 				break;
 		}
-		if ((ino++ & sb->sv_inodes_per_block_1) == 0) {
+		if ((ino++ & sbi->s_inodes_per_block_1) == 0) {
 			brelse(bh);
 			raw_inode = sysv_raw_inode(sb, ino, &bh);
 			if (!raw_inode)
@@ -93,7 +97,8 @@
 
 void sysv_free_inode(struct inode * inode)
 {
-	struct super_block * sb;
+	struct super_block *sb = inode->i_sb;
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	unsigned int ino;
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
@@ -101,7 +106,7 @@
 
 	sb = inode->i_sb;
 	ino = inode->i_ino;
-	if (ino <= SYSV_ROOT_INO || ino > sb->sv_ninodes) {
+	if (ino <= SYSV_ROOT_INO || ino > sbi->s_ninodes) {
 		printk("sysv_free_inode: inode 0,1,2 or nonexistent inode\n");
 		return;
 	}
@@ -113,12 +118,12 @@
 		return;
 	}
 	lock_super(sb);
-	count = fs16_to_cpu(sb, *sb->sv_sb_fic_count);
-	if (count < sb->sv_fic_size) {
-		*sv_sb_fic_inode(sb,count++) = cpu_to_fs16(sb, ino);
-		*sb->sv_sb_fic_count = cpu_to_fs16(sb, count);
+	count = fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
+	if (count < sbi->s_fic_size) {
+		*sv_sb_fic_inode(sb,count++) = cpu_to_fs16(sbi, ino);
+		*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
 	}
-	fs16_add(sb, sb->sv_sb_total_free_inodes, 1);
+	fs16_add(sbi, sbi->s_sb_total_free_inodes, 1);
 	dirty_sb(sb);
 	memset(raw_inode, 0, sizeof(struct sysv_inode));
 	mark_buffer_dirty(bh);
@@ -128,18 +133,18 @@
 
 struct inode * sysv_new_inode(const struct inode * dir, mode_t mode)
 {
-	struct inode * inode;
-	struct super_block * sb;
+	struct super_block *sb = dir->i_sb;
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+	struct inode *inode;
 	u16 ino;
 	unsigned count;
 
-	sb = dir->i_sb;
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
 	lock_super(sb);
-	count = fs16_to_cpu(sb, *sb->sv_sb_fic_count);
+	count = fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
 	if (count == 0 || (*sv_sb_fic_inode(sb,count-1) == 0)) {
 		count = refill_free_cache(sb);
 		if (count == 0) {
@@ -150,8 +155,8 @@
 	}
 	/* Now count > 0. */
 	ino = *sv_sb_fic_inode(sb,--count);
-	*sb->sv_sb_fic_count = cpu_to_fs16(sb, count);
-	fs16_add(sb, sb->sv_sb_total_free_inodes, -1);
+	*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
+	fs16_add(sbi, sbi->s_sb_total_free_inodes, -1);
 	dirty_sb(sb);
 	
 	if (dir->i_mode & S_ISGID) {
@@ -162,7 +167,7 @@
 		inode->i_gid = current->fsgid;
 
 	inode->i_uid = current->fsuid;
-	inode->i_ino = fs16_to_cpu(sb, ino);
+	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
@@ -180,13 +185,14 @@
 
 unsigned long sysv_count_free_inodes(struct super_block * sb)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
 	int ino, count, sb_count;
 
 	lock_super(sb);
 
-	sb_count = fs16_to_cpu(sb, *sb->sv_sb_total_free_inodes);
+	sb_count = fs16_to_cpu(sbi, *sbi->s_sb_total_free_inodes);
 
 	if (0)
 		goto trust_sb;
@@ -197,10 +203,10 @@
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
 	if (!raw_inode)
 		goto Eio;
-	while (ino <= sb->sv_ninodes) {
+	while (ino <= sbi->s_ninodes) {
 		if (raw_inode->i_mode == 0 && raw_inode->i_nlink == 0)
 			count++;
-		if ((ino++ & sb->sv_inodes_per_block_1) == 0) {
+		if ((ino++ & sbi->s_inodes_per_block_1) == 0) {
 			brelse(bh);
 			raw_inode = sysv_raw_inode(sb, ino, &bh);
 			if (!raw_inode)
@@ -220,7 +226,7 @@
 		"free inode count was %d, correcting to %d\n",
 		sb_count, count);
 	if (!(sb->s_flags & MS_RDONLY)) {
-		*sb->sv_sb_total_free_inodes = cpu_to_fs16(sb, count);
+		*sbi->s_sb_total_free_inodes = cpu_to_fs16(SYSV_SB(sb), count);
 		dirty_sb(sb);
 	}
 	goto out;
diff -Nru a/fs/sysv/inode.c b/fs/sysv/inode.c
--- a/fs/sysv/inode.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/inode.c	Mon Apr 29 13:12:01 2002
@@ -21,56 +21,68 @@
  *  the superblock.
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <asm/byteorder.h>
+#include "sysv.h"
 
 /* This is only called on sync() and umount(), when s_dirt=1. */
 static void sysv_write_super(struct super_block *sb)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+	unsigned long time = CURRENT_TIME, old_time;
+
 	lock_kernel();
-	if (!(sb->s_flags & MS_RDONLY)) {
-		/* If we are going to write out the super block,
-		   then attach current time stamp.
-		   But if the filesystem was marked clean, keep it clean. */
-		unsigned long time = CURRENT_TIME;
-		unsigned long old_time = fs32_to_cpu(sb, *sb->sv_sb_time);
-		if (sb->sv_type == FSTYPE_SYSV4)
-			if (*sb->sv_sb_state == cpu_to_fs32(sb, 0x7c269d38 - old_time))
-				*sb->sv_sb_state = cpu_to_fs32(sb, 0x7c269d38 - time);
-		*sb->sv_sb_time = cpu_to_fs32(sb, time);
-		mark_buffer_dirty(sb->sv_bh2);
+	if (sb->s_flags & MS_RDONLY)
+		goto clean;
+
+	/*
+	 * If we are going to write out the super block,
+	 * then attach current time stamp.
+	 * But if the filesystem was marked clean, keep it clean.
+	 */
+	old_time = fs32_to_cpu(sbi, *sbi->s_sb_time);
+	if (sbi->s_type == FSTYPE_SYSV4) {
+		if (*sbi->s_sb_state == cpu_to_fs32(sbi, 0x7c269d38 - old_time))
+			*sbi->s_sb_state = cpu_to_fs32(sbi, 0x7c269d38 - time);
+		*sbi->s_sb_time = cpu_to_fs32(sbi, time);
+		mark_buffer_dirty(sbi->s_bh2);
 	}
+clean:
 	sb->s_dirt = 0;
 	unlock_kernel();
 }
 
 static void sysv_put_super(struct super_block *sb)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+
 	if (!(sb->s_flags & MS_RDONLY)) {
 		/* XXX ext2 also updates the state here */
-		mark_buffer_dirty(sb->sv_bh1);
-		if (sb->sv_bh1 != sb->sv_bh2)
-			mark_buffer_dirty(sb->sv_bh2);
+		mark_buffer_dirty(sbi->s_bh1);
+		if (sbi->s_bh1 != sbi->s_bh2)
+			mark_buffer_dirty(sbi->s_bh2);
 	}
 
-	brelse(sb->sv_bh1);
-	if (sb->sv_bh1 != sb->sv_bh2)
-		brelse(sb->sv_bh2);
+	brelse(sbi->s_bh1);
+	if (sbi->s_bh1 != sbi->s_bh2)
+		brelse(sbi->s_bh2);
+
+	kfree(sbi);
 }
 
 static int sysv_statfs(struct super_block *sb, struct statfs *buf)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = sb->sv_ndatazones;
+	buf->f_blocks = sbi->s_ndatazones;
 	buf->f_bavail = buf->f_bfree = sysv_count_free_blocks(sb);
-	buf->f_files = sb->sv_ninodes;
+	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = sysv_count_free_inodes(sb);
 	buf->f_namelen = SYSV_NAMELEN;
 	return 0;
@@ -79,15 +91,15 @@
 /* 
  * NXI <-> N0XI for PDP, XIN <-> XIN0 for le32, NIX <-> 0NIX for be32
  */
-static inline void read3byte(struct super_block *sb,
+static inline void read3byte(struct sysv_sb_info *sbi,
 	unsigned char * from, unsigned char * to)
 {
-	if (sb->sv_bytesex == BYTESEX_PDP) {
+	if (sbi->s_bytesex == BYTESEX_PDP) {
 		to[0] = from[0];
 		to[1] = 0;
 		to[2] = from[1];
 		to[3] = from[2];
-	} else if (sb->sv_bytesex == BYTESEX_LE) {
+	} else if (sbi->s_bytesex == BYTESEX_LE) {
 		to[0] = from[0];
 		to[1] = from[1];
 		to[2] = from[2];
@@ -100,14 +112,14 @@
 	}
 }
 
-static inline void write3byte(struct super_block *sb,
+static inline void write3byte(struct sysv_sb_info *sbi,
 	unsigned char * from, unsigned char * to)
 {
-	if (sb->sv_bytesex == BYTESEX_PDP) {
+	if (sbi->s_bytesex == BYTESEX_PDP) {
 		to[0] = from[0];
 		to[1] = from[2];
 		to[2] = from[3];
-	} else if (sb->sv_bytesex == BYTESEX_LE) {
+	} else if (sbi->s_bytesex == BYTESEX_LE) {
 		to[0] = from[0];
 		to[1] = from[1];
 		to[2] = from[2];
@@ -146,6 +158,7 @@
 static void sysv_read_inode(struct inode *inode)
 {
 	struct super_block * sb = inode->i_sb;
+	struct sysv_sb_info * sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
 	struct sysv_inode_info * si;
@@ -153,7 +166,7 @@
 	dev_t rdev = 0;
 
 	ino = inode->i_ino;
-	if (!ino || ino > sb->sv_ninodes) {
+	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %d is out of range\n",
 		       inode->i_sb->s_id, ino);
 		goto bad_inode;
@@ -165,23 +178,23 @@
 		goto bad_inode;
 	}
 	/* SystemV FS: kludge permissions if ino==SYSV_ROOT_INO ?? */
-	inode->i_mode = fs16_to_cpu(sb, raw_inode->i_mode);
-	inode->i_uid = (uid_t)fs16_to_cpu(sb, raw_inode->i_uid);
-	inode->i_gid = (gid_t)fs16_to_cpu(sb, raw_inode->i_gid);
-	inode->i_nlink = fs16_to_cpu(sb, raw_inode->i_nlink);
-	inode->i_size = fs32_to_cpu(sb, raw_inode->i_size);
-	inode->i_atime = fs32_to_cpu(sb, raw_inode->i_atime);
-	inode->i_mtime = fs32_to_cpu(sb, raw_inode->i_mtime);
-	inode->i_ctime = fs32_to_cpu(sb, raw_inode->i_ctime);
+	inode->i_mode = fs16_to_cpu(sbi, raw_inode->i_mode);
+	inode->i_uid = (uid_t)fs16_to_cpu(sbi, raw_inode->i_uid);
+	inode->i_gid = (gid_t)fs16_to_cpu(sbi, raw_inode->i_gid);
+	inode->i_nlink = fs16_to_cpu(sbi, raw_inode->i_nlink);
+	inode->i_size = fs32_to_cpu(sbi, raw_inode->i_size);
+	inode->i_atime = fs32_to_cpu(sbi, raw_inode->i_atime);
+	inode->i_mtime = fs32_to_cpu(sbi, raw_inode->i_mtime);
+	inode->i_ctime = fs32_to_cpu(sbi, raw_inode->i_ctime);
 	inode->i_blocks = inode->i_blksize = 0;
 
 	si = SYSV_I(inode);
 	for (block = 0; block < 10+1+1+1; block++)
-		read3byte(sb, &raw_inode->i_a.i_addb[3*block],
-			(unsigned char*)&si->i_data[block]);
+		read3byte(sbi, &raw_inode->i_data[3*block],
+				(u8 *)&si->i_data[block]);
 	brelse(bh);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		rdev = (u16)fs32_to_cpu(sb, si->i_data[0]);
+		rdev = (u16)fs32_to_cpu(sbi, si->i_data[0]);
 	si->i_dir_start_lookup = 0;
 	sysv_set_inode(inode, rdev);
 	return;
@@ -194,13 +207,14 @@
 static struct buffer_head * sysv_update_inode(struct inode * inode)
 {
 	struct super_block * sb = inode->i_sb;
+	struct sysv_sb_info * sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
 	struct sysv_inode_info * si;
 	unsigned int ino, block;
 
 	ino = inode->i_ino;
-	if (!ino || ino > sb->sv_ninodes) {
+	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %d is out of range\n",
 		       inode->i_sb->s_id, ino);
 		return 0;
@@ -211,21 +225,21 @@
 		return 0;
 	}
 
-	raw_inode->i_mode = cpu_to_fs16(sb, inode->i_mode);
-	raw_inode->i_uid = cpu_to_fs16(sb, fs_high2lowuid(inode->i_uid));
-	raw_inode->i_gid = cpu_to_fs16(sb, fs_high2lowgid(inode->i_gid));
-	raw_inode->i_nlink = cpu_to_fs16(sb, inode->i_nlink);
-	raw_inode->i_size = cpu_to_fs32(sb, inode->i_size);
-	raw_inode->i_atime = cpu_to_fs32(sb, inode->i_atime);
-	raw_inode->i_mtime = cpu_to_fs32(sb, inode->i_mtime);
-	raw_inode->i_ctime = cpu_to_fs32(sb, inode->i_ctime);
+	raw_inode->i_mode = cpu_to_fs16(sbi, inode->i_mode);
+	raw_inode->i_uid = cpu_to_fs16(sbi, fs_high2lowuid(inode->i_uid));
+	raw_inode->i_gid = cpu_to_fs16(sbi, fs_high2lowgid(inode->i_gid));
+	raw_inode->i_nlink = cpu_to_fs16(sbi, inode->i_nlink);
+	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
+	raw_inode->i_atime = cpu_to_fs32(sbi, inode->i_atime);
+	raw_inode->i_mtime = cpu_to_fs32(sbi, inode->i_mtime);
+	raw_inode->i_ctime = cpu_to_fs32(sbi, inode->i_ctime);
 
 	si = SYSV_I(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		si->i_data[0] = cpu_to_fs32(sb, kdev_t_to_nr(inode->i_rdev));
+		si->i_data[0] = cpu_to_fs32(sbi, kdev_t_to_nr(inode->i_rdev));
 	for (block = 0; block < 10+1+1+1; block++)
-		write3byte(sb, (unsigned char*)&si->i_data[block],
-			&raw_inode->i_a.i_addb[3*block]);
+		write3byte(sbi, (u8 *)&si->i_data[block],
+			&raw_inode->i_data[3*block]);
 	mark_buffer_dirty(bh);
 	return bh;
 }
diff -Nru a/fs/sysv/itree.c b/fs/sysv/itree.c
--- a/fs/sysv/itree.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/itree.c	Mon Apr 29 13:12:01 2002
@@ -5,10 +5,8 @@
  *  AV, Sep--Dec 2000
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/locks.h>
-#include <linux/smp_lock.h>
+#include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
 
@@ -24,9 +22,10 @@
 static int block_to_path(struct inode *inode, long block, int offsets[DEPTH])
 {
 	struct super_block *sb = inode->i_sb;
-	int ptrs_bits = sb->sv_ind_per_block_bits;
-	unsigned long	indirect_blocks = sb->sv_ind_per_block,
-			double_blocks = sb->sv_ind_per_block_2;
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+	int ptrs_bits = sbi->s_ind_per_block_bits;
+	unsigned long	indirect_blocks = sbi->s_ind_per_block,
+			double_blocks = sbi->s_ind_per_block_2;
 	int n = 0;
 
 	if (block < 0) {
@@ -51,9 +50,9 @@
 	return n;
 }
 
-static inline int block_to_cpu(struct super_block *sb, u32 nr)
+static inline int block_to_cpu(struct sysv_sb_info *sbi, u32 nr)
 {
-	return sb->sv_block_base + fs32_to_cpu(sb, nr);
+	return sbi->s_block_base + fs32_to_cpu(sbi, nr);
 }
 
 typedef struct {
@@ -62,6 +61,8 @@
 	struct buffer_head *bh;
 } Indirect;
 
+static rwlock_t pointers_lock = RW_LOCK_UNLOCKED;
+
 static inline void add_chain(Indirect *p, struct buffer_head *bh, u32 *v)
 {
 	p->key = *(p->p = v);
@@ -91,23 +92,26 @@
 	struct buffer_head *bh;
 
 	*err = 0;
-	add_chain (chain, NULL, SYSV_I(inode)->i_data + *offsets);
+	add_chain(chain, NULL, SYSV_I(inode)->i_data + *offsets);
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
-		int block = block_to_cpu(sb, p->key);
+		int block = block_to_cpu(SYSV_SB(sb), p->key);
 		bh = sb_bread(sb, block);
 		if (!bh)
 			goto failure;
+		read_lock(&pointers_lock);
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (u32*)bh->b_data + *++offsets);
+		read_unlock(&pointers_lock);
 		if (!p->key)
-		goto no_block;
+			goto no_block;
 	}
 	return NULL;
 
 changed:
+	read_unlock(&pointers_lock);
 	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
@@ -138,7 +142,7 @@
 		 * Get buffer_head for parent block, zero it out and set 
 		 * the pointer to new one, then send parent to disk.
 		 */
-		parent = block_to_cpu(inode->i_sb, branch[n-1].key);
+		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
@@ -166,12 +170,14 @@
 				int num)
 {
 	int i;
-	/* Verify that place we are splicing to is still there and vacant */
 
+	/* Verify that place we are splicing to is still there and vacant */
+	write_lock(&pointers_lock);
 	if (!verify_chain(chain, where-1) || *where->p)
 		goto changed;
-
 	*where->p = where->key;
+	write_unlock(&pointers_lock);
+
 	inode->i_ctime = CURRENT_TIME;
 
 	/* had we spliced it onto indirect block? */
@@ -185,6 +191,7 @@
 	return 0;
 
 changed:
+	write_unlock(&pointers_lock);
 	for (i = 1; i < num; i++)
 		bforget(where[i].bh);
 	for (i = 0; i < num; i++)
@@ -205,14 +212,14 @@
 	if (depth == 0)
 		goto out;
 
-	lock_kernel();
 reread:
 	partial = get_branch(inode, depth, offsets, chain, &err);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
 got_it:
-		map_bh(bh_result, sb, block_to_cpu(sb, chain[depth-1].key));
+		map_bh(bh_result, sb, block_to_cpu(SYSV_SB(sb),
+					chain[depth-1].key));
 		/* Clean up and exit */
 		partial = chain+depth-1; /* the whole chain */
 		goto cleanup;
@@ -225,7 +232,6 @@
 			brelse(partial->bh);
 			partial--;
 		}
-		unlock_kernel();
 out:
 		return err;
 	}
@@ -277,6 +283,8 @@
 	*top = 0;
 	for (k = depth; k > 1 && !offsets[k-1]; k--)
 		;
+
+	write_lock(&pointers_lock);
 	partial = get_branch(inode, k, offsets, chain, &err);
 	if (!partial)
 		partial = chain + k-1;
@@ -284,8 +292,10 @@
 	 * If the branch acquired continuation since we've looked at it -
 	 * fine, it should all survive and (new) top doesn't belong to us.
 	 */
-	if (!partial->key && *partial->p)
+	if (!partial->key && *partial->p) {
+		write_unlock(&pointers_lock);
 		goto no_top;
+	}
 	for (p=partial; p>chain && all_zeroes((u32*)p->bh->b_data,p->p); p--)
 		;
 	/*
@@ -300,8 +310,9 @@
 		*top = *p->p;
 		*p->p = 0;
 	}
+	write_unlock(&pointers_lock);
 
-	while(partial > p) {
+	while (partial > p) {
 		brelse(partial->bh);
 		partial--;
 	}
@@ -333,7 +344,7 @@
 			if (!nr)
 				continue;
 			*p = 0;
-			block = block_to_cpu(sb, nr);
+			block = block_to_cpu(SYSV_SB(sb), nr);
 			bh = sb_bread(sb, block);
 			if (!bh)
 				continue;
@@ -372,8 +383,6 @@
 	if (n == 0)
 		return;
 
-	lock_kernel();
-
 	if (n == 1) {
 		free_data(inode, i_data+offsets[0], i_data + DIRECT);
 		goto do_indirects;
@@ -412,7 +421,6 @@
 		sysv_sync_inode (inode);
 	else
 		mark_inode_dirty(inode);
-	unlock_kernel();
 }
 
 static int sysv_writepage(struct page *page)
diff -Nru a/fs/sysv/namei.c b/fs/sysv/namei.c
--- a/fs/sysv/namei.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/namei.c	Mon Apr 29 13:12:01 2002
@@ -12,10 +12,9 @@
  *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include "sysv.h"
 
 static inline void inc_count(struct inode *inode)
 {
@@ -138,7 +137,7 @@
 {
 	struct inode *inode = old_dentry->d_inode;
 
-	if (inode->i_nlink >= inode->i_sb->sv_link_max)
+	if (inode->i_nlink >= SYSV_SB(inode->i_sb)->s_link_max)
 		return -EMLINK;
 
 	inode->i_ctime = CURRENT_TIME;
@@ -153,7 +152,7 @@
 	struct inode * inode;
 	int err = -EMLINK;
 
-	if (dir->i_nlink >= dir->i_sb->sv_link_max) 
+	if (dir->i_nlink >= SYSV_SB(dir->i_sb)->s_link_max) 
 		goto out;
 	inc_count(dir);
 
@@ -271,7 +270,7 @@
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
-			if (new_dir->i_nlink >= new_dir->i_sb->sv_link_max)
+			if (new_dir->i_nlink >= SYSV_SB(new_dir->i_sb)->s_link_max)
 				goto out_dir;
 		}
 		inc_count(old_inode);
diff -Nru a/fs/sysv/super.c b/fs/sysv/super.c
--- a/fs/sysv/super.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/super.c	Mon Apr 29 13:12:01 2002
@@ -21,10 +21,9 @@
  */
 
 #include <linux/module.h>
-
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+#include "sysv.h"
 
 /*
  * The following functions try to recognize specific filesystems.
@@ -44,10 +43,10 @@
 	JAN_1_1980 = (10*365 + 2) * 24 * 60 * 60
 };
 
-static void detected_xenix(struct super_block *sb)
+static void detected_xenix(struct sysv_sb_info *sbi)
 {
-	struct buffer_head *bh1 = sb->sv_bh1;
-	struct buffer_head *bh2 = sb->sv_bh2;
+	struct buffer_head *bh1 = sbi->s_bh1;
+	struct buffer_head *bh2 = sbi->s_bh2;
 	struct xenix_super_block * sbd1;
 	struct xenix_super_block * sbd2;
 
@@ -59,152 +58,153 @@
 		sbd2 = (struct xenix_super_block *) (bh2->b_data - 512);
 	}
 
-	sb->sv_link_max = XENIX_LINK_MAX;
-	sb->sv_fic_size = XENIX_NICINOD;
-	sb->sv_flc_size = XENIX_NICFREE;
-	sb->sv_sbd1 = (char *) sbd1;
-	sb->sv_sbd2 = (char *) sbd2;
-	sb->sv_sb_fic_count = &sbd1->s_ninode;
-	sb->sv_sb_fic_inodes = &sbd1->s_inode[0];
-	sb->sv_sb_total_free_inodes = &sbd2->s_tinode;
-	sb->sv_bcache_count = &sbd1->s_nfree;
-	sb->sv_bcache = &sbd1->s_free[0];
-	sb->sv_free_blocks = &sbd2->s_tfree;
-	sb->sv_sb_time = &sbd2->s_time;
-	sb->sv_firstdatazone = fs16_to_cpu(sb, sbd1->s_isize);
-	sb->sv_nzones = fs32_to_cpu(sb, sbd1->s_fsize);
+	sbi->s_link_max = XENIX_LINK_MAX;
+	sbi->s_fic_size = XENIX_NICINOD;
+	sbi->s_flc_size = XENIX_NICFREE;
+	sbi->s_sbd1 = (char *)sbd1;
+	sbi->s_sbd2 = (char *)sbd2;
+	sbi->s_sb_fic_count = &sbd1->s_ninode;
+	sbi->s_sb_fic_inodes = &sbd1->s_inode[0];
+	sbi->s_sb_total_free_inodes = &sbd2->s_tinode;
+	sbi->s_bcache_count = &sbd1->s_nfree;
+	sbi->s_bcache = &sbd1->s_free[0];
+	sbi->s_free_blocks = &sbd2->s_tfree;
+	sbi->s_sb_time = &sbd2->s_time;
+	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd1->s_isize);
+	sbi->s_nzones = fs32_to_cpu(sbi, sbd1->s_fsize);
 }
 
-static void detected_sysv4(struct super_block *sb)
+static void detected_sysv4(struct sysv_sb_info *sbi)
 {
 	struct sysv4_super_block * sbd;
-	struct buffer_head *bh1 = sb->sv_bh1;
-	struct buffer_head *bh2 = sb->sv_bh2;
+	struct buffer_head *bh1 = sbi->s_bh1;
+	struct buffer_head *bh2 = sbi->s_bh2;
 
 	if (bh1 == bh2)
 		sbd = (struct sysv4_super_block *) (bh1->b_data + BLOCK_SIZE/2);
 	else
 		sbd = (struct sysv4_super_block *) bh2->b_data;
 
-	sb->sv_link_max = SYSV_LINK_MAX;
-	sb->sv_fic_size = SYSV_NICINOD;
-	sb->sv_flc_size = SYSV_NICFREE;
-	sb->sv_sbd1 = (char *) sbd;
-	sb->sv_sbd2 = (char *) sbd;
-	sb->sv_sb_fic_count = &sbd->s_ninode;
-	sb->sv_sb_fic_inodes = &sbd->s_inode[0];
-	sb->sv_sb_total_free_inodes = &sbd->s_tinode;
-	sb->sv_bcache_count = &sbd->s_nfree;
-	sb->sv_bcache = &sbd->s_free[0];
-	sb->sv_free_blocks = &sbd->s_tfree;
-	sb->sv_sb_time = &sbd->s_time;
-	sb->sv_sb_state = &sbd->s_state;
-	sb->sv_firstdatazone = fs16_to_cpu(sb, sbd->s_isize);
-	sb->sv_nzones = fs32_to_cpu(sb, sbd->s_fsize);
-}
-
-static void detected_sysv2(struct super_block *sb)
-{
-	struct sysv2_super_block * sbd;
-	struct buffer_head *bh1 = sb->sv_bh1;
-	struct buffer_head *bh2 = sb->sv_bh2;
+	sbi->s_link_max = SYSV_LINK_MAX;
+	sbi->s_fic_size = SYSV_NICINOD;
+	sbi->s_flc_size = SYSV_NICFREE;
+	sbi->s_sbd1 = (char *)sbd;
+	sbi->s_sbd2 = (char *)sbd;
+	sbi->s_sb_fic_count = &sbd->s_ninode;
+	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
+	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
+	sbi->s_bcache_count = &sbd->s_nfree;
+	sbi->s_bcache = &sbd->s_free[0];
+	sbi->s_free_blocks = &sbd->s_tfree;
+	sbi->s_sb_time = &sbd->s_time;
+	sbi->s_sb_state = &sbd->s_state;
+	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
+	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
+}
+
+static void detected_sysv2(struct sysv_sb_info *sbi)
+{
+	struct sysv2_super_block *sbd;
+	struct buffer_head *bh1 = sbi->s_bh1;
+	struct buffer_head *bh2 = sbi->s_bh2;
 
 	if (bh1 == bh2)
 		sbd = (struct sysv2_super_block *) (bh1->b_data + BLOCK_SIZE/2);
 	else
 		sbd = (struct sysv2_super_block *) bh2->b_data;
 
-	sb->sv_link_max = SYSV_LINK_MAX;
-	sb->sv_fic_size = SYSV_NICINOD;
-	sb->sv_flc_size = SYSV_NICFREE;
-	sb->sv_sbd1 = (char *) sbd;
-	sb->sv_sbd2 = (char *) sbd;
-	sb->sv_sb_fic_count = &sbd->s_ninode;
-	sb->sv_sb_fic_inodes = &sbd->s_inode[0];
-	sb->sv_sb_total_free_inodes = &sbd->s_tinode;
-	sb->sv_bcache_count = &sbd->s_nfree;
-	sb->sv_bcache = &sbd->s_free[0];
-	sb->sv_free_blocks = &sbd->s_tfree;
-	sb->sv_sb_time = &sbd->s_time;
-	sb->sv_sb_state = &sbd->s_state;
-	sb->sv_firstdatazone = fs16_to_cpu(sb, sbd->s_isize);
-	sb->sv_nzones = fs32_to_cpu(sb, sbd->s_fsize);
+	sbi->s_link_max = SYSV_LINK_MAX;
+	sbi->s_fic_size = SYSV_NICINOD;
+	sbi->s_flc_size = SYSV_NICFREE;
+	sbi->s_sbd1 = (char *)sbd;
+	sbi->s_sbd2 = (char *)sbd;
+	sbi->s_sb_fic_count = &sbd->s_ninode;
+	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
+	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
+	sbi->s_bcache_count = &sbd->s_nfree;
+	sbi->s_bcache = &sbd->s_free[0];
+	sbi->s_free_blocks = &sbd->s_tfree;
+	sbi->s_sb_time = &sbd->s_time;
+	sbi->s_sb_state = &sbd->s_state;
+	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
+	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
 }
 
-static void detected_coherent(struct super_block *sb)
+static void detected_coherent(struct sysv_sb_info *sbi)
 {
 	struct coh_super_block * sbd;
-	struct buffer_head *bh1 = sb->sv_bh1;
+	struct buffer_head *bh1 = sbi->s_bh1;
 
 	sbd = (struct coh_super_block *) bh1->b_data;
 
-	sb->sv_link_max = COH_LINK_MAX;
-	sb->sv_fic_size = COH_NICINOD;
-	sb->sv_flc_size = COH_NICFREE;
-	sb->sv_sbd1 = (char *) sbd;
-	sb->sv_sbd2 = (char *) sbd;
-	sb->sv_sb_fic_count = &sbd->s_ninode;
-	sb->sv_sb_fic_inodes = &sbd->s_inode[0];
-	sb->sv_sb_total_free_inodes = &sbd->s_tinode;
-	sb->sv_bcache_count = &sbd->s_nfree;
-	sb->sv_bcache = &sbd->s_free[0];
-	sb->sv_free_blocks = &sbd->s_tfree;
-	sb->sv_sb_time = &sbd->s_time;
-	sb->sv_firstdatazone = fs16_to_cpu(sb, sbd->s_isize);
-	sb->sv_nzones = fs32_to_cpu(sb, sbd->s_fsize);
+	sbi->s_link_max = COH_LINK_MAX;
+	sbi->s_fic_size = COH_NICINOD;
+	sbi->s_flc_size = COH_NICFREE;
+	sbi->s_sbd1 = (char *)sbd;
+	sbi->s_sbd2 = (char *)sbd;
+	sbi->s_sb_fic_count = &sbd->s_ninode;
+	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
+	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
+	sbi->s_bcache_count = &sbd->s_nfree;
+	sbi->s_bcache = &sbd->s_free[0];
+	sbi->s_free_blocks = &sbd->s_tfree;
+	sbi->s_sb_time = &sbd->s_time;
+	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
+	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
 }
 
-static void detected_v7(struct super_block *sb)
+static void detected_v7(struct sysv_sb_info *sbi)
 {
-	struct buffer_head *bh2 = sb->sv_bh2;
+	struct buffer_head *bh2 = sbi->s_bh2;
 	struct v7_super_block *sbd = (struct v7_super_block *)bh2->b_data;
 
-	sb->sv_link_max = V7_LINK_MAX;
-	sb->sv_fic_size = V7_NICINOD;
-	sb->sv_flc_size = V7_NICFREE;
-	sb->sv_sbd1 = (char *)sbd;
-	sb->sv_sbd2 = (char *)sbd;
-	sb->sv_sb_fic_count = &sbd->s_ninode;
-	sb->sv_sb_fic_inodes = &sbd->s_inode[0];
-	sb->sv_sb_total_free_inodes = &sbd->s_tinode;
-	sb->sv_bcache_count = &sbd->s_nfree;
-	sb->sv_bcache = &sbd->s_free[0];
-	sb->sv_free_blocks = &sbd->s_tfree;
-	sb->sv_sb_time = &sbd->s_time;
-	sb->sv_firstdatazone = fs16_to_cpu(sb, sbd->s_isize);
-	sb->sv_nzones = fs32_to_cpu(sb, sbd->s_fsize);
+	sbi->s_link_max = V7_LINK_MAX;
+	sbi->s_fic_size = V7_NICINOD;
+	sbi->s_flc_size = V7_NICFREE;
+	sbi->s_sbd1 = (char *)sbd;
+	sbi->s_sbd2 = (char *)sbd;
+	sbi->s_sb_fic_count = &sbd->s_ninode;
+	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
+	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
+	sbi->s_bcache_count = &sbd->s_nfree;
+	sbi->s_bcache = &sbd->s_free[0];
+	sbi->s_free_blocks = &sbd->s_tfree;
+	sbi->s_sb_time = &sbd->s_time;
+	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
+	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
 }
 
-static int detect_xenix (struct super_block *sb, struct buffer_head *bh)
+static int detect_xenix(struct sysv_sb_info *sbi, struct buffer_head *bh)
 {
-	struct xenix_super_block * sbd = (struct xenix_super_block *)bh->b_data;
+	struct xenix_super_block *sbd = (struct xenix_super_block *)bh->b_data;
 	if (sbd->s_magic == cpu_to_le32(0x2b5544))
-		sb->sv_bytesex = BYTESEX_LE;
+		sbi->s_bytesex = BYTESEX_LE;
 	else if (sbd->s_magic == cpu_to_be32(0x2b5544))
-		sb->sv_bytesex = BYTESEX_BE;
+		sbi->s_bytesex = BYTESEX_BE;
 	else
 		return 0;
 	if (sbd->s_type > 2 || sbd->s_type < 1)
 		return 0;
-	sb->sv_type = FSTYPE_XENIX;
+	sbi->s_type = FSTYPE_XENIX;
 	return sbd->s_type;
 }
 
-static int detect_sysv (struct super_block *sb, struct buffer_head *bh)
+static int detect_sysv(struct sysv_sb_info *sbi, struct buffer_head *bh)
 {
+	struct super_block *sb = sbi->s_sb;
 	/* All relevant fields are at the same offsets in R2 and R4 */
 	struct sysv4_super_block * sbd;
 
 	sbd = (struct sysv4_super_block *) (bh->b_data + BLOCK_SIZE/2);
 	if (sbd->s_magic == cpu_to_le32(0xfd187e20))
-		sb->sv_bytesex = BYTESEX_LE;
+		sbi->s_bytesex = BYTESEX_LE;
 	else if (sbd->s_magic == cpu_to_be32(0xfd187e20))
-		sb->sv_bytesex = BYTESEX_BE;
+		sbi->s_bytesex = BYTESEX_BE;
 	else
 		return 0;
  
- 	if (fs16_to_cpu(sb, sbd->s_nfree) == 0xffff) {
- 		sb->sv_type = FSTYPE_AFS;
+ 	if (fs16_to_cpu(sbi, sbd->s_nfree) == 0xffff) {
+ 		sbi->s_type = FSTYPE_AFS;
  		if (!(sb->s_flags & MS_RDONLY)) {
  			printk("SysV FS: SCO EAFS on %s detected, " 
  				"forcing read-only mode.\n", 
@@ -214,11 +214,11 @@
  		return sbd->s_type;
  	}
  
-	if (fs32_to_cpu(sb, sbd->s_time) < JAN_1_1980) {
+	if (fs32_to_cpu(sbi, sbd->s_time) < JAN_1_1980) {
 		/* this is likely to happen on SystemV2 FS */
 		if (sbd->s_type > 3 || sbd->s_type < 1)
 			return 0;
-		sb->sv_type = FSTYPE_SYSV2;
+		sbi->s_type = FSTYPE_SYSV2;
 		return sbd->s_type;
 	}
 	if ((sbd->s_type > 3 || sbd->s_type < 1) &&
@@ -236,11 +236,11 @@
 		sb->s_flags |= MS_RDONLY;
 	}
 
-	sb->sv_type = FSTYPE_SYSV4;
+	sbi->s_type = FSTYPE_SYSV4;
 	return sbd->s_type >= 0x10 ? (sbd->s_type >> 4) : sbd->s_type;
 }
 
-static int detect_coherent (struct super_block *sb, struct buffer_head *bh)
+static int detect_coherent(struct sysv_sb_info *sbi, struct buffer_head *bh)
 {
 	struct coh_super_block * sbd;
 
@@ -248,21 +248,21 @@
 	if ((memcmp(sbd->s_fname,"noname",6) && memcmp(sbd->s_fname,"xxxxx ",6))
 	    || (memcmp(sbd->s_fpack,"nopack",6) && memcmp(sbd->s_fpack,"xxxxx\n",6)))
 		return 0;
-	sb->sv_bytesex = BYTESEX_PDP;
-	sb->sv_type = FSTYPE_COH;
+	sbi->s_bytesex = BYTESEX_PDP;
+	sbi->s_type = FSTYPE_COH;
 	return 1;
 }
 
-static int detect_sysv_odd(struct super_block *sb, struct buffer_head *bh)
+static int detect_sysv_odd(struct sysv_sb_info *sbi, struct buffer_head *bh)
 {
-	int size = detect_sysv(sb, bh);
+	int size = detect_sysv(sbi, bh);
 
 	return size>2 ? 0 : size;
 }
 
 static struct {
 	int block;
-	int (*test)(struct super_block *, struct buffer_head *);
+	int (*test)(struct sysv_sb_info *, struct buffer_head *);
 } flavours[] = {
 	{1, detect_xenix},
 	{0, detect_sysv},
@@ -281,7 +281,7 @@
 	[FSTYPE_AFS]	"AFS",
 };
 
-static void (*flavour_setup[])(struct super_block *) = {
+static void (*flavour_setup[])(struct sysv_sb_info *) = {
 	[FSTYPE_XENIX]	detected_xenix,
 	[FSTYPE_SYSV4]	detected_sysv4,
 	[FSTYPE_SYSV2]	detected_sysv2,
@@ -292,34 +292,35 @@
 
 static int complete_read_super(struct super_block *sb, int silent, int size)
 {
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	struct inode *root_inode;
-	char *found = flavour_names[sb->sv_type];
+	char *found = flavour_names[sbi->s_type];
 	u_char n_bits = size+8;
 	int bsize = 1 << n_bits;
 	int bsize_4 = bsize >> 2;
 
-	sb->sv_firstinodezone = 2;
+	sbi->s_firstinodezone = 2;
 
-	flavour_setup[sb->sv_type](sb);
+	flavour_setup[sbi->s_type](sbi);
 	
-	sb->sv_truncate = 1;
-	sb->sv_ndatazones = sb->sv_nzones - sb->sv_firstdatazone;
-	sb->sv_inodes_per_block = bsize >> 6;
-	sb->sv_inodes_per_block_1 = (bsize >> 6)-1;
-	sb->sv_inodes_per_block_bits = n_bits-6;
-	sb->sv_ind_per_block = bsize_4;
-	sb->sv_ind_per_block_2 = bsize_4*bsize_4;
-	sb->sv_toobig_block = 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
-	sb->sv_ind_per_block_bits = n_bits-2;
+	sbi->s_truncate = 1;
+	sbi->s_ndatazones = sbi->s_nzones - sbi->s_firstdatazone;
+	sbi->s_inodes_per_block = bsize >> 6;
+	sbi->s_inodes_per_block_1 = (bsize >> 6)-1;
+	sbi->s_inodes_per_block_bits = n_bits-6;
+	sbi->s_ind_per_block = bsize_4;
+	sbi->s_ind_per_block_2 = bsize_4*bsize_4;
+	sbi->s_toobig_block = 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
+	sbi->s_ind_per_block_bits = n_bits-2;
 
-	sb->sv_ninodes = (sb->sv_firstdatazone - sb->sv_firstinodezone)
-		<< sb->sv_inodes_per_block_bits;
+	sbi->s_ninodes = (sbi->s_firstdatazone - sbi->s_firstinodezone)
+		<< sbi->s_inodes_per_block_bits;
 
 	if (!silent)
 		printk("VFS: Found a %s FS (block size = %ld) on device %s\n",
 		       found, sb->s_blocksize, sb->s_id);
 
-	sb->s_magic = SYSV_MAGIC_BASE + sb->sv_type;
+	sb->s_magic = SYSV_MAGIC_BASE + sbi->s_type;
 	/* set up enough so that it can read an inode */
 	sb->s_op = &sysv_sops;
 	root_inode = iget(sb,SYSV_ROOT_INO);
@@ -333,7 +334,7 @@
 		printk("SysV FS: get root dentry failed\n");
 		return 0;
 	}
-	if (sb->sv_truncate)
+	if (sbi->s_truncate)
 		sb->s_root->d_op = &sysv_dentry_operations;
 	sb->s_flags |= MS_RDONLY;
 	sb->s_dirt = 1;
@@ -342,30 +343,39 @@
 
 static int sysv_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct buffer_head *bh1;
-	struct buffer_head *bh = NULL;
+	struct buffer_head *bh1, *bh = NULL;
+	struct sysv_sb_info *sbi;
 	unsigned long blocknr;
-	int size = 0;
-	int i;
+	int size = 0, i;
 	
 	if (1024 != sizeof (struct xenix_super_block))
-		panic("Xenix FS: bad super-block size");
-	if ((512 != sizeof (struct sysv4_super_block))
-            || (512 != sizeof (struct sysv2_super_block)))
-		panic("SystemV FS: bad super-block size");
+		panic("Xenix FS: bad superblock size");
+	if (512 != sizeof (struct sysv4_super_block))
+		panic("SystemV FS: bad superblock size");
+	if (512 != sizeof (struct sysv2_super_block))
+		panic("SystemV FS: bad superblock size");
 	if (500 != sizeof (struct coh_super_block))
-		panic("Coherent FS: bad super-block size");
+		panic("Coherent FS: bad superblock size");
 	if (64 != sizeof (struct sysv_inode))
-		panic("sysv fs: bad i-node size");
+		panic("sysv fs: bad inode size");
+
+	sbi = kmalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	memset(sbi, 0, sizeof(struct sysv_sb_info));
+
+	sbi->s_sb = sb;
+	sbi->s_block_base = 0;
+	sb->u.generic_sbp = sbi;
+	
 	sb_set_blocksize(sb, BLOCK_SIZE);
-	sb->sv_block_base = 0;
 
 	for (i = 0; i < sizeof(flavours)/sizeof(flavours[0]) && !size; i++) {
 		brelse(bh);
 		bh = sb_bread(sb, flavours[i].block);
 		if (!bh)
 			continue;
-		size = flavours[i].test(sb, bh);
+		size = flavours[i].test(SYSV_SB(sb), bh);
 	}
 
 	if (!size)
@@ -393,8 +403,8 @@
 	}
 
 	if (bh && bh1) {
-		sb->sv_bh1 = bh1;
-		sb->sv_bh2 = bh;
+		sbi->s_bh1 = bh1;
+		sbi->s_bh2 = bh;
 		if (complete_read_super(sb, silent, size))
 			return 0;
 	}
@@ -404,6 +414,7 @@
 	sb_set_blocksize(sb, BLOCK_SIZE);
 	printk("oldfs: cannot read superblock\n");
 failed:
+	kfree(sbi);
 	return -EINVAL;
 
 Eunknown:
@@ -422,6 +433,7 @@
 
 static int v7_fill_super(struct super_block *sb, void *data, int silent)
 {
+	struct sysv_sb_info *sbi;
 	struct buffer_head *bh, *bh2 = NULL;
 	struct v7_super_block *v7sb;
 	struct sysv_inode *v7i;
@@ -431,9 +443,17 @@
 	if (64 != sizeof (struct sysv_inode))
 		panic("sysv fs: bad i-node size");
 
-	sb->sv_type = FSTYPE_V7;
-	sb->sv_bytesex = BYTESEX_PDP;
-
+	sbi = kmalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	memset(sbi, 0, sizeof(struct sysv_sb_info));
+
+	sbi->s_sb = sb;
+	sbi->s_block_base = 0;
+	sbi->s_type = FSTYPE_V7;
+	sbi->s_bytesex = BYTESEX_PDP;
+	sb->u.generic_sbp = sbi;
+	
 	sb_set_blocksize(sb, 512);
 
 	if ((bh = sb_bread(sb, 1)) == NULL) {
@@ -445,9 +465,9 @@
 
 	/* plausibility check on superblock */
 	v7sb = (struct v7_super_block *) bh->b_data;
-	if (fs16_to_cpu(sb,v7sb->s_nfree) > V7_NICFREE ||
-	    fs16_to_cpu(sb,v7sb->s_ninode) > V7_NICINOD ||
-	    fs32_to_cpu(sb,v7sb->s_time) == 0)
+	if (fs16_to_cpu(sbi, v7sb->s_nfree) > V7_NICFREE ||
+	    fs16_to_cpu(sbi, v7sb->s_ninode) > V7_NICINOD ||
+	    fs32_to_cpu(sbi, v7sb->s_time) == 0)
 		goto failed;
 
 	/* plausibility check on root inode: it is a directory,
@@ -455,20 +475,21 @@
 	if ((bh2 = sb_bread(sb, 2)) == NULL)
 		goto failed;
 	v7i = (struct sysv_inode *)(bh2->b_data + 64);
-	if ((fs16_to_cpu(sb,v7i->i_mode) & ~0777) != S_IFDIR ||
-	    (fs32_to_cpu(sb,v7i->i_size) == 0) ||
-	    (fs32_to_cpu(sb,v7i->i_size) & 017) != 0)
+	if ((fs16_to_cpu(sbi, v7i->i_mode) & ~0777) != S_IFDIR ||
+	    (fs32_to_cpu(sbi, v7i->i_size) == 0) ||
+	    (fs32_to_cpu(sbi, v7i->i_size) & 017) != 0)
 		goto failed;
 	brelse(bh2);
 
-	sb->sv_bh1 = bh;
-	sb->sv_bh2 = bh;
+	sbi->s_bh1 = bh;
+	sbi->s_bh2 = bh;
 	if (complete_read_super(sb, silent, 1))
 		return 0;
 
 failed:
 	brelse(bh2);
 	brelse(bh);
+	kfree(sbi);
 	return -EINVAL;
 }
 
diff -Nru a/fs/sysv/symlink.c b/fs/sysv/symlink.c
--- a/fs/sysv/symlink.c	Mon Apr 29 13:12:01 2002
+++ b/fs/sysv/symlink.c	Mon Apr 29 13:12:01 2002
@@ -5,8 +5,7 @@
  *  Aug 2001, Christoph Hellwig (hch@infradead.org)
  */
 
-#include <linux/fs.h>
-#include <linux/sysv_fs.h>
+#include "sysv.h"
 
 static int sysv_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
diff -Nru a/fs/sysv/sysv.h b/fs/sysv/sysv.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/sysv/sysv.h	Mon Apr 29 13:12:01 2002
@@ -0,0 +1,236 @@
+#ifndef _SYSV_H
+#define _SYSV_H
+
+#include <linux/fs.h>
+#include <linux/sysv_fs.h>
+
+/*
+ * SystemV/V7/Coherent super-block data in memory
+ *
+ * The SystemV/V7/Coherent superblock contains dynamic data (it gets modified
+ * while the system is running). This is in contrast to the Minix and Berkeley
+ * filesystems (where the superblock is never modified). This affects the
+ * sync() operation: we must keep the superblock in a disk buffer and use this
+ * one as our "working copy".
+ */
+
+struct sysv_sb_info {
+	struct super_block *s_sb;	/* VFS superblock */
+	int	       s_type;		/* file system type: FSTYPE_{XENIX|SYSV|COH} */
+	char	       s_bytesex;	/* bytesex (le/be/pdp) */
+	char	       s_truncate;	/* if 1: names > SYSV_NAMELEN chars are truncated */
+					/* if 0: they are disallowed (ENAMETOOLONG) */
+	nlink_t        s_link_max;	/* max number of hard links to a file */
+	unsigned int   s_inodes_per_block;	/* number of inodes per block */
+	unsigned int   s_inodes_per_block_1;	/* inodes_per_block - 1 */
+	unsigned int   s_inodes_per_block_bits;	/* log2(inodes_per_block) */
+	unsigned int   s_ind_per_block;		/* number of indirections per block */
+	unsigned int   s_ind_per_block_bits;	/* log2(ind_per_block) */
+	unsigned int   s_ind_per_block_2;	/* ind_per_block ^ 2 */
+	unsigned int   s_toobig_block;		/* 10 + ipb + ipb^2 + ipb^3 */
+	unsigned int   s_block_base;	/* physical block number of block 0 */
+	unsigned short s_fic_size;	/* free inode cache size, NICINOD */
+	unsigned short s_flc_size;	/* free block list chunk size, NICFREE */
+	/* The superblock is kept in one or two disk buffers: */
+	struct buffer_head *s_bh1;
+	struct buffer_head *s_bh2;
+	/* These are pointers into the disk buffer, to compensate for
+	   different superblock layout. */
+	char *         s_sbd1;		/* entire superblock data, for part 1 */
+	char *         s_sbd2;		/* entire superblock data, for part 2 */
+	u16            *s_sb_fic_count;	/* pointer to s_sbd->s_ninode */
+        u16            *s_sb_fic_inodes; /* pointer to s_sbd->s_inode */
+	u16            *s_sb_total_free_inodes; /* pointer to s_sbd->s_tinode */
+	u16            *s_bcache_count;	/* pointer to s_sbd->s_nfree */
+	u32	       *s_bcache;	/* pointer to s_sbd->s_free */
+	u32            *s_free_blocks;	/* pointer to s_sbd->s_tfree */
+	u32            *s_sb_time;	/* pointer to s_sbd->s_time */
+	u32            *s_sb_state;	/* pointer to s_sbd->s_state, only FSTYPE_SYSV */
+	/* We keep those superblock entities that don't change here;
+	   this saves us an indirection and perhaps a conversion. */
+	u32            s_firstinodezone; /* index of first inode zone */
+	u32            s_firstdatazone;	/* same as s_sbd->s_isize */
+	u32            s_ninodes;	/* total number of inodes */
+	u32            s_ndatazones;	/* total number of data zones */
+	u32            s_nzones;	/* same as s_sbd->s_fsize */
+	u16	       s_namelen;       /* max length of dir entry */
+};
+
+/*
+ * SystemV/V7/Coherent FS inode data in memory
+ */
+struct sysv_inode_info {
+	u32		i_data[13];
+	u32		i_dir_start_lookup;
+	struct inode	vfs_inode;
+};
+
+
+static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
+{
+	return list_entry(inode, struct sysv_inode_info, vfs_inode);
+}
+
+static inline struct sysv_sb_info *SYSV_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
+
+/* identify the FS in memory */
+enum {
+	FSTYPE_NONE = 0,
+	FSTYPE_XENIX,
+	FSTYPE_SYSV4,
+	FSTYPE_SYSV2,
+	FSTYPE_COH,
+	FSTYPE_V7,
+	FSTYPE_AFS,
+	FSTYPE_END,
+};
+
+#define SYSV_MAGIC_BASE		0x012FF7B3
+
+#define XENIX_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_XENIX)
+#define SYSV4_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV4)
+#define SYSV2_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV2)
+#define COH_SUPER_MAGIC		(SYSV_MAGIC_BASE+FSTYPE_COH)
+
+
+/* Admissible values for i_nlink: 0.._LINK_MAX */
+enum {
+	XENIX_LINK_MAX	=	126,	/* ?? */
+	SYSV_LINK_MAX	=	126,	/* 127? 251? */
+	V7_LINK_MAX     =	126,	/* ?? */
+	COH_LINK_MAX	=	10000,
+};
+
+
+static inline void dirty_sb(struct super_block *sb)
+{
+	struct sysv_sb_info *sbi = SYSV_SB(sb);
+
+	mark_buffer_dirty(sbi->s_bh1);
+	if (sbi->s_bh1 != sbi->s_bh2)
+		mark_buffer_dirty(sbi->s_bh2);
+	sb->s_dirt = 1;
+}
+
+
+/* ialloc.c */
+extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
+			struct buffer_head **);
+extern struct inode * sysv_new_inode(const struct inode *, mode_t);
+extern void sysv_free_inode(struct inode *);
+extern unsigned long sysv_count_free_inodes(struct super_block *);
+
+/* balloc.c */
+extern u32 sysv_new_block(struct super_block *);
+extern void sysv_free_block(struct super_block *, u32);
+extern unsigned long sysv_count_free_blocks(struct super_block *);
+
+/* itree.c */
+extern void sysv_truncate(struct inode *);
+
+/* inode.c */
+extern void sysv_write_inode(struct inode *, int);
+extern int sysv_sync_inode(struct inode *);
+extern int sysv_sync_file(struct file *, struct dentry *, int);
+extern void sysv_set_inode(struct inode *, dev_t);
+
+/* dir.c */
+extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
+extern int sysv_add_link(struct dentry *, struct inode *);
+extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
+extern int sysv_make_empty(struct inode *, struct inode *);
+extern int sysv_empty_dir(struct inode *);
+extern void sysv_set_link(struct sysv_dir_entry *, struct page *,
+			struct inode *);
+extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
+extern ino_t sysv_inode_by_name(struct dentry *);
+
+
+extern struct inode_operations sysv_file_inode_operations;
+extern struct inode_operations sysv_dir_inode_operations;
+extern struct inode_operations sysv_fast_symlink_inode_operations;
+extern struct file_operations sysv_file_operations;
+extern struct file_operations sysv_dir_operations;
+extern struct address_space_operations sysv_aops;
+extern struct super_operations sysv_sops;
+extern struct dentry_operations sysv_dentry_operations;
+
+
+enum {
+	BYTESEX_LE,
+	BYTESEX_PDP,
+	BYTESEX_BE,
+};
+
+static inline u32 PDP_swab(u32 x)
+{
+#ifdef __LITTLE_ENDIAN
+	return ((x & 0xffff) << 16) | ((x & 0xffff0000) >> 16);
+#else
+#ifdef __BIG_ENDIAN
+	return ((x & 0xff00ff) << 8) | ((x & 0xff00ff00) >> 8);
+#else
+#error BYTESEX
+#endif
+#endif
+}
+
+static inline u32 fs32_to_cpu(struct sysv_sb_info *sbi, u32 n)
+{
+	if (sbi->s_bytesex == BYTESEX_PDP)
+		return PDP_swab(n);
+	else if (sbi->s_bytesex == BYTESEX_LE)
+		return le32_to_cpu(n);
+	else
+		return be32_to_cpu(n);
+}
+
+static inline u32 cpu_to_fs32(struct sysv_sb_info *sbi, u32 n)
+{
+	if (sbi->s_bytesex == BYTESEX_PDP)
+		return PDP_swab(n);
+	else if (sbi->s_bytesex == BYTESEX_LE)
+		return cpu_to_le32(n);
+	else
+		return cpu_to_be32(n);
+}
+
+static inline u32 fs32_add(struct sysv_sb_info *sbi, u32 *n, int d)
+{
+	if (sbi->s_bytesex == BYTESEX_PDP)
+		return *n = PDP_swab(PDP_swab(*n)+d);
+	else if (sbi->s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le32(le32_to_cpu(*n)+d);
+	else
+		return *n = cpu_to_be32(be32_to_cpu(*n)+d);
+}
+
+static inline u16 fs16_to_cpu(struct sysv_sb_info *sbi, u16 n)
+{
+	if (sbi->s_bytesex != BYTESEX_BE)
+		return le16_to_cpu(n);
+	else
+		return be16_to_cpu(n);
+}
+
+static inline u16 cpu_to_fs16(struct sysv_sb_info *sbi, u16 n)
+{
+	if (sbi->s_bytesex != BYTESEX_BE)
+		return cpu_to_le16(n);
+	else
+		return cpu_to_be16(n);
+}
+
+static inline u16 fs16_add(struct sysv_sb_info *sbi, u16 *n, int d)
+{
+	if (sbi->s_bytesex != BYTESEX_BE)
+		return *n = cpu_to_le16(le16_to_cpu(*n)+d);
+	else
+		return *n = cpu_to_be16(be16_to_cpu(*n)+d);
+}
+
+#endif /* _SYSV_H */
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Mon Apr 29 13:12:01 2002
+++ b/include/linux/fs.h	Mon Apr 29 13:12:01 2002
@@ -679,7 +679,6 @@
 
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
-#include <linux/sysv_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
@@ -723,7 +722,6 @@
 	union {
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
-		struct sysv_sb_info	sysv_sb;
 		struct ufs_sb_info	ufs_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct adfs_sb_info	adfs_sb;
diff -Nru a/include/linux/sysv_fs.h b/include/linux/sysv_fs.h
--- a/include/linux/sysv_fs.h	Mon Apr 29 13:12:01 2002
+++ b/include/linux/sysv_fs.h	Mon Apr 29 13:12:01 2002
@@ -1,69 +1,21 @@
 #ifndef _LINUX_SYSV_FS_H
 #define _LINUX_SYSV_FS_H
 
-/*
- * The SystemV/Coherent filesystem constants/structures/macros
- */
-
-
-/* This code assumes
-   - sizeof(short) = 2, sizeof(int) = 4, sizeof(long) = 4,
-   - alignof(short) = 2, alignof(long) = 4.
-*/
-
-#ifdef __GNUC__
-#define __packed2__  __attribute__ ((packed, aligned(2)))
+#if defined(__GNUC__)
+# define __packed2__	__attribute__((packed, aligned(2)))
 #else
-#error I want gcc!
+>> I want to scream! <<
 #endif
 
-#include <linux/stat.h>		/* declares S_IFLNK etc. */
-#include <linux/sched.h>	/* declares wake_up() */
-#include <linux/sysv_fs_sb.h>	/* defines the sv_... shortcuts */
-
-/* temporary hack. */
-#include <linux/sysv_fs_i.h>
-static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
-{
-	/* I think list_entry should have a more descriptive name..  --hch */
-	return list_entry(inode, struct sysv_inode_info, vfs_inode);
-}
-/* end temporary hack. */
-
-
-/* Layout on disk */
-/* ============== */
-
-static inline u32 PDP_swab(u32 x)
-{
-#ifdef __LITTLE_ENDIAN
-	return ((x & 0xffff) << 16) | ((x & 0xffff0000) >> 16);
-#else
-#ifdef __BIG_ENDIAN
-	return ((x & 0xff00ff) << 8) | ((x & 0xff00ff00) >> 8);
-#else
-#error BYTESEX
-#endif
-#endif
-}
 
 /* inode numbers are 16 bit */
-
 typedef u16 sysv_ino_t;
 
 /* Block numbers are 24 bit, sometimes stored in 32 bit.
    On Coherent FS, they are always stored in PDP-11 manner: the least
-   significant 16 bits come last.
-*/
-
+   significant 16 bits come last. */
 typedef u32 sysv_zone_t;
 
-/* Among the blocks ... */
-/* Xenix FS, Coherent FS: block 0 is the boot block, block 1 the super-block.
-   SystemV FS: block 0 contains both the boot sector and the super-block. */
-/* The first inode zone is sb->sv_firstinodezone (1 or 2). */
-
-/* Among the inodes ... */
 /* 0 is non-existent */
 #define SYSV_BADBL_INO	1	/* inode of bad blocks file */
 #define SYSV_ROOT_INO	2	/* inode of root directory */
@@ -101,7 +53,8 @@
 								
 };
 
-/* SystemV FS comes in two variants:
+/*
+ * SystemV FS comes in two variants:
  * sysv2: System V Release 2 (e.g. Microport), structure elements aligned(2).
  * sysv4: System V Release 4 (e.g. Consensys), structure elements aligned(4).
  */
@@ -223,51 +176,21 @@
 };
 
 /* SystemV/Coherent inode data on disk */
-
 struct sysv_inode {
 	u16 i_mode;
 	u16 i_nlink;
 	u16 i_uid;
 	u16 i_gid;
 	u32 i_size;
-	union { /* directories, regular files, ... */
-		unsigned char i_addb[3*(10+1+1+1)+1]; /* zone numbers: max. 10 data blocks,
-					      * then 1 indirection block,
-					      * then 1 double indirection block,
-					      * then 1 triple indirection block.
-					      * Then maybe a "file generation number" ??
-					      */
-		/* named pipes on Coherent */
-		struct {
-			char p_addp[30];
-			s16 p_pnc;
-			s16 p_prx;
-			s16 p_pwx;
-		} i_p;
-	} i_a;
+	u8  i_data[3*(10+1+1+1)];
+	u8  i_gen;
 	u32 i_atime;	/* time of last access */
 	u32 i_mtime;	/* time of last modification */
 	u32 i_ctime;	/* time of creation */
 };
 
-/* Admissible values for i_nlink: 0.._LINK_MAX */
-enum {
-	XENIX_LINK_MAX	=	126,	/* ?? */
-	SYSV_LINK_MAX	=	126,	/* 127? 251? */
-	V7_LINK_MAX     =	126,	/* ?? */
-	COH_LINK_MAX	=	10000,
-};
-
-/* The number of inodes per block is
-   sb->sv_inodes_per_block = block_size / sizeof(struct sysv_inode) */
-/* The number of indirect pointers per block is
-   sb->sv_ind_per_block = block_size / sizeof(u32) */
-
-
 /* SystemV/Coherent directory entry on disk */
-
 #define SYSV_NAMELEN	14	/* max size of name in struct sysv_dir_entry */
-
 struct sysv_dir_entry {
 	sysv_ino_t inode;
 	char name[SYSV_NAMELEN]; /* up to 14 characters, the rest are zeroes */
@@ -275,137 +198,4 @@
 
 #define SYSV_DIRSIZE	sizeof(struct sysv_dir_entry)	/* size of every directory entry */
 
-
-/* Operations */
-/* ========== */
-
-/* identify the FS in memory */
-enum {
-	FSTYPE_NONE = 0,
-	FSTYPE_XENIX,
-	FSTYPE_SYSV4,
-	FSTYPE_SYSV2,
-	FSTYPE_COH,
-	FSTYPE_V7,
-	FSTYPE_AFS,
-	FSTYPE_END,
-};
-
-#define SYSV_MAGIC_BASE		0x012FF7B3
-
-#define XENIX_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_XENIX)
-#define SYSV4_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV4)
-#define SYSV2_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV2)
-#define COH_SUPER_MAGIC		(SYSV_MAGIC_BASE+FSTYPE_COH)
-
-#ifdef __KERNEL__
-
-enum {
-	BYTESEX_LE,
-	BYTESEX_PDP,
-	BYTESEX_BE,
-};
-
-/*
- * Function prototypes
- */
-
-extern struct inode * sysv_new_inode(const struct inode *, mode_t);
-extern void sysv_free_inode(struct inode *);
-extern unsigned long sysv_count_free_inodes(struct super_block *);
-extern u32 sysv_new_block(struct super_block *);
-extern void sysv_free_block(struct super_block *, u32);
-extern unsigned long sysv_count_free_blocks(struct super_block *);
-
-extern void sysv_truncate(struct inode *);
-
-extern void sysv_write_inode(struct inode *, int);
-extern int sysv_sync_inode(struct inode *);
-extern int sysv_sync_file(struct file *, struct dentry *, int);
-extern void sysv_set_inode(struct inode *, dev_t);
-
-extern struct sysv_dir_entry *sysv_find_entry(struct dentry*, struct page**);
-extern int sysv_add_link(struct dentry*, struct inode*);
-extern int sysv_delete_entry(struct sysv_dir_entry*, struct page*);
-extern int sysv_make_empty(struct inode*, struct inode*);
-extern int sysv_empty_dir(struct inode*);
-extern void sysv_set_link(struct sysv_dir_entry*, struct page*, struct inode*);
-extern struct sysv_dir_entry *sysv_dotdot(struct inode*, struct page**);
-extern ino_t sysv_inode_by_name(struct dentry*);
-
-extern struct inode_operations sysv_file_inode_operations;
-extern struct inode_operations sysv_dir_inode_operations;
-extern struct inode_operations sysv_fast_symlink_inode_operations;
-extern struct file_operations sysv_file_operations;
-extern struct file_operations sysv_dir_operations;
-extern struct address_space_operations sysv_aops;
-extern struct super_operations sysv_sops;
-extern struct dentry_operations sysv_dentry_operations;
-
-extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned, struct buffer_head **);
-
-static inline void dirty_sb(struct super_block *sb)
-{
-	mark_buffer_dirty(sb->sv_bh1);
-	if (sb->sv_bh1 != sb->sv_bh2)
-		mark_buffer_dirty(sb->sv_bh2);
-	sb->s_dirt = 1;
-}
-
-static inline u32 fs32_to_cpu(struct super_block *sb, u32 n)
-{
-	if (sb->sv_bytesex == BYTESEX_PDP)
-		return PDP_swab(n);
-	else if (sb->sv_bytesex == BYTESEX_LE)
-		return le32_to_cpu(n);
-	else
-		return be32_to_cpu(n);
-}
-
-static inline u32 cpu_to_fs32(struct super_block *sb, u32 n)
-{
-	if (sb->sv_bytesex == BYTESEX_PDP)
-		return PDP_swab(n);
-	else if (sb->sv_bytesex == BYTESEX_LE)
-		return cpu_to_le32(n);
-	else
-		return cpu_to_be32(n);
-}
-
-static inline u32 fs32_add(struct super_block *sb, u32 *n, int d)
-{
-	if (sb->sv_bytesex == BYTESEX_PDP)
-		return *n = PDP_swab(PDP_swab(*n)+d);
-	else if (sb->sv_bytesex == BYTESEX_LE)
-		return *n = cpu_to_le32(le32_to_cpu(*n)+d);
-	else
-		return *n = cpu_to_be32(be32_to_cpu(*n)+d);
-}
-
-static inline u16 fs16_to_cpu(struct super_block *sb, u16 n)
-{
-	if (sb->sv_bytesex != BYTESEX_BE)
-		return le16_to_cpu(n);
-	else
-		return be16_to_cpu(n);
-}
-
-static inline u16 cpu_to_fs16(struct super_block *sb, u16 n)
-{
-	if (sb->sv_bytesex != BYTESEX_BE)
-		return cpu_to_le16(n);
-	else
-		return cpu_to_be16(n);
-}
-
-static inline u16 fs16_add(struct super_block *sb, u16 *n, int d)
-{
-	if (sb->sv_bytesex != BYTESEX_BE)
-		return *n = cpu_to_le16(le16_to_cpu(*n)+d);
-	else
-		return *n = cpu_to_be16(be16_to_cpu(*n)+d);
-}
-
-#endif /* __KERNEL__ */
-
-#endif
+#endif /* _LINUX_SYSV_FS_H */
diff -Nru a/include/linux/sysv_fs_i.h b/include/linux/sysv_fs_i.h
--- a/include/linux/sysv_fs_i.h	Mon Apr 29 13:12:01 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,18 +0,0 @@
-#ifndef _SYSV_FS_I
-#define _SYSV_FS_I
-
-/*
- * SystemV/V7/Coherent FS inode data in memory
- */
-struct sysv_inode_info {
-	u32 i_data[10+1+1+1];	/* zone numbers: max. 10 data blocks,
-				 * then 1 indirection block,
-				 * then 1 double indirection block,
-				 * then 1 triple indirection block.
-				 */
-	u32 i_dir_start_lookup;
-	struct inode  vfs_inode;
-};
-
-#endif
-
diff -Nru a/include/linux/sysv_fs_sb.h b/include/linux/sysv_fs_sb.h
--- a/include/linux/sysv_fs_sb.h	Mon Apr 29 13:12:01 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,89 +0,0 @@
-#ifndef _SYSV_FS_SB
-#define _SYSV_FS_SB
-
-/*
- * SystemV/V7/Coherent super-block data in memory
- * The SystemV/V7/Coherent superblock contains dynamic data (it gets modified
- * while the system is running). This is in contrast to the Minix and Berkeley
- * filesystems (where the superblock is never modified). This affects the
- * sync() operation: we must keep the superblock in a disk buffer and use this
- * one as our "working copy".
- */
-
-struct sysv_sb_info {
-	int	       s_type;		/* file system type: FSTYPE_{XENIX|SYSV|COH} */
-	char	       s_bytesex;	/* bytesex (le/be/pdp) */
-	char	       s_truncate;	/* if 1: names > SYSV_NAMELEN chars are truncated */
-					/* if 0: they are disallowed (ENAMETOOLONG) */
-	nlink_t        s_link_max;	/* max number of hard links to a file */
-	unsigned int   s_inodes_per_block;	/* number of inodes per block */
-	unsigned int   s_inodes_per_block_1;	/* inodes_per_block - 1 */
-	unsigned int   s_inodes_per_block_bits;	/* log2(inodes_per_block) */
-	unsigned int   s_ind_per_block;		/* number of indirections per block */
-	unsigned int   s_ind_per_block_bits;	/* log2(ind_per_block) */
-	unsigned int   s_ind_per_block_2;	/* ind_per_block ^ 2 */
-	unsigned int   s_toobig_block;		/* 10 + ipb + ipb^2 + ipb^3 */
-	unsigned int   s_block_base;	/* physical block number of block 0 */
-	unsigned short s_fic_size;	/* free inode cache size, NICINOD */
-	unsigned short s_flc_size;	/* free block list chunk size, NICFREE */
-	/* The superblock is kept in one or two disk buffers: */
-	struct buffer_head *s_bh1;
-	struct buffer_head *s_bh2;
-	/* These are pointers into the disk buffer, to compensate for
-	   different superblock layout. */
-	char *         s_sbd1;		/* entire superblock data, for part 1 */
-	char *         s_sbd2;		/* entire superblock data, for part 2 */
-	u16            *s_sb_fic_count;	/* pointer to s_sbd->s_ninode */
-        u16            *s_sb_fic_inodes; /* pointer to s_sbd->s_inode */
-	u16            *s_sb_total_free_inodes; /* pointer to s_sbd->s_tinode */
-	u16            *s_bcache_count;	/* pointer to s_sbd->s_nfree */
-	u32	       *s_bcache;	/* pointer to s_sbd->s_free */
-	u32            *s_free_blocks;	/* pointer to s_sbd->s_tfree */
-	u32            *s_sb_time;	/* pointer to s_sbd->s_time */
-	u32            *s_sb_state;	/* pointer to s_sbd->s_state, only FSTYPE_SYSV */
-	/* We keep those superblock entities that don't change here;
-	   this saves us an indirection and perhaps a conversion. */
-	u32            s_firstinodezone; /* index of first inode zone */
-	u32            s_firstdatazone;	/* same as s_sbd->s_isize */
-	u32            s_ninodes;	/* total number of inodes */
-	u32            s_ndatazones;	/* total number of data zones */
-	u32            s_nzones;	/* same as s_sbd->s_fsize */
-	u16	       s_namelen;       /* max length of dir entry */
-};
-/* The field s_toobig_block is currently unused. */
-
-/* sv_ == u.sysv_sb.s_ */
-#define sv_type					u.sysv_sb.s_type
-#define sv_bytesex				u.sysv_sb.s_bytesex
-#define sv_truncate				u.sysv_sb.s_truncate
-#define sv_link_max				u.sysv_sb.s_link_max
-#define sv_inodes_per_block			u.sysv_sb.s_inodes_per_block
-#define sv_inodes_per_block_1			u.sysv_sb.s_inodes_per_block_1
-#define sv_inodes_per_block_bits		u.sysv_sb.s_inodes_per_block_bits
-#define sv_ind_per_block			u.sysv_sb.s_ind_per_block
-#define sv_ind_per_block_bits			u.sysv_sb.s_ind_per_block_bits
-#define sv_ind_per_block_2			u.sysv_sb.s_ind_per_block_2
-#define sv_toobig_block				u.sysv_sb.s_toobig_block
-#define sv_block_base				u.sysv_sb.s_block_base
-#define sv_fic_size				u.sysv_sb.s_fic_size
-#define sv_flc_size				u.sysv_sb.s_flc_size
-#define sv_bh1					u.sysv_sb.s_bh1
-#define sv_bh2					u.sysv_sb.s_bh2
-#define sv_sbd1					u.sysv_sb.s_sbd1
-#define sv_sbd2					u.sysv_sb.s_sbd2
-#define sv_sb_fic_count				u.sysv_sb.s_sb_fic_count
-#define sv_sb_fic_inodes			u.sysv_sb.s_sb_fic_inodes
-#define sv_sb_total_free_inodes			u.sysv_sb.s_sb_total_free_inodes
-#define sv_bcache_count				u.sysv_sb.s_bcache_count
-#define sv_bcache				u.sysv_sb.s_bcache
-#define sv_free_blocks				u.sysv_sb.s_free_blocks
-#define sv_sb_time				u.sysv_sb.s_sb_time
-#define sv_sb_state				u.sysv_sb.s_sb_state
-#define sv_firstinodezone			u.sysv_sb.s_firstinodezone
-#define sv_firstdatazone			u.sysv_sb.s_firstdatazone
-#define sv_ninodes				u.sysv_sb.s_ninodes
-#define sv_ndatazones				u.sysv_sb.s_ndatazones
-#define sv_nzones				u.sysv_sb.s_nzones
-#define sv_namelen                              u.sysv_sb.s_namelen
-
-#endif

===================================================================


This BitKeeper patch contains the following changesets:
1.547..1.548
## Wrapped with gzip_uu ##


begin 664 bkpatch9031
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
5%ZNK5V(ZP42SP]W_`@?&QZ/SSP``
`
end
