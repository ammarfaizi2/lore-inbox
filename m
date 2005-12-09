Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVLIDVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVLIDVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 22:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLIDVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 22:21:11 -0500
Received: from ozlabs.org ([203.10.76.45]:42625 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751259AbVLIDVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 22:21:09 -0500
Date: Fri, 9 Dec 2005 14:20:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: Add missing icache flushes for hugepages
Message-ID: <20051209032051.GA11744@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Paulus, please apply and forward upstream.  This is a real bug
(though a rarely triggered one) and should be fixed before 2.6.15.

On most powerpc CPUs, the dcache and icache are not coherent so
between writing and executing a page, the caches must be flushed.
Userspace programs assume pages given to them by the kernel are icache
clean, so we must do this flush between the kernel clearing a page and
it being mapped into userspace for execute.  We were not doing this
for hugepages, this patch corrects the situation.

We use the same lazy mechanism as we use for normal pages, delaying
the flush until userspace actually attempts to execute from the page
in question.

Tested on G5 

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2005-12-09 14:02:52.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2005-12-09 14:03:09.000000000 +1100
@@ -601,7 +601,7 @@ int hash_page(unsigned long ea, unsigned
 	/* Handle hugepage regions */
 	if (unlikely(in_hugepage_area(mm->context, ea))) {
 		DBG_LOW(" -> huge page !\n");
-		return hash_huge_page(mm, access, ea, vsid, local);
+		return hash_huge_page(mm, access, ea, vsid, local, trap);
 	}
 
 	/* Get PTE and page size from page tables */
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-12-09 14:03:09.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-12-09 14:03:09.000000000 +1100
@@ -685,8 +685,36 @@ unsigned long hugetlb_get_unmapped_area(
 	return -ENOMEM;
 }
 
+/*
+ * Called by asm hashtable.S for doing lazy icache flush
+ */
+static unsigned int hash_huge_page_do_lazy_icache(unsigned long rflags,
+						  pte_t pte, int trap)
+{
+	struct page *page;
+	int i;
+
+	if (!pfn_valid(pte_pfn(pte)))
+		return rflags;
+
+	page = pte_page(pte);
+
+	/* page is dirty */
+	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
+		if (trap == 0x400) {
+			for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++)
+				__flush_dcache_icache(page_address(page+i));
+			set_bit(PG_arch_1, &page->flags);
+		} else {
+			rflags |= HPTE_R_N;
+		}
+	}
+	return rflags;
+}
+
 int hash_huge_page(struct mm_struct *mm, unsigned long access,
-		   unsigned long ea, unsigned long vsid, int local)
+		   unsigned long ea, unsigned long vsid, int local,
+		   unsigned long trap)
 {
 	pte_t *ptep;
 	unsigned long old_pte, new_pte;
@@ -737,6 +765,11 @@ int hash_huge_page(struct mm_struct *mm,
 	rflags = 0x2 | (!(new_pte & _PAGE_RW));
  	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
 	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
+	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
+		/* No CPU has hugepages but lacks no execute, so we
+		 * don't need to worry about that case */
+		rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
+						       trap);
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(old_pte & _PAGE_HASHPTE)) {
Index: working-2.6/include/asm-powerpc/mmu.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu.h	2005-12-09 14:02:53.000000000 +1100
+++ working-2.6/include/asm-powerpc/mmu.h	2005-12-09 14:03:09.000000000 +1100
@@ -221,7 +221,8 @@ extern int __hash_page_64K(unsigned long
 			   unsigned int local);
 struct mm_struct;
 extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
-			  unsigned long ea, unsigned long vsid, int local);
+			  unsigned long ea, unsigned long vsid, int local,
+			  unsigned long trap);
 
 extern void htab_finish_init(void);
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
