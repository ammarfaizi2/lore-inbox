Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVAMKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVAMKlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAMKlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:41:39 -0500
Received: from ns.suse.de ([195.135.220.2]:59798 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261550AbVAMKkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:53 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 4/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.844811@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext3: do not use journal_release_buffer

The use of journal_release_buffer is unsafe; it can overflow the
journal: When a buffer is stolen from a transaction and later removed
from that transaction with journal_release_buffer, the buffer is not
accounted to the transaction that now "owns" the buffer, and one extra
credit appears to be available.  Don't use journal_release_buffer:

We did rely on the buffer lock to synchronize xattr block accesses, and
get write access to the buffer first to get atomicity.  Return the
mb_cache_entry from ext3_xattr_cache_find instead, and do the
check/update under its lock. Only get write access when we know we will
use the buffer.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -94,9 +94,9 @@ static int ext3_xattr_set_handle2(handle
 				  struct ext3_xattr_header *);
 
 static int ext3_xattr_cache_insert(struct buffer_head *);
-static struct buffer_head *ext3_xattr_cache_find(handle_t *, struct inode *,
+static struct buffer_head *ext3_xattr_cache_find(struct inode *,
 						 struct ext3_xattr_header *,
-						 int *);
+						 struct mb_cache_entry **);
 static void ext3_xattr_rehash(struct ext3_xattr_header *,
 			      struct ext3_xattr_entry *);
 
@@ -500,33 +500,24 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 
 	if (header) {
 		struct mb_cache_entry *ce;
-		int credits = 0;
 
 		/* assert(header == HDR(bh)); */
-		if (header->h_refcount != cpu_to_le32(1))
-			goto skip_get_write_access;
-		/* ext3_journal_get_write_access() requires an unlocked bh,
-		   which complicates things here. */
-		error = ext3_journal_get_write_access_credits(handle, bh,
-							      &credits);
-		if (error)
-			goto cleanup;
 		ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev,
 					bh->b_blocknr);
-		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
 			if (ce)
 				mb_cache_entry_free(ce);
 			ea_bdebug(bh, "modifying in-place");
+			error = ext3_journal_get_write_access(handle, bh);
+			if (error)
+				goto cleanup;
+			lock_buffer(bh);
 			/* keep the buffer locked while modifying it. */
 		} else {
 			int offset;
 
 			if (ce)
 				mb_cache_entry_release(ce);
-			unlock_buffer(bh);
-			journal_release_buffer(handle, bh, credits);
-		skip_get_write_access:
 			ea_bdebug(bh, "cloning");
 			header = kmalloc(bh->b_size, GFP_KERNEL);
 			error = -ENOMEM;
@@ -622,17 +613,18 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 	}
 
 skip_replace:
-	if (IS_LAST_ENTRY(ENTRY(header+1))) {
-		/* This block is now empty. */
-		if (bh && header == HDR(bh))
-			unlock_buffer(bh);  /* we were modifying in-place. */
-		error = ext3_xattr_set_handle2(handle, inode, bh, NULL);
-	} else {
+	if (!IS_LAST_ENTRY(ENTRY(header+1)))
 		ext3_xattr_rehash(header, here);
-		if (bh && header == HDR(bh))
-			unlock_buffer(bh);  /* we were modifying in-place. */
-		error = ext3_xattr_set_handle2(handle, inode, bh, header);
+	if (bh && header == HDR(bh)) {
+		/* we were modifying in-place. */
+		unlock_buffer(bh);
+		error = ext3_journal_dirty_metadata(handle, bh);
+		if (error)
+			goto cleanup;
 	}
+	error = ext3_xattr_set_handle2(handle, inode, bh,
+				       IS_LAST_ENTRY(ENTRY(header+1)) ?
+				       NULL : header);
 
 cleanup:
 	brelse(bh);
@@ -653,10 +645,11 @@ ext3_xattr_set_handle2(handle_t *handle,
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *new_bh = NULL;
-	int credits = 0, error;
+	struct mb_cache_entry *ce = NULL;
+	int error;
 
 	if (header) {
-		new_bh = ext3_xattr_cache_find(handle, inode, header, &credits);
+		new_bh = ext3_xattr_cache_find(inode, header, &ce);
 		if (new_bh) {
 			/* We found an identical block in the cache. */
 			if (new_bh == old_bh)
@@ -667,19 +660,26 @@ ext3_xattr_set_handle2(handle_t *handle,
 				ea_bdebug(new_bh, "reusing block");
 
 				error = -EDQUOT;
-				if (DQUOT_ALLOC_BLOCK(inode, 1)) {
-					unlock_buffer(new_bh);
-					journal_release_buffer(handle, new_bh,
-							       credits);
+				if (DQUOT_ALLOC_BLOCK(inode, 1))
 					goto cleanup;
-				}
+				error = ext3_journal_get_write_access(handle, new_bh);
+				if (error)
+					goto cleanup;
+				lock_buffer(new_bh);
 				HDR(new_bh)->h_refcount = cpu_to_le32(1 +
 					le32_to_cpu(HDR(new_bh)->h_refcount));
 				ea_bdebug(new_bh, "refcount now=%d",
 					le32_to_cpu(HDR(new_bh)->h_refcount));
+				unlock_buffer(new_bh);
+				error = ext3_journal_dirty_metadata(handle, new_bh);
+				if (error)
+					goto cleanup;
 			}
-			unlock_buffer(new_bh);
+			mb_cache_entry_release(ce);
+			ce = NULL;
 		} else if (old_bh && header == HDR(old_bh)) {
+			/* We were modifying this block in-place. */
+
 			/* Keep this block. No need to lock the block as we
 			 * don't need to change the reference count. */
 			new_bh = old_bh;
@@ -715,10 +715,10 @@ getblk_failed:
 			ext3_xattr_cache_insert(new_bh);
 
 			ext3_xattr_update_super_block(handle, sb);
+			error = ext3_journal_dirty_metadata(handle, new_bh);
+			if (error)
+				goto cleanup;
 		}
-		error = ext3_journal_dirty_metadata(handle, new_bh);
-		if (error)
-			goto cleanup;
 	}
 
 	/* Update the inode. */
@@ -730,22 +730,14 @@ getblk_failed:
 
 	error = 0;
 	if (old_bh && old_bh != new_bh) {
-		struct mb_cache_entry *ce;
-
 		/*
 		 * If there was an old block, and we are no longer using it,
 		 * release the old block.
 		*/
-		error = ext3_journal_get_write_access(handle, old_bh);
-		if (error)
-			goto cleanup;
 		ce = mb_cache_entry_get(ext3_xattr_cache, old_bh->b_bdev,
 					old_bh->b_blocknr);
-		lock_buffer(old_bh);
 		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
 			/* Free the old block. */
-			if (ce)
-				mb_cache_entry_free(ce);
 			ea_bdebug(old_bh, "freeing");
 			ext3_free_blocks(handle, inode, old_bh->b_blocknr, 1);
 
@@ -754,21 +746,29 @@ getblk_failed:
 			   duplicate the handle before. */
 			get_bh(old_bh);
 			ext3_forget(handle, 1, inode, old_bh,old_bh->b_blocknr);
+			if (ce) {
+				mb_cache_entry_free(ce);
+				ce = NULL;
+			}
 		} else {
+			error = ext3_journal_get_write_access(handle, old_bh);
+			if (error)
+				goto cleanup;
 			/* Decrement the refcount only. */
+			lock_buffer(old_bh);
 			HDR(old_bh)->h_refcount = cpu_to_le32(
 				le32_to_cpu(HDR(old_bh)->h_refcount) - 1);
-			if (ce)
-				mb_cache_entry_release(ce);
 			DQUOT_FREE_BLOCK(inode, 1);
 			ext3_journal_dirty_metadata(handle, old_bh);
 			ea_bdebug(old_bh, "refcount now=%d",
 				le32_to_cpu(HDR(old_bh)->h_refcount));
+			unlock_buffer(old_bh);
 		}
-		unlock_buffer(old_bh);
 	}
 
 cleanup:
+	if (ce)
+		mb_cache_entry_release(ce);
 	brelse(new_bh);
 
 	return error;
@@ -819,7 +819,7 @@ void
 ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
 {
 	struct buffer_head *bh = NULL;
-	struct mb_cache_entry *ce;
+	struct mb_cache_entry *ce = NULL;
 
 	down_write(&EXT3_I(inode)->xattr_sem);
 	if (!EXT3_I(inode)->i_file_acl)
@@ -838,31 +838,33 @@ ext3_xattr_delete_inode(handle_t *handle
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
-	if (ext3_journal_get_write_access(handle, bh) != 0)
-		goto cleanup;
 	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev, bh->b_blocknr);
-	lock_buffer(bh);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		if (ce)
+		if (ce) {
 			mb_cache_entry_free(ce);
+			ce = NULL;
+		}
 		ext3_free_blocks(handle, inode, EXT3_I(inode)->i_file_acl, 1);
 		get_bh(bh);
 		ext3_forget(handle, 1, inode, bh, EXT3_I(inode)->i_file_acl);
 	} else {
+		if (ext3_journal_get_write_access(handle, bh) != 0)
+			goto cleanup;
+		lock_buffer(bh);
 		HDR(bh)->h_refcount = cpu_to_le32(
 			le32_to_cpu(HDR(bh)->h_refcount) - 1);
-		if (ce)
-			mb_cache_entry_release(ce);
 		ext3_journal_dirty_metadata(handle, bh);
 		if (IS_SYNC(inode))
 			handle->h_sync = 1;
 		DQUOT_FREE_BLOCK(inode, 1);
+		unlock_buffer(bh);
 	}
 	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
-	unlock_buffer(bh);
 	EXT3_I(inode)->i_file_acl = 0;
 
 cleanup:
+	if (ce)
+		mb_cache_entry_release(ce);
 	brelse(bh);
 	up_write(&EXT3_I(inode)->xattr_sem);
 }
@@ -960,8 +962,8 @@ ext3_xattr_cmp(struct ext3_xattr_header 
  * not found or an error occurred.
  */
 static struct buffer_head *
-ext3_xattr_cache_find(handle_t *handle, struct inode *inode,
-		      struct ext3_xattr_header *header, int *credits)
+ext3_xattr_cache_find(struct inode *inode, struct ext3_xattr_header *header,
+		      struct mb_cache_entry **pce)
 {
 	__u32 hash = le32_to_cpu(header->h_hash);
 	struct mb_cache_entry *ce;
@@ -985,27 +987,17 @@ again:
 			ext3_error(inode->i_sb, "ext3_xattr_cache_find",
 				"inode %ld: block %ld read error",
 				inode->i_ino, (unsigned long) ce->e_block);
-		} else if (ext3_journal_get_write_access_credits(
-				handle, bh, credits) == 0) {
-			/* ext3_journal_get_write_access() requires an unlocked
-			 * bh, which complicates things here. */
-			lock_buffer(bh);
-			if (le32_to_cpu(HDR(bh)->h_refcount) >
-				   EXT3_XATTR_REFCOUNT_MAX) {
-				ea_idebug(inode, "block %ld refcount %d>%d",
-					  (unsigned long) ce->e_block,
-					  le32_to_cpu(HDR(bh)->h_refcount),
+		} else if (le32_to_cpu(HDR(bh)->h_refcount) >
+				EXT3_XATTR_REFCOUNT_MAX) {
+			ea_idebug(inode, "block %ld refcount %d>%d",
+				  (unsigned long) ce->e_block,
+				  le32_to_cpu(HDR(bh)->h_refcount),
 					  EXT3_XATTR_REFCOUNT_MAX);
-			} else if (!ext3_xattr_cmp(header, HDR(bh))) {
-				mb_cache_entry_release(ce);
-				/* buffer will be unlocked by caller */
-				return bh;
-			}
-			unlock_buffer(bh);
-			journal_release_buffer(handle, bh, *credits);
-			*credits = 0;
-			brelse(bh);
+		} else if (ext3_xattr_cmp(header, HDR(bh)) == 0) {
+			*pce = ce;
+			return bh;
 		}
+		brelse(bh);
 		ce = mb_cache_entry_find_next(ce, 0, inode->i_sb->s_bdev, hash);
 	}
 	return NULL;
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

