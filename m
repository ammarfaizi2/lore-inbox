Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUBTMrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTMrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:16 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:34652 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261178AbUBTMqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:52 -0500
Date: Fri, 20 Feb 2004 13:46:35 +0100
Message-Id: <200402201246.i1KCkZoT004168@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 391] M68k offsets.h generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k offsets.h: Move arch/m68k/kernel/m68k_defs.h to include/asm/offsets.h and
use gen-asm-offsets framework (from Andreas Schwab and Ray Knight)

--- linux-2.6.3/arch/m68k/Makefile	2003-09-03 13:41:43.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/Makefile	2004-01-15 13:57:41.000000000 +0100
@@ -111,6 +111,14 @@
 	bzip2 -1c vmlinux >vmlinux.bz2
 endif
 
+prepare: include/asm-$(ARCH)/offsets.h
+CLEAN_FILES += include/asm-$(ARCH)/offsets.h
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
+	$(call filechk,gen-asm-offsets)
+
 archclean:
 	rm -f vmlinux.gz vmlinux.bz2
-	rm -f arch/m68k/kernel/m68k_defs.h arch/m68k/kernel/m68k_defs.d
--- linux-2.6.3/arch/m68k/fpsp040/skeleton.S	2002-11-05 10:09:41.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/fpsp040/skeleton.S	2004-01-29 12:44:08.000000000 +0100
@@ -40,7 +40,7 @@
 
 #include <linux/linkage.h>
 #include <asm/entry.h>
-#include "../kernel/m68k_defs.h"
+#include <asm/offsets.h>
 
 |SKELETON	idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- linux-2.6.3/arch/m68k/ifpsp060/iskeleton.S	2003-03-25 10:06:08.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/ifpsp060/iskeleton.S	2004-02-01 10:44:02.000000000 +0100
@@ -36,7 +36,7 @@
 
 #include <linux/linkage.h>
 #include <asm/entry.h>
-#include "../kernel/m68k_defs.h"
+#include <asm/offsets.h>
 
 
 |################################
--- linux-2.6.3/arch/m68k/kernel/Makefile	2003-08-24 09:48:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/Makefile	2004-01-15 13:57:41.000000000 +0100
@@ -16,20 +16,3 @@
 obj-$(CONFIG_MODULES)	+= module.o
 
 EXTRA_AFLAGS := -traditional
-
-$(obj)/head.o: $(obj)/head.S $(obj)/m68k_defs.h
-
-$(obj)/entry.o: $(obj)/entry.S $(obj)/m68k_defs.h
-
-$(obj)/sun3-head.o: $(obj)/sun3-head.S $(obj)/m68k_defs.h
-
-$(obj)/m68k_defs.h: $(src)/m68k_defs.c $(src)/m68k_defs.head
-	rm -f $(obj)/m68k_defs.d
-	SUNPRO_DEPENDENCIES="$(obj)/m68k_defs.d $(obj)/m68k_defs.h" \
-	$(CC) $(filter-out -MD,$(CFLAGS)) -S $(src)/m68k_defs.c -o \
-	$(obj)/m68k_defs.s
-	cp $(src)/m68k_defs.head $(obj)/m68k_defs.h
-	grep '^#define' $(obj)/m68k_defs.s >> $(obj)/m68k_defs.h
-	rm $(obj)/m68k_defs.s
--include $(obj)/m68k_defs.d
-
--- linux-2.6.3/arch/m68k/kernel/asm-offsets.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/kernel/asm-offsets.c	2004-01-06 15:41:27.000000000 +0100
@@ -0,0 +1,109 @@
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
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/amigahw.h>
+#include <linux/font.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+int main(void)
+{
+	/* offsets into the task struct */
+	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
+	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
+	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
+	DEFINE(TASK_WORK, offsetof(struct task_struct, thread.work));
+	DEFINE(TASK_NEEDRESCHED, offsetof(struct task_struct, thread.work.need_resched));
+	DEFINE(TASK_SYSCALL_TRACE, offsetof(struct task_struct, thread.work.syscall_trace));
+	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
+	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
+	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
+	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
+	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
+
+	/* offsets into the thread struct */
+	DEFINE(THREAD_KSP, offsetof(struct thread_struct, ksp));
+	DEFINE(THREAD_USP, offsetof(struct thread_struct, usp));
+	DEFINE(THREAD_SR, offsetof(struct thread_struct, sr));
+	DEFINE(THREAD_FS, offsetof(struct thread_struct, fs));
+	DEFINE(THREAD_CRP, offsetof(struct thread_struct, crp));
+	DEFINE(THREAD_ESP0, offsetof(struct thread_struct, esp0));
+	DEFINE(THREAD_FPREG, offsetof(struct thread_struct, fp));
+	DEFINE(THREAD_FPCNTL, offsetof(struct thread_struct, fpcntl));
+	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fpstate));
+
+	/* offsets into the pt_regs */
+	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
+	DEFINE(PT_ORIG_D0, offsetof(struct pt_regs, orig_d0));
+	DEFINE(PT_D1, offsetof(struct pt_regs, d1));
+	DEFINE(PT_D2, offsetof(struct pt_regs, d2));
+	DEFINE(PT_D3, offsetof(struct pt_regs, d3));
+	DEFINE(PT_D4, offsetof(struct pt_regs, d4));
+	DEFINE(PT_D5, offsetof(struct pt_regs, d5));
+	DEFINE(PT_A0, offsetof(struct pt_regs, a0));
+	DEFINE(PT_A1, offsetof(struct pt_regs, a1));
+	DEFINE(PT_A2, offsetof(struct pt_regs, a2));
+	DEFINE(PT_PC, offsetof(struct pt_regs, pc));
+	DEFINE(PT_SR, offsetof(struct pt_regs, sr));
+	/* bitfields are a bit difficult */
+	DEFINE(PT_VECTOR, offsetof(struct pt_regs, pc) + 4);
+
+	/* offsets into the irq_handler struct */
+	DEFINE(IRQ_HANDLER, offsetof(struct irq_node, handler));
+	DEFINE(IRQ_DEVID, offsetof(struct irq_node, dev_id));
+	DEFINE(IRQ_NEXT, offsetof(struct irq_node, next));
+
+	/* offsets into the kernel_stat struct */
+	DEFINE(STAT_IRQ, offsetof(struct kernel_stat, irqs));
+
+	/* offsets into the irq_cpustat_t struct */
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
+
+	/* offsets into the bi_record struct */
+	DEFINE(BIR_TAG, offsetof(struct bi_record, tag));
+	DEFINE(BIR_SIZE, offsetof(struct bi_record, size));
+	DEFINE(BIR_DATA, offsetof(struct bi_record, data));
+
+	/* offsets into font_desc (drivers/video/console/font.h) */
+	DEFINE(FONT_DESC_IDX, offsetof(struct font_desc, idx));
+	DEFINE(FONT_DESC_NAME, offsetof(struct font_desc, name));
+	DEFINE(FONT_DESC_WIDTH, offsetof(struct font_desc, width));
+	DEFINE(FONT_DESC_HEIGHT, offsetof(struct font_desc, height));
+	DEFINE(FONT_DESC_DATA, offsetof(struct font_desc, data));
+	DEFINE(FONT_DESC_PREF, offsetof(struct font_desc, pref));
+
+	/* signal defines */
+	DEFINE(SIGSEGV, SIGSEGV);
+	DEFINE(SEGV_MAPERR, SEGV_MAPERR);
+	DEFINE(SIGTRAP, SIGTRAP);
+	DEFINE(TRAP_TRACE, TRAP_TRACE);
+
+	/* offsets into the custom struct */
+	DEFINE(CUSTOMBASE, &custom);
+	DEFINE(C_INTENAR, offsetof(struct CUSTOM, intenar));
+	DEFINE(C_INTREQR, offsetof(struct CUSTOM, intreqr));
+	DEFINE(C_INTENA, offsetof(struct CUSTOM, intena));
+	DEFINE(C_INTREQ, offsetof(struct CUSTOM, intreq));
+	DEFINE(C_SERDATR, offsetof(struct CUSTOM, serdatr));
+	DEFINE(C_SERDAT, offsetof(struct CUSTOM, serdat));
+	DEFINE(C_SERPER, offsetof(struct CUSTOM, serper));
+	DEFINE(CIAABASE, &ciaa);
+	DEFINE(CIABBASE, &ciab);
+	DEFINE(C_PRA, offsetof(struct CIA, pra));
+	DEFINE(ZTWOBASE, zTwoBase);
+
+	return 0;
+}
--- linux-2.6.3/arch/m68k/kernel/entry.S	2003-07-29 18:18:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/entry.S	2004-01-15 13:57:41.000000000 +0100
@@ -42,7 +42,7 @@
 #include <asm/traps.h>
 #include <asm/unistd.h>
 
-#include "m68k_defs.h"
+#include <asm/offsets.h>
 
 .globl system_call, buserr, trap
 .globl resume, ret_from_exception
--- linux-2.6.3/arch/m68k/kernel/head.S	2003-10-19 16:22:23.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/head.S	2004-01-15 13:57:41.000000000 +0100
@@ -262,7 +262,7 @@
 #include <asm/entry.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
-#include "m68k_defs.h"
+#include <asm/offsets.h>
 
 #ifdef CONFIG_MAC
 
--- linux-2.6.3/arch/m68k/kernel/m68k_defs.c	2003-08-25 18:16:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/m68k_defs.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,109 +0,0 @@
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
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/amigahw.h>
-#include <linux/font.h>
-
-#define DEFINE(sym, val) \
-	asm volatile("\n#define " #sym " %c0" : : "i" (val))
-
-int main(void)
-{
-	/* offsets into the task struct */
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
-	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
-	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
-	DEFINE(TASK_WORK, offsetof(struct task_struct, thread.work));
-	DEFINE(TASK_NEEDRESCHED, offsetof(struct task_struct, thread.work.need_resched));
-	DEFINE(TASK_SYSCALL_TRACE, offsetof(struct task_struct, thread.work.syscall_trace));
-	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
-	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
-	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
-	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
-	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
-
-	/* offsets into the thread struct */
-	DEFINE(THREAD_KSP, offsetof(struct thread_struct, ksp));
-	DEFINE(THREAD_USP, offsetof(struct thread_struct, usp));
-	DEFINE(THREAD_SR, offsetof(struct thread_struct, sr));
-	DEFINE(THREAD_FS, offsetof(struct thread_struct, fs));
-	DEFINE(THREAD_CRP, offsetof(struct thread_struct, crp));
-	DEFINE(THREAD_ESP0, offsetof(struct thread_struct, esp0));
-	DEFINE(THREAD_FPREG, offsetof(struct thread_struct, fp));
-	DEFINE(THREAD_FPCNTL, offsetof(struct thread_struct, fpcntl));
-	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fpstate));
-
-	/* offsets into the pt_regs */
-	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
-	DEFINE(PT_ORIG_D0, offsetof(struct pt_regs, orig_d0));
-	DEFINE(PT_D1, offsetof(struct pt_regs, d1));
-	DEFINE(PT_D2, offsetof(struct pt_regs, d2));
-	DEFINE(PT_D3, offsetof(struct pt_regs, d3));
-	DEFINE(PT_D4, offsetof(struct pt_regs, d4));
-	DEFINE(PT_D5, offsetof(struct pt_regs, d5));
-	DEFINE(PT_A0, offsetof(struct pt_regs, a0));
-	DEFINE(PT_A1, offsetof(struct pt_regs, a1));
-	DEFINE(PT_A2, offsetof(struct pt_regs, a2));
-	DEFINE(PT_PC, offsetof(struct pt_regs, pc));
-	DEFINE(PT_SR, offsetof(struct pt_regs, sr));
-	/* bitfields are a bit difficult */
-	DEFINE(PT_VECTOR, offsetof(struct pt_regs, pc) + 4);
-
-	/* offsets into the irq_handler struct */
-	DEFINE(IRQ_HANDLER, offsetof(struct irq_node, handler));
-	DEFINE(IRQ_DEVID, offsetof(struct irq_node, dev_id));
-	DEFINE(IRQ_NEXT, offsetof(struct irq_node, next));
-
-	/* offsets into the kernel_stat struct */
-	DEFINE(STAT_IRQ, offsetof(struct kernel_stat, irqs));
-
-	/* offsets into the irq_cpustat_t struct */
-	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
-
-	/* offsets into the bi_record struct */
-	DEFINE(BIR_TAG, offsetof(struct bi_record, tag));
-	DEFINE(BIR_SIZE, offsetof(struct bi_record, size));
-	DEFINE(BIR_DATA, offsetof(struct bi_record, data));
-
-	/* offsets into font_desc (drivers/video/console/font.h) */
-	DEFINE(FONT_DESC_IDX, offsetof(struct font_desc, idx));
-	DEFINE(FONT_DESC_NAME, offsetof(struct font_desc, name));
-	DEFINE(FONT_DESC_WIDTH, offsetof(struct font_desc, width));
-	DEFINE(FONT_DESC_HEIGHT, offsetof(struct font_desc, height));
-	DEFINE(FONT_DESC_DATA, offsetof(struct font_desc, data));
-	DEFINE(FONT_DESC_PREF, offsetof(struct font_desc, pref));
-
-	/* signal defines */
-	DEFINE(SIGSEGV, SIGSEGV);
-	DEFINE(SEGV_MAPERR, SEGV_MAPERR);
-	DEFINE(SIGTRAP, SIGTRAP);
-	DEFINE(TRAP_TRACE, TRAP_TRACE);
-
-	/* offsets into the custom struct */
-	DEFINE(CUSTOMBASE, &custom);
-	DEFINE(C_INTENAR, offsetof(struct CUSTOM, intenar));
-	DEFINE(C_INTREQR, offsetof(struct CUSTOM, intreqr));
-	DEFINE(C_INTENA, offsetof(struct CUSTOM, intena));
-	DEFINE(C_INTREQ, offsetof(struct CUSTOM, intreq));
-	DEFINE(C_SERDATR, offsetof(struct CUSTOM, serdatr));
-	DEFINE(C_SERDAT, offsetof(struct CUSTOM, serdat));
-	DEFINE(C_SERPER, offsetof(struct CUSTOM, serper));
-	DEFINE(CIAABASE, &ciaa);
-	DEFINE(CIABBASE, &ciab);
-	DEFINE(C_PRA, offsetof(struct CIA, pra));
-	DEFINE(ZTWOBASE, zTwoBase);
-
-	return 0;
-}
--- linux-2.6.3/arch/m68k/kernel/m68k_defs.head	1998-03-21 20:04:04.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/kernel/m68k_defs.head	1970-01-01 01:00:00.000000000 +0100
@@ -1,5 +0,0 @@
-/*
- * WARNING! This file is automatically generated - DO NOT EDIT!
- */
-
-#define TS_MAGICKEY	0x5a5a5a5a
--- linux-2.6.3/arch/m68k/math-emu/fp_emu.h	2003-07-29 18:18:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/math-emu/fp_emu.h	2004-02-01 10:43:55.000000000 +0100
@@ -39,7 +39,7 @@
 #define _FP_EMU_H
 
 #ifdef __ASSEMBLY__
-#include "../kernel/m68k_defs.h"
+#include <asm/offsets.h>
 #endif
 #include <asm/math-emu.h>
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
