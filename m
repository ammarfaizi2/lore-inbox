Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWKTJ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWKTJ6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWKTJ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:58:08 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:33499 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S965326AbWKTJ6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:58:07 -0500
To: akpm@osdl.org
CC: "Russ Cox" <rsc@swtch.com>, linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix Oops in lookup
Message-Id: <E1Gm5u9-0002su-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Nov 2006 10:57:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in certain error paths of lookup routines.  The request object
was reused for sending FORGET, which is illegal.  This bug could cause
an Oops in 2.6.18.  In earlier versions it might silently corrupt
memory, but this is very unlikely.

These error paths are never triggered by libfuse, so this wasn't
noticed even with the 2.6.18 kernel, only with a filesystem using the
raw kernel interface.

Thanks to Russ Cox for the bug report and test filesystem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-11-19 20:07:47.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-11-19 20:07:49.000000000 +0100
@@ -138,6 +138,7 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_entry_out outarg;
 		struct fuse_conn *fc;
 		struct fuse_req *req;
+		struct fuse_req *forget_req;
 		struct dentry *parent;
 
 		/* Doesn't hurt to "reset" the validity timeout */
@@ -152,25 +153,33 @@ static int fuse_dentry_revalidate(struct
 		if (IS_ERR(req))
 			return 0;
 
+		forget_req = fuse_get_req(fc);
+		if (IS_ERR(forget_req)) {
+			fuse_put_request(fc, req);
+			return 0;
+		}
+
 		parent = dget_parent(entry);
 		fuse_lookup_init(req, parent->d_inode, entry, &outarg);
 		request_send(fc, req);
 		dput(parent);
 		err = req->out.h.error;
+		fuse_put_request(fc, req);
 		/* Zero nodeid is same as -ENOENT */
 		if (!err && !outarg.nodeid)
 			err = -ENOENT;
 		if (!err) {
 			struct fuse_inode *fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
-				fuse_send_forget(fc, req, outarg.nodeid, 1);
+				fuse_send_forget(fc, forget_req,
+						 outarg.nodeid, 1);
 				return 0;
 			}
 			spin_lock(&fc->lock);
 			fi->nlookup ++;
 			spin_unlock(&fc->lock);
 		}
-		fuse_put_request(fc, req);
+		fuse_put_request(fc, forget_req);
 		if (err || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
 			return 0;
 
@@ -221,6 +230,7 @@ static struct dentry *fuse_lookup(struct
 	struct inode *inode = NULL;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req;
+	struct fuse_req *forget_req;
 
 	if (entry->d_name.len > FUSE_NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -229,9 +239,16 @@ static struct dentry *fuse_lookup(struct
 	if (IS_ERR(req))
 		return ERR_PTR(PTR_ERR(req));
 
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return ERR_PTR(PTR_ERR(forget_req));
+	}
+
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
+	fuse_put_request(fc, req);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (!err && outarg.nodeid &&
 	    (invalid_nodeid(outarg.nodeid) || !valid_mode(outarg.attr.mode)))
@@ -240,11 +257,11 @@ static struct dentry *fuse_lookup(struct
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 				  &outarg.attr);
 		if (!inode) {
-			fuse_send_forget(fc, req, outarg.nodeid, 1);
+			fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 	if (err && err != -ENOENT)
 		return ERR_PTR(err);
 
@@ -388,6 +405,13 @@ static int create_new_entry(struct fuse_
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	int err;
+	struct fuse_req *forget_req;
+
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return PTR_ERR(forget_req);
+	}
 
 	req->in.h.nodeid = get_node_id(dir);
 	req->out.numargs = 1;
@@ -395,24 +419,24 @@ static int create_new_entry(struct fuse_
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (err) {
-		fuse_put_request(fc, req);
-		return err;
-	}
+	fuse_put_request(fc, req);
+	if (err)
+		goto out_put_forget_req;
+
 	err = -EIO;
 	if (invalid_nodeid(outarg.nodeid))
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr);
 	if (!inode) {
-		fuse_send_forget(fc, req, outarg.nodeid, 1);
+		fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 		return -ENOMEM;
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct dentry *alias;
@@ -434,8 +458,8 @@ static int create_new_entry(struct fuse_
 	fuse_invalidate_attr(dir);
 	return 0;
 
- out_put_request:
-	fuse_put_request(fc, req);
+ out_put_forget_req:
+	fuse_put_request(fc, forget_req);
 	return err;
 }
 
