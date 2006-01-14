Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945904AbWANAlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbWANAlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945902AbWANAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:30 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:16046 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423250AbWANAl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:27 -0500
Message-Id: <20060114004048.517453000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:54 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] fuse: miscellaneous cleanup
Content-Disposition: inline; filename=fuse_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - remove some unneeded assignments

 - use kzalloc instead of kmalloc + memset

 - simplify setting sb->s_fs_info

 - in fuse_send_init() use fuse_get_request() instead of
   do_get_request() helper

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-13 23:12:58.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-13 23:40:48.000000000 +0100
@@ -200,9 +200,6 @@ static void fuse_put_super(struct super_
 
 	spin_lock(&fuse_lock);
 	fc->mounted = 0;
-	fc->user_id = 0;
-	fc->group_id = 0;
-	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
 	up_write(&fc->sbput_sem);
@@ -379,16 +376,15 @@ static struct fuse_conn *new_conn(void)
 {
 	struct fuse_conn *fc;
 
-	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
+	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc != NULL) {
 		int i;
-		memset(fc, 0, sizeof(*fc));
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->unused_list);
 		INIT_LIST_HEAD(&fc->background);
-		sema_init(&fc->outstanding_sem, 0);
+		sema_init(&fc->outstanding_sem, 1); /* One for INIT */
 		init_rwsem(&fc->sbput_sem);
 		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
 			struct fuse_req *req = fuse_request_alloc();
@@ -420,7 +416,7 @@ static struct fuse_conn *get_conn(struct
 		fc = ERR_PTR(-EINVAL);
 	} else {
 		file->private_data = fc;
-		*get_fuse_conn_super_p(sb) = fc;
+		sb->s_fs_info = fc;
 		fc->mounted = 1;
 		fc->connected = 1;
 		fc->count = 2;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-13 23:12:57.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-13 23:40:18.000000000 +0100
@@ -280,14 +280,9 @@ struct fuse_conn {
 	struct backing_dev_info bdi;
 };
 
-static inline struct fuse_conn **get_fuse_conn_super_p(struct super_block *sb)
-{
-	return (struct fuse_conn **) &sb->s_fs_info;
-}
-
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
 {
-	return *get_fuse_conn_super_p(sb);
+	return (struct fuse_conn *) sb->s_fs_info;
 }
 
 static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 23:40:09.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 23:40:18.000000000 +0100
@@ -361,8 +361,8 @@ void request_send_background(struct fuse
 void fuse_send_init(struct fuse_conn *fc)
 {
 	/* This is called from fuse_read_super() so there's guaranteed
-	   to be a request available */
-	struct fuse_req *req = do_get_request(fc);
+	   to be exactly one request available */
+	struct fuse_req *req = fuse_get_request(fc);
 	struct fuse_init_in *arg = &req->misc.init_in;
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;

--
