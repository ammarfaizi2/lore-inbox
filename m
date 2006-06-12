Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWFLM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWFLM1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWFLM1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:27:36 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:16614 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751914AbWFLM1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:27:35 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 2/7] fuse: no backgrounding on interrupt
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplVc-00061G-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:27:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't put requests into the background when a fatal interrupt occurs
while the request is in userspace.  This removes a major wart from the
implementation.

Backgrounding of requests was introduced to allow breaking of
deadlocks.  However now the same can be achieved by aborting the
filesystem through the 'abort' sysfs attribute.

This is a change in the interface, but should not cause problems,
since these kinds of deadlocks never happen during normal operation.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-06-12 14:09:21.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-06-12 14:09:56.000000000 +0200
@@ -11,7 +11,6 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -205,20 +204,14 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	down_write(&fc->sbput_sem);
-	while (!list_empty(&fc->background))
-		fuse_release_background(fc,
-					list_entry(fc->background.next,
-						   struct fuse_req, bg_entry));
-
 	spin_lock(&fc->lock);
-	fc->mounted = 0;
 	fc->connected = 0;
+	fc->blocked = 0;
 	spin_unlock(&fc->lock);
-	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
+	wake_up_all(&fc->blocked_waitq);
 	kobject_del(&fc->kobj);
 	kobject_put(&fc->kobj);
 }
@@ -386,8 +379,6 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
-		INIT_LIST_HEAD(&fc->background);
-		init_rwsem(&fc->sbput_sem);
 		kobj_set_kset_s(fc, connections_subsys);
 		kobject_init(&fc->kobj);
 		atomic_set(&fc->num_waiting, 0);
@@ -543,7 +534,6 @@ static int fuse_fill_super(struct super_
 		goto err_kobject_del;
 
 	sb->s_root = root_dentry;
-	fc->mounted = 1;
 	fc->connected = 1;
 	kobject_get(&fc->kobj);
 	file->private_data = fc;
Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-06-12 14:09:21.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-06-12 14:09:56.000000000 +0200
@@ -64,18 +64,6 @@ static void restore_sigs(sigset_t *oldse
 	sigprocmask(SIG_SETMASK, oldset, NULL);
 }
 
-/*
- * Reset request, so that it can be reused
- *
- * The caller must be _very_ careful to make sure, that it is holding
- * the only reference to req
- */
-void fuse_reset_request(struct fuse_req *req)
-{
-	BUG_ON(atomic_read(&req->count) != 1);
-	fuse_request_init(req);
-}
-
 static void __fuse_get_request(struct fuse_req *req)
 {
 	atomic_inc(&req->count);
@@ -103,6 +91,10 @@ struct fuse_req *fuse_get_req(struct fus
 	if (intr)
 		goto out;
 
+	err = -ENOTCONN;
+	if (!fc->connected)
+		goto out;
+
 	req = fuse_request_alloc();
 	err = -ENOMEM;
 	if (!req)
@@ -129,113 +121,38 @@ void fuse_put_request(struct fuse_conn *
 }
 
 /*
- * Called with sbput_sem held for read (request_end) or write
- * (fuse_put_super).  By the time fuse_put_super() is finished, all
- * inodes belonging to background requests must be released, so the
- * iputs have to be done within the locked region.
- */
-void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
-{
-	iput(req->inode);
-	iput(req->inode2);
-	spin_lock(&fc->lock);
-	list_del(&req->bg_entry);
-	if (fc->num_background == FUSE_MAX_BACKGROUND) {
-		fc->blocked = 0;
-		wake_up_all(&fc->blocked_waitq);
-	}
-	fc->num_background--;
-	spin_unlock(&fc->lock);
-}
-
-/*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was interrupted (and not yet sent) or some error
  * occurred during communication with userspace, or the device file
- * was closed.  In case of a background request the reference to the
- * stored objects are released.  The requester thread is woken up (if
- * still waiting), the 'end' callback is called if given, else the
- * reference to the request is released
- *
- * Releasing extra reference for foreground requests must be done
- * within the same locked region as setting state to finished.  This
- * is because fuse_reset_request() may be called after request is
- * finished and it must be the sole possessor.  If request is
- * interrupted and put in the background, it will return with an error
- * and hence never be reset and reused.
+ * was closed.  The requester thread is woken up (if still waiting),
+ * the 'end' callback is called if given, else the reference to the
+ * request is released
  *
  * Called with fc->lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
+	void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
+	req->end = NULL;
 	list_del(&req->list);
 	req->state = FUSE_REQ_FINISHED;
-	if (!req->background) {
-		spin_unlock(&fc->lock);
-		wake_up(&req->waitq);
-		fuse_put_request(fc, req);
-	} else {
-		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
-		req->end = NULL;
-		spin_unlock(&fc->lock);
-		down_read(&fc->sbput_sem);
-		if (fc->mounted)
-			fuse_release_background(fc, req);
-		up_read(&fc->sbput_sem);
-
-		/* fput must go outside sbput_sem, otherwise it can deadlock */
-		if (req->file)
-			fput(req->file);
-
-		if (end)
-			end(fc, req);
-		else
-			fuse_put_request(fc, req);
+	if (req->background) {
+		if (fc->num_background == FUSE_MAX_BACKGROUND) {
+			fc->blocked = 0;
+			wake_up_all(&fc->blocked_waitq);
+		}
+		fc->num_background--;
 	}
-}
-
-/*
- * Unfortunately request interruption not just solves the deadlock
- * problem, it causes problems too.  These stem from the fact, that an
- * interrupted request is continued to be processed in userspace,
- * while all the locks and object references (inode and file) held
- * during the operation are released.
- *
- * To release the locks is exactly why there's a need to interrupt the
- * request, so there's not a lot that can be done about this, except
- * introduce additional locking in userspace.
- *
- * More important is to keep inode and file references until userspace
- * has replied, otherwise FORGET and RELEASE could be sent while the
- * inode/file is still used by the filesystem.
- *
- * For this reason the concept of "background" request is introduced.
- * An interrupted request is backgrounded if it has been already sent
- * to userspace.  Backgrounding involves getting an extra reference to
- * inode(s) or file used in the request, and adding the request to
- * fc->background list.  When a reply is received for a background
- * request, the object references are released, and the request is
- * removed from the list.  If the filesystem is unmounted while there
- * are still background requests, the list is walked and references
- * are released as if a reply was received.
- *
- * There's one more use for a background request.  The RELEASE message is
- * always sent as background, since it doesn't return an error or
- * data.
- */
-static void background_request(struct fuse_conn *fc, struct fuse_req *req)
-{
-	req->background = 1;
-	list_add(&req->bg_entry, &fc->background);
-	fc->num_background++;
-	if (fc->num_background == FUSE_MAX_BACKGROUND)
-		fc->blocked = 1;
-	if (req->inode)
-		req->inode = igrab(req->inode);
-	if (req->inode2)
-		req->inode2 = igrab(req->inode2);
+	spin_unlock(&fc->lock);
+	dput(req->dentry);
+	mntput(req->vfsmount);
 	if (req->file)
-		get_file(req->file);
+		fput(req->file);
+	wake_up(&req->waitq);
+	if (end)
+		end(fc, req);
+	else
+		fuse_put_request(fc, req);
 }
 
 /* Called with fc->lock held.  Releases, and then reacquires it. */
@@ -244,9 +161,14 @@ static void request_wait_answer(struct f
 	sigset_t oldset;
 
 	spin_unlock(&fc->lock);
-	block_sigs(&oldset);
-	wait_event_interruptible(req->waitq, req->state == FUSE_REQ_FINISHED);
-	restore_sigs(&oldset);
+	if (req->force)
+		wait_event(req->waitq, req->state == FUSE_REQ_FINISHED);
+	else {
+		block_sigs(&oldset);
+		wait_event_interruptible(req->waitq,
+					 req->state == FUSE_REQ_FINISHED);
+		restore_sigs(&oldset);
+	}
 	spin_lock(&fc->lock);
 	if (req->state == FUSE_REQ_FINISHED && !req->interrupted)
 		return;
@@ -268,8 +190,11 @@ static void request_wait_answer(struct f
 	if (req->state == FUSE_REQ_PENDING) {
 		list_del(&req->list);
 		__fuse_put_request(req);
-	} else if (req->state == FUSE_REQ_SENT)
-		background_request(fc, req);
+	} else if (req->state == FUSE_REQ_SENT) {
+		spin_unlock(&fc->lock);
+		wait_event(req->waitq, req->state == FUSE_REQ_FINISHED);
+		spin_lock(&fc->lock);
+	}
 }
 
 static unsigned len_args(unsigned numargs, struct fuse_arg *args)
@@ -327,8 +252,12 @@ void request_send(struct fuse_conn *fc, 
 static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fc->lock);
-	background_request(fc, req);
 	if (fc->connected) {
+		req->background = 1;
+		fc->num_background++;
+		if (fc->num_background == FUSE_MAX_BACKGROUND)
+			fc->blocked = 1;
+
 		queue_request(fc, req);
 		spin_unlock(&fc->lock);
 	} else {
@@ -883,10 +812,12 @@ void fuse_abort_conn(struct fuse_conn *f
 	spin_lock(&fc->lock);
 	if (fc->connected) {
 		fc->connected = 0;
+		fc->blocked = 0;
 		end_io_requests(fc);
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
 		wake_up_all(&fc->waitq);
+		wake_up_all(&fc->blocked_waitq);
 		kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock(&fc->lock);
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:09:21.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:09:56.000000000 +0200
@@ -8,12 +8,12 @@
 
 #include <linux/fuse.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
-#include <asm/semaphore.h>
 
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
@@ -135,9 +135,6 @@ struct fuse_req {
 	    fuse_conn */
 	struct list_head list;
 
-	/** Entry on the background list */
-	struct list_head bg_entry;
-
 	/** refcount */
 	atomic_t count;
 
@@ -150,6 +147,9 @@ struct fuse_req {
 	/** True if the request has reply */
 	unsigned isreply:1;
 
+	/** Force sending of the request even if interrupted */
+	unsigned force:1;
+
 	/** The request was interrupted */
 	unsigned interrupted:1;
 
@@ -192,15 +192,15 @@ struct fuse_req {
 	/** offset of data on first page */
 	unsigned page_offset;
 
-	/** Inode used in the request */
-	struct inode *inode;
-
-	/** Second inode used in the request (or NULL) */
-	struct inode *inode2;
-
 	/** File used in the request (or NULL) */
 	struct file *file;
 
+	/** vfsmount used in release */
+	struct vfsmount *vfsmount;
+
+	/** dentry used in release */
+	struct dentry *dentry;
+
 	/** Request completion callback */
 	void (*end)(struct fuse_conn *, struct fuse_req *);
 };
@@ -243,10 +243,6 @@ struct fuse_conn {
 	/** The list of requests under I/O */
 	struct list_head io;
 
-	/** Requests put in the background (RELEASE or any other
-	    interrupted request) */
-	struct list_head background;
-
 	/** Number of requests currently in the background */
 	unsigned num_background;
 
@@ -258,15 +254,9 @@ struct fuse_conn {
 	/** waitq for blocked connection */
 	wait_queue_head_t blocked_waitq;
 
-	/** RW semaphore for exclusion with fuse_put_super() */
-	struct rw_semaphore sbput_sem;
-
 	/** The next unique request id */
 	u64 reqctr;
 
-	/** Mount is active */
-	unsigned mounted;
-
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
 	unsigned connected;
@@ -383,12 +373,9 @@ void fuse_file_free(struct fuse_file *ff
 void fuse_finish_open(struct inode *inode, struct file *file,
 		      struct fuse_file *ff, struct fuse_open_out *outarg);
 
-/**
- * Send a RELEASE request
- */
-void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
-		       u64 nodeid, struct inode *inode, int flags, int isdir);
-
+/** */
+struct fuse_req *fuse_release_fill(struct fuse_file *ff, u64 nodeid, int flags,
+				   int opcode);
 /**
  * Send RELEASE or RELEASEDIR request
  */
@@ -446,11 +433,6 @@ struct fuse_req *fuse_request_alloc(void
 void fuse_request_free(struct fuse_req *req);
 
 /**
- * Reinitialize a request, the preallocated flag is left unmodified
- */
-void fuse_reset_request(struct fuse_req *req);
-
-/**
  * Reserve a preallocated request
  */
 struct fuse_req *fuse_get_req(struct fuse_conn *fc);
@@ -476,11 +458,6 @@ void request_send_noreply(struct fuse_co
  */
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 
-/**
- * Release inodes and file associated with background request
- */
-void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req);
-
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-06-12 14:09:21.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-06-12 14:09:56.000000000 +0200
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -79,7 +79,6 @@ static void fuse_lookup_init(struct fuse
 {
 	req->in.h.opcode = FUSE_LOOKUP;
 	req->in.h.nodeid = get_node_id(dir);
-	req->inode = dir;
 	req->in.numargs = 1;
 	req->in.args[0].size = entry->d_name.len + 1;
 	req->in.args[0].value = entry->d_name.name;
@@ -225,6 +224,20 @@ static struct dentry *fuse_lookup(struct
 }
 
 /*
+ * Synchronous release for the case when something goes wrong in CREATE_OPEN
+ */
+static void fuse_sync_release(struct fuse_conn *fc, struct fuse_file *ff,
+			      u64 nodeid, int flags)
+{
+	struct fuse_req *req;
+
+	req = fuse_release_fill(ff, nodeid, flags, FUSE_RELEASE);
+	req->force = 1;
+	request_send(fc, req);
+	fuse_put_request(fc, req);
+}
+
+/*
  * Atomic create+open operation
  *
  * If the filesystem doesn't support this, then fall back to separate
@@ -237,6 +250,7 @@ static int fuse_create_open(struct inode
 	struct inode *inode;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req;
+	struct fuse_req *forget_req;
 	struct fuse_open_in inarg;
 	struct fuse_open_out outopen;
 	struct fuse_entry_out outentry;
@@ -247,9 +261,14 @@ static int fuse_create_open(struct inode
 	if (fc->no_create)
 		return -ENOSYS;
 
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req))
+		return PTR_ERR(forget_req);
+
 	req = fuse_get_req(fc);
+	err = PTR_ERR(req);
 	if (IS_ERR(req))
-		return PTR_ERR(req);
+		goto out_put_forget_req;
 
 	err = -ENOMEM;
 	ff = fuse_file_alloc();
@@ -262,7 +281,6 @@ static int fuse_create_open(struct inode
 	inarg.mode = mode;
 	req->in.h.opcode = FUSE_CREATE;
 	req->in.h.nodeid = get_node_id(dir);
-	req->inode = dir;
 	req->in.numargs = 2;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -285,25 +303,23 @@ static int fuse_create_open(struct inode
 	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid))
 		goto out_free_ff;
 
+	fuse_put_request(fc, req);
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr);
-	err = -ENOMEM;
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		ff->fh = outopen.fh;
-		/* Special release, with inode = NULL, this will
-		   trigger a 'forget' request when the release is
-		   complete */
-		fuse_send_release(fc, ff, outentry.nodeid, NULL, flags, 0);
-		goto out_put_request;
+		fuse_sync_release(fc, ff, outentry.nodeid, flags);
+		fuse_send_forget(fc, forget_req, outentry.nodeid, 1);
+		return -ENOMEM;
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 	d_instantiate(entry, inode);
 	fuse_change_timeout(entry, &outentry);
 	file = lookup_instantiate_filp(nd, entry, generic_file_open);
 	if (IS_ERR(file)) {
 		ff->fh = outopen.fh;
-		fuse_send_release(fc, ff, outentry.nodeid, inode, flags, 0);
+		fuse_sync_release(fc, ff, outentry.nodeid, flags);
 		return PTR_ERR(file);
 	}
 	fuse_finish_open(inode, file, ff, &outopen);
@@ -313,6 +329,8 @@ static int fuse_create_open(struct inode
 	fuse_file_free(ff);
  out_put_request:
 	fuse_put_request(fc, req);
+ out_put_forget_req:
+	fuse_put_request(fc, forget_req);
 	return err;
 }
 
@@ -328,7 +346,6 @@ static int create_new_entry(struct fuse_
 	int err;
 
 	req->in.h.nodeid = get_node_id(dir);
-	req->inode = dir;
 	req->out.numargs = 1;
 	req->out.args[0].size = sizeof(outarg);
 	req->out.args[0].value = &outarg;
@@ -448,7 +465,6 @@ static int fuse_unlink(struct inode *dir
 
 	req->in.h.opcode = FUSE_UNLINK;
 	req->in.h.nodeid = get_node_id(dir);
-	req->inode = dir;
 	req->in.numargs = 1;
 	req->in.args[0].size = entry->d_name.len + 1;
 	req->in.args[0].value = entry->d_name.name;
@@ -480,7 +496,6 @@ static int fuse_rmdir(struct inode *dir,
 
 	req->in.h.opcode = FUSE_RMDIR;
 	req->in.h.nodeid = get_node_id(dir);
-	req->inode = dir;
 	req->in.numargs = 1;
 	req->in.args[0].size = entry->d_name.len + 1;
 	req->in.args[0].value = entry->d_name.name;
@@ -510,8 +525,6 @@ static int fuse_rename(struct inode *old
 	inarg.newdir = get_node_id(newdir);
 	req->in.h.opcode = FUSE_RENAME;
 	req->in.h.nodeid = get_node_id(olddir);
-	req->inode = olddir;
-	req->inode2 = newdir;
 	req->in.numargs = 3;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -558,7 +571,6 @@ static int fuse_link(struct dentry *entr
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	req->in.h.opcode = FUSE_LINK;
-	req->inode2 = inode;
 	req->in.numargs = 2;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -587,7 +599,6 @@ int fuse_do_getattr(struct inode *inode)
 
 	req->in.h.opcode = FUSE_GETATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->out.numargs = 1;
 	req->out.args[0].size = sizeof(arg);
 	req->out.args[0].value = &arg;
@@ -679,7 +690,6 @@ static int fuse_access(struct inode *ino
 	inarg.mask = mask;
 	req->in.h.opcode = FUSE_ACCESS;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -820,7 +830,6 @@ static char *read_link(struct dentry *de
 	}
 	req->in.h.opcode = FUSE_READLINK;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->out.argvar = 1;
 	req->out.numargs = 1;
 	req->out.args[0].size = PAGE_SIZE - 1;
@@ -939,7 +948,6 @@ static int fuse_setattr(struct dentry *e
 	iattr_to_fattr(attr, &inarg);
 	req->in.h.opcode = FUSE_SETATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -1002,7 +1010,6 @@ static int fuse_setxattr(struct dentry *
 	inarg.flags = flags;
 	req->in.h.opcode = FUSE_SETXATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 3;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -1041,7 +1048,6 @@ static ssize_t fuse_getxattr(struct dent
 	inarg.size = size;
 	req->in.h.opcode = FUSE_GETXATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 2;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -1091,7 +1097,6 @@ static ssize_t fuse_listxattr(struct den
 	inarg.size = size;
 	req->in.h.opcode = FUSE_LISTXATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -1135,7 +1140,6 @@ static int fuse_removexattr(struct dentr
 
 	req->in.h.opcode = FUSE_REMOVEXATTR;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = strlen(name) + 1;
 	req->in.args[0].value = name;
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-06-12 14:09:22.000000000 +0200
+++ linux/fs/fuse/file.c	2006-06-12 14:09:56.000000000 +0200
@@ -30,7 +30,6 @@ static int fuse_send_open(struct inode *
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 	req->in.h.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -113,37 +112,22 @@ int fuse_open_common(struct inode *inode
 	return err;
 }
 
-/* Special case for failed iget in CREATE */
-static void fuse_release_end(struct fuse_conn *fc, struct fuse_req *req)
+struct fuse_req *fuse_release_fill(struct fuse_file *ff, u64 nodeid, int flags,
+				   int opcode)
 {
-	/* If called from end_io_requests(), req has more than one
-	   reference and fuse_reset_request() cannot work */
-	if (fc->connected) {
-		u64 nodeid = req->in.h.nodeid;
-		fuse_reset_request(req);
-		fuse_send_forget(fc, req, nodeid, 1);
-	} else
-		fuse_put_request(fc, req);
-}
-
-void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
-		       u64 nodeid, struct inode *inode, int flags, int isdir)
-{
-	struct fuse_req * req = ff->release_req;
+	struct fuse_req *req = ff->release_req;
 	struct fuse_release_in *inarg = &req->misc.release_in;
 
 	inarg->fh = ff->fh;
 	inarg->flags = flags;
-	req->in.h.opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
+	req->in.h.opcode = opcode;
 	req->in.h.nodeid = nodeid;
-	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(struct fuse_release_in);
 	req->in.args[0].value = inarg;
-	request_send_background(fc, req);
-	if (!inode)
-		req->end = fuse_release_end;
 	kfree(ff);
+
+	return req;
 }
 
 int fuse_release_common(struct inode *inode, struct file *file, int isdir)
@@ -151,8 +135,15 @@ int fuse_release_common(struct inode *in
 	struct fuse_file *ff = file->private_data;
 	if (ff) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
-		u64 nodeid = get_node_id(inode);
-		fuse_send_release(fc, ff, nodeid, inode, file->f_flags, isdir);
+		struct fuse_req *req;
+
+		req = fuse_release_fill(ff, get_node_id(inode), file->f_flags,
+					isdir ? FUSE_RELEASEDIR : FUSE_RELEASE);
+
+		/* Hold vfsmount and dentry until release is finished */
+		req->vfsmount = mntget(file->f_vfsmnt);
+		req->dentry = dget(file->f_dentry);
+		request_send_background(fc, req);
 	}
 
 	/* Return value is ignored by VFS */
@@ -192,8 +183,6 @@ static int fuse_flush(struct file *file,
 	inarg.fh = ff->fh;
 	req->in.h.opcode = FUSE_FLUSH;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->file = file;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -232,8 +221,6 @@ int fuse_fsync_common(struct file *file,
 	inarg.fsync_flags = datasync ? 1 : 0;
 	req->in.h.opcode = isdir ? FUSE_FSYNCDIR : FUSE_FSYNC;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->file = file;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
@@ -266,8 +253,6 @@ void fuse_read_fill(struct fuse_req *req
 	inarg->size = count;
 	req->in.h.opcode = opcode;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->file = file;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(struct fuse_read_in);
 	req->in.args[0].value = inarg;
@@ -342,6 +327,8 @@ static void fuse_send_readpages(struct f
 	req->out.page_zeroing = 1;
 	fuse_read_fill(req, file, inode, pos, count, FUSE_READ);
 	if (fc->async_read) {
+		get_file(file);
+		req->file = file;
 		req->end = fuse_readpages_end;
 		request_send_background(fc, req);
 	} else {
@@ -420,8 +407,6 @@ static size_t fuse_send_write(struct fus
 	inarg.size = count;
 	req->in.h.opcode = FUSE_WRITE;
 	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->file = file;
 	req->in.argpages = 1;
 	req->in.numargs = 2;
 	req->in.args[0].size = sizeof(struct fuse_write_in);
Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-06-12 14:09:22.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2006-06-12 14:09:56.000000000 +0200
@@ -304,25 +304,7 @@ Scenario 1 -  Simple deadlock
  |                                    |     for "file"]
  |                                    |    *DEADLOCK*
 
-The solution for this is to allow requests to be interrupted while
-they are in userspace:
-
- |      [interrupted by signal]       |
- |    <fuse_unlink()                  |
- |    [release semaphore]             |    [semaphore acquired]
- |  <sys_unlink()                     |
- |                                    |    >fuse_unlink()
- |                                    |      [queue req on fc->pending]
- |                                    |      [wake up fc->waitq]
- |                                    |      [sleep on req->waitq]
-
-If the filesystem daemon was single threaded, this will stop here,
-since there's no other thread to dequeue and execute the request.
-In this case the solution is to kill the FUSE daemon as well.  If
-there are multiple serving threads, you just have to kill them as
-long as any remain.
-
-Moral: a filesystem which deadlocks, can soon find itself dead.
+The solution for this is to allow the filesystem to be aborted.
 
 Scenario 2 - Tricky deadlock
 ----------------------------
@@ -355,24 +337,14 @@ but is caused by a pagefault.
  |                                    |           [lock page]
  |                                    |           * DEADLOCK *
 
-Solution is again to let the the request be interrupted (not
-elaborated further).
+Solution is basically the same as above.
 
 An additional problem is that while the write buffer is being
 copied to the request, the request must not be interrupted.  This
 is because the destination address of the copy may not be valid
 after the request is interrupted.
 
-This is solved with doing the copy atomically, and allowing
-interruption while the page(s) belonging to the write buffer are
-faulted with get_user_pages().  The 'req->locked' flag indicates
-when the copy is taking place, and interruption is delayed until
-this flag is unset.
-
-Scenario 3 - Tricky deadlock with asynchronous read
----------------------------------------------------
-
-The same situation as above, except thread-1 will wait on page lock
-and hence it will be uninterruptible as well.  The solution is to
-abort the connection with forced umount (if mount is attached) or
-through the abort attribute in sysfs.
+This is solved with doing the copy atomically, and allowing abort
+while the page(s) belonging to the write buffer are faulted with
+get_user_pages().  The 'req->locked' flag indicates when the copy is
+taking place, and abort is delayed until this flag is unset.
