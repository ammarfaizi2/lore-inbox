Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSBAMoj>; Fri, 1 Feb 2002 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291746AbSBAMob>; Fri, 1 Feb 2002 07:44:31 -0500
Received: from mons.uio.no ([129.240.130.14]:38349 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S291745AbSBAMoP>;
	Fri, 1 Feb 2002 07:44:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15450.36248.23069.981900@charged.uio.no>
Date: Fri, 1 Feb 2002 13:44:08 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3] Fix spurious ETXTBSY errors due to late release
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

of struct file
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>


Hi Linus,

  The following patch should fix a problem of ETXTBSY sometimes
occurring if one tries to run a file straight after compilation.

The problem is that both NFS read and write requests can currently
hold a count on the struct file. This is done partly so as to be able
to pass along the RPC credential (which is cached in the struct file),
and partly so that asynchronous writes can report any errors via the
file->f_error mechanism.

The problem is that both the read and write requests may persist even
after file close() occurs. For O_RDONLY files, this is not a problem,
but for O_WRONLY, and O_RDWR files, the fact that the struct file is
not released until the last call to nfs_release_request() means that
inode->i_writecount does not necessarily get cleared upon file
close().

The following patch fixes both these issues.

  - NFS read requests no longer hold the struct file. They take a
    count on the the RPC credential itself.

  - NFS write requests still hold the struct file, since they want to
    report errors to sys_close() using the file->f_error mechanism.
    However they are made to release the page, credential, and file
    structures as soon as the write is completed instead of following
    the current practice of waiting for the last nfs_page request
    release.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.3-cto/fs/nfs/pagelist.c linux-2.5.3-fix_put/fs/nfs/pagelist.c
--- linux-2.5.3-cto/fs/nfs/pagelist.c	Mon Jan  7 21:55:16 2002
+++ linux-2.5.3-fix_put/fs/nfs/pagelist.c	Thu Jan 31 16:05:53 2002
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
@@ -107,34 +107,49 @@
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
@@ -142,7 +157,6 @@
 	}
 	__nfs_del_lru(req);
 	spin_unlock(&nfs_wreq_lock);
-	atomic_dec(&cache->nr_requests);
 
 #ifdef NFS_PARANOIA
 	if (!list_empty(&req->wb_list))
@@ -151,16 +165,12 @@
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
 
diff -u --recursive --new-file linux-2.5.3-cto/fs/nfs/read.c linux-2.5.3-fix_put/fs/nfs/read.c
--- linux-2.5.3-cto/fs/nfs/read.c	Tue Jan 22 00:37:32 2002
+++ linux-2.5.3-fix_put/fs/nfs/read.c	Thu Jan 31 16:05:53 2002
@@ -171,7 +171,7 @@
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page	*new;
 
-	new = nfs_create_request(file, inode, page, 0, PAGE_CACHE_SIZE);
+	new = nfs_create_request(nfs_file_cred(file), inode, page, 0, PAGE_CACHE_SIZE);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 	nfs_mark_request_read(new);
@@ -227,8 +227,9 @@
 		nfs_list_remove_request(req);
 		SetPageError(page);
 		UnlockPage(page);
-		nfs_unlock_request(req);
+		nfs_clear_request(req);
 		nfs_release_request(req);
+		nfs_unlock_request(req);
 	}
 }
 
@@ -433,6 +434,7 @@
                         (long long)NFS_FILEID(req->wb_inode),
                         req->wb_bytes,
                         (long long)(page_offset(page) + req->wb_offset));
+		nfs_clear_request(req);
 		nfs_release_request(req);
 		nfs_unlock_request(req);
 	}
diff -u --recursive --new-file linux-2.5.3-cto/fs/nfs/write.c linux-2.5.3-fix_put/fs/nfs/write.c
--- linux-2.5.3-cto/fs/nfs/write.c	Tue Jan 22 00:37:32 2002
+++ linux-2.5.3-fix_put/fs/nfs/write.c	Thu Jan 31 16:05:53 2002
@@ -354,6 +354,7 @@
 		iput(inode);
 	} else
 		spin_unlock(&nfs_wreq_lock);
+	nfs_clear_request(req);
 	nfs_release_request(req);
 }
 
@@ -684,9 +685,13 @@
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
diff -u --recursive --new-file linux-2.5.3-cto/include/linux/nfs_fs.h linux-2.5.3-fix_put/include/linux/nfs_fs.h
--- linux-2.5.3-cto/include/linux/nfs_fs.h	Thu Jan 31 15:06:03 2002
+++ linux-2.5.3-fix_put/include/linux/nfs_fs.h	Thu Jan 31 16:06:40 2002
@@ -250,7 +250,9 @@
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
diff -u --recursive --new-file linux-2.5.3-cto/include/linux/nfs_page.h linux-2.5.3-fix_put/include/linux/nfs_page.h
--- linux-2.5.3-cto/include/linux/nfs_page.h	Thu Jan 31 15:13:24 2002
+++ linux-2.5.3-fix_put/include/linux/nfs_page.h	Thu Jan 31 16:05:53 2002
@@ -41,9 +41,10 @@
 
 #define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY,&(req)->wb_flags))
 
-extern	struct nfs_page *nfs_create_request(struct file *, struct inode *,
+extern	struct nfs_page *nfs_create_request(struct rpc_cred *, struct inode *,
 					    struct page *,
 					    unsigned int, unsigned int);
+extern	void nfs_clear_request(struct nfs_page *req);
 extern	void nfs_release_request(struct nfs_page *req);
 
 
