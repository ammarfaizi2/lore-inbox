Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271482AbTGRJlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGRJlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:41:24 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:51199 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271482AbTGRJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/7][v850]  Add v850 RTE-V850E/ME2-CB port
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094538.122923702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:38 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This adds a port to the V850E/ME2 processor, and the `SolutionGear mini'
RTE-V850E/ME2-CB evaluation board.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/me2.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/me2.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/me2.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/me2.c	2003-07-15 19:06:35.000000000 +0900
@@ -0,0 +1,74 @@
+/*
+ * arch/v850/kernel/me2.c -- V850E/ME2 chip-specific support
+ *
+ *  Copyright (C) 2003  NEC Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
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
+#include <asm/v850e_timer_d.h>
+
+#include "mach.h"
+
+void __init mach_sched_init (struct irqaction *timer_action)
+{
+	/* Start hardware timer.  */
+	v850e_timer_d_configure (0, HZ);
+	/* Install timer interrupt handler.  */
+	setup_irq (IRQ_INTCMD(0), timer_action);
+}
+
+static struct v850e_intc_irq_init irq_inits[] = {
+	{ "IRQ",    0,                NUM_CPU_IRQS,      1, 7 },
+	{ "INTP",   IRQ_INTP(0),      IRQ_INTP_NUM,      1, 5 },
+	{ "CMD",    IRQ_INTCMD(0),    IRQ_INTCMD_NUM,    1, 3 },
+	{ "UBTIRE", IRQ_INTUBTIRE(0), IRQ_INTUBTIRE_NUM, 5, 4 },
+	{ "UBTIR",  IRQ_INTUBTIR(0),  IRQ_INTUBTIR_NUM,  5, 4 },
+	{ "UBTIT",  IRQ_INTUBTIT(0),  IRQ_INTUBTIT_NUM,  5, 4 },
+	{ "UBTIF",  IRQ_INTUBTIF(0),  IRQ_INTUBTIF_NUM,  5, 4 },
+	{ "UBTITO", IRQ_INTUBTITO(0), IRQ_INTUBTITO_NUM, 5, 4 },
+	{ 0 }
+};
+#define NUM_IRQ_INITS ((sizeof irq_inits / sizeof irq_inits[0]) - 1)
+
+static struct hw_interrupt_type hw_itypes[NUM_IRQ_INITS];
+
+/* Initialize V850E/ME2 chip interrupts.  */
+void __init me2_init_irqs (void)
+{
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
+}
+
+/* Called before configuring an on-chip UART.  */
+void me2_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
+{
+	if (chan == 0) {
+		/* Specify that the relevent pins on the chip should do
+		   serial I/O, not direct I/O.  */
+		ME2_PORT1_PMC |= 0xC;
+		/* Specify that we're using the UART, not the CSI device. */
+		ME2_PORT1_PFC |= 0xC;
+	} else if (chan == 1) {
+		/* Specify that the relevent pins on the chip should do
+		   serial I/O, not direct I/O.  */
+		ME2_PORT2_PMC |= 0x6;
+		/* Specify that we're using the UART, not the CSI device. */
+		ME2_PORT2_PFC |= 0x6;
+	}
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/rte_me2_cb.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_me2_cb.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/rte_me2_cb.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_me2_cb.c	2003-07-15 19:10:59.000000000 +0900
@@ -0,0 +1,308 @@
+/*
+ * arch/v850/kernel/rte_me2_cb.c -- Midas labs RTE-V850E/ME2-CB board
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
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+#include <linux/fs.h>
+#include <linux/major.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/me2.h>
+#include <asm/rte_me2_cb.h>
+#include <asm/machdep.h>
+#include <asm/v850e_intc.h>
+#include <asm/v850e_cache.h>
+#include <asm/irq.h>
+
+#include "mach.h"
+
+extern unsigned long *_intv_start;
+extern unsigned long *_intv_end;
+
+/* LED access routines.  */
+extern unsigned read_leds (int pos, char *buf, int len);
+extern unsigned write_leds (int pos, const char *buf, int len);
+
+
+/* SDRAM are almost contiguous (with a small hole in between;
+   see mach_reserve_bootmem for details), so just use both as one big area.  */
+#define RAM_START 	SDRAM_ADDR
+#define RAM_END		(SDRAM_ADDR + SDRAM_SIZE)
+
+
+void __init mach_get_physical_ram (unsigned long *ram_start,
+				   unsigned long *ram_len)
+{
+	*ram_start = RAM_START;
+	*ram_len = RAM_END - RAM_START;
+}
+
+void __init mach_reserve_bootmem ()
+{
+	extern char _root_fs_image_start, _root_fs_image_end;
+	u32 root_fs_image_start = (u32)&_root_fs_image_start;
+	u32 root_fs_image_end = (u32)&_root_fs_image_end;
+
+	/* Reserve the memory used by the root filesystem image if it's
+	   in RAM.  */
+	if (root_fs_image_start >= RAM_START && root_fs_image_start < RAM_END)
+		reserve_bootmem (root_fs_image_start,
+				 root_fs_image_end - root_fs_image_start);
+}
+
+void mach_gettimeofday (struct timespec *tv)
+{
+	tv->tv_sec = 0;
+	tv->tv_nsec = 0;
+}
+
+/* Called before configuring an on-chip UART.  */
+void rte_me2_cb_uart_pre_configure (unsigned chan,
+				    unsigned cflags, unsigned baud)
+{
+	/* The RTE-V850E/ME2-CB connects some general-purpose I/O
+	   pins on the CPU to the RTS/CTS lines of UARTB channel 0's
+	   serial connection.
+	   I/O pins P21 and P22 are RTS and CTS respectively.  */
+	if (chan == 0) {
+		/* Put P21 & P22 in I/O port mode.  */
+		ME2_PORT2_PMC &= ~0x6;
+		/* Make P21 and output, and P22 an input.  */
+		ME2_PORT2_PM = (ME2_PORT2_PM & ~0xC) | 0x4;
+	}
+
+	me2_uart_pre_configure (chan, cflags, baud);
+}
+
+void __init mach_init_irqs (void)
+{
+	/* Initialize interrupts.  */
+	me2_init_irqs ();
+	rte_me2_cb_init_irqs ();
+}
+
+#ifdef CONFIG_ROM_KERNEL
+/* Initialization for kernel in ROM.  */
+static inline rom_kernel_init (void)
+{
+	/* If the kernel is in ROM, we have to copy any initialized data
+	   from ROM into RAM.  */
+	extern unsigned long _data_load_start, _sdata, _edata;
+	register unsigned long *src = &_data_load_start;
+	register unsigned long *dst = &_sdata, *end = &_edata;
+
+	while (dst != end)
+		*dst++ = *src++;
+}
+#endif /* CONFIG_ROM_KERNEL */
+
+static void install_interrupt_vectors (void)
+{
+	unsigned long *p1, *p2;
+
+	ME2_IRAMM = 0x03; /* V850E/ME2 iRAM write mode */
+
+	/* vector copy to iRAM */
+	p1 = (unsigned long *)0; /* v85x vector start */
+	p2 = (unsigned long *)&_intv_start;
+	while (p2 < (unsigned long *)&_intv_end)
+		*p1++ = *p2++;
+
+	ME2_IRAMM = 0x00; /* V850E/ME2 iRAM read mode */
+}
+
+/* CompactFlash */
+
+static void cf_power_on (void)
+{
+	/* CF card detected? */
+	if (CB_CF_STS0 & 0x0030)
+		return;
+
+	CB_CF_REG0 = 0x0002; /* reest on */
+	mdelay (10);
+	CB_CF_REG0 = 0x0003; /* power on */
+	mdelay (10);
+	CB_CF_REG0 = 0x0001; /* reset off */
+	mdelay (10);
+}
+
+static void cf_power_off (void)
+{
+	CB_CF_REG0 = 0x0003; /* power on */
+	mdelay (10);
+	CB_CF_REG0 = 0x0002; /* reest on */
+	mdelay (10);
+}
+
+void __init mach_early_init (void)
+{
+	install_interrupt_vectors ();
+
+	/* CS1 SDRAM instruction cache enable */
+	v850e_cache_enable (0x04, 0x03, 0);
+
+	rte_cb_early_init ();
+
+	/* CompactFlash power on */
+	cf_power_on ();
+
+#if defined (CONFIG_ROM_KERNEL)
+	rom_kernel_init ();
+#endif
+}
+
+
+/* RTE-V850E/ME2-CB Programmable Interrupt Controller.  */
+
+static struct cb_pic_irq_init cb_pic_irq_inits[] = {
+	{ "CB_EXTTM0",       IRQ_CB_EXTTM0,       1, 1, 6 },
+	{ "CB_EXTSIO",       IRQ_CB_EXTSIO,       1, 1, 6 },
+	{ "CB_TOVER",        IRQ_CB_TOVER,        1, 1, 6 },
+	{ "CB_GINT0",        IRQ_CB_GINT0,        1, 1, 6 },
+	{ "CB_USB",          IRQ_CB_USB,          1, 1, 6 },
+	{ "CB_LANC",         IRQ_CB_LANC,         1, 1, 6 },
+	{ "CB_USB_VBUS_ON",  IRQ_CB_USB_VBUS_ON,  1, 1, 6 },
+	{ "CB_USB_VBUS_OFF", IRQ_CB_USB_VBUS_OFF, 1, 1, 6 },
+	{ "CB_EXTTM1",       IRQ_CB_EXTTM1,       1, 1, 6 },
+	{ "CB_EXTTM2",       IRQ_CB_EXTTM2,       1, 1, 6 },
+	{ 0 }
+};
+#define NUM_CB_PIC_IRQ_INITS  \
+   ((sizeof cb_pic_irq_inits / sizeof cb_pic_irq_inits[0]) - 1)
+
+static struct hw_interrupt_type cb_pic_hw_itypes[NUM_CB_PIC_IRQ_INITS];
+static unsigned char cb_pic_active_irqs = 0;
+
+void __init rte_me2_cb_init_irqs (void)
+{
+	cb_pic_init_irq_types (cb_pic_irq_inits, cb_pic_hw_itypes);
+
+	/* Initalize on board PIC1 (not PIC0) enable */
+	CB_PIC_INT0M  = 0x0000;
+	CB_PIC_INT1M  = 0x0000;
+	CB_PIC_INTR   = 0x0000;
+	CB_PIC_INTEN |= CB_PIC_INT1EN;
+
+	ME2_PORT2_PMC 	 |= 0x08;	/* INTP23/SCK1 mode */
+	ME2_PORT2_PFC 	 &= ~0x08;	/* INTP23 mode */
+	ME2_INTR(2) 	 &= ~0x08;	/* INTP23 falling-edge detect */
+	ME2_INTF(2) 	 &= ~0x08;	/*   " */
+
+	rte_cb_init_irqs ();	/* gbus &c */
+}
+
+
+/* Enable interrupt handling for interrupt IRQ.  */
+void cb_pic_enable_irq (unsigned irq)
+{
+	CB_PIC_INT1M |= 1 << (irq - CB_PIC_BASE_IRQ);
+}
+
+void cb_pic_disable_irq (unsigned irq)
+{
+	CB_PIC_INT1M &= ~(1 << (irq - CB_PIC_BASE_IRQ));
+}
+
+void cb_pic_shutdown_irq (unsigned irq)
+{
+	cb_pic_disable_irq (irq);
+
+	if (--cb_pic_active_irqs == 0)
+		free_irq (IRQ_CB_PIC, 0);
+
+	CB_PIC_INT1M &= ~(1 << (irq - CB_PIC_BASE_IRQ));
+}
+
+static void cb_pic_handle_irq (int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned status = CB_PIC_INTR;
+	unsigned enable = CB_PIC_INT1M;
+
+	/* Only pay attention to enabled interrupts.  */
+	status &= enable;
+
+	CB_PIC_INTEN &= ~CB_PIC_INT1EN;
+
+	if (status) {
+		unsigned mask = 1;
+
+		irq = CB_PIC_BASE_IRQ;
+		do {
+			/* There's an active interrupt, find out which one,
+			   and call its handler.  */
+			while (! (status & mask)) {
+				irq++;
+				mask <<= 1;
+			}
+			status &= ~mask;
+
+			CB_PIC_INTR = mask;
+
+			/* Recursively call handle_irq to handle it. */
+			handle_irq (irq, regs);
+		} while (status);
+	}
+
+	CB_PIC_INTEN |= CB_PIC_INT1EN;
+}
+
+
+static void irq_nop (unsigned irq) { }
+
+static unsigned cb_pic_startup_irq (unsigned irq)
+{
+	int rval;
+
+	if (cb_pic_active_irqs == 0) {
+		rval = request_irq (IRQ_CB_PIC, cb_pic_handle_irq,
+				    SA_INTERRUPT, "cb_pic_handler", 0);
+		if (rval != 0)
+			return rval;
+	}
+
+	cb_pic_active_irqs++;
+
+	cb_pic_enable_irq (irq);
+
+	return 0;
+}
+
+/* Initialize HW_IRQ_TYPES for INTC-controlled irqs described in array
+   INITS (which is terminated by an entry with the name field == 0).  */
+void __init cb_pic_init_irq_types (struct cb_pic_irq_init *inits,
+				   struct hw_interrupt_type *hw_irq_types)
+{
+	struct cb_pic_irq_init *init;
+	for (init = inits; init->name; init++) {
+		struct hw_interrupt_type *hwit = hw_irq_types++;
+
+		hwit->typename = init->name;
+
+		hwit->startup  = cb_pic_startup_irq;
+		hwit->shutdown = cb_pic_shutdown_irq;
+		hwit->enable   = cb_pic_enable_irq;
+		hwit->disable  = cb_pic_disable_irq;
+		hwit->ack      = irq_nop;
+		hwit->end      = irq_nop;
+
+		/* Initialize kernel IRQ infrastructure for this interrupt.  */
+		init_irq_handlers(init->base, init->num, init->interval, hwit);
+	}
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/rte_me2_cb.ld linux-2.6.0-test1-moo-v850-20030718/arch/v850/rte_me2_cb.ld
--- linux-2.6.0-test1-moo/arch/v850/rte_me2_cb.ld	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/rte_me2_cb.ld	2003-07-15 19:06:35.000000000 +0900
@@ -0,0 +1,30 @@
+/* Linker script for the Midas labs RTE-V850E/ME2-CB evaluation board
+   (CONFIG_RTE_CB_ME2), with kernel in SDRAM.  */
+
+MEMORY {
+	/* 128Kbyte of IRAM */
+	IRAM : ORIGIN = 0x00000000, LENGTH = 0x00020000
+	
+	/* 32MB of SDRAM.  */
+	SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
+}
+
+#define KRAM SDRAM
+
+SECTIONS {
+	.text : {
+		__kram_start = . ;
+		TEXT_CONTENTS
+		INTV_CONTENTS	/* copy to iRAM (0x0-0x620) */
+	} > KRAM
+
+	.data : {
+		DATA_CONTENTS
+		BSS_CONTENTS
+		RAMK_INIT_CONTENTS
+		__kram_end = . ;
+		BOOTMAP_CONTENTS
+	} > KRAM
+	
+	.root ALIGN (4096) : { ROOT_FS_CONTENTS } > SDRAM
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/vmlinux.lds.S linux-2.6.0-test1-moo-v850-20030718/arch/v850/vmlinux.lds.S
--- linux-2.6.0-test1-moo/arch/v850/vmlinux.lds.S	2003-06-23 14:50:13.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/vmlinux.lds.S	2003-07-15 19:06:36.000000000 +0900
@@ -247,3 +249,8 @@
 #  include "rte_nb85e_cb.ld"
 # endif
 #endif
+
+#ifdef CONFIG_RTE_CB_ME2
+#  include "rte_me2_cb.ld"
+#endif
+
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/machdep.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/machdep.h
--- linux-2.6.0-test1-moo/include/asm-v850/machdep.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/machdep.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/machdep.h -- Machine-dependent definitions
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -20,6 +20,9 @@
 #ifdef CONFIG_V850E_MA1
 #include <asm/ma1.h>
 #endif
+#ifdef CONFIG_V850E_ME2
+#include <asm/me2.h>
+#endif
 #ifdef CONFIG_V850E_TEG
 #include <asm/teg.h>
 #endif
@@ -36,6 +39,9 @@
 #ifdef CONFIG_RTE_CB_MA1
 #include <asm/rte_ma1_cb.h>
 #endif
+#ifdef CONFIG_RTE_CB_ME2
+#include <asm/rte_me2_cb.h>
+#endif
 #ifdef CONFIG_RTE_CB_NB85E
 #include <asm/rte_nb85e_cb.h>
 #endif
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/me2.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/me2.h
--- linux-2.6.0-test1-moo/include/asm-v850/me2.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/me2.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,182 @@
+/*
+ * include/asm-v850/me2.h -- V850E/ME2 cpu chip
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
+#ifndef __V850_ME2_H__
+#define __V850_ME2_H__
+
+#include <asm/v850e.h>
+#include <asm/v850e_cache.h>
+
+
+#define CPU_MODEL	"v850e/me2"
+#define CPU_MODEL_LONG	"NEC V850E/ME2"
+
+
+/* Hardware-specific interrupt numbers (in the kernel IRQ namespace).  */
+#define IRQ_INTP(n)       (n) /* Pnnn (pin) interrupts */
+#define IRQ_INTP_NUM      31
+#define IRQ_INTCMD(n)     (0x31 + (n)) /* interval timer interrupts 0-3 */
+#define IRQ_INTCMD_NUM    4
+#define IRQ_INTDMA(n)     (0x41 + (n)) /* DMA interrupts 0-3 */
+#define IRQ_INTDMA_NUM    4
+#define IRQ_INTUBTIRE(n)  (0x49 + (n)*5)/* UARTB 0-1 reception error */
+#define IRQ_INTUBTIRE_NUM 2
+#define IRQ_INTUBTIR(n)   (0x4a + (n)*5) /* UARTB 0-1 reception complete */
+#define IRQ_INTUBTIR_NUM  2
+#define IRQ_INTUBTIT(n)   (0x4b + (n)*5) /* UARTB 0-1 transmission complete */
+#define IRQ_INTUBTIT_NUM  2
+#define IRQ_INTUBTIF(n)   (0x4c + (n)*5) /* UARTB 0-1 FIFO trans. complete */
+#define IRQ_INTUBTIF_NUM  2
+#define IRQ_INTUBTITO(n)  (0x4d + (n)*5) /* UARTB 0-1 reception timeout */
+#define IRQ_INTUBTITO_NUM 2
+
+/* For <asm/irq.h> */
+#define NUM_CPU_IRQS		0x59 /* V850E/ME2 */
+
+
+/* For <asm/entry.h> */
+/* We use on-chip RAM, for a few miscellaneous variables that must be
+   accessible using a load instruction relative to R0.  */
+#define R0_RAM_ADDR			0xFFFFB000 /* V850E/ME2 */
+
+
+/* V850E/ME2 UARTB details.*/
+#define V850E_UART_NUM_CHANNELS		2
+#define V850E_UARTB_BASE_FREQ		(CPU_CLOCK_FREQ / 4)
+
+/* This is a function that gets called before configuring the UART.  */
+#define V850E_UART_PRE_CONFIGURE	me2_uart_pre_configure
+#ifndef __ASSEMBLY__
+extern void me2_uart_pre_configure (unsigned chan,
+				    unsigned cflags, unsigned baud);
+#endif /* __ASSEMBLY__ */
+
+
+/* V850E/ME2 timer C details.  */
+#define V850E_TIMER_C_BASE_ADDR		0xFFFFF600
+
+
+/* V850E/ME2 timer D details.  */
+#define V850E_TIMER_D_BASE_ADDR		0xFFFFF540
+#define V850E_TIMER_D_TMD_BASE_ADDR	(V850E_TIMER_D_BASE_ADDR + 0x0)
+#define V850E_TIMER_D_CMD_BASE_ADDR 	(V850E_TIMER_D_BASE_ADDR + 0x2)
+#define V850E_TIMER_D_TMCD_BASE_ADDR	(V850E_TIMER_D_BASE_ADDR + 0x4)
+
+#define V850E_TIMER_D_BASE_FREQ		(CPU_CLOCK_FREQ / 2)
+
+
+/* Select iRAM mode.  */
+#define ME2_IRAMM_ADDR			0xFFFFF80A
+#define ME2_IRAMM			(*(volatile u8*)ME2_IRAMM_ADDR)
+
+
+/* Interrupt edge-detection configuration.  INTF(n) and INTR(n) are only
+   valid for n == 1, 2, or 5.  */
+#define ME2_INTF_ADDR(n)		(0xFFFFFC00 + (n) * 0x2)
+#define ME2_INTF(n)			(*(volatile u8*)ME2_INTF_ADDR(n))
+#define ME2_INTR_ADDR(n)		(0xFFFFFC20 + (n) * 0x2)
+#define ME2_INTR(n)			(*(volatile u8*)ME2_INTR_ADDR(n))
+#define ME2_INTFAL_ADDR			0xFFFFFC10
+#define ME2_INTFAL			(*(volatile u8*)ME2_INTFAL_ADDR)
+#define ME2_INTRAL_ADDR			0xFFFFFC30
+#define ME2_INTRAL			(*(volatile u8*)ME2_INTRAL_ADDR)
+#define ME2_INTFDH_ADDR			0xFFFFFC16
+#define ME2_INTFDH			(*(volatile u16*)ME2_INTFDH_ADDR)
+#define ME2_INTRDH_ADDR			0xFFFFFC36
+#define ME2_INTRDH			(*(volatile u16*)ME2_INTRDH_ADDR)
+#define ME2_SESC_ADDR(n)		(0xFFFFF609 + (n) * 0x10)
+#define ME2_SESC(n)			(*(volatile u8*)ME2_SESC_ADDR(n))
+#define ME2_SESA10_ADDR			0xFFFFF5AD
+#define ME2_SESA10			(*(volatile u8*)ME2_SESA10_ADDR)
+#define ME2_SESA11_ADDR			0xFFFFF5DD
+#define ME2_SESA11			(*(volatile u8*)ME2_SESA11_ADDR)
+
+
+/* Port 1 */
+/* Direct I/O.  Bits 0-3 are pins P10-P13.  */
+#define ME2_PORT1_IO_ADDR		0xFFFFF402
+#define ME2_PORT1_IO			(*(volatile u8 *)ME2_PORT1_IO_ADDR)
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define ME2_PORT1_PM_ADDR		0xFFFFF422
+#define ME2_PORT1_PM			(*(volatile u8 *)ME2_PORT1_PM_ADDR)
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define ME2_PORT1_PMC_ADDR		0xFFFFF442
+#define ME2_PORT1_PMC			(*(volatile u8 *)ME2_PORT1_PMC_ADDR)
+/* Port function control (for serial interfaces, 0 = CSI30, 1 = UARTB0 ).  */
+#define ME2_PORT1_PFC_ADDR		0xFFFFF462
+#define ME2_PORT1_PFC			(*(volatile u8 *)ME2_PORT1_PFC_ADDR)
+
+/* Port 2 */
+/* Direct I/O.  Bits 0-3 are pins P20-P25.  */
+#define ME2_PORT2_IO_ADDR		0xFFFFF404
+#define ME2_PORT2_IO			(*(volatile u8 *)ME2_PORT2_IO_ADDR)
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define ME2_PORT2_PM_ADDR		0xFFFFF424
+#define ME2_PORT2_PM			(*(volatile u8 *)ME2_PORT2_PM_ADDR)
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define ME2_PORT2_PMC_ADDR		0xFFFFF444
+#define ME2_PORT2_PMC			(*(volatile u8 *)ME2_PORT2_PMC_ADDR)
+/* Port function control (for serial interfaces, 0 = INTP2x, 1 = UARTB1 ).  */
+#define ME2_PORT2_PFC_ADDR		0xFFFFF464
+#define ME2_PORT2_PFC			(*(volatile u8 *)ME2_PORT2_PFC_ADDR)
+
+/* Port 5 */
+/* Direct I/O.  Bits 0-5 are pins P50-P55.  */
+#define ME2_PORT5_IO_ADDR		0xFFFFF40A
+#define ME2_PORT5_IO			(*(volatile u8 *)ME2_PORT5_IO_ADDR)
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define ME2_PORT5_PM_ADDR		0xFFFFF42A
+#define ME2_PORT5_PM			(*(volatile u8 *)ME2_PORT5_PM_ADDR)
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define ME2_PORT5_PMC_ADDR		0xFFFFF44A
+#define ME2_PORT5_PMC			(*(volatile u8 *)ME2_PORT5_PMC_ADDR)
+/* Port function control ().  */
+#define ME2_PORT5_PFC_ADDR		0xFFFFF46A
+#define ME2_PORT5_PFC			(*(volatile u8 *)ME2_PORT5_PFC_ADDR)
+
+/* Port 6 */
+/* Direct I/O.  Bits 5-7 are pins P65-P67.  */
+#define ME2_PORT6_IO_ADDR		0xFFFFF40C
+#define ME2_PORT6_IO			(*(volatile u8 *)ME2_PORT6_IO_ADDR)
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define ME2_PORT6_PM_ADDR		0xFFFFF42C
+#define ME2_PORT6_PM			(*(volatile u8 *)ME2_PORT6_PM_ADDR)
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define ME2_PORT6_PMC_ADDR		0xFFFFF44C
+#define ME2_PORT6_PMC			(*(volatile u8 *)ME2_PORT6_PMC_ADDR)
+/* Port function control ().  */
+#define ME2_PORT6_PFC_ADDR		0xFFFFF46C
+#define ME2_PORT6_PFC			(*(volatile u8 *)ME2_PORT6_PFC_ADDR)
+
+/* Port 7 */
+/* Direct I/O.  Bits 2-7 are pins P72-P77.  */
+#define ME2_PORT7_IO_ADDR		0xFFFFF40E
+#define ME2_PORT7_IO			(*(volatile u8 *)ME2_PORT7_IO_ADDR)
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define ME2_PORT7_PM_ADDR		0xFFFFF42E
+#define ME2_PORT7_PM			(*(volatile u8 *)ME2_PORT7_PM_ADDR)
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define ME2_PORT7_PMC_ADDR		0xFFFFF44E
+#define ME2_PORT7_PMC			(*(volatile u8 *)ME2_PORT7_PMC_ADDR)
+/* Port function control ().  */
+#define ME2_PORT7_PFC_ADDR		0xFFFFF46E
+#define ME2_PORT7_PFC			(*(volatile u8 *)ME2_PORT7_PFC_ADDR)
+
+
+#ifndef __ASSEMBLY__
+/* Initialize V850E/ME2 chip interrupts.  */
+extern void me2_init_irqs (void);
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __V850_ME2_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_me2_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_me2_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_me2_cb.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_me2_cb.h	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,202 @@
+/*
+ * include/asm-v850/rte_me2_cb.h -- Midas labs RTE-V850E/ME2-CB board
+ *
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_RTE_ME2_CB_H__
+#define __V850_RTE_ME2_CB_H__
+
+#include <asm/rte_cb.h>		/* Common defs for Midas RTE-CB boards.  */
+
+
+#define PLATFORM		"rte-v850e/me2-cb"
+#define PLATFORM_LONG		"Midas lab RTE-V850E/ME2-CB"
+
+#define CPU_CLOCK_FREQ		150000000 /* 150MHz */
+#define FIXED_BOGOMIPS		50
+
+/* 32MB of onbard SDRAM.  */
+#define SDRAM_ADDR		0x00800000
+#define SDRAM_SIZE		0x02000000 /* 32MB */
+
+
+/* CPU addresses of GBUS memory spaces.  */
+#define GCS0_ADDR		0x04000000 /* GCS0 - Common SRAM (2MB) */
+#define GCS0_SIZE		0x00800000 /*   8MB */
+#define GCS1_ADDR		0x04800000 /* GCS1 - Flash ROM (8MB) */
+#define GCS1_SIZE		0x00800000 /*   8MB */
+#define GCS2_ADDR		0x07000000 /* GCS2 - I/O registers */
+#define GCS2_SIZE		0x00800000 /*   8MB */
+#define GCS5_ADDR		0x08000000 /* GCS5 - PCI bus space */
+#define GCS5_SIZE		0x02000000 /*   32MB */
+#define GCS6_ADDR		0x07800000 /* GCS6 - PCI control registers */
+#define GCS6_SIZE		0x00800000 /*   8MB */
+
+
+/* For <asm/page.h> */
+#define PAGE_OFFSET 		SDRAM_ADDR
+
+
+#ifdef CONFIG_ROM_KERNEL
+/* Kernel is in ROM, starting at address 0.  */
+
+#define INTV_BASE		0
+#define ROOT_FS_IMAGE_RW	0
+
+#else /* !CONFIG_ROM_KERNEL */
+/* Using RAM-kernel.  Assume some sort of boot-loader got us loaded at
+   address 0.  */
+
+#define INTV_BASE		0
+#define ROOT_FS_IMAGE_RW	1
+
+#endif /* CONFIG_ROM_KERNEL */
+
+
+/* Some misc. on-board devices.  */
+
+/* Seven-segment LED display (four digits).  */
+#define LED_ADDR(n)		(0x0FE02000 + (n))
+#define LED(n)			(*(volatile unsigned char *)LED_ADDR(n))
+#define LED_NUM_DIGITS		4
+
+
+/* On-board PIC.  */
+
+#define CB_PIC_BASE_ADDR 	0x0FE04000
+
+#define CB_PIC_INT0M_ADDR 	(CB_PIC_BASE_ADDR + 0x00)
+#define CB_PIC_INT0M      	(*(volatile u16 *)CB_PIC_INT0M_ADDR)
+#define CB_PIC_INT1M_ADDR 	(CB_PIC_BASE_ADDR + 0x10)
+#define CB_PIC_INT1M      	(*(volatile u16 *)CB_PIC_INT1M_ADDR)
+#define CB_PIC_INTR_ADDR  	(CB_PIC_BASE_ADDR + 0x20)
+#define CB_PIC_INTR       	(*(volatile u16 *)CB_PIC_INTR_ADDR)
+#define CB_PIC_INTEN_ADDR 	(CB_PIC_BASE_ADDR + 0x30)
+#define CB_PIC_INTEN      	(*(volatile u16 *)CB_PIC_INTEN_ADDR)
+
+#define CB_PIC_INT0EN        	0x0001
+#define CB_PIC_INT1EN        	0x0002
+#define CB_PIC_INT0SEL       	0x0080
+
+/* The PIC interrupts themselves.  */
+#define CB_PIC_BASE_IRQ		NUM_CPU_IRQS
+#define IRQ_CB_PIC_NUM		10
+
+/* Some specific CB_PIC interrupts. */
+#define IRQ_CB_EXTTM0		(CB_PIC_BASE_IRQ + 0)
+#define IRQ_CB_EXTSIO		(CB_PIC_BASE_IRQ + 1)
+#define IRQ_CB_TOVER		(CB_PIC_BASE_IRQ + 2)
+#define IRQ_CB_GINT0		(CB_PIC_BASE_IRQ + 3)
+#define IRQ_CB_USB		(CB_PIC_BASE_IRQ + 4)
+#define IRQ_CB_LANC		(CB_PIC_BASE_IRQ + 5)
+#define IRQ_CB_USB_VBUS_ON	(CB_PIC_BASE_IRQ + 6)
+#define IRQ_CB_USB_VBUS_OFF	(CB_PIC_BASE_IRQ + 7)
+#define IRQ_CB_EXTTM1		(CB_PIC_BASE_IRQ + 8)
+#define IRQ_CB_EXTTM2		(CB_PIC_BASE_IRQ + 9)
+
+/* The GBUS GINT1 - GINT3 (note, not GINT0!) interrupts are connected to
+   the INTP65 - INTP67 pins on the CPU.  These are shared among the GBUS
+   interrupts.  */
+#define IRQ_GINT(n)		IRQ_INTP((n) + 9)  /* 0 is unused! */
+#define IRQ_GINT_NUM		4		   /* 0 is unused! */
+
+/* The shared interrupt line from the PIC is connected to CPU pin INTP23.  */
+#define IRQ_CB_PIC		IRQ_INTP(4) /* P23 */
+
+/* Used by <asm/rte_cb.h> to derive NUM_MACH_IRQS.  */
+#define NUM_RTE_CB_IRQS		(NUM_CPU_IRQS + IRQ_CB_PIC_NUM)
+
+
+#ifndef __ASSEMBLY__
+struct cb_pic_irq_init {
+	const char *name;	/* name of interrupt type */
+
+	/* Range of kernel irq numbers for this type:
+	   BASE, BASE+INTERVAL, ..., BASE+INTERVAL*NUM  */
+	unsigned base, num, interval;
+
+	unsigned priority;	/* interrupt priority to assign */
+};
+struct hw_interrupt_type;	/* fwd decl */
+
+/* Enable interrupt handling for interrupt IRQ.  */
+extern void cb_pic_enable_irq (unsigned irq);
+/* Disable interrupt handling for interrupt IRQ.  Note that any interrupts
+   received while disabled will be delivered once the interrupt is enabled
+   again, unless they are explicitly cleared using `cb_pic_clear_pending_irq'.  */
+extern void cb_pic_disable_irq (unsigned irq);
+/* Initialize HW_IRQ_TYPES for PIC irqs described in array INITS (which is
+   terminated by an entry with the name field == 0).  */
+extern void cb_pic_init_irq_types (struct cb_pic_irq_init *inits,
+				   struct hw_interrupt_type *hw_irq_types);
+/* Initialize PIC interrupts.  */
+extern void cb_pic_init_irqs (void);
+#endif /* __ASSEMBLY__ */
+
+
+/* TL16C550C on board UART see also asm/serial.h */
+#define CB_UART_BASE    	0x0FE08000
+#define CB_UART_REG_GAP 	0x10
+#define CB_UART_CLOCK   	0x16000000
+
+/* CompactFlash setting see also asm/ide.h, asm/hdreg.h.  */
+#define CB_CF_BASE     		0x0FE0C000
+#define CB_CF_CCR_ADDR 		(CB_CF_BASE+0x200)
+#define CB_CF_CCR      		(*(volatile u8 *)CB_CF_CCR_ADDR)
+#define CB_CF_REG0_ADDR		(CB_CF_BASE+0x1000)
+#define CB_CF_REG0     		(*(volatile u16 *)CB_CF_REG0_ADDR)
+#define CB_CF_STS0_ADDR		(CB_CF_BASE+0x1004)
+#define CB_CF_STS0     		(*(volatile u16 *)CB_CF_STS0_ADDR)
+#define CB_PCATA_BASE  		(CB_CF_BASE+0x800)
+#define CB_IDE_BASE    		(CB_CF_BASE+0x9F0)
+#define CB_IDE_CTRL    		(CB_CF_BASE+0xBF6)
+#define CB_IDE_REG_OFFS		0x1
+
+
+/* SMSC LAN91C111 setting */
+#if defined(CONFIG_SMC91111)
+#define CB_LANC_BASE 		0x0FE10300
+#define CONFIG_SMC16BITONLY
+#define ETH0_ADDR 		CB_LANC_BASE
+#define ETH0_IRQ 		IRQ_CB_LANC
+#endif /* CONFIG_SMC16BITONLY */
+
+
+#undef V850E_UART_PRE_CONFIGURE
+#define V850E_UART_PRE_CONFIGURE	rte_me2_cb_uart_pre_configure
+#ifndef __ASSEMBLY__
+extern void rte_me2_cb_uart_pre_configure (unsigned chan,
+					   unsigned cflags, unsigned baud);
+#endif /* __ASSEMBLY__ */
+
+/* This board supports RTS/CTS for the on-chip UART, but only for channel 0. */
+
+/* CTS for UART channel 0 is pin P22 (bit 2 of port 2).  */
+#define V850E_UART_CTS(chan)	((chan) == 0 ? !(ME2_PORT2_IO & 0x4) : 1)
+/* RTS for UART channel 0 is pin P21 (bit 1 of port 2).  */
+#define V850E_UART_SET_RTS(chan, val)					      \
+   do {									      \
+	   if (chan == 0) {						      \
+		   unsigned old = ME2_PORT2_IO; 			      \
+		   if (val)						      \
+			   ME2_PORT2_IO = old & ~0x2;			      \
+		   else							      \
+			   ME2_PORT2_IO = old | 0x2;			      \
+	   }								      \
+   } while (0)
+
+
+#ifndef __ASSEMBLY__
+extern void rte_me2_cb_init_irqs (void);
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __V850_RTE_ME2_CB_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/serial.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/serial.h
--- linux-2.6.0-test1-moo/include/asm-v850/serial.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/serial.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,58 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1999 by Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */ 
+#include <linux/config.h>
+
+#ifdef CONFIG_RTE_CB_ME2
+
+#include <asm/rte_me2_cb.h>
+
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+
+#define irq_cannonicalize(x) (x)
+#define BASE_BAUD	250000	/* (16MHz / (16 * 38400)) * 9600 */
+#define RS_TABLE_SIZE	1
+#define SERIAL_PORT_DFNS \
+   { 0, BASE_BAUD, CB_UART_BASE, IRQ_CB_EXTSIO, STD_COM_FLAGS },
+
+/* Redefine UART register offsets.  */
+#undef UART_RX
+#undef UART_TX
+#undef UART_DLL
+#undef UART_TRG
+#undef UART_DLM
+#undef UART_IER
+#undef UART_FCTR
+#undef UART_IIR
+#undef UART_FCR
+#undef UART_EFR
+#undef UART_LCR
+#undef UART_MCR
+#undef UART_LSR
+#undef UART_MSR
+#undef UART_SCR
+#undef UART_EMSR
+
+#define UART_RX		(0 * CB_UART_REG_GAP)
+#define UART_TX		(0 * CB_UART_REG_GAP)
+#define UART_DLL	(0 * CB_UART_REG_GAP)
+#define UART_TRG	(0 * CB_UART_REG_GAP)
+#define UART_DLM	(1 * CB_UART_REG_GAP)
+#define UART_IER	(1 * CB_UART_REG_GAP)
+#define UART_FCTR	(1 * CB_UART_REG_GAP)
+#define UART_IIR	(2 * CB_UART_REG_GAP)
+#define UART_FCR	(2 * CB_UART_REG_GAP)
+#define UART_EFR	(2 * CB_UART_REG_GAP)
+#define UART_LCR	(3 * CB_UART_REG_GAP)
+#define UART_MCR	(4 * CB_UART_REG_GAP)
+#define UART_LSR	(5 * CB_UART_REG_GAP)
+#define UART_MSR	(6 * CB_UART_REG_GAP)
+#define UART_SCR	(7 * CB_UART_REG_GAP)
+#define UART_EMSR	(7 * CB_UART_REG_GAP)
+
+#endif /* CONFIG_RTE_CB_ME2 */
