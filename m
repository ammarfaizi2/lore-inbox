Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSESTln>; Sun, 19 May 2002 15:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSESTkQ>; Sun, 19 May 2002 15:40:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315048AbSESTkA>;
	Sun, 19 May 2002 15:40:00 -0400
Message-ID: <3CE80068.997D5CD4@zip.com.au>
Date: Sun, 19 May 2002 12:43:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/15] ext2: preread inode backing blocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When ext2 creates a new inode, perform an asynchronous preread against
its backing block.

Without this patch, many-file writeout gets stalled by having to read
many individual inode table blocks in the middle of writeback.

It's worth about a 20% gain in writeback bandwidth for the many-file
writeback case.

ext3 already reads the inode's backing block in
ext3_new_inode->ext3_mark_inode_dirty, so no change is needed there.

A backport to 2.4 would make sense.


=====================================

--- 2.5.16/fs/ext2/ialloc.c~tuning-20-ext2-preread-inode	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/ext2/ialloc.c	Sun May 19 11:49:49 2002
@@ -218,6 +218,44 @@ error_return:
 }
 
 /*
+ * We perform asynchronous prereading of the new inode's inode block when
+ * we create the inode, in the expectation that the inode will be written
+ * back soon.  There are two reasons:
+ *
+ * - When creating a large number of files, the async prereads will be
+ *   nicely merged into large reads
+ * - When writing out a large number of inodes, we don't need to keep on
+ *   stalling the writes while we read the inode block.
+ *
+ * FIXME: ext2_get_group_desc() needs to be simplified.
+ */
+static void ext2_preread_inode(struct inode *inode)
+{
+	unsigned long block_group;
+	unsigned long offset;
+	unsigned long block;
+	struct buffer_head *bh;
+	struct ext2_group_desc * gdp;
+
+	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
+	gdp = ext2_get_group_desc(inode->i_sb, block_group, &bh);
+	if (gdp == NULL)
+		return;
+
+	/*
+	 * Figure out the offset within the block group inode table
+	 */
+	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
+				EXT2_INODE_SIZE(inode->i_sb);
+	block = le32_to_cpu(gdp->bg_inode_table) +
+				(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
+	bh = sb_getblk(inode->i_sb, block);
+	if (!buffer_uptodate(bh) && !buffer_locked(bh))
+		ll_rw_block(READA, 1, &bh);
+	__brelse(bh);
+}
+
+/*
  * There are two policies for allocating an inode.  If the new inode is
  * a directory, then a forward search is made for a block group with both
  * free space and a low directory-to-inode ratio; if that fails, then of
@@ -417,6 +455,7 @@ repeat:
 		return ERR_PTR(-EDQUOT);
 	}
 	ext2_debug ("allocating inode %lu\n", inode->i_ino);
+	ext2_preread_inode(inode);
 	return inode;
 
 fail2:


-
