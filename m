Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUD1X1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUD1X1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUD1X1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:27:42 -0400
Received: from ns.suse.de ([195.135.220.2]:53668 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261764AbUD1X0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:26:13 -0400
Subject: [PATCH] reiserfs data logging support
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1083194836.30344.201.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 19:27:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com

Add data=journal support for reiserfs

Index: linux.mm/fs/reiserfs/file.c
===================================================================
--- linux.mm.orig/fs/reiserfs/file.c	2004-04-28 18:56:17.263385401 -0400
+++ linux.mm/fs/reiserfs/file.c	2004-04-28 18:56:35.184244448 -0400
@@ -591,9 +591,19 @@ int reiserfs_commit_page(struct inode *i
     struct buffer_head *bh, *head;
     unsigned long i_size_index = inode->i_size >> PAGE_CACHE_SHIFT;
     int new;
+    int logit = reiserfs_file_data_log(inode);
+    struct super_block *s = inode->i_sb;
+    int bh_per_page = PAGE_CACHE_SIZE / s->s_blocksize;
+    struct reiserfs_transaction_handle th;
+    th.t_trans_id = 0;
 
     blocksize = 1 << inode->i_blkbits;
 
+    if (logit) {
+	reiserfs_write_lock(s);
+	journal_begin(&th, s, bh_per_page + 1);
+	reiserfs_update_inode_transaction(inode);
+    }
     for(bh = head = page_buffers(page), block_start = 0;
         bh != head || !block_start;
 	block_start=block_end, bh = bh->b_this_page)
@@ -607,7 +617,10 @@ int reiserfs_commit_page(struct inode *i
 		    partial = 1;
 	} else {
 	    set_buffer_uptodate(bh);
-	    if (!buffer_dirty(bh)) {
+	    if (logit) {
+		reiserfs_prepare_for_journal(s, bh, 1);
+		journal_mark_dirty(&th, s, bh);
+	    } else if (!buffer_dirty(bh)) {
 		mark_buffer_dirty(bh);
 		/* do data=ordered on any page past the end
 		 * of file and any buffer marked BH_New.
@@ -619,7 +632,10 @@ int reiserfs_commit_page(struct inode *i
 	    }
 	}
     }
-
+    if (logit) {
+	journal_end(&th, s, bh_per_page + 1);
+	reiserfs_write_unlock(s);
+    }
     /*
      * If this is a partial write which happened to make all buffers
      * uptodate then we can optimize away a bogus readpage() for
Index: linux.mm/fs/reiserfs/inode.c
===================================================================
--- linux.mm.orig/fs/reiserfs/inode.c	2004-04-28 18:56:17.274384087 -0400
+++ linux.mm/fs/reiserfs/inode.c	2004-04-28 18:56:36.406098476 -0400
@@ -2147,6 +2147,11 @@ static int reiserfs_write_full_page(stru
     struct buffer_head *head, *bh;
     int partial = 0 ;
     int nr = 0;
+    int checked = PageChecked(page);
+    struct reiserfs_transaction_handle th;
+    struct super_block *s = inode->i_sb;
+    int bh_per_page = PAGE_CACHE_SIZE / s->s_blocksize;
+    th.t_trans_id = 0;
 
     /* The page dirty bit is cleared before writepage is called, which
      * means we have to tell create_empty_buffers to make dirty buffers
@@ -2154,7 +2159,7 @@ static int reiserfs_write_full_page(stru
      * in the BH_Uptodate is just a sanity check.
      */
     if (!page_has_buffers(page)) {
-	create_empty_buffers(page, inode->i_sb->s_blocksize, 
+	create_empty_buffers(page, s->s_blocksize,
 	                    (1 << BH_Dirty) | (1 << BH_Uptodate));
     }
     head = page_buffers(page) ;
@@ -2178,10 +2183,10 @@ static int reiserfs_write_full_page(stru
 	kunmap_atomic(kaddr, KM_USER0) ;
     }
     bh = head ;
-    block = page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits) ;
+    block = page->index << (PAGE_CACHE_SHIFT - s->s_blocksize_bits) ;
     /* first map all the buffers, logging any direct items we find */
     do {
-	if (buffer_dirty(bh) && (!buffer_mapped(bh) ||
+	if ((checked || buffer_dirty(bh)) && (!buffer_mapped(bh) ||
 	   (buffer_mapped(bh) && bh->b_blocknr == 0))) {
 	    /* not mapped yet, or it points to a direct item, search
 	     * the btree for the mapping info, and log any direct
@@ -2195,6 +2200,18 @@ static int reiserfs_write_full_page(stru
 	block++;
     } while(bh != head) ;
 
+    /*
+     * we start the transaction after map_block_for_writepage,
+     * because it can create holes in the file (an unbounded operation).
+     * starting it here, we can make a reliable estimate for how many
+     * blocks we're going to log
+     */
+    if (checked) {
+	ClearPageChecked(page);
+	reiserfs_write_lock(s);
+	journal_begin(&th, s, bh_per_page + 1);
+	reiserfs_update_inode_transaction(inode);
+    }
     /* now go through and lock any dirty buffers on the page */
     do {
 	get_bh(bh);
@@ -2203,6 +2220,11 @@ static int reiserfs_write_full_page(stru
 	if (buffer_mapped(bh) && bh->b_blocknr == 0)
 	    continue;
 
+	if (checked) {
+	    reiserfs_prepare_for_journal(s, bh, 1);
+	    journal_mark_dirty(&th, s, bh);
+	    continue;
+	}
 	/* from this point on, we know the buffer is mapped to a
 	 * real block and not a direct item
 	 */
@@ -2221,6 +2243,10 @@ static int reiserfs_write_full_page(stru
 	}
     } while((bh = bh->b_this_page) != head);
 
+    if (checked) {
+	journal_end(&th, s, bh_per_page + 1);
+	reiserfs_write_unlock(s);
+    }
     BUG_ON(PageWriteback(page));
     set_page_writeback(page);
     unlock_page(page);
@@ -2480,17 +2506,15 @@ static int invalidatepage_can_drop(struc
     /* the page is locked, and the only places that log a data buffer
      * also lock the page.
      */
-#if 0
     if (reiserfs_file_data_log(inode)) {
-	/* very conservative, leave the buffer pinned if anyone might need it.
-	** this should be changed to drop the buffer if it is only in the
-	** current transaction
-	*/
+	/*
+	 * very conservative, leave the buffer pinned if
+	 * anyone might need it.
+	 */
         if (buffer_journaled(bh) || buffer_journal_dirty(bh)) {
 	    ret = 0 ;
 	}
     } else
-#endif
     if (buffer_dirty(bh) || buffer_locked(bh)) {
 	struct reiserfs_journal_list *jl;
 	struct reiserfs_jh *jh = bh->b_private;
@@ -2528,6 +2552,10 @@ static int reiserfs_invalidatepage(struc
     int ret = 1;
 
     BUG_ON(!PageLocked(page));
+
+    if (offset == 0)
+	ClearPageChecked(page);
+
     if (!page_has_buffers(page))
 	goto out;
 
@@ -2561,6 +2589,15 @@ out:
     return ret;
 }
 
+static int reiserfs_set_page_dirty(struct page *page) {
+    struct inode *inode = page->mapping->host;
+    if (reiserfs_file_data_log(inode)) {
+	SetPageChecked(page);
+	return __set_page_dirty_nobuffers(page);
+    }
+    return __set_page_dirty_buffers(page);
+}
+
 /*
  * Returns 1 if the page's buffers were dropped.  The page is locked.
  *
@@ -2578,6 +2615,7 @@ static int reiserfs_releasepage(struct p
     struct buffer_head *bh ;
     int ret = 1 ;
 
+    WARN_ON(PageChecked(page));
     spin_lock(&j->j_dirty_buffers_lock) ;
     head = page_buffers(page) ;
     bh = head ;
@@ -2683,5 +2721,6 @@ struct address_space_operations reiserfs
     .prepare_write = reiserfs_prepare_write,
     .commit_write = reiserfs_commit_write,
     .bmap = reiserfs_aop_bmap,
-    .direct_IO = reiserfs_direct_IO
+    .direct_IO = reiserfs_direct_IO,
+    .set_page_dirty = reiserfs_set_page_dirty,
 } ;
Index: linux.mm/fs/reiserfs/journal.c
===================================================================
--- linux.mm.orig/fs/reiserfs/journal.c	2004-04-28 18:56:17.351374889 -0400
+++ linux.mm/fs/reiserfs/journal.c	2004-04-28 18:56:35.179245045 -0400
@@ -1024,7 +1024,6 @@ static int flush_commit_list(struct supe
   up(&jl->j_commit_lock);
 put_jl:
   put_journal_list(s, jl);
-
   return 0 ;
 }
 
@@ -1544,14 +1543,18 @@ static int flush_used_journal_lists(stru
     unsigned long cur_len;
     int ret;
     int i;
+    int limit = 256;
     struct reiserfs_journal_list *tjl;
     struct reiserfs_journal_list *flush_jl;
     unsigned long trans_id;
 
     flush_jl = tjl = jl;
 
-    /* flush for 256 transactions or 256 blocks, whichever comes first */
-    for(i = 0 ; i < 256 && len < 256 ; i++) {
+    /* in data logging mode, try harder to flush a lot of blocks */
+    if (reiserfs_data_log(s))
+	limit = 1024;
+    /* flush for 256 transactions or limit blocks, whichever comes first */
+    for(i = 0 ; i < 256 && len < limit ; i++) {
 	if (atomic_read(&tjl->j_commit_left) ||
 	    tjl->j_trans_id < jl->j_trans_id) {
 	    break;
@@ -3480,10 +3483,15 @@ static int do_journal_end(struct reiserf
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
+      char *addr;
+      struct page *page;
       tmp_bh =  journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
 		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
       set_buffer_uptodate(tmp_bh);
-      memcpy(tmp_bh->b_data, cn->bh->b_data, cn->bh->b_size) ;  
+      page = cn->bh->b_page;
+      addr = kmap(page);
+      memcpy(tmp_bh->b_data, addr, cn->bh->b_size) ; 
+      kunmap(page);
       mark_buffer_dirty(tmp_bh);
       jindex++ ;
       set_bit(BH_JDirty_wait, &(cn->bh->b_state)) ; 
Index: linux.mm/fs/reiserfs/stree.c
===================================================================
--- linux.mm.orig/fs/reiserfs/stree.c	2004-04-28 18:56:17.429365572 -0400
+++ linux.mm/fs/reiserfs/stree.c	2004-04-28 18:56:35.182244686 -0400
@@ -1495,6 +1495,41 @@ void reiserfs_delete_object (struct reis
     reiserfs_delete_solid_item (th, inode, INODE_PKEY (inode));
 }
 
+static void
+unmap_buffers(struct page *page, loff_t pos) {
+    struct buffer_head *bh ;
+    struct buffer_head *head ;
+    struct buffer_head *next ;
+    unsigned long tail_index ;
+    unsigned long cur_index ;
+
+    if (page) {
+	if (page_has_buffers(page)) {
+	    tail_index = pos & (PAGE_CACHE_SIZE - 1) ;
+	    cur_index = 0 ;
+	    head = page_buffers(page) ;
+	    bh = head ;
+	    do {
+		next = bh->b_this_page ;
+
+		/* we want to unmap the buffers that contain the tail, and
+		** all the buffers after it (since the tail must be at the
+		** end of the file).  We don't want to unmap file data
+		** before the tail, since it might be dirty and waiting to
+		** reach disk
+		*/
+		cur_index += bh->b_size ;
+		if (cur_index > tail_index) {
+		    reiserfs_unmap_buffer(bh) ;
+		}
+		bh = next ;
+	    } while (bh != head) ;
+	    if ( PAGE_SIZE == bh->b_size ) {
+		clear_page_dirty(page);
+	    }
+	}
+    }
+}
 
 static int maybe_indirect_to_direct (struct reiserfs_transaction_handle *th, 
 			      struct inode * p_s_inode,
@@ -1587,7 +1622,7 @@ int reiserfs_cut_from_item (struct reise
     char                c_mode;            /* Mode of the balance. */
     int retval2 = -1;
     int quota_cut_bytes;
-    
+    loff_t tail_pos = 0;
     
     init_tb_struct(th, &s_cut_balance, p_s_inode->i_sb, p_s_path, n_cut_size);
 
@@ -1627,6 +1662,7 @@ int reiserfs_cut_from_item (struct reise
       	    set_cpu_key_k_type (p_s_item_key, TYPE_INDIRECT);
 	    p_s_item_key->key_length = 4;
 	    n_new_file_size -= (n_new_file_size & (p_s_sb->s_blocksize - 1));
+	    tail_pos = n_new_file_size;
 	    set_cpu_key_k_offset (p_s_item_key, n_new_file_size + 1);
 	    if ( search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path) == POSITION_NOT_FOUND ){
 		print_block (PATH_PLAST_BUFFER (p_s_path), 3, PATH_LAST_POSITION (p_s_path) - 1, PATH_LAST_POSITION (p_s_path) + 1);
@@ -1724,9 +1760,10 @@ int reiserfs_cut_from_item (struct reise
     if ( n_is_inode_locked ) {
 	/* we've done an indirect->direct conversion.  when the data block
 	** was freed, it was removed from the list of blocks that must
-	** be flushed before the transaction commits, so we don't need to
-	** deal with it here.
+	** be flushed before the transaction commits, make sure to
+	** unmap and invalidate it
 	*/
+	unmap_buffers(page, tail_pos);
 	REISERFS_I(p_s_inode)->i_flags &= ~i_pack_on_close_mask ;
     }
 #ifdef REISERQUOTA_DEBUG
Index: linux.mm/fs/reiserfs/tail_conversion.c
===================================================================
--- linux.mm.orig/fs/reiserfs/tail_conversion.c	2004-04-28 18:56:17.436364735 -0400
+++ linux.mm/fs/reiserfs/tail_conversion.c	2004-04-28 18:56:35.174245642 -0400
@@ -162,42 +162,6 @@ void reiserfs_unmap_buffer(struct buffer
     unlock_buffer(bh) ;
 }
 
-static void
-unmap_buffers(struct page *page, loff_t pos) {
-  struct buffer_head *bh ;
-  struct buffer_head *head ;
-  struct buffer_head *next ;
-  unsigned long tail_index ;
-  unsigned long cur_index ;
-
-  if (page) {
-    if (page_has_buffers(page)) {
-      tail_index = pos & (PAGE_CACHE_SIZE - 1) ;
-      cur_index = 0 ;
-      head = page_buffers(page) ;
-      bh = head ;
-      do {
-	next = bh->b_this_page ;
-
-        /* we want to unmap the buffers that contain the tail, and
-        ** all the buffers after it (since the tail must be at the
-        ** end of the file).  We don't want to unmap file data 
-        ** before the tail, since it might be dirty and waiting to 
-        ** reach disk
-        */
-        cur_index += bh->b_size ;
-        if (cur_index > tail_index) {
-          reiserfs_unmap_buffer(bh) ;
-        }
-	bh = next ;
-      } while (bh != head) ;
-      if ( PAGE_SIZE == bh->b_size ) {
-	clear_page_dirty(page);
-      }
-    }
-  } 
-}
-
 /* this first locks inode (neither reads nor sync are permitted),
    reads tail through page cache, insert direct item. When direct item
    inserted successfully inode is left locked. Return value is always
@@ -287,11 +251,6 @@ int indirect2direct (struct reiserfs_tra
     }
     kunmap(page) ;
 
-    /* this will invalidate all the buffers in the page after
-    ** pos1
-    */
-    unmap_buffers(page, pos1) ;
-
     /* make sure to get the i_blocks changes from reiserfs_insert_item */
     reiserfs_update_sd(th, p_s_inode);
 
Index: linux.mm/include/linux/reiserfs_fs.h
===================================================================
--- linux.mm.orig/include/linux/reiserfs_fs.h	2004-04-28 18:56:19.194154737 -0400
+++ linux.mm/include/linux/reiserfs_fs.h	2004-04-28 18:56:35.193243372 -0400
@@ -1752,6 +1752,14 @@ int reiserfs_add_tail_list(struct inode 
 int reiserfs_add_ordered_list(struct inode *inode, struct buffer_head *bh);
 int journal_mark_dirty(struct reiserfs_transaction_handle *, struct super_block *, struct buffer_head *bh) ;
 
+static inline int
+reiserfs_file_data_log(struct inode *inode) {
+    if (reiserfs_data_log(inode->i_sb) ||
+       (REISERFS_I(inode)->i_flags & i_data_log))
+        return 1 ;
+    return 0 ;
+}
+
 static inline int reiserfs_transaction_running(struct super_block *s) {
     struct reiserfs_transaction_handle *th = current->journal_info ;
     if (th && th->t_super == s)
Index: linux.mm/include/linux/reiserfs_fs_i.h
===================================================================
--- linux.mm.orig/include/linux/reiserfs_fs_i.h	2004-04-28 18:56:19.195154618 -0400
+++ linux.mm/include/linux/reiserfs_fs_i.h	2004-04-28 18:56:35.190243731 -0400
@@ -25,6 +25,7 @@ typedef enum {
     i_link_saved_truncate_mask =  0x0020,
     i_priv_object              =  0x0080,
     i_has_xattr_dir            =  0x0100,
+    i_data_log	               =  0x0200,
 } reiserfs_inode_flags;
 
 


