Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWE0Pvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWE0Pvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWE0Pvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:51:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38619 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751570AbWE0Pv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:29 -0400
Message-ID: <348745086.27363@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155127.522802387@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:48:53 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/32] mm: introduce PG_readahead
Content-Disposition: inline; filename=mm-PG_readahead.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new page flag: PG_readahead.

It acts as a look-ahead mark, which tells the page reader:
	Hey, it's time to invoke the adaptive read-ahead logic!
	For the sake of I/O pipelining, don't wait until it runs out of
	cached pages.  ;-)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/page-flags.h |    6 ++++++
 mm/page_alloc.c            |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
+++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
@@ -90,6 +90,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define PG_readahead		20	/* Reminder to do readahead */
+
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -372,6 +374,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
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
