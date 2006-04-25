Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWDYIiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDYIiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDYIiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:38:17 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:9620 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751055AbWDYIiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:38:17 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 25 Apr 2006 10:35:13 +0200)
Subject: [PATCH 1/4] Revert "[fuse] fix deadlock between fuse_put_super() and request_end()"
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FYJ3b-0006UZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Apr 2006 10:38:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts 73ce8355c243a434524a34c05cc417dd0467996e commit.

---

 fs/fuse/dev.c    |   28 ++++++++++++----------------
 fs/fuse/fuse_i.h |   12 +++++++++---
 fs/fuse/inode.c  |   27 ++++++++++-----------------
 3 files changed, 31 insertions(+), 36 deletions(-)

2dc5efa3d0dd4f57db589c61ed9ed80fec9ac45b
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cc750c6..4967bd4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -128,14 +128,20 @@ void fuse_put_request(struct fuse_conn *
 	}
 }
 
-void fuse_remove_background(struct fuse_conn *fc, struct fuse_req *req)
+void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req)
 {
-	list_del_init(&req->bg_entry);
+	iput(req->inode);
+	iput(req->inode2);
+	if (req->file)
+		fput(req->file);
+	spin_lock(&fc->lock);
+	list_del(&req->bg_entry);
 	if (fc->num_background == FUSE_MAX_BACKGROUND) {
 		fc->blocked = 0;
 		wake_up_all(&fc->blocked_waitq);
 	}
 	fc->num_background--;
+	spin_unlock(&fc->lock);
 }
 
 /*
@@ -165,27 +171,17 @@ static void request_end(struct fuse_conn
 		wake_up(&req->waitq);
 		fuse_put_request(fc, req);
 	} else {
-		struct inode *inode = req->inode;
-		struct inode *inode2 = req->inode2;
-		struct file *file = req->file;
 		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 		req->end = NULL;
-		req->inode = NULL;
-		req->inode2 = NULL;
-		req->file = NULL;
-		if (!list_empty(&req->bg_entry))
-			fuse_remove_background(fc, req);
 		spin_unlock(&fc->lock);
-
+		down_read(&fc->sbput_sem);
+		if (fc->mounted)
+			fuse_release_background(fc, req);
+		up_read(&fc->sbput_sem);
 		if (end)
 			end(fc, req);
 		else
 			fuse_put_request(fc, req);
-
-		if (file)
-			fput(file);
-		iput(inode);
-		iput(inode2);
 	}
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 59661c4..0474202 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -258,9 +258,15 @@ struct fuse_conn {
 	/** waitq for blocked connection */
 	wait_queue_head_t blocked_waitq;
 
+	/** RW semaphore for exclusion with fuse_put_super() */
+	struct rw_semaphore sbput_sem;
+
 	/** The next unique request id */
 	u64 reqctr;
 
+	/** Mount is active */
+	unsigned mounted;
+
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
 	unsigned connected;
@@ -471,11 +477,11 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
- * Remove request from the the background list
+ * Release inodes and file associated with background request
  */
-void fuse_remove_background(struct fuse_conn *fc, struct fuse_req *req);
+void fuse_release_background(struct fuse_conn *fc, struct fuse_req *req);
 
-/** Abort all requests */
+/* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 43a6fc0..fd34037 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -204,26 +204,17 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
+	down_write(&fc->sbput_sem);
+	while (!list_empty(&fc->background))
+		fuse_release_background(fc,
+					list_entry(fc->background.next,
+						   struct fuse_req, bg_entry));
+
 	spin_lock(&fc->lock);
+	fc->mounted = 0;
 	fc->connected = 0;
-	while (!list_empty(&fc->background)) {
-		struct fuse_req *req = list_entry(fc->background.next,
-						  struct fuse_req, bg_entry);
-		struct inode *inode = req->inode;
-		struct inode *inode2 = req->inode2;
-
-		/* File would hold a reference to vfsmount */
-		BUG_ON(req->file);
-		req->inode = NULL;
-		req->inode2 = NULL;
-		fuse_remove_background(fc, req);
-
-		spin_unlock(&fc->lock);
-		iput(inode);
-		iput(inode2);
-		spin_lock(&fc->lock);
-	}
 	spin_unlock(&fc->lock);
+	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
@@ -395,6 +386,7 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
 		INIT_LIST_HEAD(&fc->background);
+		init_rwsem(&fc->sbput_sem);
 		kobj_set_kset_s(fc, connections_subsys);
 		kobject_init(&fc->kobj);
 		atomic_set(&fc->num_waiting, 0);
@@ -549,6 +541,7 @@ static int fuse_fill_super(struct super_
 		goto err_free_req;
 
 	sb->s_root = root_dentry;
+	fc->mounted = 1;
 	fc->connected = 1;
 	kobject_get(&fc->kobj);
 	file->private_data = fc;
-- 
1.2.4

