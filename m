Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269730AbUIRXjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269730AbUIRXjD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbUIRXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:38:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11684 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269684AbUIRXcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:32:00 -0400
Date: Sat, 18 Sep 2004 16:31:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: page fault scalability patch V8: [7/7] atomic pte operations for
 s390
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409181630480.24054@schroedinger.engr.sgi.com>
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

