Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWFLMbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWFLMbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWFLMbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:31:11 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:45036 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751904AbWFLMbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:31:09 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 5/7] fuse: ensure FLUSH reaches userspace
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplZ9-000636-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:30:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All POSIX locks owned by the current task are removed on close().  If
the FLUSH request resulting initiated by close() fails to reach
userspace, there might be locks remaining, which cannot be removed.

The only reason it could fail, is if allocating the request fails.  In
this case use the request reserved for RELEASE, or if that is
currently used by another FLUSH, wait for it to become available.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-06-12 14:09:57.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-06-12 14:10:01.000000000 +0200
@@ -76,6 +76,13 @@ static void __fuse_put_request(struct fu
 	atomic_dec(&req->count);
 }
 
+static void fuse_req_init_context(struct fuse_req *req)
+{
+	req->in.h.uid = current->fsuid;
+	req->in.h.gid = current->fsgid;
+	req->in.h.pid = current->pid;
+}
+
 struct fuse_req *fuse_get_req(struct fuse_conn *fc)
 {
 	struct fuse_req *req;
@@ -100,9 +107,7 @@ struct fuse_req *fuse_get_req(struct fus
 	if (!req)
 		goto out;
 
-	req->in.h.uid = current->fsuid;
-	req->in.h.gid = current->fsgid;
-	req->in.h.pid = current->pid;
+	fuse_req_init_context(req);
 	req->waiting = 1;
 	return req;
 
@@ -111,12 +116,87 @@ struct fuse_req *fuse_get_req(struct fus
 	return ERR_PTR(err);
 }
 
+/*
+ * Return request in fuse_file->reserved_req.  However that may
+ * currently be in use.  If that is the case, wait for it to become
+ * available.
+ */
+static struct fuse_req *get_reserved_req(struct fuse_conn *fc,
+					 struct file *file)
+{
+	struct fuse_req *req = NULL;
+	struct fuse_file *ff = file->private_data;
+
+	do {
+		wait_event(fc->blocked_waitq, ff->reserved_req);
+		spin_lock(&fc->lock);
+		if (ff->reserved_req) {
+			req = ff->reserved_req;
+			ff->reserved_req = NULL;
+			get_file(file);
+			req->stolen_file = file;
+		}
+		spin_unlock(&fc->lock);
+	} while (!req);
+
+	return req;
+}
+
+/*
+ * Put stolen request back into fuse_file->reserved_req
+ */
+static void put_reserved_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct file *file = req->stolen_file;
+	struct fuse_file *ff = file->private_data;
+
+	spin_lock(&fc->lock);
+	fuse_request_init(req);
+	BUG_ON(ff->reserved_req);
+	ff->reserved_req = req;
+	wake_up(&fc->blocked_waitq);
+	spin_unlock(&fc->lock);
+	fput(file);
+}
+
+/*
+ * Gets a requests for a file operation, always succeeds
+ *
+ * This is used for sending the FLUSH request, which must get to
+ * userspace, due to POSIX locks which may need to be unlocked.
+ *
+ * If allocation fails due to OOM, use the reserved request in
+ * fuse_file.
+ *
+ * This is very unlikely to deadlock accidentally, since the
+ * filesystem should not have it's own file open.  If deadlock is
+ * intentional, it can still be broken by "aborting" the filesystem.
+ */
+struct fuse_req *fuse_get_req_nofail(struct fuse_conn *fc, struct file *file)
+{
+	struct fuse_req *req;
+
+	atomic_inc(&fc->num_waiting);
+	wait_event(fc->blocked_waitq, !fc->blocked);
+	req = fuse_request_alloc();
+	if (!req)
+		req = get_reserved_req(fc, file);
+
+	fuse_req_init_context(req);
+	req->waiting = 1;
+	return req;
+}
+
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (atomic_dec_and_test(&req->count)) {
 		if (req->waiting)
 			atomic_dec(&fc->num_waiting);
-		fuse_request_free(req);
+
+		if (req->stolen_file)
+			put_reserved_req(fc, req);
+		else
+			fuse_request_free(req);
 	}
 }
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:09:59.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:10:01.000000000 +0200
@@ -65,7 +65,7 @@ struct fuse_inode {
 /** FUSE specific file data */
 struct fuse_file {
 	/** Request reserved for flush and release */
-	struct fuse_req *release_req;
+	struct fuse_req *reserved_req;
 
 	/** File handle used by userspace */
 	u64 fh;
@@ -213,6 +213,9 @@ struct fuse_req {
 
 	/** Request completion callback */
 	void (*end)(struct fuse_conn *, struct fuse_req *);
+
+	/** Request is stolen from fuse_file->reserved_req */
+	struct file *stolen_file;
 };
 
 /**
@@ -456,11 +459,16 @@ struct fuse_req *fuse_request_alloc(void
 void fuse_request_free(struct fuse_req *req);
 
 /**
- * Reserve a preallocated request
+ * Get a request, may fail with -ENOMEM
  */
 struct fuse_req *fuse_get_req(struct fuse_conn *fc);
 
 /**
+ * Gets a requests for a file operation, always succeeds
+ */
+struct fuse_req *fuse_get_req_nofail(struct fuse_conn *fc, struct file *file);
+
+/**
  * Decrement reference count of a request.  If count goes to zero free
  * the request.
  */
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-06-12 14:09:59.000000000 +0200
+++ linux/fs/fuse/file.c	2006-06-12 14:10:01.000000000 +0200
@@ -48,8 +48,8 @@ struct fuse_file *fuse_file_alloc(void)
 	struct fuse_file *ff;
 	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
 	if (ff) {
-		ff->release_req = fuse_request_alloc();
-		if (!ff->release_req) {
+		ff->reserved_req = fuse_request_alloc();
+		if (!ff->reserved_req) {
 			kfree(ff);
 			ff = NULL;
 		}
@@ -59,7 +59,7 @@ struct fuse_file *fuse_file_alloc(void)
 
 void fuse_file_free(struct fuse_file *ff)
 {
-	fuse_request_free(ff->release_req);
+	fuse_request_free(ff->reserved_req);
 	kfree(ff);
 }
 
@@ -115,7 +115,7 @@ int fuse_open_common(struct inode *inode
 struct fuse_req *fuse_release_fill(struct fuse_file *ff, u64 nodeid, int flags,
 				   int opcode)
 {
-	struct fuse_req *req = ff->release_req;
+	struct fuse_req *req = ff->reserved_req;
 	struct fuse_release_in *inarg = &req->misc.release_in;
 
 	inarg->fh = ff->fh;
@@ -187,10 +187,7 @@ static int fuse_flush(struct file *file,
 	if (fc->no_flush)
 		return 0;
 
-	req = fuse_get_req(fc);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
+	req = fuse_get_req_nofail(fc, file);
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.lock_owner = fuse_lock_owner_id(id);
