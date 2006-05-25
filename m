Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWEYMp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWEYMp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWEYMp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:45:28 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:15563 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965142AbWEYMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:45:26 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][6/24]ext2 modify format strings
Message-Id: <20060525214518sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:45:18 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [6/24]  modify format strings in print(ext2)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/balloc.c linux-2.6.17-rc4.tmp/fs/ext2/balloc.c
--- linux-2.6.17-rc4/fs/ext2/balloc.c	2006-05-25 16:31:09.390371866 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/balloc.c	2006-05-25 16:31:43.581777697 +0900
@@ -465,7 +465,7 @@ got_block:
 
 	if (target_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_new_block",
-			    "block(%d) >= blocks count(%d) - "
+			    "block(%d) >= blocks count(%u) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto io_error;
@@ -504,7 +504,7 @@ got_block:
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	ext2_debug ("allocating block %d. ", block);
+	ext2_debug ("allocating block %u. ", block);
 
 	*err = 0;
 out_release:
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/inode.c linux-2.6.17-rc4.tmp/fs/ext2/inode.c
--- linux-2.6.17-rc4/fs/ext2/inode.c	2006-05-25 16:18:35.844482659 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/inode.c	2006-05-25 16:31:43.582754259 +0900
@@ -880,7 +880,7 @@ static void ext2_free_branches(struct in
 			 */ 
 			if (!bh) {
 				ext2_error(inode->i_sb, "ext2_free_branches",
-					"Read failure, inode=%ld, block=%ld",
+					"Read failure, inode=%lu, block=%lu",
 					inode->i_ino, nr);
 				continue;
 			}
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/xattr.c linux-2.6.17-rc4.tmp/fs/ext2/xattr.c
--- linux-2.6.17-rc4/fs/ext2/xattr.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/xattr.c	2006-05-25 16:31:43.583730822 +0900
@@ -71,7 +71,7 @@
 
 #ifdef EXT2_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
 			inode->i_sb->s_id, inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
@@ -164,7 +164,7 @@ ext2_xattr_get(struct inode *inode, int 
 	error = -ENODATA;
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT2_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -175,7 +175,7 @@ ext2_xattr_get(struct inode *inode, int 
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -264,7 +264,7 @@ ext2_xattr_list(struct inode *inode, cha
 	error = 0;
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT2_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -275,7 +275,7 @@ ext2_xattr_list(struct inode *inode, cha
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -411,7 +411,7 @@ ext2_xattr_set(struct inode *inode, int 
 		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 		    header->h_blocks != cpu_to_le32(1)) {
 bad_block:		ext2_error(sb, "ext2_xattr_set",
-				"inode %ld: bad block %d", inode->i_ino, 
+				"inode %lu: bad block %u", inode->i_ino, 
 				   EXT2_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -672,7 +672,7 @@ ext2_xattr_set2(struct inode *inode, str
 						   NULL, NULL, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %u", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
@@ -772,7 +772,7 @@ ext2_xattr_delete_inode(struct inode *in
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	if (!bh) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %lu: block %u read error", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -780,7 +780,7 @@ ext2_xattr_delete_inode(struct inode *in
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -931,13 +931,13 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
-				"inode %ld: block %ld read error",
+				"inode %lu: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else {
 			lock_buffer(bh);
 			if (le32_to_cpu(HDR(bh)->h_refcount) >
 				   EXT2_XATTR_REFCOUNT_MAX) {
-				ea_idebug(inode, "block %ld refcount %d>%d",
+				ea_idebug(inode, "block %lu refcount %d>%d",
 					  (unsigned long) ce->e_block,
 					  le32_to_cpu(HDR(bh)->h_refcount),
 					  EXT2_XATTR_REFCOUNT_MAX);



