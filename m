Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWAZSoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWAZSoa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWAZSoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:44:30 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:58278 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751362AbWAZSo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:44:29 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/9] Reducing fragmentation using zones v4
Date: Thu, 26 Jan 2006 18:43:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v4
  o Minor bugs
  o ppc64 can specify kernelcore
  o Ability to disable use of ZONE_EASYRCLM at boot time
  o HugeTLB uses ZONE_EASYRCLM
  o Add drain-percpu caches for testing
  o boot-parameter documentation added

This is a zone-based approach to anti-fragmentation. This is posted in light
of the discussions related to the list-based (sometimes dubbed as sub-zones)
approach where the prevailing opinion was that zones were the answer. The
patches are based on linux-2.6.16-rc1-mm3 and has been successfully tested
on x86 and ppc64. The patches are as follows;

Patches 1-7: These patches are related to the adding of the zone, setting
up the callers, configuring the kernel etc.

Patch 8,9: This is only for testing. The first stops the OOM killer hitting
everything in sight while stress-testing high-order allocations. The second
drains the per-cpu caches for large allocations to give a clearer view of
fragmentation. To have comparable results during the high-order stress test
allocation, this patch is applied to both the stock -mm kernel and the kernel
using the zone-based approach to anti-fragmentation.

For those watching carefully, this is a different test machine from V3,
I'm far away from that test box at the moment. The usage scenario I set up
to test out the patches is;

1. Test machine: UP x86 machine with 1.2GiB physical RAM
2. Boot with kernelcore=512MB . This gives the kernel 512MB to work with and
   the rest is placed in ZONE_EASYRCLM. (see patch 3 for more comments about
   the value of kernelcore)
3. Benchmark kbuild, aim9 and the capability to give HugeTLB pages

An alternative scenario has been tested that produces similar figures. The
scenario is;

1. Test machine: UP x86 machine with 1.2GiB physical RAM
2. Boot with mem=512MB
3. Hot-add the remaining memory
4. Benchmark kbuild, aim9 and high order allocations

The alternative scenario requires two more patches related to hot-adding on
the x86. I can post them if people want to take a look or experiment with
hot-add instead of using kernelcore= .

With zone-based anti-fragmentation, the usage of zones changes slightly on
the x86. The HIGHMEM zone is effectively split into two, with allocations
destined for this area split between HIGHMEM and EASYRCLM.  GFP_HIGHUSER pages
such as PTE's are passed to HIGHMEM and the remainder (mostly user pages)
are passed to EASYRCLM. Note that if kernelcore is less than the maximum size
of ZONE_NORMAL, GFP_HIGHMEM allocations will use ZONE_NORMAL, not the reachable
portion of ZONE_EASYRCLM.

I have tested with booting a kernel with no mem= or kernelcore= to make sure
there are no normal performance regressions.  On ppc64, a 2GiB system was
booted with kernelcore=896MB and dbench run as a regression test. It was
confirmed that ZONE_EASYRCLM was created and was being used.

Benchmark comparison between -mm+NoOOM tree and with the new zones

KBuild
                               2.6.16-rc1-mm3-clean  2.6.16-rc1-mm3-zbuddy-v4
Time taken to extract kernel:                    15                        15
Time taken to build kernel:                     413                       408

(Performance varies depending on how you configure the kernelcore parameter)

Aim9
                 2.6.16-rc1-mm3-clean  2.6.16-rc1-mm3-zbuddy-v4
 1 creat-clo                 38760.21                  39736.75     976.54  2.52% File Creations and Closes/second
 2 page_test                295722.38                 280273.33  -15449.05 -5.22% System Allocations & Pages/second
 3 brk_test                1516116.67                1754948.35  238831.68 15.75% System Memory Allocations/second
 4 jmp_test                7905965.67                8911233.33 1005267.66 12.72% Non-local gotos/second
 5 signal_test              177500.00                 177653.72     153.72  0.09% Signal Traps/second
 6 exec_test                   119.58                    122.71       3.13  2.62% Program Loads/second
 7 fork_test                  2759.08                   2962.84     203.76  7.39% Task Creations/second
 8 link_test                 11756.85                  12163.27     406.42  3.46% Link/Unlink Pairs/second

(Again, performnace depends on value of kernelcore although I am surprised
at the difference here. My suspicion is that kernelcore gives a larger
ZONE_EASYRCLM than the stock kernel has ZONE_HIGHMEM so it falls back less
but I have not proved it)

HugeTLB Allocation Capability under load
                                  2.6.16-rc1-mm3-clean  2.6.16-rc1-mm3-zbuddy-v4
During compile:                                      2                         2
At rest before dd of large file:                     8                        80
At rest after  dd of large file:                    27                       166

This test is different from previous reports. Older reports used a kernel
module to really try and allocate HugeTLB-sized pages which is a bit
artifical. This test uses only the proc interface to adjust nr_hugepages. The
test is still;
  1. Build 7 kernels at the same time
  2. Try and get HugeTLB pages
  3. Stop the compiles, delete the trees and try and get HugeTLB pages
  4. DD a file the size of physical memory, cat it to null and delete it, try 
     and get HugeTLB pages.

Under pressure, both kernels are comparable for getting huge pages via
proc. However, when the system is at rest, the anti-frag kernel was able
to allocate 72 more huge pages which is about 33% of physical memory. When
dd is used to try and flush the buffer cache, there is a massive difference
of 139 huge pages. Basically all of ZONE_EASYRCLM becomes available so the
result here depends on kernelcore as you'd expect.

In terms of performance, the kernel with the additional zone performs as
well as the standard kernel with variances between runs typically around
+/- 2% on each test in aim9. If the zone is not sized at all, there is no
measurable performance difference and the patches. The final diffstat for the
core changes (i.e. excluding the two testing patches) is;

 Documentation/kernel-parameters.txt |   20 +++++++++++++
 arch/i386/kernel/setup.c            |   48 ++++++++++++++++++++++++++++++++-
 arch/i386/mm/init.c                 |    2 -
 arch/powerpc/mm/mem.c               |    2 -
 arch/powerpc/mm/numa.c              |   52
+++++++++++++++++++++++++++++++++---
 arch/x86_64/mm/init.c               |    2 -
 fs/compat.c                         |    2 -
 fs/exec.c                           |    2 -
 fs/inode.c                          |    2 -
 include/asm-i386/page.h             |    3 +-
 include/linux/gfp.h                 |    3 ++
 include/linux/highmem.h             |    2 -
 include/linux/memory_hotplug.h      |    1
 include/linux/mmzone.h              |   12 ++++----
 mm/hugetlb.c                        |    4 +-
 mm/memory.c                         |    4 +-
 mm/mempolicy.c                      |    2 -
 mm/page_alloc.c                     |   20 +++++++++----
 mm/shmem.c                          |    4 ++
 mm/swap_state.c                     |    2 -
 20 files changed, 160 insertions(+), 29 deletions(-)
m

The zone-based approach for anti-fragmentation, once configured gives two
things. First, it is a "soft-area" for HugeTLB allocations. If an admin wants,
he can set aside an area that can be used for either normal user pages or for
HugeTLB pages. The huge pages can be got by having the system in a quiet state,
dd'ing a large file, catting it to null and deleting it again. This should help
the HPC scenario of a machine with long uptime running very different types
of jobs. Second, it gives an area that is relatively easy to hotplug remove.

Comments?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
