Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVCRReX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVCRReX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVCRReX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:34:23 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:50562 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262010AbVCRRdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:33:47 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: fix busy inodes after unmount
Message-Id: <E1DCLLi-0001Lx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Mar 2005 18:33:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

If background requests (*) were pending at umount time, the inodes
stored in the request weren't released, resulting in busy inodes after
unmount and possibly Oopsen.

This patch fixes this bug by storing background requests on a
separate list.  In fuse_put_super() the list is walked and the inodes
belonging to the background requests are released.  In addition
sending FORGET messages from fuse_clear_inode() is inhibited if
unmount has started (MS_ACTIVE flag not set).  Releasing inodes in
fuse_super() results in a race with request_end() doing the same.
This is resolved with a per-mount RW semaphore which is acquired for
read in request_end() and for write in fuse_put_super().

(*) requests for which the original requester thread isn't waiting any
more

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

 dev.c    |   33 ++++++++++++++++++++++-----------
 fuse_i.h |   15 +++++++++++++++
 inode.c  |   10 +++++++++-
 3 files changed, 46 insertions(+), 12 deletions(-)

diff -rup linux-2.6.11-mm4/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.11-mm4/fs/fuse/dev.c	2005-03-18 18:01:34.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-03-18 18:02:16.000000000 +0100
@@ -140,6 +140,17 @@ void fuse_put_request(struct fuse_conn *
 		fuse_putback_request(fc, req);
 }
 
+void fuse_release_background(struct fuse_req *req)
+{
+	if (req->inode)
+		iput(req->inode);
+	if (req->inode2)
+		iput(req->inode2);
+	if (req->file)
+		fput(req->file);
+	list_del(&req->bg_entry);
+}
+
 /* Called with fuse_lock, unlocks it */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
@@ -148,12 +159,10 @@ static void request_end(struct fuse_conn
 	putback = atomic_dec_and_test(&req->count);
 	spin_unlock(&fuse_lock);
 	if (req->background) {
-		if (req->inode)
-			iput(req->inode);
-		if (req->inode2)
-			iput(req->inode2);
-		if (req->file)
-			fput(req->file);
+		down_read(&fc->sbput_sem);
+		if (fc->sb)
+			fuse_release_background(req);
+		up_read(&fc->sbput_sem);
 	}
 	wake_up(&req->waitq);
 	if (req->in.h.opcode == FUSE_INIT) {
@@ -169,11 +178,12 @@ static void request_end(struct fuse_conn
 		fuse_putback_request(fc, req);
 }
 
-static void background_request(struct fuse_req *req)
+static void background_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	/* Need to get hold of the inode(s) and/or file used in the
 	   request, so FORGET and RELEASE are not sent too early */
 	req->background = 1;
+	list_add(&req->bg_entry, &fc->background);
 	if (req->inode)
 		req->inode = igrab(req->inode);
 	if (req->inode2)
@@ -193,7 +203,8 @@ static int request_wait_answer_nonint(st
 }
 
 /* Called with fuse_lock held.  Releases, and then reacquires it. */
-static void request_wait_answer(struct fuse_req *req, int interruptible)
+static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req,
+				int interruptible)
 {
 	int intr;
 
@@ -233,7 +244,7 @@ static void request_wait_answer(struct f
 		list_del(&req->list);
 		__fuse_put_request(req);
 	} else if (!req->finished && req->sent)
-		background_request(req);
+		background_request(fc, req);
 }
 
 static unsigned len_args(unsigned numargs, struct fuse_arg *args)
@@ -277,7 +288,7 @@ static void request_send_wait(struct fus
 		   after request_end() */
 		__fuse_get_request(req);
 
-		request_wait_answer(req, interruptible);
+		request_wait_answer(fc, req, interruptible);
 	}
 	spin_unlock(&fuse_lock);
 }
@@ -313,7 +324,7 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
-	background_request(req);
+	background_request(fc, req);
 	request_send_nowait(fc, req);
 }
 
diff -rup linux-2.6.11-mm4/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.11-mm4/fs/fuse/fuse_i.h	2005-03-18 18:01:34.000000000 +0100
+++ linux-fuse/fs/fuse/fuse_i.h	2005-03-18 18:02:16.000000000 +0100
@@ -126,6 +126,9 @@ struct fuse_req {
 	    lists in fuse_conn */
 	struct list_head list;
 
+	/** Entry on the background list */
+	struct list_head bg_entry;
+
 	/** refcount */
 	atomic_t count;
 
@@ -220,6 +223,10 @@ struct fuse_conn {
 	/** The list of requests being processed */
 	struct list_head processing;
 
+	/** Requests put in the background (RELEASE or any other
+	    interrupted request) */
+	struct list_head background;
+
 	/** Controls the maximum number of outstanding requests */
 	struct semaphore outstanding_sem;
 
@@ -227,6 +234,9 @@ struct fuse_conn {
 	    outstanding_sem would go negative */
 	unsigned outstanding_debt;
 
+	/** RW semaphore for exclusion with fuse_put_super() */
+	struct rw_semaphore sbput_sem;
+
 	/** The list of unused requests */
 	struct list_head unused_list;
 
@@ -419,6 +429,11 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
+ * Release inodes and file assiciated with background request
+ */
+void fuse_release_background(struct fuse_req *req);
+
+/**
  * Get the attributes of a file
  */
 int fuse_do_getattr(struct inode *inode);
diff -rup linux-2.6.11-mm4/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.11-mm4/fs/fuse/inode.c	2005-03-18 18:01:34.000000000 +0100
+++ linux-fuse/fs/fuse/inode.c	2005-03-18 18:02:16.000000000 +0100
@@ -85,7 +85,7 @@ void fuse_send_forget(struct fuse_conn *
 static void fuse_clear_inode(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	if (fc) {
+	if (fc && (inode->i_sb->s_flags & MS_ACTIVE)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
 		fuse_send_forget(fc, fi->forget_req, fi->nodeid, inode->i_version);
 		fi->forget_req = NULL;
@@ -188,12 +188,18 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
+	down_write(&fc->sbput_sem);
+	while (!list_empty(&fc->background))
+		fuse_release_background(list_entry(fc->background.next,
+						   struct fuse_req, bg_entry));
+
 	spin_lock(&fuse_lock);
 	fc->sb = NULL;
 	fc->user_id = 0;
 	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
+	up_write(&fc->sbput_sem);
 	fuse_release_conn(fc);
 	*get_fuse_conn_super_p(sb) = NULL;
 	spin_unlock(&fuse_lock);
@@ -386,7 +392,9 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->unused_list);
+		INIT_LIST_HEAD(&fc->background);
 		sema_init(&fc->outstanding_sem, 0);
+		init_rwsem(&fc->sbput_sem);
 		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
 			struct fuse_req *req = fuse_request_alloc();
 			if (!req) {

