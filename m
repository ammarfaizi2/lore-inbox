Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWADNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWADNTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWADNTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:19:38 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:17034 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751782AbWADNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:22 -0500
Message-Id: <20060104131837.728158000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:31 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] fuse: add code documentation
Content-Disposition: inline; filename=fuse_comments.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document some not-so-trivial functions.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-04 12:14:06.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-04 12:37:42.000000000 +0100
@@ -14,6 +14,15 @@
 #include <linux/sched.h>
 #include <linux/namei.h>
 
+/*
+ * FUSE caches dentries and attributes with separate timeout.  The
+ * time in jiffies until the dentry/attributes are valid is stored in
+ * dentry->d_time and fuse_inode->i_time respectively.
+ */
+
+/*
+ * Calcualte the time in jiffies until a dentry/attributes are valid
+ */
 static inline unsigned long time_to_jiffies(unsigned long sec,
 					    unsigned long nsec)
 {
@@ -21,6 +30,10 @@ static inline unsigned long time_to_jiff
 	return jiffies + timespec_to_jiffies(&ts);
 }
 
+/*
+ * Set dentry and possibly attribute timeouts from the lookup/mk*
+ * replies
+ */
 static void fuse_change_timeout(struct dentry *entry, struct fuse_entry_out *o)
 {
 	entry->d_time = time_to_jiffies(o->entry_valid, o->entry_valid_nsec);
@@ -29,16 +42,32 @@ static void fuse_change_timeout(struct d
 			time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
+/*
+ * Mark the attributes as stale, so that at the next call to
+ * ->getattr() they will be fetched from userspace
+ */
 void fuse_invalidate_attr(struct inode *inode)
 {
 	get_fuse_inode(inode)->i_time = jiffies - 1;
 }
 
+/*
+ * Just mark the entry as stale, so that a next attempt to look it up
+ * will result in a new lookup call to userspace
+ *
+ * This is called when a dentry is about to become negative and the
+ * timeout is unknown (unlink, rmdir, rename and in some cases
+ * lookup)
+ */
 static void fuse_invalidate_entry_cache(struct dentry *entry)
 {
 	entry->d_time = jiffies - 1;
 }
 
+/*
+ * Same as fuse_invalidate_entry_cache(), but also try to remove the
+ * dentry from the hash
+ */
 static void fuse_invalidate_entry(struct dentry *entry)
 {
 	d_invalidate(entry);
@@ -60,6 +89,15 @@ static void fuse_lookup_init(struct fuse
 	req->out.args[0].value = outarg;
 }
 
+/*
+ * Check whether the dentry is still valid
+ *
+ * If the entry validity timeout has expired and the dentry is
+ * positive, try to redo the lookup.  If the lookup results in a
+ * different inode, then let the VFS invalidate the dentry and redo
+ * the lookup once more.  If the lookup results in the same inode,
+ * then refresh the attributes, timeouts and mark the dentry valid.
+ */
 static int fuse_dentry_revalidate(struct dentry *entry, struct nameidata *nd)
 {
 	struct inode *inode = entry->d_inode;
@@ -72,6 +110,7 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_conn *fc;
 		struct fuse_req *req;
 
+		/* Doesn't hurt to "reset" the validity timeout */
 		fuse_invalidate_entry_cache(entry);
 		if (!inode)
 			return 0;
@@ -102,10 +141,13 @@ static int fuse_dentry_revalidate(struct
 	return 1;
 }
 
+/*
+ * Check if there's already a hashed alias of this directory inode.
+ * If yes, then lookup and mkdir must not create a new alias.
+ */
 static int dir_alias(struct inode *inode)
 {
 	if (S_ISDIR(inode->i_mode)) {
-		/* Don't allow creating an alias to a directory  */
 		struct dentry *alias = d_find_alias(inode);
 		if (alias) {
 			dput(alias);
@@ -170,6 +212,12 @@ static struct dentry *fuse_lookup(struct
 	return NULL;
 }
 
+/*
+ * Atomic create+open operation
+ *
+ * If the filesystem doesn't support this, then fall back to separate
+ * 'mknod' + 'open' requests.
+ */
 static int fuse_create_open(struct inode *dir, struct dentry *entry, int mode,
 			    struct nameidata *nd)
 {
@@ -236,6 +284,9 @@ static int fuse_create_open(struct inode
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		ff->fh = outopen.fh;
+		/* Special release, with inode = NULL, this will
+		   trigger a 'forget' request when the release is
+		   complete */
 		fuse_send_release(fc, ff, outentry.nodeid, NULL, flags, 0);
 		goto out_put_request;
 	}
@@ -259,6 +310,9 @@ static int fuse_create_open(struct inode
 	return err;
 }
 
+/*
+ * Code shared between mknod, mkdir, symlink and link
+ */
 static int create_new_entry(struct fuse_conn *fc, struct fuse_req *req,
 			    struct inode *dir, struct dentry *entry,
 			    int mode)
@@ -576,6 +630,15 @@ static int fuse_allow_task(struct fuse_c
 	return 0;
 }
 
+/*
+ * Check whether the inode attributes are still valid
+ *
+ * If the attribute validity timeout has expired, then fetch the fresh
+ * attributes with a 'getattr' request
+ *
+ * I'm not sure why cached attributes are never returned for the root
+ * inode, this is probably being too cautious.
+ */
 static int fuse_revalidate(struct dentry *entry)
 {
 	struct inode *inode = entry->d_inode;
@@ -623,6 +686,19 @@ static int fuse_access(struct inode *ino
 	return err;
 }
 
+/*
+ * Check permission.  The two basic access models of FUSE are:
+ *
+ * 1) Local access checking ('default_permissions' mount option) based
+ * on file mode.  This is the plain old disk filesystem permission
+ * modell.
+ *
+ * 2) "Remote" access checking, where server is responsible for
+ * checking permission in each inode operation.  An exception to this
+ * is if ->permission() was invoked from sys_access() in which case an
+ * access request is sent.  Execute permission is still checked
+ * locally based on file mode.
+ */
 static int fuse_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -641,14 +717,10 @@ static int fuse_permission(struct inode 
 				err = generic_permission(inode, mask, NULL);
 		}
 
-		/* FIXME: Need some mechanism to revoke permissions:
-		   currently if the filesystem suddenly changes the
-		   file mode, we will not be informed about it, and
-		   continue to allow access to the file/directory.
-
-		   This is actually not so grave, since the user can
-		   simply keep access to the file/directory anyway by
-		   keeping it open... */
+		/* Note: the opposite of the above test does not
+		   exist.  So if permissions are revoked this won't be
+		   noticed immediately, only after the attribute
+		   timeout has expired */
 
 		return err;
 	} else {
@@ -816,6 +888,15 @@ static void iattr_to_fattr(struct iattr 
 	}
 }
 
+/*
+ * Set attributes, and at the same time refresh them.
+ *
+ * Truncation is slightly complicated, because the 'truncate' request
+ * may fail, in which case we don't want to touch the mapping.
+ * vmtruncate() doesn't allow for this case.  So do the rlimit
+ * checking by hand and call vmtruncate() only after the file has
+ * actually been truncated.
+ */
 static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 {
 	struct inode *inode = entry->d_inode;

--
