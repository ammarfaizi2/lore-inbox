Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVK1Tvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVK1Tvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVK1Tvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:51:48 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:5393 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932217AbVK1Tvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:51:47 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1Egp0p-0006vL-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:50:07 +0100)
Subject: [PATCH 7/7] fuse: support caching negative dentries
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu> <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu> <E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu> <E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu> <E1Egp0p-0006vL-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1Egp20-0006vv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:51:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for caching negative dentries.

Up till now, ->d_revalidate() always forced a new lookup on these.
Now let the lookup method return a zero node ID (not used for anything
else) meaning a negative entry, but with a positive cache timeout.
The old way of signaling negative entry (replying ENOENT) still works.

Userspace should check the ABI minor version to see whether sending a
zero ID is allowed by the kernel or not.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-11-28 17:55:27.000000000 +0100
+++ linux/fs/fuse/dir.c	2005-11-28 18:07:23.000000000 +0100
@@ -23,9 +23,26 @@ static inline unsigned long time_to_jiff
 
 static void fuse_change_timeout(struct dentry *entry, struct fuse_entry_out *o)
 {
-	struct fuse_inode *fi = get_fuse_inode(entry->d_inode);
 	entry->d_time = time_to_jiffies(o->entry_valid, o->entry_valid_nsec);
-	fi->i_time = time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+	if (entry->d_inode)
+		get_fuse_inode(entry->d_inode)->i_time =
+			time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+}
+
+void fuse_invalidate_attr(struct inode *inode)
+{
+	get_fuse_inode(inode)->i_time = jiffies - 1;
+}
+
+static void fuse_invalidate_entry_cache(struct dentry *entry)
+{
+	entry->d_time = jiffies - 1;
+}
+
+static void fuse_invalidate_entry(struct dentry *entry)
+{
+	d_invalidate(entry);
+	fuse_invalidate_entry_cache(entry);
 }
 
 static void fuse_lookup_init(struct fuse_req *req, struct inode *dir,
@@ -45,15 +62,22 @@ static void fuse_lookup_init(struct fuse
 
 static int fuse_dentry_revalidate(struct dentry *entry, struct nameidata *nd)
 {
-	if (!entry->d_inode || is_bad_inode(entry->d_inode))
+	struct inode *inode = entry->d_inode;
+
+	if (inode && is_bad_inode(inode))
 		return 0;
 	else if (time_after(jiffies, entry->d_time)) {
 		int err;
 		struct fuse_entry_out outarg;
-		struct inode *inode = entry->d_inode;
-		struct fuse_inode *fi = get_fuse_inode(inode);
-		struct fuse_conn *fc = get_fuse_conn(inode);
-		struct fuse_req *req = fuse_get_request(fc);
+		struct fuse_conn *fc;
+		struct fuse_req *req;
+
+		fuse_invalidate_entry_cache(entry);
+		if (!inode)
+			return 0;
+
+		fc = get_fuse_conn(inode);
+		req = fuse_get_request(fc);
 		if (!req)
 			return 0;
 
@@ -61,6 +85,7 @@ static int fuse_dentry_revalidate(struct
 		request_send(fc, req);
 		err = req->out.h.error;
 		if (!err) {
+			struct fuse_inode *fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
 				fuse_send_forget(fc, req, outarg.nodeid, 1);
 				return 0;
@@ -118,9 +143,9 @@ static struct dentry *fuse_lookup(struct
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err && invalid_nodeid(outarg.nodeid))
+	if (!err && outarg.nodeid && invalid_nodeid(outarg.nodeid))
 		err = -EIO;
-	if (!err) {
+	if (!err && outarg.nodeid) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 				  &outarg.attr);
 		if (!inode) {
@@ -138,22 +163,13 @@ static struct dentry *fuse_lookup(struct
 	}
 	d_add(entry, inode);
 	entry->d_op = &fuse_dentry_operations;
-	if (inode)
+	if (!err)
 		fuse_change_timeout(entry, &outarg);
+	else
+		fuse_invalidate_entry_cache(entry);
 	return NULL;
 }
 
-void fuse_invalidate_attr(struct inode *inode)
-{
-	get_fuse_inode(inode)->i_time = jiffies - 1;
-}
-
-static void fuse_invalidate_entry(struct dentry *entry)
-{
-	d_invalidate(entry);
-	entry->d_time = jiffies - 1;
-}
-
 static int fuse_create_open(struct inode *dir, struct dentry *entry, int mode,
 			    struct nameidata *nd)
 {
@@ -387,6 +403,7 @@ static int fuse_unlink(struct inode *dir
 		inode->i_nlink = 0;
 		fuse_invalidate_attr(inode);
 		fuse_invalidate_attr(dir);
+		fuse_invalidate_entry_cache(entry);
 	} else if (err == -EINTR)
 		fuse_invalidate_entry(entry);
 	return err;
@@ -412,6 +429,7 @@ static int fuse_rmdir(struct inode *dir,
 	if (!err) {
 		entry->d_inode->i_nlink = 0;
 		fuse_invalidate_attr(dir);
+		fuse_invalidate_entry_cache(entry);
 	} else if (err == -EINTR)
 		fuse_invalidate_entry(entry);
 	return err;
@@ -447,6 +465,10 @@ static int fuse_rename(struct inode *old
 		fuse_invalidate_attr(olddir);
 		if (olddir != newdir)
 			fuse_invalidate_attr(newdir);
+
+		/* newent will end up negative */
+		if (newent->d_inode)
+			fuse_invalidate_entry_cache(newent);
 	} else if (err == -EINTR) {
 		/* If request was interrupted, DEITY only knows if the
 		   rename actually took place.  If the invalidation
