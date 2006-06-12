Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWFLMcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWFLMcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWFLMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:32:22 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:11703 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751919AbWFLMcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:32:21 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 6/7] fuse: rename the interrupted flag
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplaF-00063a-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:31:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the 'interrupted' flag to 'aborted', since it indicates exactly
that, and next patch will introduce an 'interrupted' flag for a
different purpose.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-06-12 14:10:01.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-06-12 14:10:02.000000000 +0200
@@ -202,7 +202,7 @@ void fuse_put_request(struct fuse_conn *
 
 /*
  * This function is called when a request is finished.  Either a reply
- * has arrived or it was interrupted (and not yet sent) or some error
+ * has arrived or it was aborted (and not yet sent) or some error
  * occurred during communication with userspace, or the device file
  * was closed.  The requester thread is woken up (if still waiting),
  * the 'end' callback is called if given, else the reference to the
@@ -250,12 +250,12 @@ static void request_wait_answer(struct f
 		restore_sigs(&oldset);
 	}
 	spin_lock(&fc->lock);
-	if (req->state == FUSE_REQ_FINISHED && !req->interrupted)
+	if (req->state == FUSE_REQ_FINISHED && !req->aborted)
 		return;
 
-	if (!req->interrupted) {
+	if (!req->aborted) {
 		req->out.h.error = -EINTR;
-		req->interrupted = 1;
+		req->aborted = 1;
 	}
 	if (req->locked) {
 		/* This is uninterruptible sleep, because data is
@@ -361,14 +361,14 @@ void request_send_background(struct fuse
 /*
  * Lock the request.  Up to the next unlock_request() there mustn't be
  * anything that could cause a page-fault.  If the request was already
- * interrupted bail out.
+ * aborted bail out.
  */
 static int lock_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	int err = 0;
 	if (req) {
 		spin_lock(&fc->lock);
-		if (req->interrupted)
+		if (req->aborted)
 			err = -ENOENT;
 		else
 			req->locked = 1;
@@ -378,7 +378,7 @@ static int lock_request(struct fuse_conn
 }
 
 /*
- * Unlock request.  If it was interrupted during being locked, the
+ * Unlock request.  If it was aborted during being locked, the
  * requester thread is currently waiting for it to be unlocked, so
  * wake it up.
  */
@@ -387,7 +387,7 @@ static void unlock_request(struct fuse_c
 	if (req) {
 		spin_lock(&fc->lock);
 		req->locked = 0;
-		if (req->interrupted)
+		if (req->aborted)
 			wake_up(&req->waitq);
 		spin_unlock(&fc->lock);
 	}
@@ -589,8 +589,8 @@ static void request_wait(struct fuse_con
  * Read a single request into the userspace filesystem's buffer.  This
  * function waits until a request is available, then removes it from
  * the pending list and copies request data to userspace buffer.  If
- * no reply is needed (FORGET) or request has been interrupted or
- * there was an error during the copying then it's finished by calling
+ * no reply is needed (FORGET) or request has been aborted or there
+ * was an error during the copying then it's finished by calling
  * request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
@@ -645,10 +645,10 @@ static ssize_t fuse_dev_readv(struct fil
 	fuse_copy_finish(&cs);
 	spin_lock(&fc->lock);
 	req->locked = 0;
-	if (!err && req->interrupted)
+	if (!err && req->aborted)
 		err = -ENOENT;
 	if (err) {
-		if (!req->interrupted)
+		if (!req->aborted)
 			req->out.h.error = -EIO;
 		request_end(fc, req);
 		return err;
@@ -754,7 +754,7 @@ static ssize_t fuse_dev_writev(struct fi
 	if (!req)
 		goto err_unlock;
 
-	if (req->interrupted) {
+	if (req->aborted) {
 		spin_unlock(&fc->lock);
 		fuse_copy_finish(&cs);
 		spin_lock(&fc->lock);
@@ -773,9 +773,9 @@ static ssize_t fuse_dev_writev(struct fi
 	spin_lock(&fc->lock);
 	req->locked = 0;
 	if (!err) {
-		if (req->interrupted)
+		if (req->aborted)
 			err = -ENOENT;
-	} else if (!req->interrupted)
+	} else if (!req->aborted)
 		req->out.h.error = -EIO;
 	request_end(fc, req);
 
@@ -835,7 +835,7 @@ static void end_requests(struct fuse_con
 /*
  * Abort requests under I/O
  *
- * The requests are set to interrupted and finished, and the request
+ * The requests are set to aborted and finished, and the request
  * waiter is woken up.  This will make request_wait_answer() wait
  * until the request is unlocked and then return.
  *
@@ -850,7 +850,7 @@ static void end_io_requests(struct fuse_
 			list_entry(fc->io.next, struct fuse_req, list);
 		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 
-		req->interrupted = 1;
+		req->aborted = 1;
 		req->out.h.error = -ECONNABORTED;
 		req->state = FUSE_REQ_FINISHED;
 		list_del_init(&req->list);
@@ -883,9 +883,8 @@ static void end_io_requests(struct fuse_
  * onto the pending list is prevented by req->connected being false.
  *
  * Progression of requests under I/O to the processing list is
- * prevented by the req->interrupted flag being true for these
- * requests.  For this reason requests on the io list must be aborted
- * first.
+ * prevented by the req->aborted flag being true for these requests.
+ * For this reason requests on the io list must be aborted first.
  */
 void fuse_abort_conn(struct fuse_conn *fc)
 {
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:10:01.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:10:02.000000000 +0200
@@ -159,8 +159,8 @@ struct fuse_req {
 	/** Force sending of the request even if interrupted */
 	unsigned force:1;
 
-	/** The request was interrupted */
-	unsigned interrupted:1;
+	/** The request was aborted */
+	unsigned aborted:1;
 
 	/** Request is sent in the background */
 	unsigned background:1;
