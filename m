Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUFRUri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUFRUri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUFRUpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:45:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:9150 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261763AbUFRUlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:41:46 -0400
Subject: [PATCH] fix possible stack corruption during reiserfs_file_write
From: Chris Mason <mason@suse.com>
To: reiserfs-dev@namesys.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087591350.1512.10.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 16:42:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With preallocation turned on, reiserfs_allocate_blocks_for_region wasn't
sending a large enough array to hold all the blocks it was asking the
block allocator to find.  This can result in stack corruption.

The fix is to kmalloc an array to hold the blocks, making sure to
allocate something large enough.

There was also a recent optimization to force the allocator to find a
free region large enough to hold the entire preallocation size.  This
was sometimes causing more blocks to be allocated then had been
requested, which would also overflow the array.  Something more elegant
is required here, until then just disable the optimization.

Index: linux-new/fs/reiserfs/bitmap.c
===================================================================
--- linux-new.orig/fs/reiserfs/bitmap.c	2004-06-18 15:51:55.000000000 -0400
+++ linux-new/fs/reiserfs/bitmap.c	2004-06-18 15:52:19.000000000 -0400
@@ -949,10 +949,7 @@ static inline int blocknrs_and_prealloc_
 		hint->preallocate=hint->prealloc_size=0;
 	}
 	/* for unformatted nodes, force large allocations */
-	bigalloc = amount_needed + hint->prealloc_size;
-	/* try to make things even */
-	if (bigalloc & 1 && hint->prealloc_size)
-	    bigalloc--;
+	bigalloc = amount_needed;
     }
 
     do {
Index: linux-new/fs/reiserfs/file.c
===================================================================
--- linux-new.orig/fs/reiserfs/file.c	2004-06-18 15:51:55.000000000 -0400
+++ linux-new/fs/reiserfs/file.c	2004-06-18 16:02:50.000000000 -0400
@@ -131,7 +131,7 @@ int reiserfs_allocate_blocks_for_region(
     struct buffer_head *bh; // Buffer head that contains items that we are going to deal with
     __u32 * item; // pointer to item we are going to deal with
     INITIALIZE_PATH(path); // path to item, that we are going to deal with.
-    b_blocknr_t allocated_blocks[blocks_to_allocate]; // Pointer to a place where allocated blocknumbers would be stored. Right now statically allocated, later that will change.
+    b_blocknr_t *allocated_blocks; // Pointer to a place where allocated blocknumbers would be stored.
     reiserfs_blocknr_hint_t hint; // hint structure for block allocator.
     size_t res; // return value of various functions that we call.
     int curr_block; // current block used to keep track of unmapped blocks.
@@ -144,10 +144,20 @@ int reiserfs_allocate_blocks_for_region(
     int modifying_this_item = 0; // Flag for items traversal code to keep track
 				 // of the fact that we already prepared
 				 // current block for journal
-
+    int will_prealloc = 0;
 
     RFALSE(!blocks_to_allocate, "green-9004: tried to allocate zero blocks?");
 
+    /* only preallocate if this is a small write */
+    if (REISERFS_I(inode)->i_prealloc_count ||
+       (!(write_bytes & (inode->i_sb->s_blocksize -1)) &&
+        blocks_to_allocate <
+        REISERFS_SB(inode->i_sb)->s_alloc_options.preallocsize))
+        will_prealloc = REISERFS_SB(inode->i_sb)->s_alloc_options.preallocsize;
+
+    allocated_blocks = kmalloc((blocks_to_allocate + will_prealloc) *
+    					sizeof(b_blocknr_t), GFP_NOFS);
+
     /* First we compose a key to point at the writing position, we want to do
        that outside of any locking region. */
     make_cpu_key (&key, inode, pos+1, TYPE_ANY, 3/*key length*/);
@@ -174,15 +184,8 @@ int reiserfs_allocate_blocks_for_region(
     hint.key = key.on_disk_key; // on disk key of file.
     hint.block = inode->i_blocks>>(inode->i_sb->s_blocksize_bits-9); // Number of disk blocks this file occupies already.
     hint.formatted_node = 0; // We are allocating blocks for unformatted node.
+    hint.preallocate = will_prealloc;
 
-    /* only preallocate if this is a small write */
-    if (REISERFS_I(inode)->i_prealloc_count ||
-       (!(write_bytes & (inode->i_sb->s_blocksize -1)) &&
-        blocks_to_allocate <
-        REISERFS_SB(inode->i_sb)->s_alloc_options.preallocsize))
-        hint.preallocate = 1;
-    else
-        hint.preallocate = 0;
     /* Call block allocator to allocate blocks */
     res = reiserfs_allocate_blocknrs(&hint, allocated_blocks, blocks_to_allocate, blocks_to_allocate);
     if ( res != CARRY_ON ) {
@@ -511,6 +514,7 @@ retry:
 
     RFALSE( curr_block > blocks_to_allocate, "green-9007: Used too many blocks? weird");
 
+    kfree(allocated_blocks);
     return 0;
 
 // Need to deal with transaction here.
@@ -524,6 +528,7 @@ error_exit:
     reiserfs_update_sd(th, inode); // update any changes we made to blk count
     journal_end(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1);
     reiserfs_write_unlock(inode->i_sb);
+    kfree(allocated_blocks);
 
     return res;
 }


