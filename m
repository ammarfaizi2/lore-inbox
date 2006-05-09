Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWEILHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWEILHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWEILHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:07:15 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:13747
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751459AbWEILHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:07:14 -0400
Date: Tue, 9 May 2006 12:05:20 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Bob Picco <bob.picco@hp.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 1/3] zone init check and report unaligned zone boundries
Message-ID: <20060509110520.GA9634@shadowen.org>
References: <exportbomb.1147172704@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1147172704@pinky>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone init check and report unaligned zone boundries

We have a number of strict constraints on the layout of struct
page's for use with the buddy allocator.  One of which is that zone
boundries must occur at MAX_ORDER page boundries.  Add a check for
this during init.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mmzone.h |    5 +++++
 mm/page_alloc.c        |    4 ++++
 2 files changed, 9 insertions(+)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -388,6 +388,11 @@ static inline int is_dma(struct zone *zo
 	return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
 }
 
+static inline unsigned long zone_boundry_align_pfn(unsigned long pfn)
+{
+	return pfn & ~((1 << MAX_ORDER) - 1);
+}
+
 /* These two functions are used to setup the per zone pages min values */
 struct ctl_table;
 struct file;
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -2078,6 +2078,10 @@ static void __init free_area_init_core(s
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 
+		if (zone_boundry_align_pfn(zone_start_pfn) != zone_start_pfn)
+			printk(KERN_CRIT "node %d zone %s missaligned "
+					"start pfn\n", nid, zone_names[j]);
+
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
