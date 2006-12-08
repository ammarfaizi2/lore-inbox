Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164357AbWLHBQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164357AbWLHBQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164340AbWLHBOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:31 -0500
Received: from mail.suse.de ([195.135.220.2]:58527 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164339AbWLHBOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:18 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:30 +1100
Message-Id: <1061208011430.30713@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 013 of 18] knfsd: nfsd4: make verify and nverify wrappers
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Make wrappers for verify and nverify, for consistency with other ops.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:09:29.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:30.000000000 +1100
@@ -681,7 +681,7 @@ nfsd4_write(struct svc_rqst *rqstp, stru
  * to NFS_OK after the call; NVERIFY by mapping NFSERR_NOT_SAME to NFS_OK.
  */
 static __be32
-nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+_nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_verify *verify)
 {
 	__be32 *buf, *p;
@@ -733,6 +733,26 @@ out_kfree:
 	return status;
 }
 
+static __be32
+nfsd4_nverify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	      struct nfsd4_verify *verify)
+{
+	__be32 status;
+
+	status = _nfsd4_verify(rqstp, cstate, verify);
+	return status == nfserr_not_same ? nfs_ok : status;
+}
+
+static __be32
+nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     struct nfsd4_verify *verify)
+{
+	__be32 status;
+
+	status = _nfsd4_verify(rqstp, cstate, verify);
+	return status == nfserr_same ? nfs_ok : status;
+}
+
 /*
  * NULL call.
  */
@@ -911,10 +931,8 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 			op->status = nfsd4_lookupp(rqstp, cstate);
 			break;
 		case OP_NVERIFY:
-			op->status = nfsd4_verify(rqstp, cstate,
+			op->status = nfsd4_nverify(rqstp, cstate,
 						  &op->u.nverify);
-			if (op->status == nfserr_not_same)
-				op->status = nfs_ok;
 			break;
 		case OP_OPEN:
 			op->status = nfsd4_open(rqstp, cstate,
@@ -975,8 +993,6 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		case OP_VERIFY:
 			op->status = nfsd4_verify(rqstp, cstate,
 						  &op->u.verify);
-			if (op->status == nfserr_same)
-				op->status = nfs_ok;
 			break;
 		case OP_WRITE:
 			op->status = nfsd4_write(rqstp, cstate, &op->u.write);
