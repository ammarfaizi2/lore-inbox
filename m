Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCUVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCUVka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCUVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:11:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64369 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261920AbVCUU6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:58:50 -0500
Date: Mon, 21 Mar 2005 20:57:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>,
       "Luck, Tony" <tony.luck@intel.com>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] freepgt: remove arch pgd_addr_end
In-Reply-To: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503212056460.1970@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 and sparc64 hurriedly had to introduce their own variants of
pgd_addr_end, to leapfrog over the holes in their virtual address spaces
which the final clear_page_range suddenly presented when converted from
pgd_index to pgd_addr_end.  But now that free_pgtables respects the vma
list, those holes are never presented, and the arch variants can go.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/pgtable.h |    8 +++-----
 include/asm-ia64/pgtable.h    |   26 --------------------------
 include/asm-sparc64/pgtable.h |   15 ---------------
 3 files changed, 3 insertions(+), 46 deletions(-)

--- freepgt3/include/asm-generic/pgtable.h	2005-03-18 10:22:40.000000000 +0000
+++ freepgt4/include/asm-generic/pgtable.h	2005-03-21 19:07:13.000000000 +0000
@@ -136,17 +136,15 @@ static inline void ptep_set_wrprotect(st
 #endif
 
 /*
- * When walking page tables, get the address of the next boundary, or
- * the end address of the range if that comes earlier.  Although end might
- * wrap to 0 only in clear_page_range, __boundary may wrap to 0 throughout.
+ * When walking page tables, get the address of the next boundary,
+ * or the end address of the range if that comes earlier.  Although no
+ * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
  */
 
-#ifndef pgd_addr_end
 #define pgd_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
-#endif
 
 #ifndef pud_addr_end
 #define pud_addr_end(addr, end)						\
--- freepgt3/include/asm-ia64/pgtable.h	2005-03-21 19:07:01.000000000 +0000
+++ freepgt4/include/asm-ia64/pgtable.h	2005-03-21 19:07:13.000000000 +0000
@@ -551,32 +551,6 @@ do {											\
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
 
-/*
- * Override for pgd_addr_end() to deal with the virtual address space holes
- * in each region.  In regions 0..4 virtual address bits are used like this:
- *      +--------+------+--------+-----+-----+--------+
- *      | pgdhi3 | rsvd | pgdlow | pmd | pte | offset |
- *      +--------+------+--------+-----+-----+--------+
- *  'pgdlow' overflows to pgdhi3 (a.k.a. region bits) leaving rsvd==0
- */
-#define IA64_PGD_OVERFLOW (PGDIR_SIZE << (PAGE_SHIFT-6))
-
-#define pgd_addr_end(addr, end)						\
-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
- 	if (REGION_NUMBER(__boundary) < 5 && 				\
-	    __boundary & IA64_PGD_OVERFLOW)				\
-		__boundary += (RGN_SIZE - 1) & ~(IA64_PGD_OVERFLOW - 1);\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
-#define pmd_addr_end(addr, end)						\
-({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
- 	if (REGION_NUMBER(__boundary) < 5 &&				\
-	    __boundary & IA64_PGD_OVERFLOW)				\
-		__boundary += (RGN_SIZE - 1) & ~(IA64_PGD_OVERFLOW - 1);\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
 #include <asm-generic/pgtable-nopud.h>
 #include <asm-generic/pgtable.h>
 
--- freepgt3/include/asm-sparc64/pgtable.h	2005-03-18 10:22:42.000000000 +0000
+++ freepgt4/include/asm-sparc64/pgtable.h	2005-03-21 19:07:13.000000000 +0000
@@ -432,21 +432,6 @@ extern int io_remap_page_range(struct vm
 			       unsigned long offset,
 			       unsigned long size, pgprot_t prot, int space);
 
-/* Override for {pgd,pmd}_addr_end() to deal with the virtual address
- * space hole.  We simply sign extend bit 43.
- */
-#define pgd_addr_end(addr, end)						\
-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
-	__boundary = ((long) (__boundary << 20)) >> 20;			\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
-#define pmd_addr_end(addr, end)						\
-({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
-	__boundary = ((long) (__boundary << 20)) >> 20;			\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
 #include <asm-generic/pgtable.h>
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
