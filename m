Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269680AbUIRXhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269680AbUIRXhb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbUIRXc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:32:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43683 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269683AbUIRXbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:31:15 -0400
Date: Sat, 18 Sep 2004 16:30:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: page fault scalability patch V8: [6/7] atomic pte operations for
 x86_64
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409181629490.24054@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
 <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
 <20040901215741.3538bbf4.davem@davemloft.net>
 <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
 <20040902131057.0341e337.davem@davemloft.net>
 <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
 <20040902140759.5f1003d5.davem@davemloft.net>
 <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide atomic pte operations for x86_64

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/include/asm-x86_64/pgalloc.h
===================================================================
--- linus.orig/include/asm-x86_64/pgalloc.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-x86_64/pgalloc.h	2004-09-18 14:25:23.000000000 -0700
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
+		(cmpxchg(pgd, PGD_NONE, _PAGE_TABLE | __pa(pmd)) == PGD_NONE)

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
Index: linus/include/asm-x86_64/pgtable.h
===================================================================
--- linus.orig/include/asm-x86_64/pgtable.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-x86_64/pgtable.h	2004-09-18 14:25:23.000000000 -0700
@@ -436,6 +436,11 @@
 #define	kc_offset_to_vaddr(o) \
    (((o) & (1UL << (__VIRTUAL_MASK_SHIFT-1))) ? ((o) | (~__VIRTUAL_MASK)) : (o))

+
+#define ptep_xchg(mm,addr,xp,newval)	__pte(xchg(&(xp)->pte, pte_val(newval))
+#define ptep_cmpxchg(mm,addr,xp,newval,oldval) (cmpxchg(&(xp)->pte, pte_val(newval), pte_val(oldval) == pte_val(oldval))
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR


