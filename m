Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWJKQ2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWJKQ2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWJKQ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50596 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161108AbWJKQ22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] clean m68k ksyms
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgwV-0005gy-AE@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:28:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sun3_ksyms gone, m68k_ksyms trimmed down to exports of the assembler ones,
for sun3 added the missing exports of __ioremap() and iounmap().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/kernel/m68k_ksyms.c |   51 -----------------------------------------
 arch/m68k/kernel/process.c    |    3 ++
 arch/m68k/kernel/setup.c      |   15 ++++++++++++
 arch/m68k/mm/kmap.c           |    4 +++
 arch/m68k/mm/memory.c         |    8 +++++-
 arch/m68k/mm/sun3kmap.c       |    3 ++
 arch/m68k/sun3/Makefile       |    2 +-
 arch/m68k/sun3/idprom.c       |    3 ++
 arch/m68k/sun3/sun3_ksyms.c   |   13 ----------
 arch/m68k/sun3/sun3dvma.c     |    6 ++++-
 10 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/arch/m68k/kernel/m68k_ksyms.c b/arch/m68k/kernel/m68k_ksyms.c
index f9636e8..6fc69c7 100644
--- a/arch/m68k/kernel/m68k_ksyms.c
+++ b/arch/m68k/kernel/m68k_ksyms.c
@@ -1,61 +1,10 @@
 #include <linux/module.h>
-#include <linux/linkage.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/user.h>
-#include <linux/elfcore.h>
-#include <linux/in6.h>
-#include <linux/interrupt.h>
-
-#include <asm/setup.h>
-#include <asm/machdep.h>
-#include <asm/pgalloc.h>
-#include <asm/irq.h>
-#include <asm/io.h>
 #include <asm/semaphore.h>
-#include <asm/checksum.h>
 
 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
 asmlinkage long long __lshrdi3 (long long, int);
 asmlinkage long long __muldi3 (long long, long long);
-extern char m68k_debug_device[];
-
-/* platform dependent support */
-
-EXPORT_SYMBOL(m68k_machtype);
-EXPORT_SYMBOL(m68k_cputype);
-EXPORT_SYMBOL(m68k_is040or060);
-EXPORT_SYMBOL(m68k_realnum_memory);
-EXPORT_SYMBOL(m68k_memory);
-#ifndef CONFIG_SUN3
-EXPORT_SYMBOL(cache_push);
-EXPORT_SYMBOL(cache_clear);
-#ifndef CONFIG_SINGLE_MEMORY_CHUNK
-EXPORT_SYMBOL(mm_vtop);
-EXPORT_SYMBOL(mm_ptov);
-EXPORT_SYMBOL(mm_end_of_chunk);
-#else
-EXPORT_SYMBOL(m68k_memoffset);
-#endif /* !CONFIG_SINGLE_MEMORY_CHUNK */
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(kernel_set_cachemode);
-#endif /* !CONFIG_SUN3 */
-EXPORT_SYMBOL(m68k_debug_device);
-EXPORT_SYMBOL(mach_hwclk);
-EXPORT_SYMBOL(mach_get_ss);
-EXPORT_SYMBOL(mach_get_rtc_pll);
-EXPORT_SYMBOL(mach_set_rtc_pll);
-#ifdef CONFIG_INPUT_M68K_BEEP_MODULE
-EXPORT_SYMBOL(mach_beep);
-#endif
-EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(dump_thread);
-EXPORT_SYMBOL(kernel_thread);
-#ifdef CONFIG_VME
-EXPORT_SYMBOL(vme_brdtype);
-#endif
 
 /* The following are special because they're not called
    explicitly (the C compiler generates them).  Fortunately,
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 24e83d5..99fc122 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -187,6 +187,7 @@ int kernel_thread(int (*fn)(void *), voi
 	set_fs (fs);
 	return pid;
 }
+EXPORT_SYMBOL(kernel_thread);
 
 void flush_thread(void)
 {
@@ -311,6 +312,7 @@ int dump_fpu (struct pt_regs *regs, stru
 		: "memory");
 	return 1;
 }
+EXPORT_SYMBOL(dump_fpu);
 
 /*
  * fill in the user structure for a core dump..
@@ -357,6 +359,7 @@ void dump_thread(struct pt_regs * regs, 
 	/* dump floating point stuff */
 	dump->u_fpvalid = dump_fpu (regs, &dump->m68kfp);
 }
+EXPORT_SYMBOL(dump_thread);
 
 /*
  * sys_execve() executes a new program.
diff --git a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
index 42d5b85..9af3ee0 100644
--- a/arch/m68k/kernel/setup.c
+++ b/arch/m68k/kernel/setup.c
@@ -42,27 +42,37 @@ #endif
 
 unsigned long m68k_machtype;
 unsigned long m68k_cputype;
+EXPORT_SYMBOL(m68k_machtype);
+EXPORT_SYMBOL(m68k_cputype);
 unsigned long m68k_fputype;
 unsigned long m68k_mmutype;
 #ifdef CONFIG_VME
 unsigned long vme_brdtype;
+EXPORT_SYMBOL(vme_brdtype);
 #endif
 
 int m68k_is040or060;
+EXPORT_SYMBOL(m68k_is040or060);
 
 extern int end;
 extern unsigned long availmem;
 
 int m68k_num_memory;
 int m68k_realnum_memory;
+EXPORT_SYMBOL(m68k_realnum_memory);
+#ifdef CONFIG_SINGLE_MEMORY_CHUNK
 unsigned long m68k_memoffset;
+EXPORT_SYMBOL(m68k_memoffset);
+#endif
 struct mem_info m68k_memory[NUM_MEMINFO];
+EXPORT_SYMBOL(m68k_memory);
 
 static struct mem_info m68k_ramdisk;
 
 static char m68k_command_line[CL_SIZE];
 
 char m68k_debug_device[6] = "";
+EXPORT_SYMBOL(m68k_debug_device);
 
 void (*mach_sched_init) (irq_handler_t handler) __initdata = NULL;
 /* machine dependent irq functions */
@@ -72,10 +82,14 @@ int (*mach_get_hardware_list) (char *buf
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
 int (*mach_hwclk) (int, struct rtc_time*);
+EXPORT_SYMBOL(mach_hwclk);
 int (*mach_set_clock_mmss) (unsigned long);
 unsigned int (*mach_get_ss)(void);
 int (*mach_get_rtc_pll)(struct rtc_pll_info *);
 int (*mach_set_rtc_pll)(struct rtc_pll_info *);
+EXPORT_SYMBOL(mach_get_ss);
+EXPORT_SYMBOL(mach_get_rtc_pll);
+EXPORT_SYMBOL(mach_set_rtc_pll);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
 void (*mach_power_off)( void );
@@ -89,6 +103,7 @@ void (*mach_l2_flush) (int);
 #endif
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
 void (*mach_beep)(unsigned int, unsigned int);
+EXPORT_SYMBOL(mach_beep);
 #endif
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 int isa_type;
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index f46f049..b54ef17 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -7,6 +7,7 @@
  *	     used by other architectures		/Roman Zippel
  */
 
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -219,6 +220,7 @@ #endif
 
 	return (void __iomem *)retaddr;
 }
+EXPORT_SYMBOL(__ioremap);
 
 /*
  * Unmap a ioremap()ed region again
@@ -234,6 +236,7 @@ #else
 	free_io_area((__force void *)addr);
 #endif
 }
+EXPORT_SYMBOL(iounmap);
 
 /*
  * __iounmap unmaps nearly everything, so be careful
@@ -360,3 +363,4 @@ void kernel_set_cachemode(void *addr, un
 
 	flush_tlb_all();
 }
+EXPORT_SYMBOL(kernel_set_cachemode);
diff --git a/arch/m68k/mm/memory.c b/arch/m68k/mm/memory.c
index a0c095e..0f88812 100644
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 1995  Hamish Macdonald
  */
 
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -157,9 +158,8 @@ #endif
 
 	return -1;
 }
-#endif
+EXPORT_SYMBOL(mm_vtop);
 
-#ifndef CONFIG_SINGLE_MEMORY_CHUNK
 unsigned long mm_ptov (unsigned long paddr)
 {
 	int i = 0;
@@ -185,6 +185,7 @@ #ifdef DEBUG_INVALID_PTOV
 #endif
 	return -1;
 }
+EXPORT_SYMBOL(mm_ptov);
 #endif
 
 /* invalidate page in both caches */
@@ -298,6 +299,7 @@ #ifdef CONFIG_M68K_L2_CACHE
 	mach_l2_flush(0);
 #endif
 }
+EXPORT_SYMBOL(cache_clear);	/* probably can be unexported */
 
 
 /*
@@ -350,6 +352,7 @@ #ifdef CONFIG_M68K_L2_CACHE
 	mach_l2_flush(1);
 #endif
 }
+EXPORT_SYMBOL(cache_push);	/* probably can be unexported */
 
 #ifndef CONFIG_SINGLE_MEMORY_CHUNK
 int mm_end_of_chunk (unsigned long addr, int len)
@@ -361,4 +364,5 @@ int mm_end_of_chunk (unsigned long addr,
 			return 1;
 	return 0;
 }
+EXPORT_SYMBOL(mm_end_of_chunk);
 #endif
diff --git a/arch/m68k/mm/sun3kmap.c b/arch/m68k/mm/sun3kmap.c
index 8caa459..1af24cb 100644
--- a/arch/m68k/mm/sun3kmap.c
+++ b/arch/m68k/mm/sun3kmap.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -112,11 +113,13 @@ void __iomem *__ioremap(unsigned long ph
 	return sun3_ioremap(phys, size, SUN3_PAGE_TYPE_IO);
 
 }
+EXPORT_SYMBOL(__ioremap);
 
 void iounmap(void __iomem *addr)
 {
 	vfree((void *)(PAGE_MASK & (unsigned long)addr));
 }
+EXPORT_SYMBOL(iounmap);
 
 /* sun3_map_test(addr, val) -- Reads a byte from addr, storing to val,
  * trapping the potential read fault.  Returns 0 if the access faulted,
diff --git a/arch/m68k/sun3/Makefile b/arch/m68k/sun3/Makefile
index 4d4f069..be1a847 100644
--- a/arch/m68k/sun3/Makefile
+++ b/arch/m68k/sun3/Makefile
@@ -2,6 +2,6 @@ #
 # Makefile for Linux arch/m68k/sun3 source directory
 #
 
-obj-y	:= sun3_ksyms.o sun3ints.o sun3dvma.o sbus.o idprom.o
+obj-y	:= sun3ints.o sun3dvma.o sbus.o idprom.o
 
 obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o intersil.o
diff --git a/arch/m68k/sun3/idprom.c b/arch/m68k/sun3/idprom.c
index 02c1fee..dca6ab6 100644
--- a/arch/m68k/sun3/idprom.c
+++ b/arch/m68k/sun3/idprom.c
@@ -6,6 +6,7 @@
  * Sun3/3x models added by David Monro (davidm@psrg.cs.usyd.edu.au)
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -16,6 +17,8 @@ #include <asm/idprom.h>
 #include <asm/machines.h>  /* Fun with Sun released architectures. */
 
 struct idprom *idprom;
+EXPORT_SYMBOL(idprom);
+
 static struct idprom idprom_buffer;
 
 /* Here is the master table of Sun machines which use some implementation
diff --git a/arch/m68k/sun3/sun3_ksyms.c b/arch/m68k/sun3/sun3_ksyms.c
deleted file mode 100644
index 43e5a9a..0000000
--- a/arch/m68k/sun3/sun3_ksyms.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include <linux/module.h>
-#include <linux/types.h>
-#include <asm/dvma.h>
-#include <asm/idprom.h>
-
-/*
- * Add things here when you find the need for it.
- */
-EXPORT_SYMBOL(dvma_map_align);
-EXPORT_SYMBOL(dvma_unmap);
-EXPORT_SYMBOL(dvma_malloc_align);
-EXPORT_SYMBOL(dvma_free);
-EXPORT_SYMBOL(idprom);
diff --git a/arch/m68k/sun3/sun3dvma.c b/arch/m68k/sun3/sun3dvma.c
index a2bc2da..8709677 100644
--- a/arch/m68k/sun3/sun3dvma.c
+++ b/arch/m68k/sun3/sun3dvma.c
@@ -6,6 +6,7 @@
  * Contains common routines for sun3/sun3x DVMA management.
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/list.h>
@@ -312,6 +313,7 @@ #endif
 	BUG();
 	return 0;
 }
+EXPORT_SYMBOL(dvma_map_align);
 
 void dvma_unmap(void *baddr)
 {
@@ -327,7 +329,7 @@ void dvma_unmap(void *baddr)
 	return;
 
 }
-
+EXPORT_SYMBOL(dvma_unmap);
 
 void *dvma_malloc_align(unsigned long len, unsigned long align)
 {
@@ -367,6 +369,7 @@ #endif
 	return (void *)vaddr;
 
 }
+EXPORT_SYMBOL(dvma_malloc_align);
 
 void dvma_free(void *vaddr)
 {
@@ -374,3 +377,4 @@ void dvma_free(void *vaddr)
 	return;
 
 }
+EXPORT_SYMBOL(dvma_free);
-- 
1.4.2.GIT


