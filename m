Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311241AbSCLPes>; Tue, 12 Mar 2002 10:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311242AbSCLPem>; Tue, 12 Mar 2002 10:34:42 -0500
Received: from mons.uio.no ([129.240.130.14]:49341 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311241AbSCLPe2>;
	Tue, 12 Mar 2002 10:34:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15502.8187.739733.434509@charged.uio.no>
Date: Tue, 12 Mar 2002 16:34:19 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Fix 2.4.19-pre3 NFS reads from holding a write leases.
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  The VFS does not like us holding the 'write_access' lease on a
file for too long. The function 'get_write_access()' gets called on an
inode whenever a struct file is created for writing, and is only
released on the last fput() of that struct file.

  NFS caches the struct file in the nfs_page in order to access
the RPC credentials that are cached in the filp->private_data area.
Unfortunately this means that both NFS reads and writes can end up
prolonging the write_access lease beyond the end of the 'sys_close()'.


  The following patch changes the NFS code so that it caches the RPC
credentials directly in the nfs_page.  The struct file is still kept
around for ordinary writes, in order that we can report asynchronous
write errors in sys_close() via filp->f_error.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.19-fix_create/fs/nfs/flushd.c linux-2.4.19-fix_put/fs/nfs/flushd.c
--- linux-2.4.19-fix_create/fs/nfs/flushd.c	Fri Nov  9 23:28:15 2001
+++ linux-2.4.19-fix_put/fs/nfs/flushd.c	Tue Mar 12 15:34:24 2002
@@ -59,7 +59,7 @@
 static void	nfs_flushd_exit(struct rpc_task *);
 
 
-int nfs_reqlist_init(struct nfs_server *server)
+static int nfs_reqlist_init(struct nfs_server *server)
 {
 	struct nfs_reqlist	*cache;
 	struct rpc_task		*task;
@@ -136,7 +136,7 @@
 	init_waitqueue_head(&cache->request_wait);
 	server->rw_requests = cache;
 
-	return 0;
+	return nfs_reqlist_init(server);
 }
 
 void nfs_reqlist_free(struct nfs_server *server)
diff -u --recursive --new-file linux-2.4.19-fix_create/fs/nfs/pagelist.c linux-2.4.19-fix_put/fs/nfs/pagelist.c
--- linux-2.4.19-fix_create/fs/nfs/pagelist.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.19-fix_put/fs/nfs/pagelist.c	Tue Mar 12 15:34:24 2002
@@ -53,7 +53,7 @@
 
 /**
  * nfs_create_request - Create an NFS read/write request.
- * @file: file that owns this request
+ * @cred: RPC credential to use
  * @inode: inode to which the request is attached
  * @page: page to write
  * @offset: starting offset within the page for the write
@@ -66,7 +66,7 @@
  * User should ensure it is safe to sleep in this function.
  */
 struct nfs_page *
-nfs_create_request(struct file *file, struct inode *inode,
+nfs_create_request(struct rpc_cred *cred, struct inode *inode,
 		   struct page *page,
 		   unsigned int offset, unsigned int count)
 {
@@ -108,34 +108,49 @@
 	req->wb_offset  = offset;
 	req->wb_bytes   = count;
 
-	/* If we have a struct file, use its cached credentials */
-	if (file) {
-		req->wb_file    = file;
-		get_file(file);
-		req->wb_cred	= nfs_file_cred(file);
-	}
+	if (cred)
+		req->wb_cred = get_rpccred(cred);
 	req->wb_inode   = inode;
 	req->wb_count   = 1;
 
 	return req;
 }
 
+/**
+ * nfs_clear_request - Free up all resources allocated to the request
+ * @req:
+ *
+ * Release all resources associated with a write request after it
+ * has completed.
+ */
+void nfs_clear_request(struct nfs_page *req)
+{
+	/* Release struct file or cached credential */
+	if (req->wb_file) {
+		fput(req->wb_file);
+		req->wb_file = NULL;
+	}
+	if (req->wb_cred) {
+		put_rpccred(req->wb_cred);
+		req->wb_cred = NULL;
+	}
+	if (req->wb_page) {
+		page_cache_release(req->wb_page);
+		req->wb_page = NULL;
+		atomic_dec(&NFS_REQUESTLIST(req->wb_inode)->nr_requests);
+	}
+}
+
 
 /**
  * nfs_release_request - Release the count on an NFS read/write request
  * @req: request to release
  *
- * Release all resources associated with a write request after it
- * has been committed to stable storage
- *
  * Note: Should never be called with the spinlock held!
  */
 void
 nfs_release_request(struct nfs_page *req)
 {
-	struct inode		*inode = req->wb_inode;
-	struct nfs_reqlist	*cache = NFS_REQUESTLIST(inode);
-
 	spin_lock(&nfs_wreq_lock);
 	if (--req->wb_count) {
 		spin_unlock(&nfs_wreq_lock);
@@ -143,7 +158,6 @@
 	}
 	__nfs_del_lru(req);
 	spin_unlock(&nfs_wreq_lock);
-	atomic_dec(&cache->nr_requests);
 
 #ifdef NFS_PARANOIA
 	if (!list_empty(&req->wb_list))
@@ -152,16 +166,12 @@
 		BUG();
 	if (NFS_WBACK_BUSY(req))
 		BUG();
-	if (atomic_read(&cache->nr_requests) < 0)
+	if (atomic_read(&NFS_REQUESTLIST(req->wb_inode)->nr_requests) < 0)
 		BUG();
 #endif
 
 	/* Release struct file or cached credential */
-	if (req->wb_file)
-		fput(req->wb_file);
-	else if (req->wb_cred)
-		put_rpccred(req->wb_cred);
-	page_cache_release(req->wb_page);
+	nfs_clear_request(req);
 	nfs_page_free(req);
 }
 
@@ -236,7 +246,7 @@
 
 		req = nfs_list_entry(head->next);
 		if (prev) {
-			if (req->wb_file != prev->wb_file)
+			if (req->wb_cred != prev->wb_cred)
 				break;
 			if (page_index(req->wb_page) != page_index(prev->wb_page)+1)
 				break;
@@ -270,7 +280,7 @@
 {
 	struct nfs_server *server = NFS_SERVER(req->wb_inode);
 	struct list_head *pos, *head = req->wb_list_head;
-	struct file *file = req->wb_file;
+	struct rpc_cred *cred = req->wb_cred;
 	unsigned long idx = page_index(req->wb_page) + 1;
 	int npages = 0;
 
@@ -291,7 +301,7 @@
 			break;
 		if (req->wb_offset != 0)
 			break;
-		if (req->wb_file != file)
+		if (req->wb_cred != cred)
 			break;
 	}
 	return npages;
diff -u --recursive --new-file linux-2.4.19-fix_create/fs/nfs/read.c linux-2.4.19-fix_put/fs/nfs/read.c
--- linux-2.4.19-fix_create/fs/nfs/read.c	Mon Feb 25 20:38:09 2002
+++ linux-2.4.19-fix_put/fs/nfs/read.c	Tue Mar 12 15:34:24 2002
@@ -168,7 +168,7 @@
 {
 	struct nfs_page	*new;
 
-	new = nfs_create_request(file, inode, page, 0, PAGE_CACHE_SIZE);
+	new = nfs_create_request(nfs_file_cred(file), inode, page, 0, PAGE_CACHE_SIZE);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 	nfs_mark_request_read(new);
@@ -224,8 +224,9 @@
 		nfs_list_remove_request(req);
 		SetPageError(page);
 		UnlockPage(page);
-		nfs_unlock_request(req);
+		nfs_clear_request(req);
 		nfs_release_request(req);
+		nfs_unlock_request(req);
 	}
 }
 
@@ -431,6 +432,7 @@
                         (long long)NFS_FILEID(req->wb_inode),
                         req->wb_bytes,
                         (long long)(page_offset(page) + req->wb_offset));
+		nfs_clear_request(req);
 		nfs_release_request(req);
 		nfs_unlock_request(req);
 	}
@@ -448,19 +450,9 @@
 int
 nfs_readpage(struct file *file, struct page *page)
 {
-	struct inode *inode;
+	struct inode *inode = page->mapping->host;
 	int		error;
 
-	if (!file) {
-		struct address_space *mapping = page->mapping;
-		if (!mapping)
-			BUG();
-		inode = mapping->host;
-	} else
-		inode = file->f_dentry->d_inode;
-	if (!inode)
-		BUG();
-
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_CACHE_SIZE, page->index);
 	/*
diff -u --recursive --new-file linux-2.4.19-fix_create/fs/nfs/write.c linux-2.4.19-fix_put/fs/nfs/write.c
--- linux-2.4.19-fix_create/fs/nfs/write.c	Mon Feb 25 20:38:09 2002
+++ linux-2.4.19-fix_put/fs/nfs/write.c	Tue Mar 12 15:34:24 2002
@@ -238,17 +238,11 @@
 int
 nfs_writepage(struct page *page)
 {
-	struct inode *inode;
+	struct inode *inode = page->mapping->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
-	struct address_space *mapping = page->mapping;
 
-	if (!mapping)
-		BUG();
-	inode = mapping->host;
-	if (!inode)
-		BUG();
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
 	/* Ensure we've flushed out any previous writes */
@@ -362,6 +356,7 @@
 		iput(inode);
 	} else
 		spin_unlock(&nfs_wreq_lock);
+	nfs_clear_request(req);
 	nfs_release_request(req);
 }
 
@@ -688,9 +683,13 @@
 		}
 		spin_unlock(&nfs_wreq_lock);
 
-		new = nfs_create_request(file, inode, page, offset, bytes);
+		new = nfs_create_request(nfs_file_cred(file), inode, page, offset, bytes);
 		if (IS_ERR(new))
 			return new;
+		if (file) {
+			new->wb_file = file;
+			get_file(file);
+		}
 		/* If the region is locked, adjust the timeout */
 		if (region_locked(inode, new))
 			new->wb_timeout = jiffies + NFS_WRITEBACK_LOCKDELAY;
@@ -768,7 +767,8 @@
 int
 nfs_flush_incompatible(struct file *file, struct page *page)
 {
-	struct inode	*inode = file->f_dentry->d_inode;
+	struct rpc_cred	*cred = nfs_file_cred(file);
+	struct inode	*inode = page->mapping->host;
 	struct nfs_page	*req;
 	int		status = 0;
 	/*
@@ -781,7 +781,7 @@
 	 */
 	req = nfs_find_request(inode,page);
 	if (req) {
-		if (req->wb_file != file || req->wb_page != page)
+		if (req->wb_file != file || req->wb_cred != cred || req->wb_page != page)
 			status = nfs_wb_page(inode, page);
 		nfs_release_request(req);
 	}
@@ -798,7 +798,7 @@
 nfs_updatepage(struct file *file, struct page *page, unsigned int offset, unsigned int count)
 {
 	struct dentry	*dentry = file->f_dentry;
-	struct inode	*inode = dentry->d_inode;
+	struct inode	*inode = page->mapping->host;
 	struct nfs_page	*req;
 	loff_t		end;
 	int		status = 0;
diff -u --recursive --new-file linux-2.4.19-fix_create/include/linux/nfs_flushd.h linux-2.4.19-fix_put/include/linux/nfs_flushd.h
--- linux-2.4.19-fix_create/include/linux/nfs_flushd.h	Thu Nov 22 20:47:41 2001
+++ linux-2.4.19-fix_put/include/linux/nfs_flushd.h	Tue Mar 12 15:34:24 2002
@@ -32,7 +32,6 @@
  */
 extern int		nfs_reqlist_alloc(struct nfs_server *);
 extern void		nfs_reqlist_free(struct nfs_server *);
-extern int		nfs_reqlist_init(struct nfs_server *);
 extern void		nfs_reqlist_exit(struct nfs_server *);
 extern void		nfs_wake_flushd(void);
 
diff -u --recursive --new-file linux-2.4.19-fix_create/include/linux/nfs_fs.h linux-2.4.19-fix_put/include/linux/nfs_fs.h
--- linux-2.4.19-fix_create/include/linux/nfs_fs.h	Fri Dec 21 18:42:03 2001
+++ linux-2.4.19-fix_put/include/linux/nfs_fs.h	Tue Mar 12 15:34:24 2002
@@ -165,7 +165,9 @@
 static __inline__ struct rpc_cred *
 nfs_file_cred(struct file *file)
 {
-	struct rpc_cred *cred = (struct rpc_cred *)(file->private_data);
+	struct rpc_cred *cred = NULL;
+	if (file)
+		cred = (struct rpc_cred *)file->private_data;
 #ifdef RPC_DEBUG
 	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
 		BUG();
diff -u --recursive --new-file linux-2.4.19-fix_create/include/linux/nfs_page.h linux-2.4.19-fix_put/include/linux/nfs_page.h
--- linux-2.4.19-fix_create/include/linux/nfs_page.h	Thu Nov 22 20:47:41 2001
+++ linux-2.4.19-fix_put/include/linux/nfs_page.h	Tue Mar 12 15:34:24 2002
@@ -41,9 +41,10 @@
 
 #define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY,&(req)->wb_flags))
 
-extern	struct nfs_page *nfs_create_request(struct file *, struct inode *,
+extern	struct nfs_page *nfs_create_request(struct rpc_cred *, struct inode *,
 					    struct page *,
 					    unsigned int, unsigned int);
+extern	void nfs_clear_request(struct nfs_page *req);
 extern	void nfs_release_request(struct nfs_page *req);
 
 
