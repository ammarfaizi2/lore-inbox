Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWIHAUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWIHAUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWIHAUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:20:06 -0400
Received: from c-69-241-229-183.hsd1.mi.comcast.net ([69.241.229.183]:50082
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S1751934AbWIHAUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:20:01 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH] NFS: large non-page-aligned direct I/O clobbers memory
Date: Thu, 07 Sep 2006 20:19:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Message-Id: <20060908001959.11254.3925.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

The logic in nfs_direct_read_schedule and nfs_direct_write_schedule can
allow data->npages to be one larger than rpages.  This causes a page
pointer to be written beyond the end of the pagevec in nfs_read_data (or
nfs_write_data).

Fix this by making nfs_(read|write)_alloc() calculate the size of the
pagevec array, and initialise data->npages.

Also get rid of the redundant argument to nfs_commit_alloc().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/direct.c         |   50 +++++++++++++----------------------------------
 fs/nfs/read.c           |   24 ++++++++++++-----------
 fs/nfs/write.c          |   37 ++++++++++++++---------------------
 include/linux/nfs_fs.h  |    6 +++---
 include/linux/nfs_xdr.h |    4 ++--
 5 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index fecd3b0..76ca1cb 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -100,25 +100,6 @@ static inline int put_dreq(struct nfs_di
 	return atomic_dec_and_test(&dreq->io_count);
 }
 
-/*
- * "size" is never larger than rsize or wsize.
- */
-static inline int nfs_direct_count_pages(unsigned long user_addr, size_t size)
-{
-	int page_count;
-
-	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	page_count -= user_addr >> PAGE_SHIFT;
-	BUG_ON(page_count < 0);
-
-	return page_count;
-}
-
-static inline unsigned int nfs_max_pages(unsigned int size)
-{
-	return (size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-}
-
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
  * @rw: direction (read or write)
@@ -276,28 +257,24 @@ static ssize_t nfs_direct_read_schedule(
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	size_t rsize = NFS_SERVER(inode)->rsize;
-	unsigned int rpages = nfs_max_pages(rsize);
 	unsigned int pgbase;
 	int result;
 	ssize_t started = 0;
 
 	get_dreq(dreq);
 
-	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_read_data *data;
 		size_t bytes;
 
+		pgbase = user_addr & ~PAGE_MASK;
+		bytes = min(rsize,count);
+
 		result = -ENOMEM;
-		data = nfs_readdata_alloc(rpages);
+		data = nfs_readdata_alloc(pgbase + bytes);
 		if (unlikely(!data))
 			break;
 
-		bytes = rsize;
-		if (count < rsize)
-			bytes = count;
-
-		data->npages = nfs_direct_count_pages(user_addr, bytes);
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
 					data->npages, 1, 0, data->pagevec, NULL);
@@ -344,8 +321,10 @@ static ssize_t nfs_direct_read_schedule(
 		started += bytes;
 		user_addr += bytes;
 		pos += bytes;
+		/* FIXME: Remove this unnecessary math from final patch */
 		pgbase += bytes;
 		pgbase &= ~PAGE_MASK;
+		BUG_ON(pgbase != (user_addr & ~PAGE_MASK));
 
 		count -= bytes;
 	} while (count != 0);
@@ -524,7 +503,7 @@ static void nfs_direct_write_complete(st
 
 static void nfs_alloc_commit_data(struct nfs_direct_req *dreq)
 {
-	dreq->commit_data = nfs_commit_alloc(0);
+	dreq->commit_data = nfs_commit_alloc();
 	if (dreq->commit_data != NULL)
 		dreq->commit_data->req = (struct nfs_page *) dreq;
 }
@@ -605,28 +584,24 @@ static ssize_t nfs_direct_write_schedule
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	size_t wsize = NFS_SERVER(inode)->wsize;
-	unsigned int wpages = nfs_max_pages(wsize);
 	unsigned int pgbase;
 	int result;
 	ssize_t started = 0;
 
 	get_dreq(dreq);
 
-	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_write_data *data;
 		size_t bytes;
 
+		pgbase = user_addr & ~PAGE_MASK;
+		bytes = min(wsize,count);
+
 		result = -ENOMEM;
-		data = nfs_writedata_alloc(wpages);
+		data = nfs_writedata_alloc(pgbase + bytes);
 		if (unlikely(!data))
 			break;
 
-		bytes = wsize;
-		if (count < wsize)
-			bytes = count;
-
-		data->npages = nfs_direct_count_pages(user_addr, bytes);
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
 					data->npages, 0, 0, data->pagevec, NULL);
@@ -676,8 +651,11 @@ static ssize_t nfs_direct_write_schedule
 		started += bytes;
 		user_addr += bytes;
 		pos += bytes;
+
+		/* FIXME: Remove this useless math from the final patch */
 		pgbase += bytes;
 		pgbase &= ~PAGE_MASK;
+		BUG_ON(pgbase != (user_addr & ~PAGE_MASK));
 
 		count -= bytes;
 	} while (count != 0);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index da9cf11..7a9ee00 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -43,13 +43,15 @@ static mempool_t *nfs_rdata_mempool;
 
 #define MIN_POOL_READ	(32)
 
-struct nfs_read_data *nfs_readdata_alloc(unsigned int pagecount)
+struct nfs_read_data *nfs_readdata_alloc(size_t len)
 {
+	unsigned int pagecount = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	struct nfs_read_data *p = mempool_alloc(nfs_rdata_mempool, SLAB_NOFS);
 
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
+		p->npages = pagecount;
 		if (pagecount <= ARRAY_SIZE(p->page_array))
 			p->pagevec = p->page_array;
 		else {
@@ -140,7 +142,7 @@ static int nfs_readpage_sync(struct nfs_
 	int		result;
 	struct nfs_read_data *rdata;
 
-	rdata = nfs_readdata_alloc(1);
+	rdata = nfs_readdata_alloc(count);
 	if (!rdata)
 		return -ENOMEM;
 
@@ -336,25 +338,25 @@ static int nfs_pagein_multi(struct list_
 	struct nfs_page *req = nfs_list_entry(head->next);
 	struct page *page = req->wb_page;
 	struct nfs_read_data *data;
-	unsigned int rsize = NFS_SERVER(inode)->rsize;
-	unsigned int nbytes, offset;
+	size_t rsize = NFS_SERVER(inode)->rsize, nbytes;
+	unsigned int offset;
 	int requests = 0;
 	LIST_HEAD(list);
 
 	nfs_list_remove_request(req);
 
 	nbytes = req->wb_bytes;
-	for(;;) {
-		data = nfs_readdata_alloc(1);
+	do {
+		size_t len = min(nbytes,rsize);
+
+		data = nfs_readdata_alloc(len);
 		if (!data)
 			goto out_bad;
 		INIT_LIST_HEAD(&data->pages);
 		list_add(&data->pages, &list);
 		requests++;
-		if (nbytes <= rsize)
-			break;
-		nbytes -= rsize;
-	}
+		nbytes -= len;
+	} while(nbytes != 0);
 	atomic_set(&req->wb_complete, requests);
 
 	ClearPageError(page);
@@ -402,7 +404,7 @@ static int nfs_pagein_one(struct list_he
 	if (NFS_SERVER(inode)->rsize < PAGE_CACHE_SIZE)
 		return nfs_pagein_multi(head, inode);
 
-	data = nfs_readdata_alloc(NFS_SERVER(inode)->rpages);
+	data = nfs_readdata_alloc(NFS_SERVER(inode)->rsize);
 	if (!data)
 		goto out_bad;
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5077499..8ab3cf1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -90,22 +90,13 @@ static mempool_t *nfs_commit_mempool;
 
 static DECLARE_WAIT_QUEUE_HEAD(nfs_write_congestion);
 
-struct nfs_write_data *nfs_commit_alloc(unsigned int pagecount)
+struct nfs_write_data *nfs_commit_alloc(void)
 {
 	struct nfs_write_data *p = mempool_alloc(nfs_commit_mempool, SLAB_NOFS);
 
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
-		if (pagecount <= ARRAY_SIZE(p->page_array))
-			p->pagevec = p->page_array;
-		else {
-			p->pagevec = kcalloc(pagecount, sizeof(struct page *), GFP_NOFS);
-			if (!p->pagevec) {
-				mempool_free(p, nfs_commit_mempool);
-				p = NULL;
-			}
-		}
 	}
 	return p;
 }
@@ -117,13 +108,15 @@ void nfs_commit_free(struct nfs_write_da
 	mempool_free(p, nfs_commit_mempool);
 }
 
-struct nfs_write_data *nfs_writedata_alloc(unsigned int pagecount)
+struct nfs_write_data *nfs_writedata_alloc(size_t len)
 {
+	unsigned int pagecount = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	struct nfs_write_data *p = mempool_alloc(nfs_wdata_mempool, SLAB_NOFS);
 
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
+		p->npages = pagecount;
 		if (pagecount <= ARRAY_SIZE(p->page_array))
 			p->pagevec = p->page_array;
 		else {
@@ -208,7 +201,7 @@ static int nfs_writepage_sync(struct nfs
 	int		result, written = 0;
 	struct nfs_write_data *wdata;
 
-	wdata = nfs_writedata_alloc(1);
+	wdata = nfs_writedata_alloc(wsize);
 	if (!wdata)
 		return -ENOMEM;
 
@@ -999,24 +992,24 @@ static int nfs_flush_multi(struct inode 
 	struct nfs_page *req = nfs_list_entry(head->next);
 	struct page *page = req->wb_page;
 	struct nfs_write_data *data;
-	unsigned int wsize = NFS_SERVER(inode)->wsize;
-	unsigned int nbytes, offset;
+	size_t wsize = NFS_SERVER(inode)->wsize, nbytes;
+	unsigned int offset;
 	int requests = 0;
 	LIST_HEAD(list);
 
 	nfs_list_remove_request(req);
 
 	nbytes = req->wb_bytes;
-	for (;;) {
-		data = nfs_writedata_alloc(1);
+	do {
+		size_t len = min(nbytes, wsize);
+
+		data = nfs_writedata_alloc(len);
 		if (!data)
 			goto out_bad;
 		list_add(&data->pages, &list);
 		requests++;
-		if (nbytes <= wsize)
-			break;
-		nbytes -= wsize;
-	}
+		nbytes -= len;
+	} while (nbytes != 0);
 	atomic_set(&req->wb_complete, requests);
 
 	ClearPageError(page);
@@ -1070,7 +1063,7 @@ static int nfs_flush_one(struct inode *i
 	struct nfs_write_data	*data;
 	unsigned int		count;
 
-	data = nfs_writedata_alloc(NFS_SERVER(inode)->wpages);
+	data = nfs_writedata_alloc(NFS_SERVER(inode)->wsize);
 	if (!data)
 		goto out_bad;
 
@@ -1378,7 +1371,7 @@ nfs_commit_list(struct inode *inode, str
 	struct nfs_write_data	*data;
 	struct nfs_page         *req;
 
-	data = nfs_commit_alloc(NFS_SERVER(inode)->wpages);
+	data = nfs_commit_alloc();
 
 	if (!data)
 		goto out_bad;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 2474345..530b1e6 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -427,7 +427,7 @@ extern int nfs_writeback_done(struct rpc
 extern void nfs_writedata_release(void *);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-struct nfs_write_data *nfs_commit_alloc(unsigned int pagecount);
+struct nfs_write_data *nfs_commit_alloc(void);
 void nfs_commit_free(struct nfs_write_data *p);
 #endif
 
@@ -478,7 +478,7 @@ static inline int nfs_wb_page(struct ino
 /*
  * Allocate nfs_write_data structures
  */
-extern struct nfs_write_data *nfs_writedata_alloc(unsigned int pagecount);
+extern struct nfs_write_data *nfs_writedata_alloc(size_t len);
 
 /*
  * linux/fs/nfs/read.c
@@ -492,7 +492,7 @@ extern void nfs_readdata_release(void *d
 /*
  * Allocate nfs_read_data structures
  */
-extern struct nfs_read_data *nfs_readdata_alloc(unsigned int pagecount);
+extern struct nfs_read_data *nfs_readdata_alloc(size_t len);
 
 /*
  * linux/fs/nfs3proc.c
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index db9cbf6..41e5a19 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -729,7 +729,7 @@ struct nfs_read_data {
 	struct list_head	pages;	/* Coalesced read requests */
 	struct nfs_page		*req;	/* multi ops per nfs_page */
 	struct page		**pagevec;
-	unsigned int		npages;	/* active pages in pagevec */
+	unsigned int		npages;	/* Max length of pagevec */
 	struct nfs_readargs args;
 	struct nfs_readres  res;
 #ifdef CONFIG_NFS_V4
@@ -748,7 +748,7 @@ struct nfs_write_data {
 	struct list_head	pages;		/* Coalesced requests we wish to flush */
 	struct nfs_page		*req;		/* multi ops per nfs_page */
 	struct page		**pagevec;
-	unsigned int		npages;		/* active pages in pagevec */
+	unsigned int		npages;		/* Max length of pagevec */
 	struct nfs_writeargs	args;		/* argument struct */
 	struct nfs_writeres	res;		/* result struct */
 #ifdef CONFIG_NFS_V4
