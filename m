Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269673AbUIRXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269673AbUIRXYk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbUIRXYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:24:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5048 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269667AbUIRXYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:24:30 -0400
Date: Sat, 18 Sep 2004 16:23:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: page fault scalability patch V8: [0/7] Description
In-Reply-To: <20040902140759.5f1003d5.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0409181616150.24054@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
 <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
 <20040901215741.3538bbf4.davem@davemloft.net>
 <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
 <20040902131057.0341e337.davem@davemloft.net>
 <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
 <20040902140759.5f1003d5.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Lameter <clameter@sgi.com>

This is a series of patches that increases the scalability of
the page fault handler for SMP. Typical performance increases in the page
fault rate are:

2 CPUs -> 10%
4 CPUs -> 50%
8 CPUs -> 70%

With a high number of CPUs (16..512) we are seeing the page fault rate
roughly doubling.

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

The set of patches is composed of 7 patches:

1/7: Make mm->rss atomic

   The page table lock is used to protect mm->rss and the first patch
   makes rss atomic so that it may be changed without holding the
   page_table_lock.
   Generic atomic variables are only 32 bit under Linux. However, 32 bits
   is sufficient for rss even on a 64 bit machine since rss refers to the
   number of pages allowing still up to 2^(31+12)= 8 terabytes of memory
   to be in use by a single process. A 64 bit atomic would of course be better.

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

   This patch adds atomic pte operations to the IA64 platform. The page_table_lock
   will then no longer be acquired for page faults that create pte's for anonymous
   memory.

4/7: Make cmpxchg generally available on i386

   The atomic operations on the page table rely heavily on cmpxchg instructions.
   This patch adds emulations for cmpxchg and cmpxchg8b for old 80386 and 80486
   cpus. The emulations are only included if a kernel is build for these old
   cpus. The emulations are skipped for the real cmpxchg instructions if the kernel
   that is build for 386 or 486 is then run on a more recent cpu.

   This patch may be used independently of the other patches.

5/7: Atomic pte operations for i386

   Add atomic PTE operations for i386. A generally available cmpxchg (last patch)
   must be available for this patch.

6/7: Atomic pte operation for x86_64

   Add atomic pte operations for x86_64. This has not been tested yet since I have
   no x86_64.

7/7: Atomic pte operations for s390

   Add atomic PTE operations for S390. This has also not been tested yet since I have
   no S/390 available. Feedback from the S/390 people seems to indicate though that
   the way it is done is fine.

