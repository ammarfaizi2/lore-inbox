Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274577AbRITRj0>; Thu, 20 Sep 2001 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274580AbRITRjU>; Thu, 20 Sep 2001 13:39:20 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:16393 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274577AbRITRjF>; Thu, 20 Sep 2001 13:39:05 -0400
Message-ID: <3BAA29C2.A9718F49@zip.com.au>
Date: Thu, 20 Sep 2001 10:39:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>,
		<20010920170812.CCCACE641B@ns1.suse.com> <773660000.1001006393@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Thursday, September 20, 2001 07:08:25 PM +0200 Dieter Nützel
> <Dieter.Nuetzel@hamburg.de> wrote:
> 
> > Please have a look at Robert Love's Linux kernel preemption patches and
> > the  conversation about my reported latency results.
> >
> 
> Andrew Morton has patches that significantly improve the reiserfs latency,
> looks like the last one he sent me was 2.4.7-pre9.  He and I did a bunch of
> work to make sure they introduce schedules only when it was safe.
> 
> Andrew, are these still maintained or should I pull out the reiserfs bits?
> 

This is the reiserfs part - it applies to 2.4.10-pre12 OK.

For the purposes of Robert's patch, conditional_schedule()
should be defined as 

	if (current->need_resched && current->lock_depth == 0) {
		unlock_kernel();
		lock_kernel();
	}

which is somewhat crufty, because the implementation of lock_kernel()
is arch-specific.  But all architectures seem to implement it the same way.



--- linux-2.4.7/include/linux/reiserfs_fs.h	Sat Jul 21 12:37:14 2001
+++ linux-akpm/include/linux/reiserfs_fs.h	Sun Jul 22 22:06:17 2001
@@ -1165,8 +1165,8 @@ extern inline loff_t max_reiserfs_offset
 #define fs_generation(s) ((s)->u.reiserfs_sb.s_generation_counter)
 #define get_generation(s) atomic_read (&fs_generation(s))
 #define FILESYSTEM_CHANGED_TB(tb)  (get_generation((tb)->tb_sb) != (tb)->fs_gen)
-#define fs_changed(gen,s) (gen != get_generation (s))
-
+#define __fs_changed(gen,s) (gen != get_generation (s))
+#define fs_changed(gen,s) ({conditional_schedule(); __fs_changed(gen,s);})
 
 /***************************************************************************/
 /*                  FIXATE NODES                                           */
--- linux-2.4.7/fs/reiserfs/bitmap.c	Wed May  2 22:00:06 2001
+++ linux-akpm/fs/reiserfs/bitmap.c	Sun Jul 22 22:06:17 2001
@@ -420,19 +420,31 @@ free_and_return:
     }
        
 
-    reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[i], 1) ;
 
+/* this check needs to go before preparing the buffer because that can
+** schedule when low-latency patches are in use.  It is ok if the buffer
+** is locked, preparing it will wait on it, and we handle the case where
+** this block was allocated while we sleep below.
+*/
 #ifdef CONFIG_REISERFS_CHECK
-    if (buffer_locked (SB_AP_BITMAP (s)[i]) || is_reusable (s, search_start, 0) == 0)
-	reiserfs_panic (s, "vs-4140: reiserfs_new_blocknrs: bitmap block is locked or bad block number found");
+    if (is_reusable (s, search_start, 0) == 0)
+	reiserfs_panic (s, "vs-4140: reiserfs_new_blocknrs: bad block number found");
 #endif
 
+    reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[i], 1) ;
+
     /* if this bit was already set, we've scheduled, and someone else
     ** has allocated it.  loop around and try again
     */
     if (reiserfs_test_and_set_le_bit (j, SB_AP_BITMAP (s)[i]->b_data)) {
 	reiserfs_warning("vs-4150: reiserfs_new_blocknrs, block not free");
 	reiserfs_restore_prepared_buffer(s, SB_AP_BITMAP(s)[i]) ;
+	/* if this block has been allocated while we slept, it is
+	** impossible to find any more contiguous blocks for ourselves.
+	** If we are doing preallocation, give up now and return.
+	*/
+	if (for_prealloc)
+	    goto free_and_return ;
 	amount_needed++ ;
 	continue ;
     }    
--- linux-2.4.7/fs/reiserfs/buffer2.c	Tue Jan 16 10:31:19 2001
+++ linux-akpm/fs/reiserfs/buffer2.c	Sun Jul 22 22:06:17 2001
@@ -73,7 +73,9 @@ void wait_buffer_until_released (struct 
 
 struct buffer_head  * reiserfs_bread (kdev_t n_dev, int n_block, int n_size) 
 {
-    return bread (n_dev, n_block, n_size);
+    struct buffer_head *ret = bread (n_dev, n_block, n_size);
+    conditional_schedule();
+    return ret;
 }
 
 /* This function looks for a buffer which contains a given block.  If
--- linux-2.4.7/fs/reiserfs/journal.c	Sat Jul 21 12:37:14 2001
+++ linux-akpm/fs/reiserfs/journal.c	Sun Jul 22 22:06:17 2001
@@ -577,6 +577,7 @@ inline void insert_journal_hash(struct r
 
 /* lock the current transaction */
 inline static void lock_journal(struct super_block *p_s_sb) {
+  conditional_schedule();
   while(atomic_read(&(SB_JOURNAL(p_s_sb)->j_wlock)) > 0) {
     sleep_on(&(SB_JOURNAL(p_s_sb)->j_wait)) ;
   }
@@ -706,6 +707,7 @@ reiserfs_panic(s, "journal-539: flush_co
 	mark_buffer_dirty(tbh) ;
       }
       ll_rw_block(WRITE, 1, &tbh) ;
+      conditional_schedule();
       count++ ;
       put_bh(tbh) ; /* once for our get_hash */
     } 
@@ -833,6 +835,7 @@ static int update_journal_header_block(s
     set_bit(BH_Dirty, &(SB_JOURNAL(p_s_sb)->j_header_bh->b_state)) ;
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
     wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+    conditional_schedule();
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
       reiserfs_panic(p_s_sb, "journal-712: buffer write failed\n") ;
     }
@@ -2076,6 +2079,7 @@ int journal_join(struct reiserfs_transac
 }
 
 int journal_begin(struct reiserfs_transaction_handle *th, struct super_block  * p_s_sb, unsigned long nblocks) {
+  conditional_schedule();
   return do_journal_begin_r(th, p_s_sb, nblocks, 0) ;
 }
 
@@ -2213,6 +2217,7 @@ int journal_mark_dirty_nolog(struct reis
 }
 
 int journal_end(struct reiserfs_transaction_handle *th, struct super_block *p_s_sb, unsigned long nblocks) {
+  conditional_schedule();
   return do_journal_end(th, p_s_sb, nblocks, 0) ;
 }
 
@@ -2648,6 +2653,7 @@ void reiserfs_prepare_for_journal(struct
       }
 #endif
       wait_on_buffer(bh) ;
+      conditional_schedule();
     }
     retry_count++ ;
   }
@@ -2820,6 +2826,7 @@ printk("journal-2020: do_journal_end: BA
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
+      conditional_schedule();		/* getblk can sleep, so... */
       tmp_bh = getblk(p_s_sb->s_dev, reiserfs_get_journal_block(p_s_sb) + 
 		     ((cur_write_start + jindex) % JOURNAL_BLOCK_COUNT), 
 				       p_s_sb->s_blocksize) ;
--- linux-2.4.7/fs/reiserfs/stree.c	Sat Jul 21 12:37:14 2001
+++ linux-akpm/fs/reiserfs/stree.c	Sun Jul 22 22:06:17 2001
@@ -681,9 +681,9 @@ int search_by_key (struct super_block * 
                                        DISK_LEAF_NODE_LEVEL */
     ) {
     kdev_t n_dev = p_s_sb->s_dev;
-    int  n_block_number = SB_ROOT_BLOCK (p_s_sb),
-      expected_level = SB_TREE_HEIGHT (p_s_sb),
-      n_block_size    = p_s_sb->s_blocksize;
+    int n_block_number; 
+    int expected_level;
+    int n_block_size = p_s_sb->s_blocksize;
     struct buffer_head  *       p_s_bh;
     struct path_element *       p_s_last_element;
     int				n_node_level, n_retval;
@@ -694,6 +694,8 @@ int search_by_key (struct super_block * 
     int n_repeat_counter = 0;
 #endif
 
+    conditional_schedule();
+
     /* As we add each node to a path we increase its count.  This means that
        we must be careful to release all nodes in a path before we either
        discard the path struct or re-use the path struct, as we do here. */
@@ -705,6 +707,9 @@ int search_by_key (struct super_block * 
     /* With each iteration of this loop we search through the items in the
        current node, and calculate the next current node(next path element)
        for the next iteration of this loop.. */
+    fs_gen = get_generation (p_s_sb);
+    n_block_number = SB_ROOT_BLOCK (p_s_sb);
+    expected_level = SB_TREE_HEIGHT (p_s_sb);
     while ( 1 ) {
 
 #ifdef CONFIG_REISERFS_CHECK
@@ -1174,6 +1179,8 @@ static char  prepare_for_delete_or_cut(
 	    for ( n_retry = 0, n_counter = *p_n_removed;
 		  n_counter < n_unfm_number; n_counter++, p_n_unfm_pointer-- )  {
 
+		conditional_schedule();
+
 		if (item_moved (&s_ih, p_s_path)) {
 		    need_research = 1 ;
 		    break;
@@ -1191,6 +1198,16 @@ static char  prepare_for_delete_or_cut(
 		}
 		/* Search for the buffer in cache. */
 		p_s_un_bh = get_hash_table(p_s_sb->s_dev, *p_n_unfm_pointer, n_blk_size);
+
+		/* AKPM: this is not _really_ needed.  It takes us from 2,000 usecs to 500 */
+		if (p_s_un_bh && conditional_schedule_needed()) {
+		  unconditional_schedule();
+		  if ( item_moved (&s_ih, p_s_path) )  {
+		      need_research = 1;
+		      brelse(p_s_un_bh) ;
+		      break ;
+		  }
+		}
 
 		if (p_s_un_bh) {
 		    mark_buffer_clean(p_s_un_bh) ;
