Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272235AbRH3OaJ>; Thu, 30 Aug 2001 10:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272251AbRH3O34>; Thu, 30 Aug 2001 10:29:56 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:20491 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272247AbRH3O3o>; Thu, 30 Aug 2001 10:29:44 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19874.676713.618088@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:28:50 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: F-reiserfs_get_block-cleanup.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

   This patch fixes several bugs in reiserfs_get_block():
    . race condition, when code took block number from "indirect item"
      without re-checking that this item is still there after blocking
      call. This causes file-system corruption on writing into hole;
    . uses stronger condition to check whether to start new transaction;
    . increase amount of space reserved into transaction (jbegin_count)
      to accommodate for updating of inode on disk (reiserfs_update_sd());
    . cast "block" to loff_t;
    . move (block < 0) check to the top of the function;
    . remove obsolete REISERFS_CHECK around pop_journal_writer();
    . add warning number and \n in warning message;

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/inode.c linux.patched/fs/reiserfs/inode.c
--- linux/fs/reiserfs/inode.c	Thu Aug 30 17:13:02 2001
+++ linux.patched/fs/reiserfs/inode.c	Thu Aug 30 16:57:50 2001
@@ -526,16 +526,26 @@ int reiserfs_get_block (struct inode * i
     int fs_gen;
     int windex ;
     struct reiserfs_transaction_handle th ;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 ;
+    /* space reserved in transaction batch: 
+        . 3 balancings in direct->indirect conversion
+        . 1 block involved into reiserfs_update_sd()
+       XXX in practically impossible worst case direct2indirect()
+       can incur (much) more that 3 balancings. */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 1;
     int version;
     int transaction_started = 0 ;
-    loff_t new_offset = (block << inode->i_sb->s_blocksize_bits) + 1 ;
+    loff_t new_offset = (((loff_t)block) << inode->i_sb->s_blocksize_bits) + 1 ;
 
 				/* bad.... */
     lock_kernel() ;
     th.t_trans_id = 0 ;
     version = inode_items_version (inode);
 
+    if (block < 0) {
+	unlock_kernel();
+	return -EIO;
+    }
+
     if (!file_capable (inode, block)) {
 	unlock_kernel() ;
 	return -EFBIG;
@@ -553,20 +563,14 @@ int reiserfs_get_block (struct inode * i
 	return ret;
     }
 
-    if (block < 0) {
-	unlock_kernel();
-	return -EIO;
-    }
-
     inode->u.reiserfs_i.i_pack_on_close = 1 ;
 
     windex = push_journal_writer("reiserfs_get_block") ;
   
     /* set the key of the first byte in the 'block'-th block of file */
-    make_cpu_key (&key, inode,
-		  (loff_t)block * inode->i_sb->s_blocksize + 1, // k_offset
+    make_cpu_key (&key, inode, new_offset,
 		  TYPE_ANY, 3/*key length*/);
-    if ((new_offset + inode->i_sb->s_blocksize) >= inode->i_size) {
+    if ((new_offset + inode->i_sb->s_blocksize - 1) > inode->i_size) {
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
 	transaction_started = 1 ;
     }
@@ -619,10 +623,13 @@ int reiserfs_get_block (struct inode * i
     }
 
     if (indirect_item_found (retval, ih)) {
+	b_blocknr_t unfm_ptr;
+
 	/* 'block'-th block is in the file already (there is
 	   corresponding cell in some indirect item). But it may be
 	   zero unformatted node pointer (hole) */
-	if (!item[pos_in_item]) {
+	unfm_ptr = le32_to_cpu (item[pos_in_item]);
+	if (unfm_ptr == 0) {
 	    /* use allocated block to plug the hole */
 	    reiserfs_prepare_for_journal(inode->i_sb, bh, 1) ;
 	    if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
@@ -631,15 +638,14 @@ int reiserfs_get_block (struct inode * i
 	    }
 	    bh_result->b_state |= (1UL << BH_New);
 	    item[pos_in_item] = cpu_to_le32 (allocated_block_nr);
+	    unfm_ptr = allocated_block_nr;
 	    journal_mark_dirty (&th, inode->i_sb, bh);
 	    inode->i_blocks += (inode->i_sb->s_blocksize / 512) ;
 	    reiserfs_update_sd(&th, inode) ;
 	}
-	set_block_dev_mapped(bh_result, le32_to_cpu (item[pos_in_item]), inode);
+	set_block_dev_mapped(bh_result, unfm_ptr, inode);
 	pathrelse (&path);
-#ifdef REISERFS_CHECK
 	pop_journal_writer(windex) ;
-#endif /* REISERFS_CHECK */
 	if (transaction_started)
 	    journal_end(&th, inode->i_sb, jbegin_count) ;
 
@@ -816,8 +822,8 @@ int reiserfs_get_block (struct inode * i
 	    goto failure;
 	}
 	if (retval == POSITION_FOUND) {
-	    reiserfs_warning ("vs-: reiserfs_get_block: "
-			      "%k should not be found", &key);
+	    reiserfs_warning ("vs-825: reiserfs_get_block: "
+			      "%k should not be found\n", &key);
 	    retval = -EEXIST;
 	    if (allocated_block_nr)
 	        reiserfs_free_block (&th, allocated_block_nr);
