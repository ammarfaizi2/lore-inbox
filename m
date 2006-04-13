Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWDMJwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWDMJwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWDMJwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:52:15 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:56792 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964864AbWDMJwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:52:14 -0400
Date: Thu, 13 Apr 2006 10:52:08 +0100
To: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060413095207.GA4047@skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (13/04/06 00:20), Mel Gorman didst pronounce:
> This is V2 of the patchset. They have been boot tested on x86, ppc64
> and x86_64 but I still need to do a double check that zones are the
> same size before and after the patch on all arches. IA64 passed a
> basic compile-test. a driver program that fed in the values generated
> by IA64 to add_active_range(), zone_present_pages_in_node() and
> zone_absent_pages_in_node() seemed to generate expected values.

I didn't look at the test program output carefully enough! There was a
double counting of some holes because of a missing "if" - obvious in the
morning. Fix is this (applies on top of the debugging patch)

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c linux-2.6.17-rc1-zonesizing-v7/mm/mem_init.c
--- linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c	2006-04-13 10:30:50.000000000 +0100
+++ linux-2.6.17-rc1-zonesizing-v7/mm/mem_init.c	2006-04-13 10:37:11.000000000 +0100
@@ -761,9 +761,11 @@ unsigned long __init zone_absent_pages_i
 		}
 
 		/* Update the hole size cound and move on */
-		hole_pages += start_pfn - prev_end_pfn;
-		printk("Hole found index %d: %lu -> %lu\n",
-				i, prev_end_pfn, start_pfn);
+		if (start_pfn > arch_zone_lowest_possible_pfn[zone_type]) {
+			hole_pages += start_pfn - prev_end_pfn;
+			printk("Hole found index %d: %lu -> %lu\n",
+					i, prev_end_pfn, start_pfn);
+		}
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
