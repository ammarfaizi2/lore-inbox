Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWJPXbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWJPXbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJPXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41415 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422929AbWJPXaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:15 +1000
Message-Id: <1061016233015.11330@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 5] knfsd: nfsd4: fix open permission checking
References: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "J. Bruce Fields" <bfields@fieldses.org>
We weren't actually checking for SHARE_ACCESS_WRITE, with the result that
the owner could open a non-writeable file for write!

Continue to allow DENY_WRITE only with write access.

Thanks to Jim Rees for reporting the bug.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-10-17 09:02:26.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-10-17 09:04:13.000000000 +1000
@@ -78,8 +78,10 @@ do_open_permission(struct svc_rqst *rqst
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_READ)
 		accmode |= MAY_READ;
-	if (open->op_share_deny & NFS4_SHARE_ACCESS_WRITE)
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
 		accmode |= (MAY_WRITE | MAY_TRUNC);
+	if (open->op_share_deny & NFS4_SHARE_DENY_WRITE)
+		accmode |= MAY_WRITE;
 
 	status = fh_verify(rqstp, current_fh, S_IFREG, accmode);
 
