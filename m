Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVADUjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVADUjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVADUgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:36:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30884 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262150AbVADUcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:32:21 -0500
Date: Tue, 4 Jan 2005 12:32:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V14 [5/7]: x86_64 atomic pte
 operations
In-Reply-To: <20050104202104.GA28454@muc.de>
Message-ID: <Pine.LNX.4.58.0501041231320.1083@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de>
 <Pine.LNX.4.58.0501041154560.1083@schroedinger.engr.sgi.com>
 <20050104202104.GA28454@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Andi Kleen wrote:

> > The macro checks for the size of the pointer and then generates the
> > appropriate cmpxchg instruction. pgd_t is a struct which may be
> > problematic for the cmpxchg macros.
>
> It just checks sizeof, that should be fine.

Index: linux-2.6.10/include/asm-x86_64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/pgalloc.h	2005-01-03 15:02:01.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/pgalloc.h	2005-01-04 12:31:14.000000000 -0800
@@ -7,6 +7,10 @@
 #include <linux/threads.h>
 #include <linux/mm.h>

+#define PMD_NONE 0
+#define PUD_NONE 0
+#define PGD_NONE 0
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
 #define pud_populate(mm, pud, pmd) \
@@ -14,11 +18,24 @@
 #define pgd_populate(mm, pgd, pud) \
 		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pud)))

+#define pmd_test_and_populate(mm, pmd, pte) \
+		(cmpxchg(pmd, PMD_NONE, _PAGE_TABLE | __pa(pte)) == PMD_NONE)
+#define pud_test_and_populate(mm, pud, pmd) \
+		(cmpxchg(pgd, PUD_NONE, _PAGE_TABLE | __pa(pmd)) == PUD_NONE)
+#define pgd_test_and_populate(mm, pgd, pud) \
+		(cmpxchg(pgd, PGD_NONE, _PAGE_TABLE | __pa(pud)) == PGD_NONE)
+
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
 }

+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+	return cmpxchg(pmd, PMD_NONE, _PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)) == PMD_NONE;
+}
+
 extern __inline__ pmd_t *get_pmd(void)
 {
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL);
Index: linux-2.6.10/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-x86_64/pgtable.h	2005-01-03 15:02:01.000000000 -0800
+++ linux-2.6.10/include/asm-x86_64/pgtable.h	2005-01-04 12:29:25.000000000 -0800
@@ -413,6 +413,10 @@
 #define	kc_offset_to_vaddr(o) \
    (((o) & (1UL << (__VIRTUAL_MASK_SHIFT-1))) ? ((o) | (~__VIRTUAL_MASK)) : (o))

+
+#define ptep_cmpxchg(__vma,__addr,__xp,__oldval,__newval) (cmpxchg(&(__xp)->pte, pte_val(__oldval), pte_val(__newval)) == pte_val(__oldval))
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
