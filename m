Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVI3KYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVI3KYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVI3KYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:24:47 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:523 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S965031AbVI3KYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:24:46 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: clean up dead code related to nfs exporting
Message-Id: <E1ELI3p-0005rf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Sep 2005 12:24:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove last remains of NFS exportability support.

The code is actually buggy (as reported by Akshat Aranya), since
'alias' will be leaked if it's non-null and alias->d_flags has
DCACHE_DISCONNECTED.

This is not an active bug, since there will never be any disconnected
dentries.  But it's better to get rid of the unnecessary complexity
anyway.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-09-28 12:57:38.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-09-30 12:07:11.000000000 +0200
@@ -741,13 +741,14 @@ static struct dentry *fuse_lookup(struct
 	if (inode && S_ISDIR(inode->i_mode)) {
 		/* Don't allow creating an alias to a directory  */
 		struct dentry *alias = d_find_alias(inode);
-		if (alias && !(alias->d_flags & DCACHE_DISCONNECTED)) {
+		if (alias) {
 			dput(alias);
 			iput(inode);
 			return ERR_PTR(-EIO);
 		}
 	}
-	return d_splice_alias(inode, entry);
+	d_add(entry, inode);
+	return NULL;
 }
 
 static int fuse_setxattr(struct dentry *entry, const char *name,
