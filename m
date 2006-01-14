Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWANUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWANUPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWANUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:15:49 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:24772 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751055AbWANUPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:15:49 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix bitfield race
Message-Id: <E1Exro1-0002AX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 Jan 2006 21:15:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix race in setting bitfields of fuse_conn.  Spotted by Andrew Morton.

The two fields ->connected and ->mounted were always changed with the
fuse_lock held.  But other bitfields in the same structure were
changed without the lock.  In theory this could lead to losing the
assignment of even the ones under lock.  The chosen solution is to
change these two fields to be a full unsigned type.  The other
bitfields aren't "important" enough to warrant the extra complexity of
full locking or changing them to bitops.

For all bitfields document why they are safe wrt. concurrent
assignments.

Also make the initialization of the 'num_waiting' atomic counter
explicit.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-14 20:57:08.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 20:58:31.000000000 +0100
@@ -397,6 +397,7 @@ static struct fuse_conn *new_conn(void)
 		init_rwsem(&fc->sbput_sem);
 		kobj_set_kset_s(fc, connections_subsys);
 		kobject_init(&fc->kobj);
+		atomic_set(&fc->num_waiting, 0);
 		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
 			struct fuse_req *req = fuse_request_alloc();
 			if (!req) {
@@ -492,6 +493,7 @@ static void fuse_send_init(struct fuse_c
 	   to be exactly one request available */
 	struct fuse_req *req = fuse_get_request(fc);
 	struct fuse_init_in *arg = &req->misc.init_in;
+
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
 	req->in.h.opcode = FUSE_INIT;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 20:56:57.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 20:58:42.000000000 +0100
@@ -94,6 +94,11 @@ struct fuse_out {
 	/** Header returned from userspace */
 	struct fuse_out_header h;
 
+	/*
+	 * The following bitfields are not changed during the request
+	 * processing
+	 */
+
 	/** Last argument is variable length (can be shorter than
 	    arg->size) */
 	unsigned argvar:1;
@@ -136,6 +141,12 @@ struct fuse_req {
 	/** refcount */
 	atomic_t count;
 
+	/*
+	 * The following bitfields are either set once before the
+	 * request is queued or setting/clearing them is protected by
+	 * fuse_lock
+	 */
+
 	/** True if the request has reply */
 	unsigned isreply:1;
 
@@ -250,15 +261,22 @@ struct fuse_conn {
 	u64 reqctr;
 
 	/** Mount is active */
-	unsigned mounted : 1;
+	unsigned mounted;
 
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
-	unsigned connected : 1;
+	unsigned connected;
 
-	/** Connection failed (version mismatch) */
+	/** Connection failed (version mismatch).  Cannot race with
+	    setting other bitfields since it is only set once in INIT
+	    reply, before any other request, and never cleared */
 	unsigned conn_error : 1;
 
+	/*
+	 * The following bitfields are only for optimization purposes
+	 * and hence races in setting them will not cause malfunction
+	 */
+
 	/** Is fsync not implemented by fs? */
 	unsigned no_fsync : 1;
 

