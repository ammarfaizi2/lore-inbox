Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDKTm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDKTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDKTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:42:57 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:15308 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750830AbWDKTm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:42:57 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [git patch] fuse fixes
Message-Id: <E1FTOks-0002uc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Apr 2006 21:42:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from 'for-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/mszeredi/fuse.git

to receive the following updates:

 fs/fuse/dev.c    |   54 +++++++++++++++++++++++++++++++++++-------------------
 fs/fuse/file.c   |   10 +++++++---
 fs/fuse/fuse_i.h |   15 ++++++---------
 fs/fuse/inode.c  |   27 +++++++++++++++++----------
 4 files changed, 65 insertions(+), 41 deletions(-)

Miklos Szeredi:
      [fuse] fix deadlock between fuse_put_super() and request_end()
      [fuse] Fix accounting the number of waiting requests
      [fuse] Don't init request twice
      [fuse] Direct I/O  should not use fuse_reset_request

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6c740f8..cc750c6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -92,48 +92,50 @@ struct fuse_req *fuse_get_req(struct fus
 {
 	struct fuse_req *req;
 	sigset_t oldset;
+	int intr;
 	int err;
 
+	atomic_inc(&fc->num_waiting);
 	block_sigs(&oldset);
-	err = wait_event_interruptible(fc->blocked_waitq, !fc->blocked);
+	intr = wait_event_interruptible(fc->blocked_waitq, !fc->blocked);
 	restore_sigs(&oldset);
-	if (err)
-		return ERR_PTR(-EINTR);
+	err = -EINTR;
+	if (intr)
+		goto out;
 
 	req = fuse_request_alloc();
+	err = -ENOMEM;
 	if (!req)
-		return ERR_PTR(-ENOMEM);
+		goto out;
 
-	atomic_inc(&fc->num_waiting);
-	fuse_request_init(req);
 	req->in.h.uid = current->fsuid;
 	req->in.h.gid = current->fsgid;
 	req->in.h.pid = current->pid;
+	req->waiting = 1;
 	return req;
+
+ out:
+	atomic_dec(&fc->num_waiting);
+	return ERR_PTR(err);
 }
 
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (atomic_dec_and_test(&req->count)) {
-		atomic_dec(&fc->num_waiting);
+		if (req->waiting)
+			atomic_dec(&fc->num_waiting);
 		fuse_request_free(req);
 	}
 }
 
-void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
+void fuse_remove_background(struct fuse_conn *fc, struct fuse_req *req)
 {
-	iput(req->inode);
-	iput(req->inode2);
-	if (req->file)
-		fput(req->file);
-	spin_lock(&fc->lock);
-	list_del(&req->bg_entry);
+	list_del_init(&req->bg_entry);
 	if (fc->num_background == FUSE_MAX_BACKGROUND) {
 		fc->blocked = 0;
 		wake_up_all(&fc->blocked_waitq);
 	}
 	fc->num_background--;
-	spin_unlock(&fc->lock);
 }
 
 /*
@@ -163,17 +165,27 @@ static void request_end(struct fuse_conn
 		wake_up(&req->waitq);
 		fuse_put_request(fc, req);
 	} else {
+		struct inode *inode = req->inode;
+		struct inode *inode2 = req->inode2;
+		struct file *file = req->file;
 		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 		req->end = NULL;
+		req->inode = NULL;
+		req->inode2 = NULL;
+		req->file = NULL;
+		if (!list_empty(&req->bg_entry))
+			fuse_remove_background(fc, req);
 		spin_unlock(&fc->lock);
-		down_read(&fc->sbput_sem);
-		if (fc->mounted)
-			fuse_release_background(fc, req);
-		up_read(&fc->sbput_sem);
+
 		if (end)
 			end(fc, req);
 		else
 			fuse_put_request(fc, req);
+
+		if (file)
+			fput(file);
+		iput(inode);
+		iput(inode2);
 	}
 }
 
@@ -277,6 +289,10 @@ static void queue_request(struct fuse_co
 		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fc->pending);
 	req->state = FUSE_REQ_PENDING;
+	if (!req->waiting) {
+		req->waiting = 1;
+		atomic_inc(&fc->num_waiting);
+	}
 	wake_up(&fc->waitq);
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e4f041a..fc342cf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -565,8 +565,12 @@ static ssize_t fuse_direct_io(struct fil
 		buf += nres;
 		if (nres != nbytes)
 			break;
-		if (count)
-			fuse_reset_request(req);
+		if (count) {
+			fuse_put_request(fc, req);
+			req = fuse_get_req(fc);
+			if (IS_ERR(req))
+				break;
+		}
 	}
 	fuse_put_request(fc, req);
 	if (res > 0) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 19c7185..59661c4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -159,6 +159,9 @@ struct fuse_req {
 	/** Data is being copied to/from the request */
 	unsigned locked:1;
 
+	/** Request is counted as "waiting" */
+	unsigned waiting:1;
+
 	/** State of the request */
 	enum fuse_req_state state;
 
@@ -255,15 +258,9 @@ struct fuse_conn {
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
@@ -474,11 +471,11 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
- * Release inodes and file associated with background request
+ * Remove request from the the background list
  */
-void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req);
+void fuse_remove_background(struct fuse_conn *fc, struct fuse_req *req);
 
-/* Abort all requests */
+/** Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd34037..43a6fc0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -204,17 +204,26 @@ static void fuse_put_super(struct super_
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
+	while (!list_empty(&fc->background)) {
+		struct fuse_req *req = list_entry(fc->background.next,
+						  struct fuse_req, bg_entry);
+		struct inode *inode = req->inode;
+		struct inode *inode2 = req->inode2;
+
+		/* File would hold a reference to vfsmount */
+		BUG_ON(req->file);
+		req->inode = NULL;
+		req->inode2 = NULL;
+		fuse_remove_background(fc, req);
+
+		spin_unlock(&fc->lock);
+		iput(inode);
+		iput(inode2);
+		spin_lock(&fc->lock);
+	}
 	spin_unlock(&fc->lock);
-	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
@@ -386,7 +395,6 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
 		INIT_LIST_HEAD(&fc->background);
-		init_rwsem(&fc->sbput_sem);
 		kobj_set_kset_s(fc, connections_subsys);
 		kobject_init(&fc->kobj);
 		atomic_set(&fc->num_waiting, 0);
@@ -541,7 +549,6 @@ static int fuse_fill_super(struct super_
 		goto err_free_req;
 
 	sb->s_root = root_dentry;
-	fc->mounted = 1;
 	fc->connected = 1;
 	kobject_get(&fc->kobj);
 	file->private_data = fc;
