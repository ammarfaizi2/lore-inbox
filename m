Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVK1Tng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVK1Tng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVK1Tng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:43:36 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:41742 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932210AbVK1Tng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:43:36 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:41:23 +0100)
Subject: [PATCH 1/7] fuse: check directory aliasing in mkdir
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:43:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the created directory inode for aliases in the mkdir() method.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-11-28 14:01:08.000000000 +0100
+++ linux/fs/fuse/dir.c	2005-11-28 14:01:52.000000000 +0100
@@ -74,6 +74,19 @@ static int fuse_dentry_revalidate(struct
 	return 1;
 }
 
+static int dir_alias(struct inode *inode)
+{
+	if (S_ISDIR(inode->i_mode)) {
+		/* Don't allow creating an alias to a directory  */
+		struct dentry *alias = d_find_alias(inode);
+		if (alias) {
+			dput(alias);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 };
@@ -263,7 +276,7 @@ static int create_new_entry(struct fuse_
 	fuse_put_request(fc, req);
 
 	/* Don't allow userspace to do really stupid things... */
-	if ((inode->i_mode ^ mode) & S_IFMT) {
+	if (((inode->i_mode ^ mode) & S_IFMT) || dir_alias(inode)) {
 		iput(inode);
 		return -EIO;
 	}
@@ -874,14 +887,9 @@ static struct dentry *fuse_lookup(struct
 	err = fuse_lookup_iget(dir, entry, &inode);
 	if (err)
 		return ERR_PTR(err);
-	if (inode && S_ISDIR(inode->i_mode)) {
-		/* Don't allow creating an alias to a directory  */
-		struct dentry *alias = d_find_alias(inode);
-		if (alias) {
-			dput(alias);
-			iput(inode);
-			return ERR_PTR(-EIO);
-		}
+	if (inode && dir_alias(inode)) {
+		iput(inode);
+		return ERR_PTR(-EIO);
 	}
 	d_add(entry, inode);
 	return NULL;
