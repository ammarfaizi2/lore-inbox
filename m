Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWDCFVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWDCFVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWDCFVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:46261 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964846AbWDCFVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:21:03 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:15 +1000
Message-Id: <1060403051915.1893@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 014 of 16] knfsd: nfsd4: add missing rpciod_down()
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should be shutting down rpciod for the callback channel when we shut down
the server.

Also note that we do rpciod_up() and create the callback client *before*
setting cb_set--the cb_set only determines whether the initial null was
succesful.  So cb_set is not a reliable determiner of whether we need to
clean up, only cb_client is.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4state.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfs4state.c~current~ ./fs/nfsd/nfs4state.c
--- ./fs/nfsd/nfs4state.c~current~	2006-04-03 15:12:16.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-04-03 15:12:16.000000000 +1000
@@ -330,22 +330,29 @@ put_nfs4_client(struct nfs4_client *clp)
 }
 
 static void
+shutdown_callback_client(struct nfs4_client *clp)
+{
+	struct rpc_clnt *clnt = clp->cl_callback.cb_client;
+
+	/* shutdown rpc client, ending any outstanding recall rpcs */
+	if (clnt) {
+		clp->cl_callback.cb_client = NULL;
+		rpc_shutdown_client(clnt);
+		rpciod_down();
+	}
+}
+
+static void
 expire_client(struct nfs4_client *clp)
 {
 	struct nfs4_stateowner *sop;
 	struct nfs4_delegation *dp;
-	struct nfs4_callback *cb = &clp->cl_callback;
-	struct rpc_clnt *clnt = clp->cl_callback.cb_client;
 	struct list_head reaplist;
 
 	dprintk("NFSD: expire_client cl_count %d\n",
 	                    atomic_read(&clp->cl_count));
 
-	/* shutdown rpc client, ending any outstanding recall rpcs */
-	if (atomic_read(&cb->cb_set) == 1 && clnt) {
-		rpc_shutdown_client(clnt);
-		clnt = clp->cl_callback.cb_client = NULL;
-	}
+	shutdown_callback_client(clp);
 
 	INIT_LIST_HEAD(&reaplist);
 	spin_lock(&recall_lock);
