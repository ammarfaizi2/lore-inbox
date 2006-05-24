Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWEXLTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWEXLTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWEXLTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:01 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31360 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932681AbWEXLTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:01 -0400
Message-ID: <348469537.16036@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111858.869793445@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:50 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/33] readahead: page flag PG_readahead
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

--- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
+++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
@@ -89,6 +89,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_buddy		19	/* Page is free, on buddy lists */
+#define PG_readahead		20	/* Reminder to do readahead */
 
 
 #if (BITS_PER_LONG > 32)
@@ -372,6 +373,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define __SetPageReadahead(page) __set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux-2.6.17-rc4-mm3.orig/mm/page_alloc.c
+++ linux-2.6.17-rc4-mm3/mm/page_alloc.c
@@ -564,7 +564,7 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);

--
