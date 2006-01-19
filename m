Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWASTKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWASTKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161349AbWASTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:10:08 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:47804 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161346AbWASTKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:10:04 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/5] Reducing fragmentation using zones
Date: Thu, 19 Jan 2006 19:08:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a zone-based approach to fragmentation reduction. This is posted
in light of the discussions related to the list-based (sometimes dubbed
as sub-zones) approach where the prevailing opinion was that zones were
the answer. The patches are based on linux-2.6.16-rc1-mm1 and has been
successfully tested on x86 and ppc64. The patches are as follows;

Patches 1-4: These patches are related to the adding of the zone and setting
up the callers

Patch 5: This is only for testing. It stops the OOM killer hitting everything
in sight while stress-testing high-order allocations. To have comparable
results during the high-order stress test allocation, this patch is applied
to both the stock -mm kernel and the kernel using the zone-based approach
to anti-fragmentation.

The usage scenario I set up to test out the patches is;

1. Test machine: 4-way x86 machine with 1.5GiB physical RAM
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
                               2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
Time taken to extract kernel:                    14                        14
Time taken to build kernel:                     741                       738

(Performance is about the same, what you would expect really. To see a
regression, you would have to have kernelcore=TooSmallANumber)

Aim9
                 2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
 1 creat-clo                 12273.11                  12235.72     -37.39 -0.30% File Creations and Closes/second
 2 page_test                131762.75                 132946.18    1183.43  0.90% System Allocations & Pages/second
 3 brk_test                 586206.90                 603298.90   17092.00  2.92% System Memory Allocations/second
 4 jmp_test                4375520.75                4376557.81    1037.06  0.02% Non-local gotos/second
 5 signal_test               79436.76                  81086.49    1649.73  2.08% Signal Traps/second
 6 exec_test                    62.90                     62.81      -0.09 -0.14% Program Loads/second
 7 fork_test                  1211.92                   1212.52       0.60  0.05% Task Creations/second
 8 link_test                  4332.30                   4346.60      14.30  0.33% Link/Unlink Pairs/second

(Again, performance is about the same. The differences are about the same
as what you would see between runs)

High order allocations under load
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3 
Order                                        10                        10 
Allocation type                         HighMem                   HighMem 
Attempted allocations                       275                       275 
Success allocs                               60                       106 
Failed allocs                               215                       169 
DMA zone allocs                               1                         1 
Normal zone allocs                            5                         8 
HighMem zone allocs                          54                         0 
EasyRclm zone allocs                          0                        97 
% Success                                    21                        38 
HighAlloc Under Load Test Results Pass 2
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3 
Order                                        10                        10 
Allocation type                         HighMem                   HighMem 
Attempted allocations                       275                       275 
Success allocs                              101                       154 
Failed allocs                               174                       121 
DMA zone allocs                               1                         1 
Normal zone allocs                            5                         8 
HighMem zone allocs                          95                         0 
EasyRclm zone allocs                          0                       145 
% Success                                    36                        56 
HighAlloc Test Results while Rested
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3 
Order                                        10                        10 
Allocation type                         HighMem                   HighMem 
Attempted allocations                       275                       275 
Success allocs                              141                       212 
Failed allocs                               134                        63 
DMA zone allocs                               1                         1 
Normal zone allocs                           16                         8 
HighMem zone allocs                         124                         0 
EasyRclm zone allocs                          0                       203 
% Success                                    51                        77 

The use of ZONE_EASYRCLM pushes up the success rate for HugeTLB-sized
allocations by 46 huge pages which is a big improvement.  To compare, the
list-based approach gave an additional 19. At rest, an additional 71 pages
were available although this varies depending on the location of per-cpu pages
(patch available that drains them).  To compare, at rest, the list-based
approach was able to allocate an additional 192 huge pages. It is important
to note that the value of kernelcore at boot time can have a big impact on
the these stress test. Again, to compare, list-based anti-fragmentation had
no tunables.

In terms of performance, the kernel with the additional zone performs as
well as the standard kernel with variances between runs typically around
+/- 2% on each test in aim9. If the zone is not sized at all, there is no
measurable performance difference and the patches. The zone-based approach is
a lot less invasive of the core paths than the list-based approach was. The
final diffstat is;

 arch/i386/kernel/setup.c |   28 +++++++++++++++++++++++++++-
 arch/powerpc/mm/numa.c   |   37 ++++++++++++++++++++++++++++++++++---
 fs/compat.c              |    2 +-
 fs/exec.c                |    2 +-
 fs/inode.c               |    2 +-
 include/asm-i386/page.h  |    3 ++-
 include/linux/gfp.h      |    3 +++
 include/linux/highmem.h  |    2 +-
 include/linux/mmzone.h   |   14 ++++++++------
 mm/memory.c              |    4 ++--
 mm/page_alloc.c          |   27 +++++++++++++++++++--------
 mm/shmem.c               |    4 ++++
 mm/swap_state.c          |    2 +-
 13 files changed, 104 insertions(+), 26 deletions(-)

Unlike the list-based (or sub-zones if you prefer) approach, the zone-based
approach does not not help high-order kernel allocations but it can help
huge pages. Huge pages are currently allocated from ZONE_HIGHMEM as they
are not "easily reclaimable". However, if the HugeTLB page is the same size
as a sparsemem section size (the smallest unit that can be hot-removed)
we could use ZONE_EASYRCLM. If huge pages are the same size as a sparsemem
section they cause no fragmentation with that section.  On ppc64 this is
typically the case, but not so on 86. One possibility is to have an
architecture-specific option that determines if ZONE_EASYRCLM is used or not.

Comments?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
