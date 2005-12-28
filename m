Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVL1W6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVL1W6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVL1W6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:58:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:41321 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932546AbVL1W6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:58:46 -0500
Date: Wed, 28 Dec 2005 22:59:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in exit_mmap->free_pgtables
In-Reply-To: <1135726300.22744.25.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Dec 2005 22:58:46.0040 (UTC) FILETIME=[41D23180:01C60C02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Lee Revell wrote:

> I am seeing excessive latencies (2ms+) in free_pgtables, called from
> exit_mmap with 2.6.15-rc5.  This is a significant regression from 2.6.14
> where the maximum observed latency was less than 1ms with some tuning.
> Here is the trace.
> 
> The problem is that we now do a lot more work in free_pgtables under the
> mm->page_table_lock spinlock so preemption can be delayed for a long
> time.  Here is the change responsible:

Yes, I'm to blame for that - sorry.  It didn't occur to me that I was
moving any signficant amount of work (on mms with many vmas) into the
section with preemption disabled.  Actually, the mm->page_table_lock
is _not_ held there any more; but preemption is still disabled while
using the per-cpu mmu_gathers.

I wish you'd found it at -rc1 time.  It's not something that can
be properly corrected in a hurry.  The proper fix is to rework the
tlb_gather_mmu stuff, so it can be done without preemption disabled.
It's already a serious limitation in unmap_vmas, with CONFIG_PREEMPT's
ZAP_BLOCK_SIZE spoiling throughput with far too many TLB flushes.

On my list to work on; but the TLB always needs great care, and this
goes down into architectural divergences, with truncation of a mapped
file adding further awkward constraints.  I imagine 2.6.16-rc1 is only
a couple of weeks away, so it's unlikely to be fixed in 2.6.16 either.

> What was the purpose of this change?

To narrow the scope of the page_table_lock, so that it could be taken
later and released earlier, for slightly better preemptibility, and
to allow more scalable locking by splitting it up per page-table page.
And a step towards the mmu_gather rework I refer to above, to recover
from 2.6.11's unmap_vmas slowdown.

Here's an untested patch which should mostly correct your latency
problem with 2.6.15-rc.  But it's certainly not the right solution,
and it's probably both too ugly and too late for 2.6.15.  If you
really want Linus to put it in, please test it out, especially on
ia64, and try to persuade him.  Personally I'd prefer to wait for
the right solution: but I don't have your low-latency needs, and
I'm certainly guilty of a regression here.


2.6.15-rc1 moved the unlinking of a vma from its prio_tree and anon_vma
into free_pgtables: so the vma is hidden from rmap and vmtruncate before
freeing its page tables, allowing safe descent without page table lock.
But free_pgtables is still called with preemption disabled, and Lee
Revell has now detected high latency there.

The right fix will be to rework the mmu_gathering, not to need preemption
disabled; but for now an ugly CONFIG_PREEMPT block in free_pgtables, to
make an initial unlinking pass with preemption enabled - made uglier by
CONFIG_IA64 definitions (only ia64 actually uses the start and end given
to tlb_finish_mmu, and our floor and ceiling don't quite work for those).
These CONFIG choices being to minimize the additional TLB flushing.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+)

--- 2.6.15-rc7/mm/memory.c	2005-12-25 11:19:27.000000000 +0000
+++ linux/mm/memory.c	2005-12-28 21:49:35.000000000 +0000
@@ -254,18 +254,48 @@ void free_pgd_range(struct mmu_gather **
 		flush_tlb_pgtables((*tlb)->mm, start, end);
 }
 
+#ifdef CONFIG_IA64
+#define tlb_start_addr(tlb)	(tlb)->start_addr
+#define tlb_end_addr(tlb)	(tlb)->end_addr
+#else
+#define tlb_start_addr(tlb)	0UL	/* only ia64 really uses it */
+#define tlb_end_addr(tlb)	0UL	/* only ia64 really uses it */
+#endif
+
 void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
 		unsigned long floor, unsigned long ceiling)
 {
+#ifdef CONFIG_PREEMPT
+	struct vm_area_struct *unlink = vma;
+	int fullmm = (*tlb)->fullmm;
+
+	if (!vma)	/* Sometimes when exiting after an oops */
+		return;
+	if (vma->vm_next)
+		tlb_finish_mmu(*tlb, tlb_start_addr(*tlb), tlb_end_addr(*tlb));
+	/*
+	 * Hide vma from rmap and vmtruncate before freeeing pgtables,
+	 * with preemption enabled, except when unmapping just one area.
+	 */
+	while (unlink) {
+		anon_vma_unlink(unlink);
+		unlink_file_vma(unlink);
+		unlink = unlink->vm_next;
+	}
+	if (vma->vm_next)
+		*tlb = tlb_gather_mmu(vma->vm_mm, fullmm);
+#endif
 	while (vma) {
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long addr = vma->vm_start;
 
+#ifndef CONFIG_PREEMPT
 		/*
 		 * Hide vma from rmap and vmtruncate before freeing pgtables
 		 */
 		anon_vma_unlink(vma);
 		unlink_file_vma(vma);
+#endif
 
 		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
@@ -279,8 +309,10 @@ void free_pgtables(struct mmu_gather **t
 							HPAGE_SIZE)) {
 				vma = next;
 				next = vma->vm_next;
+#ifndef CONFIG_PREEMPT
 				anon_vma_unlink(vma);
 				unlink_file_vma(vma);
+#endif
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
