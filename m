Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVC3VTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVC3VTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVC3VTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:19:34 -0500
Received: from pat.uio.no ([129.240.130.16]:40447 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261175AbVC3VPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:15:23 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050330115640.0bc38d01.akpm@osdl.org>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
	 <20050330115640.0bc38d01.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-+gbzpnutx6ewOMaP0XUD"
Date: Wed, 30 Mar 2005 16:14:59 -0500
Message-Id: <1112217299.10771.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.715, required 12,
	autolearn=disabled, AWL 1.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+gbzpnutx6ewOMaP0XUD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

on den 30.03.2005 Klokka 11:56 (-0800) skreiv Andrew Morton:
> > That's normal and cannot be avoided: when writing, we have to look for
> > the existence of old nfs_page requests. The reason is that if one does
> > exist, we must either coalesce our new dirty area into it or if we
> > can't, we must flush the old request out to the server.
> 
> One could use the radix-tree tagging stuff so that the gang lookup only
> looks up pages which are !NFS_WBACK_BUSY.

Yes. Together with the radix tree-based sorting of dirty requests,
that's pretty much what I've spent most of today doing. Lee, could you
see how the attached combined patch changes your latency numbers?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

--=-+gbzpnutx6ewOMaP0XUD
Content-Disposition: inline; filename=linux-2.6.12-nfspage_use_tags.dif
Content-Type: text/x-patch; name=linux-2.6.12-nfspage_use_tags.dif; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: linux-2.6.12-rc1/fs/nfs/inode.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/nfs/inode.c
+++ linux-2.6.12-rc1/fs/nfs/inode.c
@@ -118,7 +118,7 @@ nfs_write_inode(struct inode *inode, int
 	int flags = sync ? FLUSH_WAIT : 0;
 	int ret;
 
-	ret = nfs_commit_inode(inode, 0, 0, flags);
+	ret = nfs_commit_inode(inode, flags);
 	if (ret < 0)
 		return ret;
 	return 0;
Index: linux-2.6.12-rc1/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/nfs/pagelist.c
+++ linux-2.6.12-rc1/fs/nfs/pagelist.c
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
@@ -243,6 +240,62 @@ nfs_coalesce_requests(struct list_head *
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
+	}
+out:
+	return res;
+}
+
 /**
  * nfs_scan_list - Scan a list for matching requests
  * @head: One of the NFS inode request lists
@@ -280,7 +333,7 @@ nfs_scan_list(struct list_head *head, st
 		if (req->wb_index > idx_end)
 			break;
 
-		if (!nfs_lock_request(req))
+		if (!nfs_set_page_writeback_locked(req))
 			continue;
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, dst);
Index: linux-2.6.12-rc1/fs/nfs/read.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/nfs/read.c
+++ linux-2.6.12-rc1/fs/nfs/read.c
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
Index: linux-2.6.12-rc1/fs/nfs/write.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/nfs/write.c
+++ linux-2.6.12-rc1/fs/nfs/write.c
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
@@ -539,7 +540,7 @@ nfs_scan_dirty(struct inode *inode, stru
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	int	res;
-	res = nfs_scan_list(&nfsi->dirty, dst, idx_start, npages);
+	res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
 	nfsi->ndirty -= res;
 	sub_page_state(nr_dirty,res);
 	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
@@ -821,7 +822,7 @@ out:
 #else
 	nfs_inode_remove_request(req);
 #endif
-	nfs_unlock_request(req);
+	nfs_clear_page_writeback(req);
 }
 
 static inline int flush_task_priority(int how)
@@ -952,7 +953,7 @@ out_bad:
 		nfs_writedata_free(data);
 	}
 	nfs_mark_request_dirty(req);
-	nfs_unlock_request(req);
+	nfs_clear_page_writeback(req);
 	return -ENOMEM;
 }
 
@@ -1002,7 +1003,7 @@ static int nfs_flush_one(struct list_hea
 		struct nfs_page *req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_dirty(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
 }
@@ -1029,7 +1030,7 @@ nfs_flush_list(struct list_head *head, i
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_dirty(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return error;
 }
@@ -1121,7 +1122,7 @@ static void nfs_writeback_done_full(stru
 		nfs_inode_remove_request(req);
 #endif
 	next:
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 }
 
@@ -1210,36 +1211,24 @@ static void nfs_commit_rpcsetup(struct l
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
 	
@@ -1278,7 +1267,7 @@ nfs_commit_list(struct list_head *head, 
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req);
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
 }
@@ -1324,7 +1313,7 @@ nfs_commit_done(struct rpc_task *task)
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 	next:
-		nfs_unlock_request(req);
+		nfs_clear_page_writeback(req);
 		res++;
 	}
 	sub_page_state(nr_unstable,res);
@@ -1350,8 +1339,7 @@ static int nfs_flush_inode(struct inode 
 }
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-int nfs_commit_inode(struct inode *inode, unsigned long idx_start,
-		    unsigned int npages, int how)
+int nfs_commit_inode(struct inode *inode, int how)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	LIST_HEAD(head);
@@ -1359,15 +1347,13 @@ int nfs_commit_inode(struct inode *inode
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
@@ -1389,7 +1375,7 @@ int nfs_sync_inode(struct inode *inode, 
 			error = nfs_flush_inode(inode, idx_start, npages, how);
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (error == 0)
-			error = nfs_commit_inode(inode, idx_start, npages, how);
+			error = nfs_commit_inode(inode, how);
 #endif
 	} while (error > 0);
 	return error;
Index: linux-2.6.12-rc1/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.12-rc1.orig/include/linux/nfs_fs.h
+++ linux-2.6.12-rc1/include/linux/nfs_fs.h
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
Index: linux-2.6.12-rc1/include/linux/nfs_page.h
===================================================================
--- linux-2.6.12-rc1.orig/include/linux/nfs_page.h
+++ linux-2.6.12-rc1/include/linux/nfs_page.h
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
+extern  int nfs_scan_lock_dirty(struct nfs_inode *nfsi, struct list_head *dst,
+				unsigned long idx_start, unsigned int npages);
 extern	int nfs_scan_list(struct list_head *, struct list_head *,
 			  unsigned long, unsigned int);
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

--=-+gbzpnutx6ewOMaP0XUD--

