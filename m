Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVG1SoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVG1SoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVG1Sm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:42:57 -0400
Received: from [151.97.230.9] ([151.97.230.9]:21480 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261449AbVG1SmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:42:01 -0400
Subject: [patch 2/3] uml: fix tlb flushing for dirty bit
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 20:56:59 +0200
Message-Id: <20050728185659.AF970843@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since UML has no hardware support for "dirty" and "accessed" bits, what we do
is to get host faults on write (for dirtying) and even on read (for accessed
bit).

However, we didn't mark the pte as needing host flush in the "TLBs" (which is
done by marking the PTE with _PAGE_NEWPROT), so we didn't actually remap the
page as read-only or not-readable.

The bug affects both pte_mkold() and pte_mkclean(), but in this patch, I'm
fixing only pte_mkclean(), since this could fix userspace-seeable bugs.

This should affect a lot operation correctness, especially for the "dirty" bit
handling. However, since no big failures were seen, this should be
investigated a bit more.

In particular:
* pte_mkclean() must be changed only after getting a program using shared,
writable mapping to fail; it will have to dirty a page, flush it with
msync(2) and then make it dirty again and exit.

* pte_mkold() must be changed only after benchmarking.

I'm still sending this patch, but I'm still resistant on the merge, especially
for the pte_mkold() change. In fact, it has been separate to another patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/tlb.c     |   14 ++++++++++++--
 linux-2.6.git-paolo/include/asm-um/pgtable.h |   11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/tlb.c~uml-fix-tlb-flushing arch/um/kernel/tlb.c
--- linux-2.6.git/arch/um/kernel/tlb.c~uml-fix-tlb-flushing	2005-07-28 19:45:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tlb.c	2005-07-28 19:45:03.000000000 +0200
@@ -84,9 +84,19 @@ void fix_range_common(struct mm_struct *
                 r = pte_read(*npte);
                 w = pte_write(*npte);
                 x = pte_exec(*npte);
-                if(!pte_dirty(*npte))
+
+		/* To emulate dirty and accessed page bits, we want to get write
+		 * or even read faults. However, we do that only if the page is
+		 * marked with NEW_PROT, which is done by pte_{mkold,mkclean}.
+		 *
+		 * NOTE: we don't want to do pte_{rd,wr}protect in that case,
+		 * because that could confuse the VMM, in particular that would
+		 * confuse for sure remap_file_pages_prot(), where you can't
+		 * restore the protection bits from the VMA. */
+
+                if (!pte_dirty(*npte))
                         w = 0;
-                if(!pte_young(*npte)){
+                if (!pte_young(*npte)) {
                         r = 0;
                         w = 0;
                 }
diff -puN include/asm-um/pgtable.h~uml-fix-tlb-flushing include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~uml-fix-tlb-flushing	2005-07-28 19:45:03.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-07-28 20:49:48.000000000 +0200
@@ -15,8 +15,16 @@
 #include "asm/fixmap.h"
 
 #define _PAGE_PRESENT	0x001
+
+/* Since in UML the TLB's must be sync'ed by hand, and that is expensive,
+ * whenever we modify a PTE we mark it with _PAGE_NEWPAGE (if it needs to be
+ * mapped/unmapped) or _PAGE_NEWPROT (if we just need mprotect). For PGD's,
+ * PMD's, PUD's, we can only set _PAGE_NEWPAGE when calling p?d_clear.
+ * The TLB flushing is done in fix_range_common / flush_tlb_kernel_range_common. */
+
 #define _PAGE_NEWPAGE	0x002
 #define _PAGE_NEWPROT   0x004
+
 #define _PAGE_FILE	0x008   /* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x010	/* If not present */
 #define _PAGE_RW	0x020
@@ -251,6 +259,9 @@ static inline pte_t pte_exprotect(pte_t 
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_clear_bits(pte, _PAGE_DIRTY);
+	/* We want that next flush makes this page again not-writable, so we'll
+	 * mark it as dirty again */
+	pte_set_bits(pte, _PAGE_NEWPROT);
 	return(pte);
 }
 
_
