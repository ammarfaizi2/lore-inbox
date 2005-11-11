Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVKKIgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVKKIgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVKKIgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:13 -0500
Received: from i121.durables.org ([64.81.244.121]:8142 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932237AbVKKIgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:05 -0500
Date: Fri, 11 Nov 2005 02:35:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <7.282480653@selenic.com>
Message-Id: <8.282480653@selenic.com>
Subject: [PATCH 7/15] misc: Make x86 doublefault handling optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds configurable support for doublefault reporting on x86

add/remove: 0/3 grow/shrink: 0/1 up/down: 0/-13048 (-13048)
function                                     old     new   delta
cpu_init                                     846     786     -60
doublefault_fn                               188       -    -188
doublefault_stack                           4096       -   -4096
doublefault_tss                             8704       -   -8704

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/arch/i386/kernel/Makefile
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/i386/kernel/Makefile	2005-11-09 11:19:46.000000000 -0800
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o i8237.o
+		quirks.o i8237.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
@@ -33,6 +33,7 @@ obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
+obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_AFLAGS   := -traditional
Index: 2.6.14-misc/arch/i386/kernel/cpu/common.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/cpu/common.c	2005-11-01 10:54:31.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/cpu/common.c	2005-11-09 11:19:46.000000000 -0800
@@ -628,8 +628,10 @@ void __devinit cpu_init(void)
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
+#ifdef CONFIG_DOUBLEFAULT
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
+#endif
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-01 10:54:33.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:19:46.000000000 -0800
@@ -315,6 +315,15 @@ config BUG
           option for embedded systems with no facilities for reporting errors.
           Just say Y.
 
+config DOUBLEFAULT
+	depends X86
+	default y if X86
+	bool "Enable doublefault exception handler" if EMBEDDED
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k.
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EMBEDDED
