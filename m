Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWDXUUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWDXUUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWDXUUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:20:16 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:27032 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751221AbWDXUUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:20:14 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060424202009.20409.89016.sendpatchset@skynet>
Subject: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V4
Date: Mon, 24 Apr 2006 21:20:09 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V4 of the patchset to size zones and memory holes in an
architecture-independent manner.

After this release, I would like to look at getting this into the -mm
tree assuming there are no boot-related problems found before I would
also like to hear some feedback. Andi has already stated for release V2
that he didn't think it helped x86_64 much, so later releases made more
effort at reducing the x86_64-specific code.  Andi, are you still concerned
about the x86_64 changes? For the i386, ia64 and power maintainers, have
you concerns or do you think these are ready to get some wider testing?
For anyone else watching, code reviews and acks would be very welcome
because my own testing cannot cover every machine configuration.

The reasons why I'd like to this merged include;

 o Less architecture-specific code - particuarly for x86 and ppc64
 o More maintainable. Changes to zone layout need only be made in one place
 o Zone-sizing and memory hole calculation is one less job that needs to be
   done for new architecture ports
 o With the architecture-independent representation, zone-based
   anti-fragmentation needs a lot less architecture-specific code making it
   more portable between architectures. This will be important for future
   hugepage-availability work
 o Nigel Cunningham has stated that that software suspend could potentially
   use the architecture-independent representation to discover what pages
   need to be saved during suspend


Changelog since V3
o Rebase to 2.6.17-rc2
o Allow the active regions to be cleared. Needed by x86_64 when it decides
  the SRAT table is bad half way through the registering of active regions
o Fix for flatmem x86_64 machines booting

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
Patch 4 changes x86_64 to use the mechanism - 96 arch-specific LOC removed
Patch 5 changes ia64 to use the mechanism - 57 arch-specific LOC removed

At this point, there is a reduction of 431 architecture-specific lines of code
and a net reduction of 52 lines. The arch-independent code is a lot easier
to read in comparison to some of the arch-specific stuff, particularly in
arch/i386/ .

For Patch 6, it was also noted that page_alloc.c has a *lot* of
initialisation code which makes the file harder to read than it needs to
be. Patch 6 creates a new file mem_init.c and moves a lot of initialisation
code from page_alloc.c to it. After the patch is applied, there is still a net
loss of 33 lines.

The patches have been successfully boot tested by me and verified that the
zones are the correct size on

o x86, flatmem with 1.5GiB of RAM
o x86, NUMAQ
o PPC64, NUMA
o PPC64, CONFIG_NUMA=n
o Power, RS6000 with and without HIGHMEM enabled
o x86_64, NUMA with SRAT
o x86_64, NUMA with broken SRAT that falls back to k8topology discovery
o x86_64, ACPI_NUMA, ACPI_MEMORY_HOTPLUG && !SPARSEMEM to trigger the
  hotadd path without sparsemem fun in srat.c (SRAT broken on test machine and
  I'm pretty sure the machine does not support physical memory hotadd anyway
  so test may not have been effective other than being a compile test.)
o x86_64, CONFIG_NUMA=n
o x86_64, AMD64 desktop machine with flatmem

Tony Luck has succesfully tested for ia64 on Itanium with tiger_defconfig,
gensparse_defconfig and defconfig. Bob Picco has also tested and debugged
on IA64. Jack Steiner successfully boot tested on a mammoth SGI IA64-based
machine. These were on patches against 2.6.17-rc1 but there have been no
ia64-changes made between release 3 and 4 of these patches.

There are differences in the zone sizes for x86_64 as the arch-specific code
for x86_64 accounts the kernel image and the starting mem_maps as memory
holes but the architecture-specific code accounts the memory as present.

The net reduction seems small but the big benefit of this set of patches
is the reduction of 431 lines of architecture-specific code, some of
which is very hairy. There should be a greater net reduction when other
architectures use the same mechanisms for zone and hole sizing but I lack
the hardware to test on.

Comments?

Additional credit;
	Dave Hansen for the initial suggestion and comments on early patches
	Andy Whitcroft for reviewing early versions and catching numerous errors
	Tony Luck for testing and debugging on IA64
	Bob Picco for testing and fixing bugs related to pfn registration
	Jack Steiner and Yasunori for testing on IA64

 arch/i386/Kconfig           |    8 
 arch/i386/kernel/setup.c    |   19 
 arch/i386/kernel/srat.c     |   98 ----
 arch/i386/mm/discontig.c    |   59 --
 arch/ia64/Kconfig           |    3 
 arch/ia64/mm/contig.c       |   60 --
 arch/ia64/mm/discontig.c    |   41 -
 arch/ia64/mm/init.c         |   12 
 arch/powerpc/Kconfig        |   13 
 arch/powerpc/mm/mem.c       |   53 --
 arch/powerpc/mm/numa.c      |  157 ------
 arch/ppc/Kconfig            |    3 
 arch/ppc/mm/init.c          |   26 -
 arch/x86_64/Kconfig         |    3 
 arch/x86_64/kernel/e820.c   |  109 +---
 arch/x86_64/kernel/setup.c  |    6 
 arch/x86_64/mm/init.c       |   62 --
 arch/x86_64/mm/k8topology.c |    3 
 arch/x86_64/mm/numa.c       |   18 
 arch/x86_64/mm/srat.c       |   10 
 include/asm-ia64/meminit.h  |    1 
 include/asm-x86_64/e820.h   |    5 
 include/asm-x86_64/proto.h  |    2 
 include/linux/mm.h          |   19 
 include/linux/mmzone.h      |   15 
 mm/Makefile                 |    2 
 mm/mem_init.c               | 1044 ++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  678 ----------------------------
 28 files changed, 1248 insertions(+), 1281 deletions(-)
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
