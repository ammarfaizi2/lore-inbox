Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVDGTPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVDGTPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVDGTPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:15:47 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:64191 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262561AbVDGTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:14:30 -0400
Date: Thu, 7 Apr 2005 14:14:10 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Matt Porter <mporter@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: make usage of CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT
 consistent
Message-ID: <Pine.LNX.4.61.0504071354060.5277@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT are not currently consistently used 
in the code base.  Fixed up the usage such that CONFIG_PTE_64BIT is used 
when we have a 64-bit PTE regardless of physical address width.  
CONFIG_PHYS_64BIT is used if the physical address width is larger than 
32-bits, regardless of PTE size.

These changes required a few sub-arch specific ifdef's to be fixed and the 
introduction of a physical address format string.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c	2005-04-07 14:13:06 -05:00
+++ b/arch/ppc/mm/pgtable.c	2005-04-07 14:13:06 -05:00
@@ -74,7 +74,7 @@
 #define p_mapped_by_tlbcam(x)	(0UL)
 #endif /* HAVE_TLBCAM */
 
-#ifdef CONFIG_44x
+#ifdef CONFIG_PTE_64BIT
 /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
 #define PGDIR_ORDER	1
 #else
@@ -142,13 +142,13 @@
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
@@ -162,7 +162,7 @@
 
 	return ioremap64(addr64, size);
 }
-#endif /* CONFIG_44x */
+#endif /* CONFIG_PHYS_64BIT */
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
@@ -193,7 +193,7 @@
 	 */
 	if ( mem_init_done && (p < virt_to_phys(high_memory)) )
 	{
-		printk("__ioremap(): phys addr "PTE_FMT" is RAM lr %p\n", p,
+		printk("__ioremap(): phys addr "PHYS_FMT" is RAM lr %p\n", p,
 		       __builtin_return_address(0));
 		return NULL;
 	}
diff -Nru a/include/asm-ppc/mmu.h b/include/asm-ppc/mmu.h
--- a/include/asm-ppc/mmu.h	2005-04-07 14:13:06 -05:00
+++ b/include/asm-ppc/mmu.h	2005-04-07 14:13:06 -05:00
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


