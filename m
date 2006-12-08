Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164317AbWLHBOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164317AbWLHBOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164328AbWLHBNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47167 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164325AbWLHBNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:39 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:51 +1100
Message-Id: <1061208011351.30627@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 18] knfsd: nfsd4: handling more nfsd_cross_mnt errors in nfsd4 readdir
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

This patch on its own causes no change in behavior, since nfsd_cross_mnt()
only returns -EAGAIN; but in the future I'd like it to also be able to
return -ETIMEDOUT, so we may as well handle any possible error here.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4xdr.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-12-08 12:07:28.000000000 +1100
+++ ./fs/nfsd/nfs4xdr.c	2006-12-08 12:08:31.000000000 +1100
@@ -1845,15 +1845,11 @@ nfsd4_encode_dirent_fattr(struct nfsd4_r
 
 	exp_get(exp);
 	if (d_mountpoint(dentry)) {
-		if (nfsd_cross_mnt(cd->rd_rqstp, &dentry, &exp)) {
-		/*
-		 * -EAGAIN is the only error returned from
-		 * nfsd_cross_mnt() and it indicates that an
-		 * up-call has  been initiated to fill in the export
-		 * options on exp.  When the answer comes back,
-		 * this call will be retried.
-		 */
-			nfserr = nfserr_dropit;
+		int err;
+
+		err = nfsd_cross_mnt(cd->rd_rqstp, &dentry, &exp);
+		if (err) {
+			nfserr = nfserrno(err);
 			goto out_put;
 		}
 
