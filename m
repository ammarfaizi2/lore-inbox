Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWILP5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWILP5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWILPu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:50:57 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:35036 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030227AbWILPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:53 -0400
Message-Id: <20060912144903.646750000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 06/20] nfs: teach the NFS client how to treat PG_swapcache pages
Content-Disposition: inline; filename=nfs_swapcache.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all relevant occurences of page->index and page->mapping in the NFS
client with the new page_file_index() and page_file_mapping() functions.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/nfs/file.c     |    6 +++---
 fs/nfs/pagelist.c |    8 ++++----
 fs/nfs/read.c     |   10 +++++-----
 fs/nfs/write.c    |   28 ++++++++++++++--------------
 4 files changed, 26 insertions(+), 26 deletions(-)

Index: linux-2.6/fs/nfs/file.c
===================================================================
--- linux-2.6.orig/fs/nfs/file.c
+++ linux-2.6/fs/nfs/file.c
@@ -303,17 +303,17 @@ static int nfs_commit_write(struct file 
 
 static void nfs_invalidate_page(struct page *page, unsigned long offset)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page_file_mapping(page)->host;
 
 	/* Cancel any unstarted writes on this page */
 	if (offset == 0)
-		nfs_sync_inode_wait(inode, page->index, 1, FLUSH_INVALIDATE);
+		nfs_sync_inode_wait(inode, page_file_index(page), 1, FLUSH_INVALIDATE);
 }
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
 	if (gfp & __GFP_FS)
-		return !nfs_wb_page(page->mapping->host, page);
+		return !nfs_wb_page(page_file_mapping(page)->host, page);
 	else
 		/*
 		 * Avoid deadlock on nfs_wait_on_request().
Index: linux-2.6/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.orig/fs/nfs/pagelist.c
+++ linux-2.6/fs/nfs/pagelist.c
@@ -82,11 +82,11 @@ nfs_create_request(struct nfs_open_conte
 	 * update_nfs_request below if the region is not locked. */
 	req->wb_page    = page;
 	atomic_set(&req->wb_complete, 0);
-	req->wb_index	= page->index;
+	req->wb_index	= page_file_index(page);
 	page_cache_get(page);
 	BUG_ON(PagePrivate(page));
 	BUG_ON(!PageLocked(page));
-	BUG_ON(page->mapping->host != inode);
+	BUG_ON(page_file_mapping(page)->host != inode);
 	req->wb_offset  = offset;
 	req->wb_pgbase	= offset;
 	req->wb_bytes   = count;
@@ -271,7 +271,7 @@ nfs_coalesce_requests(struct list_head *
  * nfs_scan_lock_dirty - Scan the radix tree for dirty requests
  * @nfsi: NFS inode
  * @dst: Destination list
- * @idx_start: lower bound of page->index to scan
+ * @idx_start: lower bound of page_file_index(page) to scan
  * @npages: idx_start + npages sets the upper bound to scan.
  *
  * Moves elements from one of the inode request lists.
@@ -328,7 +328,7 @@ out:
  * @nfsi: NFS inode
  * @head: One of the NFS inode request lists
  * @dst: Destination list
- * @idx_start: lower bound of page->index to scan
+ * @idx_start: lower bound of page_file_index(page) to scan
  * @npages: idx_start + npages sets the upper bound to scan.
  *
  * Moves elements from one of the inode request lists.
Index: linux-2.6/fs/nfs/read.c
===================================================================
--- linux-2.6.orig/fs/nfs/read.c
+++ linux-2.6/fs/nfs/read.c
@@ -86,9 +86,9 @@ unsigned int nfs_page_length(struct inod
 	if (i_size <= 0)
 		return 0;
 	idx = (i_size - 1) >> PAGE_CACHE_SHIFT;
-	if (page->index > idx)
+	if (page_file_index(page) > idx)
 		return 0;
-	if (page->index != idx)
+	if (page_file_index(page) != idx)
 		return PAGE_CACHE_SIZE;
 	return 1 + ((i_size - 1) & (PAGE_CACHE_SIZE - 1));
 }
@@ -595,11 +595,11 @@ int nfs_readpage_result(struct rpc_task 
 int nfs_readpage(struct file *file, struct page *page)
 {
 	struct nfs_open_context *ctx;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page_file_mapping(page)->host;
 	int		error;
 
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
-		page, PAGE_CACHE_SIZE, page->index);
+		page, PAGE_CACHE_SIZE, page_file_index(page));
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
 	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 
@@ -647,7 +647,7 @@ static int
 readpage_async_filler(void *data, struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *new;
 	unsigned int len;
 
Index: linux-2.6/fs/nfs/write.c
===================================================================
--- linux-2.6.orig/fs/nfs/write.c
+++ linux-2.6/fs/nfs/write.c
@@ -145,13 +145,13 @@ void nfs_writedata_release(void *wdata)
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page_file_mapping(page)->host;
 	loff_t end, i_size = i_size_read(inode);
 	unsigned long end_index = (i_size - 1) >> PAGE_CACHE_SHIFT;
 
-	if (i_size > 0 && page->index < end_index)
+	if (i_size > 0 && page_file_index(page) < end_index)
 		return;
-	end = ((loff_t)page->index << PAGE_CACHE_SHIFT) + ((loff_t)offset+count);
+	end = page_offset(page) + ((loff_t)offset+count);
 	if (i_size >= end)
 		return;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
@@ -174,11 +174,11 @@ static void nfs_mark_uptodate(struct pag
 		return;
 	}
 
-	end_offs = i_size_read(page->mapping->host) - 1;
+	end_offs = i_size_read(page_file_mapping(page)->host) - 1;
 	if (end_offs < 0)
 		return;
 	/* Is this the last page? */
-	if (page->index != (unsigned long)(end_offs >> PAGE_CACHE_SHIFT))
+	if (page_file_index(page) != (unsigned long)(end_offs >> PAGE_CACHE_SHIFT))
 		return;
 	/* This is the last page: set PG_uptodate if we cover the entire
 	 * extent of the data, then zero the rest of the page.
@@ -293,7 +293,7 @@ static int wb_priority(struct writeback_
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct nfs_open_context *ctx;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page_file_mapping(page)->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	loff_t i_size = i_size_read(inode);
@@ -320,14 +320,14 @@ int nfs_writepage(struct page *page, str
 	nfs_wb_page_priority(inode, page, priority);
 
 	/* easy case */
-	if (page->index < end_index)
+	if (page_file_index(page) < end_index)
 		goto do_it;
 	/* things got complicated... */
 	offset = i_size & (PAGE_CACHE_SIZE-1);
 
 	/* OK, are we completely out? */
 	err = 0; /* potential race with truncate - ignore */
-	if (page->index >= end_index+1 || !offset)
+	if (page_file_index(page) >= end_index+1 || !offset)
 		goto out;
 do_it:
 	ctx = nfs_find_open_context(inode, NULL, FMODE_WRITE);
@@ -599,7 +599,7 @@ static void nfs_cancel_commit_list(struc
  * nfs_scan_dirty - Scan an inode for dirty requests
  * @inode: NFS inode to scan
  * @dst: destination list
- * @idx_start: lower bound of page->index to scan.
+ * @idx_start: lower bound of page_file_index(page) to scan.
  * @npages: idx_start + npages sets the upper bound to scan.
  *
  * Moves requests from the inode's dirty page list.
@@ -625,7 +625,7 @@ nfs_scan_dirty(struct inode *inode, stru
  * nfs_scan_commit - Scan an inode for commit requests
  * @inode: NFS inode to scan
  * @dst: destination list
- * @idx_start: lower bound of page->index to scan.
+ * @idx_start: lower bound of page_file_index(page) to scan.
  * @npages: idx_start + npages sets the upper bound to scan.
  *
  * Moves requests from the inode's 'commit' request list.
@@ -706,14 +706,14 @@ static struct nfs_page * nfs_update_requ
 
 	end = offset + bytes;
 
-	if (nfs_wait_on_write_congestion(page->mapping, server->flags & NFS_MOUNT_INTR))
+	if (nfs_wait_on_write_congestion(page_file_mapping(page), server->flags & NFS_MOUNT_INTR))
 		return ERR_PTR(-ERESTARTSYS);
 	for (;;) {
 		/* Loop over all inode entries and see if we find
 		 * A request for the page we wish to update
 		 */
 		spin_lock(&nfsi->req_lock);
-		req = _nfs_find_request(inode, page->index);
+		req = _nfs_find_request(inode, page_file_index(page));
 		if (req) {
 			if (!nfs_lock_request_dontget(req)) {
 				int error;
@@ -784,7 +784,7 @@ static struct nfs_page * nfs_update_requ
 int nfs_flush_incompatible(struct file *file, struct page *page)
 {
 	struct nfs_open_context *ctx = (struct nfs_open_context *)file->private_data;
-	struct inode	*inode = page->mapping->host;
+	struct inode	*inode = page_file_mapping(page)->host;
 	struct nfs_page	*req;
 	int		status = 0;
 	/*
@@ -795,7 +795,7 @@ int nfs_flush_incompatible(struct file *
 	 * Also do the same if we find a request from an existing
 	 * dropped page.
 	 */
-	req = nfs_find_request(inode, page->index);
+	req = nfs_find_request(inode, page_file_index(page));
 	if (req) {
 		if (req->wb_page != page || ctx != req->wb_context)
 			status = nfs_wb_page(inode, page);

--

