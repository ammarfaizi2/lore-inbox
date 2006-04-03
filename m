Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWDCFVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWDCFVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDCFVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:51868 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964842AbWDCFVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:21:13 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:25 +1000
Message-Id: <1060403051925.1917@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 016 of 16] knfsd: nfsd4: grant delegations more frequently
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keep unused openowners around for at least one lease period, to avoid the
need for as many open confirmations and to allow handing out more
delegations.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4state.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff ./fs/nfsd/nfs4state.c~current~ ./fs/nfsd/nfs4state.c
--- ./fs/nfsd/nfs4state.c~current~	2006-04-03 15:12:17.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-04-03 15:12:17.000000000 +1000
@@ -1198,8 +1198,7 @@ move_to_close_lru(struct nfs4_stateowner
 {
 	dprintk("NFSD: move_to_close_lru nfs4_stateowner %p\n", sop);
 
-	unhash_stateowner(sop);
-	list_add_tail(&sop->so_close_lru, &close_lru);
+	list_move_tail(&sop->so_close_lru, &close_lru);
 	sop->so_time = get_seconds();
 }
 
@@ -1928,8 +1927,7 @@ nfs4_laundromat(void)
 		}
 		dprintk("NFSD: purging unused open stateowner (so_id %d)\n",
 			sop->so_id);
-		list_del(&sop->so_close_lru);
-		nfs4_put_stateowner(sop);
+		release_stateowner(sop);
 	}
 	if (clientid_val < NFSD_LAUNDROMAT_MINTIMEOUT)
 		clientid_val = NFSD_LAUNDROMAT_MINTIMEOUT;
@@ -3217,15 +3215,8 @@ __nfs4_state_shutdown(void)
 	int i;
 	struct nfs4_client *clp = NULL;
 	struct nfs4_delegation *dp = NULL;
-	struct nfs4_stateowner *sop = NULL;
 	struct list_head *pos, *next, reaplist;
 
-	list_for_each_safe(pos, next, &close_lru) {
-		sop = list_entry(pos, struct nfs4_stateowner, so_close_lru);
-		list_del(&sop->so_close_lru);
-		nfs4_put_stateowner(sop);
-	}
-
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&conf_id_hashtbl[i])) {
 			clp = list_entry(conf_id_hashtbl[i].next, struct nfs4_client, cl_idhash);
