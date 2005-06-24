Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263248AbVFXLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbVFXLbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbVFXLbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:31:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:717 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263248AbVFXLax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:30:53 -0400
Date: Fri, 24 Jun 2005 17:10:05 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: [PATCH 2/2] Filesystem AIO write
Message-ID: <20050624114005.GB4574@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050624104928.GA4408@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624104928.GA4408@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:19:28PM +0530, Suparna Bhattacharya wrote:
> On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> > (2) Buffered filesystem AIO read/write (me/Ben)

Filesystem AIO write

AIO support for O_SYNC buffered writes, built over O_SYNC-speedup.
It uses the tagged radix tree lookups to writeout just the pages
pertaining to this request, and retries instead of blocking
for writeback to complete on the same range. All the writeout is 
issued at the time of io submission, and there is a check to make
sure that retries skip over straight to the wait_on_page_writeback_range.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 include/linux/aio.h |    8 ++++-
 mm/filemap.c        |   82 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 21 deletions(-)

diff -urp -X dontdiff2 linux-2.6.10-rc1/include/linux/aio.h linux-2.6.10-rc1-new/include/linux/aio.h
--- linux-2.6.10-rc1/include/linux/aio.h	2004-11-26 14:30:55.000000000 +0530
+++ linux-2.6.10-rc1-new/include/linux/aio.h	2004-11-26 14:07:29.000000000 +0530
@@ -27,21 +27,26 @@ struct kioctx;
 #define KIF_LOCKED		0
 #define KIF_KICKED		1
 #define KIF_CANCELLED		2
+#define KIF_SYNCED		3
 
 #define kiocbTryLock(iocb)	test_and_set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbTryKick(iocb)	test_and_set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbTrySync(iocb)	test_and_set_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbSetLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbSetSynced(iocb)	set_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbClearLocked(iocb)	clear_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbClearKicked(iocb)	clear_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbClearCancelled(iocb)	clear_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearSynced(iocb)	clear_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbIsLocked(iocb)	test_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbIsSynced(iocb)	test_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 struct kiocb {
 	struct list_head	ki_run_list;
@@ -184,7 +189,8 @@ do {									\
 	}								\
 } while (0)
 
-#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
+#define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,	\
+	struct wait_bit_queue, wait), struct kiocb, ki_wait)
 #define is_retried_kiocb(iocb) ((iocb)->ki_retried > 1)
 
 #include <linux/aio_abi.h>
diff -urp -X dontdiff2 linux-2.6.10-rc1/mm/filemap.c linux-2.6.10-rc1-new/mm/filemap.c
--- linux-2.6.10-rc1/mm/filemap.c	2004-11-26 13:33:13.000000000 +0530
+++ linux-2.6.10-rc1-new/mm/filemap.c	2004-11-26 16:04:24.000000000 +0530
@@ -209,10 +209,11 @@ EXPORT_SYMBOL(filemap_flush);
 
 /*
  * Wait for writeback to complete against pages indexed by start->end
- * inclusive
+ * inclusive. In AIO context, this may queue an async notification
+ * and retry callback and return, instead of blocking the caller.
  */
-static int wait_on_page_writeback_range(struct address_space *mapping,
-				pgoff_t start, pgoff_t end)
+static int __wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end, wait_queue_t *wait)
 {
 	struct pagevec pvec;
 	int nr_pages;
@@ -224,20 +225,20 @@ static int wait_on_page_writeback_range(
 
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
@@ -254,6 +255,14 @@ static int wait_on_page_writeback_range(
 	return ret;
 }
 
+static inline int wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end)
+{
+	return __wait_on_page_writeback_range(mapping, start, end,
+		&current->__wait.wait);
+}
+
+
 /*
  * Write and wait upon all the pages in the passed range.  This is a "data
  * integrity" operation.  It waits upon in-flight writeout before starting and
@@ -267,18 +276,27 @@ int sync_page_range(struct inode *inode,
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
-	int ret;
+	int ret = 0;
 
 	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTrySync(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
-	if (ret == 0) {
+
+	if (ret >= 0) {
 		down(&inode->i_sem);
 		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
 		up(&inode->i_sem);
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
@@ -293,15 +311,23 @@ int sync_page_range_nolock(struct inode 
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
-	int ret;
+	int ret = 0;
 
 	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTrySync(io_wait_to_kiocb(current->io_wait)))
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
@@ -2001,7 +2028,7 @@ generic_file_buffered_write(struct kiocb
 	 */
 	if (likely(status >= 0)) {
 		if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-			if (!a_ops->writepage || !is_sync_kiocb(iocb))
+			if (!a_ops->writepage)
 				status = generic_osync_inode(inode, mapping,
 						OSYNC_METADATA|OSYNC_DATA);
 		}
@@ -2108,14 +2135,23 @@ generic_file_aio_write_nolock(struct kio
 	ssize_t ret;
 	loff_t pos = *ppos;
 
+	if (!is_sync_kiocb(iocb) && kiocbIsSynced(iocb)) {
+		/* nothing to transfer, may just need to sync data */
+		ret = iov->iov_len; /* vector AIO not supported yet */
+		goto osync;
+	}
+
 	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, ppos);
 
+osync:
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		int err;
 
 		err = sync_page_range_nolock(inode, mapping, pos, ret);
-		if (err < 0)
-			ret = err;
+		if (err < 0) {
+			ret = err;	
+			*ppos = pos;
+		}
 	}
 	return ret;
 }
@@ -2161,19 +2197,26 @@ ssize_t generic_file_aio_write(struct ki
 	struct iovec local_iov = { .iov_base = (void __user *)buf,
 					.iov_len = count };
 
-	BUG_ON(iocb->ki_pos != pos);
+	if (!is_sync_kiocb(iocb) && kiocbIsSynced(iocb)) {
+		/* nothing to transfer, may just need to sync data */
+		ret = count;
+		goto osync;
+	}
 
 	down(&inode->i_sem);
	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
 						&iocb->ki_pos);
 	up(&inode->i_sem);
 
+osync:
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

