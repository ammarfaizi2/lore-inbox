Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWIDXQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWIDXQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWIDXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:16:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965026AbWIDXQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:14 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:16:08 +1000
Message-Id: <1060904231608.23162@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 9] knfsd: nfsd4: acls: fix handling of zero-length acls
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

It is legal to have zero-length NFSv4 acls; they just deny everything.

Also, nfs4_acl_nfsv4_to_posix will always return with pacl and dpacl set on
success, so the caller doesn't need to check this.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |   15 +--------------
 ./fs/nfsd/vfs.c     |   10 ++++------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff .prev/fs/nfsd/nfs4acl.c ./fs/nfsd/nfs4acl.c
--- .prev/fs/nfsd/nfs4acl.c	2006-09-04 17:27:48.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-09-04 17:28:10.000000000 +1000
@@ -357,33 +357,20 @@ nfs4_acl_nfsv4_to_posix(struct nfs4_acl 
 		goto out;
 
 	error = nfs4_acl_split(acl, dacl);
-	if (error < 0)
+	if (error)
 		goto out_acl;
 
-	if (acl->naces == 0) {
-		error = -ENODATA;
-		goto try_dpacl;
-	}
-
 	*pacl = _nfsv4_to_posix_one(acl, flags);
 	if (IS_ERR(*pacl)) {
 		error = PTR_ERR(*pacl);
 		*pacl = NULL;
 		goto out_acl;
 	}
-try_dpacl:
-	if (dacl->naces == 0) {
-		if (pacl == NULL || *pacl == NULL)
-			error = -ENODATA;
-		goto out_acl;
-	}
 
-	error = 0;
 	*dpacl = _nfsv4_to_posix_one(dacl, flags);
 	if (IS_ERR(*dpacl)) {
 		error = PTR_ERR(*dpacl);
 		*dpacl = NULL;
-		goto out_acl;
 	}
 out_acl:
 	if (error) {

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-09-04 17:09:47.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-09-04 17:28:10.000000000 +1000
@@ -447,13 +447,11 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqst
 	} else if (error < 0)
 		goto out_nfserr;
 
-	if (pacl) {
-		error = set_nfsv4_acl_one(dentry, pacl, POSIX_ACL_XATTR_ACCESS);
-		if (error < 0)
-			goto out_nfserr;
-	}
+	error = set_nfsv4_acl_one(dentry, pacl, POSIX_ACL_XATTR_ACCESS);
+	if (error < 0)
+		goto out_nfserr;
 
-	if (dpacl) {
+	if (S_ISDIR(inode->i_mode)) {
 		error = set_nfsv4_acl_one(dentry, dpacl, POSIX_ACL_XATTR_DEFAULT);
 		if (error < 0)
 			goto out_nfserr;
