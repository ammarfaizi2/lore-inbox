Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbULQDet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbULQDet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbULQDes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:34:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34767 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262733AbULQDcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:32:45 -0500
Date: Thu, 16 Dec 2004 19:32:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V13 [0/8]: Overview
In-Reply-To: <20041212212456.GB2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0412161931460.11341@schroedinger.engr.sgi.com>
References: <41BBF923.6040207@yahoo.com.au>
 <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
 <20041212212456.GB2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V12->V13 of this patch:
- list_rss: Fix issues Hugh dickins pointed out.
- i386: Hugh Dickins patch. Fall back to not use get_64 if ptl is used to
  restore performance on PAE..
- introduce get_pte_atomic for non ptl access to pte.
- i386 PAE: get_pte_atomic uses get_64bit
- ptep cmpxchg must now include update_mmu_cache functionality. All
  arches updated.
- add optional prefault patch [8/8] which is controllable via
  /proc/sys/vm/max_pre_alloc
- This patch series tested by me on i386 PAE and ia64

Potential issues:
- I avoided to check mm == current->mm for incrementing current->rss in
  the anonymous fault handler. Instead I added some code
  around handle_mm_fault in memory.c to deal with the situation
  if mm != current->mm.

Potential unintended benefits from mm containing a tasklist:
- Threads are now freed via rcu thus the tasklist may be traversed
  without acquiring the tasklist lock if the other list operations
  for task_struct are also switched to be of rcu type.
- The list of threads of a mm is determined in two locations by a
  walk of all the tasks. The code could be change to use the
  tasklist in mm.

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

The patchset is composed of 8 patches (and was tested against 2.6.10-rc3-bk10):

1/8: Avoid page_table_lock in handle_mm_fault

   This patch defers the acquisition of the page_table_lock as much as
   possible and uses atomic operations for allocating anonymous memory.
   These atomic operations are simulated by acquiring the page_table_lock
   for very small time frames if an architecture does not define
   __HAVE_ARCH_ATOMIC_TABLE_OPS. It also changes the swapper so that a
   pte will not be set to empty if a page is in transition to swap.

   If only the first two patches are applied then the time that the
   page_table_lock is held is simply reduced. The lock may then be
   acquired multiple times during a page fault.

2/8: Atomic pte operations for ia64

3/8: Make cmpxchg generally available on i386

   The atomic operations on the page table rely heavily on cmpxchg
   instructions. This patch adds emulations for cmpxchg and cmpxchg8b
   for old 80386 and 80486 cpus. The emulations are only included if a
   kernel is build for these old cpus and are skipped for the real
   cmpxchg instructions if the kernel that is build for 386 or 486 is
   then run on a more recent cpu.

   This patch may be used independently of the other patches.

4/8: Atomic pte operations for i386

   A generally available cmpxchg (last patch) must be available for
   this patch to preserve the ability to build kernels for 386 and 486.

5/8: Atomic pte operation for x86_64

6/8: Atomic pte operations for s390

7/8: Split counter implementation for rss
  Add tsk->rss and tsk->anon_rss. Add tasklist. Add logic
  to calculate rss from tasklist.

8/8: Prefaulting for the page table scalability patchset.

  Note that this patch is significantly different from the patches
  posted under the title "Anticipatory prefaulting" because the handling
  of the pte's differs significantly. This prefault patch can reach
  higher orders during prefaulting since no pagevec is needed to store the
  preallocated pages.

  The maximum order of preallocation can be controlled via
  /proc/sys/vm/max_prealloc_order and is set to 3 by default. Setting
  max_prealloc_order to zero switches off preallocation altogether.

Signed-off-by: Christoph Lameter <clameter@sgi.com>


