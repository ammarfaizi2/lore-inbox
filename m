Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVDAEbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVDAEbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVDAEbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:31:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7573 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262615AbVDAEaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:30:35 -0500
Date: Fri, 1 Apr 2005 06:30:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050401043022.GA22753@elte.hu>
References: <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu> <20050331145015.GA4830@elte.hu> <1112322516.2509.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <1112322516.2509.28.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.111, required 5.9,
	BAYES_00 -4.90, REMOVE_REMOVAL_NEAR 0.79
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Lee Revell <rlrevell@joe-job.com> wrote:

> > > ah - cool! This was a 100 MB writeout so having 3.7 msecs to process 
> > > 20K+ pages is not unreasonable. To break the latency, can i just do a 
> > > simple lock-break, via the patch below?
> > 
> > with this patch the worst-case latency during NFS writeout is down to 40 
> > usecs (!).
> > 
> > Lee: i've uploaded the -42-05 release with this patch included - could 
> > you test it on your (no doubt more complex than mine) NFS setup?
> 
> This fixes all the NFS related latency problems I was seeing.  Now the 
> longest latency from an NFS kernel compile with "make -j64" is 391 
> usecs in get_swap_page.

great! The latest patches (-42-08 and later) have the reworked 
nfs_scan_list() lock-breaker, which should perform similarly.

i bet these NFS patches also improve generic NFS performance on fast 
networks. I've attached the full patchset with all fixes and 
improvements included - might be worth a try in -mm?

	Ingo

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfs-latency.patch"

--- linux/fs/nfs/inode.c.orig
+++ linux/fs/nfs/inode.c
@@ -118,7 +118,7 @@ nfs_write_inode(struct inode *inode, int
 	int flags = sync ? FLUSH_WAIT : 0;
 	int ret;
 
-	ret = nfs_commit_inode(inode, 0, 0, flags);
+	ret = nfs_commit_inode(inode, flags);
 	if (ret < 0)
 		return ret;
 	return 0;
--- linux/fs/nfs/write.c.orig
+++ linux/fs/nfs/write.c
@@ -352,7 +352,7 @@ int nfs_writepages(struct address_space 
 		if (err < 0)
 			goto out;
 	}
-	err = nfs_commit_inode(inode, 0, 0, wb_priority(wbc));
+	err = nfs_commit_inode(inode, wb_priority(wbc));
 	if (err > 0) {
 		wbc->nr_to_write -= err;
 		err = 0;
@@ -446,6 +446,8 @@ nfs_mark_request_dirty(struct nfs_page *
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	spin_lock(&nfsi->req_lock);
+	radix_tree_tag_set(&nfsi->nfs_page_tree,
+			req->wb_index, NFS_PAGE_TAG_DIRTY);
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfsi->req_lock);
@@ -503,13 +505,12 @@ nfs_wait_on_requests(struct inode *inode
 
 	spin_lock(&nfsi->req_lock);
 	next = idx_start;
-	while (radix_tree_gang_lookup(&nfsi->nfs_page_tree, (void **)&req, next, 1)) {
+	while (radix_tree_gang_lookup_tag(&nfsi->nfs_page_tree, (void **)&req, next, 1, NFS_PAGE_TAG_WRITEBACK)) {
 		if (req->wb_index > idx_end)
 			break;
 
 		next = req->wb_index + 1;
-		if (!NFS_WBACK_BUSY(req))
-			continue;
+		BUG_ON(!NFS_WBACK_BUSY(req));
 
 		atomic_inc(&req->wb_count);
 		spin_unlock(&nfsi->req_lock);
@@ -538,12 +539,15 @@ static int
 nfs_scan_dirty(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	int	res;
-	res = nfs_scan_list(&nfsi->dirty, dst, idx_start, npages);
-	nfsi->ndirty -= res;
-	sub_page_state(nr_dirty,res);
-	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
+	int res = 0;
+
+	if (nfsi->ndirty != 0) {
+		res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
+		nfsi->ndirty -= res;
+		sub_page_state(nr_dirty,res);
+		if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
+			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
+	}
 	return res;
 }
 
@@ -562,11 +566,14 @@ static int
 nfs_scan_commit(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	int	res;
-	res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
-	nfsi->ncommit -= res;
-	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
+	int res = 0;
+
+	if (nfsi->ncommit != 0) {
+		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages);
+		nfsi->ncommit -= res;
+		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
+			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
+	}
 	return res;
 }
 #endif
@@ -821,7 +828,7 @@ out:
 #else
 	nfs_inode_remove_request(req);
 #endif
-	nfs_unlock_request(req);
+	nfs_clear_page_writeback(req);
 }
 
 static inline int flush_task_priority(int how)
@@ -952,7 +959,7 @@ out_bad:
 		nfs_writedata_free(data);
 	}
 	nfs_mark_request_dirty(req);
-	nfs_unlock_request(req);
+	nfs_clear_page_writeback(req);
 	return -ENOMEM;
 }
 
@@ -1002,7 +1009,7 @@ static int nfs_flush_one(struct list_hea
 		struct nfs_page *req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_dirty(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
 }
@@ -1029,7 +1036,7 @@ nfs_flush_list(struct list_head *head, i
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_dirty(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return error;
 }
@@ -1121,7 +1128,7 @@ static void nfs_writeback_done_full(stru
 		nfs_inode_remove_request(req);
 #endif
 	next:
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 }
 
@@ -1210,36 +1217,24 @@ static void nfs_commit_rpcsetup(struct l
 		struct nfs_write_data *data, int how)
 {
 	struct rpc_task		*task = &data->task;
-	struct nfs_page		*first, *last;
+	struct nfs_page		*first;
 	struct inode		*inode;
-	loff_t			start, end, len;
 
 	/* Set up the RPC argument and reply structs
 	 * NB: take care not to mess about with data->commit et al. */
 
 	list_splice_init(head, &data->pages);
 	first = nfs_list_entry(data->pages.next);
-	last = nfs_list_entry(data->pages.prev);
 	inode = first->wb_context->dentry->d_inode;
 
-	/*
-	 * Determine the offset range of requests in the COMMIT call.
-	 * We rely on the fact that data->pages is an ordered list...
-	 */
-	start = req_offset(first);
-	end = req_offset(last) + last->wb_bytes;
-	len = end - start;
-	/* If 'len' is not a 32-bit quantity, pass '0' in the COMMIT call */
-	if (end >= i_size_read(inode) || len < 0 || len > (~((u32)0) >> 1))
-		len = 0;
-
 	data->inode	  = inode;
 	data->cred	  = first->wb_context->cred;
 
 	data->args.fh     = NFS_FH(data->inode);
-	data->args.offset = start;
-	data->args.count  = len;
-	data->res.count   = len;
+	/* Note: we always request a commit of the entire inode */
+	data->args.offset = 0;
+	data->args.count  = 0;
+	data->res.count   = 0;
 	data->res.fattr   = &data->fattr;
 	data->res.verf    = &data->verf;
 	
@@ -1278,7 +1273,7 @@ nfs_commit_list(struct list_head *head, 
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
 }
@@ -1324,7 +1319,7 @@ nfs_commit_done(struct rpc_task *task)
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 	next:
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 		res++;
 	}
 	sub_page_state(nr_unstable,res);
@@ -1350,8 +1345,7 @@ static int nfs_flush_inode(struct inode 
 }
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-int nfs_commit_inode(struct inode *inode, unsigned long idx_start,
-		    unsigned int npages, int how)
+int nfs_commit_inode(struct inode *inode, int how)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	LIST_HEAD(head);
@@ -1359,15 +1353,13 @@ int nfs_commit_inode(struct inode *inode
 				error = 0;
 
 	spin_lock(&nfsi->req_lock);
-	res = nfs_scan_commit(inode, &head, idx_start, npages);
+	res = nfs_scan_commit(inode, &head, 0, 0);
+	spin_unlock(&nfsi->req_lock);
 	if (res) {
-		res += nfs_scan_commit(inode, &head, 0, 0);
-		spin_unlock(&nfsi->req_lock);
 		error = nfs_commit_list(&head, how);
-	} else
-		spin_unlock(&nfsi->req_lock);
-	if (error < 0)
-		return error;
+		if (error < 0)
+			return error;
+	}
 	return res;
 }
 #endif
@@ -1389,7 +1381,7 @@ int nfs_sync_inode(struct inode *inode, 
 			error = nfs_flush_inode(inode, idx_start, npages, how);
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (error == 0)
-			error = nfs_commit_inode(inode, idx_start, npages, how);
+			error = nfs_commit_inode(inode, how);
 #endif
 	} while (error > 0);
 	return error;
--- linux/fs/nfs/read.c.orig
+++ linux/fs/nfs/read.c
@@ -173,7 +173,6 @@ static int nfs_readpage_async(struct nfs
 	if (len < PAGE_CACHE_SIZE)
 		memclear_highpage_flush(page, len, PAGE_CACHE_SIZE - len);
 
-	nfs_lock_request(new);
 	nfs_list_add_request(new, &one_request);
 	nfs_pagein_one(&one_request, inode);
 	return 0;
@@ -185,7 +184,6 @@ static void nfs_readpage_release(struct 
 
 	nfs_clear_request(req);
 	nfs_release_request(req);
-	nfs_unlock_request(req);
 
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",
 			req->wb_context->dentry->d_inode->i_sb->s_id,
@@ -553,7 +551,6 @@ readpage_async_filler(void *data, struct
 	}
 	if (len < PAGE_CACHE_SIZE)
 		memclear_highpage_flush(page, len, PAGE_CACHE_SIZE - len);
-	nfs_lock_request(new);
 	nfs_list_add_request(new, desc->head);
 	return 0;
 }
--- linux/fs/nfs/pagelist.c.orig
+++ linux/fs/nfs/pagelist.c
@@ -112,6 +112,33 @@ void nfs_unlock_request(struct nfs_page 
 }
 
 /**
+ * nfs_set_page_writeback_locked - Lock a request for writeback
+ * @req:
+ */
+int nfs_set_page_writeback_locked(struct nfs_page *req)
+{
+	struct nfs_inode *nfsi = NFS_I(req->wb_context->dentry->d_inode);
+
+	if (!nfs_lock_request(req))
+		return 0;
+	radix_tree_tag_set(&nfsi->nfs_page_tree, req->wb_index, NFS_PAGE_TAG_WRITEBACK);
+	return 1;
+}
+
+/**
+ * nfs_clear_page_writeback - Unlock request and wake up sleepers
+ */
+void nfs_clear_page_writeback(struct nfs_page *req)
+{
+	struct nfs_inode *nfsi = NFS_I(req->wb_context->dentry->d_inode);
+
+	spin_lock(&nfsi->req_lock);
+	radix_tree_tag_clear(&nfsi->nfs_page_tree, req->wb_index, NFS_PAGE_TAG_WRITEBACK);
+	spin_unlock(&nfsi->req_lock);
+	nfs_unlock_request(req);
+}
+
+/**
  * nfs_clear_request - Free up all resources allocated to the request
  * @req:
  *
@@ -151,36 +178,6 @@ nfs_release_request(struct nfs_page *req
 }
 
 /**
- * nfs_list_add_request - Insert a request into a sorted list
- * @req: request
- * @head: head of list into which to insert the request.
- *
- * Note that the wb_list is sorted by page index in order to facilitate
- * coalescing of requests.
- * We use an insertion sort that is optimized for the case of appended
- * writes.
- */
-void
-nfs_list_add_request(struct nfs_page *req, struct list_head *head)
-{
-	struct list_head *pos;
-
-#ifdef NFS_PARANOIA
-	if (!list_empty(&req->wb_list)) {
-		printk(KERN_ERR "NFS: Add to list failed!\n");
-		BUG();
-	}
-#endif
-	list_for_each_prev(pos, head) {
-		struct nfs_page	*p = nfs_list_entry(pos);
-		if (p->wb_index < req->wb_index)
-			break;
-	}
-	list_add(&req->wb_list, pos);
-	req->wb_list_head = head;
-}
-
-/**
  * nfs_wait_on_request - Wait for a request to complete.
  * @req: request to wait upon.
  *
@@ -243,6 +240,63 @@ nfs_coalesce_requests(struct list_head *
 	return npages;
 }
 
+#define NFS_SCAN_MAXENTRIES 16
+/**
+ * nfs_scan_lock_dirty - Scan the radix tree for dirty requests
+ * @nfsi: NFS inode
+ * @dst: Destination list
+ * @idx_start: lower bound of page->index to scan
+ * @npages: idx_start + npages sets the upper bound to scan.
+ *
+ * Moves elements from one of the inode request lists.
+ * If the number of requests is set to 0, the entire address_space
+ * starting at index idx_start, is scanned.
+ * The requests are *not* checked to ensure that they form a contiguous set.
+ * You must be holding the inode's req_lock when calling this function
+ */
+int
+nfs_scan_lock_dirty(struct nfs_inode *nfsi, struct list_head *dst,
+	      unsigned long idx_start, unsigned int npages)
+{
+	struct nfs_page *pgvec[NFS_SCAN_MAXENTRIES];
+	struct nfs_page *req;
+	unsigned long idx_end;
+	int found, i;
+	int res;
+
+	res = 0;
+	if (npages == 0)
+		idx_end = ~0;
+	else
+		idx_end = idx_start + npages - 1;
+
+	for (;;) {
+		found = radix_tree_gang_lookup_tag(&nfsi->nfs_page_tree,
+				(void **)&pgvec[0], idx_start, NFS_SCAN_MAXENTRIES,
+				NFS_PAGE_TAG_DIRTY);
+		if (found <= 0)
+			break;
+		for (i = 0; i < found; i++) {
+			req = pgvec[i];
+			if (req->wb_index > idx_end)
+				goto out;
+
+			idx_start = req->wb_index + 1;
+
+			if (nfs_set_page_writeback_locked(req)) {
+				radix_tree_tag_clear(&nfsi->nfs_page_tree,
+						req->wb_index, NFS_PAGE_TAG_DIRTY);
+				nfs_list_remove_request(req);
+				nfs_list_add_request(req, dst);
+				res++;
+			}
+		}
+		cond_resched_lock(&nfsi->req_lock);
+	}
+out:
+	return res;
+}
+
 /**
  * nfs_scan_list - Scan a list for matching requests
  * @head: One of the NFS inode request lists
@@ -257,10 +311,12 @@ nfs_coalesce_requests(struct list_head *
  * You must be holding the inode's req_lock when calling this function
  */
 int
-nfs_scan_list(struct list_head *head, struct list_head *dst,
-	      unsigned long idx_start, unsigned int npages)
+nfs_scan_list(struct nfs_inode *nfsi, struct list_head *head,
+	      struct list_head *dst, unsigned long idx_start,
+	      unsigned int npages)
 {
-	struct list_head	*pos, *tmp;
+	LIST_HEAD(locked);
+	struct list_head	*pos;
 	struct nfs_page		*req;
 	unsigned long		idx_end;
 	int			res;
@@ -271,21 +327,22 @@ nfs_scan_list(struct list_head *head, st
 	else
 		idx_end = idx_start + npages - 1;
 
-	list_for_each_safe(pos, tmp, head) {
+	while (!list_empty(head)) {
 
+		pos = head->next;
 		req = nfs_list_entry(pos);
 
-		if (req->wb_index < idx_start)
-			continue;
-		if (req->wb_index > idx_end)
-			break;
-
-		if (!nfs_lock_request(req))
-			continue;
-		nfs_list_remove_request(req);
-		nfs_list_add_request(req, dst);
-		res++;
+		if (!nfs_set_page_writeback_locked(req)) {
+			list_del(pos);
+			list_add(&req->wb_list, &locked);
+		} else {
+			nfs_list_remove_request(req);
+			nfs_list_add_request(req, dst);
+			res++;
+		}
+		cond_resched_lock(&nfsi->req_lock);
 	}
+	list_splice(&locked, head);
 	return res;
 }
 
--- linux/include/linux/nfs_fs.h.orig
+++ linux/include/linux/nfs_fs.h
@@ -377,10 +377,10 @@ extern void nfs_commit_done(struct rpc_t
  */
 extern int  nfs_sync_inode(struct inode *, unsigned long, unsigned int, int);
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-extern int  nfs_commit_inode(struct inode *, unsigned long, unsigned int, int);
+extern int  nfs_commit_inode(struct inode *, int);
 #else
 static inline int
-nfs_commit_inode(struct inode *inode, unsigned long idx_start, unsigned int npages, int how)
+nfs_commit_inode(struct inode *inode, int how)
 {
 	return 0;
 }
--- linux/include/linux/nfs_page.h.orig
+++ linux/include/linux/nfs_page.h
@@ -20,12 +20,19 @@
 #include <asm/atomic.h>
 
 /*
+ * Valid flags for the radix tree
+ */
+#define NFS_PAGE_TAG_DIRTY	0
+#define NFS_PAGE_TAG_WRITEBACK	1
+
+/*
  * Valid flags for a dirty buffer
  */
 #define PG_BUSY			0
 #define PG_NEED_COMMIT		1
 #define PG_NEED_RESCHED		2
 
+struct nfs_inode;
 struct nfs_page {
 	struct list_head	wb_list,	/* Defines state of page: */
 				*wb_list_head;	/*      read/write/commit */
@@ -54,14 +61,17 @@ extern	void nfs_clear_request(struct nfs
 extern	void nfs_release_request(struct nfs_page *req);
 
 
-extern	void nfs_list_add_request(struct nfs_page *, struct list_head *);
-
-extern	int nfs_scan_list(struct list_head *, struct list_head *,
-			  unsigned long, unsigned int);
+extern  int nfs_scan_lock_dirty(struct nfs_inode *nfsi, struct list_head *dst,
+				unsigned long idx_start, unsigned int npages);
+extern	int nfs_scan_list(struct nfs_inode *nfsi, struct list_head *,
+			  struct list_head *, unsigned long, unsigned int);
 extern	int nfs_coalesce_requests(struct list_head *, struct list_head *,
 				  unsigned int);
 extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
+extern  int nfs_set_page_writeback_locked(struct nfs_page *req);
+extern  void nfs_clear_page_writeback(struct nfs_page *req);
+
 
 /*
  * Lock the page of an asynchronous request without incrementing the wb_count
@@ -86,6 +96,18 @@ nfs_lock_request(struct nfs_page *req)
 	return 1;
 }
 
+/**
+ * nfs_list_add_request - Insert a request into a list
+ * @req: request
+ * @head: head of list into which to insert the request.
+ */
+static inline void
+nfs_list_add_request(struct nfs_page *req, struct list_head *head)
+{
+	list_add_tail(&req->wb_list, head);
+	req->wb_list_head = head;
+}
+
 
 /**
  * nfs_list_remove_request - Remove a request from its wb_list
@@ -96,10 +118,6 @@ nfs_list_remove_request(struct nfs_page 
 {
 	if (list_empty(&req->wb_list))
 		return;
-	if (!NFS_WBACK_BUSY(req)) {
-		printk(KERN_ERR "NFS: unlocked request attempted removed from list!\n");
-		BUG();
-	}
 	list_del_init(&req->wb_list);
 	req->wb_list_head = NULL;
 }

--xHFwDpU9dbj6ez1V--
