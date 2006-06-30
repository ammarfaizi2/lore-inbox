Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWF3GkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWF3GkU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWF3GkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:40:19 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:65022 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751181AbWF3GkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:40:17 -0400
To: jitendra@linsyssoft.com, adilger@clusterfs.com, cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC][PATCH 3/3] add ext2_fileblk_t for file offset
Message-Id: <20060630154007sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 30 Jun 2006 15:40:07 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/3] ext2_fileblk_t.patch
This patch converts ext2 file offset to ext2_fileblk_t.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
---
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/ext2.h linux-2.6.17.tmp/fs/ext2/ext2.h
--- linux-2.6.17/fs/ext2/ext2.h	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/ext2.h	2006-06-29 21:27:31.000000000 +0900
@@ -38,7 +38,7 @@ struct ext2_inode_info {
 	 * most-recently-allocated block in this file.  Yes, it is misnamed.
 	 * We use this for detecting linearly ascending allocation requests.
 	 */
-	__u32	i_next_alloc_block;
+	ext2_fileblk_t	i_next_alloc_block;
 
 	/*
 	 * i_next_alloc_goal is the *physical* companion to i_next_alloc_block.
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/inode.c linux-2.6.17.tmp/fs/ext2/inode.c
--- linux-2.6.17/fs/ext2/inode.c	2006-06-29 21:27:18.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/inode.c	2006-06-29 21:27:31.000000000 +0900
@@ -194,7 +194,7 @@ static inline int verify_chain(Indirect 
  */
 
 static int ext2_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			ext2_fileblk_t i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT2_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -363,7 +363,7 @@ static unsigned long ext2_find_near(stru
  */
 
 static inline int ext2_find_goal(struct inode *inode,
-				 long block,
+				 ext2_fileblk_t block,
 				 Indirect chain[4],
 				 Indirect *partial,
 				 ext2_fsblk_t *goal)
@@ -489,7 +489,7 @@ static int ext2_alloc_branch(struct inod
  */
 
 static inline int ext2_splice_branch(struct inode *inode,
-				     long block,
+				     ext2_fileblk_t block,
 				     Indirect chain[4],
 				     Indirect *where,
 				     int num)
@@ -905,7 +905,7 @@ void ext2_truncate (struct inode * inode
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long iblock;
+	ext2_fileblk_t iblock;
 	unsigned blocksize;
 
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/super.c linux-2.6.17.tmp/fs/ext2/super.c
--- linux-2.6.17/fs/ext2/super.c	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/super.c	2006-06-29 21:27:31.000000000 +0900
@@ -1104,7 +1104,7 @@ static ssize_t ext2_quota_read(struct su
 			       size_t len, loff_t off)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
+	ext2_fileblk_t blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
 	int err = 0;
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
@@ -1148,7 +1148,7 @@ static ssize_t ext2_quota_write(struct s
 				const char *data, size_t len, loff_t off)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
+	ext2_fileblk_t blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
 	int err = 0;
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/include/linux/ext2_fs_sb.h linux-2.6.17.tmp/include/linux/ext2_fs_sb.h
--- linux-2.6.17/include/linux/ext2_fs_sb.h	2006-06-29 21:27:18.000000000 +0900
+++ linux-2.6.17.tmp/include/linux/ext2_fs_sb.h	2006-06-29 21:27:31.000000000 +0900
@@ -21,6 +21,7 @@
 
 typedef unsigned long ext2_fsblk_t;
 typedef long ext2_grpblk_t;
+typedef unsigned long ext2_fileblk_t;
 
 /*
  * second extended-fs super-block data in memory

