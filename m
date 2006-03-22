Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932889AbWCVWek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWCVWek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932895AbWCVWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:34:38 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3253 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S932890AbWCVWeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:34:24 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223348.12658.94409.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 16/34] mm: page-replace-init.patch
Date: Wed, 22 Mar 2006 23:34:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Move initialization of the replacement policy's variables into the
implementation.

API:

initialize the implementation's per zone variables

	void page_replace_init_zone(struct zone *);

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h |    2 ++
 init/main.c                     |    2 ++
 mm/useonce.c                        |   15 +++++++++++++++
 mm/page_alloc.c                 |    8 ++------
 4 files changed, 21 insertions(+), 6 deletions(-)

Index: linux-2.6/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6.orig/include/linux/mm_page_replace.h	2006-03-13 20:37:39.000000000 +0100
+++ linux-2.6/include/linux/mm_page_replace.h	2006-03-13 20:37:40.000000000 +0100
@@ -67,6 +67,8 @@ struct scan_control {
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
+extern void page_replace_init(void);
+extern void page_replace_init_zone(struct zone *);
 /* void page_replace_hint_active(struct page *); */
 /* void page_replace_hint_use_once(struct page *); */
 extern void fastcall page_replace_add(struct page *);
Index: linux-2.6/mm/useonce.c
===================================================================
--- linux-2.6.orig/mm/useonce.c	2006-03-13 20:37:38.000000000 +0100
+++ linux-2.6/mm/useonce.c	2006-03-13 20:37:40.000000000 +0100
@@ -6,6 +6,21 @@
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
 					buffer_heads_over_limit */
 
+void __init page_replace_init(void)
+{
+	/* empty hook */
+}
+
+void __init page_replace_init_zone(struct zone *zone)
+{
+	INIT_LIST_HEAD(&zone->active_list);
+	INIT_LIST_HEAD(&zone->inactive_list);
+	zone->nr_scan_active = 0;
+	zone->nr_scan_inactive = 0;
+	zone->nr_active = 0;
+	zone->nr_inactive = 0;
+}
+
 static inline void
 add_page_to_inactive_list(struct zone *zone, struct page *page)
 {
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-03-13 20:37:05.000000000 +0100
+++ linux-2.6/mm/page_alloc.c	2006-03-13 20:37:40.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2075,12 +2076,7 @@ static void __init free_area_init_core(s
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
 		zone_pcp_init(zone);
-		INIT_LIST_HEAD(&zone->active_list);
-		INIT_LIST_HEAD(&zone->inactive_list);
-		zone->nr_scan_active = 0;
-		zone->nr_scan_inactive = 0;
-		zone->nr_active = 0;
-		zone->nr_inactive = 0;
+		page_replace_init_zone(zone);
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2006-03-13 20:37:05.000000000 +0100
+++ linux-2.6/init/main.c	2006-03-13 20:37:40.000000000 +0100
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -507,6 +508,7 @@ asmlinkage void __init start_kernel(void
 #endif
 	vfs_caches_init_early();
 	cpuset_init_early();
+	page_replace_init();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
