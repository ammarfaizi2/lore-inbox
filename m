Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTKLUB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 15:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTKLUB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 15:01:58 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:59836 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264286AbTKLUBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 15:01:52 -0500
Date: Wed, 12 Nov 2003 14:01:19 -0600
From: Jack Steiner <steiner@sgi.com>
To: davidm@hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Inefficient TLB flushing 
Message-ID: <20031112200119.GA22429@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Something appears broken in TLB flushing on IA64 (& possibly other
architectures). Functionally, it works but performance is bad on 
systems with large cpu counts. 

The result is that TLB flushing in exit_mmap() is frequently being done via
IPIs to all cpus rather than with a "ptc" instruction or with a new context..



Take a look at exit_mmap()  (in mm/mmap.c):

	void exit_mmap(struct mm_struct *mm)
	{
  (1)		tlb = tlb_gather_mmu(mm, 1);
  		unmap_vmas(&tlb,...
		...
  (2)		tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
		...
	}


	static inline void
	tlb_finish_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
	{
		...
		ia64_tlb_flush_mmu(tlb, start, end);
		...
	}


	static inline void
	ia64_tlb_flush_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
	{
		...
   (3)		if (tlb->fullmm) {
			flush_tlb_mm(tlb->mm);
   (4)		} else if (unlikely (end - start >= 1TB ...
			/* This should be very rare and is not worth optimizing for.
   (5)			flush_tlb_all();
		...

	flush_tlb_all() flushes with IPI to every cpu


<start> & <end> are passed from exit_mmap at line (2) as 0..MM_VM_SIZE which is
0..0xa000000000000000 (on IA64) & the expression at (4) is always TRUE. If tlb->fullmm is 
false, the code in ia64_tlb_flush_mmu calls flush_tlb_all. flush_tlb_all uses IPIs to 
do the TLB flushing.


Normally, tlb->fullmm at line (3) is 1 since it is initialized to 1 at line (1). However, in 
unmap_vmas(), if a resched interrupt occurs during VMA teardown, the tlb flushing
is reinitialized & tlb_gather_mmu() is called with tlb_gather_mmu(mm, 0). When the
call to tlb_finish_mmu() is made at line (2), TLB flushing is done with an IPI


Does this analysis look correct??  AFAICT, this bug (inefficiency) may apply to other
architectures although I cant access it's peformance impact.


Here is the patch that I am currently testing:


--- /usr/tmp/TmpDir.19957-0/linux/mm/memory.c_1.79	Wed Nov 12 13:56:25 2003
+++ linux/mm/memory.c	Wed Nov 12 12:57:25 2003
@@ -574,9 +574,10 @@
 			if ((long)zap_bytes > 0)
 				continue;
 			if (need_resched()) {
+				int fullmm = (*tlbp)->fullmm;
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
-				*tlbp = tlb_gather_mmu(mm, 0);
+				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
 			zap_bytes = ZAP_BLOCK_SIZE;
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


