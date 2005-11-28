Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVK1TuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVK1TuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVK1TuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:50:23 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:18437 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932213AbVK1TuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:50:22 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:49:01 +0100)
Subject: [PATCH 6/7] fuse: add frsize to statfs reply
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu> <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu> <E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu> <E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1Egp0p-0006vL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:50:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'frsize' member to the statfs reply.

I'm not sure if sending f_fsid will ever be needed, but just in case
leave some space at the end of the structure, so less compatibility
mess would be required.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2005-11-28 14:01:07.000000000 +0100
+++ linux/fs/fuse/inode.c	2005-11-28 16:45:12.000000000 +0100
@@ -218,6 +218,7 @@ static void convert_fuse_statfs(struct k
 {
 	stbuf->f_type    = FUSE_SUPER_MAGIC;
 	stbuf->f_bsize   = attr->bsize;
+	stbuf->f_frsize  = attr->frsize;
 	stbuf->f_blocks  = attr->blocks;
 	stbuf->f_bfree   = attr->bfree;
 	stbuf->f_bavail  = attr->bavail;
@@ -238,10 +239,12 @@ static int fuse_statfs(struct super_bloc
 	if (!req)
 		return -EINTR;
 
+	memset(&outarg, 0, sizeof(outarg));
 	req->in.numargs = 0;
 	req->in.h.opcode = FUSE_STATFS;
 	req->out.numargs = 1;
-	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].size =
+		fc->minor < 4 ? FUSE_COMPAT_STATFS_SIZE : sizeof(outarg);
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-11-28 14:02:09.000000000 +0100
+++ linux/include/linux/fuse.h	2005-11-28 15:25:14.000000000 +0100
@@ -53,6 +53,9 @@ struct fuse_kstatfs {
 	__u64	ffree;
 	__u32	bsize;
 	__u32	namelen;
+	__u32	frsize;
+	__u32	padding;
+	__u32	spare[6];
 };
 
 #define FATTR_MODE	(1 << 0)
@@ -213,6 +216,8 @@ struct fuse_write_out {
 	__u32	padding;
 };
 
+#define FUSE_COMPAT_STATFS_SIZE 48
+
 struct fuse_statfs_out {
 	struct fuse_kstatfs st;
 };
