Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWDMTOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWDMTOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDMTOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:14:08 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:29093 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750806AbWDMTOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:14:07 -0400
Date: Thu, 13 Apr 2006 20:14:02 +0100
To: "Luck, Tony" <tony.luck@intel.com>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060413191402.GA20606@skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie> <20060413171942.GA15047@agluck-lia64.sc.intel.com> <20060413173008.GA19402@skynet.ie> <20060413174720.GA15183@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060413174720.GA15183@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (13/04/06 10:47), Luck, Tony didst pronounce:
> > Double counted a hole here, then went downhill. Does the following fix
> > it?
> 
> Yes, that boots.  What's more the counts of pages in DMA/Normal
> zone match the kernel w/o your patches too.  So for tiger_defconfig
> you've now exactly matched the old behaivour.
> 

Very very cool. Thanks for persisting.

> I'll try to test generic and sparse kernels later, but I have to
> look at another issue now.
> 

When you get around to it later, there is one case you may hit that Bob
Picco encountered and fixed for me. It's where a "new" range is registered
that is inside an existing area; e.g.

add_active_range:    0->10000
add_active_range: 9800->10000

It ends up merging incorrectly and you end up with one region from
9800-10000. The fix is below. 

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c linux-2.6.17-rc1-107-debug/mm/mem_init.c
--- linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c	2006-04-13 10:30:50.000000000 +0100
+++ linux-2.6.17-rc1-107-debug/mm/mem_init.c	2006-04-13 18:39:24.000000000 +0100
@@ -922,6 +926,13 @@ void __init add_active_range(unsigned in
 		if (early_node_map[i].nid != nid)
 			continue;
 
+		/* Skip if an existing region covers this new one */
+		if (start_pfn >= early_node_map[i].start_pfn &&
+				end_pfn <= early_node_map[i].end_pfn) {
+			printk("Existing\n");
+			return;
+		}
+
 		/* Merge forward if suitable */
 		if (start_pfn <= early_node_map[i].end_pfn &&
 				end_pfn > early_node_map[i].end_pfn) {
