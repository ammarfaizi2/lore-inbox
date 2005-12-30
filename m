Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVL3Wnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVL3Wnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVL3Wn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:43:29 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:24639 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S964855AbVL3WnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:43:06 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224242.765.58222.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 3/9] clockpro-PG_test.patch
Date: Fri, 30 Dec 2005 23:43:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Introduce a new PG_flag, needed for the clockpro work.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/page-flags.h |    8 ++++++++
 mm/page_alloc.c            |    3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6-git/include/linux/page-flags.h
===================================================================
--- linux-2.6-git.orig/include/linux/page-flags.h
+++ linux-2.6-git/include/linux/page-flags.h
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_test			20	/* Page is in its test period */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -303,6 +305,12 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageTest(page)	test_bit(PG_test, &(page)->flags)
+#define SetPageTest(page)	set_bit(PG_test, &(page)->flags)
+#define TestSetPageTest(page) test_and_set_bit(PG_test, &(page)->flags)
+#define ClearPageTest(page)	clear_bit(PG_test, &(page)->flags)
+#define TestClearPageTest(page) test_and_clear_bit(PG_test, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -499,7 +499,8 @@ static int prep_new_page(struct page *pa
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_checked | 1 << PG_mappedtodisk);
+			1 << PG_checked | 1 << PG_mappedtodisk |
+			1 << PG_test);
 	set_page_private(page, 0);
 	set_page_refs(page, order);
 	kernel_map_pages(page, 1 << order, 1);
