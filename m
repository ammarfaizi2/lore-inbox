Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVK1Tpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVK1Tpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVK1Tpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:45:49 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:42254 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932195AbVK1Tpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:45:49 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:43:18 +0100)
Subject: [PATCH 2/7] fuse: check for invalid node ID in fuse_create_open()
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:45:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for invalid node ID values in the new atomic create+open method.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-11-28 17:24:22.000000000 +0100
+++ linux/fs/fuse/dir.c	2005-11-28 17:24:26.000000000 +0100
@@ -87,6 +87,11 @@ static int dir_alias(struct inode *inode
 	return 0;
 }
 
+static inline int invalid_nodeid(u64 nodeid)
+{
+	return !nodeid || nodeid == FUSE_ROOT_ID;
+}
+
 static struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 };
@@ -110,7 +115,7 @@ static int fuse_lookup_iget(struct inode
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err && (!outarg.nodeid || outarg.nodeid == FUSE_ROOT_ID))
+	if (!err && invalid_nodeid(outarg.nodeid))
 		err = -EIO;
 	if (!err) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
@@ -206,7 +211,7 @@ static int fuse_create_open(struct inode
 	}
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode))
+	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid))
 		goto out_free_ff;
 
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
@@ -263,7 +268,7 @@ static int create_new_entry(struct fuse_
 		fuse_put_request(fc, req);
 		return err;
 	}
-	if (!outarg.nodeid || outarg.nodeid == FUSE_ROOT_ID) {
+	if (invalid_nodeid(outarg.nodeid)) {
 		fuse_put_request(fc, req);
 		return -EIO;
 	}
