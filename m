Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSKLJkV>; Tue, 12 Nov 2002 04:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266430AbSKLJkV>; Tue, 12 Nov 2002 04:40:21 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:46328 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266425AbSKLJkK>; Tue, 12 Nov 2002 04:40:10 -0500
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.47-uc0 (MMU-less fixups)
References: <3DD06E49.8080309@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 12 Nov 2002 18:46:52 +0900
In-Reply-To: <3DD06E49.8080309@snapgear.com>
Message-ID: <buo7kfjyvar.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Here's a v850 update for linux-2.5.47-uc0:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.47-uc0-v850-20021112-dist.patch
Content-Description: linux-2.5.47-uc0-v850-20021112-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/Makefile arch/v850/Makefile
--- ../orig/linux-2.5.47-uc0/arch/v850/Makefile	2002-11-12 12:06:32.000000000 +0900
+++ arch/v850/Makefile	2002-11-12 14:21:34.000000000 +0900
@@ -22,7 +22,8 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
-LDFLAGS_BLOB := -I binary -O elf32-little -B v850e
+LDFLAGS_BLOB := -b binary --oformat elf32-little
+OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
 
 HEAD := $(arch_dir)/kernel/head.o $(arch_dir)/kernel/init_task.o
@@ -43,7 +44,7 @@
 root_fs_image.o: root_fs_image_force
 
 root_fs_image_force: $(ROOT_FS_IMAGE)
-	$(OBJCOPY) $(ARCHBLOBLFLAGS) --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
+	$(OBJCOPY) $(OBJCOPY_FLAGS_BLOB) --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
 endif
 
 
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/anna.c arch/v850/kernel/anna.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/anna.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/anna.c	2002-11-12 17:51:31.000000000 +0900
@@ -27,11 +27,14 @@
 #include "mach.h"
 
 
-/* SRAM and SDRAM are vaguely contiguous (with a hole in between; see
-   mach_reserve_bootmem for details), so just use both as one big area.  */
+/* SRAM and SDRAM are vaguely contiguous (with a big hole in between; see
+   mach_reserve_bootmem for details); use both as one big area.  */
 #define RAM_START 	SRAM_ADDR
 #define RAM_END		(SDRAM_ADDR + SDRAM_SIZE)
 
+/* The bits of this port are connected to an 8-LED bar-graph.  */
+#define LEDS_PORT	4
+
 
 static void anna_led_tick (void);
 
@@ -60,17 +63,11 @@
 
 void __init mach_setup (char **cmdline)
 {
-	printk (KERN_INFO
-		"CPU: %s\n"
-		"Platform: %s\n",
-		CPU_MODEL_LONG,
-		PLATFORM_LONG);
-
 #ifdef CONFIG_V850E_NB85E_UART_CONSOLE
 	nb85e_uart_cons_init (1);
 #endif
 
-	ANNA_PORT_PM (0) = 0;	/* Make all LED pins output pins.  */
+	ANNA_PORT_PM (LEDS_PORT) = 0;	/* Make all LED pins output pins.  */
 	mach_tick = anna_led_tick;
 }
 
@@ -138,7 +135,7 @@
 	disable_reset_guard ();
 #endif
 	local_irq_disable ();	/* Ignore all interrupts.  */
-	ANNA_PORT_IO(0) = 0xAA;	/* Note that we halted.  */
+	ANNA_PORT_IO(LEDS_PORT) = 0xAA;	/* Note that we halted.  */
 	for (;;)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
@@ -191,9 +188,9 @@
 
 			if (pos + dir <= max_pos) {
 				/* Each bit of port 0 has a LED. */
-				clear_bit (pos, &ANNA_PORT_IO(0));
+				clear_bit (pos, &ANNA_PORT_IO(LEDS_PORT));
 				pos += dir;
-				set_bit (pos, &ANNA_PORT_IO(0));
+				set_bit (pos, &ANNA_PORT_IO(LEDS_PORT));
 			}
 		}
 
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/entry.S arch/v850/kernel/entry.S
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/entry.S	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/entry.S	2002-11-12 17:51:31.000000000 +0900
@@ -657,6 +657,12 @@
 	shl	16, r6			// clear upper 16 bits
 	shr	20, r6			// shift back, and remove lower nibble
 	add	-8, r6			// remove bias for irqs
+
+	// If the IRQ index is negative, it's actually one of the exception
+	// traps below 0x80 (currently, the illegal instruction trap, and
+	// the `debug trap').  Handle these separately.
+	bn	exception
+
 	// Call the high-level interrupt handling code.
 	jarl	CSYM(handle_irq), lp
 	// fall through
@@ -665,6 +671,23 @@
    handlers, below).  */
 ret_from_irq:
 	RETURN(IRQ)
+
+exception:
+	mov	hilo(ret_from_irq), lp	// where the handler should return
+	
+	cmp	-2, r6
+	bne	1f
+	// illegal instruction exception
+	addi	SIGILL, r0, r6		// Arg 0: signal number
+	mov	CURRENT_TASK, r7	// Arg 1: task
+	jr	CSYM(force_sig)		// tail call
+
+1:	cmp	-1, r6
+	bne	bad_trap_wrapper
+	// `dbtrap' exception
+	movea	PTO, sp, r6		// Arg 0: user regs
+	jr	CSYM(debug_trap)	// tail call
+
 END(irq)
 
 
@@ -692,44 +715,7 @@
 	jarl	CSYM(handle_irq), lp
 
 	RETURN(NMI)
-END(nmi0)
-
-
-/*
- * Illegal instruction trap.
- *
- * The stack-pointer (r3) should have already been saved to the memory
- * location ENTRY_SP (the reason for this is that the interrupt vectors may be
- * beyond a 22-bit signed offset jump from the actual interrupt handler, and
- * this allows them to save the stack-pointer and use that register to do an
- * indirect jump).
- */
-G_ENTRY(illegal_instruction):
-	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers. 
-	ei
-	addi	SIGILL, r0, r6		// Arg 0: signal number
-	mov	CURRENT_TASK, r7	// Arg 1: task
-	mov	hilo(ret_from_irq), lp	// where the handler should return
-	jr	CSYM(force_sig)
-END(illegal_instruction)
-
-
-/*
- * `Debug' trap
- *
- * The stack-pointer (r3) should have already been saved to the memory
- * location ENTRY_SP (the reason for this is that the interrupt vectors may be
- * beyond a 22-bit signed offset jump from the actual interrupt handler, and
- * this allows them to save the stack-pointer and use that register to do an
- * indirect jump).
- */
-G_ENTRY(dbtrap):
-	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers. 
-	ei
-	movea	PTO, sp, r6		// Arg 0: user regs
-	mov	hilo(ret_from_irq), lp	// where the handler should return
-	jr	CSYM(debug_trap)
-END(dbtrap)
+END(nmi)
 
 
 /*
@@ -771,8 +757,7 @@
 	.data
 
 	.align 4
-	.globl CSYM(trap_table)
-CSYM(trap_table):
+C_DATA(trap_table):
 	.long bad_trap_wrapper		// trap 0, doesn't use trap table. 
 	.long syscall_long		// trap 1, `long' syscall. 
 	.long bad_trap_wrapper
@@ -789,13 +774,13 @@
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
+C_END(trap_table)
 
 
 	.section .rodata
 	
 	.align 4
-	.globl CSYM(sys_call_table)
-CSYM(sys_call_table):
+C_DATA(sys_call_table):
 	.long CSYM(sys_ni_syscall)	// 0  -  old "setup()" system call
 	.long CSYM(sys_exit)
 	.long sys_fork_wrapper
@@ -1003,3 +988,4 @@
 	.long CSYM(sys_ni_syscall)	// sys_madvise
 
 	.space (NR_syscalls-205)*4
+C_END(sys_call_table)
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/fpga85e2c.c arch/v850/kernel/fpga85e2c.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/fpga85e2c.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/fpga85e2c.c	2002-11-12 17:51:31.000000000 +0900
@@ -73,8 +73,6 @@
 
 void __init mach_setup (char **cmdline)
 {
-	printk (KERN_INFO "CPU: NEC V850E2 (NA85E2C FPGA implementation)\n");
-
 	memcons_setup ();
 
 	/* Setup up NMI0 to copy the registers to a known memory location.
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/gbus_int.c arch/v850/kernel/gbus_int.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/gbus_int.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/gbus_int.c	2002-11-12 17:51:31.000000000 +0900
@@ -72,7 +72,7 @@
 }
 
 /* Disable all GBUS irqs.  */
-int gbus_int_disable_irqs ()
+void gbus_int_disable_irqs ()
 {
 	unsigned w, n;
 	for (w = 0; w < GBUS_INT_NUM_WORDS; w++)
@@ -183,7 +183,7 @@
 {
 	struct gbus_int_irq_init *init;
 	for (init = inits; init->name; init++) {
-		int i;
+		unsigned i;
 		struct hw_interrupt_type *hwit = hw_irq_types++;
 
 		hwit->typename = init->name;
@@ -200,7 +200,7 @@
 
 		/* Set the interrupt priorities.  */
 		for (i = 0; i < init->num; i++) {
-			int j;
+			unsigned j;
 			for (j = 0; j < NUM_USED_GINTS; j++)
 				if (used_gint[j].priority > init->priority)
 					break;
@@ -222,7 +222,7 @@
 
 /* GBUS interrupts themselves.  */
 
-__init struct gbus_int_irq_init gbus_irq_inits[] = {
+struct gbus_int_irq_init gbus_irq_inits[] __initdata = {
 	/* First set defaults.  */
 	{ "GBUS_INT", IRQ_GBUS_INT(0), IRQ_GBUS_INT_NUM, 1, 6},
 	{ 0 }
@@ -236,7 +236,7 @@
 /* Initialize GBUS interrupts.  */
 void __init gbus_int_init_irqs (void)
 {
-	int i;
+	unsigned i;
 
 	/* First initialize the shared gint interrupts.  */
 	for (i = 0; i < NUM_USED_GINTS; i++) {
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/head.S arch/v850/kernel/head.S
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/head.S	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/head.S	2002-11-12 17:51:31.000000000 +0900
@@ -118,4 +118,4 @@
 	// Start Linux kernel.
 	mov	hilo(CSYM(machine_halt)), lp
 	jr	CSYM(start_kernel)
-END(start)
+C_END(start)
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/intv.S arch/v850/kernel/intv.S
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/intv.S	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/intv.S	2002-11-12 17:51:31.000000000 +0900
@@ -52,10 +52,10 @@
 	JUMP_TO_HANDLER (trap, ENTRY_SP)	// TRAP1n
 
 	.balign	0x10
-	JUMP_TO_HANDLER (illegal_instruction, ENTRY_SP) // illegal insn trap
+	JUMP_TO_HANDLER (irq, ENTRY_SP)		// illegal insn trap
 
 	.balign	0x10
-	JUMP_TO_HANDLER (dbtrap, ENTRY_SP)	// DBTRAP insn
+	JUMP_TO_HANDLER (irq, ENTRY_SP)		// DBTRAP insn
 
 
 	/* Hardware interrupt vectors.  */
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/nb85e_intc.c arch/v850/kernel/nb85e_intc.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/nb85e_intc.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/nb85e_intc.c	2002-11-12 17:51:31.000000000 +0900
@@ -33,7 +33,7 @@
 {
 	struct nb85e_intc_irq_init *init;
 	for (init = inits; init->name; init++) {
-		int i;
+		unsigned i;
 		struct hw_interrupt_type *hwit = hw_irq_types++;
 
 		hwit->typename = init->name;
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/nb85e_utils.c arch/v850/kernel/nb85e_utils.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/nb85e_utils.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/nb85e_utils.c	2002-11-12 17:51:31.000000000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/nb85e_utils.h -- Utility functions associated with
  *	the NB85E cpu core
  *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02  NEC Corporation
+ *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -40,7 +40,7 @@
 	/* Find the lowest clock divider setting that can represent RATE.  */
 	for (_divlog2 = min_divlog2; _divlog2 <= max_divlog2; _divlog2++) {
 		/* Minimum interrupt rate possible using this divider.  */
-		int min_int_rate
+		unsigned min_int_rate
 			= (base_freq >> _divlog2) >> counter_size;
 
 		if (min_int_rate <= rate) {
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_cb.c arch/v850/kernel/rte_cb.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_cb.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/rte_cb.c	2002-11-12 17:51:31.000000000 +0900
@@ -60,25 +60,11 @@
 
 void __init mach_setup (char **cmdline)
 {
-	printk (KERN_INFO
-		"CPU: %s\n"
-		"Platform: %s%s\n",
-		CPU_MODEL_LONG,
-		PLATFORM_LONG,
-#ifdef CONFIG_ROM_KERNEL
-		""
-#elif defined (CONFIG_RTE_CB_MULTI)
-		" (with Multi ROM monitor)"
-#else
-		" (with ROM monitor)"
-#endif		
-		);
-
 	/* Probe for Mother-A, and print a message if we find it.  */
-	*(volatile long *)MB_A_SRAM_ADDR = 0xDEADBEEF;
-	if (*(volatile long *)MB_A_SRAM_ADDR == 0xDEADBEEF) {
-		*(volatile long *)MB_A_SRAM_ADDR = 0x12345678;
-		if (*(volatile long *)MB_A_SRAM_ADDR == 0x12345678)
+	*(volatile unsigned long *)MB_A_SRAM_ADDR = 0xDEADBEEF;
+	if (*(volatile unsigned long *)MB_A_SRAM_ADDR == 0xDEADBEEF) {
+		*(volatile unsigned long *)MB_A_SRAM_ADDR = 0x12345678;
+		if (*(volatile unsigned long *)MB_A_SRAM_ADDR == 0x12345678)
 			printk (KERN_INFO
 				"          NEC SolutionGear/Midas lab"
 				" RTE-MOTHER-A motherboard\n");
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_cb_leds.c arch/v850/kernel/rte_cb_leds.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_cb_leds.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/rte_cb_leds.c	2002-11-12 17:51:31.000000000 +0900
@@ -109,10 +109,12 @@
 	else if (whence == 2)
 		offs += LED_NUM_DIGITS; /* end-relative */
 
-	if (offs >= 0 && offs <= LED_NUM_DIGITS)
-		file->f_pos = offs;
-	else
+	if (offs < 0 || offs > LED_NUM_DIGITS)
 		return -EINVAL;
+
+	file->f_pos = offs;
+
+	return 0;
 }
 
 static struct file_operations leds_fops = {
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_mb_a_pci.c arch/v850/kernel/rte_mb_a_pci.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/rte_mb_a_pci.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/rte_mb_a_pci.c	2002-11-12 17:51:31.000000000 +0900
@@ -239,7 +239,7 @@
 	struct resource *r;
 
 	pci_for_each_dev (dev) {
-		int di_num;
+		unsigned di_num;
 		unsigned class = dev->class >> 8;
 
 		if (class && class != PCI_CLASS_BRIDGE_HOST) {
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/setup.c arch/v850/kernel/setup.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/setup.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/setup.c	2002-11-12 17:51:32.000000000 +0900
@@ -78,6 +78,9 @@
 	/* ... and tell the kernel about it.  */
 	init_mem_alloc (ram_start, ram_len);
 
+	printk (KERN_INFO "CPU: %s\nPlatform: %s\n",
+		CPU_MODEL_LONG, PLATFORM_LONG);
+
 	/* do machine-specific setups.  */
 	mach_setup (cmdline);
 
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/signal.c arch/v850/kernel/signal.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/signal.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/signal.c	2002-11-12 17:51:32.000000000 +0900
@@ -512,9 +512,10 @@
 	/* Did we come from a system call? */
 	if (PT_REGS_SYSCALL (regs)) {
 		/* Restart the system call - no handlers present */
-		if (regs->gpr[GPR_RVAL] == -ERESTARTNOHAND ||
-		    regs->gpr[GPR_RVAL] == -ERESTARTSYS ||
-		    regs->gpr[GPR_RVAL] == -ERESTARTNOINTR) {
+		if (regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTNOHAND ||
+		    regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTSYS ||
+		    regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTNOINTR)
+		{
 			regs->gpr[12] = PT_REGS_SYSCALL (regs);
 			regs->pc -= 4; /* Size of `trap 0' insn.  */
 		}
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/sim.c arch/v850/kernel/sim.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/sim.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/sim.c	2002-11-12 17:51:32.000000000 +0900
@@ -42,8 +42,6 @@
 	const char *err;
 	unsigned long root_dev_addr, root_dev_len;
 
-	printk (KERN_INFO "CPU: NEC V850E (GDB simulator)\n");
-
 	simcons_setup ();
 
 	printk (KERN_INFO "Reading root filesystem: %s", ROOT_FS);
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/sim85e2c.c arch/v850/kernel/sim85e2c.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/sim85e2c.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/sim85e2c.c	2002-11-12 17:51:32.000000000 +0900
@@ -79,8 +79,6 @@
 
 void __init mach_setup (char **cmdline)
 {
-	printk (KERN_INFO "CPU: NEC V850E2 (sim85e2c simulator)\n");
-
 	memcons_setup ();
 }
 
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/kernel/simcons.c arch/v850/kernel/simcons.c
--- ../orig/linux-2.5.47-uc0/arch/v850/kernel/simcons.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/simcons.c	2002-11-12 17:51:32.000000000 +0900
@@ -154,5 +154,5 @@
 {
 	V850_SIM_SYSCALL (make_raw, 0);
 	register_console (&simcons);
-	printk (KERN_INFO "Console: GDB/v850e simulator stdio\n");
+	printk (KERN_INFO "Console: GDB V850E simulator stdio\n");
 }
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/arch/v850/rte_ma1_cb.ld arch/v850/rte_ma1_cb.ld
--- ../orig/linux-2.5.47-uc0/arch/v850/rte_ma1_cb.ld	2002-11-12 12:06:32.000000000 +0900
+++ arch/v850/rte_ma1_cb.ld	2002-11-12 17:51:31.000000000 +0900
@@ -105,8 +105,8 @@
 		___initramfs_end = . ;
 	} > SDRAM
 
-	/* This provides address at which the interrupt vectors are
-	   initially loaded by the loader.  */
+	/* The address at which the interrupt vectors are initially
+	   loaded by the loader.  */
 	__intv_load_start = ALIGN (0x10) ;
 
 	/* Interrupt vector space.  Because we're using the monitor
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/anna.h include/asm-v850/anna.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/anna.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/anna.h	2002-11-12 17:51:32.000000000 +0900
@@ -127,6 +127,22 @@
 				     unsigned cflags, unsigned baud);
 #endif
 
+/* This board supports RTS/CTS for the on-chip UART, but only for channel 1. */
+
+/* CTS for UART channel 1 is pin P37 (bit 7 of port 3).  */
+#define NB85E_UART_CTS(chan)	((chan) == 1 ? !(ANNA_PORT_IO(3) & 0x80) : 1)
+/* RTS for UART channel 1 is pin P07 (bit 7 of port 0).  */
+#define NB85E_UART_SET_RTS(chan, val)					      \
+   do {									      \
+	   if (chan == 1) {						      \
+		   unsigned old = ANNA_PORT_IO(0); 			      \
+		   if (val)						      \
+			   ANNA_PORT_IO(0) = old & ~0x80;		      \
+		   else							      \
+			   ANNA_PORT_IO(0) = old | 0x80;		      \
+	   }								      \
+   } while (0)
+
 
 /* Timer C details.  */
 #define NB85E_TIMER_C_BASE_ADDR		0xFFFFF600
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/asm.h include/asm-v850/asm.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/asm.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/asm.h	2002-11-12 17:51:32.000000000 +0900
@@ -16,6 +16,10 @@
    .globl name;								      \
    .type  name,@function;						      \
    name
+#define G_DATA(name)							      \
+   .globl name;								      \
+   .type  name,@object;							      \
+   name
 #define END(name)							      \
    .size  name,.-name
 
@@ -23,3 +27,6 @@
    .align 4;								      \
    .type  name,@function;						      \
    name
+#define L_DATA(name)							      \
+   .type  name,@object;							      \
+   name
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/clinkage.h include/asm-v850/clinkage.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/clinkage.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/clinkage.h	2002-11-12 17:51:32.000000000 +0900
@@ -20,6 +20,7 @@
 #define C_SYMBOL_NAME(name) 	macrology_paste(_, name)
 #define C_SYMBOL_STRING(name)	macrology_stringify(C_SYMBOL_NAME(name))
 #define C_ENTRY(name)		G_ENTRY(C_SYMBOL_NAME(name))
+#define C_DATA(name)		G_DATA(C_SYMBOL_NAME(name))
 #define C_END(name)		END(C_SYMBOL_NAME(name))
 
 #endif /* __V850_CLINKAGE_H__ */
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/fpga85e2c.h include/asm-v850/fpga85e2c.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/fpga85e2c.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/fpga85e2c.h	2002-11-12 17:51:32.000000000 +0900
@@ -19,8 +19,11 @@
 #include <asm/clinkage.h>
 
 
-#define CPU_ARCH		"v850e2"
-#define CPU_MODEL		"FPGA NA85E2C/V850E2"
+#define CPU_ARCH 	"v850e2"
+#define CPU_MODEL	"v850e2/fpga85e2c"
+#define CPU_MODEL_LONG	"NEC V850E2/NA85E2C"
+#define PLATFORM	"fpga85e2c"
+#define PLATFORM_LONG	"NA85E2C FPGA implementation"
 
 
 /* `external ram'.  */
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/gbus_int.h include/asm-v850/gbus_int.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/gbus_int.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/gbus_int.h	2002-11-12 17:51:32.000000000 +0900
@@ -65,7 +65,7 @@
 /* Return true if interrupt handling for interrupt IRQ is enabled.  */
 extern int gbus_int_irq_enabled (unsigned irq);
 /* Disable all GBUS irqs.  */
-extern int gbus_int_disable_irqs (void);
+extern void gbus_int_disable_irqs (void);
 /* Clear any pending interrupts for IRQ.  */
 extern void gbus_int_clear_pending_irq (unsigned irq);
 /* Return true if interrupt IRQ is pending (but disabled).  */
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/processor.h include/asm-v850/processor.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/processor.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/processor.h	2002-11-12 14:24:51.000000000 +0900
@@ -30,6 +30,12 @@
  */
 #define TASK_SIZE	(0xFFFFFFFF)
 
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.  We won't be using it.
+ */
+#define TASK_UNMAPPED_BASE	0
+
 
 #ifndef __ASSEMBLY__
 
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/sim.h include/asm-v850/sim.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/sim.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/sim.h	2002-11-12 17:51:32.000000000 +0900
@@ -16,7 +16,10 @@
 
 
 #define CPU_ARCH		"v850e"
-#define CPU_MODEL		"GDB/v850e simulator"
+#define CPU_MODEL		"v850e"
+#define CPU_MODEL_LONG		"NEC V850E"
+#define PLATFORM		"gdb/v850e"
+#define PLATFORM_LONG		"GDB V850E simulator"
 
 
 /* We use a wierd value for RAM, not just 0, for testing purposes.
diff -ruN -X../cludes ../orig/linux-2.5.47-uc0/include/asm-v850/sim85e2c.h include/asm-v850/sim85e2c.h
--- ../orig/linux-2.5.47-uc0/include/asm-v850/sim85e2c.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/sim85e2c.h	2002-11-12 17:51:32.000000000 +0900
@@ -16,8 +16,11 @@
 #define __V850_SIM85E2C_H__
 
 
-#define CPU_ARCH		"v850e2"
-#define CPU_MODEL		"sim85e2c simulator"
+#define CPU_ARCH 	"v850e2"
+#define CPU_MODEL	"v850e2"
+#define CPU_MODEL_LONG	"NEC V850E2"
+#define PLATFORM	"sim85e2c"
+#define PLATFORM_LONG	"SIM85E2C V850E2 simulator"
 
 
 /* Various memory areas supported by the simulator.

--=-=-=



Thanks,

-Miles
-- 
Is it true that nothing can be known?  If so how do we know this?  -Woody Allen

--=-=-=--
