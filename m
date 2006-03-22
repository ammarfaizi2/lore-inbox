Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932912AbWCVWiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWCVWiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbWCVWh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:37:57 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:43892 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932912AbWCVWhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:37:19 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223645.12658.29198.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 33/34] mm: cart-r.patch
Date: Wed, 22 Mar 2006 23:37:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Another CART based policy, this one extends CART to handle cyclic access.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_cart_data.h         |    8 ++++
 include/linux/mm_cart_policy.h       |    7 +++
 include/linux/mm_page_replace.h      |    2 -
 include/linux/mm_page_replace_data.h |    2 -
 mm/Kconfig                           |    6 +++
 mm/Makefile                          |    1 
 mm/cart.c                            |   63 ++++++++++++++++++++++++++++++-----
 7 files changed, 78 insertions(+), 11 deletions(-)

Index: linux-2.6-git/include/linux/mm_cart_data.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_cart_data.h
+++ linux-2.6-git/include/linux/mm_cart_data.h
@@ -13,11 +13,15 @@ struct page_replace_data {
 	unsigned long		nr_T2;
 	unsigned long           nr_shortterm;
 	unsigned long           nr_p;
+#if defined CONFIG_MM_POLICY_CART_R
+	unsigned long		nr_r;
+#endif
 	unsigned long		flags;
 };
 
 #define CART_RECLAIMED_T1	0
 #define CART_SATURATED		1
+#define CART_CYCLIC		2
 
 #define ZoneReclaimedT1(z)	test_bit(CART_RECLAIMED_T1, &((z)->policy.flags))
 #define SetZoneReclaimedT1(z)	__set_bit(CART_RECLAIMED_T1, &((z)->policy.flags))
@@ -27,5 +31,9 @@ struct page_replace_data {
 #define SetZoneSaturated(z)	__set_bit(CART_SATURATED, &((z)->policy.flags))
 #define TestClearZoneSaturated(z)  __test_and_clear_bit(CART_SATURATED, &((z)->policy.flags))
 
+#define ZoneCyclic(z)		test_bit(CART_CYCLIC, &((z)->policy.flags))
+#define SetZoneCyclic(z)	__set_bit(CART_CYCLIC, &((z)->policy.flags))
+#define ClearZoneCyclic(z)	__clear_bit(CART_CYCLIC, &((z)->policy.flags))
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_CART_DATA_H_ */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -116,7 +116,7 @@ static inline int page_replace_isolate(s
 #include <linux/mm_use_once_policy.h>
 #elif defined CONFIG_MM_POLICY_CLOCKPRO
 #include <linux/mm_clockpro_policy.h>
-#elif defined CONFIG_MM_POLICY_CART
+#elif defined CONFIG_MM_POLICY_CART || defined CONFIG_MM_POLICY_CART_R
 #include <linux/mm_cart_policy.h>
 #else
 #error no mm policy
Index: linux-2.6-git/include/linux/mm_page_replace_data.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace_data.h
+++ linux-2.6-git/include/linux/mm_page_replace_data.h
@@ -7,7 +7,7 @@
 #include <linux/mm_use_once_data.h>
 #elif defined CONFIG_MM_POLICY_CLOCKPRO
 #include <linux/mm_clockpro_data.h>
-#elif defined CONFIG_MM_POLICY_CART
+#elif defined CONFIG_MM_POLICY_CART || defined CONFIG_MM_POLICY_CART_R
 #include <linux/mm_cart_data.h>
 #else
 #error no mm policy
Index: linux-2.6-git/mm/Kconfig
===================================================================
--- linux-2.6-git.orig/mm/Kconfig
+++ linux-2.6-git/mm/Kconfig
@@ -152,6 +152,12 @@ config MM_POLICY_CART
 	help
 	  This option selects a CART based policy
 
+config MM_POLICY_CART_R
+	bool "CART-r"
+	help
+	  This option selects a CART based policy modified to handle cyclic
+	  access patterns.
+
 endchoice
 
 #
Index: linux-2.6-git/mm/cart.c
===================================================================
--- linux-2.6-git.orig/mm/cart.c
+++ linux-2.6-git/mm/cart.c
@@ -69,6 +69,9 @@ void __init page_replace_init_zone(struc
 	zone->policy.nr_T2 = 0;
 	zone->policy.nr_shortterm = 0;
 	zone->policy.nr_p = 0;
+#if defined CONFIG_MM_POLICY_CART_R
+	zone->policy.nr_r = 0;
+#endif
 	zone->policy.flags = 0;
 }
 
@@ -166,6 +169,30 @@ static inline void __cart_p_dec(struct z
 		zone->policy.nr_p = 0UL;
 }
 
+#if defined CONFIG_MM_POLICY_CART_R
+static inline void __cart_r_inc(struct zone *zone)
+{
+	unsigned long ratio;
+	ratio = (cart_longterm(zone) / (zone->policy.nr_shortterm + 1)) ?: 1;
+	zone->policy.nr_r += ratio;
+	if (zone->policy.nr_r > cart_c(zone))
+		zone->policy.nr_r = cart_c(zone);
+}
+
+static inline void __cart_r_dec(struct zone *zone)
+{
+	unsigned long ratio;
+	ratio = (zone->policy.nr_shortterm / (cart_longterm(zone) + 1)) ?: 1;
+	if (zone->policy.nr_r > ratio)
+		zone->policy.nr_r -= ratio;
+	else
+		zone->policy.nr_r = 0UL;
+}
+#else
+#define __cart_r_inc(z) do { } while (0)
+#define __cart_r_dec(z) do { } while (0)
+#endif
+
 static unsigned long list_count(struct list_head *list, int PG_flag, int result)
 {
 	unsigned long nr = 0;
@@ -236,6 +263,8 @@ void __page_replace_add(struct zone *zon
 
 	if (rflags & NR_found) {
 		SetPageLongTerm(page);
+		__cart_r_dec(zone);
+
 		rflags &= NR_listid;
 		if (rflags == NR_b1) {
 			__cart_p_inc(zone);
@@ -246,6 +275,7 @@ void __page_replace_add(struct zone *zon
 		/* ++cart_longterm(zone); */
 	} else {
 		ClearPageLongTerm(page);
+		__cart_r_inc(zone);
 		++zone->policy.nr_shortterm;
 	}
 	SetPageT1(page);
@@ -454,19 +484,28 @@ static int isolate_pages(struct zone *zo
 
 static inline int cart_reclaim_T1(struct zone *zone)
 {
+	int ret = 0;
 	int t1 = zone->policy.nr_T1 > zone->policy.nr_p;
 	int sat = TestClearZoneSaturated(zone);
 	int rec = ZoneReclaimedT1(zone);
+#if defined CONFIG_MM_POLICY_CART_R
+	int cyc = zone->policy.nr_r < cart_longterm(zone);
 
-	if (t1) {
-		if (sat && rec)
-			return 0;
-		return 1;
-	}
+	t1 |= cyc;
+#endif
 
-	if (sat && !rec)
-		return 1;
-	return 0;
+	if ((t1 && !(rec && sat)) ||
+	    (!t1 && (!rec && sat)))
+			ret = 1;
+
+#if defined CONFIG_MM_POLICY_CART_R
+	if (ret && cyc)
+		SetZoneCyclic(zone);
+	else
+		ClearZoneCyclic(zone);
+#endif
+
+	return ret;
 }
 
 
@@ -642,7 +681,10 @@ void page_replace_zoneinfo(struct zone *
 		   "\n        T2         %lu"
 		   "\n        shortterm  %lu"
 		   "\n        p          %lu"
-		   "\n        flags      %lu"
+#if defined CONFIG_MM_POLICY_CART_R
+		   "\n        r          %lu"
+#endif
+		   "\n        flags      %lx"
 		   "\n        scanned    %lu"
 		   "\n        spanned    %lu"
 		   "\n        present    %lu",
@@ -654,6 +696,9 @@ void page_replace_zoneinfo(struct zone *
 		   zone->policy.nr_T2,
 		   zone->policy.nr_shortterm,
 		   zone->policy.nr_p,
+#if defined CONFIG_MM_POLICY_CART_R
+		   zone->policy.nr_r,
+#endif
 		   zone->policy.flags,
 		   zone->pages_scanned,
 		   zone->spanned_pages,
Index: linux-2.6-git/include/linux/mm_cart_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_cart_policy.h
+++ linux-2.6-git/include/linux/mm_cart_policy.h
@@ -82,6 +82,13 @@ static inline void page_replace_remove(s
 
 static inline int page_replace_reclaimable(struct page *page)
 {
+#if defined CONFIG_MM_POLICY_CART_R
+	if (PageNew(page) && ZoneCyclic(page_zone(page))) {
+		ClearPageNew(page);
+		return RECLAIM_OK;
+	}
+#endif
+
 	if (page_referenced(page, 1, 0))
 		return RECLAIM_ACTIVATE;
 
Index: linux-2.6-git/mm/Makefile
===================================================================
--- linux-2.6-git.orig/mm/Makefile
+++ linux-2.6-git/mm/Makefile
@@ -15,6 +15,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 obj-$(CONFIG_MM_POLICY_USEONCE) += useonce.o
 obj-$(CONFIG_MM_POLICY_CLOCKPRO) += nonresident.o clockpro.o
 obj-$(CONFIG_MM_POLICY_CART) += nonresident-cart.o cart.o
+obj-$(CONFIG_MM_POLICY_CART_R) += nonresident-cart.o cart.o
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
