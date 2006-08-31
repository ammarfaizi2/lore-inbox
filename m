Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWHaPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWHaPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWHaPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:49:09 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:5531 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751662AbWHaPtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:49:06 -0400
Date: Thu, 31 Aug 2006 16:49:03 +0100
To: Keith Mannthey <kmannth@gmail.com>
Cc: akpm@osdl.org, tony.luck@intel.com, linux-mm@kvack.org, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Message-ID: <20060831154903.GA7011@skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (30/08/06 13:57), Keith Mannthey didst pronounce:
> On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
> >
> >Size zones and holes in an architecture independent manner for x86_64.
> 
> 
> Hey Mel,

Hi Keith.

>  I am having some trouble with the srat.c changes.  I keep running into
> "SRAT: Hotplug area has existing memory" so am am taking more throught
> look at this patch.
>  I am working on 2.6.18-rc4-mm3 x86_64.
> 

ok, great. How much physical memory is installed on the machine? I want to
determine if the "usable" entries in the e820 map contain physical memory
or not.

>   srat.c is doing some sanity checking against the e820 and hot-add
> memory ranges.  BIOS folk aren't to be trusted with the SRAT.  Calling
> remove_all_active_ranges before acpi_numa_init leaves nothing to fall
> back onto if the SRAT is bad.  (see bad_srat()). What should happen
> when we discard the srat info?
> 

When the SRAT is bad, the information is discarded and discovered by an
alternative method later in the boot process.

In this case, numa_initmem_init() is called after acpi_numa_init(). It
calls acpi_scan_nodes() which returns -1 because the SRAT is bad. Once
that happens, either k8_scan_nodes() will be called and the regions
discovered there or if that is not possible, it'll fall through and
e820_register_active_regions will be called without any node awareness.

>  i386 code may have similar fallback logic (haven't been there in a while)
> 

There is fallback logic in the i386 code as well.

> also
> 
> >diff -rup -X /usr/src/patchset-0.6/bin//dontdiff 
> >linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c 
> >linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c
> >--- linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c   
> >2006-08-21 09:23:50.000000000 +0100
> >+++ linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c   
> >2006-08-21 10:15:58.000000000 +0100
> >@@ -84,6 +84,7 @@ static __init void bad_srat(void)
> >                apicid_to_node[i] = NUMA_NO_NODE;
> >        for (i = 0; i < MAX_NUMNODES; i++)
> >                nodes_add[i].start = nodes[i].end = 0;
> >+       remove_all_active_ranges();
> > }
> 
> We go back to setup_arch with no active areas?
> 

Yes, and it'll be discovered using an alternative method later. There is
no point returning to setup_arch with known bad information about active
areas.

> > static __init inline int srat_disabled(void)
> >@@ -166,7 +167,7 @@ static int hotadd_enough_memory(struct b
> >
> >        if (mem < 0)
> >                return 0;
> >-       allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
> >+       allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) * 
> >PAGE_SIZE;
> >        allowed = (allowed / 100) * hotadd_percent;
> >        if (allocated + mem > allowed) {
> >                unsigned long range;
> >@@ -238,7 +239,7 @@ static int reserve_hotadd(int node, unsi
> >        }
> >
> >        /* This check might be a bit too strict, but I'm keeping it for 
> >        now. */
> >-       if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
> >+       if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
> >                printk(KERN_ERR "SRAT: Hotplug area has existing 
> >                memory\n");
> >                return -1;
> >        }
> We really do want to to compare against the e820 map at it contains
> the memory that is really present (this info was blown away before
> acpi_numa) 

The information used by absent_pages_in_range() should match what was
available to e820_hole_size().

> Anyway I fixed up to have the current chunk added
> (e820_register_active_regions) after calling this code so it logicaly
> makes sense but it still trip over the check.  
> I am not sure what you
> are printing out in you debug code but dosen't look like pfns or
> phys_addresses but maybe it can tell us why the check fails.
> 

My debug code for add_active_range() printing out pfns but I spotted one
case where absent_pages_in_range(I) does not do what one would expect.
Lets say the ranges with physical memory was 0->1000 and 2000-3000 (in
pfns).  absent_pages_in_range(0, 3000) would return 1000 as you'd expect but
absent_pages_in_range(5000-6000) would return 0! I have a patch that might
fix this at the end of the mail but I'm not sure it's the problem you are
hitting. In the bootlog, I see;

SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 152) 0 entries of 3200 used
Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-470000000
Entering add_active_range(0, 0, 152) 2 entries of 3200 used
Entering add_active_range(0, 256, 524165) 2 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
SRAT: Node 0 PXM 0 0-1070000000
SRAT: Hotplug area has existing memory

The last part (0-1070000000) is checked as a hotplug area but it's clear
that memory exists in that range.  As reserve_hotadd() requires that the
whole range be a hole, I'm having trouble seeing how it ever successfully
reserved unless the ranges going into reserve_hotadd() are something other
than the pfn range for 0-1070000000). The patch later will print out the
range used by reserve_hotadd() so we can see.

> >@@ -329,6 +330,8 @@ acpi_numa_memory_affinity_init(struct ac
> >
> >        printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
> >               nd->start, nd->end);
> >+       e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
> >+                                               nd->end >> PAGE_SHIFT);
> 
> A node chunk in this section of code may be a hot-pluggable zone. With
> MEMORY_HOTPLUG_SPARSE we don't want to register these regions.
> 

The ranges should not get registered as active memory by
e820_register_active_regions() unless they are marked E820_RAM. My
understanding is that the regions for hotadd would be marked "reserved"
in the e820 map. Is that wrong?

> >        if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 
> >        0) {
> >                /* Ignore hotadd region. Undo damage */
> 
>  I have but the e820_register_active_regions as a else to this
> statment the absent pages check fails.
> 

The patch below omits this change because I think
e820_register_active_regions() will still have got called by the time
you encounter a hotplug area.

> Also nodes_cover_memory and alot of these check were based against
> comparing the srat data against the e820.  Now all this code is
> comparing SRAT against SRAT....
> 

I don't see why. The SRAT table passes a range to
e820_register_active_regions() so should be comparing SRAT to e820

> I am willing to help here but we should compare the SRAT against to
> e820. Table v. Table.
> 
> What to you think should be done?
> 

Can you read through this patch and see does it address the problem in any
way? If it doesn't, can you send a complete bootlog so I can see what is
being sent to reserve_hotadd()? Thanks

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/arch/x86_64/mm/srat.c linux-2.6.18-rc4-mm3-fix_x8664_hotadd/arch/x86_64/mm/srat.c
--- linux-2.6.18-rc4-mm3-clean/arch/x86_64/mm/srat.c	2006-08-29 16:25:10.000000000 +0100
+++ linux-2.6.18-rc4-mm3-fix_x8664_hotadd/arch/x86_64/mm/srat.c	2006-08-31 16:17:26.000000000 +0100
@@ -240,7 +240,8 @@ static int reserve_hotadd(int node, unsi
 
 	/* This check might be a bit too strict, but I'm keeping it for now. */
 	if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
-		printk(KERN_ERR "SRAT: Hotplug area has existing memory\n");
+		printk(KERN_ERR "SRAT: Hotplug area %lu -> %lu has existing memory\n",
+				s_pfn, e_pfn);
 		return -1;
 	}
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c linux-2.6.18-rc4-mm3-fix_x8664_hotadd/mm/page_alloc.c
--- linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c	2006-08-29 16:25:31.000000000 +0100
+++ linux-2.6.18-rc4-mm3-fix_x8664_hotadd/mm/page_alloc.c	2006-08-31 14:52:38.000000000 +0100
@@ -2280,6 +2280,10 @@ unsigned long __init __absent_pages_in_r
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
+	/* If the range is outside of physical memory, return the range */
+	if (range_start_pfn > prev_end_pfn)
+		hole_pages = range_end_pfn - range_start_pfn;
+
 	return hole_pages;
 }
 
