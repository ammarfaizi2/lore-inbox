Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWIDXPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWIDXPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIDXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:15:35 -0400
Received: from ns.suse.de ([195.135.220.2]:23757 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932237AbWIDXPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:33 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:27 +1000
Message-Id: <1060904231527.23059@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 9] knfsd: svcrpc: gss: factor out some common wrapping code
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Factor out some common code from the integrity and privacy cases.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |   43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-09-04 17:09:50.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-09-04 17:12:31.000000000 +1000
@@ -1147,6 +1147,25 @@ out:
 	return ret;
 }
 
+u32 *
+svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
+{
+	u32 *p;
+
+	p = gsd->body_start;
+	gsd->body_start = NULL;
+	/* move accept_stat to right place: */
+	memcpy(p, p + 2, 4);
+	/* Don't wrap in failure case: */
+	/* Counting on not getting here if call was not even accepted! */
+	if (*p != rpc_success) {
+		resbuf->head[0].iov_len -= 2 * 4;
+		return NULL;
+	}
+	p++;
+	return p;
+}
+
 static inline int
 svcauth_gss_wrap_resp_integ(struct svc_rqst *rqstp)
 {
@@ -1160,17 +1179,9 @@ svcauth_gss_wrap_resp_integ(struct svc_r
 	int integ_offset, integ_len;
 	int stat = -EINVAL;
 
-	p = gsd->body_start;
-	gsd->body_start = NULL;
-	/* move accept_stat to right place: */
-	memcpy(p, p + 2, 4);
-	/* Don't wrap in failure case: */
-	/* Counting on not getting here if call was not even accepted! */
-	if (*p != rpc_success) {
-		resbuf->head[0].iov_len -= 2 * 4;
+	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
+	if (p == NULL)
 		goto out;
-	}
-	p++;
 	integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
 	integ_len = resbuf->len - integ_offset;
 	BUG_ON(integ_len % 4);
@@ -1222,17 +1233,9 @@ svcauth_gss_wrap_resp_priv(struct svc_rq
 	int offset, *len;
 	int pad;
 
-	p = gsd->body_start;
-	gsd->body_start = NULL;
-	/* move accept_stat to right place: */
-	memcpy(p, p + 2, 4);
-	/* Don't wrap in failure case: */
-	/* Counting on not getting here if call was not even accepted! */
-	if (*p != rpc_success) {
-		resbuf->head[0].iov_len -= 2 * 4;
+	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
+	if (p == NULL)
 		return 0;
-	}
-	p++;
 	len = p++;
 	offset = (u8 *)p - (u8 *)resbuf->head[0].iov_base;
 	*p++ = htonl(gc->gc_seq);
