Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCaSDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCaSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCaSDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:03:25 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:21664 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932180AbWCaSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:03:24 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 9/10] fuse: account background requests
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNxm-0005fC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 20:03:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch removed limiting the number of outstanding
requests.  This patch adds a much simpler limiting, that is also
compatible with file locking operations.

A task may have at most one synchronous request allocated.  So these
requests need not be otherwise limited.

However the number of background requests (release, forget,
asynchronous reads, interrupted requests) can grow indefinitely.  This
can be used by a malicous user to cause FUSE to allocate arbitrary
amounts of unswappable kernel memory, denying service.

For this reason add a limit for the number of background requests, and
block allocations of new requests until the number goes bellow the
limit.

Also use this mechanism to block all requests until the INIT reply is
received.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:32.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:32.000000000 +0200
@@ -90,7 +90,17 @@ static void __fuse_put_request(struct fu
 
 struct fuse_req *fuse_get_req(struct fuse_conn *fc)
 {
-	struct fuse_req *req = fuse_request_alloc();
+	struct fuse_req *req;
+	sigset_t oldset;
+	int err;
+
+	block_sigs(&oldset);
+	err = wait_event_interruptible(fc->blocked_waitq, !fc->blocked);
+	restore_sigs(&oldset);
+	if (err)
+		return ERR_PTR(-EINTR);
+
+	req = fuse_request_alloc();
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 
@@ -118,6 +128,11 @@ void fuse_release_background(struct fuse
 		fput(req->file);
 	spin_lock(&fc->lock);
 	list_del(&req->bg_entry);
+	if (fc->num_background == FUSE_MAX_BACKGROUND) {
+		fc->blocked = 0;
+		wake_up_all(&fc->blocked_waitq);
+	}
+	fc->num_background--;
 	spin_unlock(&fc->lock);
 }
 
@@ -195,6 +210,9 @@ static void background_request(struct fu
 {
 	req->background = 1;
 	list_add(&req->bg_entry, &fc->background);
+	fc->num_background++;
+	if (fc->num_background == FUSE_MAX_BACKGROUND)
+		fc->blocked = 1;
 	if (req->inode)
 		req->inode = igrab(req->inode);
 	if (req->inode2)
@@ -288,6 +306,7 @@ void request_send(struct fuse_conn *fc, 
 static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fc->lock);
+	background_request(fc, req);
 	if (fc->connected) {
 		queue_request(fc, req);
 		spin_unlock(&fc->lock);
@@ -306,9 +325,6 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
-	spin_lock(&fc->lock);
-	background_request(fc, req);
-	spin_unlock(&fc->lock);
 	request_send_nowait(fc, req);
 }
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-03-31 18:55:32.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-03-31 18:55:32.000000000 +0200
@@ -18,6 +18,9 @@
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
 
+/** Maximum number of outstanding background requests */
+#define FUSE_MAX_BACKGROUND 10
+
 /** It could be as large as PATH_MAX, but would that have any uses? */
 #define FUSE_NAME_MAX 1024
 
@@ -241,6 +244,17 @@ struct fuse_conn {
 	    interrupted request) */
 	struct list_head background;
 
+	/** Number of requests currently in the background */
+	unsigned num_background;
+
+	/** Flag indicating if connection is blocked.  This will be
+	    the case before the INIT reply is received, and if there
+	    are too many outstading backgrounds requests */
+	int blocked;
+
+	/** waitq for blocked connection */
+	wait_queue_head_t blocked_waitq;
+
 	/** RW semaphore for exclusion with fuse_put_super() */
 	struct rw_semaphore sbput_sem;
 
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:32.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:32.000000000 +0200
@@ -381,6 +381,7 @@ static struct fuse_conn *new_conn(void)
 	if (fc) {
 		spin_lock_init(&fc->lock);
 		init_waitqueue_head(&fc->waitq);
+		init_waitqueue_head(&fc->blocked_waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
@@ -392,6 +393,7 @@ static struct fuse_conn *new_conn(void)
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
 		fc->reqctr = 0;
+		fc->blocked = 1;
 	}
 	return fc;
 }
@@ -438,6 +440,8 @@ static void process_init_reply(struct fu
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 	}
 	fuse_put_request(fc, req);
+	fc->blocked = 0;
+	wake_up_all(&fc->blocked_waitq);
 }
 
 static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
