Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVK1Tqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVK1Tqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVK1Tqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:46:49 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:16645 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932206AbVK1Tqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:46:49 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:45:29 +0100)
Subject: [PATCH 3/7] fuse: clean up fuse_lookup()
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:46:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify fuse_lookup() and related functions.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-11-28 17:24:26.000000000 +0100
+++ linux/fs/fuse/dir.c	2005-11-28 17:26:51.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
-#include <linux/mount.h>
 
 static inline unsigned long time_to_jiffies(unsigned long sec,
 					    unsigned long nsec)
@@ -22,6 +21,13 @@ static inline unsigned long time_to_jiff
 	return jiffies + timespec_to_jiffies(&ts);
 }
 
+static void fuse_change_timeout(struct dentry *entry, struct fuse_entry_out *o)
+{
+	struct fuse_inode *fi = get_fuse_inode(entry->d_inode);
+	entry->d_time = time_to_jiffies(o->entry_valid, o->entry_valid_nsec);
+	fi->i_time = time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+}
+
 static void fuse_lookup_init(struct fuse_req *req, struct inode *dir,
 			     struct dentry *entry,
 			     struct fuse_entry_out *outarg)
@@ -66,10 +72,7 @@ static int fuse_dentry_revalidate(struct
 			return 0;
 
 		fuse_change_attributes(inode, &outarg.attr);
-		entry->d_time = time_to_jiffies(outarg.entry_valid,
-						outarg.entry_valid_nsec);
-		fi->i_time = time_to_jiffies(outarg.attr_valid,
-					     outarg.attr_valid_nsec);
+		fuse_change_timeout(entry, &outarg);
 	}
 	return 1;
 }
@@ -96,8 +99,8 @@ static struct dentry_operations fuse_den
 	.d_revalidate	= fuse_dentry_revalidate,
 };
 
-static int fuse_lookup_iget(struct inode *dir, struct dentry *entry,
-			    struct inode **inodep)
+static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
+				  struct nameidata *nd)
 {
 	int err;
 	struct fuse_entry_out outarg;
@@ -106,11 +109,11 @@ static int fuse_lookup_iget(struct inode
 	struct fuse_req *req;
 
 	if (entry->d_name.len > FUSE_NAME_MAX)
-		return -ENAMETOOLONG;
+		return ERR_PTR(-ENAMETOOLONG);
 
 	req = fuse_get_request(fc);
 	if (!req)
-		return -EINTR;
+		return ERR_PTR(-EINTR);
 
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
@@ -122,24 +125,22 @@ static int fuse_lookup_iget(struct inode
 				  &outarg.attr);
 		if (!inode) {
 			fuse_send_forget(fc, req, outarg.nodeid, 1);
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 	fuse_put_request(fc, req);
 	if (err && err != -ENOENT)
-		return err;
+		return ERR_PTR(err);
 
-	if (inode) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-		entry->d_time =	time_to_jiffies(outarg.entry_valid,
-						outarg.entry_valid_nsec);
-		fi->i_time = time_to_jiffies(outarg.attr_valid,
-					     outarg.attr_valid_nsec);
+	if (inode && dir_alias(inode)) {
+		iput(inode);
+		return ERR_PTR(-EIO);
 	}
-
+	d_add(entry, inode);
 	entry->d_op = &fuse_dentry_operations;
-	*inodep = inode;
-	return 0;
+	if (inode)
+		fuse_change_timeout(entry, &outarg);
+	return NULL;
 }
 
 void fuse_invalidate_attr(struct inode *inode)
@@ -163,7 +164,6 @@ static int fuse_create_open(struct inode
 	struct fuse_open_in inarg;
 	struct fuse_open_out outopen;
 	struct fuse_entry_out outentry;
-	struct fuse_inode *fi;
 	struct fuse_file *ff;
 	struct file *file;
 	int flags = nd->intent.open.flags - 1;
@@ -224,13 +224,8 @@ static int fuse_create_open(struct inode
 		goto out_put_request;
 	}
 	fuse_put_request(fc, req);
-	entry->d_time =	time_to_jiffies(outentry.entry_valid,
-					outentry.entry_valid_nsec);
-	fi = get_fuse_inode(inode);
-	fi->i_time = time_to_jiffies(outentry.attr_valid,
-				     outentry.attr_valid_nsec);
-
 	d_instantiate(entry, inode);
+	fuse_change_timeout(entry, &outentry);
 	file = lookup_instantiate_filp(nd, entry, generic_file_open);
 	if (IS_ERR(file)) {
 		ff->fh = outopen.fh;
@@ -254,7 +249,6 @@ static int create_new_entry(struct fuse_
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
-	struct fuse_inode *fi;
 	int err;
 
 	req->in.h.nodeid = get_node_id(dir);
@@ -286,14 +280,8 @@ static int create_new_entry(struct fuse_
 		return -EIO;
 	}
 
-	entry->d_time = time_to_jiffies(outarg.entry_valid,
-					outarg.entry_valid_nsec);
-
-	fi = get_fuse_inode(inode);
-	fi->i_time = time_to_jiffies(outarg.attr_valid,
-				     outarg.attr_valid_nsec);
-
 	d_instantiate(entry, inode);
+	fuse_change_timeout(entry, &outarg);
 	fuse_invalidate_attr(dir);
 	return 0;
 }
@@ -883,23 +871,6 @@ static int fuse_getattr(struct vfsmount 
 	return err;
 }
 
-static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
-				  struct nameidata *nd)
-{
-	struct inode *inode;
-	int err;
-
-	err = fuse_lookup_iget(dir, entry, &inode);
-	if (err)
-		return ERR_PTR(err);
-	if (inode && dir_alias(inode)) {
-		iput(inode);
-		return ERR_PTR(-EIO);
-	}
-	d_add(entry, inode);
-	return NULL;
-}
-
 static int fuse_setxattr(struct dentry *entry, const char *name,
 			 const void *value, size_t size, int flags)
 {
