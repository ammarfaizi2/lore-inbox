Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966243AbWKOHu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966243AbWKOHu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755482AbWKOHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:27 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22477 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755477AbWKOHu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:26 -0500
Message-ID: <363577021.03710@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075025.438524224@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/28] mm: introduce PG_readahead
Content-Disposition: inline; filename=mm-introduce-pg_readahead.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new page flag: PG_readahead.

It acts as a look-ahead mark, which tells the page reader:
	Hey, it's time to invoke the adaptive read-ahead logic!
	For the sake of I/O pipelining, don't wait until it runs out of
	cached pages.  ;-)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/page-flags.h
+++ linux-2.6.19-rc5-mm2/include/linux/page-flags.h
@@ -91,6 +91,8 @@
 #define PG_nosave_free		18	/* Used for system suspend/resume */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define PG_readahead		20	/* Reminder to do read-ahead */
+
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -247,6 +249,10 @@ static inline void SetPageUptodate(struc
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define ClearPageReadahead(page) clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux-2.6.19-rc5-mm2.orig/mm/page_alloc.c
+++ linux-2.6.19-rc5-mm2/mm/page_alloc.c
@@ -598,7 +598,7 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_fs_misc | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);

--
