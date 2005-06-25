Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFYSjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFYSjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFYSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:39:38 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:35582 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261238AbVFYSfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:35:46 -0400
Date: Sun, 26 Jun 2005 03:34:42 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12] mips: add MIPS specific support for
 flatmem/discontigmem
Message-Id: <20050626033442.42522745.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 2.6.12-git6 doesn't boot on some MIPS machines.
They need the support of flat memory and discontig memory.
Please apply.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff git6-orig/arch/mips/Kconfig git6/arch/mips/Kconfig
--- git6-orig/arch/mips/Kconfig	Sat Jun 25 11:46:13 2005
+++ git6/arch/mips/Kconfig	Sun Jun 26 02:47:04 2005
@@ -1416,6 +1416,12 @@
 	bool "High Memory Support"
 	depends on MIPS32 && (CPU_R3000 || CPU_SB1 || CPU_R7000 || CPU_RM9000 || CPU_R10000) && !(MACH_DECSTATION || MOMENCO_JAGUAR_ATX)
 
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on !NUMA
+
+source "mm/Kconfig"
+
 config SMP
 	bool "Multi-Processing support"
 	depends on CPU_RM9000 || (SIBYTE_SB1250 && !SIBYTE_STANDALONE) || SGI_IP27
diff -urN -X dontdiff git6-orig/arch/mips/kernel/setup.c git6/arch/mips/kernel/setup.c
--- git6-orig/arch/mips/kernel/setup.c	Sat Jun 18 04:48:29 2005
+++ git6/arch/mips/kernel/setup.c	Sun Jun 26 01:48:35 2005
@@ -33,6 +33,7 @@
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
 #include <linux/console.h>
+#include <linux/mmzone.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -356,6 +357,8 @@
 	}
 #endif
 
+	memory_present(0, first_usable_pfn, max_low_pfn);
+
 	/* Initialize the boot-time allocator with low memory only.  */
 	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);
 
@@ -557,6 +560,7 @@
 
 	parse_cmdline_early();
 	bootmem_init();
+	sparse_init();
 	paging_init();
 	resource_init();
 }
diff -urN -X dontdiff git6-orig/arch/mips/mm/init.c git6/arch/mips/mm/init.c
--- git6-orig/arch/mips/mm/init.c	Sat Jun 25 11:46:13 2005
+++ git6/arch/mips/mm/init.c	Sun Jun 26 01:57:17 2005
@@ -128,7 +128,7 @@
 #endif /* CONFIG_MIPS64 */
 #endif /* CONFIG_HIGHMEM */
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 extern void pagetable_init(void);
 
 void __init paging_init(void)
@@ -253,7 +253,7 @@
 	       initsize >> 10,
 	       (unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)));
 }
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
diff -urN -X dontdiff git6-orig/arch/mips/mm/pgtable.c git6/arch/mips/mm/pgtable.c
--- git6-orig/arch/mips/mm/pgtable.c	Sat Jun 18 04:48:29 2005
+++ git6/arch/mips/mm/pgtable.c	Sat Jun 25 23:02:33 2005
@@ -5,7 +5,7 @@
 
 void show_mem(void)
 {
-#ifndef CONFIG_DISCONTIGMEM  /* XXX(hch): later.. */
+#ifndef CONFIG_NEED_MULTIPLE_NODES  /* XXX(hch): later.. */
 	int pfn, total = 0, reserved = 0;
 	int shared = 0, cached = 0;
 	int highmem = 0;
diff -urN -X dontdiff git6-orig/include/asm-mips/mmzone.h git6/include/asm-mips/mmzone.h
--- git6-orig/include/asm-mips/mmzone.h	Sat Jun 18 04:48:29 2005
+++ git6/include/asm-mips/mmzone.h	Sun Jun 26 02:46:38 2005
@@ -8,6 +8,8 @@
 #include <asm/page.h>
 #include <mmzone.h>
 
+#ifdef CONFIG_DISCONTIGMEM
+
 #define kvaddr_to_nid(kvaddr)	pa_to_nid(__pa(kvaddr))
 #define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
 
@@ -35,5 +37,7 @@
 
 /* XXX: FIXME -- wli */
 #define kern_addr_valid(addr)	(0)
+
+#endif /* CONFIG_DISCONTIGMEM */
 
 #endif /* _ASM_MMZONE_H_ */
diff -urN -X dontdiff git6-orig/include/asm-mips/page.h git6/include/asm-mips/page.h
--- git6-orig/include/asm-mips/page.h	Sat Jun 18 04:48:29 2005
+++ git6/include/asm-mips/page.h	Sat Jun 25 23:04:56 2005
@@ -127,7 +127,7 @@
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
diff -urN -X dontdiff git6-orig/include/asm-mips/pgtable.h git6/include/asm-mips/pgtable.h
--- git6-orig/include/asm-mips/pgtable.h	Sat Jun 18 04:48:29 2005
+++ git6/include/asm-mips/pgtable.h	Sat Jun 25 23:05:10 2005
@@ -350,7 +350,7 @@
 	__update_cache(vma, address, pte);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 #define kern_addr_valid(addr)	(1)
 #endif
 


