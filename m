Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWBCKSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWBCKSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBCKSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:18:40 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:4253 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751120AbWBCKSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:18:40 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix request_end() fuse_reset_request() race
Message-Id: <E1F4y16-00044o-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 03 Feb 2006 11:18:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last fix for this function in fact opened up a much more often
triggering race.

It was uncommented tricky code, that was buggy.  Add comment, make it
less tricky and fix bug.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

diff -ru linux/fs/fuse/dev.c ../t/linux-fuse/fs/fuse/dev.c
--- linux/fs/fuse/dev.c	2006-02-02 17:42:38.000000000 +0100
+++ ../t/linux-fuse/fs/fuse/dev.c	2006-02-02 17:42:28.000000000 +0100
@@ -120,9 +120,9 @@
 	return do_get_request(fc);
 }
 
+/* Must be called with fuse_lock held */
 static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
 {
-	spin_lock(&fuse_lock);
 	if (req->preallocated) {
 		atomic_dec(&fc->num_waiting);
 		list_add(&req->list, &fc->unused_list);
@@ -134,11 +134,19 @@
 		fc->outstanding_debt--;
 	else
 		up(&fc->outstanding_sem);
-	spin_unlock(&fuse_lock);
 }
 
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 {
+	if (atomic_dec_and_test(&req->count)) {
+		spin_lock(&fuse_lock);
+		fuse_putback_request(fc, req);
+		spin_unlock(&fuse_lock);
+	}
+}
+
+static void fuse_put_request_locked(struct fuse_conn *fc, struct fuse_req *req)
+{
 	if (atomic_dec_and_test(&req->count))
 		fuse_putback_request(fc, req);
 }
@@ -162,27 +170,37 @@
  * stored objects are released.  The requester thread is woken up (if
  * still waiting), the 'end' callback is called if given, else the
  * reference to the request is released
+ * 
+ * Releasing extra reference for foreground requests must be done
+ * within the same locked region as setting state to finished.  This
+ * is because fuse_reset_request() may be called after request is
+ * finished and it must be the sole possessor.  If request is
+ * interrupted and put in the background, it will return with an error
+ * and hence never be reset and reused.
  *
  * Called with fuse_lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
-	req->end = NULL;
 	list_del(&req->list);
 	req->state = FUSE_REQ_FINISHED;
-	spin_unlock(&fuse_lock);
-	if (req->background) {
+	if (!req->background) {
+		wake_up(&req->waitq);
+		fuse_put_request_locked(fc, req);
+		spin_unlock(&fuse_lock);
+	} else {
+		void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
+		req->end = NULL;
+		spin_unlock(&fuse_lock);
 		down_read(&fc->sbput_sem);
 		if (fc->mounted)
 			fuse_release_background(req);
 		up_read(&fc->sbput_sem);
+		if (end)
+			end(fc, req);
+		else
+			fuse_put_request(fc, req);
 	}
-	wake_up(&req->waitq);
-	if (end)
-		end(fc, req);
-	else
-		fuse_put_request(fc, req);
 }
 
 /*
