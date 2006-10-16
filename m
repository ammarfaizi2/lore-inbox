Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWJPXaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWJPXaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWJPXaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:40135 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422928AbWJPXaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:09 +1000
Message-Id: <1061016233009.11318@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 5] knfsd: nfsd4: fix owner-override on open
References: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "J. Bruce Fields" <bfields@fieldses.org>
If a client creates a file using an open which sets the mode to 000, or if
a chmod changes permissions after a file is opened, then situations may
arise where an NFS client knows that some IO is permitted (because a
process holds the file open), but the NFS server does not (because it
doesn't know about the open, and only sees that the IO conflicts with the
current mode of the file).

As a hack to solve this problem, NFS servers normally allow the owner to
override permissions on IO.  The client can still enforce correct
permissions-checking on open by performing an explicit access check.

In NFSv4 the client can rely on the explicit on-the-wire open instead of an
access check.

Therefore we should not be allowing the owner to override permissions on an
over-the-wire open!

However, we should still allow the owner to override permissions in the case
where the client is claiming an open that it already made either before a
reboot, or while it was holding a delegation.

Thanks to Jim Rees for reporting the bug.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-10-17 09:02:22.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-10-17 09:02:26.000000000 +1000
@@ -68,20 +68,18 @@ fh_dup2(struct svc_fh *dst, struct svc_f
 }
 
 static int
-do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, int accmode)
 {
-	int accmode, status;
+	int status;
 
 	if (open->op_truncate &&
 		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
 
-	accmode = MAY_NOP;
 	if (open->op_share_access & NFS4_SHARE_ACCESS_READ)
-		accmode = MAY_READ;
+		accmode |= MAY_READ;
 	if (open->op_share_deny & NFS4_SHARE_ACCESS_WRITE)
 		accmode |= (MAY_WRITE | MAY_TRUNC);
-	accmode |= MAY_OWNER_OVERRIDE;
 
 	status = fh_verify(rqstp, current_fh, S_IFREG, accmode);
 
@@ -124,7 +122,7 @@ do_open_lookup(struct svc_rqst *rqstp, s
 				&resfh.fh_handle.fh_base,
 				resfh.fh_handle.fh_size);
 
-		status = do_open_permission(rqstp, current_fh, open);
+		status = do_open_permission(rqstp, current_fh, open, MAY_NOP);
 	}
 
 	fh_put(&resfh);
@@ -155,7 +153,7 @@ do_open_fhandle(struct svc_rqst *rqstp, 
 	open->op_truncate = (open->op_iattr.ia_valid & ATTR_SIZE) &&
 		(open->op_iattr.ia_size == 0);
 
-	status = do_open_permission(rqstp, current_fh, open);
+	status = do_open_permission(rqstp, current_fh, open, MAY_OWNER_OVERRIDE);
 
 	return status;
 }
