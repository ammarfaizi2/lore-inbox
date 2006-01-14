Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945915AbWANAp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbWANAp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945919AbWANAmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:10 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:19374 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945908AbWANAmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:04 -0500
Message-Id: <20060114004118.605226000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:00 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] fuse: add connection aborting
Content-Disposition: inline; filename=fuse_abort_conn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to abort a filesystem connection.

With the introduction of asynchronous reads, the ability to interrupt
any request is not enough to dissolve deadlocks, since now waiting for
the request completion (page unlocked) is independent of the actual
request, so in a deadlock all threads will be uninterruptible.

The solution is to make it possible to abort all requests, even those
currently undergoing I/O to/from userspace.  The natural interface for
this is 'mount -f mountpoint', but that only works as long as the
filesystem is attached.  So also add an 'abort' attribute to the sysfs
view of the connection.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-14 00:23:16.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:33:20.000000000 +0100
@@ -260,11 +260,13 @@ static void request_wait_answer(struct f
 	wait_event_interruptible(req->waitq, req->state == FUSE_REQ_FINISHED);
 	restore_sigs(&oldset);
 	spin_lock(&fuse_lock);
-	if (req->state == FUSE_REQ_FINISHED)
+	if (req->state == FUSE_REQ_FINISHED && !req->interrupted)
 		return;
 
-	req->out.h.error = -EINTR;
-	req->interrupted = 1;
+	if (!req->interrupted) {
+		req->out.h.error = -EINTR;
+		req->interrupted = 1;
+	}
 	if (req->locked) {
 		/* This is uninterruptible sleep, because data is
 		   being copied to/from the buffers of req.  During
@@ -770,6 +772,10 @@ static ssize_t fuse_dev_writev(struct fi
 		goto err_finish;
 
 	spin_lock(&fuse_lock);
+	err = -ENOENT;
+	if (!fc->connected)
+		goto err_unlock;
+
 	req = request_find(fc, oh.unique);
 	err = -EINVAL;
 	if (!req)
@@ -836,7 +842,11 @@ static unsigned fuse_dev_poll(struct fil
 	return mask;
 }
 
-/* Abort all requests on the given list (pending or processing) */
+/*
+ * Abort all requests on the given list (pending or processing)
+ *
+ * This function releases and reacquires fuse_lock
+ */
 static void end_requests(struct fuse_conn *fc, struct list_head *head)
 {
 	while (!list_empty(head)) {
@@ -848,6 +858,59 @@ static void end_requests(struct fuse_con
 	}
 }
 
+/*
+ * Abort requests under I/O
+ *
+ * The requests are set to interrupted and finished, and the request
+ * waiter is woken up.  This will make request_wait_answer() wait
+ * until the request is unlocked and then return.
+ */
+static void end_io_requests(struct fuse_conn *fc)
+{
+	while (!list_empty(&fc->io)) {
+		struct fuse_req *req;
+		req = list_entry(fc->io.next, struct fuse_req, list);
+		req->interrupted = 1;
+		req->out.h.error = -ECONNABORTED;
+		req->state = FUSE_REQ_FINISHED;
+		list_del_init(&req->list);
+		wake_up(&req->waitq);
+	}
+}
+
+/*
+ * Abort all requests.
+ *
+ * Emergency exit in case of a malicious or accidental deadlock, or
+ * just a hung filesystem.
+ *
+ * The same effect is usually achievable through killing the
+ * filesystem daemon and all users of the filesystem.  The exception
+ * is the combination of an asynchronous request and the tricky
+ * deadlock (see Documentation/filesystems/fuse.txt).
+ *
+ * During the aborting, progression of requests from the pending and
+ * processing lists onto the io list, and progression of new requests
+ * onto the pending list is prevented by req->connected being false.
+ *
+ * Progression of requests under I/O to the processing list is
+ * prevented by the req->interrupted flag being true for these
+ * requests.  For this reason requests on the io list must be aborted
+ * first.
+ */
+void fuse_abort_conn(struct fuse_conn *fc)
+{
+	spin_lock(&fuse_lock);
+	if (fc->connected) {
+		fc->connected = 0;
+		end_io_requests(fc);
+		end_requests(fc, &fc->pending);
+		end_requests(fc, &fc->processing);
+		wake_up_all(&fc->waitq);
+	}
+	spin_unlock(&fuse_lock);
+}
+
 static int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:23:16.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:33:20.000000000 +0100
@@ -246,8 +246,8 @@ struct fuse_conn {
 	/** Mount is active */
 	unsigned mounted : 1;
 
-	/** Connection established, cleared on umount and device
-	    release */
+	/** Connection established, cleared on umount, connection
+	    abort and device release */
 	unsigned connected : 1;
 
 	/** Connection failed (version mismatch) */
@@ -463,6 +463,9 @@ void request_send_background(struct fuse
  */
 void fuse_release_background(struct fuse_req *req);
 
+/* Abort all requests */
+void fuse_abort_conn(struct fuse_conn *fc);
+
 /**
  * Get the attributes of a file
  */
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-14 00:33:16.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 00:33:20.000000000 +0100
@@ -196,6 +196,11 @@ struct inode *fuse_iget(struct super_blo
 	return inode;
 }
 
+static void fuse_umount_begin(struct super_block *sb)
+{
+	fuse_abort_conn(get_fuse_conn_super(sb));
+}
+
 static void fuse_put_super(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
@@ -454,6 +459,7 @@ static struct super_operations fuse_supe
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
 	.put_super	= fuse_put_super,
+	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
 	.show_options	= fuse_show_options,
 };
@@ -560,11 +566,21 @@ static ssize_t fuse_conn_waiting_show(st
 	return sprintf(page, "%i\n", atomic_read(&fc->num_waiting));
 }
 
+static ssize_t fuse_conn_abort_store(struct fuse_conn *fc, const char *page,
+				     size_t count)
+{
+	fuse_abort_conn(fc);
+	return count;
+}
+
 static struct fuse_conn_attr fuse_conn_waiting =
 	__ATTR(waiting, 0400, fuse_conn_waiting_show, NULL);
+static struct fuse_conn_attr fuse_conn_abort =
+	__ATTR(abort, 0600, NULL, fuse_conn_abort_store);
 
 static struct attribute *fuse_conn_attrs[] = {
 	&fuse_conn_waiting.attr,
+	&fuse_conn_abort.attr,
 	NULL,
 };
 

--
