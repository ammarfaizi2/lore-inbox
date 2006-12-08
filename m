Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164359AbWLHBSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164359AbWLHBSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164346AbWLHBRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:17:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:47290 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164343AbWLHBO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:28 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:41 +1100
Message-Id: <1061208011441.30737@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 015 of 18] knfsd: nfsd4: simplify migration op check
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

I'm not too fond of these big if conditions.  Replace them by checks of a
flag in the operation descriptor.  To my eye this makes the code a bit more
self-documenting, and makes the complicated part of the code
(proc_compound) a little more compact.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:09:30.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:30.000000000 +1100
@@ -802,6 +802,8 @@ typedef __be32(*nfsd4op_func)(struct svc
 struct nfsd4_operation {
 	nfsd4op_func op_func;
 	u32 op_flags;
+/* GETATTR and ops not listed as returning NFS4ERR_MOVED: */
+#define ALLOWED_ON_ABSENT_FS 1
 };
 
 static struct nfsd4_operation nfsd4_ops[];
@@ -887,17 +889,8 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
 			}
-		}
-		/* Check must be done at start of each operation, except
-		 * for GETATTR and ops not listed as returning NFS4ERR_MOVED
-		 */
-		else if (cstate->current_fh.fh_export->ex_fslocs.migrated &&
-			 !((op->opnum == OP_GETATTR) ||
-			   (op->opnum == OP_PUTROOTFH) ||
-			   (op->opnum == OP_PUTPUBFH) ||
-			   (op->opnum == OP_RENEW) ||
-			   (op->opnum == OP_SETCLIENTID) ||
-			   (op->opnum == OP_RELEASE_LOCKOWNER))) {
+		} else if (cstate->current_fh.fh_export->ex_fslocs.migrated &&
+			  !(opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
 			op->status = nfserr_moved;
 			goto encode_op;
 		}
@@ -951,6 +944,7 @@ static struct nfsd4_operation nfsd4_ops[
 	},
 	[OP_GETATTR] = {
 		.op_func = (nfsd4op_func)nfsd4_getattr,
+		.op_flags = ALLOWED_ON_ABSENT_FS,
 	},
 	[OP_GETFH] = {
 		.op_func = (nfsd4op_func)nfsd4_getfh,
@@ -988,8 +982,13 @@ static struct nfsd4_operation nfsd4_ops[
 	[OP_PUTFH] = {
 		.op_func = (nfsd4op_func)nfsd4_putfh,
 	},
+	[OP_PUTPUBFH] = {
+		/* unsupported; just for future reference: */
+		.op_flags = ALLOWED_ON_ABSENT_FS,
+	},
 	[OP_PUTROOTFH] = {
 		.op_func = (nfsd4op_func)nfsd4_putrootfh,
+		.op_flags = ALLOWED_ON_ABSENT_FS,
 	},
 	[OP_READ] = {
 		.op_func = (nfsd4op_func)nfsd4_read,
@@ -1008,6 +1007,7 @@ static struct nfsd4_operation nfsd4_ops[
 	},
 	[OP_RENEW] = {
 		.op_func = (nfsd4op_func)nfsd4_renew,
+		.op_flags = ALLOWED_ON_ABSENT_FS,
 	},
 	[OP_RESTOREFH] = {
 		.op_func = (nfsd4op_func)nfsd4_restorefh,
@@ -1020,6 +1020,7 @@ static struct nfsd4_operation nfsd4_ops[
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = (nfsd4op_func)nfsd4_setclientid,
+		.op_flags = ALLOWED_ON_ABSENT_FS,
 	},
 	[OP_SETCLIENTID_CONFIRM] = {
 		.op_func = (nfsd4op_func)nfsd4_setclientid_confirm,
@@ -1032,6 +1033,7 @@ static struct nfsd4_operation nfsd4_ops[
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = (nfsd4op_func)nfsd4_release_lockowner,
+		.op_flags = ALLOWED_ON_ABSENT_FS,
 	},
 };
 
