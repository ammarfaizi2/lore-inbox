Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVKUNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVKUNIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVKUNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:08:10 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:8527 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932302AbVKUNIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:08:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=UuIxJpls2Losq/V0VhZf4xpDJ2YXF+O5bRvpI9OwtKnMt2dlCZN5z3Ghe+ioSk0He7uGDMpC9DmHrONohkD89RHJx27pgUEGOwPX64PWtHq8d4YFEpfbXwdiqUsaxqKBffhIEa0wzggdjLvA+7CpuKJq68W5KTD0rVSCBZhT81Q=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124042.14370.75677.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 4/12] mm: set_page_refs opt
Date: Mon, 21 Nov 2005 08:08:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inline set_page_refs.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -450,23 +450,6 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-void set_page_refs(struct page *page, int order)
-{
-#ifdef CONFIG_MMU
-	set_page_count(page, 1);
-#else
-	int i;
-
-	/*
-	 * We need to reference all the pages for this order, otherwise if
-	 * anyone accesses one of the pages with (get/put) it will be freed.
-	 * - eg: access_process_vm()
-	 */
-	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
-#endif /* CONFIG_MMU */
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
Index: linux-2.6/mm/internal.h
===================================================================
--- linux-2.6.orig/mm/internal.h
+++ linux-2.6/mm/internal.h
@@ -9,5 +9,20 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-/* page_alloc.c */
-extern void set_page_refs(struct page *page, int order);
+static inline void set_page_refs(struct page *page, int order)
+{
+#ifdef CONFIG_MMU
+	set_page_count(page, 1);
+#else
+	int i;
+
+	/*
+	 * We need to reference all the pages for this order, otherwise if
+	 * anyone accesses one of the pages with (get/put) it will be freed.
+	 * - eg: access_process_vm()
+	 */
+	for (i = 0; i < (1 << order); i++)
+		set_page_count(page + i, 1);
+#endif /* CONFIG_MMU */
+}
+
Send instant messages to your online friends http://au.messenger.yahoo.com 
