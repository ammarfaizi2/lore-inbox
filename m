Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUGBQZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUGBQZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGBQZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:25:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9867 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264717AbUGBQXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:23:42 -0400
Date: Fri, 2 Jul 2004 22:03:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 18/22] AIO O_SYNC write
Message-ID: <20040702163301.GH3450@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch
> [10] aio-pipe.patch
> [11] aio-context-switch.patch
> 
> Concurrent O_SYNC write speedups using radix-tree walks
> [12] writepages-range.patch
> [13] fix-writeback-range.patch
> [14] fix-writepages-range.patch
> [15] fdatawrite-range.patch
> [16] O_SYNC-speedup.patch
> 
> AIO O_SYNC write
> [17] aio-wait_on_page_writeback_range.patch
> [18] aio-O_SYNC.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
----------------------------------------------------------

From: Suparna Bhattacharya

AIO support for O_SYNC buffered writes, built over O_SYNC-speedup
an reworked against the tagged radix-tree-lookup based writeback
changes.

It uses the tagged radix tree lookups to writeout just the pages
pertaining to this request, and then takes the retry based approach
to wait for writeback to complete on the same range (using AIO enabled 
wait_on_page_writeback_range). All the writeout is issued at the
time of io submission, and there is a check to make sure that
retries skip over straight to the wait_on_page_writeback_range.

The code turns out to be a little simpler than earlier
iterations by not trying to make the high level code allow for
retries at blocking points other than those handled in this patch.


 fs/aio.c                  |   13 +---
 include/linux/aio.h       |    5 +
 include/linux/writeback.h |    4 +
 mm/filemap.c              |  136 +++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 130 insertions(+), 28 deletions(-)

--- aio/fs/aio.c	2004-06-21 10:52:41.616987200 -0700
+++ aio-O_SYNC/fs/aio.c	2004-06-21 10:53:40.302065712 -0700
@@ -1322,16 +1322,10 @@ static ssize_t aio_pwrite(struct kiocb *
 	ssize_t ret = 0;
 
 	ret = file->f_op->aio_write(iocb, iocb->ki_buf,
-		iocb->ki_left, iocb->ki_pos);
+				iocb->ki_left, iocb->ki_pos);
 
-	/*
-	 * TBD: Even if iocb->ki_left = 0, could we need to
-	 * wait for data to be sync'd ? Or can we assume
-	 * that aio_fdsync/aio_fsync would be called explicitly
-	 * as required.
-	 */
 	if (ret > 0) {
-		iocb->ki_buf += ret;
+		iocb->ki_buf += iocb->ki_buf ? ret : 0;
 		iocb->ki_left -= ret;
 
 		ret = -EIOCBRETRY;
@@ -1339,8 +1333,9 @@ static ssize_t aio_pwrite(struct kiocb *
 
 	/* This means we must have transferred all that we could */
 	/* No need to retry anymore */
-	if (ret == 0)
+	if ((ret == 0) || (iocb->ki_left == 0)) {
 		ret = iocb->ki_nbytes - iocb->ki_left;
+	}
 
 	return ret;
 }
--- aio/include/linux/aio.h	2004-06-21 10:52:25.147490944 -0700
+++ aio-O_SYNC/include/linux/aio.h	2004-06-21 10:53:40.302065712 -0700
@@ -29,21 +29,26 @@ struct kioctx;
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
--- aio/include/linux/writeback.h	2004-06-21 10:53:19.034298904 -0700
+++ aio-O_SYNC/include/linux/writeback.h	2004-06-21 10:53:40.303065560 -0700
@@ -103,8 +103,10 @@ void page_writeback_init(void);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
-int sync_page_range(struct inode *inode, struct address_space *mapping,
+ssize_t sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count);
+ssize_t sync_page_range_nolock(struct inode *inode, struct address_space
+		*mapping, loff_t pos, size_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
--- aio/mm/filemap.c	2004-06-21 10:53:25.532311056 -0700
+++ aio-O_SYNC/mm/filemap.c	2004-06-21 10:53:40.307064952 -0700
@@ -274,23 +274,75 @@ static inline ssize_t wait_on_page_write
  * We need to re-take i_sem during the generic_osync_inode list walk because
  * it is otherwise livelockable.
  */
-int sync_page_range(struct inode *inode, struct address_space *mapping,
+ssize_t sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count)
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
-	int ret;
+	ssize_t ret = 0;
 
 	if (mapping->backing_dev_info->memory_backed || !count)
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
+		ret = wait_on_page_writeback_range_wq(mapping, start, end,
+			current->io_wait);
+		if (ret > 0) {
+			ret <<= PAGE_CACHE_SHIFT;
+			if (ret > count)
+				ret = count;
+		}
+	}
+	return ret;
+}
+
+/*
+ * It is really better to use sync_page_range, rather than call
+ * sync_page_range_nolock while holding i_sem, if you don't
+ * want to block parallel O_SYNC writes until the pages in this
+ * range are written out.
+ */
+ssize_t sync_page_range_nolock(struct inode *inode, struct address_space
+	*mapping, loff_t pos, size_t count)
+{
+	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
+	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
+	ssize_t ret = 0;
+
+	if (mapping->backing_dev_info->memory_backed || !count)
+		return 0;
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTrySync(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
+	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
+
+	if (ret >= 0) {
+		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
+	}
+do_wait:
+	if (ret >= 0) {
+		ret = wait_on_page_writeback_range_wq(mapping, start, end,
+			current->io_wait);
+		if (ret > 0) {
+			ret <<= PAGE_CACHE_SHIFT;
+			if (ret > count)
+				ret = count;
+		}
+	}
 	return ret;
 }
 /**
@@ -301,7 +353,10 @@ int sync_page_range(struct inode *inode,
  */
 int filemap_fdatawait(struct address_space *mapping)
 {
-	return wait_on_page_writeback_range(mapping, 0, -1);
+	int ret = wait_on_page_writeback_range(mapping, 0, -1);
+	if (ret > 0)
+		ret = 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(filemap_fdatawait);
@@ -1968,7 +2023,7 @@ EXPORT_SYMBOL(generic_write_checks);
  *							okir@monad.swb.de
  */
 ssize_t
-generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
@@ -2149,7 +2204,7 @@ generic_file_aio_write_nolock(struct kio
 	 */
 	if (likely(status >= 0)) {
 		if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-			if (!a_ops->writepage || !is_sync_kiocb(iocb))
+			if (!a_ops->writepage)
 				status = generic_osync_inode(inode, mapping,
 						OSYNC_METADATA|OSYNC_DATA);
 		}
@@ -2174,6 +2229,48 @@ out:
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 ssize_t
+generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t ret;
+	loff_t pos = *ppos;
+
+	if (!is_sync_kiocb(iocb) && kiocbIsSynced(iocb)) {
+		/* nothing to transfer, may just need to sync data */
+		ret = iov->iov_len; /* vector AIO not supported yet */
+		goto osync;
+	}
+
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, ppos);
+
+osync:
+	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		ret = sync_page_range_nolock(inode, mapping, pos, ret);
+		if (ret >= 0)
+			*ppos = pos + ret;
+	}
+	return ret;
+}
+
+
+ssize_t
+__generic_file_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
+ssize_t
 generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
@@ -2199,19 +2296,22 @@ ssize_t generic_file_aio_write(struct ki
 	struct iovec local_iov = { .iov_base = (void __user *)buf,
 					.iov_len = count };
 
-	BUG_ON(iocb->ki_pos != pos);
+	if (!is_sync_kiocb(iocb) && kiocbIsSynced(iocb)) {
+		/* nothing to transfer, may just need to sync data */
+		ret = count;
+		goto osync;
+	}
 
 	down(&inode->i_sem);
-	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
+	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
 						&iocb->ki_pos);
 	up(&inode->i_sem);
 
+osync:
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		ssize_t err;
-
-		err = sync_page_range(inode, mapping, pos, ret);
-		if (err < 0)
-			ret = err;
+		ret = sync_page_range(inode, mapping, pos, ret);
+		if (ret >= 0)
+			iocb->ki_pos = pos + ret;
 	}
 	return ret;
 }
@@ -2227,7 +2327,7 @@ ssize_t generic_file_write(struct file *
 					.iov_len = count };
 
 	down(&inode->i_sem);
-	ret = generic_file_write_nolock(file, &local_iov, 1, ppos);
+	ret = __generic_file_write_nolock(file, &local_iov, 1, ppos);
 	up(&inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
@@ -2264,11 +2364,11 @@ ssize_t generic_file_writev(struct file 
 	ssize_t ret;
 
 	down(&inode->i_sem);
-	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
+	ret = __generic_file_write_nolock(file, iov, nr_segs, ppos);
 	up(&inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		int err;
+		ssize_t err;
 
 		err = sync_page_range(inode, mapping, *ppos - ret, ret);
 		if (err < 0)
