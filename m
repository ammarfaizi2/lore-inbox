Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSF2Pju>; Sat, 29 Jun 2002 11:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSF2Pjt>; Sat, 29 Jun 2002 11:39:49 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:65290 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S312973AbSF2Pjr>; Sat, 29 Jun 2002 11:39:47 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add 4G-1 file support to FAT32
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 30 Jun 2002 00:41:49 +0900
Message-ID: <87d6ua3xdu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch changes cont_prepare_write(), in order to support a large
file.

 int cont_prepare_write(struct page *page, unsigned offset,
-		unsigned to, get_block_t *get_block, unsigned long *bytes)
+		unsigned to, get_block_t *get_block, loff_t *bytes)

And it adds 4G-1 file support to FAT32.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.24/fs/buffer.c fat_big-file-2.5.24/fs/buffer.c
--- linux-2.5.24/fs/buffer.c	Sun Jun 23 15:43:09 2002
+++ fat_big-file-2.5.24/fs/buffer.c	Sun Jun 23 15:31:44 2002
@@ -1930,7 +1930,7 @@
  */
 
 int cont_prepare_write(struct page *page, unsigned offset,
-		unsigned to, get_block_t *get_block, unsigned long *bytes)
+		unsigned to, get_block_t *get_block, loff_t *bytes)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
diff -urN linux-2.5.24/fs/fat/file.c fat_big-file-2.5.24/fs/fat/file.c
--- linux-2.5.24/fs/fat/file.c	Sun Jun 23 15:43:10 2002
+++ fat_big-file-2.5.24/fs/fat/file.c	Sun Jun 23 15:31:45 2002
@@ -54,7 +54,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
 		BUG();
 		return -EIO;
 	}
diff -urN linux-2.5.24/fs/fat/inode.c fat_big-file-2.5.24/fs/fat/inode.c
--- linux-2.5.24/fs/fat/inode.c	Sun Jun 23 15:43:10 2002
+++ fat_big-file-2.5.24/fs/fat/inode.c	Sun Jun 23 15:31:45 2002
@@ -417,7 +417,7 @@
 	}
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -775,6 +775,8 @@
 		sbi->fat_length = CF_LE_L(b->fat32_length);
 		sbi->root_cluster = CF_LE_L(b->root_cluster);
 
+		sb->s_maxbytes = 0xffffffff;
+		
 		/* MC - if info_sector is 0, don't multiply by 0 */
 		sbi->fsinfo_sector = CF_LE_W(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
@@ -1063,7 +1065,7 @@
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) >> 9;
+			   & ~((loff_t)inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
diff -urN linux-2.5.24/include/linux/buffer_head.h fat_big-file-2.5.24/include/linux/buffer_head.h
--- linux-2.5.24/include/linux/buffer_head.h	Sun Jun 23 15:43:30 2002
+++ fat_big-file-2.5.24/include/linux/buffer_head.h	Sun Jun 23 15:32:04 2002
@@ -180,7 +180,7 @@
 int block_read_full_page(struct page*, get_block_t*);
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
+				loff_t *);
 int generic_cont_expand(struct inode *inode, loff_t size) ;
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_sync_page(struct page *);
diff -urN linux-2.5.24/include/linux/msdos_fs_i.h fat_big-file-2.5.24/include/linux/msdos_fs_i.h
--- linux-2.5.24/include/linux/msdos_fs_i.h	Sun Jun 23 15:43:31 2002
+++ fat_big-file-2.5.24/include/linux/msdos_fs_i.h	Sun Jun 23 15:32:06 2002
@@ -8,7 +8,7 @@
  */
 
 struct msdos_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
