Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268387AbTBSDDC>; Tue, 18 Feb 2003 22:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268394AbTBSDCQ>; Tue, 18 Feb 2003 22:02:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13200 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268387AbTBSC74>;
	Tue, 18 Feb 2003 21:59:56 -0500
Message-Id: <200302190307.h1J37T225487@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: akpm@zip.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/2) x440 discontig support on 2.5.62: early, early ioremap
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Feb 2003 19:07:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was written by Dave Hansen, I just brought it forward to 2.5.62 :-)

This patch is used by the x440 discontigmem to map the srat tables into low 
memory so that the memory can be setup.  This remap function is used very 
early in the boot process... at the start of setup_arch().

Dave posted this previously to linux-kernel.  Here's a pointer to his email:
    http://marc.theaimsgroup.com/?l=linux-kernel&m=104515534619345&w=2

Please consider applying this patch to your tree.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

diff -Nru a/arch/i386/mm/Makefile b/arch/i386/mm/Makefile
--- a/arch/i386/mm/Makefile	Tue Feb 18 16:51:20 2003
+++ b/arch/i386/mm/Makefile	Tue Feb 18 16:51:20 2003
@@ -2,7 +2,7 @@
 # Makefile for the linux i386-specific parts of the memory manager.
 #
 
-obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o
+obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
boot_ioremap.o
 
 obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff -Nru a/arch/i386/mm/boot_ioremap.c b/arch/i386/mm/boot_ioremap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mm/boot_ioremap.c	Tue Feb 18 16:51:20 2003
@@ -0,0 +1,94 @@
+/*
+ * arch/i386/mm/boot_ioremap.c
+ * 
+ * Re-map functions for early boot-time before paging_init() when the 
+ * boot-time pagetables are still in use
+ *
+ * Written by Dave Hansen <haveblue@us.ibm.com>
+ */
+
+
+/*
+ * We need to use the 2-level pagetable functions, but CONFIG_X86_PAE
+ * keeps that from happenning.  If anyone has a better way, I'm listening.
+ *
+ * boot_pte_t is defined only if this all works correctly
+ */
+
+#include <linux/config.h>
+#undef CONFIG_X86_PAE
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+
+/* 
+ * I'm cheating here.  It is known that the two boot PTE pages are 
+ * allocated next to each other.  I'm pretending that they're just
+ * one big array. 
+ */
+
+#define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
+#define boot_pte_index(address) \
+	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
+
+static inline boot_pte_t* boot_vaddr_to_pte(void *address)
+{
+	boot_pte_t* boot_pg = (boot_pte_t*)pg0;
+	return &boot_pg[boot_pte_index((unsigned long)address)];
+}
+
+/*
+ * This is only for a caller who is clever enough to page-align
+ * phys_addr and virtual_source, and who also has a preference
+ * about which virtual address from which to steal ptes
+ */
+static void __boot_ioremap(unsigned long phys_addr, unsigned long nrpages, 
+		    void* virtual_source)
+{
+	boot_pte_t* pte;
+	int i;
+
+	pte = boot_vaddr_to_pte(virtual_source);
+	for (i=0; i < nrpages; i++, phys_addr += PAGE_SIZE, pte++) {
+		set_pte(pte, pfn_pte(phys_addr>>PAGE_SHIFT, PAGE_KERNEL));
+	}
+}
+
+/* the virtual space we're going to remap comes from this array */
+#define BOOT_IOREMAP_PAGES 4
+#define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
+__init char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
+		__attribute__ ((aligned (PAGE_SIZE)));
+
+/*
+ * This only applies to things which need to ioremap before paging_init()
+ * bt_ioremap() and plain ioremap() are both useless at this point.
+ * 
+ * When used, we're still using the boot-time pagetables, which only
+ * have 2 PTE pages mapping the first 8MB
+ *
+ * There is no unmap.  The boot-time PTE pages aren't used after boot.
+ * If you really want the space back, just remap it yourself.
+ * boot_ioremap(&ioremap_space-PAGE_OFFSET, BOOT_IOREMAP_SIZE)
+ */
+__init void* boot_ioremap(unsigned long phys_addr, unsigned long size)
+{
+	unsigned long last_addr, offset;
+	unsigned int nrpages;
+	
+	last_addr = phys_addr + size - 1;
+
+	/* page align the requested address */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+	
+	nrpages = size >> PAGE_SHIFT;
+	if (nrpages > BOOT_IOREMAP_PAGES)
+		return NULL;
+	
+	__boot_ioremap(phys_addr, nrpages, boot_ioremap_space);
+
+	return &boot_ioremap_space[offset];
+}
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Tue Feb 18 16:51:20 2003
+++ b/include/asm-i386/page.h	Tue Feb 18 16:51:20 2003
@@ -49,6 +49,7 @@
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
+#define boot_pte_t pte_t /* or would you rather have a typedef */
 #define pte_val(x)	((x).pte_low)
 #define HPAGE_SHIFT	22
 #endif


