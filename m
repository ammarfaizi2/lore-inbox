Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUI0TPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUI0TPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUI0TNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:13:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:55477 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267251AbUI0TNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:13:04 -0400
Date: Mon, 27 Sep 2004 12:12:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Andy Lutomirski <luto@myrealbox.com>, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V9: [6/7] atomic pte operations for
 x86_64
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409271211490.31769@schroedinger.engr.sgi.com>
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


