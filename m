Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271485AbTGRJrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTGRJre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:47:34 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:51455 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271485AbTGRJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/7][v850]  Refactor v850 UART driver
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094536.4AA1F3702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:36 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The v850 family contains several related-but-not-identical on-chip
UARTs.  This patch factors out the common code and uses it to implement
both types (only one was supported before).

Also, this patch changes the way the v850 UART is initialized, to use
the same method as other linux serial drivers.

This patch renames the UART code to be `v850e_uart' rather than
`nb85e_uart', as the former is more correct.  As this change renames
some files too, the patch contains a number of whole-file add/removes.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/anna.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/anna.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c	2003-07-16 17:23:42.000000000 +0900
@@ -65,10 +71,6 @@
 
 void __init mach_setup (char **cmdline)
 {
-#ifdef CONFIG_V850E_NB85E_UART_CONSOLE
-	nb85e_uart_cons_init (1);
-#endif
-
 	ANNA_PORT_PM (LEDS_PORT) = 0;	/* Make all LED pins output pins.  */
 	mach_tick = anna_led_tick;
 }
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/as85ep1.c	2003-01-14 10:26:59.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/as85ep1.c	2003-07-16 17:23:42.000000000 +0900
@@ -97,10 +97,6 @@
 
 void __init mach_setup (char **cmdline)
 {
-#ifdef CONFIG_V850E_NB85E_UART_CONSOLE
-	nb85e_uart_cons_init (1);
-#endif
-
 	AS85EP1_PORT_PMC (LEDS_PORT) = 0; /* Make the LEDs port an I/O port. */
 	AS85EP1_PORT_PM (LEDS_PORT) = 0; /* Make all the bits output pins.  */
 	mach_tick = as85ep1_led_tick;
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/anna.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h
--- linux-2.6.0-test1-moo/include/asm-v850/anna.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h	2003-07-17 20:25:27.000000000 +0900
@@ -116,12 +90,15 @@
 
 
 /* Anna UART details (basically the same as the V850E/MA1, but 2 channels).  */
-#define NB85E_UART_NUM_CHANNELS		2
-#define NB85E_UART_BASE_FREQ		(SYS_CLOCK_FREQ / 2)
-#define NB85E_UART_CHIP_NAME 		"V850E2/NA85E2A"
+#define V850E_UART_NUM_CHANNELS		2
+#define V850E_UART_BASE_FREQ		(SYS_CLOCK_FREQ / 2)
+#define V850E_UART_CHIP_NAME 		"V850E2/NA85E2A"
+
+/* This is the UART channel that's actually connected on the board.  */
+#define V850E_UART_CONSOLE_CHANNEL	1
 
 /* This is a function that gets called before configuring the UART.  */
-#define NB85E_UART_PRE_CONFIGURE	anna_uart_pre_configure
+#define V850E_UART_PRE_CONFIGURE	anna_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void anna_uart_pre_configure (unsigned chan,
 				     unsigned cflags, unsigned baud);
@@ -130,9 +107,9 @@
 /* This board supports RTS/CTS for the on-chip UART, but only for channel 1. */
 
 /* CTS for UART channel 1 is pin P37 (bit 7 of port 3).  */
-#define NB85E_UART_CTS(chan)	((chan) == 1 ? !(ANNA_PORT_IO(3) & 0x80) : 1)
+#define V850E_UART_CTS(chan)	((chan) == 1 ? !(ANNA_PORT_IO(3) & 0x80) : 1)
 /* RTS for UART channel 1 is pin P07 (bit 7 of port 0).  */
-#define NB85E_UART_SET_RTS(chan, val)					      \
+#define V850E_UART_SET_RTS(chan, val)					      \
    do {									      \
 	   if (chan == 1) {						      \
 		   unsigned old = ANNA_PORT_IO(0); 			      \
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h
--- linux-2.6.0-test1-moo/include/asm-v850/as85ep1.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/as85ep1.h	2003-07-17 20:25:27.000000000 +0900
@@ -110,12 +108,12 @@
 
 
 /* AS85EP1 UART details (basically the same as the V850E/MA1, but 2 channels).  */
-#define NB85E_UART_NUM_CHANNELS		2
-#define NB85E_UART_BASE_FREQ		(SYS_CLOCK_FREQ / 4)
-#define NB85E_UART_CHIP_NAME 		"V850E/NA85E"
+#define V850E_UART_NUM_CHANNELS		2
+#define V850E_UART_BASE_FREQ		(SYS_CLOCK_FREQ / 4)
+#define V850E_UART_CHIP_NAME 		"V850E/NA85E"
 
 /* This is a function that gets called before configuring the UART.  */
-#define NB85E_UART_PRE_CONFIGURE	as85ep1_uart_pre_configure
+#define V850E_UART_PRE_CONFIGURE	as85ep1_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void as85ep1_uart_pre_configure (unsigned chan,
 					unsigned cflags, unsigned baud);
@@ -124,9 +122,9 @@
 /* This board supports RTS/CTS for the on-chip UART, but only for channel 1. */
 
 /* CTS for UART channel 1 is pin P54 (bit 4 of port 5).  */
-#define NB85E_UART_CTS(chan)   ((chan) == 1 ? !(AS85EP1_PORT_IO(5) & 0x10) : 1)
+#define V850E_UART_CTS(chan)   ((chan) == 1 ? !(AS85EP1_PORT_IO(5) & 0x10) : 1)
 /* RTS for UART channel 1 is pin P53 (bit 3 of port 5).  */
-#define NB85E_UART_SET_RTS(chan, val)					      \
+#define V850E_UART_SET_RTS(chan, val)					      \
    do {									      \
 	   if (chan == 1) {						      \
 		   unsigned old = AS85EP1_PORT_IO(5); 			      \
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/ma.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma.h
--- linux-2.6.0-test1-moo/include/asm-v850/ma.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma.h	2003-07-15 19:06:37.000000000 +0900
@@ -28,10 +27,10 @@
 
 
 /* MA series UART details.  */
-#define NB85E_UART_BASE_FREQ		CPU_CLOCK_FREQ
+#define V850E_UART_BASE_FREQ		CPU_CLOCK_FREQ
 
 /* This is a function that gets called before configuring the UART.  */
-#define NB85E_UART_PRE_CONFIGURE	ma_uart_pre_configure
+#define V850E_UART_PRE_CONFIGURE	ma_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void ma_uart_pre_configure (unsigned chan,
 				   unsigned cflags, unsigned baud);
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/ma1.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma1.h
--- linux-2.6.0-test1-moo/include/asm-v850/ma1.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ma1.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/ma1.h -- V850E/MA1 cpu chip
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -40,12 +40,11 @@
 #define IRQ_INTST(n)	(0x27 + (n)*4) /* UART 0-2 transmission completion */
 #define IRQ_INTST_NUM	3
 
-/* For <asm/irq.h> */
 #define NUM_CPU_IRQS	0x30
 
 
 /* The MA1 has a UART with 3 channels.  */
-#define NB85E_UART_NUM_CHANNELS	3
+#define V850E_UART_NUM_CHANNELS	3
 
 
 #endif /* __V850_MA1_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_uart.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_uart.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_uart.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_uart.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,144 +0,0 @@
-/*
- * include/asm-v850/nb85e_uart.h -- On-chip UART often used with the
- *	NB85E cpu core
- *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-/* There's not actually a single UART implementation used by nb85e
-   derivatives, but rather a series of implementations that are all
-   `close' to one another.  This file attempts to capture some
-   commonality between them.  */
-
-#ifndef __V850_NB85E_UART_H__
-#define __V850_NB85E_UART_H__
-
-#include <asm/types.h>
-#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
-
-
-/* The base address of the UART control registers for channel N.
-   The default is the address used on the V850E/MA1.  */
-#ifndef NB85E_UART_BASE_ADDR
-#define NB85E_UART_BASE_ADDR(n)		(0xFFFFFA00 + 0x10 * (n))
-#endif 
-
-/* Addresses of specific UART control registers for channel N.
-   The defaults are the addresses used on the V850E/MA1; if a platform
-   wants to redefine any of these, it must redefine them all.  */
-#ifndef NB85E_UART_ASIM_ADDR
-#define NB85E_UART_ASIM_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x0)
-#define NB85E_UART_RXB_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x2)
-#define NB85E_UART_ASIS_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x3)
-#define NB85E_UART_TXB_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x4)
-#define NB85E_UART_ASIF_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x5)
-#define NB85E_UART_CKSR_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x6)
-#define NB85E_UART_BRGC_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x7)
-#endif
-
-#ifndef NB85E_UART_CKSR_MAX_FREQ
-#define NB85E_UART_CKSR_MAX_FREQ (25*1000*1000)
-#endif
-
-/* UART config registers.  */
-#define NB85E_UART_ASIM(n)	(*(volatile u8 *)NB85E_UART_ASIM_ADDR(n))
-/* Control bits for config registers.  */
-#define NB85E_UART_ASIM_CAE	0x80 /* clock enable */
-#define NB85E_UART_ASIM_TXE	0x40 /* transmit enable */
-#define NB85E_UART_ASIM_RXE	0x20 /* receive enable */
-#define NB85E_UART_ASIM_PS_MASK	0x18 /* mask covering parity-select bits */
-#define NB85E_UART_ASIM_PS_NONE	0x00 /* no parity */
-#define NB85E_UART_ASIM_PS_ZERO	0x08 /* zero parity */
-#define NB85E_UART_ASIM_PS_ODD	0x10 /* odd parity */
-#define NB85E_UART_ASIM_PS_EVEN	0x18 /* even parity */
-#define NB85E_UART_ASIM_CL_8	0x04 /* char len is 8 bits (otherwise, 7) */
-#define NB85E_UART_ASIM_SL_2	0x02 /* 2 stop bits (otherwise, 1) */
-#define NB85E_UART_ASIM_ISRM	0x01 /* generate INTSR interrupt on errors
-					(otherwise, generate INTSER) */
-
-/* UART serial interface status registers.  */
-#define NB85E_UART_ASIS(n)	(*(volatile u8 *)NB85E_UART_ASIS_ADDR(n))
-/* Control bits for status registers.  */
-#define NB85E_UART_ASIS_PE	0x04 /* parity error */
-#define NB85E_UART_ASIS_FE	0x02 /* framing error */
-#define NB85E_UART_ASIS_OVE	0x01 /* overrun error */
-
-/* UART serial interface transmission status registers.  */
-#define NB85E_UART_ASIF(n)	(*(volatile u8 *)NB85E_UART_ASIF_ADDR(n))
-#define NB85E_UART_ASIF_TXBF	0x02 /* transmit buffer flag (data in TXB) */
-#define NB85E_UART_ASIF_TXSF	0x01 /* transmit shift flag (sending data) */
-
-/* UART receive buffer register.  */
-#define NB85E_UART_RXB(n)	(*(volatile u8 *)NB85E_UART_RXB_ADDR(n))
-
-/* UART transmit buffer register.  */
-#define NB85E_UART_TXB(n)	(*(volatile u8 *)NB85E_UART_TXB_ADDR(n))
-
-/* UART baud-rate generator control registers.  */
-#define NB85E_UART_CKSR(n)	(*(volatile u8 *)NB85E_UART_CKSR_ADDR(n))
-#define NB85E_UART_CKSR_MAX	11
-#define NB85E_UART_BRGC(n)	(*(volatile u8 *)NB85E_UART_BRGC_ADDR(n))
-
-
-/* This UART doesn't implement RTS/CTS by default, but some platforms
-   implement them externally, so check to see if <asm/machdep.h> defined
-   anything.  */
-#ifdef NB85E_UART_CTS
-#define nb85e_uart_cts(n)	NB85E_UART_CTS(n)
-#else
-#define nb85e_uart_cts(n)	(1)
-#endif
-
-/* Do the same for RTS.  */
-#ifdef NB85E_UART_SET_RTS
-#define nb85e_uart_set_rts(n,v)	NB85E_UART_SET_RTS(n,v)
-#else
-#define nb85e_uart_set_rts(n,v)	((void)0)
-#endif
-
-/* Return true if all characters awaiting transmission on uart channel N
-   have been transmitted.  */
-#define nb85e_uart_xmit_done(n)						      \
-   (! (NB85E_UART_ASIF(n) & NB85E_UART_ASIF_TXBF))
-/* Wait for this to be true.  */
-#define nb85e_uart_wait_for_xmit_done(n)				      \
-   do { } while (! nb85e_uart_xmit_done (n))
-
-/* Return true if uart channel N is ready to transmit a character.  */
-#define nb85e_uart_xmit_ok(n)						      \
-   (nb85e_uart_xmit_done(n) && nb85e_uart_cts(n))
-/* Wait for this to be true.  */
-#define nb85e_uart_wait_for_xmit_ok(n)					      \
-   do { } while (! nb85e_uart_xmit_ok (n))
-
-/* Write character CH to uart channel N.  */
-#define nb85e_uart_putc(n, ch)	(NB85E_UART_TXB(n) = (ch))
-
-
-#define NB85E_UART_MINOR_BASE	64
-
-
-#ifndef __ASSEMBLY__
-
-/* Setup a console using channel 0 of the builtin uart.  */
-extern void nb85e_uart_cons_init (unsigned chan);
-
-/* Configure and turn on uart channel CHAN, using the termios `control
-   modes' bits in CFLAGS, and a baud-rate of BAUD.  */
-void nb85e_uart_configure (unsigned chan, unsigned cflags, unsigned baud);
-
-/* If the macro NB85E_UART_PRE_CONFIGURE is defined (presumably by a
-   <asm/machdep.h>), it is called from nb85e_uart_pre_configure before
-   anything else is done, with interrupts disabled.  */
-
-#endif /* !__ASSEMBLY__ */
-
-
-#endif /* __V850_NB85E_UART_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/rte_cb.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_cb.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/rte_cb.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/rte_cb.c	2003-07-16 17:23:42.000000000 +0900
@@ -52,23 +53,11 @@
 				"          NEC SolutionGear/Midas lab"
 				" RTE-MOTHER-A motherboard\n");
 	}
-
-#if defined (CONFIG_V850E_NB85E_UART_CONSOLE) && !defined (CONFIG_TIME_BOOTUP)
-	nb85e_uart_cons_init (0);
-#endif
+#endif /* CONFIG_RTE_MB_A_PCI */
 
 	mach_tick = led_tick;
 }
 
-#ifdef CONFIG_TIME_BOOTUP
-void initial_boot_done (void)
-{
-#ifdef CONFIG_V850E_NB85E_UART_CONSOLE
-	nb85e_uart_cons_init (0);
-#endif
-}
-#endif
-
 void machine_restart (char *__unused)
 {
 #ifdef CONFIG_RESET_GUARD
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_ma1_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_ma1_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_ma1_cb.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_ma1_cb.h	2003-07-15 19:06:37.000000000 +0900
@@ -98,8 +101,8 @@
 
 /* Override the basic MA uart pre-initialization so that we can
    initialize extra stuff.  */
-#undef NB85E_UART_PRE_CONFIGURE	/* should be defined by <asm/ma.h> */
-#define NB85E_UART_PRE_CONFIGURE	rte_ma1_cb_uart_pre_configure
+#undef V850E_UART_PRE_CONFIGURE	/* should be defined by <asm/ma.h> */
+#define V850E_UART_PRE_CONFIGURE	rte_ma1_cb_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void rte_ma1_cb_uart_pre_configure (unsigned chan,
 					   unsigned cflags, unsigned baud);
@@ -108,9 +111,9 @@
 /* This board supports RTS/CTS for the on-chip UART, but only for channel 0. */
 
 /* CTS for UART channel 0 is pin P43 (bit 3 of port 4).  */
-#define NB85E_UART_CTS(chan)	((chan) == 0 ? !(MA_PORT4_IO & 0x8) : 1)
+#define V850E_UART_CTS(chan)	((chan) == 0 ? !(MA_PORT4_IO & 0x8) : 1)
 /* RTS for UART channel 0 is pin P42 (bit 2 of port 4).  */
-#define NB85E_UART_SET_RTS(chan, val)					      \
+#define V850E_UART_SET_RTS(chan, val)					      \
    do {									      \
 	   if (chan == 0) {						      \
 		   unsigned old = MA_PORT4_IO; 				      \
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_nb85e_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_nb85e_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_nb85e_cb.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_nb85e_cb.h	2003-07-15 19:06:37.000000000 +0900
@@ -86,8 +89,8 @@
 
 /* Override the basic TEG UART pre-initialization so that we can
    initialize extra stuff.  */
-#undef NB85E_UART_PRE_CONFIGURE	/* should be defined by <asm/teg.h> */
-#define NB85E_UART_PRE_CONFIGURE	rte_nb85e_cb_uart_pre_configure
+#undef V850E_UART_PRE_CONFIGURE	/* should be defined by <asm/teg.h> */
+#define V850E_UART_PRE_CONFIGURE	rte_nb85e_cb_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void rte_nb85e_cb_uart_pre_configure (unsigned chan,
 					     unsigned cflags, unsigned baud);
@@ -96,9 +99,9 @@
 /* This board supports RTS/CTS for the on-chip UART. */
 
 /* CTS is pin P00.  */
-#define NB85E_UART_CTS(chan)	(! (TEG_PORT0_IO & 0x1))
+#define V850E_UART_CTS(chan)	(! (TEG_PORT0_IO & 0x1))
 /* RTS is pin P02.  */
-#define NB85E_UART_SET_RTS(chan, val)					      \
+#define V850E_UART_SET_RTS(chan, val)					      \
    do {									      \
 	   unsigned old = TEG_PORT0_IO;					      \
 	   TEG_PORT0_IO = val ? (old & ~0x4) : (old | 0x4);		      \
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/teg.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/teg.h
--- linux-2.6.0-test1-moo/include/asm-v850/teg.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/teg.h	2003-07-15 19:06:37.000000000 +0900
@@ -51,18 +51,18 @@
 
 
 /* TEG UART details.  */
-#define NB85E_UART_BASE_ADDR(n)		(0xFFFFF600 + 0x10 * (n))
-#define NB85E_UART_ASIM_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x0)
-#define NB85E_UART_ASIS_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x2)
-#define NB85E_UART_ASIF_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x4)
-#define NB85E_UART_CKSR_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x6)
-#define NB85E_UART_BRGC_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x8)
-#define NB85E_UART_TXB_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0xA)
-#define NB85E_UART_RXB_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0xC)
-#define NB85E_UART_NUM_CHANNELS		1
-#define NB85E_UART_BASE_FREQ		CPU_CLOCK_FREQ
+#define V850E_UART_BASE_ADDR(n)		(0xFFFFF600 + 0x10 * (n))
+#define V850E_UART_ASIM_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x0)
+#define V850E_UART_ASIS_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x2)
+#define V850E_UART_ASIF_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x4)
+#define V850E_UART_CKSR_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x6)
+#define V850E_UART_BRGC_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x8)
+#define V850E_UART_TXB_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0xA)
+#define V850E_UART_RXB_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0xC)
+#define V850E_UART_NUM_CHANNELS		1
+#define V850E_UART_BASE_FREQ		CPU_CLOCK_FREQ
 /* This is a function that gets called before configuring the UART.  */
-#define NB85E_UART_PRE_CONFIGURE	teg_uart_pre_configure
+#define V850E_UART_PRE_CONFIGURE	teg_uart_pre_configure
 #ifndef __ASSEMBLY__
 extern void teg_uart_pre_configure (unsigned chan,
 				    unsigned cflags, unsigned baud);
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_uart.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uart.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_uart.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uart.h	2003-07-16 18:45:18.000000000 +0900
@@ -0,0 +1,77 @@
+/*
+ * include/asm-v850/v850e_uart.h -- common V850E on-chip UART driver
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
+/* There's not actually a single UART implementation used by V850E CPUs,
+   but rather a series of implementations that are all `close' to one
+   another.  This file corresponds to the single driver which handles all
+   of them.  */
+
+#ifndef __V850_V850E_UART_H__
+#define __V850_V850E_UART_H__
+
+#include <linux/config.h>
+#include <linux/termios.h>
+
+#include <asm/v850e_utils.h>
+#include <asm/types.h>
+#include <asm/machdep.h>	/* Pick up chip-specific defs.  */
+
+
+/* Include model-specific definitions.  */
+#ifdef CONFIG_V850E_UART
+# ifdef CONFIG_V850E_UARTB
+#  include <asm-v850/v850e_uartb.h>
+# else
+#  include <asm-v850/v850e_uarta.h> /* original V850E UART */
+# endif
+#endif
+
+
+/* Optional capabilities some hardware provides.  */
+
+/* This UART doesn't implement RTS/CTS by default, but some platforms
+   implement them externally, so check to see if <asm/machdep.h> defined
+   anything.  */
+#ifdef V850E_UART_CTS
+#define v850e_uart_cts(n)		V850E_UART_CTS(n)
+#else
+#define v850e_uart_cts(n)		(1)
+#endif
+
+/* Do the same for RTS.  */
+#ifdef V850E_UART_SET_RTS
+#define v850e_uart_set_rts(n,v)		V850E_UART_SET_RTS(n,v)
+#else
+#define v850e_uart_set_rts(n,v)		((void)0)
+#endif
+
+
+/* This is the serial channel to use for the boot console (if desired).  */
+#ifndef V850E_UART_CONSOLE_CHANNEL
+# define V850E_UART_CONSOLE_CHANNEL 0
+#endif
+
+
+#ifndef __ASSEMBLY__
+
+/* Setup a console using channel 0 of the builtin uart.  */
+extern void v850e_uart_cons_init (unsigned chan);
+
+/* Configure and turn on uart channel CHAN, using the termios `control
+   modes' bits in CFLAGS, and a baud-rate of BAUD.  */
+void v850e_uart_configure (unsigned chan, unsigned cflags, unsigned baud);
+
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __V850_V850E_UART_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_uarta.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uarta.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_uarta.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uarta.h	2003-07-17 11:08:09.000000000 +0900
@@ -0,0 +1,278 @@
+/*
+ * include/asm-v850/v850e_uarta.h -- original V850E on-chip UART
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
+/* This is the original V850E UART implementation is called just `UART' in
+   the docs, but we name this header file <asm/v850e_uarta.h> because the
+   name <asm/v850e_uart.h> is used for the common driver that handles both
+   `UART' and `UARTB' implementations.  */
+
+#ifndef __V850_V850E_UARTA_H__
+#define __V850_V850E_UARTA_H__
+
+
+/* Raw hardware interface.  */
+
+/* The base address of the UART control registers for channel N.
+   The default is the address used on the V850E/MA1.  */
+#ifndef V850E_UART_BASE_ADDR
+#define V850E_UART_BASE_ADDR(n)		(0xFFFFFA00 + 0x10 * (n))
+#endif 
+
+/* Addresses of specific UART control registers for channel N.
+   The defaults are the addresses used on the V850E/MA1; if a platform
+   wants to redefine any of these, it must redefine them all.  */
+#ifndef V850E_UART_ASIM_ADDR
+#define V850E_UART_ASIM_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x0)
+#define V850E_UART_RXB_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x2)
+#define V850E_UART_ASIS_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x3)
+#define V850E_UART_TXB_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x4)
+#define V850E_UART_ASIF_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x5)
+#define V850E_UART_CKSR_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x6)
+#define V850E_UART_BRGC_ADDR(n)		(V850E_UART_BASE_ADDR(n) + 0x7)
+#endif
+
+/* UART config registers.  */
+#define V850E_UART_ASIM(n)	(*(volatile u8 *)V850E_UART_ASIM_ADDR(n))
+/* Control bits for config registers.  */
+#define V850E_UART_ASIM_CAE	0x80 /* clock enable */
+#define V850E_UART_ASIM_TXE	0x40 /* transmit enable */
+#define V850E_UART_ASIM_RXE	0x20 /* receive enable */
+#define V850E_UART_ASIM_PS_MASK	0x18 /* mask covering parity-select bits */
+#define V850E_UART_ASIM_PS_NONE	0x00 /* no parity */
+#define V850E_UART_ASIM_PS_ZERO	0x08 /* zero parity */
+#define V850E_UART_ASIM_PS_ODD	0x10 /* odd parity */
+#define V850E_UART_ASIM_PS_EVEN	0x18 /* even parity */
+#define V850E_UART_ASIM_CL_8	0x04 /* char len is 8 bits (otherwise, 7) */
+#define V850E_UART_ASIM_SL_2	0x02 /* 2 stop bits (otherwise, 1) */
+#define V850E_UART_ASIM_ISRM	0x01 /* generate INTSR interrupt on errors
+					(otherwise, generate INTSER) */
+
+/* UART serial interface status registers.  */
+#define V850E_UART_ASIS(n)	(*(volatile u8 *)V850E_UART_ASIS_ADDR(n))
+/* Control bits for status registers.  */
+#define V850E_UART_ASIS_PE	0x04 /* parity error */
+#define V850E_UART_ASIS_FE	0x02 /* framing error */
+#define V850E_UART_ASIS_OVE	0x01 /* overrun error */
+
+/* UART serial interface transmission status registers.  */
+#define V850E_UART_ASIF(n)	(*(volatile u8 *)V850E_UART_ASIF_ADDR(n))
+#define V850E_UART_ASIF_TXBF	0x02 /* transmit buffer flag (data in TXB) */
+#define V850E_UART_ASIF_TXSF	0x01 /* transmit shift flag (sending data) */
+
+/* UART receive buffer register.  */
+#define V850E_UART_RXB(n)	(*(volatile u8 *)V850E_UART_RXB_ADDR(n))
+
+/* UART transmit buffer register.  */
+#define V850E_UART_TXB(n)	(*(volatile u8 *)V850E_UART_TXB_ADDR(n))
+
+/* UART baud-rate generator control registers.  */
+#define V850E_UART_CKSR(n)	(*(volatile u8 *)V850E_UART_CKSR_ADDR(n))
+#define V850E_UART_CKSR_MAX	11
+#define V850E_UART_BRGC(n)	(*(volatile u8 *)V850E_UART_BRGC_ADDR(n))
+#define V850E_UART_BRGC_MIN	8
+
+
+#ifndef V850E_UART_CKSR_MAX_FREQ
+#define V850E_UART_CKSR_MAX_FREQ (25*1000*1000)
+#endif
+
+/* Calculate the minimum value for CKSR on this processor.  */
+static inline unsigned v850e_uart_cksr_min (void)
+{
+	int min = 0;
+	unsigned freq = V850E_UART_BASE_FREQ;
+	while (freq > V850E_UART_CKSR_MAX_FREQ) {
+		freq >>= 1;
+		min++;
+	}
+	return min;
+}
+
+
+/* Slightly abstract interface used by driver.  */
+
+
+/* Interrupts used by the UART.  */
+
+/* Received when the most recently transmitted character has been sent.  */
+#define V850E_UART_TX_IRQ(chan)		IRQ_INTST (chan)
+/* Received when a new character has been received.  */
+#define V850E_UART_RX_IRQ(chan)		IRQ_INTSR (chan)
+
+
+/* UART clock generator interface.  */
+
+/* This type encapsulates a particular uart frequency.  */
+typedef struct {
+	unsigned clk_divlog2;
+	unsigned brgen_count;
+} v850e_uart_speed_t;
+
+/* Calculate a uart speed from BAUD for this uart.  */
+static inline v850e_uart_speed_t v850e_uart_calc_speed (unsigned baud)
+{
+	v850e_uart_speed_t speed;
+
+	/* Calculate the log2 clock divider and baud-rate counter values
+	   (note that the UART divides the resulting clock by 2, so
+	   multiply BAUD by 2 here to compensate).  */
+	calc_counter_params (V850E_UART_BASE_FREQ, baud * 2,
+			     v850e_uart_cksr_min(),
+			     V850E_UART_CKSR_MAX, 8/*bits*/,
+			     &speed.clk_divlog2, &speed.brgen_count);
+
+	return speed;
+}
+
+/* Return the current speed of uart channel CHAN.  */
+static inline v850e_uart_speed_t v850e_uart_speed (unsigned chan)
+{
+	v850e_uart_speed_t speed;
+	speed.clk_divlog2 = V850E_UART_CKSR (chan);
+	speed.brgen_count = V850E_UART_BRGC (chan);
+	return speed;
+}
+
+/* Set the current speed of uart channel CHAN.  */
+static inline void v850e_uart_set_speed(unsigned chan,v850e_uart_speed_t speed)
+{
+	V850E_UART_CKSR (chan) = speed.clk_divlog2;
+	V850E_UART_BRGC (chan) = speed.brgen_count;
+}
+
+static inline int
+v850e_uart_speed_eq (v850e_uart_speed_t speed1, v850e_uart_speed_t speed2)
+{
+	return speed1.clk_divlog2 == speed2.clk_divlog2
+		&& speed1.brgen_count == speed2.brgen_count;
+}
+
+/* Minimum baud rate possible.  */
+#define v850e_uart_min_baud() \
+   ((V850E_UART_BASE_FREQ >> V850E_UART_CKSR_MAX) / (2 * 255) + 1)
+
+/* Maximum baud rate possible.  The error is quite high at max, though.  */
+#define v850e_uart_max_baud() \
+   ((V850E_UART_BASE_FREQ >> v850e_uart_cksr_min()) / (2 *V850E_UART_BRGC_MIN))
+
+/* The `maximum' clock rate the uart can used, which is wanted (though not
+   really used in any useful way) by the serial framework.  */
+#define v850e_uart_max_clock() \
+   ((V850E_UART_BASE_FREQ >> v850e_uart_cksr_min()) / 2)
+
+
+/* UART configuration interface.  */
+
+/* Type of the uart config register; must be a scalar.  */
+typedef u16 v850e_uart_config_t;
+
+/* The uart hardware config register for channel CHAN.  */
+#define V850E_UART_CONFIG(chan)		V850E_UART_ASIM (chan)
+
+/* This config bit set if the uart is enabled.  */
+#define V850E_UART_CONFIG_ENABLED	V850E_UART_ASIM_CAE
+/* If the uart _isn't_ enabled, store this value to it to do so.  */
+#define V850E_UART_CONFIG_INIT		V850E_UART_ASIM_CAE
+/* Store this config value to disable the uart channel completely.  */
+#define V850E_UART_CONFIG_FINI		0
+
+/* Setting/clearing these bits enable/disable TX/RX, respectively (but
+   otherwise generally leave things running).  */
+#define V850E_UART_CONFIG_RX_ENABLE	V850E_UART_ASIM_RXE
+#define V850E_UART_CONFIG_TX_ENABLE	V850E_UART_ASIM_TXE
+
+/* These masks define which config bits affect TX/RX modes, respectively.  */
+#define V850E_UART_CONFIG_RX_BITS \
+  (V850E_UART_ASIM_PS_MASK | V850E_UART_ASIM_CL_8 | V850E_UART_ASIM_ISRM)
+#define V850E_UART_CONFIG_TX_BITS \
+  (V850E_UART_ASIM_PS_MASK | V850E_UART_ASIM_CL_8 | V850E_UART_ASIM_SL_2)
+
+static inline v850e_uart_config_t v850e_uart_calc_config (unsigned cflags)
+{
+	v850e_uart_config_t config = 0;
+
+	/* Figure out new configuration of control register.  */
+	if (cflags & CSTOPB)
+		/* Number of stop bits, 1 or 2.  */
+		config |= V850E_UART_ASIM_SL_2;
+	if ((cflags & CSIZE) == CS8)
+		/* Number of data bits, 7 or 8.  */
+		config |= V850E_UART_ASIM_CL_8;
+	if (! (cflags & PARENB))
+		/* No parity check/generation.  */
+		config |= V850E_UART_ASIM_PS_NONE;
+	else if (cflags & PARODD)
+		/* Odd parity check/generation.  */
+		config |= V850E_UART_ASIM_PS_ODD;
+	else
+		/* Even parity check/generation.  */
+		config |= V850E_UART_ASIM_PS_EVEN;
+	if (cflags & CREAD)
+		/* Reading enabled.  */
+		config |= V850E_UART_ASIM_RXE;
+
+	config |= V850E_UART_ASIM_CAE;
+	config |= V850E_UART_ASIM_TXE; /* Writing is always enabled.  */
+	config |= V850E_UART_ASIM_ISRM; /* Errors generate a read-irq.  */
+
+	return config;
+}
+
+/* This should delay as long as necessary for a recently written config
+   setting to settle, before we turn the uart back on.  */
+static inline void
+v850e_uart_config_delay (v850e_uart_config_t config, v850e_uart_speed_t speed)
+{
+	/* The UART may not be reset properly unless we wait at least 2
+	   `basic-clocks' until turning on the TXE/RXE bits again.
+	   A `basic clock' is the clock used by the baud-rate generator,
+	   i.e., the cpu clock divided by the 2^new_clk_divlog2.
+	   The loop takes 2 insns, so loop CYCLES / 2 times.  */
+	register unsigned count = 1 << speed.clk_divlog2;
+	while (--count != 0)
+		/* nothing */;
+}
+
+
+/* RX/TX interface.  */
+
+/* Return true if all characters awaiting transmission on uart channel N
+   have been transmitted.  */
+#define v850e_uart_xmit_done(n)						      \
+   (! (V850E_UART_ASIF(n) & V850E_UART_ASIF_TXBF))
+/* Wait for this to be true.  */
+#define v850e_uart_wait_for_xmit_done(n)				      \
+   do { } while (! v850e_uart_xmit_done (n))
+
+/* Return true if uart channel N is ready to transmit a character.  */
+#define v850e_uart_xmit_ok(n)						      \
+   (v850e_uart_xmit_done(n) && v850e_uart_cts(n))
+/* Wait for this to be true.  */
+#define v850e_uart_wait_for_xmit_ok(n)					      \
+   do { } while (! v850e_uart_xmit_ok (n))
+
+/* Write character CH to uart channel CHAN.  */
+#define v850e_uart_putc(chan, ch)	(V850E_UART_TXB(chan) = (ch))
+
+/* Return latest character read on channel CHAN.  */
+#define v850e_uart_getc(chan)		V850E_UART_RXB (chan)
+
+/* Return bit-mask of uart error status.  */
+#define v850e_uart_err(chan)		V850E_UART_ASIS (chan)
+/* Various error bits set in the error result.  */
+#define V850E_UART_ERR_OVERRUN		V850E_UART_ASIS_OVE
+#define V850E_UART_ERR_FRAME		V850E_UART_ASIS_FE
+#define V850E_UART_ERR_PARITY		V850E_UART_ASIS_PE
+
+
+#endif /* __V850_V850E_UARTA_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_uartb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uartb.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_uartb.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_uartb.h	2003-07-17 11:07:07.000000000 +0900
@@ -0,0 +1,262 @@
+/*
+ * include/asm-v850/v850e_uartb.h -- V850E on-chip `UARTB' UART
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
+/* The V850E UARTB is basically a superset of the original V850E UART, but
+   even where it's the same, the names and details have changed a bit.
+   It's similar enough to use the same driver (v850e_uart.c), but the
+   details have been abstracted slightly to do so.  */
+
+#ifndef __V850_V850E_UARTB_H__
+#define __V850_V850E_UARTB_H__
+
+
+/* Raw hardware interface.  */
+
+#define V850E_UARTB_BASE_ADDR(n)	(0xFFFFFA00 + 0x10 * (n))
+
+/* Addresses of specific UART control registers for channel N.  */
+#define V850E_UARTB_CTL0_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0x0)
+#define V850E_UARTB_CTL2_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0x2)
+#define V850E_UARTB_STR_ADDR(n)		(V850E_UARTB_BASE_ADDR(n) + 0x4)
+#define V850E_UARTB_RX_ADDR(n)		(V850E_UARTB_BASE_ADDR(n) + 0x6)
+#define V850E_UARTB_RXAP_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0x6)
+#define V850E_UARTB_TX_ADDR(n)		(V850E_UARTB_BASE_ADDR(n) + 0x8)
+#define V850E_UARTB_FIC0_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0xA)
+#define V850E_UARTB_FIC1_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0xB)
+#define V850E_UARTB_FIC2_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0xC)
+#define V850E_UARTB_FIS0_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0xE)
+#define V850E_UARTB_FIS1_ADDR(n)	(V850E_UARTB_BASE_ADDR(n) + 0xF)
+
+/* UARTB control register 0 (general config).  */
+#define V850E_UARTB_CTL0(n)	(*(volatile u8 *)V850E_UARTB_CTL0_ADDR(n))
+/* Control bits for config registers.  */
+#define V850E_UARTB_CTL0_PWR		0x80	/* clock enable */
+#define V850E_UARTB_CTL0_TXE		0x40	/* transmit enable */
+#define V850E_UARTB_CTL0_RXE		0x20	/* receive enable */
+#define V850E_UARTB_CTL0_DIR		0x10	/*  */
+#define V850E_UARTB_CTL0_PS1		0x08	/* parity */
+#define V850E_UARTB_CTL0_PS0		0x04	/* parity */
+#define V850E_UARTB_CTL0_CL		0x02	/* char len 1:8bit, 0:7bit */
+#define V850E_UARTB_CTL0_SL		0x01	/* stop bit 1:2bit, 0:1bit */
+#define V850E_UARTB_CTL0_PS_MASK	0x0C	/* mask covering parity bits */
+#define V850E_UARTB_CTL0_PS_NONE	0x00	/* no parity */
+#define V850E_UARTB_CTL0_PS_ZERO	0x04	/* zero parity */
+#define V850E_UARTB_CTL0_PS_ODD		0x08	/* odd parity */
+#define V850E_UARTB_CTL0_PS_EVEN	0x0C	/* even parity */
+#define V850E_UARTB_CTL0_CL_8		0x02	/* char len 1:8bit, 0:7bit */
+#define V850E_UARTB_CTL0_SL_2		0x01	/* stop bit 1:2bit, 0:1bit */
+
+/* UARTB control register 2 (clock divider).  */
+#define V850E_UARTB_CTL2(n)	(*(volatile u16 *)V850E_UARTB_CTL2_ADDR(n))
+#define V850E_UARTB_CTL2_MIN	4
+#define V850E_UARTB_CTL2_MAX	0xFFFF
+
+/* UARTB serial interface status register.  */
+#define V850E_UARTB_STR(n)	(*(volatile u8 *)V850E_UARTB_STR_ADDR(n))
+/* Control bits for status registers.  */
+#define V850E_UARTB_STR_TSF	0x80	/* UBTX or FIFO exist data  */
+#define V850E_UARTB_STR_OVF	0x08	/* overflow error */
+#define V850E_UARTB_STR_PE	0x04	/* parity error */
+#define V850E_UARTB_STR_FE	0x02	/* framing error */
+#define V850E_UARTB_STR_OVE	0x01	/* overrun error */
+
+/* UARTB receive data register.  */
+#define V850E_UARTB_RX(n)	(*(volatile u8 *)V850E_UARTB_RX_ADDR(n))
+#define V850E_UARTB_RXAP(n)	(*(volatile u16 *)V850E_UARTB_RXAP_ADDR(n))
+/* Control bits for status registers.  */
+#define V850E_UARTB_RXAP_PEF	0x0200 /* parity error */
+#define V850E_UARTB_RXAP_FEF	0x0100 /* framing error */
+
+/* UARTB transmit data register.  */
+#define V850E_UARTB_TX(n)	(*(volatile u8 *)V850E_UARTB_TX_ADDR(n))
+
+/* UARTB FIFO control register 0.  */
+#define V850E_UARTB_FIC0(n)	(*(volatile u8 *)V850E_UARTB_FIC0_ADDR(n))
+
+/* UARTB FIFO control register 1.  */
+#define V850E_UARTB_FIC1(n)	(*(volatile u8 *)V850E_UARTB_FIC1_ADDR(n))
+
+/* UARTB FIFO control register 2.  */
+#define V850E_UARTB_FIC2(n)	(*(volatile u16 *)V850E_UARTB_FIC2_ADDR(n))
+
+/* UARTB FIFO status register 0.  */
+#define V850E_UARTB_FIS0(n)	(*(volatile u8 *)V850E_UARTB_FIS0_ADDR(n))
+
+/* UARTB FIFO status register 1.  */
+#define V850E_UARTB_FIS1(n)	(*(volatile u8 *)V850E_UARTB_FIS1_ADDR(n))
+
+
+/* Slightly abstract interface used by driver.  */
+
+
+/* Interrupts used by the UART.  */
+
+/* Received when the most recently transmitted character has been sent.  */
+#define V850E_UART_TX_IRQ(chan)		IRQ_INTUBTIT (chan)
+/* Received when a new character has been received.  */
+#define V850E_UART_RX_IRQ(chan)		IRQ_INTUBTIR (chan)
+
+/* Use by serial driver for information purposes.  */
+#define V850E_UART_BASE_ADDR(chan)	V850E_UARTB_BASE_ADDR(chan)
+
+
+/* UART clock generator interface.  */
+
+/* This type encapsulates a particular uart frequency.  */
+typedef u16 v850e_uart_speed_t;
+
+/* Calculate a uart speed from BAUD for this uart.  */
+static inline v850e_uart_speed_t v850e_uart_calc_speed (unsigned baud)
+{
+	v850e_uart_speed_t speed;
+
+	/*
+	 * V850E/ME2 UARTB baud rate is determined by the value of UBCTL2
+	 * fx = V850E_UARTB_BASE_FREQ = CPU_CLOCK_FREQ/4
+	 * baud = fx / 2*speed   [ speed >= 4 ]
+	 */
+	speed = V850E_UARTB_CTL2_MIN;
+	while (((V850E_UARTB_BASE_FREQ / 2) / speed ) > baud)
+		speed++;
+
+	return speed;
+}
+
+/* Return the current speed of uart channel CHAN.  */
+#define v850e_uart_speed(chan)		    V850E_UARTB_CTL2 (chan)
+
+/* Set the current speed of uart channel CHAN.  */
+#define v850e_uart_set_speed(chan, speed)   (V850E_UARTB_CTL2 (chan) = (speed))
+
+/* Return true if SPEED1 and SPEED2 are the same.  */
+#define v850e_uart_speed_eq(speed1, speed2) ((speed1) == (speed2))
+
+/* Minimum baud rate possible.  */
+#define v850e_uart_min_baud() \
+   ((V850E_UARTB_BASE_FREQ / 2) / V850E_UARTB_CTL2_MAX)
+
+/* Maximum baud rate possible.  The error is quite high at max, though.  */
+#define v850e_uart_max_baud() \
+   ((V850E_UARTB_BASE_FREQ / 2) / V850E_UARTB_CTL2_MIN)
+
+/* The `maximum' clock rate the uart can used, which is wanted (though not
+   really used in any useful way) by the serial framework.  */
+#define v850e_uart_max_clock() \
+   (V850E_UARTB_BASE_FREQ / 2)
+
+
+/* UART configuration interface.  */
+
+/* Type of the uart config register; must be a scalar.  */
+typedef u16 v850e_uart_config_t;
+
+/* The uart hardware config register for channel CHAN.  */
+#define V850E_UART_CONFIG(chan)		V850E_UARTB_CTL0 (chan)
+
+/* This config bit set if the uart is enabled.  */
+#define V850E_UART_CONFIG_ENABLED	V850E_UARTB_CTL0_PWR
+/* If the uart _isn't_ enabled, store this value to it to do so.  */
+#define V850E_UART_CONFIG_INIT		V850E_UARTB_CTL0_PWR
+/* Store this config value to disable the uart channel completely.  */
+#define V850E_UART_CONFIG_FINI		0
+
+/* Setting/clearing these bits enable/disable TX/RX, respectively (but
+   otherwise generally leave things running).  */
+#define V850E_UART_CONFIG_RX_ENABLE	V850E_UARTB_CTL0_RXE
+#define V850E_UART_CONFIG_TX_ENABLE	V850E_UARTB_CTL0_TXE
+
+/* These masks define which config bits affect TX/RX modes, respectively.  */
+#define V850E_UART_CONFIG_RX_BITS \
+  (V850E_UARTB_CTL0_PS_MASK | V850E_UARTB_CTL0_CL_8)
+#define V850E_UART_CONFIG_TX_BITS \
+  (V850E_UARTB_CTL0_PS_MASK | V850E_UARTB_CTL0_CL_8 | V850E_UARTB_CTL0_SL_2)
+
+static inline v850e_uart_config_t v850e_uart_calc_config (unsigned cflags)
+{
+	v850e_uart_config_t config = 0;
+
+	/* Figure out new configuration of control register.  */
+	if (cflags & CSTOPB)
+		/* Number of stop bits, 1 or 2.  */
+		config |= V850E_UARTB_CTL0_SL_2;
+	if ((cflags & CSIZE) == CS8)
+		/* Number of data bits, 7 or 8.  */
+		config |= V850E_UARTB_CTL0_CL_8;
+	if (! (cflags & PARENB))
+		/* No parity check/generation.  */
+		config |= V850E_UARTB_CTL0_PS_NONE;
+	else if (cflags & PARODD)
+		/* Odd parity check/generation.  */
+		config |= V850E_UARTB_CTL0_PS_ODD;
+	else
+		/* Even parity check/generation.  */
+		config |= V850E_UARTB_CTL0_PS_EVEN;
+	if (cflags & CREAD)
+		/* Reading enabled.  */
+		config |= V850E_UARTB_CTL0_RXE;
+
+	config |= V850E_UARTB_CTL0_PWR;
+	config |= V850E_UARTB_CTL0_TXE; /* Writing is always enabled.  */
+	config |= V850E_UARTB_CTL0_DIR; /* LSB first.  */
+
+	return config;
+}
+
+/* This should delay as long as necessary for a recently written config
+   setting to settle, before we turn the uart back on.  */
+static inline void
+v850e_uart_config_delay (v850e_uart_config_t config, v850e_uart_speed_t speed)
+{
+	/* The UART may not be reset properly unless we wait at least 2
+	   `basic-clocks' until turning on the TXE/RXE bits again.
+	   A `basic clock' is the clock used by the baud-rate generator,
+	   i.e., the cpu clock divided by the 2^new_clk_divlog2.
+	   The loop takes 2 insns, so loop CYCLES / 2 times.  */
+	register unsigned count = 1 << speed;
+	while (--count != 0)
+		/* nothing */;
+}
+
+
+/* RX/TX interface.  */
+
+/* Return true if all characters awaiting transmission on uart channel N
+   have been transmitted.  */
+#define v850e_uart_xmit_done(n)						      \
+   (! (V850E_UARTB_STR(n) & V850E_UARTB_STR_TSF))
+/* Wait for this to be true.  */
+#define v850e_uart_wait_for_xmit_done(n)				      \
+   do { } while (! v850e_uart_xmit_done (n))
+
+/* Return true if uart channel N is ready to transmit a character.  */
+#define v850e_uart_xmit_ok(n)						      \
+   (v850e_uart_xmit_done(n) && v850e_uart_cts(n))
+/* Wait for this to be true.  */
+#define v850e_uart_wait_for_xmit_ok(n)					      \
+   do { } while (! v850e_uart_xmit_ok (n))
+
+/* Write character CH to uart channel CHAN.  */
+#define v850e_uart_putc(chan, ch)	(V850E_UARTB_TX(chan) = (ch))
+
+/* Return latest character read on channel CHAN.  */
+#define v850e_uart_getc(chan)		V850E_UARTB_RX (chan)
+
+/* Return bit-mask of uart error status.  */
+#define v850e_uart_err(chan)		V850E_UARTB_STR (chan)
+/* Various error bits set in the error result.  */
+#define V850E_UART_ERR_OVERRUN		V850E_UARTB_STR_OVE
+#define V850E_UART_ERR_FRAME		V850E_UARTB_STR_FE
+#define V850E_UART_ERR_PARITY		V850E_UARTB_STR_PE
+
+
+#endif /* __V850_V850E_UARTB_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/drivers/serial/Kconfig linux-2.6.0-test1-moo-v850-20030718/drivers/serial/Kconfig
--- linux-2.6.0-test1-moo/drivers/serial/Kconfig	2003-07-03 13:07:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/drivers/serial/Kconfig	2003-07-16 17:34:06.000000000 +0900
@@ -404,14 +404,19 @@
 	  on your Sparc system as the console, you can do so by answering
 	  Y to this option.
 
-config V850E_NB85E_UART
+config V850E_UART
 	bool "NEC V850E on-chip UART support"
-	depends on V850E_NB85E || V850E2_ANNA || V850E_AS85EP1
+	depends on V850E_MA1 || V850E_ME2 || V850E_TEG || V850E2_ANNA || V850E_AS85EP1
 	default y
 
-config V850E_NB85E_UART_CONSOLE
+config V850E_UARTB
+        bool
+	depends V850E_UART && V850E_ME2
+	default y
+
+config V850E_UART_CONSOLE
 	bool "Use NEC V850E on-chip UART for console"
-	depends on V850E_NB85E_UART
+	depends on V850E_UART
 
 config SERIAL98
 	tristate "PC-9800 8251-based primary serial port support"
@@ -426,12 +431,12 @@
 
 config SERIAL_CORE
 	tristate
-	default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && !SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_MUX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_NB85E_UART && (SERIAL_AMBA=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m || SERIAL98=m)
-	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_MUX=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_NB85E_UART || SERIAL98=y
+	default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && !SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_MUX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_UART && (SERIAL_AMBA=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m || SERIAL98=m)
+	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_MUX=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_UART || SERIAL98=y
 
 config SERIAL_CORE_CONSOLE
 	bool
-	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_MUX_CONSOLE || SERIAL_SUNZILOG_CONSOLE || SERIAL_SUNSU_CONSOLE || SERIAL_SUNSAB_CONSOLE || V850E_NB85E_UART_CONSOLE || SERIAL98_CONSOLE
+	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_MUX_CONSOLE || SERIAL_SUNZILOG_CONSOLE || SERIAL_SUNSU_CONSOLE || SERIAL_SUNSAB_CONSOLE || V850E_UART_CONSOLE || SERIAL98_CONSOLE
 	default y
 
 config SERIAL_68328
diff -ruN -X../cludes linux-2.6.0-test1-moo/drivers/serial/Makefile linux-2.6.0-test1-moo-v850-20030718/drivers/serial/Makefile
--- linux-2.6.0-test1-moo/drivers/serial/Makefile	2003-06-23 14:50:21.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/drivers/serial/Makefile	2003-07-15 19:23:50.000000000 +0900
@@ -29,5 +29,5 @@
 obj-$(CONFIG_SERIAL_68328) += 68328serial.o
 obj-$(CONFIG_SERIAL_68360) += 68360serial.o
 obj-$(CONFIG_SERIAL_COLDFIRE) += mcfserial.o
-obj-$(CONFIG_V850E_NB85E_UART) += nb85e_uart.o
+obj-$(CONFIG_V850E_UART) += v850e_uart.o
 obj-$(CONFIG_SERIAL98) += serial98.o
diff -ruN -X../cludes linux-2.6.0-test1-moo/drivers/serial/nb85e_uart.c linux-2.6.0-test1-moo-v850-20030718/drivers/serial/nb85e_uart.c
--- linux-2.6.0-test1-moo/drivers/serial/nb85e_uart.c	2003-06-16 14:52:46.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/drivers/serial/nb85e_uart.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,610 +0,0 @@
-/*
- * drivers/serial/nb85e_uart.c -- Serial I/O using V850E/NB85E on-chip UART
- *
- *  Copyright (C) 2001,02,03  NEC Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/console.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-
-#include <asm/nb85e_uart.h>
-#include <asm/nb85e_utils.h>
-
-/* Initial UART state.  This may be overridden by machine-dependent headers. */
-#ifndef NB85E_UART_INIT_BAUD
-#define NB85E_UART_INIT_BAUD	115200
-#endif
-#ifndef NB85E_UART_INIT_CFLAGS
-#define NB85E_UART_INIT_CFLAGS	(B115200 | CS8 | CREAD)
-#endif
-
-/* XXX This should be in a header file.  */
-#define NB85E_UART_BRGC_MIN	8
-
-/* A string used for prefixing printed descriptions; since the same UART
-   macro is actually used on other chips than the V850E/NB85E.  This must
-   be a constant string.  */
-#ifndef NB85E_UART_CHIP_NAME
-#define NB85E_UART_CHIP_NAME "V850E/NB85E"
-#endif
-
-
-/* Helper functions for doing baud-rate/frequency calculations.  */
-
-/* Calculate the minimum value for CKSR on this processor.  */
-static inline unsigned cksr_min (void)
-{
-	int min = 0;
-	unsigned freq = NB85E_UART_BASE_FREQ;
-	while (freq > NB85E_UART_CKSR_MAX_FREQ) {
-		freq >>= 1;
-		min++;
-	}
-	return min;
-}
-
-/* Minimum baud rate possible.  */
-#define min_baud() \
-   ((NB85E_UART_BASE_FREQ >> NB85E_UART_CKSR_MAX) / (2 * 255) + 1)
-
-/* Maximum baud rate possible.  The error is quite high at max, though.  */
-#define max_baud() \
-   ((NB85E_UART_BASE_FREQ >> cksr_min()) / (2 * NB85E_UART_BRGC_MIN))
-
-
-/* Low-level UART functions.  */
-
-/* These masks define which control bits affect TX/RX modes, respectively.  */
-#define RX_BITS \
-  (NB85E_UART_ASIM_PS_MASK | NB85E_UART_ASIM_CL_8 | NB85E_UART_ASIM_ISRM)
-#define TX_BITS \
-  (NB85E_UART_ASIM_PS_MASK | NB85E_UART_ASIM_CL_8 | NB85E_UART_ASIM_SL_2)
-
-/* The UART require various delays after writing control registers.  */
-static inline void nb85e_uart_delay (unsigned cycles)
-{
-	/* The loop takes 2 insns, so loop CYCLES / 2 times.  */
-	register unsigned count = cycles >> 1;
-	while (--count != 0)
-		/* nothing */;
-}
-
-/* Configure and turn on uart channel CHAN, using the termios `control
-   modes' bits in CFLAGS, and a baud-rate of BAUD.  */
-void nb85e_uart_configure (unsigned chan, unsigned cflags, unsigned baud)
-{
-	int flags;
-	unsigned new_config = 0; /* What we'll write to the control reg. */
-	unsigned new_clk_divlog2; /* New baud-rate generate clock divider. */
-	unsigned new_brgen_count; /* New counter max for baud-rate generator.*/
-	/* These are the current values corresponding to the above.  */
-	unsigned old_config, old_clk_divlog2, old_brgen_count;
-
-	/* Calculate new baud-rate generator config values.  */
-
-	/* Calculate the log2 clock divider and baud-rate counter values
-	   (note that the UART divides the resulting clock by 2, so
-	   multiply BAUD by 2 here to compensate).  */
-	calc_counter_params (NB85E_UART_BASE_FREQ, baud * 2,
-			     cksr_min(), NB85E_UART_CKSR_MAX, 8/*bits*/,
-			     &new_clk_divlog2, &new_brgen_count);
-
-	/* Figure out new configuration of control register.  */
-	if (cflags & CSTOPB)
-		/* Number of stop bits, 1 or 2.  */
-		new_config |= NB85E_UART_ASIM_SL_2;
-	if ((cflags & CSIZE) == CS8)
-		/* Number of data bits, 7 or 8.  */
-		new_config |= NB85E_UART_ASIM_CL_8;
-	if (! (cflags & PARENB))
-		/* No parity check/generation.  */
-		new_config |= NB85E_UART_ASIM_PS_NONE;
-	else if (cflags & PARODD)
-		/* Odd parity check/generation.  */
-		new_config |= NB85E_UART_ASIM_PS_ODD;
-	else
-		/* Even parity check/generation.  */
-		new_config |= NB85E_UART_ASIM_PS_EVEN;
-	if (cflags & CREAD)
-		/* Reading enabled.  */
-		new_config |= NB85E_UART_ASIM_RXE;
-
-	new_config |= NB85E_UART_ASIM_TXE; /* Writing is always enabled.  */
-	new_config |= NB85E_UART_ASIM_CAE;
-	new_config |= NB85E_UART_ASIM_ISRM; /* Errors generate a read-irq.  */
-
-	/* Disable interrupts while we're twiddling the hardware.  */
-	local_irq_save (flags);
-
-#ifdef NB85E_UART_PRE_CONFIGURE
-	NB85E_UART_PRE_CONFIGURE (chan, cflags, baud);
-#endif
-
-	old_config = NB85E_UART_ASIM (chan);
-	old_clk_divlog2 = NB85E_UART_CKSR (chan);
-	old_brgen_count = NB85E_UART_BRGC (chan);
-
-	if (new_clk_divlog2 != old_clk_divlog2
-	    || new_brgen_count != old_brgen_count)
-	{
-		/* The baud rate has changed.  First, disable the UART.  */
-		NB85E_UART_ASIM (chan) = 0;
-		old_config = 0;
-		/* Reprogram the baud-rate generator.  */
-		NB85E_UART_CKSR (chan) = new_clk_divlog2;
-		NB85E_UART_BRGC (chan) = new_brgen_count;
-	}
-
-	if (! (old_config & NB85E_UART_ASIM_CAE)) {
-		/* If we are enabling the uart for the first time, start
-		   by turning on the enable bit, which must be done
-		   before turning on any other bits.  */
-		NB85E_UART_ASIM (chan) = NB85E_UART_ASIM_CAE;
-		/* Enabling the uart also resets it.  */
-		old_config = NB85E_UART_ASIM_CAE;
-	}
-
-	if (new_config != old_config) {
-		/* Which of the TXE/RXE bits we'll temporarily turn off
-		   before changing other control bits.  */
-		unsigned temp_disable = 0;
-		/* Which of the TXE/RXE bits will be enabled.  */
-		unsigned enable = 0;
-		unsigned changed_bits = new_config ^ old_config;
-
-		/* Which of RX/TX will be enabled in the new configuration.  */
-		if (new_config & RX_BITS)
-			enable |= (new_config & NB85E_UART_ASIM_RXE);
-		if (new_config & TX_BITS)
-			enable |= (new_config & NB85E_UART_ASIM_TXE);
-
-		/* Figure out which of RX/TX needs to be disabled; note
-		   that this will only happen if they're not already
-		   disabled.  */
-		if (changed_bits & RX_BITS)
-			temp_disable |= (old_config & NB85E_UART_ASIM_RXE);
-		if (changed_bits & TX_BITS)
-			temp_disable |= (old_config & NB85E_UART_ASIM_TXE);
-
-		/* We have to turn off RX and/or TX mode before changing
-		   any associated control bits.  */
-		if (temp_disable)
-			NB85E_UART_ASIM (chan) = old_config & ~temp_disable;
-
-		/* Write the new control bits, while RX/TX are disabled. */ 
-		if (changed_bits & ~enable)
-			NB85E_UART_ASIM (chan) = new_config & ~enable;
-
-		/* The UART may not be reset properly unless we
-		   wait at least 2 `basic-clocks' until turning
-		   on the TXE/RXE bits again.  A `basic clock'
-		   is the clock used by the baud-rate generator, i.e.,
-		   the cpu clock divided by the 2^new_clk_divlog2.  */
-		nb85e_uart_delay (1 << (new_clk_divlog2 + 1));
-
-		/* Write the final version, with enable bits turned on.  */
-		NB85E_UART_ASIM (chan) = new_config;
-	}
-
-	local_irq_restore (flags);
-}
-
-
-/*  Low-level console. */
-
-#ifdef CONFIG_V850E_NB85E_UART_CONSOLE
-
-static void nb85e_uart_cons_write (struct console *co,
-				   const char *s, unsigned count)
-{
-	if (count > 0) {
-		unsigned chan = co->index;
-		unsigned irq = IRQ_INTST (chan);
-		int irq_was_enabled, irq_was_pending, flags;
-
-		/* We don't want to get `transmission completed' (INTST)
-		   interrupts, since we're busy-waiting, so we disable
-		   them while sending (we don't disable interrupts
-		   entirely because sending over a serial line is really
-		   slow).  We save the status of INTST and restore it
-		   when we're done so that using printk doesn't
-		   interfere with normal serial transmission (other than
-		   interleaving the output, of course!).  This should
-		   work correctly even if this function is interrupted
-		   and the interrupt printks something.  */
-
-		/* Disable interrupts while fiddling with INTST.  */
-		local_irq_save (flags);
-		/* Get current INTST status.  */
-		irq_was_enabled = nb85e_intc_irq_enabled (irq);
-		irq_was_pending = nb85e_intc_irq_pending (irq);
-		/* Disable INTST if necessary.  */
-		if (irq_was_enabled)
-			nb85e_intc_disable_irq (irq);
-		/* Turn interrupts back on.  */
-		local_irq_restore (flags);
-
-		/* Send characters.  */
-		while (count > 0) {
-			int ch = *s++;
-
-			if (ch == '\n') {
-				/* We don't have the benefit of a tty
-				   driver, so translate NL into CR LF.  */
-				nb85e_uart_wait_for_xmit_ok (chan);
-				nb85e_uart_putc (chan, '\r');
-			}
-
-			nb85e_uart_wait_for_xmit_ok (chan);
-			nb85e_uart_putc (chan, ch);
-
-			count--;
-		}
-
-		/* Restore saved INTST status.  */
-		if (irq_was_enabled) {
-			/* Wait for the last character we sent to be
-			   completely transmitted (as we'll get an INTST
-			   interrupt at that point).  */
-			nb85e_uart_wait_for_xmit_done (chan);
-			/* Clear pending interrupts received due
-			   to our transmission, unless there was already
-			   one pending, in which case we want the
-			   handler to be called.  */
-			if (! irq_was_pending)
-				nb85e_intc_clear_pending_irq (irq);
-			/* ... and then turn back on handling.  */
-			nb85e_intc_enable_irq (irq);
-		}
-	}
-}
-
-extern struct uart_driver nb85e_uart_driver;
-static struct console nb85e_uart_cons =
-{
-    .name	= "ttyS",
-    .write	= nb85e_uart_cons_write,
-    .device	= uart_console_device,
-    .flags	= CON_PRINTBUFFER,
-    .cflag	= NB85E_UART_INIT_CFLAGS,
-    .index	= -1,
-    .data	= &nb85e_uart_driver,
-};
-
-void nb85e_uart_cons_init (unsigned chan)
-{
-	nb85e_uart_configure (chan, NB85E_UART_INIT_CFLAGS,
-			      NB85E_UART_INIT_BAUD);
-	nb85e_uart_cons.index = chan;
-	register_console (&nb85e_uart_cons);
-	printk ("Console: %s on-chip UART channel %d\n",
-		NB85E_UART_CHIP_NAME, chan);
-}
-
-#define NB85E_UART_CONSOLE &nb85e_uart_cons
-
-#else /* !CONFIG_V850E_NB85E_UART_CONSOLE */
-#define NB85E_UART_CONSOLE 0
-#endif /* CONFIG_V850E_NB85E_UART_CONSOLE */
-
-/* TX/RX interrupt handlers.  */
-
-static void nb85e_uart_stop_tx (struct uart_port *port, unsigned tty_stop);
-
-void nb85e_uart_tx (struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->info->xmit;
-	int stopped = uart_tx_stopped (port);
-
-	if (nb85e_uart_xmit_ok (port->line)) {
-		int tx_ch;
-
-		if (port->x_char) {
-			tx_ch = port->x_char;
-			port->x_char = 0;
-		} else if (!uart_circ_empty (xmit) && !stopped) {
-			tx_ch = xmit->buf[xmit->tail];
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		} else
-			goto no_xmit;
-
-		nb85e_uart_putc (port->line, tx_ch);
-		port->icount.tx++;
-
-		if (uart_circ_chars_pending (xmit) < WAKEUP_CHARS)
-			uart_write_wakeup (port);
-	}
-
- no_xmit:
-	if (uart_circ_empty (xmit) || stopped)
-		nb85e_uart_stop_tx (port, stopped);
-}
-
-static void nb85e_uart_tx_irq (int irq, void *data, struct pt_regs *regs)
-{
-	struct uart_port *port = data;
-	nb85e_uart_tx (port);
-}
-
-static void nb85e_uart_rx_irq (int irq, void *data, struct pt_regs *regs)
-{
-	struct uart_port *port = data;
-	unsigned ch_stat = TTY_NORMAL;
-	unsigned ch = NB85E_UART_RXB (port->line);
-	unsigned err = NB85E_UART_ASIS (port->line);
-
-	if (err) {
-		if (err & NB85E_UART_ASIS_OVE) {
-			ch_stat = TTY_OVERRUN;
-			port->icount.overrun++;
-		} else if (err & NB85E_UART_ASIS_FE) {
-			ch_stat = TTY_FRAME;
-			port->icount.frame++;
-		} else if (err & NB85E_UART_ASIS_PE) {
-			ch_stat = TTY_PARITY;
-			port->icount.parity++;
-		}
-	}
-
-	port->icount.rx++;
-
-	tty_insert_flip_char (port->info->tty, ch, ch_stat);
-	tty_schedule_flip (port->info->tty);
-}
-
-/* Control functions for the serial framework.  */
-
-static void nb85e_uart_nop (struct uart_port *port) { }
-static int nb85e_uart_success (struct uart_port *port) { return 0; }
-
-static unsigned nb85e_uart_tx_empty (struct uart_port *port)
-{
-	return TIOCSER_TEMT;	/* Can't detect.  */
-}
-
-static void nb85e_uart_set_mctrl (struct uart_port *port, unsigned mctrl)
-{
-#ifdef NB85E_UART_SET_RTS
-	NB85E_UART_SET_RTS (port->line, (mctrl & TIOCM_RTS));
-#endif
-}
-
-static unsigned nb85e_uart_get_mctrl (struct uart_port *port)
-{
-	/* We don't support DCD or DSR, so consider them permanently active. */
-	int mctrl = TIOCM_CAR | TIOCM_DSR;
-
-	/* We may support CTS.  */
-#ifdef NB85E_UART_CTS
-	mctrl |= NB85E_UART_CTS(port->line) ? TIOCM_CTS : 0;
-#else
-	mctrl |= TIOCM_CTS;
-#endif
-
-	return mctrl;
-}
-
-static void nb85e_uart_start_tx (struct uart_port *port, unsigned tty_start)
-{
-	nb85e_intc_disable_irq (IRQ_INTST (port->line));
-	nb85e_uart_tx (port);
-	nb85e_intc_enable_irq (IRQ_INTST (port->line));
-}
-
-static void nb85e_uart_stop_tx (struct uart_port *port, unsigned tty_stop)
-{
-	nb85e_intc_disable_irq (IRQ_INTST (port->line));
-}
-
-static void nb85e_uart_start_rx (struct uart_port *port)
-{
-	nb85e_intc_enable_irq (IRQ_INTSR (port->line));
-}
-
-static void nb85e_uart_stop_rx (struct uart_port *port)
-{
-	nb85e_intc_disable_irq (IRQ_INTSR (port->line));
-}
-
-static void nb85e_uart_break_ctl (struct uart_port *port, int break_ctl)
-{
-	/* Umm, do this later.  */
-}
-
-static int nb85e_uart_startup (struct uart_port *port)
-{
-	int err;
-
-	/* Alloc RX irq.  */
-	err = request_irq (IRQ_INTSR (port->line), nb85e_uart_rx_irq,
-			   SA_INTERRUPT, "nb85e_uart", port);
-	if (err)
-		return err;
-
-	/* Alloc TX irq.  */
-	err = request_irq (IRQ_INTST (port->line), nb85e_uart_tx_irq,
-			   SA_INTERRUPT, "nb85e_uart", port);
-	if (err) {
-		free_irq (IRQ_INTSR (port->line), port);
-		return err;
-	}
-
-	nb85e_uart_start_rx (port);
-
-	return 0;
-}
-
-static void nb85e_uart_shutdown (struct uart_port *port)
-{
-	/* Disable port interrupts.  */
-	free_irq (IRQ_INTST (port->line), port);
-	free_irq (IRQ_INTSR (port->line), port);
-
-	/* Turn off xmit/recv enable bits.  */
-	NB85E_UART_ASIM (port->line)
-		&= ~(NB85E_UART_ASIM_TXE | NB85E_UART_ASIM_RXE);
-	/* Then reset the channel.  */
-	NB85E_UART_ASIM (port->line) = 0;
-}
-
-static void
-nb85e_uart_set_termios (struct uart_port *port, struct termios *termios,
-		        struct termios *old)
-{
-	unsigned cflags = termios->c_cflag;
-
-	/* Restrict flags to legal values.  */
-	if ((cflags & CSIZE) != CS7 && (cflags & CSIZE) != CS8)
-		/* The new value of CSIZE is invalid, use the old value.  */
-		cflags = (cflags & ~CSIZE)
-			| (old ? (old->c_cflag & CSIZE) : CS8);
-
-	termios->c_cflag = cflags;
-
-	nb85e_uart_configure (port->line, cflags,
-			      uart_get_baud_rate (port, termios, old,
-						  min_baud(), max_baud()));
-}
-
-static const char *nb85e_uart_type (struct uart_port *port)
-{
-	return port->type == PORT_NB85E_UART ? "nb85e_uart" : 0;
-}
-
-static void nb85e_uart_config_port (struct uart_port *port, int flags)
-{
-	if (flags & UART_CONFIG_TYPE)
-		port->type = PORT_NB85E_UART;
-}
-
-static int
-nb85e_uart_verify_port (struct uart_port *port, struct serial_struct *ser)
-{
-	if (ser->type != PORT_UNKNOWN && ser->type != PORT_NB85E_UART)
-		return -EINVAL;
-	if (ser->irq != IRQ_INTST (port->line))
-		return -EINVAL;
-	return 0;
-}
-
-static struct uart_ops nb85e_uart_ops = {
-	.tx_empty	= nb85e_uart_tx_empty,
-	.get_mctrl	= nb85e_uart_get_mctrl,
-	.set_mctrl	= nb85e_uart_set_mctrl,
-	.start_tx	= nb85e_uart_start_tx,
-	.stop_tx	= nb85e_uart_stop_tx,
-	.stop_rx	= nb85e_uart_stop_rx,
-	.enable_ms	= nb85e_uart_nop,
-	.break_ctl	= nb85e_uart_break_ctl,
-	.startup	= nb85e_uart_startup,
-	.shutdown	= nb85e_uart_shutdown,
-	.set_termios	= nb85e_uart_set_termios,
-	.type		= nb85e_uart_type,
-	.release_port	= nb85e_uart_nop,
-	.request_port	= nb85e_uart_success,
-	.config_port	= nb85e_uart_config_port,
-	.verify_port	= nb85e_uart_verify_port,
-};
-
-/* Initialization and cleanup.  */
-
-static struct uart_driver nb85e_uart_driver = {
-	.owner			= THIS_MODULE,
-	.driver_name		= "nb85e_uart",
-	.devfs_name		= "tts/",
-	.dev_name		= "ttyS",
-	.major			= TTY_MAJOR,
-	.minor			= NB85E_UART_MINOR_BASE,
-	.nr			= NB85E_UART_NUM_CHANNELS,
-	.cons			= NB85E_UART_CONSOLE,
-};
-
-
-static struct uart_port nb85e_uart_ports[NB85E_UART_NUM_CHANNELS];
-
-static int __init nb85e_uart_init (void)
-{
-	int rval;
-
-	printk (KERN_INFO "%s on-chip UART\n", NB85E_UART_CHIP_NAME);
-
-	rval = uart_register_driver (&nb85e_uart_driver);
-	if (rval == 0) {
-		unsigned chan;
-
-		for (chan = 0; chan < NB85E_UART_NUM_CHANNELS; chan++) {
-			struct uart_port *port = &nb85e_uart_ports[chan];
-			
-			memset (port, 0, sizeof *port);
-
-			port->ops = &nb85e_uart_ops;
-			port->line = chan;
-			port->iotype = SERIAL_IO_MEM;
-			port->flags = UPF_BOOT_AUTOCONF;
-
-			/* We actually use multiple IRQs, but the serial
-			   framework seems to mainly use this for
-			   informational purposes anyway.  Here we use the TX
-			   irq.  */
-			port->irq = IRQ_INTST (chan);
-
-			/* The serial framework doesn't really use these
-			   membase/mapbase fields for anything useful, but
-			   it requires that they be something non-zero to
-			   consider the port `valid', and also uses them
-			   for informational purposes.  */
-			port->membase = (void *)NB85E_UART_BASE_ADDR (chan);
-			port->mapbase = NB85E_UART_BASE_ADDR (chan);
-
-			/* The framework insists on knowing the uart's master
-			   clock freq, though it doesn't seem to do anything
-			   useful for us with it.  We must make it at least
-			   higher than (the maximum baud rate * 16), otherwise
-			   the framework will puke during its internal
-			   calculations, and force the baud rate to be 9600.
-			   To be accurate though, just repeat the calculation
-			   we use when actually setting the speed.
-
-			   The `* 8' means `* 16 / 2':  16 to account for for
-			   the serial framework's built-in bias, and 2 because
-			   there's an additional / 2 in the hardware.  */
-			port->uartclk =
-				(NB85E_UART_BASE_FREQ >> cksr_min()) * 8;
-
-			uart_add_one_port (&nb85e_uart_driver, port);
-		}
-	}
-
-	return rval;
-}
-
-static void __exit nb85e_uart_exit (void)
-{
-	unsigned chan;
-
-	for (chan = 0; chan < NB85E_UART_NUM_CHANNELS; chan++)
-		uart_remove_one_port (&nb85e_uart_driver,
-				      &nb85e_uart_ports[chan]);
-
-	uart_unregister_driver (&nb85e_uart_driver);
-}
-
-module_init (nb85e_uart_init);
-module_exit (nb85e_uart_exit);
-
-MODULE_AUTHOR ("Miles Bader");
-MODULE_DESCRIPTION ("NEC " NB85E_UART_CHIP_NAME " on-chip UART");
-MODULE_LICENSE ("GPL");
diff -ruN -X../cludes linux-2.6.0-test1-moo/drivers/serial/v850e_uart.c linux-2.6.0-test1-moo-v850-20030718/drivers/serial/v850e_uart.c
--- linux-2.6.0-test1-moo/drivers/serial/v850e_uart.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/drivers/serial/v850e_uart.c	2003-07-17 11:04:06.000000000 +0900
@@ -0,0 +1,549 @@
+/*
+ * drivers/serial/v850e_uart.c -- Serial I/O using V850E on-chip UART or UARTB
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
+/* This driver supports both the original V850E UART interface (called
+   merely `UART' in the docs) and the newer `UARTB' interface, which is
+   roughly a superset of the first one.  The selection is made at
+   configure time -- if CONFIG_V850E_UARTB is defined, then UARTB is
+   presumed, otherwise the old UART -- as these are on-CPU UARTS, a system
+   can never have both.
+
+   The UARTB interface also has a 16-entry FIFO mode, which is not
+   yet supported by this driver.  */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/v850e_uart.h>
+
+/* Initial UART state.  This may be overridden by machine-dependent headers. */
+#ifndef V850E_UART_INIT_BAUD
+#define V850E_UART_INIT_BAUD	115200
+#endif
+#ifndef V850E_UART_INIT_CFLAGS
+#define V850E_UART_INIT_CFLAGS	(B115200 | CS8 | CREAD)
+#endif
+
+/* A string used for prefixing printed descriptions; since the same UART
+   macro is actually used on other chips than the V850E.  This must be a
+   constant string.  */
+#ifndef V850E_UART_CHIP_NAME
+#define V850E_UART_CHIP_NAME	"V850E"
+#endif
+
+#define V850E_UART_MINOR_BASE	64	   /* First tty minor number */
+
+
+/* Low-level UART functions.  */
+
+/* Configure and turn on uart channel CHAN, using the termios `control
+   modes' bits in CFLAGS, and a baud-rate of BAUD.  */
+void v850e_uart_configure (unsigned chan, unsigned cflags, unsigned baud)
+{
+	int flags;
+	v850e_uart_speed_t old_speed;
+	v850e_uart_config_t old_config;
+	v850e_uart_speed_t new_speed = v850e_uart_calc_speed (baud);
+	v850e_uart_config_t new_config = v850e_uart_calc_config (cflags);
+
+	/* Disable interrupts while we're twiddling the hardware.  */
+	local_irq_save (flags);
+
+#ifdef V850E_UART_PRE_CONFIGURE
+	V850E_UART_PRE_CONFIGURE (chan, cflags, baud);
+#endif
+
+	old_config = V850E_UART_CONFIG (chan);
+	old_speed = v850e_uart_speed (chan);
+
+	if (! v850e_uart_speed_eq (old_speed, new_speed)) {
+		/* The baud rate has changed.  First, disable the UART.  */
+		V850E_UART_CONFIG (chan) = V850E_UART_CONFIG_FINI;
+		old_config = 0;	/* Force the uart to be re-initialized. */
+
+		/* Reprogram the baud-rate generator.  */
+		v850e_uart_set_speed (chan, new_speed);
+	}
+
+	if (! (old_config & V850E_UART_CONFIG_ENABLED)) {
+		/* If we are using the uart for the first time, start by
+		   enabling it, which must be done before turning on any
+		   other bits.  */
+		V850E_UART_CONFIG (chan) = V850E_UART_CONFIG_INIT;
+		/* See the initial state.  */
+		old_config = V850E_UART_CONFIG (chan);
+	}
+
+	if (new_config != old_config) {
+		/* Which of the TXE/RXE bits we'll temporarily turn off
+		   before changing other control bits.  */
+		unsigned temp_disable = 0;
+		/* Which of the TXE/RXE bits will be enabled.  */
+		unsigned enable = 0;
+		unsigned changed_bits = new_config ^ old_config;
+
+		/* Which of RX/TX will be enabled in the new configuration.  */
+		if (new_config & V850E_UART_CONFIG_RX_BITS)
+			enable |= (new_config & V850E_UART_CONFIG_RX_ENABLE);
+		if (new_config & V850E_UART_CONFIG_TX_BITS)
+			enable |= (new_config & V850E_UART_CONFIG_TX_ENABLE);
+
+		/* Figure out which of RX/TX needs to be disabled; note
+		   that this will only happen if they're not already
+		   disabled.  */
+		if (changed_bits & V850E_UART_CONFIG_RX_BITS)
+			temp_disable
+				|= (old_config & V850E_UART_CONFIG_RX_ENABLE);
+		if (changed_bits & V850E_UART_CONFIG_TX_BITS)
+			temp_disable
+				|= (old_config & V850E_UART_CONFIG_TX_ENABLE);
+
+		/* We have to turn off RX and/or TX mode before changing
+		   any associated control bits.  */
+		if (temp_disable)
+			V850E_UART_CONFIG (chan) = old_config & ~temp_disable;
+
+		/* Write the new control bits, while RX/TX are disabled. */ 
+		if (changed_bits & ~enable)
+			V850E_UART_CONFIG (chan) = new_config & ~enable;
+
+		v850e_uart_config_delay (new_config, new_speed);
+
+		/* Write the final version, with enable bits turned on.  */
+		V850E_UART_CONFIG (chan) = new_config;
+	}
+
+	local_irq_restore (flags);
+}
+
+
+/*  Low-level console. */
+
+#ifdef CONFIG_V850E_UART_CONSOLE
+
+static void v850e_uart_cons_write (struct console *co,
+				   const char *s, unsigned count)
+{
+	if (count > 0) {
+		unsigned chan = co->index;
+		unsigned irq = V850E_UART_TX_IRQ (chan);
+		int irq_was_enabled, irq_was_pending, flags;
+
+		/* We don't want to get `transmission completed'
+		   interrupts, since we're busy-waiting, so we disable them
+		   while sending (we don't disable interrupts entirely
+		   because sending over a serial line is really slow).  We
+		   save the status of the tx interrupt and restore it when
+		   we're done so that using printk doesn't interfere with
+		   normal serial transmission (other than interleaving the
+		   output, of course!).  This should work correctly even if
+		   this function is interrupted and the interrupt printks
+		   something.  */
+
+		/* Disable interrupts while fiddling with tx interrupt.  */
+		local_irq_save (flags);
+		/* Get current tx interrupt status.  */
+		irq_was_enabled = v850e_intc_irq_enabled (irq);
+		irq_was_pending = v850e_intc_irq_pending (irq);
+		/* Disable tx interrupt if necessary.  */
+		if (irq_was_enabled)
+			v850e_intc_disable_irq (irq);
+		/* Turn interrupts back on.  */
+		local_irq_restore (flags);
+
+		/* Send characters.  */
+		while (count > 0) {
+			int ch = *s++;
+
+			if (ch == '\n') {
+				/* We don't have the benefit of a tty
+				   driver, so translate NL into CR LF.  */
+				v850e_uart_wait_for_xmit_ok (chan);
+				v850e_uart_putc (chan, '\r');
+			}
+
+			v850e_uart_wait_for_xmit_ok (chan);
+			v850e_uart_putc (chan, ch);
+
+			count--;
+		}
+
+		/* Restore saved tx interrupt status.  */
+		if (irq_was_enabled) {
+			/* Wait for the last character we sent to be
+			   completely transmitted (as we'll get an
+			   interrupt interrupt at that point).  */
+			v850e_uart_wait_for_xmit_done (chan);
+			/* Clear pending interrupts received due
+			   to our transmission, unless there was already
+			   one pending, in which case we want the
+			   handler to be called.  */
+			if (! irq_was_pending)
+				v850e_intc_clear_pending_irq (irq);
+			/* ... and then turn back on handling.  */
+			v850e_intc_enable_irq (irq);
+		}
+	}
+}
+
+extern struct uart_driver v850e_uart_driver;
+static struct console v850e_uart_cons =
+{
+    .name	= "ttyS",
+    .write	= v850e_uart_cons_write,
+    .device	= uart_console_device,
+    .flags	= CON_PRINTBUFFER,
+    .cflag	= V850E_UART_INIT_CFLAGS,
+    .index	= -1,
+    .data	= &v850e_uart_driver,
+};
+
+void v850e_uart_cons_init (unsigned chan)
+{
+	v850e_uart_configure (chan, V850E_UART_INIT_CFLAGS,
+			      V850E_UART_INIT_BAUD);
+	v850e_uart_cons.index = chan;
+	register_console (&v850e_uart_cons);
+	printk ("Console: %s on-chip UART channel %d\n",
+		V850E_UART_CHIP_NAME, chan);
+}
+
+/* This is what the init code actually calls.  */
+static int v850e_uart_console_init (void)
+{
+	v850e_uart_cons_init (V850E_UART_CONSOLE_CHANNEL);
+	return 0;
+}
+console_initcall(v850e_uart_console_init);
+
+#define V850E_UART_CONSOLE &v850e_uart_cons
+
+#else /* !CONFIG_V850E_UART_CONSOLE */
+#define V850E_UART_CONSOLE 0
+#endif /* CONFIG_V850E_UART_CONSOLE */
+
+/* TX/RX interrupt handlers.  */
+
+static void v850e_uart_stop_tx (struct uart_port *port, unsigned tty_stop);
+
+void v850e_uart_tx (struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->info->xmit;
+	int stopped = uart_tx_stopped (port);
+
+	if (v850e_uart_xmit_ok (port->line)) {
+		int tx_ch;
+
+		if (port->x_char) {
+			tx_ch = port->x_char;
+			port->x_char = 0;
+		} else if (!uart_circ_empty (xmit) && !stopped) {
+			tx_ch = xmit->buf[xmit->tail];
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} else
+			goto no_xmit;
+
+		v850e_uart_putc (port->line, tx_ch);
+		port->icount.tx++;
+
+		if (uart_circ_chars_pending (xmit) < WAKEUP_CHARS)
+			uart_write_wakeup (port);
+	}
+
+ no_xmit:
+	if (uart_circ_empty (xmit) || stopped)
+		v850e_uart_stop_tx (port, stopped);
+}
+
+static irqreturn_t v850e_uart_tx_irq(int irq, void *data, struct pt_regs *regs)
+{
+	struct uart_port *port = data;
+	v850e_uart_tx (port);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t v850e_uart_rx_irq(int irq, void *data, struct pt_regs *regs)
+{
+	struct uart_port *port = data;
+	unsigned ch_stat = TTY_NORMAL;
+	unsigned ch = v850e_uart_getc (port->line);
+	unsigned err = v850e_uart_err (port->line);
+
+	if (err) {
+		if (err & V850E_UART_ERR_OVERRUN) {
+			ch_stat = TTY_OVERRUN;
+			port->icount.overrun++;
+		} else if (err & V850E_UART_ERR_FRAME) {
+			ch_stat = TTY_FRAME;
+			port->icount.frame++;
+		} else if (err & V850E_UART_ERR_PARITY) {
+			ch_stat = TTY_PARITY;
+			port->icount.parity++;
+		}
+	}
+
+	port->icount.rx++;
+
+	tty_insert_flip_char (port->info->tty, ch, ch_stat);
+	tty_schedule_flip (port->info->tty);
+
+	return IRQ_HANDLED;
+}
+
+
+/* Control functions for the serial framework.  */
+
+static void v850e_uart_nop (struct uart_port *port) { }
+static int v850e_uart_success (struct uart_port *port) { return 0; }
+
+static unsigned v850e_uart_tx_empty (struct uart_port *port)
+{
+	return TIOCSER_TEMT;	/* Can't detect.  */
+}
+
+static void v850e_uart_set_mctrl (struct uart_port *port, unsigned mctrl)
+{
+#ifdef V850E_UART_SET_RTS
+	V850E_UART_SET_RTS (port->line, (mctrl & TIOCM_RTS));
+#endif
+}
+
+static unsigned v850e_uart_get_mctrl (struct uart_port *port)
+{
+	/* We don't support DCD or DSR, so consider them permanently active. */
+	int mctrl = TIOCM_CAR | TIOCM_DSR;
+
+	/* We may support CTS.  */
+#ifdef V850E_UART_CTS
+	mctrl |= V850E_UART_CTS(port->line) ? TIOCM_CTS : 0;
+#else
+	mctrl |= TIOCM_CTS;
+#endif
+
+	return mctrl;
+}
+
+static void v850e_uart_start_tx (struct uart_port *port, unsigned tty_start)
+{
+	v850e_intc_disable_irq (V850E_UART_TX_IRQ (port->line));
+	v850e_uart_tx (port);
+	v850e_intc_enable_irq (V850E_UART_TX_IRQ (port->line));
+}
+
+static void v850e_uart_stop_tx (struct uart_port *port, unsigned tty_stop)
+{
+	v850e_intc_disable_irq (V850E_UART_TX_IRQ (port->line));
+}
+
+static void v850e_uart_start_rx (struct uart_port *port)
+{
+	v850e_intc_enable_irq (V850E_UART_RX_IRQ (port->line));
+}
+
+static void v850e_uart_stop_rx (struct uart_port *port)
+{
+	v850e_intc_disable_irq (V850E_UART_RX_IRQ (port->line));
+}
+
+static void v850e_uart_break_ctl (struct uart_port *port, int break_ctl)
+{
+	/* Umm, do this later.  */
+}
+
+static int v850e_uart_startup (struct uart_port *port)
+{
+	int err;
+
+	/* Alloc RX irq.  */
+	err = request_irq (V850E_UART_RX_IRQ (port->line), v850e_uart_rx_irq,
+			   SA_INTERRUPT, "v850e_uart", port);
+	if (err)
+		return err;
+
+	/* Alloc TX irq.  */
+	err = request_irq (V850E_UART_TX_IRQ (port->line), v850e_uart_tx_irq,
+			   SA_INTERRUPT, "v850e_uart", port);
+	if (err) {
+		free_irq (V850E_UART_RX_IRQ (port->line), port);
+		return err;
+	}
+
+	v850e_uart_start_rx (port);
+
+	return 0;
+}
+
+static void v850e_uart_shutdown (struct uart_port *port)
+{
+	/* Disable port interrupts.  */
+	free_irq (V850E_UART_TX_IRQ (port->line), port);
+	free_irq (V850E_UART_RX_IRQ (port->line), port);
+
+	/* Turn off xmit/recv enable bits.  */
+	V850E_UART_CONFIG (port->line)
+		&= ~(V850E_UART_CONFIG_TX_ENABLE
+		     | V850E_UART_CONFIG_RX_ENABLE);
+	/* Then reset the channel.  */
+	V850E_UART_CONFIG (port->line) = 0;
+}
+
+static void
+v850e_uart_set_termios (struct uart_port *port, struct termios *termios,
+		        struct termios *old)
+{
+	unsigned cflags = termios->c_cflag;
+
+	/* Restrict flags to legal values.  */
+	if ((cflags & CSIZE) != CS7 && (cflags & CSIZE) != CS8)
+		/* The new value of CSIZE is invalid, use the old value.  */
+		cflags = (cflags & ~CSIZE)
+			| (old ? (old->c_cflag & CSIZE) : CS8);
+
+	termios->c_cflag = cflags;
+
+	v850e_uart_configure (port->line, cflags,
+			      uart_get_baud_rate (port, termios, old,
+						  v850e_uart_min_baud(),
+						  v850e_uart_max_baud()));
+}
+
+static const char *v850e_uart_type (struct uart_port *port)
+{
+	return port->type == PORT_V850E_UART ? "v850e_uart" : 0;
+}
+
+static void v850e_uart_config_port (struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_V850E_UART;
+}
+
+static int
+v850e_uart_verify_port (struct uart_port *port, struct serial_struct *ser)
+{
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_V850E_UART)
+		return -EINVAL;
+	if (ser->irq != V850E_UART_TX_IRQ (port->line))
+		return -EINVAL;
+	return 0;
+}
+
+static struct uart_ops v850e_uart_ops = {
+	.tx_empty	= v850e_uart_tx_empty,
+	.get_mctrl	= v850e_uart_get_mctrl,
+	.set_mctrl	= v850e_uart_set_mctrl,
+	.start_tx	= v850e_uart_start_tx,
+	.stop_tx	= v850e_uart_stop_tx,
+	.stop_rx	= v850e_uart_stop_rx,
+	.enable_ms	= v850e_uart_nop,
+	.break_ctl	= v850e_uart_break_ctl,
+	.startup	= v850e_uart_startup,
+	.shutdown	= v850e_uart_shutdown,
+	.set_termios	= v850e_uart_set_termios,
+	.type		= v850e_uart_type,
+	.release_port	= v850e_uart_nop,
+	.request_port	= v850e_uart_success,
+	.config_port	= v850e_uart_config_port,
+	.verify_port	= v850e_uart_verify_port,
+};
+
+/* Initialization and cleanup.  */
+
+static struct uart_driver v850e_uart_driver = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "v850e_uart",
+	.devfs_name		= "tts/",
+	.dev_name		= "ttyS",
+	.major			= TTY_MAJOR,
+	.minor			= V850E_UART_MINOR_BASE,
+	.nr			= V850E_UART_NUM_CHANNELS,
+	.cons			= V850E_UART_CONSOLE,
+};
+
+
+static struct uart_port v850e_uart_ports[V850E_UART_NUM_CHANNELS];
+
+static int __init v850e_uart_init (void)
+{
+	int rval;
+
+	printk (KERN_INFO "%s on-chip UART\n", V850E_UART_CHIP_NAME);
+
+	rval = uart_register_driver (&v850e_uart_driver);
+	if (rval == 0) {
+		unsigned chan;
+
+		for (chan = 0; chan < V850E_UART_NUM_CHANNELS; chan++) {
+			struct uart_port *port = &v850e_uart_ports[chan];
+			
+			memset (port, 0, sizeof *port);
+
+			port->ops = &v850e_uart_ops;
+			port->line = chan;
+			port->iotype = SERIAL_IO_MEM;
+			port->flags = UPF_BOOT_AUTOCONF;
+
+			/* We actually use multiple IRQs, but the serial
+			   framework seems to mainly use this for
+			   informational purposes anyway.  Here we use the TX
+			   irq.  */
+			port->irq = V850E_UART_TX_IRQ (chan);
+
+			/* The serial framework doesn't really use these
+			   membase/mapbase fields for anything useful, but
+			   it requires that they be something non-zero to
+			   consider the port `valid', and also uses them
+			   for informational purposes.  */
+			port->membase = (void *)V850E_UART_BASE_ADDR (chan);
+			port->mapbase = V850E_UART_BASE_ADDR (chan);
+
+			/* The framework insists on knowing the uart's master
+			   clock freq, though it doesn't seem to do anything
+			   useful for us with it.  We must make it at least
+			   higher than (the maximum baud rate * 16), otherwise
+			   the framework will puke during its internal
+			   calculations, and force the baud rate to be 9600.
+			   To be accurate though, just repeat the calculation
+			   we use when actually setting the speed.  */
+			port->uartclk = v850e_uart_max_clock() * 16;
+
+			uart_add_one_port (&v850e_uart_driver, port);
+		}
+	}
+
+	return rval;
+}
+
+static void __exit v850e_uart_exit (void)
+{
+	unsigned chan;
+
+	for (chan = 0; chan < V850E_UART_NUM_CHANNELS; chan++)
+		uart_remove_one_port (&v850e_uart_driver,
+				      &v850e_uart_ports[chan]);
+
+	uart_unregister_driver (&v850e_uart_driver);
+}
+
+module_init (v850e_uart_init);
+module_exit (v850e_uart_exit);
+
+MODULE_AUTHOR ("Miles Bader");
+MODULE_DESCRIPTION ("NEC " V850E_UART_CHIP_NAME " on-chip UART");
+MODULE_LICENSE ("GPL");
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/linux/serial_core.h linux-2.6.0-test1-moo-v850-20030718/include/linux/serial_core.h
--- linux-2.6.0-test1-moo/include/linux/serial_core.h	2003-07-14 13:20:21.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/linux/serial_core.h	2003-07-16 17:49:46.000000000 +0900
@@ -57,7 +57,7 @@
 #define PORT_SUNSAB	39
 
 /* NEC v850.  */
-#define PORT_NB85E_UART	40
+#define PORT_V850E_UART	40
 
 /* NEC PC-9800 */
 #define PORT_8251_PC98	41
