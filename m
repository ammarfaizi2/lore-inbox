Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSKFCTW>; Tue, 5 Nov 2002 21:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265524AbSKFCTW>; Tue, 5 Nov 2002 21:19:22 -0500
Received: from mons.uio.no ([129.240.130.14]:42431 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265523AbSKFCTI>;
	Tue, 5 Nov 2002 21:19:08 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Convert NFS client to use ->readpages()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Nov 2002 03:25:42 +0100
Message-ID: <shssmyfe8nt.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  - Add the library function read_cache_pages(), which is used in a
    similar fashion to the single page 'read_cache_page()'. It hides
    the details of the LRU cache etc. from a filesystem that wants to
    to populate an address space with a list of pages.

  - Fix NFS so that readahead uses the ->readpages() interface. Means
    that we can immediately schedule an RPC call in order to complete
    the I/O, rather than relying on somebody later triggering it by
    calling lock_page() (and hence sync_page()). The sync_page()
    method is race-prone, since the waiting page may try to call it
    before we've finished initializing the 'struct nfs_page'.

  - Clear out nfs_sync_page(), the nfs_inode->read list, and
    friends. When the I/O completion gets scheduled in ->readpage(),
    ->readpages(), they have no reason to exist.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46-01-readpages1/fs/nfs/file.c linux-2.5.46-02-readpages2/fs/nfs/file.c
--- linux-2.5.46-01-readpages1/fs/nfs/file.c	2002-10-14 10:03:48.000000000 -0400
+++ linux-2.5.46-02-readpages2/fs/nfs/file.c	2002-11-05 07:52:59.000000000 -0500
@@ -77,11 +77,6 @@
 
 	dfprintk(VFS, "nfs: flush(%s/%ld)\n", inode->i_sb->s_id, inode->i_ino);
 
-	/* Make sure all async reads have been sent off. We don't bother
-	 * waiting on them though... */
-	if (file->f_mode & FMODE_READ)
-		nfs_pagein_inode(inode, 0, 0);
-
 	status = nfs_wb_file(inode, file);
 	if (!status) {
 		status = file->f_error;
@@ -170,35 +165,9 @@
 	return status;
 }
 
-/*
- * The following is used by wait_on_page_locked(), generic_file_readahead()
- * to initiate the completion of any page readahead operations.
- */
-static int nfs_sync_page(struct page *page)
-{
-	struct address_space *mapping;
-	struct inode	*inode;
-	unsigned long	index = page->index;
-	unsigned int	rpages;
-	int		result;
-
-	mapping = page->mapping;
-	if (!mapping)
-		return 0;
-	inode = mapping->host;
-	if (!inode)
-		return 0;
-
-	rpages = NFS_SERVER(inode)->rpages;
-	result = nfs_pagein_inode(inode, index, rpages);
-	if (result < 0)
-		return result;
-	return 0;
-}
-
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
-	.sync_page = nfs_sync_page,
+	.readpages = nfs_readpages,
 	.writepage = nfs_writepage,
 	.prepare_write = nfs_prepare_write,
 	.commit_write = nfs_commit_write,
diff -u --recursive --new-file linux-2.5.46-01-readpages1/fs/nfs/flushd.c linux-2.5.46-02-readpages2/fs/nfs/flushd.c
--- linux-2.5.46-01-readpages1/fs/nfs/flushd.c	2002-10-08 18:43:11.000000000 -0400
+++ linux-2.5.46-02-readpages2/fs/nfs/flushd.c	2002-11-05 07:52:59.000000000 -0500
@@ -166,11 +166,6 @@
 			nfs_flush_list(&head, server->wpages, FLUSH_AGING);
 			continue;
 		}
-		if (nfs_scan_lru_read_timeout(server, &head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_pagein_list(&head, server->rpages);
-			continue;
-		}
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (nfs_scan_lru_commit_timeout(server, &head)) {
 			spin_unlock(&nfs_wreq_lock);
diff -u --recursive --new-file linux-2.5.46-01-readpages1/fs/nfs/inode.c linux-2.5.46-02-readpages2/fs/nfs/inode.c
--- linux-2.5.46-01-readpages1/fs/nfs/inode.c	2002-10-16 08:44:04.000000000 -0400
+++ linux-2.5.46-02-readpages2/fs/nfs/inode.c	2002-11-05 07:52:59.000000000 -0500
@@ -117,7 +117,7 @@
 	/*
 	 * The following can never actually happen...
 	 */
-	if (nfs_have_writebacks(inode) || nfs_have_read(inode)) {
+	if (nfs_have_writebacks(inode)) {
 		printk(KERN_ERR "nfs_delete_inode: inode %ld has pending RPC requests\n", inode->i_ino);
 	}
 
@@ -1555,11 +1555,9 @@
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
 		inode_init_once(&nfsi->vfs_inode);
-		INIT_LIST_HEAD(&nfsi->read);
 		INIT_LIST_HEAD(&nfsi->dirty);
 		INIT_LIST_HEAD(&nfsi->commit);
 		INIT_LIST_HEAD(&nfsi->writeback);
-		nfsi->nread = 0;
 		nfsi->ndirty = 0;
 		nfsi->ncommit = 0;
 		nfsi->npages = 0;
diff -u --recursive --new-file linux-2.5.46-01-readpages1/fs/nfs/pagelist.c linux-2.5.46-02-readpages2/fs/nfs/pagelist.c
--- linux-2.5.46-01-readpages1/fs/nfs/pagelist.c	2002-10-08 18:43:11.000000000 -0400
+++ linux-2.5.46-02-readpages2/fs/nfs/pagelist.c	2002-11-05 07:52:59.000000000 -0500
@@ -516,13 +516,6 @@
 			continue;
 		}
 #endif
-		/* OK, so we try to free up some pending readaheads */
-		nfs_scan_lru_read(server, &head);
-		if (!list_empty(&head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_pagein_list(&head, server->rpages);
-			continue;
-		}
 		/* Last resort: we try to flush out single requests */
 		nfs_scan_lru_dirty(server, &head);
 		if (!list_empty(&head)) {
diff -u --recursive --new-file linux-2.5.46-01-readpages1/fs/nfs/read.c linux-2.5.46-02-readpages2/fs/nfs/read.c
--- linux-2.5.46-01-readpages1/fs/nfs/read.c	2002-10-08 19:44:22.000000000 -0400
+++ linux-2.5.46-02-readpages2/fs/nfs/read.c	2002-11-05 07:52:59.000000000 -0500
@@ -34,6 +34,8 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
+static int nfs_pagein_one(struct list_head *, struct inode *);
+
 static kmem_cache_t *nfs_rdata_cachep;
 
 static __inline__ struct nfs_read_data *nfs_readdata_alloc(void)
@@ -129,36 +131,20 @@
 	return result;
 }
 
-/*
- * Add a request to the inode's asynchronous read list.
- */
-static inline void
-nfs_mark_request_read(struct nfs_page *req)
-{
-	struct inode *inode = req->wb_inode;
-	struct nfs_inode *nfsi = NFS_I(inode);
-
-	spin_lock(&nfs_wreq_lock);
-	nfs_list_add_request(req, &nfsi->read);
-	nfsi->nread++;
-	__nfs_add_lru(&NFS_SERVER(inode)->lru_read, req);
-	spin_unlock(&nfs_wreq_lock);
-}
-
 static int
 nfs_readpage_async(struct file *file, struct inode *inode, struct page *page)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
+	LIST_HEAD(one_request);
 	struct nfs_page	*new;
 
 	new = nfs_create_request(nfs_file_cred(file), inode, page, 0, PAGE_CACHE_SIZE);
-	if (IS_ERR(new))
+	if (IS_ERR(new)) {
+		unlock_page(page);
 		return PTR_ERR(new);
-	nfs_mark_request_read(new);
-
-	if (nfsi->nread >= NFS_SERVER(inode)->rpages ||
-	    page->index == (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
-		nfs_pagein_inode(inode, 0, 0);
+	}
+	nfs_lock_request(new);
+	nfs_list_add_request(new, &one_request);
+	nfs_pagein_one(&one_request, inode);
 	return 0;
 }
 
@@ -261,91 +247,6 @@
 	return error;
 }
 
-/**
- * nfs_scan_lru_read_timeout - Scan LRU list for timed out read requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Moves a maximum of 'rpages' timed out requests from the NFS read LRU list.
- * The elements are checked to ensure that they form a contiguous set
- * of pages, and that they originated from the same file.
- */
-int
-nfs_scan_lru_read_timeout(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru_timeout(&server->lru_read, dst, server->rpages);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		nfsi->nread -= npages;
-	}
-	return npages;
-}
-
-/**
- * nfs_scan_lru_read - Scan LRU list for read requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Moves a maximum of 'rpages' requests from the NFS read LRU list.
- * The elements are checked to ensure that they form a contiguous set
- * of pages, and that they originated from the same file.
- */
-int
-nfs_scan_lru_read(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru(&server->lru_read, dst, server->rpages);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		nfsi->nread -= npages;
-	}
-	return npages;
-}
-
-/*
- * nfs_scan_read - Scan an inode for read requests
- * @inode: NFS inode to scan
- * @dst: destination list
- * @idx_start: lower bound of page->index to scan
- * @npages: idx_start + npages sets the upper bound to scan
- *
- * Moves requests from the inode's read list.
- * The requests are *not* checked to ensure that they form a contiguous set.
- */
-static int
-nfs_scan_read(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
-{
-	struct nfs_inode *nfsi = NFS_I(inode);
-	int	res;
-	res = nfs_scan_list(&nfsi->read, dst, NULL, idx_start, npages);
-	nfsi->nread -= res;
-	if ((nfsi->nread == 0) != list_empty(&nfsi->read))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.nread.\n");
-	return res;
-}
-
-int nfs_pagein_inode(struct inode *inode, unsigned long idx_start,
-		     unsigned int npages)
-{
-	LIST_HEAD(head);
-	int	res,
-		error = 0;
-
-	spin_lock(&nfs_wreq_lock);
-	res = nfs_scan_read(inode, &head, idx_start, npages);
-	spin_unlock(&nfs_wreq_lock);
-	if (res)
-		error = nfs_pagein_list(&head, NFS_SERVER(inode)->rpages);
-	if (error < 0)
-		return error;
-	return res;
-}
-
 /*
  * This is the callback from RPC telling us whether a reply was
  * received or some error occurred (timeout or socket shutdown).
@@ -439,6 +340,66 @@
 	goto out;
 }
 
+struct nfs_readdesc {
+	struct list_head *head;
+	struct file *filp;
+};
+
+static int
+readpage_sync_filler(void *data, struct page *page)
+{
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
+	return nfs_readpage_sync(desc->filp, page->mapping->host, page);
+}
+
+static int
+readpage_async_filler(void *data, struct page *page)
+{
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
+	struct nfs_page *new;
+	new = nfs_create_request(nfs_file_cred(desc->filp),
+				page->mapping->host, page,
+				0, PAGE_CACHE_SIZE);
+	if (IS_ERR(new)) {
+			SetPageError(page);
+			unlock_page(page);
+			return PTR_ERR(new);
+	}
+	nfs_lock_request(new);
+	nfs_list_add_request(new, desc->head);
+	return 0;
+}
+
+int
+nfs_readpages(struct file *filp, struct address_space *mapping,
+		struct list_head *pages, unsigned nr_pages)
+{
+	LIST_HEAD(head);
+	struct nfs_readdesc desc = {
+		.filp		= filp,
+		.head		= &head,
+	};
+	struct nfs_server *server = NFS_SERVER(mapping->host);
+	int is_sync = server->rsize < PAGE_CACHE_SIZE;
+	int ret;
+
+	ret = read_cache_pages(mapping, pages,
+			       is_sync ? readpage_sync_filler :
+					 readpage_async_filler,
+			       &desc);
+	if (!list_empty(pages)) {
+		struct page *page = list_entry(pages->prev, struct page, list);
+		list_del(&page->list);
+		page_cache_release(page);
+	}
+	if (!list_empty(&head)) {
+		int err = nfs_pagein_list(&head, server->rpages);
+		if (!ret)
+			ret = err;
+	}
+	return ret;
+}
+
 int nfs_init_readpagecache(void)
 {
 	nfs_rdata_cachep = kmem_cache_create("nfs_read_data",
diff -u --recursive --new-file linux-2.5.46-01-readpages1/include/linux/nfs_fs.h linux-2.5.46-02-readpages2/include/linux/nfs_fs.h
--- linux-2.5.46-01-readpages1/include/linux/nfs_fs.h	2002-10-14 10:03:48.000000000 -0400
+++ linux-2.5.46-02-readpages2/include/linux/nfs_fs.h	2002-11-05 14:39:19.000000000 -0500
@@ -163,13 +163,11 @@
 	/*
 	 * This is the list of dirty unwritten pages.
 	 */
-	struct list_head	read;
 	struct list_head	dirty;
 	struct list_head	commit;
 	struct list_head	writeback;
 
-	unsigned int		nread,
-				ndirty,
+	unsigned int		ndirty,
 				ncommit,
 				npages;
 
@@ -348,12 +346,6 @@
 #endif
 
 static inline int
-nfs_have_read(struct inode *inode)
-{
-	return !list_empty(&NFS_I(inode)->read);
-}
-
-static inline int
 nfs_have_writebacks(struct inode *inode)
 {
 	return !list_empty(&NFS_I(inode)->writeback);
@@ -396,10 +388,9 @@
  * linux/fs/nfs/read.c
  */
 extern int  nfs_readpage(struct file *, struct page *);
-extern int  nfs_pagein_inode(struct inode *, unsigned long, unsigned int);
+extern int  nfs_readpages(struct file *, struct address_space *,
+		struct list_head *, unsigned);
 extern int  nfs_pagein_list(struct list_head *, int);
-extern int  nfs_scan_lru_read(struct nfs_server *, struct list_head *);
-extern int  nfs_scan_lru_read_timeout(struct nfs_server *, struct list_head *);
 extern void nfs_readpage_result(struct rpc_task *, unsigned int count, int eof);
 extern void nfs_readdata_release(struct rpc_task *);
 
diff -u --recursive --new-file linux-2.5.46-01-readpages1/include/linux/pagemap.h linux-2.5.46-02-readpages2/include/linux/pagemap.h
--- linux-2.5.46-01-readpages1/include/linux/pagemap.h	2002-10-29 19:59:58.000000000 -0500
+++ linux-2.5.46-02-readpages2/include/linux/pagemap.h	2002-11-05 07:52:59.000000000 -0500
@@ -63,6 +63,8 @@
 extern struct page * read_cache_page(struct address_space *mapping,
 				unsigned long index, filler_t *filler,
 				void *data);
+extern int read_cache_pages(struct address_space *mapping,
+		struct list_head *pages, filler_t *filler, void *data);
 
 extern int add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index);
diff -u --recursive --new-file linux-2.5.46-01-readpages1/kernel/ksyms.c linux-2.5.46-02-readpages2/kernel/ksyms.c
--- linux-2.5.46-01-readpages1/kernel/ksyms.c	2002-10-31 10:28:34.000000000 -0500
+++ linux-2.5.46-02-readpages2/kernel/ksyms.c	2002-11-05 07:52:59.000000000 -0500
@@ -284,6 +284,7 @@
 EXPORT_SYMBOL(find_or_create_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
+EXPORT_SYMBOL(read_cache_pages);
 EXPORT_SYMBOL(mark_page_accessed);
 EXPORT_SYMBOL(vfs_readlink);
 EXPORT_SYMBOL(vfs_follow_link);
diff -u --recursive --new-file linux-2.5.46-01-readpages1/mm/readahead.c linux-2.5.46-02-readpages2/mm/readahead.c
--- linux-2.5.46-01-readpages1/mm/readahead.c	2002-11-05 07:52:41.000000000 -0500
+++ linux-2.5.46-02-readpages2/mm/readahead.c	2002-11-05 07:52:59.000000000 -0500
@@ -42,6 +42,46 @@
 	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 }
 
+/**
+ * read_cache_pages - populate an address space with some pages, and
+ * 			start reads against them.
+ * @mapping: the address_space
+ * @pages: The address of a list_head which contains the target pages.  These
+ *   pages have their ->index populated and are otherwise uninitialised.
+ * @filler: callback routine for filling a single page.
+ * @data: private data for the callback routine.
+ *
+ * Hides the details of the LRU cache etc from the filesystems.
+ */
+int
+read_cache_pages(struct address_space *mapping,
+		 struct list_head *pages,
+		 int (*filler)(void *, struct page *),
+		 void *data)
+{
+	struct page *page;
+	struct pagevec lru_pvec;
+	int ret = 0;
+
+	pagevec_init(&lru_pvec, 0);
+
+	while (!list_empty(pages)) {
+		page = list_entry(pages->prev, struct page, list);
+		list_del(&page->list);
+		if (add_to_page_cache(page, mapping, page->index)) {
+			page_cache_release(page);
+			continue;
+		}
+		ret = filler(data, page);
+		if (!pagevec_add(&lru_pvec, page))
+			__pagevec_lru_add(&lru_pvec);
+		if (ret)
+			break;
+	}
+	pagevec_lru_add(&lru_pvec);
+	return ret;
+}
+
 static int
 read_pages(struct address_space *mapping, struct file *filp,
 		struct list_head *pages, unsigned nr_pages)
