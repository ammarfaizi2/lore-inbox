Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945908AbWANAmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbWANAmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945913AbWANAlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:53 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:17070 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945906AbWANAlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:36 -0500
Message-Id: <20060114004054.231956000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:55 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] fuse: introduce unified request state
Content-Disposition: inline; filename=fuse_request_state.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The state of request was made up of 2 bitfields (->sent and
->finished) and of the fact that the request was on a list or not.

Unify this into a single state field.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 22:52:03.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 22:52:06.000000000 +0100
@@ -181,7 +181,7 @@ static void process_init_reply(struct fu
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	req->finished = 1;
+	req->state = FUSE_REQ_FINISHED;
 	spin_unlock(&fuse_lock);
 	if (req->background) {
 		down_read(&fc->sbput_sem);
@@ -250,10 +250,10 @@ static void request_wait_answer(struct f
 
 	spin_unlock(&fuse_lock);
 	block_sigs(&oldset);
-	wait_event_interruptible(req->waitq, req->finished);
+	wait_event_interruptible(req->waitq, req->state == FUSE_REQ_FINISHED);
 	restore_sigs(&oldset);
 	spin_lock(&fuse_lock);
-	if (req->finished)
+	if (req->state == FUSE_REQ_FINISHED)
 		return;
 
 	req->out.h.error = -EINTR;
@@ -268,10 +268,10 @@ static void request_wait_answer(struct f
 		wait_event(req->waitq, !req->locked);
 		spin_lock(&fuse_lock);
 	}
-	if (!req->sent && !list_empty(&req->list)) {
+	if (req->state == FUSE_REQ_PENDING) {
 		list_del(&req->list);
 		__fuse_put_request(req);
-	} else if (!req->finished && req->sent)
+	} else if (req->state == FUSE_REQ_SENT)
 		background_request(fc, req);
 }
 
@@ -306,6 +306,7 @@ static void queue_request(struct fuse_co
 			fc->outstanding_debt++;
 	}
 	list_add_tail(&req->list, &fc->pending);
+	req->state = FUSE_REQ_PENDING;
 	wake_up(&fc->waitq);
 }
 
@@ -639,6 +640,7 @@ static ssize_t fuse_dev_readv(struct fil
 		goto err_unlock;
 
 	req = list_entry(fc->pending.next, struct fuse_req, list);
+	req->state = FUSE_REQ_READING;
 	list_del_init(&req->list);
 
 	in = &req->in;
@@ -672,7 +674,7 @@ static ssize_t fuse_dev_readv(struct fil
 	if (!req->isreply)
 		request_end(fc, req);
 	else {
-		req->sent = 1;
+		req->state = FUSE_REQ_SENT;
 		list_add_tail(&req->list, &fc->processing);
 		spin_unlock(&fuse_lock);
 	}
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-13 22:52:03.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-13 22:52:06.000000000 +0100
@@ -111,6 +111,15 @@ struct fuse_out {
 	struct fuse_arg args[3];
 };
 
+/** The request state */
+enum fuse_req_state {
+	FUSE_REQ_INIT = 0,
+	FUSE_REQ_PENDING,
+	FUSE_REQ_READING,
+	FUSE_REQ_SENT,
+	FUSE_REQ_FINISHED
+};
+
 /**
  * A request to the client
  */
@@ -140,11 +149,8 @@ struct fuse_req {
 	/** Data is being copied to/from the request */
 	unsigned locked:1;
 
-	/** Request has been sent to userspace */
-	unsigned sent:1;
-
-	/** The request is finished */
-	unsigned finished:1;
+	/** State of the request */
+	enum fuse_req_state state;
 
 	/** The request input */
 	struct fuse_in in;

--
