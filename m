Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWG1Jns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWG1Jns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWG1Jns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:43:48 -0400
Received: from mx1.suse.de ([195.135.220.2]:28348 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751079AbWG1Jnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:43:47 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 19:42:55 +1000
Message-Id: <1060728094255.7278@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] knfsd: Fix stale file handle problem with subtree_checking.
References: <20060728194103.7245.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a bug that was introduced since 2.6.17,
and should go in 2.6.18.

### Comments for Changeset

A recent patch:

  h=7fc90ec93a5eb71f4b08403baf5ba7176b3ec6b1

moved the call to nfsd_setuser out of the 'find a dentry for a
filehandle' branch of fh_verify so that it would always be called.

This had the unfortunately side-effect of moving *after* the call
to decode_fh, so the prober fsuid was not set when nfsd_acceptable
was called, the 'permission' check did the wrong thing.

This patch moves the nfsd_setuser call back where it was, and add as
call in the other branch of the if.

Cc: "J. Bruce Fields" <bfields@fieldses.org>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsfh.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff .prev/fs/nfsd/nfsfh.c ./fs/nfsd/nfsfh.c
--- .prev/fs/nfsd/nfsfh.c	2006-07-28 19:14:17.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2006-07-28 19:14:36.000000000 +1000
@@ -187,6 +187,11 @@ fh_verify(struct svc_rqst *rqstp, struct
 			goto out;
 		}
 
+		/* Set user creds for this exportpoint */
+		error = nfserrno(nfsd_setuser(rqstp, exp));
+		if (error)
+			goto out;
+
 		/*
 		 * Look up the dentry using the NFS file handle.
 		 */
@@ -241,16 +246,17 @@ fh_verify(struct svc_rqst *rqstp, struct
 		dprintk("nfsd: fh_verify - just checking\n");
 		dentry = fhp->fh_dentry;
 		exp = fhp->fh_export;
+		/* Set user creds for this exportpoint; necessary even
+		 * in the "just checking" case because this may be a
+		 * filehandle that was created by fh_compose, and that
+		 * is about to be used in another nfsv4 compound
+		 * operation */
+		error = nfserrno(nfsd_setuser(rqstp, exp));
+		if (error)
+			goto out;
 	}
 	cache_get(&exp->h);
 
-	/* Set user creds for this exportpoint; necessary even in the "just
-	 * checking" case because this may be a filehandle that was created by
-	 * fh_compose, and that is about to be used in another nfsv4 compound
-	 * operation */
-	error = nfserrno(nfsd_setuser(rqstp, exp));
-	if (error)
-		goto out;
 
 	error = nfsd_mode_check(rqstp, dentry->d_inode->i_mode, type);
 	if (error)
