Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWIDXQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWIDXQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIDXPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36781 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932237AbWIDXPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:39 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:32 +1000
Message-Id: <1060904231532.23071@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 9] knfsd: svcrpc: gss: fix failure on SVC_DENIED in integrity case
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

If the request is denied after gss_accept was called, we shouldn't try to
wrap the reply.  We were checking the accept_stat but not the reply_stat.

To check the reply_stat in _release, we need a pointer to before (rather
than after) the verifier, so modify body_start appropriately.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-09-04 17:12:31.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-09-04 17:13:17.000000000 +1000
@@ -903,9 +903,9 @@ out_seq:
 struct gss_svc_data {
 	/* decoded gss client cred: */
 	struct rpc_gss_wire_cred	clcred;
-	/* pointer to the beginning of the procedure-specific results,
-	 * which may be encrypted/checksummed in svcauth_gss_release: */
-	u32				*body_start;
+	/* save a pointer to the beginning of the encoded verifier,
+	 * for use in encryption/checksumming in svcauth_gss_release: */
+	u32				*verf_start;
 	struct rsc			*rsci;
 };
 
@@ -968,7 +968,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 	if (!svcdata)
 		goto auth_err;
 	rqstp->rq_auth_data = svcdata;
-	svcdata->body_start = NULL;
+	svcdata->verf_start = NULL;
 	svcdata->rsci = NULL;
 	gc = &svcdata->clcred;
 
@@ -1097,6 +1097,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 		goto complete;
 	case RPC_GSS_PROC_DATA:
 		*authp = rpcsec_gsserr_ctxproblem;
+		svcdata->verf_start = resv->iov_base + resv->iov_len;
 		if (gss_write_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
 		rqstp->rq_cred = rsci->cred;
@@ -1110,7 +1111,6 @@ svcauth_gss_accept(struct svc_rqst *rqst
 					gc->gc_seq, rsci->mechctx))
 				goto auth_err;
 			/* placeholders for length and seq. number: */
-			svcdata->body_start = resv->iov_base + resv->iov_len;
 			svc_putu32(resv, 0);
 			svc_putu32(resv, 0);
 			break;
@@ -1119,7 +1119,6 @@ svcauth_gss_accept(struct svc_rqst *rqst
 					gc->gc_seq, rsci->mechctx))
 				goto auth_err;
 			/* placeholders for length and seq. number: */
-			svcdata->body_start = resv->iov_base + resv->iov_len;
 			svc_putu32(resv, 0);
 			svc_putu32(resv, 0);
 			break;
@@ -1150,14 +1149,21 @@ out:
 u32 *
 svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
 {
-	u32 *p;
+	u32 *p, verf_len;
+
+	p = gsd->verf_start;
+	gsd->verf_start = NULL;
 
-	p = gsd->body_start;
-	gsd->body_start = NULL;
+	/* If the reply stat is nonzero, don't wrap: */
+	if (*(p-1) != rpc_success)
+		return NULL;
+	/* Skip the verifier: */
+	p += 1;
+	verf_len = ntohl(*p++);
+	p += XDR_QUADLEN(verf_len);
 	/* move accept_stat to right place: */
 	memcpy(p, p + 2, 4);
-	/* Don't wrap in failure case: */
-	/* Counting on not getting here if call was not even accepted! */
+	/* Also don't wrap if the accept stat is nonzero: */
 	if (*p != rpc_success) {
 		resbuf->head[0].iov_len -= 2 * 4;
 		return NULL;
@@ -1283,7 +1289,7 @@ svcauth_gss_release(struct svc_rqst *rqs
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;
 	/* Release can be called twice, but we only wrap once. */
-	if (gsd->body_start == NULL)
+	if (gsd->verf_start == NULL)
 		goto out;
 	/* normally not set till svc_send, but we need it here: */
 	/* XXX: what for?  Do we mess it up the moment we call svc_putu32
