Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVETJDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVETJDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVETJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:03:08 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:32773 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261384AbVETJA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:00:57 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] FUSE: don't allow restarting of system calls
Message-Id: <E1DZ3Mx-0003ST-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 11:00:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes ability to interrupt and restart operations while
there hasn't been any side-effect.

The reason: applications.  There are some apps it seems that generate
signals at a fast rate.  This means, that if the operation cannot make
enough progress between two signals, it will be restarted for ever.
This bug actually manifested itself with 'krusader' trying to open a
file for writing under sshfs.  Thanks to Eduard Czimbalmos for the
report.

The problem can be solved just by making open() uninterruptible,
because in this case it was the truncate operation that slowed down
the progress.  But it's better to solve this by simply not allowing
interrupts at all (except SIGKILL), because applications don't expect
file operations to be interruptible anyway.  As an added bonus the
code is simplified somewhat.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

 dev.c    |   73 +++++++++++----------------------------------------------------
 dir.c    |   36 +++++++++++++++----------------
 file.c   |   33 ++++++++++------------------
 fuse_i.h |   12 ----------
 inode.c  |    2 -
 5 files changed, 45 insertions(+), 111 deletions(-)

diff -rup linux-2.6.12-rc4-mm2/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc4-mm2/fs/fuse/dev.c	2005-05-20 10:12:39.000000000 +0200
+++ linux-fuse/fs/fuse/dev.c	2005-05-20 10:13:55.000000000 +0200
@@ -101,20 +101,9 @@ static struct fuse_req *do_get_request(s
 	return req;
 }
 
+/* This can return NULL, but only in case it's interrupted by a SIGKILL */
 struct fuse_req *fuse_get_request(struct fuse_conn *fc)
 {
-	if (down_interruptible(&fc->outstanding_sem))
-		return NULL;
-	return do_get_request(fc);
-}
-
-/*
- * Non-interruptible version of the above function is for operations
- * which can't legally return -ERESTART{SYS,NOINTR}.  This can still
- * return NULL, but only in case the signal is SIGKILL.
- */
-struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc)
-{
 	int intr;
 	sigset_t oldset;
 
@@ -239,43 +228,20 @@ static void background_request(struct fu
 		get_file(req->file);
 }
 
-static int request_wait_answer_nonint(struct fuse_req *req)
-{
-	int err;
-	sigset_t oldset;
-	block_sigs(&oldset);
-	err = wait_event_interruptible(req->waitq, req->finished);
-	restore_sigs(&oldset);
-	return err;
-}
-
 /* Called with fuse_lock held.  Releases, and then reacquires it. */
-static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req,
-				int interruptible)
+static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
 {
-	int intr;
+	sigset_t oldset;
 
 	spin_unlock(&fuse_lock);
-	if (interruptible)
-		intr = wait_event_interruptible(req->waitq, req->finished);
-	else
-		intr = request_wait_answer_nonint(req);
+	block_sigs(&oldset);
+	wait_event_interruptible(req->waitq, req->finished);
+	restore_sigs(&oldset);
 	spin_lock(&fuse_lock);
-	if (intr && interruptible && req->sent) {
-		/* If request is already in userspace, only allow KILL
-		   signal to interrupt */
-		spin_unlock(&fuse_lock);
-		intr = request_wait_answer_nonint(req);
-		spin_lock(&fuse_lock);
-	}
-	if (!intr)
+	if (req->finished)
 		return;
 
-	if (!interruptible || req->sent)
-		req->out.h.error = -EINTR;
-	else
-		req->out.h.error = -ERESTARTNOINTR;
-
+	req->out.h.error = -EINTR;
 	req->interrupted = 1;
 	if (req->locked) {
 		/* This is uninterruptible sleep, because data is
@@ -328,8 +294,10 @@ static void queue_request(struct fuse_co
 	wake_up(&fc->waitq);
 }
 
-static void request_send_wait(struct fuse_conn *fc, struct fuse_req *req,
-			      int interruptible)
+/*
+ * This can only be interrupted by a SIGKILL
+ */
+void request_send(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
 	spin_lock(&fuse_lock);
@@ -343,26 +311,11 @@ static void request_send_wait(struct fus
 		   after request_end() */
 		__fuse_get_request(req);
 
-		request_wait_answer(fc, req, interruptible);
+		request_wait_answer(fc, req);
 	}
 	spin_unlock(&fuse_lock);
 }
 
-void request_send(struct fuse_conn *fc, struct fuse_req *req)
-{
-	request_send_wait(fc, req, 1);
-}
-
-/*
- * Non-interruptible version of the above function is for operations
- * which can't legally return -ERESTART{SYS,NOINTR}.  This can still
- * be interrupted but only with SIGKILL.
- */
-void request_send_nonint(struct fuse_conn *fc, struct fuse_req *req)
-{
-	request_send_wait(fc, req, 0);
-}
-
 static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fuse_lock);
diff -rup linux-2.6.12-rc4-mm2/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc4-mm2/fs/fuse/dir.c	2005-05-20 10:12:39.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-05-20 10:13:55.000000000 +0200
@@ -46,12 +46,12 @@ static int fuse_dentry_revalidate(struct
 		struct inode *inode = entry->d_inode;
 		struct fuse_inode *fi = get_fuse_inode(inode);
 		struct fuse_conn *fc = get_fuse_conn(inode);
-		struct fuse_req *req = fuse_get_request_nonint(fc);
+		struct fuse_req *req = fuse_get_request(fc);
 		if (!req)
 			return 0;
 
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
-		request_send_nonint(fc, req);
+		request_send(fc, req);
 		err = req->out.h.error;
 		if (!err) {
 			if (outarg.nodeid != get_node_id(inode)) {
@@ -91,7 +91,7 @@ static int fuse_lookup_iget(struct inode
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
@@ -185,7 +185,7 @@ static int fuse_mknod(struct inode *dir,
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -211,7 +211,7 @@ static int fuse_mkdir(struct inode *dir,
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -236,7 +236,7 @@ static int fuse_symlink(struct inode *di
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	req->in.h.opcode = FUSE_SYMLINK;
 	req->in.numargs = 2;
@@ -253,7 +253,7 @@ static int fuse_unlink(struct inode *dir
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	req->in.h.opcode = FUSE_UNLINK;
 	req->in.h.nodeid = get_node_id(dir);
@@ -284,7 +284,7 @@ static int fuse_rmdir(struct inode *dir,
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	req->in.h.opcode = FUSE_RMDIR;
 	req->in.h.nodeid = get_node_id(dir);
@@ -311,7 +311,7 @@ static int fuse_rename(struct inode *old
 	struct fuse_conn *fc = get_fuse_conn(olddir);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.newdir = get_node_id(newdir);
@@ -356,7 +356,7 @@ static int fuse_link(struct dentry *entr
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
@@ -386,7 +386,7 @@ int fuse_do_getattr(struct inode *inode)
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	req->in.h.opcode = FUSE_GETATTR;
 	req->in.h.nodeid = get_node_id(inode);
@@ -533,7 +533,7 @@ static int fuse_readdir(struct file *fil
 	struct page *page;
 	struct inode *inode = file->f_dentry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request_nonint(fc);
+	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
@@ -563,7 +563,7 @@ static char *read_link(struct dentry *de
 	char *link;
 
 	if (!req)
-		return ERR_PTR(-ERESTARTNOINTR);
+		return ERR_PTR(-EINTR);
 
 	link = (char *) __get_free_page(GFP_KERNEL);
 	if (!link) {
@@ -675,7 +675,7 @@ static int fuse_setattr(struct dentry *e
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.valid = iattr_to_fattr(attr, &inarg.attr);
@@ -759,7 +759,7 @@ static int fuse_setxattr(struct dentry *
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -799,7 +799,7 @@ static ssize_t fuse_getxattr(struct dent
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -849,7 +849,7 @@ static ssize_t fuse_listxattr(struct den
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.size = size;
@@ -895,7 +895,7 @@ static int fuse_removexattr(struct dentr
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
 	req->in.h.opcode = FUSE_REMOVEXATTR;
 	req->in.h.nodeid = get_node_id(inode);
diff -rup linux-2.6.12-rc4-mm2/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc4-mm2/fs/fuse/file.c	2005-05-20 10:12:39.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-05-20 10:13:55.000000000 +0200
@@ -20,9 +20,6 @@ int fuse_open_common(struct inode *inode
 	struct fuse_open_out outarg;
 	struct fuse_file *ff;
 	int err;
-	/* Restarting the syscall is not allowed if O_CREAT and O_EXCL
-	   are both set, because creation will fail on the restart */
-	int excl = (file->f_flags & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL);
 
 	err = generic_file_open(inode, file);
 	if (err)
@@ -36,12 +33,9 @@ int fuse_open_common(struct inode *inode
 		 	return err;
 	}
 
-	if (excl)
-		req = fuse_get_request_nonint(fc);
-	else
-		req = fuse_get_request(fc);
+	req = fuse_get_request(fc);
 	if (!req)
-		return excl ? -EINTR : -ERESTARTSYS;
+		return -EINTR;
 
 	err = -ENOMEM;
 	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
@@ -65,10 +59,7 @@ int fuse_open_common(struct inode *inode
 	req->out.numargs = 1;
 	req->out.args[0].size = sizeof(outarg);
 	req->out.args[0].value = &outarg;
-	if (excl)
-		request_send_nonint(fc, req);
-	else
-		request_send(fc, req);
+	request_send(fc, req);
 	err = req->out.h.error;
 	if (!err && !(fc->flags & FUSE_KERNEL_CACHE))
 		invalidate_inode_pages(inode->i_mapping);
@@ -129,7 +120,7 @@ static int fuse_flush(struct file *file)
 	if (fc->no_flush)
 		return 0;
 
-	req = fuse_get_request_nonint(fc);
+	req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
@@ -142,7 +133,7 @@ static int fuse_flush(struct file *file)
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
-	request_send_nonint(fc, req);
+	request_send(fc, req);
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (err == -ENOSYS) {
@@ -167,7 +158,7 @@ int fuse_fsync_common(struct file *file,
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTSYS;
+		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
@@ -220,7 +211,7 @@ size_t fuse_send_read_common(struct fuse
 	req->out.argvar = 1;
 	req->out.numargs = 1;
 	req->out.args[0].size = count;
-	request_send_nonint(fc, req);
+	request_send(fc, req);
 	return req->out.args[0].size;
 }
 
@@ -236,7 +227,7 @@ static int fuse_readpage(struct file *fi
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t pos = (loff_t) page->index << PAGE_CACHE_SHIFT;
-	struct fuse_req *req = fuse_get_request_nonint(fc);
+	struct fuse_req *req = fuse_get_request(fc);
 	int err = -EINTR;
 	if (!req)
 		goto out;
@@ -309,7 +300,7 @@ static int fuse_readpages(struct file *f
 	int err;
 	data.file = file;
 	data.inode = inode;
-	data.req = fuse_get_request_nonint(fc);
+	data.req = fuse_get_request(fc);
 	if (!data.req)
 		return -EINTR;
 
@@ -344,7 +335,7 @@ static size_t fuse_send_write(struct fus
 	req->out.numargs = 1;
 	req->out.args[0].size = sizeof(struct fuse_write_out);
 	req->out.args[0].value = &outarg;
-	request_send_nonint(fc, req);
+	request_send(fc, req);
 	return outarg.size;
 }
 
@@ -364,7 +355,7 @@ static int fuse_commit_write(struct file
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t pos = ((loff_t) page->index << PAGE_CACHE_SHIFT) + offset;
-	struct fuse_req *req = fuse_get_request_nonint(fc);
+	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
@@ -438,7 +429,7 @@ static ssize_t fuse_direct_io(struct fil
 	ssize_t res = 0;
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTSYS;
+		return -EINTR;
 
 	while (count) {
 		size_t tmp;
diff -rup linux-2.6.12-rc4-mm2/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc4-mm2/fs/fuse/fuse_i.h	2005-05-20 10:12:39.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-05-20 10:13:55.000000000 +0200
@@ -416,27 +416,17 @@ void fuse_reset_request(struct fuse_req 
 struct fuse_req *fuse_get_request(struct fuse_conn *fc);
 
 /**
- * Reserve a preallocated request, only interruptible by SIGKILL
- */
-struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc);
-
-/**
  * Decrement reference count of a request.  If count goes to zero put
  * on unused list (preallocated) or free reqest (not preallocated).
  */
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
- * Send a request (synchronous, interruptible)
+ * Send a request (synchronous)
  */
 void request_send(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
- * Send a request (synchronous, non-interruptible except by SIGKILL)
- */
-void request_send_nonint(struct fuse_conn *fc, struct fuse_req *req);
-
-/**
  * Send a request with no reply
  */
 void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req);
diff -rup linux-2.6.12-rc4-mm2/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.12-rc4-mm2/fs/fuse/inode.c	2005-05-20 10:12:39.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-05-20 10:13:55.000000000 +0200
@@ -231,7 +231,7 @@ static int fuse_statfs(struct super_bloc
 
         req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTSYS;
+		return -EINTR;
 
 	req->in.numargs = 0;
 	req->in.h.opcode = FUSE_STATFS;
