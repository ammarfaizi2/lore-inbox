Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSFAImr>; Sat, 1 Jun 2002 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFAIlu>; Sat, 1 Jun 2002 04:41:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55562 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317002AbSFAIlG>;
	Sat, 1 Jun 2002 04:41:06 -0400
Message-ID: <3CF88968.442B5026@zip.com.au>
Date: Sat, 01 Jun 2002 01:44:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/16] rename flushpage to invalidatepage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a pet peeve: the identifier "flushpage" implies "flush the page
to disk".  Which is very much not what the flushpage functions actually
do.

The patch renames block_flushpage and the flushpage
address_space_operation to "invalidatepage".

It also fixes a buglet in invalidate_this_page2(), which was calling
block_flushpage() directly - it needs to call do_flushpage() (now
do_invalidatepage()) so that the filesystem's ->flushpage (now
->invalidatepage) a_op gets a chance to relinquish any interest which
it has in the page's buffers.


=====================================

--- 2.5.19/fs/buffer.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/buffer.c	Sat Jun  1 01:18:14 2002
@@ -1341,22 +1341,21 @@ int try_to_release_page(struct page *pag
 }
 
 /**
- * block_flushpage - invalidate part of all of a buffer-backed page
+ * block_invalidatepage - invalidate part of all of a buffer-backed page
  *
  * @page: the page which is affected
  * @offset: the index of the truncation point
  *
- * block_flushpage() should be called block_invalidatepage().  It is
- * called when all or part of the page has become invalidatedby a truncate
- * operation.
+ * block_invalidatepage() is called when all or part of the page has become
+ * invalidatedby a truncate operation.
  *
- * block_flushpage() does not have to release all buffers, but it must
+ * block_invalidatepage() does not have to release all buffers, but it must
  * ensure that no dirty buffer is left outside @offset and that no I/O
  * is underway against any of the blocks which are outside the truncation
  * point.  Because the caller is about to free (and possibly reuse) those
  * blocks on-disk.
  */
-int block_flushpage(struct page *page, unsigned long offset)
+int block_invalidatepage(struct page *page, unsigned long offset)
 {
 	struct buffer_head *head, *bh, *next;
 	unsigned int curr_off = 0;
@@ -1393,7 +1392,7 @@ int block_flushpage(struct page *page, u
 
 	return 1;
 }
-EXPORT_SYMBOL(block_flushpage);
+EXPORT_SYMBOL(block_invalidatepage);
 
 /*
  * We attach and possibly dirty the buffers atomically wrt
@@ -2276,10 +2275,11 @@ int brw_kiovec(int rw, int nr, struct ki
  *        some of the bmap kludges and interface ugliness here.
  *
  * NOTE: unlike file pages, swap pages are locked while under writeout.
- * This is to avoid a deadlock which occurs when free_swap_and_cache()
- * calls block_flushpage() under spinlock and hits a locked buffer, and
- * schedules under spinlock.   Another approach would be to teach
- * find_trylock_page() to also trylock the page's writeback flags.
+ * This is to throttle processes which reuse their swapcache pages while
+ * they are under writeout, and to ensure that there is no I/O going on
+ * when the page has been successfully locked.  Functions such as
+ * free_swap_and_cache() need to guarantee that there is no I/O in progress
+ * because they will be freeing up swap blocks, which may then be reused.
  *
  * Swap pages are also marked PageWriteback when they are being written
  * so that memory allocators will throttle on them.
--- 2.5.19/fs/jfs/jfs_metapage.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/jfs/jfs_metapage.c	Sat Jun  1 01:18:14 2002
@@ -537,7 +537,7 @@ void release_metapage(metapage_t * mp)
 
 			if (test_bit(META_discard, &mp->flag)) {
 				lock_page(mp->page);
-				block_flushpage(mp->page, 0);
+				block_invalidatepage(mp->page, 0);
 				unlock_page(mp->page);
 			}
 
@@ -590,13 +590,13 @@ void invalidate_metapages(struct inode *
 			 * If in the metapage cache, we've got the page locked
 			 */
 			lock_page(mp->page);
-			block_flushpage(mp->page, 0);
+			block_invalidatepage(mp->page, 0);
 			unlock_page(mp->page);
 		} else {
 			spin_unlock(&meta_lock);
 			page = find_lock_page(mapping, lblock>>l2BlocksPerPage);
 			if (page) {
-				block_flushpage(page, 0);
+				block_invalidatepage(page, 0);
 				unlock_page(page);
 			}
 		}
--- 2.5.19/include/linux/buffer_head.h~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/include/linux/buffer_head.h	Sat Jun  1 01:18:14 2002
@@ -191,7 +191,7 @@ void FASTCALL(unlock_buffer(struct buffe
  * address_spaces.
  */
 int try_to_release_page(struct page * page, int gfp_mask);
-int block_flushpage(struct page *page, unsigned long offset);
+int block_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page*, get_block_t*);
 int block_read_full_page(struct page*, get_block_t*);
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
--- 2.5.19/mm/filemap.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/mm/filemap.c	Sat Jun  1 01:18:14 2002
@@ -23,7 +23,7 @@
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
- *  - block_flushpage
+ *  - block_invalidatepage
  *  - page_has_buffers
  *  - generic_osync_inode
  *
@@ -154,30 +154,30 @@ unlock:
 	spin_unlock(&pagemap_lru_lock);
 }
 
-static int do_flushpage(struct page *page, unsigned long offset)
+static int do_invalidatepage(struct page *page, unsigned long offset)
 {
-	int (*flushpage) (struct page *, unsigned long);
-	flushpage = page->mapping->a_ops->flushpage;
-	if (flushpage)
-		return (*flushpage)(page, offset);
-	return block_flushpage(page, offset);
+	int (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage;
+	if (invalidatepage)
+		return (*invalidatepage)(page, offset);
+	return block_invalidatepage(page, offset);
 }
 
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
 	if (PagePrivate(page))
-		do_flushpage(page, partial);
+		do_invalidatepage(page, partial);
 }
 
 /*
  * AKPM: the PagePrivate test here seems a bit bogus.  It bypasses the
- * mapping's ->flushpage, which may still want to be called.
+ * mapping's ->invalidatepage, which may still want to be called.
  */
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!PagePrivate(page) || do_flushpage(page, 0))
+	if (!PagePrivate(page) || do_invalidatepage(page, 0))
 		lru_cache_del(page);
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
@@ -339,7 +339,7 @@ static inline int invalidate_this_page2(
 
 			page_cache_get(page);
 			write_unlock(&mapping->page_lock);
-			block_flushpage(page, 0);
+			do_invalidatepage(page, 0);
 		} else
 			unlocked = 0;
 
--- 2.5.19/Documentation/filesystems/Locking~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/Documentation/filesystems/Locking	Sat Jun  1 01:18:14 2002
@@ -138,7 +138,7 @@ prototypes:
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*bmap)(struct address_space *, long);
-	int (*flushpage) (struct page *, unsigned long);
+	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
 
@@ -156,7 +156,7 @@ set_page_dirty		no	no
 prepare_write:		no	yes
 commit_write:		no	yes
 bmap:			yes
-flushpage:		no	yes
+invalidatepage:		no	yes
 releasepage:		no	yes
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
@@ -206,10 +206,10 @@ filesystems and by the swapper. The latt
 instances do not actually need the BKL. Please, keep it that way and don't
 breed new callers.
 
-	->flushpage() is called when the filesystem must attempt to drop
+	->invalidatepage() is called when the filesystem must attempt to drop
 some or all of the buffers from the page when it is being truncated.  It
-returns zero on success.  If ->flushpage is zero, the kernel uses
-block_flushpage() instead.
+returns zero on success.  If ->invalidatepage is zero, the kernel uses
+block_invalidatepage() instead.
 
 	->releasepage() is called when the kernel is about to try to drop the
 buffers from the page in preparation for freeing it.  It returns zero to
--- 2.5.19/fs/ext3/inode.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/ext3/inode.c	Sat Jun  1 01:18:14 2002
@@ -1364,10 +1364,10 @@ ext3_readpages(struct address_space *map
 	return mpage_readpages(mapping, pages, nr_pages, ext3_get_block);
 }
 
-static int ext3_flushpage(struct page *page, unsigned long offset)
+static int ext3_invalidatepage(struct page *page, unsigned long offset)
 {
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
-	return journal_flushpage(journal, page, offset);
+	return journal_invalidatepage(journal, page, offset);
 }
 
 static int ext3_releasepage(struct page *page, int wait)
@@ -1385,7 +1385,7 @@ struct address_space_operations ext3_aop
 	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */
 	commit_write:	ext3_commit_write,	/* BKL not held.  We take it */
 	bmap:		ext3_bmap,		/* BKL held */
-	flushpage:	ext3_flushpage,		/* BKL not held.  Don't need */
+	invalidatepage:	ext3_invalidatepage,	/* BKL not held.  Don't need */
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
 };
 
@@ -1413,7 +1413,7 @@ struct address_space_operations ext3_wri
 	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */
 	commit_write:	ext3_commit_write,	/* BKL not held.  We take it */
 	bmap:		ext3_bmap,		/* BKL held */
-	flushpage:	ext3_flushpage,		/* BKL not held.  Don't need */
+	invalidatepage:	ext3_invalidatepage,	/* BKL not held.  Don't need */
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
 };
 
--- 2.5.19/fs/jbd/journal.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/jbd/journal.c	Sat Jun  1 01:18:14 2002
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(log_wait_commit);
 EXPORT_SYMBOL(log_start_commit);
 EXPORT_SYMBOL(journal_wipe);
 EXPORT_SYMBOL(journal_blocks_per_page);
-EXPORT_SYMBOL(journal_flushpage);
+EXPORT_SYMBOL(journal_invalidatepage);
 EXPORT_SYMBOL(journal_try_to_free_buffers);
 EXPORT_SYMBOL(journal_bmap);
 EXPORT_SYMBOL(journal_force_commit);
--- 2.5.19/fs/jbd/transaction.c~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/jbd/transaction.c	Sat Jun  1 01:18:14 2002
@@ -1749,13 +1749,13 @@ static int dispose_buffer(struct journal
 }
 
 /*
- * journal_flushpage 
+ * journal_invalidatepage 
  *
  * This code is tricky.  It has a number of cases to deal with.
  *
  * There are two invariants which this code relies on:
  *
- * i_size must be updated on disk before we start calling flushpage on the
+ * i_size must be updated on disk before we start calling invalidatepage on the
  * data.
  * 
  *  This is done in ext3 by defining an ext3_setattr method which
@@ -1891,7 +1891,7 @@ zap_buffer:	
 /*
  * Return non-zero if the page's buffers were successfully reaped
  */
-int journal_flushpage(journal_t *journal, 
+int journal_invalidatepage(journal_t *journal, 
 		      struct page *page, 
 		      unsigned long offset)
 {
--- 2.5.19/include/linux/fs.h~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/include/linux/fs.h	Sat Jun  1 01:18:14 2002
@@ -306,7 +306,7 @@ struct address_space_operations {
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	int (*bmap)(struct address_space *, long);
-	int (*flushpage) (struct page *, unsigned long);
+	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
--- 2.5.19/include/linux/jbd.h~block_invalidatepage	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/include/linux/jbd.h	Sat Jun  1 01:18:14 2002
@@ -641,7 +641,8 @@ extern int	 journal_dirty_metadata (hand
 extern void	 journal_release_buffer (handle_t *, struct buffer_head *);
 extern void	 journal_forget (handle_t *, struct buffer_head *);
 extern void	 journal_sync_buffer (struct buffer_head *);
-extern int	 journal_flushpage(journal_t *, struct page *, unsigned long);
+extern int	 journal_invalidatepage(journal_t *,
+				struct page *, unsigned long);
 extern int	 journal_try_to_free_buffers(journal_t *, struct page *, int);
 extern int	 journal_stop(handle_t *);
 extern int	 journal_flush (journal_t *);

-
