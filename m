Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVL3Wmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVL3Wmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVL3Wmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:42:49 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:59156 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932165AbVL3Wm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:42:26 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224202.765.89078.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 13/14] page-replace-init.patch
Date: Fri, 30 Dec 2005 23:42:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

page-replace interface function:
  page_replace_init_zone()

This function initialized the page replace specific members of
struct zone.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mm_page_replace.h |    1 +
 mm/page_alloc.c                 |    6 ++----
 mm/page_replace.c               |    8 ++++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -38,6 +38,7 @@
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
+void __init page_replace_init_zone(struct zone *);
 void __page_replace_insert(struct zone *, struct page *);
 void page_replace_candidates(struct zone *, int, struct list_head *);
 
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -36,6 +36,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2007,11 +2008,7 @@ static void __init free_area_init_core(s
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
 		zone_pcp_init(zone);
-		INIT_LIST_HEAD(&zone->active_list);
-		INIT_LIST_HEAD(&zone->inactive_list);
-		zone->nr_scan_active = 0;
-		zone->nr_active = 0;
-		zone->nr_inactive = 0;
+		page_replace_init_zone(zone);
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
Index: linux-2.6-git/mm/page_replace.c
===================================================================
--- linux-2.6-git.orig/mm/page_replace.c
+++ linux-2.6-git/mm/page_replace.c
@@ -22,6 +22,15 @@ static int __init page_replace_init(void
 
 module_init(page_replace_init)
 
+void __init page_replace_init_zone(struct zone *zone)
+{
+	INIT_LIST_HEAD(&zone->active_list);
+	INIT_LIST_HEAD(&zone->inactive_list);
+	zone->nr_active = 0;
+	zone->nr_inactive = 0;
+	zone->nr_scan_active = 0;
+}
+
 static inline void
 add_page_to_inactive_list(struct zone *zone, struct page *page)
 {
