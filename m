Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUJ3SLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUJ3SLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUJ3SKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:10:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261241AbUJ3SHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:07:34 -0400
Date: Sat, 30 Oct 2004 20:07:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: al@alarsen.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] QNX4 cleanups
Message-ID: <20041030180702.GT4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in the QNX4 fs:
- remove two unused global functions
- make some functions static


diffstat output:
 fs/qnx4/bitmap.c        |   58 ----------------------------------------
 fs/qnx4/inode.c         |    6 ++--
 include/linux/qnx4_fs.h |    4 --
 3 files changed, 4 insertions(+), 64 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/include/linux/qnx4_fs.h.old	2004-10-30 14:53:54.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/include/linux/qnx4_fs.h	2004-10-30 15:01:34.000000000 +0200
@@ -114,15 +114,12 @@
 extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
 extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
 
-extern struct buffer_head *qnx4_getblk(struct inode *, int, int);
 extern struct buffer_head *qnx4_bread(struct inode *, int, int);
 
 extern struct inode_operations qnx4_file_inode_operations;
 extern struct inode_operations qnx4_dir_inode_operations;
 extern struct file_operations qnx4_file_operations;
 extern struct file_operations qnx4_dir_operations;
-extern int qnx4_is_free(struct super_block *sb, long block);
-extern int qnx4_set_bitmap(struct super_block *sb, long block, int busy);
 extern int qnx4_create(struct inode *inode, struct dentry *dentry, int mode, struct nameidata *nd);
 extern void qnx4_truncate(struct inode *inode);
 extern void qnx4_free_inode(struct inode *inode);
@@ -130,7 +127,6 @@
 extern int qnx4_rmdir(struct inode *dir, struct dentry *dentry);
 extern int qnx4_sync_file(struct file *file, struct dentry *dentry, int);
 extern int qnx4_sync_inode(struct inode *inode);
-extern int qnx4_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh, int create);
 
 static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
 {
--- linux-2.6.10-rc1-mm2-full/fs/qnx4/inode.c.old	2004-10-30 14:58:16.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/qnx4/inode.c	2004-10-30 15:01:28.000000000 +0200
@@ -162,7 +162,7 @@
 	return 0;
 }
 
-struct buffer_head *qnx4_getblk(struct inode *inode, int nr,
+static struct buffer_head *qnx4_getblk(struct inode *inode, int nr,
 				 int create)
 {
 	struct buffer_head *result = NULL;
@@ -212,7 +212,7 @@
 	return NULL;
 }
 
-int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
+static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
 {
 	unsigned long phys;
 
@@ -447,7 +447,7 @@
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
-struct address_space_operations qnx4_aops = {
+static struct address_space_operations qnx4_aops = {
 	.readpage	= qnx4_readpage,
 	.writepage	= qnx4_writepage,
 	.sync_page	= block_sync_page,
--- linux-2.6.10-rc1-mm2-full/fs/qnx4/bitmap.c.old	2004-10-30 14:49:21.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/qnx4/bitmap.c	2004-10-30 14:57:34.000000000 +0200
@@ -28,7 +28,7 @@
 	return 0;
 }
 
-void count_bits(register const char *bmPart, register int size,
+static void count_bits(register const char *bmPart, register int size,
 		int *const tf)
 {
 	char b;
@@ -85,62 +85,6 @@
 
 #ifdef CONFIG_QNX4FS_RW
 
-int qnx4_is_free(struct super_block *sb, long block)
-{
-	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
-	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
-	struct buffer_head *bh;
-	const char *g;
-	int ret = -EIO;
-
-	start += block / (QNX4_BLOCK_SIZE * 8);
-	QNX4DEBUG(("qnx4: is_free requesting block [%lu], bitmap in block [%lu]\n",
-		   (unsigned long) block, (unsigned long) start));
-	(void) size;		/* CHECKME */
-	bh = sb_bread(sb, start);
-	if (bh == NULL) {
-		return -EIO;
-	}
-	g = bh->b_data + (block % QNX4_BLOCK_SIZE);
-	if (((*g) & (1 << (block % 8))) == 0) {
-		QNX4DEBUG(("qnx4: is_free -> block is free\n"));
-		ret = 1;
-	} else {
-		QNX4DEBUG(("qnx4: is_free -> block is busy\n"));
-		ret = 0;
-	}
-	brelse(bh);
-
-	return ret;
-}
-
-int qnx4_set_bitmap(struct super_block *sb, long block, int busy)
-{
-	int start = le32_to_cpu(qnx4_sb(sb)->BitMap->di_first_xtnt.xtnt_blk) - 1;
-	int size = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size);
-	struct buffer_head *bh;
-	char *g;
-
-	start += block / (QNX4_BLOCK_SIZE * 8);
-	QNX4DEBUG(("qnx4: set_bitmap requesting block [%lu], bitmap in block [%lu]\n",
-		   (unsigned long) block, (unsigned long) start));
-	(void) size;		/* CHECKME */
-	bh = sb_bread(sb, start);
-	if (bh == NULL) {
-		return -EIO;
-	}
-	g = bh->b_data + (block % QNX4_BLOCK_SIZE);
-	if (busy == 0) {
-		(*g) &= ~(1 << (block % 8));
-	} else {
-		(*g) |= (1 << (block % 8));
-	}
-	mark_buffer_dirty(bh);
-	brelse(bh);
-
-	return 0;
-}
-
 static void qnx4_clear_inode(struct inode *inode)
 {
 	struct qnx4_inode_entry *qnx4_ino = qnx4_raw_inode(inode);

