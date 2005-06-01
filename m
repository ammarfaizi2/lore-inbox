Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFATEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFATEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFATDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:03:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53132 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261262AbVFATAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:00:07 -0400
Date: Wed, 1 Jun 2005 11:59:50 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       ia64 list <linux-ia64@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Periodically drain non local pagesets
In-Reply-To: <1117651618.13600.16.camel@localhost>
Message-ID: <Pine.LNX.4.62.0506011155270.9664@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0506011047060.9277@schroedinger.engr.sgi.com>
 <1117651618.13600.16.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Dave Hansen wrote:

> Also, are you sure that you need the local_irq_en/disable()?  

drain_pages() does the same. We would run into trouble if an 
interrupt would use the page allocator.

Fix for the zone comparison:

Index: linux-2.6.12-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.12-rc5.orig/mm/page_alloc.c	2005-06-01 10:41:25.000000000 -0700
+++ linux-2.6.12-rc5/mm/page_alloc.c	2005-06-01 11:57:55.000000000 -0700
@@ -528,7 +528,7 @@ void drain_remote_pages(void)
 		struct per_cpu_pageset *pset;
 
 		/* Do not drain local pagesets */
-		if (zone == zone_table[numa_node_id()])
+		if (zone->zone_pgdat->node_id == numa_node_id())
 			continue;
 
 		pset = zone->pageset[smp_processor_id()];
