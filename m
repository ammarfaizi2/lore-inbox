Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSKLWyQ>; Tue, 12 Nov 2002 17:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbSKLWyQ>; Tue, 12 Nov 2002 17:54:16 -0500
Received: from spacewalker.citi.umich.edu ([141.211.133.39]:6272 "EHLO
	spacewalker.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267020AbSKLWyB>; Tue, 12 Nov 2002 17:54:01 -0500
Date: Tue, 12 Nov 2002 18:00:44 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS O_DIRECT clean-up #2
Message-ID: <Pine.LNX.4.44.0211121758250.3001-100000@spacewalker.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get NFS O_DIRECT support close to working.  affects only O_DIRECT paths, 
no normal I/O paths are touched.

against 2.5.47.


diff -ruN 04-odirect1/fs/nfs/direct.c 05-odirect2/fs/nfs/direct.c
--- 04-odirect1/fs/nfs/direct.c	Tue Nov 12 16:07:53 2002
+++ 05-odirect2/fs/nfs/direct.c	Tue Nov 12 16:08:54 2002
@@ -35,10 +35,12 @@
  */
 
 #include <linux/config.h>
+#include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/file.h>
-#include <linux/errno.h>
+#include <linux/pagemap.h>
+
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
 #include <linux/sunrpc/clnt.h>
@@ -48,33 +50,39 @@
 
 #define NFSDBG_FACILITY		(NFSDBG_PAGECACHE | NFSDBG_VFS)
 #define VERF_SIZE		(2 * sizeof(__u32))
+#define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
 
 /**
- * nfs_get_user_pages - find and set up page representing user buffer
- * addr: user-space address of target buffer
- * size: total size in bytes of target buffer
+ * nfs_get_user_pages - find and set up pages representing user buffer
+ * @vec: pointer to vector that defines I/O buffer
  * @pages: returned array of page struct pointers underlying target buffer
- * write: whether or not buffer is target of a write operation
+ * rw: whether or not buffer is target of a write operation
  */
 static inline int
-nfs_get_user_pages(unsigned long addr, size_t size,
-		struct page ***pages, int rw)
+nfs_get_user_pages(int rw, const struct iovec *vec, struct page ***pages)
 {
+	unsigned long addr = (unsigned long) vec->iov_base;
+	size_t size = vec->iov_len;
 	int result = -ENOMEM;
-	unsigned page_count = (unsigned) size >> PAGE_SHIFT;
-	unsigned array_size = (page_count * sizeof(struct page *)) + 2U;
+	unsigned long page_count;
+	size_t array_size;
+
+	/* set an arbitrary limit to prevent arithmetic overflow */
+	if (size > MAX_DIRECTIO_SIZE)
+		return -EFBIG;
+
+	page_count = (addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	page_count -= addr >> PAGE_SHIFT;
 
-	*pages = (struct page **) kmalloc(array_size, GFP_KERNEL);
+	array_size = (page_count * sizeof(struct page *));
+	*pages = kmalloc(array_size, GFP_KERNEL);
 	if (*pages) {
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, addr,
-					page_count, (rw == WRITE), 0,
+					page_count, (rw == READ), 0,
 					*pages, NULL);
 		up_read(&current->mm->mmap_sem);
-		if (result < 0)
-			printk(KERN_ERR "%s: get_user_pages result %d\n",
-					__FUNCTION__, result);
 	}
 	return result;
 }
@@ -84,141 +92,208 @@
  * @pages: array of page struct pointers underlying target buffer
  */
 static inline void
-nfs_free_user_pages(struct page **pages, unsigned count)
+nfs_free_user_pages(struct page **pages)
+{
+	kfree(pages);
+}
+
+/**
+ * nfs_iov2pagelist - convert one iov to a list of page requests
+ * rw: direction (read or write)
+ * @file: file struct of target file
+ * @iov: pointer to vector that defines I/O buffer
+ * offset: where in file to begin the read
+ * @pages: array of mapped pages to use for this I/O
+ * @requests: append new page requests to this list head
+ */
+static int
+nfs_iov2pagelist(int rw, struct file *file, const struct iovec *iov,
+		loff_t offset, struct page **pages, struct list_head *requests)
 {
+	struct inode *inode = file->f_dentry->d_inode;
+	struct rpc_cred *cred = nfs_file_cred(file);
+	unsigned long user_addr = (unsigned long) iov->iov_base;
+	size_t bytes = iov->iov_len;
+
+	unsigned pg_offset = user_addr & ~PAGE_MASK;
 	unsigned page = 0;
+	int tot_bytes = 0;
+
+	while (bytes) {
+		struct nfs_page *new;
+		unsigned pg_bytes;
+
+		pg_bytes = PAGE_SIZE - pg_offset;
+		if (pg_bytes > bytes)
+			pg_bytes = bytes;
+
+		/* page is unlocked by nfs_readpage_result */
+		if (rw == READ)
+			lock_page(pages[page]);
+
+		new = nfs_create_request(cred, inode, pages[page],
+					 pg_offset, pg_bytes);
+		if (IS_ERR(new)) {
+			nfs_release_list(requests);
+			nfs_free_user_pages(pages);
+			return PTR_ERR(new);
+		}
 
-	while (count--)
-		page_cache_release(pages[page++]);
+		new->wb_index = offset >> PAGE_SHIFT;
+		new->wb_offset = offset & ~ PAGE_MASK;
+		if (rw == WRITE)
+			/* a la nfs_update_request */
+			nfs_lock_request_dontget(new);
+		else
+			/* a la nfs_scan_list */
+			nfs_lock_request(new);
+		nfs_list_add_request(new, requests);
+
+		offset += pg_bytes;
+		tot_bytes += pg_bytes;
+		bytes -= pg_bytes;
+		page++;
 
-	kfree(pages);
+		/* after the first page */
+		pg_offset = 0;
+	}
+
+	return tot_bytes;
 }
 
 /**
- * nfs_iov2pagelist - convert an array of iovecs to a list of page requests
- * @inode: inode of target file
- * @cred: credentials of user who requested I/O
+ * nfs_direct_read_async - Read directly using asynchronous RPC
+ * @file: target file
  * @iov: array of vectors that define I/O buffer
  * offset: where in file to begin the read
  * nr_segs: size of iovec array
- * @requests: append new page requests to this list head
+ *
+ * Flush out pending writes in the page cache first so we pick up changes
+ * made by non-direct writers.  Then convert the iovecs into a list of NFS
+ * page requests, and page them in.
  */
 static int
-nfs_iov2pagelist(int rw, const struct inode *inode,
-		const struct rpc_cred *cred,
-		const struct iovec *iov, loff_t offset,
-		unsigned long nr_segs, struct list_head *requests)
+nfs_direct_read_async(struct file *file, const struct iovec *iov,
+		loff_t offset, unsigned long nr_segs)
 {
+	LIST_HEAD(requests);
+	struct page **pages;
+	struct inode *inode = file->f_dentry->d_inode;
 	unsigned seg;
+	int result;
 	int tot_bytes = 0;
-	struct page **pages;
 
-	/* for each iovec in the array... */
+	/* push any pending non-direct writes so our reads see them */
+	result = nfs_wb_all(inode);
+	if (result < 0) {
+		result = file->f_error;
+		file->f_error = 0;
+		return result;
+	}
+
 	for (seg = 0; seg < nr_segs; seg++) {
-		const unsigned long user_addr =
-					(unsigned long) iov[seg].iov_base;
-		size_t bytes = iov[seg].iov_len;
-		unsigned int pg_offset = (user_addr & ~PAGE_MASK);
-		int page_count, page = 0;
+		const struct iovec *vec = &iov[seg];
+		int page_count;
 
-		page_count = nfs_get_user_pages(user_addr, bytes, &pages, rw);
+		page_count = nfs_get_user_pages(READ, vec, &pages);
 		if (page_count < 0) {
-			nfs_release_list(requests);
+			nfs_release_list(&requests);
+			nfs_free_user_pages(pages);
 			return page_count;
 		}
 
-		/* ...build as many page requests as required */
-		while (bytes > 0) {
-			struct nfs_page *new;
-			const unsigned int pg_bytes = (bytes > PAGE_SIZE) ?
-							PAGE_SIZE : bytes;
-
-			new = nfs_create_request((struct rpc_cred *) cred,
-						 (struct inode *) inode,
-						 pages[page],
-						 pg_offset, pg_bytes);
-			if (IS_ERR(new)) {
-				nfs_free_user_pages(pages, page_count);
-				nfs_release_list(requests);
-				return PTR_ERR(new);
-			}
-			new->wb_index = offset;
-			nfs_list_add_request(new, requests);
-
-			/* after the first page */
-			pg_offset = 0;
-			offset += PAGE_SIZE;
-			tot_bytes += pg_bytes;
-			bytes -= pg_bytes;
-			page++;
+		result = nfs_iov2pagelist(READ, file, vec, offset, pages,
+				&requests);
+		if (result <= 0) {
+			nfs_release_list(&requests);
+			nfs_free_user_pages(pages);
+			return result;
+		}
+		tot_bytes += result;
+
+		result = nfs_pagein_list(&requests,
+					NFS_SERVER(inode)->rpages);
+		if (result < 0) {
+			tot_bytes = result;
+			nfs_free_user_pages(pages);
+			break;
 		}
 
-		/* don't release pages here -- I/O completion will do that */
-		nfs_free_user_pages(pages, 0);
+		while (page_count--) {
+			struct page *page = pages[page_count];
+
+			page_cache_get(page);
+			wait_on_page_locked(page);
+			if (PageError(page))
+				tot_bytes = -EIO;
+			page_cache_release(page);
+		}
+
+		nfs_free_user_pages(pages);
+
+		if (tot_bytes < 0)
+			break;
 	}
 
 	return tot_bytes;
 }
 
 /**
- * do_nfs_direct_IO - Read or write data without caching
- * @inode: inode of target file
- * @cred: credentials of user who requested I/O
+ * nfs_direct_write_async - Write directly using asynchronous RPC
+ * @file: file struct of target file
  * @iov: array of vectors that define I/O buffer
  * offset: where in file to begin the read
  * nr_segs: size of iovec array
  *
- * Break the passed-in iovec into a series of page-sized or smaller
- * requests, where each page is mapped for direct user-land I/O.
- *
- * For each of these pages, create an NFS page request and
- * append it to an automatic list of page requests.
+ * Convert the iovecs into a list of NFS page requests, then flush
+ * them out.  Invalidate any cached pages for this file so that normal
+ * accessors will see these changes.
  *
- * When all page requests have been queued, start the I/O on the
- * whole list.  The underlying routines coalesce the pages on the
- * list into a bunch of asynchronous "r/wsize" network requests.
+ * nfs_writeback_done will emit COMMIT requests should they be required.
  *
- * I/O completion automatically unmaps and releases the pages.
+ * O_SYNC for files and "sync" for file systems causes STABLE writes
+ * that are sent one at a time.  This is for applications that have
+ * ultra-strict write ordering requirements.
  */
 static int
-do_nfs_direct_IO(int rw, const struct inode *inode,
-		const struct rpc_cred *cred, const struct iovec *iov,
+nfs_direct_write_async(struct file *file, const struct iovec *iov,
 		loff_t offset, unsigned long nr_segs)
 {
 	LIST_HEAD(requests);
-	int result, tot_bytes;
+	struct page **pages;
+	struct inode *inode = file->f_dentry->d_inode;
+	unsigned seg;
+	int result;
+	int tot_bytes = 0;
+	int flags = IS_SYNC(inode) ?  FLUSH_STABLE | FLUSH_WAIT : FLUSH_WAIT;
 
-	result = nfs_iov2pagelist(rw, inode, cred, iov, offset, nr_segs,
-								&requests);
-	if (result < 0)
-		return result;
-	tot_bytes = result;
+	for (seg = 0; seg < nr_segs; seg++) {
+		const struct iovec *vec = &iov[seg];
 
-	switch (rw) {
-	case READ:
-		if (IS_SYNC(inode) || (NFS_SERVER(inode)->rsize < PAGE_SIZE)) {
-			result = nfs_direct_read_sync(inode, cred, iov, offset, nr_segs);
-			break;
+		result = nfs_get_user_pages(WRITE, vec, &pages);
+		if (result < 0) {
+			nfs_release_list(&requests);
+			nfs_free_user_pages(pages);
+			return result;
 		}
-		result = nfs_pagein_list(&requests, NFS_SERVER(inode)->rpages);
-		break;
-	case WRITE:
-		if (IS_SYNC(inode) || (NFS_SERVER(inode)->wsize < PAGE_SIZE))
-			result = nfs_direct_write_sync(inode, cred, iov, offset, nr_segs);
-		else
-			result = nfs_flush_list(&requests,
-					NFS_SERVER(inode)->wpages, FLUSH_WAIT);
 
-		/* invalidate cache so non-direct readers pick up changes */
-		invalidate_inode_pages((struct inode *) inode);
-		break;
-	default:
-		result = -EINVAL;
-		break;
+		result = nfs_iov2pagelist(WRITE, file, vec, offset,
+							pages, &requests);
+		nfs_free_user_pages(pages);
+		if (result <= 0)
+			break;
+		tot_bytes += result;
+
+		result = nfs_flush_list(&requests,
+					NFS_SERVER(inode)->wpages, flags);
+		if (result < 0) {
+			tot_bytes = result;
+			break;
+		}
 	}
 
-	if (result < 0)
-		return result;
+	/* cause any non-direct readers to pick up our writes */
+	invalidate_inode_pages(inode->i_mapping);
 	return tot_bytes;
 }
 
@@ -232,27 +307,39 @@
  *
  * The inode's i_sem is no longer held by the VFS layer before it calls
  * this function to do a write.
+ *
+ * For now, NFS O_DIRECT returns -EINVAL when r/wsize is smaller than
+ * PAGE_SIZE.
  */
 int
 nfs_direct_IO(int rw, struct file *file, const struct iovec *iov,
 		loff_t offset, unsigned long nr_segs)
 {
-	/* None of this works yet, so prevent it from compiling. */
-#if 0
-	int result;
-	struct dentry *dentry = file->f_dentry;
-	const struct inode *inode = dentry->d_inode->i_mapping->host;
-	const struct rpc_cred *cred = nfs_file_cred(file);
-#endif
-
-	dfprintk(VFS, "NFS: direct_IO(%s) (%s/%s) off/no(%Lu/%lu)\n",
-				((rw == READ) ? "READ" : "WRITE"),
-				dentry->d_parent->d_name.name,
-				dentry->d_name.name, offset, nr_segs);
+	int result = -EINVAL;
+	struct inode *inode = file->f_dentry->d_inode;
 
-	result = do_nfs_direct_IO(rw, inode, cred, iov, offset, nr_segs);
+	switch (rw) {
+	case READ:
+		dfprintk(VFS, "NFS: direct_IO(read) (%s) off/no(%Lu/%lu)\n",
+			file->f_dentry->d_name.name, offset, nr_segs);
+
+		if (NFS_SERVER(inode)->rpages)
+			result = nfs_direct_read_async(file, iov, offset,
+					nr_segs);
+		break;
+	case WRITE:
+		dfprintk(VFS, "NFS: direct_IO(write) (%s) off/no(%Lu/%lu)\n",
+			file->f_dentry->d_name.name, offset, nr_segs);
+
+		if (NFS_SERVER(inode)->wpages)
+			result = nfs_direct_write_async(file, iov, offset,
+					nr_segs);
+		break;
+	default:
+		break;
+	}
 
-	dfprintk(VFS, "NFS: direct_IO result = %d\n", result);
+	dfprintk(VFS, "NFS: direct_IO result=%d\n", result);
 
 	return result;
 }

