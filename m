Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164344AbWLHBO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164344AbWLHBO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164328AbWLHBOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:05 -0500
Received: from mail.suse.de ([195.135.220.2]:58464 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164325AbWLHBNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:49 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:02 +1100
Message-Id: <1061208011402.30651@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 18] knfsd: svcrpc: remove another silent drop from deferral code
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

There's no point deferring something just to immediately fail the deferral,
especially now that we can do something more useful in the failure case by
returning an error.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/cache.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff .prev/net/sunrpc/cache.c ./net/sunrpc/cache.c
--- .prev/net/sunrpc/cache.c	2006-12-08 12:09:12.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-12-08 12:09:26.000000000 +1100
@@ -530,6 +530,13 @@ static int cache_defer_req(struct cache_
 	struct cache_deferred_req *dreq;
 	int hash = DFR_HASH(item);
 
+	if (cache_defer_cnt >= DFR_MAX) {
+		/* too much in the cache, randomly drop this one,
+		 * or continue and drop the oldest below
+		 */
+		if (net_random()&1)
+			return -ETIMEDOUT;
+	}
 	dreq = req->defer(req);
 	if (dreq == NULL)
 		return -ETIMEDOUT;
@@ -548,17 +555,8 @@ static int cache_defer_req(struct cache_
 	/* it is in, now maybe clean up */
 	dreq = NULL;
 	if (++cache_defer_cnt > DFR_MAX) {
-		/* too much in the cache, randomly drop
-		 * first or last
-		 */
-		if (net_random()&1) 
-			dreq = list_entry(cache_defer_list.next,
-					  struct cache_deferred_req,
-					  recent);
-		else
-			dreq = list_entry(cache_defer_list.prev,
-					  struct cache_deferred_req,
-					  recent);
+		dreq = list_entry(cache_defer_list.prev,
+				  struct cache_deferred_req, recent);
 		list_del(&dreq->recent);
 		list_del(&dreq->hash);
 		cache_defer_cnt--;
