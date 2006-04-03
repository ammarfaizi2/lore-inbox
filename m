Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWDCFUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWDCFUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWDCFUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:38581 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751443AbWDCFUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:06 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:18 +1000
Message-Id: <1060403051818.1757@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 16] knfsd: nfsd4: better nfs4acl errors
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're returning -1 in a few places in the NFSv4<->POSIX acl translation
code where we could return a reasonable error.

Also allows some minor simplification elsewhere.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |    6 +++---
 ./fs/nfsd/nfs4xdr.c |    7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfs4acl.c~current~ ./fs/nfsd/nfs4acl.c
--- ./fs/nfsd/nfs4acl.c~current~	2006-04-03 15:12:05.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-04-03 15:12:06.000000000 +1000
@@ -710,9 +710,9 @@ calculate_posix_ace_count(struct nfs4_ac
 		/* Also, the remaining entries are for named users and
 		 * groups, and come in threes (mask, allow, deny): */
 		if (n4acl->naces < 7)
-			return -1;
+			return -EINVAL;
 		if ((n4acl->naces - 7) % 3)
-			return -1;
+			return -EINVAL;
 		return 4 + (n4acl->naces - 7)/3;
 	}
 }
@@ -866,7 +866,7 @@ nfs4_acl_add_ace(struct nfs4_acl *acl, u
 	struct nfs4_ace *ace;
 
 	if ((ace = kmalloc(sizeof(*ace), GFP_KERNEL)) == NULL)
-		return -1;
+		return -ENOMEM;
 
 	ace->type = type;
 	ace->flag = flag;

diff ./fs/nfsd/nfs4xdr.c~current~ ./fs/nfsd/nfs4xdr.c
--- ./fs/nfsd/nfs4xdr.c~current~	2006-04-03 15:12:06.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-04-03 15:12:06.000000000 +1000
@@ -299,11 +299,10 @@ nfsd4_decode_fattr(struct nfsd4_compound
 						buf, dummy32, &ace.who);
 			if (status)
 				goto out_nfserr;
-			if (nfs4_acl_add_ace(*acl, ace.type, ace.flag,
-				 ace.access_mask, ace.whotype, ace.who) != 0) {
-				status = -ENOMEM;
+			status = nfs4_acl_add_ace(*acl, ace.type, ace.flag,
+				 ace.access_mask, ace.whotype, ace.who);
+			if (status)
 				goto out_nfserr;
-			}
 		}
 	} else
 		*acl = NULL;
