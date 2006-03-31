Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWCaR5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWCaR5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCaR5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:57:00 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:48540 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932166AbWCaR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:56:59 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 6/10] fuse: use a per-mount spinlock
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNrW-0005cu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:56:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the global spinlock in favor of a per-mount one.

This patch is basically find & replace.  The difficult part has
already been done by the previous patch.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -94,11 +94,11 @@ static struct fuse_req *do_get_request(s
 {
 	struct fuse_req *req;
 
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	BUG_ON(list_empty(&fc->unused_list));
 	req = list_entry(fc->unused_list.next, struct fuse_req, list);
 	list_del_init(&req->list);
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 	fuse_request_init(req);
 	req->preallocated = 1;
 	req->in.h.uid = current->fsuid;
@@ -124,7 +124,7 @@ struct fuse_req *fuse_get_request(struct
 	return do_get_request(fc);
 }
 
-/* Must be called with fuse_lock held */
+/* Must be called with fc->lock held */
 static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (req->preallocated) {
@@ -143,9 +143,9 @@ static void fuse_putback_request(struct 
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (atomic_dec_and_test(&req->count)) {
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 		fuse_putback_request(fc, req);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	}
 }
 
@@ -155,15 +155,15 @@ static void fuse_put_request_locked(stru
 		fuse_putback_request(fc, req);
 }
 
-void fuse_release_background(struct fuse_req *req)
+void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	iput(req->inode);
 	iput(req->inode2);
 	if (req->file)
 		fput(req->file);
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	list_del(&req->bg_entry);
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 }
 
 /*
@@ -182,7 +182,7 @@ void fuse_release_background(struct fuse
  * interrupted and put in the background, it will return with an error
  * and hence never be reset and reused.
  *
- * Called with fuse_lock, unlocks it
+ * Called with fc->lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
@@ -191,14 +191,14 @@ static void request_end(struct fuse_conn
 	if (!req->background) {
 		wake_up(&req->waitq);
 		fuse_put_request_locked(fc, req);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	} else {
 		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 		req->end = NULL;
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 		down_read(&fc->sbput_sem);
 		if (fc->mounted)
-			fuse_release_background(req);
+			fuse_release_background(fc, req);
 		up_read(&fc->sbput_sem);
 		if (end)
 			end(fc, req);
@@ -248,16 +248,16 @@ static void background_request(struct fu
 		get_file(req->file);
 }
 
-/* Called with fuse_lock held.  Releases, and then reacquires it. */
+/* Called with fc->lock held.  Releases, and then reacquires it. */
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
 {
 	sigset_t oldset;
 
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 	block_sigs(&oldset);
 	wait_event_interruptible(req->waitq, req->state == FUSE_REQ_FINISHED);
 	restore_sigs(&oldset);
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	if (req->state == FUSE_REQ_FINISHED && !req->interrupted)
 		return;
 
@@ -271,9 +271,9 @@ static void request_wait_answer(struct f
 		   locked state, there mustn't be any filesystem
 		   operation (e.g. page fault), since that could lead
 		   to deadlock */
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 		wait_event(req->waitq, !req->locked);
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 	}
 	if (req->state == FUSE_REQ_PENDING) {
 		list_del(&req->list);
@@ -324,7 +324,7 @@ static void queue_request(struct fuse_co
 void request_send(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	if (!fc->connected)
 		req->out.h.error = -ENOTCONN;
 	else if (fc->conn_error)
@@ -337,15 +337,15 @@ void request_send(struct fuse_conn *fc, 
 
 		request_wait_answer(fc, req);
 	}
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 }
 
 static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	if (fc->connected) {
 		queue_request(fc, req);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	} else {
 		req->out.h.error = -ENOTCONN;
 		request_end(fc, req);
@@ -361,9 +361,9 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	background_request(fc, req);
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 	request_send_nowait(fc, req);
 }
 
@@ -372,16 +372,16 @@ void request_send_background(struct fuse
  * anything that could cause a page-fault.  If the request was already
  * interrupted bail out.
  */
-static int lock_request(struct fuse_req *req)
+static int lock_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	int err = 0;
 	if (req) {
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 		if (req->interrupted)
 			err = -ENOENT;
 		else
 			req->locked = 1;
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	}
 	return err;
 }
@@ -391,18 +391,19 @@ static int lock_request(struct fuse_req 
  * requester thread is currently waiting for it to be unlocked, so
  * wake it up.
  */
-static void unlock_request(struct fuse_req *req)
+static void unlock_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (req) {
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 		req->locked = 0;
 		if (req->interrupted)
 			wake_up(&req->waitq);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	}
 }
 
 struct fuse_copy_state {
+	struct fuse_conn *fc;
 	int write;
 	struct fuse_req *req;
 	const struct iovec *iov;
@@ -415,11 +416,12 @@ struct fuse_copy_state {
 	unsigned len;
 };
 
-static void fuse_copy_init(struct fuse_copy_state *cs, int write,
-			   struct fuse_req *req, const struct iovec *iov,
-			   unsigned long nr_segs)
+static void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *fc,
+			   int write, struct fuse_req *req,
+			   const struct iovec *iov, unsigned long nr_segs)
 {
 	memset(cs, 0, sizeof(*cs));
+	cs->fc = fc;
 	cs->write = write;
 	cs->req = req;
 	cs->iov = iov;
@@ -449,7 +451,7 @@ static int fuse_copy_fill(struct fuse_co
 	unsigned long offset;
 	int err;
 
-	unlock_request(cs->req);
+	unlock_request(cs->fc, cs->req);
 	fuse_copy_finish(cs);
 	if (!cs->seglen) {
 		BUG_ON(!cs->nr_segs);
@@ -472,7 +474,7 @@ static int fuse_copy_fill(struct fuse_co
 	cs->seglen -= cs->len;
 	cs->addr += cs->len;
 
-	return lock_request(cs->req);
+	return lock_request(cs->fc, cs->req);
 }
 
 /* Do as much copy to/from userspace buffer as we can */
@@ -584,9 +586,9 @@ static void request_wait(struct fuse_con
 		if (signal_pending(current))
 			break;
 
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 		schedule();
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&fc->waitq, &wait);
@@ -614,7 +616,7 @@ static ssize_t fuse_dev_readv(struct fil
 		return -EPERM;
 
  restart:
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	err = -EAGAIN;
 	if((file->f_flags & O_NONBLOCK) && fc->connected &&
 	   list_empty(&fc->pending))
@@ -643,14 +645,14 @@ static ssize_t fuse_dev_readv(struct fil
 		request_end(fc, req);
 		goto restart;
 	}
-	spin_unlock(&fuse_lock);
-	fuse_copy_init(&cs, 1, req, iov, nr_segs);
+	spin_unlock(&fc->lock);
+	fuse_copy_init(&cs, fc, 1, req, iov, nr_segs);
 	err = fuse_copy_one(&cs, &in->h, sizeof(in->h));
 	if (!err)
 		err = fuse_copy_args(&cs, in->numargs, in->argpages,
 				     (struct fuse_arg *) in->args, 0);
 	fuse_copy_finish(&cs);
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	req->locked = 0;
 	if (!err && req->interrupted)
 		err = -ENOENT;
@@ -665,12 +667,12 @@ static ssize_t fuse_dev_readv(struct fil
 	else {
 		req->state = FUSE_REQ_SENT;
 		list_move_tail(&req->list, &fc->processing);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 	}
 	return reqsize;
 
  err_unlock:
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 	return err;
 }
 
@@ -739,7 +741,7 @@ static ssize_t fuse_dev_writev(struct fi
 	if (!fc)
 		return -ENODEV;
 
-	fuse_copy_init(&cs, 0, NULL, iov, nr_segs);
+	fuse_copy_init(&cs, fc, 0, NULL, iov, nr_segs);
 	if (nbytes < sizeof(struct fuse_out_header))
 		return -EINVAL;
 
@@ -751,7 +753,7 @@ static ssize_t fuse_dev_writev(struct fi
 	    oh.len != nbytes)
 		goto err_finish;
 
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	err = -ENOENT;
 	if (!fc->connected)
 		goto err_unlock;
@@ -762,9 +764,9 @@ static ssize_t fuse_dev_writev(struct fi
 		goto err_unlock;
 
 	if (req->interrupted) {
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 		fuse_copy_finish(&cs);
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 		request_end(fc, req);
 		return -ENOENT;
 	}
@@ -772,12 +774,12 @@ static ssize_t fuse_dev_writev(struct fi
 	req->out.h = oh;
 	req->locked = 1;
 	cs.req = req;
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 
 	err = copy_out_args(&cs, &req->out, nbytes);
 	fuse_copy_finish(&cs);
 
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	req->locked = 0;
 	if (!err) {
 		if (req->interrupted)
@@ -789,7 +791,7 @@ static ssize_t fuse_dev_writev(struct fi
 	return err ? err : nbytes;
 
  err_unlock:
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
  err_finish:
 	fuse_copy_finish(&cs);
 	return err;
@@ -813,12 +815,12 @@ static unsigned fuse_dev_poll(struct fil
 
 	poll_wait(file, &fc->waitq, wait);
 
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	if (!fc->connected)
 		mask = POLLERR;
 	else if (!list_empty(&fc->pending))
 		mask |= POLLIN | POLLRDNORM;
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 
 	return mask;
 }
@@ -826,7 +828,7 @@ static unsigned fuse_dev_poll(struct fil
 /*
  * Abort all requests on the given list (pending or processing)
  *
- * This function releases and reacquires fuse_lock
+ * This function releases and reacquires fc->lock
  */
 static void end_requests(struct fuse_conn *fc, struct list_head *head)
 {
@@ -835,7 +837,7 @@ static void end_requests(struct fuse_con
 		req = list_entry(head->next, struct fuse_req, list);
 		req->out.h.error = -ECONNABORTED;
 		request_end(fc, req);
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 	}
 }
 
@@ -866,10 +868,10 @@ static void end_io_requests(struct fuse_
 			req->end = NULL;
 			/* The end function will consume this reference */
 			__fuse_get_request(req);
-			spin_unlock(&fuse_lock);
+			spin_unlock(&fc->lock);
 			wait_event(req->waitq, !req->locked);
 			end(fc, req);
-			spin_lock(&fuse_lock);
+			spin_lock(&fc->lock);
 		}
 	}
 }
@@ -896,7 +898,7 @@ static void end_io_requests(struct fuse_
  */
 void fuse_abort_conn(struct fuse_conn *fc)
 {
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	if (fc->connected) {
 		fc->connected = 0;
 		end_io_requests(fc);
@@ -905,18 +907,18 @@ void fuse_abort_conn(struct fuse_conn *f
 		wake_up_all(&fc->waitq);
 		kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	}
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 }
 
 static int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = fuse_get_conn(file);
 	if (fc) {
-		spin_lock(&fuse_lock);
+		spin_lock(&fc->lock);
 		fc->connected = 0;
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
-		spin_unlock(&fuse_lock);
+		spin_unlock(&fc->lock);
 		fasync_helper(-1, file, 0, &fc->fasync);
 		kobject_put(&fc->kobj);
 	}
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-03-31 18:55:31.000000000 +0200
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -144,7 +144,7 @@ struct fuse_req {
 	/*
 	 * The following bitfields are either set once before the
 	 * request is queued or setting/clearing them is protected by
-	 * fuse_lock
+	 * fuse_conn->lock
 	 */
 
 	/** True if the request has reply */
@@ -213,6 +213,9 @@ struct fuse_req {
  * unmounted.
  */
 struct fuse_conn {
+	/** Lock protecting accessess to  members of this structure */
+	spinlock_t lock;
+
 	/** The user id for this mount */
 	uid_t user_id;
 
@@ -352,21 +355,6 @@ static inline u64 get_node_id(struct ino
 extern const struct file_operations fuse_dev_operations;
 
 /**
- * This is the single global spinlock which protects FUSE's structures
- *
- * The following data is protected by this lock:
- *
- *  - the private_data field of the device file
- *  - the s_fs_info field of the super block
- *  - unused_list, pending, processing lists in fuse_conn
- *  - background list in fuse_conn
- *  - the unique request ID counter reqctr in fuse_conn
- *  - the sb (super_block) field in fuse_conn
- *  - the file (device file) field in fuse_conn
- */
-extern spinlock_t fuse_lock;
-
-/**
  * Get a filled in inode
  */
 struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
@@ -490,7 +478,7 @@ void request_send_background(struct fuse
 /**
  * Release inodes and file associated with background request
  */
-void fuse_release_background(struct fuse_req *req);
+void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req);
 
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -22,7 +22,6 @@ MODULE_AUTHOR("Miklos Szeredi <miklos@sz
 MODULE_DESCRIPTION("Filesystem in Userspace");
 MODULE_LICENSE("GPL");
 
-spinlock_t fuse_lock;
 static kmem_cache_t *fuse_inode_cachep;
 static struct subsystem connections_subsys;
 
@@ -207,13 +206,14 @@ static void fuse_put_super(struct super_
 
 	down_write(&fc->sbput_sem);
 	while (!list_empty(&fc->background))
-		fuse_release_background(list_entry(fc->background.next,
+		fuse_release_background(fc,
+					list_entry(fc->background.next,
 						   struct fuse_req, bg_entry));
 
-	spin_lock(&fuse_lock);
+	spin_lock(&fc->lock);
 	fc->mounted = 0;
 	fc->connected = 0;
-	spin_unlock(&fuse_lock);
+	spin_unlock(&fc->lock);
 	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
@@ -388,6 +388,7 @@ static struct fuse_conn *new_conn(void)
 	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc) {
 		int i;
+		spin_lock_init(&fc->lock);
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
@@ -734,7 +735,6 @@ static int __init fuse_init(void)
 	printk("fuse init (API version %i.%i)\n",
 	       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
 
-	spin_lock_init(&fuse_lock);
 	res = fuse_fs_init();
 	if (res)
 		goto err;
