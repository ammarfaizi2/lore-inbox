Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWANAlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWANAlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbWANAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:49 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:17582 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945909AbWANAlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:42 -0500
Message-Id: <20060114004102.778741000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:57 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] fuse: extend semantics of connected flag
Content-Disposition: inline; filename=fuse_connected.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ->connected flag for a fuse_conn object previously only indicated
whether the device file for this connection is currently open or not.

Change it's meaning so that it indicates whether the connection is
active or not: now either umount or device release will clear the
flag.

The separate ->mounted flag is still needed for handling background
requests.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 23:52:20.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:12:49.000000000 +0100
@@ -26,7 +26,7 @@ static struct fuse_conn *fuse_get_conn(s
 	struct fuse_conn *fc;
 	spin_lock(&fuse_lock);
 	fc = file->private_data;
-	if (fc && !fc->mounted)
+	if (fc && !fc->connected)
 		fc = NULL;
 	spin_unlock(&fuse_lock);
 	return fc;
@@ -594,7 +594,7 @@ static void request_wait(struct fuse_con
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue_exclusive(&fc->waitq, &wait);
-	while (fc->mounted && list_empty(&fc->pending)) {
+	while (fc->connected && list_empty(&fc->pending)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current))
 			break;
@@ -634,7 +634,7 @@ static ssize_t fuse_dev_readv(struct fil
 		goto err_unlock;
 	request_wait(fc);
 	err = -ENODEV;
-	if (!fc->mounted)
+	if (!fc->connected)
 		goto err_unlock;
 	err = -ERESTARTSYS;
 	if (list_empty(&fc->pending))
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-13 23:52:20.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:13:21.000000000 +0100
@@ -249,7 +249,8 @@ struct fuse_conn {
 	/** Mount is active */
 	unsigned mounted : 1;
 
-	/** Connection established */
+	/** Connection established, cleared on umount and device
+	    release */
 	unsigned connected : 1;
 
 	/** Connection failed (version mismatch) */
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-13 23:52:20.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 00:12:49.000000000 +0100
@@ -200,6 +200,7 @@ static void fuse_put_super(struct super_
 
 	spin_lock(&fuse_lock);
 	fc->mounted = 0;
+	fc->connected = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
 	up_write(&fc->sbput_sem);

--
