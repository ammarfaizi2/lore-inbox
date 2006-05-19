Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWESSA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWESSA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWESSAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:46 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:60309 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932415AbWESSAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:32 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 3/6] nfs: Eliminate nfs_get_user_pages()
Date: Fri, 19 May 2006 14:00:28 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180028.3244.7809.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown observed that the kmalloc() in nfs_get_user_pages() is more
likely to fail if the I/O is large enough to require the allocation of more
than a single page to keep track of all the pinned pages in the user's
buffer.

Instead of tracking one large page array per dreq/iocb, track pages per
nfs_read/write_data, just like the cached I/O path does.  An array for
pages is already allocated for us by nfs_readdata_alloc() (and the write
and commit equivalents).

This is also required for adding support for vectored I/O to the NFS direct
I/O path.

The original reason to pin the user buffer and allocate all the NFS data
structures before trying to schedule I/O was to ensure all needed resources
are allocated on the client before starting to send requests.  This reduces
the chance that resource exhaustion on the client will cause a short read
or write.

On the other hand, for an application making very large application I/O
requests, this means that it will be nearly impossible for the application
to make forward progress on a resource-limited client.

Thus, moving the buffer pinning functionality into the I/O scheduling
loops should be good for scalability.  The next patch will do the same for
NFS data structure allocation.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c         |  173 ++++++++++++++++++++++++-----------------------
 include/linux/nfs_xdr.h |    2 +
 2 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index aef0b98..ae451db 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -73,8 +73,6 @@ struct nfs_direct_req {
 	struct nfs_open_context	*ctx;		/* file open context info */
 	struct kiocb *		iocb;		/* controlling i/o request */
 	struct inode *		inode;		/* target file of i/o */
-	struct page **		pages;		/* pages in our buffer */
-	unsigned int		npages;		/* count of pages */
 
 	/* completion state */
 	spinlock_t		lock;		/* protect completion state */
@@ -105,6 +103,16 @@ static inline int nfs_direct_dec_outstan
 	return (result == 0);
 }
 
+static inline unsigned long nfs_count_pages(unsigned long user_addr, size_t size)
+{
+	unsigned long page_count;
+
+	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	page_count -= user_addr >> PAGE_SHIFT;
+
+	return page_count;
+}
+
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
  * @rw: direction (read or write)
@@ -127,50 +135,21 @@ ssize_t nfs_direct_IO(int rw, struct kio
 	return -EINVAL;
 }
 
-static void nfs_free_user_pages(struct page **pages, int npages, int do_dirty)
+static void nfs_dirty_user_pages(struct page **pages, int npages)
 {
 	int i;
 	for (i = 0; i < npages; i++) {
 		struct page *page = pages[i];
-		if (do_dirty && !PageCompound(page))
+		if (!PageCompound(page))
 			set_page_dirty_lock(page);
-		page_cache_release(page);
 	}
-	kfree(pages);
 }
 
-static inline int nfs_get_user_pages(int rw, unsigned long user_addr, size_t size, struct page ***pages)
+static void nfs_release_user_pages(struct page **pages, int npages)
 {
-	int result = -ENOMEM;
-	unsigned long page_count;
-	size_t array_size;
-
-	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	page_count -= user_addr >> PAGE_SHIFT;
-
-	array_size = (page_count * sizeof(struct page *));
-	*pages = kmalloc(array_size, GFP_KERNEL);
-	if (*pages) {
-		down_read(&current->mm->mmap_sem);
-		result = get_user_pages(current, current->mm, user_addr,
-					page_count, (rw == READ), 0,
-					*pages, NULL);
-		up_read(&current->mm->mmap_sem);
-		if (result != page_count) {
-			/*
-			 * If we got fewer pages than expected from
-			 * get_user_pages(), the user buffer runs off the
-			 * end of a mapping; return EFAULT.
-			 */
-			if (result >= 0) {
-				nfs_free_user_pages(*pages, result, 0);
-				result = -EFAULT;
-			} else
-				kfree(*pages);
-			*pages = NULL;
-		}
-	}
-	return result;
+	int i;
+	for (i = 0; i < npages; i++)
+		page_cache_release(pages[i]);
 }
 
 static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
@@ -229,18 +208,11 @@ out:
 }
 
 /*
- * We must hold a reference to all the pages in this direct read request
- * until the RPCs complete.  This could be long *after* we are woken up in
- * nfs_direct_wait (for instance, if someone hits ^C on a slow server).
- *
- * In addition, synchronous I/O uses a stack-allocated iocb.  Thus we
- * can't trust the iocb is still valid here if this is a synchronous
- * request.  If the waiter is woken prematurely, the iocb is long gone.
+ * Synchronous I/O uses a stack-allocated iocb.  Thus we can't trust
+ * the iocb is still valid here if this is a synchronous request.
  */
 static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
-	nfs_free_user_pages(dreq->pages, dreq->npages, 1);
-
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (!res)
@@ -295,6 +267,11 @@ static struct nfs_direct_req *nfs_direct
 	return dreq;
 }
 
+/*
+ * We must hold a reference to all the pages in this direct read request
+ * until the RPCs complete.  This could be long *after* we are woken up in
+ * nfs_direct_wait (for instance, if someone hits ^C on a slow server).
+ */
 static void nfs_direct_read_result(struct rpc_task *task, void *calldata)
 {
 	struct nfs_read_data *data = calldata;
@@ -303,6 +280,9 @@ static void nfs_direct_read_result(struc
 	if (nfs_readpage_result(task, data) != 0)
 		return;
 
+	nfs_dirty_user_pages(data->pagevec, data->npages);
+	nfs_release_user_pages(data->pagevec, data->npages);
+
 	spin_lock(&dreq->lock);
 
 	if (likely(task->tk_status >= 0))
@@ -316,6 +296,7 @@ static void nfs_direct_read_result(struc
 	}
 
 	spin_unlock(&dreq->lock);
+
 	nfs_direct_complete(dreq);
 }
 
@@ -333,14 +314,13 @@ static void nfs_direct_read_schedule(str
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	struct list_head *list = &dreq->list;
-	struct page **pages = dreq->pages;
 	size_t rsize = NFS_SERVER(inode)->rsize;
-	unsigned int curpage, pgbase;
+	unsigned int pgbase;
+	unsigned long result;
+	struct nfs_read_data *data;
 
-	curpage = 0;
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
-		struct nfs_read_data *data;
 		size_t bytes;
 
 		bytes = rsize;
@@ -351,13 +331,21 @@ static void nfs_direct_read_schedule(str
 		data = list_entry(list->next, struct nfs_read_data, pages);
 		list_del_init(&data->pages);
 
+		data->npages = nfs_count_pages(user_addr, bytes);
+		down_read(&current->mm->mmap_sem);
+		result = get_user_pages(current, current->mm, user_addr,
+					data->npages, 1, 0, data->pagevec, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (unlikely(result < data->npages))
+			goto out_err;
+
 		data->inode = inode;
 		data->cred = ctx->cred;
 		data->args.fh = NFS_FH(inode);
 		data->args.context = ctx;
 		data->args.offset = pos;
 		data->args.pgbase = pgbase;
-		data->args.pages = &pages[curpage];
+		data->args.pages = data->pagevec;
 		data->args.count = bytes;
 		data->res.fattr = &data->fattr;
 		data->res.eof = 0;
@@ -380,17 +368,32 @@ static void nfs_direct_read_schedule(str
 				bytes,
 				(unsigned long long)data->args.offset);
 
+		user_addr += bytes;
 		pos += bytes;
 		pgbase += bytes;
-		curpage += pgbase >> PAGE_SHIFT;
 		pgbase &= ~PAGE_MASK;
 
 		count -= bytes;
 	} while (count != 0);
 	BUG_ON(!list_empty(list));
+	return;
+
+	/* If get_user_pages fails, we stop sending reads.  Read length
+	 * accounting is handled by nfs_direct_read_result() . */
+out_err:
+	nfs_release_user_pages(data->pagevec, result);
+
+	list_add(&data->pages, list);
+	while (!list_empty(list)) {
+		data = list_entry(list->next, struct nfs_read_data, pages);
+		list_del(&data->pages);
+		nfs_readdata_free(data);
+		if (nfs_direct_dec_outstanding(dreq))
+			nfs_direct_complete(dreq);
+	}
 }
 
-static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos, struct page **pages, unsigned int nr_pages)
+static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
 	ssize_t result;
 	sigset_t oldset;
@@ -402,8 +405,6 @@ static ssize_t nfs_direct_read(struct ki
 	if (!dreq)
 		return -ENOMEM;
 
-	dreq->pages = pages;
-	dreq->npages = nr_pages;
 	dreq->inode = inode;
 	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
 	if (!is_sync_kiocb(iocb))
@@ -424,6 +425,7 @@ static void nfs_direct_free_writedata(st
 	while (!list_empty(&dreq->list)) {
 		struct nfs_write_data *data = list_entry(dreq->list.next, struct nfs_write_data, pages);
 		list_del(&data->pages);
+		nfs_release_user_pages(data->pagevec, data->npages);
 		nfs_writedata_release(data);
 	}
 }
@@ -677,14 +679,13 @@ static void nfs_direct_write_schedule(st
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	struct list_head *list = &dreq->list;
-	struct page **pages = dreq->pages;
 	size_t wsize = NFS_SERVER(inode)->wsize;
-	unsigned int curpage, pgbase;
+	unsigned int pgbase;
+	unsigned long result;
+	struct nfs_write_data *data;
 
-	curpage = 0;
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
-		struct nfs_write_data *data;
 		size_t bytes;
 
 		bytes = wsize;
@@ -693,6 +694,15 @@ static void nfs_direct_write_schedule(st
 
 		BUG_ON(list_empty(list));
 		data = list_entry(list->next, struct nfs_write_data, pages);
+
+		data->npages = nfs_count_pages(user_addr, bytes);
+		down_read(&current->mm->mmap_sem);
+		result = get_user_pages(current, current->mm, user_addr,
+					data->npages, 0, 0, data->pagevec, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (unlikely(result < data->npages))
+			goto out_err;
+
 		list_move_tail(&data->pages, &dreq->rewrite_list);
 
 		data->inode = inode;
@@ -701,7 +711,7 @@ static void nfs_direct_write_schedule(st
 		data->args.context = ctx;
 		data->args.offset = pos;
 		data->args.pgbase = pgbase;
-		data->args.pages = &pages[curpage];
+		data->args.pages = data->pagevec;
 		data->args.count = bytes;
 		data->res.fattr = &data->fattr;
 		data->res.count = bytes;
@@ -725,17 +735,32 @@ static void nfs_direct_write_schedule(st
 				bytes,
 				(unsigned long long)data->args.offset);
 
+		user_addr += bytes;
 		pos += bytes;
 		pgbase += bytes;
-		curpage += pgbase >> PAGE_SHIFT;
 		pgbase &= ~PAGE_MASK;
 
 		count -= bytes;
 	} while (count != 0);
 	BUG_ON(!list_empty(list));
+	return;
+
+	/* If get_user_pages fails, we stop sending writes.  Write length
+	 * accounting is handled by nfs_direct_write_result() . */
+out_err:
+	nfs_release_user_pages(data->pagevec, result);
+
+	list_add(&data->pages, list);
+	while (!list_empty(list)) {
+		data = list_entry(list->next, struct nfs_write_data, pages);
+		list_del(&data->pages);
+		nfs_writedata_free(data);
+		if (nfs_direct_dec_outstanding(dreq))
+			nfs_direct_write_complete(dreq, inode);
+	}
 }
 
-static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos, struct page **pages, int nr_pages)
+static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
 	ssize_t result;
 	sigset_t oldset;
@@ -751,8 +776,6 @@ static ssize_t nfs_direct_write(struct k
 	if (dreq->commit_data == NULL || count < wsize)
 		sync = FLUSH_STABLE;
 
-	dreq->pages = pages;
-	dreq->npages = nr_pages;
 	dreq->inode = inode;
 	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
 	if (!is_sync_kiocb(iocb))
@@ -795,8 +818,6 @@ ssize_t nfs_file_direct_read(struct kioc
 				unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval = -EINVAL;
-	int page_count;
-	struct page **pages;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	/* XXX: temporary */
@@ -824,14 +845,7 @@ ssize_t nfs_file_direct_read(struct kioc
 	if (retval)
 		goto out;
 
-	retval = nfs_get_user_pages(READ, (unsigned long) buf,
-						count, &pages);
-	if (retval < 0)
-		goto out;
-	page_count = retval;
-
-	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos,
-						pages, page_count);
+	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos);
 	if (retval > 0)
 		iocb->ki_pos = pos + retval;
 
@@ -868,8 +882,6 @@ ssize_t nfs_file_direct_write(struct kio
 				unsigned long nr_segs, loff_t pos)
 {
 	ssize_t retval;
-	int page_count;
-	struct page **pages;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	/* XXX: temporary */
@@ -903,14 +915,7 @@ ssize_t nfs_file_direct_write(struct kio
 	if (retval)
 		goto out;
 
-	retval = nfs_get_user_pages(WRITE, (unsigned long) buf,
-						count, &pages);
-	if (retval < 0)
-		goto out;
-	page_count = retval;
-
-	retval = nfs_direct_write(iocb, (unsigned long) buf, count,
-					pos, pages, page_count);
+	retval = nfs_direct_write(iocb, (unsigned long) buf, count, pos);
 
 	/*
 	 * XXX: nfs_end_data_update() already ensures this file's
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 7c7320f..102b5c8 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -729,6 +729,7 @@ struct nfs_read_data {
 	struct list_head	pages;	/* Coalesced read requests */
 	struct nfs_page		*req;	/* multi ops per nfs_page */
 	struct page		**pagevec;
+	int			npages;	/* active pages in pagevec */
 	struct nfs_readargs args;
 	struct nfs_readres  res;
 #ifdef CONFIG_NFS_V4
@@ -747,6 +748,7 @@ struct nfs_write_data {
 	struct list_head	pages;		/* Coalesced requests we wish to flush */
 	struct nfs_page		*req;		/* multi ops per nfs_page */
 	struct page		**pagevec;
+	int			npages;		/* active pages in pagevec */
 	struct nfs_writeargs	args;		/* argument struct */
 	struct nfs_writeres	res;		/* result struct */
 #ifdef CONFIG_NFS_V4
