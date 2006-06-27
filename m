Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030736AbWF0HWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbWF0HWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWF0HU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:5799 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030744AbWF0HUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:55 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:48 +1000
Message-Id: <1060627072048.26757@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 014 of 14] knfsd: svcrpc: gss: server-side implementation of rpcsec_gss privacy.
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


Server-side implementation of rpcsec_gss privacy, which enables encryption
of the payload of every rpc request and response.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |  154 ++++++++++++++++++++++++++++++++++--
 ./net/sunrpc/svc.c                  |    1 
 2 files changed, 148 insertions(+), 7 deletions(-)

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 15:05:11.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 15:07:54.000000000 +1000
@@ -832,6 +832,74 @@ out:
 	return stat;
 }
 
+static inline int
+total_buf_len(struct xdr_buf *buf)
+{
+	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
+}
+
+static void
+fix_priv_head(struct xdr_buf *buf, int pad)
+{
+	if (buf->page_len == 0) {
+		/* We need to adjust head and buf->len in tandem in this
+		 * case to make svc_defer() work--it finds the original
+		 * buffer start using buf->len - buf->head[0].iov_len. */
+		buf->head[0].iov_len -= pad;
+	}
+}
+
+static int
+unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
+{
+	u32 priv_len, maj_stat;
+	int pad, saved_len, remaining_len, offset;
+
+	rqstp->rq_sendfile_ok = 0;
+
+	priv_len = ntohl(svc_getu32(&buf->head[0]));
+	if (rqstp->rq_deferred) {
+		/* Already decrypted last time through! The sequence number
+		 * check at out_seq is unnecessary but harmless: */
+		goto out_seq;
+	}
+	/* buf->len is the number of bytes from the original start of the
+	 * request to the end, where head[0].iov_len is just the bytes
+	 * not yet read from the head, so these two values are different: */
+	remaining_len = total_buf_len(buf);
+	if (priv_len > remaining_len)
+		return -EINVAL;
+	pad = remaining_len - priv_len;
+	buf->len -= pad;
+	fix_priv_head(buf, pad);
+
+	/* Maybe it would be better to give gss_unwrap a length parameter: */
+	saved_len = buf->len;
+	buf->len = priv_len;
+	maj_stat = gss_unwrap(ctx, 0, buf);
+	pad = priv_len - buf->len;
+	buf->len = saved_len;
+	buf->len -= pad;
+	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
+	 * In the krb5p case, at least, the data ends up offset, so we need to
+	 * move it around. */
+	/* XXX: This is very inefficient.  It would be better to either do
+	 * this while we encrypt, or maybe in the receive code, if we can peak
+	 * ahead and work out the service and mechanism there. */
+	offset = buf->head[0].iov_len % 4;
+	if (offset) {
+		buf->buflen = RPCSVC_MAXPAYLOAD;
+		xdr_shift_buf(buf, offset);
+		fix_priv_head(buf, pad);
+	}
+	if (maj_stat != GSS_S_COMPLETE)
+		return -EINVAL;
+out_seq:
+	if (ntohl(svc_getu32(&buf->head[0])) != seq)
+		return -EINVAL;
+	return 0;
+}
+
 struct gss_svc_data {
 	/* decoded gss client cred: */
 	struct rpc_gss_wire_cred	clcred;
@@ -1047,7 +1115,14 @@ svcauth_gss_accept(struct svc_rqst *rqst
 			svc_putu32(resv, 0);
 			break;
 		case RPC_GSS_SVC_PRIVACY:
-			/* currently unsupported */
+			if (unwrap_priv_data(rqstp, &rqstp->rq_arg,
+					gc->gc_seq, rsci->mechctx))
+				goto auth_err;
+			/* placeholders for length and seq. number: */
+			svcdata->body_start = resv->iov_base + resv->iov_len;
+			svc_putu32(resv, 0);
+			svc_putu32(resv, 0);
+			break;
 		default:
 			goto auth_err;
 		}
@@ -1089,9 +1164,8 @@ svcauth_gss_wrap_resp_integ(struct svc_r
 	gsd->body_start = NULL;
 	/* move accept_stat to right place: */
 	memcpy(p, p + 2, 4);
-	/* don't wrap in failure case: */
-	/* Note: counting on not getting here if call was not even
-	 * accepted! */
+	/* Don't wrap in failure case: */
+	/* Counting on not getting here if call was not even accepted! */
 	if (*p != rpc_success) {
 		resbuf->head[0].iov_len -= 2 * 4;
 		goto out;
@@ -1138,6 +1212,65 @@ out_err:
 	return stat;
 }
 
+static inline int
+svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp)
+{
+	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
+	struct rpc_gss_wire_cred *gc = &gsd->clcred;
+	struct xdr_buf *resbuf = &rqstp->rq_res;
+	struct page **inpages = NULL;
+	u32 *p;
+	int offset, *len;
+	int pad;
+
+	p = gsd->body_start;
+	gsd->body_start = NULL;
+	/* move accept_stat to right place: */
+	memcpy(p, p + 2, 4);
+	/* Don't wrap in failure case: */
+	/* Counting on not getting here if call was not even accepted! */
+	if (*p != rpc_success) {
+		resbuf->head[0].iov_len -= 2 * 4;
+		return 0;
+	}
+	p++;
+	len = p++;
+	offset = (u8 *)p - (u8 *)resbuf->head[0].iov_base;
+	*p++ = htonl(gc->gc_seq);
+	inpages = resbuf->pages;
+	/* XXX: Would be better to write some xdr helper functions for
+	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
+	if (resbuf->tail[0].iov_base && rqstp->rq_restailpage == 0) {
+		BUG_ON(resbuf->tail[0].iov_base >= resbuf->head[0].iov_base
+							+ PAGE_SIZE);
+		BUG_ON(resbuf->tail[0].iov_base < resbuf->head[0].iov_base);
+		if (resbuf->tail[0].iov_len + resbuf->head[0].iov_len
+				+ 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+			return -ENOMEM;
+		memmove(resbuf->tail[0].iov_base + RPC_MAX_AUTH_SIZE,
+			resbuf->tail[0].iov_base,
+			resbuf->tail[0].iov_len);
+		resbuf->tail[0].iov_base += RPC_MAX_AUTH_SIZE;
+	}
+	if (resbuf->tail[0].iov_base == NULL) {
+		if (resbuf->head[0].iov_len + 2*RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+			return -ENOMEM;
+		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
+			+ resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
+		resbuf->tail[0].iov_len = 0;
+		rqstp->rq_restailpage = 0;
+	}
+	if (gss_wrap(gsd->rsci->mechctx, offset, resbuf, inpages))
+		return -ENOMEM;
+	*len = htonl(resbuf->len - offset);
+	pad = 3 - ((resbuf->len - offset - 1)&3);
+	p = (u32 *)(resbuf->tail[0].iov_base + resbuf->tail[0].iov_len);
+	memset(p, 0, pad);
+	resbuf->tail[0].iov_len += pad;
+	resbuf->len += pad;
+	return 0;
+}
+
 static int
 svcauth_gss_release(struct svc_rqst *rqstp)
 {
@@ -1152,15 +1285,22 @@ svcauth_gss_release(struct svc_rqst *rqs
 	if (gsd->body_start == NULL)
 		goto out;
 	/* normally not set till svc_send, but we need it here: */
-	resbuf->len = resbuf->head[0].iov_len
-		+ resbuf->page_len + resbuf->tail[0].iov_len;
+	/* XXX: what for?  Do we mess it up the moment we call svc_putu32
+	 * or whatever? */
+	resbuf->len = total_buf_len(resbuf);
 	switch (gc->gc_svc) {
 	case RPC_GSS_SVC_NONE:
 		break;
 	case RPC_GSS_SVC_INTEGRITY:
-		svcauth_gss_wrap_resp_integ(rqstp);
+		stat = svcauth_gss_wrap_resp_integ(rqstp);
+		if (stat)
+			goto out_err;
 		break;
 	case RPC_GSS_SVC_PRIVACY:
+		stat = svcauth_gss_wrap_resp_priv(rqstp);
+		if (stat)
+			goto out_err;
+		break;
 	default:
 		goto out_err;
 	}

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-06-27 15:07:01.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-06-27 15:07:54.000000000 +1000
@@ -280,6 +280,7 @@ svc_process(struct svc_serv *serv, struc
 	rqstp->rq_res.page_base = 0;
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.buflen = PAGE_SIZE;
+	rqstp->rq_res.tail[0].iov_base = NULL;
 	rqstp->rq_res.tail[0].iov_len = 0;
 	/* Will be turned off only in gss privacy case: */
 	rqstp->rq_sendfile_ok = 1;
