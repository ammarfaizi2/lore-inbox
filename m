Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbTCJINR>; Mon, 10 Mar 2003 03:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbTCJINR>; Mon, 10 Mar 2003 03:13:17 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:28910 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262741AbTCJIND>; Mon, 10 Mar 2003 03:13:03 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Correct v850 support for RTE-NB85E-CB platform
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030310082338.C31203712@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 10 Mar 2003 17:23:38 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was previously some vestigial support for this platform, but it
didn't actually work (or compile).

diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/Makefile linux-2.5.64-moo/arch/v850/kernel/Makefile
--- linux-2.5.64-moo.orig/arch/v850/kernel/Makefile	2003-02-12 11:26:18.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/Makefile	2003-03-10 16:55:48.000000000 +0900
@@ -1,8 +1,8 @@
 #
 # arch/v850/kernel/Makefile
 #
-#  Copyright (C) 2001,02  NEC Corporation
-#  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+#  Copyright (C) 2001,02,03  NEC Electronics Corporation
+#  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
 #
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
@@ -15,8 +15,9 @@
 	 signal.o irq.o mach.o ptrace.o bug.o
 obj-$(CONFIG_MODULES)		+= module.o v850_ksyms.o
 # chip-specific code
-obj-$(CONFIG_V850E_MA1)		+= ma.o	nb85e_utils.o nb85e_timer_d.o
 obj-$(CONFIG_V850E_NB85E)	+= nb85e_intc.o
+obj-$(CONFIG_V850E_MA1)		+= ma.o nb85e_utils.o nb85e_timer_d.o
+obj-$(CONFIG_V850E_TEG)		+= teg.o nb85e_utils.o nb85e_timer_d.o
 obj-$(CONFIG_V850E2_ANNA)	+= anna.o nb85e_intc.o nb85e_utils.o nb85e_timer_d.o
 obj-$(CONFIG_V850E_AS85EP1)	+= as85ep1.o nb85e_intc.o nb85e_utils.o nb85e_timer_d.o
 # platform-specific code
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/gbus_int.c linux-2.5.64-moo/arch/v850/kernel/gbus_int.c
--- linux-2.5.64-moo.orig/arch/v850/kernel/gbus_int.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/gbus_int.c	2003-03-10 16:55:48.000000000 +0900
@@ -26,7 +26,9 @@
 /* For each GINT interrupt, how many GBUS interrupts are using it.  */
 static unsigned gint_num_active_irqs[NUM_GINTS] = { 0 };
 
-/* A table of GINTn interrupts we actually use.  */
+/* A table of GINTn interrupts we actually use.
+   Note that we don't use GINT0 because all the boards we support treat it
+   specially.  */
 struct used_gint {
 	unsigned gint;
 	unsigned priority;
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/rte_cb_multi.c linux-2.5.64-moo/arch/v850/kernel/rte_cb_multi.c
--- linux-2.5.64-moo.orig/arch/v850/kernel/rte_cb_multi.c	2003-03-05 13:07:37.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/rte_cb_multi.c	2003-03-10 16:55:48.000000000 +0900
@@ -16,22 +16,55 @@
 
 #include <asm/machdep.h>
 
+#define IRQ_ADDR(irq) (0x80 + (irq) * 0x10)
+
 /* A table of which interrupt vectors to install, since blindly
    installing all of them makes the debugger stop working.  This is a
    list of offsets in the interrupt vector area; each entry means to
    copy that particular 16-byte vector.  An entry less than zero ends
    the table.  */
 static long multi_intv_install_table[] = {
-	0x40, 0x50,		/* trap vectors */
+	/* Trap vectors */
+	0x40, 0x50,		
+
 #ifdef CONFIG_RTE_CB_MULTI_DBTRAP
-	0x60,			/* illegal insn / dbtrap */
+	/* Illegal insn / dbtrap.  These are used by multi, so only handle
+	   them if configured to do so.  */
+	0x60,
+#endif
+
+	/* GINT1 - GINT3 (note, not GINT0!) */
+	IRQ_ADDR (IRQ_GINT(1)),
+	IRQ_ADDR (IRQ_GINT(2)),
+	IRQ_ADDR (IRQ_GINT(3)),
+
+	/* Timer D interrupts (up to 4 timers) */
+	IRQ_ADDR (IRQ_INTCMD(0)),
+#if IRQ_INTCMD_NUM > 1
+	IRQ_ADDR (IRQ_INTCMD(1)),
+#if IRQ_INTCMD_NUM > 2
+	IRQ_ADDR (IRQ_INTCMD(2)),
+#if IRQ_INTCMD_NUM > 3
+	IRQ_ADDR (IRQ_INTCMD(3)),
+#endif
 #endif
-	/* Note -- illegal insn trap is used by the debugger.  */
-	0xD0, 0xE0, 0xF0,	/* GINT1 - GINT3 */
-	0x240, 0x250, 0x260, 0x270, /* timer D interrupts */
-	0x2D0, 0x2E0, 0x2F0,	/* UART channel 0 */
-	0x310, 0x320, 0x330,	/* UART channel 1 */
-	0x350, 0x360, 0x370,	/* UART channel 2 */
+#endif
+	
+	/* UART interrupts (up to 3 channels) */
+	IRQ_ADDR (IRQ_INTSER (0)), /* err */
+	IRQ_ADDR (IRQ_INTSR  (0)), /* rx */
+	IRQ_ADDR (IRQ_INTST  (0)), /* tx */
+#if IRQ_INTSR_NUM > 1
+	IRQ_ADDR (IRQ_INTSER (1)), /* err */
+	IRQ_ADDR (IRQ_INTSR  (1)), /* rx */
+	IRQ_ADDR (IRQ_INTST  (1)), /* tx */
+#if IRQ_INTSR_NUM > 2
+	IRQ_ADDR (IRQ_INTSER (2)), /* err */
+	IRQ_ADDR (IRQ_INTSR  (2)), /* rx */
+	IRQ_ADDR (IRQ_INTST  (2)), /* tx */
+#endif
+#endif
+
 	-1
 };
 
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/rte_ma1_cb.c linux-2.5.64-moo/arch/v850/kernel/rte_ma1_cb.c
--- linux-2.5.64-moo.orig/arch/v850/kernel/rte_ma1_cb.c	2003-03-05 13:07:37.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/rte_ma1_cb.c	2003-03-10 16:55:48.000000000 +0900
@@ -67,7 +67,7 @@
 	if (chan == 0) {
 		/* Put P42 & P43 in I/O port mode.  */
 		MA_PORT4_PMC &= ~0xC;
-		/* Make P42 and output, and P43 an input.  */
+		/* Make P42 an output, and P43 an input.  */
 		MA_PORT4_PM = (MA_PORT4_PM & ~0xC) | 0x8;
 	}
 
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/rte_nb85e_cb.c linux-2.5.64-moo/arch/v850/kernel/rte_nb85e_cb.c
--- linux-2.5.64-moo.orig/arch/v850/kernel/rte_nb85e_cb.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/rte_nb85e_cb.c	2003-03-10 16:56:48.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/rte_nb85e_cb.c -- Midas labs RTE-V850E/NB85E-CB board
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -29,7 +29,7 @@
 void __init mach_get_physical_ram (unsigned long *ram_start,
 				   unsigned long *ram_len)
 {
-	/* We just use SDRAM here; the kernel itself is in SRAM.  */
+	/* We just use SDRAM here.  */
 	*ram_start = SDRAM_ADDR;
 	*ram_len = SDRAM_SIZE;
 }
@@ -41,8 +41,10 @@
 	u32 root_fs_image_end = (u32)&_root_fs_image_end;
 
 	/* Reserve the memory used by the root filesystem image if it's
-	   in RAM.  */
-	if (root_fs_image_start >= RAM_START && root_fs_image_start < RAM_END)
+	   in SDRAM.  */
+	if (root_fs_image_end > root_fs_image_start
+	    && root_fs_image_start >= SDRAM_ADDR
+	    && root_fs_image_start < (SDRAM_ADDR + SDRAM_SIZE))
 		reserve_bootmem (root_fs_image_start,
 				 root_fs_image_end - root_fs_image_start);
 }
@@ -52,3 +54,24 @@
 	tv->tv_sec = 0;
 	tv->tv_nsec = 0;
 }
+
+/* Called before configuring an on-chip UART.  */
+void rte_nb85e_cb_uart_pre_configure (unsigned chan,
+				    unsigned cflags, unsigned baud)
+{
+	/* The RTE-NB85E-CB connects some general-purpose I/O pins on the
+	   CPU to the RTS/CTS lines the UART's serial connection, as follows:
+	   P00 = CTS (in), P01 = DSR (in), P02 = RTS (out), P03 = DTR (out). */
+
+	TEG_PORT0_PM = 0x03;	/* P00 and P01 inputs, P02 and P03 outputs */
+	TEG_PORT0_IO = 0x03;	/* Accept input */
+
+	/* Do pre-configuration for the actual UART.  */
+	teg_uart_pre_configure (chan, cflags, baud);
+}
+
+void __init mach_init_irqs (void)
+{
+	teg_init_irqs ();
+	rte_cb_init_irqs ();
+}
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/teg.c linux-2.5.64-moo/arch/v850/kernel/teg.c
--- linux-2.5.64-moo.orig/arch/v850/kernel/teg.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/teg.c	2003-03-10 16:55:48.000000000 +0900
@@ -0,0 +1,63 @@
+/*
+ * arch/v850/kernel/teg.c -- NB85E-TEG cpu chip
+ *
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/machdep.h>
+#include <asm/nb85e_timer_d.h>
+
+#include "mach.h"
+
+void __init mach_sched_init (struct irqaction *timer_action)
+{
+	/* Select timer interrupt instead of external pin.  */
+	TEG_ISS |= 0x1;
+	/* Start hardware timer.  */
+	nb85e_timer_d_configure (0, HZ);
+	/* Install timer interrupt handler.  */
+	setup_irq (IRQ_INTCMD(0), timer_action);
+}
+
+static struct nb85e_intc_irq_init irq_inits[] = {
+	{ "IRQ", 0,		NUM_CPU_IRQS,	1, 7 },
+	{ "CMD", IRQ_INTCMD(0),	IRQ_INTCMD_NUM,	1, 5 },
+	{ "SER", IRQ_INTSER(0),	IRQ_INTSER_NUM,	1, 3 },
+	{ "SR",	 IRQ_INTSR(0),	IRQ_INTSR_NUM,	1, 4 },
+	{ "ST",	 IRQ_INTST(0),	IRQ_INTST_NUM,	1, 5 },
+	{ 0 }
+};
+#define NUM_IRQ_INITS ((sizeof irq_inits / sizeof irq_inits[0]) - 1)
+
+static struct hw_interrupt_type hw_itypes[NUM_IRQ_INITS];
+
+/* Initialize MA chip interrupts.  */
+void __init teg_init_irqs (void)
+{
+	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+}
+
+/* Called before configuring an on-chip UART.  */
+void teg_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
+{
+	/* Enable UART I/O pins instead of external interrupt pins, and
+	   UART interrupts instead of external pin interrupts.  */
+	TEG_ISS |= 0x4E;
+}
diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/rte_nb85e_cb-multi.ld linux-2.5.64-moo/arch/v850/rte_nb85e_cb-multi.ld
--- linux-2.5.64-moo.orig/arch/v850/rte_nb85e_cb-multi.ld	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/rte_nb85e_cb-multi.ld	2003-03-10 16:55:48.000000000 +0900
@@ -0,0 +1,57 @@
+/* Linker script for the Midas labs RTE-NB85E-CB evaluation board
+   (CONFIG_RTE_CB_NB85E), with kernel in SDRAM, under Multi debugger.  */
+
+MEMORY {
+	/* 1MB of SRAM; we can't use the last 96KB, because it's used by
+	   the monitor scratch-RAM.  This memory is mirrored 4 times.  */
+	SRAM  : ORIGIN = 0x03C00000, LENGTH = 0x000E8000
+	/* Monitor scratch RAM; only the interrupt vectors should go here.  */
+	MRAM  : ORIGIN = 0x03CE8000, LENGTH = 0x00018000
+	/* 16MB of SDRAM.  */
+	SDRAM : ORIGIN = 0x01000000, LENGTH = 0x01000000
+}
+
+#ifdef CONFIG_RTE_CB_NB85E_KSRAM
+# define KRAM SRAM
+#else
+# define KRAM SDRAM
+#endif
+
+SECTIONS {
+	/* We can't use RAMK_KRAM_CONTENTS because that puts the whole
+	   kernel in a single ELF segment, and the Multi debugger (which
+	   we use to load the kernel) appears to have bizarre problems
+	   dealing with it.  */
+
+	.text : {
+		__kram_start = . ;
+		TEXT_CONTENTS
+	} > KRAM
+
+	.data : {
+		DATA_CONTENTS
+		BSS_CONTENTS
+		RAMK_INIT_CONTENTS
+		__kram_end = . ;
+		BOOTMAP_CONTENTS
+
+		/* The address at which the interrupt vectors are initially
+		   loaded by the loader.  We can't load the interrupt vectors
+		   directly into their target location, because the monitor
+		   ROM for the GHS Multi debugger barfs if we try.
+		   Unfortunately, Multi also doesn't deal correctly with ELF
+		   sections where the LMA and VMA differ (it just ignores the
+		   LMA), so we can't use that feature to work around the
+		   problem!  What we do instead is just put the interrupt
+		   vectors into a normal section, and have the
+		   `mach_early_init' function for Midas boards do the
+		   necessary copying and relocation at runtime (this section
+		   basically only contains `jr' instructions, so it's not
+		   that hard).  */
+		. = ALIGN (0x10) ;
+		__intv_load_start = . ;
+		INTV_CONTENTS
+	} > KRAM
+
+	.root ALIGN (4096) : { ROOT_FS_CONTENTS } > SDRAM
+}
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/nb85e_timer_d.h linux-2.5.64-moo/include/asm-v850/nb85e_timer_d.h
--- linux-2.5.64-moo.orig/include/asm-v850/nb85e_timer_d.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/nb85e_timer_d.h	2003-03-10 16:55:48.000000000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/nb85e_timer_d.h -- `Timer D' component often used
  *	with the NB85E cpu core
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -27,7 +27,7 @@
 
 /* Count compare registers for timer D.  */
 #define NB85E_TIMER_D_CMD_ADDR(n) (NB85E_TIMER_D_CMD_BASE_ADDR + 0x10 * (n))
-#define NB85E_TIMER_D_CMD(n)	  (*(u16 *)NB85E_TIMER_D_CMD_ADDR(n))
+#define NB85E_TIMER_D_CMD(n)	  (*(volatile u16 *)NB85E_TIMER_D_CMD_ADDR(n))
 
 /* Control registers for timer D.  */
 #define NB85E_TIMER_D_TMCD_ADDR(n) (NB85E_TIMER_D_TMCD_BASE_ADDR + 0x10 * (n))
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/processor.h linux-2.5.64-moo/include/asm-v850/processor.h
--- linux-2.5.64-moo.orig/include/asm-v850/processor.h	2002-12-24 15:01:24.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/processor.h	2003-03-10 16:55:48.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/processor.h
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -88,15 +88,16 @@
 {
 }
 
-/* Return saved (kernel) PC of a blocked thread.  */
-extern inline unsigned long thread_saved_pc (struct thread_struct *t)
-{
-	struct pt_regs *r = (struct pt_regs *)(t->ksp + STATE_SAVE_PT_OFFSET);
-	/* Actually, we return the LP register, because the thread is
-	   actually blocked in switch_thread, and we're interested in
-	   the PC it will _return_ to.  */
-	return r->gpr[GPR_LP];
-}
+
+/* Return the registers saved during context-switch by the currently
+   not-running thread T.  Note that this only includes some registers!
+   See entry.S for details.  */
+#define thread_saved_regs(t) ((struct pt_regs*)((t)->ksp + STATE_SAVE_PT_OFFSET))
+/* Return saved (kernel) PC of a blocked thread.  Actually, we return the
+   LP register, because the thread is actually blocked in switch_thread,
+   and we're interested in the PC it will _return_ to.  */
+#define thread_saved_pc(t)   (thread_saved_regs(t)->gpr[GPR_LP])
+
 
 unsigned long get_wchan (struct task_struct *p);
 
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/rte_cb.h linux-2.5.64-moo/include/asm-v850/rte_cb.h
--- linux-2.5.64-moo.orig/include/asm-v850/rte_cb.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/rte_cb.h	2003-03-10 16:55:49.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/rte_cb.h -- Midas labs RTE-CB series of evaluation boards
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -15,18 +15,6 @@
 #define __V850_RTE_CB_H__
 
 
-/* CPU addresses of GBUS memory spaces.  */
-#define GCS0_ADDR		0x05000000 /* GCS0 - Common SRAM (2MB) */
-#define GCS0_SIZE		0x00200000 /*   2MB */
-#define GCS1_ADDR		0x06000000 /* GCS1 - Flash ROM (8MB) */
-#define GCS1_SIZE		0x00800000 /*   8MB */
-#define GCS2_ADDR		0x07900000 /* GCS2 - I/O registers */
-#define GCS2_SIZE		0x00400000 /*   4MB */
-#define GCS5_ADDR		0x04000000 /* GCS5 - PCI bus space */
-#define GCS5_SIZE		0x01000000 /*   16MB */
-#define GCS6_ADDR		0x07980000 /* GCS6 - PCI control registers */
-#define GCS6_SIZE		0x00000200 /*   512B */
-
 /* The SRAM on the Mother-A motherboard.  */
 #define MB_A_SRAM_ADDR		GCS0_ADDR
 #define MB_A_SRAM_SIZE		0x00200000 /* 2MB */
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/rte_ma1_cb.h linux-2.5.64-moo/include/asm-v850/rte_ma1_cb.h
--- linux-2.5.64-moo.orig/include/asm-v850/rte_ma1_cb.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/rte_ma1_cb.h	2003-03-10 16:55:49.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/rte_ma1_cb.h -- Midas labs RTE-V850/MA1-CB board
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -17,6 +17,19 @@
 #include <asm/rte_cb.h>		/* Common defs for Midas RTE-CB boards.  */
 
 
+/* CPU addresses of GBUS memory spaces.  */
+#define GCS0_ADDR		0x05000000 /* GCS0 - Common SRAM (2MB) */
+#define GCS0_SIZE		0x00200000 /*   2MB */
+#define GCS1_ADDR		0x06000000 /* GCS1 - Flash ROM (8MB) */
+#define GCS1_SIZE		0x00800000 /*   8MB */
+#define GCS2_ADDR		0x07900000 /* GCS2 - I/O registers */
+#define GCS2_SIZE		0x00400000 /*   4MB */
+#define GCS5_ADDR		0x04000000 /* GCS5 - PCI bus space */
+#define GCS5_SIZE		0x01000000 /*   16MB */
+#define GCS6_ADDR		0x07980000 /* GCS6 - PCI control registers */
+#define GCS6_SIZE		0x00000200 /*   512B */
+
+
 /* The GBUS GINT0 - GINT4 interrupts are connected to the INTP000 - INTP011
    pins on the CPU.  These are shared among the GBUS interrupts.  */
 #define IRQ_GINT(n)		IRQ_INTP(n)
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/rte_nb85e_cb.h linux-2.5.64-moo/include/asm-v850/rte_nb85e_cb.h
--- linux-2.5.64-moo.orig/include/asm-v850/rte_nb85e_cb.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/rte_nb85e_cb.h	2003-03-10 16:55:49.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/rte_nb85e_cb.h -- Midas labs RTE-V850/NB85E-CB board
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -16,6 +16,30 @@
 
 #include <asm/rte_cb.h>		/* Common defs for Midas RTE-CB boards.  */
 
+
+/* CPU addresses of GBUS memory spaces.  */
+#define GCS0_ADDR		0x00400000 /* GCS0 - Common SRAM (2MB) */
+#define GCS0_SIZE		0x00400000 /*   4MB */
+#define GCS1_ADDR		0x02000000 /* GCS1 - Flash ROM (8MB) */
+#define GCS1_SIZE		0x00800000 /*   8MB */
+#define GCS2_ADDR		0x03900000 /* GCS2 - I/O registers */
+#define GCS2_SIZE		0x00080000 /*   512KB */
+#define GCS3_ADDR		0x02800000 /* GCS3 - EXT-bus: memory space */
+#define GCS3_SIZE		0x00800000 /*   8MB */
+#define GCS4_ADDR		0x03A00000 /* GCS4 - EXT-bus: I/O space */
+#define GCS4_SIZE		0x00200000 /*   2MB */
+#define GCS5_ADDR		0x00800000 /* GCS5 - PCI bus space */
+#define GCS5_SIZE		0x00800000 /*   8MB */
+#define GCS6_ADDR		0x03980000 /* GCS6 - PCI control registers */
+#define GCS6_SIZE		0x00010000 /*   64KB */
+
+
+/* The GBUS GINT0 - GINT3 interrupts are connected to CPU interrupts 10-12.
+   These are shared among the GBUS interrupts.  */
+#define IRQ_GINT(n)		(10 + (n))
+#define IRQ_GINT_NUM		3
+
+
 #define PLATFORM	"rte-v850e/nb85e-cb"
 #define PLATFORM_LONG	"Midas lab RTE-V850E/NB85E-CB"
 
@@ -41,13 +65,13 @@
 
 /* The chip's real interrupt vectors are in ROM, but they jump to a
    secondary interrupt vector table in RAM.  */
-#define INTV_BASE	0x004F8000
+#define INTV_BASE		0x03CF8000
 
 /* Scratch memory used by the ROM monitor, which shouldn't be used by
    linux (except for the alternate interrupt vector area, defined
    above).  */
 #define MON_SCRATCH_ADDR	0x03CE8000
-#define MON_SCRATCH_SIZE	0x00008000 /* 32KB */
+#define MON_SCRATCH_SIZE	0x00018000 /* 96KB */
 
 #endif /* CONFIG_ROM_KERNEL */
 
@@ -60,4 +84,25 @@
 #define LED_NUM_DIGITS	4
 
 
+/* Override the basic TEG UART pre-initialization so that we can
+   initialize extra stuff.  */
+#undef NB85E_UART_PRE_CONFIGURE	/* should be defined by <asm/teg.h> */
+#define NB85E_UART_PRE_CONFIGURE	rte_nb85e_cb_uart_pre_configure
+#ifndef __ASSEMBLY__
+extern void rte_nb85e_cb_uart_pre_configure (unsigned chan,
+					     unsigned cflags, unsigned baud);
+#endif
+
+/* This board supports RTS/CTS for the on-chip UART. */
+
+/* CTS is pin P00.  */
+#define NB85E_UART_CTS(chan)	(! (TEG_PORT0_IO & 0x1))
+/* RTS is pin P02.  */
+#define NB85E_UART_SET_RTS(chan, val)					      \
+   do {									      \
+	   unsigned old = TEG_PORT0_IO;					      \
+	   TEG_PORT0_IO = val ? (old & ~0x4) : (old | 0x4);		      \
+   } while (0)
+
+
 #endif /* __V850_RTE_NB85E_CB_H__ */
diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/teg.h linux-2.5.64-moo/include/asm-v850/teg.h
--- linux-2.5.64-moo.orig/include/asm-v850/teg.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/teg.h	2003-03-10 16:55:49.000000000 +0900
@@ -1,8 +1,8 @@
 /*
- * include/asm-v850/nb85e_teg.h -- NB85E-TEG cpu chip
+ * include/asm-v850/teg.h -- NB85E-TEG cpu chip
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -11,33 +11,43 @@
  * Written by Miles Bader <miles@gnu.org>
  */
 
-#ifndef __V850_NB85E_TEG_H__
-#define __V850_NB85E_TEG_H__
+#ifndef __V850_TEG_H__
+#define __V850_TEG_H__
 
-/* The NB85E_TEG uses the NB85E cpu core.  */
+
+/* The TEG uses the NB85E cpu core.  */
 #include <asm/nb85e.h>
 
-#define CHIP		"v850e/nb85e-teg"
-#define CHIP_LONG	"NEC V850E/NB85E TEG"
 
-/* Hardware-specific interrupt numbers (in the kernel IRQ namespace).  */
-#define IRQ_INTOV(n)	(n)	/* 0-3 */
-#define IRQ_INTOV_NUM	4
-#define IRQ_INTCMD(n)	(0x1c + (n)) /* interval timer interrupts 0-3 */
-#define IRQ_INTCMD_NUM	4
-#define IRQ_INTDMA(n)	(0x20 + (n)) /* DMA interrupts 0-3 */
-#define IRQ_INTDMA_NUM	4
-#define IRQ_INTCSI(n)	(0x24 + (n)) /* CSI 0-2 transmit/receive completion */
-#define IRQ_INTCSI_NUM	3
-#define IRQ_INTSER(n)	(0x25 + (n)) /* UART 0-2 reception error */
-#define IRQ_INTSER_NUM	3
-#define IRQ_INTSR(n)	(0x26 + (n)) /* UART 0-2 reception completion */
-#define IRQ_INTSR_NUM	3
-#define IRQ_INTST(n)	(0x27 + (n)) /* UART 0-2 transmission completion */
-#define IRQ_INTST_NUM	3
+#define CPU_MODEL	"v850e/nb85e-teg"
+#define CPU_MODEL_LONG	"NEC V850E/NB85E TEG"
+
+
+/* For <asm/entry.h> */
+/* We use on-chip RAM, for a few miscellaneous variables that must be
+   accessible using a load instruction relative to R0.  On the NB85E/TEG,
+   There's 60KB of iRAM starting at 0xFFFF0000, however we need the base
+   address to be addressable by a 16-bit signed offset, so we only use the
+   second half of it starting from 0xFFFF8000.  */
+#define R0_RAM_ADDR			0xFFFF8000
+
+
+/* Hardware-specific interrupt numbers (in the kernel IRQ namespace).
+   Some of these are parameterized even though there's only a single
+   interrupt, for compatibility with some generic code that works on other
+   processor models.  */
+#define IRQ_INTCMD(n)	6	/* interval timer interrupt */
+#define IRQ_INTCMD_NUM	1
+#define IRQ_INTSER(n)	16	/* UART reception error */
+#define IRQ_INTSER_NUM	1
+#define IRQ_INTSR(n)	17	/* UART reception completion */
+#define IRQ_INTSR_NUM	1
+#define IRQ_INTST(n)	18	/* UART transmission completion */
+#define IRQ_INTST_NUM	1
 
 /* For <asm/irq.h> */
-#define NUM_MACH_IRQS	0x30
+#define NUM_CPU_IRQS	64
+
 
 /* TEG UART details.  */
 #define NB85E_UART_BASE_ADDR(n)		(0xFFFFF600 + 0x10 * (n))
@@ -50,9 +60,36 @@
 #define NB85E_UART_RXB_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0xC)
 #define NB85E_UART_NUM_CHANNELS		1
 #define NB85E_UART_BASE_FREQ		CPU_CLOCK_FREQ
+/* This is a function that gets called before configuring the UART.  */
+#define NB85E_UART_PRE_CONFIGURE	teg_uart_pre_configure
+#ifndef __ASSEMBLY__
+extern void teg_uart_pre_configure (unsigned chan,
+				    unsigned cflags, unsigned baud);
+#endif
+
 
 /* The TEG RTPU.  */
 #define NB85E_RTPU_BASE_ADDR		0xFFFFF210
 
 
-#endif /* __V850_NB85E_TEG_H__ */
+/* TEG series timer D details.  */
+#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF210
+#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
+#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
+#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x8)
+#define NB85E_TIMER_D_BASE_FREQ		CPU_CLOCK_FREQ
+
+
+/* `Interrupt Source Select' control register.  */
+#define TEG_ISS_ADDR			0xFFFFF7FA
+#define TEG_ISS				(*(volatile u8 *)TEG_ISS_ADDR)
+
+/* Port 0 I/O register (bits 0-3 used).  */
+#define TEG_PORT0_IO_ADDR		0xFFFFF7F2
+#define TEG_PORT0_IO			(*(volatile u8 *)TEG_PORT0_IO_ADDR)
+/* Port 0 control register (bits 0-3 control mode, 0 = output, 1 = input).  */
+#define TEG_PORT0_PM_ADDR		0xFFFFF7F4
+#define TEG_PORT0_PM			(*(volatile u8 *)TEG_PORT0_PM_ADDR)
+
+
+#endif /* __V850_TEG_H__ */
