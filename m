Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVADVdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVADVdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVADVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:30:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:35531 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262119AbVADV0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:26:49 -0500
Date: Tue, 4 Jan 2005 13:26:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V14 [5/7]: x86_64 atomic pte
 operations
In-Reply-To: <41DB08BF.4000700@didntduck.org>
Message-ID: <Pine.LNX.4.58.0501041325370.17246@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>
 <41DB08BF.4000700@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Brian Gerst wrote:

> > +#define pud_test_and_populate(mm, pud, pmd) \
> > +		(cmpxchg((int *)pgd, PUD_NONE, _PAGE_TABLE | __pa(pmd)) == PUD_NONE)
>                                  ^^^
> Shouldn't this be pud?

Corrrect. Sigh. Could someone test this on x86_64?

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
+		(cmpxchg(pud, PUD_NONE, _PAGE_TABLE | __pa(pmd)) == PUD_NONE)
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
