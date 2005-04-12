Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVDLU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVDLU1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVDLU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:26:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:9928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262125AbVDLKbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:13 -0400
Message-Id: <200504121031.j3CAVADx005253@shell0.pdx.osdl.net>
Subject: [patch 033/198] ppc32: make usage of CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT consistent
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, galak@freescale.com,
       kumar.gala@freescale.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kumar Gala <galak@freescale.com>

CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT are not currently consistently used in
the code base.  Fixed up the usage such that CONFIG_PTE_64BIT is used when we
have a 64-bit PTE regardless of physical address width.  CONFIG_PHYS_64BIT is
used if the physical address width is larger than 32-bits, regardless of PTE
size.

These changes required a few sub-arch specific ifdef's to be fixed and the
introduction of a physical address format string.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/mm/pgtable.c |   10 +++++-----
 25-akpm/include/asm-ppc/mmu.h |    4 +++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN arch/ppc/mm/pgtable.c~ppc32-make-usage-of-config_pte_64bit-config_phys_64bit arch/ppc/mm/pgtable.c
--- 25/arch/ppc/mm/pgtable.c~ppc32-make-usage-of-config_pte_64bit-config_phys_64bit	2005-04-12 03:21:11.356410464 -0700
+++ 25-akpm/arch/ppc/mm/pgtable.c	2005-04-12 03:21:11.361409704 -0700
@@ -74,7 +74,7 @@ extern unsigned long p_mapped_by_tlbcam(
 #define p_mapped_by_tlbcam(x)	(0UL)
 #endif /* HAVE_TLBCAM */
 
-#ifdef CONFIG_44x
+#ifdef CONFIG_PTE_64BIT
 /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
 #define PGDIR_ORDER	1
 #else
@@ -142,13 +142,13 @@ void pte_free(struct page *ptepage)
 	__free_page(ptepage);
 }
 
-#ifndef CONFIG_44x
+#ifndef CONFIG_PHYS_64BIT
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
 	return __ioremap(addr, size, _PAGE_NO_CACHE);
 }
-#else /* CONFIG_44x */
+#else /* CONFIG_PHYS_64BIT */
 void __iomem *
 ioremap64(unsigned long long addr, unsigned long size)
 {
@@ -162,7 +162,7 @@ ioremap(phys_addr_t addr, unsigned long 
 
 	return ioremap64(addr64, size);
 }
-#endif /* CONFIG_44x */
+#endif /* CONFIG_PHYS_64BIT */
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
@@ -193,7 +193,7 @@ __ioremap(phys_addr_t addr, unsigned lon
 	 */
 	if ( mem_init_done && (p < virt_to_phys(high_memory)) )
 	{
-		printk("__ioremap(): phys addr "PTE_FMT" is RAM lr %p\n", p,
+		printk("__ioremap(): phys addr "PHYS_FMT" is RAM lr %p\n", p,
 		       __builtin_return_address(0));
 		return NULL;
 	}
diff -puN include/asm-ppc/mmu.h~ppc32-make-usage-of-config_pte_64bit-config_phys_64bit include/asm-ppc/mmu.h
--- 25/include/asm-ppc/mmu.h~ppc32-make-usage-of-config_pte_64bit-config_phys_64bit	2005-04-12 03:21:11.358410160 -0700
+++ 25-akpm/include/asm-ppc/mmu.h	2005-04-12 03:21:11.361409704 -0700
@@ -15,11 +15,13 @@
  * virtual/physical addressing like 32-bit virtual / 36-bit
  * physical need a larger than native word size type. -Matt
  */
-#ifndef CONFIG_PTE_64BIT
+#ifndef CONFIG_PHYS_64BIT
 typedef unsigned long phys_addr_t;
+#define PHYS_FMT	"%.8lx"
 #else
 typedef unsigned long long phys_addr_t;
 extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
+#define PHYS_FMT	"%16Lx"
 #endif
 
 /* Default "unsigned long" context */
_
