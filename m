Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVADToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVADToN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVADTjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:39:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18682 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261857AbVADThA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:37:00 -0500
Date: Tue, 4 Jan 2005 11:35:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V14 [0/7]: Overview
In-Reply-To: <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V13->V14 of this patch:
- 4level page support
- Tested on ia64, i386 and i386 in PAE mode

This is a series of patches that increases the scalability of
the page fault handler for SMP. The performance increase is
accomplished by avoiding the use of the
page_table_lock spinlock (but not mm->mmap_sem) through new atomic
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
processors for the page table handler.

A tasklist is generated for each mm (rcu based). Values in that list
are added up to calculate rss or anon_rss values.

The patchset is composed of 7 patches (and was tested against 2.6.10-bk6):

1/7: Avoid page_table_lock in handle_mm_fault

   This patch defers the acquisition of the page_table_lock as much as
   possible and uses atomic operations for allocating anonymous memory.
   These atomic operations are simulated by acquiring the page_table_lock
   for very small time frames if an architecture does not define
   __HAVE_ARCH_ATOMIC_TABLE_OPS. It also changes kswapd so that a
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

Signed-off-by: Christoph Lameter <clameter@sgi.com>

