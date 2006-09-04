Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWIDXPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWIDXPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWIDXPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:15:51 -0400
Received: from mail.suse.de ([195.135.220.2]:27341 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932240AbWIDXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:43 +1000
Message-Id: <1060904231543.23100@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 9] knfsd: nfsd4: refactor exp_pseudoroot
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

We could be using more common code in exp_pseudoroot().  This will also
simplify some changes we need to make later.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-09-04 17:09:49.000000000 +1000
+++ ./fs/nfsd/export.c	2006-09-04 17:18:25.000000000 +1000
@@ -1048,30 +1048,24 @@ int
 exp_pseudoroot(struct auth_domain *clp, struct svc_fh *fhp,
 	       struct cache_req *creq)
 {
-	struct svc_expkey *fsid_key;
 	struct svc_export *exp;
 	int rv;
 	u32 fsidv[2];
 
 	mk_fsid_v1(fsidv, 0);
 
-	fsid_key = exp_find_key(clp, 1, fsidv, creq);
-	if (IS_ERR(fsid_key) && PTR_ERR(fsid_key) == -EAGAIN)
+	exp = exp_find(clp, 1, fsidv, creq);
+	if (IS_ERR(exp) && PTR_ERR(exp) == -EAGAIN)
 		return nfserr_dropit;
-	if (!fsid_key || IS_ERR(fsid_key))
-		return nfserr_perm;
-
-	exp = exp_get_by_name(clp, fsid_key->ek_mnt, fsid_key->ek_dentry, creq);
 	if (exp == NULL)
 		rv = nfserr_perm;
 	else if (IS_ERR(exp))
 		rv = nfserrno(PTR_ERR(exp));
 	else {
 		rv = fh_compose(fhp, exp,
-				fsid_key->ek_dentry, NULL);
+				exp->ex_dentry, NULL);
 		exp_put(exp);
 	}
-	cache_put(&fsid_key->h, &svc_expkey_cache);
 	return rv;
 }
 
