Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbRGLOVA>; Thu, 12 Jul 2001 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGLOUv>; Thu, 12 Jul 2001 10:20:51 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:16654
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265166AbRGLOUm>; Thu, 12 Jul 2001 10:20:42 -0400
Date: Thu, 12 Jul 2001 10:20:07 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: reiserfs-list@namesys.com
Subject: [PATCH] speedup reiserfs O_SYNC and fsync
Message-ID: <414690000.994947607@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

This patch makes reiserfs O_SYNC and fsync faster by only
committing the last transcation a file/dir was included in,
instead of forcing a commit on the current transaction.

More speedups are still possible, this patch is fairly conservative.

It is based on 2.4.7-pre6 + the direct->indirect target flushing
patch I just sent.  More testers would be greatly appreciated ;-)

Note, this changes the reiserfs in-core inode.  modules users need
to recompile the whole kernel.

-chris

diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/dir.c	Thu Jul 12 10:46:26 2001
@@ -47,22 +47,10 @@
 };
 
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
-  int ret = 0 ;
-  int windex ;
-  struct reiserfs_transaction_handle th ;
-
   lock_kernel();
-
-  journal_begin(&th, dentry->d_inode->i_sb, 1) ;
-  windex = push_journal_writer("dir_fsync") ;
-  reiserfs_prepare_for_journal(th.t_super, SB_BUFFER_WITH_SB(th.t_super), 1) ;
-  journal_mark_dirty(&th, dentry->d_inode->i_sb, SB_BUFFER_WITH_SB (dentry->d_inode->i_sb)) ;
-  pop_journal_writer(windex) ;
-  journal_end_sync(&th, dentry->d_inode->i_sb, 1) ;
-
-  unlock_kernel();
-
-  return ret ;
+  reiserfs_commit_for_inode(dentry->d_inode) ;
+  unlock_kernel() ;
+  return 0 ;
 }
 
 
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/file.c	Thu Jul 12 10:46:26 2001
@@ -50,6 +50,7 @@
     lock_kernel() ;
     down (&inode->i_sem); 
     journal_begin(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3) ;
+    reiserfs_update_inode_transaction(inode) ;
 
 #ifdef REISERFS_PREALLOCATE
     reiserfs_discard_prealloc (&th, inode);
@@ -83,10 +84,7 @@
 			      int datasync
 			      ) {
   struct inode * p_s_inode = p_s_dentry->d_inode;
-  struct reiserfs_transaction_handle th ;
   int n_err = 0;
-  int windex ;
-  int jbegin_count = 1 ;
 
   lock_kernel() ;
 
@@ -94,14 +92,9 @@
       BUG ();
 
   n_err = fsync_inode_buffers(p_s_inode) ;
-  /* commit the current transaction to flush any metadata
-  ** changes.  sys_fsync takes care of flushing the dirty pages for us
-  */
-  journal_begin(&th, p_s_inode->i_sb, jbegin_count) ;
-  windex = push_journal_writer("sync_file") ;
-  reiserfs_update_sd(&th, p_s_inode);
-  pop_journal_writer(windex) ;
-  journal_end_sync(&th, p_s_inode->i_sb,jbegin_count) ;
+
+  reiserfs_commit_for_inode(p_s_inode) ;
+
   unlock_kernel() ;
   return ( n_err < 0 ) ? -EIO : 0;
 }
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/inode.c	Thu Jul 12 10:46:26 2001
@@ -41,6 +41,7 @@
 	down (&inode->i_sem); 
 
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
+	reiserfs_update_inode_transaction(inode) ;
 	windex = push_journal_writer("delete_inode") ;
 
 	reiserfs_delete_object (&th, inode);
@@ -232,6 +233,7 @@
   reiserfs_update_sd(th, inode) ;
   journal_end(th, s, len) ;
   journal_begin(th, s, len) ;
+  reiserfs_update_inode_transaction(inode) ;
 }
 
 // it is called by get_block when create == 0. Returns block number
@@ -567,6 +569,7 @@
 		  TYPE_ANY, 3/*key length*/);
     if ((new_offset + inode->i_sb->s_blocksize) >= inode->i_size) {
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
+	reiserfs_update_inode_transaction(inode) ;
 	transaction_started = 1 ;
     }
  research:
@@ -591,6 +594,7 @@
 	if (!transaction_started) {
 	    pathrelse(&path) ;
 	    journal_begin(&th, inode->i_sb, jbegin_count) ;
+	    reiserfs_update_inode_transaction(inode) ;
 	    transaction_started = 1 ;
 	    goto research ;
 	}
@@ -658,6 +662,7 @@
 	*/
 	pathrelse(&path) ;
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
+	reiserfs_update_inode_transaction(inode) ;
 	transaction_started = 1 ;
 	goto research;
     }
@@ -1277,6 +1282,10 @@
         return ;
     }
     lock_kernel() ;
+
+    /* this is really only used for atime updates, so they don't have
+    ** to be included in O_SYNC or fsync
+    */
     journal_begin(&th, inode->i_sb, 1) ;
     reiserfs_update_sd (&th, inode);
     journal_end(&th, inode->i_sb, 1) ;
@@ -1650,6 +1659,7 @@
     ** (it will unmap bh if it packs).
     */
     journal_begin(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 ) ;
+    reiserfs_update_inode_transaction(p_s_inode) ;
     windex = push_journal_writer("reiserfs_vfs_truncate_file") ;
     reiserfs_do_truncate (&th, p_s_inode, page, update_timestamps) ;
     pop_journal_writer(windex) ;
@@ -1696,6 +1706,7 @@
 start_over:
     lock_kernel() ;
     journal_begin(&th, inode->i_sb, jbegin_count) ;
+    reiserfs_update_inode_transaction(inode) ;
 
     make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3) ;
 
@@ -1927,22 +1938,34 @@
 static int reiserfs_commit_write(struct file *f, struct page *page,
 			         unsigned from, unsigned to) {
     struct inode *inode = page->mapping->host;
+    loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
     int ret ;
 
     reiserfs_wait_on_write_block(inode->i_sb) ;
+
+    /* generic_commit_write does this for us, but does not update the
+    ** transaction tracking stuff when the size changes.  So, we have
+    ** to do the i_size updates here.
+    */
+    if (pos > inode->i_size) {
+	struct reiserfs_transaction_handle th ;
+	lock_kernel() ;
+	journal_begin(&th, inode->i_sb, 1) ;
+	reiserfs_update_inode_transaction(inode) ;
+	inode->i_size = pos ;
+	reiserfs_update_sd(&th, inode) ;
+	journal_end(&th, inode->i_sb, 1) ;
+	unlock_kernel() ;
+    }
+
     ret = generic_commit_write(f, page, from, to) ;
 
     /* we test for O_SYNC here so we can commit the transaction
     ** for any packed tails the file might have had
     */
     if (f->f_flags & O_SYNC) {
-	struct reiserfs_transaction_handle th ;
 	lock_kernel() ;
-	journal_begin(&th, inode->i_sb, 1) ;
-	reiserfs_prepare_for_journal(inode->i_sb, 
-	                             SB_BUFFER_WITH_SB(inode->i_sb), 1) ;
-	journal_mark_dirty(&th, inode->i_sb, SB_BUFFER_WITH_SB(inode->i_sb)) ;
-	journal_end_sync(&th, inode->i_sb, 1) ;
+	reiserfs_commit_for_inode(inode) ;
 	unlock_kernel() ;
     }
     return ret ;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/journal.c	Thu Jul 12 10:46:26 2001
@@ -2315,6 +2315,11 @@
 ** will wait until the current transaction is done/commited before returning 
 */
 int journal_end_sync(struct reiserfs_transaction_handle *th, struct super_block *p_s_sb, unsigned long nblocks) {
+
+  if (SB_JOURNAL(p_s_sb)->j_len == 0) {
+    reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
+    journal_mark_dirty(th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
+  }
   return do_journal_end(th, p_s_sb, nblocks, COMMIT_NOW | WAIT) ;
 }
 
@@ -2605,6 +2610,41 @@
     }
   }
   return 0 ;
+}
+
+void reiserfs_update_inode_transaction(struct inode *inode) {
+  
+  inode->u.reiserfs_i.i_trans_index = SB_JOURNAL_LIST_INDEX(inode->i_sb);
+
+  inode->u.reiserfs_i.i_trans_id = SB_JOURNAL(inode->i_sb)->j_trans_id ;
+}
+
+static int reiserfs_inode_in_this_transaction(struct inode *inode) {
+  if (inode->u.reiserfs_i.i_trans_id == SB_JOURNAL(inode->i_sb)->j_trans_id || 
+      inode->u.reiserfs_i.i_trans_id == 0) {
+    return 1; 
+  } 
+  return 0 ;
+}
+
+void reiserfs_commit_for_inode(struct inode *inode) {
+  struct reiserfs_journal_list *jl ;
+  struct reiserfs_transaction_handle th ;
+  struct super_block *sb = inode->i_sb ;
+
+  jl = SB_JOURNAL_LIST(sb) + inode->u.reiserfs_i.i_trans_index ;
+
+  /* is it from the current transaction, or from an unknown transaction? */
+  if (reiserfs_inode_in_this_transaction(inode)) {
+    journal_join(&th, sb, 1) ;
+    reiserfs_update_inode_transaction(inode) ;
+    journal_end_sync(&th, sb, 1) ;
+  } else if (jl->j_trans_id == inode->u.reiserfs_i.i_trans_id) {
+    flush_commit_list(sb, jl, 1) ;
+  }
+  /* if the transaction id does not match, this list is long since flushed
+  ** and we don't have to do anything here
+  */
 }
 
 void reiserfs_restore_prepared_buffer(struct super_block *p_s_sb, 
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/namei.c	Thu Jul 12 10:46:26 2001
@@ -554,6 +554,8 @@
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	return retval;
     }
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
 	
     inode->i_op = &reiserfs_file_inode_operations;
     inode->i_fop = &reiserfs_file_operations;
@@ -613,6 +615,9 @@
     //FIXME: needed for block and char devices only
     reiserfs_update_sd (&th, inode);
 
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
+
     retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
 				 inode, 1/*visible*/);
     if (retval) {
@@ -668,6 +673,8 @@
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	return retval;
     }
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
 
     inode->i_op = &reiserfs_dir_inode_operations;
     inode->i_fop = &reiserfs_dir_operations;
@@ -736,6 +743,9 @@
     }
     inode = dentry->d_inode;
 
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
+
     if (de.de_objectid != inode->i_ino) {
 	// FIXME: compare key of an object and a key found in the
 	// entry
@@ -809,6 +819,9 @@
     }
     inode = dentry->d_inode;
 
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
+
     if (de.de_objectid != inode->i_ino) {
 	// FIXME: compare key of an object and a key found in the
 	// entry
@@ -898,6 +911,9 @@
 	return retval;
     }
 
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
+
     inode->i_op = &page_symlink_inode_operations;
     inode->i_mapping->a_ops = &reiserfs_address_space_operations;
 
@@ -953,6 +969,10 @@
     /* create new entry */
     retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len,
 				 inode, 1/*visible*/);
+
+    reiserfs_update_inode_transaction(inode) ;
+    reiserfs_update_inode_transaction(dir) ;
+
     if (retval) {
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
@@ -1098,6 +1118,10 @@
 	return retval;
     }
 
+    reiserfs_update_inode_transaction(old_dir) ;
+    reiserfs_update_inode_transaction(new_dir) ;
+    if (new_inode) 
+	reiserfs_update_inode_transaction(new_inode) ;
 
     while (1) {
 	// look for old name using corresponding entry key (found by reiserfs_find_entry)
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Thu Jul 12 10:46:26 2001
+++ b/fs/reiserfs/stree.c	Thu Jul 12 10:46:26 2001
@@ -1928,6 +1928,7 @@
 
 	  journal_end(th, p_s_inode->i_sb, orig_len_alloc) ;
 	  journal_begin(th, p_s_inode->i_sb, orig_len_alloc) ;
+	  reiserfs_update_inode_transaction(p_s_inode) ;
 	}
     } while ( n_file_size > ROUND_UP (n_new_file_size) &&
 	      search_for_position_by_key(p_s_inode->i_sb, &s_item_key, &s_search_path) == POSITION_FOUND )  ;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu Jul 12 10:46:26 2001
+++ b/include/linux/reiserfs_fs.h	Thu Jul 12 10:46:26 2001
@@ -1580,6 +1580,8 @@
 */
 #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
 
+void reiserfs_commit_for_inode(struct inode *) ;
+void reiserfs_update_inode_transaction(struct inode *) ;
 void reiserfs_wait_on_write_block(struct super_block *s) ;
 void reiserfs_block_writes(struct reiserfs_transaction_handle *th) ;
 void reiserfs_allow_writes(struct super_block *s) ;
diff -Nru a/include/linux/reiserfs_fs_i.h b/include/linux/reiserfs_fs_i.h
--- a/include/linux/reiserfs_fs_i.h	Thu Jul 12 10:46:26 2001
+++ b/include/linux/reiserfs_fs_i.h	Thu Jul 12 10:46:26 2001
@@ -40,6 +40,12 @@
                                    is a comment you should make.... -Hans */
   //nopack-attribute
   int nopack;
+  
+  /* we use these for fsync or O_SYNC to decide which transaction needs
+  ** to be committed in order for this inode to be properly flushed
+  */
+  unsigned long i_trans_id ;
+  unsigned long i_trans_index ;
 };
 
 

