Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWESSAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWESSAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWESSAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:48 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:34780 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932448AbWESSAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:43 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 4/6] nfs: alloc nfs_read/write_data as direct I/O is scheduled
Date: Fri, 19 May 2006 14:00:32 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180032.3244.94575.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange the logic in the NFS direct I/O path so that nfs_read/write_data
structs are allocated just before they are scheduled, rather than
allocating them all at once before we start scheduling requests.

This will make it easier to support vectored asynchronous direct I/O.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c |  230 +++++++++++++++++++------------------------------------
 1 files changed, 79 insertions(+), 151 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index ae451db..9cd6b96 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -68,8 +68,6 @@ struct nfs_direct_req {
 	struct kref		kref;		/* release manager */
 
 	/* I/O parameters */
-	struct list_head	list,		/* nfs_read/write_data structs */
-				rewrite_list;	/* saved nfs_write_data structs */
 	struct nfs_open_context	*ctx;		/* file open context info */
 	struct kiocb *		iocb;		/* controlling i/o request */
 	struct inode *		inode;		/* target file of i/o */
@@ -82,6 +80,7 @@ struct nfs_direct_req {
 	struct completion	completion;	/* wait for i/o completion */
 
 	/* commit state */
+	struct list_head	rewrite_list;	/* saved nfs_write_data structs */
 	struct nfs_write_data *	commit_data;	/* special write_data for commits */
 	int			flags;
 #define NFS_ODIRECT_DO_COMMIT		(1)	/* an unstable reply was received */
@@ -113,6 +112,11 @@ static inline unsigned long nfs_count_pa
 	return page_count;
 }
 
+static inline unsigned int nfs_max_pages(unsigned int xsize)
+{
+	return (xsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+}
+
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
  * @rw: direction (read or write)
@@ -161,8 +165,8 @@ static inline struct nfs_direct_req *nfs
 		return NULL;
 
 	kref_init(&dreq->kref);
+	kref_get(&dreq->kref);
 	init_completion(&dreq->completion);
-	INIT_LIST_HEAD(&dreq->list);
 	INIT_LIST_HEAD(&dreq->rewrite_list);
 	dreq->iocb = NULL;
 	dreq->ctx = NULL;
@@ -225,49 +229,6 @@ static void nfs_direct_complete(struct n
 }
 
 /*
- * Note we also set the number of requests we have in the dreq when we are
- * done.  This prevents races with I/O completion so we will always wait
- * until all requests have been dispatched and completed.
- */
-static struct nfs_direct_req *nfs_direct_read_alloc(size_t nbytes, size_t rsize)
-{
-	struct list_head *list;
-	struct nfs_direct_req *dreq;
-	unsigned int rpages = (rsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	dreq = nfs_direct_req_alloc();
-	if (!dreq)
-		return NULL;
-
-	list = &dreq->list;
-	for(;;) {
-		struct nfs_read_data *data = nfs_readdata_alloc(rpages);
-
-		if (unlikely(!data)) {
-			while (!list_empty(list)) {
-				data = list_entry(list->next,
-						  struct nfs_read_data, pages);
-				list_del(&data->pages);
-				nfs_readdata_free(data);
-			}
-			kref_put(&dreq->kref, nfs_direct_req_release);
-			return NULL;
-		}
-
-		INIT_LIST_HEAD(&data->pages);
-		list_add(&data->pages, list);
-
-		data->req = (struct nfs_page *) dreq;
-		dreq->outstanding++;
-		if (nbytes <= rsize)
-			break;
-		nbytes -= rsize;
-	}
-	kref_get(&dreq->kref);
-	return dreq;
-}
-
-/*
  * We must hold a reference to all the pages in this direct read request
  * until the RPCs complete.  This could be long *after* we are woken up in
  * nfs_direct_wait (for instance, if someone hits ^C on a slow server).
@@ -306,39 +267,53 @@ static const struct rpc_call_ops nfs_rea
 };
 
 /*
- * For each nfs_read_data struct that was allocated on the list, dispatch
- * an NFS READ operation
+ * For each rsize'd chunk of the user's buffer, dispatch an NFS READ
+ * operation.  If nfs_readdata_alloc() or get_user_pages() fails,
+ * bail and stop sending more reads.  Read length accounting is
+ * handled automatically by nfs_direct_read_result() .
  */
-static void nfs_direct_read_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos)
+static int nfs_direct_read_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
-	struct list_head *list = &dreq->list;
 	size_t rsize = NFS_SERVER(inode)->rsize;
+	unsigned int rpages = nfs_max_pages(rsize);
 	unsigned int pgbase;
-	unsigned long result;
-	struct nfs_read_data *data;
+	unsigned int started = 0;
+
+	dreq->outstanding++;
 
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
+		struct nfs_read_data *data;
 		size_t bytes;
+		unsigned long result;
+
+		data = nfs_readdata_alloc(rpages);
+		if (unlikely(!data))
+			break;
 
 		bytes = rsize;
 		if (count < rsize)
 			bytes = count;
 
-		BUG_ON(list_empty(list));
-		data = list_entry(list->next, struct nfs_read_data, pages);
-		list_del_init(&data->pages);
-
 		data->npages = nfs_count_pages(user_addr, bytes);
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
 					data->npages, 1, 0, data->pagevec, NULL);
 		up_read(&current->mm->mmap_sem);
-		if (unlikely(result < data->npages))
-			goto out_err;
+		if (unlikely(result < data->npages)) {
+			nfs_release_user_pages(data->pagevec, result);
+			nfs_readdata_release(data);
+			break;
+		}
 
+		spin_lock(&dreq->lock);
+		dreq->outstanding++;
+		spin_unlock(&dreq->lock);
+		started++;	/* indicate there is something to wait for */
+
+		data->req = (struct nfs_page *) dreq;
 		data->inode = inode;
 		data->cred = ctx->cred;
 		data->args.fh = NFS_FH(inode);
@@ -375,33 +350,22 @@ static void nfs_direct_read_schedule(str
 
 		count -= bytes;
 	} while (count != 0);
-	BUG_ON(!list_empty(list));
-	return;
 
-	/* If get_user_pages fails, we stop sending reads.  Read length
-	 * accounting is handled by nfs_direct_read_result() . */
-out_err:
-	nfs_release_user_pages(data->pagevec, result);
-
-	list_add(&data->pages, list);
-	while (!list_empty(list)) {
-		data = list_entry(list->next, struct nfs_read_data, pages);
-		list_del(&data->pages);
-		nfs_readdata_free(data);
-		if (nfs_direct_dec_outstanding(dreq))
-			nfs_direct_complete(dreq);
-	}
+	if (nfs_direct_dec_outstanding(dreq))
+		nfs_direct_complete(dreq);
+
+	return started;
 }
 
 static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
-	ssize_t result;
+	ssize_t result = 0;
 	sigset_t oldset;
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_direct_req *dreq;
 
-	dreq = nfs_direct_read_alloc(count, NFS_SERVER(inode)->rsize);
+	dreq = nfs_direct_req_alloc();
 	if (!dreq)
 		return -ENOMEM;
 
@@ -412,8 +376,8 @@ static ssize_t nfs_direct_read(struct ki
 
 	nfs_add_stats(inode, NFSIOS_DIRECTREADBYTES, count);
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_read_schedule(dreq, user_addr, count, pos);
-	result = nfs_direct_wait(dreq);
+	if (nfs_direct_read_schedule(dreq, user_addr, count, pos))
+		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
 	return result;
@@ -421,9 +385,8 @@ static ssize_t nfs_direct_read(struct ki
 
 static void nfs_direct_free_writedata(struct nfs_direct_req *dreq)
 {
-	list_splice_init(&dreq->rewrite_list, &dreq->list);
-	while (!list_empty(&dreq->list)) {
-		struct nfs_write_data *data = list_entry(dreq->list.next, struct nfs_write_data, pages);
+	while (!list_empty(&dreq->rewrite_list)) {
+		struct nfs_write_data *data = list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
 		list_del(&data->pages);
 		nfs_release_user_pages(data->pagevec, data->npages);
 		nfs_writedata_release(data);
@@ -578,47 +541,6 @@ static void nfs_direct_write_complete(st
 }
 #endif
 
-static struct nfs_direct_req *nfs_direct_write_alloc(size_t nbytes, size_t wsize)
-{
-	struct list_head *list;
-	struct nfs_direct_req *dreq;
-	unsigned int wpages = (wsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	dreq = nfs_direct_req_alloc();
-	if (!dreq)
-		return NULL;
-
-	list = &dreq->list;
-	for(;;) {
-		struct nfs_write_data *data = nfs_writedata_alloc(wpages);
-
-		if (unlikely(!data)) {
-			while (!list_empty(list)) {
-				data = list_entry(list->next,
-						  struct nfs_write_data, pages);
-				list_del(&data->pages);
-				nfs_writedata_free(data);
-			}
-			kref_put(&dreq->kref, nfs_direct_req_release);
-			return NULL;
-		}
-
-		INIT_LIST_HEAD(&data->pages);
-		list_add(&data->pages, list);
-
-		data->req = (struct nfs_page *) dreq;
-		dreq->outstanding++;
-		if (nbytes <= wsize)
-			break;
-		nbytes -= wsize;
-	}
-
-	nfs_alloc_commit_data(dreq);
-
-	kref_get(&dreq->kref);
-	return dreq;
-}
-
 static void nfs_direct_write_result(struct rpc_task *task, void *calldata)
 {
 	struct nfs_write_data *data = calldata;
@@ -671,40 +593,55 @@ static const struct rpc_call_ops nfs_wri
 };
 
 /*
- * For each nfs_write_data struct that was allocated on the list, dispatch
- * an NFS WRITE operation
+ * For each wsize'd chunk of the user's buffer, dispatch an NFS WRITE
+ * operation.  If nfs_writedata_alloc() or get_user_pages() fails,
+ * bail and stop sending more writes.  Write length accounting is
+ * handled automatically by nfs_direct_write_result() .
  */
-static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos, int sync)
+static int nfs_direct_write_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos, int sync)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
-	struct list_head *list = &dreq->list;
 	size_t wsize = NFS_SERVER(inode)->wsize;
+	unsigned int wpages = nfs_max_pages(wsize);
 	unsigned int pgbase;
-	unsigned long result;
-	struct nfs_write_data *data;
+	unsigned int started = 0;
+
+	dreq->outstanding++;
 
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
+		struct nfs_write_data *data;
 		size_t bytes;
+		unsigned long result;
+
+		data = nfs_writedata_alloc(wpages);
+		if (unlikely(!data))
+			break;
 
 		bytes = wsize;
 		if (count < wsize)
 			bytes = count;
 
-		BUG_ON(list_empty(list));
-		data = list_entry(list->next, struct nfs_write_data, pages);
-
 		data->npages = nfs_count_pages(user_addr, bytes);
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
 					data->npages, 0, 0, data->pagevec, NULL);
 		up_read(&current->mm->mmap_sem);
-		if (unlikely(result < data->npages))
-			goto out_err;
+		if (unlikely(result < data->npages)) {
+			nfs_release_user_pages(data->pagevec, result);
+			nfs_writedata_release(data);
+			break;
+		}
+
+		spin_lock(&dreq->lock);
+		dreq->outstanding++;
+		spin_unlock(&dreq->lock);
+		started++;	/* indicate there is something to wait for */
 
 		list_move_tail(&data->pages, &dreq->rewrite_list);
 
+		data->req = (struct nfs_page *) dreq;
 		data->inode = inode;
 		data->cred = ctx->cred;
 		data->args.fh = NFS_FH(inode);
@@ -742,27 +679,16 @@ static void nfs_direct_write_schedule(st
 
 		count -= bytes;
 	} while (count != 0);
-	BUG_ON(!list_empty(list));
-	return;
 
-	/* If get_user_pages fails, we stop sending writes.  Write length
-	 * accounting is handled by nfs_direct_write_result() . */
-out_err:
-	nfs_release_user_pages(data->pagevec, result);
-
-	list_add(&data->pages, list);
-	while (!list_empty(list)) {
-		data = list_entry(list->next, struct nfs_write_data, pages);
-		list_del(&data->pages);
-		nfs_writedata_free(data);
-		if (nfs_direct_dec_outstanding(dreq))
-			nfs_direct_write_complete(dreq, inode);
-	}
+	if (nfs_direct_dec_outstanding(dreq))
+		nfs_direct_write_complete(dreq, inode);
+
+	return started;
 }
 
 static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
-	ssize_t result;
+	ssize_t result = 0;
 	sigset_t oldset;
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
@@ -770,9 +696,11 @@ static ssize_t nfs_direct_write(struct k
 	size_t wsize = NFS_SERVER(inode)->wsize;
 	int sync = 0;
 
-	dreq = nfs_direct_write_alloc(count, wsize);
+	dreq = nfs_direct_req_alloc();
 	if (!dreq)
 		return -ENOMEM;
+	nfs_alloc_commit_data(dreq);
+
 	if (dreq->commit_data == NULL || count < wsize)
 		sync = FLUSH_STABLE;
 
@@ -786,8 +714,8 @@ static ssize_t nfs_direct_write(struct k
 	nfs_begin_data_update(inode);
 
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_write_schedule(dreq, user_addr, count, pos, sync);
-	result = nfs_direct_wait(dreq);
+	if (nfs_direct_write_schedule(dreq, user_addr, count, pos, sync))
+		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
 	return result;
