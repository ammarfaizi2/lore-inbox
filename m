Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSJPFg7>; Wed, 16 Oct 2002 01:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264887AbSJPFg7>; Wed, 16 Oct 2002 01:36:59 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:16320 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264886AbSJPFgx>; Wed, 16 Oct 2002 01:36:53 -0400
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
References: <3DAC337D.7010804@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 16 Oct 2002 14:42:44 +0900
In-Reply-To: <3DAC337D.7010804@snapgear.com>
Message-ID: <buoit03lz1n.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Here's a v850 update for 2.5.42uc1.

I addressed two of Christoph Hellwig's concerns, (1) vmlinux.lds.S
[barf] and (2) the asm-constant generation mechanism.

He also complained about using the MD driver &c instead of initrd, but
I'm not sure what do about that -- it'd be nice to use a `standard'
solution, but when I originally looked at the initrd stuff, it seemed
very convoluted and confusing; since earlier lkml discussion had pointed
to using MD as the nearest thing to the old blkmem device, that seemed
like the way to go.

What's your opinion on this?


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.42uc1-v850-20021016-dist.patch
Content-Description: linux-2.5.42uc1-v850-20021016-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/Makefile arch/v850/Makefile
--- ../orig/linux-2.5.42uc1/arch/v850/Makefile	2002-10-16 10:45:53.000000000 +0900
+++ arch/v850/Makefile	2002-10-16 13:46:51.000000000 +0900
@@ -23,32 +23,6 @@
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
 
-# linker scripts
-ifdef CONFIG_V850E_SIM
-LINKER_SCRIPT = $(arch_dir)/sim.ld
-endif
-ifdef CONFIG_V850E2_SIM85E2C
-LINKER_SCRIPT = $(arch_dir)/sim85e2c.ld
-endif
-ifdef CONFIG_V850E2_FPGA85E2C
-LINKER_SCRIPT = $(arch_dir)/fpga85e2c.ld
-endif
-ifdef CONFIG_V850E2_ANNA
-LINKER_SCRIPT = $(arch_dir)/anna.ld
-endif
-ifdef CONFIG_RTE_CB_MA1
-ifdef CONFIG_ROM_KERNEL
-LINKER_SCRIPT = $(arch_dir)/rte_ma1_cb-rom.ld
-else
-ifdef CONFIG_RTE_CB_MA1_KSRAM
-LINKER_SCRIPT = $(arch_dir)/rte_ma1_cb-ksram.ld
-else
-LINKER_SCRIPT = $(arch_dir)/rte_ma1_cb.ld
-endif
-endif
-endif
-
-
 HEAD := $(arch_dir)/kernel/head.o $(arch_dir)/kernel/init_task.o
 core-y += $(arch_dir)/kernel/
 libs-y += $(arch_dir)/lib/
@@ -73,17 +47,19 @@
 endif
 
 
-# Barf.
-$(arch_dir)/vmlinux.lds.S: $(LINKER_SCRIPT)
-	cp $< $@
-
-
-archmrproper:
-
-archdep:
+prepare: include/asm-$(ARCH)/asm-consts.h
 
-archclean:
-	rm -f vmlinux
-	rm -f root_fs_image.o
-	rm -f $(arch_dir)/kernel/v850_defs.h $(arch_dir)/kernel/v850_defs.d
-	rm -f $(arch_dir)/vmlinux.lds.S $(arch_dir)/vmlinux.lds.s
+# Generate constants from C code for use by asm files
+arch/$(ARCH)/kernel/asm-consts.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+include/asm-$(ARCH)/asm-consts.h.tmp: arch/$(ARCH)/kernel/asm-consts.s
+	@$(generate-asm-offsets.h) < $< > $@
+include/asm-$(ARCH)/asm-consts.h: include/asm-$(ARCH)/asm-consts.h.tmp
+	@echo -n '  Generating $@'
+	@$(update-if-changed)
+
+
+CLEAN_FILES += include/asm-$(ARCH)/asm-consts.h.tmp \
+	       include/asm-$(ARCH)/asm-consts.h \
+	       arch/$(ARCH)/kernel/asm-consts.s \
+	       root_fs_image.o
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/kernel/Makefile arch/v850/kernel/Makefile
--- ../orig/linux-2.5.42uc1/arch/v850/kernel/Makefile	2002-10-16 10:45:54.000000000 +0900
+++ arch/v850/kernel/Makefile	2002-10-16 13:47:05.000000000 +0900
@@ -36,17 +36,3 @@
 
 
 include $(TOPDIR)/Rules.make
-
-
-$(obj)/head.o: $(src)/head.S $(obj)/v850_defs.h
-$(obj)/entry.o: $(src)/entry.S $(obj)/v850_defs.h
-
--include $(obj)/v850_defs.d
-
-$(obj)/v850_defs.h: $(src)/v850_defs.c $(src)/v850_defs.head
-	rm -f $(obj)/v850_defs.d
-	SUNPRO_DEPENDENCIES="$(obj)/v850_defs.d $(obj)/v850_defs.h" \
-	$(CC) $(filter-out -MD,$(CFLAGS)) -S -o $(obj)/v850_defs.s $(src)/v850_defs.c
-	cp $(src)/v850_defs.head $(src)/v850_defs.h
-	grep '^#define' $(obj)/v850_defs.s >> $(obj)/v850_defs.h
-	rm $(obj)/v850_defs.s
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/kernel/asm-consts.c arch/v850/kernel/asm-consts.c
--- ../orig/linux-2.5.42uc1/arch/v850/kernel/asm-consts.c	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/kernel/asm-consts.c	2002-10-16 13:51:15.000000000 +0900
@@ -0,0 +1,60 @@
+/*
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ *
+ * We use the technique used in the OSF Mach kernel code:
+ * generate asm statements containing #defines,
+ * compile this file to assembler, and then extract the
+ * #defines from the assembly-language output.
+ */
+
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <asm/irq.h>
+#include <asm/hardirq.h>
+#include <asm/errno.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int main (void)
+{
+	/* offsets into the task struct */
+	DEFINE (TASK_STATE, offsetof (struct task_struct, state));
+	DEFINE (TASK_FLAGS, offsetof (struct task_struct, flags));
+	DEFINE (TASK_PTRACE, offsetof (struct task_struct, ptrace));
+	DEFINE (TASK_BLOCKED, offsetof (struct task_struct, blocked));
+	DEFINE (TASK_THREAD, offsetof (struct task_struct, thread));
+	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
+	DEFINE (TASK_MM, offsetof (struct task_struct, mm));
+	DEFINE (TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
+	DEFINE (TASK_PID, offsetof (struct task_struct, pid));
+
+	/* offsets into the kernel_stat struct */
+	DEFINE (STAT_IRQ, offsetof (struct kernel_stat, irqs));
+
+
+	/* signal defines */
+	DEFINE (SIGSEGV, SIGSEGV);
+	DEFINE (SEGV_MAPERR, SEGV_MAPERR);
+	DEFINE (SIGTRAP, SIGTRAP);
+	DEFINE (SIGCHLD, SIGCHLD);
+	DEFINE (SIGILL, SIGILL);
+	DEFINE (TRAP_TRACE, TRAP_TRACE);
+
+	/* ptrace flag bits */
+	DEFINE (PT_PTRACED, PT_PTRACED);
+	DEFINE (PT_DTRACE, PT_DTRACE);
+
+	/* error values */
+	DEFINE (ENOSYS, ENOSYS);
+
+	/* clone flag bits */
+	DEFINE (CLONE_VFORK, CLONE_VFORK);
+	DEFINE (CLONE_VM, CLONE_VM);
+
+	return 0;
+}
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/kernel/entry.S arch/v850/kernel/entry.S
--- ../orig/linux-2.5.42uc1/arch/v850/kernel/entry.S	2002-10-16 10:45:54.000000000 +0900
+++ arch/v850/kernel/entry.S	2002-10-16 13:44:55.000000000 +0900
@@ -22,7 +22,7 @@
 #include <asm/irq.h>
 #include <asm/errno.h>
 
-#include "v850_defs.h"
+#include <asm/asm-consts.h>
 
 
 /* Make a slightly more convenient alias for C_SYMBOL_NAME.  */
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/kernel/v850_defs.c arch/v850/kernel/v850_defs.c
--- ../orig/linux-2.5.42uc1/arch/v850/kernel/v850_defs.c	2002-10-16 10:45:54.000000000 +0900
+++ arch/v850/kernel/v850_defs.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,58 +0,0 @@
-/*
- * This program is used to generate definitions needed by
- * assembly language modules.
- *
- * We use the technique used in the OSF Mach kernel code:
- * generate asm statements containing #defines,
- * compile this file to assembler, and then extract the
- * #defines from the assembly-language output.
- */
-
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <asm/irq.h>
-#include <asm/hardirq.h>
-#include <asm/errno.h>
-
-#define DEFINE(sym, val) \
-	asm volatile ("\n#define " #sym " %0" : : "i" (val))
-
-int main (void)
-{
-	/* offsets into the task struct */
-	DEFINE (TASK_STATE, offsetof (struct task_struct, state));
-	DEFINE (TASK_FLAGS, offsetof (struct task_struct, flags));
-	DEFINE (TASK_PTRACE, offsetof (struct task_struct, ptrace));
-	DEFINE (TASK_BLOCKED, offsetof (struct task_struct, blocked));
-	DEFINE (TASK_THREAD, offsetof (struct task_struct, thread));
-	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
-	DEFINE (TASK_MM, offsetof (struct task_struct, mm));
-	DEFINE (TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
-	DEFINE (TASK_PID, offsetof (struct task_struct, pid));
-
-	/* offsets into the kernel_stat struct */
-	DEFINE (STAT_IRQ, offsetof (struct kernel_stat, irqs));
-
-
-	/* signal defines */
-	DEFINE (SIGSEGV, SIGSEGV);
-	DEFINE (SEGV_MAPERR, SEGV_MAPERR);
-	DEFINE (SIGTRAP, SIGTRAP);
-	DEFINE (SIGCHLD, SIGCHLD);
-	DEFINE (SIGILL, SIGILL);
-	DEFINE (TRAP_TRACE, TRAP_TRACE);
-
-	/* ptrace flag bits */
-	DEFINE (PT_PTRACED, PT_PTRACED);
-	DEFINE (PT_DTRACE, PT_DTRACE);
-
-	/* error values */
-	DEFINE (ENOSYS, ENOSYS);
-
-	/* clone flag bits */
-	DEFINE (CLONE_VFORK, CLONE_VFORK);
-	DEFINE (CLONE_VM, CLONE_VM);
-
-	return 0;
-}
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/kernel/v850_defs.head arch/v850/kernel/v850_defs.head
--- ../orig/linux-2.5.42uc1/arch/v850/kernel/v850_defs.head	2002-10-16 10:45:54.000000000 +0900
+++ arch/v850/kernel/v850_defs.head	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-/*
- * WARNING! This file is automatically generated - DO NOT EDIT!
- */
-
-#define TS_MAGICKEY	0x5a5a5a5a
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/arch/v850/vmlinux.lds.S arch/v850/vmlinux.lds.S
--- ../orig/linux-2.5.42uc1/arch/v850/vmlinux.lds.S	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/vmlinux.lds.S	2002-10-16 13:30:43.000000000 +0900
@@ -0,0 +1,27 @@
+#include <linux/config.h>
+
+#ifdef CONFIG_V850E_SIM
+#include "sim.ld"
+#endif
+
+#ifdef CONFIG_V850E2_SIM85E2C
+#include "sim85e2c.ld"
+#endif
+
+#ifdef CONFIG_V850E2_FPGA85E2C
+#include "fpga85e2c.ld"
+#endif
+
+#ifdef CONFIG_V850E2_ANNA
+#include "anna.ld"
+#endif
+
+#ifdef CONFIG_RTE_CB_MA1
+# ifdef CONFIG_ROM_KERNEL
+#  include "rte_ma1_cb-rom.ld"
+# elif CONFIG_RTE_CB_MA1_KSRAM
+#  include "rte_ma1_cb-ksram.ld"
+# else /* !CONFIG_ROM_KERNEL && !CONFIG_RTE_CB_MA1_KSRAM */
+#  include "rte_ma1_cb.ld"
+# endif /* CONFIG_ROM_KERNEL */
+#endif /* CONFIG_RTE_CB_MA1 */
diff -ruN -X../cludes ../orig/linux-2.5.42uc1/include/asm-v850/page.h include/asm-v850/page.h
--- ../orig/linux-2.5.42uc1/include/asm-v850/page.h	2002-10-16 10:45:57.000000000 +0900
+++ include/asm-v850/page.h	2002-10-16 11:53:42.000000000 +0900
@@ -21,6 +21,7 @@
 #define PAGE_SIZE       (1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~(PAGE_SIZE-1))
 
+
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. For archs with
  * no MMU this corresponds to the first free page in physical memory (aligned
@@ -30,11 +31,6 @@
 #define PAGE_OFFSET  0x0000000
 #endif
 
-/*
- * MAP_NR -- given an address, calculate the index of the page struct which
- * points to the address's page.
- */
-#define MAP_NR(addr) (((unsigned long)(addr) - PAGE_OFFSET) >> PAGE_SHIFT)
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -91,9 +87,11 @@
 
 #endif /* !__ASSEMBLY__ */
 
+
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
+
 #ifndef __ASSEMBLY__
 
 extern void __bug (void) __attribute__ ((noreturn));
@@ -116,18 +114,31 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define __pa(x)			__virt_to_phys ((unsigned long)(x))
-#define __va(x)			((void *)__phys_to_virt ((unsigned long)(x)))
 
 /* No current v850 processor has virtual memory.  */
 #define __virt_to_phys(addr)	(addr)
 #define __phys_to_virt(addr)	(addr)
 
-#define virt_to_page(kaddr) 	(mem_map + MAP_NR (kaddr))
+#define virt_to_pfn(kaddr)	(__virt_to_phys (kaddr) >> PAGE_SHIFT)
+#define pfn_to_virt(pfn)	__phys_to_virt ((pfn) << PAGE_SHIFT)
+
+#define MAP_NR(kaddr) \
+  (((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT)
+#define virt_to_page(kaddr)	(mem_map + MAP_NR (kaddr))
+#define page_to_virt(page) \
+  ((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
+
+#define pfn_to_page(pfn)	virt_to_page (pfn_to_virt (pfn))
+#define page_to_pfn(page)	virt_to_pfn (page_to_virt (page))
+
 #define	virt_addr_valid(kaddr)						\
   (((void *)(kaddr) >= (void *)PAGE_OFFSET) && MAP_NR (kaddr) < max_mapnr)
 
 
+#define __pa(x)		     __virt_to_phys ((unsigned long)(x))
+#define __va(x)		     ((void *)__phys_to_virt ((unsigned long)(x)))
+
+
 #endif /* KERNEL */
 
 #ifdef CONFIG_CONTIGUOUS_PAGE_ALLOC

--=-=-=



Thanks,

-Miles
-- 
Occam's razor split hairs so well, I bought the whole argument!

--=-=-=--
