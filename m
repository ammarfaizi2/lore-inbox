Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbUKHQ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUKHQ2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUKHQ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:28:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261837AbUKHOfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:02 -0500
Date: Mon, 8 Nov 2004 14:34:17 GMT
Message-Id: <200411081434.iA8EYHod023516@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 5/20] FRV: Fujitsu FR-V CPU arch implementation part 3
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 3 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_3-2610rc1mm3.diff
 frv_ksyms.c      |  124 +++
 gdb-io.c         |  216 +++++
 gdb-io.h         |   55 +
 gdb-stub.c       | 2082 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 head-mmu-fr451.S |  374 +++++++++
 head.S           |  638 ++++++++++++++++
 head.inc         |   50 +
 7 files changed, 3539 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/frv_ksyms.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/frv_ksyms.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/frv_ksyms.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/frv_ksyms.c	2004-11-05 14:13:03.088564605 +0000
@@ -0,0 +1,124 @@
+#include <linux/module.h>
+#include <linux/linkage.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/user.h>
+#include <linux/elfcore.h>
+#include <linux/in6.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+
+#include <asm/setup.h>
+#include <asm/pgalloc.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/checksum.h>
+#include <asm/hardirq.h>
+#include <asm/current.h>
+
+extern void dump_thread(struct pt_regs *, struct user *);
+extern long __memcpy_user(void *dst, const void *src, size_t count);
+
+/* platform dependent support */
+
+EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(iounmap);
+
+EXPORT_SYMBOL(dump_thread);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strncpy);
+
+EXPORT_SYMBOL(ip_fast_csum);
+
+#if 0
+EXPORT_SYMBOL(local_irq_count);
+EXPORT_SYMBOL(local_bh_count);
+#endif
+EXPORT_SYMBOL(kernel_thread);
+
+EXPORT_SYMBOL(enable_irq);
+EXPORT_SYMBOL(disable_irq);
+EXPORT_SYMBOL(__res_bus_clock_speed_HZ);
+EXPORT_SYMBOL(__page_offset);
+EXPORT_SYMBOL(__memcpy_user);
+EXPORT_SYMBOL(flush_dcache_page);
+
+#ifndef CONFIG_MMU
+EXPORT_SYMBOL(memory_start);
+EXPORT_SYMBOL(memory_end);
+#endif
+
+EXPORT_SYMBOL_NOVERS(__debug_bug_trap);
+
+/* Networking helper routines. */
+EXPORT_SYMBOL(csum_partial_copy);
+
+/* The following are special because they're not called
+   explicitly (the C compiler generates them).  Fortunately,
+   their interface isn't gonna change any time soon now, so
+   it's OK to leave it out of version control.  */
+EXPORT_SYMBOL_NOVERS(memcpy);
+EXPORT_SYMBOL_NOVERS(memset);
+EXPORT_SYMBOL_NOVERS(memcmp);
+EXPORT_SYMBOL_NOVERS(memscan);
+EXPORT_SYMBOL_NOVERS(memmove);
+EXPORT_SYMBOL_NOVERS(strtok);
+
+EXPORT_SYMBOL(get_wchan);
+
+#ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
+EXPORT_SYMBOL_NOVERS(atomic_test_and_ANDNOT_mask);
+EXPORT_SYMBOL_NOVERS(atomic_test_and_OR_mask);
+EXPORT_SYMBOL_NOVERS(atomic_test_and_XOR_mask);
+EXPORT_SYMBOL_NOVERS(atomic_add_return);
+EXPORT_SYMBOL_NOVERS(atomic_sub_return);
+EXPORT_SYMBOL_NOVERS(__xchg_8);
+EXPORT_SYMBOL_NOVERS(__xchg_16);
+EXPORT_SYMBOL_NOVERS(__xchg_32);
+EXPORT_SYMBOL_NOVERS(__cmpxchg_8);
+EXPORT_SYMBOL_NOVERS(__cmpxchg_16);
+EXPORT_SYMBOL_NOVERS(__cmpxchg_32);
+#endif
+
+/*
+ * libgcc functions - functions that are used internally by the
+ * compiler...  (prototypes are not correct though, but that
+ * doesn't really matter since they're not versioned).
+ */
+extern void __gcc_bcmp(void);
+extern void __ashldi3(void);
+extern void __ashrdi3(void);
+extern void __cmpdi2(void);
+extern void __divdi3(void);
+extern void __lshrdi3(void);
+extern void __moddi3(void);
+extern void __muldi3(void);
+extern void __negdi2(void);
+extern void __ucmpdi2(void);
+extern void __udivdi3(void);
+extern void __udivmoddi4(void);
+extern void __umoddi3(void);
+
+        /* gcc lib functions */
+//EXPORT_SYMBOL_NOVERS(__gcc_bcmp);
+EXPORT_SYMBOL_NOVERS(__ashldi3);
+EXPORT_SYMBOL_NOVERS(__ashrdi3);
+//EXPORT_SYMBOL_NOVERS(__cmpdi2);
+//EXPORT_SYMBOL_NOVERS(__divdi3);
+EXPORT_SYMBOL_NOVERS(__lshrdi3);
+//EXPORT_SYMBOL_NOVERS(__moddi3);
+EXPORT_SYMBOL_NOVERS(__muldi3);
+EXPORT_SYMBOL_NOVERS(__negdi2);
+//EXPORT_SYMBOL_NOVERS(__ucmpdi2);
+//EXPORT_SYMBOL_NOVERS(__udivdi3);
+//EXPORT_SYMBOL_NOVERS(__udivmoddi4);
+//EXPORT_SYMBOL_NOVERS(__umoddi3);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-io.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-io.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-io.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-io.c	2004-11-05 14:13:03.093564183 +0000
@@ -0,0 +1,216 @@
+/* gdb-io.c: FR403 GDB stub I/O
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/serial_reg.h>
+
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/irc-regs.h>
+#include <asm/timer-regs.h>
+#include <asm/gdb-stub.h>
+#include "gdb-io.h"
+
+#ifdef CONFIG_GDBSTUB_UART0
+#define __UART(X) (*(volatile uint8_t *)(UART0_BASE + (UART_##X)))
+#define __UART_IRR_NMI 0xff0f0000
+#else /* CONFIG_GDBSTUB_UART1 */
+#define __UART(X) (*(volatile uint8_t *)(UART1_BASE + (UART_##X)))
+#define __UART_IRR_NMI 0xfff00000
+#endif
+
+#define LSR_WAIT_FOR(STATE)			\
+do {						\
+	gdbstub_do_rx();			\
+} while (!(__UART(LSR) & UART_LSR_##STATE))
+
+#define FLOWCTL_QUERY(LINE)	({ __UART(MSR) & UART_MSR_##LINE; })
+#define FLOWCTL_CLEAR(LINE)	do { __UART(MCR) &= ~UART_MCR_##LINE; mb(); } while (0)
+#define FLOWCTL_SET(LINE)	do { __UART(MCR) |= UART_MCR_##LINE;  mb(); } while (0)
+
+#define FLOWCTL_WAIT_FOR(LINE)			\
+do {						\
+	gdbstub_do_rx();			\
+} while(!FLOWCTL_QUERY(LINE))
+
+/*****************************************************************************/
+/*
+ * initialise the GDB stub
+ * - called with PSR.ET==0, so can't incur external interrupts
+ */
+void gdbstub_io_init(void)
+{
+	/* set up the serial port */
+	__UART(LCR) = UART_LCR_WLEN8; /* 1N8 */
+	__UART(FCR) =
+		UART_FCR_ENABLE_FIFO |
+		UART_FCR_CLEAR_RCVR |
+		UART_FCR_CLEAR_XMIT |
+		UART_FCR_TRIGGER_1;
+
+	FLOWCTL_CLEAR(DTR);
+	FLOWCTL_SET(RTS);
+
+//	gdbstub_set_baud(115200);
+
+	/* we want to get serial receive interrupts */
+	__UART(IER) = UART_IER_RDI | UART_IER_RLSI;
+	mb();
+
+	__set_IRR(6, __UART_IRR_NMI);	/* map ERRs and UARTx to NMI */
+
+} /* end gdbstub_io_init() */
+
+/*****************************************************************************/
+/*
+ * set up the GDB stub serial port baud rate timers
+ */
+void gdbstub_set_baud(unsigned baud)
+{
+	unsigned value, high, low;
+	u8 lcr;
+
+	/* work out the divisor to give us the nearest higher baud rate */
+	value = __serial_clock_speed_HZ / 16 / baud;
+
+	/* determine the baud rate range */
+	high = __serial_clock_speed_HZ / 16 / value;
+	low = __serial_clock_speed_HZ / 16 / (value + 1);
+
+	/* pick the nearest bound */
+	if (low + (high - low) / 2 > baud)
+		value++;
+
+	lcr = __UART(LCR);
+	__UART(LCR) |= UART_LCR_DLAB;
+	mb();
+	__UART(DLL) = value & 0xff;
+	__UART(DLM) = (value >> 8) & 0xff;
+	mb();
+	__UART(LCR) = lcr;
+	mb();
+
+} /* end gdbstub_set_baud() */
+
+/*****************************************************************************/
+/*
+ * receive characters into the receive FIFO
+ */
+void gdbstub_do_rx(void)
+{
+	unsigned ix, nix;
+
+	ix = gdbstub_rx_inp;
+
+	while (__UART(LSR) & UART_LSR_DR) {
+		nix = (ix + 2) & 0xfff;
+		if (nix == gdbstub_rx_outp)
+			break;
+
+		gdbstub_rx_buffer[ix++] = __UART(LSR);
+		gdbstub_rx_buffer[ix++] = __UART(RX);
+		ix = nix;
+	}
+
+	gdbstub_rx_inp = ix;
+
+	__clr_RC(15);
+	__clr_IRL();
+
+} /* end gdbstub_do_rx() */
+
+/*****************************************************************************/
+/*
+ * wait for a character to come from the debugger
+ */
+int gdbstub_rx_char(unsigned char *_ch, int nonblock)
+{
+	unsigned ix;
+	u8 ch, st;
+
+	*_ch = 0xff;
+
+	if (gdbstub_rx_unget) {
+		*_ch = gdbstub_rx_unget;
+		gdbstub_rx_unget = 0;
+		return 0;
+	}
+
+ try_again:
+	gdbstub_do_rx();
+
+	/* pull chars out of the buffer */
+	ix = gdbstub_rx_outp;
+	if (ix == gdbstub_rx_inp) {
+		if (nonblock)
+			return -EAGAIN;
+		//watchdog_alert_counter = 0;
+		goto try_again;
+	}
+
+	st = gdbstub_rx_buffer[ix++];
+	ch = gdbstub_rx_buffer[ix++];
+	gdbstub_rx_outp = ix & 0x00000fff;
+
+	if (st & UART_LSR_BI) {
+		gdbstub_proto("### GDB Rx Break Detected ###\n");
+		return -EINTR;
+	}
+	else if (st & (UART_LSR_FE|UART_LSR_OE|UART_LSR_PE)) {
+		gdbstub_proto("### GDB Rx Error (st=%02x) ###\n",st);
+		return -EIO;
+	}
+	else {
+		gdbstub_proto("### GDB Rx %02x (st=%02x) ###\n",ch,st);
+		*_ch = ch & 0x7f;
+		return 0;
+	}
+
+} /* end gdbstub_rx_char() */
+
+/*****************************************************************************/
+/*
+ * send a character to the debugger
+ */
+void gdbstub_tx_char(unsigned char ch)
+{
+	FLOWCTL_SET(DTR);
+	LSR_WAIT_FOR(THRE);
+//	FLOWCTL_WAIT_FOR(CTS);
+
+	if (ch == 0x0a) {
+		__UART(TX) = 0x0d;
+		mb();
+		LSR_WAIT_FOR(THRE);
+//		FLOWCTL_WAIT_FOR(CTS);
+	}
+	__UART(TX) = ch;
+	mb();
+
+	FLOWCTL_CLEAR(DTR);
+} /* end gdbstub_tx_char() */
+
+/*****************************************************************************/
+/*
+ * send a character to the debugger
+ */
+void gdbstub_tx_flush(void)
+{
+	LSR_WAIT_FOR(TEMT);
+	LSR_WAIT_FOR(THRE);
+	FLOWCTL_CLEAR(DTR);
+} /* end gdbstub_tx_flush() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-io.h linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-io.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-io.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-io.h	2004-11-05 14:13:03.096563929 +0000
@@ -0,0 +1,55 @@
+/* gdb-io.h: FR403 GDB I/O port defs
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _GDB_IO_H
+#define _GDB_IO_H
+
+#include <asm/serial-regs.h>
+
+#undef UART_RX
+#undef UART_TX
+#undef UART_DLL
+#undef UART_DLM
+#undef UART_IER
+#undef UART_IIR
+#undef UART_FCR
+#undef UART_LCR
+#undef UART_MCR
+#undef UART_LSR
+#undef UART_MSR
+#undef UART_SCR
+
+#define UART_RX		0*8	/* In:  Receive buffer (DLAB=0) */
+#define UART_TX		0*8	/* Out: Transmit buffer (DLAB=0) */
+#define UART_DLL	0*8	/* Out: Divisor Latch Low (DLAB=1) */
+#define UART_DLM	1*8	/* Out: Divisor Latch High (DLAB=1) */
+#define UART_IER	1*8	/* Out: Interrupt Enable Register */
+#define UART_IIR	2*8	/* In:  Interrupt ID Register */
+#define UART_FCR	2*8	/* Out: FIFO Control Register */
+#define UART_LCR	3*8	/* Out: Line Control Register */
+#define UART_MCR	4*8	/* Out: Modem Control Register */
+#define UART_LSR	5*8	/* In:  Line Status Register */
+#define UART_MSR	6*8	/* In:  Modem Status Register */
+#define UART_SCR	7*8	/* I/O: Scratch Register */
+
+#define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
+#define UART_LCR_SBC	0x40	/* Set break control */
+#define UART_LCR_SPAR	0x20	/* Stick parity (?) */
+#define UART_LCR_EPAR	0x10	/* Even parity select */
+#define UART_LCR_PARITY	0x08	/* Parity Enable */
+#define UART_LCR_STOP	0x04	/* Stop bits: 0=1 stop bit, 1= 2 stop bits */
+#define UART_LCR_WLEN5  0x00	/* Wordlength: 5 bits */
+#define UART_LCR_WLEN6  0x01	/* Wordlength: 6 bits */
+#define UART_LCR_WLEN7  0x02	/* Wordlength: 7 bits */
+#define UART_LCR_WLEN8  0x03	/* Wordlength: 8 bits */
+
+
+#endif /* _GDB_IO_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-stub.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-stub.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/gdb-stub.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/gdb-stub.c	2004-11-05 14:46:41.000000000 +0000
@@ -0,0 +1,2082 @@
+/* gdb-stub.c: FRV GDB stub
+ *
+ * Copyright (C) 2003,4 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from Linux/MIPS version, Copyright (C) 1995 Andreas Busse
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ *  To enable debugger support, two things need to happen.  One, a
+ *  call to set_debug_traps() is necessary in order to allow any breakpoints
+ *  or error conditions to be properly intercepted and reported to gdb.
+ *  Two, a breakpoint needs to be generated to begin communication.  This
+ *  is most easily accomplished by a call to breakpoint().  Breakpoint()
+ *  simulates a breakpoint by executing a BREAK instruction.
+ *
+ *
+ *    The following gdb commands are supported:
+ *
+ * command          function                               Return value
+ *
+ *    g             return the value of the CPU registers  hex data or ENN
+ *    G             set the value of the CPU registers     OK or ENN
+ *
+ *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
+ *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
+ *
+ *    c             Resume at current address              SNN   ( signal NN)
+ *    cAA..AA       Continue at address AA..AA             SNN
+ *
+ *    s             Step one instruction                   SNN
+ *    sAA..AA       Step one instruction from AA..AA       SNN
+ *
+ *    k             kill
+ *
+ *    ?             What was the last sigval ?             SNN   (signal NN)
+ *
+ *    bBB..BB	    Set baud rate to BB..BB		   OK or BNN, then sets
+ *							   baud rate
+ *
+ * All commands and responses are sent with a packet which includes a
+ * checksum.  A packet consists of
+ *
+ * $<packet info>#<checksum>.
+ *
+ * where
+ * <packet info> :: <characters representing the command or response>
+ * <checksum>    :: < two hex digits computed as modulo 256 sum of <packetinfo>>
+ *
+ * When a packet is received, it is first acknowledged with either '+' or '-'.
+ * '+' indicates a successful transfer.  '-' indicates a failed transfer.
+ *
+ * Example:
+ *
+ * Host:                  Reply:
+ * $m0,10#2a               +$00010203040506070809101112131415#42
+ *
+ *
+ *  ==============
+ *  MORE EXAMPLES:
+ *  ==============
+ *
+ *  For reference -- the following are the steps that one
+ *  company took (RidgeRun Inc) to get remote gdb debugging
+ *  going. In this scenario the host machine was a PC and the
+ *  target platform was a Galileo EVB64120A MIPS evaluation
+ *  board.
+ *
+ *  Step 1:
+ *  First download gdb-5.0.tar.gz from the internet.
+ *  and then build/install the package.
+ *
+ *  Example:
+ *    $ tar zxf gdb-5.0.tar.gz
+ *    $ cd gdb-5.0
+ *    $ ./configure --target=frv-elf-gdb
+ *    $ make
+ *    $ frv-elf-gdb
+ *
+ *  Step 2:
+ *  Configure linux for remote debugging and build it.
+ *
+ *  Example:
+ *    $ cd ~/linux
+ *    $ make menuconfig <go to "Kernel Hacking" and turn on remote debugging>
+ *    $ make dep; make vmlinux
+ *
+ *  Step 3:
+ *  Download the kernel to the remote target and start
+ *  the kernel running. It will promptly halt and wait
+ *  for the host gdb session to connect. It does this
+ *  since the "Kernel Hacking" option has defined
+ *  CONFIG_REMOTE_DEBUG which in turn enables your calls
+ *  to:
+ *     set_debug_traps();
+ *     breakpoint();
+ *
+ *  Step 4:
+ *  Start the gdb session on the host.
+ *
+ *  Example:
+ *    $ frv-elf-gdb vmlinux
+ *    (gdb) set remotebaud 115200
+ *    (gdb) target remote /dev/ttyS1
+ *    ...at this point you are connected to
+ *       the remote target and can use gdb
+ *       in the normal fasion. Setting
+ *       breakpoints, single stepping,
+ *       printing variables, etc.
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/nmi.h>
+
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/gdb-stub.h>
+
+#define LEDS(x) do { /* *(u32*)0xe1200004 = ~(x); mb(); */ } while(0)
+
+#undef GDBSTUB_DEBUG_PROTOCOL
+
+extern void debug_to_serial(const char *p, int n);
+extern void gdbstub_console_write(struct console *co, const char *p, unsigned n);
+
+extern volatile uint32_t __break_error_detect[3]; /* ESFR1, ESR15, EAR15 */
+extern struct user_context __break_user_context;
+
+struct __debug_amr {
+	unsigned long L, P;
+} __attribute__((aligned(8)));
+
+struct __debug_mmu {
+	struct {
+		unsigned long	hsr0, pcsr, esr0, ear0, epcr0;
+#ifdef CONFIG_MMU
+		unsigned long	tplr, tppr, tpxr, cxnr;
+#endif
+	} regs;
+
+	struct __debug_amr	iamr[16];
+	struct __debug_amr	damr[16];
+
+#ifdef CONFIG_MMU
+	struct __debug_amr	tlb[64*2];
+#endif
+};
+
+static struct __debug_mmu __debug_mmu;
+
+/*
+ * BUFMAX defines the maximum number of characters in inbound/outbound buffers
+ * at least NUMREGBYTES*2 are needed for register packets
+ */
+#define BUFMAX 2048
+
+#define BREAK_INSN	0x801000c0	/* use "break" as bkpt */
+
+static const char gdbstub_banner[] = "Linux/FR-V GDB Stub (c) RedHat 2003\n";
+
+volatile u8	gdbstub_rx_buffer[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+volatile u32	gdbstub_rx_inp = 0;
+volatile u32	gdbstub_rx_outp = 0;
+volatile u8	gdbstub_rx_overflow = 0;
+u8		gdbstub_rx_unget = 0;
+
+/* set with GDB whilst running to permit step through exceptions */
+extern volatile u32 __attribute__((section(".bss"))) gdbstub_trace_through_exceptions;
+
+static char	input_buffer[BUFMAX];
+static char	output_buffer[BUFMAX];
+
+static const char hexchars[] = "0123456789abcdef";
+
+static const char *regnames[] = {
+	"PSR ", "ISR ", "CCR ", "CCCR",
+	"LR  ", "LCR ", "PC  ", "_stt",
+	"sys ", "GR8*", "GNE0", "GNE1",
+	"IACH", "IACL",
+	"TBR ", "SP  ", "FP  ", "GR3 ",
+	"GR4 ", "GR5 ", "GR6 ", "GR7 ",
+	"GR8 ", "GR9 ", "GR10", "GR11",
+	"GR12", "GR13", "GR14", "GR15",
+	"GR16", "GR17", "GR18", "GR19",
+	"GR20", "GR21", "GR22", "GR23",
+	"GR24", "GR25", "GR26", "GR27",
+	"EFRM", "CURR", "GR30", "BFRM"
+};
+
+struct gdbstub_bkpt {
+	unsigned long	addr;		/* address of breakpoint */
+	unsigned	len;		/* size of breakpoint */
+	uint32_t	originsns[7];	/* original instructions */
+};
+
+static struct gdbstub_bkpt gdbstub_bkpts[256];
+
+/*
+ * local prototypes
+ */
+
+static void gdbstub_recv_packet(char *buffer);
+static int gdbstub_send_packet(char *buffer);
+static int gdbstub_compute_signal(unsigned long tbr);
+static int hex(unsigned char ch);
+static int hexToInt(char **ptr, unsigned long *intValue);
+static unsigned char *mem2hex(const void *mem, char *buf, int count, int may_fault);
+static char *hex2mem(const char *buf, void *_mem, int count);
+
+/*
+ * Convert ch from a hex digit to an int
+ */
+static int hex(unsigned char ch)
+{
+	if (ch >= 'a' && ch <= 'f')
+		return ch-'a'+10;
+	if (ch >= '0' && ch <= '9')
+		return ch-'0';
+	if (ch >= 'A' && ch <= 'F')
+		return ch-'A'+10;
+	return -1;
+}
+
+void gdbstub_printk(const char *fmt, ...)
+{
+	static char buf[1024];
+	va_list args;
+	int len;
+
+	/* Emit the output into the temporary buffer */
+	va_start(args, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+	debug_to_serial(buf, len);
+}
+
+static inline char *gdbstub_strcpy(char *dst, const char *src)
+{
+	int loop = 0;
+	while ((dst[loop] = src[loop]))
+	       loop++;
+	return dst;
+}
+
+static void gdbstub_purge_cache(void)
+{
+	asm volatile("	dcef	@(gr0,gr0),#1	\n"
+		     "	icei	@(gr0,gr0),#1	\n"
+		     "	membar			\n"
+		     "	bar			\n"
+		     );
+}
+
+/*****************************************************************************/
+/*
+ * scan for the sequence $<data>#<checksum>
+ */
+static void gdbstub_recv_packet(char *buffer)
+{
+	unsigned char checksum;
+	unsigned char xmitcsum;
+	unsigned char ch;
+	int count, i, ret, error;
+
+	for (;;) {
+		/* wait around for the start character, ignore all other characters */
+		do {
+			gdbstub_rx_char(&ch, 0);
+		} while (ch != '$');
+
+		checksum = 0;
+		xmitcsum = -1;
+		count = 0;
+		error = 0;
+
+		/* now, read until a # or end of buffer is found */
+		while (count < BUFMAX) {
+			ret = gdbstub_rx_char(&ch, 0);
+			if (ret < 0)
+				error = ret;
+
+			if (ch == '#')
+				break;
+			checksum += ch;
+			buffer[count] = ch;
+			count++;
+		}
+
+		if (error == -EIO) {
+			gdbstub_proto("### GDB Rx Error - Skipping packet ###\n");
+			gdbstub_proto("### GDB Tx NAK\n");
+			gdbstub_tx_char('-');
+			continue;
+		}
+
+		if (count >= BUFMAX || error)
+			continue;
+
+		buffer[count] = 0;
+
+		/* read the checksum */
+		ret = gdbstub_rx_char(&ch, 0);
+		if (ret < 0)
+			error = ret;
+		xmitcsum = hex(ch) << 4;
+
+		ret = gdbstub_rx_char(&ch, 0);
+		if (ret < 0)
+			error = ret;
+		xmitcsum |= hex(ch);
+
+		if (error) {
+			if (error == -EIO)
+				gdbstub_proto("### GDB Rx Error - Skipping packet\n");
+			gdbstub_proto("### GDB Tx NAK\n");
+			gdbstub_tx_char('-');
+			continue;
+		}
+
+		/* check the checksum */
+		if (checksum != xmitcsum) {
+			gdbstub_proto("### GDB Tx NAK\n");
+			gdbstub_tx_char('-');	/* failed checksum */
+			continue;
+		}
+
+		gdbstub_proto("### GDB Rx '$%s#%02x' ###\n", buffer, checksum);
+		gdbstub_proto("### GDB Tx ACK\n");
+		gdbstub_tx_char('+'); /* successful transfer */
+
+		/* if a sequence char is present, reply the sequence ID */
+		if (buffer[2] == ':') {
+			gdbstub_tx_char(buffer[0]);
+			gdbstub_tx_char(buffer[1]);
+
+			/* remove sequence chars from buffer */
+			count = 0;
+			while (buffer[count]) count++;
+			for (i=3; i <= count; i++)
+				buffer[i - 3] = buffer[i];
+		}
+
+		break;
+	}
+} /* end gdbstub_recv_packet() */
+
+/*****************************************************************************/
+/*
+ * send the packet in buffer.
+ * - return 0 if successfully ACK'd
+ * - return 1 if abandoned due to new incoming packet
+ */
+static int gdbstub_send_packet(char *buffer)
+{
+	unsigned char checksum;
+	int count;
+	unsigned char ch;
+
+	/* $<packet info>#<checksum> */
+	gdbstub_proto("### GDB Tx '%s' ###\n", buffer);
+
+	do {
+		gdbstub_tx_char('$');
+		checksum = 0;
+		count = 0;
+
+		while ((ch = buffer[count]) != 0) {
+			gdbstub_tx_char(ch);
+			checksum += ch;
+			count += 1;
+		}
+
+		gdbstub_tx_char('#');
+		gdbstub_tx_char(hexchars[checksum >> 4]);
+		gdbstub_tx_char(hexchars[checksum & 0xf]);
+
+	} while (gdbstub_rx_char(&ch,0),
+#ifdef GDBSTUB_DEBUG_PROTOCOL
+		 ch=='-' && (gdbstub_proto("### GDB Rx NAK\n"),0),
+		 ch!='-' && ch!='+' && (gdbstub_proto("### GDB Rx ??? %02x\n",ch),0),
+#endif
+		 ch!='+' && ch!='$');
+
+	if (ch=='+') {
+		gdbstub_proto("### GDB Rx ACK\n");
+		return 0;
+	}
+
+	gdbstub_proto("### GDB Tx Abandoned\n");
+	gdbstub_rx_unget = ch;
+	return 1;
+} /* end gdbstub_send_packet() */
+
+/*
+ * While we find nice hex chars, build an int.
+ * Return number of chars processed.
+ */
+static int hexToInt(char **ptr, unsigned long *_value)
+{
+	int count = 0, ch;
+
+	*_value = 0;
+	while (**ptr) {
+		ch = hex(**ptr);
+		if (ch < 0)
+			break;
+
+		*_value = (*_value << 4) | ((uint8_t) ch & 0xf);
+		count++;
+
+		(*ptr)++;
+	}
+
+	return count;
+}
+
+/*****************************************************************************/
+/*
+ * probe an address to see whether it maps to anything
+ */
+static inline int gdbstub_addr_probe(const void *vaddr)
+{
+#ifdef CONFIG_MMU
+	unsigned long paddr;
+
+	asm("lrad %1,%0,#1,#0,#0" : "=r"(paddr) : "r"(vaddr));
+	if (!(paddr & xAMPRx_V))
+		return 0;
+#endif
+
+	return 1;
+} /* end gdbstub_addr_probe() */
+
+#ifdef CONFIG_MMU
+static unsigned long __saved_dampr, __saved_damlr;
+
+static inline unsigned long gdbstub_virt_to_pte(unsigned long vaddr)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long val, dampr5;
+
+	pgd = (pgd_t *) __get_DAMLR(3) + pgd_index(vaddr);
+	pmd = pmd_offset(pgd, vaddr);
+
+	if (pmd_bad(*pmd) || !pmd_present(*pmd))
+		return 0;
+
+	/* make sure dampr5 maps to the correct pmd */
+	dampr5 = __get_DAMPR(5);
+	val = pmd_val(*pmd);
+	__set_DAMPR(5, val | xAMPRx_L | xAMPRx_SS_16Kb | xAMPRx_S | xAMPRx_C | xAMPRx_V);
+
+	/* now its safe to access pmd */
+	pte = (pte_t *)__get_DAMLR(5) + __pte_index(vaddr);
+	if (pte_present(*pte))
+		val = pte_val(*pte);
+	else
+		val = 0;
+
+	/* restore original dampr5 */
+	__set_DAMPR(5, dampr5);
+
+	return val;
+}
+#endif
+
+static inline int gdbstub_addr_map(const void *vaddr)
+{
+#ifdef CONFIG_MMU
+	unsigned long pte;
+
+	__saved_dampr = __get_DAMPR(2);
+	__saved_damlr = __get_DAMLR(2);
+#endif
+	if (gdbstub_addr_probe(vaddr))
+		return 1;
+#ifdef CONFIG_MMU
+	pte = gdbstub_virt_to_pte((unsigned long) vaddr);
+	if (pte) {
+		__set_DAMPR(2, pte);
+		__set_DAMLR(2, (unsigned long) vaddr & PAGE_MASK);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+static inline void gdbstub_addr_unmap(void)
+{
+#ifdef CONFIG_MMU
+	__set_DAMPR(2, __saved_dampr);
+	__set_DAMLR(2, __saved_damlr);
+#endif
+}
+
+/*
+ * access potentially dodgy memory through a potentially dodgy pointer
+ */
+static inline int gdbstub_read_dword(const void *addr, uint32_t *_res)
+{
+	unsigned long brr;
+	uint32_t res;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	ld%I2	%M2,%0	\n"
+		     "	movsg	brr,%1	\n"
+		     : "=r"(res), "=r"(brr)
+		     : "m"(*(uint32_t *) addr));
+	*_res = res;
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static inline int gdbstub_write_dword(void *addr, uint32_t val)
+{
+	unsigned long brr;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	st%I2	%1,%M2	\n"
+		     "	movsg	brr,%0	\n"
+		     : "=r"(brr)
+		     : "r"(val), "m"(*(uint32_t *) addr));
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static inline int gdbstub_read_word(const void *addr, uint16_t *_res)
+{
+	unsigned long brr;
+	uint16_t res;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	lduh%I2	%M2,%0	\n"
+		     "	movsg	brr,%1	\n"
+		     : "=r"(res), "=r"(brr)
+		     : "m"(*(uint16_t *) addr));
+	*_res = res;
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static inline int gdbstub_write_word(void *addr, uint16_t val)
+{
+	unsigned long brr;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	sth%I2	%1,%M2	\n"
+		     "	movsg	brr,%0	\n"
+		     : "=r"(brr)
+		     : "r"(val), "m"(*(uint16_t *) addr));
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static inline int gdbstub_read_byte(const void *addr, uint8_t *_res)
+{
+	unsigned long brr;
+	uint8_t res;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	ldub%I2	%M2,%0	\n"
+		     "	movsg	brr,%1	\n"
+		     : "=r"(res), "=r"(brr)
+		     : "m"(*(uint8_t *) addr));
+	*_res = res;
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static inline int gdbstub_write_byte(void *addr, uint8_t val)
+{
+	unsigned long brr;
+
+	if (!gdbstub_addr_map(addr))
+		return 0;
+
+	asm volatile("	movgs	gr0,brr	\n"
+		     "	stb%I2	%1,%M2	\n"
+		     "	movsg	brr,%0	\n"
+		     : "=r"(brr)
+		     : "r"(val), "m"(*(uint8_t *) addr));
+	gdbstub_addr_unmap();
+	return likely(!brr);
+}
+
+static void __gdbstub_console_write(struct console *co, const char *p, unsigned n)
+{
+	char outbuf[26];
+	int qty;
+
+	outbuf[0] = 'O';
+
+	while (n > 0) {
+		qty = 1;
+
+		while (n > 0 && qty < 20) {
+			mem2hex(p, outbuf + qty, 2, 0);
+			qty += 2;
+			if (*p == 0x0a) {
+				outbuf[qty++] = '0';
+				outbuf[qty++] = 'd';
+			}
+			p++;
+			n--;
+		}
+
+		outbuf[qty] = 0;
+		gdbstub_send_packet(outbuf);
+	}
+}
+
+#if 0
+void debug_to_serial(const char *p, int n)
+{
+	gdbstub_console_write(NULL,p,n);
+}
+#endif
+
+#ifdef CONFIG_GDBSTUB_CONSOLE
+
+static kdev_t gdbstub_console_dev(struct console *con)
+{
+	return MKDEV(1,3); /* /dev/null */
+}
+
+static struct console gdbstub_console = {
+	.name	= "gdb",
+	.write	= gdbstub_console_write,	/* in break.S */
+	.device	= gdbstub_console_dev,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+#endif
+
+/*****************************************************************************/
+/*
+ * Convert the memory pointed to by mem into hex, placing result in buf.
+ * - if successful, return a pointer to the last char put in buf (NUL)
+ * - in case of mem fault, return NULL
+ * may_fault is non-zero if we are reading from arbitrary memory, but is currently
+ * not used.
+ */
+static unsigned char *mem2hex(const void *_mem, char *buf, int count, int may_fault)
+{
+	const uint8_t *mem = _mem;
+	uint8_t ch[4] __attribute__((aligned(4)));
+
+	if ((uint32_t)mem&1 && count>=1) {
+		if (!gdbstub_read_byte(mem,ch))
+			return NULL;
+		*buf++ = hexchars[ch[0] >> 4];
+		*buf++ = hexchars[ch[0] & 0xf];
+		mem++;
+		count--;
+	}
+
+	if ((uint32_t)mem&3 && count>=2) {
+		if (!gdbstub_read_word(mem,(uint16_t *)ch))
+			return NULL;
+		*buf++ = hexchars[ch[0] >> 4];
+		*buf++ = hexchars[ch[0] & 0xf];
+		*buf++ = hexchars[ch[1] >> 4];
+		*buf++ = hexchars[ch[1] & 0xf];
+		mem += 2;
+		count -= 2;
+	}
+
+	while (count>=4) {
+		if (!gdbstub_read_dword(mem,(uint32_t *)ch))
+			return NULL;
+		*buf++ = hexchars[ch[0] >> 4];
+		*buf++ = hexchars[ch[0] & 0xf];
+		*buf++ = hexchars[ch[1] >> 4];
+		*buf++ = hexchars[ch[1] & 0xf];
+		*buf++ = hexchars[ch[2] >> 4];
+		*buf++ = hexchars[ch[2] & 0xf];
+		*buf++ = hexchars[ch[3] >> 4];
+		*buf++ = hexchars[ch[3] & 0xf];
+		mem += 4;
+		count -= 4;
+	}
+
+	if (count>=2) {
+		if (!gdbstub_read_word(mem,(uint16_t *)ch))
+			return NULL;
+		*buf++ = hexchars[ch[0] >> 4];
+		*buf++ = hexchars[ch[0] & 0xf];
+		*buf++ = hexchars[ch[1] >> 4];
+		*buf++ = hexchars[ch[1] & 0xf];
+		mem += 2;
+		count -= 2;
+	}
+
+	if (count>=1) {
+		if (!gdbstub_read_byte(mem,ch))
+			return NULL;
+		*buf++ = hexchars[ch[0] >> 4];
+		*buf++ = hexchars[ch[0] & 0xf];
+	}
+
+	*buf = 0;
+
+	return buf;
+} /* end mem2hex() */
+
+/*****************************************************************************/
+/*
+ * convert the hex array pointed to by buf into binary to be placed in mem
+ * return a pointer to the character AFTER the last byte of buffer consumed
+ */
+static char *hex2mem(const char *buf, void *_mem, int count)
+{
+	uint8_t *mem = _mem;
+	union {
+		uint32_t l;
+		uint16_t w;
+		uint8_t  b[4];
+	} ch;
+
+	if ((u32)mem&1 && count>=1) {
+		ch.b[0]  = hex(*buf++) << 4;
+		ch.b[0] |= hex(*buf++);
+		if (!gdbstub_write_byte(mem,ch.b[0]))
+			return NULL;
+		mem++;
+		count--;
+	}
+
+	if ((u32)mem&3 && count>=2) {
+		ch.b[0]  = hex(*buf++) << 4;
+		ch.b[0] |= hex(*buf++);
+		ch.b[1]  = hex(*buf++) << 4;
+		ch.b[1] |= hex(*buf++);
+		if (!gdbstub_write_word(mem,ch.w))
+			return NULL;
+		mem += 2;
+		count -= 2;
+	}
+
+	while (count>=4) {
+		ch.b[0]  = hex(*buf++) << 4;
+		ch.b[0] |= hex(*buf++);
+		ch.b[1]  = hex(*buf++) << 4;
+		ch.b[1] |= hex(*buf++);
+		ch.b[2]  = hex(*buf++) << 4;
+		ch.b[2] |= hex(*buf++);
+		ch.b[3]  = hex(*buf++) << 4;
+		ch.b[3] |= hex(*buf++);
+		if (!gdbstub_write_dword(mem,ch.l))
+			return NULL;
+		mem += 4;
+		count -= 4;
+	}
+
+	if (count>=2) {
+		ch.b[0]  = hex(*buf++) << 4;
+		ch.b[0] |= hex(*buf++);
+		ch.b[1]  = hex(*buf++) << 4;
+		ch.b[1] |= hex(*buf++);
+		if (!gdbstub_write_word(mem,ch.w))
+			return NULL;
+		mem += 2;
+		count -= 2;
+	}
+
+	if (count>=1) {
+		ch.b[0]  = hex(*buf++) << 4;
+		ch.b[0] |= hex(*buf++);
+		if (!gdbstub_write_byte(mem,ch.b[0]))
+			return NULL;
+	}
+
+	return (char *) buf;
+} /* end hex2mem() */
+
+/*****************************************************************************/
+/*
+ * This table contains the mapping between FRV TBR.TT exception codes,
+ * and signals, which are primarily what GDB understands.  It also
+ * indicates which hardware traps we need to commandeer when
+ * initializing the stub.
+ */
+static const struct brr_to_sig_map {
+	unsigned long	brr_mask;	/* BRR bitmask */
+	unsigned long	tbr_tt;		/* TBR.TT code (in BRR.EBTT) */
+	unsigned int	signo;		/* Signal that we map this into */
+} brr_to_sig_map[] = {
+	{ BRR_EB,	TBR_TT_INSTR_ACC_ERROR,	SIGSEGV		},
+	{ BRR_EB,	TBR_TT_ILLEGAL_INSTR,	SIGILL		},
+	{ BRR_EB,	TBR_TT_PRIV_INSTR,	SIGILL		},
+	{ BRR_EB,	TBR_TT_MP_EXCEPTION,	SIGFPE		},
+	{ BRR_EB,	TBR_TT_DATA_ACC_ERROR,	SIGSEGV		},
+	{ BRR_EB,	TBR_TT_DATA_STR_ERROR,	SIGSEGV		},
+	{ BRR_EB,	TBR_TT_DIVISION_EXCEP,	SIGFPE		},
+	{ BRR_EB,	TBR_TT_COMPOUND_EXCEP,	SIGSEGV		},
+	{ BRR_EB,	TBR_TT_INTERRUPT_13,	SIGALRM		},	/* watchdog */
+	{ BRR_EB,	TBR_TT_INTERRUPT_14,	SIGINT		},	/* GDB serial */
+	{ BRR_EB,	TBR_TT_INTERRUPT_15,	SIGQUIT		},	/* NMI */
+	{ BRR_CB,	0,			SIGUSR1		},
+	{ BRR_TB,	0,			SIGUSR2		},
+	{ BRR_DBNEx,	0,			SIGTRAP		},
+	{ BRR_DBx,	0,			SIGTRAP		},	/* h/w watchpoint */
+	{ BRR_IBx,	0,			SIGTRAP		},	/* h/w breakpoint */
+	{ BRR_CBB,	0,			SIGTRAP		},
+	{ BRR_SB,	0,			SIGTRAP		},
+	{ BRR_ST,	0,			SIGTRAP		},	/* single step */
+	{ 0,		0,			SIGHUP		}	/* default */
+};
+
+/*****************************************************************************/
+/*
+ * convert the FRV BRR register contents into a UNIX signal number
+ */
+static inline int gdbstub_compute_signal(unsigned long brr)
+{
+	const struct brr_to_sig_map *map;
+	unsigned long tbr = (brr & BRR_EBTT) >> 12;
+
+	for (map = brr_to_sig_map; map->brr_mask; map++)
+		if (map->brr_mask & brr)
+			if (!map->tbr_tt || map->tbr_tt == tbr)
+				break;
+
+	return map->signo;
+} /* end gdbstub_compute_signal() */
+
+/*****************************************************************************/
+/*
+ * set a software breakpoint or a hardware breakpoint or watchpoint
+ */
+static int gdbstub_set_breakpoint(unsigned long type, unsigned long addr, unsigned long len)
+{
+	unsigned long tmp;
+	int bkpt, loop, xloop;
+
+	union {
+		struct {
+			unsigned long mask0, mask1;
+		};
+		uint8_t bytes[8];
+	} dbmr;
+
+	//gdbstub_printk("setbkpt(%ld,%08lx,%ld)\n", type, addr, len);
+
+	switch (type) {
+		/* set software breakpoint */
+	case 0:
+		if (addr & 3 || len > 7*4)
+			return -EINVAL;
+
+		for (bkpt = 255; bkpt >= 0; bkpt--)
+			if (!gdbstub_bkpts[bkpt].addr)
+				break;
+		if (bkpt < 0)
+			return -ENOSPC;
+
+		for (loop = 0; loop < len/4; loop++)
+			if (!gdbstub_read_dword(&((uint32_t *) addr)[loop],
+						&gdbstub_bkpts[bkpt].originsns[loop]))
+				return -EFAULT;
+
+		for (loop = 0; loop < len/4; loop++)
+			if (!gdbstub_write_dword(&((uint32_t *) addr)[loop],
+						 BREAK_INSN)
+			    ) {
+				/* need to undo the changes if possible */
+				for (xloop = 0; xloop < loop; xloop++)
+					gdbstub_write_dword(&((uint32_t *) addr)[xloop],
+							    gdbstub_bkpts[bkpt].originsns[xloop]);
+				return -EFAULT;
+			}
+
+		gdbstub_bkpts[bkpt].addr = addr;
+		gdbstub_bkpts[bkpt].len = len;
+
+#if 0
+		gdbstub_printk("Set BKPT[%02x]: %08lx #%d {%04x, %04x} -> { %04x, %04x }\n",
+			       bkpt,
+			       gdbstub_bkpts[bkpt].addr,
+			       gdbstub_bkpts[bkpt].len,
+			       gdbstub_bkpts[bkpt].originsns[0],
+			       gdbstub_bkpts[bkpt].originsns[1],
+			       ((uint32_t *) addr)[0],
+			       ((uint32_t *) addr)[1]
+			       );
+#endif
+		return 0;
+
+		/* set hardware breakpoint */
+	case 1:
+		if (addr & 3 || len != 4)
+			return -EINVAL;
+
+		if (!(__debug_regs->dcr & DCR_IBE0)) {
+			//gdbstub_printk("set h/w break 0: %08lx\n", addr);
+			__debug_regs->dcr |= DCR_IBE0;
+			asm volatile("movgs %0,ibar0" : : "r"(addr));
+			return 0;
+		}
+
+		if (!(__debug_regs->dcr & DCR_IBE1)) {
+			//gdbstub_printk("set h/w break 1: %08lx\n", addr);
+			__debug_regs->dcr |= DCR_IBE1;
+			asm volatile("movgs %0,ibar1" : : "r"(addr));
+			return 0;
+		}
+
+		if (!(__debug_regs->dcr & DCR_IBE2)) {
+			//gdbstub_printk("set h/w break 2: %08lx\n", addr);
+			__debug_regs->dcr |= DCR_IBE2;
+			asm volatile("movgs %0,ibar2" : : "r"(addr));
+			return 0;
+		}
+
+		if (!(__debug_regs->dcr & DCR_IBE3)) {
+			//gdbstub_printk("set h/w break 3: %08lx\n", addr);
+			__debug_regs->dcr |= DCR_IBE3;
+			asm volatile("movgs %0,ibar3" : : "r"(addr));
+			return 0;
+		}
+
+		return -ENOSPC;
+
+		/* set data read/write/access watchpoint */
+	case 2:
+	case 3:
+	case 4:
+		if ((addr & ~7) != ((addr + len - 1) & ~7))
+			return -EINVAL;
+
+		tmp = addr & 7;
+
+		memset(dbmr.bytes, 0xff, sizeof(dbmr.bytes));
+		for (loop = 0; loop < len; loop++)
+			dbmr.bytes[tmp + loop] = 0;
+
+		addr &= ~7;
+
+		if (!(__debug_regs->dcr & (DCR_DRBE0|DCR_DWBE0))) {
+			//gdbstub_printk("set h/w watchpoint 0 type %ld: %08lx\n", type, addr);
+			tmp = type==2 ? DCR_DWBE0 : type==3 ? DCR_DRBE0 : DCR_DRBE0|DCR_DWBE0;
+			__debug_regs->dcr |= tmp;
+			asm volatile("	movgs	%0,dbar0	\n"
+				     "	movgs	%1,dbmr00	\n"
+				     "	movgs	%2,dbmr01	\n"
+				     "	movgs	gr0,dbdr00	\n"
+				     "	movgs	gr0,dbdr01	\n"
+				     : : "r"(addr), "r"(dbmr.mask0), "r"(dbmr.mask1));
+			return 0;
+		}
+
+		if (!(__debug_regs->dcr & (DCR_DRBE1|DCR_DWBE1))) {
+			//gdbstub_printk("set h/w watchpoint 1 type %ld: %08lx\n", type, addr);
+			tmp = type==2 ? DCR_DWBE1 : type==3 ? DCR_DRBE1 : DCR_DRBE1|DCR_DWBE1;
+			__debug_regs->dcr |= tmp;
+			asm volatile("	movgs	%0,dbar1	\n"
+				     "	movgs	%1,dbmr10	\n"
+				     "	movgs	%2,dbmr11	\n"
+				     "	movgs	gr0,dbdr10	\n"
+				     "	movgs	gr0,dbdr11	\n"
+				     : : "r"(addr), "r"(dbmr.mask0), "r"(dbmr.mask1));
+			return 0;
+		}
+
+		return -ENOSPC;
+
+	default:
+		return -EINVAL;
+	}
+
+} /* end gdbstub_set_breakpoint() */
+
+/*****************************************************************************/
+/*
+ * clear a breakpoint or watchpoint
+ */
+int gdbstub_clear_breakpoint(unsigned long type, unsigned long addr, unsigned long len)
+{
+	unsigned long tmp;
+	int bkpt, loop;
+
+	union {
+		struct {
+			unsigned long mask0, mask1;
+		};
+		uint8_t bytes[8];
+	} dbmr;
+
+	//gdbstub_printk("clearbkpt(%ld,%08lx,%ld)\n", type, addr, len);
+
+	switch (type) {
+		/* clear software breakpoint */
+	case 0:
+		for (bkpt = 255; bkpt >= 0; bkpt--)
+			if (gdbstub_bkpts[bkpt].addr == addr && gdbstub_bkpts[bkpt].len == len)
+				break;
+		if (bkpt < 0)
+			return -ENOENT;
+
+		gdbstub_bkpts[bkpt].addr = 0;
+
+		for (loop = 0; loop < len/4; loop++)
+			if (!gdbstub_write_dword(&((uint32_t *) addr)[loop],
+						 gdbstub_bkpts[bkpt].originsns[loop]))
+				return -EFAULT;
+		return 0;
+
+		/* clear hardware breakpoint */
+	case 1:
+		if (addr & 3 || len != 4)
+			return -EINVAL;
+
+#define __get_ibar(X) ({ unsigned long x; asm volatile("movsg ibar"#X",%0" : "=r"(x)); x; })
+
+		if (__debug_regs->dcr & DCR_IBE0 && __get_ibar(0) == addr) {
+			//gdbstub_printk("clear h/w break 0: %08lx\n", addr);
+			__debug_regs->dcr &= ~DCR_IBE0;
+			asm volatile("movgs gr0,ibar0");
+			return 0;
+		}
+
+		if (__debug_regs->dcr & DCR_IBE1 && __get_ibar(1) == addr) {
+			//gdbstub_printk("clear h/w break 1: %08lx\n", addr);
+			__debug_regs->dcr &= ~DCR_IBE1;
+			asm volatile("movgs gr0,ibar1");
+			return 0;
+		}
+
+		if (__debug_regs->dcr & DCR_IBE2 && __get_ibar(2) == addr) {
+			//gdbstub_printk("clear h/w break 2: %08lx\n", addr);
+			__debug_regs->dcr &= ~DCR_IBE2;
+			asm volatile("movgs gr0,ibar2");
+			return 0;
+		}
+
+		if (__debug_regs->dcr & DCR_IBE3 && __get_ibar(3) == addr) {
+			//gdbstub_printk("clear h/w break 3: %08lx\n", addr);
+			__debug_regs->dcr &= ~DCR_IBE3;
+			asm volatile("movgs gr0,ibar3");
+			return 0;
+		}
+
+		return -EINVAL;
+
+		/* clear data read/write/access watchpoint */
+	case 2:
+	case 3:
+	case 4:
+		if ((addr & ~7) != ((addr + len - 1) & ~7))
+			return -EINVAL;
+
+		tmp = addr & 7;
+
+		memset(dbmr.bytes, 0xff, sizeof(dbmr.bytes));
+		for (loop = 0; loop < len; loop++)
+			dbmr.bytes[tmp + loop] = 0;
+
+		addr &= ~7;
+
+#define __get_dbar(X) ({ unsigned long x; asm volatile("movsg dbar"#X",%0" : "=r"(x)); x; })
+#define __get_dbmr0(X) ({ unsigned long x; asm volatile("movsg dbmr"#X"0,%0" : "=r"(x)); x; })
+#define __get_dbmr1(X) ({ unsigned long x; asm volatile("movsg dbmr"#X"1,%0" : "=r"(x)); x; })
+
+		/* consider DBAR 0 */
+		tmp = type==2 ? DCR_DWBE0 : type==3 ? DCR_DRBE0 : DCR_DRBE0|DCR_DWBE0;
+
+		if ((__debug_regs->dcr & (DCR_DRBE0|DCR_DWBE0)) != tmp ||
+		    __get_dbar(0) != addr ||
+		    __get_dbmr0(0) != dbmr.mask0 ||
+		    __get_dbmr1(0) != dbmr.mask1)
+			goto skip_dbar0;
+
+		//gdbstub_printk("clear h/w watchpoint 0 type %ld: %08lx\n", type, addr);
+		__debug_regs->dcr &= ~(DCR_DRBE0|DCR_DWBE0);
+		asm volatile("	movgs	gr0,dbar0	\n"
+			     "	movgs	gr0,dbmr00	\n"
+			     "	movgs	gr0,dbmr01	\n"
+			     "	movgs	gr0,dbdr00	\n"
+			     "	movgs	gr0,dbdr01	\n");
+		return 0;
+
+	skip_dbar0:
+		/* consider DBAR 0 */
+		tmp = type==2 ? DCR_DWBE1 : type==3 ? DCR_DRBE1 : DCR_DRBE1|DCR_DWBE1;
+
+		if ((__debug_regs->dcr & (DCR_DRBE1|DCR_DWBE1)) != tmp ||
+		    __get_dbar(1) != addr ||
+		    __get_dbmr0(1) != dbmr.mask0 ||
+		    __get_dbmr1(1) != dbmr.mask1)
+			goto skip_dbar1;
+
+		//gdbstub_printk("clear h/w watchpoint 1 type %ld: %08lx\n", type, addr);
+		__debug_regs->dcr &= ~(DCR_DRBE1|DCR_DWBE1);
+		asm volatile("	movgs	gr0,dbar1	\n"
+			     "	movgs	gr0,dbmr10	\n"
+			     "	movgs	gr0,dbmr11	\n"
+			     "	movgs	gr0,dbdr10	\n"
+			     "	movgs	gr0,dbdr11	\n");
+		return 0;
+
+	skip_dbar1:
+		return -ENOSPC;
+
+	default:
+		return -EINVAL;
+	}
+} /* end gdbstub_clear_breakpoint() */
+
+/*****************************************************************************/
+/*
+ * check a for an internal software breakpoint, and wind the PC back if necessary
+ */
+static void gdbstub_check_breakpoint(void)
+{
+	unsigned long addr = __debug_frame->pc - 4;
+	int bkpt;
+
+	for (bkpt = 255; bkpt >= 0; bkpt--)
+		if (gdbstub_bkpts[bkpt].addr == addr)
+			break;
+	if (bkpt >= 0)
+		__debug_frame->pc = addr;
+
+	//gdbstub_printk("alter pc [%d] %08lx\n", bkpt, __debug_frame->pc);
+
+} /* end gdbstub_check_breakpoint() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+static void __attribute__((unused)) gdbstub_show_regs(void)
+{
+	uint32_t *reg;
+	int loop;
+
+	gdbstub_printk("\n");
+
+	gdbstub_printk("Frame: @%p [%s]\n",
+		       __debug_frame,
+		       __debug_frame->psr & PSR_S ? "kernel" : "user");
+
+	reg = (uint32_t *) __debug_frame;
+	for (loop = 0; loop < REG__END; loop++) {
+		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+
+		if (loop == REG__END - 1 || loop % 5 == 4)
+			printk("\n");
+		else
+			printk(" | ");
+	}
+
+	gdbstub_printk("Process %s (pid: %d)\n", current->comm, current->pid);
+} /* end gdbstub_show_regs() */
+
+/*****************************************************************************/
+/*
+ * dump debugging regs
+ */
+static void __attribute__((unused)) gdbstub_dump_debugregs(void)
+{
+	unsigned long x;
+
+	x = __debug_regs->dcr;
+	gdbstub_printk("DCR    %08lx  ", x);
+
+	x = __debug_regs->brr;
+	gdbstub_printk("BRR %08lx\n", x);
+
+	gdbstub_printk("IBAR0  %08lx  ", __get_ibar(0));
+	gdbstub_printk("IBAR1  %08lx  ", __get_ibar(1));
+	gdbstub_printk("IBAR2  %08lx  ", __get_ibar(2));
+	gdbstub_printk("IBAR3  %08lx\n", __get_ibar(3));
+
+	gdbstub_printk("DBAR0  %08lx  ", __get_dbar(0));
+	gdbstub_printk("DBMR00 %08lx  ", __get_dbmr0(0));
+	gdbstub_printk("DBMR01 %08lx\n", __get_dbmr1(0));
+
+	gdbstub_printk("DBAR1  %08lx  ", __get_dbar(1));
+	gdbstub_printk("DBMR10 %08lx  ", __get_dbmr0(1));
+	gdbstub_printk("DBMR11 %08lx\n", __get_dbmr1(1));
+
+	gdbstub_printk("\n");
+} /* end gdbstub_dump_debugregs() */
+
+/*****************************************************************************/
+/*
+ * dump the MMU state into a structure so that it can be accessed with GDB
+ */
+void gdbstub_get_mmu_state(void)
+{
+	asm volatile("movsg hsr0,%0" : "=r"(__debug_mmu.regs.hsr0));
+	asm volatile("movsg pcsr,%0" : "=r"(__debug_mmu.regs.pcsr));
+	asm volatile("movsg esr0,%0" : "=r"(__debug_mmu.regs.esr0));
+	asm volatile("movsg ear0,%0" : "=r"(__debug_mmu.regs.ear0));
+	asm volatile("movsg epcr0,%0" : "=r"(__debug_mmu.regs.epcr0));
+
+	/* read the protection / SAT registers */
+	__debug_mmu.iamr[0].L  = __get_IAMLR(0);
+	__debug_mmu.iamr[0].P  = __get_IAMPR(0);
+	__debug_mmu.iamr[1].L  = __get_IAMLR(1);
+	__debug_mmu.iamr[1].P  = __get_IAMPR(1);
+	__debug_mmu.iamr[2].L  = __get_IAMLR(2);
+	__debug_mmu.iamr[2].P  = __get_IAMPR(2);
+	__debug_mmu.iamr[3].L  = __get_IAMLR(3);
+	__debug_mmu.iamr[3].P  = __get_IAMPR(3);
+	__debug_mmu.iamr[4].L  = __get_IAMLR(4);
+	__debug_mmu.iamr[4].P  = __get_IAMPR(4);
+	__debug_mmu.iamr[5].L  = __get_IAMLR(5);
+	__debug_mmu.iamr[5].P  = __get_IAMPR(5);
+	__debug_mmu.iamr[6].L  = __get_IAMLR(6);
+	__debug_mmu.iamr[6].P  = __get_IAMPR(6);
+	__debug_mmu.iamr[7].L  = __get_IAMLR(7);
+	__debug_mmu.iamr[7].P  = __get_IAMPR(7);
+	__debug_mmu.iamr[8].L  = __get_IAMLR(8);
+	__debug_mmu.iamr[8].P  = __get_IAMPR(8);
+	__debug_mmu.iamr[9].L  = __get_IAMLR(9);
+	__debug_mmu.iamr[9].P  = __get_IAMPR(9);
+	__debug_mmu.iamr[10].L = __get_IAMLR(10);
+	__debug_mmu.iamr[10].P = __get_IAMPR(10);
+	__debug_mmu.iamr[11].L = __get_IAMLR(11);
+	__debug_mmu.iamr[11].P = __get_IAMPR(11);
+	__debug_mmu.iamr[12].L = __get_IAMLR(12);
+	__debug_mmu.iamr[12].P = __get_IAMPR(12);
+	__debug_mmu.iamr[13].L = __get_IAMLR(13);
+	__debug_mmu.iamr[13].P = __get_IAMPR(13);
+	__debug_mmu.iamr[14].L = __get_IAMLR(14);
+	__debug_mmu.iamr[14].P = __get_IAMPR(14);
+	__debug_mmu.iamr[15].L = __get_IAMLR(15);
+	__debug_mmu.iamr[15].P = __get_IAMPR(15);
+
+	__debug_mmu.damr[0].L  = __get_DAMLR(0);
+	__debug_mmu.damr[0].P  = __get_DAMPR(0);
+	__debug_mmu.damr[1].L  = __get_DAMLR(1);
+	__debug_mmu.damr[1].P  = __get_DAMPR(1);
+	__debug_mmu.damr[2].L  = __get_DAMLR(2);
+	__debug_mmu.damr[2].P  = __get_DAMPR(2);
+	__debug_mmu.damr[3].L  = __get_DAMLR(3);
+	__debug_mmu.damr[3].P  = __get_DAMPR(3);
+	__debug_mmu.damr[4].L  = __get_DAMLR(4);
+	__debug_mmu.damr[4].P  = __get_DAMPR(4);
+	__debug_mmu.damr[5].L  = __get_DAMLR(5);
+	__debug_mmu.damr[5].P  = __get_DAMPR(5);
+	__debug_mmu.damr[6].L  = __get_DAMLR(6);
+	__debug_mmu.damr[6].P  = __get_DAMPR(6);
+	__debug_mmu.damr[7].L  = __get_DAMLR(7);
+	__debug_mmu.damr[7].P  = __get_DAMPR(7);
+	__debug_mmu.damr[8].L  = __get_DAMLR(8);
+	__debug_mmu.damr[8].P  = __get_DAMPR(8);
+	__debug_mmu.damr[9].L  = __get_DAMLR(9);
+	__debug_mmu.damr[9].P  = __get_DAMPR(9);
+	__debug_mmu.damr[10].L = __get_DAMLR(10);
+	__debug_mmu.damr[10].P = __get_DAMPR(10);
+	__debug_mmu.damr[11].L = __get_DAMLR(11);
+	__debug_mmu.damr[11].P = __get_DAMPR(11);
+	__debug_mmu.damr[12].L = __get_DAMLR(12);
+	__debug_mmu.damr[12].P = __get_DAMPR(12);
+	__debug_mmu.damr[13].L = __get_DAMLR(13);
+	__debug_mmu.damr[13].P = __get_DAMPR(13);
+	__debug_mmu.damr[14].L = __get_DAMLR(14);
+	__debug_mmu.damr[14].P = __get_DAMPR(14);
+	__debug_mmu.damr[15].L = __get_DAMLR(15);
+	__debug_mmu.damr[15].P = __get_DAMPR(15);
+
+#ifdef CONFIG_MMU
+	do {
+		/* read the DAT entries from the TLB */
+		struct __debug_amr *p;
+		int loop;
+
+		asm volatile("movsg tplr,%0" : "=r"(__debug_mmu.regs.tplr));
+		asm volatile("movsg tppr,%0" : "=r"(__debug_mmu.regs.tppr));
+		asm volatile("movsg tpxr,%0" : "=r"(__debug_mmu.regs.tpxr));
+		asm volatile("movsg cxnr,%0" : "=r"(__debug_mmu.regs.cxnr));
+
+		p = __debug_mmu.tlb;
+
+		/* way 0 */
+		asm volatile("movgs %0,tpxr" :: "r"(0 << TPXR_WAY_SHIFT));
+		for (loop = 0; loop < 64; loop++) {
+			asm volatile("tlbpr %0,gr0,#1,#0" :: "r"(loop << PAGE_SHIFT));
+			asm volatile("movsg tplr,%0" : "=r"(p->L));
+			asm volatile("movsg tppr,%0" : "=r"(p->P));
+			p++;
+		}
+
+		/* way 1 */
+		asm volatile("movgs %0,tpxr" :: "r"(1 << TPXR_WAY_SHIFT));
+		for (loop = 0; loop < 64; loop++) {
+			asm volatile("tlbpr %0,gr0,#1,#0" :: "r"(loop << PAGE_SHIFT));
+			asm volatile("movsg tplr,%0" : "=r"(p->L));
+			asm volatile("movsg tppr,%0" : "=r"(p->P));
+			p++;
+		}
+
+		asm volatile("movgs %0,tplr" :: "r"(__debug_mmu.regs.tplr));
+		asm volatile("movgs %0,tppr" :: "r"(__debug_mmu.regs.tppr));
+		asm volatile("movgs %0,tpxr" :: "r"(__debug_mmu.regs.tpxr));
+	} while(0);
+#endif
+
+} /* end gdbstub_get_mmu_state() */
+
+/*****************************************************************************/
+/*
+ * handle event interception and GDB remote protocol processing
+ * - on entry:
+ *	PSR.ET==0, PSR.S==1 and the CPU is in debug mode
+ *	__debug_frame points to the saved registers
+ *	__frame points to the kernel mode exception frame, if it was in kernel
+ *      mode when the break happened
+ */
+void gdbstub(int sigval)
+{
+	unsigned long addr, length, loop, dbar, temp, temp2, temp3;
+	uint32_t zero;
+	char *ptr;
+	int flush_cache = 0;
+
+	LEDS(0x5000);
+
+	if (sigval < 0) {
+#ifndef CONFIG_GDBSTUB_IMMEDIATE
+		/* return immediately if GDB immediate activation option not set */
+		return;
+#else
+		sigval = SIGINT;
+#endif
+	}
+
+	save_user_regs(&__break_user_context);
+
+#if 0
+	gdbstub_printk("--> gdbstub() %08x %p %08x %08x\n",
+		       __debug_frame->pc,
+		       __debug_frame,
+		       __debug_regs->brr,
+		       __debug_regs->bpsr);
+//	gdbstub_show_regs();
+#endif
+
+	LEDS(0x5001);
+
+	/* if we were interrupted by input on the serial gdbstub serial port,
+	 * restore the context prior to the interrupt so that we return to that
+	 * directly
+	 */
+	temp = (unsigned long) __entry_kerneltrap_table;
+	temp2 = (unsigned long) __entry_usertrap_table;
+	temp3 = __debug_frame->pc & ~15;
+
+	if (temp3 == temp + TBR_TT_INTERRUPT_15 ||
+	    temp3 == temp2 + TBR_TT_INTERRUPT_15
+	    ) {
+		asm volatile("movsg pcsr,%0" : "=r"(__debug_frame->pc));
+		__debug_frame->psr |= PSR_ET;
+		__debug_frame->psr &= ~PSR_S;
+		if (__debug_frame->psr & PSR_PS)
+			__debug_frame->psr |= PSR_S;
+		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_regs->brr |= BRR_EB;
+		sigval = SIGINT;
+	}
+
+	/* handle the decrement timer going off (FR451 only) */
+	if (temp3 == temp + TBR_TT_DECREMENT_TIMER ||
+	    temp3 == temp2 + TBR_TT_DECREMENT_TIMER
+	    ) {
+		asm volatile("movgs %0,timerd" :: "r"(10000000));
+		asm volatile("movsg pcsr,%0" : "=r"(__debug_frame->pc));
+		__debug_frame->psr |= PSR_ET;
+		__debug_frame->psr &= ~PSR_S;
+		if (__debug_frame->psr & PSR_PS)
+			__debug_frame->psr |= PSR_S;
+		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_regs->brr |= BRR_EB;
+		sigval = SIGXCPU;;
+	}
+
+	LEDS(0x5002);
+
+	/* after a BREAK insn, the PC lands on the far side of it */
+	if (__debug_regs->brr & BRR_SB)
+		gdbstub_check_breakpoint();
+
+	LEDS(0x5003);
+
+	/* handle attempts to write console data via GDB "O" commands */
+	if (__debug_frame->pc == (unsigned long) gdbstub_console_write + 4) {
+		__gdbstub_console_write((struct console *) __debug_frame->gr8,
+					(const char *) __debug_frame->gr9,
+					(unsigned) __debug_frame->gr10);
+		goto done;
+	}
+
+	if (gdbstub_rx_unget) {
+		sigval = SIGINT;
+		goto packet_waiting;
+	}
+
+	if (!sigval)
+		sigval = gdbstub_compute_signal(__debug_regs->brr);
+
+	LEDS(0x5004);
+
+	/* send a message to the debugger's user saying what happened if it may
+	 * not be clear cut (we can't map exceptions onto signals properly)
+	 */
+	if (sigval != SIGINT && sigval != SIGTRAP && sigval != SIGILL) {
+		static const char title[] = "Break ";
+		static const char crlf[] = "\r\n";
+		unsigned long brr = __debug_regs->brr;
+		char hx;
+
+		ptr = output_buffer;
+		*ptr++ = 'O';
+		ptr = mem2hex(title, ptr, sizeof(title) - 1,0);
+
+		hx = hexchars[(brr & 0xf0000000) >> 28];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x0f000000) >> 24];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x00f00000) >> 20];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x000f0000) >> 16];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x0000f000) >> 12];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x00000f00) >> 8];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x000000f0) >> 4];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+		hx = hexchars[(brr & 0x0000000f)];
+		*ptr++ = hexchars[hx >> 4];	*ptr++ = hexchars[hx & 0xf];
+
+		ptr = mem2hex(crlf, ptr, sizeof(crlf) - 1, 0);
+		*ptr = 0;
+		gdbstub_send_packet(output_buffer);	/* send it off... */
+	}
+
+	LEDS(0x5005);
+
+	/* tell the debugger that an exception has occurred */
+	ptr = output_buffer;
+
+	/* Send trap type (converted to signal) */
+	*ptr++ = 'T';
+	*ptr++ = hexchars[sigval >> 4];
+	*ptr++ = hexchars[sigval & 0xf];
+
+	/* Send Error PC */
+	*ptr++ = hexchars[GDB_REG_PC >> 4];
+	*ptr++ = hexchars[GDB_REG_PC & 0xf];
+	*ptr++ = ':';
+	ptr = mem2hex(&__debug_frame->pc, ptr, 4, 0);
+	*ptr++ = ';';
+
+	/*
+	 * Send frame pointer
+	 */
+	*ptr++ = hexchars[GDB_REG_FP >> 4];
+	*ptr++ = hexchars[GDB_REG_FP & 0xf];
+	*ptr++ = ':';
+	ptr = mem2hex(&__debug_frame->fp, ptr, 4, 0);
+	*ptr++ = ';';
+
+	/*
+	 * Send stack pointer
+	 */
+	*ptr++ = hexchars[GDB_REG_SP >> 4];
+	*ptr++ = hexchars[GDB_REG_SP & 0xf];
+	*ptr++ = ':';
+	ptr = mem2hex(&__debug_frame->sp, ptr, 4, 0);
+	*ptr++ = ';';
+
+	*ptr++ = 0;
+	gdbstub_send_packet(output_buffer);	/* send it off... */
+
+	LEDS(0x5006);
+
+ packet_waiting:
+	gdbstub_get_mmu_state();
+
+	/* wait for input from remote GDB */
+	while (1) {
+		output_buffer[0] = 0;
+
+		LEDS(0x5007);
+		gdbstub_recv_packet(input_buffer);
+		LEDS(0x5600 | input_buffer[0]);
+
+		switch (input_buffer[0]) {
+			/* request repeat of last signal number */
+		case '?':
+			output_buffer[0] = 'S';
+			output_buffer[1] = hexchars[sigval >> 4];
+			output_buffer[2] = hexchars[sigval & 0xf];
+			output_buffer[3] = 0;
+			break;
+
+		case 'd':
+			/* toggle debug flag */
+			break;
+
+			/* return the value of the CPU registers
+			 * - GR0,  GR1,  GR2,  GR3,  GR4,  GR5,  GR6,  GR7,
+			 * - GR8,  GR9,  GR10, GR11, GR12, GR13, GR14, GR15,
+			 * - GR16, GR17, GR18, GR19, GR20, GR21, GR22, GR23,
+			 * - GR24, GR25, GR26, GR27, GR28, GR29, GR30, GR31,
+			 * - GR32, GR33, GR34, GR35, GR36, GR37, GR38, GR39,
+			 * - GR40, GR41, GR42, GR43, GR44, GR45, GR46, GR47,
+			 * - GR48, GR49, GR50, GR51, GR52, GR53, GR54, GR55,
+			 * - GR56, GR57, GR58, GR59, GR60, GR61, GR62, GR63,
+			 * - FP0,  FP1,  FP2,  FP3,  FP4,  FP5,  FP6,  FP7,
+			 * - FP8,  FP9,  FP10, FP11, FP12, FP13, FP14, FP15,
+			 * - FP16, FP17, FP18, FP19, FP20, FP21, FP22, FP23,
+			 * - FP24, FP25, FP26, FP27, FP28, FP29, FP30, FP31,
+			 * - FP32, FP33, FP34, FP35, FP36, FP37, FP38, FP39,
+			 * - FP40, FP41, FP42, FP43, FP44, FP45, FP46, FP47,
+			 * - FP48, FP49, FP50, FP51, FP52, FP53, FP54, FP55,
+			 * - FP56, FP57, FP58, FP59, FP60, FP61, FP62, FP63,
+			 * - PC, PSR, CCR, CCCR,
+			 * - _X132, _X133, _X134
+			 * - TBR, BRR, DBAR0, DBAR1, DBAR2, DBAR3,
+			 * - _X141, _X142, _X143, _X144,
+			 * - LR, LCR
+			 */
+		case 'g':
+			zero = 0;
+			ptr = output_buffer;
+
+			/* deal with GR0, GR1-GR27, GR28-GR31, GR32-GR63 */
+			ptr = mem2hex(&zero, ptr, 4, 0);
+
+			for (loop = 1; loop <= 27; loop++)
+				ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(loop),
+					      ptr, 4, 0);
+			temp = (unsigned long) __frame;
+			ptr = mem2hex(&temp, ptr, 4, 0);
+			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(29), ptr, 4, 0);
+			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(30), ptr, 4, 0);
+#ifdef CONFIG_MMU
+			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(31), ptr, 4, 0);
+#else
+			temp = (unsigned long) __debug_frame;
+			ptr = mem2hex(&temp, ptr, 4, 0);
+#endif
+
+			for (loop = 32; loop <= 63; loop++)
+				ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(loop),
+					      ptr, 4, 0);
+
+			/* deal with FR0-FR63 */
+			for (loop = 0; loop <= 63; loop++)
+				ptr = mem2hex((unsigned long *)&__break_user_context +
+					      __FPMEDIA_FR(loop),
+					      ptr, 4, 0);
+
+			/* deal with special registers */
+			ptr = mem2hex(&__debug_frame->pc,    ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->psr,   ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->ccr,   ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->cccr,  ptr, 4, 0);
+			ptr = mem2hex(&zero, ptr, 4, 0);
+			ptr = mem2hex(&zero, ptr, 4, 0);
+			ptr = mem2hex(&zero, ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->tbr,   ptr, 4, 0);
+			ptr = mem2hex(&__debug_regs->brr ,   ptr, 4, 0);
+
+			asm volatile("movsg dbar0,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg dbar1,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg dbar2,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg dbar3,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+
+			asm volatile("movsg scr0,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg scr1,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg scr2,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+			asm volatile("movsg scr3,%0" : "=r"(dbar));
+			ptr = mem2hex(&dbar, ptr, 4, 0);
+
+			ptr = mem2hex(&__debug_frame->lr, ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->lcr, ptr, 4, 0);
+
+			ptr = mem2hex(&__debug_frame->iacc0, ptr, 8, 0);
+
+			ptr = mem2hex(&__break_user_context.f.fsr[0], ptr, 4, 0);
+
+			for (loop = 0; loop <= 7; loop++)
+				ptr = mem2hex(&__break_user_context.f.acc[loop], ptr, 4, 0);
+
+			ptr = mem2hex(&__break_user_context.f.accg, ptr, 8, 0);
+
+			for (loop = 0; loop <= 1; loop++)
+				ptr = mem2hex(&__break_user_context.f.msr[loop], ptr, 4, 0);
+
+			ptr = mem2hex(&__debug_frame->gner0, ptr, 4, 0);
+			ptr = mem2hex(&__debug_frame->gner1, ptr, 4, 0);
+
+			ptr = mem2hex(&__break_user_context.f.fner[0], ptr, 4, 0);
+			ptr = mem2hex(&__break_user_context.f.fner[1], ptr, 4, 0);
+
+			break;
+
+			/* set the values of the CPU registers */
+		case 'G':
+			ptr = &input_buffer[1];
+
+			/* deal with GR0, GR1-GR27, GR28-GR31, GR32-GR63 */
+			ptr = hex2mem(ptr, &temp, 4);
+
+			for (loop = 1; loop <= 27; loop++)
+				ptr = hex2mem(ptr, (unsigned long *)__debug_frame + REG_GR(loop),
+					      4);
+
+			ptr = hex2mem(ptr, &temp, 4);
+			__frame = (struct pt_regs *) temp;
+			ptr = hex2mem(ptr, &__debug_frame->gr29, 4);
+			ptr = hex2mem(ptr, &__debug_frame->gr30, 4);
+#ifdef CONFIG_MMU
+			ptr = hex2mem(ptr, &__debug_frame->gr31, 4);
+#else
+			ptr = hex2mem(ptr, &temp, 4);
+#endif
+
+			for (loop = 32; loop <= 63; loop++)
+				ptr = hex2mem(ptr, (unsigned long *)__debug_frame + REG_GR(loop),
+					      4);
+
+			/* deal with FR0-FR63 */
+			for (loop = 0; loop <= 63; loop++)
+				ptr = mem2hex((unsigned long *)&__break_user_context +
+					      __FPMEDIA_FR(loop),
+					      ptr, 4, 0);
+
+			/* deal with special registers */
+			ptr = hex2mem(ptr, &__debug_frame->pc,  4);
+			ptr = hex2mem(ptr, &__debug_frame->psr, 4);
+			ptr = hex2mem(ptr, &__debug_frame->ccr, 4);
+			ptr = hex2mem(ptr, &__debug_frame->cccr,4);
+
+			for (loop = 132; loop <= 140; loop++)
+				ptr = hex2mem(ptr, &temp, 4);
+
+			ptr = hex2mem(ptr, &temp, 4);
+			asm volatile("movgs %0,scr0" :: "r"(temp));
+			ptr = hex2mem(ptr, &temp, 4);
+			asm volatile("movgs %0,scr1" :: "r"(temp));
+			ptr = hex2mem(ptr, &temp, 4);
+			asm volatile("movgs %0,scr2" :: "r"(temp));
+			ptr = hex2mem(ptr, &temp, 4);
+			asm volatile("movgs %0,scr3" :: "r"(temp));
+
+			ptr = hex2mem(ptr, &__debug_frame->lr,  4);
+			ptr = hex2mem(ptr, &__debug_frame->lcr, 4);
+
+			ptr = hex2mem(ptr, &__debug_frame->iacc0, 8);
+
+			ptr = hex2mem(ptr, &__break_user_context.f.fsr[0], 4);
+
+			for (loop = 0; loop <= 7; loop++)
+				ptr = hex2mem(ptr, &__break_user_context.f.acc[loop], 4);
+
+			ptr = hex2mem(ptr, &__break_user_context.f.accg, 8);
+
+			for (loop = 0; loop <= 1; loop++)
+				ptr = hex2mem(ptr, &__break_user_context.f.msr[loop], 4);
+
+			ptr = hex2mem(ptr, &__debug_frame->gner0, 4);
+			ptr = hex2mem(ptr, &__debug_frame->gner1, 4);
+
+			ptr = hex2mem(ptr, &__break_user_context.f.fner[0], 4);
+			ptr = hex2mem(ptr, &__break_user_context.f.fner[1], 4);
+
+			gdbstub_strcpy(output_buffer,"OK");
+			break;
+
+			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
+		case 'm':
+			ptr = &input_buffer[1];
+
+			if (hexToInt(&ptr, &addr) &&
+			    *ptr++ == ',' &&
+			    hexToInt(&ptr, &length)
+			    ) {
+				if (mem2hex((char *)addr, output_buffer, length, 1))
+					break;
+				gdbstub_strcpy (output_buffer, "E03");
+			}
+			else {
+				gdbstub_strcpy(output_buffer,"E01");
+			}
+			break;
+
+			/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
+		case 'M':
+			ptr = &input_buffer[1];
+
+			if (hexToInt(&ptr, &addr) &&
+			    *ptr++ == ',' &&
+			    hexToInt(&ptr, &length) &&
+			    *ptr++ == ':'
+			    ) {
+				if (hex2mem(ptr, (char *)addr, length)) {
+					gdbstub_strcpy(output_buffer, "OK");
+				}
+				else {
+					gdbstub_strcpy(output_buffer, "E03");
+				}
+			}
+			else
+				gdbstub_strcpy(output_buffer, "E02");
+
+			flush_cache = 1;
+			break;
+
+			/* PNN,=RRRRRRRR: Write value R to reg N return OK */
+		case 'P':
+			ptr = &input_buffer[1];
+
+			if (!hexToInt(&ptr, &addr) ||
+			    *ptr++ != '=' ||
+			    !hexToInt(&ptr, &temp)
+			    ) {
+				gdbstub_strcpy(output_buffer, "E01");
+				break;
+			}
+
+			temp2 = 1;
+			switch (addr) {
+			case GDB_REG_GR(0):
+				break;
+			case GDB_REG_GR(1) ... GDB_REG_GR(63):
+				__break_user_context.i.gr[addr - GDB_REG_GR(0)] = temp;
+				break;
+			case GDB_REG_FR(0) ... GDB_REG_FR(63):
+				__break_user_context.f.fr[addr - GDB_REG_FR(0)] = temp;
+				break;
+			case GDB_REG_PC:
+				__break_user_context.i.pc = temp;
+				break;
+			case GDB_REG_PSR:
+				__break_user_context.i.psr = temp;
+				break;
+			case GDB_REG_CCR:
+				__break_user_context.i.ccr = temp;
+				break;
+			case GDB_REG_CCCR:
+				__break_user_context.i.cccr = temp;
+				break;
+			case GDB_REG_BRR:
+				__debug_regs->brr = temp;
+				break;
+			case GDB_REG_LR:
+				__break_user_context.i.lr = temp;
+				break;
+			case GDB_REG_LCR:
+				__break_user_context.i.lcr = temp;
+				break;
+			case GDB_REG_FSR0:
+				__break_user_context.f.fsr[0] = temp;
+				break;
+			case GDB_REG_ACC(0) ... GDB_REG_ACC(7):
+				__break_user_context.f.acc[addr - GDB_REG_ACC(0)] = temp;
+				break;
+			case GDB_REG_ACCG(0):
+				*(uint32_t *) &__break_user_context.f.accg[0] = temp;
+				break;
+			case GDB_REG_ACCG(4):
+				*(uint32_t *) &__break_user_context.f.accg[4] = temp;
+				break;
+			case GDB_REG_MSR(0) ... GDB_REG_MSR(1):
+				__break_user_context.f.msr[addr - GDB_REG_MSR(0)] = temp;
+				break;
+			case GDB_REG_GNER(0) ... GDB_REG_GNER(1):
+				__break_user_context.i.gner[addr - GDB_REG_GNER(0)] = temp;
+				break;
+			case GDB_REG_FNER(0) ... GDB_REG_FNER(1):
+				__break_user_context.f.fner[addr - GDB_REG_FNER(0)] = temp;
+				break;
+			default:
+				temp2 = 0;
+				break;
+			}
+
+			if (temp2) {
+				gdbstub_strcpy(output_buffer, "OK");
+			}
+			else {
+				gdbstub_strcpy(output_buffer, "E02");
+			}
+			break;
+
+			/* cAA..AA    Continue at address AA..AA(optional) */
+		case 'c':
+			/* try to read optional parameter, pc unchanged if no parm */
+			ptr = &input_buffer[1];
+			if (hexToInt(&ptr, &addr))
+				__debug_frame->pc = addr;
+			goto done;
+
+			/* kill the program */
+		case 'k' :
+			goto done;	/* just continue */
+
+
+			/* reset the whole machine (FIXME: system dependent) */
+		case 'r':
+			break;
+
+
+			/* step to next instruction */
+		case 's':
+			__debug_regs->dcr |= DCR_SE;
+			goto done;
+
+			/* set baud rate (bBB) */
+		case 'b':
+			ptr = &input_buffer[1];
+			if (!hexToInt(&ptr, &temp)) {
+				gdbstub_strcpy(output_buffer,"B01");
+				break;
+			}
+
+			if (temp) {
+				/* ack before changing speed */
+				gdbstub_send_packet("OK");
+				gdbstub_set_baud(temp);
+			}
+			break;
+
+			/* set breakpoint */
+		case 'Z':
+			ptr = &input_buffer[1];
+
+			if (!hexToInt(&ptr,&temp) || *ptr++ != ',' ||
+			    !hexToInt(&ptr,&addr) || *ptr++ != ',' ||
+			    !hexToInt(&ptr,&length)
+			    ) {
+				gdbstub_strcpy(output_buffer,"E01");
+				break;
+			}
+
+			if (temp >= 5) {
+				gdbstub_strcpy(output_buffer,"E03");
+				break;
+			}
+
+			if (gdbstub_set_breakpoint(temp, addr, length) < 0) {
+				gdbstub_strcpy(output_buffer,"E03");
+				break;
+			}
+
+			if (temp == 0)
+				flush_cache = 1; /* soft bkpt by modified memory */
+
+			gdbstub_strcpy(output_buffer,"OK");
+			break;
+
+			/* clear breakpoint */
+		case 'z':
+			ptr = &input_buffer[1];
+
+			if (!hexToInt(&ptr,&temp) || *ptr++ != ',' ||
+			    !hexToInt(&ptr,&addr) || *ptr++ != ',' ||
+			    !hexToInt(&ptr,&length)
+			    ) {
+				gdbstub_strcpy(output_buffer,"E01");
+				break;
+			}
+
+			if (temp >= 5) {
+				gdbstub_strcpy(output_buffer,"E03");
+				break;
+			}
+
+			if (gdbstub_clear_breakpoint(temp, addr, length) < 0) {
+				gdbstub_strcpy(output_buffer,"E03");
+				break;
+			}
+
+			if (temp == 0)
+				flush_cache = 1; /* soft bkpt by modified memory */
+
+			gdbstub_strcpy(output_buffer,"OK");
+			break;
+
+		default:
+			gdbstub_proto("### GDB Unsupported Cmd '%s'\n",input_buffer);
+			break;
+		}
+
+		/* reply to the request */
+		LEDS(0x5009);
+		gdbstub_send_packet(output_buffer);
+	}
+
+ done:
+	restore_user_regs(&__break_user_context);
+
+	//gdbstub_dump_debugregs();
+	//gdbstub_printk("<-- gdbstub() %08x\n", __debug_frame->pc);
+
+	/* need to flush the instruction cache before resuming, as we may have
+	 * deposited a breakpoint, and the icache probably has no way of
+	 * knowing that a data ref to some location may have changed something
+	 * that is in the instruction cache.  NB: We flush both caches, just to
+	 * be sure...
+	 */
+
+	/* note: flushing the icache will clobber EAR0 on the FR451 */
+	if (flush_cache)
+		gdbstub_purge_cache();
+
+	LEDS(0x5666);
+
+} /* end gdbstub() */
+
+/*****************************************************************************/
+/*
+ * initialise the GDB stub
+ */
+void __init gdbstub_init(void)
+{
+#ifdef CONFIG_GDBSTUB_IMMEDIATE
+	unsigned char ch;
+	int ret;
+#endif
+
+	gdbstub_printk("%s", gdbstub_banner);
+	gdbstub_printk("DCR: %x\n", __debug_regs->dcr);
+
+	gdbstub_io_init();
+
+	/* try to talk to GDB (or anyone insane enough to want to type GDB protocol by hand) */
+	gdbstub_proto("### GDB Tx ACK\n");
+	gdbstub_tx_char('+'); /* 'hello world' */
+
+#ifdef CONFIG_GDBSTUB_IMMEDIATE
+	gdbstub_printk("GDB Stub waiting for packet\n");
+
+	/*
+	 * In case GDB is started before us, ack any packets
+	 * (presumably "$?#xx") sitting there.
+	 */
+	do { gdbstub_rx_char(&ch, 0); } while (ch != '$');
+	do { gdbstub_rx_char(&ch, 0); } while (ch != '#');
+	do { ret = gdbstub_rx_char(&ch, 0); } while (ret != 0); /* eat first csum byte */
+	do { ret = gdbstub_rx_char(&ch, 0); } while (ret != 0); /* eat second csum byte */
+
+	gdbstub_proto("### GDB Tx NAK\n");
+	gdbstub_tx_char('-'); /* nak it */
+
+#else
+	gdbstub_printk("GDB Stub set\n");
+#endif
+
+#if 0
+	/* send banner */
+	ptr = output_buffer;
+	*ptr++ = 'O';
+	ptr = mem2hex(gdbstub_banner, ptr, sizeof(gdbstub_banner) - 1, 0);
+	gdbstub_send_packet(output_buffer);
+#endif
+#if defined(CONFIG_GDBSTUB_CONSOLE) && defined(CONFIG_GDBSTUB_IMMEDIATE)
+	register_console(&gdbstub_console);
+#endif
+
+} /* end gdbstub_init() */
+
+/*****************************************************************************/
+/*
+ * register the console at a more appropriate time
+ */
+#if defined (CONFIG_GDBSTUB_CONSOLE) && !defined(CONFIG_GDBSTUB_IMMEDIATE)
+static int __init gdbstub_postinit(void)
+{
+	printk("registering console\n");
+	register_console(&gdbstub_console);
+	return 0;
+} /* end gdbstub_postinit() */
+
+__initcall(gdbstub_postinit);
+#endif
+
+/*****************************************************************************/
+/*
+ * send an exit message to GDB
+ */
+void gdbstub_exit(int status)
+{
+	unsigned char checksum;
+	int count;
+	unsigned char ch;
+
+	sprintf(output_buffer,"W%02x",status&0xff);
+
+	gdbstub_tx_char('$');
+	checksum = 0;
+	count = 0;
+
+	while ((ch = output_buffer[count]) != 0) {
+		gdbstub_tx_char(ch);
+		checksum += ch;
+		count += 1;
+	}
+
+	gdbstub_tx_char('#');
+	gdbstub_tx_char(hexchars[checksum >> 4]);
+	gdbstub_tx_char(hexchars[checksum & 0xf]);
+
+	/* make sure the output is flushed, or else RedBoot might clobber it */
+	gdbstub_tx_char('-');
+	gdbstub_tx_flush();
+
+} /* end gdbstub_exit() */
+
+/*****************************************************************************/
+/*
+ * GDB wants to call malloc() and free() to allocate memory for calling kernel
+ * functions directly from its command line
+ */
+static void *malloc(size_t size) __attribute__((unused));
+static void *malloc(size_t size)
+{
+	return kmalloc(size, GFP_ATOMIC);
+}
+
+static void free(void *p) __attribute__((unused));
+static void free(void *p)
+{
+	kfree(p);
+}
+
+static uint32_t ___get_HSR0(void) __attribute__((unused));
+static uint32_t ___get_HSR0(void)
+{
+	return __get_HSR(0);
+}
+
+static uint32_t ___set_HSR0(uint32_t x) __attribute__((unused));
+static uint32_t ___set_HSR0(uint32_t x)
+{
+	__set_HSR(0, x);
+	return __get_HSR(0);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head.inc linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head.inc
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head.inc	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head.inc	2004-11-05 14:13:03.112562578 +0000
@@ -0,0 +1,50 @@
+/* head.inc: head common definitions -*- asm -*-
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+#if defined(CONFIG_MB93090_MB00)
+#define LED_ADDR (0x21200000+4)
+
+.macro LEDS val
+	sethi.p		%hi(0xFFC00030),gr3
+	setlo		%lo(0xFFC00030),gr3
+	lduh		@(gr3,gr0),gr3
+	andicc		gr3,#0x100,gr0,icc0
+	bne		icc0,0,999f
+	
+	setlos		#~\val,gr3
+	st		gr3,@(gr30,gr0)
+	membar
+	dcf		@(gr30,gr0)
+    999:
+.endm
+
+#elif defined(CONFIG_MB93093_PDK)
+#define LED_ADDR (0x20000023)
+
+.macro LEDS val
+	setlos		#\val,gr3
+	stb		gr3,@(gr30,gr0)
+	membar
+.endm
+
+#else
+#define LED_ADDR 0
+
+.macro LEDS val
+.endm
+#endif	
+
+#ifdef CONFIG_MMU
+__sdram_base = 0x00000000		/* base address to which SDRAM relocated */
+#else
+__sdram_base = 0xc0000000		/* base address to which SDRAM relocated */
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head-mmu-fr451.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head-mmu-fr451.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head-mmu-fr451.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head-mmu-fr451.S	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,374 @@
+/* head-mmu-fr451.S: FR451 mmu-linux specific bits of initialisation
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <asm/mem-layout.h>
+#include <asm/spr-regs.h>
+#include <asm/mb86943a.h>
+#include "head.inc"
+
+
+#define __400_DBR0	0xfe000e00
+#define __400_DBR1	0xfe000e08
+#define __400_DBR2	0xfe000e10
+#define __400_DBR3	0xfe000e18
+#define __400_DAM0	0xfe000f00
+#define __400_DAM1	0xfe000f08
+#define __400_DAM2	0xfe000f10
+#define __400_DAM3	0xfe000f18
+#define __400_LGCR	0xfe000010
+#define __400_LCR	0xfe000100
+#define __400_LSBR	0xfe000c00
+
+	.section	.text.init,"ax"
+	.balign		4
+
+###############################################################################
+#
+# describe the position and layout of the SDRAM controller registers
+#
+#	ENTRY:			EXIT:
+# GR5	-			cacheline size
+# GR11	-			displacement of 2nd SDRAM addr reg from GR14
+# GR12	-			displacement of 3rd SDRAM addr reg from GR14
+# GR13	-			displacement of 4th SDRAM addr reg from GR14
+# GR14	-			address of 1st SDRAM addr reg
+# GR15	-			amount to shift address by to match SDRAM addr reg
+# GR26	&__head_reference	[saved]
+# GR30	LED address		[saved]
+# CC0	-			T if DBR0 is present
+# CC1	-			T if DBR1 is present
+# CC2	-			T if DBR2 is present
+# CC3	-			T if DBR3 is present
+#
+###############################################################################
+	.globl		__head_fr451_describe_sdram
+__head_fr451_describe_sdram:
+	sethi.p		%hi(__400_DBR0),gr14
+	setlo		%lo(__400_DBR0),gr14
+	setlos.p	#__400_DBR1-__400_DBR0,gr11
+	setlos		#__400_DBR2-__400_DBR0,gr12
+	setlos.p	#__400_DBR3-__400_DBR0,gr13
+	setlos		#32,gr5			; cacheline size
+	setlos.p	#0,gr15			; amount to shift addr reg by
+	setlos		#0x00ff,gr4
+	movgs		gr4,cccr		; extant DARS/DAMK regs
+	bralr
+
+###############################################################################
+#
+# rearrange the bus controller registers
+#
+#	ENTRY:			EXIT:
+# GR26	&__head_reference	[saved]
+# GR30	LED address		revised LED address
+#
+###############################################################################
+	.globl		__head_fr451_set_busctl
+__head_fr451_set_busctl:
+	sethi.p		%hi(__400_LGCR),gr4
+	setlo		%lo(__400_LGCR),gr4
+	sethi.p		%hi(__400_LSBR),gr10
+	setlo		%lo(__400_LSBR),gr10
+	sethi.p		%hi(__400_LCR),gr11
+	setlo		%lo(__400_LCR),gr11
+
+	# set the bus controller
+	ldi		@(gr4,#0),gr5
+	ori		gr5,#0xff,gr5		; make sure all chip-selects are enabled
+	sti		gr5,@(gr4,#0)
+
+	sethi.p		%hi(__region_CS1),gr4
+	setlo		%lo(__region_CS1),gr4
+	sethi.p		%hi(__region_CS1_M),gr5
+	setlo		%lo(__region_CS1_M),gr5
+	sethi.p		%hi(__region_CS1_C),gr6
+	setlo		%lo(__region_CS1_C),gr6
+	sti		gr4,@(gr10,#1*0x08)
+	sti		gr5,@(gr10,#1*0x08+0x100)
+	sti		gr6,@(gr11,#1*0x08)
+	sethi.p		%hi(__region_CS2),gr4
+	setlo		%lo(__region_CS2),gr4
+	sethi.p		%hi(__region_CS2_M),gr5
+	setlo		%lo(__region_CS2_M),gr5
+	sethi.p		%hi(__region_CS2_C),gr6
+	setlo		%lo(__region_CS2_C),gr6
+	sti		gr4,@(gr10,#2*0x08)
+	sti		gr5,@(gr10,#2*0x08+0x100)
+	sti		gr6,@(gr11,#2*0x08)
+	sethi.p		%hi(__region_CS3),gr4
+	setlo		%lo(__region_CS3),gr4
+	sethi.p		%hi(__region_CS3_M),gr5
+	setlo		%lo(__region_CS3_M),gr5
+	sethi.p		%hi(__region_CS3_C),gr6
+	setlo		%lo(__region_CS3_C),gr6
+	sti		gr4,@(gr10,#3*0x08)
+	sti		gr5,@(gr10,#3*0x08+0x100)
+	sti		gr6,@(gr11,#3*0x08)
+	sethi.p		%hi(__region_CS4),gr4
+	setlo		%lo(__region_CS4),gr4
+	sethi.p		%hi(__region_CS4_M),gr5
+	setlo		%lo(__region_CS4_M),gr5
+	sethi.p		%hi(__region_CS4_C),gr6
+	setlo		%lo(__region_CS4_C),gr6
+	sti		gr4,@(gr10,#4*0x08)
+	sti		gr5,@(gr10,#4*0x08+0x100)
+	sti		gr6,@(gr11,#4*0x08)
+	sethi.p		%hi(__region_CS5),gr4
+	setlo		%lo(__region_CS5),gr4
+	sethi.p		%hi(__region_CS5_M),gr5
+	setlo		%lo(__region_CS5_M),gr5
+	sethi.p		%hi(__region_CS5_C),gr6
+	setlo		%lo(__region_CS5_C),gr6
+	sti		gr4,@(gr10,#5*0x08)
+	sti		gr5,@(gr10,#5*0x08+0x100)
+	sti		gr6,@(gr11,#5*0x08)
+	sethi.p		%hi(__region_CS6),gr4
+	setlo		%lo(__region_CS6),gr4
+	sethi.p		%hi(__region_CS6_M),gr5
+	setlo		%lo(__region_CS6_M),gr5
+	sethi.p		%hi(__region_CS6_C),gr6
+	setlo		%lo(__region_CS6_C),gr6
+	sti		gr4,@(gr10,#6*0x08)
+	sti		gr5,@(gr10,#6*0x08+0x100)
+	sti		gr6,@(gr11,#6*0x08)
+	sethi.p		%hi(__region_CS7),gr4
+	setlo		%lo(__region_CS7),gr4
+	sethi.p		%hi(__region_CS7_M),gr5
+	setlo		%lo(__region_CS7_M),gr5
+	sethi.p		%hi(__region_CS7_C),gr6
+	setlo		%lo(__region_CS7_C),gr6
+	sti		gr4,@(gr10,#7*0x08)
+	sti		gr5,@(gr10,#7*0x08+0x100)
+	sti		gr6,@(gr11,#7*0x08)
+	membar
+	bar
+
+	# adjust LED bank address
+#ifdef CONFIG_MB93091_VDK
+	sethi.p		%hi(__region_CS2 + 0x01200004),gr30
+	setlo		%lo(__region_CS2 + 0x01200004),gr30
+#endif
+	bralr
+
+###############################################################################
+#
+# determine the total SDRAM size
+#
+#	ENTRY:			EXIT:
+# GR25	-			SDRAM size
+# GR26	&__head_reference	[saved]
+# GR30	LED address		[saved]
+#
+###############################################################################
+	.globl		__head_fr451_survey_sdram
+__head_fr451_survey_sdram:
+	sethi.p		%hi(__400_DAM0),gr11
+	setlo		%lo(__400_DAM0),gr11
+	sethi.p		%hi(__400_DBR0),gr12
+	setlo		%lo(__400_DBR0),gr12
+
+	sethi.p		%hi(0xfe000000),gr17		; unused SDRAM DBR value
+	setlo		%lo(0xfe000000),gr17
+	setlos		#0,gr25
+
+	ldi		@(gr12,#0x00),gr4		; DAR0
+	subcc		gr4,gr17,gr0,icc0
+	beq		icc0,#0,__head_no_DCS0
+	ldi		@(gr11,#0x00),gr6		; DAM0: bits 31:20 match addr 31:20
+	add		gr25,gr6,gr25
+	addi		gr25,#1,gr25
+__head_no_DCS0:
+
+	ldi		@(gr12,#0x08),gr4		; DAR1
+	subcc		gr4,gr17,gr0,icc0
+	beq		icc0,#0,__head_no_DCS1
+	ldi		@(gr11,#0x08),gr6		; DAM1: bits 31:20 match addr 31:20
+	add		gr25,gr6,gr25
+	addi		gr25,#1,gr25
+__head_no_DCS1:
+
+	ldi		@(gr12,#0x10),gr4		; DAR2
+	subcc		gr4,gr17,gr0,icc0
+	beq		icc0,#0,__head_no_DCS2
+	ldi		@(gr11,#0x10),gr6		; DAM2: bits 31:20 match addr 31:20
+	add		gr25,gr6,gr25
+	addi		gr25,#1,gr25
+__head_no_DCS2:
+
+	ldi		@(gr12,#0x18),gr4		; DAR3
+	subcc		gr4,gr17,gr0,icc0
+	beq		icc0,#0,__head_no_DCS3
+	ldi		@(gr11,#0x18),gr6		; DAM3: bits 31:20 match addr 31:20
+	add		gr25,gr6,gr25
+	addi		gr25,#1,gr25
+__head_no_DCS3:
+	bralr
+
+###############################################################################
+#
+# set the protection map with the I/DAMPR registers
+#
+#	ENTRY:			EXIT:
+# GR25	SDRAM size		[saved]
+# GR26	&__head_reference	[saved]
+# GR30	LED address		[saved]
+#
+#
+# Using this map:
+#	REGISTERS	ADDRESS RANGE		VIEW
+#	===============	======================	===============================
+#	IAMPR0/DAMPR0	0xC0000000-0xCFFFFFFF	Cached kernel RAM Window
+#	DAMPR11		0xE0000000-0xFFFFFFFF	Uncached I/O
+#
+###############################################################################
+	.globl		__head_fr451_set_protection
+__head_fr451_set_protection:
+	movsg		lr,gr27
+
+	# set the I/O region protection registers for FR451 in MMU mode
+#define PGPROT_IO	xAMPRx_L|xAMPRx_M|xAMPRx_S_KERNEL|xAMPRx_C|xAMPRx_V
+
+	sethi.p		%hi(__region_IO),gr5
+	setlo		%lo(__region_IO),gr5
+	setlos		#PGPROT_IO|xAMPRx_SS_512Mb,gr4
+	or		gr4,gr5,gr4
+	movgs		gr5,damlr11			; General I/O tile
+	movgs		gr4,dampr11
+
+	# need to open a window onto at least part of the RAM for the kernel's use
+	sethi.p		%hi(__sdram_base),gr8
+	setlo		%lo(__sdram_base),gr8		; physical address
+	sethi.p		%hi(__page_offset),gr9
+	setlo		%lo(__page_offset),gr9		; virtual address
+
+	setlos		#xAMPRx_L|xAMPRx_M|xAMPRx_SS_256Mb|xAMPRx_S_KERNEL|xAMPRx_V,gr11
+	or		gr8,gr11,gr8
+
+	movgs		gr9,iamlr0			; mapped from real address 0
+	movgs		gr8,iampr0			; cached kernel memory at 0xC0000000
+	movgs		gr9,damlr0
+	movgs		gr8,dampr0
+
+	# set a temporary mapping for the kernel running at address 0 until we've turned on the MMU
+	sethi.p		%hi(__sdram_base),gr9
+	setlo		%lo(__sdram_base),gr9		; virtual address
+
+	and.p		gr4,gr11,gr4
+	and		gr5,gr11,gr5
+	or.p		gr4,gr11,gr4
+	or		gr5,gr11,gr5
+
+	movgs		gr9,iamlr1			; mapped from real address 0
+	movgs		gr8,iampr1			; cached kernel memory at 0x00000000
+	movgs		gr9,damlr1
+	movgs		gr8,dampr1
+
+	# we use DAMR2-10 for kmap_atomic(), cache flush and TLB management
+	# since the DAMLR regs are not going to change, we can set them now
+	# also set up IAMLR2 to the same as DAMLR5
+	sethi.p		%hi(KMAP_ATOMIC_PRIMARY_FRAME),gr4
+	setlo		%lo(KMAP_ATOMIC_PRIMARY_FRAME),gr4
+	sethi.p		%hi(PAGE_SIZE),gr5
+	setlo		%lo(PAGE_SIZE),gr5
+	
+	movgs		gr4,damlr2
+	movgs		gr4,iamlr2
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr3
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr4
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr5
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr6
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr7
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr8
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr9
+	add		gr4,gr5,gr4
+	movgs		gr4,damlr10
+
+	movgs		gr0,dampr2
+	movgs		gr0,dampr4
+	movgs		gr0,dampr5
+	movgs		gr0,dampr6
+	movgs		gr0,dampr7
+	movgs		gr0,dampr8
+	movgs		gr0,dampr9
+	movgs		gr0,dampr10
+
+	movgs		gr0,iamlr3
+	movgs		gr0,iamlr4
+	movgs		gr0,iamlr5
+	movgs		gr0,iamlr6
+	movgs		gr0,iamlr7
+
+	movgs		gr0,iampr2
+	movgs		gr0,iampr3
+	movgs		gr0,iampr4
+	movgs		gr0,iampr5
+	movgs		gr0,iampr6
+	movgs		gr0,iampr7
+
+	# start in TLB context 0 with the swapper's page tables
+	movgs		gr0,cxnr
+
+	sethi.p		%hi(swapper_pg_dir),gr4
+	setlo		%lo(swapper_pg_dir),gr4
+	sethi.p		%hi(__page_offset),gr5
+	setlo		%lo(__page_offset),gr5
+	sub		gr4,gr5,gr4
+	movgs		gr4,ttbr
+	setlos		#xAMPRx_L|xAMPRx_M|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V,gr5
+	or		gr4,gr5,gr4
+	movgs		gr4,dampr3
+
+	# the FR451 also has an extra trap base register
+	movsg		tbr,gr4
+	movgs		gr4,btbr
+
+	LEDS		0x3300
+	jmpl		@(gr27,gr0)
+
+###############################################################################
+#
+# finish setting up the protection registers
+#
+###############################################################################
+	.globl		__head_fr451_finalise_protection
+__head_fr451_finalise_protection:
+	# turn on the timers as appropriate
+	movgs		gr0,timerh
+	movgs		gr0,timerl
+	movgs		gr0,timerd
+	movsg		hsr0,gr4
+	sethi.p		%hi(HSR0_ETMI),gr5
+	setlo		%lo(HSR0_ETMI),gr5
+	or		gr4,gr5,gr4
+	movgs		gr4,hsr0
+	
+	# clear the TLB entry cache
+	movgs		gr0,iamlr1
+	movgs		gr0,iampr1
+	movgs		gr0,damlr1
+	movgs		gr0,dampr1
+
+	# clear the PGE cache
+	sethi.p		%hi(__flush_tlb_all),gr4
+	setlo		%lo(__flush_tlb_all),gr4
+	jmpl		@(gr4,gr0)
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/head.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/head.S	2004-11-05 14:13:03.123561649 +0000
@@ -0,0 +1,638 @@
+/* head.S: kernel entry point for FR-V kernel
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <asm/spr-regs.h>
+#include <asm/mb86943a.h>
+#include "head.inc"
+
+###############################################################################
+#
+# void _boot(unsigned long magic, char *command_line) __attribute__((noreturn))
+#
+# - if magic is 0xdead1eaf, then command_line is assumed to point to the kernel
+#   command line string
+#
+###############################################################################
+	.section	.text.head,"ax"
+	.balign		4
+
+	.globl		_boot, __head_reference
+        .type		_boot,@function
+_boot:
+__head_reference:
+	sethi.p		%hi(LED_ADDR),gr30
+	setlo		%lo(LED_ADDR),gr30
+
+	LEDS		0x0000
+
+	# calculate reference address for PC-relative stuff
+	call		0f
+0:	movsg		lr,gr26
+	addi		gr26,#__head_reference-0b,gr26
+
+	# invalidate and disable both of the caches and turn off the memory access checking
+	dcef		@(gr0,gr0),1
+	bar
+
+	sethi.p		%hi(~(HSR0_ICE|HSR0_DCE|HSR0_CBM|HSR0_EIMMU|HSR0_EDMMU)),gr4
+	setlo		%lo(~(HSR0_ICE|HSR0_DCE|HSR0_CBM|HSR0_EIMMU|HSR0_EDMMU)),gr4
+	movsg		hsr0,gr5
+	and		gr4,gr5,gr5
+	movgs		gr5,hsr0
+	movsg		hsr0,gr5
+
+	LEDS		0x0001
+
+	icei		@(gr0,gr0),1
+	dcei		@(gr0,gr0),1
+	bar
+
+	# turn the instruction cache back on
+	sethi.p		%hi(HSR0_ICE),gr4
+	setlo		%lo(HSR0_ICE),gr4
+	movsg		hsr0,gr5
+	or		gr4,gr5,gr5
+	movgs		gr5,hsr0
+	movsg		hsr0,gr5
+
+	bar
+
+	LEDS		0x0002
+
+	# retrieve the parameters (including command line) before we overwrite them
+	sethi.p		%hi(0xdead1eaf),gr7
+	setlo		%lo(0xdead1eaf),gr7
+	subcc		gr7,gr8,gr0,icc0
+	bne		icc0,#0,__head_no_parameters
+
+	sethi.p		%hi(redboot_command_line-1),gr6
+	setlo		%lo(redboot_command_line-1),gr6
+	sethi.p		%hi(__head_reference),gr4
+	setlo		%lo(__head_reference),gr4
+	sub		gr6,gr4,gr6
+	add.p		gr6,gr26,gr6
+	subi		gr9,#1,gr9
+	setlos.p	#511,gr4
+	setlos		#1,gr5
+
+__head_copy_cmdline:
+	ldubu.p		@(gr9,gr5),gr16
+	subicc		gr4,#1,gr4,icc0
+	stbu.p		gr16,@(gr6,gr5)
+	subicc		gr16,#0,gr0,icc1
+	bls		icc0,#0,__head_end_cmdline
+	bne		icc1,#1,__head_copy_cmdline
+__head_end_cmdline:
+	stbu		gr0,@(gr6,gr5)
+__head_no_parameters:
+
+###############################################################################
+#
+# we need to relocate the SDRAM to 0x00000000 (linux) or 0xC0000000 (uClinux)
+# - note that we're going to have to run entirely out of the icache whilst
+#   fiddling with the SDRAM controller registers
+#
+###############################################################################
+#ifdef CONFIG_MMU
+	call		__head_fr451_describe_sdram
+
+#else
+	movsg		psr,gr5
+	srli		gr5,#28,gr5
+	subicc		gr5,#3,gr0,icc0
+	beq		icc0,#0,__head_fr551_sdram
+
+	call		__head_fr401_describe_sdram
+	bra		__head_do_sdram
+
+__head_fr551_sdram:
+	call		__head_fr555_describe_sdram
+	LEDS		0x000d
+
+__head_do_sdram:
+#endif
+
+	# preload the registers with invalid values in case any DBR/DARS are marked not present
+	sethi.p		%hi(0xfe000000),gr17		; unused SDRAM DBR value
+	setlo		%lo(0xfe000000),gr17
+	or.p		gr17,gr0,gr20
+	or		gr17,gr0,gr21
+	or.p		gr17,gr0,gr22
+	or		gr17,gr0,gr23
+
+	# consult the SDRAM controller CS address registers
+	cld		@(gr14,gr0 ),gr20,	cc0,#1	; DBR0 / DARS0
+	cld		@(gr14,gr11),gr21,	cc1,#1	; DBR1 / DARS1
+	cld		@(gr14,gr12),gr22,	cc2,#1	; DBR2 / DARS2
+	cld.p		@(gr14,gr13),gr23,	cc3,#1	; DBR3 / DARS3
+
+	sll		gr20,gr15,gr20			; shift values up for FR551
+	sll		gr21,gr15,gr21
+	sll		gr22,gr15,gr22
+	sll		gr23,gr15,gr23
+
+	LEDS		0x0003
+
+	# assume the lowest valid CS line to be the SDRAM base and get its address
+	subcc		gr20,gr17,gr0,icc0
+	subcc.p		gr21,gr17,gr0,icc1
+	subcc		gr22,gr17,gr0,icc2
+	subcc.p		gr23,gr17,gr0,icc3
+	ckne		icc0,cc4			; T if DBR0 != 0xfe000000
+	ckne		icc1,cc5
+	ckne		icc2,cc6
+	ckne		icc3,cc7
+	cor		gr23,gr0,gr24,		cc7,#1	; GR24 = SDRAM base
+	cor		gr22,gr0,gr24,		cc6,#1
+	cor		gr21,gr0,gr24,		cc5,#1
+	cor		gr20,gr0,gr24,		cc4,#1
+
+	# calculate the displacement required to get the SDRAM into the right place in memory
+	sethi.p		%hi(__sdram_base),gr16
+	setlo		%lo(__sdram_base),gr16
+	sub		gr16,gr24,gr16			; delta = __sdram_base - DBRx
+
+	# calculate the new values to go in the controller regs
+	cadd.p		gr20,gr16,gr20,		cc4,#1	; DCS#0 (new) = DCS#0 (old) + delta
+	cadd		gr21,gr16,gr21,		cc5,#1
+	cadd.p		gr22,gr16,gr22,		cc6,#1
+	cadd		gr23,gr16,gr23,		cc7,#1
+
+	srl		gr20,gr15,gr20			; shift values down for FR551
+	srl		gr21,gr15,gr21
+	srl		gr22,gr15,gr22
+	srl		gr23,gr15,gr23
+
+	# work out the address at which the reg updater resides and lock it into icache
+	# also work out the address the updater will jump to when finished
+	sethi.p		%hi(__head_move_sdram-__head_reference),gr18
+	setlo		%lo(__head_move_sdram-__head_reference),gr18
+	sethi.p		%hi(__head_sdram_moved-__head_reference),gr19
+	setlo		%lo(__head_sdram_moved-__head_reference),gr19
+	add.p		gr18,gr26,gr18
+	add		gr19,gr26,gr19
+	add.p		gr19,gr16,gr19			; moved = addr + (__sdram_base - DBRx)
+	add		gr18,gr5,gr4			; two cachelines probably required
+
+	icpl		gr18,gr0,#1			; load and lock the cachelines
+	icpl		gr4,gr0,#1
+	LEDS		0x0004
+	membar
+	bar
+	jmpl		@(gr18,gr0)
+
+	.balign		32
+__head_move_sdram:
+	cst		gr20,@(gr14,gr0 ),	cc4,#1
+	cst		gr21,@(gr14,gr11),	cc5,#1
+	cst		gr22,@(gr14,gr12),	cc6,#1
+	cst		gr23,@(gr14,gr13),	cc7,#1
+	cld		@(gr14,gr0 ),gr20,	cc4,#1
+	cld		@(gr14,gr11),gr21,	cc5,#1
+	cld		@(gr14,gr12),gr22,	cc4,#1
+	cld		@(gr14,gr13),gr23,	cc7,#1
+	bar
+	membar
+	jmpl		@(gr19,gr0)
+
+	.balign		32
+__head_sdram_moved:
+	icul		gr18
+	add		gr18,gr5,gr4
+	icul		gr4
+	icei		@(gr0,gr0),1
+	dcei		@(gr0,gr0),1
+
+	LEDS		0x0005
+
+	# recalculate reference address
+	call		0f
+0:	movsg		lr,gr26
+	addi		gr26,#__head_reference-0b,gr26
+
+
+###############################################################################
+#
+# move the kernel image down to the bottom of the SDRAM
+#
+###############################################################################
+	sethi.p		%hi(__kernel_image_size_no_bss+15),gr4
+	setlo		%lo(__kernel_image_size_no_bss+15),gr4
+	srli.p		gr4,#4,gr4			; count
+	or		gr26,gr26,gr16			; source
+
+	sethi.p		%hi(__sdram_base),gr17		; destination
+	setlo		%lo(__sdram_base),gr17
+
+	setlos		#8,gr5
+	sub.p		gr16,gr5,gr16			; adjust src for LDDU
+	sub		gr17,gr5,gr17			; adjust dst for LDDU
+
+	sethi.p		%hi(__head_move_kernel-__head_reference),gr18
+	setlo		%lo(__head_move_kernel-__head_reference),gr18
+	sethi.p		%hi(__head_kernel_moved-__head_reference+__sdram_base),gr19
+	setlo		%lo(__head_kernel_moved-__head_reference+__sdram_base),gr19
+	add		gr18,gr26,gr18
+	icpl		gr18,gr0,#1
+	jmpl		@(gr18,gr0)
+
+	.balign		32
+__head_move_kernel:
+	lddu		@(gr16,gr5),gr10
+	lddu		@(gr16,gr5),gr12
+	stdu.p		gr10,@(gr17,gr5)
+	subicc		gr4,#1,gr4,icc0
+	stdu.p		gr12,@(gr17,gr5)
+	bhi		icc0,#0,__head_move_kernel
+	jmpl		@(gr19,gr0)
+
+	.balign		32
+__head_kernel_moved:
+	icul		gr18
+	icei		@(gr0,gr0),1
+	dcei		@(gr0,gr0),1
+
+	LEDS		0x0006
+
+	# recalculate reference address
+	call		0f
+0:	movsg		lr,gr26
+	addi		gr26,#__head_reference-0b,gr26
+
+
+###############################################################################
+#
+# rearrange the iomem map and set the protection registers
+#
+###############################################################################
+
+#ifdef CONFIG_MMU
+	LEDS		0x3301
+	call		__head_fr451_set_busctl
+	LEDS		0x3303
+	call		__head_fr451_survey_sdram
+	LEDS		0x3305
+	call		__head_fr451_set_protection
+
+#else
+	movsg		psr,gr5
+	srli		gr5,#PSR_IMPLE_SHIFT,gr5
+	subicc		gr5,#PSR_IMPLE_FR551,gr0,icc0
+	beq		icc0,#0,__head_fr555_memmap
+	subicc		gr5,#PSR_IMPLE_FR451,gr0,icc0
+	beq		icc0,#0,__head_fr451_memmap
+
+	LEDS		0x3101
+	call		__head_fr401_set_busctl
+	LEDS		0x3103
+	call		__head_fr401_survey_sdram
+	LEDS		0x3105
+	call		__head_fr401_set_protection
+	bra		__head_done_memmap
+
+__head_fr451_memmap:
+	LEDS		0x3301
+	call		__head_fr401_set_busctl
+	LEDS		0x3303
+	call		__head_fr401_survey_sdram
+	LEDS		0x3305
+	call		__head_fr451_set_protection
+	bra		__head_done_memmap
+
+__head_fr555_memmap:
+	LEDS		0x3501
+	call		__head_fr555_set_busctl
+	LEDS		0x3503
+	call		__head_fr555_survey_sdram
+	LEDS		0x3505
+	call		__head_fr555_set_protection
+
+__head_done_memmap:
+#endif
+	LEDS		0x0007
+
+###############################################################################
+#
+# turn the data cache and MMU on
+# - for the FR451 this'll mean that the window through which the kernel is
+#   viewed will change
+#
+###############################################################################
+
+#ifdef CONFIG_MMU
+#define MMUMODE		HSR0_EIMMU|HSR0_EDMMU|HSR0_EXMMU|HSR0_EDAT|HSR0_XEDAT
+#else
+#define MMUMODE		HSR0_EIMMU|HSR0_EDMMU
+#endif
+
+	movsg		hsr0,gr5
+
+	sethi.p		%hi(MMUMODE),gr4
+	setlo		%lo(MMUMODE),gr4
+	or		gr4,gr5,gr5
+
+#if defined(CONFIG_FRV_DEFL_CACHE_WTHRU)
+	sethi.p		%hi(HSR0_DCE|HSR0_CBM_WRITE_THRU),gr4
+	setlo		%lo(HSR0_DCE|HSR0_CBM_WRITE_THRU),gr4
+#elif defined(CONFIG_FRV_DEFL_CACHE_WBACK)
+	sethi.p		%hi(HSR0_DCE|HSR0_CBM_COPY_BACK),gr4
+	setlo		%lo(HSR0_DCE|HSR0_CBM_COPY_BACK),gr4
+#elif defined(CONFIG_FRV_DEFL_CACHE_WBEHIND)
+	sethi.p		%hi(HSR0_DCE|HSR0_CBM_COPY_BACK),gr4
+	setlo		%lo(HSR0_DCE|HSR0_CBM_COPY_BACK),gr4
+
+	movsg		psr,gr6
+	srli		gr6,#24,gr6
+	cmpi		gr6,#0x50,icc0		// FR451
+	beq		icc0,#0,0f
+	cmpi		gr6,#0x40,icc0		// FR405
+	bne		icc0,#0,1f
+0:
+	# turn off write-allocate
+	sethi.p		%hi(HSR0_NWA),gr6
+	setlo		%lo(HSR0_NWA),gr6
+	or		gr4,gr6,gr4
+1:
+
+#else
+#error No default cache configuration set
+#endif
+
+	or		gr4,gr5,gr5
+	movgs		gr5,hsr0
+	bar
+
+	LEDS		0x0008
+
+	sethi.p		%hi(__head_mmu_enabled),gr19
+	setlo		%lo(__head_mmu_enabled),gr19
+	jmpl		@(gr19,gr0)
+
+__head_mmu_enabled:
+	icei		@(gr0,gr0),#1
+	dcei		@(gr0,gr0),#1
+
+	LEDS		0x0009
+
+#ifdef CONFIG_MMU
+	call		__head_fr451_finalise_protection
+#endif
+
+	LEDS		0x000a
+
+###############################################################################
+#
+# set up the runtime environment
+#
+###############################################################################
+
+	# clear the BSS area
+	sethi.p		%hi(__bss_start),gr4
+	setlo		%lo(__bss_start),gr4
+	sethi.p		%hi(_end),gr5
+	setlo		%lo(_end),gr5
+	or.p		gr0,gr0,gr18
+	or		gr0,gr0,gr19
+
+0:
+	stdi		gr18,@(gr4,#0)
+	stdi		gr18,@(gr4,#8)
+	stdi		gr18,@(gr4,#16)
+	stdi.p		gr18,@(gr4,#24)
+	addi		gr4,#24,gr4
+	subcc		gr5,gr4,gr0,icc0
+	bhi		icc0,#2,0b
+
+	LEDS		0x000b
+
+	# save the SDRAM details
+	sethi.p		%hi(__sdram_old_base),gr4
+	setlo		%lo(__sdram_old_base),gr4
+	st		gr24,@(gr4,gr0)
+
+	sethi.p		%hi(__sdram_base),gr5
+	setlo		%lo(__sdram_base),gr5
+	sethi.p		%hi(memory_start),gr4
+	setlo		%lo(memory_start),gr4
+	st		gr5,@(gr4,gr0)
+
+	add		gr25,gr5,gr25
+	sethi.p		%hi(memory_end),gr4
+	setlo		%lo(memory_end),gr4
+	st		gr25,@(gr4,gr0)
+
+	# point the TBR at the kernel trap table
+	sethi.p		%hi(__entry_kerneltrap_table),gr4
+	setlo		%lo(__entry_kerneltrap_table),gr4
+	movgs		gr4,tbr
+
+	# set up the exception frame for init
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	sethi.p		%hi(_gp),gr16
+	setlo		%lo(_gp),gr16
+	sethi.p		%hi(__entry_usertrap_table),gr4
+	setlo		%lo(__entry_usertrap_table),gr4
+
+	lddi		@(gr28,#0),gr28		; load __frame & current
+	ldi.p		@(gr29,#4),gr15		; set current_thread
+
+	or		gr0,gr0,fp
+	or		gr28,gr0,sp
+
+	sti.p		gr4,@(gr28,REG_TBR)
+	setlos		#ISR_EDE|ISR_DTT_DIVBYZERO|ISR_EMAM_EXCEPTION,gr5
+	movgs		gr5,isr
+
+	# turn on and off various CPU services
+	movsg		psr,gr22
+	sethi.p		%hi(#PSR_EM|PSR_EF|PSR_CM|PSR_NEM),gr4
+	setlo		%lo(#PSR_EM|PSR_EF|PSR_CM|PSR_NEM),gr4
+	or		gr22,gr4,gr22
+	movgs		gr22,psr
+
+	andi		gr22,#~(PSR_PIL|PSR_PS|PSR_S),gr22
+	ori		gr22,#PSR_ET,gr22
+	sti		gr22,@(gr28,REG_PSR)
+
+
+###############################################################################
+#
+# set up the registers and jump into the kernel
+#
+###############################################################################
+
+	LEDS		0x000c
+
+	# initialise the processor and the peripherals
+	#call		SYMBOL_NAME(processor_init)
+	#call		SYMBOL_NAME(unit_init)
+	#LEDS		0x0aff
+
+	sethi.p		#0xe5e5,gr3
+	setlo		#0xe5e5,gr3
+	or.p		gr3,gr0,gr4
+	or		gr3,gr0,gr5
+	or.p		gr3,gr0,gr6
+	or		gr3,gr0,gr7
+	or.p		gr3,gr0,gr8
+	or		gr3,gr0,gr9
+	or.p		gr3,gr0,gr10
+	or		gr3,gr0,gr11
+	or.p		gr3,gr0,gr12
+	or		gr3,gr0,gr13
+	or.p		gr3,gr0,gr14
+	or		gr3,gr0,gr17
+	or.p		gr3,gr0,gr18
+	or		gr3,gr0,gr19
+	or.p		gr3,gr0,gr20
+	or		gr3,gr0,gr21
+	or.p		gr3,gr0,gr23
+	or		gr3,gr0,gr24
+	or.p		gr3,gr0,gr25
+	or		gr3,gr0,gr26
+	or.p		gr3,gr0,gr27
+#	or		gr3,gr0,gr30
+	or		gr3,gr0,gr31
+	movgs		gr0,lr
+	movgs		gr0,lcr
+	movgs		gr0,ccr
+	movgs		gr0,cccr
+
+#ifdef CONFIG_MMU
+	movgs		gr3,scr2
+	movgs		gr3,scr3
+#endif
+
+	LEDS		0x0fff
+
+	# invoke the debugging stub if present
+	# - arch/frv/kernel/debug-stub.c will shift control directly to init/main.c
+	#   (it will not return here)
+	break
+	.globl		__debug_stub_init_break
+__debug_stub_init_break:
+
+	# however, if you need to use an ICE, and don't care about using any userspace
+	# debugging tools (such as the ptrace syscall), you can just step over the break
+	# above and get to the kernel this way
+	# look at arch/frv/kernel/debug-stub.c: debug_stub_init() to see what you've missed
+	call		start_kernel
+
+	.globl		__head_end
+__head_end:
+	.size		_boot, .-_boot
+
+	# provide a point for GDB to place a break
+	.section	.text.start,"ax"
+	.globl		_start
+	.balign		4
+_start:
+	call		_boot
+
+	.previous
+###############################################################################
+#
+# split a tile off of the region defined by GR8-GR9
+#
+#	ENTRY:			EXIT:
+# GR4	-			IAMPR value representing tile
+# GR5	-			DAMPR value representing tile
+# GR6	-			IAMLR value representing tile
+# GR7	-			DAMLR value representing tile
+# GR8	region base pointer	[saved]
+# GR9	region top pointer	updated to exclude new tile
+# GR11	xAMLR mask		[saved]
+# GR25	SDRAM size		[saved]
+# GR30	LED address		[saved]
+#
+# - GR8 and GR9 should be rounded up/down to the nearest megabyte before calling
+#
+###############################################################################
+	.globl		__head_split_region
+	.type		__head_split_region,@function
+__head_split_region:
+	subcc.p		gr9,gr8,gr4,icc0
+	setlos		#31,gr5
+	scan.p		gr4,gr0,gr6
+	beq		icc0,#0,__head_region_empty
+	sub.p		gr5,gr6,gr6			; bit number of highest set bit (1MB=>20)
+	setlos		#1,gr4
+	sll.p		gr4,gr6,gr4			; size of region (1 << bitno)
+	subi		gr6,#17,gr6			; 1MB => 0x03
+	slli.p		gr6,#4,gr6			; 1MB => 0x30
+	sub		gr9,gr4,gr9			; move uncovered top down
+
+	or		gr9,gr6,gr4
+	ori		gr4,#xAMPRx_S_USER|xAMPRx_C_CACHED|xAMPRx_V,gr4
+	or.p		gr4,gr0,gr5
+
+	and		gr4,gr11,gr6
+	and.p		gr5,gr11,gr7
+	bralr
+
+__head_region_empty:
+	or.p		gr0,gr0,gr4
+	or		gr0,gr0,gr5
+	or.p		gr0,gr0,gr6
+	or		gr0,gr0,gr7
+	bralr
+	.size		__head_split_region, .-__head_split_region
+
+###############################################################################
+#
+# write the 32-bit hex number in GR8 to ttyS0
+#
+###############################################################################
+#if 0
+	.globl		__head_write_to_ttyS0
+	.type		__head_write_to_ttyS0,@function
+__head_write_to_ttyS0:
+	sethi.p		%hi(0xfeff9c00),gr31
+	setlo		%lo(0xfeff9c00),gr31
+	setlos		#8,gr20
+
+0:	ldubi		@(gr31,#5*8),gr21
+	andi		gr21,#0x60,gr21
+	subicc		gr21,#0x60,gr21,icc0
+	bne		icc0,#0,0b
+
+1:	srli		gr8,#28,gr21
+	slli		gr8,#4,gr8
+
+	addi		gr21,#'0',gr21
+	subicc		gr21,#'9',gr0,icc0
+	bls		icc0,#2,2f
+	addi		gr21,#'A'-'0'-10,gr21
+2:
+	stbi		gr21,@(gr31,#0*8)
+	subicc		gr20,#1,gr20,icc0
+	bhi		icc0,#2,1b
+
+	setlos		#'\r',gr21
+	stbi		gr21,@(gr31,#0*8)
+
+	setlos		#'\n',gr21
+	stbi		gr21,@(gr31,#0*8)
+
+3:	ldubi		@(gr31,#5*8),gr21
+	andi		gr21,#0x60,gr21
+	subicc		gr21,#0x60,gr21,icc0
+	bne		icc0,#0,3b
+	bralr
+
+	.size		__head_write_to_ttyS0, .-__head_write_to_ttyS0
+#endif
