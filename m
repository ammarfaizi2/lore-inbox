Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWJPXar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWJPXar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWJPXal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:43463 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422930AbWJPXaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:25 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:19 +1000
Message-Id: <1061016233019.11342@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 5] knfsd: nfsd4: Fix error handling in nfsd's callback client
References: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "J. Bruce Fields" <bfields@fieldses.org>
Coverity noticed that the error handling code in the NFSv4 callback client
sets cb->cb_client to NULL, then calls rpc_shutdown_client with the NULL
pointer.

Coverity: #cid 1397

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4callback.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff .prev/fs/nfsd/nfs4callback.c ./fs/nfsd/nfs4callback.c
--- .prev/fs/nfsd/nfs4callback.c	2006-10-17 09:05:30.000000000 +1000
+++ ./fs/nfsd/nfs4callback.c	2006-10-17 09:05:30.000000000 +1000
@@ -421,7 +421,7 @@ nfsd4_probe_callback(struct nfs4_client 
 
 	/* Create RPC client */
 	cb->cb_client = rpc_create(&args);
-	if (!cb->cb_client) {
+	if (IS_ERR(cb->cb_client)) {
 		dprintk("NFSD: couldn't create callback client\n");
 		goto out_err;
 	}
@@ -448,10 +448,10 @@ nfsd4_probe_callback(struct nfs4_client 
 out_rpciod:
 	atomic_dec(&clp->cl_count);
 	rpciod_down();
-	cb->cb_client = NULL;
 out_clnt:
 	rpc_shutdown_client(cb->cb_client);
 out_err:
+	cb->cb_client = NULL;
 	dprintk("NFSD: warning: no callback path to client %.*s\n",
 		(int)clp->cl_name.len, clp->cl_name.data);
 }
