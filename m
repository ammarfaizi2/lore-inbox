Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945913AbWANAm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWANAm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945917AbWANAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:32 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:20398 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945913AbWANAmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:14 -0500
Message-Id: <20060114004132.683704000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:02 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] fuse: move INIT handling to inode.c
Content-Disposition: inline; filename=fuse_send_init_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now the INIT requests can be completely handled in inode.c and the
fuse_send_init() function need not be global any more.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-14 00:43:41.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:45:13.000000000 +0100
@@ -154,28 +154,6 @@ void fuse_release_background(struct fuse
 	spin_unlock(&fuse_lock);
 }
 
-static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
-{
-	int i;
-	struct fuse_init_out *arg = &req->misc.init_out;
-
-	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
-		fc->conn_error = 1;
-	else {
-		fc->minor = arg->minor;
-		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
-	}
-
-	/* After INIT reply is received other requests can go
-	   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
-	   up()s on outstanding_sem.  The last up() is done in
-	   fuse_putback_request() */
-	for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
-		up(&fc->outstanding_sem);
-
-	fuse_put_request(fc, req);
-}
-
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was interrupted (and not yet sent) or some error
@@ -366,29 +344,6 @@ void request_send_background(struct fuse
 	request_send_nowait(fc, req);
 }
 
-void fuse_send_init(struct fuse_conn *fc)
-{
-	/* This is called from fuse_read_super() so there's guaranteed
-	   to be exactly one request available */
-	struct fuse_req *req = fuse_get_request(fc);
-	struct fuse_init_in *arg = &req->misc.init_in;
-	arg->major = FUSE_KERNEL_VERSION;
-	arg->minor = FUSE_KERNEL_MINOR_VERSION;
-	req->in.h.opcode = FUSE_INIT;
-	req->in.numargs = 1;
-	req->in.args[0].size = sizeof(*arg);
-	req->in.args[0].value = arg;
-	req->out.numargs = 1;
-	/* Variable length arguement used for backward compatibility
-	   with interface version < 7.5.  Rest of init_out is zeroed
-	   by do_get_request(), so a short reply is not a problem */
-	req->out.argvar = 1;
-	req->out.args[0].size = sizeof(struct fuse_init_out);
-	req->out.args[0].value = &req->misc.init_out;
-	req->end = process_init_reply;
-	request_send_background(fc, req);
-}
-
 /*
  * Lock the request.  Up to the next unlock_request() there mustn't be
  * anything that could cause a page-fault.  If the request was already
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:43:41.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:45:13.000000000 +0100
@@ -480,8 +480,3 @@ int fuse_do_getattr(struct inode *inode)
  * Invalidate inode attributes
  */
 void fuse_invalidate_attr(struct inode *inode);
-
-/**
- * Send the INIT message
- */
-void fuse_send_init(struct fuse_conn *fc);
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-14 00:41:33.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 00:45:13.000000000 +0100
@@ -464,6 +464,51 @@ static struct super_operations fuse_supe
 	.show_options	= fuse_show_options,
 };
 
+static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
+{
+	int i;
+	struct fuse_init_out *arg = &req->misc.init_out;
+
+	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
+		fc->conn_error = 1;
+	else {
+		fc->minor = arg->minor;
+		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
+	}
+
+	/* After INIT reply is received other requests can go
+	   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
+	   up()s on outstanding_sem.  The last up() is done in
+	   fuse_putback_request() */
+	for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
+		up(&fc->outstanding_sem);
+
+	fuse_put_request(fc, req);
+}
+
+static void fuse_send_init(struct fuse_conn *fc)
+{
+	/* This is called from fuse_read_super() so there's guaranteed
+	   to be exactly one request available */
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_init_in *arg = &req->misc.init_in;
+	arg->major = FUSE_KERNEL_VERSION;
+	arg->minor = FUSE_KERNEL_MINOR_VERSION;
+	req->in.h.opcode = FUSE_INIT;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(*arg);
+	req->in.args[0].value = arg;
+	req->out.numargs = 1;
+	/* Variable length arguement used for backward compatibility
+	   with interface version < 7.5.  Rest of init_out is zeroed
+	   by do_get_request(), so a short reply is not a problem */
+	req->out.argvar = 1;
+	req->out.args[0].size = sizeof(struct fuse_init_out);
+	req->out.args[0].value = &req->misc.init_out;
+	req->end = process_init_reply;
+	request_send_background(fc, req);
+}
+
 static unsigned long long conn_id(void)
 {
 	static unsigned long long ctr = 1;

--
