Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWF0RqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWF0RqB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWF0RqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:46:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2496 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161231AbWF0RqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:46:00 -0400
Date: Tue, 27 Jun 2006 10:45:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
Subject: [ZVC 1/4] Fix potential use of out of range page in kmem_getpages.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ZVC: Fix potential use of out of range page in kmem_getpages.

We use page_zone(page) following several page increments in kmem_getpages().
Which page in a zone we use really does not matter. However, we may reach an
invalid page and then oops.

So move the counter decrement before we increment page.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm3/mm/slab.c
===================================================================
--- linux-2.6.17-mm3.orig/mm/slab.c	2006-06-27 09:40:25.620599382 -0700
+++ linux-2.6.17-mm3/mm/slab.c	2006-06-27 09:40:32.330144958 -0700
@@ -1539,12 +1539,12 @@ static void kmem_freepages(struct kmem_c
 	struct page *page = virt_to_page(addr);
 	const unsigned long nr_freed = i;
 
+	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
 	while (i--) {
 		BUG_ON(!PageSlab(page));
 		__ClearPageSlab(page);
 		page++;
 	}
-	sub_zone_page_state(page_zone(page), NR_SLAB, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
