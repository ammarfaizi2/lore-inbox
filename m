Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVCaVDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVCaVDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCaVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:03:39 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:5043 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261776AbVCaVCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:02:16 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: 3/3 ABI version change
Message-Id: <E1DH6nk-00017T-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 23:02:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change ABI major version from 5 to 6, and check if userspace supports
the new interface.  If the version in INIT reply doesn't match the
current one, return ECONNREFUSED error on all operations.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc1-mm4/fs/fuse/dev.c	2005-03-31 21:43:42.000000000 +0200
+++ linux-fuse/fs/fuse/dev.c	2005-03-31 21:50:31.000000000 +0200
@@ -183,6 +183,10 @@ static void request_end(struct fuse_conn
 	wake_up(&req->waitq);
 	if (req->in.h.opcode == FUSE_INIT) {
 		int i;
+
+		if (req->misc.init_in_out.major != FUSE_KERNEL_VERSION)
+			fc->conn_error = 1;
+
 		/* After INIT reply is received other requests can go
 		   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
 		   up()s on outstanding_sem.  The last up() is done in
@@ -329,8 +333,11 @@ static void request_send_wait(struct fus
 {
 	req->isreply = 1;
 	spin_lock(&fuse_lock);
-	req->out.h.error = -ENOTCONN;
-	if (fc->file) {
+	if (!fc->file)
+		req->out.h.error = -ENOTCONN;
+	else if (fc->conn_error)
+		req->out.h.error = -ECONNREFUSED;
+	else {
 		queue_request(fc, req);
 		/* acquire extra reference, since request is still needed
 		   after request_end() */
diff -rup linux-2.6.12-rc1-mm4/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc1-mm4/fs/fuse/fuse_i.h	2005-03-31 21:43:42.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-03-31 21:50:31.000000000 +0200
@@ -261,6 +261,9 @@ struct fuse_conn {
 	/** Is removexattr not implemented by fs? */
 	unsigned no_removexattr : 1;
 
+	/** Connection failed (version mismatch) */
+	unsigned conn_error : 1;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
diff -rup linux-2.6.12-rc1-mm4/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.12-rc1-mm4/include/linux/fuse.h	2005-03-31 21:50:44.000000000 +0200
+++ linux-fuse/include/linux/fuse.h	2005-03-31 21:50:31.000000000 +0200
@@ -11,7 +11,7 @@
 #include <asm/types.h>
 
 /** Version number of this interface */
-#define FUSE_KERNEL_VERSION 5
+#define FUSE_KERNEL_VERSION 6
 
 /** Minor version number of this interface */
 #define FUSE_KERNEL_MINOR_VERSION 1

