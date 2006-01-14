Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945924AbWANAm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWANAm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945917AbWANAmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:13 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:18862 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945916AbWANAl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:58 -0500
Message-Id: <20060114004114.241169000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:59 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] fuse: add number of waiting requests attribute
Content-Disposition: inline; filename=fuse_num_waiting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 'waiting' attribute which indicates how many
filesystem requests are currently waiting to be completed.  A non-zero
value without any filesystem activity indicates a hung or deadlocked
filesystem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-14 00:22:44.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 00:33:16.000000000 +0100
@@ -555,7 +555,16 @@ static struct file_system_type fuse_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
+static ssize_t fuse_conn_waiting_show(struct fuse_conn *fc, char *page)
+{
+	return sprintf(page, "%i\n", atomic_read(&fc->num_waiting));
+}
+
+static struct fuse_conn_attr fuse_conn_waiting =
+	__ATTR(waiting, 0400, fuse_conn_waiting_show, NULL);
+
 static struct attribute *fuse_conn_attrs[] = {
+	&fuse_conn_waiting.attr,
 	NULL,
 };
 
Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-14 00:22:44.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:23:16.000000000 +0100
@@ -109,18 +109,24 @@ struct fuse_req *fuse_get_request(struct
 	int intr;
 	sigset_t oldset;
 
+	atomic_inc(&fc->num_waiting);
 	block_sigs(&oldset);
 	intr = down_interruptible(&fc->outstanding_sem);
 	restore_sigs(&oldset);
-	return intr ? NULL : do_get_request(fc);
+	if (intr) {
+		atomic_dec(&fc->num_waiting);
+		return NULL;
+	} 
+	return do_get_request(fc);
 }
 
 static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fuse_lock);
-	if (req->preallocated)
+	if (req->preallocated) {
+		atomic_dec(&fc->num_waiting);
 		list_add(&req->list, &fc->unused_list);
-	else
+	} else
 		fuse_request_free(req);
 
 	/* If we are in debt decrease that first */
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:22:44.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:23:16.000000000 +0100
@@ -280,6 +280,9 @@ struct fuse_conn {
 	/** Is create not implemented by fs? */
 	unsigned no_create : 1;
 
+	/** The number of requests waiting for completion */
+	atomic_t num_waiting;
+
 	/** Negotiated minor version */
 	unsigned minor;
 

--
