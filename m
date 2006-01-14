Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945934AbWANAp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWANAp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbWANAmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:11 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:19886 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945918AbWANAmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:07 -0500
Message-Id: <20060114004123.473215000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:01 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] fuse: add asynchronous request support
Content-Disposition: inline; filename=fuse_async_req.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add possibility for requests to run asynchronously and call an 'end'
callback when finished.

With this, the special handling of the INIT and RELEASE requests can
be cleaned up too.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-14 00:41:33.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:43:41.000000000 +0100
@@ -172,6 +172,8 @@ static void process_init_reply(struct fu
 	   fuse_putback_request() */
 	for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
 		up(&fc->outstanding_sem);
+
+	fuse_put_request(fc, req);
 }
 
 /*
@@ -180,13 +182,15 @@ static void process_init_reply(struct fu
  * occurred during communication with userspace, or the device file
  * was closed.  In case of a background request the reference to the
  * stored objects are released.  The requester thread is woken up (if
- * still waiting), and finally the reference to the request is
- * released
+ * still waiting), the 'end' callback is called if given, else the
+ * reference to the request is released
  *
  * Called with fuse_lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
+	void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
+	req->end = NULL;
 	list_del(&req->list);
 	req->state = FUSE_REQ_FINISHED;
 	spin_unlock(&fuse_lock);
@@ -197,16 +201,10 @@ static void request_end(struct fuse_conn
 		up_read(&fc->sbput_sem);
 	}
 	wake_up(&req->waitq);
-	if (req->in.h.opcode == FUSE_INIT)
-		process_init_reply(fc, req);
-	else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
-		/* Special case for failed iget in CREATE */
-		u64 nodeid = req->in.h.nodeid;
-		fuse_reset_request(req);
-		fuse_send_forget(fc, req, nodeid, 1);
-		return;
-	}
-	fuse_put_request(fc, req);
+	if (end)
+		end(fc, req);
+	else
+		fuse_put_request(fc, req);
 }
 
 /*
@@ -387,6 +385,7 @@ void fuse_send_init(struct fuse_conn *fc
 	req->out.argvar = 1;
 	req->out.args[0].size = sizeof(struct fuse_init_out);
 	req->out.args[0].value = &req->misc.init_out;
+	req->end = process_init_reply;
 	request_send_background(fc, req);
 }
 
@@ -864,17 +863,32 @@ static void end_requests(struct fuse_con
  * The requests are set to interrupted and finished, and the request
  * waiter is woken up.  This will make request_wait_answer() wait
  * until the request is unlocked and then return.
+ *
+ * If the request is asynchronous, then the end function needs to be
+ * called after waiting for the request to be unlocked (if it was
+ * locked).
  */
 static void end_io_requests(struct fuse_conn *fc)
 {
 	while (!list_empty(&fc->io)) {
-		struct fuse_req *req;
-		req = list_entry(fc->io.next, struct fuse_req, list);
+		struct fuse_req *req =
+			list_entry(fc->io.next, struct fuse_req, list);
+		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
+
 		req->interrupted = 1;
 		req->out.h.error = -ECONNABORTED;
 		req->state = FUSE_REQ_FINISHED;
 		list_del_init(&req->list);
 		wake_up(&req->waitq);
+		if (end) {
+			req->end = NULL;
+			/* The end function will consume this reference */
+			__fuse_get_request(req);
+			spin_unlock(&fuse_lock);
+			wait_event(req->waitq, !req->locked);
+			end(fc, req);
+			spin_lock(&fuse_lock);
+		}
 	}
 }
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:41:33.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:43:41.000000000 +0100
@@ -120,6 +120,8 @@ enum fuse_req_state {
 	FUSE_REQ_FINISHED
 };
 
+struct fuse_conn;
+
 /**
  * A request to the client
  */
@@ -186,6 +188,9 @@ struct fuse_req {
 
 	/** File used in the request (or NULL) */
 	struct file *file;
+
+	/** Request completion callback */
+	void (*end)(struct fuse_conn *, struct fuse_req *);
 };
 
 /**
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-13 23:40:09.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-14 00:43:41.000000000 +0100
@@ -113,6 +113,14 @@ int fuse_open_common(struct inode *inode
 	return err;
 }
 
+/* Special case for failed iget in CREATE */
+static void fuse_release_end(struct fuse_conn *fc, struct fuse_req *req)
+{
+	u64 nodeid = req->in.h.nodeid;
+	fuse_reset_request(req);
+	fuse_send_forget(fc, req, nodeid, 1);
+}
+
 void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
 		       u64 nodeid, struct inode *inode, int flags, int isdir)
 {
@@ -128,6 +136,8 @@ void fuse_send_release(struct fuse_conn 
 	req->in.args[0].size = sizeof(struct fuse_release_in);
 	req->in.args[0].value = inarg;
 	request_send_background(fc, req);
+	if (!inode)
+		req->end = fuse_release_end;
 	kfree(ff);
 }
 

--
