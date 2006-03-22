Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWCVWhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWCVWhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWCVWhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:37:06 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3301 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932886AbWCVWg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:26 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223552.12658.16852.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 28/34] mm: clockpro-PG_reclaim2.patch
Date: Wed, 22 Mar 2006 23:36:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Add a second PG_flag to the page reclaim framework.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/page-flags.h |    2 ++
 mm/hugetlb.c               |    4 ++--
 mm/page_alloc.c            |    3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h	2006-03-13 20:38:26.000000000 +0100
+++ linux-2.6/include/linux/page-flags.h	2006-03-13 20:45:31.000000000 +0100
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_reclaim2		20	/* reserved by the mm reclaim code */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-03-13 20:38:26.000000000 +0100
+++ linux-2.6/mm/page_alloc.c	2006-03-13 20:45:31.000000000 +0100
@@ -150,6 +150,7 @@ static void bad_page(struct page *page)
 			1 << PG_private |
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
+			1 << PG_reclaim2 |
 			1 << PG_dirty	|
 			1 << PG_reclaim |
 			1 << PG_slab    |
@@ -361,6 +362,7 @@ static inline int free_pages_check(struc
 			1 << PG_private |
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
+			1 << PG_reclaim2 |
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
@@ -518,6 +520,7 @@ static int prep_new_page(struct page *pa
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_reclaim1 |
+			1 << PG_reclaim2 |
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
Index: linux-2.6/mm/hugetlb.c
===================================================================
--- linux-2.6.orig/mm/hugetlb.c	2006-03-13 20:38:26.000000000 +0100
+++ linux-2.6/mm/hugetlb.c	2006-03-13 20:45:31.000000000 +0100
@@ -152,8 +152,8 @@ static void update_and_free_page(struct 
 	nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]--;
 	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_reclaim1 | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_reclaim1 | 1 << PG_reclaim2 |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(&page[i], 0);
 	}
 	set_page_count(page, 1);
