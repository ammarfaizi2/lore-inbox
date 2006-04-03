Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWDCFWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDCFWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWDCFVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964849AbWDCFUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:53 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:05 +1000
Message-Id: <1060403051905.1869@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 16] knfsd: nfsd4: fix laundromat shutdown race
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to make sure the laundromat work doesn't reschedule itself just when
we try to cancel it.  Also, we shouldn't be waiting for it to finish running
while holding the state lock, as that's a potential deadlock.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4state.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff ./fs/nfsd/nfs4state.c~current~ ./fs/nfsd/nfs4state.c
--- ./fs/nfsd/nfs4state.c~current~	2006-04-03 15:12:03.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-04-03 15:12:16.000000000 +1000
@@ -3238,8 +3238,6 @@ __nfs4_state_shutdown(void)
 	}
 
 	cancel_delayed_work(&laundromat_work);
-	flush_workqueue(laundry_wq);
-	destroy_workqueue(laundry_wq);
 	nfsd4_shutdown_recdir();
 	nfs4_init = 0;
 }
@@ -3247,6 +3245,8 @@ __nfs4_state_shutdown(void)
 void
 nfs4_state_shutdown(void)
 {
+	cancel_rearming_delayed_workqueue(laundry_wq, &laundromat_work);
+	destroy_workqueue(laundry_wq);
 	nfs4_lock_state();
 	nfs4_release_reclaim();
 	__nfs4_state_shutdown();
