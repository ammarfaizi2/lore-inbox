Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUI0TTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUI0TTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUI0TSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:18:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58003 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267234AbUI0TMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:12:19 -0400
Date: Mon, 27 Sep 2004 12:11:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Andy Lutomirski <luto@myrealbox.com>, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V9: [5/7] atomic pte operations for
 i386
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409271211060.31769@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de> <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Atomic pte operations for i386
	* Needs the general cmpxchg patch for i386

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/include/asm-i386/pgtable.h
===================================================================
--- linus.orig/include/asm-i386/pgtable.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-i386/pgtable.h	2004-09-18 15:41:52.000000000 -0700
@@ -412,6 +412,7 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */
Index: linus/include/asm-i386/pgtable-3level.h
===================================================================
--- linus.orig/include/asm-i386/pgtable-3level.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-i386/pgtable-3level.h	2004-09-18 15:41:52.000000000 -0700
@@ -6,7 +6,8 @@
  * tables on PPro+ CPUs.
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- */
+ * August 26, 2004 added ptep_cmpxchg and ptep_xchg <christoph@lameter.com>
+*/

 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
@@ -141,4 +142,26 @@
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })

+/* Atomic PTE operations */
+static inline pte_t ptep_xchg(struct mm_struct *mm, pte_t *ptep, pte_t newval)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits.
+	 * (But we also have a cmpxchg8b. Why not use that? (cl))
+	  */
+	res.pte_low = xchg(&ptep->pte_low, newval.pte_low);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = newval.pte_high;
+
+	return res;
+}
+
+
+static inline int ptep_cmpxchg(struct mm_struct *mm, unsigned long address, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: linus/include/asm-i386/pgtable-2level.h
===================================================================
--- linus.orig/include/asm-i386/pgtable-2level.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-i386/pgtable-2level.h	2004-09-18 15:41:52.000000000 -0700
@@ -82,4 +82,8 @@
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })

+/* Atomic PTE operations */
+#define ptep_xchg(mm,xp,a)       __pte(xchg(&(xp)->pte_low, (a).pte_low))
+#define ptep_cmpxchg(mm,a,xp,oldpte,newpte) (cmpxchg(&(xp)->pte_low, (oldpte).pte_low, (newpte).pte_low)==(oldpte).pte_low)
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
Index: linus/include/asm-i386/pgalloc.h
===================================================================
--- linus.orig/include/asm-i386/pgalloc.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-i386/pgalloc.h	2004-09-18 15:41:52.000000000 -0700
@@ -7,6 +7,8 @@
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */

+#define PMD_NONE 0L
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))

@@ -16,6 +18,19 @@
 		((unsigned long long)page_to_pfn(pte) <<
 			(unsigned long long) PAGE_SHIFT)));
 }
+
+/* Atomic version */
+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+#ifdef CONFIG_X86_PAE
+	return cmpxchg8b( ((unsigned long long *)pmd), PMD_NONE, _PAGE_TABLE +
+		((unsigned long long)page_to_pfn(pte) <<
+			(unsigned long long) PAGE_SHIFT) ) == PMD_NONE;
+#else
+	return cmpxchg( (unsigned long *)pmd, PMD_NONE, _PAGE_TABLE + (page_to_pfn(pte) << PAGE_SHIFT)) == PMD_NONE;
+#endif
+}
+
 /*
  * Allocate and free page tables.
  */
@@ -49,6 +64,7 @@
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
+#define pgd_test_and_populate(mm, pmd, pte)	({ BUG(); 1; })

 #define check_pgt_cache()	do { } while (0)


