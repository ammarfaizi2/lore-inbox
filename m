Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWAQXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWAQXxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWAQXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:53:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8112 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932534AbWAQXxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:53:16 -0500
Date: Tue, 17 Jan 2006 17:53:02 -0600
From: Robin Holt <holt@sgi.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060117235302.GA22451@lnx-holt.americas.sgi.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

This appears to work on ia64 with the attached patch.  Could you
send me any test application you think would be helpful for me
to verify it is operating correctly?  I could not get the PTSHARE_PUD
to compile.  I put _NO_ effort into it.  I found the following line
was invalid and quit trying.

> +	spged = pgd_val(0);

Thanks,
Robin Holt


Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig	2006-01-14 07:16:46.149226872 -0600
+++ linux-2.6/arch/ia64/Kconfig	2006-01-14 07:25:02.228853432 -0600
@@ -289,6 +289,38 @@ source "mm/Kconfig"
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
+menu "Page table levels to share"
+	depends on PTSHARE
+
+config PTSHARE_PTE
+	bool "Bottom level table (PTE)"
+	depends on PTSHARE
+	default y
+
+config PTSHARE_PMD
+	bool "Middle level table (PMD)"
+	depends on PTSHARE
+	default y
+
+config PTSHARE_PUD
+	bool "Upper level table (PUD)"
+	depends on PTSHARE && PGTABLE_4
+	default n
+
+endmenu
+
+config PTSHARE_HUGEPAGE
+	bool
+	depends on PTSHARE && PTSHARE_PMD
+	default y
+
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
 	help
Index: linux-2.6/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/pgtable.h	2006-01-14 09:49:47.628417563 -0600
+++ linux-2.6/include/asm-ia64/pgtable.h	2006-01-14 09:51:25.315194368 -0600
@@ -283,14 +283,16 @@ ia64_phys_addr_valid (unsigned long addr
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page(pud)			((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page_kernel(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #ifdef CONFIG_PGTABLE_4
 #define pgd_none(pgd)			(!pgd_val(pgd))
 #define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)			((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page_kernel(pgd)		((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page(pgd)			virt_to_page((pgd_val(pgd) + PAGE_OFFSET))
 #endif
 
 /*
@@ -363,12 +365,12 @@ pgd_offset (struct mm_struct *mm, unsign
 #ifdef CONFIG_PGTABLE_4
 /* Find an entry in the second-level page table.. */
 #define pud_offset(dir,addr) \
-	((pud_t *) pgd_page(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
+	((pud_t *) pgd_page_kernel(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 #endif
 
 /* Find an entry in the third-level page table.. */
 #define pmd_offset(dir,addr) \
-	((pmd_t *) pud_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+	((pmd_t *) pud_page_kernel(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 /*
  * Find an entry in the third-level page table.  This looks more complicated than it
