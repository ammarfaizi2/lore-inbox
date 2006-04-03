Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWDCFVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWDCFVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWDCFVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:42140 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964842AbWDCFUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:01 +1000
Message-Id: <1060403051901.1857@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 16] knfsd: svcrpc: WARN() instead of returning an error from svc_take_page
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every caller of svc_take_page ignores its return value and assumes it
succeeded.  So just WARN() instead of returning an ignored error.  This
would have saved some time debugging a recent nfsd4 problem.

If there are still failure cases here, then the result is probably that we
overwrite an earlier part of the reply while xdr-encoding.

While the corrupted reply is a nasty bug, it would be worse to panic here
and create the possibility of a remote DOS; hence WARN() instead of BUG().

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff ./include/linux/sunrpc/svc.h~current~ ./include/linux/sunrpc/svc.h
--- ./include/linux/sunrpc/svc.h~current~	2006-04-03 15:12:15.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-04-03 15:12:15.000000000 +1000
@@ -197,15 +197,13 @@ svc_take_res_page(struct svc_rqst *rqstp
 	return rqstp->rq_respages[rqstp->rq_resused++];
 }
 
-static inline int svc_take_page(struct svc_rqst *rqstp)
+static inline void svc_take_page(struct svc_rqst *rqstp)
 {
-	if (rqstp->rq_arghi <= rqstp->rq_argused)
-		return -ENOMEM;
+	WARN_ON(rqstp->rq_arghi <= rqstp->rq_argused);
 	rqstp->rq_arghi--;
 	rqstp->rq_respages[rqstp->rq_resused] =
 		rqstp->rq_argpages[rqstp->rq_arghi];
 	rqstp->rq_resused++;
-	return 0;
 }
 
 static inline void svc_pushback_allpages(struct svc_rqst *rqstp)
