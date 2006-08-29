Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWH2QuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWH2QuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWH2QtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:49:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965120AbWH2QqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:46:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/19] BLOCK: Dissociate generic_writepages() from mpage stuff [try #5]
Date: Tue, 29 Aug 2006 17:46:06 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164606.15723.65159.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Dissociate the generic_writepages() function from the mpage stuff, moving its
declaration to linux/mm.h and actually emitting a full implementation into
mm/page-writeback.c.

The implementation is a partial duplicate of mpage_writepages() with all BIO
references removed.

It is used by NFS to do writeback.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/block_dev.c            |    1 
 fs/mpage.c                |    2 +
 include/linux/mpage.h     |    6 --
 include/linux/writeback.h |    2 +
 mm/page-writeback.c       |  134 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1c146a2..02acae1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -17,6 +17,7 @@ #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
 #include <linux/uio.h>
diff --git a/fs/mpage.c b/fs/mpage.c
index 1e45982..692a3e5 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -693,6 +693,8 @@ out:
  * the call was made get new I/O started against them.  If wbc->sync_mode is
  * WB_SYNC_ALL then we were called for data integrity and we must wait for
  * existing IO to complete.
+ *
+ * If you fix this you should check generic_writepages() also!
  */
 int
 mpage_writepages(struct address_space *mapping,
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 3ca8804..517c098 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -20,9 +20,3 @@ int mpage_writepages(struct address_spac
 		struct writeback_control *wbc, get_block_t get_block);
 int mpage_writepage(struct page *page, get_block_t *get_block,
 		struct writeback_control *wbc);
-
-static inline int
-generic_writepages(struct address_space *mapping, struct writeback_control *wbc)
-{
-	return mpage_writepages(mapping, wbc, NULL);
-}
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9e38b56..671c43b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -110,6 +110,8 @@ balance_dirty_pages_ratelimited(struct a
 }
 
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
+extern int generic_writepages(struct address_space *mapping,
+			      struct writeback_control *wbc);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, loff_t count);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f75d033..eeeaf43 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -30,6 +30,7 @@ #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/buffer_head.h>
+#include <linux/pagevec.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -543,6 +544,139 @@ void __init page_writeback_init(void)
 	register_cpu_notifier(&ratelimit_nb);
 }
 
+/**
+ * generic_writepages - walk the list of dirty pages of the given
+ *                      address space and writepage() all of them.
+ *
+ * @mapping: address space structure to write
+ * @wbc: subtract the number of written pages from *@wbc->nr_to_write
+ *
+ * This is a library function, which implements the writepages()
+ * address_space_operation.
+ *
+ * If a page is already under I/O, generic_writepages() skips it, even
+ * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
+ * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
+ * and msync() need to guarantee that all the data which was dirty at the time
+ * the call was made get new I/O started against them.  If wbc->sync_mode is
+ * WB_SYNC_ALL then we were called for data integrity and we must wait for
+ * existing IO to complete.
+ *
+ * Derived from mpage_writepages() - if you fix this you should check that
+ * also!
+ */
+int generic_writepages(struct address_space *mapping,
+		       struct writeback_control *wbc)
+{
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	int ret = 0;
+	int done = 0;
+	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	struct pagevec pvec;
+	int nr_pages;
+	pgoff_t index;
+	pgoff_t end;		/* Inclusive */
+	int scanned = 0;
+	int range_whole = 0;
+
+	if (wbc->nonblocking && bdi_write_congested(bdi)) {
+		wbc->encountered_congestion = 1;
+		return 0;
+	}
+
+	writepage = mapping->a_ops->writepage;
+
+	/* deal with chardevs and other special file */
+	if (!writepage)
+		return 0;
+
+	pagevec_init(&pvec, 0);
+	if (wbc->range_cyclic) {
+		index = mapping->writeback_index; /* Start from prev offset */
+		end = -1;
+	} else {
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
+		scanned = 1;
+	}
+retry:
+	while (!done && (index <= end) &&
+	       (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+					      PAGECACHE_TAG_DIRTY,
+					      min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
+		unsigned i;
+
+		scanned = 1;
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			/*
+			 * At this point we hold neither mapping->tree_lock nor
+			 * lock on the page itself: the page may be truncated or
+			 * invalidated (changing page->mapping to NULL), or even
+			 * swizzled back from swapper_space to tmpfs file
+			 * mapping
+			 */
+			lock_page(page);
+
+			if (unlikely(page->mapping != mapping)) {
+				unlock_page(page);
+				continue;
+			}
+
+			if (!wbc->range_cyclic && page->index > end) {
+				done = 1;
+				unlock_page(page);
+				continue;
+			}
+
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				wait_on_page_writeback(page);
+
+			if (PageWriteback(page) ||
+			    !clear_page_dirty_for_io(page)) {
+				unlock_page(page);
+				continue;
+			}
+
+			ret = (*writepage)(page, wbc);
+			if (ret) {
+				if (ret == -ENOSPC)
+					set_bit(AS_ENOSPC, &mapping->flags);
+				else
+					set_bit(AS_EIO, &mapping->flags);
+			}
+
+			if (unlikely(ret == AOP_WRITEPAGE_ACTIVATE))
+				unlock_page(page);
+			if (ret || (--(wbc->nr_to_write) <= 0))
+				done = 1;
+			if (wbc->nonblocking && bdi_write_congested(bdi)) {
+				wbc->encountered_congestion = 1;
+				done = 1;
+			}
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+	if (!scanned && !done) {
+		/*
+		 * We hit the last page and there is more work to be done: wrap
+		 * back to the start of the file
+		 */
+		scanned = 1;
+		index = 0;
+		goto retry;
+	}
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = index;
+	return ret;
+}
+
+EXPORT_SYMBOL(generic_writepages);
+
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
