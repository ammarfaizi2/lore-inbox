Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWIDXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWIDXRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWIDXRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:17:30 -0400
Received: from mail.suse.de ([195.135.220.2]:35789 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965021AbWIDXQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:09 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:16:03 +1000
Message-Id: <1060904231603.23150@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 9] knfsd: nfsd4: acls: simplify nfs4_acl_nfsv4_to_posix interface
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

There's no need to handle the case where the caller passes in null for pacl
or dpacl; no caller does that, because it would be a dumb thing to do.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |   48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff .prev/fs/nfsd/nfs4acl.c ./fs/nfsd/nfs4acl.c
--- .prev/fs/nfsd/nfs4acl.c	2006-09-04 17:26:00.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-09-04 17:27:48.000000000 +1000
@@ -360,39 +360,33 @@ nfs4_acl_nfsv4_to_posix(struct nfs4_acl 
 	if (error < 0)
 		goto out_acl;
 
-	if (pacl != NULL) {
-		if (acl->naces == 0) {
-			error = -ENODATA;
-			goto try_dpacl;
-		}
-
-		*pacl = _nfsv4_to_posix_one(acl, flags);
-		if (IS_ERR(*pacl)) {
-			error = PTR_ERR(*pacl);
-			*pacl = NULL;
-			goto out_acl;
-		}
+	if (acl->naces == 0) {
+		error = -ENODATA;
+		goto try_dpacl;
 	}
 
+	*pacl = _nfsv4_to_posix_one(acl, flags);
+	if (IS_ERR(*pacl)) {
+		error = PTR_ERR(*pacl);
+		*pacl = NULL;
+		goto out_acl;
+	}
 try_dpacl:
-	if (dpacl != NULL) {
-		if (dacl->naces == 0) {
-			if (pacl == NULL || *pacl == NULL)
-				error = -ENODATA;
-			goto out_acl;
-		}
-
-		error = 0;
-		*dpacl = _nfsv4_to_posix_one(dacl, flags);
-		if (IS_ERR(*dpacl)) {
-			error = PTR_ERR(*dpacl);
-			*dpacl = NULL;
-			goto out_acl;
-		}
+	if (dacl->naces == 0) {
+		if (pacl == NULL || *pacl == NULL)
+			error = -ENODATA;
+		goto out_acl;
 	}
 
+	error = 0;
+	*dpacl = _nfsv4_to_posix_one(dacl, flags);
+	if (IS_ERR(*dpacl)) {
+		error = PTR_ERR(*dpacl);
+		*dpacl = NULL;
+		goto out_acl;
+	}
 out_acl:
-	if (error && pacl) {
+	if (error) {
 		posix_acl_release(*pacl);
 		*pacl = NULL;
 	}
