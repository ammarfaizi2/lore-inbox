Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbUKHJ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbUKHJ6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKHJ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:58:46 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52097 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261588AbUKHJ6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:58:00 -0500
Date: Mon, 8 Nov 2004 15:37:38 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
Message-ID: <20041108100738.GA4003@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The O_SYNC speedup patches missed the generic_file_xxx_nolock cases,
which means that pages weren't actually getting sync'ed in those
cases. This patch fixes that. 

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>


 include/linux/writeback.h |    2 +
 mm/filemap.c              |   67 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff -urp -X dontdiff2 linux-2.6.10-rc1/include/linux/writeback.h linux-2.6.10-rc1-aio/include/linux/writeback.h
--- linux-2.6.10-rc1/include/linux/writeback.h	2004-11-03 12:04:10.000000000 +0530
+++ linux-2.6.10-rc1-aio/include/linux/writeback.h	2004-11-04 10:10:31.000000000 +0530
@@ -106,6 +106,8 @@ int pdflush_operation(void (*fn)(unsigne
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count);
+int sync_page_range_nolock(struct inode *inode, struct address_space
+		*mapping, loff_t pos, size_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
diff -urp -X dontdiff2 linux-2.6.10-rc1/mm/filemap.c linux-2.6.10-rc1-aio/mm/filemap.c
--- linux-2.6.10-rc1/mm/filemap.c	2004-11-03 12:04:24.000000000 +0530
+++ linux-2.6.10-rc1-aio/mm/filemap.c	2004-11-04 10:10:31.000000000 +0530
@@ -283,6 +283,30 @@ int sync_page_range(struct inode *inode,
 }
 EXPORT_SYMBOL(sync_page_range);
 
+/*
+ * Note: Holding i_sem across sync_page_range_nolock is not a good idea
+ * as it forces O_SYNC writers to different parts of the same file
+ * to be serialised right until io completion.
+ */
+int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
+			loff_t pos, size_t count)
+{
+	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
+	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
+	int ret;
+
+	if (mapping->backing_dev_info->memory_backed || !count)
+		return 0;
+	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
+	if (ret == 0) {
+		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
+	}
+	if (ret == 0)
+		ret = wait_on_page_writeback_range(mapping, start, end);
+	return ret;
+}
+EXPORT_SYMBOL(sync_page_range_nolock);
+
 /**
  * filemap_fdatawait - walk the list of under-writeback pages of the given
  *     address space and wait for all of them.
@@ -1998,7 +2022,7 @@ generic_file_buffered_write(struct kiocb
 EXPORT_SYMBOL(generic_file_buffered_write);
 
 ssize_t
-generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
@@ -2075,6 +2099,43 @@ out:
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
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, ppos);
+
+	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		int err;
+
+		err = sync_page_range_nolock(inode, mapping, pos, ret);
+		if (err < 0)
+			ret = err;
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
@@ -2128,7 +2189,7 @@ ssize_t generic_file_write(struct file *
 					.iov_len = count };
 
 	down(&inode->i_sem);
-	ret = generic_file_write_nolock(file, &local_iov, 1, ppos);
+	ret = __generic_file_write_nolock(file, &local_iov, 1, ppos);
 	up(&inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
@@ -2165,7 +2226,7 @@ ssize_t generic_file_writev(struct file 
 	ssize_t ret;
 
 	down(&inode->i_sem);
-	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
+	ret = __generic_file_write_nolock(file, iov, nr_segs, ppos);
 	up(&inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
