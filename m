Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758373AbWK2WGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbWK2WGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758372AbWK2WGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:06:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15061 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758362AbWK2WF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:05:28 -0500
Message-Id: <20061129220655.352656000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, miklos@szeredi.hu
Subject: [patch 22/23] fuse: fix Oops in lookup
Content-Disposition: inline; filename=fuse-fix-oops-in-lookup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Miklos Szeredi <miklos@szeredi.hu>

Fix bug in certain error paths of lookup routines.  The request object was
reused for sending FORGET, which is illegal.  This bug could cause an Oops
in 2.6.18.  In earlier versions it might silently corrupt memory, but this
is very unlikely.

These error paths are never triggered by libfuse, so this wasn't noticed
even with the 2.6.18 kernel, only with a filesystem using the raw kernel
interface.

Thanks to Russ Cox for the bug report and test filesystem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
[chrisw: backport to 2.6.18 -stable]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/fuse/dir.c |   52 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 14 deletions(-)

--- linux-2.6.18.4.orig/fs/fuse/dir.c
+++ linux-2.6.18.4/fs/fuse/dir.c
@@ -138,6 +138,7 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_entry_out outarg;
 		struct fuse_conn *fc;
 		struct fuse_req *req;
+		struct fuse_req *forget_req;
 
 		/* Doesn't hurt to "reset" the validity timeout */
 		fuse_invalidate_entry_cache(entry);
@@ -151,21 +152,29 @@ static int fuse_dentry_revalidate(struct
 		if (IS_ERR(req))
 			return 0;
 
+		forget_req = fuse_get_req(fc);
+		if (IS_ERR(forget_req)) {
+			fuse_put_request(fc, req);
+			return 0;
+		}
+
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
 		request_send(fc, req);
 		err = req->out.h.error;
+		fuse_put_request(fc, req);
 		/* Zero nodeid is same as -ENOENT */
 		if (!err && !outarg.nodeid)
 			err = -ENOENT;
 		if (!err) {
 			struct fuse_inode *fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
-				fuse_send_forget(fc, req, outarg.nodeid, 1);
+				fuse_send_forget(fc, forget_req,
+						 outarg.nodeid, 1);
 				return 0;
 			}
 			fi->nlookup ++;
 		}
-		fuse_put_request(fc, req);
+		fuse_put_request(fc, forget_req);
 		if (err || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
 			return 0;
 
@@ -214,6 +223,7 @@ static struct dentry *fuse_lookup(struct
 	struct inode *inode = NULL;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req;
+	struct fuse_req *forget_req;
 
 	if (entry->d_name.len > FUSE_NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -222,9 +232,16 @@ static struct dentry *fuse_lookup(struct
 	if (IS_ERR(req))
 		return ERR_PTR(PTR_ERR(req));
 
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return ERR_PTR(PTR_ERR(forget_req));
+	}
+
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
+	fuse_put_request(fc, req);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (!err && outarg.nodeid &&
 	    (invalid_nodeid(outarg.nodeid) || !valid_mode(outarg.attr.mode)))
@@ -233,11 +250,11 @@ static struct dentry *fuse_lookup(struct
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 				  &outarg.attr);
 		if (!inode) {
-			fuse_send_forget(fc, req, outarg.nodeid, 1);
+			fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 	if (err && err != -ENOENT)
 		return ERR_PTR(err);
 
@@ -375,6 +392,13 @@ static int create_new_entry(struct fuse_
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	int err;
+	struct fuse_req *forget_req;
+
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return PTR_ERR(forget_req);
+	}
 
 	req->in.h.nodeid = get_node_id(dir);
 	req->out.numargs = 1;
@@ -382,24 +406,24 @@ static int create_new_entry(struct fuse_
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (err) {
-		fuse_put_request(fc, req);
-		return err;
-	}
+	fuse_put_request(fc, req);
+	if (err)
+		goto out_put_forget_req;
+
 	err = -EIO;
 	if (invalid_nodeid(outarg.nodeid))
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr);
 	if (!inode) {
-		fuse_send_forget(fc, req, outarg.nodeid, 1);
+		fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 		return -ENOMEM;
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 
 	if (dir_alias(inode)) {
 		iput(inode);
@@ -411,8 +435,8 @@ static int create_new_entry(struct fuse_
 	fuse_invalidate_attr(dir);
 	return 0;
 
- out_put_request:
-	fuse_put_request(fc, req);
+ out_put_forget_req:
+	fuse_put_request(fc, forget_req);
 	return err;
 }
 

--
