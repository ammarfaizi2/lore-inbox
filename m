Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVKJQn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKJQn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVKJQnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:43:55 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22961 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751152AbVKJQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:43:54 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051110164340.20950.94903.sendpatchset@localhost.localdomain>
In-Reply-To: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
Subject: [PATCH,RFC 2.6.14 10/15] KGDB: ARM-specific changes
Date: Thu, 10 Nov 2005 11:42:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a backend, written by Deepak Saxena <dsaxena@plexity.net> and George
Davis <gdavis@mvista.com> as well as support for the TI OMAP boards, ADI
Coyote, PXA2xx, and ARM Versatile.  Geoff Levand <geoffrey.levand@am.sony.com>
Nicolas Pitre, and Manish Lachwani have contributed various fixups here as
well.  This should only require (on boards that don't have a custom uart)
registering the uart with KGDB to add any other boards, or using kgdboe it
should Just Work.

 arch/arm/kernel/Makefile              |    1 
 arch/arm/kernel/kgdb-jmp.S            |   30 ++++
 arch/arm/kernel/kgdb.c                |  208 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c               |    5 
 arch/arm/kernel/traps.c               |   11 +
 arch/arm/mach-ixp2000/core.c          |    5 
 arch/arm/mach-ixp2000/ixdp2x01.c      |    6 
 arch/arm/mach-ixp4xx/coyote-setup.c   |    5 
 arch/arm/mach-ixp4xx/ixdp425-setup.c  |   12 +
 arch/arm/mach-omap1/board-osk.c       |    2 
 arch/arm/mach-omap1/serial.c          |    4 
 arch/arm/mach-pxa/Makefile            |    1 
 arch/arm/mach-pxa/kgdb-serial.c       |   98 ++++++++++++++++
 arch/arm/mach-versatile/kgdb_serial.c |  121 +++++++++++++++++++
 arch/arm/mm/extable.c                 |    7 +
 drivers/serial/amba-pl011.c           |    2 
 include/asm-arm/kgdb.h                |   87 ++++++++++++++
 include/asm-arm/system.h              |   41 ++++++
 lib/Kconfig.debug                     |    2 
 19 files changed, 642 insertions(+), 6 deletions(-)

Index: linux-2.6.14/arch/arm/kernel/kgdb.c
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/arm/kernel/kgdb.c
@@ -0,0 +1,208 @@
+/*
+ * arch/arm/kernel/kgdb.c
+ *
+ * ARM KGDB support
+ *
+ * Copyright (c) 2002-2004 MontaVista Software, Inc
+ *
+ * Authors:  George Davis <davis_g@mvista.com>
+ *           Deepak Saxena <dsaxena@plexity.net>
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/personality.h>
+#include <linux/ptrace.h>
+#include <linux/elf.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm/traps.h>
+
+/* Make a local copy of the registers passed into the handler (bletch) */
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *kernel_regs)
+{
+	int regno;
+
+	/* Initialize all to zero (??) */
+	for (regno = 0; regno < GDB_MAX_REGS; regno++)
+		gdb_regs[regno] = 0;
+
+	gdb_regs[_R0] = kernel_regs->ARM_r0;
+	gdb_regs[_R1] = kernel_regs->ARM_r1;
+	gdb_regs[_R2] = kernel_regs->ARM_r2;
+	gdb_regs[_R3] = kernel_regs->ARM_r3;
+	gdb_regs[_R4] = kernel_regs->ARM_r4;
+	gdb_regs[_R5] = kernel_regs->ARM_r5;
+	gdb_regs[_R6] = kernel_regs->ARM_r6;
+	gdb_regs[_R7] = kernel_regs->ARM_r7;
+	gdb_regs[_R8] = kernel_regs->ARM_r8;
+	gdb_regs[_R9] = kernel_regs->ARM_r9;
+	gdb_regs[_R10] = kernel_regs->ARM_r10;
+	gdb_regs[_FP] = kernel_regs->ARM_fp;
+	gdb_regs[_IP] = kernel_regs->ARM_ip;
+	gdb_regs[_SP] = kernel_regs->ARM_sp;
+	gdb_regs[_LR] = kernel_regs->ARM_lr;
+	gdb_regs[_PC] = kernel_regs->ARM_pc;
+	gdb_regs[_CPSR] = kernel_regs->ARM_cpsr;
+}
+
+/* Copy local gdb registers back to kgdb regs, for later copy to kernel */
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *kernel_regs)
+{
+	kernel_regs->ARM_r0 = gdb_regs[_R0];
+	kernel_regs->ARM_r1 = gdb_regs[_R1];
+	kernel_regs->ARM_r2 = gdb_regs[_R2];
+	kernel_regs->ARM_r3 = gdb_regs[_R3];
+	kernel_regs->ARM_r4 = gdb_regs[_R4];
+	kernel_regs->ARM_r5 = gdb_regs[_R5];
+	kernel_regs->ARM_r6 = gdb_regs[_R6];
+	kernel_regs->ARM_r7 = gdb_regs[_R7];
+	kernel_regs->ARM_r8 = gdb_regs[_R8];
+	kernel_regs->ARM_r9 = gdb_regs[_R9];
+	kernel_regs->ARM_r10 = gdb_regs[_R10];
+	kernel_regs->ARM_fp = gdb_regs[_FP];
+	kernel_regs->ARM_ip = gdb_regs[_IP];
+	kernel_regs->ARM_sp = gdb_regs[_SP];
+	kernel_regs->ARM_lr = gdb_regs[_LR];
+	kernel_regs->ARM_pc = gdb_regs[_PC];
+	kernel_regs->ARM_cpsr = gdb_regs[GDB_MAX_REGS - 1];
+}
+
+static inline struct pt_regs *kgdb_get_user_regs(struct task_struct *task)
+{
+	return (struct pt_regs *)
+	    ((unsigned long)task->thread_info + THREAD_SIZE -
+	     8 - sizeof(struct pt_regs));
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
+				 struct task_struct *task)
+{
+	int regno;
+	struct pt_regs *thread_regs;
+
+	/* Just making sure... */
+	if (task == NULL)
+		return;
+
+	/* Initialize to zero */
+	for (regno = 0; regno < GDB_MAX_REGS; regno++)
+		gdb_regs[regno] = 0;
+
+	/* Otherwise, we have only some registers from switch_to() */
+	thread_regs = kgdb_get_user_regs(task);
+	gdb_regs[_R0] = thread_regs->ARM_r0;	/* Not really valid? */
+	gdb_regs[_R1] = thread_regs->ARM_r1;	/* "               " */
+	gdb_regs[_R2] = thread_regs->ARM_r2;	/* "               " */
+	gdb_regs[_R3] = thread_regs->ARM_r3;	/* "               " */
+	gdb_regs[_R4] = thread_regs->ARM_r4;
+	gdb_regs[_R5] = thread_regs->ARM_r5;
+	gdb_regs[_R6] = thread_regs->ARM_r6;
+	gdb_regs[_R7] = thread_regs->ARM_r7;
+	gdb_regs[_R8] = thread_regs->ARM_r8;
+	gdb_regs[_R9] = thread_regs->ARM_r9;
+	gdb_regs[_R10] = thread_regs->ARM_r10;
+	gdb_regs[_FP] = thread_regs->ARM_fp;
+	gdb_regs[_IP] = thread_regs->ARM_ip;
+	gdb_regs[_SP] = thread_regs->ARM_sp;
+	gdb_regs[_LR] = thread_regs->ARM_lr;
+	gdb_regs[_PC] = thread_regs->ARM_pc;
+	gdb_regs[_CPSR] = thread_regs->ARM_cpsr;
+}
+
+static int compiled_break;
+
+int kgdb_arch_handle_exception(int exception_vector, int signo,
+			       int err_code, char *remcom_in_buffer,
+			       char *remcom_out_buffer,
+			       struct pt_regs *linux_regs)
+{
+	long addr;
+	char *ptr;
+
+	switch (remcom_in_buffer[0]) {
+	case 'c':
+		kgdb_contthread = NULL;
+
+		/*
+		 * Try to read optional parameter, pc unchanged if no parm.
+		 * If this was a compiled breakpoint, we need to move
+		 * to the next instruction or we will just breakpoint
+		 * over and over again.
+		 */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->ARM_pc = addr;
+		} else if (compiled_break == 1) {
+			linux_regs->ARM_pc += 4;
+		}
+
+		compiled_break = 0;
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static int kgdb_brk_fn(struct pt_regs *regs, unsigned int instr)
+{
+	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+
+	return 0;
+}
+
+static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int instr)
+{
+	compiled_break = 1;
+	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+
+	return 0;
+}
+
+static struct undef_hook kgdb_brkpt_hook = {
+	.instr_mask = 0xffffffff,
+	.instr_val = KGDB_BREAKINST,
+	.fn = kgdb_brk_fn
+};
+
+static struct undef_hook kgdb_compiled_brkpt_hook = {
+	.instr_mask = 0xffffffff,
+	.instr_val = KGDB_COMPILED_BREAK,
+	.fn = kgdb_compiled_brk_fn
+};
+
+/*
+ * Register our undef instruction hooks with ARM undef core.
+ * We regsiter a hook specifically looking for the KGB break inst
+ * and we handle the normal undef case within the do_undefinstr
+ * handler.
+ */
+int kgdb_arch_init(void)
+{
+	register_undef_hook(&kgdb_brkpt_hook);
+	register_undef_hook(&kgdb_compiled_brkpt_hook);
+
+	return 0;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+#ifndef __ARMEB__
+	.gdb_bpt_instr = {0xfe, 0xde, 0xff, 0xe7}
+#else
+	.gdb_bpt_instr = {0xe7, 0xff, 0xde, 0xfe}
+#endif
+};
Index: linux-2.6.14/arch/arm/kernel/kgdb-jmp.S
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/arm/kernel/kgdb-jmp.S
@@ -0,0 +1,30 @@
+/*
+ * arch/arm/kernel/kgdb-jmp.S
+ *
+ * Trivial setjmp and longjmp procedures to support bus error recovery
+ * which may occur during kgdb memory read/write operations.
+ *
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *         source@mvista.com
+ *
+ * 2002-2005 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program as licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+#include <linux/linkage.h>
+
+ENTRY (kgdb_fault_setjmp)
+	/* Save registers */
+	stmia	r0, {r0-r14}
+	str	lr,[r0, #60]
+	mrs	r1,cpsr
+	str	r1,[r0,#64]
+	ldr	r1,[r0,#4]
+	mov	r0, #0
+	mov	pc,lr
+
+ENTRY (kgdb_fault_longjmp)
+	/* Restore registers */
+	mov	r1,#1
+	str	r1,[r0]
+	ldmia	r0,{r0-pc}^
Index: linux-2.6.14/arch/arm/kernel/Makefile
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/Makefile
+++ linux-2.6.14/arch/arm/kernel/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_KGDB)		+= kgdb.o kgdb-jmp.o
 
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
Index: linux-2.6.14/arch/arm/kernel/setup.c
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/setup.c
+++ linux-2.6.14/arch/arm/kernel/setup.c
@@ -785,6 +785,11 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 #endif
+
+#if	defined(CONFIG_KGDB)
+	extern void __init early_trap_init(void);
+	early_trap_init();
+#endif
 }
 
 
Index: linux-2.6.14/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/traps.c
+++ linux-2.6.14/arch/arm/kernel/traps.c
@@ -270,6 +270,7 @@ asmlinkage void do_undefinstr(struct pt_
 	unsigned int instr;
 	struct undef_hook *hook;
 	siginfo_t info;
+	mm_segment_t fs;
 	void __user *pc;
 
 	/*
@@ -279,12 +280,15 @@ asmlinkage void do_undefinstr(struct pt_
 	 */
 	regs->ARM_pc -= correction;
 
+	fs = get_fs();
+	set_fs(KERNEL_DS);
 	pc = (void __user *)instruction_pointer(regs);
 	if (thumb_mode(regs)) {
 		get_user(instr, (u16 __user *)pc);
 	} else {
 		get_user(instr, (u32 __user *)pc);
 	}
+	set_fs(fs);
 
 	spin_lock_irq(&undef_lock);
 	list_for_each_entry(hook, &undef_hook, node) {
@@ -670,6 +674,13 @@ EXPORT_SYMBOL(abort);
 
 void __init trap_init(void)
 {
+#if	defined(CONFIG_KGDB)
+	return;
+}
+
+void __init early_trap_init(void)
+{
+#endif
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
 	extern char __kuser_helper_start[], __kuser_helper_end[];
Index: linux-2.6.14/arch/arm/mach-ixp2000/core.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-ixp2000/core.c
+++ linux-2.6.14/arch/arm/mach-ixp2000/core.c
@@ -34,6 +34,7 @@
 #include <asm/system.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
+#include <asm/kgdb.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -144,6 +145,10 @@ void __init ixp2000_map_io(void)
 
 	iotable_init(ixp2000_io_desc, ARRAY_SIZE(ixp2000_io_desc));
 
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &ixp2000_serial_port);
+#endif
+
 	/* Set slowport to 8-bit mode.  */
 	ixp2000_reg_write(IXP2000_SLOWPORT_FRM, 1);
 }
Index: linux-2.6.14/arch/arm/mach-ixp2000/ixdp2x01.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-ixp2000/ixdp2x01.c
+++ linux-2.6.14/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -38,6 +38,7 @@
 #include <asm/system.h>
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
+#include <asm/kgdb.h>
 
 #include <asm/mach/pci.h>
 #include <asm/mach/map.h>
@@ -175,6 +176,11 @@ static void __init ixdp2x01_map_io(void)
 
 	early_serial_setup(&ixdp2x01_serial_ports[0]);
 	early_serial_setup(&ixdp2x01_serial_ports[1]);
+
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &ixdp2x01_serial_ports[0]);
+	kgdb8250_add_port(1, &ixdp2x01_serial_ports[1]);
+#endif
 }
 
 
Index: linux-2.6.14/arch/arm/mach-ixp4xx/coyote-setup.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-ixp4xx/coyote-setup.c
+++ linux-2.6.14/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -91,9 +91,12 @@ static void __init coyote_init(void)
 		coyote_uart_data[0].irq = IRQ_IXP4XX_UART1;
 	}
 
-
 	ixp4xx_sys_init();
 	platform_add_devices(coyote_devices, ARRAY_SIZE(coyote_devices));
+
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &coyote_serial_port);
+#endif
 }
 
 #ifdef CONFIG_ARCH_ADI_COYOTE
Index: linux-2.6.14/arch/arm/mach-ixp4xx/ixdp425-setup.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ linux-2.6.14/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -23,6 +23,7 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
+#include <asm/kgdb.h>
 
 static struct flash_platform_data ixdp425_flash_data = {
 	.map_name	= "cfi_probe",
@@ -77,7 +78,8 @@ static struct plat_serial8250_port ixdp4
 		.mapbase	= IXP4XX_UART1_BASE_PHYS,
 		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
+					UPF_SHARE_IRQ,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
 		.uartclk	= IXP4XX_UART_XTAL,
@@ -86,7 +88,8 @@ static struct plat_serial8250_port ixdp4
 		.mapbase	= IXP4XX_UART2_BASE_PHYS,
 		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
 		.irq		= IRQ_IXP4XX_UART1,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
+					UPF_SHARE_IRQ,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
 		.uartclk	= IXP4XX_UART_XTAL,
@@ -121,6 +124,11 @@ static void __init ixdp425_init(void)
 	}
 
 	platform_add_devices(ixdp425_devices, ARRAY_SIZE(ixdp425_devices));
+
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &ixdp425_serial_ports[0]);
+	kgdb8250_add_port(1, &ixdp425_serial_ports[1]);
+#endif
 }
 
 #ifdef CONFIG_ARCH_IXDP425
Index: linux-2.6.14/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-omap1/board-osk.c
+++ linux-2.6.14/arch/arm/mach-omap1/board-osk.c
@@ -46,7 +46,7 @@
 #include <asm/arch/tc.h>
 #include <asm/arch/common.h>
 
-static int __initdata osk_serial_ports[OMAP_MAX_NR_PORTS] = {1, 0, 0};
+static int __initdata osk_serial_ports[OMAP_MAX_NR_PORTS] = {1, 1, 1};
 
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
Index: linux-2.6.14/arch/arm/mach-omap1/serial.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-omap1/serial.c
+++ linux-2.6.14/arch/arm/mach-omap1/serial.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
+#include <linux/kgdb.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 
@@ -194,6 +195,9 @@ void __init omap_serial_init(int ports[O
 			break;
 		}
 		omap_serial_reset(&serial_platform_data[i]);
+#ifdef CONFIG_KGDB_8250
+		kgdb8250_add_platform_port(i, &serial_platform_data[i]);
+#endif
 	}
 }
 
Index: linux-2.6.14/arch/arm/mach-pxa/kgdb-serial.c
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/arm/mach-pxa/kgdb-serial.c
@@ -0,0 +1,98 @@
+/*
+ * linux/arch/arm/mach-pxa/kgdb-serial.c
+ *
+ * Provides low level kgdb serial support hooks for PXA2xx boards
+ *
+ * Author:	Nicolas Pitre
+ * Copyright:	(C) 2002-2005 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/serial_reg.h>
+#include <linux/kgdb.h>
+#include <asm/processor.h>
+#include <asm/hardware.h>
+#include <asm/arch/pxa-regs.h>
+
+#if   defined(CONFIG_KGDB_PXA_FFUART)
+
+#define UART		FFUART
+#define CKEN_UART	CKEN6_FFUART
+#define GPIO_RX_MD	GPIO34_FFRXD_MD
+#define GPIO_TX_MD	GPIO39_FFTXD_MD
+
+#elif defined(CONFIG_KGDB_PXA_BTUART)
+
+#define UART		BTUART
+#define CKEN_UART	CKEN7_BTUART
+#define GPIO_RX_MD	GPIO42_BTRXD_MD
+#define GPIO_TX_MD	GPIO43_BTTXD_MD
+
+#elif defined(CONFIG_KGDB_PXA_STUART)
+
+#define UART		STUART
+#define CKEN_UART	CKEN5_STUART
+#define GPIO_RX_MD	GPIO46_STRXD_MD
+#define GPIO_TX_MD	GPIO47_STTXD_MD
+
+#endif
+
+#define UART_BAUDRATE	(CONFIG_KGDB_BAUDRATE)
+
+static volatile unsigned long *port = (unsigned long *)&UART;
+
+static int kgdb_serial_init(void)
+{
+	pxa_set_cken(CKEN_UART, 1);
+	pxa_gpio_mode(GPIO_RX_MD);
+	pxa_gpio_mode(GPIO_TX_MD);
+
+	port[UART_IER] = 0;
+	port[UART_LCR] = LCR_DLAB;
+	port[UART_DLL] = ((921600 / UART_BAUDRATE) & 0xff);
+	port[UART_DLM] = ((921600 / UART_BAUDRATE) >> 8);
+	port[UART_LCR] = LCR_WLS1 | LCR_WLS0;
+	port[UART_MCR] = 0;
+	port[UART_IER] = IER_UUE;
+	port[UART_FCR] = FCR_ITL_16;
+
+	return 0;
+}
+
+static void kgdb_serial_putchar(int c)
+{
+	if (!(CKEN & CKEN_UART) || port[UART_IER] != IER_UUE)
+		kgdb_serial_init();
+	while (!(port[UART_LSR] & LSR_TDRQ))
+		cpu_relax();
+	port[UART_TX] = c;
+}
+
+static void kgdb_serial_flush(void)
+{
+	if ((CKEN & CKEN_UART) && (port[UART_IER] & IER_UUE))
+		while (!(port[UART_LSR] & LSR_TEMT))
+			cpu_relax();
+}
+
+static int kgdb_serial_getchar(void)
+{
+	unsigned char c;
+	if (!(CKEN & CKEN_UART) || port[UART_IER] != IER_UUE)
+		kgdb_serial_init();
+	while (!(port[UART_LSR] & UART_LSR_DR))
+		cpu_relax();
+	c = port[UART_RX];
+	return c;
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.init = kgdb_serial_init,
+	.write_char = kgdb_serial_putchar,
+	.flush = kgdb_serial_flush,
+	.read_char = kgdb_serial_getchar,
+};
Index: linux-2.6.14/arch/arm/mach-pxa/Makefile
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-pxa/Makefile
+++ linux-2.6.14/arch/arm/mach-pxa/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LEDS) += $(led-y)
 
 # Misc features
 obj-$(CONFIG_PM) += pm.o sleep.o
+obj-$(CONFIG_KGDB_PXA_SERIAL) += kgdb-serial.o
 
 ifeq ($(CONFIG_PXA27x),y)
 obj-$(CONFIG_PM) += standby.o
Index: linux-2.6.14/arch/arm/mach-versatile/kgdb_serial.c
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/arm/mach-versatile/kgdb_serial.c
@@ -0,0 +1,121 @@
+/*
+ * arch/arm/mach-versatile/kgdb_serial.c
+ *
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for KGDB on ARM Versatile.
+ */
+#include <linux/config.h>
+#include <linux/serial_reg.h>
+#include <linux/kgdb.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/hardware.h>
+#include <asm/hardware/amba_serial.h>
+#include <asm/arch-versatile/hardware.h>
+
+#define ARM_BAUD_38400		23
+/*
+ * Functions that will be used later
+ */
+#define UART_GET_INT_STATUS(p)	readb((p) + UART010_IIR)
+#define UART_GET_MIS(p)		readw((p) + UART011_MIS)
+#define UART_PUT_ICR(p, c)	writel((c), (p) + UART010_ICR)
+#define UART_GET_FR(p)		readb((p) + UART01x_FR)
+#define UART_GET_CHAR(p)	readb((p) + UART01x_DR)
+#define UART_PUT_CHAR(p, c)     writel((c), (p) + UART01x_DR)
+#define UART_GET_RSR(p)		readb((p) + UART01x_RSR)
+#define UART_GET_CR(p)		readb((p) + UART010_CR)
+#define UART_PUT_CR(p,c)        writel((c), (p) + UART010_CR)
+#define UART_GET_LCRL(p)	readb((p) + UART010_LCRL)
+#define UART_PUT_LCRL(p,c)	writel((c), (p) + UART010_LCRL)
+#define UART_GET_LCRM(p)        readb((p) + UART010_LCRM)
+#define UART_PUT_LCRM(p,c)	writel((c), (p) + UART010_LCRM)
+#define UART_GET_LCRH(p)	readb((p) + UART010_LCRH)
+#define UART_PUT_LCRH(p,c)	writel((c), (p) + UART010_LCRH)
+#define UART_RX_DATA(s)		(((s) & UART01x_FR_RXFE) == 0)
+#define UART_TX_READY(s)	(((s) & UART01x_FR_TXFF) == 0)
+#define UART_TX_EMPTY(p)	((UART_GET_FR(p) & UART01x_FR_TMSK) == 0)
+
+/*
+ * KGDB IRQ
+ */
+static int kgdb_irq = 12;
+static volatile unsigned char *port = NULL;
+
+static int kgdb_serial_init(void)
+{
+	int rate = ARM_BAUD_38400;
+
+	port = IO_ADDRESS(0x101F1000);
+	UART_PUT_CR(port, 0);
+
+	/* Set baud rate */
+	UART_PUT_LCRM(port, ((rate & 0xf00) >> 8));
+	UART_PUT_LCRL(port, (rate & 0xff));
+	UART_PUT_LCRH(port, UART01x_LCRH_WLEN_8 | UART01x_LCRH_FEN);
+	UART_PUT_CR(port, UART01x_CR_UARTEN);
+
+	return 0;
+}
+
+static void kgdb_serial_putchar(int ch)
+{
+	unsigned int status;
+
+	do {
+		status = UART_GET_FR(port);
+	} while (!UART_TX_READY(status));
+
+	UART_PUT_CHAR(port, ch);
+}
+
+static int kgdb_serial_getchar(void)
+{
+	unsigned int status;
+	int ch;
+
+	do {
+		status = UART_GET_FR(port);
+	} while (!UART_RX_DATA(status));
+	ch = UART_GET_CHAR(port);
+	return ch;
+}
+
+static struct uart_port kgdb_amba_port = {
+	.irq = 12,
+	.iobase = 0,
+	.iotype = UPIO_MEM,
+	.membase = (unsigned char *)IO_ADDRESS(0x101F1000),
+};
+
+static irqreturn_t kgdb_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int status = UART_GET_MIS(port);
+
+	if (irq != kgdb_irq)
+		return IRQ_NONE;
+
+	if (status & 0x40)
+		breakpoint();
+
+	return IRQ_HANDLED;
+}
+
+static void __init kgdb_hookup_irq(void)
+{
+	request_irq(kgdb_irq, kgdb_interrupt, SA_SHIRQ, "GDB-stub",
+		    &kgdb_amba_port);
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.init = kgdb_serial_init,
+	.write_char = kgdb_serial_putchar,
+	.read_char = kgdb_serial_getchar,
+	.late_init = kgdb_hookup_irq,
+};
Index: linux-2.6.14/arch/arm/mm/extable.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mm/extable.c
+++ linux-2.6.14/arch/arm/mm/extable.c
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mm/extable.c
  */
 #include <linux/module.h>
+#include <linux/kgdb.h>
 #include <asm/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
@@ -11,6 +12,12 @@ int fixup_exception(struct pt_regs *regs
 	fixup = search_exception_tables(instruction_pointer(regs));
 	if (fixup)
 		regs->ARM_pc = fixup->fixup;
+#ifdef CONFIG_KGDB
+	if (atomic_read(&debugger_active) && kgdb_may_fault)
+		/* Restore our previous state. */
+		kgdb_fault_longjmp(kgdb_fault_jmp_regs);
+		/* Not reached. */
+#endif
 
 	return fixup != NULL;
 }
Index: linux-2.6.14/drivers/serial/amba-pl011.c
===================================================================
--- linux-2.6.14.orig/drivers/serial/amba-pl011.c
+++ linux-2.6.14/drivers/serial/amba-pl011.c
@@ -350,7 +350,7 @@ static int pl011_startup(struct uart_por
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+	retval = request_irq(uap->port.irq, pl011_int, SA_SHIRQ, "uart-pl011", uap);
 	if (retval)
 		goto clk_dis;
 
Index: linux-2.6.14/include/asm-arm/kgdb.h
===================================================================
--- /dev/null
+++ linux-2.6.14/include/asm-arm/kgdb.h
@@ -0,0 +1,87 @@
+/*
+ * include/asm-arm/kgdb.h
+ *
+ * ARM KGDB support
+ *
+ * Author: Deepak Saxena <dsaxena@mvista.com>
+ *
+ * Copyright (C) 2002 MontaVista Software Inc.
+ *
+ */
+
+#ifndef __ASM_KGDB_H__
+#define __ASM_KGDB_H__
+
+#include <linux/config.h>
+#include <asm/ptrace.h>
+
+
+/*
+ * GDB assumes that we're a user process being debugged, so
+ * it will send us an SWI command to write into memory as the
+ * debug trap. When an SWI occurs, the next instruction addr is
+ * placed into R14_svc before jumping to the vector trap.
+ * This doesn't work for kernel debugging as we are already in SVC
+ * we would loose the kernel's LR, which is a bad thing. This
+ * is  bad thing.
+ *
+ * By doing this as an undefined instruction trap, we force a mode
+ * switch from SVC to UND mode, allowing us to save full kernel state.
+ *
+ * We also define a KGDB_COMPILED_BREAK which can be used to compile
+ * in breakpoints. This is important for things like sysrq-G and for
+ * the initial breakpoint from trap_init().
+ *
+ * Note to ARM HW designers: Add real trap support like SH && PPC to
+ * make our lives much much simpler. :)
+ */
+#define	BREAK_INSTR_SIZE		4
+#define GDB_BREAKINST                   0xef9f0001
+#define KGDB_BREAKINST                  0xe7ffdefe
+#define KGDB_COMPILED_BREAK             0xe7ffdeff
+#define CACHE_FLUSH_IS_SAFE		1
+
+#ifndef	__ASSEMBLY__
+
+#define	BREAKPOINT()			asm(".word 	0xe7ffdeff")
+
+
+extern void kgdb_handle_bus_error(void);
+extern int kgdb_fault_expected;
+
+/*
+ * From Amit S. Kale:
+ *
+ * In the register packet, words 0-15 are R0 to R10, FP, IP, SP, LR, PC. But
+ * Register 16 isn't cpsr. GDB passes CPSR in word 25. There are 9 words in
+ * between which are unused. Passing only 26 words to gdb is sufficient.
+ * GDB can figure out that floating point registers are not passed.
+ * GDB_MAX_REGS should be 26.
+ */
+#define	GDB_MAX_REGS		(26)
+
+#define	KGDB_MAX_NO_CPUS	1
+#define	BUFMAX			400
+#define	NUMREGBYTES		(GDB_MAX_REGS << 2)
+#define	NUMCRITREGBYTES		(32 << 2)
+
+#define	_R0		0
+#define	_R1		1
+#define	_R2		2
+#define	_R3		3
+#define	_R4		4
+#define	_R5		5
+#define	_R6		6
+#define	_R7		7
+#define	_R8		8
+#define	_R9		9
+#define	_R10		10
+#define	_FP		11
+#define	_IP		12
+#define	_SP		13
+#define	_LR		14
+#define	_PC		15
+#define	_CPSR		(GDB_MAX_REGS - 1)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_KGDB_H__ */
Index: linux-2.6.14/include/asm-arm/system.h
===================================================================
--- linux-2.6.14.orig/include/asm-arm/system.h
+++ linux-2.6.14/include/asm-arm/system.h
@@ -405,6 +405,47 @@ static inline unsigned long __xchg(unsig
 	return ret;
 }
 
+#define	__HAVE_ARCH_CMPXCHG	1
+
+#include <asm/types.h>
+
+static inline unsigned long __cmpxchg_u32(volatile int *m, unsigned long old,
+					unsigned long new)
+{
+	u32 retval;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	retval = *m;
+	if (retval == old)
+		*m = new;
+	local_irq_restore(flags);	/* implies memory barrier  */
+
+	return retval;
+}
+
+/* This function doesn't exist, so you'll get a linker error
+   if something tries to do an invalid cmpxchg().  */
+extern void __cmpxchg_called_with_bad_pointer(void);
+
+static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
+	unsigned long new, int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32(ptr, old, new);
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)
Index: linux-2.6.14/lib/Kconfig.debug
===================================================================
--- linux-2.6.14.orig/lib/Kconfig.debug
+++ linux-2.6.14/lib/Kconfig.debug
@@ -187,7 +187,7 @@ config WANT_EXTRA_DEBUG_INFORMATION
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
 	select WANT_EXTRA_DEBUG_INFORMATION
-	depends on DEBUG_KERNEL && (X86 || MIPS || (SUPERH && !SUPERH64) || IA64 || X86_64 || ((!SMP || BROKEN) && PPC32))
+	depends on DEBUG_KERNEL && (ARM || X86 || MIPS || (SUPERH && !SUPERH64) || IA64 || X86_64 || ((!SMP || BROKEN) && PPC32))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. It is strongly suggested that you enable

-- 
Tom
