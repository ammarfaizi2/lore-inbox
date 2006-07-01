Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWGARRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWGARRT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWGARRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:17:19 -0400
Received: from mail.parknet.jp ([210.171.160.80]:4623 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932383AbWGARRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:17:18 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat: cleanup fat_get_block(s)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Jul 2006 02:17:13 +0900
Message-ID: <87odw9jld2.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_blocks() was removed. So, this removes it on fat, and will take
advantage of the multi block mapping.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff -puN fs/fat/inode.c~fat-get_block-cleanup fs/fat/inode.c
--- linux-2.6/fs/fat/inode.c~fat-get_block-cleanup	2006-06-29 22:43:48.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/inode.c	2006-06-29 22:43:48.000000000 +0900
@@ -50,14 +50,14 @@ static int fat_add_cluster(struct inode 
 	return err;
 }
 
-static int __fat_get_blocks(struct inode *inode, sector_t iblock,
-			    unsigned long *max_blocks,
-			    struct buffer_head *bh_result, int create)
+static inline int __fat_get_block(struct inode *inode, sector_t iblock,
+				  unsigned long *max_blocks,
+				  struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	sector_t phys;
 	unsigned long mapped_blocks;
+	sector_t phys;
 	int err, offset;
 
 	err = fat_bmap(inode, iblock, &phys, &mapped_blocks);
@@ -73,7 +73,7 @@ static int __fat_get_blocks(struct inode
 
 	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		fat_fs_panic(sb, "corrupted file size (i_pos %lld, %lld)",
-			     MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
+			MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
 		return -EIO;
 	}
 
@@ -93,34 +93,29 @@ static int __fat_get_blocks(struct inode
 	err = fat_bmap(inode, iblock, &phys, &mapped_blocks);
 	if (err)
 		return err;
+
 	BUG_ON(!phys);
 	BUG_ON(*max_blocks != mapped_blocks);
 	set_buffer_new(bh_result);
 	map_bh(bh_result, sb, phys);
+
 	return 0;
 }
 
-static int fat_get_blocks(struct inode *inode, sector_t iblock,
-			  struct buffer_head *bh_result, int create)
+static int fat_get_block(struct inode *inode, sector_t iblock,
+			 struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
-	int err;
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
+	int err;
 
-	err = __fat_get_blocks(inode, iblock, &max_blocks, bh_result, create);
+	err = __fat_get_block(inode, iblock, &max_blocks, bh_result, create);
 	if (err)
 		return err;
 	bh_result->b_size = max_blocks << sb->s_blocksize_bits;
 	return 0;
 }
 
-static int fat_get_block(struct inode *inode, sector_t iblock,
-			 struct buffer_head *bh_result, int create)
-{
-	unsigned long max_blocks = 1;
-	return __fat_get_blocks(inode, iblock, &max_blocks, bh_result, create);
-}
-
 static int fat_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, fat_get_block, wbc);
@@ -188,7 +183,7 @@ static ssize_t fat_direct_IO(int rw, str
 	 * condition of fat_get_block() and ->truncate().
 	 */
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
-				  offset, nr_segs, fat_get_blocks, NULL);
+				  offset, nr_segs, fat_get_block, NULL);
 }
 
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
_
