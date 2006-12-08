Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424822AbWLHHEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424822AbWLHHEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424859AbWLHHEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:04:44 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42566 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424822AbWLHHEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:04:43 -0500
Date: Fri, 8 Dec 2006 16:08:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: [RFC] [PATCH] virtual memmap on sparsemem v3 [4/4] ia64 support
Message-Id: <20061208160803.b6ea27ed.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 support for sparsemem/vmem_map.
* defines mem_map[] and set its value (by static way).
* changes definitions of VMALLOC_START.
* adds CONFIGS.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: devel-2.6.19/arch/ia64/Kconfig
===================================================================
--- devel-2.6.19.orig/arch/ia64/Kconfig	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/arch/ia64/Kconfig	2006-12-08 15:03:21.000000000 +0900
@@ -333,6 +333,14 @@
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
+config ARCH_SPARSEMEM_VMEMMAP
+	def_bool y
+	depends on ARCH_SPARSEMEM_ENABLE
+
+config ARCH_SPARSEMEM_VMEMMAP_STATIC
+	def_bool y
+	depends on SPARSEMEM_VMEMMAP
+
 config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB)
 	depends on ARCH_DISCONTIGMEM_ENABLE
Index: devel-2.6.19/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- devel-2.6.19.orig/arch/ia64/kernel/vmlinux.lds.S	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/arch/ia64/kernel/vmlinux.lds.S	2006-12-08 15:03:21.000000000 +0900
@@ -2,6 +2,7 @@
 #include <asm/cache.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
+#include <asm/sparsemem.h>
 #include <asm/pgtable.h>
 
 #define LOAD_OFFSET	(KERNEL_START - KERNEL_TR_PAGE_SIZE)
@@ -34,6 +35,9 @@
 
   v = PAGE_OFFSET;	/* this symbol is here to make debugging easier... */
   phys_start = _start - LOAD_OFFSET;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+  mem_map = VIRTUAL_MEM_MAP_START;
+#endif
 
   code : { } :code
   . = KERNEL_START;
Index: devel-2.6.19/include/asm-ia64/sparsemem.h
===================================================================
--- devel-2.6.19.orig/include/asm-ia64/sparsemem.h	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/include/asm-ia64/sparsemem.h	2006-12-08 15:03:21.000000000 +0900
@@ -16,5 +16,14 @@
 #endif
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VIRTUAL_MEM_MAP_START	(RGN_BASE(RGN_GATE) + 0x200000000)
+
+#ifndef __ASSEMBLY__
+#define VIRTUAL_MEM_MAP_SIZE	((1UL << (MAX_PHYSMEM_BITS - PAGE_SHIFT)) * sizeof(struct page))
+#define VIRTUAL_MEM_MAP_END	(VIRTUAL_MEM_MAP_START + VIRTUAL_MEM_MAP_SIZE)
+#endif
+#endif
+
 #endif /* CONFIG_SPARSEMEM */
 #endif /* _ASM_IA64_SPARSEMEM_H */
Index: devel-2.6.19/include/asm-ia64/pgtable.h
===================================================================
--- devel-2.6.19.orig/include/asm-ia64/pgtable.h	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/include/asm-ia64/pgtable.h	2006-12-08 15:03:21.000000000 +0900
@@ -230,13 +230,21 @@
 #define set_pte(ptep, pteval)	(*(ptep) = (pteval))
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
+#if defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define VMALLOC_START	(VIRTUAL_MEM_MAP_END)
+#define VMALLOC_END	(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
+
+#elif defined(CONFIG_VIRTUAL_MEM_MAP)
 #define VMALLOC_START		(RGN_BASE(RGN_GATE) + 0x200000000UL)
-#ifdef CONFIG_VIRTUAL_MEM_MAP
-# define VMALLOC_END_INIT	(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
-# define VMALLOC_END		vmalloc_end
-  extern unsigned long vmalloc_end;
+
+#defineVMALLOC_END_INIT    (RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
+#define VMALLOC_END		vmalloc_end
+extern unsigned long vmalloc_end;
 #else
+
+#define VMALLOC_START		(RGN_BASE(RGN_GATE) + 0x200000000UL)
 # define VMALLOC_END		(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
+
 #endif
 
 /* fs/proc/kcore.c */

