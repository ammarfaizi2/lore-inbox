Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWDCFVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWDCFVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWDCFUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:47 -0400
Received: from ns1.suse.de ([195.135.220.2]:41653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964842AbWDCFUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:33 +1000
Message-Id: <1060403051833.1797@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 16] knfsd: nfsd: nfsd_setuser doesn't really need to modify rqstp->rq_cred.
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In addition to setting the processes filesystem id's, nfsd_setuser also
modifies the value of the rq_cred which stores the id's that originally
came from the rpc call, for example to reflect root squashing.

There's no real reason to do that--the only case where rqstp->rq_cred 
is actually used later on is in the NFSv4 SETCLIENTID/SETCLIENTID_CONFIRM
operations, and there the results are the opposite of what we want--those
two operations don't deal with the filesystem at all, they only record the
credentials used with the rpc call for later reference (so that we may
require the same credentials be used on later operations), and the
credentials shouldn't vary just because there was or wasn't a previous
operation in the compound that referred to some export  

This fixes a bug which caused mounts from Solaris clients to fail.

Signed-off-by: Andy Adamson <andros@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/auth.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff ./fs/nfsd/auth.c~current~ ./fs/nfsd/auth.c
--- ./fs/nfsd/auth.c~current~	2006-04-03 15:12:09.000000000 +1000
+++ ./fs/nfsd/auth.c	2006-04-03 15:12:09.000000000 +1000
@@ -14,46 +14,46 @@
 
 int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
-	struct svc_cred	*cred = &rqstp->rq_cred;
+	struct svc_cred	cred = rqstp->rq_cred;
 	int i;
 	int ret;
 
 	if (exp->ex_flags & NFSEXP_ALLSQUASH) {
-		cred->cr_uid = exp->ex_anon_uid;
-		cred->cr_gid = exp->ex_anon_gid;
-		put_group_info(cred->cr_group_info);
-		cred->cr_group_info = groups_alloc(0);
+		cred.cr_uid = exp->ex_anon_uid;
+		cred.cr_gid = exp->ex_anon_gid;
+		cred.cr_group_info = groups_alloc(0);
 	} else if (exp->ex_flags & NFSEXP_ROOTSQUASH) {
 		struct group_info *gi;
-		if (!cred->cr_uid)
-			cred->cr_uid = exp->ex_anon_uid;
-		if (!cred->cr_gid)
-			cred->cr_gid = exp->ex_anon_gid;
-		gi = groups_alloc(cred->cr_group_info->ngroups);
+		if (!cred.cr_uid)
+			cred.cr_uid = exp->ex_anon_uid;
+		if (!cred.cr_gid)
+			cred.cr_gid = exp->ex_anon_gid;
+		gi = groups_alloc(cred.cr_group_info->ngroups);
 		if (gi)
-			for (i = 0; i < cred->cr_group_info->ngroups; i++) {
-				if (!GROUP_AT(cred->cr_group_info, i))
+			for (i = 0; i < cred.cr_group_info->ngroups; i++) {
+				if (!GROUP_AT(cred.cr_group_info, i))
 					GROUP_AT(gi, i) = exp->ex_anon_gid;
 				else
-					GROUP_AT(gi, i) = GROUP_AT(cred->cr_group_info, i);
+					GROUP_AT(gi, i) = GROUP_AT(cred.cr_group_info, i);
 			}
-		put_group_info(cred->cr_group_info);
-		cred->cr_group_info = gi;
-	}
+		cred.cr_group_info = gi;
+	} else
+		get_group_info(cred.cr_group_info);
 
-	if (cred->cr_uid != (uid_t) -1)
-		current->fsuid = cred->cr_uid;
+	if (cred.cr_uid != (uid_t) -1)
+		current->fsuid = cred.cr_uid;
 	else
 		current->fsuid = exp->ex_anon_uid;
-	if (cred->cr_gid != (gid_t) -1)
-		current->fsgid = cred->cr_gid;
+	if (cred.cr_gid != (gid_t) -1)
+		current->fsgid = cred.cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
 
-	if (!cred->cr_group_info)
+	if (!cred.cr_group_info)
 		return -ENOMEM;
-	ret = set_current_groups(cred->cr_group_info);
-	if ((cred->cr_uid)) {
+	ret = set_current_groups(cred.cr_group_info);
+	put_group_info(cred.cr_group_info);
+	if ((cred.cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
 	} else {
 		cap_t(current->cap_effective) |= (CAP_NFSD_MASK &
