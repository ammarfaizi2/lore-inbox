Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbULAXm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbULAXm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULAXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:42:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38869 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261497AbULAXlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:41:14 -0500
Date: Wed, 1 Dec 2004 15:41:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12 [0/7]: Overview and performance
 tests
In-Reply-To: <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V11->V12 of this patch:
- dump sloppy_rss in favor of list_rss (Linus' proposal)
- keep up against current Linus tree (patch is based on 2.6.10-rc2-bk14)

This is a series of patches that increases the scalability of
the page fault handler for SMP. Here are some performance results
on a machine with 512 processors allocating 32 GB with an increasing
number of threads (that are assigned a processor each).

Without the patches:
Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32   3    1    1.416s    138.165s 139.050s 45073.831  45097.498
 32   3    2    1.397s    148.523s  78.044s 41965.149  80201.646
 32   3    4    1.390s    152.618s  44.044s 40851.258 141545.239
 32   3    8    1.500s    374.008s  53.001s 16754.519 118671.950
 32   3   16    1.415s   1051.759s  73.094s  5973.803  85087.358
 32   3   32    1.867s   3400.417s 117.003s  1849.186  53754.928
 32   3   64    5.361s  11633.040s 197.034s   540.577  31881.112
 32   3  128   23.387s  39386.390s 332.055s   159.642  18918.599
 32   3  256   15.409s  20031.450s 168.095s   313.837  37237.918
 32   3  512   18.720s  10338.511s  86.047s   607.446  72752.686

With the patches:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32   3    1    1.451s    140.151s 141.060s 44430.367  44428.115
 32   3    2    1.399s    136.349s  73.041s 45673.303  85699.793
 32   3    4    1.321s    129.760s  39.027s 47996.303 160197.217
 32   3    8    1.279s    100.648s  20.039s 61724.641 308454.557
 32   3   16    1.414s    153.975s  15.090s 40488.236 395681.716
 32   3   32    2.534s    337.021s  17.016s 18528.487 366445.400
 32   3   64    4.271s    709.872s  18.057s  8809.787 338656.440
 32   3  128   18.734s   1805.094s  21.084s  3449.586 288005.644
 32   3  256   14.698s    963.787s  11.078s  6429.787 534077.540
 32   3  512   15.299s    453.990s   5.098s 13406.321 1050416.414

For more than 8 cpus the page fault rate increases by orders
of magnitude. For more than 64 cpus the improvement in performace
is 10 times better.

The performance increase is accomplished by avoiding the use of the
page_table_lock spinlock (but not mm->mmap_sem!) through new atomic
operations on pte's (ptep_xchg, ptep_cmpxchg) and on pmd and pgd's
(pgd_test_and_populate, pmd_test_and_populate).

The page table lock can be avoided in the following situations:

1. An empty pte or pmd entry is populated

This is safe since the swapper may only depopulate them and the
swapper code has been changed to never set a pte to be empty until the
page has been evicted. The population of an empty pte is frequent
if a process touches newly allocated memory.

2. Modifications of flags in a pte entry (write/accessed).

These modifications are done by the CPU or by low level handlers
on various platforms also bypassing the page_table_lock. So this
seems to be safe too.

One essential change in the VM is the use of pte_cmpxchg (or its
generic emulation) on page table entries before doing an
update_mmu_change without holding the page table lock. However, we do
similar things now with other atomic pte operations such as
ptep_get_and_clear and ptep_test_and_clear_dirty. These operations
clear a pte *after* doing an operation on it. The ptep_cmpxchg as used
in this patch operates on an *cleared* pte and replaces it with a pte
pointing to valid memory. The effect of this change on various
architectures has to be thought through. Local definitions of
ptep_cmpxchg and ptep_xchg may be necessary.

For IA64 an icache coherency issue may arise that potentially requires
the flushing of the icache (as done via update_mmu_cache on IA64) prior
to the use of ptep_cmpxchg. Similar issues may arise on other platforms.

The patch introduces a split counter for rss handling to avoid atomic
operations and locks currently necessary for rss modifications. In
addition to mm->rss, tsk->rss is introduced. tsk->rss is defined to be
in the same cache line as tsk->mm (which is already used by the fault
handler) and thus tsk->rss can be incremented without locks
in a fast way. The cache line does not need to be shared between
processors in the page table handler.

A tasklist is generated for each mm (rcu based). Values in that list
are added up to calculate rss or anon_rss values.

The patchset is composed of 7 patches:

1/7: Avoid page_table_lock in handle_mm_fault

   This patch defers the acquisition of the page_table_lock as much as
   possible and uses atomic operations for allocating anonymous memory.
   These atomic operations are simulated by acquiring the page_table_lock
   for very small time frames if an architecture does not define
   __HAVE_ARCH_ATOMIC_TABLE_OPS. It also changes the swapper so that a
   pte will not be set to empty if a page is in transition to swap.

   If only the first two patches are applied then the time that the
   page_table_lock is held is simply reduced. The lock may then be
   acquired multiple times during a page fault.

2/7: Atomic pte operations for ia64

3/7: Make cmpxchg generally available on i386

   The atomic operations on the page table rely heavily on cmpxchg
   instructions. This patch adds emulations for cmpxchg and cmpxchg8b
   for old 80386 and 80486 cpus. The emulations are only included if a
   kernel is build for these old cpus and are skipped for the real
   cmpxchg instructions if the kernel that is build for 386 or 486 is
   then run on a more recent cpu.

   This patch may be used independently of the other patches.

4/7: Atomic pte operations for i386

   A generally available cmpxchg (last patch) must be available for
   this patch to preserve the ability to build kernels for 386 and 486.

5/7: Atomic pte operation for x86_64

6/7: Atomic pte operations for s390

7/7: Split counter implementation for rss
  Add tsk->rss and tsk->anon_rss. Add tasklist. Add logic
  to calculate rss from tasklist.

There are some additional outstanding performance enhancements that are
not available yet but which require this patch. Those modifications
push the maximum page fault rate from ~ 1 mio faults per second as
shown above to above 3 mio faults per second.

The last editions of the sloppy rss, atomic rss and deferred rss patch
will be posted to linux-ia64 for archival purpose.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

