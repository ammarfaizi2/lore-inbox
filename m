Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932887AbWCVWfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbWCVWfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWCVWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:35:32 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22624 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932887AbWCVWfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:25 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223451.12658.69502.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 22/34] mm: page-replace-shrink-new.patch
Date: Wed, 22 Mar 2006 23:35:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Add a general shrinker that policies can make use of.
The policy defines MM_POLICY_HAS_SHRINKER when it does _NOT_ want
to make use of this framework.

API:
	unsigned long __page_replace_nr_scan(struct zone *);

return the number of pages in the scanlist for this zone.

	void page_replace_candidates(struct zone *, int, struct list_head *);

fill the @list with at most @nr pages from @zone.

	void page_replace_reinsert_zone(struct zone *, struct list_head *, int);

reinsert @list into @zone where @nr pages were freed - reinsert those pages that
could not be freed.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    6 +++++
 include/linux/mm_use_once_policy.h |    2 +
 mm/vmscan.c                        |   43 +++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -128,5 +128,11 @@ static inline void page_replace_add_drai
 	put_cpu();
 }
 
+#if ! defined MM_POLICY_HAS_SHRINKER
+/* unsigned long __page_replace_nr_scan(struct zone *); */
+void page_replace_candidates(struct zone *, int, struct list_head *);
+void page_replace_reinsert_zone(struct zone *, struct list_head *, int);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_PAGE_REPLACE_H */
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -958,6 +958,49 @@ int should_reclaim_mapped(struct zone *z
 	return 0;
 }
 
+#if ! defined MM_POLICY_HAS_SHRINKER
+void page_replace_shrink(struct zone *zone, struct scan_control *sc)
+{
+	unsigned long nr_scan = 0;
+
+	atomic_inc(&zone->reclaim_in_progress);
+
+	if (unlikely(sc->swap_cluster_max > SWAP_CLUSTER_MAX)) {
+		nr_scan = zone->policy.nr_scan;
+		zone->policy.nr_scan =
+			sc->swap_cluster_max + SWAP_CLUSTER_MAX - 1;
+	} else
+		zone->policy.nr_scan +=
+			(__page_replace_nr_scan(zone) >> sc->priority) + 1;
+
+	while (zone->policy.nr_scan >= SWAP_CLUSTER_MAX) {
+		LIST_HEAD(page_list);
+		int nr_freed;
+
+		zone->policy.nr_scan -= SWAP_CLUSTER_MAX;
+		page_replace_candidates(zone, SWAP_CLUSTER_MAX, &page_list);
+		if (list_empty(&page_list))
+			continue;
+
+		nr_freed = shrink_list(&page_list, sc);
+
+		local_irq_disable();
+		if (current_is_kswapd())
+			__mod_page_state(kswapd_steal, nr_freed);
+		__mod_page_state_zone(zone, pgsteal, nr_freed);
+		local_irq_enable();
+
+		page_replace_reinsert_zone(zone, &page_list, nr_freed);
+	}
+	if (nr_scan)
+		zone->policy.nr_scan = nr_scan;
+
+	atomic_dec(&zone->reclaim_in_progress);
+
+	throttle_vm_writeout();
+}
+#endif
+
 /*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -169,5 +169,7 @@ static inline unsigned long __page_repla
 	return zone->policy.nr_active + zone->policy.nr_inactive;
 }
 
+#define MM_POLICY_HAS_SHRINKER
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
