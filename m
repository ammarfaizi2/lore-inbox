Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVAMKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVAMKlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAMKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:41:07 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:60054 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261551AbVAMKkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:53 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 8/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.984071@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hide ext3_get_inode_loc in_mem option

The in_mem optimization in ext3_get_inode_loc avoids a disk read when
only the requested inode in the block group is allocated: In that case
ext3_get_inode_loc assumes that it can recreate the inode from the
in-memory inode. This is incorrect with in-inode extended attributes,
which don't have a shadow copy in memory. Hide the in_mem option and
clarify comments; the subsequent ea-in-inode changes the in_mem check as
required.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.10.orig/include/linux/ext3_fs.h
+++ linux-2.6.10/include/linux/ext3_fs.h
@@ -764,6 +764,7 @@ extern int  ext3_sync_inode (handle_t *,
 extern void ext3_discard_reservation (struct inode *);
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
+extern int ext3_get_inode_loc(struct inode *, struct ext3_iloc *);
 extern void ext3_truncate (struct inode *);
 extern void ext3_set_inode_flags(struct inode *);
 extern void ext3_set_aops(struct inode *inode);
Index: linux-2.6.10/fs/ext3/inode.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/inode.c
+++ linux-2.6.10/fs/ext3/inode.c
@@ -2269,13 +2269,13 @@ static unsigned long ext3_get_inode_bloc
 	return block;
 }
 
-/* 
+/*
  * ext3_get_inode_loc returns with an extra refcount against the inode's
- * underlying buffer_head on success.  If `in_mem' is false then we're purely
- * trying to determine the inode's location on-disk and no read need be
- * performed.
+ * underlying buffer_head on success. If 'in_mem' is true, we have all
+ * data in memory that is needed to recreate the on-disk version of this
+ * inode.
  */
-static int ext3_get_inode_loc(struct inode *inode,
+static int __ext3_get_inode_loc(struct inode *inode,
 				struct ext3_iloc *iloc, int in_mem)
 {
 	unsigned long block;
@@ -2300,7 +2300,11 @@ static int ext3_get_inode_loc(struct ino
 			goto has_buffer;
 		}
 
-		/* we can't skip I/O if inode is on a disk only */
+		/*
+		 * If we have all information of the inode in memory and this
+		 * is the only valid inode in the block, we need not read the
+		 * block.
+		 */
 		if (in_mem) {
 			struct buffer_head *bitmap_bh;
 			struct ext3_group_desc *desc;
@@ -2309,10 +2313,6 @@ static int ext3_get_inode_loc(struct ino
 			int block_group;
 			int start;
 
-			/*
-			 * If this is the only valid inode in the block we
-			 * need not read the block.
-			 */
 			block_group = (inode->i_ino - 1) /
 					EXT3_INODES_PER_GROUP(inode->i_sb);
 			inodes_per_buffer = bh->b_size /
@@ -2359,8 +2359,9 @@ static int ext3_get_inode_loc(struct ino
 
 make_io:
 		/*
-		 * There are another valid inodes in the buffer so we must
-		 * read the block from disk
+		 * There are other valid inodes in the buffer, this inode
+		 * has in-inode xattrs, or we don't have this inode in memory.
+		 * Read the block from disk.
 		 */
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
@@ -2380,6 +2381,11 @@ has_buffer:
 	return 0;
 }
 
+int ext3_get_inode_loc(struct inode *inode, struct ext3_iloc *iloc)
+{
+	return __ext3_get_inode_loc(inode, iloc, 1);
+}
+
 void ext3_set_inode_flags(struct inode *inode)
 {
 	unsigned int flags = EXT3_I(inode)->i_flags;
@@ -2411,7 +2417,7 @@ void ext3_read_inode(struct inode * inod
 #endif
 	ei->i_rsv_window.rsv_end = EXT3_RESERVE_WINDOW_NOT_ALLOCATED;
 
-	if (ext3_get_inode_loc(inode, &iloc, 0))
+	if (__ext3_get_inode_loc(inode, &iloc, 0))
 		goto bad_inode;
 	bh = iloc.bh;
 	raw_inode = ext3_raw_inode(&iloc);
@@ -2848,7 +2854,7 @@ ext3_reserve_inode_write(handle_t *handl
 {
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, iloc, 1);
+		err = ext3_get_inode_loc(inode, iloc);
 		if (!err) {
 			BUFFER_TRACE(iloc->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle, iloc->bh);
@@ -2947,7 +2953,7 @@ ext3_pin_inode(handle_t *handle, struct 
 
 	int err = 0;
 	if (handle) {
-		err = ext3_get_inode_loc(inode, &iloc, 1);
+		err = ext3_get_inode_loc(inode, &iloc);
 		if (!err) {
 			BUFFER_TRACE(iloc.bh, "get_write_access");
 			err = journal_get_write_access(handle, iloc.bh);
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

