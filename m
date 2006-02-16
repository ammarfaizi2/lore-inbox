Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWBPNXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWBPNXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWBPNXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:23:50 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:56783 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161058AbWBPNXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:23:49 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix bug in aborted fuse_release_end()
Message-Id: <E1F9j6W-0003Wu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Feb 2006 14:23:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a rather theoretical case of the BUG triggering in
fuse_reset_request():

  - iget() fails because of OOM after a successful CREATE_OPEN request
  - during IO on the resulting RELEASE request the connection is aborted

Fix and add warning to fuse_reset_request().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-02-16 14:03:37.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-02-16 14:09:17.000000000 +0100
@@ -66,6 +66,12 @@ static void restore_sigs(sigset_t *oldse
 	sigprocmask(SIG_SETMASK, oldset, NULL);
 }
 
+/*
+ * Reset request, so that it can be reused
+ *
+ * The caller must be _very_ careful to make sure, that it is holding
+ * the only reference to req
+ */
 void fuse_reset_request(struct fuse_req *req)
 {
 	int preallocated = req->preallocated;
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-02-16 14:03:37.000000000 +0100
+++ linux/fs/fuse/file.c	2006-02-16 14:09:17.000000000 +0100
@@ -116,9 +116,14 @@ int fuse_open_common(struct inode *inode
 /* Special case for failed iget in CREATE */
 static void fuse_release_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	u64 nodeid = req->in.h.nodeid;
-	fuse_reset_request(req);
-	fuse_send_forget(fc, req, nodeid, 1);
+	/* If called from end_io_requests(), req has more than one
+	   reference and fuse_reset_request() cannot work */
+	if (fc->connected) {
+		u64 nodeid = req->in.h.nodeid;
+		fuse_reset_request(req);
+		fuse_send_forget(fc, req, nodeid, 1);
+	} else
+		fuse_put_request(fc, req);
 }
 
 void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
