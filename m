Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWCaR7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWCaR7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWCaR7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:59:55 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:49564 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932174AbWCaR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:59:53 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 8/10] fuse: clean up request accounting
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNuJ-0005eU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:59:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE allocated most requests from a fixed size pool filled at mount
time.  However in some cases (release/forget) non-pool requests were
used.  File locking operations aren't well served by the request pool,
since they may block indefinetly thus exhausting the pool.

This patch removes the request pool and always allocates requests on
demand.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:32.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:32.000000000 +0200
@@ -72,10 +72,8 @@ static void restore_sigs(sigset_t *oldse
  */
 void fuse_reset_request(struct fuse_req *req)
 {
-	int preallocated = req->preallocated;
 	BUG_ON(atomic_read(&req->count) != 1);
 	fuse_request_init(req);
-	req->preallocated = preallocated;
 }
 
 static void __fuse_get_request(struct fuse_req *req)
@@ -90,71 +88,28 @@ static void __fuse_put_request(struct fu
 	atomic_dec(&req->count);
 }
 
-static struct fuse_req *do_get_request(struct fuse_conn *fc)
+struct fuse_req *fuse_get_req(struct fuse_conn *fc)
 {
-	struct fuse_req *req;
+	struct fuse_req *req = fuse_request_alloc();
+	if (!req)
+		return ERR_PTR(-ENOMEM);
 
-	spin_lock(&fc->lock);
-	BUG_ON(list_empty(&fc->unused_list));
-	req = list_entry(fc->unused_list.next, struct fuse_req, list);
-	list_del_init(&req->list);
-	spin_unlock(&fc->lock);
+	atomic_inc(&fc->num_waiting);
 	fuse_request_init(req);
-	req->preallocated = 1;
 	req->in.h.uid = current->fsuid;
 	req->in.h.gid = current->fsgid;
 	req->in.h.pid = current->pid;
 	return req;
 }
 
-/* This can return NULL, but only in case it's interrupted by a SIGKILL */
-struct fuse_req *fuse_get_request(struct fuse_conn *fc)
-{
-	int intr;
-	sigset_t oldset;
-
-	atomic_inc(&fc->num_waiting);
-	block_sigs(&oldset);
-	intr = down_interruptible(&fc->outstanding_sem);
-	restore_sigs(&oldset);
-	if (intr) {
-		atomic_dec(&fc->num_waiting);
-		return NULL;
-	}
-	return do_get_request(fc);
-}
-
-/* Must be called with fc->lock held */
-static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
-{
-	if (req->preallocated) {
-		atomic_dec(&fc->num_waiting);
-		list_add(&req->list, &fc->unused_list);
-	} else
-		fuse_request_free(req);
-
-	/* If we are in debt decrease that first */
-	if (fc->outstanding_debt)
-		fc->outstanding_debt--;
-	else
-		up(&fc->outstanding_sem);
-}
-
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (atomic_dec_and_test(&req->count)) {
-		spin_lock(&fc->lock);
-		fuse_putback_request(fc, req);
-		spin_unlock(&fc->lock);
+		atomic_dec(&fc->num_waiting);
+		fuse_request_free(req);
 	}
 }
 
-static void fuse_put_request_locked(struct fuse_conn *fc, struct fuse_req *req)
-{
-	if (atomic_dec_and_test(&req->count))
-		fuse_putback_request(fc, req);
-}
-
 void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	iput(req->inode);
@@ -189,9 +144,9 @@ static void request_end(struct fuse_conn
 	list_del(&req->list);
 	req->state = FUSE_REQ_FINISHED;
 	if (!req->background) {
-		wake_up(&req->waitq);
-		fuse_put_request_locked(fc, req);
 		spin_unlock(&fc->lock);
+		wake_up(&req->waitq);
+		fuse_put_request(fc, req);
 	} else {
 		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 		req->end = NULL;
@@ -302,16 +257,6 @@ static void queue_request(struct fuse_co
 	req->in.h.unique = fc->reqctr;
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
-	if (!req->preallocated) {
-		/* If request is not preallocated (either FORGET or
-		   RELEASE), then still decrease outstanding_sem, so
-		   user can't open infinite number of files while not
-		   processing the RELEASE requests.  However for
-		   efficiency do it without blocking, so if down()
-		   would block, just increase the debt instead */
-		if (down_trylock(&fc->outstanding_sem))
-			fc->outstanding_debt++;
-	}
 	list_add_tail(&req->list, &fc->pending);
 	req->state = FUSE_REQ_PENDING;
 	wake_up(&fc->waitq);
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-03-31 18:55:10.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-03-31 18:55:32.000000000 +0200
@@ -117,8 +117,8 @@ static int fuse_dentry_revalidate(struct
 			return 0;
 
 		fc = get_fuse_conn(inode);
-		req = fuse_get_request(fc);
-		if (!req)
+		req = fuse_get_req(fc);
+		if (IS_ERR(req))
 			return 0;
 
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
@@ -188,9 +188,9 @@ static struct dentry *fuse_lookup(struct
 	if (entry->d_name.len > FUSE_NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return ERR_PTR(-EINTR);
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return ERR_PTR(PTR_ERR(req));
 
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
@@ -244,15 +244,14 @@ static int fuse_create_open(struct inode
 	struct file *file;
 	int flags = nd->intent.open.flags - 1;
 
-	err = -ENOSYS;
 	if (fc->no_create)
-		goto out;
+		return -ENOSYS;
 
-	err = -EINTR;
-	req = fuse_get_request(fc);
-	if (!req)
-		goto out;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
+	err = -ENOMEM;
 	ff = fuse_file_alloc();
 	if (!ff)
 		goto out_put_request;
@@ -314,7 +313,6 @@ static int fuse_create_open(struct inode
 	fuse_file_free(ff);
  out_put_request:
 	fuse_put_request(fc, req);
- out:
 	return err;
 }
 
@@ -375,9 +373,9 @@ static int fuse_mknod(struct inode *dir,
 {
 	struct fuse_mknod_in inarg;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -407,9 +405,9 @@ static int fuse_mkdir(struct inode *dir,
 {
 	struct fuse_mkdir_in inarg;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -427,9 +425,9 @@ static int fuse_symlink(struct inode *di
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	unsigned len = strlen(link) + 1;
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->in.h.opcode = FUSE_SYMLINK;
 	req->in.numargs = 2;
@@ -444,9 +442,9 @@ static int fuse_unlink(struct inode *dir
 {
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->in.h.opcode = FUSE_UNLINK;
 	req->in.h.nodeid = get_node_id(dir);
@@ -476,9 +474,9 @@ static int fuse_rmdir(struct inode *dir,
 {
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->in.h.opcode = FUSE_RMDIR;
 	req->in.h.nodeid = get_node_id(dir);
@@ -504,9 +502,9 @@ static int fuse_rename(struct inode *old
 	int err;
 	struct fuse_rename_in inarg;
 	struct fuse_conn *fc = get_fuse_conn(olddir);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.newdir = get_node_id(newdir);
@@ -553,9 +551,9 @@ static int fuse_link(struct dentry *entr
 	struct fuse_link_in inarg;
 	struct inode *inode = entry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
@@ -583,9 +581,9 @@ int fuse_do_getattr(struct inode *inode)
 	int err;
 	struct fuse_attr_out arg;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	struct fuse_req *req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->in.h.opcode = FUSE_GETATTR;
 	req->in.h.nodeid = get_node_id(inode);
@@ -673,9 +671,9 @@ static int fuse_access(struct inode *ino
 	if (fc->no_access)
 		return 0;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mask = mask;
@@ -780,9 +778,9 @@ static int fuse_readdir(struct file *fil
 	if (is_bad_inode(inode))
 		return -EIO;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
@@ -809,11 +807,11 @@ static char *read_link(struct dentry *de
 {
 	struct inode *inode = dentry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_req *req = fuse_get_req(fc);
 	char *link;
 
-	if (!req)
-		return ERR_PTR(-EINTR);
+	if (IS_ERR(req))
+		return ERR_PTR(PTR_ERR(req));
 
 	link = (char *) __get_free_page(GFP_KERNEL);
 	if (!link) {
@@ -933,9 +931,9 @@ static int fuse_setattr(struct dentry *e
 		}
 	}
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	iattr_to_fattr(attr, &inarg);
@@ -995,9 +993,9 @@ static int fuse_setxattr(struct dentry *
 	if (fc->no_setxattr)
 		return -EOPNOTSUPP;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -1035,9 +1033,9 @@ static ssize_t fuse_getxattr(struct dent
 	if (fc->no_getxattr)
 		return -EOPNOTSUPP;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -1085,9 +1083,9 @@ static ssize_t fuse_listxattr(struct den
 	if (fc->no_listxattr)
 		return -EOPNOTSUPP;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -1131,9 +1129,9 @@ static int fuse_removexattr(struct dentr
 	if (fc->no_removexattr)
 		return -EOPNOTSUPP;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->in.h.opcode = FUSE_REMOVEXATTR;
 	req->in.h.nodeid = get_node_id(inode);
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-03-31 18:55:29.000000000 +0200
+++ linux/fs/fuse/file.c	2006-03-31 18:55:32.000000000 +0200
@@ -22,9 +22,9 @@ static int fuse_send_open(struct inode *
 	struct fuse_req *req;
 	int err;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
@@ -184,9 +184,9 @@ static int fuse_flush(struct file *file)
 	if (fc->no_flush)
 		return 0;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
@@ -223,9 +223,9 @@ int fuse_fsync_common(struct file *file,
 	if ((!isdir && fc->no_fsync) || (isdir && fc->no_fsyncdir))
 		return 0;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
@@ -297,9 +297,9 @@ static int fuse_readpage(struct file *fi
 	if (is_bad_inode(inode))
 		goto out;
 
-	err = -EINTR;
-	req = fuse_get_request(fc);
-	if (!req)
+	req = fuse_get_req(fc);
+	err = PTR_ERR(req);
+	if (IS_ERR(req))
 		goto out;
 
 	req->out.page_zeroing = 1;
@@ -368,10 +368,10 @@ static int fuse_readpages_fill(void *_da
 	     (req->num_pages + 1) * PAGE_CACHE_SIZE > fc->max_read ||
 	     req->pages[req->num_pages - 1]->index + 1 != page->index)) {
 		fuse_send_readpages(req, data->file, inode);
-		data->req = req = fuse_get_request(fc);
-		if (!req) {
+		data->req = req = fuse_get_req(fc);
+		if (IS_ERR(req)) {
 			unlock_page(page);
-			return -EINTR;
+			return PTR_ERR(req);
 		}
 	}
 	req->pages[req->num_pages] = page;
@@ -392,9 +392,9 @@ static int fuse_readpages(struct file *f
 
 	data.file = file;
 	data.inode = inode;
-	data.req = fuse_get_request(fc);
-	if (!data.req)
-		return -EINTR;
+	data.req = fuse_get_req(fc);
+	if (IS_ERR(data.req))
+		return PTR_ERR(data.req);
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
 	if (!err) {
@@ -455,9 +455,9 @@ static int fuse_commit_write(struct file
 	if (is_bad_inode(inode))
 		return -EIO;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->num_pages = 1;
 	req->pages[0] = page;
@@ -532,9 +532,9 @@ static ssize_t fuse_direct_io(struct fil
 	if (is_bad_inode(inode))
 		return -EIO;
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	while (count) {
 		size_t nres;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-03-31 18:55:32.000000000 +0200
@@ -18,9 +18,6 @@
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
 
-/** If more requests are outstanding, then the operation will block */
-#define FUSE_MAX_OUTSTANDING 10
-
 /** It could be as large as PATH_MAX, but would that have any uses? */
 #define FUSE_NAME_MAX 1024
 
@@ -131,8 +128,8 @@ struct fuse_conn;
  * A request to the client
  */
 struct fuse_req {
-	/** This can be on either unused_list, pending processing or
-	    io lists in fuse_conn */
+	/** This can be on either pending processing or io lists in
+	    fuse_conn */
 	struct list_head list;
 
 	/** Entry on the background list */
@@ -150,9 +147,6 @@ struct fuse_req {
 	/** True if the request has reply */
 	unsigned isreply:1;
 
-	/** The request is preallocated */
-	unsigned preallocated:1;
-
 	/** The request was interrupted */
 	unsigned interrupted:1;
 
@@ -247,19 +241,9 @@ struct fuse_conn {
 	    interrupted request) */
 	struct list_head background;
 
-	/** Controls the maximum number of outstanding requests */
-	struct semaphore outstanding_sem;
-
-	/** This counts the number of outstanding requests if
-	    outstanding_sem would go negative */
-	unsigned outstanding_debt;
-
 	/** RW semaphore for exclusion with fuse_put_super() */
 	struct rw_semaphore sbput_sem;
 
-	/** The list of unused requests */
-	struct list_head unused_list;
-
 	/** The next unique request id */
 	u64 reqctr;
 
@@ -452,11 +436,11 @@ void fuse_reset_request(struct fuse_req 
 /**
  * Reserve a preallocated request
  */
-struct fuse_req *fuse_get_request(struct fuse_conn *fc);
+struct fuse_req *fuse_get_req(struct fuse_conn *fc);
 
 /**
- * Decrement reference count of a request.  If count goes to zero put
- * on unused list (preallocated) or free request (not preallocated).
+ * Decrement reference count of a request.  If count goes to zero free
+ * the request.
  */
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
 
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:32.000000000 +0200
@@ -243,9 +243,9 @@ static int fuse_statfs(struct super_bloc
 	struct fuse_statfs_out outarg;
 	int err;
 
-        req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	memset(&outarg, 0, sizeof(outarg));
 	req->in.numargs = 0;
@@ -370,15 +370,7 @@ static int fuse_show_options(struct seq_
 
 static void fuse_conn_release(struct kobject *kobj)
 {
-	struct fuse_conn *fc = get_fuse_conn_kobj(kobj);
-
-	while (!list_empty(&fc->unused_list)) {
-		struct fuse_req *req;
-		req = list_entry(fc->unused_list.next, struct fuse_req, list);
-		list_del(&req->list);
-		fuse_request_free(req);
-	}
-	kfree(fc);
+	kfree(get_fuse_conn_kobj(kobj));
 }
 
 static struct fuse_conn *new_conn(void)
@@ -387,27 +379,16 @@ static struct fuse_conn *new_conn(void)
 
 	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc) {
-		int i;
 		spin_lock_init(&fc->lock);
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
-		INIT_LIST_HEAD(&fc->unused_list);
 		INIT_LIST_HEAD(&fc->background);
-		sema_init(&fc->outstanding_sem, 1); /* One for INIT */
 		init_rwsem(&fc->sbput_sem);
 		kobj_set_kset_s(fc, connections_subsys);
 		kobject_init(&fc->kobj);
 		atomic_set(&fc->num_waiting, 0);
-		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
-			struct fuse_req *req = fuse_request_alloc();
-			if (!req) {
-				kobject_put(&fc->kobj);
-				return NULL;
-			}
-			list_add(&req->list, &fc->unused_list);
-		}
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
 		fc->reqctr = 0;
@@ -438,7 +419,6 @@ static struct super_operations fuse_supe
 
 static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 {
-	int i;
 	struct fuse_init_out *arg = &req->misc.init_out;
 
 	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
@@ -457,22 +437,11 @@ static void process_init_reply(struct fu
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 	}
-
-	/* After INIT reply is received other requests can go
-	   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
-	   up()s on outstanding_sem.  The last up() is done in
-	   fuse_putback_request() */
-	for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
-		up(&fc->outstanding_sem);
-
 	fuse_put_request(fc, req);
 }
 
-static void fuse_send_init(struct fuse_conn *fc)
+static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 {
-	/* This is called from fuse_read_super() so there's guaranteed
-	   to be exactly one request available */
-	struct fuse_req *req = fuse_get_request(fc);
 	struct fuse_init_in *arg = &req->misc.init_in;
 
 	arg->major = FUSE_KERNEL_VERSION;
@@ -508,6 +477,7 @@ static int fuse_fill_super(struct super_
 	struct fuse_mount_data d;
 	struct file *file;
 	struct dentry *root_dentry;
+	struct fuse_req *init_req;
 	int err;
 
 	if (!parse_fuse_opt((char *) data, &d))
@@ -554,13 +524,17 @@ static int fuse_fill_super(struct super_
 		goto err;
 	}
 
+	init_req = fuse_request_alloc();
+	if (!init_req)
+		goto err_put_root;
+
 	err = kobject_set_name(&fc->kobj, "%llu", conn_id());
 	if (err)
-		goto err_put_root;
+		goto err_free_req;
 
 	err = kobject_add(&fc->kobj);
 	if (err)
-		goto err_put_root;
+		goto err_free_req;
 
 	sb->s_root = root_dentry;
 	fc->mounted = 1;
@@ -574,10 +548,12 @@ static int fuse_fill_super(struct super_
 	 */
 	fput(file);
 
-	fuse_send_init(fc);
+	fuse_send_init(fc, init_req);
 
 	return 0;
 
+ err_free_req:
+	fuse_request_free(init_req);
  err_put_root:
 	dput(root_dentry);
  err:
