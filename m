Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWEERev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWEERev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWEEReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:34:50 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:33668 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750839AbWEEReu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:34:50 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 0/8] Reducing fragmentation using zones v6
Date: Fri,  5 May 2006 18:34:46 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V6 of the zone-based anti-fragmentation patches. These patches require
the architecture-independent zone-sizing patches posted under the subject
"[PATCH 0/7] Sizing zones and holes in an architecture independent manner V5"
at http://marc.theaimsgroup.com/?l=linux-kernel&m=114649066331962&w=2 .

In this version, all the zone sizing is done in one place rather
than per-architecture like older versions. Any architecture that uses
add_active_range() and free_area_init_nodes() to initialise it's zones
can trivially support ZONE_EASYRCLM by parsing a kernelcore= command-line
parameter and calling set_required_kernelcore().

As these patches require the zone-sizing merged first, I am not looking to
merge these now. I just wanted to show that zone-based anti-fragmentation is
a bit nicer looking when the zone sizing is not architecture-specific. Some
of this patch is a bit rough and ready :)

Changelog since v5
  o Rebase on top of arch-independent zone and hole sizing code
  o Calculate ZONE_EASYRCLM boundaries in an arch-independent manner

Changelog since v4
  o Move x86_64 from one patch to another
  o Fix for oops bug on ppc64

Changelog since v3
  o Minor bugs
  o ppc64 can specify kernelcore
  o Ability to disable use of ZONE_EASYRCLM at boot time
  o HugeTLB uses ZONE_EASYRCLM
  o Add drain-percpu caches for testing
  o boot-parameter documentation added

This is a zone-based approach to anti-fragmentation. This is posted in light
of the discussions related to the list-based (sometimes dubbed as sub-zones)
approach where the prevailing opinion was that zones were the answer. The
patches have been boot-tested based on linux-2.6.17-rc3-mm1 with x86,
x86_64, ppc64 in a variety of different configurations. It was boot-tested
on ia64 where it blew up before the serial console was initialised. Lacking
early_printk, I have not figured out what is going wrong there yet. If
anyone has physical access to an IA64 that can send me a bug report, I'd
appreciate it.

Ordinarily, I would include performance regressions, but I'm not looking to
merge this time.

The diffstat for the all the patches is;

 Documentation/kernel-parameters.txt |   16 ++
 arch/i386/kernel/setup.c            |   12 ++
 arch/i386/kernel/srat.c             |    2
 arch/ia64/kernel/efi.c              |    5
 arch/powerpc/kernel/prom.c          |    9 +
 arch/ppc/mm/init.c                  |    9 +
 arch/x86_64/kernel/setup.c          |    6 +
 arch/x86_64/mm/init.c               |    2
 fs/compat.c                         |    2
 fs/exec.c                           |    2
 fs/inode.c                          |   11 ++
 fs/ntfs/malloc.h                    |    3
 include/asm-i386/page.h             |    3
 include/linux/gfp.h                 |    3
 include/linux/highmem.h             |    2
 include/linux/mm.h                  |    1
 include/linux/mmzone.h              |   12 +-
 mm/hugetlb.c                        |    4
 mm/mem_init.c                       |  198 +++++++++++++++++++++++++++++++++---
 mm/memory.c                         |    4
 mm/page_alloc.c                     |   10 +
 mm/shmem.c                          |    4
 mm/swap_state.c                     |    2
 23 files changed, 288 insertions(+), 34 deletions(-)
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
