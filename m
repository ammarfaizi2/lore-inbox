Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWHCHnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHCHnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHCHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:43:16 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:6854 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932322AbWHCHnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:43:16 -0400
Subject: [PATCH 2/4] Trivial move of __HAVE macros in i386 pagetable headers
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
In-Reply-To: <1154590902.11423.52.camel@localhost.localdomain>
References: <1154590902.11423.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:43:13 +1000
Message-Id: <1154590994.11423.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the __HAVE_ARCH_PTEP defines to accompany the function definitions.
Anything else is just a complete nightmare to track through the 2/3-level
paging code, and this caused duplicate definitions to be needed (pte_same),
which could have easily been taken care of with the asm-generic pgtable
functions.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable-2level.h working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable-2level.h
--- working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable-2level.h	2006-06-28 10:39:29.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable-2level.h	2006-08-03 17:25:04.000000000 +1000
@@ -21,8 +21,9 @@
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
-#define pte_same(a, b)		((a).pte_low == (b).pte_low)
+
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
 #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable-3level.h working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable-3level.h
--- working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable-3level.h	2006-06-28 10:39:29.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable-3level.h	2006-08-03 17:25:04.000000000 +1000
@@ -105,6 +105,7 @@ static inline void pmd_clear(pmd_t *pmd)
 	*(tmp + 1) = 0;
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t res;
@@ -117,6 +118,7 @@ static inline pte_t ptep_get_and_clear(s
 	return res;
 }
 
+#define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable.h working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable.h
--- working-2.6.18-rc2-mm1-zach-1/include/asm-i386/pgtable.h	2006-07-27 16:00:56.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable.h	2006-08-03 17:28:26.000000000 +1000
@@ -246,6 +246,7 @@ static inline pte_t pte_mkhuge(pte_t pte
 # include <asm/pgtable-2level.h>
 #endif
 
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	if (!pte_dirty(*ptep))
@@ -253,6 +254,7 @@ static inline int ptep_test_and_clear_di
 	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
 }
 
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	if (!pte_young(*ptep))
@@ -260,6 +262,7 @@ static inline int ptep_test_and_clear_yo
 	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
 {
 	pte_t pte;
@@ -272,6 +275,7 @@ static inline pte_t ptep_get_and_clear_f
 	return pte;
 }
 
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
@@ -441,12 +445,6 @@ extern void noexec_setup(const char *str
 #define GET_IOSPACE(pfn)		0
 #define GET_PFN(pfn)			(pfn)
 
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
 #endif /* _I386_PGTABLE_H */

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

