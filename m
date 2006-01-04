Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWADNTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWADNTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWADNTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:19:37 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:17290 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751786AbWADNTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:25 -0500
Message-Id: <20060104131846.869224000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:36 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] fuse: check file type in lookup
Content-Disposition: inline; filename=fuse_check_type.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously invalid types were quietly changed to regular files, but at
revalidation the inode was changed to bad.  This was rather
inconsistent behavior.

Now check if the type is valid on initial lookup, and return -EIO if
not.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-04 12:37:53.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-04 12:37:57.000000000 +0100
@@ -166,6 +166,12 @@ static struct dentry_operations fuse_den
 	.d_revalidate	= fuse_dentry_revalidate,
 };
 
+static inline int valid_mode(int m)
+{
+	return S_ISREG(m) || S_ISDIR(m) || S_ISLNK(m) || S_ISCHR(m) ||
+		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
+}
+
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  struct nameidata *nd)
 {
@@ -185,7 +191,8 @@ static struct dentry *fuse_lookup(struct
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err && outarg.nodeid && invalid_nodeid(outarg.nodeid))
+	if (!err && ((outarg.nodeid && invalid_nodeid(outarg.nodeid)) ||
+		     !valid_mode(outarg.attr.mode)))
 		err = -EIO;
 	if (!err && outarg.nodeid) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
@@ -328,10 +335,13 @@ static int create_new_entry(struct fuse_
 		fuse_put_request(fc, req);
 		return err;
 	}
-	if (invalid_nodeid(outarg.nodeid)) {
-		fuse_put_request(fc, req);
-		return -EIO;
-	}
+	err = -EIO;
+	if (invalid_nodeid(outarg.nodeid))
+		goto out_put_request;
+
+	if ((outarg.attr.mode ^ mode) & S_IFMT)
+		goto out_put_request;
+
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr);
 	if (!inode) {
@@ -340,8 +350,7 @@ static int create_new_entry(struct fuse_
 	}
 	fuse_put_request(fc, req);
 
-	/* Don't allow userspace to do really stupid things... */
-	if (((inode->i_mode ^ mode) & S_IFMT) || dir_alias(inode)) {
+	if (dir_alias(inode)) {
 		iput(inode);
 		return -EIO;
 	}
@@ -350,6 +359,10 @@ static int create_new_entry(struct fuse_
 	fuse_change_timeout(entry, &outarg);
 	fuse_invalidate_attr(dir);
 	return 0;
+
+ out_put_request:
+	fuse_put_request(fc, req);
+	return err;
 }
 
 static int fuse_mknod(struct inode *dir, struct dentry *entry, int mode,
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-04 12:37:55.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-04 12:37:57.000000000 +0100
@@ -135,12 +135,8 @@ static void fuse_init_inode(struct inode
 		fuse_init_common(inode);
 		init_special_inode(inode, inode->i_mode,
 				   new_decode_dev(attr->rdev));
-	} else {
-		/* Don't let user create weird files */
-		inode->i_mode = S_IFREG;
-		fuse_init_common(inode);
-		fuse_init_file_inode(inode);
-	}
+	} else
+		BUG();
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)

--
