Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030743AbWF0HVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030743AbWF0HVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030744AbWF0HVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:21:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:4519 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030743AbWF0HUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:44 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:37 +1000
Message-Id: <1060627072037.26733@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 14] knfsd: svcrpc: Simplify nfsd rpcsec_gss integrity code
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


Pull out some of the integrity code into its own function, otherwise
svcauth_gss_release() is going to become very ungainly after the addition
of privacy code.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |  115 ++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 51 deletions(-)

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 14:59:44.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 15:05:11.000000000 +1000
@@ -1072,8 +1072,8 @@ out:
 	return ret;
 }
 
-static int
-svcauth_gss_release(struct svc_rqst *rqstp)
+static inline int
+svcauth_gss_wrap_resp_integ(struct svc_rqst *rqstp)
 {
 	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
@@ -1085,6 +1085,67 @@ svcauth_gss_release(struct svc_rqst *rqs
 	int integ_offset, integ_len;
 	int stat = -EINVAL;
 
+	p = gsd->body_start;
+	gsd->body_start = NULL;
+	/* move accept_stat to right place: */
+	memcpy(p, p + 2, 4);
+	/* don't wrap in failure case: */
+	/* Note: counting on not getting here if call was not even
+	 * accepted! */
+	if (*p != rpc_success) {
+		resbuf->head[0].iov_len -= 2 * 4;
+		goto out;
+	}
+	p++;
+	integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
+	integ_len = resbuf->len - integ_offset;
+	BUG_ON(integ_len % 4);
+	*p++ = htonl(integ_len);
+	*p++ = htonl(gc->gc_seq);
+	if (xdr_buf_subsegment(resbuf, &integ_buf, integ_offset,
+				integ_len))
+		BUG();
+	if (resbuf->page_len == 0
+			&& resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE
+			< PAGE_SIZE) {
+		BUG_ON(resbuf->tail[0].iov_len);
+		/* Use head for everything */
+		resv = &resbuf->head[0];
+	} else if (resbuf->tail[0].iov_base == NULL) {
+		if (resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+			goto out_err;
+		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
+						+ resbuf->head[0].iov_len;
+		resbuf->tail[0].iov_len = 0;
+		rqstp->rq_restailpage = 0;
+		resv = &resbuf->tail[0];
+	} else {
+		resv = &resbuf->tail[0];
+	}
+	mic.data = (u8 *)resv->iov_base + resv->iov_len + 4;
+	if (gss_get_mic(gsd->rsci->mechctx, &integ_buf, &mic))
+		goto out_err;
+	svc_putu32(resv, htonl(mic.len));
+	memset(mic.data + mic.len, 0,
+			round_up_to_quad(mic.len) - mic.len);
+	resv->iov_len += XDR_QUADLEN(mic.len) << 2;
+	/* not strictly required: */
+	resbuf->len += XDR_QUADLEN(mic.len) << 2;
+	BUG_ON(resv->iov_len > PAGE_SIZE);
+out:
+	stat = 0;
+out_err:
+	return stat;
+}
+
+static int
+svcauth_gss_release(struct svc_rqst *rqstp)
+{
+	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
+	struct rpc_gss_wire_cred *gc = &gsd->clcred;
+	struct xdr_buf *resbuf = &rqstp->rq_res;
+	int stat = -EINVAL;
+
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;
 	/* Release can be called twice, but we only wrap once. */
@@ -1097,55 +1158,7 @@ svcauth_gss_release(struct svc_rqst *rqs
 	case RPC_GSS_SVC_NONE:
 		break;
 	case RPC_GSS_SVC_INTEGRITY:
-		p = gsd->body_start;
-		gsd->body_start = NULL;
-		/* move accept_stat to right place: */
-		memcpy(p, p + 2, 4);
-		/* don't wrap in failure case: */
-		/* Note: counting on not getting here if call was not even
-		 * accepted! */
-		if (*p != rpc_success) {
-			resbuf->head[0].iov_len -= 2 * 4;
-			goto out;
-		}
-		p++;
-		integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
-		integ_len = resbuf->len - integ_offset;
-		BUG_ON(integ_len % 4);
-		*p++ = htonl(integ_len);
-		*p++ = htonl(gc->gc_seq);
-		if (xdr_buf_subsegment(resbuf, &integ_buf, integ_offset,
-					integ_len))
-			BUG();
-		if (resbuf->page_len == 0
-			&& resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE
-				< PAGE_SIZE) {
-			BUG_ON(resbuf->tail[0].iov_len);
-			/* Use head for everything */
-			resv = &resbuf->head[0];
-		} else if (resbuf->tail[0].iov_base == NULL) {
-			if (resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE
-					> PAGE_SIZE)
-				goto out_err;
-			resbuf->tail[0].iov_base =
-				resbuf->head[0].iov_base
-				+ resbuf->head[0].iov_len;
-			resbuf->tail[0].iov_len = 0;
-			rqstp->rq_restailpage = 0;
-			resv = &resbuf->tail[0];
-		} else {
-			resv = &resbuf->tail[0];
-		}
-		mic.data = (u8 *)resv->iov_base + resv->iov_len + 4;
-		if (gss_get_mic(gsd->rsci->mechctx, &integ_buf, &mic))
-			goto out_err;
-		svc_putu32(resv, htonl(mic.len));
-		memset(mic.data + mic.len, 0,
-				round_up_to_quad(mic.len) - mic.len);
-		resv->iov_len += XDR_QUADLEN(mic.len) << 2;
-		/* not strictly required: */
-		resbuf->len += XDR_QUADLEN(mic.len) << 2;
-		BUG_ON(resv->iov_len > PAGE_SIZE);
+		svcauth_gss_wrap_resp_integ(rqstp);
 		break;
 	case RPC_GSS_SVC_PRIVACY:
 	default:
