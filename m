Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSKHUc0>; Fri, 8 Nov 2002 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSKHUcZ>; Fri, 8 Nov 2002 15:32:25 -0500
Received: from pat.uio.no ([129.240.130.16]:63381 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262360AbSKHUcW>;
	Fri, 8 Nov 2002 15:32:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.8418.239639.519476@charged.uio.no>
Date: Fri, 8 Nov 2002 21:38:58 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Make nfs_find_request() scale
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nfs_find_request() needs to be called every time we schedule a write
on the page cache. Currently it is implemented as a linked list which
needs to be traversed completely in the case where we don't already
have a pending write request on the page in question.

The following patch adopts the new radix tree, as is already used in
the page cache. Performance change is more or less negligeable with
the current hard limit of 256 outstanding write requests per mount.

However when I remove this limit then the old nfs_find_request()
actually results in a 50% reduction in speed on my benchmark test
(iozone with 4 threads each writing a 512Mb file on a 512Mb Linux
client against a Solaris server on 100Mbit switched net). With this
patch, the result for the same benchmark is a 50% increase in speed.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46-03-writepages/fs/nfs/inode.c linux-2.5.46-04-radix_tree/fs/nfs/inode.c
--- linux-2.5.46-03-writepages/fs/nfs/inode.c	2002-11-08 14:16:27.000000000 -0500
+++ linux-2.5.46-04-radix_tree/fs/nfs/inode.c	2002-11-08 14:21:21.000000000 -0500
@@ -1559,7 +1559,7 @@
 		inode_init_once(&nfsi->vfs_inode);
 		INIT_LIST_HEAD(&nfsi->dirty);
 		INIT_LIST_HEAD(&nfsi->commit);
-		INIT_LIST_HEAD(&nfsi->writeback);
+		INIT_RADIX_TREE(&nfsi->nfs_page_tree, GFP_ATOMIC);
 		nfsi->ndirty = 0;
 		nfsi->ncommit = 0;
 		nfsi->npages = 0;
diff -u --recursive --new-file linux-2.5.46-03-writepages/fs/nfs/pagelist.c linux-2.5.46-04-radix_tree/fs/nfs/pagelist.c
--- linux-2.5.46-03-writepages/fs/nfs/pagelist.c	2002-11-05 07:52:59.000000000 -0500
+++ linux-2.5.46-04-radix_tree/fs/nfs/pagelist.c	2002-11-08 14:22:53.000000000 -0500
@@ -36,7 +36,6 @@
 	p = kmem_cache_alloc(nfs_page_cachep, SLAB_NOFS);
 	if (p) {
 		memset(p, 0, sizeof(*p));
-		INIT_LIST_HEAD(&p->wb_hash);
 		INIT_LIST_HEAD(&p->wb_list);
 		INIT_LIST_HEAD(&p->wb_lru);
 		init_waitqueue_head(&p->wb_wait);
@@ -161,14 +160,9 @@
 	spin_unlock(&nfs_wreq_lock);
 
 #ifdef NFS_PARANOIA
-	if (!list_empty(&req->wb_list))
-		BUG();
-	if (!list_empty(&req->wb_hash))
-		BUG();
-	if (NFS_WBACK_BUSY(req))
-		BUG();
-	if (atomic_read(&NFS_REQUESTLIST(req->wb_inode)->nr_requests) < 0)
-		BUG();
+	BUG_ON (!list_empty(&req->wb_list));
+	BUG_ON (NFS_WBACK_BUSY(req));
+	BUG_ON (atomic_read(&NFS_REQUESTLIST(req->wb_inode)->nr_requests) < 0);
 #endif
 
 	/* Release struct file or cached credential */
diff -u --recursive --new-file linux-2.5.46-03-writepages/fs/nfs/write.c linux-2.5.46-04-radix_tree/fs/nfs/write.c
--- linux-2.5.46-03-writepages/fs/nfs/write.c	2002-11-08 14:16:27.000000000 -0500
+++ linux-2.5.46-04-radix_tree/fs/nfs/write.c	2002-11-08 14:21:21.000000000 -0500
@@ -301,19 +301,21 @@
 /*
  * Insert a write request into an inode
  */
-static inline void
+static inline int
 nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	if (!list_empty(&req->wb_hash))
-		return;
-	if (!NFS_WBACK_BUSY(req))
-		printk(KERN_ERR "NFS: unlocked request attempted hashed!\n");
-	if (list_empty(&nfsi->writeback))
+	int error;
+
+	error = radix_tree_insert(&nfsi->nfs_page_tree, req->wb_index, req);
+	BUG_ON(error == -EEXIST);
+	if (error)
+		return error;
+	if (!nfsi->npages)
 		igrab(inode);
 	nfsi->npages++;
-	list_add(&req->wb_hash, &nfsi->writeback);
 	req->wb_count++;
+	return 0;
 }
 
 /*
@@ -324,21 +326,14 @@
 {
 	struct nfs_inode *nfsi;
 	struct inode *inode;
+
+	BUG_ON (!NFS_WBACK_BUSY(req));
 	spin_lock(&nfs_wreq_lock);
-	if (list_empty(&req->wb_hash)) {
-		spin_unlock(&nfs_wreq_lock);
-		return;
-	}
-	if (!NFS_WBACK_BUSY(req))
-		printk(KERN_ERR "NFS: unlocked request attempted unhashed!\n");
 	inode = req->wb_inode;
-	list_del(&req->wb_hash);
-	INIT_LIST_HEAD(&req->wb_hash);
 	nfsi = NFS_I(inode);
+	radix_tree_delete(&nfsi->nfs_page_tree, req->wb_index);
 	nfsi->npages--;
-	if ((nfsi->npages == 0) != list_empty(&nfsi->writeback))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.npages.\n");
-	if (list_empty(&nfsi->writeback)) {
+	if (!nfsi->npages) {
 		spin_unlock(&nfs_wreq_lock);
 		iput(inode);
 	} else
@@ -354,19 +349,12 @@
 _nfs_find_request(struct inode *inode, unsigned long index)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	struct list_head	*head, *next;
+	struct nfs_page *req;
 
-	head = &nfsi->writeback;
-	next = head->next;
-	while (next != head) {
-		struct nfs_page *req = nfs_inode_wb_entry(next);
-		next = next->next;
-		if (req->wb_index != index)
-			continue;
+	req = (struct nfs_page*)radix_tree_lookup(&nfsi->nfs_page_tree, index);
+	if (req)
 		req->wb_count++;
-		return req;
-	}
-	return NULL;
+	return req;
 }
 
 static struct nfs_page *
@@ -437,8 +425,8 @@
 nfs_wait_on_requests(struct inode *inode, struct file *file, unsigned long idx_start, unsigned int npages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	struct list_head	*p, *head;
-	unsigned long		idx_end;
+	struct nfs_page *req;
+	unsigned long		idx_end, next;
 	unsigned int		res = 0;
 	int			error;
 
@@ -448,21 +436,17 @@
 		idx_end = idx_start + npages - 1;
 
 	spin_lock(&nfs_wreq_lock);
-	head = &nfsi->writeback;
-	p = head->next;
-	while (p != head) {
-		struct nfs_page *req = nfs_inode_wb_entry(p);
-
-		p = p->next;
+	next = idx_start;
+	while (radix_tree_gang_lookup(&nfsi->nfs_page_tree, (void **)&req, next, 1)) {
+		if (req->wb_index > idx_end)
+			break;
 
+		next = req->wb_index + 1;
 		if (file && req->wb_file != file)
 			continue;
-
-		if (req->wb_index < idx_start || req->wb_index > idx_end)
-			continue;
-
 		if (!NFS_WBACK_BUSY(req))
 			continue;
+
 		req->wb_count++;
 		spin_unlock(&nfs_wreq_lock);
 		error = nfs_wait_on_request(req);
@@ -470,7 +454,7 @@
 		if (error < 0)
 			return error;
 		spin_lock(&nfs_wreq_lock);
-		p = head->next;
+		next = idx_start;
 		res++;
 	}
 	spin_unlock(&nfs_wreq_lock);
@@ -664,8 +648,14 @@
 		}
 
 		if (new) {
+			int error;
 			nfs_lock_request_dontget(new);
-			nfs_inode_add_request(inode, new);
+			error = nfs_inode_add_request(inode, new);
+			if (error) {
+				spin_unlock(&nfs_wreq_lock);
+				nfs_unlock_request(new);
+				return ERR_PTR(error);
+			}
 			spin_unlock(&nfs_wreq_lock);
 			nfs_mark_request_dirty(new);
 			return new;
diff -u --recursive --new-file linux-2.5.46-03-writepages/include/linux/nfs_fs.h linux-2.5.46-04-radix_tree/include/linux/nfs_fs.h
--- linux-2.5.46-03-writepages/include/linux/nfs_fs.h	2002-11-08 14:18:31.000000000 -0500
+++ linux-2.5.46-04-radix_tree/include/linux/nfs_fs.h	2002-11-08 14:21:21.000000000 -0500
@@ -165,7 +165,7 @@
 	 */
 	struct list_head	dirty;
 	struct list_head	commit;
-	struct list_head	writeback;
+	struct radix_tree_root	nfs_page_tree;
 
 	unsigned int		ndirty,
 				ncommit,
@@ -356,7 +356,7 @@
 static inline int
 nfs_have_writebacks(struct inode *inode)
 {
-	return !list_empty(&NFS_I(inode)->writeback);
+	return NFS_I(inode)->npages != 0;
 }
 
 static inline int
diff -u --recursive --new-file linux-2.5.46-03-writepages/include/linux/nfs_page.h linux-2.5.46-04-radix_tree/include/linux/nfs_page.h
--- linux-2.5.46-03-writepages/include/linux/nfs_page.h	2002-10-04 11:30:34.000000000 -0400
+++ linux-2.5.46-04-radix_tree/include/linux/nfs_page.h	2002-11-08 14:24:09.000000000 -0500
@@ -23,8 +23,7 @@
 #define PG_BUSY			0
 
 struct nfs_page {
-	struct list_head	wb_hash,	/* Inode */
-				wb_lru,		/* superblock lru list */
+	struct list_head	wb_lru,		/* superblock lru list */
 				wb_list,	/* Defines state of page: */
 				*wb_list_head;	/*      read/write/commit */
 	struct file		*wb_file;
@@ -125,12 +124,6 @@
 	return list_entry(head, struct nfs_page, wb_list);
 }
 
-static inline struct nfs_page *
-nfs_inode_wb_entry(struct list_head *head)
-{
-	return list_entry(head, struct nfs_page, wb_hash);
-}
-
 static inline void
 __nfs_add_lru(struct list_head *head, struct nfs_page *req)
 {
