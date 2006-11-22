Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755214AbWKVPwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbWKVPwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbWKVPwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:52:37 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:49883 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1755214AbWKVPwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:52:36 -0500
Date: Wed, 22 Nov 2006 15:52:33 +0000
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Noll <maan@systemlinux.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061122155233.GA30607@skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200611221142.21212.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/06 11:42), Andi Kleen didst pronounce:
> ject    : x86_64: Bad page state in process 'swapper'
> > References : http://lkml.org/lkml/2006/11/10/135
> >              http://lkml.org/lkml/2006/11/10/208
> > Submitter  : Andre Noll <maan@systemlinux.org>
> > Handled-By : David Rientjes <rientjes@cs.washington.edu>
> > Status     : problem is being debugged
> 
> Does this still happen with -rc6? 
> 
> It's probably another bug in the memmap parsing rewrite (Mel cc'ed) 
> but the debugging information in the standard kernel unfortunately
> doesn't give enough output to find out where it happens.
> 

Right, so I took a closer look to see what the story was.

According to the thread, this was the E820 map with the corresponding
PFNs appended to the usable regions.

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)    (  0-159)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)  
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)  
 BIOS-e820: 0000000000100000 - 00000000fbff0000 (usable)    (256-1032176)
 BIOS-e820: 00000000fbff0000 - 00000000fbfff000 (ACPI data) 
 BIOS-e820: 00000000fbfff000 - 00000000fc000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)    (1048576-2097152)

This is what the PFN ranges look like to arch-independent zone-sizing
reading the map without node awareness

Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 1032176) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2097152) 2 entries of 3200 used

That matches exactly. So far so good. Later with node awareness, we get

SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-fc000000
Entering add_active_range(0, 256, 1032176) 0 entries of 3200 used
SRAT: Node 1 PXM 1 100000000-200000000
Entering add_active_range(1, 1048576, 2097152) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-fc000000
Entering add_active_range(0, 0, 159) 2 entries of 3200 used
Entering add_active_range(0, 256, 1032176) 3 entries of 3200 used

Unusual ordering, but the information is still correct. The final sorted
map looks like;

early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->  1032176
    1:  1048576 ->  2097152

Again, everything there looks like what the E820 map reports so I don't
believe this is the zone-sizings code fault although it may be exposing a
bug from elsewhere. According to bootmap, things look like

Bootmem setup node 0 0000000000000000-00000000fc000000
Bootmem setup node 1 0000000100000000-0000000200000000

That's node 0 PFN 0->1032192 and node 1 PFN 1048576->2097152.

That is showing an additional 16 page frames that are not in the E820 map
(although I have seen this before and it didn't show up as a bad page). I
would be very interested in finding out what the bad_page PFNs are if this
bug still exists to see if it is those 16 frames. I've included a patch
below that might help.

Andre, if the bug still exists for you, can you apply Andi's patch to
reduce the log size and the following patch please and post us the
output with loglevel=8 please? Thanks

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-clean/arch/x86_64/mm/numa.c linux-2.6.19-rc6-debug_bootmem_init_issues/arch/x86_64/mm/numa.c
--- linux-2.6.19-rc6-clean/arch/x86_64/mm/numa.c	2006-11-22 15:08:20.000000000 +0000
+++ linux-2.6.19-rc6-debug_bootmem_init_issues/arch/x86_64/mm/numa.c	2006-11-22 15:07:47.000000000 +0000
@@ -192,6 +192,9 @@ void __init setup_node_zones(int nodeid)
 				memmapsize, SMP_CACHE_BYTES, 
 				round_down(limit - memmapsize, PAGE_SIZE), 
 				limit);
+	printk(KERN_DEBUG "Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			nodeid, NODE_DATA(nodeid)->node_mem_map,
+			memmapsize, NODE_DATA(nodeid)->node_mem_map);
 #endif
 } 
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-clean/mm/page_alloc.c linux-2.6.19-rc6-debug_bootmem_init_issues/mm/page_alloc.c
--- linux-2.6.19-rc6-clean/mm/page_alloc.c	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-debug_bootmem_init_issues/mm/page_alloc.c	2006-11-22 14:16:46.000000000 +0000
@@ -2453,6 +2453,9 @@ static void __init alloc_node_mem_map(st
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
 		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
+		printk(KERN_DEBUG
+			"Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			pgdat->node_id, map, size, pgdat->node_mem_map);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
@@ -2683,6 +2686,9 @@ void __init free_area_init_nodes(unsigne
 	/* Regions in the early_node_map can be in any order */
 	sort_node_map();
 
+	/* Print out the page size for debugging meminit problems */
+	printk(KERN_DEBUG "sizeof(struct page) = %d\n", sizeof(struct page));
+
 	/* Print out the zone ranges */
 	printk("Zone PFN ranges:\n");
 	for (i = 0; i < MAX_NR_ZONES; i++)
