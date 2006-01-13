Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161638AbWAMDOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161638AbWAMDOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161641AbWAMDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:14:36 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:30893 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1161638AbWAMDOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:14:36 -0500
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Jan 2006 14:14:28 +1100
Message-Id: <1060113031428.4660@cse.unsw.edu.au>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH kNFSd 002 of 3] Fix some more errno/nfserr confusion in vfs.c
References: <20060113141059.4573.patches@notabene>
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@suse.de>

nfsd_sync* return an errno, which usually needs to be converted to an errno,
sometimes immediately, sometimes a little later.

Also, nfsd_setattr returns an nfserr which SHOULDN'T be converted from
an errno (because it isn't one).

Also some tidyups of the form:
  err = XX
  err = nfserrno(err)
and
  err = XX
  if (err)
      err = nfserrno(err)
become
  err = nfserrno(XX)

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/vfs.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2006-01-13 12:37:26.000000000 +1100
+++ ./fs/nfsd/vfs.c	2006-01-13 13:20:55.000000000 +1100
@@ -891,9 +891,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	int			err = 0;
 	int			stable = *stablep;
 
+#ifdef MSNFS
 	err = nfserr_perm;
 
-#ifdef MSNFS
 	if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 		(!lock_may_write(file->f_dentry->d_inode, offset, cnt)))
 		goto out;
@@ -1065,8 +1065,7 @@ nfsd_commit(struct svc_rqst *rqstp, stru
 		return err;
 	if (EX_ISSYNC(fhp->fh_export)) {
 		if (file->f_op && file->f_op->fsync) {
-			err = nfsd_sync(file);
-			err = nfserrno(err);
+			err = nfserrno(nfsd_sync(file));
 		} else {
 			err = nfserr_notsupp;
 		}
@@ -1177,7 +1176,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 		goto out_nfserr;
 
 	if (EX_ISSYNC(fhp->fh_export)) {
-		err = nfsd_sync_dir(dentry);
+		err = nfserrno(nfsd_sync_dir(dentry));
 		write_inode_now(dchild->d_inode, 1);
 	}
 
@@ -1310,9 +1309,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 		goto out_nfserr;
 
 	if (EX_ISSYNC(fhp->fh_export)) {
-		err = nfsd_sync_dir(dentry);
-		if (err)
-			err = nfserrno(err);
+		err = nfserrno(nfsd_sync_dir(dentry));
 		/* setattr will sync the child (or not) */
 	}
 
@@ -1339,7 +1336,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	if ((iap->ia_valid &= ~(ATTR_UID|ATTR_GID)) != 0) {
  		int err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
 		if (err2)
-			err = nfserrno(err2);
+			err = err2;
 	}
 
 	/*
@@ -1514,10 +1511,8 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	err = vfs_link(dold, dirp, dnew);
 	if (!err) {
 		if (EX_ISSYNC(ffhp->fh_export)) {
-			err = nfsd_sync_dir(ddir);
+			err = nfserrno(nfsd_sync_dir(ddir));
 			write_inode_now(dest, 1);
-			if (err)
-				err = nfserrno(err);
 		}
 	} else {
 		if (err == -EXDEV && rqstp->rq_vers == 2)
