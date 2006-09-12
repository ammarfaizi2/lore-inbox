Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWILPvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWILPvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWILPve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:51:34 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:24485 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751444AbWILPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:04 -0400
Message-Id: <20060912144903.290326000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 03/20] mm: add support for non block device backed swap files
Content-Disposition: inline; filename=swapfile.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new addres_space_operations method is added:
  int swapfile(struct address_space *, int)

When during sys_swapon() this method is found and returns no error the 
swapper_space.a_ops will proxy to sis->swap_file->f_mapping->a_ops.

The swapfile method will be used to communicate to the address_space that the
VM relies on it, and the address_space should take adequate measures (like 
reserving memory for mempools or the like).

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/buffer.c          |    2 -
 include/linux/fs.h   |    1 
 include/linux/swap.h |    4 +++
 init/Kconfig         |    5 ++++
 mm/page_io.c         |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |    6 +++++
 mm/swapfile.c        |   27 ++++++++++++++++++++++
 7 files changed, 103 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h
+++ linux-2.6/include/linux/swap.h
@@ -115,6 +115,7 @@ enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
 	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
 	SWP_ACTIVE	= (SWP_USED | SWP_WRITEOK),
+	SWP_FILE	= (1 << 2),	/* file swap area */
 					/* add others here before... */
 	SWP_SCANNING	= (1 << 8),	/* refcount in scan_swap_map */
 };
@@ -212,6 +213,9 @@ extern void swap_unplug_io_fn(struct bac
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
 extern int swap_writepage(struct page *page, struct writeback_control *wbc);
+extern void swap_sync_page(struct page *page);
+extern int swap_set_page_dirty(struct page *page);
+extern int swap_releasepage(struct page *page, gfp_t gfp_mask);
 extern int rw_swap_page_sync(int, swp_entry_t, struct page *);
 
 /* linux/mm/swap_state.c */
Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -100,6 +100,11 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config SWAP_FILE
+	bool "Support for paging to/from non block device files"
+	depends on SWAP
+	default n
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---
Index: linux-2.6/mm/page_io.c
===================================================================
--- linux-2.6.orig/mm/page_io.c
+++ linux-2.6/mm/page_io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/swapops.h>
 #include <linux/writeback.h>
+#include <linux/buffer_head.h>
 #include <asm/pgtable.h>
 
 static struct bio *get_swap_bio(gfp_t gfp_flags, pgoff_t index,
@@ -91,6 +92,14 @@ int swap_writepage(struct page *page, st
 		unlock_page(page);
 		goto out;
 	}
+#ifdef CONFIG_SWAP_FILE
+	{
+		struct swap_info_struct *sis = page_swap_info(page);
+		if (sis->flags & SWP_FILE)
+			return sis->swap_file->f_mapping->
+				a_ops->writepage(page, wbc);
+	}
+#endif
 	bio = get_swap_bio(GFP_NOIO, page_private(page), page,
 				end_swap_bio_write);
 	if (bio == NULL) {
@@ -116,6 +125,14 @@ int swap_readpage(struct file *file, str
 
 	BUG_ON(!PageLocked(page));
 	ClearPageUptodate(page);
+#ifdef CONFIG_SWAP_FILE
+	{
+		struct swap_info_struct *sis = page_swap_info(page);
+		if (sis->flags & SWP_FILE)
+			return sis->swap_file->f_mapping->
+				a_ops->readpage(sis->swap_file, page);
+	}
+#endif
 	bio = get_swap_bio(GFP_KERNEL, page_private(page), page,
 				end_swap_bio_read);
 	if (bio == NULL) {
@@ -129,6 +146,49 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_SWAP_FILE
+void swap_sync_page(struct page *page)
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+
+	if (sis->flags & SWP_FILE) {
+		const struct address_space_operations * a_ops =
+			sis->swap_file->f_mapping->a_ops;
+		if (a_ops->sync_page)
+			a_ops->sync_page(page);
+	} else
+		block_sync_page(page);
+}
+
+int swap_set_page_dirty(struct page *page)
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+
+	if (sis->flags & SWP_FILE) {
+		const struct address_space_operations * a_ops =
+			sis->swap_file->f_mapping->a_ops;
+		if (a_ops->set_page_dirty)
+			return a_ops->set_page_dirty(page);
+		return __set_page_dirty_buffers(page);
+	}
+
+	return __set_page_dirty_nobuffers(page);
+}
+
+int swap_releasepage(struct page *page, gfp_t gfp_mask)
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+	const struct address_space_operations * a_ops =
+		sis->swap_file->f_mapping->a_ops;
+
+	if ((sis->flags & SWP_FILE) && a_ops->releasepage)
+		return a_ops->releasepage(page, gfp_mask);
+
+	BUG();
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * A scruffy utility function to read or write an arbitrary swap page
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -26,8 +26,14 @@
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
+#ifdef CONFIG_SWAP_FILE
+	.sync_page	= swap_sync_page,
+	.set_page_dirty	= swap_set_page_dirty,
+	.releasepage	= swap_releasepage,
+#else
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
+#endif
 	.migratepage	= migrate_page,
 };
 
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -411,7 +411,12 @@ void free_swap_and_cache(swp_entry_t ent
 	if (page) {
 		int one_user;
 
+#ifdef CONFIG_SWAP_FILE
+		if (PagePrivate(page))
+			page_mapping(page)->a_ops->releasepage(page, 0);
+#else
 		BUG_ON(PagePrivate(page));
+#endif
 		one_user = (page_count(page) == 2);
 		/* Only cache user (+us), or swap space full? Free it! */
 		/* Also recheck PageSwapCache after page is locked (above) */
@@ -944,6 +949,13 @@ static void destroy_swap_extents(struct 
 		list_del(&se->list);
 		kfree(se);
 	}
+#ifdef CONFIG_SWAP_FILE
+	if (sis->flags & SWP_FILE) {
+		sis->flags &= ~SWP_FILE;
+		sis->swap_file->f_mapping->a_ops->
+			swapfile(sis->swap_file->f_mapping, 0);
+	}
+#endif
 }
 
 /*
@@ -1036,6 +1048,19 @@ static int setup_swap_extents(struct swa
 		goto done;
 	}
 
+#ifdef CONFIG_SWAP_FILE
+	if (sis->swap_file->f_mapping->a_ops->swapfile) {
+		ret = sis->swap_file->f_mapping->a_ops->
+			swapfile(sis->swap_file->f_mapping, 1);
+		if (!ret) {
+			sis->flags |= SWP_FILE;
+			ret = add_swap_extent(sis, 0, sis->max, 0);
+			*span = sis->pages;
+		}
+		goto done;
+	}
+#endif
+
 	blkbits = inode->i_blkbits;
 	blocks_per_page = PAGE_SIZE >> blkbits;
 
@@ -1592,7 +1617,7 @@ asmlinkage long sys_swapon(const char __
 
 	mutex_lock(&swapon_mutex);
 	spin_lock(&swap_lock);
-	p->flags = SWP_ACTIVE;
+	p->flags |= SWP_WRITEOK;
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
 
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -382,6 +382,7 @@ struct address_space_operations {
 	/* migrate the contents of a page to the specified target */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *);
+	int (*swapfile)(struct address_space *, int);
 };
 
 struct backing_dev_info;
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1567,7 +1567,7 @@ static void discard_buffer(struct buffer
  */
 int try_to_release_page(struct page *page, gfp_t gfp_mask)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))

--

