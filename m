Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270400AbUJVFH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270400AbUJVFH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 01:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270389AbUJVFFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 01:05:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56467 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268710AbUJVE5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:57:51 -0400
Date: Thu, 21 Oct 2004 21:57:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
In-Reply-To: <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Update set_huge_pte throughout all arches
	* set_huge_pte has an additional address argument
	* set_huge_pte must also do what update_mmu_cache typically does
	  for PAGESIZE ptes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/arch/sh/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/hugetlbpage.c	2004-10-21 20:17:44.000000000 -0700
@@ -57,7 +57,8 @@
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

 void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+			 struct page *page, pte_t * page_table, int write_access,
+			 unsigned long address)
 {
 	unsigned long i;
 	pte_t entry;
@@ -74,6 +75,7 @@

 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte(page_table, entry);
+		update_mmu_cache(vma, address, entry);
 		page_table++;

 		pte_val(entry) += PAGE_SIZE;
Index: linux-2.6.9/arch/sh64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/sh64/mm/hugetlbpage.c	2004-10-18 14:53:46.000000000 -0700
+++ linux-2.6.9/arch/sh64/mm/hugetlbpage.c	2004-10-21 20:26:15.000000000 -0700
@@ -57,7 +57,8 @@
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

 static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+			 struct page *page, pte_t * page_table, int write_access,
+			 unsigned long address)
 {
 	unsigned long i;
 	pte_t entry;
@@ -256,7 +257,7 @@
 				goto out;
 			}
 		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE, addr);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
Index: linux-2.6.9/include/linux/hugetlb.h
===================================================================
--- linux-2.6.9.orig/include/linux/hugetlb.h	2004-10-21 14:50:14.000000000 -0700
+++ linux-2.6.9/include/linux/hugetlb.h	2004-10-21 20:22:45.000000000 -0700
@@ -18,7 +18,7 @@
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 pte_t *huge_pte_alloc(struct mm_struct *, unsigned long);
-void set_huge_pte(struct mm_struct *, struct vm_area_struct *, struct page *, pte_t *, int);
+void set_huge_pte(struct mm_struct *, struct vm_area_struct *, struct page *, pte_t *, int, unsigned long);
 int handle_hugetlb_mm_fault(struct mm_struct *, struct vm_area_struct *, unsigned long, int);

 int hugetlb_report_meminfo(char *);
Index: linux-2.6.9/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/sparc64/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
+++ linux-2.6.9/arch/sparc64/mm/hugetlbpage.c	2004-10-21 20:20:20.000000000 -0700
@@ -54,7 +54,8 @@
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

 void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+			 struct page *page, pte_t * page_table, int write_access,
+			 unsigned long address)
 {
 	unsigned long i;
 	pte_t entry;
@@ -71,6 +72,7 @@

 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte(page_table, entry);
+		update_mmu_cache(vma, address, entry)
 		page_table++;

 		pte_val(entry) += PAGE_SIZE;
Index: linux-2.6.9/arch/i386/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/i386/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
+++ linux-2.6.9/arch/i386/mm/hugetlbpage.c	2004-10-21 20:18:36.000000000 -0700
@@ -54,7 +54,8 @@
 	return (pte_t *) pmd;
 }

-void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page,
+			pte_t * page_table, int write_access, unsigned long address)
 {
 	pte_t entry;

Index: linux-2.6.9/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/mm/hugetlbpage.c	2004-10-21 20:02:52.000000000 -0700
+++ linux-2.6.9/arch/ia64/mm/hugetlbpage.c	2004-10-21 20:25:02.000000000 -0700
@@ -61,7 +61,7 @@

 void
 set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
-	      struct page *page, pte_t * page_table, int write_access)
+	      struct page *page, pte_t * page_table, int write_access, unsigned long address)
 {
 	pte_t entry;

@@ -74,6 +74,7 @@
 	entry = pte_mkyoung(entry);
 	mk_pte_huge(entry);
 	set_pte(page_table, entry);
+	update_mmu_cache(vma, address, entry);
 	return;
 }
 /*

