Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVJEOqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVJEOqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVJEOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:04 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:51342 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932639AbVJEOqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:46:00 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 0/7] Fragmentation Avoidance V16
Date: Wed,  5 Oct 2005 15:45:47 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

UserReclaimable - These are userspace pages that are easily reclaimable. This
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
a block of pages allocated for UserReclaimable and page each of them out.

Fallback is used when there are no 2^MAX_ORDER pages available and there
are no free pages of the desired type. The fallback lists were chosen in a
way that keeps the most easily reclaimable pages together.

Three benchmark results are included all based on a 2.6.14-rc3 kernel
compiled with gcc 3.4 (it is known that gcc 2.95 produces different results).
The first is the output of portions of AIM9 for the vanilla allocator and
the modified one;

(Tests run with bench-aim9.sh from VMRegress 0.14)
2.6.14-rc3
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.04        963   16.03931        16039.31 File Creations and Closes/second
     2 page_test           60.01       4194   69.88835       118810.20 System Allocations & Pages/second
     3 brk_test            60.03       1573   26.20356       445460.60 System Memory Allocations/second
     4 jmp_test            60.01     251144 4185.03583      4185035.83 Non-local gotos/second
     5 signal_test         60.02       5118   85.27158        85271.58 Signal Traps/second
     6 exec_test           60.03        758   12.62702           63.14 Program Loads/second
     7 fork_test           60.03        820   13.65984         1365.98 Task Creations/second
     8 link_test           60.02       5326   88.73709         5590.44 Link/Unlink Pairs/second

2.6.14-rc3-mbuddy-v16
------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 creat-clo           60.06        959   15.96737        15967.37 File Creations and Closes/second
     2 page_test           60.02       4067   67.76075       115193.27 System Allocations & Pages/second
     3 brk_test            60.01       1578   26.29562       447025.50 System Memory Allocations/second
     4 jmp_test            60.01     251498 4190.93484      4190934.84 Non-local gotos/second
     5 signal_test         60.01       5127   85.43576        85435.76 Signal Traps/second
     6 exec_test           60.03        753   12.54373           62.72 Program Loads/second
     7 fork_test           60.02        802   13.36221         1336.22 Task Creations/second
     8 link_test           60.01       5307   88.43526         5571.42 Link/Unlink Pairs/second

Difference in performance operations report generated by diff-aim9.sh
                   Clean   mbuddy-v16
                ---------- ----------
 1 creat-clo      16039.31   15967.37     -71.94 -0.45% File Creations and Closes/second
 2 page_test     118810.20  115193.27   -3616.93 -3.04% System Allocations & Pages/second
 3 brk_test      445460.60  447025.50    1564.90  0.35% System Memory Allocations/second
 4 jmp_test     4185035.83 4190934.84    5899.01  0.14% Non-local gotos/second
 5 signal_test    85271.58   85435.76     164.18  0.19% Signal Traps/second
 6 exec_test         63.14      62.72      -0.42 -0.67% Program Loads/second
 7 fork_test       1365.98    1336.22     -29.76 -2.18% Task Creations/second
 8 link_test       5590.44    5571.42     -19.02 -0.34% Link/Unlink Pairs/second

In this test, there were regressions in the page_test. However, it is known
that different kernel configurations, compilers and even different runs show
similar varianes of +/- 3% . I do not consider it significant.

The second benchmark tested the CPU cache usage to make sure it was not
getting clobbered. The test was to repeatedly render a large postscript file
10 times and get the average. The result is;

2.6.13-clean:      Average: 42.725 real, 42.626 user, 0.041 sys
2.6.13-mbuddy-v14: Average: 42.793 real, 42.695 user, 0.034 sys

So there are no adverse cache effects. The last test is to show that the
allocator can satisfy more high-order allocations, especially under load,
than the standard allocator. The test performs the following;

1. Start updatedb running in the background
2. Load kernel modules that tries to allocate high-order blocks on demand
3. Clean a kernel tree
4. Make 4 copies of the tree. As each copy finishes, a compile starts at -j4
5. Start compiling the primary tree
6. Sleep 3 minutes while the 5 trees are being compiled
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second
    - Performance will get badly shot as it forces consider amounts of pageout

The result of the allocations under load (load averaging 18) were;

2.6.14-rc3 Clean
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        46
Failed allocs:         114
DMA zone allocs:       1
Normal zone allocs:    32
HighMem zone allocs:   13
% Success:            28

2.6.14-rc3 MBuddy V14
Order:                 10
Allocation type:       HighMem
Attempted allocations: 160
Success allocs:        97
Failed allocs:         63
DMA zone allocs:       1
Normal zone allocs:    89
HighMem zone allocs:   7
% Success:            60


One thing that had to be changed in the 2.6.14-rc3-clean test was to disable
the OOM killer. During one test, the OOM killer had better results but invoked
the OOM killer 457 times to achieve it. The patch with the placement policy
never invoked the OOM killer.

When the system is at rest after the test and the kernel trees deleted, the
standard allocator was able to allocate 54 order-10 pages and the modified
allocator allocated 159.

The results show that the modified allocator has comparable speed has
no adverse cache effects but is far less fragmented and able to satisfy
high-order allocations.
-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
