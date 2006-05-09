Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWEILHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWEILHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWEILHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:07:21 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:14771
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751749AbWEILHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:07:19 -0400
Date: Tue, 9 May 2006 12:05:35 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Bob Picco <bob.picco@hp.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 2/3] x86 align highmem zone boundries with NUMA
Message-ID: <20060509110535.GA9732@shadowen.org>
References: <exportbomb.1147172704@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1147172704@pinky>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86 align highmem zone boundries with NUMA

When in x86 NUMA mode we allocate struct pages's node local and map
them into the kernel virtual address space in the remap space.
This space cuts into the end of ZONE_NORMAL.  When we round
ZONE_NORMAL down we must ensure we maintain the zone boundry
constraint, we must round to MAX_ORDER.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 discontig.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
diff -upN reference/arch/i386/mm/discontig.c current/arch/i386/mm/discontig.c
--- reference/arch/i386/mm/discontig.c
+++ current/arch/i386/mm/discontig.c
@@ -304,10 +304,13 @@ unsigned long __init setup_memory(void)
 	/* partially used pages are not usable - thus round upwards */
 	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
 
-	system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
+	max_low_pfn = find_max_low_pfn() - reserve_pages;
 	printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
 			reserve_pages, max_low_pfn + reserve_pages);
 	printk("max_pfn = %ld\n", max_pfn);
+
+	system_max_low_pfn = max_low_pfn = zone_boundry_align_pfn(max_low_pfn);
+
 #ifdef CONFIG_HIGHMEM
 	highstart_pfn = highend_pfn = max_pfn;
 	if (max_pfn > system_max_low_pfn)
