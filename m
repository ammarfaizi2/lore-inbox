Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVKFISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVKFISm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVKFISl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:18:41 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:29617 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932299AbVKFISk (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:18:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=FXmaUxndmwPdJJi1jLa5ybYG0U+0YYQSVXLaDAaWUOnjcKnTfudMf+psbyEE8J8gnmFcDBhNxlppDkDF84AKXZmrUXXw+VIfKtMWFZ6Y27ipL7RCEYw4BxtiKa10IFXjoiQ9STDD4mn0YenzsTOuF5UZt6LtIqNyU6el0QbHQhk=  ;
Message-ID: <436DBCE2.4050502@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:20:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 2/14] mm: pte prefetch
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au>
In-Reply-To: <436DBCBC.5000906@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050107070405010703040702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050107070405010703040702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/14

-- 
SUSE Labs, Novell Inc.


--------------050107070405010703040702
Content-Type: text/plain;
 name="mm-pte-prefetch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-pte-prefetch.patch"

Prefetch ptes a line ahead. Worth 25% on ia64 when doing big forks.

Index: linux-2.6/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-generic/pgtable.h
+++ linux-2.6/include/asm-generic/pgtable.h
@@ -196,6 +196,33 @@ static inline void ptep_set_wrprotect(st
 })
 #endif
 
+#ifndef __HAVE_ARCH_PTE_PREFETCH
+#define PTES_PER_LINE (L1_CACHE_BYTES / sizeof(pte_t))
+#define PTE_LINE_MASK (~(PTES_PER_LINE - 1))
+#define ADDR_PER_LINE (PTES_PER_LINE << PAGE_SHIFT)
+#define ADDR_LINE_MASK (~(ADDR_PER_LINE - 1))
+
+#define pte_prefetch(pte, addr, end)					\
+({									\
+	unsigned long __nextline = ((addr) + ADDR_PER_LINE) & ADDR_LINE_MASK; \
+	if (__nextline < (end))						\
+		prefetch(pte + PTES_PER_LINE);				\
+})
+
+#define pte_prefetch_start(pte, addr, end)				\
+({									\
+ 	prefetch(pte);							\
+ 	pte_prefetch(pte, addr, end);					\
+})
+
+#define pte_prefetch_next(pte, addr, end)				\
+({									\
+	unsigned long __addr = (addr);					\
+	if (!(__addr & ~ADDR_LINE_MASK)) /* We hit a new cacheline */	\
+		pte_prefetch(pte, __addr, end);				\
+})
+#endif
+
 #ifndef __ASSEMBLY__
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -437,6 +437,8 @@ again:
 	if (!dst_pte)
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
+	pte_prefetch_start(src_pte, addr, end);
+
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock(src_ptl);
 
@@ -458,7 +460,8 @@ again:
 		}
 		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
 		progress += 8;
-	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE,
+			pte_prefetch_next(src_pte, addr, end), addr != end);
 
 	spin_unlock(src_ptl);
 	pte_unmap_nested(src_pte - 1);
@@ -561,6 +564,7 @@ static unsigned long zap_pte_range(struc
 	int anon_rss = 0;
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	pte_prefetch_start(pte, addr, end);
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent)) {
@@ -629,7 +633,8 @@ static unsigned long zap_pte_range(struc
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
-	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
+	} while (pte++, addr += PAGE_SIZE, pte_prefetch_next(pte, addr, end),
+			(addr != end && *zap_work > 0));
 
 	add_mm_rss(mm, file_rss, anon_rss);
 	pte_unmap_unlock(pte - 1, ptl);

--------------050107070405010703040702--
Send instant messages to your online friends http://au.messenger.yahoo.com 
