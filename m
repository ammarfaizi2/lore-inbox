Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWDCFYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWDCFYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWDCFXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:23:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40348 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964841AbWDCFUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:43 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:56 +1000
Message-Id: <1060403051856.1845@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 16] knfsd: svcrpc: gss: don't call svc_take_page unnecessarily
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're using svc_take_page here to get another page for the tail in case one
wasn't already allocated.  But there isn't always guaranteed to be another
page available.

Also fix a typo that made us check the tail buffer for space when we meant
to be checking the head buffer.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-04-03 15:12:14.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-04-03 15:12:14.000000000 +1000
@@ -1122,18 +1122,20 @@ svcauth_gss_release(struct svc_rqst *rqs
 					integ_len))
 			BUG();
 		if (resbuf->page_len == 0
-			&& resbuf->tail[0].iov_len + RPC_MAX_AUTH_SIZE
+			&& resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE
 				< PAGE_SIZE) {
 			BUG_ON(resbuf->tail[0].iov_len);
 			/* Use head for everything */
 			resv = &resbuf->head[0];
 		} else if (resbuf->tail[0].iov_base == NULL) {
-			/* copied from nfsd4_encode_read */
-			svc_take_page(rqstp);
-			resbuf->tail[0].iov_base = page_address(rqstp
-					->rq_respages[rqstp->rq_resused-1]);
-			rqstp->rq_restailpage = rqstp->rq_resused-1;
+			if (resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE
+					> PAGE_SIZE)
+				goto out_err;
+			resbuf->tail[0].iov_base =
+				resbuf->head[0].iov_base
+				+ resbuf->head[0].iov_len;
 			resbuf->tail[0].iov_len = 0;
+			rqstp->rq_restailpage = 0;
 			resv = &resbuf->tail[0];
 		} else {
 			resv = &resbuf->tail[0];
