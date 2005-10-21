Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVJURpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVJURpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVJURpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:45:47 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:63848 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965041AbVJURpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:45:46 -0400
Message-ID: <435928BC.5000509@oracle.com>
Date: Fri, 21 Oct 2005 10:43:24 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org> <43544499.5010601@oracle.com>
In-Reply-To: <43544499.5010601@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We think we could do this sort of thing with a specific truncation loop,
> but that's the nasty code I wasn't sure would be any more acceptable
> than this nasty core patch.

OK, I'm appending a patch which attempts to solve this problem in OCFS2 code
instead of up in the VFS.  It's against a branch in OCFS2 svn, but one which
isn't incomprehensibly different from what is in -mm.

The idea is to stop the DLM thread from deadlocking on locked pages (which are
held by other tasks waiting for the DLM) by tagging them with PG_fs_misc.  The
DLM thread knows that the pages are locked by callers who are waiting for the
thread so they can assume ownership of the page lock, of a sort.  The DLM
thread writes back dirty data in the page manually so it doesn't unlock the
callers page.  It can basically ignore clean pages because they're going to be
reread by the lock holder once they get the DLM lock.  Comments in the patch
above ocfs2_data_convert_worker, get_lock_or_fs_misc,
ocfs2_write_dirty_fs_misc_page, and ocfs2_set_fs_misc lay this out.

It introduces block_read_full_page() and truncate_inode_pages() derivatives
which understand the PG_fs_misc special case.  It needs a few export patches to
the core, but the real burden is on OCFS2 to keep these derivatives up to date.
Maybe after they stabilize for a while, and say another clustered file system
has similar problems, we could roll some core helpers out of them.  But for now
it illustrates what the solution would look like in OCFS2.  I'm sure I missed
some corner cases, but this passes the most basic functional testing.

The specific exports it needs from 2.6.14-rc4-mm1 are:

$ grep '+EXPORT' patches/*.patch
patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(__wake_up_bit_all);
patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(wake_up_page_all);
patches/export-pagevec-helpers.patch:+EXPORT_SYMBOL_GPL(pagevec_lookup);
patches/export-page_waitqueue.patch:+EXPORT_SYMBOL_GPL(page_waitqueue);
patches/export-truncate_complete_pate.patch:+EXPORT_SYMBOL(truncate_complete_page);
patches/export-wake_up_page.patch:+EXPORT_SYMBOL(wake_up_page);

that wake_up_page_all() is just a variant that provides 0 nr_exclusive to
__wake_up_bit():

-void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
+static inline int __wake_up_bit_nr(wait_queue_head_t *wq, void *word, int bit,
+                                  int nr_exclusive)
 {
        struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
        if (waitqueue_active(wq))
-               __wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
+               __wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE,
+                         nr_exclusive, &key);
+}
+
+void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
+{
+       __wake_up_bit_nr(wq, word, bit, 1);
 }
 EXPORT_SYMBOL(__wake_up_bit);

+void fastcall __wake_up_bit_all(wait_queue_head_t *wq, void *word, int bit)
+{
+       __wake_up_bit_nr(wq, word, bit, 0);
+}
+EXPORT_SYMBOL(__wake_up_bit_all);

Is this preferable to the core changes and is it something that's mergeable?
We'd love to come to a solution that won't be a barrier to merging so we can
get on with it.  I can send that exporting series if we decide this is the
right thing.

- z

Index: fs/ocfs2/dlmglue.h
===================================================================
--- fs/ocfs2/dlmglue.h	(revision 2660)
+++ fs/ocfs2/dlmglue.h	(working copy)
@@ -54,6 +54,8 @@ int ocfs2_create_new_inode_locks(struct
 int ocfs2_drop_inode_locks(struct inode *inode);
 int ocfs2_data_lock(struct inode *inode,
 		    int write);
+int ocfs2_data_lock_holding_page(struct inode *inode, int write,
+			         struct page *page);
 void ocfs2_data_unlock(struct inode *inode,
 		       int write);
 int ocfs2_rw_lock(struct inode *inode, int write);
@@ -70,6 +72,11 @@ int ocfs2_meta_lock_full(struct inode *i
 /* 99% of the time we don't want to supply any additional flags --
  * those are for very specific cases only. */
 #define ocfs2_meta_lock(i, h, b, e) ocfs2_meta_lock_full(i, h, b, e, 0)
+int ocfs2_meta_lock_holding_page(struct inode *inode,
+				 ocfs2_journal_handle *handle,
+				 struct buffer_head **ret_bh,
+				 int ex,
+				 struct page *page);
 void ocfs2_meta_unlock(struct inode *inode,
 		       int ex);
 int ocfs2_super_lock(ocfs2_super *osb,
Index: fs/ocfs2/aops.c
===================================================================
--- fs/ocfs2/aops.c	(revision 2661)
+++ fs/ocfs2/aops.c	(working copy)
@@ -130,8 +130,8 @@ bail:
 	return err;
 }

-static int ocfs2_get_block(struct inode *inode, sector_t iblock,
-			   struct buffer_head *bh_result, int create)
+int ocfs2_get_block(struct inode *inode, sector_t iblock,
+		    struct buffer_head *bh_result, int create)
 {
 	int err = 0;
 	u64 p_blkno, past_eof;
@@ -198,7 +198,7 @@ static int ocfs2_readpage(struct file *f

 	mlog_entry("(0x%p, %lu)\n", file, (page ? page->index : 0));

-	ret = ocfs2_meta_lock(inode, NULL, NULL, 0);
+	ret = ocfs2_meta_lock_holding_page(inode, NULL, NULL, 0, page);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out;
@@ -226,7 +226,7 @@ static int ocfs2_readpage(struct file *f
 		goto out_alloc;
 	}

-	ret = ocfs2_data_lock(inode, 0);
+	ret = ocfs2_data_lock_holding_page(inode, 0, page);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out_alloc;
@@ -283,7 +283,7 @@ int ocfs2_prepare_write(struct file *fil

 	mlog_entry("(0x%p, 0x%p, %u, %u)\n", file, page, from, to);

-	ret = ocfs2_meta_lock(inode, NULL, NULL, 0);
+	ret = ocfs2_meta_lock_holding_page(inode, NULL, NULL, 0, page);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out;
@@ -397,13 +397,14 @@ static int ocfs2_commit_write(struct fil
 		locklevel = 1;
 	}

-	ret = ocfs2_meta_lock(inode, NULL, &di_bh, locklevel);
+	ret = ocfs2_meta_lock_holding_page(inode, NULL, &di_bh, locklevel,
+					   page);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out;
 	}

-	ret = ocfs2_data_lock(inode, 1);
+	ret = ocfs2_data_lock_holding_page(inode, 1, page);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out_unlock_meta;
Index: fs/ocfs2/aops.h
===================================================================
--- fs/ocfs2/aops.h	(revision 2660)
+++ fs/ocfs2/aops.h	(working copy)
@@ -22,6 +22,8 @@
 #ifndef OCFS2_AOPS_H
 #define OCFS2_AOPS_H

+int ocfs2_get_block(struct inode *inode, sector_t iblock,
+		    struct buffer_head *bh_result, int create);
 int ocfs2_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to);

Index: fs/ocfs2/dlmglue.c
===================================================================
--- fs/ocfs2/dlmglue.c	(revision 2660)
+++ fs/ocfs2/dlmglue.c	(working copy)
@@ -30,6 +30,8 @@
 #include <linux/smp_lock.h>
 #include <linux/crc32.h>
 #include <linux/kthread.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>

 #include <cluster/heartbeat.h>
 #include <cluster/nodemanager.h>
@@ -43,6 +45,7 @@
 #include "ocfs2.h"

 #include "alloc.h"
+#include "aops.h"
 #include "dlmglue.h"
 #include "extent_map.h"
 #include "heartbeat.h"
@@ -113,9 +116,6 @@ static struct ocfs2_lock_res_ops ocfs2_i
 	.unblock	= ocfs2_unblock_meta,
 };

-static void ocfs2_data_convert_worker(struct ocfs2_lock_res *lockres,
-				      int blocking);
-
 static struct ocfs2_lock_res_ops ocfs2_inode_data_lops = {
 	.ast		= ocfs2_inode_ast_func,
 	.bast		= ocfs2_inode_bast_func,
@@ -1154,6 +1154,43 @@ out:
 	return status;
 }

+/*
+ * The use of PG_fs_misc here is working around a lock ordering inversion.
+ * We're indicating to the DLM vote thread (the thread which invalidates the
+ * page cache of inodes who are releasing their locks to other nodes) that
+ * we're about to sleep on the DLM while holding a page lock.  See
+ * ocfs2_data_convert_worker().
+ */
+static void ocfs2_set_fs_misc(struct page *page)
+{
+	BUG_ON(PageFsMisc(page));
+	SetPageFsMisc(page);
+	mb();
+	wake_up_page_all(page, PG_locked);
+}
+
+static void ocfs2_clear_fs_misc(struct page *page)
+{
+	wait_event(*page_waitqueue(page), PageFsMisc(page));
+	ClearPageFsMisc(page);
+	smp_mb__after_clear_bit();
+	/* we'll also be unlocking the page so we don't need to wake
+	 * the page waitqueue here */
+}
+
+int ocfs2_data_lock_holding_page(struct inode *inode,
+				 int write,
+				 struct page *page)
+{
+	int ret;
+
+	ocfs2_set_fs_misc(page);
+	ret = ocfs2_data_lock(inode, write);
+	ocfs2_clear_fs_misc(page);
+
+	return ret;
+}
+
 static void ocfs2_vote_on_unlock(ocfs2_super *osb,
 				 struct ocfs2_lock_res *lockres)
 {
@@ -1597,6 +1634,21 @@ bail:
 	return status;
 }

+int ocfs2_meta_lock_holding_page(struct inode *inode,
+				 ocfs2_journal_handle *handle,
+				 struct buffer_head **ret_bh,
+				 int ex,
+				 struct page *page)
+{
+	int ret;
+
+	ocfs2_set_fs_misc(page);
+	ret = ocfs2_meta_lock(inode, handle, ret_bh, ex);
+	ocfs2_clear_fs_misc(page);
+
+	return ret;
+}
+
 void ocfs2_meta_unlock(struct inode *inode,
 		       int ex)
 {
@@ -2297,32 +2349,209 @@ leave:
 	return ret;
 }

+/*
+ * this is a hand-rolled block_read_full_page() which takes our specific
+ * situation into account -- it doesn't unlock the page nor change its state
+ * bits in the radix tree.  This page has already had its dirty bit cleared by
+ * the caller so we want to clear the dirty state in the buffers, too.
+ *
+ * It doesn't have to zero pages that straddle i_size because we can't dirty
+ * pages for writeback from mmap.  ocfs2_prepare_write() has already made sure
+ * that partially written pages contain zeros.
+ *
+ * Truncate can't race with this -- it'll get stuck waiting for a DLM lock.
+ */
+static void ocfs2_write_dirty_fs_misc_page(struct page *page)
+{
+	struct buffer_head *bh, *head;
+	struct inode *inode = page->mapping->host;
+	sector_t block;
+
+	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+
+	BUG_ON(!page_has_buffers(page));
+	head = page_buffers(page);
+
+	bh = head;
+	do {
+		if (!buffer_mapped(bh)) {
+			int err = ocfs2_get_block(inode, block, bh, 1);
+			BUG_ON(err);
+			if (buffer_new(bh)) {
+				clear_buffer_new(bh);
+				unmap_underlying_metadata(bh->b_bdev,
+						          bh->b_blocknr);
+			}
+		}
+		bh = bh->b_this_page;
+		block++;
+	} while (bh != head);
+
+	/* start io */
+	do {
+		lock_buffer(bh);
+		BUG_ON(buffer_jbd(bh)); /* not sure.. */
+		/* clear dirty to match having cleared dirty on the page
+		 * in the caller */
+		clear_buffer_dirty(bh);
+		bh->b_end_io = end_buffer_write_sync;
+		get_bh(bh);
+		submit_bh(WRITE, bh);
+	} while ((bh = bh->b_this_page) != head);
+
+	block_sync_page(page);
+
+	/* wait on it */
+	do {
+		wait_on_buffer(bh);
+	} while ((bh = bh->b_this_page) != head);
+}
+
+
+/*
+ * This returns when either we get the page lock or we clear PG_fs_msic on
+ * behalf of an ocfs2 thread that is heading to block in the DLM.  If we have
+ * the page lock we just unlock it as usual.  If we've cleared the misc bit
+ * then that ocfs2 path is going to wait for us to set it again when we're
+ * done.  It's like that ocfs2 path has transferred ownership of the page lock
+ * to us temporarily.
+ */
+static inline int get_lock_or_fs_misc(struct page *page, int *have_fs_misc)
+{
+	if (!TestSetPageLocked(page)) {
+		*have_fs_misc = 0;
+		return 1;
+	}
+
+	if (TestClearPageFsMisc(page)) {
+		*have_fs_misc = 1;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void ocfs2_lock_page_or_fs_misc(struct page *page, int *have_fs_misc)
+{
+	wait_event(*page_waitqueue(page), get_lock_or_fs_misc(page,
+							      have_fs_misc));
+}
+
+static void ocfs2_return_fs_misc(struct page *page)
+{
+	BUG_ON(PageFsMisc(page));
+	SetPageFsMisc(page);
+	mb();
+	wake_up_page_all(page, PG_fs_misc);
+}
+
+/*
+ * This is called in the context of a DLM helper thread that is operating on a
+ * lock that is converting between two modes.  While it is converting there are
+ * no local holders of the lock and local lock acquiry is blocking waiting for
+ * it to finish.  If a write lock is being dropped so that another node can
+ * acquire a read lock then dirty data has to be written so that other nodes
+ * who later acquire the read lock can read in data.  If a read lock is being
+ * dropped so that another node can acquire a write lock then the page cache
+ * has to be emptied entirely so that read requests aren't satisfied from the
+ * cache once the other node's write starts.
+ *
+ * There is a lock ordering inversion here.  Some FS paths will be holding a
+ * page lock while they wait for a DLM lock.  This path will be blocking local
+ * DLM lock acquiry while it is doing its page cache work which involves
+ * waiting for locked pages.  This is worked around by having those FS paths
+ * set PG_fs_misc on the pages they hold the lock on before they block waiting
+ * for the DLM.  When this path sees a page like this we use PG_fs_misc to sort
+ * of transfer ownership of the page lock to us temporarily.  We leave clean
+ * pages alone -- they're not uptodate and their owner is going to be reading
+ * into them once they get their DLM locks.  We have to write back dirty pages,
+ * though, so that other nodes can read them.
+ *
+ * XXX I think these pagevec loops are safe as index approaches ~0 because
+ * radix_tree_gang_lookup() returns if the index wrapps, but I might not be
+ * reading the code right.
+ */
 static void ocfs2_data_convert_worker(struct ocfs2_lock_res *lockres,
 				      int blocking)
 {
-	struct inode *inode;
-	struct address_space *mapping;
+	struct inode *inode = ocfs2_lock_res_inode(lockres);
+	struct address_space *mapping = inode->i_mapping;
+	int old_level = lockres->l_level;
+	pgoff_t index;
+	struct pagevec pvec;
+	unsigned i;

 	mlog_entry_void();

-       	inode = ocfs2_lock_res_inode(lockres);
-	mapping = inode->i_mapping;
+	/* we're betting that we don't need to call sync_mapping_buffers(),
+	 * having never called mark_buffer_dirty_inode() */
+	BUG_ON(!mapping->assoc_mapping && !list_empty(&mapping->private_list));
+
+	/* first drop all mappings of our pages.  When we have shared
+	 * write this will introduce dirty pages that we'll want to
+	 * writeback below */
+	if (blocking == LKM_EXMODE)
+		unmap_mapping_range(mapping, 0, 0, 0);

-	if (filemap_fdatawrite(mapping)) {
-		mlog(ML_ERROR, "Could not sync inode %"MLFu64" for downconvert!",
-		     OCFS2_I(inode)->ip_blkno);
+	blk_run_address_space(mapping);
+
+	/* start writeback on dirty pages if we're converting from a lock that
+	 * could have dirtied pages. */
+	pagevec_init(&pvec, 0);
+	index = 0;
+	while (old_level == LKM_EXMODE  &&
+	       pagevec_lookup_tag(&pvec, mapping, &index, PAGECACHE_TAG_DIRTY,
+				  PAGEVEC_SIZE)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			int have_fs_misc;
+			struct page *page = pvec.pages[i];
+
+			ocfs2_lock_page_or_fs_misc(page, &have_fs_misc);
+
+			if (have_fs_misc) {
+				/* we can't wait on or unlock this page, but we
+				 * need to write it out */
+				if (test_clear_page_dirty(page))
+					ocfs2_write_dirty_fs_misc_page(page);
+				ocfs2_return_fs_misc(page);
+				continue;
+			}
+
+			if (PageDirty(page))
+				write_one_page(page, 0);
+			else
+				unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
 	}
-	sync_mapping_buffers(mapping);
-	if (blocking == LKM_EXMODE) {
-		truncate_inode_pages(mapping, 0);
-		unmap_mapping_range(mapping, 0, 0, 0);
-	} else {
-		/* We only need to wait on the I/O if we're not also
-		 * truncating pages because truncate_inode_pages waits
-		 * for us above. We don't truncate pages if we're
-		 * blocking anything < EXMODE because we want to keep
-		 * them around in that case. */
+
+	/* wait for io */
+	if (old_level == LKM_EXMODE)
 		filemap_fdatawait(mapping);
+
+	/* now remove all pages if we're blocking exclusive and can't have any
+	 * remaining in our page cache */
+	index = 0;
+	while (blocking == LKM_EXMODE &&
+	       pagevec_lookup(&pvec, mapping, index, PAGEVEC_SIZE)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+			int have_fs_misc;
+			index = page->index + 1;
+
+			ocfs2_lock_page_or_fs_misc(page, &have_fs_misc);
+
+			if (have_fs_misc) {
+				ocfs2_return_fs_misc(page);
+				continue;
+			}
+
+			truncate_complete_page(mapping, page);
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
 	}

 	mlog_exit_void();
