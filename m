Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVJMBR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVJMBR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVJMBRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:17:25 -0400
Received: from silver.veritas.com ([143.127.12.111]:38551 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964845AbVJMBRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:17:24 -0400
Date: Thu, 13 Oct 2005 02:16:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>,
       Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] mm: flush_tlb_range outside ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130214570.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:17:24.0602 (UTC) FILETIME=[DE4345A0:01C5CF93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was one small but very significant change in the previous patch:
mprotect's flush_tlb_range fell outside the page_table_lock: as it is
in 2.4, but that doesn't prove it safe in 2.6.

On some architectures flush_tlb_range comes to the same as flush_tlb_mm,
which has always been called from outside page_table_lock in dup_mmap,
and is so proved safe.  Others required a deeper audit: I could find no
reliance on page_table_lock in any; but in ia64 and parisc found some
code which looks a bit as if it might want preemption disabled.  That
won't do any actual harm, so pending a decision from the maintainers,
disable preemption there.

Remove comments on page_table_lock from flush_tlb_mm, flush_tlb_range
and flush_tlb_page entries in cachetlb.txt: they were rather misleading
(what generic code does is different from what usually happens), the
rules are now changing, and it's not yet clear where we'll end up (will
the generic tlb_flush_mmu happen always under lock? never under lock?
or sometimes under and sometimes not?).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/cachetlb.txt    |    9 ---------
 arch/ia64/mm/tlb.c            |    2 ++
 include/asm-parisc/tlbflush.h |    3 ++-
 3 files changed, 4 insertions(+), 10 deletions(-)

--- mm14/Documentation/cachetlb.txt	2005-06-17 20:48:29.000000000 +0100
+++ mm15/Documentation/cachetlb.txt	2005-10-11 23:57:25.000000000 +0100
@@ -49,9 +49,6 @@ changes occur:
 	page table operations such as what happens during
 	fork, and exec.
 
-	Platform developers note that generic code will always
-	invoke this interface without mm->page_table_lock held.
-
 3) void flush_tlb_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 
@@ -72,9 +69,6 @@ changes occur:
 	call flush_tlb_page (see below) for each entry which may be
 	modified.
 
-	Platform developers note that generic code will always
-	invoke this interface with mm->page_table_lock held.
-
 4) void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 
 	This time we need to remove the PAGE_SIZE sized translation
@@ -93,9 +87,6 @@ changes occur:
 
 	This is used primarily during fault processing.
 
-	Platform developers note that generic code will always
-	invoke this interface with mm->page_table_lock held.
-
 5) void flush_tlb_pgtables(struct mm_struct *mm,
 			   unsigned long start, unsigned long end)
 
--- mm14/arch/ia64/mm/tlb.c	2005-06-17 20:48:29.000000000 +0100
+++ mm15/arch/ia64/mm/tlb.c	2005-10-11 23:57:25.000000000 +0100
@@ -155,10 +155,12 @@ flush_tlb_range (struct vm_area_struct *
 # ifdef CONFIG_SMP
 	platform_global_tlb_purge(start, end, nbits);
 # else
+	preempt_disable();
 	do {
 		ia64_ptcl(start, (nbits<<2));
 		start += (1UL << nbits);
 	} while (start < end);
+	preempt_enable();
 # endif
 
 	ia64_srlz_i();			/* srlz.i implies srlz.d */
--- mm14/include/asm-parisc/tlbflush.h	2004-12-24 21:37:30.000000000 +0000
+++ mm15/include/asm-parisc/tlbflush.h	2005-10-11 23:57:25.000000000 +0100
@@ -69,7 +69,7 @@ static inline void flush_tlb_range(struc
 	if (npages >= 512)  /* XXX arbitrary, should be tuned */
 		flush_tlb_all();
 	else {
-
+		preempt_disable();
 		mtsp(vma->vm_mm->context,1);
 		if (split_tlb) {
 			purge_tlb_start();
@@ -87,6 +87,7 @@ static inline void flush_tlb_range(struc
 			}
 			purge_tlb_end();
 		}
+		preempt_enable();
 	}
 }
 
