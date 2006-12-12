Return-Path: <linux-kernel-owner+w=401wt.eu-S932214AbWLLRPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWLLRPx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWLLRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:15:16 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34651 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbWLLRPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:15:06 -0500
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/4] Pass vma argument to copy_user_highpage().
Date: Tue, 12 Dec 2006 17:14:55 +0000
Message-Id: <11659437003509-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11659436971966-git-send-email-ralf@linux-mips.org>
References: <11659436971966-git-send-email-ralf@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

To allow a more effective copy_user_highpage() on certain architectures,
a vma argument is added to the function and cow_user_page() allowing
the implementation of these functions to check for the VM_EXEC bit.

The main part of this patch was originally written by Ralf Baechle;
Atushi Nemoto did the the debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/linux/highmem.h |    3 ++-
 mm/hugetlb.c            |    6 +++---
 mm/memory.c             |   10 +++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

Index: upstream-alias/mm/memory.c
===================================================================
--- upstream-alias.orig/mm/memory.c
+++ upstream-alias/mm/memory.c
@@ -1441,7 +1441,7 @@ static inline pte_t maybe_mkwrite(pte_t 
 	return pte;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
+static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
 {
 	/*
 	 * If the source page was a PFN mapping, we don't have
@@ -1464,9 +1464,9 @@ static inline void cow_user_page(struct 
 		kunmap_atomic(kaddr, KM_USER0);
 		flush_dcache_page(dst);
 		return;
-		
+
 	}
-	copy_user_highpage(dst, src, va);
+	copy_user_highpage(dst, src, va, vma);
 }
 
 /*
@@ -1577,7 +1577,7 @@ gotten:
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, address);
+		cow_user_page(new_page, old_page, address, vma);
 	}
 
 	/*
@@ -2200,7 +2200,7 @@ retry:
 			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 			if (!page)
 				goto oom;
-			copy_user_highpage(page, new_page, address);
+			copy_user_highpage(page, new_page, address, vma);
 			page_cache_release(new_page);
 			new_page = page;
 			anon = 1;
Index: upstream-alias/include/linux/highmem.h
===================================================================
--- upstream-alias.orig/include/linux/highmem.h
+++ upstream-alias/include/linux/highmem.h
@@ -98,7 +98,8 @@ static inline void memclear_highpage_flu
 
 #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
 
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
+static inline void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
 {
 	char *vfrom, *vto;
 
Index: upstream-alias/mm/hugetlb.c
===================================================================
--- upstream-alias.orig/mm/hugetlb.c
+++ upstream-alias/mm/hugetlb.c
@@ -44,14 +44,14 @@ static void clear_huge_page(struct page 
 }
 
 static void copy_huge_page(struct page *dst, struct page *src,
-			   unsigned long addr)
+			   unsigned long addr, struct vm_area_struct *vma)
 {
 	int i;
 
 	might_sleep();
 	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++) {
 		cond_resched();
-		copy_user_highpage(dst + i, src + i, addr + i*PAGE_SIZE);
+		copy_user_highpage(dst + i, src + i, addr + i*PAGE_SIZE, vma);
 	}
 }
 
@@ -442,7 +442,7 @@ static int hugetlb_cow(struct mm_struct 
 	}
 
 	spin_unlock(&mm->page_table_lock);
-	copy_huge_page(new_page, old_page, address);
+	copy_huge_page(new_page, old_page, address, vma);
 	spin_lock(&mm->page_table_lock);
 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
