Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267167AbUFZNRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267167AbUFZNRR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUFZNRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 09:17:17 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:28681 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S267167AbUFZNRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 09:17:13 -0400
Message-ID: <40DD7814.779DEF17@tv-sign.ru>
Date: Sat, 26 Jun 2004 17:20:20 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] kill mm_struct.used_hugetlb
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

mm_struct.used_hugetlb used to eliminate costly find_vma()
from follow_page(). Now it is used only in ia64 version of
follow_huge_addr(). I know nothing about ia64, but this
REGION_NUMBER() looks simple enough to kill used_hugetlb.

There is debug version (commented out) of follow_huge_addr()
in i386 which looks at used_hugetlb, but it can work without
this check.

Am i missed somethimg?

Oleg.

Signed-off: Oleg Nesterov

diff -urp 6.7-clean/arch/i386/mm/hugetlbpage.c 6.7-hugetlb/arch/i386/mm/hugetlbpage.c
--- 6.7-clean/arch/i386/mm/hugetlbpage.c	2004-05-24 14:15:58.000000000 +0400
+++ 6.7-hugetlb/arch/i386/mm/hugetlbpage.c	2004-06-26 16:48:08.000000000 +0400
@@ -147,9 +147,6 @@ follow_huge_addr(struct mm_struct *mm, u
 	struct page *page;
 	struct vm_area_struct *vma;
 
-	if (! mm->used_hugetlb)
-		return ERR_PTR(-EINVAL);
-
 	vma = find_vma(mm, addr);
 	if (!vma || !is_vm_hugetlb_page(vma))
 		return ERR_PTR(-EINVAL);
diff -urp 6.7-clean/arch/ia64/mm/hugetlbpage.c 6.7-hugetlb/arch/ia64/mm/hugetlbpage.c
--- 6.7-clean/arch/ia64/mm/hugetlbpage.c	2004-05-24 14:15:58.000000000 +0400
+++ 6.7-hugetlb/arch/ia64/mm/hugetlbpage.c	2004-06-26 16:48:21.000000000 +0400
@@ -158,8 +158,6 @@ struct page *follow_huge_addr(struct mm_
 	struct page *page;
 	pte_t *ptep;
 
-	if (! mm->used_hugetlb)
-		return ERR_PTR(-EINVAL);
 	if (REGION_NUMBER(addr) != REGION_HPAGE)
 		return ERR_PTR(-EINVAL);
 
diff -urp 6.7-clean/include/linux/hugetlb.h 6.7-hugetlb/include/linux/hugetlb.h
--- 6.7-clean/include/linux/hugetlb.h	2004-06-08 13:44:18.000000000 +0400
+++ 6.7-hugetlb/include/linux/hugetlb.h	2004-06-26 16:50:59.000000000 +0400
@@ -34,13 +34,6 @@ extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
 extern int sysctl_hugetlb_shm_group;
 
-static inline void
-mark_mm_hugetlb(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	if (is_vm_hugetlb_page(vma))
-		mm->used_hugetlb = 1;
-}
-
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
@@ -72,7 +65,6 @@ static inline unsigned long hugetlb_tota
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
-#define mark_mm_hugetlb(mm, vma)		do { } while (0)
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
diff -urp 6.7-clean/include/linux/sched.h 6.7-hugetlb/include/linux/sched.h
--- 6.7-clean/include/linux/sched.h	2004-06-16 12:38:59.000000000 +0400
+++ 6.7-hugetlb/include/linux/sched.h	2004-06-26 16:49:06.000000000 +0400
@@ -217,9 +217,6 @@ struct mm_struct {
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
-#ifdef CONFIG_HUGETLB_PAGE
-	int used_hugetlb;
-#endif
 	cpumask_t cpu_vm_mask;
 
 	/* Architecture-specific MM context */
diff -urp 6.7-clean/mm/mmap.c 6.7-hugetlb/mm/mmap.c
--- 6.7-clean/mm/mmap.c	2004-06-08 13:44:19.000000000 +0400
+++ 6.7-hugetlb/mm/mmap.c	2004-06-26 16:51:21.000000000 +0400
@@ -318,7 +318,6 @@ static void vma_link(struct mm_struct *m
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 
-	mark_mm_hugetlb(mm, vma);
 	mm->map_count++;
 	validate_mm(mm);
 }
