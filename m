Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDRNAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDRNAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDRNAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:00:24 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:54988 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750772AbWDRNAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:00:24 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060418130015.28928.10163.sendpatchset@skynet>
Subject: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V3
Date: Tue, 18 Apr 2006 14:00:15 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V3 of the patchset to size zones and memory holes in an
architecture-independent manner. A number of bugs have been fixed in the
IA64 changes and it is now known to boot with the correct zone sizes. In
this release, 98 lines of x86_64 arch-specific code is removed because
it used similar initialisation functions to powerpc. In the last release,
only 34 lines were removed.

Andi, in light of the x86_64 changes since the last release, can you take
another look at the x86_64 changes please? Does this release make a bit
more sense for x86_64 now?

Changelog since V2
o Fix a bug where holes in lower zones get double counted
o Catch the case where a new range is registered that is within an range
o Catch the case where a zone boundary is within a hole
o Use the EFI map for registering ranges on x86_64+numa
o On IA64+NUMA, add the active ranges before rounding for granules
o On x86_64, remove e820_hole_size and e820_bootmem_free and use
  arch-independent equivalents
o On x86_64, remove the map walk in e820_end_of_ram()
o Rename memory_present_with_active_regions, name ambiguous
o Add absent_pages_in_range() for arches to call

Changelog since V1
o Correctly convert virtual and physical addresses to PFNs on ia64
o Correctly convert physical addresses to PFN on older ppc 
o When add_active_range() is called with overlapping pfn ranges, merge them
o When a zone boundary occurs within a memory hole, account correctly
o Minor whitespace damage cleanup
o Debugging patch temporarily included

At a basic level, architectures define structures to record where active
ranges of page frames are located. Once located, the code to calculate
zone sizes and holes in each architecture is very similar.  Some of this
zone and hole sizing code is difficult to read for no good reason. This
set of patches eliminates the similar-looking architecture-specific code.

The patches introduce a mechanism where architectures register where the
active ranges of page frames are with add_active_range(). When all areas
have been discovered, free_area_init_nodes() is called to initialise
the pgdat and zones. The zone sizes and holes are then calculated in an
architecture independent manner.

Patch 1 introduces the mechanism for registering and initialising PFN ranges
Patch 2 changes ppc to use the mechanism - 128 arch-specific LOC removed
Patch 3 changes x86 to use the mechanism - 150 arch-specific LOC removed
Patch 4 changes x86_64 to use the mechanism - 98 arch-specific LOC removed
Patch 5 changes ia64 to use the mechanism - 60 arch-specific LOC removed

At this point, there is a net reduction of 62 lines of code and the
arch-independent code is a lot easier to read in comparison to some of
the arch-specific stuff, particularly in arch/i386/ .

For Patch 6, it was also noted that page_alloc.c has a *lot* of
initialisation code which makes the file harder to read than it needs to
be. Patch 6 creates a new file mem_init.c and moves a lot of initialisation
code from page_alloc.c to it. After the patch is applied, there is still a net
loss of 43 lines.

The patches have been successfully boot tested and verified that the
zones are the correct size on

o x86, flatmem
o x86, NUMAQ
o PPC64, NUMA
o PPC64, CONFIG_NUMA=n
o x86_64, NUMA with SRAT
o x86_64, CONFIG_NUMA=n

There are differences in the zone sizes for x86_64 as the arch-specific code
for x86_64 accounts the kernel image and the starting mem_maps as memory
holes but the architecture-specific code accounts the memory as present.
The patches have been compile tested for ia64 for flatmem and sparsemem
configurations. At attempt was made to boot test on an ancient RS/6000
but the vanilla kernel does not boot so I have to investigate there.

The net reduction seems small but the big benefit of this set of patches
is the reduction of 437 lines of architecture-specific code, some of
which is very hairy. There should be a greater net reduction when other
architectures use the same mechanisms for zone and hole sizing but I lack
the hardware to test on.

Comments?

Additional credit;
	Dave Hansen for the initial suggestion and comments on early patches
	Andy Whitcroft for reviewing early versions and catching numerous errors
	Tony Luck and Yasunori Goto for testing and debugging on IA64
	Bob Picco for testing and fixing bugs related to pfn registration

 arch/i386/Kconfig          |    8 
 arch/i386/kernel/setup.c   |   19 
 arch/i386/kernel/srat.c    |   98 ----
 arch/i386/mm/discontig.c   |   59 --
 arch/ia64/Kconfig          |    3 
 arch/ia64/mm/contig.c      |   60 --
 arch/ia64/mm/discontig.c   |   41 -
 arch/ia64/mm/init.c        |   12 
 arch/powerpc/Kconfig       |   13 
 arch/powerpc/mm/mem.c      |   53 --
 arch/powerpc/mm/numa.c     |  157 ------
 arch/ppc/Kconfig           |    3 
 arch/ppc/mm/init.c         |   26 -
 arch/x86_64/Kconfig        |    3 
 arch/x86_64/kernel/e820.c  |  109 +---
 arch/x86_64/kernel/setup.c |    3 
 arch/x86_64/mm/init.c      |   62 --
 arch/x86_64/mm/numa.c      |   18 
 arch/x86_64/mm/srat.c      |    7 
 include/asm-ia64/meminit.h |    1 
 include/asm-x86_64/e820.h  |    5 
 include/asm-x86_64/proto.h |    2 
 include/linux/mm.h         |   18 
 include/linux/mmzone.h     |   15 
 mm/Makefile                |    2 
 mm/mem_init.c              | 1040 +++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            |  678 -----------------------------
 27 files changed, 1236 insertions(+), 1279 deletions(-)

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
