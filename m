Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWFLMde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWFLMde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWFLMdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:33:33 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:45698 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751924AbWFLMdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:33:32 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 7/7] fuse: add request interruption
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplbV-00064G-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:33:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add synchronous request interruption.  This is needed for file locking
operations which have to be interruptible.  However filesystem may
implement interruptibility of other operations (e.g. like NFS 'intr'
mount option).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-06-12 14:10:02.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-06-12 14:10:03.000000000 +0200
@@ -34,6 +34,7 @@ static void fuse_request_init(struct fus
 {
 	memset(req, 0, sizeof(*req));
 	INIT_LIST_HEAD(&req->list);
+	INIT_LIST_HEAD(&req->intr_entry);
 	init_waitqueue_head(&req->waitq);
 	atomic_set(&req->count, 1);
 }
@@ -215,6 +216,7 @@ static void request_end(struct fuse_conn
 	void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 	req->end = NULL;
 	list_del(&req->list);
+	list_del(&req->intr_entry);
 	req->state = FUSE_REQ_FINISHED;
 	if (req->background) {
 		if (fc->num_background == FUSE_MAX_BACKGROUND) {
@@ -235,28 +237,63 @@ static void request_end(struct fuse_conn
 		fuse_put_request(fc, req);
 }
 
+static void wait_answer_interruptible(struct fuse_conn *fc,
+				      struct fuse_req *req)
+{
+	if (signal_pending(current))
+		return;
+
+	spin_unlock(&fc->lock);
+	wait_event_interruptible(req->waitq, req->state == FUSE_REQ_FINISHED);
+	spin_lock(&fc->lock);
+}
+
+static void queue_interrupt(struct fuse_conn *fc, struct fuse_req *req)
+{
+	list_add_tail(&req->intr_entry, &fc->interrupts);
+	wake_up(&fc->waitq);
+	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
+}
+
 /* Called with fc->lock held.  Releases, and then reacquires it. */
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
 {
-	sigset_t oldset;
+	if (!fc->no_interrupt) {
+		/* Any signal may interrupt this */
+		wait_answer_interruptible(fc, req);
 
-	spin_unlock(&fc->lock);
-	if (req->force)
+		if (req->aborted)
+			goto aborted;
+		if (req->state == FUSE_REQ_FINISHED)
+			return;
+
+		req->interrupted = 1;
+		if (req->state == FUSE_REQ_SENT)
+			queue_interrupt(fc, req);
+	}
+
+	if (req->force) {
+		spin_unlock(&fc->lock);
 		wait_event(req->waitq, req->state == FUSE_REQ_FINISHED);
-	else {
+		spin_lock(&fc->lock);
+	} else {
+		sigset_t oldset;
+
+		/* Only fatal signals may interrupt this */
 		block_sigs(&oldset);
-		wait_event_interruptible(req->waitq,
-					 req->state == FUSE_REQ_FINISHED);
+		wait_answer_interruptible(fc, req);
 		restore_sigs(&oldset);
 	}
-	spin_lock(&fc->lock);
-	if (req->state == FUSE_REQ_FINISHED && !req->aborted)
-		return;
 
-	if (!req->aborted) {
-		req->out.h.error = -EINTR;
-		req->aborted = 1;
-	}
+	if (req->aborted)
+		goto aborted;
+	if (req->state == FUSE_REQ_FINISHED)
+ 		return;
+
+	req->out.h.error = -EINTR;
+	req->aborted = 1;
+
+ aborted:
 	if (req->locked) {
 		/* This is uninterruptible sleep, because data is
 		   being copied to/from the buffers of req.  During
@@ -288,13 +325,19 @@ static unsigned len_args(unsigned numarg
 	return nbytes;
 }
 
+static u64 fuse_get_unique(struct fuse_conn *fc)
+ {
+ 	fc->reqctr++;
+ 	/* zero is special */
+ 	if (fc->reqctr == 0)
+ 		fc->reqctr = 1;
+
+	return fc->reqctr;
+}
+
 static void queue_request(struct fuse_conn *fc, struct fuse_req *req)
 {
-	fc->reqctr++;
-	/* zero is special */
-	if (fc->reqctr == 0)
-		fc->reqctr = 1;
-	req->in.h.unique = fc->reqctr;
+	req->in.h.unique = fuse_get_unique(fc);
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fc->pending);
@@ -307,9 +350,6 @@ static void queue_request(struct fuse_co
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 }
 
-/*
- * This can only be interrupted by a SIGKILL
- */
 void request_send(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
@@ -566,13 +606,18 @@ static int fuse_copy_args(struct fuse_co
 	return err;
 }
 
+static int request_pending(struct fuse_conn *fc)
+{
+	return !list_empty(&fc->pending) || !list_empty(&fc->interrupts);
+}
+
 /* Wait until a request is available on the pending list */
 static void request_wait(struct fuse_conn *fc)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&fc->waitq, &wait);
-	while (fc->connected && list_empty(&fc->pending)) {
+	while (fc->connected && !request_pending(fc)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current))
 			break;
@@ -586,6 +631,45 @@ static void request_wait(struct fuse_con
 }
 
 /*
+ * Transfer an interrupt request to userspace
+ *
+ * Unlike other requests this is assembled on demand, without a need
+ * to allocate a separate fuse_req structure.
+ *
+ * Called with fc->lock held, releases it
+ */
+static int fuse_read_interrupt(struct fuse_conn *fc, struct fuse_req *req,
+			       const struct iovec *iov, unsigned long nr_segs)
+{
+	struct fuse_copy_state cs;
+	struct fuse_in_header ih;
+	struct fuse_interrupt_in arg;
+	unsigned reqsize = sizeof(ih) + sizeof(arg);
+	int err;
+
+	list_del_init(&req->intr_entry);
+	req->intr_unique = fuse_get_unique(fc);
+	memset(&ih, 0, sizeof(ih));
+	memset(&arg, 0, sizeof(arg));
+	ih.len = reqsize;
+	ih.opcode = FUSE_INTERRUPT;
+	ih.unique = req->intr_unique;
+	arg.unique = req->in.h.unique;
+
+	spin_unlock(&fc->lock);
+	if (iov_length(iov, nr_segs) < reqsize)
+		return -EINVAL;
+
+	fuse_copy_init(&cs, fc, 1, NULL, iov, nr_segs);
+	err = fuse_copy_one(&cs, &ih, sizeof(ih));
+	if (!err)
+		err = fuse_copy_one(&cs, &arg, sizeof(arg));
+	fuse_copy_finish(&cs);
+
+	return err ? err : reqsize;
+}
+
+/*
  * Read a single request into the userspace filesystem's buffer.  This
  * function waits until a request is available, then removes it from
  * the pending list and copies request data to userspace buffer.  If
@@ -610,7 +694,7 @@ static ssize_t fuse_dev_readv(struct fil
 	spin_lock(&fc->lock);
 	err = -EAGAIN;
 	if ((file->f_flags & O_NONBLOCK) && fc->connected &&
-	    list_empty(&fc->pending))
+	    !request_pending(fc))
 		goto err_unlock;
 
 	request_wait(fc);
@@ -618,9 +702,15 @@ static ssize_t fuse_dev_readv(struct fil
 	if (!fc->connected)
 		goto err_unlock;
 	err = -ERESTARTSYS;
-	if (list_empty(&fc->pending))
+	if (!request_pending(fc))
 		goto err_unlock;
 
+	if (!list_empty(&fc->interrupts)) {
+		req = list_entry(fc->interrupts.next, struct fuse_req,
+				 intr_entry);
+		return fuse_read_interrupt(fc, req, iov, nr_segs);
+	}
+
 	req = list_entry(fc->pending.next, struct fuse_req, list);
 	req->state = FUSE_REQ_READING;
 	list_move(&req->list, &fc->io);
@@ -658,6 +748,8 @@ static ssize_t fuse_dev_readv(struct fil
 	else {
 		req->state = FUSE_REQ_SENT;
 		list_move_tail(&req->list, &fc->processing);
+		if (req->interrupted)
+			queue_interrupt(fc, req);
 		spin_unlock(&fc->lock);
 	}
 	return reqsize;
@@ -684,7 +776,7 @@ static struct fuse_req *request_find(str
 	list_for_each(entry, &fc->processing) {
 		struct fuse_req *req;
 		req = list_entry(entry, struct fuse_req, list);
-		if (req->in.h.unique == unique)
+		if (req->in.h.unique == unique || req->intr_unique == unique)
 			return req;
 	}
 	return NULL;
@@ -750,7 +842,6 @@ static ssize_t fuse_dev_writev(struct fi
 		goto err_unlock;
 
 	req = request_find(fc, oh.unique);
-	err = -EINVAL;
 	if (!req)
 		goto err_unlock;
 
@@ -761,6 +852,23 @@ static ssize_t fuse_dev_writev(struct fi
 		request_end(fc, req);
 		return -ENOENT;
 	}
+	/* Is it an interrupt reply? */
+	if (req->intr_unique == oh.unique) {
+		err = -EINVAL;
+		if (nbytes != sizeof(struct fuse_out_header))
+			goto err_unlock;
+
+		if (oh.error == -ENOSYS)
+			fc->no_interrupt = 1;
+		else if (oh.error == -EAGAIN)
+			queue_interrupt(fc, req);
+
+		spin_unlock(&fc->lock);
+		fuse_copy_finish(&cs);
+		return nbytes;
+	}
+
+	req->state = FUSE_REQ_WRITING;
 	list_move(&req->list, &fc->io);
 	req->out.h = oh;
 	req->locked = 1;
@@ -809,7 +917,7 @@ static unsigned fuse_dev_poll(struct fil
 	spin_lock(&fc->lock);
 	if (!fc->connected)
 		mask = POLLERR;
-	else if (!list_empty(&fc->pending))
+	else if (request_pending(fc))
 		mask |= POLLIN | POLLRDNORM;
 	spin_unlock(&fc->lock);
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:10:02.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:10:03.000000000 +0200
@@ -131,6 +131,7 @@ enum fuse_req_state {
 	FUSE_REQ_PENDING,
 	FUSE_REQ_READING,
 	FUSE_REQ_SENT,
+	FUSE_REQ_WRITING,
 	FUSE_REQ_FINISHED
 };
 
@@ -144,9 +145,15 @@ struct fuse_req {
 	    fuse_conn */
 	struct list_head list;
 
+	/** Entry on the interrupts list  */
+	struct list_head intr_entry;
+
 	/** refcount */
 	atomic_t count;
 
+	/** Unique ID for the interrupt request */
+	u64 intr_unique;
+
 	/*
 	 * The following bitfields are either set once before the
 	 * request is queued or setting/clearing them is protected by
@@ -165,6 +172,9 @@ struct fuse_req {
 	/** Request is sent in the background */
 	unsigned background:1;
 
+	/** The request has been interrupted */
+	unsigned interrupted:1;
+
 	/** Data is being copied to/from the request */
 	unsigned locked:1;
 
@@ -262,6 +272,9 @@ struct fuse_conn {
 	/** Number of requests currently in the background */
 	unsigned num_background;
 
+	/** Pending interrupts */
+	struct list_head interrupts;
+
 	/** Flag indicating if connection is blocked.  This will be
 	    the case before the INIT reply is received, and if there
 	    are too many outstading backgrounds requests */
@@ -320,6 +333,9 @@ struct fuse_conn {
 	/** Is create not implemented by fs? */
 	unsigned no_create : 1;
 
+	/** Is interrupt not implemented by fs? */
+	unsigned no_interrupt : 1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-06-12 14:09:59.000000000 +0200
+++ linux/include/linux/fuse.h	2006-06-12 14:10:03.000000000 +0200
@@ -125,7 +125,8 @@ enum fuse_opcode {
 	FUSE_SETLK         = 32,
 	FUSE_SETLKW        = 33,
 	FUSE_ACCESS        = 34,
-	FUSE_CREATE        = 35
+	FUSE_CREATE        = 35,
+	FUSE_INTERRUPT     = 36,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -291,6 +292,10 @@ struct fuse_init_out {
 	__u32	max_write;
 };
 
+struct fuse_interrupt_in {
+	__u64	unique;
+};
+
 struct fuse_in_header {
 	__u32	len;
 	__u32	opcode;
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-06-12 14:10:01.000000000 +0200
+++ linux/fs/fuse/file.c	2006-06-12 14:10:03.000000000 +0200
@@ -705,6 +705,9 @@ static int fuse_setlk(struct file *file,
 	fuse_lk_fill(req, file, fl, opcode, pid);
 	request_send(fc, req);
 	err = req->out.h.error;
+	/* locking is restartable */
+	if (err == -EINTR)
+		err = -ERESTARTSYS;
 	fuse_put_request(fc, req);
 	return err;
 }
Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-06-12 14:09:57.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2006-06-12 14:10:03.000000000 +0200
@@ -124,6 +124,46 @@ For each connection the following files 
 
 Only the owner of the mount may read or write these files.
 
+Interrupting filesystem operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If a process issuing a FUSE filesystem request is interrupted, the
+following will happen:
+
+  1) If the request is not yet sent to userspace AND the signal is
+     fatal (SIGKILL or unhandled fatal signal), then the request is
+     dequeued and returns immediately.
+
+  2) If the request is not yet sent to userspace AND the signal is not
+     fatal, then an 'interrupted' flag is set for the request.  When
+     the request has been successfully transfered to userspace and
+     this flag is set, an INTERRUPT request is queued.
+
+  3) If the request is already sent to userspace, then an INTERRUPT
+     request is queued.
+
+INTERRUPT requests take precedence over other requests, so the
+userspace filesystem will receive queued INTERRUPTs before any others.
+
+The userspace filesystem may ignore the INTERRUPT requests entirely,
+or may honor them by sending a reply to the _original_ request, with
+the error set to EINTR.
+
+It is also possible that there's a race between processing the
+original request and it's INTERRUPT request.  There are two possibilities:
+
+  1) The INTERRUPT request is processed before the original request is
+     processed
+
+  2) The INTERRUPT request is processed after the original request has
+     been answered
+
+If the filesystem cannot find the original request, it should wait for
+some timeout and/or a number of new requests to arrive, after which it
+should reply to the INTERRUPT request with an EAGAIN error.  In case
+1) the INTERRUPT request will be requeued.  In case 2) the INTERRUPT
+reply will be ignored.
+
 Aborting a filesystem connection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -351,10 +391,10 @@ but is caused by a pagefault.
 
 Solution is basically the same as above.
 
-An additional problem is that while the write buffer is being
-copied to the request, the request must not be interrupted.  This
-is because the destination address of the copy may not be valid
-after the request is interrupted.
+An additional problem is that while the write buffer is being copied
+to the request, the request must not be interrupted/aborted.  This is
+because the destination address of the copy may not be valid after the
+request has returned.
 
 This is solved with doing the copy atomically, and allowing abort
 while the page(s) belonging to the write buffer are faulted with
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-06-12 14:09:59.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-06-12 14:10:03.000000000 +0200
@@ -381,6 +381,7 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
+		INIT_LIST_HEAD(&fc->interrupts);
 		atomic_set(&fc->num_waiting, 0);
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
