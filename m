Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUI0TR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUI0TR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUI0TQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:16:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64182 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267259AbUI0TNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:13:40 -0400
Date: Mon, 27 Sep 2004 12:13:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Andy Lutomirski <luto@myrealbox.com>, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V9: [7/7] atomic pte operatiosn for
 s390
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409271212290.31769@schroedinger.engr.sgi.com>
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
	* Provide atomic pte operations for s390

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/include/asm-s390/pgtable.h
===================================================================
--- linus.orig/include/asm-s390/pgtable.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-s390/pgtable.h	2004-09-18 14:47:30.000000000 -0700
@@ -783,6 +783,19 @@

 #define kern_addr_valid(addr)   (1)

+/* Atomic PTE operations */
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
+static inline pte_t ptep_xchg(struct mm_struct *mm, unsigned long address, pte_t *ptep, pte_t pteval)
+{
+	return __pte(xchg(ptep, pte_val(pteval)));
+}
+
+static inline int ptep_cmpxchg (struct mm_struct *mm, unsigned long address, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
 /*
  * No page table caches to initialise
  */
Index: linus/include/asm-s390/pgalloc.h
===================================================================
--- linus.orig/include/asm-s390/pgalloc.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-s390/pgalloc.h	2004-09-18 14:47:30.000000000 -0700
@@ -97,6 +97,10 @@
 	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
 }

+static inline int pgd_test_and_populate(struct mm_struct *mm, pdg_t *pgd, pmd_t *pmd)
+{
+	return cmpxchg(pgd, _PAGE_TABLE_INV, _PGD_ENTRY | __pa(pmd)) == _PAGE_TABLE_INV;
+}
 #endif /* __s390x__ */

 static inline void
@@ -119,6 +123,18 @@
 	pmd_populate_kernel(mm, pmd, (pte_t *)((page-mem_map) << PAGE_SHIFT));
 }

+static inline int
+pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+{
+	int rc;
+	spin_lock(&mm->page_table_lock);
+
+	rc=pte_same(*pmd, _PAGE_INVALID_EMPTY);
+	if (rc) pmd_populate(mm, pmd, page);
+	spin_unlock(&mm->page_table_lock);
+	return rc;
+}
+
 /*
  * page table entry allocation/free routines.
  */

