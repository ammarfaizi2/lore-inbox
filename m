Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVKVTRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVKVTRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVKVTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:17:24 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32232 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965125AbVKVTRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:17:22 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Message-Id: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/5] Light fragmentation avoidance without usemap
Date: Tue, 22 Nov 2005 19:17:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an approach to anti-defragmentation that does not use a usemap bitmap
but uses a page flag. Rather than using separate free lists in the zone,
it extends the struct free_area which reduces the cache footprint a bit and
eliminates quite a lot of code. In total, it adds 246 lines of code, can be
fully disabled via a compile-time option without any performance penalty and
when enabled, it was able allocate 78% of physical memory in 4MiB contiguous
chunks after a heavy set of benchmarks completed.

This gives best-effort for low fragmentation in all zones. Guaranteed reclaim
for hotplug and high order allocation in a zone still requires a special zone.

Full benchmarks are below the Changelog, but here is the summary

			clean		anti-defrag
Kernel extract		16		16		(no difference)
Kernel build		736		736		(no difference)
aim9-page_test		132996.67	133802.07	+805.40 (0.61%)
aim9-brk_test		627478.75	628223.93	+745.18 (0.12%)
HugePages under load	79		98		+19     (24%)		
HugePages after tests	102		296		+194	(190%)

All the aim9 results measured are within 1% of the standard allocator. Kernel
compiles vary sometimes by about 1-2 seconds or about 0.1%. The HugeTLB pages
under load was 7 simulatanous kernel compiles, each -j1.

When anti-defrag is disabled via the config option, it behaves and
performs just like the standard allocator with no performance impact I can
measure. When it is enabled, there are definite variances but they are small
and on loads like kernel builds, it makes less than 3 seconds of a difference
over 12 minutes.

Diffstat for full set of patches
 fs/buffer.c                |    3 
 fs/compat.c                |    2 
 fs/exec.c                  |    2 
 fs/inode.c                 |    2 
 include/asm-i386/page.h    |    3 
 include/linux/gfp.h        |    3 
 include/linux/highmem.h    |    3 
 include/linux/mmzone.h     |   28 ++++-
 include/linux/page-flags.h |    8 +
 init/Kconfig               |   12 ++
 mm/memory.c                |    6 -
 mm/page_alloc.c            |  227 ++++++++++++++++++++++++++++++++++++---------
 mm/shmem.c                 |    4 
 mm/swap_state.c            |    3 
 14 files changed, 246 insertions(+), 60 deletions(-)

Changelog since v20
o Update to 2.6.15-rc1-mm2
o Remove usemap to reduce cache footprint, also does not hurt hotplug add
o Extend free_area not use new free_area lists, reduces footprint and is faster
o Leverage existing support for per-cpu page drain to avoid free but pinned
  pages
o Small number of micro-optimisations

Changelog since complex anti-defragmentation v19
o Updated to 2.6.15-rc1-mm2
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
be clustered together. When a page is allocated, the page-flags are updated
with a value indicating it's type of page so that it is placed on the correct
list on free.

When the preferred freelists are expired, the largest possible block is taken
from the alternative list. Buddies that are split from that large block are
placed on the preferred allocation-type freelists to mitigate fragmentation.

Four benchmark results are included all based on a 2.6.15-rc1-mm2 kernel
compiled with gcc 3.4. These benchmarks were run in the order you see them
*without* rebooting. This means that when the final highorder stress test,
the system is already running with any fragmentation introduced by other
benchmarks.

The first test called bench-kbuild.sh times a kernel build. Time is in seconds

			clean		anti-defrag
Kernel extract		16		16
Kernel build		736		736

The second is the output of portions of AIM9 for the vanilla
allocator and the modified one;

(Tests run with bench-aim9.sh from VMRegress 0.18)
2.6.15-rc1-mm2-clean
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.02        958   15.96135        15961.35 File Creations and Closes/second
     2 page_test           60.00       4694   78.23333       132996.67 System Allocations & Pages/second
     3 brk_test            60.01       2215   36.91051       627478.75 System Memory Allocations/second
     4 jmp_test            60.00     264119 4401.98333      4401983.33 Non-local gotos/second
     5 signal_test         60.02       5068   84.43852        84438.52 Signal Traps/second
     6 exec_test           60.07        761   12.66855           63.34 Program Loads/second
     7 fork_test           60.06       1073   17.86547         1786.55 Task Creations/second
     8 link_test           60.02       5282   88.00400         5544.25 Link/Unlink Pairs/second
------------------------------------------------------------------------------------------------------------

2.6.14-rc1-mm2-mbuddy-v21
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.04        957   15.93937        15939.37 File Creations and Closes/second
     2 page_test           60.02       4724   78.70710       133802.07 System Allocations & Pages/second
     3 brk_test            60.02       2218   36.95435       628223.93 System Memory Allocations/second
     4 jmp_test            60.01     264389 4405.74904      4405749.04 Non-local gotos/second
     5 signal_test         60.01       5022   83.68605        83686.05 Signal Traps/second
     6 exec_test           60.00        756   12.60000           63.00 Program Loads/second
     7 fork_test           60.06       1076   17.91542         1791.54 Task Creations/second
     8 link_test           60.01       5318   88.61856         5582.97 Link/Unlink Pairs/second
------------------------------------------------------------------------------------------------------------

Difference in performance operations report generated by diff-aim9.sh
                   Clean   mbuddy-v21
                ---------- ----------
 1 creat-clo      15961.35   15939.37     -21.98 -0.14% File Creations and Closes/second
 2 page_test     132996.67  133802.07     805.40  0.61% System Allocations & Pages/second
 3 brk_test      627478.75  628223.93     745.18  0.12% System Memory Allocations/second
 4 jmp_test     4401983.33 4405749.04    3765.71  0.09% Non-local gotos/second
 5 signal_test    84438.52   83686.05    -752.47 -0.89% Signal Traps/second
 6 exec_test         63.34      63.00      -0.34 -0.54% Program Loads/second
 7 fork_test       1786.55    1791.54       4.99  0.28% Task Creations/second
 8 link_test       5544.25    5582.97      38.72  0.70% Link/Unlink Pairs/second

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

2.6.15-rc1-mm2-clean:      Average: 7.42 real, 7.25 user, 0.078 sys
2.6.15-rc1-mm2-mbuddy-v21: Average: 7.406 real, 6.916 user, 0.088 sys

So there are no adverse cache effects. The last test is to show that the
allocator can satisfy more high-order allocations, especially under load,
than the standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 6 copies of the tree. As each copy finishes, a compile starts at -j1
5. Start compiling the primary tree
6. Sleep 1 minute while the 7 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 275 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second
    - Performance will get badly shot as it forces considerable amounts of
      pageout
8. At rest, dd a file from /dev/zero that is the size of physical memory, cat
   it and delete it again to flush as much of buffer cache as possible. Then
   try and allocate as many pages as possible

The result of the allocations under load;

2.6.15-rc1-mm2 Clean
rder:                 10
Allocation type:       HighMem
Attempted allocations: 275
Success allocs:        79
Failed allocs:         196
DMA zone allocs:       1
Normal zone allocs:    4
HighMem zone allocs:   74
% Success:            28

2.6.15-rc1-mm2 MBuddy V21
Order:                 10
Allocation type:       HighMem
Attempted allocations: 275
Success allocs:        98
Failed allocs:         177
DMA zone allocs:       1
Normal zone allocs:    2
HighMem zone allocs:   95
% Success:            35

There is not a large difference there but a lot of it depends on what decisions
LRU takes and under load, your chances are not good. An indicator of how
well fragmentation is addressed is testing again after the load decreases.
After the tests completed, the standard allocator was able to allocate 102
order-10 pages and the modified allocator allocated 296.

The results show that the modified allocator has comparable speed, has no
adverse cache effects but is far less fragmented and in a better position
to satisfy high-order allocations.
-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
