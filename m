Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWDCFVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWDCFVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWDCFUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38556 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964846AbWDCFUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:38 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:51 +1000
Message-Id: <1060403051851.1833@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 16] knfsd: nfsd4: fix corruption on readdir encoding with 64k pages
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix corruption on readdir encoding with 64k pages.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4xdr.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfs4xdr.c~current~ ./fs/nfsd/nfs4xdr.c
--- ./fs/nfsd/nfs4xdr.c~current~	2006-04-03 15:12:11.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-04-03 15:12:13.000000000 +1000
@@ -2157,7 +2157,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 {
 	int maxcount;
 	loff_t offset;
-	u32 *page, *savep;
+	u32 *page, *savep, *tailbase;
 	ENCODE_HEAD;
 
 	if (nfserr)
@@ -2173,6 +2173,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 	WRITE32(0);
 	ADJUST_ARGS();
 	resp->xbuf->head[0].iov_len = ((char*)resp->p) - (char*)resp->xbuf->head[0].iov_base;
+	tailbase = p;
 
 	maxcount = PAGE_SIZE;
 	if (maxcount > readdir->rd_maxcount)
@@ -2217,14 +2218,12 @@ nfsd4_encode_readdir(struct nfsd4_compou
 	*p++ = htonl(readdir->common.err == nfserr_eof);
 	resp->xbuf->page_len = ((char*)p) - (char*)page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
 
-	/* allocate a page for the tail */
-	svc_take_page(resp->rqstp);
-	resp->xbuf->tail[0].iov_base = 
-		page_address(resp->rqstp->rq_respages[resp->rqstp->rq_resused-1]);
-	resp->rqstp->rq_restailpage = resp->rqstp->rq_resused-1;
+	/* Use rest of head for padding and remaining ops: */
+	resp->rqstp->rq_restailpage = 0;
+	resp->xbuf->tail[0].iov_base = tailbase;
 	resp->xbuf->tail[0].iov_len = 0;
 	resp->p = resp->xbuf->tail[0].iov_base;
-	resp->end = resp->p + PAGE_SIZE/4;
+	resp->end = resp->p + (PAGE_SIZE - resp->xbuf->head[0].iov_len)/4;
 
 	return 0;
 err_no_verf:
