Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWJPQ2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWJPQ2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWJPQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:35 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:59546 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1422747AbWJPQ21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:27 -0400
Message-Id: <20061016162741.475543000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:14 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 05/12] fuse: fix handling of moved directory
Content-Disposition: inline; filename=fuse_dir_alias_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fuse considered it an error (EIO) if lookup returned a directory
inode, to which a dentry already refered.  This is because directory
aliases are not allowed.

But in a network filesystem this could happen legitimately, if a
directory is moved on a remote client.  This patch attempts to relax
the restriction by trying to first evict the offending alias from the
cache.  If this fails, it still returns an error (EBUSY).

A rarer situation is if an mkdir races with an indenpendent lookup,
which finds the newly created directory already moved.  In this
situation the mkdir should return success, but that would be
incorrect, since the dentry cannot be instantiated, so return EBUSY.

Previously checking for a directory alias and instantiation of the
dentry weren't done atomically in lookup/mkdir, hence two such calls
racing with each other could create aliased directories.  To prevent
this introduce a new per-connection mutex: fuse_conn->inst_mutex,
which is taken for instantiations with a directory inode.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 16:17:31.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:21:11.000000000 +0200
@@ -177,22 +177,6 @@ static int fuse_dentry_revalidate(struct
 	return 1;
 }
 
-/*
- * Check if there's already a hashed alias of this directory inode.
- * If yes, then lookup and mkdir must not create a new alias.
- */
-static int dir_alias(struct inode *inode)
-{
-	if (S_ISDIR(inode->i_mode)) {
-		struct dentry *alias = d_find_alias(inode);
-		if (alias) {
-			dput(alias);
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static int invalid_nodeid(u64 nodeid)
 {
 	return !nodeid || nodeid == FUSE_ROOT_ID;
@@ -208,6 +192,24 @@ static int valid_mode(int m)
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
 }
 
+/*
+ * Add a directory inode to a dentry, ensuring that no other dentry
+ * refers to this inode.  Called with fc->inst_mutex.
+ */
+static int fuse_d_add_directory(struct dentry *entry, struct inode *inode)
+{
+	struct dentry *alias = d_find_alias(inode);
+	if (alias) {
+		/* This tries to shrink the subtree below alias */
+		fuse_invalidate_entry(alias);
+		dput(alias);
+		if (!list_empty(&inode->i_dentry))
+			return -EBUSY;
+	}
+	d_add(entry, inode);
+	return 0;
+}
+
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  struct nameidata *nd)
 {
@@ -243,11 +245,17 @@ static struct dentry *fuse_lookup(struct
 	if (err && err != -ENOENT)
 		return ERR_PTR(err);
 
-	if (inode && dir_alias(inode)) {
-		iput(inode);
-		return ERR_PTR(-EIO);
-	}
-	d_add(entry, inode);
+	if (inode && S_ISDIR(inode->i_mode)) {
+		mutex_lock(&fc->inst_mutex);
+		err = fuse_d_add_directory(entry, inode);
+		mutex_unlock(&fc->inst_mutex);
+		if (err) {
+			iput(inode);
+			return ERR_PTR(err);
+		}
+	} else
+		d_add(entry, inode);
+
 	entry->d_op = &fuse_dentry_operations;
 	if (!err)
 		fuse_change_timeout(entry, &outarg);
@@ -403,12 +411,22 @@ static int create_new_entry(struct fuse_
 	}
 	fuse_put_request(fc, req);
 
-	if (dir_alias(inode)) {
-		iput(inode);
-		return -EIO;
-	}
+	if (S_ISDIR(inode->i_mode)) {
+		struct dentry *alias;
+		mutex_lock(&fc->inst_mutex);
+		alias = d_find_alias(inode);
+		if (alias) {
+			/* New directory must have moved since mkdir */
+			mutex_unlock(&fc->inst_mutex);
+			dput(alias);
+			iput(inode);
+			return -EBUSY;
+		}
+		d_instantiate(entry, inode);
+		mutex_unlock(&fc->inst_mutex);
+	} else
+		d_instantiate(entry, inode);
 
-	d_instantiate(entry, inode);
 	fuse_change_timeout(entry, &outarg);
 	fuse_invalidate_attr(dir);
 	return 0;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-10-16 16:17:31.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-10-16 16:17:36.000000000 +0200
@@ -239,6 +239,9 @@ struct fuse_conn {
 	/** Lock protecting accessess to  members of this structure */
 	spinlock_t lock;
 
+	/** Mutex protecting against directory alias creation */
+	struct mutex inst_mutex;
+
 	/** Refcount */
 	atomic_t count;
 
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 16:17:31.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:17:36.000000000 +0200
@@ -379,6 +379,7 @@ static struct fuse_conn *new_conn(void)
 	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc) {
 		spin_lock_init(&fc->lock);
+		mutex_init(&fc->inst_mutex);
 		atomic_set(&fc->count, 1);
 		init_waitqueue_head(&fc->waitq);
 		init_waitqueue_head(&fc->blocked_waitq);
@@ -398,8 +399,10 @@ static struct fuse_conn *new_conn(void)
 
 void fuse_conn_put(struct fuse_conn *fc)
 {
-	if (atomic_dec_and_test(&fc->count))
+	if (atomic_dec_and_test(&fc->count)) {
+		mutex_destroy(&fc->inst_mutex);
 		kfree(fc);
+	}
 }
 
 struct fuse_conn *fuse_conn_get(struct fuse_conn *fc)

--
