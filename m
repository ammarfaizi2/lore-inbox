Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164325AbWLHBPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164325AbWLHBPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164349AbWLHBOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:58592 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164350AbWLHBOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:44 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:56 +1100
Message-Id: <1061208011456.30773@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 018 of 18] knfsd: Fix up some bit-rot in exp_export
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The nfsservctl systemcall isn't used but recent nfs-utils releases for
exporting filesystems, and consequently the code that is uses -
exp_export - has suffered some bitrot.

Particular:
  - some newly added fields in 'struct svc_export' are being initialised
    properly.
  - the return value is now always -ENOMEM ...

This patch fixes both these problems.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-08 12:08:37.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-08 12:09:31.000000000 +1100
@@ -955,6 +955,8 @@ exp_export(struct nfsctl_export *nxp)
 
 	exp = exp_get_by_name(clp, nd.mnt, nd.dentry, NULL);
 
+	memset(&new, 0, sizeof(new));
+
 	/* must make sure there won't be an ex_fsid clash */
 	if ((nxp->ex_flags & NFSEXP_FSID) &&
 	    (fsid_key = exp_get_fsid_key(clp, nxp->ex_dev)) &&
@@ -985,6 +987,9 @@ exp_export(struct nfsctl_export *nxp)
 
 	new.h.expiry_time = NEVER;
 	new.h.flags = 0;
+	new.ex_path = kstrdup(nxp->ex_path, GFP_KERNEL);
+	if (! new.ex_path)
+		goto finish;
 	new.ex_client = clp;
 	new.ex_mnt = nd.mnt;
 	new.ex_dentry = nd.dentry;
@@ -1005,10 +1010,11 @@ exp_export(struct nfsctl_export *nxp)
 		/* failed to create at least one index */
 		exp_do_unexport(exp);
 		cache_flush();
-		err = -ENOMEM;
-	}
-
+	} else
+		err = 0;
 finish:
+	if (new.ex_path)
+		kfree(new.ex_path);
 	if (exp)
 		exp_put(exp);
 	if (fsid_key && !IS_ERR(fsid_key))
