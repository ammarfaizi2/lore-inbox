Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVKGRlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVKGRlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVKGRlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:41:49 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:50185 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964856AbVKGRlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:41:47 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] fat: support ->direct_IO()
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:41:39 +0900
In-Reply-To: <874q6otl0q.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:39:33 +0900")
Message-ID: <87zmogs6cs.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add to support of ->direct_IO() for mostly read.

The user of this seems to want to use for streaming read.  So, current
direct I/O has limitation, it can only overwrite.
(For write operation, mainly we need to handle the hole etc..)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c           |   14 ++++++--
 fs/fat/dir.c             |    6 +--
 fs/fat/inode.c           |   82 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/msdos_fs.h |    3 +
 4 files changed, 89 insertions(+), 16 deletions(-)

diff -puN fs/fat/cache.c~fat_direct-io fs/fat/cache.c
--- linux-2.6.14/fs/fat/cache.c~fat_direct-io	2005-11-07 03:58:58.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/cache.c	2005-11-07 03:58:58.000000000 +0900
@@ -295,7 +295,8 @@ static int fat_bmap_cluster(struct inode
 	return dclus;
 }
 
-int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys)
+int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
+	     unsigned long *mapped_blocks)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -303,9 +304,12 @@ int fat_bmap(struct inode *inode, sector
 	int cluster, offset;
 
 	*phys = 0;
+	*mapped_blocks = 0;
 	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
-		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits))
+		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits)) {
 			*phys = sector + sbi->dir_start;
+			*mapped_blocks = 1;
+		}
 		return 0;
 	}
 	last_block = (MSDOS_I(inode)->mmu_private + (sb->s_blocksize - 1))
@@ -318,7 +322,11 @@ int fat_bmap(struct inode *inode, sector
 	cluster = fat_bmap_cluster(inode, cluster);
 	if (cluster < 0)
 		return cluster;
-	else if (cluster)
+	else if (cluster) {
 		*phys = fat_clus_to_blknr(sbi, cluster) + offset;
+		*mapped_blocks = sbi->sec_per_clus - offset;
+		if (*mapped_blocks > last_block - sector)
+			*mapped_blocks = last_block - sector;
+	}
 	return 0;
 }
diff -puN fs/fat/dir.c~fat_direct-io fs/fat/dir.c
--- linux-2.6.14/fs/fat/dir.c~fat_direct-io	2005-11-07 03:58:58.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/dir.c	2005-11-07 03:58:58.000000000 +0900
@@ -68,8 +68,8 @@ static int fat__get_entry(struct inode *
 {
 	struct super_block *sb = dir->i_sb;
 	sector_t phys, iblock;
-	int offset;
-	int err;
+	unsigned long mapped_blocks;
+	int err, offset;
 
 next:
 	if (*bh)
@@ -77,7 +77,7 @@ next:
 
 	*bh = NULL;
 	iblock = *pos >> sb->s_blocksize_bits;
-	err = fat_bmap(dir, iblock, &phys);
+	err = fat_bmap(dir, iblock, &phys, &mapped_blocks);
 	if (err || !phys)
 		return -1;	/* beyond EOF or error */
 
diff -puN fs/fat/inode.c~fat_direct-io fs/fat/inode.c
--- linux-2.6.14/fs/fat/inode.c~fat_direct-io	2005-11-07 03:58:58.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/inode.c	2005-11-07 03:58:58.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/vfs.h>
 #include <linux/parser.h>
+#include <linux/uio.h>
 #include <asm/unaligned.h>
 
 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
@@ -49,43 +50,77 @@ static int fat_add_cluster(struct inode 
 	return err;
 }
 
-static int fat_get_block(struct inode *inode, sector_t iblock,
-			 struct buffer_head *bh_result, int create)
+static int __fat_get_blocks(struct inode *inode, sector_t iblock,
+			    unsigned long *max_blocks,
+			    struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	sector_t phys;
-	int err;
+	unsigned long mapped_blocks;
+	int err, offset;
 
-	err = fat_bmap(inode, iblock, &phys);
+	err = fat_bmap(inode, iblock, &phys, &mapped_blocks);
 	if (err)
 		return err;
 	if (phys) {
 		map_bh(bh_result, sb, phys);
+		*max_blocks = min(mapped_blocks, *max_blocks);
 		return 0;
 	}
 	if (!create)
 		return 0;
+
 	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		fat_fs_panic(sb, "corrupted file size (i_pos %lld, %lld)",
 			     MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
 		return -EIO;
 	}
-	if (!((unsigned long)iblock & (MSDOS_SB(sb)->sec_per_clus - 1))) {
+
+	offset = (unsigned long)iblock & (sbi->sec_per_clus - 1);
+	if (!offset) {
+		/* TODO: multiple cluster allocation would be desirable. */
 		err = fat_add_cluster(inode);
 		if (err)
 			return err;
 	}
-	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
-	err = fat_bmap(inode, iblock, &phys);
+	/* available blocks on this cluster */
+	mapped_blocks = sbi->sec_per_clus - offset;
+
+	*max_blocks = min(mapped_blocks, *max_blocks);
+	MSDOS_I(inode)->mmu_private += *max_blocks << sb->s_blocksize_bits;
+
+	err = fat_bmap(inode, iblock, &phys, &mapped_blocks);
 	if (err)
 		return err;
-	if (!phys)
-		BUG();
+	BUG_ON(!phys);
+	BUG_ON(*max_blocks != mapped_blocks);
 	set_buffer_new(bh_result);
 	map_bh(bh_result, sb, phys);
 	return 0;
 }
 
+static int fat_get_blocks(struct inode *inode, sector_t iblock,
+			  unsigned long max_blocks,
+			  struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = inode->i_sb;
+	int err;
+
+	err = __fat_get_blocks(inode, iblock, &max_blocks, bh_result, create);
+	if (err)
+		return err;
+	bh_result->b_size = max_blocks << sb->s_blocksize_bits;
+	return 0;
+}
+
+static int fat_get_block(struct inode *inode, sector_t iblock,
+			 struct buffer_head *bh_result, int create)
+{
+	unsigned long max_blocks = 1;
+	return __fat_get_blocks(inode, iblock, &max_blocks, bh_result, create);
+}
+
 static int fat_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, fat_get_block, wbc);
@@ -128,6 +163,34 @@ static int fat_commit_write(struct file 
 	return err;
 }
 
+static ssize_t fat_direct_IO(int rw, struct kiocb *iocb,
+			     const struct iovec *iov,
+			     loff_t offset, unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+
+	if (rw == WRITE) {
+		/*
+		 * FIXME: blockdev_direct_IO() doesn't use ->prepare_write(),
+		 * so we need to update the ->mmu_private to block boundary.
+		 *
+		 * But we must fill the remaining area or hole by nul for
+		 * updating ->mmu_private.
+		 */
+		loff_t size = offset + iov_length(iov, nr_segs);
+		if (MSDOS_I(inode)->mmu_private < size)
+			return -EINVAL;
+	}
+
+	/*
+	 * FAT need to use the DIO_LOCKING for avoiding the race
+	 * condition of fat_get_block() and ->truncate().
+	 */
+	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
+				  offset, nr_segs, fat_get_blocks, NULL);
+}
+
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, fat_get_block);
@@ -141,6 +204,7 @@ static struct address_space_operations f
 	.sync_page	= block_sync_page,
 	.prepare_write	= fat_prepare_write,
 	.commit_write	= fat_commit_write,
+	.direct_IO	= fat_direct_IO,
 	.bmap		= _fat_bmap
 };
 
diff -puN include/linux/msdos_fs.h~fat_direct-io include/linux/msdos_fs.h
--- linux-2.6.14/include/linux/msdos_fs.h~fat_direct-io	2005-11-07 03:58:58.000000000 +0900
+++ linux-2.6.14-hirofumi/include/linux/msdos_fs.h	2005-11-07 03:58:58.000000000 +0900
@@ -329,7 +329,8 @@ static inline void fatwchar_to16(__u8 *d
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
 			   int *fclus, int *dclus);
-extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
+extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
+		    unsigned long *mapped_blocks);
 
 /* fat/dir.c */
 extern struct file_operations fat_dir_operations;
_
