Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945944AbWANAqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWANAqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWANAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:50 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:17326 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945908AbWANAlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:37 -0500
Message-Id: <20060114004057.312383000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:56 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] fuse: introduce list for requests under I/O
Content-Disposition: inline; filename=fuse_io_list.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new list for requests in the process of being transfered
to/from userspace.  This will be needed to be able to abort all
requests even those currently under I/O

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 22:52:06.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 22:52:09.000000000 +0100
@@ -181,6 +181,7 @@ static void process_init_reply(struct fu
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
+	list_del(&req->list);
 	req->state = FUSE_REQ_FINISHED;
 	spin_unlock(&fuse_lock);
 	if (req->background) {
@@ -641,7 +642,7 @@ static ssize_t fuse_dev_readv(struct fil
 
 	req = list_entry(fc->pending.next, struct fuse_req, list);
 	req->state = FUSE_REQ_READING;
-	list_del_init(&req->list);
+	list_move(&req->list, &fc->io);
 
 	in = &req->in;
 	reqsize = in->h.len;
@@ -675,7 +676,7 @@ static ssize_t fuse_dev_readv(struct fil
 		request_end(fc, req);
 	else {
 		req->state = FUSE_REQ_SENT;
-		list_add_tail(&req->list, &fc->processing);
+		list_move_tail(&req->list, &fc->processing);
 		spin_unlock(&fuse_lock);
 	}
 	return reqsize;
@@ -768,7 +769,6 @@ static ssize_t fuse_dev_writev(struct fi
 	if (!req)
 		goto err_unlock;
 
-	list_del_init(&req->list);
 	if (req->interrupted) {
 		spin_unlock(&fuse_lock);
 		fuse_copy_finish(&cs);
@@ -776,6 +776,7 @@ static ssize_t fuse_dev_writev(struct fi
 		request_end(fc, req);
 		return -ENOENT;
 	}
+	list_move(&req->list, &fc->io);
 	req->out.h = oh;
 	req->locked = 1;
 	cs.req = req;
@@ -835,7 +836,6 @@ static void end_requests(struct fuse_con
 	while (!list_empty(head)) {
 		struct fuse_req *req;
 		req = list_entry(head->next, struct fuse_req, list);
-		list_del_init(&req->list);
 		req->out.h.error = -ECONNABORTED;
 		request_end(fc, req);
 		spin_lock(&fuse_lock);
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-13 22:52:06.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-13 22:52:09.000000000 +0100
@@ -124,8 +124,8 @@ enum fuse_req_state {
  * A request to the client
  */
 struct fuse_req {
-	/** This can be on either unused_list, pending or processing
-	    lists in fuse_conn */
+	/** This can be on either unused_list, pending processing or
+	    io lists in fuse_conn */
 	struct list_head list;
 
 	/** Entry on the background list */
@@ -223,6 +223,9 @@ struct fuse_conn {
 	/** The list of requests being processed */
 	struct list_head processing;
 
+	/** The list of requests under I/O */
+	struct list_head io;
+
 	/** Requests put in the background (RELEASE or any other
 	    interrupted request) */
 	struct list_head background;
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-13 22:52:03.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-13 22:52:09.000000000 +0100
@@ -382,6 +382,7 @@ static struct fuse_conn *new_conn(void)
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
+		INIT_LIST_HEAD(&fc->io);
 		INIT_LIST_HEAD(&fc->unused_list);
 		INIT_LIST_HEAD(&fc->background);
 		sema_init(&fc->outstanding_sem, 1); /* One for INIT */

--
