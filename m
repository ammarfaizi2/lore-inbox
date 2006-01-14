Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423244AbWANAlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423244AbWANAlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423248AbWANAlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:11 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:14510 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423244AbWANAlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:05 -0500
Message-Id: <20060114004033.548624000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:51 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] fuse: fix request_end()
Content-Disposition: inline; filename=fuse_fix_request_end.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function used the request object after decrementing it's
reference count and releasing the lock.  This could in theory lead to
all sorts of problems.

Fix and simplify at the same time.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 22:51:43.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 22:51:48.000000000 +0100
@@ -171,19 +171,17 @@ static void process_init_reply(struct fu
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was interrupted (and not yet sent) or some error
- * occurred during communication with userspace, or the device file was
- * closed.  It decreases the reference count for the request.  In case
- * of a background request the reference to the stored objects are
- * released.  The requester thread is woken up (if still waiting), and
- * finally the request is either freed or put on the unused_list
+ * occurred during communication with userspace, or the device file
+ * was closed.  In case of a background request the reference to the
+ * stored objects are released.  The requester thread is woken up (if
+ * still waiting), and finally the reference to the request is
+ * released
  *
  * Called with fuse_lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	int putback;
 	req->finished = 1;
-	putback = atomic_dec_and_test(&req->count);
 	spin_unlock(&fuse_lock);
 	if (req->background) {
 		down_read(&fc->sbput_sem);
@@ -197,13 +195,11 @@ static void request_end(struct fuse_conn
 	else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
 		/* Special case for failed iget in CREATE */
 		u64 nodeid = req->in.h.nodeid;
-		__fuse_get_request(req);
 		fuse_reset_request(req);
 		fuse_send_forget(fc, req, nodeid, 1);
-		putback = 0;
+		return;
 	}
-	if (putback)
-		fuse_putback_request(fc, req);
+	fuse_put_request(fc, req);
 }
 
 /*

--
