Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVAMK56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVAMK56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVAMK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:57:50 -0500
Received: from ns.suse.de ([195.135.220.2]:65174 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261572AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 5/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.877501@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext3: factor our common xattr code; unnecessary lock

The ext3_xattr_set_handle2 and ext3_xattr_delete_inode functions contain
duplicate code to decrease the reference count of an xattr block. Move
this to a separate function.

Also we know we have exclusive access to the inode in
ext3_xattr_delete_inode; there is no need to grab the xattr_sem lock.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -356,6 +356,41 @@ static void ext3_xattr_update_super_bloc
 }
 
 /*
+ * Release the xattr block BH: If the reference count is > 1, decrement
+ * it; otherwise free the block.
+ */
+static void
+ext3_xattr_release_block(handle_t *handle, struct inode *inode,
+			 struct buffer_head *bh)
+{
+	struct mb_cache_entry *ce = NULL;
+
+	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev, bh->b_blocknr);
+	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
+		ea_bdebug(bh, "freeing");
+		if (ce)
+			mb_cache_entry_free(ce);
+		ext3_free_blocks(handle, inode, bh->b_blocknr, 1);
+		get_bh(bh);
+		ext3_forget(handle, 1, inode, bh, bh->b_blocknr);
+	} else {
+		if (ext3_journal_get_write_access(handle, bh) == 0) {
+			lock_buffer(bh);
+			HDR(bh)->h_refcount = cpu_to_le32(
+				le32_to_cpu(HDR(bh)->h_refcount) - 1);
+			ext3_journal_dirty_metadata(handle, bh);
+			if (IS_SYNC(inode))
+				handle->h_sync = 1;
+			DQUOT_FREE_BLOCK(inode, 1);
+			unlock_buffer(bh);
+			ea_bdebug(bh, "refcount now=%d",
+				  le32_to_cpu(HDR(bh)->h_refcount) - 1);
+		}
+		if (ce)
+			mb_cache_entry_release(ce);
+	}
+}
+/*
  * ext3_xattr_set_handle()
  *
  * Create, replace or remove an extended attribute for this inode. Buffer
@@ -733,37 +768,8 @@ getblk_failed:
 		/*
 		 * If there was an old block, and we are no longer using it,
 		 * release the old block.
-		*/
-		ce = mb_cache_entry_get(ext3_xattr_cache, old_bh->b_bdev,
-					old_bh->b_blocknr);
-		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
-			/* Free the old block. */
-			ea_bdebug(old_bh, "freeing");
-			ext3_free_blocks(handle, inode, old_bh->b_blocknr, 1);
-
-			/* ext3_forget() calls bforget() for us, but we
-			   let our caller release old_bh, so we need to
-			   duplicate the handle before. */
-			get_bh(old_bh);
-			ext3_forget(handle, 1, inode, old_bh,old_bh->b_blocknr);
-			if (ce) {
-				mb_cache_entry_free(ce);
-				ce = NULL;
-			}
-		} else {
-			error = ext3_journal_get_write_access(handle, old_bh);
-			if (error)
-				goto cleanup;
-			/* Decrement the refcount only. */
-			lock_buffer(old_bh);
-			HDR(old_bh)->h_refcount = cpu_to_le32(
-				le32_to_cpu(HDR(old_bh)->h_refcount) - 1);
-			DQUOT_FREE_BLOCK(inode, 1);
-			ext3_journal_dirty_metadata(handle, old_bh);
-			ea_bdebug(old_bh, "refcount now=%d",
-				le32_to_cpu(HDR(old_bh)->h_refcount));
-			unlock_buffer(old_bh);
-		}
+		 */
+		ext3_xattr_release_block(handle, inode, old_bh);
 	}
 
 cleanup:
@@ -813,13 +819,13 @@ retry:
  * ext3_xattr_delete_inode()
  *
  * Free extended attribute resources associated with this inode. This
- * is called immediately before an inode is freed.
+ * is called immediately before an inode is freed. We have exclusive
+ * access to the inode.
  */
 void
 ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
 {
 	struct buffer_head *bh = NULL;
-	struct mb_cache_entry *ce = NULL;
 
 	down_write(&EXT3_I(inode)->xattr_sem);
 	if (!EXT3_I(inode)->i_file_acl)
@@ -838,33 +844,10 @@ ext3_xattr_delete_inode(handle_t *handle
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
-	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev, bh->b_blocknr);
-	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		if (ce) {
-			mb_cache_entry_free(ce);
-			ce = NULL;
-		}
-		ext3_free_blocks(handle, inode, EXT3_I(inode)->i_file_acl, 1);
-		get_bh(bh);
-		ext3_forget(handle, 1, inode, bh, EXT3_I(inode)->i_file_acl);
-	} else {
-		if (ext3_journal_get_write_access(handle, bh) != 0)
-			goto cleanup;
-		lock_buffer(bh);
-		HDR(bh)->h_refcount = cpu_to_le32(
-			le32_to_cpu(HDR(bh)->h_refcount) - 1);
-		ext3_journal_dirty_metadata(handle, bh);
-		if (IS_SYNC(inode))
-			handle->h_sync = 1;
-		DQUOT_FREE_BLOCK(inode, 1);
-		unlock_buffer(bh);
-	}
-	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
+	ext3_xattr_release_block(handle, inode, bh);
 	EXT3_I(inode)->i_file_acl = 0;
 
 cleanup:
-	if (ce)
-		mb_cache_entry_release(ce);
 	brelse(bh);
 	up_write(&EXT3_I(inode)->xattr_sem);
 }
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

