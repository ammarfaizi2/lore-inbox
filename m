Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKSTnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKSTnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUKSTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:43:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22407 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261557AbUKSTmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:42:51 -0500
Date: Fri, 19 Nov 2004 11:42:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <1100848068.25520.49.camel@gaston>
Message-ID: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Changes from V10->V11 of this patch:
- cmpxchg_i386: Optimize code generated after feedback from Linus. Various
  fixes.
- drop make_rss_atomic in favor of rss_sloppy
- generic: adapt to new changes in Linus tree, some fixes to fallback
  functions. Add generic ptep_xchg_flush based on xchg.
- S390: remove use of page_table_lock from ptep_xchg_flush (deadlock)
- x86_64: remove ptep_xchg
- i386: integrated Nick Piggin's changes for PAE mode. Create ptep_xchg_flush and
  various fixes.
- ia64: if necessary flush icache before ptep_cmpxchg. Remove ptep_xchg

This is a series of patches that increases the scalability of
the page fault handler for SMP. Here are some performance results
on a machine with 32 processors allocating 32 GB with an increasing
number of cpus.

Without the patches:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32  10    1    3.966s    366.840s 370.082s 56556.456  56553.456
 32  10    2    3.604s    319.004s 172.058s 65006.086 121511.453
 32  10    4    3.705s    341.550s 106.007s 60741.936 197704.486
 32  10    8    3.597s    809.711s 119.021s 25785.427 175917.674
 32  10   16    5.886s   2238.122s 163.084s  9345.560 127998.973
 32  10   32   21.748s   5458.983s 201.062s  3826.409 104011.521

With the patches:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32  10    1    3.772s    330.629s 334.042s 62713.587  62708.706
 32  10    2    3.767s    352.252s 185.077s 58905.502 112886.222
 32  10    4    3.549s    255.683s  77.000s 80898.177 272326.496
 32  10    8    3.522s    263.879s  52.030s 78427.083 400965.857
 32  10   16    5.193s    384.813s  42.076s 53772.158 490378.852
 32  10   32   15.806s    996.890s  54.077s 20708.587 382879.208

With a high number of CPUs the page fault rate improves more than
twofold and may reach 500000 faults/sec betweenr 16-512 cpus. The
fault rate drops if a process is running on all processors as also
here for the 32 cpu case.

Note that the measurements were done on a NUMA system and this
test uses off node memory. Variations may exist due to allocations in
memory areas in diverse distances to the local cpu. The slight drop
for 2 cpus is probably due to that effect.

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

One essential change in the VM is the use of pte_cmpxchg (or its generic
emulation) on page table entries before doing an update_mmu_change without holding
the page table lock. However, we do similar things now with other atomic pte operations
such as ptep_get_and_clear and ptep_test_and_clear_dirty. These operations clear
a pte *after* doing an operation on it. The ptep_cmpxchg as used in this patch
operates on an *cleared* pte and replaces it with a pte pointing to valid memory.
The effect of this change on various architectures has to be thought through. Local
definitions of ptep_cmpxchg and ptep_xchg may be necessary.

For IA64 an icache coherency issue may arise that potentially requires the
flushing of the icache (as done via update_mmu_cache on IA64) prior
to the use of ptep_cmpxchg. Similar issues may arise on other platforms.

The patch uses sloppy rss handling. mm->rss is incremented without
proper locking because locking would introduce too much overhead. Rss
is not essential for vm operations (3 uses of rss in rmap.c were not necessary and
were removed). The difference in rss values has been found to be less than 1% in
our tests (see also the separate email to linux-mm and linux-ia64 on the subject
of "sloppy rss"). The move away from using atomic operations for rss in earlier versions
of this patch also increases the performance of the page fault handler in the single
thread case over an unpatched kernel.

Note that I have posted two other approaches of dealing with the rss problem:

A. make_rss_atomic. The earlier releases contained that patch but then another
   variable (such as anon_rss) was introduced that would have required additional
   atomic operations. Atomic rss operations are also causing slowdowns on
   machines with a high number of cpus due to memory contention.

B. remove_rss. Replace rss with a periodic scan over the vm to determine
   rss and additional numbers. This was also discussed on linux-mm and linux-ia64.
   The scans while displaying /proc data were undesirable.

The patchset is composed of 7 patches:

1/7: Sloppy rss

   Removes mm->rss usage from mm/rmap.c and insures that negative rss values
   are not displayed.

2/7: Avoid page_table_lock in handle_mm_fault

   This patch defers the acquisition of the page_table_lock as much as
   possible and uses atomic operations for allocating anonymous memory.
   These atomic operations are simulated by acquiring the page_table_lock
   for very small time frames if an architecture does not define
   __HAVE_ARCH_ATOMIC_TABLE_OPS. It also changes the swapper so that a
   pte will not be set to empty if a page is in transition to swap.

   If only the first two patches are applied then the time that the page_table_lock
   is held is simply reduced. The lock may then be acquired multiple
   times during a page fault.

   The remaining patches introduce the necessary atomic pte operations to avoid
   the page_table_lock.

3/7: Atomic pte operations for ia64

4/7: Make cmpxchg generally available on i386

   The atomic operations on the page table rely heavily on cmpxchg instructions.
   This patch adds emulations for cmpxchg and cmpxchg8b for old 80386 and 80486
   cpus. The emulations are only included if a kernel is build for these old
   cpus and are skipped for the real cmpxchg instructions if the kernel
   that is build for 386 or 486 is then run on a more recent cpu.

   This patch may be used independently of the other patches.

5/7: Atomic pte operations for i386

   A generally available cmpxchg (last patch) must be available for this patch to
   preserve the ability to build kernels for 386 and 486.

6/7: Atomic pte operation for x86_64

7/7: Atomic pte operations for s390

