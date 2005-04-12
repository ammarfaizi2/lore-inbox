Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVDLSkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVDLSkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDLSgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:36:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:8139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262302AbVDLKeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:08 -0400
Message-Id: <200504121033.j3CAXdO8005939@shell0.pdx.osdl.net>
Subject: [patch 194/198] nfsd4: fix struct file leak
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au,
       bfields@citi.umich.edu
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@cse.unsw.edu.au>

We were failing to close on an error path, resulting in a leak of struct files
which could take a v4 server down fairly quickly....  So call
nfs4_close_delegation instead of just open-coding parts of it.

Simplify the cleanup on delegation failure while we're at it.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/nfsd/nfs4state.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -puN fs/nfsd/nfs4state.c~nfsd4-fix-struct-file-leak fs/nfsd/nfs4state.c
--- 25/fs/nfsd/nfs4state.c~nfsd4-fix-struct-file-leak	2005-04-12 03:21:49.583599048 -0700
+++ 25-akpm/fs/nfsd/nfs4state.c	2005-04-12 03:21:49.589598136 -0700
@@ -190,7 +190,8 @@ nfs4_close_delegation(struct nfs4_delega
 	dp->dl_vfs_file = NULL;
 	/* The following nfsd_close may not actually close the file,
 	 * but we want to remove the lease in any case. */
-	setlease(filp, F_UNLCK, &dp->dl_flock);
+	if (dp->dl_flock)
+		setlease(filp, F_UNLCK, &dp->dl_flock);
 	nfsd_close(filp);
 	vfsclose++;
 }
@@ -1673,10 +1674,7 @@ nfs4_open_delegation(struct svc_fh *fh, 
 	if ((status = setlease(stp->st_vfs_file,
 		flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK, &flp))) {
 		dprintk("NFSD: setlease failed [%d], no delegation\n", status);
-		list_del(&dp->dl_del_perfile);
-		list_del(&dp->dl_del_perclnt);
-		nfs4_put_delegation(dp);
-		free_delegation++;
+		unhash_delegation(dp);
 		flag = NFS4_OPEN_DELEGATE_NONE;
 		goto out;
 	}
_
