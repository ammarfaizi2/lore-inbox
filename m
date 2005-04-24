Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVDXPVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVDXPVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVDXPVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:21:10 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:39832 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262336AbVDXPUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:20:42 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: reference counting fix
Message-Id: <E1DPity-0000Mj-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:20:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an Oops which was caused by premature release of the
fuse_conn object.  It does this by introducing reference counting for
this object, instead of using the ->file and ->sb members.  Since
->file and ->sb are never actually dereferenced, these are replaced by
->connected and ->mounted bool members.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc2-mm3/fs/fuse/dev.c	2005-04-22 15:37:21.000000000 +0200
+++ linux-fuse/fs/fuse/dev.c	2005-04-22 15:50:32.000000000 +0200
@@ -24,7 +24,7 @@ static inline struct fuse_conn *fuse_get
 	struct fuse_conn *fc;
 	spin_lock(&fuse_lock);
 	fc = file->private_data;
-	if (fc && !fc->sb)
+	if (fc && !fc->mounted)
 		fc = NULL;
 	spin_unlock(&fuse_lock);
 	return fc;
@@ -176,7 +176,7 @@ static void request_end(struct fuse_conn
 	spin_unlock(&fuse_lock);
 	if (req->background) {
 		down_read(&fc->sbput_sem);
-		if (fc->sb)
+		if (fc->mounted)
 			fuse_release_background(req);
 		up_read(&fc->sbput_sem);
 	}
@@ -333,7 +333,7 @@ static void request_send_wait(struct fus
 {
 	req->isreply = 1;
 	spin_lock(&fuse_lock);
-	if (!fc->file)
+	if (!fc->connected)
 		req->out.h.error = -ENOTCONN;
 	else if (fc->conn_error)
 		req->out.h.error = -ECONNREFUSED;
@@ -366,7 +366,7 @@ void request_send_nonint(struct fuse_con
 static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fuse_lock);
-	if (fc->file) {
+	if (fc->connected) {
 		queue_request(fc, req);
 		spin_unlock(&fuse_lock);
 	} else {
@@ -621,7 +621,7 @@ static void request_wait(struct fuse_con
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&fc->waitq, &wait);
-	while (fc->sb && list_empty(&fc->pending)) {
+	while (fc->mounted && list_empty(&fc->pending)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current))
 			break;
@@ -660,7 +660,7 @@ static ssize_t fuse_dev_readv(struct fil
 		goto err_unlock;
 	request_wait(fc);
 	err = -ENODEV;
-	if (!fc->sb)
+	if (!fc->mounted)
 		goto err_unlock;
 	err = -ERESTARTSYS;
 	if (list_empty(&fc->pending))
@@ -868,7 +868,7 @@ static int fuse_dev_release(struct inode
 	spin_lock(&fuse_lock);
 	fc = file->private_data;
 	if (fc) {
-		fc->file = NULL;
+		fc->connected = 0;
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
 		fuse_release_conn(fc);
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h	2005-04-22 15:49:29.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-04-22 15:50:32.000000000 +0200
@@ -192,11 +192,8 @@ struct fuse_req {
  * unmounted.
  */
 struct fuse_conn {
-	/** The superblock of the mounted filesystem */
-	struct super_block *sb;
-
-	/** The opened client device */
-	struct file *file;
+	/** Reference count */
+	int count;
 
 	/** The user id for this mount */
 	uid_t user_id;
@@ -239,6 +236,12 @@ struct fuse_conn {
 	/** The next unique request id */
 	int reqctr;
 
+	/** Mount is active */
+	unsigned mounted : 1;
+
+	/** Connection established */
+	unsigned connected : 1;
+
 	/** Connection failed (version mismatch) */
 	unsigned conn_error : 1;
 
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.12-rc2-mm3/fs/fuse/inode.c	2005-04-22 15:49:29.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-04-22 15:50:32.000000000 +0200
@@ -84,8 +84,8 @@ void fuse_send_forget(struct fuse_conn *
 
 static void fuse_clear_inode(struct inode *inode)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
-	if (fc && (inode->i_sb->s_flags & MS_ACTIVE)) {
+	if (inode->i_sb->s_flags & MS_ACTIVE) {
+		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
 		fuse_send_forget(fc, fi->forget_req, fi->nodeid, inode->i_version);
 		fi->forget_req = NULL;
@@ -194,14 +194,13 @@ static void fuse_put_super(struct super_
 						   struct fuse_req, bg_entry));
 
 	spin_lock(&fuse_lock);
-	fc->sb = NULL;
+	fc->mounted = 0;
 	fc->user_id = 0;
 	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
 	up_write(&fc->sbput_sem);
 	fuse_release_conn(fc);
-	*get_fuse_conn_super_p(sb) = NULL;
 	spin_unlock(&fuse_lock);
 }
 
@@ -364,7 +363,8 @@ static void free_conn(struct fuse_conn *
 /* Must be called with the fuse lock held */
 void fuse_release_conn(struct fuse_conn *fc)
 {
-	if (!fc->sb && !fc->file)
+	fc->count--;
+	if (!fc->count)
 		free_conn(fc);
 }
 
@@ -376,10 +376,6 @@ static struct fuse_conn *new_conn(void)
 	if (fc != NULL) {
 		int i;
 		memset(fc, 0, sizeof(*fc));
-		fc->sb = NULL;
-		fc->file = NULL;
-		fc->flags = 0;
-		fc->user_id = 0;
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
@@ -417,8 +413,10 @@ static struct fuse_conn *get_conn(struct
 		fc = ERR_PTR(-EINVAL);
 	} else {
 		file->private_data = fc;
-		fc->sb = sb;
-		fc->file = file;
+		*get_fuse_conn_super_p(sb) = fc;
+		fc->mounted = 1;
+		fc->connected = 1;
+		fc->count = 2;
 	}
 	spin_unlock(&fuse_lock);
 	return fc;
@@ -539,8 +537,6 @@ static int fuse_fill_super(struct super_
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
 	fc->max_write = FUSE_MAX_IN / 2;
 
-	*get_fuse_conn_super_p(sb) = fc;
-
 	err = -ENOMEM;
 	root = get_root_inode(sb, d.rootmode);
 	if (root == NULL)
@@ -556,10 +552,8 @@ static int fuse_fill_super(struct super_
 
  err:
 	spin_lock(&fuse_lock);
-	fc->sb = NULL;
 	fuse_release_conn(fc);
 	spin_unlock(&fuse_lock);
-	*get_fuse_conn_super_p(sb) = NULL;
 	return err;
 }
 
