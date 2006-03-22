Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932895AbWCVWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWCVWmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbWCVWmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:42:43 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:44268 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932895AbWCVWem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:34:42 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223408.12658.49441.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 18/34] mm: page-replace-counts.patch
Date: Wed, 22 Mar 2006 23:34:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract the various page counts used to drive the scanner.

API:

give the 'active', 'inactive' and free count for the selected pgdat.
(free interpretation of '' words)

    void __page_replace_counts(unsigned long *, unsigned long *,
			    unsigned long *, struct pglist_data *);

total number of pages in the policies care

    unsigned long __page_replace_nr_pages(struct zone *);

number of pages to base the scan speed on

    unsigned long __page_replace_nr_scan(struct zone *);


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    3 +++
 include/linux/mm_use_once_policy.h |    5 +++++
 mm/page_alloc.c                    |   12 +-----------
 mm/useonce.c                       |   16 ++++++++++++++++
 mm/vmscan.c                        |    6 +++---
 5 files changed, 28 insertions(+), 14 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -95,6 +95,9 @@ extern void page_replace_shrink(struct z
 /* void __page_replace_rotate_reclaimable(struct zone *, struct page *); */
 extern void page_replace_show(struct zone *);
 extern void page_replace_zoneinfo(struct zone *, struct seq_file *);
+extern void __page_replace_counts(unsigned long *, unsigned long *,
+				  unsigned long *, struct pglist_data *);
+/* unsigned long __page_replace_nr_pages(struct zone *); */
 
 #ifdef CONFIG_MIGRATION
 extern int page_replace_isolate(struct page *p);
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -478,3 +478,19 @@ void page_replace_zoneinfo(struct zone *
 		   zone->spanned_pages,
 		   zone->present_pages);
 }
+
+void __page_replace_counts(unsigned long *active, unsigned long *inactive,
+			   unsigned long *free, struct pglist_data *pgdat)
+{
+	struct zone *zones = pgdat->node_zones;
+	int i;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		*active += zones[i].nr_active;
+		*inactive += zones[i].nr_inactive;
+		*free += zones[i].free_pages;
+	}
+}
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -1307,17 +1307,7 @@ EXPORT_SYMBOL(mod_page_state_offset);
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
 {
-	struct zone *zones = pgdat->node_zones;
-	int i;
-
-	*active = 0;
-	*inactive = 0;
-	*free = 0;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		*active += zones[i].nr_active;
-		*inactive += zones[i].nr_inactive;
-		*free += zones[i].free_pages;
-	}
+	__page_replace_counts(active, inactive, free, pgdat);
 }
 
 void get_zone_counts(unsigned long *active,
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -135,5 +135,10 @@ static inline void __page_replace_rotate
 	}
 }
 
+static inline unsigned long __page_replace_nr_pages(struct zone *zone)
+{
+	return zone->nr_active + zone->nr_inactive;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -1033,7 +1033,7 @@ int try_to_free_pages(struct zone **zone
 			continue;
 
 		zone->temp_priority = DEF_PRIORITY;
-		lru_pages += zone->nr_active + zone->nr_inactive;
+		lru_pages += __page_replace_nr_pages(zone);
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1175,7 +1175,7 @@ scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
-			lru_pages += zone->nr_active + zone->nr_inactive;
+			lru_pages += __page_replace_nr_pages(zone);
 		}
 
 		/*
@@ -1219,7 +1219,7 @@ scan:
 			if (zone->all_unreclaimable)
 				continue;
 			if (nr_slab == 0 && zone->pages_scanned >=
-				    (zone->nr_active + zone->nr_inactive) * 4)
+				    __page_replace_nr_pages(zone) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and
