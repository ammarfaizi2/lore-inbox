Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWBYQIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWBYQIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWBYQIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:08:43 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:63716 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964771AbWBYQIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:08:42 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix bug in negative lookup
Message-Id: <E1FD1xt-0008Du-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 25 Feb 2006 17:08:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If negative entries (nodeid == 0) were sent in reply to LOOKUP
requests, two bugs could be triggered:

- looking up a negative entry would return -EIO,

- revaildate on an entry which turned negative would send a FORGET
  request with zero nodeid, which would cause an abort() in the
  library.

The above would only happen if the 'negative_timeout=N' option was
used, otherwise lookups reply -ENOENT, which worked correctly.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-02-25 16:29:59.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-02-25 16:34:46.000000000 +0100
@@ -111,6 +111,8 @@ static int fuse_dentry_revalidate(struct
 
 		/* Doesn't hurt to "reset" the validity timeout */
 		fuse_invalidate_entry_cache(entry);
+
+		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
 			return 0;
 
@@ -122,6 +124,9 @@ static int fuse_dentry_revalidate(struct
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
 		request_send(fc, req);
 		err = req->out.h.error;
+		/* Zero nodeid is same as -ENOENT */
+		if (!err && !outarg.nodeid)
+			err = -ENOENT;
 		if (!err) {
 			struct fuse_inode *fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
@@ -190,8 +195,9 @@ static struct dentry *fuse_lookup(struct
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err && ((outarg.nodeid && invalid_nodeid(outarg.nodeid)) ||
-		     !valid_mode(outarg.attr.mode)))
+	/* Zero nodeid is same as -ENOENT, but with valid timeout */
+	if (!err && outarg.nodeid &&
+	    (invalid_nodeid(outarg.nodeid) || !valid_mode(outarg.attr.mode)))
 		err = -EIO;
 	if (!err && outarg.nodeid) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
