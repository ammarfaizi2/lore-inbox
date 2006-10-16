Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWJPQ3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWJPQ3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWJPQ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:29:22 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:6043 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1422765AbWJPQ2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:48 -0400
Message-Id: <20061016162818.537073000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:21 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 12/12] fuse: add DESTROY operation
Content-Disposition: inline; filename=fuse_destroy_method.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DESTROY operation for block device based filesystems.  With the
help of this operation, such a filesystem can flush dirty data to the
device synchronously before the umount returns.

This is needed in situations where the filesystem is assumed to be
clean immediately after unmount (e.g. ejecting removable media).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-10-16 16:21:39.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-10-16 16:21:43.000000000 +0200
@@ -298,6 +298,9 @@ struct fuse_conn {
 	    reply, before any other request, and never cleared */
 	unsigned conn_error : 1;
 
+	/** Connection successful.  Only set in INIT */
+	unsigned conn_init : 1;
+
 	/** Do readpages asynchronously?  Only set in INIT */
 	unsigned async_read : 1;
 
@@ -368,6 +371,9 @@ struct fuse_conn {
 
 	/** Key for lock owner ID scrambling */
 	u32 scramble_key[4];
+
+	/** Reserved request for the DESTROY message */
+	struct fuse_req *destroy_req;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 16:21:38.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:21:43.000000000 +0200
@@ -206,10 +206,23 @@ static void fuse_umount_begin(struct vfs
 		fuse_abort_conn(get_fuse_conn_super(vfsmnt->mnt_sb));
 }
 
+static void fuse_send_destroy(struct fuse_conn *fc)
+{
+	struct fuse_req *req = fc->destroy_req;
+	if (req && fc->conn_init) {
+		fc->destroy_req = NULL;
+		req->in.h.opcode = FUSE_DESTROY;
+		req->force = 1;
+		request_send(fc, req);
+		fuse_put_request(fc, req);
+	}
+}
+
 static void fuse_put_super(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
+	fuse_send_destroy(fc);
 	spin_lock(&fc->lock);
 	fc->connected = 0;
 	fc->blocked = 0;
@@ -410,6 +423,8 @@ static struct fuse_conn *new_conn(void)
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (atomic_dec_and_test(&fc->count)) {
+		if (fc->destroy_req)
+			fuse_request_free(fc->destroy_req);
 		mutex_destroy(&fc->inst_mutex);
 		kfree(fc);
 	}
@@ -466,6 +481,7 @@ static void process_init_reply(struct fu
 		fc->bdi.ra_pages = min(fc->bdi.ra_pages, ra_pages);
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
+		fc->conn_init = 1;
 	}
 	fuse_put_request(fc, req);
 	fc->blocked = 0;
@@ -563,6 +579,12 @@ static int fuse_fill_super(struct super_
 	if (!init_req)
 		goto err_put_root;
 
+	if (is_bdev) {
+		fc->destroy_req = fuse_request_alloc();
+		if (!fc->destroy_req)
+			goto err_put_root;
+	}
+
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
 	if (file->private_data)
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-10-16 16:21:39.000000000 +0200
+++ linux/include/linux/fuse.h	2006-10-16 16:21:43.000000000 +0200
@@ -133,6 +133,7 @@ enum fuse_opcode {
 	FUSE_CREATE        = 35,
 	FUSE_INTERRUPT     = 36,
 	FUSE_BMAP          = 37,
+	FUSE_DESTROY       = 38,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */

--
