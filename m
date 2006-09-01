Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWIALJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWIALJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWIALJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:09:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:35414 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751461AbWIALJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:09:11 -0400
Date: Fri, 1 Sep 2006 13:09:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 1/9] Guest page hinting: unused / free pages.
Message-ID: <20060901110908.GB15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 1/9] Guest page hinting: unused / free pages.

A very simple but already quite effective improvement in the handling
of guest memory vs. host memory is to tell the host when pages are
free. That allows the host to avoid the paging of guest pages without
meaningful content. The host can "forget" the page content and provide
a fresh frame containing zeroes instead.

To communicate the page states "unused" and "stable" to the host two
architecture defined primitives page_set_unused() and page_set_stable()
are introduced, which are used in the page allocator. The already
existing arch_free_page is not used for page_set_unused since it is
called before the reserved pages check. In addition arch_free_page can
do anything on a given architecture, while page_set_stable() and
page_set_unused() have a clearly defined meaning.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/mm.h          |    2 ++
 include/linux/page-states.h |   32 ++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |    3 +++
 3 files changed, 37 insertions(+)

diff -urpN linux-2.6/include/linux/mm.h linux-2.6-patched/include/linux/mm.h
--- linux-2.6/include/linux/mm.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/linux/mm.h	2006-09-01 12:49:35.000000000 +0200
@@ -304,6 +304,8 @@ struct page {
  * routine so they can be sure the page doesn't go away from under them.
  */
 
+#include <linux/page-states.h>
+
 /*
  * Drop a ref, return true if the refcount fell to zero (the page has no users)
  */
diff -urpN linux-2.6/include/linux/page-states.h linux-2.6-patched/include/linux/page-states.h
--- linux-2.6/include/linux/page-states.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/linux/page-states.h	2006-09-01 12:49:35.000000000 +0200
@@ -0,0 +1,32 @@
+#ifndef _LINUX_PAGE_STATES_H
+#define _LINUX_PAGE_STATES_H
+
+/*
+ * include/linux/page-states.h
+ *
+ * (C) Copyright IBM Corp. 2005, 2006
+ *
+ * Authors: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *          Hubertus Franke <frankeh@watson.ibm.com>
+ *          Himanshu Raj <rhim@cc.gatech.edu>
+ */
+
+#if defined(CONFIG_PAGE_STATES)
+#include <asm/page-states.h>
+#else
+
+/* Guest page hinting architecture primitives:
+ * - page_set_unused:
+ *     Indicates to the host that the page content is of no interest
+ *     to the guest. The host can "forget" the page content and replace
+ *     it with a page containing zeroes.
+ * - page_set_stable:
+ *     Indicate to the host that the page content is needed by the guest.
+ */
+
+#define page_set_unused(_page,_order)		do { } while (0)
+#define page_set_stable(_page,_order)		do { } while (0)
+
+#endif
+
+#endif /* _LINUX_PAGE_STATES_H */
diff -urpN linux-2.6/mm/page_alloc.c linux-2.6-patched/mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/page_alloc.c	2006-09-01 12:49:35.000000000 +0200
@@ -515,6 +515,7 @@ static void __free_pages_ok(struct page 
 		reserved += free_pages_check(page + i);
 	if (reserved)
 		return;
+	page_set_unused(page, order);
 
 	kernel_map_pages(page, 1 << order, 0);
 	local_irq_save(flags);
@@ -798,6 +799,7 @@ static void fastcall free_hot_cold_page(
 		page->mapping = NULL;
 	if (free_pages_check(page))
 		return;
+	page_set_unused(page, 0);
 
 	kernel_map_pages(page, 1, 0);
 
@@ -885,6 +887,7 @@ again:
 	put_cpu();
 
 	VM_BUG_ON(bad_range(zone, page));
+	page_set_stable(page, order);
 	if (prep_new_page(page, order, gfp_flags))
 		goto again;
 	return page;
