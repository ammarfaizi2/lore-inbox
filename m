Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbREaPht>; Thu, 31 May 2001 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbREaPhk>; Thu, 31 May 2001 11:37:40 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3082 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S262116AbREaPha>; Thu, 31 May 2001 11:37:30 -0400
Date: Thu, 31 May 2001 11:37:25 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] reiserfs cleanup -- flush routines
Message-ID: <1068290000.991323444@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

When packed tails get converted, reiserfs makes sure the new full block
is flushed before transaction commit, which avoids losing old file data if
we crash.  But, of all the possible ways I could have coded this, I 
probably picked the worst one.

So, this patch rips out all that crap, and instead puts the new buffers
onto the buffer list for a dummy inode.  fsync_inode_buffers is used to
flush the list before a commit.  The old way involved pinned pages, so
this should be much more VM friendly.

This is also a building block for a few other patches, so it is important
to get this part right.  It works for me, but I'd really appreciate a
few more testers.  

If you are testing with reiserfs as a module, make sure to recompile 
the entire kernel (in-core inode/super structures have changed).

-chris


diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu May 31 09:55:13 2001
+++ b/fs/reiserfs/inode.c	Thu May 31 09:55:13 2001
@@ -43,7 +43,6 @@
 	windex = push_journal_writer("delete_inode") ;
 
 	reiserfs_delete_object (&th, inode);
-	reiserfs_remove_page_from_flush_list(&th, inode) ;
 	pop_journal_writer(windex) ;
 	reiserfs_release_objectid (&th, inode->i_ino);
 
@@ -102,6 +101,11 @@
     ih->u.ih_entry_count = cpu_to_le16 (entry_count);
 }
 
+static void add_to_flushlist(struct inode *inode, struct buffer_head *bh) {
+    struct inode *jinode = &(SB_JOURNAL(inode->i_sb)->j_dummy_inode) ;
+
+    buffer_insert_inode_queue(bh, jinode) ;
+}
 
 //
 // FIXME: we might cache recently accessed indirect item (or at least
@@ -128,60 +132,6 @@
 ** --chris
 */
 
-/* people who call journal_begin with a page locked must call this
-** BEFORE calling journal_begin
-*/
-static int prevent_flush_page_lock(struct page *page, 
-				   struct inode *inode) {
-  struct reiserfs_page_list *pl ;
-  struct super_block *s = inode->i_sb ;
-  /* we don't care if the inode has a stale pointer from an old
-  ** transaction
-  */
-  if(!page || inode->u.reiserfs_i.i_conversion_trans_id != SB_JOURNAL(s)->j_trans_id) {
-    return 0 ;
-  }
-  pl = inode->u.reiserfs_i.i_converted_page ;
-  if (pl && pl->page == page) {
-    pl->do_not_lock = 1 ;
-  }
-  /* this last part is really important.  The address space operations have
-  ** the page locked before they call the journal functions.  So it is possible
-  ** for one process to be waiting in flush_pages_before_commit for a 
-  ** page, then for the process with the page locked to call journal_begin.
-  **
-  ** We'll deadlock because the process flushing pages will never notice
-  ** the process with the page locked has called prevent_flush_page_lock.
-  ** So, we wake up the page waiters, even though the page is still locked.
-  ** The process waiting in flush_pages_before_commit must check the
-  ** pl->do_not_lock flag, and stop trying to lock the page.
-  */
-  wake_up(&page->wait) ;
-  return 0 ;
- 
-}
-/* people who call journal_end with a page locked must call this
-** AFTER calling journal_end
-*/
-static int allow_flush_page_lock(struct page *page, 
-				   struct inode *inode) {
-
-  struct reiserfs_page_list *pl ;
-  struct super_block *s = inode->i_sb ;
-  /* we don't care if the inode has a stale pointer from an old
-  ** transaction
-  */
-  if(!page || inode->u.reiserfs_i.i_conversion_trans_id != SB_JOURNAL(s)->j_trans_id) {
-    return 0 ;
-  }
-  pl = inode->u.reiserfs_i.i_converted_page ;
-  if (pl && pl->page == page) {
-    pl->do_not_lock = 0 ;
-  }
-  return 0 ;
- 
-}
-
 /* If this page has a file tail in it, and
 ** it was read in by get_block_create_0, the page data is valid,
 ** but tail is still sitting in a direct item, and we can't write to
@@ -593,7 +543,6 @@
 	return -EIO;
     }
 
-    prevent_flush_page_lock(bh_result->b_page, inode) ;
     inode->u.reiserfs_i.i_pack_on_close = 1 ;
 
     windex = push_journal_writer("reiserfs_get_block") ;
@@ -687,7 +636,6 @@
 	if (transaction_started)
 	    journal_end(&th, inode->i_sb, jbegin_count) ;
 
-	allow_flush_page_lock(bh_result->b_page, inode) ;
 	unlock_kernel() ;
 	 
 	/* the item was found, so new blocks were not added to the file
@@ -796,8 +744,12 @@
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
 	    */
-	    reiserfs_add_page_to_flush_list(&th, inode, unbh) ;
-	    mark_buffer_dirty(unbh) ;
+	    add_to_flushlist(inode, unbh) ;
+
+	    /* mark it dirty now to prevent commit_write from adding
+	    ** this buffer to the inode's dirty buffer list
+	    */
+	    __mark_buffer_dirty(unbh) ;
 		  
 	    //inode->i_blocks += inode->i_sb->s_blocksize / 512;
 	    //mark_tail_converted (inode);
@@ -891,7 +843,6 @@
       journal_end(&th, inode->i_sb, jbegin_count) ;
     }
     pop_journal_writer(windex) ;
-    allow_flush_page_lock(bh_result->b_page, inode) ;
     unlock_kernel() ;
     reiserfs_check_path(&path) ;
     return retval;
@@ -1658,13 +1609,11 @@
     ** because the truncate might pack the item anyway 
     ** (it will unmap bh if it packs).
     */
-    prevent_flush_page_lock(page, p_s_inode) ;
     journal_begin(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 ) ;
     windex = push_journal_writer("reiserfs_vfs_truncate_file") ;
     reiserfs_do_truncate (&th, p_s_inode, page, update_timestamps) ;
     pop_journal_writer(windex) ;
     journal_end(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 ) ;
-    allow_flush_page_lock(page, p_s_inode) ;
 
     if (page) {
         length = offset & (blocksize - 1) ;
@@ -1706,7 +1655,6 @@
 
 start_over:
     lock_kernel() ;
-    prevent_flush_page_lock(bh_result->b_page, inode) ;
     journal_begin(&th, inode->i_sb, jbegin_count) ;
 
     make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3) ;
@@ -1772,7 +1720,6 @@
 out:
     pathrelse(&path) ;
     journal_end(&th, inode->i_sb, jbegin_count) ;
-    allow_flush_page_lock(bh_result->b_page, inode) ;
     unlock_kernel() ;
 
     /* this is where we fill in holes in the file. */
@@ -1936,29 +1883,27 @@
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
 
+static int reiserfs_commit_write(struct file *f, struct page *page,
+			         unsigned from, unsigned to) {
+    struct inode *inode = page->mapping->host;
+    int ret ;
 
-static int reiserfs_commit_write(struct file *f, struct page *page, 
-                                 unsigned from, unsigned to) {
-    struct inode *inode = page->mapping->host ;
-    int ret ; 
-    struct reiserfs_transaction_handle th ;
-    
     reiserfs_wait_on_write_block(inode->i_sb) ;
-    lock_kernel();
-    prevent_flush_page_lock(page, inode) ;
     ret = generic_commit_write(f, page, from, to) ;
+
     /* we test for O_SYNC here so we can commit the transaction
     ** for any packed tails the file might have had
     */
     if (f->f_flags & O_SYNC) {
+	struct reiserfs_transaction_handle th ;
+	lock_kernel() ;
 	journal_begin(&th, inode->i_sb, 1) ;
 	reiserfs_prepare_for_journal(inode->i_sb, 
 	                             SB_BUFFER_WITH_SB(inode->i_sb), 1) ;
 	journal_mark_dirty(&th, inode->i_sb, SB_BUFFER_WITH_SB(inode->i_sb)) ;
 	journal_end_sync(&th, inode->i_sb, 1) ;
+	unlock_kernel() ;
     }
-    allow_flush_page_lock(page, inode) ;
-    unlock_kernel();
     return ret ;
 }
 
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 31 09:55:13 2001
+++ b/fs/reiserfs/journal.c	Thu May 31 09:55:13 2001
@@ -114,11 +114,7 @@
 static int reiserfs_clean_and_file_buffer(struct buffer_head *bh) {
   if (bh) {
     clear_bit(BH_Dirty, &bh->b_state) ;
-#if 0
-    if (bh->b_list != BUF_CLEAN) {
-      reiserfs_file_buffer(bh, BUF_CLEAN) ;
-    }
-#endif
+    refile_buffer(bh) ;
   }
   return 0 ;
 }
@@ -1889,6 +1885,7 @@
   memset(journal_writers, 0, sizeof(char *) * 512) ; /* debug code */
 
   INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
+  INIT_LIST_HEAD(&(SB_JOURNAL(p_s_sb)->j_dummy_inode.i_dirty_buffers)) ;
   reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
                                  SB_BMAP_NR(p_s_sb)) ;
   allocate_bitmap_nodes(p_s_sb) ;
@@ -2581,9 +2578,6 @@
 	    ** in the current trans
 	    */
 	    mark_buffer_notjournal_dirty(cn->bh) ;
-	    if (!buffer_locked(cn->bh)) {
-	      reiserfs_clean_and_file_buffer(cn->bh) ;
-	    }
 	    cleaned = 1 ;
 	    atomic_dec(&(cn->bh->b_count)) ;
 	    if (atomic_read(&(cn->bh->b_count)) < 0) {
@@ -2601,6 +2595,7 @@
   }
 
   if (bh) {
+    reiserfs_clean_and_file_buffer(bh) ;
     atomic_dec(&(bh->b_count)) ; /* get_hash incs this */
     if (atomic_read(&(bh->b_count)) < 0) {
       printk("journal-2165: bh->b_count < 0\n") ;
@@ -2655,275 +2650,6 @@
   }
 }
 
-/* 
- * Wait for a page to get unlocked.
- *
- * This must be called with the caller "holding" the page,
- * ie with increased "page->count" so that the page won't
- * go away during the wait..
- */
-static void ___reiserfs_wait_on_page(struct reiserfs_page_list *pl)
-{
-    struct task_struct *tsk = current;
-    struct page *page = pl->page ;
-    DECLARE_WAITQUEUE(wait, tsk);
-
-    add_wait_queue(&page->wait, &wait);
-    do {
-	block_sync_page(page);
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	if (!PageLocked(page) || pl->do_not_lock)
-	    break;
-	schedule();
-    } while (PageLocked(page));
-    tsk->state = TASK_RUNNING;
-    remove_wait_queue(&page->wait, &wait);
-}
-
-/*
- * Get an exclusive lock on the page..
- * but, every time you get woken up, check the page to make sure
- * someone hasn't called a journal_begin with it locked.
- *
- * the page should always be locked when this returns
- *
- * returns 0 if you've got the page locked
- * returns 1 if it returns because someone else has called journal_begin
- *           with the page locked
- * this is only useful to the code that flushes pages before a 
- * commit.  Do not export this hack.  Ever.
- */
-static int reiserfs_try_lock_page(struct reiserfs_page_list *pl)
-{
-    struct page *page = pl->page ;
-    while (TryLockPage(page)) {
-	if (pl->do_not_lock) {
-	    /* the page is locked, but we cannot have it */
-	    return 1 ;
-	}
-	___reiserfs_wait_on_page(pl);
-    }
-    /* we have the page locked */
-    return 0 ;
-}
-
-
-/*
-** This can only be called from do_journal_end.
-** it runs through the list things that need flushing before the
-** transaction can commit, and writes each of them to disk
-**
-*/
-
-static void flush_pages_before_commit(struct reiserfs_transaction_handle *th,
-                                      struct super_block *p_s_sb) {
-  struct reiserfs_page_list *pl = SB_JOURNAL(p_s_sb)->j_flush_pages ;
-  struct reiserfs_page_list *pl_tmp ;
-  struct buffer_head *bh, *head ;
-  int count = 0 ;
-
-  /* first write each dirty unlocked buffer in the list */
-
-  while(pl) {
-    /* ugly.  journal_end can be called from get_block, which has a 
-    ** page locked.  So, we have to check to see if pl->page is the page
-    ** currently locked by the calling function, and if so, skip the
-    ** lock
-    */
-    if (reiserfs_try_lock_page(pl)) {
-      goto setup_next ;
-    }
-    if (!PageLocked(pl->page)) {
-      BUG() ;
-    }
-    if (pl->page->buffers) {
-      head = pl->page->buffers ;
-      bh = head ;
-      do {
-	if (bh->b_blocknr == pl->blocknr && buffer_dirty(bh) &&
-	    !buffer_locked(bh) && buffer_uptodate(bh) ) {
-	  ll_rw_block(WRITE, 1, &bh) ;
-	}
-	bh = bh->b_this_page ;
-      } while (bh != head) ;
-    }
-    if (!pl->do_not_lock) {
-      UnlockPage(pl->page) ;
-    }
-setup_next:
-    pl = pl->next ;
-  }
-
-  /* now wait on them */
-
-  pl = SB_JOURNAL(p_s_sb)->j_flush_pages ;
-  while(pl) {
-    if (reiserfs_try_lock_page(pl)) {
-      goto remove_page ;
-    }
-    if (!PageLocked(pl->page)) {
-      BUG() ;
-    }
-    if (pl->page->buffers) {
-      head = pl->page->buffers ;
-      bh = head ;
-      do {
-	if (bh->b_blocknr == pl->blocknr) {
-	  count++ ;
-	  wait_on_buffer(bh) ;
-	  if (!buffer_uptodate(bh)) {
-	    reiserfs_panic(p_s_sb, "journal-2443: flush_pages_before_commit, error writing block %lu\n", bh->b_blocknr) ;
-	  }
-	}
-	bh = bh->b_this_page ;
-      } while (bh != head) ;
-    }
-    if (!pl->do_not_lock) {
-      UnlockPage(pl->page) ;
-    }
-remove_page:
-    /* we've waited on the I/O, we can remove the page from the
-    ** list, and free our pointer struct to it.
-    */
-    if (pl->prev) {
-      pl->prev->next = pl->next ;
-    }
-    if (pl->next) {
-      pl->next->prev = pl->prev ;
-    }
-    put_page(pl->page) ;
-    pl_tmp = pl ;
-    pl = pl->next ;
-    reiserfs_kfree(pl_tmp, sizeof(struct reiserfs_page_list), p_s_sb) ;
-  }
-  SB_JOURNAL(p_s_sb)->j_flush_pages = NULL ;
-}
-
-/*
-** called when a indirect item is converted back into a tail.
-**
-** The reiserfs part of the inode stores enough information to find
-** our page_list struct in the flush list.  We remove it from the list
-** and free the struct.
-**
-** Note, it is possible for this to happen:
-**
-** reiserfs_add_page_to_flush_list(inode)
-** transaction ends, list is flushed
-** reiserfs_remove_page_from_flush_list(inode)
-**
-** This would be bad because the page_list pointer in the inode is not
-** updated when the list is flushed, so we can't know if the pointer is
-** valid.  So, in the inode, we also store the transaction id when the
-** page was added.  If we are trying to remove something from an old 
-** transaction, we just clear out the pointer in the inode and return.
-**
-** Normal case is to use the reiserfs_page_list pointer in the inode to 
-** find and remove the page from the flush list.
-*/
-int reiserfs_remove_page_from_flush_list(struct reiserfs_transaction_handle *th,
-                                         struct inode *inode) {
-  struct reiserfs_page_list *pl ;
-
-  /* was this conversion done in a previous transaction? If so, return */
-  if (inode->u.reiserfs_i.i_conversion_trans_id < th->t_trans_id) {
-    inode->u.reiserfs_i.i_converted_page = NULL ;
-    inode->u.reiserfs_i.i_conversion_trans_id = 0  ;
-    return 0 ;
-  }
-
-  /* remove the page_list struct from the list, release our hold on the
-  ** page, and free the page_list struct
-  */
-  pl = inode->u.reiserfs_i.i_converted_page ;
-  if (pl) {
-    if (pl->next) {
-      pl->next->prev = pl->prev ;
-    }
-    if (pl->prev) {
-      pl->prev->next = pl->next ;
-    }
-    if (SB_JOURNAL(inode->i_sb)->j_flush_pages == pl) {
-      SB_JOURNAL(inode->i_sb)->j_flush_pages = pl->next ;
-    }
-    put_page(pl->page) ;
-    reiserfs_kfree(pl, sizeof(struct reiserfs_page_list), inode->i_sb) ;
-    inode->u.reiserfs_i.i_converted_page = NULL ;
-    inode->u.reiserfs_i.i_conversion_trans_id = 0 ;
-  }
-  return 0 ;
-}
-
-/*
-** Called after a direct to indirect transaction.  The unformatted node
-** must be flushed to disk before the transaction commits, otherwise, we
-** risk losing the data from the direct item.  This adds the page
-** containing the unformatted node to a list of pages that need flushing.
-**
-** it calls get_page(page), so the page won't disappear until we've
-** flushed or removed it from our list.
-**
-** pointers to the reiserfs_page_list struct are stored in the inode, 
-** so this page can be quickly removed from the list after the tail is
-** converted back into a direct item.
-**
-** If we fail to find the memory for the reiserfs_page_list struct, we
-** just sync the page now.  Not good, but safe.
-**
-** since this must be called with the page locked, we always set
-** the do_not_lock field in the page_list struct we allocate
-**
-*/
-int reiserfs_add_page_to_flush_list(struct reiserfs_transaction_handle *th, 
-                                    struct inode *inode,
-				    struct buffer_head *bh) {
-  struct reiserfs_page_list *new_pl ;
-
-/* debugging use ONLY.  Do not define this on data you care about. */
-#ifdef REISERFS_NO_FLUSH_AFTER_CONVERT
-  return 0 ;
-#endif
-
-  get_page(bh->b_page) ;
-  new_pl = reiserfs_kmalloc(sizeof(struct reiserfs_page_list), GFP_BUFFER,
-                            inode->i_sb) ;
-  if (!new_pl) {
-    put_page(bh->b_page) ;
-    reiserfs_warning("journal-2480: forced to flush page, out of memory\n") ;
-    ll_rw_block(WRITE, 1, &bh) ;
-    wait_on_buffer(bh) ;
-    if (!buffer_uptodate(bh)) {
-      reiserfs_panic(inode->i_sb, "journal-2484: error writing buffer %lu to disk\n", bh->b_blocknr) ;
-    }
-    inode->u.reiserfs_i.i_converted_page = NULL ;
-    return 0 ;
-  }
-
-  new_pl->page = bh->b_page ;
-  new_pl->do_not_lock = 1 ;
-  new_pl->blocknr = bh->b_blocknr ;
-  new_pl->next = SB_JOURNAL(inode->i_sb)->j_flush_pages; 
-  if (new_pl->next) {
-    new_pl->next->prev = new_pl ;
-  }
-  new_pl->prev = NULL ;
-  SB_JOURNAL(inode->i_sb)->j_flush_pages = new_pl ;
-  
-  /* if we have numbers from an old transaction, zero the converted
-  ** page, it has already been flushed and freed
-  */
-  if (inode->u.reiserfs_i.i_conversion_trans_id &&
-      inode->u.reiserfs_i.i_conversion_trans_id < th->t_trans_id) {
-    inode->u.reiserfs_i.i_converted_page = NULL ;
-  }
-  if (inode->u.reiserfs_i.i_converted_page) {
-    reiserfs_panic(inode->i_sb, "journal-2501: inode already had a converted page\n") ;
-  }
-  inode->u.reiserfs_i.i_converted_page = new_pl ;
-  inode->u.reiserfs_i.i_conversion_trans_id = th->t_trans_id ;
-  return 0 ;
-}
-
 /*
 ** long and ugly.  If flush, will not return until all commit
 ** blocks and all real buffers in the trans are on disk.
@@ -3136,11 +2862,8 @@
   jindex = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ; 
   SB_JOURNAL_LIST_INDEX(p_s_sb) = jindex ;
 
-  /* make sure to flush any data converted from direct items to
-  ** indirect items before allowing the commit blocks to reach the
-  ** disk
-  */
-  flush_pages_before_commit(th, p_s_sb) ;
+  /* write any buffers that must hit disk before this commit is done */
+  fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;
 
   /* honor the flush and async wishes from the caller */
   if (flush) {
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Thu May 31 09:55:12 2001
+++ b/fs/reiserfs/stree.c	Thu May 31 09:55:12 2001
@@ -1192,13 +1192,21 @@
 		/* Search for the buffer in cache. */
 		p_s_un_bh = get_hash_table(p_s_sb->s_dev, *p_n_unfm_pointer, n_blk_size);
 
-		if (p_s_un_bh && buffer_locked(p_s_un_bh)) {
-		  __wait_on_buffer(p_s_un_bh) ;
-		  if ( item_moved (&s_ih, p_s_path) )  {
-		      need_research = 1;
-		      brelse(p_s_un_bh) ;
-		      break ;
-		  }
+		if (p_s_un_bh) {
+		    mark_buffer_clean(p_s_un_bh) ;
+		    if (buffer_locked(p_s_un_bh)) {
+		        __wait_on_buffer(p_s_un_bh) ;
+		    }
+		    /* even if the item moves, the block number of the
+		    ** unformatted node we want to cut won't.  So, it was
+		    ** safe to clean the buffer here, this block _will_
+		    ** get freed during this call to prepare_for_delete_or_cut
+		    */
+		    if ( item_moved (&s_ih, p_s_path) )  {
+		        need_research = 1;
+		        brelse(p_s_un_bh) ;
+		        break ;
+		    }
 		}
 		if ( p_s_un_bh && block_in_use (p_s_un_bh)) {
 		    /* Block is locked or held more than by one holder and by
@@ -1243,30 +1251,7 @@
 		if ( item_moved (&s_ih, p_s_path) )  {
 		    need_research = 1;
 		    break ;
-#if 0
-		    reiserfs_prepare_for_journal(p_s_sb, 
-		                                 PATH_PLAST_BUFFER(p_s_path),
-						 1) ;
-		    if ( comp_items(&s_ih, p_s_path) )  {
-		      reiserfs_restore_prepared_buffer(p_s_sb, 
-		                               PATH_PLAST_BUFFER(p_s_path)) ;
-		      brelse(p_s_un_bh);
-		      break;
-		    }
-		    *p_n_unfm_pointer = 0;
-		    journal_mark_dirty (th,p_s_sb,PATH_PLAST_BUFFER(p_s_path));
-
-		    reiserfs_free_block(th, p_s_sb, block_addr);
-		    if (p_s_un_bh) {
-			mark_buffer_clean (p_s_un_bh);
-			brelse (p_s_un_bh);
-		    }
-		    if ( comp_items(&s_ih, p_s_path) )  {
-		      break ;
-		    }
-#endif
 		}
-
 	    }
 
 	    /* a trick.  If the buffer has been logged, this
@@ -1793,11 +1778,11 @@
     
     do_balance(&s_cut_balance, NULL, NULL, c_mode);
     if ( n_is_inode_locked ) {
-        /* we've converted from indirect to direct, we must remove
-	** ourselves from the list of pages that need flushing before
-	** this transaction can commit
+	/* we've done an indirect->direct conversion.  when the data block 
+	** was freed, it was removed from the list of blocks that must 
+	** be flushed before the transaction commits, so we don't need to 
+	** deal with it here.
 	*/
-	reiserfs_remove_page_from_flush_list(th, p_s_inode) ;
 	p_s_inode->u.reiserfs_i.i_pack_on_close = 0 ;
     }
     return n_ret_value;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu May 31 09:55:13 2001
+++ b/include/linux/reiserfs_fs.h	Thu May 31 09:55:13 2001
@@ -1541,29 +1541,6 @@
   __u32 j_mount_id ;
 } ;
 
-/* these are used to keep flush pages that contain converted direct items.
-** if the page is not flushed before the transaction that converted it
-** is committed, we risk losing data
-**
-** note, while a page is in this list, its counter is incremented.
-*/
-struct reiserfs_page_list {
-  struct reiserfs_page_list *next ;
-  struct reiserfs_page_list *prev ;
-  struct page *page ;
-  unsigned long blocknr ; /* block number holding converted data */
-
-  /* if a transaction writer has the page locked the flush_page_list
-  ** function doesn't need to (and can't) get the lock while flushing
-  ** the page.  do_not_lock needs to be set by anyone who calls journal_end
-  ** with a page lock held.  They have to look in the inode and see
-  ** if the inode has the page they have locked in the flush list.
-  **
-  ** this sucks.
-  */
-  int do_not_lock ; 
-} ;
-
 extern task_queue reiserfs_commit_thread_tq ;
 extern wait_queue_head_t reiserfs_commit_thread_wait ;
 
diff -Nru a/include/linux/reiserfs_fs_i.h b/include/linux/reiserfs_fs_i.h
--- a/include/linux/reiserfs_fs_i.h	Thu May 31 09:55:13 2001
+++ b/include/linux/reiserfs_fs_i.h	Thu May 31 09:55:13 2001
@@ -3,11 +3,6 @@
 
 #include <linux/list.h>
 
-/* these are used to keep track of the pages that need
-** flushing before the current transaction can commit
-*/
-struct reiserfs_page_list ;
-
 struct reiserfs_inode_info {
   __u32 i_key [4];/* key is still 4 32 bit integers */
   
@@ -21,21 +16,6 @@
   int i_pack_on_close ; // file might need tail packing on close 
 
   __u32 i_first_direct_byte; // offset of first byte stored in direct item.
-
-  /* pointer to the page that must be flushed before 
-  ** the current transaction can commit.
-  **
-  ** this pointer is only used when the tail is converted back into
-  ** a direct item, or the file is deleted
-  */
-  struct reiserfs_page_list *i_converted_page ;
-
-  /* we save the id of the transaction when we did the direct->indirect
-  ** conversion.  That allows us to flush the buffers to disk
-  ** without having to update this inode to zero out the converted
-  ** page variable
-  */
-  int i_conversion_trans_id ;
 
 				/* My guess is this contains the first
                                    unused block of a sequence of
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Thu May 31 09:55:13 2001
+++ b/include/linux/reiserfs_fs_sb.h	Thu May 31 09:55:13 2001
@@ -249,6 +249,7 @@
   int j_free_bitmap_nodes ;
   int j_used_bitmap_nodes ;
   struct list_head j_bitmap_nodes ;
+  struct inode j_dummy_inode ;
   struct reiserfs_list_bitmap j_list_bitmap[JOURNAL_NUM_BITMAPS] ;	/* array of bitmaps to record the deleted blocks */
   struct reiserfs_journal_list j_journal_list[JOURNAL_LIST_COUNT] ;	    /* array of all the journal lists */
   struct reiserfs_journal_cnode *j_hash_table[JOURNAL_HASH_SIZE] ; 	    /* hash table for real buffer heads in current trans */ 

