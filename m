Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSG2FAA>; Mon, 29 Jul 2002 01:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSG2FAA>; Mon, 29 Jul 2002 01:00:00 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55688 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318022AbSG2E77>;
	Mon, 29 Jul 2002 00:59:59 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.52231.710183.242098@argo.ozlabs.ibm.com>
Date: Mon, 29 Jul 2002 15:00:55 +1000 (EST)
To: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: page table page->index
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a situation where page->index for a pagetable page can be set
to 0 instead of the correct value.  This means that ptep_to_address
will return the wrong answer.  The problem occurs when remap_pmd_range
calls pte_alloc_map and pte_alloc_map needs to allocate a new pte
page, because remap_pmd_range has masked off the top bits of the
address (to avoid overflow in the computation of `end'), and it passes
the masked address to pte_alloc_map.

Now we presumably don't need to get from the physical pages mapped by
remap_page_range back to the ptes mapping them.  But we could easily
map some normal pages using ptes in that pagetable page subsequently,
and when we call ptep_to_address on their ptes it will give the wrong
answer.

The patch below fixes the problem.

There is a more general question this brings up - some of the
procedures which iterate over ranges of ptes will do the wrong thing
if the end of the address range is too close to ~0UL, while others are
OK.  Is this a problem in practice?  On i386, ppc, and the 64-bit
architectures it isn't since user addresses can't go anywhere near
~0UL, but what about arm or m68k for instance?

And BTW, being able to go from a pte pointer to the mm and virtual
address that that pte maps is an extremely useful thing on ppc, since
it will enable me to do MMU hash-table management at set_pte (and
ptep_*) time and thus avoid the extra traversal of the pagetables that
I am currently doing in flush_tlb_*.  So if you do decide to back out
rmap, please leave in the hooks for setting page->mapping and
page->index on pagetable pages.

Paul.

diff -urN linux-2.5/mm/memory.c pmac-2.5/mm/memory.c
--- linux-2.5/mm/memory.c	Thu Jul 18 05:27:58 2002
+++ pmac-2.5/mm/memory.c	Sat Jul 27 15:42:18 2002
@@ -863,18 +863,19 @@
 static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
 	unsigned long phys_addr, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	phys_addr -= address;
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
+		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, address, end - address, address + phys_addr, prot);
+		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;

