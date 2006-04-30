Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWD3Qg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWD3Qg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWD3Qg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:36:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:26077 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751167AbWD3Qg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:36:29 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Client-side nfsacl caching fix
Date: Sun, 30 Apr 2006 18:34:36 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301834.37273.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two errors in the client-side acl cache: First, when nfs3_proc_getacl
requests only the default acl of a file and the access acl is not cached
already, a NULL access acl entry is cached instead of ERR_PTR(-EAGAIN)
("not cached").

Second, update the cached acls in nfs3_proc_setacls: nfs_refresh_inode does 
not always invalidate the cached acls, and when it does not, the cached acls 
get out of sync.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.16/fs/nfs/nfs3acl.c
===================================================================
--- linux-2.6.16.orig/fs/nfs/nfs3acl.c
+++ linux-2.6.16/fs/nfs/nfs3acl.c
@@ -172,8 +172,10 @@ static void nfs3_cache_acls(struct inode
 		inode->i_ino, acl, dfacl);
 	spin_lock(&inode->i_lock);
 	__nfs3_forget_cached_acls(NFS_I(inode));
-	nfsi->acl_access = posix_acl_dup(acl);
-	nfsi->acl_default = posix_acl_dup(dfacl);
+	if (!IS_ERR(acl))
+		nfsi->acl_access = posix_acl_dup(acl);
+	if (!IS_ERR(dfacl))
+		nfsi->acl_default = posix_acl_dup(dfacl);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -250,7 +252,9 @@ struct posix_acl *nfs3_proc_getacl(struc
 			res.acl_access = NULL;
 		}
 	}
-	nfs3_cache_acls(inode, res.acl_access, res.acl_default);
+	nfs3_cache_acls(inode,
+		(res.mask & NFS_ACL)   ? res.acl_access  : ERR_PTR(-EINVAL),
+		(res.mask & NFS_DFACL) ? res.acl_default : ERR_PTR(-EINVAL));
 
 	switch(type) {
 		case ACL_TYPE_ACCESS:
@@ -321,6 +325,7 @@ static int nfs3_proc_setacls(struct inod
 	switch (status) {
 		case 0:
 			status = nfs_refresh_inode(inode, &fattr);
+			nfs3_cache_acls(inode, acl, dfacl);
 			break;
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
