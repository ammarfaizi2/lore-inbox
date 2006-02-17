Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWBQORQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWBQORQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBQORQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:17:16 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:5598 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751024AbWBQORP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:17:15 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/7] Reducing fragmentation using zones v5
Date: Fri, 17 Feb 2006 14:15:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
patches have been tested based on linux-2.6.16-rc3-mm1 with x86 and two
different ppc64 machines. It has also been just booted tested on x86_64. If
there are no objections, I would like to these patches to spend some time
in -mm. The patches also apply with offsets to 2.6.16-rc3.

The usage scenario I set up to test out the patches is;

1. Test machine 1: 4-way x86 machine with 1.5GiB physical RAM
   Test machine 2: 4-way PPC64 machine with 4GiB physical RAM
2. Boot with kernelcore=512MB . This gives the kernel 512MB to work with and
   the rest is placed in ZONE_EASYRCLM. (see patch 3 for more comments about
      the value of kernelcore)
3. Benchmark kbuild, aim9 and high order allocations

An alternative scenario has been tested that produces similar figures. The
scenario is;

1. Test machine: 4-way x86 machine with 1.5GiB physical RAM
2. Boot with mem=512MB
3. Hot-add the remaining memory
4. Benchmark kbuild, aim9 and high order allocations

The alternative scenario requires two more patches related to hot-adding on
the x86. I can post them if people want to take a look or experiment with
hot-add instead of using kernelcore= .

Benchmark comparison between -mm+NoOOM tree and with the new zones on the
x86. The tests are run in order with no reboots between the tests.  This is
so that the system is in a used state when we try and allocate large pages.

KBuild
                               2.6.16-rc3-mm1-clean  2.6.16-rc3-mm1-zbuddy-v5
Time taken to extract kernel:                    16                        14
Time taken to build kernel:                    1110                      1110

Comparable performance there. On ppc64, zbuddy was slightly faster as well.

Aim9
                 2.6.16-rc3-mm1-clean  2.6.16-rc3-mm1-zbuddy-v5
 1 creat-clo            13381.10              13276.69     -104.41 -0.78% File Creations and Closes/second
 2 page_test            121821.06             123350.55    1529.49  1.26% System Allocations & Pages/second
 3 brk_test             597817.76             589136.95   -8680.81 -1.45% System Memory Allocations/second
 4 jmp_test            4372237.96            4377790.74    5552.78  0.13% Non-local gotos/second
 5 signal_test           84038.65              82755.75   -1282.90 -1.53% Signal Traps/second
 6 exec_test                61.99                 62.21       0.22  0.35% Program Loads/second
 7 fork_test              1178.82               1162.36     -16.46 -1.40% Task Creations/second
 8 link_test              4801.10               4799.00      -2.10 -0.04% Link/Unlink Pairs/second

Comparable performance again. On ppc64, almost all the microbenchmarks were
within 0.2% of each other. The one exception was jmp_test but then I found
that jmp_test results vary widely between runs on the same kernel on ppc64
so I ignored it.

HugeTLB Allocation Capability under load
This test is different from older reports. Older reports used a kernel module
to really try and allocate HugeTLB-sized pages which is artificial. This test
uses only the proc interface to adjust nr_hugepages. The test is;

  1. Build 7 kernels at the same time
  2. Try and get HugeTLB pages
  3. Stop the compiles, delete the trees and try and get HugeTLB pages
  4. DD a file the size of physical memory, cat it to /dev/null and delete
     it, try and get HugeTLB pages.

The results for x86 were;

                                  2.6.16-rc3-mm1-clean  2.6.16-rc3-mm1-zbuddy-v5
During compile:                                      7                         7
At rest before dd of large file:                    56                        60
At rest after  dd of large file:                    79                        85

These seem comparable, but it is only because the HighMem zone on the clean
kernel is a similar size to the EasyRclm zone with zbuddy-v5. With PPC64,
where there was a much larger difference, the results were;

                                  2.6.16-rc3-mm1-clean  2.6.16-rc3-mm1-zbuddy-v5
During compile:                                      0                         0
At rest before dd of large file:                     0                       103
At rest after  dd of large file:                     6                       154

So, the zone can potentially make a massive difference to the availability
of HugeTLB pages some systems. I am expecting a similar result on an x86
with more physical RAM than my current test box.

Using the kernel module to really stress the allocation of pages,
there were even wider differences between the results with the zone-based
anti-fragmentation kernel having a clear advantage. On ppc64, 191 huge pages
were available at rest with zone-based anti-fragmentation in comparison to
33 huge pages without it. On x86, the zone-based anti-fragmentation had
only slightly more huge pages, but this again is because of the similar
size of the HighMem on the clean kernel compared to the EasyRclm zone on
the anti-fragmentation kernel.

Bottom line, both kernels perform similarly on two different architectures but,
when configured correctly, there can be massive difference to the availability
of huge pages and the regions that can be hot-removed. When kernelcore is
not configured at boot time, there is no measurable differences between
the kernels.

The final diffstat for the patches is;
 Documentation/kernel-parameters.txt |   20 ++++++++++++
 arch/i386/kernel/setup.c            |   49 ++++++++++++++++++++++++++++++-
 arch/i386/mm/init.c                 |    2 -
 arch/powerpc/mm/mem.c               |    2 -
 arch/powerpc/mm/numa.c              |   56 ++++++++++++++++++++++++++++++++++--
 arch/x86_64/mm/init.c               |    2 -
 fs/compat.c                         |    2 -
 fs/exec.c                           |    2 -
 fs/inode.c                          |    2 -
 include/asm-i386/page.h             |    3 +
 include/linux/gfp.h                 |    3 +
 include/linux/highmem.h             |    2 -
 include/linux/memory_hotplug.h      |    1 
 include/linux/mmzone.h              |   12 ++++---
 mm/hugetlb.c                        |    4 +-
 mm/memory.c                         |    4 +-
 mm/mempolicy.c                      |    2 -
 mm/page_alloc.c                     |   20 +++++++++---
 mm/shmem.c                          |    4 ++
 mm/swap_state.c                     |    2 -
 20 files changed, 165 insertions(+), 29 deletions(-)

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
