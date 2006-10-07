Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWJGNGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWJGNGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWJGNGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:06:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:24976 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751708AbWJGNGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:06:07 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105824.14024.85405.sendpatchset@linux.site>
In-Reply-To: <20061007105758.14024.70048.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [patch 3/3] mm: add arch_alloc_page
Date: Sat,  7 Oct 2006 15:06:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an arch_alloc_page to match arch_free_page.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h	2006-10-06 11:59:20.000000000 +1000
+++ linux-2.6/include/linux/gfp.h	2006-10-06 12:02:35.000000000 +1000
@@ -101,6 +101,9 @@ static inline int gfp_zone(gfp_t gfp)
 #ifndef HAVE_ARCH_FREE_PAGE
 static inline void arch_free_page(struct page *page, int order) { }
 #endif
+#ifndef HAVE_ARCH_ALLOC_PAGE
+static inline void arch_alloc_page(struct page *page, int order) { }
+#endif
 
 extern struct page *
 FASTCALL(__alloc_pages(gfp_t, unsigned int, struct zonelist *));
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-10-06 12:01:52.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2006-10-06 12:02:35.000000000 +1000
@@ -552,6 +552,8 @@ static int prep_new_page(struct page *pa
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refcounted(page);
+
+	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
 
 	if (gfp_flags & __GFP_ZERO)
