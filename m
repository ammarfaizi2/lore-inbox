Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWEYMpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWEYMpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWEYMpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:45:05 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:59338 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965141AbWEYMpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:45:03 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][5/24]ext3 modify format strings
Message-Id: <20060525214455sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:44:55 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [5/24]  modify format strings in print(ext3)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:30:41.543692519 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:31:14.558340552 +0900
@@ -1406,15 +1406,15 @@ allocated:
 			}
 		}
 	}
-	ext3_debug("found bit %d\n", group_allocated_blk);
+	ext3_debug("found bit %u\n", group_allocated_blk);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block(%lu) >= blocks count(%d) - "
-			    "block_group = %d, es == %p ", ret_block,
+			    "block(%lu) >= blocks count(%u) - "
+			    "block_group = %u, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/inode.c linux-2.6.17-rc4.tmp/fs/ext3/inode.c
--- linux-2.6.17-rc4/fs/ext3/inode.c	2006-05-25 16:30:19.455802165 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/inode.c	2006-05-25 16:31:14.560293677 +0900
@@ -2113,7 +2113,7 @@ static void ext3_free_branches(handle_t 
 			 */
 			if (!bh) {
 				ext3_error(inode->i_sb, "ext3_free_branches",
-					   "Read failure, inode=%ld, block=%ld",
+					   "Read failure, inode=%lu, block=%lu",
 					   inode->i_ino, nr);
 				continue;
 			}
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/namei.c linux-2.6.17-rc4.tmp/fs/ext3/namei.c
--- linux-2.6.17-rc4/fs/ext3/namei.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/namei.c	2006-05-25 16:31:14.562246802 +0900
@@ -1910,8 +1910,8 @@ int ext3_orphan_add(handle_t *handle, st
 	if (!err)
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 
-	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %ld will point to %d\n",
+	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
+	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out_unlock:
 	unlock_super(sb);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/resize.c linux-2.6.17-rc4.tmp/fs/ext3/resize.c
--- linux-2.6.17-rc4/fs/ext3/resize.c	2006-05-25 16:30:41.544669082 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/resize.c	2006-05-25 16:31:14.562246802 +0900
@@ -45,7 +45,7 @@ static int verify_group_input(struct sup
 
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT3-fs: adding %s group %u: %u blocks "
-		       "(%d free, %u reserved)\n",
+		       "(%lld free, %u reserved)\n",
 		       ext3_bg_has_super(sb, input->group) ? "normal" :
 		       "no-super", input->group, input->blocks_count,
 		       free_blocks_count, input->reserved_blocks);
@@ -145,7 +145,7 @@ static void mark_bitmap_end(int start_bi
 	if (start_bit >= end_bit)
 		return;
 
-	ext3_debug("mark end bits +%d through +%d used\n", start_bit, end_bit);
+	ext3_debug("mark end bits +%u through +%u used\n", start_bit, end_bit);
 	for (i = start_bit; i < ((start_bit + 7) & ~7UL); i++)
 		ext3_set_bit(i, bitmap);
 	if (i < end_bit)
@@ -340,7 +340,7 @@ static int verify_reserved_gdb(struct su
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
 		if (le32_to_cpu(*p++) != grp * EXT3_BLOCKS_PER_GROUP(sb) + blk){
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved GDT %ld missing grp %d (%ld)",
+				     "reserved GDT %lu missing grp %d (%lu)",
 				     blk, grp,
 				     grp * EXT3_BLOCKS_PER_GROUP(sb) + blk);
 			return -EINVAL;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/super.c linux-2.6.17-rc4.tmp/fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c	2006-05-25 16:30:41.546622207 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/super.c	2006-05-25 16:31:14.564199927 +0900
@@ -377,7 +377,7 @@ static void dump_orphan_list(struct supe
 	list_for_each(l, &sbi->s_orphan) {
 		struct inode *inode = orphan_list_entry(l);
 		printk(KERN_ERR "  "
-		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
+		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
 		       inode->i_sb->s_id, inode->i_ino, inode,
 		       inode->i_mode, inode->i_nlink, 
 		       NEXT_ORPHAN(inode));
@@ -1254,17 +1254,17 @@ static void ext3_orphan_cleanup (struct 
 		DQUOT_INIT(inode);
 		if (inode->i_nlink) {
 			printk(KERN_DEBUG
-				"%s: truncating inode %ld to %Ld bytes\n",
+				"%s: truncating inode %lu to %Ld bytes\n",
 				__FUNCTION__, inode->i_ino, inode->i_size);
-			jbd_debug(2, "truncating inode %ld to %Ld bytes\n",
+			jbd_debug(2, "truncating inode %lu to %Ld bytes\n",
 				  inode->i_ino, inode->i_size);
 			ext3_truncate(inode);
 			nr_truncates++;
 		} else {
 			printk(KERN_DEBUG
-				"%s: deleting unreferenced inode %ld\n",
+				"%s: deleting unreferenced inode %lu\n",
 				__FUNCTION__, inode->i_ino);
-			jbd_debug(2, "deleting unreferenced inode %ld\n",
+			jbd_debug(2, "deleting unreferenced inode %lu\n",
 				  inode->i_ino);
 			nr_orphans++;
 		}
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/xattr.c linux-2.6.17-rc4.tmp/fs/ext3/xattr.c
--- linux-2.6.17-rc4/fs/ext3/xattr.c	2006-05-25 16:30:19.457755290 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/xattr.c	2006-05-25 16:31:14.565176490 +0900
@@ -75,7 +75,7 @@
 
 #ifdef EXT3_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
 			inode->i_sb->s_id, inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
@@ -233,7 +233,7 @@ ext3_xattr_block_get(struct inode *inode
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %u", inode->i_ino,
+			   "inode %lu: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -375,7 +375,7 @@ ext3_xattr_block_list(struct inode *inod
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %u", inode->i_ino,
+			   "inode %lu: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block %u", inode->i_ino,
+				"inode %lu: bad block %u", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -847,7 +847,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block %u", inode->i_ino,
+		   "inode %lu: bad block %u", inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1076,14 +1076,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block %u read error", inode->i_ino,
+			"inode %lu: block %u read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block %u", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -1210,11 +1210,11 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext3_error(inode->i_sb, __FUNCTION__,
-				"inode %ld: block %ld read error",
+				"inode %lu: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else if (le32_to_cpu(BHDR(bh)->h_refcount) >=
 				EXT3_XATTR_REFCOUNT_MAX) {
-			ea_idebug(inode, "block %ld refcount %d>=%d",
+			ea_idebug(inode, "block %lu refcount %d>=%d",
 				  (unsigned long) ce->e_block,
 				  le32_to_cpu(BHDR(bh)->h_refcount),
 					  EXT3_XATTR_REFCOUNT_MAX);



