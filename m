Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWEHOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWEHOKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEHOKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:10:37 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:14262 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751269AbWEHOKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:10:36 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060508141030.26912.93090.sendpatchset@skynet>
Subject: [PATCH 0/6] Sizing zones and holes in an architecture independent manner V6
Date: Mon,  8 May 2006 15:10:30 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V6 of the patchset to size zones and memory holes in an
architecture-independent manner. This is based against 2.6.17-rc3-mm1
and as there were no objections to these patches since V4. Please merge.

The reasons why I'd like to this merged include;

 o Less architecture-specific code - particularly for x86 and ppc64
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

When testing on powerpc, I found compile errors that looked like this;

arch/powerpc/kernel/built-in.o(.init.text+0x7778): In function `vrsqrtefp':
: undefined reference to `__udivdi3'
arch/powerpc/kernel/built-in.o(.init.text+0x77c4): In function `vrsqrtefp':
: undefined reference to `__udivdi3'
make: *** [.tmp_vmlinux1] Error 1

A workaround that is *very likely wrong* and blatantly stolen from arch/sh
is at http://www.csn.ul.ie/~mel/udivdi3-powerpc-workaround.diff .

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
Patch 2 changes ppc to use the mechanism - 128 arch-specific LOC removed
Patch 3 changes x86 to use the mechanism - 142 arch-specific LOC removed
Patch 4 changes x86_64 to use the mechanism - 94 arch-specific LOC removed
Patch 5 changes ia64 to use the mechanism - 57 arch-specific LOC removed

At this point, there is a reduction of 421 architecture-specific lines of code
and a net reduction of 25 lines. The arch-independent code is a lot easier
to read in comparison to some of the arch-specific stuff, particularly in
arch/i386/ .

For Patch 6, it was also noted that page_alloc.c has a *lot* of
initialisation code which makes the file harder to read than it needs to
be. Patch 6 creates a new file mem_init.c and moves a lot of initialisation
code from page_alloc.c to it. After the patch is applied, there is still a net
loss of 7 lines.

The patches have been successfully boot tested by me and verified that the
zones are the correct size on

o x86, flatmem with 1.5GiB of RAM
o x86, NUMAQ
o x86, NUMA, with SRAT
o x86 with SRAT CONFIG_NUMA=n
o PPC64, NUMA
o PPC64, CONFIG_NUMA=n
o PPC64, CONFIG_64BIT=N
o Power, RS6000 (Had difficulty here with missing __udivdi3 symbol)
o x86_64, NUMA with SRAT
o x86_64, NUMA with broken SRAT that falls back to k8topology discovery
o x86_64, ACPI_NUMA, ACPI_MEMORY_HOTPLUG && !SPARSEMEM to trigger the
  hotadd path without sparsemem fun in srat.c (SRAT broken on test machine and
  I'm pretty sure the machine does not support physical memory hotadd anyway
  so test may not have been effective other than being a compile test.)
o x86_64, CONFIG_NUMA=n
o x86_64, CONFIG_64=n
o x86_64, CONFIG_64=n, CONFIG_NUMA=n
o x86_64, AMD64 desktop machine with flatmem
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

The net reduction seems small but the big benefit of this set of patches
is the reduction of 421 lines of architecture-specific code, some of
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
	Andi Kleen for reviewing and feeding back about x86_64

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
