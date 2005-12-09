Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVLIQjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVLIQjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVLIQjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:39:16 -0500
Received: from smtpout.mac.com ([17.250.248.85]:26071 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932483AbVLIQjP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:39:15 -0500
Date: Fri,  9 Dec 2005 10:39:14 -0600
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes the function make_huge_pte non-static, so it can be used
by drivers that want to mmap huge pages. Consequently, a prototype for the
function is added to hugetlb.h. Since I was looking here, I noticed some
coding style problems in the function and fix them with this patch.

Signed-off-by: Mark Rustad <MRustad@mac.com>

 include/linux/hugetlb.h |    1 +
 mm/hugetlb.c            |   13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/hugetlb.h	2005-11-28 15:58:37.000000000 -0600
+++ b/include/linux/hugetlb.h	2005-12-08 10:38:36.099028314 -0600
@@ -24,6 +24,7 @@ int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page);
 int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, int write_access);
 
--- a/mm/hugetlb.c	2005-11-29 12:11:43.794928597 -0600
+++ b/mm/hugetlb.c	2005-12-08 10:43:43.983294767 -0600
@@ -261,16 +261,15 @@ struct vm_operations_struct hugetlb_vm_o
 	.nopage = hugetlb_nopage,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
+pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
 {
 	pte_t entry;
 
-	if (vma->vm_flags & VM_WRITE) {
-		entry =
-		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-	} else {
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	}
+	entry = mk_pte(page, vma->vm_page_prot);
+	if (vma->vm_flags & VM_WRITE)
+		entry = pte_mkwrite(pte_mkdirty(entry));
+	else
+		entry = pte_wrprotect(entry);
 	entry = pte_mkyoung(entry);
 	entry = pte_mkhuge(entry);
 
-- 
Mark Rustad, mrustad@mac.com
