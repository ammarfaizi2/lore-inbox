Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWFFNrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWFFNrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWFFNrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:47:14 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:65239 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932161AbWFFNrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:47:14 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 0/5] Sizing zones and holes in an architecture independent manner V7
Date: Tue,  6 Jun 2006 14:47:10 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V7 of the patchset to size zones and memory holes in an
architecture-independent manner.

The notable change in this release is a fix of the ACPI bug on x86_64 from
V6. Christian Kujau has tested the various from rc4-mm1 to rc4-mm3 and found
that his ACPI problem got fixed in the later -mms for unknown reasons. He
tested rc4-mm3 with and without these patches and reported no problems. Bob
Picco also tested these patches and found that V6 had an ACPI problem with
mem=3GB (just below the ACPI data) but booted fine with this release. With
these tests, I think the patches are ready for another spin in -mm.

Changelog since V6
o MAX_ACTIVE_REGIONS is really maximum active regions, not MAX_ACTIVE_REGIONS-1
o MAX_ACTIVE_REGIONS is 256 unless the architecture specifically asks for
  a different number or MAX_NUMNODES is >= 32
o nr_nodemap_entries tracks the number of entries rather than terminating with
  end_pfn == 0
o Add number of documentation-related comments. Functions exposed by headers
  may potentially be picked up by kerneldoc
o Changed misleading zone_present_pages_in_node() name to
  zone_spanned_pages_in_node()
o Be a bit more verbose to help debugging when things go wrong.
o On x86_64, end_pfn_map now gets updated properly or ACPI tables get "lost"
o Signoffs added to patches 1 and 5 by Bob Picco related to contributions,
  fixes and reviews

Changelog since V5
o Add a missing #include to mm/mem_init.c
o Drop the verbose debugging part of the set
o Report active range registration when loglevel is set for KERN_DEBUG

Changelog since V4
o Rebase to 2.6.17-rc3-mm1
o Calculate holes on x86 with SRAT correctly

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
Patch 2 changes ppc to use the mechanism - 134 arch-specific LOC removed
Patch 3 changes x86 to use the mechanism - 142 arch-specific LOC removed
Patch 4 changes x86_64 to use the mechanism - 78 arch-specific LOC removed
Patch 5 changes ia64 to use the mechanism - 57 arch-specific LOC removed

The patches have been successfully boot tested by me and verified that the
zones are the correct size on

o x86, flatmem with 1.5GiB of RAM
o x86, NUMAQ
o x86 with SRAT CONFIG_NUMA=n
o PPC64, NUMA
o PPC64, CONFIG_NUMA=n
o PPC64, CONFIG_64BIT=N
o x86_64, NUMA with SRAT
o x86_64, NUMA with broken SRAT that falls back to k8topology discovery
o x86_64, CONFIG_NUMA=n
o x86_64, CONFIG_64=n
o x86_64, CONFIG_64=n, CONFIG_NUMA=n
o x86_64, ACPI_NUMA, ACPI_MEMORY_HOTPLUG && !SPARSEMEM to trigger the
  hotadd path without sparsemem fun in srat.c (SRAT broken on test machine and
  I'm pretty sure the machine does not support physical memory hotadd anyway
  so test may not have been effective other than being a compile test.)
o ia64 (Itanium 2)
o ia64 (Itanium 2), CONFIG_64=N

Tony Luck has successfully tested for ia64 on Itanium with tiger_defconfig,
gensparse_defconfig and defconfig. Bob Picco has also tested and debugged
on IA64. Jack Steiner successfully boot tested on a mammoth SGI IA64-based
machine. These were on patches against 2.6.17-rc1 and release 3 of these
patches but there have been no ia64-changes since release 3.

There are differences in the zone sizes for x86_64 as the arch-specific code
for x86_64 accounts the kernel image and the starting mem_maps as memory
holes but the architecture-independent code accounts the memory as present.

The big benefit of this set of patches is the reduction of 411 lines of
architecture-specific code, some of which is very hairy. There should be
a greater net reduction when other architectures use the same mechanisms
for zone and hole sizing but I lack the hardware to test on.

Additional credit;
	Dave Hansen for the initial suggestion and comments on early patches
	Andy Whitcroft for reviewing early versions and catching numerous errors
	Tony Luck for testing and debugging on IA64
	Bob Picco for fixing bugs related to pfn registration, reviewing a
		number of patch revisions, providing a number of suggestions on
		future direction and testing heavily
	Jack Steiner and Robin Holt for testing on IA64 and clarifying issues
		related to memory holes
	Yasunori for testing on IA64
	Andi Kleen for reviewing and feeding back about x86_64
	Christian Kujau for providing valuable information related to ACPI
		problems on x86_64 and testing potential fixes

 arch/i386/Kconfig           |    8 
 arch/i386/kernel/setup.c    |   19 
 arch/i386/kernel/srat.c     |  101 ---
 arch/i386/mm/discontig.c    |   65 --
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
 arch/x86_64/kernel/setup.c  |    7 
 arch/x86_64/mm/init.c       |   62 --
 arch/x86_64/mm/k8topology.c |    3 
 arch/x86_64/mm/numa.c       |   18 
 arch/x86_64/mm/srat.c       |   11 
 include/asm-ia64/meminit.h  |    1 
 include/asm-x86_64/e820.h   |    5 
 include/asm-x86_64/proto.h  |    2 
 include/linux/mm.h          |   34 +
 include/linux/mmzone.h      |   10 
 mm/Makefile                 |    2 
 mm/mem_init.c               | 1121 ++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  750 -----------------------------
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
