Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUI0THW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUI0THW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUI0THW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:07:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11690 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267232AbUI0THO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:07:14 -0400
Date: Mon, 27 Sep 2004 12:06:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Andy Lutomirski <luto@myrealbox.com>, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V9: [0/7] overview
In-Reply-To: <20040923090345.GA6146@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0409271204180.31769@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Changes from V8->V9 of this patch:
- Verify that mm->rss is changed to atomic on all arches
- Fixes to the i386 cmpxchg support. Make it as small as possible
  by using a function instead of inlining.
- Patches against 2.6.9-rc2-bk15

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

The patchset is composed of 7 patches:

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

