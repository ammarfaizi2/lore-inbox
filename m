Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWCSCnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWCSCnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCSCnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:43:02 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:37826 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751287AbWCSCed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:33 -0500
Message-Id: <20060319023450.287264000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/23] readahead: page flag PG_readahead
Content-Disposition: inline; filename=readahead-page-flag-PG_readahead.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An new page flag PG_readahead is introduced as a look-ahead mark, which
reminds the caller to give the adaptive read-ahead logic a chance to do
read-ahead ahead of time for I/O pipelining.

It roughly corresponds to `ahead_start' of the stock read-ahead logic.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/page-flags.h |    5 +++++
 mm/page_alloc.c            |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-mm2.orig/include/linux/page-flags.h
+++ linux-2.6.16-rc6-mm2/include/linux/page-flags.h
@@ -76,6 +76,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_readahead		20	/* Reminder to do readahead */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -343,6 +344,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define __SetPageReadahead(page) __set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux-2.6.16-rc6-mm2.orig/mm/page_alloc.c
+++ linux-2.6.16-rc6-mm2/mm/page_alloc.c
@@ -549,7 +549,7 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);

--
