Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbULQDtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbULQDtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbULQDqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:46:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26832 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262737AbULQDgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:36:35 -0500
Date: Thu, 16 Dec 2004 19:36:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V13 [5/8]: atomic pte operations for
 AMD64
In-Reply-To: <Pine.LNX.4.58.0412161931460.11341@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412161935200.11341@schroedinger.engr.sgi.com>
References: <41BBF923.6040207@yahoo.com.au>
 <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
 <20041212212456.GB2714@holomorphy.com> <Pine.LNX.4.58.0412161931460.11341@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Provide atomic pte operations for x86_64

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/asm-x86_64/pgalloc.h
===================================================================
--- linux-2.6.9.orig/include/asm-x86_64/pgalloc.h	2004-10-18 14:54:30.000000000 -0700
+++ linux-2.6.9/include/asm-x86_64/pgalloc.h	2004-11-23 10:59:01.000000000 -0800
@@ -7,16 +7,26 @@
 #include <linux/threads.h>
 #include <linux/mm.h>

+#define PMD_NONE 0
+#define PGD_NONE 0
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
 #define pgd_populate(mm, pgd, pmd) \
 		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pmd)))
+#define pgd_test_and_populate(mm, pgd, pmd) \
+		(cmpxchg((int *)pgd, PGD_NONE, _PAGE_TABLE | __pa(pmd)) == PGD_NONE)

 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
 }

+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+	return cmpxchg((int *)pmd, PMD_NONE, _PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)) == PMD_NONE;
+}
+
 extern __inline__ pmd_t *get_pmd(void)
 {
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL);
Index: linux-2.6.9/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-x86_64/pgtable.h	2004-11-22 15:08:43.000000000 -0800
+++ linux-2.6.9/include/asm-x86_64/pgtable.h	2004-11-23 10:59:01.000000000 -0800
@@ -437,6 +437,10 @@
 #define	kc_offset_to_vaddr(o) \
    (((o) & (1UL << (__VIRTUAL_MASK_SHIFT-1))) ? ((o) | (~__VIRTUAL_MASK)) : (o))

+
+#define ptep_cmpxchg(__vma,__addr,__xp,__oldval,__newval) (cmpxchg(&(__xp)->pte, pte_val(__oldval), pte_val(__newval)) == pte_val(__oldval))
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR

