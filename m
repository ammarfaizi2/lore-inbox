Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVDVHUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVDVHUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVDVHUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:20:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:47237 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262002AbVDVHUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:20:34 -0400
Date: Fri, 22 Apr 2005 09:20:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] squashfs: (void*)ify read_blocklist
Message-ID: <20050422072037.GB10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050421011126.GD29755@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c            |   16 ++++++++++------
 include/linux/squashfs_fs_sb.h |    6 +++---
 2 files changed, 13 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc3cow/fs/squashfs/inode.c~squashfs_cu5	2005-04-22 07:00:14.806604672 +0200
+++ linux-2.6.12-rc3cow/fs/squashfs/inode.c	2005-04-22 09:17:47.387021752 +0200
@@ -58,7 +58,7 @@ static struct dentry *squashfs_lookup(st
 				struct nameidata *);
 static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode);
 static unsigned int read_blocklist(struct inode *inode, int index,
-				int readahead_blks, char *block_list,
+				int readahead_blks, void *block_list,
 				unsigned short **block_p, unsigned int *bsize);
 static struct super_block *squashfs_get_sb(struct file_system_type *, int,
 				const char *, void *);
@@ -1116,7 +1116,7 @@ skip_read:
 #define SIZE 256
 
 static unsigned int read_blocklist(struct inode *inode, int index,
-				int readahead_blks, char *block_list,
+				int readahead_blks, void *_block_list,
 				unsigned short **block_p, unsigned int *bsize)
 {
 	squashfs_sb_info *msBlk = inode->i_sb->s_fs_info;
@@ -1125,6 +1125,7 @@ static unsigned int read_blocklist(struc
 	int block_ptr = SQUASHFS_I(inode)->block_list_start;
 	int offset = SQUASHFS_I(inode)->offset;
 	unsigned int block = SQUASHFS_I(inode)->start_block;
+	unsigned int *block_list = _block_list;
 
 	for (;;) {
 		int blocks = (index + readahead_blks - i);
@@ -1136,7 +1137,9 @@ static unsigned int read_blocklist(struc
 		}
 
 		if (msBlk->swap) {
-			unsigned char sblock_list[SIZE];
+			unsigned int *sblock_list = kmalloc(SIZE, GFP_KERNEL);
+			if (!sblock_list)
+				return 0;
 
 			if (!squashfs_get_cached_block(inode->i_sb,
 					sblock_list, block_ptr,
@@ -1144,10 +1147,11 @@ static unsigned int read_blocklist(struc
 					&offset)) {
 				ERROR("Unable to read block list [%d:%x]\n",
 					block_ptr, offset);
+				kfree(sblock_list);
 				return 0;
 			}
-			SQUASHFS_SWAP_INTS(((unsigned int *)block_list),
-					((unsigned int *)sblock_list), blocks);
+			SQUASHFS_SWAP_INTS(block_list, sblock_list, blocks);
+			kfree(sblock_list);
 		} else
 			if (!squashfs_get_cached_block(inode->i_sb,
 					block_list, block_ptr, offset,
@@ -1158,7 +1162,7 @@ static unsigned int read_blocklist(struc
 				return 0;
 			}
 
-		for (block_listp = (unsigned int *) block_list; i < index &&
+		for (block_listp = block_list; i < index &&
 					blocks; i ++, block_listp ++, blocks --)
 			block += SQUASHFS_COMPRESSED_SIZE_BLOCK(*block_listp);
 
--- linux-2.6.12-rc3cow/include/linux/squashfs_fs_sb.h~squashfs_cu5	2005-04-22 07:00:14.693621848 +0200
+++ linux-2.6.12-rc3cow/include/linux/squashfs_fs_sb.h	2005-04-22 09:17:43.833561960 +0200
@@ -59,10 +59,10 @@ typedef struct squashfs_sb_info {
 	struct semaphore	fragment_mutex;
 	wait_queue_head_t	waitq;
 	wait_queue_head_t	fragment_wait_queue;
-	struct inode		*(*iget)(struct super_block *s, squashfs_inode \
+	struct inode		*(*iget)(struct super_block *s, squashfs_inode
 				inode);
-	unsigned int		(*read_blocklist)(struct inode *inode, int \
-				index, int readahead_blks, char *block_list, \
+	unsigned int		(*read_blocklist)(struct inode *inode, int
+				index, int readahead_blks, void *block_list,
 				unsigned short **block_p, unsigned int *bsize);
 	} squashfs_sb_info;
 #endif
