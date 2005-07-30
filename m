Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVG3EIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVG3EIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVG3EGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:06:50 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:42509 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262827AbVG3EGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:43 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44GSM005927@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 3/6 i386 dt-inline-cleanup
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0328 (UTC) FILETIME=[E47F7280:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 inline assembler cleanup.

This change encapsulates descriptor and task register management.  Also,
it is possible to improve assembler generation in two cases; savesegment
may store the value in a register instead of a memory location, which
allows GCC to optimize stack variables into registers, and MOV MEM, SEG
is always a 16-bit write to memory, making the casting in math-emu
unnecessary.

Diffs against: 2.6.13-rc4 + cpu-inline-cleanup

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/doublefault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/doublefault.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/doublefault.c	2005-07-29 11:49:18.000000000 -0700
@@ -20,7 +20,7 @@
 	struct Xgt_desc_struct gdt_desc = {0, 0};
 	unsigned long gdt, tss;
 
-	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
+	store_gdt(&gdt_desc);
 	gdt = gdt_desc.address;
 
 	printk("double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
Index: linux-2.6.13/arch/i386/kernel/efi.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/efi.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/efi.c	2005-07-29 11:49:18.000000000 -0700
@@ -104,8 +104,7 @@
 	local_flush_tlb();
 
 	cpu_gdt_descr[0].address = __pa(cpu_gdt_descr[0].address);
-	__asm__ __volatile__("lgdt %0":"=m"
-			    (*(struct Xgt_desc_struct *) __pa(&cpu_gdt_descr[0])));
+	load_gdt((struct Xgt_desc_struct *) __pa(&cpu_gdt_descr[0]));
 }
 
 static void efi_call_phys_epilog(void)
@@ -114,7 +113,7 @@
 
 	cpu_gdt_descr[0].address =
 		(unsigned long) __va(cpu_gdt_descr[0].address);
-	__asm__ __volatile__("lgdt %0":"=m"(cpu_gdt_descr));
+	load_gdt(&cpu_gdt_descr);
 	cr4 = read_cr4();
 
 	if (cr4 & X86_CR4_PSE) {
Index: linux-2.6.13/arch/i386/kernel/reboot.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/reboot.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/reboot.c	2005-07-29 11:49:18.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/dmi.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
+#include <asm/desc.h>
 #include "mach_reboot.h"
 #include <linux/reboot_fixups.h>
 
@@ -242,13 +243,13 @@
 
 	/* Set up the IDT for real mode. */
 
-	__asm__ __volatile__ ("lidt %0" : : "m" (real_mode_idt));
+	load_idt(&real_mode_idt);
 
 	/* Set up a GDT from which we can load segment descriptors for real
 	   mode.  The GDT is not used in real mode; it is just needed here to
 	   prepare the descriptors. */
 
-	__asm__ __volatile__ ("lgdt %0" : : "m" (real_mode_gdt));
+	load_gdt(&real_mode_gdt);
 
 	/* Load the data segment registers, and thus the descriptors ready for
 	   real mode.  The base address of each segment is 0x100, 16 times the
@@ -316,7 +317,7 @@
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
-			__asm__ __volatile__("lidt %0": :"m" (no_idt));
+			load_idt(&no_idt);
 			__asm__ __volatile__("int3");
 		}
 		/* rebooting needs to touch the page at absolute addr 0 */
@@ -325,7 +326,7 @@
 			mach_reboot_fixups(); /* for board specific fixups */
 			mach_reboot();
 			/* That didn't work - force a triple fault.. */
-			__asm__ __volatile__("lidt %0": :"m" (no_idt));
+			load_idt(&no_idt);
 			__asm__ __volatile__("int3");
 		}
 	}
Index: linux-2.6.13/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/signal.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/signal.c	2005-07-29 11:49:18.000000000 -0700
@@ -278,9 +278,9 @@
 	int tmp, err = 0;
 
 	tmp = 0;
-	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
+	savesegment(gs, tmp);
 	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
-	__asm__("movl %%fs,%0" : "=r"(tmp): "0"(tmp));
+	savesegment(fs, tmp);
 	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
 
 	err |= __put_user(regs->xes, (unsigned int __user *)&sc->es);
Index: linux-2.6.13/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/traps.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/traps.c	2005-07-29 11:49:18.000000000 -0700
@@ -1006,7 +1006,7 @@
 	 * it uses the read-only mapped virtual address.
 	 */
 	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
+	load_idt(&idt_descr);
 }
 #endif
 
Index: linux-2.6.13/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/vm86.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/vm86.c	2005-07-29 11:49:18.000000000 -0700
@@ -294,8 +294,8 @@
  */
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
-	asm volatile("mov %%fs,%0":"=m" (tsk->thread.saved_fs));
-	asm volatile("mov %%gs,%0":"=m" (tsk->thread.saved_gs));
+	savesegment(fs, tsk->thread.saved_fs);
+	savesegment(gs, tsk->thread.saved_gs);
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
Index: linux-2.6.13/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/common.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/common.c	2005-07-29 11:49:18.000000000 -0700
@@ -613,8 +613,8 @@
 	memcpy(thread->tls_array, &per_cpu(cpu_gdt_table, cpu),
 		GDT_ENTRY_TLS_ENTRIES * 8);
 
-	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
+	load_gdt(&cpu_gdt_descr[cpu]);
+	load_idt(&idt_descr);
 
 	/*
 	 * Delete NT
Index: linux-2.6.13/arch/i386/math-emu/get_address.c
===================================================================
--- linux-2.6.13.orig/arch/i386/math-emu/get_address.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/math-emu/get_address.c	2005-07-29 11:49:18.000000000 -0700
@@ -155,7 +155,6 @@
 { 
   struct desc_struct descriptor;
   unsigned long base_address, limit, address, seg_top;
-  unsigned short selector;
 
   segment--;
 
@@ -173,17 +172,11 @@
       /* fs and gs aren't used by the kernel, so they still have their
 	 user-space values. */
     case PREFIX_FS_-1:
-      /* The cast is needed here to get gcc 2.8.0 to use a 16 bit register
-	 in the assembler statement. */
-
-      __asm__("mov %%fs,%0":"=r" (selector));
-      addr->selector = selector;
+      /* N.B. - movl %seg, mem is a 2 byte write regardless of prefix */
+      savesegment(fs, addr->selector);
       break;
     case PREFIX_GS_-1:
-      /* The cast is needed here to get gcc 2.8.0 to use a 16 bit register
-	 in the assembler statement. */
-      __asm__("mov %%gs,%0":"=r" (selector));
-      addr->selector = selector;
+      savesegment(gs, addr->selector);
       break;
     default:
       addr->selector = PM_REG_(segment);
Index: linux-2.6.13/arch/i386/power/cpu.c
===================================================================
--- linux-2.6.13.orig/arch/i386/power/cpu.c	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/arch/i386/power/cpu.c	2005-07-29 11:49:18.000000000 -0700
@@ -42,17 +42,17 @@
 	/*
 	 * descriptor tables
 	 */
-	asm volatile ("sgdt %0" : "=m" (ctxt->gdt_limit));
-	asm volatile ("sidt %0" : "=m" (ctxt->idt_limit));
-	asm volatile ("str %0"  : "=m" (ctxt->tr));
+ 	store_gdt(&ctxt->gdt_limit);
+ 	store_idt(&ctxt->idt_limit);
+ 	store_tr(ctxt->tr);
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
-	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
-	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
-	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
+ 	savesegment(es, ctxt->es);
+ 	savesegment(fs, ctxt->fs);
+ 	savesegment(gs, ctxt->gs);
+ 	savesegment(ss, ctxt->ss);
 
 	/*
 	 * control registers 
@@ -118,16 +118,16 @@
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
-	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
-	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
+ 	load_gdt(&ctxt->gdt_limit);
+ 	load_idt(&ctxt->idt_limit);
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %0, %%es" :: "r" (ctxt->es));
-	asm volatile ("movw %0, %%fs" :: "r" (ctxt->fs));
-	asm volatile ("movw %0, %%gs" :: "r" (ctxt->gs));
-	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
+ 	loadsegment(es, ctxt->es);
+ 	loadsegment(fs, ctxt->fs);
+ 	loadsegment(gs, ctxt->gs);
+ 	loadsegment(ss, ctxt->ss);
 
 	/*
 	 * sysenter MSRs
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-07-29 11:49:18.000000000 -0700
@@ -93,13 +93,13 @@
 		".align 4\n\t"			\
 		".long 1b,3b\n"			\
 		".previous"			\
-		: :"m" (value))
+		: :"rm" (value))
 
 /*
  * Save a segment register away
  */
 #define savesegment(seg, value) \
-	asm volatile("mov %%" #seg ",%0":"=m" (value))
+	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
 /*
  * Clear and set 'TS' bit respectively
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-07-29 11:49:12.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-07-29 11:49:18.000000000 -0700
@@ -30,6 +30,16 @@
 #define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
 
+#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
+#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
+
+#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
+#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
+#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+
 /*
  * This is the ldt that every process will get unless we need
  * something other than this.
