Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHAHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHAHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHAHr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:47:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62112 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265490AbUHAHoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:44:16 -0400
Date: Sun, 1 Aug 2004 13:23:47 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Concurrent O_SYNC write support
Message-ID: <20040801075347.GE7327@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040801074518.GA7310@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801074518.GA7310@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 01:15:18PM +0530, Suparna Bhattacharya wrote:
> 
> The attached patches (generated against 2.6.8-rc2) enable concurrent 
> O_SYNC writers to different parts of the same file by avoiding 
> serialising on i_sem across the wait for IO completion.
> 
> This is mostly your work, ported to the tagged radix tree VFS changes
> and a few fixes. I have been carrying these patches for sometime now; 
> they can be the merged upstream. Please apply.
> 

[5] O_SYNC-speedup.patch

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

--------------------------------------------------------------


From: Andrew Morton <akpm@osdl.org>

In databases it is common to have multiple threads or processes performing
O_SYNC writes against different parts of the same file.

Our performance at this is poor, because each writer blocks access to the
file by waiting on I/O completion while holding i_sem: everything is
serialised.

The patch improves things by moving the writing and waiting outside i_sem.
So other threads can get in and submit their I/O and permit the disk
scheduler to optimise the IO patterns better.

Also, the O_SYNC writer only writes and waits on the pages which he wrote,
rather than writing and waiting on all dirty pages in the file.

The reason we haven't been able to do this before is that the required walk
of the address_space page lists is easily livelockable without the i_sem
serialisation.  But in this patch we perform the waiting via a radix-tree
walk of the affected pages.  This cannot be livelocked.

The sync of the inode's metadata is still performed inside i_sem.  This is
because it is list-based and is hence still livelockable.  However it is
usually the case that databases are overwriting existing file blocks and
there will be no dirty buffers attached to the address_space anyway.

The code is careful to ensure that the IO for the pages and the IO for the
metadata are nonblockingly scheduled at the same time.  This is am improvemtn
over the current code, which will issue two separate write-and-wait cycles:
one for metadata, one for pages.

Note from Suparna:
Reworked to use the tagged radix-tree based writeback infrastructure.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.8-rc2-suparna/include/linux/buffer_head.h |    6 -
 linux-2.6.8-rc2-suparna/include/linux/fs.h          |    5 +
 linux-2.6.8-rc2-suparna/include/linux/writeback.h   |    2 
 linux-2.6.8-rc2-suparna/mm/filemap.c                |   93 +++++++++++++++-----
 4 files changed, 81 insertions(+), 25 deletions(-)

diff -puN include/linux/buffer_head.h~O_SYNC-speedup include/linux/buffer_head.h
--- linux-2.6.8-rc2/include/linux/buffer_head.h~O_SYNC-speedup	2004-08-01 12:34:44.000000000 +0530
+++ linux-2.6.8-rc2-suparna/include/linux/buffer_head.h	2004-08-01 12:34:45.000000000 +0530
@@ -202,12 +202,6 @@ int nobh_prepare_write(struct page*, uns
 int nobh_commit_write(struct file *, struct page *, unsigned, unsigned);
 int nobh_truncate_page(struct address_space *, loff_t);
 
-#define OSYNC_METADATA	(1<<0)
-#define OSYNC_DATA	(1<<1)
-#define OSYNC_INODE	(1<<2)
-int generic_osync_inode(struct inode *, struct address_space *, int);
-
-
 /*
  * inline definitions
  */
diff -puN include/linux/fs.h~O_SYNC-speedup include/linux/fs.h
--- linux-2.6.8-rc2/include/linux/fs.h~O_SYNC-speedup	2004-08-01 12:34:44.000000000 +0530
+++ linux-2.6.8-rc2-suparna/include/linux/fs.h	2004-08-01 12:34:45.000000000 +0530
@@ -823,6 +823,11 @@ extern int vfs_rename(struct inode *, st
 #define DT_SOCK		12
 #define DT_WHT		14
 
+#define OSYNC_METADATA	(1<<0)
+#define OSYNC_DATA	(1<<1)
+#define OSYNC_INODE	(1<<2)
+int generic_osync_inode(struct inode *, struct address_space *, int);
+
 /*
  * This is the "filldir" function type, used by readdir() to let
  * the kernel specify what kind of dirent layout it wants to have.
diff -puN include/linux/writeback.h~O_SYNC-speedup include/linux/writeback.h
--- linux-2.6.8-rc2/include/linux/writeback.h~O_SYNC-speedup	2004-08-01 12:34:45.000000000 +0530
+++ linux-2.6.8-rc2-suparna/include/linux/writeback.h	2004-08-01 12:34:45.000000000 +0530
@@ -103,6 +103,8 @@ void page_writeback_init(void);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
+int sync_page_range(struct inode *inode, struct address_space *mapping,
+			loff_t pos, size_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
diff -puN mm/filemap.c~O_SYNC-speedup mm/filemap.c
--- linux-2.6.8-rc2/mm/filemap.c~O_SYNC-speedup	2004-08-01 12:34:45.000000000 +0530
+++ linux-2.6.8-rc2-suparna/mm/filemap.c	2004-08-01 12:34:45.000000000 +0530
@@ -247,6 +247,34 @@ static int wait_on_page_writeback_range(
 	return ret;
 }
 
+
+/*
+ * Write and wait upon all the pages in the passed range.  This is a "data
+ * integrity" operation.  It waits upon in-flight writeout before starting and
+ * waiting upon new writeout.  If there was an IO error, return it.
+ *
+ * We need to re-take i_sem during the generic_osync_inode list walk because
+ * it is otherwise livelockable.
+ */
+int sync_page_range(struct inode *inode, struct address_space *mapping,
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
+		down(&inode->i_sem);
+		ret = generic_osync_inode(inode, mapping, OSYNC_METADATA);
+		up(&inode->i_sem);
+	}
+	if (ret == 0)
+		ret = wait_on_page_writeback_range(mapping, start, end);
+	return ret;
+}
 /**
  * filemap_fdatawait - walk the list of under-writeback pages of the given
  *     address space and wait for all of them.
@@ -2026,11 +2054,13 @@ generic_file_aio_write_nolock(struct kio
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
-	if (status >= 0) {
-		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
-			status = generic_osync_inode(inode, mapping,
-					OSYNC_METADATA|OSYNC_DATA);
-	}
+	if (likely(status >= 0)) {
+		if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+			if (!a_ops->writepage || !is_sync_kiocb(iocb))
+				status = generic_osync_inode(inode, mapping,
+						OSYNC_METADATA|OSYNC_DATA);
+		}
+  	}
 	
 	/*
 	 * If we get here for O_DIRECT writes then we must have fallen through
@@ -2070,36 +2100,52 @@ ssize_t generic_file_aio_write(struct ki
 			       size_t count, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	ssize_t err;
-	struct iovec local_iov = { .iov_base = (void __user *)buf, .iov_len = count };
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t ret;
+	struct iovec local_iov = { .iov_base = (void __user *)buf,
+					.iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 
 	down(&inode->i_sem);
-	err = generic_file_aio_write_nolock(iocb, &local_iov, 1, 
+	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
 						&iocb->ki_pos);
 	up(&inode->i_sem);
 
-	return err;
-}
+	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		ssize_t err;
 
+		err = sync_page_range(inode, mapping, pos, ret);
+		if (err < 0)
+			ret = err;
+	}
+	return ret;
+}
 EXPORT_SYMBOL(generic_file_aio_write);
 
 ssize_t generic_file_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *ppos)
 {
-	struct inode	*inode = file->f_mapping->host;
-	ssize_t		err;
-	struct iovec local_iov = { .iov_base = (void __user *)buf, .iov_len = count };
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t	ret;
+	struct iovec local_iov = { .iov_base = (void __user *)buf,
+					.iov_len = count };
 
 	down(&inode->i_sem);
-	err = generic_file_write_nolock(file, &local_iov, 1, ppos);
+	ret = generic_file_write_nolock(file, &local_iov, 1, ppos);
 	up(&inode->i_sem);
 
-	return err;
-}
+	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		ssize_t err;
 
+		err = sync_page_range(inode, mapping, *ppos - ret, ret);
+		if (err < 0)
+			ret = err;
+	}
+	return ret;
+}
 EXPORT_SYMBOL(generic_file_write);
 
 ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
@@ -2118,14 +2164,23 @@ ssize_t generic_file_readv(struct file *
 EXPORT_SYMBOL(generic_file_readv);
 
 ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
-			unsigned long nr_segs, loff_t * ppos) 
+			unsigned long nr_segs, loff_t *ppos)
 {
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	ssize_t ret;
 
 	down(&inode->i_sem);
 	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
 	up(&inode->i_sem);
+
+	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		int err;
+
+		err = sync_page_range(inode, mapping, *ppos - ret, ret);
+		if (err < 0)
+			ret = err;
+	}
 	return ret;
 }
 

_
