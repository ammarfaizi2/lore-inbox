Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266371AbTGJQdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbTGJQdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:33:33 -0400
Received: from tmi.comex.ru ([217.10.33.92]:57259 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S266371AbTGJQdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:33:09 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@osdl.org>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Thu, 10 Jul 2003 20:46:59 +0000
In-Reply-To: <20030710085155.40c78883.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Jul 2003 08:51:55 -0700")
Message-ID: <877k6qgldo.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87smpeigio.fsf@gw.home.net>
	<20030710042016.1b12113b.akpm@osdl.org> <87isqaiegy.fsf@gw.home.net>
	<20030710085155.40c78883.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:


 AM> ext3_read_inode() got reorganised.  Your latest patch will not apply to
 AM> current kernels.

OK. fixed version:



ext3_get_inode_loc() read inode's block only if:
  1) this inode has no copy in memory
  2) inode's block has another valid inode(s)

this optimization allows to avoid needless I/O in two cases:
1) just allocated inode is first valid in the inode's block
2) kernel wants to write inode, but buffer in which inode
   belongs to gets freed by VM




diff -puN fs/ext3/inode.c~ext3-noread-inode fs/ext3/inode.c
--- linux-2.5.74/fs/ext3/inode.c~ext3-noread-inode	Thu Jul 10 20:05:25 2003
+++ linux-2.5.74-alexey/fs/ext3/inode.c	Thu Jul 10 20:25:24 2003
@@ -2339,24 +2339,106 @@ static unsigned long ext3_get_inode_bloc
 /* 
  * ext3_get_inode_loc returns with an extra refcount against the
  * inode's underlying buffer_head on success. 
+ * in_mem arg enables optimization
  */
 
-int ext3_get_inode_loc (struct inode *inode, struct ext3_iloc *iloc)
+int ext3_get_inode_loc (struct inode *inode, struct ext3_iloc *iloc, int in_mem)
 {
 	unsigned long block;
-
+	struct buffer_head *bh;
+	
 	block = ext3_get_inode_block(inode->i_sb, inode->i_ino, iloc);
-	if (block) {
-		struct buffer_head *bh = sb_bread(inode->i_sb, block);
-		if (bh) {
-			iloc->bh = bh;
-			return 0;
-		}
+	if (!block)
+		return -EIO;
+
+	bh = sb_getblk(inode->i_sb, block);
+	if (!bh) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
-			    "unable to read inode block - "
-			    "inode=%lu, block=%lu", inode->i_ino, block);
+				"unable to read inode block - "
+				"inode=%lu, block=%lu", inode->i_ino, block);
+		return -EIO;
+	}
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
+			struct ext3_group_desc *desc;
+			int inodes_per_buffer;
+			int inode_offset, i;
+			int block_group;
+			int start;
+
+			/*
+			 * if this inode is only valid in buffer we need not I/O
+			 */
+			block_group = (inode->i_ino - 1) / EXT3_INODES_PER_GROUP(inode->i_sb);
+			inodes_per_buffer = bh->b_size /
+				EXT3_INODE_SIZE(inode->i_sb);
+			inode_offset = ((inode->i_ino - 1) %
+					EXT3_INODES_PER_GROUP(inode->i_sb));
+			start = inode_offset & ~(inodes_per_buffer - 1);
+
+			/* check is inode bitmap is in cache? */
+			desc = ext3_get_group_desc(inode->i_sb, block_group, NULL);
+			if (!desc)
+				goto make_io;
+
+			bitmap_bh = sb_getblk(inode->i_sb, le32_to_cpu(desc->bg_inode_bitmap));
+			if (!bitmap_bh)
+				goto make_io;
+
+			/* 
+			 * if inode bitmap isn't in cache then we may end up by 2 reads
+			 * instead of 1 read before optimizing. skip it
+			 */
+			if (!buffer_uptodate(bitmap_bh)) {
+				brelse(bitmap_bh);
+				goto make_io;
+			}
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
+make_io:
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
+			brelse(bh);
+			return -EIO;
+		}
 	}
-	return -EIO;
+has_buffer:
+	iloc->bh = bh;
+	return 0;
 }
 
 void ext3_set_inode_flags(struct inode *inode)
@@ -2389,7 +2471,7 @@ void ext3_read_inode(struct inode * inod
 	ei->i_acl = EXT3_ACL_NOT_CACHED;
 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
 #endif
-	if (ext3_get_inode_loc(inode, &iloc))
+	if (ext3_get_inode_loc(inode, &iloc, 0))
 		goto bad_inode;
 	bh = iloc.bh;
 	raw_inode = ext3_raw_inode(&iloc);
@@ -2793,7 +2875,7 @@ ext3_reserve_inode_write(handle_t *handl
 {
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, iloc);
+		err = ext3_get_inode_loc(inode, iloc, 1);
 		if (!err) {
 			BUFFER_TRACE(iloc->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle, iloc->bh);
@@ -2891,7 +2973,7 @@ ext3_pin_inode(handle_t *handle, struct 
 
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, &iloc);
+		err = ext3_get_inode_loc(inode, &iloc, 1);
 		if (!err) {
 			BUFFER_TRACE(iloc.bh, "get_write_access");
 			err = journal_get_write_access(handle, iloc.bh);
diff -puN include/linux/ext3_fs.h~ext3-noread-inode include/linux/ext3_fs.h
--- linux-2.5.74/include/linux/ext3_fs.h~ext3-noread-inode	Thu Jul 10 20:24:39 2003
+++ linux-2.5.74-alexey/include/linux/ext3_fs.h	Thu Jul 10 20:25:08 2003
@@ -721,7 +721,7 @@ extern int ext3_forget(handle_t *, int, 
 extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 
-extern int  ext3_get_inode_loc (struct inode *, struct ext3_iloc *);
+extern int  ext3_get_inode_loc (struct inode *, struct ext3_iloc *, int);
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
 extern int  ext3_setattr (struct dentry *, struct iattr *);

_




