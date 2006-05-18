Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWERPzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWERPzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWERPzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:55:44 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:42392
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751096AbWERPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:55:42 -0400
Date: Thu, 18 May 2006 16:55:12 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, nickpiggin@yahoo.com.au,
       haveblue@us.ibm.com, bob.picco@hp.com, mingo@elte.hu, mbligh@mbligh.org,
       ak@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] zone init check and report unaligned zone boundaries fix
Message-ID: <20060518155512.GA10814@shadowen.org>
References: <exportbomb.1147967697@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1147967697@pinky>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone init check and report unaligned zone boundaries fix v2

We are reporting bad boundaries for the first zone which is allowed
to be missaligned because nodes are not allowed to be missaligned,
and zones which have zero size.  Cull them.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 page_alloc.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -2223,10 +2223,6 @@ static void __meminit free_area_init_cor
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 
-		if (zone_boundary_align_pfn(zone_start_pfn) != zone_start_pfn)
-			printk(KERN_CRIT "node %d zone %s missaligned "
-					"start pfn\n", nid, zone_names[j]);
-
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -2235,6 +2231,11 @@ static void __meminit free_area_init_cor
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
 
+		if (zone_boundary_align_pfn(zone_start_pfn) !=
+					zone_start_pfn && j != 0 && size != 0)
+			printk(KERN_CRIT "node %d zone %s missaligned "
+					"start pfn\n", nid, zone_names[j]);
+
 		zone->spanned_pages = size;
 		zone->present_pages = realsize;
 		zone->name = zone_names[j];
