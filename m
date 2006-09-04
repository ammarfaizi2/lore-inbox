Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWIDPid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWIDPid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWIDPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:38:33 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:62382 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S964876AbWIDPic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:38:32 -0400
Date: Mon, 4 Sep 2006 16:38:30 +0100
To: Keith Mannthey <kmannth@gmail.com>
Cc: akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Account for holes that are outside the range of physical memory
Message-ID: <20060904153830.GB14263@skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com> <20060831154903.GA7011@skynet.ie> <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com> <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie> <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com> <20060904153613.GA14263@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060904153613.GA14263@skynet.ie>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

absent_pages_in_range() made the assumption that users of the API would
not care about holes beyound the end of physical memory. This was not the
case. This patch will account for ranges outside of physical memory as
holes correctly.

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/arch/x86_64/mm/srat.c linux-2.6.18-rc4-mm3-001_account_holes_range/arch/x86_64/mm/srat.c
--- linux-2.6.18-rc4-mm3-clean/arch/x86_64/mm/srat.c	2006-08-28 15:05:28.000000000 +0100
+++ linux-2.6.18-rc4-mm3-001_account_holes_range/arch/x86_64/mm/srat.c	2006-09-01 13:29:25.000000000 +0100
@@ -240,7 +240,9 @@ static int reserve_hotadd(int node, unsi
 
 	/* This check might be a bit too strict, but I'm keeping it for now. */
 	if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
-		printk(KERN_ERR "SRAT: Hotplug area has existing memory\n");
+		printk(KERN_ERR
+			"SRAT: Hotplug area %lu -> %lu has existing memory\n",
+			s_pfn, e_pfn);
 		return -1;
 	}
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c linux-2.6.18-rc4-mm3-001_account_holes_range/mm/page_alloc.c
--- linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c	2006-08-28 15:05:30.000000000 +0100
+++ linux-2.6.18-rc4-mm3-001_account_holes_range/mm/page_alloc.c	2006-09-01 13:29:25.000000000 +0100
@@ -2259,6 +2259,10 @@ unsigned long __init __absent_pages_in_r
 	if (i == -1)
 		return 0;
 
+	/* Account for ranges before physical memory on this node */
+	if (early_node_map[i].start_pfn > range_start_pfn)
+		hole_pages = early_node_map[i].start_pfn - range_start_pfn;
+
 	prev_end_pfn = early_node_map[i].start_pfn;
 
 	/* Find all holes for the zone within the node */
@@ -2280,6 +2284,11 @@ unsigned long __init __absent_pages_in_r
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
+	/* Account for ranges past physical memory on this node */
+	if (range_end_pfn > prev_end_pfn)
+		hole_pages = range_end_pfn -
+				max(range_start_pfn, prev_end_pfn);
+
 	return hole_pages;
 }
 
@@ -2301,9 +2310,16 @@ unsigned long __init zone_absent_pages_i
 					unsigned long zone_type,
 					unsigned long *ignored)
 {
-	return __absent_pages_in_range(nid,
-				arch_zone_lowest_possible_pfn[zone_type],
-				arch_zone_highest_possible_pfn[zone_type]);
+	unsigned long node_start_pfn, node_end_pfn;
+	unsigned long zone_start_pfn, zone_end_pfn;
+
+	get_pfn_range_for_nid(nid, &node_start_pfn, &node_end_pfn);
+	zone_start_pfn = max(arch_zone_lowest_possible_pfn[zone_type],
+							node_start_pfn);
+	zone_end_pfn = min(arch_zone_highest_possible_pfn[zone_type],
+							node_end_pfn);
+
+	return __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 }
 
 /* Return the zone index a PFN is in */
