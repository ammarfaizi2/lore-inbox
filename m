Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWIVECX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWIVECX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 00:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIVECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 00:02:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17581 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932258AbWIVECW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 00:02:22 -0400
Date: Thu, 21 Sep 2006 21:02:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: [RFC] Initial alpha-0 for new page allocator API
Message-ID: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have repeatedly discussed the problems of devices having varying 
address range requirements for doing DMA. We would like for the device 
drivers to have the ability to specify exactly which address range is 
allowed. Also the NUMA guys would like to have the ability to specify NUMA 
related information.

So I have put all the important allocation information in a struct 
allocation_control and am trying to get a new API developed that will fit 
our needs for better control over allocations. The discussion of the exact 
nature of the implementation necessary in the page allocator to supply 
pages fulfilling the criteria specified may better be deferred until we 
have a reasonable API.

The implementation given here uses the existing page_allocator in order to 
define the behavior of the new functions. The free functions have an _a_ 
and a _some_ in there to avoid name clashes. Will be removed later.

This is only a discussion basis. Once we agree on the API then I will 
implement that API with minimal effort on top of the existing page 
allocator and then we can try to see how a device driver would be working 
with this. I envision that we would have one allocation_control structure 
in the task structure to control the allocation of pages for a process. 
This should allow us to move the memory policy related information into 
the allocation_control structure. I also would think that a device driver
would have an allocation_control structure somewhere where parameters are 
set up so that allocations using this structure will yield the pages 
satisfying the requirements of the device drivers.

Index: linux-2.6.18-rc6-mm1/include/linux/allocator.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc6-mm1/include/linux/allocator.h	2006-09-21 20:48:30.000000000 -0700
@@ -0,0 +1,35 @@
+/*
+ * Necessary definitions to perform allocations
+ */
+
+#include <linux/mm.h>
+
+struct allocation_control {
+	gfp_t flags;
+	int order;
+#ifdef CONFIG_NUMA
+	int node;
+	struct mempol *mpol;
+#endif
+	unsigned long low_boundary;
+	unsigned long high_boundary;
+};
+
+/*
+ * Functions to allocate memory in units of PAGE_SIZE
+ */
+struct page *allocate_pages(struct allocation_control *ac,
+					gfp_t additional_flags);
+
+/*
+ * Free a single page
+ * (which may be of higher order if allocated with GFP_COMP set)
+ */
+void free_a_page(struct page *);
+
+/*
+ * Free a page as allocated with the given allocation control.
+ * This is needed if higher order pages were allocated without GFP_COMP set.
+ */
+void free_some_pages(struct page *, struct allocation_control *ac);
+
Index: linux-2.6.18-rc6-mm1/mm/page_allocator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc6-mm1/mm/page_allocator.c	2006-09-21 20:49:37.000000000 -0700
@@ -0,0 +1,37 @@
+/*
+ * Standard Page Allocator Definitions
+ */
+#include <linux/allocator.h>
+
+struct page *allocate_pages(struct allocation_control *ac,
+					gfp_t additional_flags)
+{
+	gfp_t gfp_flags = additional_flags | ac->flags;
+
+#ifdef CONFIG_ZONE_DMA32
+	if (high_boundary < MAX_DMA32_ADDRESS)
+			gfp_flags |= __GFP_DMA32;
+	else
+#endif
+#ifdef CONFIG_ZONE_DMA
+	if (high_boundary < MAX_DMA_ADDRESS)
+			gfp_flags |= GFP_DMA;
+#endif
+
+#ifdef CONFIG_NUMA
+	if (ac->node != -1)
+		return alloc_pages_node(ac->node, gfp_flags, ac->order);
+#endif
+
+	return alloc_pages(gfp_flags, ac->order);
+}
+
+void free_a_page(struct page *page)
+{
+	__free_pages(page, 0);
+}
+
+void free_some_pages(struct page *page, struct allocation_control *ac)
+{
+	__free_pages(page, ac->order);
+}
