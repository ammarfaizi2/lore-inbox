Return-Path: <linux-kernel-owner+w=401wt.eu-S964983AbWL1IkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWL1IkY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWL1IkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:40:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:38563 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964983AbWL1Ijn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:39:43 -0500
Date: Thu, 28 Dec 2006 14:14:08 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 8/8] AIO O_SYNC filesystem write
Message-ID: <20061228084408.GH6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AIO support for O_SYNC buffered writes, built over O_SYNC-speedup.
It uses the tagged radix tree lookups to writeout just the pages
pertaining to this request, and retries instead of blocking
for writeback to complete on the same range. All the writeout is 
issued at the time of io submission, and there is a check to make
sure that retries skip over straight to the wait_on_page_writeback_range.

Limitations: Extending file writes or hole overwrites with O_SYNC may
still block because we have yet to convert generic_osync_inode to be
asynchronous. For non O_SYNC writes, writeout happens in the background
and so typically appears async to the caller except for memory throttling
and non-block aligned writes involving read-modify-write.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 include/linux/aio.h                      |    0 
 linux-2.6.20-rc1-root/include/linux/fs.h |   13 +++++-
 linux-2.6.20-rc1-root/mm/filemap.c       |   61 +++++++++++++++++++++----------
 3 files changed, 54 insertions(+), 20 deletions(-)

diff -puN include/linux/aio.h~aio-fs-write include/linux/aio.h
diff -puN mm/filemap.c~aio-fs-write mm/filemap.c
--- linux-2.6.20-rc1/mm/filemap.c~aio-fs-write	2006-12-21 08:46:21.000000000 +0530
+++ linux-2.6.20-rc1-root/mm/filemap.c	2006-12-21 08:46:21.000000000 +0530
@@ -239,10 +239,11 @@ EXPORT_SYMBOL(filemap_flush);
  * @end:	ending page index
  *
  * Wait for writeback to complete against pages indexed by start->end
- * inclusive
+ * inclusive. In AIO context, this may queue an async notification
+ * and retry callback and return, instead of blocking the caller.
  */
-int wait_on_page_writeback_range(struct address_space *mapping,
-				pgoff_t start, pgoff_t end)
+int __wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end, wait_queue_t *wait)
 {
 	struct pagevec pvec;
 	int nr_pages;
@@ -254,20 +255,20 @@ int wait_on_page_writeback_range(struct 
 
 	pagevec_init(&pvec, 0);
 	index = start;
-	while ((index <= end) &&
+	while (!ret && (index <= end) &&
 			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_WRITEBACK,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
+		for (i = 0; !ret && (i < nr_pages); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* until radix tree lookup accepts end_index */
 			if (page->index > end)
 				continue;
 
-			wait_on_page_writeback(page);
+			ret = __wait_on_page_writeback(page, wait);
 			if (PageError(page))
 				ret = -EIO;
 		}
@@ -303,18 +304,27 @@ int sync_page_range(struct inode *inode,
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
-	int ret;
+	int ret = 0;
 
 	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTryRestart(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
-	if (ret == 0) {
+
+	if (ret >= 0) {
 		mutex_lock(&inode->i_mutex);
 		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
 		mutex_unlock(&inode->i_mutex);
 	}
-	if (ret == 0)
-		ret = wait_on_page_writeback_range(mapping, start, end);
+do_wait:
+	if (ret >= 0) {
+		ret = __wait_on_page_writeback_range(mapping, start, end,
+			current->io_wait);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(sync_page_range);
@@ -335,15 +345,23 @@ int sync_page_range_nolock(struct inode 
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
-	int ret;
+	int ret = 0;
 
 	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTryRestart(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
-	if (ret == 0)
+	if (ret >= 0)
 		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
-	if (ret == 0)
-		ret = wait_on_page_writeback_range(mapping, start, end);
+do_wait:
+	if (ret >= 0) {
+		ret = __wait_on_page_writeback_range(mapping, start, end,
+			current->io_wait);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(sync_page_range_nolock);
@@ -2216,7 +2234,7 @@ zero_length_segment:
 	 */
 	if (likely(status >= 0)) {
 		if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-			if (!a_ops->writepage || !is_sync_kiocb(iocb))
+			if (!a_ops->writepage)
 				status = generic_osync_inode(inode, mapping,
 						OSYNC_METADATA|OSYNC_DATA);
 		}
@@ -2268,7 +2286,10 @@ __generic_file_aio_write_nolock(struct k
 		ocount -= iv->iov_len;	/* This segment is no good */
 		break;
 	}
-
+	if (!is_sync_kiocb(iocb) && kiocbIsRestarted(iocb)) {
+		/* nothing to transfer, may just need to sync data */
+		return ocount;
+	}
 	count = ocount;
 	pos = *ppos;
 
@@ -2368,8 +2389,10 @@ ssize_t generic_file_aio_write_nolock(st
 		ssize_t err;
 
 		err = sync_page_range_nolock(inode, mapping, pos, ret);
-		if (err < 0)
+		if (err < 0) {
 			ret = err;
+			iocb->ki_pos = pos;
+		}
 	}
 	return ret;
 }
@@ -2394,8 +2417,10 @@ ssize_t generic_file_aio_write(struct ki
 		ssize_t err;
 
 		err = sync_page_range(inode, mapping, pos, ret);
-		if (err < 0)
+		if (err < 0) {
 			ret = err;
+			iocb->ki_pos = pos;
+		}
 	}
 	return ret;
 }
diff -puN include/linux/fs.h~aio-fs-write include/linux/fs.h
--- linux-2.6.20-rc1/include/linux/fs.h~aio-fs-write	2006-12-21 08:46:21.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/fs.h	2006-12-21 08:46:21.000000000 +0530
@@ -279,6 +279,7 @@ extern int dir_notify_enable;
 #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/pid.h>
+#include <linux/sched.h>
 #include <linux/mutex.h>
 
 #include <asm/atomic.h>
@@ -1588,8 +1589,16 @@ extern int filemap_fdatawait(struct addr
 extern int filemap_write_and_wait(struct address_space *mapping);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
-extern int wait_on_page_writeback_range(struct address_space *mapping,
-				pgoff_t start, pgoff_t end);
+extern int __wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end, wait_queue_t *wait);
+
+static inline int wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end)
+{
+	return __wait_on_page_writeback_range(mapping, start, end,
+		&current->__wait.wait);
+}
+
 extern int __filemap_fdatawrite_range(struct address_space *mapping,
 				loff_t start, loff_t end, int sync_mode);
 
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

