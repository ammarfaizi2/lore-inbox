Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWIDJpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIDJpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWIDJpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:45:09 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:58267 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751282AbWIDJpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:45:07 -0400
Date: Mon, 4 Sep 2006 10:45:03 +0100
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
Message-ID: <20060904094503.GA4475@skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com> <Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie> <20060831100156.24fc0521.pj@sgi.com> <Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie> <20060901202430.0681f5c5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060901202430.0681f5c5.pj@sgi.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/09/06 20:24), Paul Jackson didst pronounce:
> > That is a bit of a sickener. It may be worth getting your good lab tech 
> > to check if there is a configuration setting in the hardware for 
> > simulating console output before you make the trip.
> 
> Apparently my lab setup simply lacks correct flow control on the serial
> console line.  I hacked the 8250 serial driver in my kernel to put a one
> msec delay between each character output, and it no longer drops
> console output during boot.
> 

Nice work.

> > > This may take a day or three to yield results, unless I get lucky.
> > >
> > 
> > I have Keith's problem with reserve-based-hot-add to keep me occupied in 
> > the meantime. Whenever you get the chance will be fine. Thanks a lot
> 
> Ok, below is the console output for one of these crashes.
> 
> This output is missing the first couple dozen lines commencing with
> grub announcing it is loading my kernel, as those lines seem to go via
> a different serial driver that I didn't chase down to hack.  Those
> initial lines were still dropping lotsa chars.  If you need those
> initial lines bad, holler, and I can probably hack something to get
> them to show up.
> 

I could do with those lines, but I believe there was enough information
printed to determine why it failed to boot. I've attached a patch that
should boot the machine and assuming it works, I just need the output of
dmesg.

> By the way, the crash continues to happen 100% with the patch:
> 
>   patches/account-for-memmap-and-optionally-the-kernel-image-as-holes.patch
> 

Not suprising considering what the min_free_kbytes is from this output!

> Node 0 DMA free:1616kB min:143085642166168kB low:178857052707708kB high:214628463249252kB active:0kB inactive:0kB present:18446744073709538996kB pages_scanned:0 all_unreclaimable? yes
> lowmem_reserve[]: 0 2026 2026
> Node 0 DMA32 free:2036328kB min:5776kB low:7220kB high:8664kB active:0kB inactive:0kB present:2075356kB pages_scanned:0 all_unreclaimable? no
>

I believe it is because memmap was calculated to be bigger than it
possibly could be. Can you try booting the following patch with
loglevel=8 and send me the dmesg output if it boots please? Thanks

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c linux-2.6.18-rc4-mm3-fix_accountmemmap/mm/page_alloc.c
--- linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c	2006-08-28 15:05:30.000000000 +0100
+++ linux-2.6.18-rc4-mm3-fix_accountmemmap/mm/page_alloc.c	2006-09-04 10:36:04.000000000 +0100
@@ -2373,7 +2373,9 @@ unsigned long __meminit account_memmap(s
 	if (zone_index == memmap_zone_idx(pgdat->node_mem_map)) {
 		pages = pgdat->node_spanned_pages;
 		pages = (pages * sizeof(struct page)) >> PAGE_SHIFT;
-		printk(KERN_DEBUG "%lu pages used for memmap\n", pages);
+		printk(KERN_DEBUG
+			"  %s zone: %lu pages used for memmap\n",
+			zone_names[zone_index], pages);
 	}
 	return pages;
 }
@@ -2411,7 +2413,9 @@ unsigned long account_memmap(struct pgli
 	}
 
 	pages >>= PAGE_SHIFT;
-	printk(KERN_DEBUG "%lu pages used for SPARSE memmap\n", pages);
+	printk(KERN_DEBUG
+		"  %s zone: %lu pages used for SPARSEMEM memmap\n",
+		zone_names[zone_index], pages);
 	return pages;
 }
 #endif
@@ -2437,17 +2441,24 @@ static void __meminit free_area_init_cor
 	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, realsize;
+		unsigned long size, realsize, memmap_size;
 
 		size = zone_spanned_pages_in_node(nid, j, zones_size);
 		realsize = size - zone_absent_pages_in_node(nid, j,
 								zholes_size);
 
-		realsize -= account_memmap(pgdat, j);
+		/* Account for the size of mem_map */
+		memmap_size = account_memmap(pgdat, j);
+		if (realsize >= memmap_size)
+			realsize -= memmap_size;
+		else
+			printk(KERN_WARNING "memmap_size of %lu exceeds %lu\n",
+					memmap_size, realsize);
+
 		/* Account for reserved DMA pages */
 		if (j == ZONE_DMA && realsize > dma_reserve) {
 			realsize -= dma_reserve;
-			printk(KERN_DEBUG "%lu pages DMA reserved\n",
+			printk(KERN_DEBUG "  DMA zone: %lu pages reserved\n",
 								dma_reserve);
 		}
 

-- 
VGER BF report: U 0.499996
