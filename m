Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269177AbTGJKe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269178AbTGJKe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:34:59 -0400
Received: from tmi.comex.ru ([217.10.33.92]:43687 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269177AbTGJKez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:34:55 -0400
Subject: [PATCH] minor optimization for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Thu, 10 Jul 2003 14:49:03 +0000
Message-ID: <87smpeigio.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

Andreas Dilger proposed do not read inode's block during inode updating
if we have enough data to fill that block. here is the patch.


ext3_get_inode_loc() read inode's block only if:
  1) this inode has no copy in memory
  2) inode's block has another valid inode(s)

this optimization allows to avoid needless I/O in two cases:
1) just allocated inode is first in the inode's block
2) kernel wants to write inode, but buffer in which inode
   belongs to gets freed by VM




diff -puN fs/ext3/inode.c~ext3-noread-inode fs/ext3/inode.c
--- linux-2.5.73/fs/ext3/inode.c~ext3-noread-inode	Thu Jul 10 12:03:52 2003
+++ linux-2.5.73-alexey/fs/ext3/inode.c	Thu Jul 10 14:40:51 2003
@@ -2286,7 +2286,7 @@ out_stop:
  * inode's underlying buffer_head on success. 
  */
 
-int ext3_get_inode_loc (struct inode *inode, struct ext3_iloc *iloc)
+int ext3_get_inode_loc (struct inode *inode, struct ext3_iloc *iloc, int in_mem)
 {
 	struct buffer_head *bh = 0;
 	unsigned long block;
@@ -2328,12 +2328,69 @@ int ext3_get_inode_loc (struct inode *in
 		EXT3_INODE_SIZE(inode->i_sb);
 	block = le32_to_cpu(gdp[desc].bg_inode_table) +
 		(offset >> EXT3_BLOCK_SIZE_BITS(inode->i_sb));
-	if (!(bh = sb_bread(inode->i_sb, block))) {
+	if (!(bh = sb_getblk(inode->i_sb, block))) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
 			    "unable to read inode block - "
 			    "inode=%lu, block=%lu", inode->i_ino, block);
 		goto bad_inode;
 	}
+	if (!buffer_uptodate(bh)) {
+		lock_buffer(bh);
+		if (buffer_uptodate(bh)) {
+			/* someone has already initialized buffer */
+			unlock_buffer(bh);
+			goto has_buffer;
+		}
+
+		/* we can't skip I/O if inode is on a disk only */
+		if (in_mem) {
+			struct buffer_head *bitmap_bh; 
+			int inodes_per_buffer;
+			int inode_offset, i;
+			int start;
+
+			/*
+			 * if this inode is only valid in buffer we need not I/O
+			 */
+			inodes_per_buffer = bh->b_size /
+				EXT3_INODE_SIZE(inode->i_sb);
+			inode_offset = ((inode->i_ino - 1) %
+					EXT3_INODES_PER_GROUP(inode->i_sb));
+			start = inode_offset & ~(inodes_per_buffer - 1);
+			bitmap_bh = read_inode_bitmap(inode->i_sb, block_group);
+			for (i = start; i < start + inodes_per_buffer; i++) {
+				if (i == inode_offset)
+					continue;
+				if (ext3_test_bit(i, bitmap_bh->b_data))
+					break;
+			}
+			brelse(bitmap_bh);
+			if (i == start + inodes_per_buffer) {
+				/* all inodes (but our) are free. so, we skip I/O */
+				memset(bh->b_data, 0, bh->b_size);
+				set_buffer_uptodate(bh);
+				unlock_buffer(bh);
+				goto has_buffer;
+			}
+		}
+
+		/*
+		 * No, there are another valid inodes in the buffer
+		 * so, to preserve them we have to read buffer from
+		 * the disk
+		 */
+		get_bh(bh);
+		bh->b_end_io = end_buffer_io_sync;
+		submit_bh(READ, bh);
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh)) {
+			ext3_error (inode->i_sb, "ext3_get_inode_loc",
+					"unable to read inode block - "
+					"inode=%lu, block=%lu", inode->i_ino, block);
+			goto bad_inode;
+		}
+	}
+  has_buffer:
 	offset &= (EXT3_BLOCK_SIZE(inode->i_sb) - 1);
 
 	iloc->bh = bh;
@@ -2376,7 +2433,7 @@ void ext3_read_inode(struct inode * inod
 	ei->i_acl = EXT3_ACL_NOT_CACHED;
 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
 #endif
-	if (ext3_get_inode_loc(inode, &iloc))
+	if (ext3_get_inode_loc(inode, &iloc, 0))
 		goto bad_inode;
 	bh = iloc.bh;
 	raw_inode = iloc.raw_inode;
@@ -2781,7 +2838,7 @@ ext3_reserve_inode_write(handle_t *handl
 {
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, iloc);
+		err = ext3_get_inode_loc(inode, iloc, 1);
 		if (!err) {
 			BUFFER_TRACE(iloc->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle, iloc->bh);
@@ -2879,7 +2936,7 @@ ext3_pin_inode(handle_t *handle, struct 
 
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, &iloc);
+		err = ext3_get_inode_loc(inode, &iloc, 1);
 		if (!err) {
 			BUFFER_TRACE(iloc.bh, "get_write_access");
 			err = journal_get_write_access(handle, iloc.bh);
diff -puN fs/ext3/ialloc.c~ext3-noread-inode fs/ext3/ialloc.c
--- linux-2.5.73/fs/ext3/ialloc.c~ext3-noread-inode	Thu Jul 10 13:05:37 2003
+++ linux-2.5.73-alexey/fs/ext3/ialloc.c	Thu Jul 10 13:06:12 2003
@@ -50,7 +50,7 @@
  *
  * Return buffer_head of bitmap on success or NULL.
  */
-static struct buffer_head *
+struct buffer_head *
 read_inode_bitmap(struct super_block * sb, unsigned long block_group)
 {
 	struct ext3_group_desc *desc;
diff -puN include/linux/ext3_fs.h~ext3-noread-inode include/linux/ext3_fs.h
--- linux-2.5.73/include/linux/ext3_fs.h~ext3-noread-inode	Thu Jul 10 13:41:59 2003
+++ linux-2.5.73-alexey/include/linux/ext3_fs.h	Thu Jul 10 14:40:13 2003
@@ -717,6 +717,8 @@ extern unsigned long ext3_count_free_ino
 extern unsigned long ext3_count_dirs (struct super_block *);
 extern void ext3_check_inodes_bitmap (struct super_block *);
 extern unsigned long ext3_count_free (struct buffer_head *, unsigned);
+extern struct buffer_head * read_inode_bitmap(struct super_block *, unsigned long);
+
 
 
 /* inode.c */
@@ -724,7 +726,7 @@ extern int ext3_forget(handle_t *, int, 
 extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 
-extern int  ext3_get_inode_loc (struct inode *, struct ext3_iloc *);
+extern int  ext3_get_inode_loc (struct inode *, struct ext3_iloc *, int);
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
 extern int  ext3_setattr (struct dentry *, struct iattr *);

_

