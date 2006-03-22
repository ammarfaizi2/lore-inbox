Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932872AbWCVWdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbWCVWdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWCVWcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:32:39 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27679 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932871AbWCVWcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:33 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223158.12658.73621.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 05/34] mm: page-replace-generic-pagevec.patch
Date: Wed, 22 Mar 2006 23:32:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Since PG_active is already used to discriminate between active and inactive
lists, use it to collapse the two pagevec add functions and make it a generic
helper function.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    2 +
 include/linux/mm_use_once_policy.h |   16 ++++++++
 mm/swap.c                          |   31 ++++++++++++++++
 mm/useonce.c                       |   68 ++-----------------------------------
 4 files changed, 53 insertions(+), 64 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -8,6 +8,22 @@ static inline void page_replace_hint_act
 	SetPageActive(page);
 }
 
+static inline void
+add_page_to_inactive_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->policy.inactive_list);
+	zone->policy.nr_inactive++;
+}
+
+static inline void
+__page_replace_add(struct zone *zone, struct page *page)
+{
+	if (PageActive(page))
+		add_page_to_active_list(zone, page);
+	else
+		add_page_to_inactive_list(zone, page);
+}
+
 static inline void page_replace_hint_use_once(struct page *page)
 {
 }
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -6,10 +6,12 @@
 #include <linux/mmzone.h>
 #include <linux/mm.h>
 #include <linux/pagevec.h>
+#include <linux/mm_inline.h>
 
 /* void page_replace_hint_active(struct page *); */
 /* void page_replace_hint_use_once(struct page *); */
 extern void fastcall page_replace_add(struct page *);
+/* void __page_replace_add(struct zone *, struct page *); */
 /* void page_replace_add_drain(void); */
 extern void __page_replace_add_drain(unsigned int);
 extern int page_replace_add_drain_all(void);
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -11,64 +11,6 @@
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
 static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
 
-/*
- * Add the passed pages to the LRU, then drop the caller's refcount
- * on them.  Reinitialises the caller's pagevec.
- */
-void __pagevec_page_replace_add(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		add_page_to_inactive_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
-EXPORT_SYMBOL(__pagevec_page_replace_add);
-
-static void __pagevec_lru_add_active(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
 static inline void lru_cache_add(struct page *page)
 {
 	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
@@ -85,18 +27,16 @@ static inline void lru_cache_add_active(
 
 	page_cache_get(page);
 	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add_active(pvec);
+		__pagevec_page_replace_add(pvec);
 	put_cpu_var(lru_add_active_pvecs);
 }
 
 void fastcall page_replace_add(struct page *page)
 {
-	if (PageActive(page)) {
-		ClearPageActive(page);
+	if (PageActive(page))
 		lru_cache_add_active(page);
-	} else {
+	else
 		lru_cache_add(page);
-	}
 }
 
 void __page_replace_add_drain(unsigned int cpu)
@@ -107,7 +47,7 @@ void __page_replace_add_drain(unsigned i
 		__pagevec_page_replace_add(pvec);
 	pvec = &per_cpu(lru_add_active_pvecs, cpu);
 	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
+		__pagevec_page_replace_add(pvec);
 }
 
 #ifdef CONFIG_NUMA
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -306,6 +306,37 @@ unsigned pagevec_lookup_tag(struct pagev
 
 EXPORT_SYMBOL(pagevec_lookup_tag);
 
+/*
+ * Add the passed pages to the LRU, then drop the caller's refcount
+ * on them.  Reinitialises the caller's pagevec.
+ */
+void __pagevec_page_replace_add(struct pagevec *pvec)
+{
+	int i;
+	struct zone *zone = NULL;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (TestSetPageLRU(page))
+			BUG();
+		__page_replace_add(zone, page);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+EXPORT_SYMBOL(__pagevec_page_replace_add);
+
 #ifdef CONFIG_SMP
 /*
  * We tolerate a little inaccuracy to avoid ping-ponging the counter between
