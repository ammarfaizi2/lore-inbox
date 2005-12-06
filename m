Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVLFNew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVLFNew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLFNew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:34:52 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:47319 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932565AbVLFNev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:34:51 -0500
Message-Id: <20051206135702.540410000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:09 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 01/13] mm: restore sc.nr_to_reclaim
Content-Disposition: inline; filename=mm-revert-vmscan-balancing-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep it before the real fine grained scan patch is ready :)

The following patches really needs small scan quantities, at least in
normal situation.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |    8 ++++++++
 1 files changed, 8 insertions(+)

--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
@@ -63,6 +63,9 @@ struct scan_control {
 
 	unsigned long nr_mapped;	/* From page_state */
 
+	/* How many pages shrink_cache() should reclaim */
+	int nr_to_reclaim;
+
 	/* Ask shrink_caches, or shrink_zone to scan at this priority */
 	unsigned int priority;
 
@@ -898,6 +901,7 @@ static void shrink_cache(struct zone *zo
 		if (current_is_kswapd())
 			mod_page_state(kswapd_steal, nr_freed);
 		mod_page_state_zone(zone, pgsteal, nr_freed);
+		sc->nr_to_reclaim -= nr_freed;
 
 		spin_lock_irq(&zone->lru_lock);
 		/*
@@ -1097,6 +1101,8 @@ shrink_zone(struct zone *zone, struct sc
 	else
 		nr_inactive = 0;
 
+	sc->nr_to_reclaim = sc->swap_cluster_max;
+
 	while (nr_active || nr_inactive) {
 		if (nr_active) {
 			sc->nr_to_scan = min(nr_active,
@@ -1110,6 +1116,8 @@ shrink_zone(struct zone *zone, struct sc
 					(unsigned long)sc->swap_cluster_max);
 			nr_inactive -= sc->nr_to_scan;
 			shrink_cache(zone, sc);
+			if (sc->nr_to_reclaim <= 0)
+				break;
 		}
 	}
 

--
