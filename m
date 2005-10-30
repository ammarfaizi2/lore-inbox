Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJ3SeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJ3SeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJ3SeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:34:10 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37803 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932195AbVJ3SeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:34:09 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-Id: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/7] Fragmentation Avoidance V19
Date: Sun, 30 Oct 2005 18:33:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This is the latest release of the fragmentation avoidance patches with no
code changes since v18. If it is possible, I would like to get this into -mm,
so this patch is generated against the latest -mm tree 2.6.14-rc5-mm1 and
is known to apply cleanly. If there is another tree that should be diffed
against instead, just say so and I'll send another version.

Here are a few brief reasons why this set of patches is useful;

o Reduced fragmentation improves the chance a large order allocation succeeds
o General-purpose memory hotplug needs the page/memory groupings provided
o Reduces the number of badly-placed pages that page migration mechanism must
  deal with. This also applies to any active page defragmentation mechanism.
o This patch is a pre-requisite for a linear scanning mechanism that could
  be used to guarantee large-page allocations

Built and tested successfully on a single processor AMD machine, quad
processor Xeon machine and PPC64. Benchmarks are generated on the Xeon machine.

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
o Many superflous parenthesis removed

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
without impairing the performance of the allocator. High fragmentation in
the standard binary buddy allocator means that high-order allocations can
rarely be serviced. This patch works by dividing allocations into three
different types of allocations;

EasyReclaimable - These are userspace pages that are easily reclaimable. This
	flag is set when it is known that the pages will be trivially reclaimed
	by writing the page out to swap or syncing with backing storage

KernelReclaimable - These are pages allocated by the kernel that are easily
	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
	These type of pages potentially could be reclaimed by dumping the
	caches and reaping the slabs

KernelNonReclaimable - These are pages that are allocated by the kernel that
	are not trivially reclaimed. For example, the memory allocated for a
	loaded module would be in this category. By default, allocations are
	considered to be of this type

Instead of having one global MAX_ORDER-sized array of free lists,
there are four, one for each type of allocation and another reserve for
fallbacks. 

Once a 2^MAX_ORDER block of pages it split for a type of allocation, it is
added to the free-lists for that type, in effect reserving it. Hence, over
time, pages of the different types can be clustered together. This means that
if 2^MAX_ORDER number of pages were required, the system could linearly scan
a block of pages allocated for EasyReclaimable and page each of them out.

Fallback is used when there are no 2^MAX_ORDER pages available and there
are no free pages of the desired type. The fallback lists were chosen in a
way that keeps the most easily reclaimable pages together.

Three benchmark results are included all based on a 2.6.14-rc3 kernel
compiled with gcc 3.4 (it is known that gcc 2.95 produces different results).
The first is the output of portions of AIM9 for the vanilla allocator and
the modified one;

(Tests run with bench-aim9.sh from VMRegress 0.17)
2.6.14-rc5-mm1-clean
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.04        961   16.00600        16006.00 File Creations and Closes/second
     2 page_test           60.02       4149   69.12696       117515.83 System Allocations & Pages/second
     3 brk_test            60.04       1555   25.89940       440289.81 System Memory Allocations/second
     4 jmp_test            60.00     250768 4179.46667      4179466.67 Non-local gotos/second
     5 signal_test         60.01       4849   80.80320        80803.20 Signal Traps/second
     6 exec_test           60.00        741   12.35000           61.75 Program Loads/second
     7 fork_test           60.06        797   13.27006         1327.01 Task Creations/second
     8 link_test           60.01       5269   87.80203         5531.53 Link/Unlink Pairs/second

2.6.14-rc3-mbuddy-v19
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.04        954   15.88941        15889.41 File Creations and Closes/second
     2 page_test           60.01       4133   68.87185       117082.15 System Allocations & Pages/second
     3 brk_test            60.02       1546   25.75808       437887.37 System Memory Allocations/second
     4 jmp_test            60.00     250797 4179.95000      4179950.00 Non-local gotos/second
     5 signal_test         60.01       5121   85.33578        85335.78 Signal Traps/second
     6 exec_test           60.00        743   12.38333           61.92 Program Loads/second
     7 fork_test           60.05        806   13.42215         1342.21 Task Creations/second
     8 link_test           60.00       5291   88.18333         5555.55 Link/Unlink Pairs/second

Difference in performance operations report generated by diff-aim9.sh
                   Clean   mbuddy-v19
                ---------- ----------
 1 creat-clo      16006.00   15889.41    -116.59 -0.73% File Creations and Closes/second
 2 page_test     117515.83  117082.15    -433.68 -0.37% System Allocations & Pages/second
 3 brk_test      440289.81  437887.37   -2402.44 -0.55% System Memory Allocations/second
 4 jmp_test     4179466.67 4179950.00     483.33  0.01% Non-local gotos/second
 5 signal_test    80803.20   85335.78    4532.58  5.61% Signal Traps/second
 6 exec_test         61.75      61.92       0.17  0.28% Program Loads/second
 7 fork_test       1327.01    1342.21      15.20  1.15% Task Creations/second
 8 link_test       5531.53    5555.55      24.02  0.43% Link/Unlink Pairs/second

In this test, there were small regressions in the page_test. However, it
is known that different kernel configurations, compilers and even different
runs show similar varianes of +/- 3% .

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

2.6.14-rc5-mm1-clean:      Average: 43.254 real, 38.89 user, 0.042 sys
2.6.14-rc5-mm1-mbuddy-v19: Average: 43.212 real, 40.494 user, 0.044 sys

So there are no adverse cache effects. The last test is to show that the
allocator can satisfy more high-order allocations, especially under load,
than the standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 6 copies of the tree. As each copy finishes, a compile starts at -j2
5. Start compiling the primary tree
6. Sleep 1 minute while the 7 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second
    - Performance will get badly shot as it forces considerable amounts of
      pageout

The result of the allocations under load (load averaging 18) were;

2.6.14-rc5-mm1 Clean
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        30
Failed allocs:         130
DMA zone allocs:       0
Normal zone allocs:    7
HighMem zone allocs:   23
% Success:            18

2.6.14-rc5-mm1 MBuddy V19
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        76
Failed allocs:         84
DMA zone allocs:       1
Normal zone allocs:    30
HighMem zone allocs:   45
% Success:            47

One thing that had to be changed in the 2.6.14-rc5-mm1 clean test was to
disable the OOM killer. During one test, the OOM killer had better results
but invoked the OOM killer a very large number of times to achieve it. The
patch with the placement policy never invoked the OOM killer.

The above results are not very dramatic but the affect is very noticeable when
the system is at rest after the test completes. After the test, the standard
allocator was able to allocate 45 order-10 pages and the modified allocator
allocated 159. The ability to allocate large pages under load depend heavily
on the decisions of kswapd so there can be large variances in results but
that is a separate problem. It is also known that the success of large 
allocations is also dependant on the location of per-cpu pages but fixing
that problem is a separate issue.

The results show that the modified allocator has comparable speed, has no
adverse cache effects but is far less fragmented and in a better position
to satisfy high-order allocations.
-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
