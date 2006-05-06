Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWEFTRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEFTRE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWEFTRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:17:04 -0400
Received: from 70-56-217-91.albq.qwest.net ([70.56.217.91]:56514 "EHLO
	moria.ionkov.net") by vger.kernel.org with ESMTP id S932065AbWEFTRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:17:02 -0400
Date: Sat, 6 May 2006 13:17:26 -0600
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: signal handling fixes
Message-ID: <20060506191726.GB8063@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple races can happen when v9fs is interrupted by a signal and Tflush
message is sent to the server. After v9fs sends Tflush it doesn't wait
until it receives Rflush, and possibly the response of the original
message. This behavior may confuse v9fs what fids are allocated by the
file server.

This patch fixes the races and the fid allocation.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 80a519c7156950fd54f7540c44e31873b7e01b19
tree 743a5322d5bd7087db67758432a5da1a976c7a31
parent d0ea523deb849227892c3359227219a260390dec
author Latchesar Ionkov <lucho@ionkov.net> Tue, 02 May 2006 16:49:28 -0600
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 02 May 2006 16:49:28 -0600

 fs/9p/mux.c       |  226 +++++++++++++++++++++++++++++++----------------------
 fs/9p/mux.h       |    4 -
 fs/9p/vfs_file.c  |   13 ++-
 fs/9p/vfs_inode.c |   19 ++++
 4 files changed, 160 insertions(+), 102 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 3e5b124..4d63661 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -50,15 +50,23 @@ enum {
 	Wpending = 8,		/* can write */
 };
 
+enum {
+	None,
+	Flushing,
+	Flushed,
+};
+
 struct v9fs_mux_poll_task;
 
 struct v9fs_req {
+	spinlock_t lock;
 	int tag;
 	struct v9fs_fcall *tcall;
 	struct v9fs_fcall *rcall;
 	int err;
 	v9fs_mux_req_callback cb;
 	void *cba;
+	int flush;
 	struct list_head req_list;
 };
 
@@ -96,8 +104,8 @@ struct v9fs_mux_poll_task {
 
 struct v9fs_mux_rpc {
 	struct v9fs_mux_data *m;
-	struct v9fs_req *req;
 	int err;
+	struct v9fs_fcall *tcall;
 	struct v9fs_fcall *rcall;
 	wait_queue_head_t wqueue;
 };
@@ -524,10 +532,9 @@ again:
 
 static void process_request(struct v9fs_mux_data *m, struct v9fs_req *req)
 {
-	int ecode, tag;
+	int ecode;
 	struct v9fs_str *ename;
 
-	tag = req->tag;
 	if (!req->err && req->rcall->id == RERROR) {
 		ecode = req->rcall->params.rerror.errno;
 		ename = &req->rcall->params.rerror.error;
@@ -553,23 +560,6 @@ static void process_request(struct v9fs_
 		if (!req->err)
 			req->err = -EIO;
 	}
-
-	if (req->err == ERREQFLUSH)
-		return;
-
-	if (req->cb) {
-		dprintk(DEBUG_MUX, "calling callback tcall %p rcall %p\n",
-			req->tcall, req->rcall);
-
-		(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
-		req->cb = NULL;
-	} else
-		kfree(req->rcall);
-
-	v9fs_mux_put_tag(m, tag);
-
-	wake_up(&m->equeue);
-	kfree(req);
 }
 
 /**
@@ -669,17 +659,26 @@ static void v9fs_read_work(void *a)
 		list_for_each_entry_safe(rreq, rptr, &m->req_list, req_list) {
 			if (rreq->tag == rcall->tag) {
 				req = rreq;
-				req->rcall = rcall;
-				list_del(&req->req_list);
-				spin_unlock(&m->lock);
-				process_request(m, req);
+				if (req->flush != Flushing)
+					list_del(&req->req_list);
 				break;
 			}
-
 		}
+		spin_unlock(&m->lock);
 
-		if (!req) {
-			spin_unlock(&m->lock);
+		if (req) {
+			req->rcall = rcall;
+			process_request(m, req);
+
+			if (req->flush != Flushing) {
+				if (req->cb)
+					(*req->cb) (req, req->cba);
+				else
+					kfree(req->rcall);
+
+				wake_up(&m->equeue);
+			}
+		} else {
 			if (err >= 0 && rcall->id != RFLUSH)
 				dprintk(DEBUG_ERROR,
 					"unexpected response mux %p id %d tag %d\n",
@@ -721,7 +720,7 @@ static void v9fs_read_work(void *a)
  * @cb: callback function to call when response is received
  * @cba: parameter to pass to the callback function
  */
-static struct v9fs_req *v9fs_send_request(struct v9fs_mux_data *m,
+static struct v9fs_req *v9fs_send_request(struct v9fs_mux_data *m, 
 					  struct v9fs_fcall *tc,
 					  v9fs_mux_req_callback cb, void *cba)
 {
@@ -746,7 +745,6 @@ static struct v9fs_req *v9fs_send_reques
 		return ERR_PTR(-ENOMEM);
 
 	v9fs_set_tag(tc, n);
-
 	if ((v9fs_debug_level&DEBUG_FCALL) == DEBUG_FCALL) {
 		char buf[150];
 
@@ -754,12 +752,14 @@ static struct v9fs_req *v9fs_send_reques
 		printk(KERN_NOTICE "<<< %p %s\n", m, buf);
 	}
 
+	spin_lock_init(&req->lock);
 	req->tag = n;
 	req->tcall = tc;
 	req->rcall = NULL;
 	req->err = 0;
 	req->cb = cb;
 	req->cba = cba;
+	req->flush = None;
 
 	spin_lock(&m->lock);
 	list_add_tail(&req->req_list, &m->unsent_req_list);
@@ -776,72 +776,108 @@ static struct v9fs_req *v9fs_send_reques
 	return req;
 }
 
-static void v9fs_mux_flush_cb(void *a, struct v9fs_fcall *tc,
-			      struct v9fs_fcall *rc, int err)
+static void v9fs_mux_free_request(struct v9fs_mux_data *m, struct v9fs_req *req)
+{
+	v9fs_mux_put_tag(m, req->tag);
+	kfree(req);
+}
+
+static void v9fs_mux_flush_cb(struct v9fs_req *freq, void *a)
 {
 	v9fs_mux_req_callback cb;
 	int tag;
 	struct v9fs_mux_data *m;
-	struct v9fs_req *req, *rptr;
+	struct v9fs_req *req, *rreq, *rptr;
 
 	m = a;
-	dprintk(DEBUG_MUX, "mux %p tc %p rc %p err %d oldtag %d\n", m, tc,
-		rc, err, tc->params.tflush.oldtag);
+	dprintk(DEBUG_MUX, "mux %p tc %p rc %p err %d oldtag %d\n", m, 
+		freq->tcall, freq->rcall, freq->err, 
+		freq->tcall->params.tflush.oldtag);
 
 	spin_lock(&m->lock);
 	cb = NULL;
-	tag = tc->params.tflush.oldtag;
-	list_for_each_entry_safe(req, rptr, &m->req_list, req_list) {
-		if (req->tag == tag) {
+	tag = freq->tcall->params.tflush.oldtag;
+	req = NULL;
+	list_for_each_entry_safe(rreq, rptr, &m->req_list, req_list) {
+		if (rreq->tag == tag) {
+			req = rreq;
 			list_del(&req->req_list);
-			if (req->cb) {
-				cb = req->cb;
-				req->cb = NULL;
-				spin_unlock(&m->lock);
-				(*cb) (req->cba, req->tcall, req->rcall,
-				       req->err);
-			}
-			kfree(req);
-			wake_up(&m->equeue);
 			break;
 		}
 	}
+	spin_unlock(&m->lock);
 
-	if (!cb)
-		spin_unlock(&m->lock);
+	if (req) {
+		spin_lock(&req->lock);
+		req->flush = Flushed;
+		spin_unlock(&req->lock);
+
+		if (req->cb)
+			(*req->cb) (req, req->cba);
+		else
+			kfree(req->rcall);
+
+		wake_up(&m->equeue);
+	}
 
-	v9fs_mux_put_tag(m, tag);
-	kfree(tc);
-	kfree(rc);
+	kfree(freq->tcall);
+	kfree(freq->rcall);
+	v9fs_mux_free_request(m, freq);
 }
 
-static void
+static int
 v9fs_mux_flush_request(struct v9fs_mux_data *m, struct v9fs_req *req)
 {
 	struct v9fs_fcall *fc;
-
+	struct v9fs_req *rreq, *rptr;
+                                                                                             
 	dprintk(DEBUG_MUX, "mux %p req %p tag %d\n", m, req, req->tag);
 
+	/* if a response was received for a request, do nothing */
+	spin_lock(&req->lock);
+	if (req->rcall || req->err) {
+		spin_unlock(&req->lock);
+		dprintk(DEBUG_MUX, "mux %p req %p response already received\n", m, req);
+		return 0;
+	}
+
+	req->flush = Flushing;
+	spin_unlock(&req->lock);
+
+	spin_lock(&m->lock);
+	/* if the request is not sent yet, just remove it from the list */
+	list_for_each_entry_safe(rreq, rptr, &m->unsent_req_list, req_list) {
+		if (rreq->tag == req->tag) {
+			dprintk(DEBUG_MUX, "mux %p req %p request is not sent yet\n", m, req);
+			list_del(&rreq->req_list);
+			req->flush = Flushed;
+			spin_unlock(&m->lock);
+			if (req->cb)
+				(*req->cb) (req, req->cba);
+			return 0;
+		}
+	}
+	spin_unlock(&m->lock);
+
+	clear_thread_flag(TIF_SIGPENDING);
 	fc = v9fs_create_tflush(req->tag);
 	v9fs_send_request(m, fc, v9fs_mux_flush_cb, m);
+	return 1;
 }
 
 static void
-v9fs_mux_rpc_cb(void *a, struct v9fs_fcall *tc, struct v9fs_fcall *rc, int err)
+v9fs_mux_rpc_cb(struct v9fs_req *req, void *a)
 {
 	struct v9fs_mux_rpc *r;
 
-	if (err == ERREQFLUSH) {
-		kfree(rc);
-		dprintk(DEBUG_MUX, "err req flush\n");
-		return;
-	}
-
+	dprintk(DEBUG_MUX, "req %p r %p\n", req, a);
 	r = a;
-	dprintk(DEBUG_MUX, "mux %p req %p tc %p rc %p err %d\n", r->m, r->req,
-		tc, rc, err);
-	r->rcall = rc;
-	r->err = err;
+	r->rcall = req->rcall;
+	r->err = req->err;
+
+	if (req->flush!=None && !req->err)
+		r->err = -ERESTARTSYS;
+
 	wake_up(&r->wqueue);
 }
 
@@ -856,12 +892,13 @@ int
 v9fs_mux_rpc(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
 	     struct v9fs_fcall **rc)
 {
-	int err;
+	int err, sigpending;
 	unsigned long flags;
 	struct v9fs_req *req;
 	struct v9fs_mux_rpc r;
 
 	r.err = 0;
+	r.tcall = tc;
 	r.rcall = NULL;
 	r.m = m;
 	init_waitqueue_head(&r.wqueue);
@@ -869,48 +906,50 @@ v9fs_mux_rpc(struct v9fs_mux_data *m, st
 	if (rc)
 		*rc = NULL;
 
+	sigpending = 0;
+	if (signal_pending(current)) {
+		sigpending = 1;
+		clear_thread_flag(TIF_SIGPENDING);
+	}
+
 	req = v9fs_send_request(m, tc, v9fs_mux_rpc_cb, &r);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		dprintk(DEBUG_MUX, "error %d\n", err);
-		return PTR_ERR(req);
+		return err;
 	}
 
-	r.req = req;
-	dprintk(DEBUG_MUX, "mux %p tc %p tag %d rpc %p req %p\n", m, tc,
-		req->tag, &r, req);
 	err = wait_event_interruptible(r.wqueue, r.rcall != NULL || r.err < 0);
 	if (r.err < 0)
 		err = r.err;
 
 	if (err == -ERESTARTSYS && m->trans->status == Connected && m->err == 0) {
-		spin_lock(&m->lock);
-		req->tcall = NULL;
-		req->err = ERREQFLUSH;
-		spin_unlock(&m->lock);
+		if (v9fs_mux_flush_request(m, req)) {
+			/* wait until we get response of the flush message */
+			do {
+				clear_thread_flag(TIF_SIGPENDING);
+				err = wait_event_interruptible(r.wqueue, 
+					r.rcall || r.err);
+			} while (!r.rcall && !r.err && err==-ERESTARTSYS &&
+				m->trans->status==Connected && !m->err);
+		}
+		sigpending = 1;
+	}
 
-		clear_thread_flag(TIF_SIGPENDING);
-		v9fs_mux_flush_request(m, req);
+	if (sigpending) {
 		spin_lock_irqsave(&current->sighand->siglock, flags);
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
-	if (!err) {
-		if (r.rcall)
-			dprintk(DEBUG_MUX, "got response id %d tag %d\n",
-				r.rcall->id, r.rcall->tag);
-
-		if (rc)
-			*rc = r.rcall;
-		else
-			kfree(r.rcall);
-	} else {
+	if (rc)
+		*rc = r.rcall;
+	else
 		kfree(r.rcall);
-		dprintk(DEBUG_MUX, "got error %d\n", err);
-		if (err > 0)
-			err = -EIO;
-	}
+
+	v9fs_mux_free_request(m, req);
+	if (err > 0)
+		err = -EIO;
 
 	return err;
 }
@@ -951,12 +990,15 @@ void v9fs_mux_cancel(struct v9fs_mux_dat
 	struct v9fs_req *req, *rtmp;
 	LIST_HEAD(cancel_list);
 
-	dprintk(DEBUG_MUX, "mux %p err %d\n", m, err);
+	dprintk(DEBUG_ERROR, "mux %p err %d\n", m, err);
 	m->err = err;
 	spin_lock(&m->lock);
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
 	}
+	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
+		list_move(&req->req_list, &cancel_list);
+	}
 	spin_unlock(&m->lock);
 
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
@@ -965,11 +1007,9 @@ void v9fs_mux_cancel(struct v9fs_mux_dat
 			req->err = err;
 
 		if (req->cb)
-			(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
+			(*req->cb) (req, req->cba);
 		else
 			kfree(req->rcall);
-
-		kfree(req);
 	}
 
 	wake_up(&m->equeue);
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
index e90bfd3..fb10c50 100644
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -24,6 +24,7 @@
  */
 
 struct v9fs_mux_data;
+struct v9fs_req;
 
 /**
  * v9fs_mux_req_callback - callback function that is called when the
@@ -36,8 +37,7 @@ struct v9fs_mux_data;
  * @rc - response call
  * @err - error code (non-zero if error occured)
  */
-typedef void (*v9fs_mux_req_callback)(void *a, struct v9fs_fcall *tc,
-	struct v9fs_fcall *rc, int err);
+typedef void (*v9fs_mux_req_callback)(struct v9fs_req *req, void *a);
 
 int v9fs_mux_global_init(void);
 void v9fs_mux_global_exit(void);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 083dcfc..1a8e460 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -72,11 +72,17 @@ int v9fs_file_open(struct inode *inode, 
 		return -ENOSPC;
 	}
 
-	err = v9fs_t_walk(v9ses, vfid->fid, fid, NULL, NULL);
+	err = v9fs_t_walk(v9ses, vfid->fid, fid, NULL, &fcall);
 	if (err < 0) {
 		dprintk(DEBUG_ERROR, "rewalk didn't work\n");
-		goto put_fid;
+		if (fcall && fcall->id == RWALK)
+			goto clunk_fid;
+		else {
+			v9fs_put_idpool(fid, &v9ses->fidpool);
+			goto free_fcall;
+		}
 	}
+	kfree(fcall);
 
 	/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
 	/* translate open mode appropriately */
@@ -109,8 +115,7 @@ int v9fs_file_open(struct inode *inode, 
 clunk_fid:
 	v9fs_t_clunk(v9ses, fid);
 
-put_fid:
-	v9fs_put_idpool(fid, &v9ses->fidpool);
+free_fcall:
 	kfree(fcall);
 
 	return err;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 133db36..2cb87ba 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -270,7 +270,10 @@ v9fs_create(struct v9fs_session_info *v9
 	err = v9fs_t_walk(v9ses, pfid, fid, NULL, &fcall);
 	if (err < 0) {
 		PRINT_FCALL_ERROR("clone error", fcall);
-		goto put_fid;
+		if (fcall && fcall->id == RWALK)
+			goto clunk_fid;
+		else
+			goto put_fid;
 	}
 	kfree(fcall);
 
@@ -322,6 +325,9 @@ v9fs_clone_walk(struct v9fs_session_info
 		&fcall);
 
 	if (err < 0) {
+		if (fcall && fcall->id == RWALK)
+			goto clunk_fid;
+
 		PRINT_FCALL_ERROR("walk error", fcall);
 		v9fs_put_idpool(nfid, &v9ses->fidpool);
 		goto error;
@@ -640,19 +646,26 @@ static struct dentry *v9fs_vfs_lookup(st
 	}
 
 	result = v9fs_t_walk(v9ses, dirfidnum, newfid,
-		(char *)dentry->d_name.name, NULL);
+		(char *)dentry->d_name.name, &fcall);
+
 	if (result < 0) {
-		v9fs_put_idpool(newfid, &v9ses->fidpool);
+		if (fcall && fcall->id == RWALK)
+			v9fs_t_clunk(v9ses, newfid);
+		else
+			v9fs_put_idpool(newfid, &v9ses->fidpool);
+
 		if (result == -ENOENT) {
 			d_add(dentry, NULL);
 			dprintk(DEBUG_VFS,
 				"Return negative dentry %p count %d\n",
 				dentry, atomic_read(&dentry->d_count));
+			kfree(fcall);
 			return NULL;
 		}
 		dprintk(DEBUG_ERROR, "walk error:%d\n", result);
 		goto FreeFcall;
 	}
+	kfree(fcall);
 
 	result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (result < 0) {

