Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbTCLHgJ>; Wed, 12 Mar 2003 02:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbTCLHgJ>; Wed, 12 Mar 2003 02:36:09 -0500
Received: from angband.namesys.com ([212.16.7.85]:35731 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263079AbTCLHgD>; Wed, 12 Mar 2003 02:36:03 -0500
Date: Wed, 12 Mar 2003 10:46:42 +0300
From: Oleg Drokin <green@namesys.com>
To: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [OOPS] Linux-2.4.20-pre4 with reiserfs
Message-ID: <20030312104642.B9291@namesys.com>
References: <200303112216.12359.l.allegrucci@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303112216.12359.l.allegrucci@tiscali.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Mar 11, 2003 at 10:16:12PM +0000, Lorenzo Allegrucci wrote:

> `fsx-linux -c 2 linux-2.4.20.tar.bz2' on a console and
> `fsstress -d -d -n 10000 -p 10' on a second console.
> The oops happened just few seconds after I run `vmstat 1'
> on third console.  Reproducible.

Ah, looks like known direct io problem.
There was a directio fix in 2.4.21-pre5, but 
some later IBM guys made us aware of another directio problem,
see the patch below (should help for you).
Please try 2.4.21-pre5 + this patch and if it still does not work, please tell us.
Thank you. (note that this patch was not passed through our full patch verification
process yet, but it works for me and for Chris Mason (whose code is most part of the patch)).

Bye,
    Oleg 

===== fs/reiserfs/inode.c 1.42 vs edited =====
--- 1.42/fs/reiserfs/inode.c	Thu Feb 13 15:42:42 2003
+++ edited/fs/reiserfs/inode.c	Fri Mar  7 09:54:11 2003
@@ -469,7 +469,7 @@
     tail_end = (tail_start | (bh_result->b_size - 1)) + 1 ;
 
     index = tail_offset >> PAGE_CACHE_SHIFT ;
-    if (index != hole_page->index) {
+    if ( !hole_page || index != hole_page->index) {
 	tail_page = grab_cache_page(inode->i_mapping, index) ;
 	retval = -ENOMEM;
 	if (!tail_page) {
@@ -1810,7 +1810,12 @@
 	    flush_dcache_page(page) ;
 	    kunmap(page) ;
 	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
-	        mark_buffer_dirty(bh) ;
+	        if (!atomic_set_buffer_dirty(bh)) {
+			set_buffer_flushtime(bh);
+			refile_buffer(bh);
+			buffer_insert_inode_data_queue(bh, p_s_inode);
+			balance_dirty();
+		}
 	    }
 	}
 	UnlockPage(page) ;
@@ -2158,6 +2163,9 @@
                               struct kiobuf *iobuf, unsigned long blocknr,
 			      int blocksize) 
 {
+    lock_kernel();
+    reiserfs_commit_for_tail(inode);
+    unlock_kernel();
     return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
                              reiserfs_get_block_direct_io) ;
 }
===== fs/reiserfs/journal.c 1.25 vs edited =====
--- 1.25/fs/reiserfs/journal.c	Tue Aug 20 15:39:48 2002
+++ edited/fs/reiserfs/journal.c	Fri Mar  7 09:54:14 2003
@@ -2649,32 +2649,52 @@
   inode->u.reiserfs_i.i_trans_id = SB_JOURNAL(inode->i_sb)->j_trans_id ;
 }
 
-static int reiserfs_inode_in_this_transaction(struct inode *inode) {
-  if (inode->u.reiserfs_i.i_trans_id == SB_JOURNAL(inode->i_sb)->j_trans_id || 
-      inode->u.reiserfs_i.i_trans_id == 0) {
-    return 1; 
-  } 
-  return 0 ;
+void reiserfs_update_tail_transaction(struct inode *inode) {
+  
+  inode->u.reiserfs_i.i_tail_trans_index = SB_JOURNAL_LIST_INDEX(inode->i_sb);
+
+  inode->u.reiserfs_i.i_tail_trans_id = SB_JOURNAL(inode->i_sb)->j_trans_id ;
+}
+
+static void __commit_trans_index(struct inode *inode, unsigned long id,
+                                 unsigned long index) 
+{
+    struct reiserfs_journal_list *jl ;
+    struct reiserfs_transaction_handle th ;
+    struct super_block *sb = inode->i_sb ;
+
+    jl = SB_JOURNAL_LIST(sb) + index;
+
+    /* is it from the current transaction, or from an unknown transaction? */
+    if (id == SB_JOURNAL(sb)->j_trans_id) {
+	journal_join(&th, sb, 1) ;
+	journal_end_sync(&th, sb, 1) ;
+    } else if (jl->j_trans_id == id) {
+	flush_commit_list(sb, jl, 1) ;
+    }
+    /* if the transaction id does not match, this list is long since flushed
+    ** and we don't have to do anything here
+    */
 }
+void reiserfs_commit_for_tail(struct inode *inode) {
+    unsigned long id = inode->u.reiserfs_i.i_tail_trans_id;
+    unsigned long index = inode->u.reiserfs_i.i_tail_trans_index;
 
+    /* for tails, if this info is unset there's nothing to commit */
+    if (id && index)
+	__commit_trans_index(inode, id, index);
+}
 void reiserfs_commit_for_inode(struct inode *inode) {
-  struct reiserfs_journal_list *jl ;
-  struct reiserfs_transaction_handle th ;
-  struct super_block *sb = inode->i_sb ;
-
-  jl = SB_JOURNAL_LIST(sb) + inode->u.reiserfs_i.i_trans_index ;
-
-  /* is it from the current transaction, or from an unknown transaction? */
-  if (reiserfs_inode_in_this_transaction(inode)) {
-    journal_join(&th, sb, 1) ;
-    reiserfs_update_inode_transaction(inode) ;
-    journal_end_sync(&th, sb, 1) ;
-  } else if (jl->j_trans_id == inode->u.reiserfs_i.i_trans_id) {
-    flush_commit_list(sb, jl, 1) ;
-  }
-  /* if the transaction id does not match, this list is long since flushed
-  ** and we don't have to do anything here
-  */
+    unsigned long id = inode->u.reiserfs_i.i_trans_id;
+    unsigned long index = inode->u.reiserfs_i.i_trans_index;
+
+    /* for the whole inode, assume unset id or index means it was
+     * changed in the current transaction.  More conservative
+     */
+    if (!id || !index)
+	reiserfs_update_inode_transaction(inode) ;
+
+    __commit_trans_index(inode, id, index);
 }
 
 void reiserfs_restore_prepared_buffer(struct super_block *p_s_sb, 
===== fs/reiserfs/tail_conversion.c 1.16 vs edited =====
--- 1.16/fs/reiserfs/tail_conversion.c	Thu Feb 13 15:42:42 2003
+++ edited/fs/reiserfs/tail_conversion.c	Fri Mar  7 09:54:15 2003
@@ -133,6 +133,7 @@
 
     inode->u.reiserfs_i.i_first_direct_byte = U32_MAX;
 
+    reiserfs_update_tail_transaction(inode);
     return 0;
 }
 
===== include/linux/reiserfs_fs.h 1.26 vs edited =====
--- 1.26/include/linux/reiserfs_fs.h	Mon Jan 20 13:19:30 2003
+++ edited/include/linux/reiserfs_fs.h	Fri Mar  7 09:58:17 2003
@@ -1558,7 +1558,9 @@
 #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
 
 void reiserfs_commit_for_inode(struct inode *) ;
+void reiserfs_commit_for_tail(struct inode *) ;
 void reiserfs_update_inode_transaction(struct inode *) ;
+void reiserfs_update_tail_transaction(struct inode *) ;
 void reiserfs_wait_on_write_block(struct super_block *s) ;
 void reiserfs_block_writes(struct reiserfs_transaction_handle *th) ;
 void reiserfs_allow_writes(struct super_block *s) ;
===== include/linux/reiserfs_fs_i.h 1.8 vs edited =====
--- 1.8/include/linux/reiserfs_fs_i.h	Fri Aug  9 19:22:34 2002
+++ edited/include/linux/reiserfs_fs_i.h	Fri Mar  7 09:54:16 2003
@@ -53,6 +53,13 @@
     ** flushed */
     unsigned long i_trans_id ;
     unsigned long i_trans_index ;
+
+    /* direct io needs to make sure the tail is on disk to avoid
+     * buffer alias problems.  This records the transaction last
+     * involved in a direct->indirect conversion for this file
+     */
+    unsigned long i_tail_trans_id;
+    unsigned long i_tail_trans_index;
 };
 
 #endif
