Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWJPQbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWJPQbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWJPQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:33 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:32457 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422752AbWJPQ23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:29 -0400
Message-Id: <20061016162747.991830000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:15 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 06/12] fuse: fix dereferencing dentry parent
Content-Disposition: inline; filename=fuse_parent_deref_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no locking for ->d_revalidate, so fuse_dentry_revalidate()
should use dget_parent() instead of simply dereferencing ->d_parent.

Due to topology changes in the directory tree the parent could become
negative or be destroyed while being used.  There hasn't been any
reports about this yet.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 16:21:11.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:21:20.000000000 +0200
@@ -138,6 +138,7 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_entry_out outarg;
 		struct fuse_conn *fc;
 		struct fuse_req *req;
+		struct dentry *parent;
 
 		/* Doesn't hurt to "reset" the validity timeout */
 		fuse_invalidate_entry_cache(entry);
@@ -151,8 +152,10 @@ static int fuse_dentry_revalidate(struct
 		if (IS_ERR(req))
 			return 0;
 
-		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
+		parent = dget_parent(entry);
+		fuse_lookup_init(req, parent->d_inode, entry, &outarg);
 		request_send(fc, req);
+		dput(parent);
 		err = req->out.h.error;
 		/* Zero nodeid is same as -ENOENT */
 		if (!err && !outarg.nodeid)

--
