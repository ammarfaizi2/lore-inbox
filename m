Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWADNUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWADNUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWADNTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:19:17 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:15754 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751782AbWADNTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:15 -0500
Message-Id: <20060104131841.129433000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:34 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] fuse: make maximum write data configurable
Content-Disposition: inline; filename=fuse_configurable_max_write.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the maximum size of write data configurable by the filesystem.
The previous fixed 4096 limit only worked on architectures where the
page size is less or equal to this.  This change make writing work on
other architectures too, and also lets the filesystem receive bigger
write requests in direct_io mode.

Normal writes which go through the page cache are still limited to a
page sized chunk per request.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-04 12:37:53.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-04 12:37:55.000000000 +0100
@@ -148,6 +148,26 @@ void fuse_release_background(struct fuse
 	spin_unlock(&fuse_lock);
 }
 
+static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
+{
+	int i;
+	struct fuse_init_out *arg = &req->misc.init_out;
+
+	if (arg->major != FUSE_KERNEL_VERSION)
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
+}
+
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was interrupted (and not yet sent) or some error
@@ -172,21 +192,9 @@ static void request_end(struct fuse_conn
 		up_read(&fc->sbput_sem);
 	}
 	wake_up(&req->waitq);
-	if (req->in.h.opcode == FUSE_INIT) {
-		int i;
-
-		if (req->misc.init_in_out.major != FUSE_KERNEL_VERSION)
-			fc->conn_error = 1;
-
-		fc->minor = req->misc.init_in_out.minor;
-
-		/* After INIT reply is received other requests can go
-		   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
-		   up()s on outstanding_sem.  The last up() is done in
-		   fuse_putback_request() */
-		for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
-			up(&fc->outstanding_sem);
-	} else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
+	if (req->in.h.opcode == FUSE_INIT)
+		process_init_reply(fc, req);
+	else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
 		/* Special case for failed iget in CREATE */
 		u64 nodeid = req->in.h.nodeid;
 		__fuse_get_request(req);
@@ -359,7 +367,7 @@ void fuse_send_init(struct fuse_conn *fc
 	/* This is called from fuse_read_super() so there's guaranteed
 	   to be a request available */
 	struct fuse_req *req = do_get_request(fc);
-	struct fuse_init_in_out *arg = &req->misc.init_in_out;
+	struct fuse_init_in *arg = &req->misc.init_in;
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
 	req->in.h.opcode = FUSE_INIT;
@@ -367,8 +375,12 @@ void fuse_send_init(struct fuse_conn *fc
 	req->in.args[0].size = sizeof(*arg);
 	req->in.args[0].value = arg;
 	req->out.numargs = 1;
-	req->out.args[0].size = sizeof(*arg);
-	req->out.args[0].value = arg;
+	/* Variable length arguement used for backward compatibility
+	   with interface version < 7.5.  Rest of init_out is zeroed
+	   by do_get_request(), so a short reply is not a problem */
+	req->out.argvar = 1;
+	req->out.args[0].size = sizeof(struct fuse_init_out);
+	req->out.args[0].value = &req->misc.init_out;
 	request_send_background(fc, req);
 }
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-04 12:37:53.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-04 12:37:55.000000000 +0100
@@ -21,9 +21,6 @@
 /** If more requests are outstanding, then the operation will block */
 #define FUSE_MAX_OUTSTANDING 10
 
-/** Maximum size of data in a write request */
-#define FUSE_MAX_WRITE 4096
-
 /** It could be as large as PATH_MAX, but would that have any uses? */
 #define FUSE_NAME_MAX 1024
 
@@ -162,7 +159,8 @@ struct fuse_req {
 	union {
 		struct fuse_forget_in forget_in;
 		struct fuse_release_in release_in;
-		struct fuse_init_in_out init_in_out;
+		struct fuse_init_in init_in;
+		struct fuse_init_out init_out;
 	} misc;
 
 	/** page vector */
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-04 12:37:53.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-04 12:37:55.000000000 +0100
@@ -485,7 +485,6 @@ static int fuse_fill_super(struct super_
 	fc->max_read = d.max_read;
 	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
-	fc->max_write = FUSE_MAX_WRITE;
 
 	err = -ENOMEM;
 	root = get_root_inode(sb, d.rootmode);
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-01-04 12:37:53.000000000 +0100
+++ linux/include/linux/fuse.h	2006-01-04 12:37:55.000000000 +0100
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 4
+#define FUSE_KERNEL_MINOR_VERSION 5
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -244,11 +244,18 @@ struct fuse_access_in {
 	__u32	padding;
 };
 
-struct fuse_init_in_out {
+struct fuse_init_in {
 	__u32	major;
 	__u32	minor;
 };
 
+struct fuse_init_out {
+	__u32	major;
+	__u32	minor;
+	__u32	unused[3];
+	__u32	max_write;
+};
+
 struct fuse_in_header {
 	__u32	len;
 	__u32	opcode;

--
