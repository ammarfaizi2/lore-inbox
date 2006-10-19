Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946213AbWJSQfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946213AbWJSQfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946194AbWJSQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:35:36 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:14048 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1946209AbWJSQfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:35:33 -0400
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/3] Pass vma argument to copy_user_highpage().
Date: Thu, 19 Oct 2006 17:35:47 +0100
Message-Id: <11612757501251-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161275748231-git-send-email-ralf@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org>
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
 mm/memory.c             |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

Index: upstream-linus/mm/memory.c
===================================================================
--- upstream-linus.orig/mm/memory.c	2006-10-17 00:14:41.000000000 +0100
+++ upstream-linus/mm/memory.c	2006-10-17 00:15:40.000000000 +0100
@@ -1431,7 +1431,7 @@ static inline pte_t maybe_mkwrite(pte_t 
 	return pte;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
+static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
 {
 	/*
 	 * If the source page was a PFN mapping, we don't have
@@ -1453,9 +1453,9 @@ static inline void cow_user_page(struct 
 			memset(kaddr, 0, PAGE_SIZE);
 		kunmap_atomic(kaddr, KM_USER0);
 		return;
-		
+
 	}
-	copy_user_highpage(dst, src, va);
+	copy_user_highpage(dst, src, va, vma);
 }
 
 /*
@@ -1566,7 +1566,7 @@ gotten:
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, address);
+		cow_user_page(new_page, old_page, address, vma);
 	}
 
 	/*
@@ -2190,7 +2190,7 @@ retry:
 			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 			if (!page)
 				goto oom;
-			copy_user_highpage(page, new_page, address);
+			copy_user_highpage(page, new_page, address, vma);
 			page_cache_release(new_page);
 			new_page = page;
 			anon = 1;
Index: upstream-linus/include/linux/highmem.h
===================================================================
--- upstream-linus.orig/include/linux/highmem.h	2006-10-17 00:15:21.000000000 +0100
+++ upstream-linus/include/linux/highmem.h	2006-10-17 00:17:23.000000000 +0100
@@ -96,7 +96,8 @@ static inline void memclear_highpage_flu
 
 #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
 
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
+static inline void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
 {
 	char *vfrom, *vto;
 
