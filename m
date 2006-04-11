Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWDKKkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWDKKkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWDKKkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:40:00 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:41423 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750717AbWDKKj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:39:59 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, ak@suse.de
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060411103946.18153.83059.sendpatchset@skynet>
Subject: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Date: Tue, 11 Apr 2006 11:39:46 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(The TO: list are the architecture maintainers according to the
MAINTAINERS. Apologies in advance if I got the list wrong)

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
Patch 2 changes ppc to use the mechanism - 136 arch-specific LOC removed
Patch 3 changes x86 to use the mechanism - 150 arch-specific LOC removed
Patch 4 changes x86_64 to use the mechanism - 35 arch-specific LOC removed
Patch 5 changes ia64 to use the mechanism - 59 arch-specific LOC removed

At this point, there is a net reduction of 27 lines of code and the
arch-independent code is a lot easier to read in comparison to some of
the arch-specific stuff, particularly in arch/i386/ .

For Patch 6, it was also noted that page_alloc.c has a *lot* of
initialisation code which makes the file harder to read than it needs to
be. Patch 6 creates a new file mem_init.c and moves a lot of initialisation
code from page_alloc.c to it. After the patch is applied, there is still
a net reduction of 3 lines of code.

The patches have been successfully boot tested on

o x86, flatmem
o x86, NUMAQ
o PPC64, NUMA
o PPC64, CONFIG_NUMA=n
o x86_64, NUMA with SRAT

The patches have only been *compile tested* for ia64 with a flatmem
configuration. At attempt was made to boot test on an ancient RS/6000
but the vanilla kernel does not boot so I have to investigate there.

The net reduction seems small but the big benefit of this set of patches
is the reduction of 380 lines of architecture-specific code, some of
which is very hairy. There should be a greater net reduction when other
architectures use the same mechanisms for zone and hole sizing but I lack
the hardware to test on.

Comments?

Additional credit;
	Dave Hansen for the initial suggestion and comments on early patches
	Andy Whitcroft for reviewing early versions and catching numerous errors

 arch/i386/Kconfig          |    8 
 arch/i386/kernel/setup.c   |   19 
 arch/i386/kernel/srat.c    |   98 ----
 arch/i386/mm/discontig.c   |   59 --
 arch/ia64/Kconfig          |    3 
 arch/ia64/mm/contig.c      |   62 --
 arch/ia64/mm/discontig.c   |   43 -
 arch/ia64/mm/init.c        |   10 
 arch/powerpc/Kconfig       |   13 
 arch/powerpc/mm/mem.c      |   50 --
 arch/powerpc/mm/numa.c     |  157 ------
 arch/ppc/Kconfig           |    3 
 arch/ppc/mm/init.c         |   21 
 arch/x86_64/Kconfig        |    3 
 arch/x86_64/kernel/e820.c  |   18 
 arch/x86_64/mm/init.c      |   60 --
 arch/x86_64/mm/numa.c      |   15 
 include/asm-ia64/meminit.h |    1 
 include/asm-x86_64/e820.h  |    1 
 include/asm-x86_64/proto.h |    2 
 include/linux/mm.h         |   14 
 include/linux/mmzone.h     |   15 
 mm/Makefile                |    2 
 mm/mem_init.c              | 1028 +++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            |  678 -----------------------------
 25 files changed, 1190 insertions(+), 1193 deletions(-)

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
