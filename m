Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSGMGUq>; Sat, 13 Jul 2002 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSGMGUp>; Sat, 13 Jul 2002 02:20:45 -0400
Received: from holomorphy.com ([66.224.33.161]:40352 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318105AbSGMGUo>;
	Sat, 13 Jul 2002 02:20:44 -0400
Date: Fri, 12 Jul 2002 23:22:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lazy_buddy-2.5.25-1
Message-ID: <20020713062232.GC21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020710085917.GP25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020710085917.GP25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 01:59:17AM -0700, William Lee Irwin III wrote:
> This patch implements deferred coalescing for the Linux page-level
[...]
> TODO:
[...]
> (5)  use split_free_pages() to recover pages from higher-order
> 	deferred queues to avoid spuriously failing under fragmentation

Okay, people bugged me about this so here it is, testbooted on an
8cpu 16GB i386 box:

Cheers,
Bill


===== mm/page_alloc.c 1.129 vs edited =====
--- 1.129/mm/page_alloc.c	Wed Jul 10 22:09:41 2002
+++ edited/mm/page_alloc.c	Fri Jul 12 22:55:45 2002
@@ -344,6 +344,26 @@
 	}
 }
 
+static struct page *FASTCALL(steal_deferred_page(zone_t *, int));
+static struct page *steal_deferred_page(zone_t *zone, int order)
+{
+	struct page *page;
+	free_area_t *area = zone->free_area;
+	int found_order;
+
+	for (found_order = order+1; found_order < MAX_ORDER; ++found_order)
+		if (!list_empty(&area[found_order].deferred_pages))
+			goto found_page;
+
+	return NULL;
+
+found_page:
+	page = list_entry(area[found_order].deferred_pages.next, struct page, list);
+	list_del(&page->list);
+	area[found_order].locally_free--;
+	split_pages(zone, page, order, found_order);
+}
+
 #ifdef CONFIG_SOFTWARE_SUSPEND
 int is_head_of_free_region(struct page *page)
 {
@@ -391,8 +411,12 @@
 		area->locally_free--;
 	} else
 		page = buddy_alloc(zone, order);
-	if (unlikely(!page))
+	if (unlikely(!page)) {
+		page = steal_deferred_page(zone, order);
+		if (likely(!page))
 		goto out;
+	}
+
 	prep_new_page(page);
 	area->active++;
 	zone->free_pages -= 1UL << order;
