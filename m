Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVG3EIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVG3EIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVG3EG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:06:56 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:45837 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262823AbVG3EGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:44 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44GTn005939@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 6/6 i386 mmu-set-pte
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0187 (UTC) FILETIME=[E469EEB0:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_pte macros in a couple places where they were missing.

Also, setting PDPEs in PAE mode does not require atomic operations,
since the PDPEs are cached by the processor, and only reloaded on
an explicit or implicit reload of CR3.

Since the four PDPEs must always be present in an active root, and the kernel
PDPE is never updated, we are safe even from SMIs and interrupts / NMIs using
task gates (which reload CR3).  Actually, much of this is moot, since the
user PDPEs are never updated either, and the only usage of task gates is by
the doublefault handler.  It appears the only place PGDs get updated in PAE
mode is in init_low_mappings() / zap_low_mapping() for initial page table
creation and recovery from ACPI sleep state, and these sites are safe by
inspection.  Getting rid of the cmpxchg8b saves code space and 720 cycles
in pgd_alloc on P4.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-07-29 14:06:16.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-07-29 14:10:42.000000000 -0700
@@ -12,6 +12,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 static DEFINE_SPINLOCK(cpa_lock);
 static struct list_head df_list = LIST_HEAD_INIT(df_list);
@@ -52,8 +53,8 @@
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
-		pbase[i] = pfn_pte(addr >> PAGE_SHIFT, 
-				   addr == address ? prot : PAGE_KERNEL);
+               set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT, 
+                                          addr == address ? prot : PAGE_KERNEL));
 	}
 	return base;
 } 
Index: linux-2.6.13/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-07-29 11:02:58.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/init.c	2005-07-29 14:37:18.000000000 -0700
@@ -348,7 +348,7 @@
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
+	set_pgd(&pgd_base[0], pgd_base[USER_PTRS_PER_PGD]);
 #endif
 }
 
Index: linux-2.6.13/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable-3level.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable-3level.h	2005-07-29 14:18:57.000000000 -0700
@@ -64,7 +64,7 @@
 #define set_pmd(pmdptr,pmdval) \
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
-		set_64bit((unsigned long long *)(pudptr),pud_val(pudval))
+		(*(pudptr) = (pudval))
 
 /*
  * Pentium-II erratum A13: in PAE mode we explicitly have to flush
