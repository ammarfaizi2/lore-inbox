Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRFGOzh>; Thu, 7 Jun 2001 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbRFGOz1>; Thu, 7 Jun 2001 10:55:27 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:49163
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262659AbRFGOzQ>; Thu, 7 Jun 2001 10:55:16 -0400
Date: Thu, 07 Jun 2001 10:54:50 -0400
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [PATCH] reiserfs writepage <-> preallocation race
Message-ID: <356050000.991925690@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a race when reiserfs_writepage tries to fill holes
in the file.  The preallocation code relies on i_sem to protect
allocations for a given file, which won't work with concurrent
writepages (reiserfs doesn't lock_super during allocations).  

The fix turns off preallocation when writepage is filling
holes, and removes the discard_prealloc calls from reiserfs_get_block.
That cleanup is done later when i_sem is actually held.

Alan, please apply.

-chris

--- linux-2.4.5/fs/reiserfs/inode.c	Fri Jun  1 16:27:50 2001
+++ linux-2.4.5/fs/reiserfs/inode.c	Wed Jun  6 14:59:01 2001
@@ -21,6 +21,7 @@
 #define GET_BLOCK_CREATE 1    /* add anything you need to find block */
 #define GET_BLOCK_NO_HOLE 2   /* return -ENOENT for file holes */
 #define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
+#define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
 
 //
 // initially this function was derived from minix or ext2's analog and
@@ -489,6 +490,19 @@
     return retval ;
 }
 
+static inline int _allocate_block(struct reiserfs_transaction_handle *th,
+                           struct inode *inode, 
+			   b_blocknr_t *allocated_block_nr, 
+			   unsigned long tag,
+			   int flags) {
+  
+#ifdef REISERFS_PREALLOCATE
+    if (!(flags & GET_BLOCK_NO_ISEM)) {
+        return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr, tag);
+    }
+#endif
+    return reiserfs_new_unf_blocknrs (th, allocated_block_nr, tag);
+}
 //
 // initially this function was derived from ext2's analog and evolved
 // as the prototype did.  You'll need to look at the ext2 version to
@@ -581,11 +595,7 @@
 	    goto research ;
 	}
 
-#ifdef REISERFS_PREALLOCATE
-	repeat = reiserfs_new_unf_blocknrs2 (&th, inode, &allocated_block_nr, tag);
-#else
-	repeat = reiserfs_new_unf_blocknrs (&th, &allocated_block_nr, tag);
-#endif
+	repeat = _allocate_block(&th, inode, &allocated_block_nr, tag, create);
 
 	if (repeat == NO_DISK_SPACE) {
 	    /* restart the transaction to give the journal a chance to free
@@ -593,11 +603,7 @@
 	    ** research if we succeed on the second try
 	    */
 	    restart_transaction(&th, inode, &path) ; 
-#ifdef REISERFS_PREALLOCATE
-	    repeat = reiserfs_new_unf_blocknrs2 (&th, inode, &allocated_block_nr, tag);
-#else
-	    repeat = reiserfs_new_unf_blocknrs (&th, &allocated_block_nr, tag);
-#endif
+	    repeat = _allocate_block(&th, inode,&allocated_block_nr,tag,create);
 
 	    if (repeat != NO_DISK_SPACE) {
 		goto research ;
@@ -684,10 +690,6 @@
 	    retval = reiserfs_insert_item (&th, &path, &tmp_key, &tmp_ih, (char *)&unp);
 	    if (retval) {
 		reiserfs_free_block (&th, allocated_block_nr);
-
-#ifdef REISERFS_PREALLOCATE
-		reiserfs_discard_prealloc (&th, inode); 
-#endif
 		goto failure; // retval == -ENOSPC or -EIO or -EEXIST
 	    }
 	    if (unp)
@@ -735,10 +737,6 @@
 	    mark_buffer_uptodate (unbh, 1);
 	    if (retval) {
 		reiserfs_free_block (&th, allocated_block_nr);
-
-#ifdef REISERFS_PREALLOCATE
-		reiserfs_discard_prealloc (&th, inode); 
-#endif
 		goto failure;
 	    }
 	    /* we've converted the tail, so we must 
@@ -784,10 +782,6 @@
 	    retval = reiserfs_paste_into_item (&th, &path, &tmp_key, (char *)&un, UNFM_P_SIZE);
 	    if (retval) {
 		reiserfs_free_block (&th, allocated_block_nr);
-
-#ifdef REISERFS_PREALLOCATE
-		reiserfs_discard_prealloc (&th, inode); 
-#endif
 		goto failure;
 	    }
 	    if (un.unfm_nodenum)
@@ -824,6 +818,8 @@
 	    reiserfs_warning ("vs-: reiserfs_get_block: "
 			      "%k should not be found", &key);
 	    retval = -EEXIST;
+	    if (allocated_block_nr)
+	        reiserfs_free_block (&th, allocated_block_nr);
 	    pathrelse(&path) ;
 	    goto failure;
 	}
@@ -872,6 +868,8 @@
     inode->i_generation = INODE_PKEY (inode)->k_dir_id;
     inode->i_blksize = PAGE_SIZE;
 
+    INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
+
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
 	unsigned long blocks;
@@ -1427,6 +1425,8 @@
     inode->u.reiserfs_i.i_first_direct_byte = S_ISLNK(mode) ? 1 : 
       U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;
 
+    INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
+
     if (old_format_only (sb))
 	inode2sd_v1 (&sd, inode);
     else
@@ -1725,7 +1725,8 @@
     /* this is where we fill in holes in the file. */
     if (use_get_block) {
         kmap(bh_result->b_page) ;
-	retval = reiserfs_get_block(inode, block, bh_result, 1) ;
+	retval = reiserfs_get_block(inode, block, bh_result, 
+	                            GET_BLOCK_CREATE | GET_BLOCK_NO_ISEM) ;
         kunmap(bh_result->b_page) ;
 	if (!retval) {
 	    if (!buffer_mapped(bh_result) || bh_result->b_blocknr == 0) {

