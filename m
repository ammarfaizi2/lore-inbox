Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVKGK6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVKGK6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVKGK6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:58:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60828 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751308AbVKGK6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:58:08 -0500
Date: Mon, 7 Nov 2005 10:58:07 +0000
From: arjan@infradead.org
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [patch 02/02] Debug option to write-protect rodata: the write protect logic and config option
Message-ID: <20051107105807.GB6531@infradead.org>
References: <20051107105624.GA6531@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107105624.GA6531@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a patch that turns the kernel's .rodata section to be
actually read only, eg any write attempts to it cause a segmentation fault.

This patch introduces the actual debug option to catch any writes to rodata

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.14/arch/x86_64/Kconfig.debug linux-2.6.14-fordiff/arch/x86_64/Kconfig.debug
--- linux-2.6.14/arch/x86_64/Kconfig.debug	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-fordiff/arch/x86_64/Kconfig.debug	2005-11-07 10:57:03.000000000 +0100
@@ -51,6 +51,18 @@ config IOMMU_LEAK
          Add a simple leak tracer to the IOMMU code. This is useful when you
 	 are debugging a buggy device driver that leaks IOMMU mappings.
 
+config DEBUG_RODATA
+       bool "Write protect kernel read-only data structures"
+       depends on DEBUG_KERNEL
+       help
+ 	  Mark the kernel read-only data as write-protected in the pagetables,
+	  in order to catch accidental (and incorrect) writes to such const data.
+	  This option may have a slight performance impact because a portion
+	  of the kernel code won't be covered by a 2Mb TLB anymore.
+	  If in doubt, say "N".
+
+
+
 #config X86_REMOTE_DEBUG
 #       bool "kgdb debugging stub"
 
diff -purN linux-2.6.14/arch/x86_64/mm/init.c linux-2.6.14-fordiff/arch/x86_64/mm/init.c
--- linux-2.6.14/arch/x86_64/mm/init.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-fordiff/arch/x86_64/mm/init.c	2005-11-07 10:52:17.000000000 +0100
@@ -87,7 +87,7 @@ void show_mem(void)
 /* References to section boundaries */
 
 extern char _text, _etext, _edata, __bss_start, _end[];
-extern char __init_begin, __init_end;
+extern char __init_begin, __init_end, __start_rodata, __end_rodata;
 
 int after_bootmem;
 
@@ -449,6 +449,27 @@ void __init mem_init(void)
 #endif
 }
 
+
+#ifdef CONFIG_DEBUG_RODATA
+void mark_rodata_ro(void)
+{
+	unsigned long addr;
+
+	addr = (unsigned long)(&__start_rodata);
+	for (; addr < (unsigned long)(&__end_rodata); addr += PAGE_SIZE)
+		change_page_attr_addr(addr, 1, PAGE_KERNEL_RO);
+	
+	printk ("Write protecting the kernel read-only data: %luk \n", (&__end_rodata - &__start_rodata) >> 10);
+
+	/* 
+         * change_page_attr_addr() requires a global_flush_tlb() call after it. We do this after the printk
+         * so that if something went wrong in the change, the printk gets out at least to give a better debug hint
+         * of who is the culprit.
+         */
+	global_flush_tlb();
+}
+#endif
+
 extern char __initdata_begin[], __initdata_end[];
 
 void free_initmem(void)
diff -purN linux-2.6.14/include/asm-generic/vmlinux.lds.h linux-2.6.14-fordiff/include/asm-generic/vmlinux.lds.h
--- linux-2.6.14/include/asm-generic/vmlinux.lds.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-fordiff/include/asm-generic/vmlinux.lds.h	2005-11-05 13:08:52.000000000 +0100
@@ -10,6 +10,8 @@
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
 #define RODATA								\
+	. = ALIGN(4096); 						\
+	__start_rodata = .;						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		*(.rodata) *(.rodata.*)					\
 		*(__vermagic)		/* Kernel version magic */	\
@@ -67,6 +69,8 @@
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
 	}								\
+	__end_rodata = .;						\
+	. = ALIGN(4096); 						\
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
diff -purN linux-2.6.14/init/main.c linux-2.6.14-fordiff/init/main.c
--- linux-2.6.14/init/main.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-fordiff/init/main.c	2005-11-07 11:03:26.000000000 +0100
@@ -100,6 +100,11 @@ extern void acpi_early_init(void);
 #else
 static inline void acpi_early_init(void) { }
 #endif
+#ifdef CONFIG_DEBUG_RODATA
+extern void mark_rodata_ro(void);
+#else
+static inline void mark_rodata_ro(void) {  }
+#endif
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -710,6 +715,7 @@ static int init(void * unused)
 	 */
 	free_initmem();
 	unlock_kernel();
+	mark_rodata_ro();
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
