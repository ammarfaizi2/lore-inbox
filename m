Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVJGLWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVJGLWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJGLWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:22:43 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:32271 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932255AbVJGLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:22:43 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: don't drop dentry in d_revalidate
Message-Id: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 13:21:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS d_revalidate() is doing things that are supposed to be done by
d_invalidate().

Dropping the dentry is especially bad, since it will make
d_invalidate() bypass all checks.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/nfs/dir.c
===================================================================
--- linux.orig/fs/nfs/dir.c	2005-10-04 13:59:57.000000000 +0200
+++ linux/fs/nfs/dir.c	2005-10-07 12:53:45.000000000 +0200
@@ -762,12 +762,7 @@ out_zap_parent:
 	if (inode && S_ISDIR(inode->i_mode)) {
 		/* Purge readdir caches. */
 		nfs_zap_caches(inode);
-		/* If we have submounts, don't unhash ! */
-		if (have_submounts(dentry))
-			goto out_valid;
-		shrink_dcache_parent(dentry);
 	}
-	d_drop(dentry);
 	unlock_kernel();
 	dput(parent);
 	return 0;
