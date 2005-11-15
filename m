Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVKOQt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVKOQt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVKOQt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:49:58 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:30892 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964927AbVKOQt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:49:57 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Message-Id: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/5] Light Fragmentation Avoidance V20
Date: Tue, 15 Nov 2005 16:49:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a much simplified anti-defragmentation approach that simply tries to
keep kernel allocations in groups of 2^(MAX_ORDER-1) and easily reclaimed
allocations in groups of 2^(MAX_ORDER-1). It uses no balancing, tunables
special reserves and it introduces no new branches in the main path. For
small memory systems, it can be disabled via a config option.  In total,
it adds 275 new lines of code with minimum changes made to the main path.

It is fast and reduces fragmentation a lot giving a best-effort for low
fragmentation rather than hard guarantees. High order allocation stress tests
show that this mechanism is pretty good in practice. A zone-based system
approach based on this would give hard guarantees on the ability to reclaim
a region for hotplug or hugetlb pages with best-effort everywhere else. This
set of patches is aimed at giving best effort low fragmentation everywhere,
including zones the kernel is using.

Full benchmarks are below the Changelog, but here is the summary

			clean		anti-defrag
Kernel extract		15		16		-1 second
Kernel build		736		735		+1 second
aim9-page_test		131847.72	132832.86	+0.75%
aim9-brk_test		621709.43	623125.62	+0.23%
HugePages under load	73		113		+54%
HugePages after tests	78		118		+51%

In general, Aim9 shows the allocator is comparable.  The difference between
the kernel compiles is negligible indicating that this approach does not
impact the common code paths. The lack of higher success rates on HugePage
allocations was due to the presence of per-cpu pages.

When anti-defrag is disabled via the config option, it behaves and performs
just like the standard allocator with no performance impact. Comments on it's
complexity (still too complex?) and alternative benchmarks are appreciated.

Diffstat for full set of patches
 fs/buffer.c             |    3 
 fs/compat.c             |    2 
 fs/exec.c               |    2 
 fs/inode.c              |    2 
 include/asm-i386/page.h |    3 
 include/linux/gfp.h     |   13 +-
 include/linux/highmem.h |    3 
 include/linux/mmzone.h  |   67 ++++++++++
 init/Kconfig            |   12 +
 mm/memory.c             |    6 
 mm/page_alloc.c         |  305 ++++++++++++++++++++++++++++++++++++++----------
 mm/shmem.c              |    4 
 mm/swap_state.c         |    3 
 13 files changed, 350 insertions(+), 75 deletions(-)

Changelog since complex anti-defragmentation v19
o Updated to 2.6.14-mm2
o Removed the fallback area and balancing code
o Only differentiate between kernel and easy reclaimable allocations
  - Removes almost all the code that deals with usemaps
  - Made a number of simplifications based on two allocation lists
  - Fallback code is drastically simpler
o Do not change behaviour for high-order allocations
o Drop stats patch - unnecessary complications

Changelog since v18
o Resync against 2.6.14-rc5-mm1
o 004_markfree dropped
o Documentation note added on the behavior of free_area.nr_free

Changelog since v17
o Update to 2.6.14-rc4-mm1
o Remove explicit casts where implicit casts were in place
o Change __GFP_USER to __GFP_EASYRCLM, RCLM_USER to RCLM_EASY and PCPU_USER to
  PCPU_EASY
o Print a warning and return NULL if both RCLM flags are set in the GFP flags
o Reduce size of fallback_allocs
o Change magic number 64 to FREE_AREA_USEMAP_SIZE
o CodingStyle regressions cleanup
o Move sparsemen setup_usemap() out of header
o Changed fallback_balance to a mechanism that depended on zone->present_pages
  to avoid hotplug problems later
o Many superfluous parenthesis removed

Changlog since v16
o Variables using bit operations now are unsigned long. Note that when used
  as indices, they are integers and cast to unsigned long when necessary.
  This is because aim9 shows regressions when used as unsigned longs 
  throughout (~10% slowdown)
o 004_showfree added to provide more debugging information
o 008_stats dropped. Even with CONFIG_ALLOCSTATS disabled, it is causing 
  severe performance regressions. No explanation as to why
o for_each_rclmtype_order moved to header
o More coding style cleanups

Changelog since V14 (V15 not released)
o Update against 2.6.14-rc3
o Resync with Joel's work. All suggestions made on fix-ups to his last
  set of patches should also be in here. e.g. __GFP_USER is still __GFP_USER
  but is better commented.
o Large amount of CodingStyle, readability cleanups and corrections pointed
  out by Dave Hansen.
o Fix CONFIG_NUMA error that corrupted per-cpu lists
o Patches broken out to have one-feature-per-patch rather than
  more-code-per-patch
o Fix fallback bug where pages for RCLM_NORCLM end up on random other
  free lists.

Changelog since V13
o Patches are now broken out
o Added per-cpu draining of userrclm pages
o Brought the patch more in line with memory hotplug work
o Fine-grained use of the __GFP_USER and __GFP_KERNRCLM flags
o Many coding-style corrections
o Many whitespace-damage corrections

Changelog since V12
o Minor whitespace damage fixed as pointed by Joel Schopp

Changelog since V11
o Mainly a redefiff against 2.6.12-rc5
o Use #defines for indexing into pcpu lists
o Fix rounding error in the size of usemap

Changelog since V10
o All allocation types now use per-cpu caches like the standard allocator
o Removed all the additional buddy allocator statistic code
o Elimated three zone fields that can be lived without
o Simplified some loops
o Removed many unnecessary calculations

Changelog since V9
o Tightened what pools are used for fallbacks, less likely to fragment
o Many micro-optimisations to have the same performance as the standard 
  allocator. Modified allocator now faster than standard allocator using
  gcc 3.3.5
o Add counter for splits/coalescing

Changelog since V8
o rmqueue_bulk() allocates pages in large blocks and breaks it up into the
  requested size. Reduces the number of calls to __rmqueue()
o Beancounters are now a configurable option under "Kernel Hacking"
o Broke out some code into inline functions to be more Hotplug-friendly
o Increased the size of reserve for fallbacks from 10% to 12.5%. 

Changelog since V7
o Updated to 2.6.11-rc4
o Lots of cleanups, mainly related to beancounters
o Fixed up a miscalculation in the bitmap size as pointed out by Mike Kravetz
  (thanks Mike)
o Introduced a 10% reserve for fallbacks. Drastically reduces the number of
  kernnorclm allocations that go to the wrong places
o Don't trigger OOM when large allocations are involved

Changelog since V6
o Updated to 2.6.11-rc2
o Minor change to allow prezeroing to be a cleaner looking patch

Changelog since V5
o Fixed up gcc-2.95 errors
o Fixed up whitespace damage

Changelog since V4
o No changes. Applies cleanly against 2.6.11-rc1 and 2.6.11-rc1-bk6. Applies
  with offsets to 2.6.11-rc1-mm1

Changelog since V3
o inlined get_pageblock_type() and set_pageblock_type()
o set_pageblock_type() now takes a zone parameter to avoid a call to page_zone()
o When taking from the global pool, do not scan all the low-order lists

Changelog since V2
o Do not to interfere with the "min" decay
o Update the __GFP_BITS_SHIFT properly. Old value broke fsync and probably
  anything to do with asynchronous IO
  
Changelog since V1
o Update patch to 2.6.11-rc1
o Cleaned up bug where memory was wasted on a large bitmap
o Remove code that needed the binary buddy bitmaps
o Update flags to avoid colliding with __GFP_ZERO changes
o Extended fallback_count bean counters to show the fallback count for each
  allocation type
o In-code documentation

Version 1
o Initial release against 2.6.9

This patch is designed to reduce fragmentation in the standard buddy allocator
without impairing the performance of the allocator. High fragmentation
in the standard binary buddy allocator means that high-order allocations
can rarely be serviced. This patch works by dividing allocations into two
different types of allocations;

EasyReclaimable - These are userspace pages that are easily reclaimable. This
	flag is set when it is known that the pages will be trivially reclaimed
	by writing the page out to swap or syncing with backing storage

KernelNonReclaimable - These are pages that are allocated by the kernel that
	are not trivially reclaimed. For example, the memory allocated for a
	loaded module would be in this category. By default, allocations are
	considered to be of this type

Instead of having one global MAX_ORDER-sized array of free lists, there are
two, one for each type of allocation. Once a 2^MAX_ORDER block of pages is
split for a type of allocation, it is added to the free-lists for that type,
in effect reserving it. Hence, over time, pages of the different types can
be clustered together.

When the preferred freelists are expired, the largest possible block is taken
from the alternative list. Buddies that are split from that large block are
placed on the preferred allocation-type freelists to mitigate fragmentation.

Four benchmark results are included all based on a 2.6.14-mm2 kernel compiled
with gcc 3.4. These benchmarks were run in the order you see them *without*
rebooting. This means that when the final highorder stress test, the system is
already running with any fragmentation introduced by other benchmarks.

The first test called bench-kbuild.sh times a kernel build. Time is in seconds

			clean		anti-defrag
Kernel extract		15		16				
Kernel build		736		735

The second is the output of portions of AIM9 for the vanilla
allocator and the modified one;

(Tests run with bench-aim9.sh from VMRegress 0.18)
2.6.14-mm2-clean
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.03        959   15.97535        15975.35 File Creations and Closes/second
     2 page_test           60.02       4655   77.55748       131847.72 System Allocations & Pages/second
     3 brk_test            60.02       2195   36.57114       621709.43 System Memory Allocations/second
     4 jmp_test            60.00     264177 4402.95000      4402950.00 Non-local gotos/second
     5 signal_test         60.00       4982   83.03333        83033.33 Signal Traps/second
     6 exec_test           60.08        763   12.69973           63.50 Program Loads/second
     7 fork_test           60.06        977   16.26707         1626.71 Task Creations/second
     8 link_test           60.01       5315   88.56857         5579.82 Link/Unlink Pairs/second

2.6.14-mm2-mbuddy-v20
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.04        961   16.00600        16006.00 File Creations and Closes/second
     2 page_test           60.01       4689   78.13698       132832.86 System Allocations & Pages/second
     3 brk_test            60.02       2200   36.65445       623125.62 System Memory Allocations/second
     4 jmp_test            60.00     264321 4405.35000      4405350.00 Non-local gotos/second
     5 signal_test         60.01       4943   82.36961        82369.61 Signal Traps/second
     6 exec_test           60.05        757   12.60616           63.03 Program Loads/second
     7 fork_test           60.04        975   16.23917         1623.92 Task Creations/second
     8 link_test           60.02       5317   88.58714         5580.99 Link/Unlink Pairs/second
------------------------------------------------------------------------------------------------------------

Difference in performance operations report generated by diff-aim9.sh
                   Clean   mbuddy-v20
                ---------- ----------
 1 creat-clo      15975.35   16006.00      30.65  0.19% File Creations and Closes/second
 2 page_test     131847.72  132832.86     985.14  0.75% System Allocations & Pages/second
 3 brk_test      621709.43  623125.62    1416.19  0.23% System Memory Allocations/second
 4 jmp_test     4402950.00 4405350.00    2400.00  0.05% Non-local gotos/second
 5 signal_test    83033.33   82369.61    -663.72 -0.80% Signal Traps/second
 6 exec_test         63.50      63.03      -0.47 -0.74% Program Loads/second
 7 fork_test       1626.71    1623.92      -2.79 -0.17% Task Creations/second
 8 link_test       5579.82    5580.99       1.17  0.02% Link/Unlink Pairs/second

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

2.6.14-mm2-clean:      Average: 7.414 real, 7.08 user, 0.08 sys
2.6.14-mm2-mbuddy-v20: Average: 7.412 real, 7.236 user, 0.084 sys

So there are no adverse cache effects. The last test is to show that the
allocator can satisfy more high-order allocations, especially under load,
than the standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 4 copies of the tree. As each copy finishes, a compile starts at -j2
5. Start compiling the primary tree
6. Sleep 1 minute while the 7 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second
    - Performance will get badly shot as it forces considerable amounts of
      pageout

This is a relatively light load that consumes almost all of physical memory
without putting either allocator under serious pressure and triggering
OOM. The result of the allocations under load (load averaging 12) were;

2.6.14-mm2 Clean
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        73
Failed allocs:         87
DMA zone allocs:       0
Normal zone allocs:    22
HighMem zone allocs:   51
% Success:            45

2.6.14-mm2 MBuddy V20
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        96
Failed allocs:         64
DMA zone allocs:       0
Normal zone allocs:    30
HighMem zone allocs:   66
% Success:            60

It shows the placement policy is significantly better than the standard
allocator at satisfying hugetlb sized allocations.  After the tests completed,
the standard allocator was able to allocate 78 order-10 pages and the modified
allocator allocated 102.  It is known that the success of large allocations
is also dependant on the location of per-cpu pages but fixing that problem
is a separate issue.

The results show that the modified allocator has comparable speed, has no
adverse cache effects but is far less fragmented and in a better position
to satisfy high-order allocations.
-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
