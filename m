Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSJQL6S>; Thu, 17 Oct 2002 07:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJQL4o>; Thu, 17 Oct 2002 07:56:44 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:10368 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261401AbSJQLfF>; Thu, 17 Oct 2002 07:35:05 -0400
Date: Thu, 17 Oct 2002 20:40:15 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (21/26) serial #2
Message-ID: <20021017204015.A1271@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 21/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 New serial driver support for PC-9800 legacy serial port.
 This driver emulates 16550A.
 This driver is based on 8250.c but heavily modified.

diffstat:
 drivers/serial/serial98.c | 2896 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 2896 insertions(+)

patch:
diff -urN linux/drivers/serial/serial98.c linux98/drivers/serial/serial98.c
--- linux/drivers/serial/serial98.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/serial/serial98.c	Wed Oct 16 15:37:43 2002
@@ -0,0 +1,2896 @@
+/*
+ *  linux/drivers/serial/serial98.c
+ *
+ *  Driver for NEC PC-9801 serial ports
+ *
+ *  Based on drivers/serial/8250.c, by Russell King.
+ *      $Id: 8250.c,v 1.90 2002/07/28 10:03:27 rmk Exp $
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *
+ *  Copyright (C) 2002 Osamu Tomita <tomita@cinet.co.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ *
+ * A note about mapbase / membase
+ *
+ *  mapbase is the physical address of the IO port.  Currently, we don't
+ *  support this very well, and it may well be dropped from this driver
+ *  in future.  As such, mapbase should be NULL.
+ *
+ *  membase is an 'ioremapped' cookie.  This is compatible with the old
+ *  serial.c driver, and is currently the preferred form.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/serial_reg.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pc9800.h>
+#include <asm/pc9800_sca.h>
+
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#ifdef CONFIG_MC16550II
+#ifndef CONFIG_SERIAL_8250_SHARE_IRQ
+#define CONFIG_SERIAL_8250_SHARE_IRQ
+#endif
+#endif
+#include <linux/serial_core.h>
+#include "8250.h"
+
+/*
+ * Configuration:
+ *   share_irqs - whether we pass SA_SHIRQ to request_irq().  This option
+ *                is unsafe when used on edge-triggered interrupts.
+ */
+unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
+
+/*
+ * Debugging.
+ */
+#if 0
+#define DEBUG_AUTOCONF(fmt...)	printk(fmt)
+#else
+#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
+#endif
+
+#if 0
+#define DEBUG_INTR(fmt...)	printk(fmt)
+#else
+#define DEBUG_INTR(fmt...)	do { } while (0)
+#endif
+
+#define PASS_LIMIT	256
+
+/*
+ * We default to IRQ0 for the "no irq" hack.   Some
+ * machine types want others as well - they're free
+ * to redefine this in their header file.
+ */
+#define is_real_interrupt(irq)	((irq) != 0)
+
+/*
+ * This converts from our new CONFIG_ symbols to the symbols
+ * that asm/serial.h expects.  You _NEED_ to comment out the
+ * linux/config.h include contained inside asm/serial.h for
+ * this to work.
+ */
+#undef CONFIG_SERIAL_MANY_PORTS
+#undef CONFIG_SERIAL_DETECT_IRQ
+#undef CONFIG_SERIAL_MULTIPORT
+#undef CONFIG_HUB6
+
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
+#define CONFIG_SERIAL_DETECT_IRQ 1
+#endif
+#ifdef CONFIG_SERIAL_8250_MULTIPORT
+#define CONFIG_SERIAL_MULTIPORT 1
+#endif
+
+/*
+ * HUB6 is always on.  This will be removed once the header
+ * files have been cleaned.
+ */
+#define CONFIG_HUB6 1
+#define CONFIG_SERIAL_MANY_PORTS 1
+
+#include <asm/serial.h>
+
+static struct old_serial_port old_serial_port[] = {
+	SERIAL_PORT_DFNS /* defined in asm/serial.h */
+};
+
+#define UART_NR	ARRAY_SIZE(old_serial_port)
+
+#if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
+
+#define PORT_RSA_MAX 4
+static int probe_rsa[PORT_RSA_MAX];
+static int force_rsa[PORT_RSA_MAX];
+#endif /* CONFIG_SERIAL_8250_RSA  */
+
+struct uart_8250_port {
+	struct uart_port	port;
+	struct timer_list	timer;		/* "no irq" timer */
+	struct list_head	list;		/* ports on this IRQ */
+	unsigned char		acr;
+	unsigned char		ier;
+	unsigned char		rev;
+	unsigned char		lcr;
+	unsigned int		lsr_break_flag;
+	unsigned char		mcr;
+	unsigned char		cmd8251;
+	unsigned char		msr8251;
+
+	/*
+	 * We provide a per-port pm hook.
+	 */
+	void			(*pm)(struct uart_port *port,
+				      unsigned int state, unsigned int old);
+};
+
+struct irq_info {
+	spinlock_t		lock;
+	struct list_head	*head;
+};
+
+static struct irq_info irq_lists[NR_IRQS];
+
+/*
+ * Here we define the default xmit fifo size used for each type of UART.
+ */
+static const struct serial_uart_config uart_config[PORT_MAX_8250+1] = {
+	{ "unknown",	1,	0 },
+	{ "8250",	1,	0 },
+	{ "16450",	1,	0 },
+	{ "16550",	1,	0 },
+	{ "16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "Cirrus",	1, 	0 },
+	{ "ST16650",	1,	UART_CLEAR_FIFO | UART_STARTECH },
+	{ "ST16650V2",	32,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
+	{ "TI16750",	64,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "Startech",	1,	0 },
+	{ "16C950/954",	128,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "ST16654",	64,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
+	{ "XR16850",	128,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
+	{ "RSA",	2048,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "8251",	1,	0 },
+	{ "MC16550II",	16,	UART_CLEAR_FIFO | UART_USE_FIFO }
+};
+
+#if 0
+/*
+ * This is used to figure out the divisor speeds and the timeouts
+ */
+static int div_table_8251_5[]={
+    0, 3072, 2048, 0, 0, 1024, 768, 512, 256, 128,
+    0, 64, 32, 16, 8, 4, 0, 0, 0, 0,
+    0
+};
+static int div_table_8251_8[]={
+    0, 2496, 1664, 0, 0, 832, 624, 416, 208, 104,
+    0, 52, 26, 13, 6, 3, 0, 0, 0, 0,
+    0
+};
+#endif
+
+#define FIFO_ON_8251F() \
+	outb(inb(FCR_8251F) | UART_FCR_ENABLE_FIFO, FCR_8251F)
+#define FIFO_OFF_8251F() \
+	outb(inb(FCR_8251F) & ~UART_FCR_ENABLE_FIFO, FCR_8251F)
+
+#define MODE_COM1_NORMAL	0
+#define MODE_COM1_VFAST	1
+#define MODE_COM1_FIFO	2
+static int mode_com1 = MODE_COM1_NORMAL;
+static int speed_pc98 = 0;
+static int lcr_pc98 = 0;
+static int mcr_pc98 = 0;
+static int scr_pc98 = 0;
+static int cmd_8251f = 0x15;
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,11)
+#define CONFIG_RESOURCE98
+#endif
+
+#ifdef CONFIG_RESOURCE98
+#define COM1_EXTENT1 -5
+/*#define COM1_EXTENT1 -3
+  #define COM1_EXTENT2 -4*/
+#define COM1_EXTENT3 -11
+#else
+#define COM1_EXTENT1 3
+#define COM1_EXTENT2 4
+#define COM1_EXTENT3 10
+#endif
+
+#define system_clock (*(unsigned char*)(__va(PC9800SCA_BIOS_FLAG)) & 0x80)
+
+static void wait_8251f(void)
+{
+	outb(0, 0x5f);
+	outb(0, 0x5f);
+	outb(0, 0x5f);
+	outb(0, 0x5f);
+}
+
+
+
+static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
+{
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_HUB6:
+		outb(up->port.hub6 - 1 + offset, up->port.iobase);
+		return inb(up->port.iobase + 1);
+
+	case SERIAL_IO_MEM:
+		return readb(up->port.membase + offset);
+
+	case SERIAL_IO_8251:
+		switch (offset) {
+			u8 tmp;
+		case +0:	/* RX/TX/DLL/TRG */
+			if (lcr_pc98 & UART_LCR_DLAB
+			    /* && mode_com1 != MODE_COM1_NORMAL */)
+				return speed_pc98;
+			return inb(RX_8251F);
+		case +1:	/* DLM/IER/FCTR */
+			if (lcr_pc98 & UART_LCR_DLAB)
+				return 0;
+			tmp = inb(IER1_8251F);
+			return (((inb(IER2_8251F) & 0x18) >> 1)
+				| ((tmp & 0x04) >> 1) | (tmp & 0x01));
+		case +2:	/* IIR/FCR/EFR */
+			return (inb(IIR_8251F) & 0x0f) | 0xc0;
+		case +3:	/* LCR */
+			return lcr_pc98;
+		case +4:	/* MCR */
+			return mcr_pc98;
+		case +5:	/* LSR */
+			tmp = inb(LSR_8251F);
+			return (((tmp & 0x64) >> 2) | ((tmp & 0x10) >> 3)
+				| ((tmp & 0x08) >> 1) | ((tmp & 0x02) << 4)
+				| ((tmp & 0x01) << 6));
+		case +6:
+			return inb(MSR_8251F);
+		case +7:
+			return scr_pc98;
+		}
+		printk(KERN_WARNING
+			"16550A emuration: unsupported offset %d\n",
+			offset);
+		return 0;
+#ifdef CONFIG_MC16550II
+	case SERIAL_IO_MC16550II:
+		return inb_p(up->port.iobase + (offset << 8));
+#endif
+	default:
+		return inb(up->port.iobase + offset);
+	}
+}
+
+static _INLINE_ void
+serial_out(struct uart_8250_port *up, int offset, int value)
+{
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_HUB6:
+		outb(up->port.hub6 - 1 + offset, up->port.iobase);
+		outb(value, up->port.iobase + 1);
+		break;
+
+	case SERIAL_IO_MEM:
+		writeb(value, up->port.membase + offset);
+		break;
+
+	case SERIAL_IO_8251:
+		switch (offset) {
+			int tmp;
+			u8 tmp8;
+			unsigned long flags;
+		case +0:
+			if (lcr_pc98 & UART_LCR_DLAB) {
+				speed_pc98 = value;
+				if (mode_com1 == MODE_COM1_VFAST) {
+					if (value <= 0x0c) {
+						outb(value | VFAST_ENABLE,
+						      VFAST_8251F);
+						return;
+					}
+					outb(0, VFAST_8251F);
+				}
+				if (PC9800_8MHz_P())
+					tmp = (value * 13) / 12;
+				else
+					tmp = (value * 4) / 3;
+				//save_flags(flags);
+				//cli();
+				spin_lock_irqsave(&up->port.lock, flags);
+				outb_p(0xb6, 0x77);
+				outb_p(tmp, 0x75);
+				outb_p(tmp >> 8, 0x75);
+				//restore_flags(flags);
+				spin_unlock_irqrestore(&up->port.lock, flags);
+			}
+			else
+				outb(value, TX_8251F);
+			return;
+		case +1:
+			if (!(lcr_pc98 & UART_LCR_DLAB)) {
+				//save_flags(flags);
+				//cli();
+				spin_lock_irqsave(&up->port.lock, flags);
+				tmp8 = inb(IER2_8251F);
+				outb(value & 0x01, IER1_8251F_COUT);
+				outb((tmp8 & 0xe7) | ((value & 0x0c) << 1),
+				      IER2_8251F);
+				outb(((value & 0x02) >> 1) | 0x04,
+				      IER1_8251F_COUT);
+				//restore_flags(flags);
+				spin_unlock_irqrestore(&up->port.lock, flags);
+			}
+			return;
+		case +2:
+			//save_flags(flags);
+			//cli();
+			spin_lock_irqsave(&up->port.lock, flags);
+			outb((inb(FCR_8251F) & 0x18) | (value & 0xe7) | 0x01,
+			      FCR_8251F);
+			//restore_flags(flags);
+			spin_unlock_irqrestore(&up->port.lock, flags);
+			return;
+		case +3:
+			//save_flags(flags);
+			//cli();
+			spin_lock_irqsave(&up->port.lock, flags);
+			if ((lcr_pc98 ^ value) & 0x3f) {
+				FIFO_OFF_8251F ();
+				outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+				FIFO_ON_8251F();
+				wait_8251f();
+				FIFO_OFF_8251F();
+				outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+				FIFO_ON_8251F();
+				wait_8251f();
+				FIFO_OFF_8251F();
+				outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+				FIFO_ON_8251F();
+				wait_8251f();
+				FIFO_OFF_8251F();
+				outb(COMMAND_8251F_RESET, COMMAND_8251F);
+				FIFO_ON_8251F();
+				wait_8251f();
+
+				tmp8 = (((value & 0x03) << 2)
+					| ((value & 0x18) << 1) | 0x02);
+				if (value & 4) {
+					tmp8 |= 0x80;
+					if (value & 3)
+						tmp8 |= 0x40;
+				}
+				else
+					tmp8 |= 0x40;
+
+				FIFO_OFF_8251F();
+				outb(tmp8, COMMAND_8251F); /* mode write */
+				FIFO_ON_8251F();
+				wait_8251f();
+
+				if ((lcr_pc98 ^ value) & 0x40)
+					goto modify_command;
+				goto command_write;
+			}
+			if ((lcr_pc98 ^ value) & 0x40) {
+			modify_command:
+				cmd_8251f = ((cmd_8251f & 0xf7)
+					     | ((value & 0x40) >> 3));
+			command_write:
+				FIFO_OFF_8251F();
+				/* command write */
+				outb(cmd_8251f, COMMAND_8251F);
+				FIFO_ON_8251F();
+			}
+			lcr_pc98 = value;
+			//restore_flags(flags);
+			spin_unlock_irqrestore(&up->port.lock, flags);
+			wait_8251f();
+			return;
+		case +4:
+			//save_flags(flags);
+			//cli();
+			spin_lock_irqsave(&up->port.lock, flags);
+			if ((mcr_pc98 ^ value) & 0x03) {
+				cmd_8251f = ((cmd_8251f & 0xdd)
+					     | (((char []){ 0x00, 0x02,
+							    0x20, 0x22 })
+						[value & 0x03]));
+				FIFO_OFF_8251F();
+				/* command write */
+				outb(cmd_8251f, COMMAND_8251F);
+				FIFO_ON_8251F();
+			}
+			mcr_pc98 = value;
+			//restore_flags(flags);
+			spin_unlock_irqrestore(&up->port.lock, flags);
+			wait_8251f();
+			return;
+		case +7:
+			scr_pc98 = value;
+			return;
+		}
+		printk(KERN_WARNING
+			"16550A emuration: unsupported offset %d\n",
+			offset);
+		return;
+
+	default:
+		outb(value, up->port.iobase + offset);
+	}
+}
+
+/*
+ * We used to support using pause I/O for certain machines.  We
+ * haven't supported this for a while, but just in case it's badly
+ * needed for certain old 386 machines, I've left these #define's
+ * in....
+ */
+#define serial_inp(up, offset)		serial_in(up, offset)
+#define serial_outp(up, offset, value)	serial_out(up, offset, value)
+
+
+/*
+ * 8251 Serial Driver for PC-9800
+ */
+
+static void out_8251_lcr(int mode)
+{
+	udelay(10);
+	outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+	udelay(10);
+	outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+	udelay(10);
+	outb(COMMAND_8251F_DUMMY, COMMAND_8251F);
+	udelay(10);
+	outb(COMMAND_8251F_RESET, COMMAND_8251F);
+	udelay(10);
+	outb(mode, COMMAND_8251F);
+	udelay(100);
+}
+
+static void cmd_out_8251(struct uart_8250_port *up)
+{
+	if (up->mcr & UART_MCR_DTR)
+		up->cmd8251 |= 2;
+	else
+		up->cmd8251 &= 253;
+
+	if (up->mcr & UART_MCR_RTS)
+		up->cmd8251 |= 32;
+	else
+		up->cmd8251 &= 223;
+
+#if 0
+	printk("8251cmd(0x%x) 8255MCR(0x%x)\n", up->cmd8251, up->mcr);
+#endif
+	outb(up->cmd8251, COMMAND_8251F);
+}
+
+static void autoconfig8251(struct uart_8250_port *up, unsigned int probeflags)
+{
+	unsigned char scratch, scratch2;
+	unsigned long flags;
+	int tmp;
+
+	if (!up->port.iobase)
+		return;
+
+	out_8251_lcr(0xf2);
+	outb(0x01, up->port.iobase + PORT_8251_CMD);
+	udelay(1000);
+	if(!(inb_p(up->port.iobase + PORT_8251_STS) & STAT_8251_TXRDY))
+		return;
+	//save_flags(flags); cli();
+	spin_lock_irqsave(&up->port.lock, flags);
+	tmp = (inb(IER1_8251F)
+			& ~(INTR_8251_RXRE | INTR_8251_TXEE | INTR_8251_TXRE));
+	outb((tmp | 0x2), IER1_8251F);   
+	outb(tmp , IER1_8251F);
+
+	/*
+	 * Do a simple existence test first; if we fail this, there's
+	 * no point trying anything else.
+	 *
+	 * 0x80 is used as a nonsense port to prevent against false
+	 * positives due to ISA bus float.  The assumption is that
+	 * 0x80 is a non-existent port; which should be safe since
+	 * include/asm/io.h also makes this assumption.
+	 */
+
+	scratch = inb(IER1_8251F);
+	outb(0, IER1_8251F);
+	scratch2 = inb(IER1_8251F);
+	outb(scratch, IER1_8251F);
+
+	if (scratch2) {
+		//restore_flags(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return;	 /* We failed; there's nothing here */
+	}
+
+	out_8251_lcr(0x6E);
+	up->port.iotype = PORT_8251;
+
+	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+
+	if (up->port.iotype == PORT_UNKNOWN) {
+		//restore_flags(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return;
+	}
+
+	/*
+	 * Reset the UART.
+	 */
+	up->mcr &= ~(UART_MCR_DTR | UART_MCR_RTS);
+	cmd_out_8251(up);
+	outb(0xDD, COMMAND_8251F);    /*  ~00100010b  ~00110010b */
+	inb(up->port.iobase + PORT_8251_DATA);
+	
+	//restore_flags(flags);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void ier_out(struct uart_8250_port *up)
+{
+	if (up->port.line == 0) {
+#if 0
+		printk("IER  changed(0x%x.8255IER)!\n",up->ier);
+#endif
+		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
+			outb_p(INTR_8251_RXRE, IER1_8251F_COUT);
+		} else {
+			outb_p(0, IER1_8251F_COUT);
+		}
+		if (up->ier & UART_IER_THRI) {
+			outb_p(INTR_8251_RXRE | INTR_8251_TXEE, IER1_8251F_COUT);
+			outb_p(INTR_8251_RXRE | INTR_8251_TXRE, IER1_8251F_COUT);
+		} else {
+			outb_p(INTR_8251_TXEE, IER1_8251F_COUT);
+			outb_p(INTR_8251_TXRE, IER1_8251F_COUT);
+		}
+	} else {
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static void change_speed_8251(struct uart_port *port, unsigned int cflag,
+				unsigned int iflag, unsigned int quot)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned int mval = 0;
+	int bits;
+	unsigned long flags;
+	int base_baud8251, quot8251 = 0;
+
+	/* byte size and parity */
+	switch (cflag & CSIZE) {
+	case CS5: mval = 0x00; bits = 7; break;
+	case CS6: mval = 0x04; bits = 8; break;
+	case CS7: mval = 0x08; bits = 9; break;
+	case CS8: mval = 0x0c; bits = 10; break;
+		/* Never happens, but GCC is too dumb to figure it out */
+	default:  mval = 0x00; bits = 7; break;
+	}
+	if (cflag & CSTOPB) {
+		mval |= 0x40;
+		bits++;
+	}
+	if (cflag & PARENB) {
+		mval |= 0x10;	/*parity*/
+		bits++;
+	}
+	if (!(cflag & PARODD))
+		mval |= 0x20;	/* even parity*/
+
+	mval|= 2;
+	/* Determine divisor based on baud rate */
+	base_baud8251 = (system_clock) ? (1996800 / 16) : (2457600 / 16);
+	quot8251 = base_baud8251 * quot / BASE_BAUD;
+#if 0
+	printk("change_speed_8251(): base_baud8251=%d baud=%d quot8251=%d\n",
+		base_baud8251, BASE_BAUD / quot, quot8251);
+#endif
+	/* CTS flow control flag and modem status interrupts */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, cflag))
+		up->ier |= UART_IER_MSI;
+
+	ier_out(up);
+
+	/*
+	 * Set up parity check flag
+	 */
+	up->port.read_status_mask = STAT_8251_OER | STAT_8251_TXEMP | STAT_8251_DSR;
+	if (iflag & INPCK)
+		up->port.read_status_mask |= STAT_8251_FER | STAT_8251_PER;
+	if (iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= STAT_8251_BRK;
+
+	/*
+	 * Characters to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (iflag & IGNPAR)
+		up->port.ignore_status_mask |= STAT_8251_PER | STAT_8251_FER;
+	if (iflag & IGNBRK) {
+		up->port.ignore_status_mask |= STAT_8251_BRK;
+		/*
+		 * If we're ignore parity and break indicators, ignore 
+		 * overruns too.  (For real raw support).
+		 */
+		if (iflag & IGNPAR)
+			up->port.ignore_status_mask |= STAT_8251_OER;
+	}
+	/*
+	 * !!! ignore all characters if CREAD is not set
+	 */
+	if ((cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= STAT_8251_DSR;
+
+	//save_flags(flags);
+	//cli();
+	spin_lock_irqsave(&up->port.lock, flags);
+	out_8251_lcr(mval);
+	up->cmd8251 = 0x37;
+	cmd_out_8251(up);
+
+	outb_p(0xb6, 0x77);
+
+	outb_p(quot8251 & 0xff, 0x75);
+	outb_p(quot8251 >> 8, 0x75);
+
+	//restore_flags(flags);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void receive_chars_8251(struct uart_8250_port *up, int *status,
+				struct pt_regs *regs)
+{
+	struct tty_struct *tty = up->port.info->tty;
+	unsigned char ch;
+	int ignored = 0;
+
+	do {
+		ch = inb(0x30);
+		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+			break;
+		*tty->flip.char_buf_ptr = ch;
+		up->port.icount.rx++;
+		*tty->flip.flag_buf_ptr = 0;
+		if (*status & (STAT_8251_BRK | STAT_8251_PER |
+			       STAT_8251_FER | STAT_8251_OER)) {
+			/*
+			 * For statistics only
+			 */
+			if (*status & STAT_8251_BRK) {
+				*status &= ~(STAT_8251_FER | STAT_8251_PER);
+				up->port.icount.brk++;
+			} else if (*status & STAT_8251_PER)
+				up->port.icount.parity++;
+			else if (*status & STAT_8251_FER)
+				up->port.icount.frame++;
+			if (*status & STAT_8251_OER)
+				up->port.icount.overrun++;
+
+			/*
+			 * Now check to see if character should be
+			 * ignored, and mask off conditions which
+			 * should be ignored.
+			 */
+			if (*status & up->port.ignore_status_mask) {
+				if (++ignored > 100)
+					break;
+				goto ignore_char;
+			}
+			*status &= up->port.read_status_mask;
+
+			if (*status & STAT_8251_BRK)
+				*tty->flip.flag_buf_ptr = TTY_BREAK;
+			else if (*status & STAT_8251_PER)
+				*tty->flip.flag_buf_ptr = TTY_PARITY;
+			else if (*status & STAT_8251_FER)
+				*tty->flip.flag_buf_ptr = TTY_FRAME;
+			if (*status & STAT_8251_OER) {
+				/*
+				 * Overrun is special, since it's
+				 * reported immediately, and doesn't
+				 * affect the current character
+				 */
+				if (tty->flip.count < TTY_FLIPBUF_SIZE) {
+					tty->flip.count++;
+					tty->flip.flag_buf_ptr++;
+					tty->flip.char_buf_ptr++;
+					*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+				}
+			}
+		}
+		tty->flip.flag_buf_ptr++;
+		tty->flip.char_buf_ptr++;
+		tty->flip.count++;
+	ignore_char:
+		*status = inb(0x32);
+	} while (*status & STAT_8251_RXRDY);
+	tty_flip_buffer_push(tty);
+}
+
+static void transmit_chars_8251(struct uart_8250_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	if (up->port.x_char) {
+		outb(up->port.x_char, 0x30);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		up->ier &= ~UART_IER_THRI;
+		ier_out(up);
+		return;
+	}
+
+	count = up->port.fifosize;
+	do {
+		outb(xmit->buf[xmit->tail], 0x30);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_event(&up->port, EVT_WRITE_WAKEUP);
+
+	DEBUG_INTR("THRE...");
+
+	if (uart_circ_empty(xmit)) {
+		up->ier &= ~UART_IER_THRI;
+		ier_out(up);
+	}
+}
+
+static int chk_temt(struct uart_8250_port *up)
+{
+	if (up->port.line != 0)
+		return serial_inp(up, UART_LSR);
+
+	if (inb_p(up->port.iobase + PORT_8251_STS) & STAT_8251_TXEMP)
+		return UART_LSR_TEMT;
+
+	return 0;
+}
+
+static unsigned int msr_in(struct uart_8250_port *up)
+{
+	unsigned int ms, st;
+	unsigned int tmp;
+
+	if (up->port.line != 0)
+		return serial_in(up, UART_MSR);
+
+	ms = inb_p(0x33);
+	st = inb_p(0x32);
+	up->msr8251 = ms;
+
+	tmp = 0;
+	if (!(ms & 32))
+		tmp |= UART_MSR_DCD;
+	if (!(ms & 128))
+		tmp |= UART_MSR_RI;
+	if (!(ms & 64))
+		tmp |= UART_MSR_CTS;
+	if (st & 128)
+		tmp |= UART_MSR_DSR;
+	return tmp;
+}
+
+void mcr_out(struct uart_8250_port *up)
+{
+	if (up->port.line != 0) {
+		serial_out(up, UART_MCR, up->mcr);
+		return ;
+	}
+
+	cmd_out_8251(up);
+}
+
+static void begin_break_8251(struct uart_8250_port *up)
+{
+	if (!up->port.iobase)
+		return;
+
+	//cli();
+	up->cmd8251 |= 8;
+	cmd_out_8251(up);
+	//sti();
+}
+
+static void end_break_8251(struct uart_8250_port *up)
+{
+	if (!up->port.iobase)
+		return;
+
+	//cli();
+	up->cmd8251 &= 247;
+	cmd_out_8251(up);
+	//sti();
+}
+
+/*
+ * For the 16C950
+ */
+static void serial_icr_write(struct uart_8250_port *up, int offset, int value)
+{
+	serial_out(up, UART_SCR, offset);
+	serial_out(up, UART_ICR, value);
+}
+
+static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
+{
+	unsigned int value;
+
+	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
+	serial_out(up, UART_SCR, offset);
+	value = serial_in(up, UART_ICR);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return value;
+}
+
+#ifdef CONFIG_SERIAL_8250_RSA
+/*
+ * Attempts to turn on the RSA FIFO.  Returns zero on failure.
+ * We set the port uart clock rate if we succeed.
+ */
+static int __enable_rsa(struct uart_8250_port *up)
+{
+	unsigned char mode;
+	int result;
+
+	mode = serial_inp(up, UART_RSA_MSR);
+	result = mode & UART_RSA_MSR_FIFO;
+
+	if (!result) {
+		serial_outp(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
+		mode = serial_inp(up, UART_RSA_MSR);
+		result = mode & UART_RSA_MSR_FIFO;
+	}
+
+	if (result)
+		up->port.uartclk = SERIAL_RSA_BAUD_BASE * 16;
+
+	return result;
+}
+
+static void enable_rsa(struct uart_8250_port *up)
+{
+	if (up->port.type == PORT_RSA) {
+		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
+			spin_lock_irq(&up->port.lock);
+			__enable_rsa(up);
+			spin_unlock_irq(&up->port.lock);
+		}
+		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
+			serial_outp(up, UART_RSA_FRR, 0);
+	}
+}
+
+/*
+ * Attempts to turn off the RSA FIFO.  Returns zero on failure.
+ * It is unknown why interrupts were disabled in here.  However,
+ * the caller is expected to preserve this behaviour by grabbing
+ * the spinlock before calling this function.
+ */
+static void disable_rsa(struct uart_8250_port *up)
+{
+	unsigned char mode;
+	int result;
+
+	if (up->port.type == PORT_RSA &&
+	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
+		spin_lock_irq(&up->port.lock);
+
+		mode = serial_inp(up, UART_RSA_MSR);
+		result = !(mode & UART_RSA_MSR_FIFO);
+
+		if (!result) {
+			serial_outp(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
+			mode = serial_inp(up, UART_RSA_MSR);
+			result = !(mode & UART_RSA_MSR_FIFO);
+		}
+
+		if (result)
+			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
+		spin_unlock_irq(&up->port.lock);
+	}
+}
+#endif /* CONFIG_SERIAL_8250_RSA */
+
+/*
+ * This is a quickie test to see how big the FIFO is.
+ * It doesn't work at all the time, more's the pity.
+ */
+static int size_fifo(struct uart_8250_port *up)
+{
+	unsigned char old_fcr, old_mcr, old_dll, old_dlm;
+	int count;
+
+	old_fcr = serial_inp(up, UART_FCR);
+	old_mcr = serial_inp(up, UART_MCR);
+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+	serial_outp(up, UART_MCR, UART_MCR_LOOP);
+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
+	old_dll = serial_inp(up, UART_DLL);
+	old_dlm = serial_inp(up, UART_DLM);
+	serial_outp(up, UART_DLL, 0x01);
+	serial_outp(up, UART_DLM, 0x00);
+	serial_outp(up, UART_LCR, 0x03);
+	for (count = 0; count < 256; count++)
+		serial_outp(up, UART_TX, count);
+	mdelay(20);/* FIXME - schedule_timeout */
+	for (count = 0; (serial_inp(up, UART_LSR) & UART_LSR_DR) &&
+	     (count < 256); count++)
+		serial_inp(up, UART_RX);
+	serial_outp(up, UART_FCR, old_fcr);
+	serial_outp(up, UART_MCR, old_mcr);
+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
+	serial_outp(up, UART_DLL, old_dll);
+	serial_outp(up, UART_DLM, old_dlm);
+
+	return count;
+}
+
+/*
+ * This is a helper routine to autodetect StarTech/Exar/Oxsemi UART's.
+ * When this function is called we know it is at least a StarTech
+ * 16650 V2, but it might be one of several StarTech UARTs, or one of
+ * its clones.  (We treat the broken original StarTech 16650 V1 as a
+ * 16550, and why not?  Startech doesn't seem to even acknowledge its
+ * existence.)
+ * 
+ * What evil have men's minds wrought...
+ */
+static void
+autoconfig_startech_uarts(struct uart_8250_port *up)
+{
+	unsigned char scratch, scratch2, scratch3, scratch4;
+
+	/*
+	 * First we check to see if it's an Oxford Semiconductor UART.
+	 *
+	 * If we have to do this here because some non-National
+	 * Semiconductor clone chips lock up if you try writing to the
+	 * LSR register (which serial_icr_read does)
+	 */
+	if (up->port.type == PORT_16550A) {
+		/*
+		 * EFR [4] must be set else this test fails
+		 *
+		 * This shouldn't be necessary, but Mike Hudson
+		 * (Exoray@isys.ca) claims that it's needed for 952
+		 * dual UART's (which are not recommended for new designs).
+		 */
+		up->acr = 0;
+		serial_out(up, UART_LCR, 0xBF);
+		serial_out(up, UART_EFR, 0x10);
+		serial_out(up, UART_LCR, 0x00);
+		/* Check for Oxford Semiconductor 16C950 */
+		scratch = serial_icr_read(up, UART_ID1);
+		scratch2 = serial_icr_read(up, UART_ID2);
+		scratch3 = serial_icr_read(up, UART_ID3);
+		
+		if (scratch == 0x16 && scratch2 == 0xC9 &&
+		    (scratch3 == 0x50 || scratch3 == 0x52 ||
+		     scratch3 == 0x54)) {
+			up->port.type = PORT_16C950;
+			up->rev = serial_icr_read(up, UART_REV) |
+						  (scratch3 << 8);
+			return;
+		}
+	}
+	
+	/*
+	 * We check for a XR16C850 by setting DLL and DLM to 0, and then
+	 * reading back DLL and DLM.  The chip type depends on the DLM
+	 * value read back:
+	 *  0x10 - XR16C850 and the DLL contains the chip revision.
+	 *  0x12 - XR16C2850.
+	 *  0x14 - XR16C854.
+	 */
+
+	/* Save the DLL and DLM */
+
+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
+	scratch3 = serial_inp(up, UART_DLL);
+	scratch4 = serial_inp(up, UART_DLM);
+
+	serial_outp(up, UART_DLL, 0);
+	serial_outp(up, UART_DLM, 0);
+	scratch2 = serial_inp(up, UART_DLL);
+	scratch = serial_inp(up, UART_DLM);
+	serial_outp(up, UART_LCR, 0);
+
+	if (scratch == 0x10 || scratch == 0x12 || scratch == 0x14) {
+		if (scratch == 0x10)
+			up->rev = scratch2;
+		up->port.type = PORT_16850;
+		return;
+	}
+
+	/* Restore the DLL and DLM */
+
+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
+	serial_outp(up, UART_DLL, scratch3);
+	serial_outp(up, UART_DLM, scratch4);
+	serial_outp(up, UART_LCR, 0);
+
+	/*
+	 * We distinguish between the '654 and the '650 by counting
+	 * how many bytes are in the FIFO.  I'm using this for now,
+	 * since that's the technique that was sent to me in the
+	 * serial driver update, but I'm not convinced this works.
+	 * I've had problems doing this in the past.  -TYT
+	 */
+	if (size_fifo(up) == 64)
+		up->port.type = PORT_16654;
+	else
+		up->port.type = PORT_16650V2;
+}
+
+/*
+ * This routine is called by rs_init() to initialize a specific serial
+ * port.  It determines what type of UART chip this serial port is
+ * using: 8250, 16450, 16550, 16550A.  The important question is
+ * whether or not this UART is a 16550A or not, since this will
+ * determine whether or not we can use its FIFO features or not.
+ */
+static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
+{
+	unsigned char status1, status2, scratch, scratch2, scratch3;
+	unsigned char save_lcr, save_mcr;
+	unsigned long flags;
+
+	DEBUG_AUTOCONF("Testing ttyS%d (0x%04x, 0x%08lx)...\n",
+			up->port.line, up->port.iobase, up->port.membase);
+
+	if (!up->port.iobase && !up->port.membase)
+		return;
+
+	if (up->port.iobase == 0x30) {
+		unsigned char t1 = inb(IIR_8251F);
+		unsigned char t2 = inb(IIR_8251F);
+		unsigned char rsflags =
+			(*(unsigned char*)__va(PC9821SCA_RSFLAGS));
+
+		up->port.type = SERIAL_IO_8251;
+		if (((t1 & 0x40) != (t2 & 0x40)) &&
+		   (!((t1 & 0x20) | (t2 & 0x20)))) {
+			if (rsflags & 0x10) {
+				printk(KERN_INFO "COM1: V.Fast/FIFO Mode (System clock is %dMHz).\n",(system_clock ? 8 : 5));
+				mode_com1 = MODE_COM1_VFAST;
+			} else {
+				printk(KERN_INFO "COM1: FIFO Mode (System clock is %dMHz).\n",(system_clock ? 8 : 5));
+				mode_com1 = MODE_COM1_FIFO;
+				up->port.type = PORT_8251;
+			}
+		} else {
+			printk(KERN_INFO "COM1: Normal Mode (System clock %dMHz)\n",(system_clock ? 8 : 5));
+			/* return;*/
+		}
+	}
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL) {
+		autoconfig8251(up, probeflags);
+		printk("autoconfig8251 finished(type=%d).\n", up->port.type);
+		return ;
+	}
+
+	/*
+	 * We really do need global IRQs disabled here - we're going to
+	 * be frobbing the chips IRQ enable register to see if it exists.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+//	save_flags(flags); cli();
+
+	if (!(up->port.flags & ASYNC_BUGGY_UART)) {
+		/*
+		 * Do a simple existence test first; if we fail this,
+		 * there's no point trying anything else.
+		 * 
+		 * 0x80 is used as a nonsense port to prevent against
+		 * false positives due to ISA bus float.  The
+		 * assumption is that 0x80 is a non-existent port;
+		 * which should be safe since include/asm/io.h also
+		 * makes this assumption.
+		 */
+		scratch = serial_inp(up, UART_IER);
+		serial_outp(up, UART_IER, 0);
+#ifdef CONFIG_MC16550II
+		if ((up->port.iobase & 0xf0) == 0xd0)
+			outb(0xff, 0x080);
+		else
+#endif
+		outb(0xff, 0x05f);
+		scratch2 = serial_inp(up, UART_IER);
+		serial_outp(up, UART_IER, 0x0F);
+		outb(0xff, 0x05f);
+		scratch3 = serial_inp(up, UART_IER);
+		serial_outp(up, UART_IER, scratch);
+		if (scratch2 != 0 || scratch3 != 0x0F) {
+			/*
+			 * We failed; there's nothing here
+			 */
+			DEBUG_AUTOCONF("serial: ttyS%d: simple autoconfig "
+				       "failed (%02x, %02x)\n",
+				       up->port.line, scratch2, scratch3);
+			goto out;
+		}
+	}
+
+	save_mcr = serial_in(up, UART_MCR);
+	save_lcr = serial_in(up, UART_LCR);
+
+	/* 
+	 * Check to see if a UART is really there.  Certain broken
+	 * internal modems based on the Rockwell chipset fail this
+	 * test, because they apparently don't implement the loopback
+	 * test mode.  So this test is skipped on the COM 1 through
+	 * COM 4 ports.  This *should* be safe, since no board
+	 * manufacturer would be stupid enough to design a board
+	 * that conflicts with COM 1-4 --- we hope!
+	 */
+	if (!(up->port.flags & ASYNC_SKIP_TEST)) {
+		serial_outp(up, UART_MCR, UART_MCR_LOOP | 0x0A);
+		status1 = serial_inp(up, UART_MSR) & 0xF0;
+		serial_outp(up, UART_MCR, save_mcr);
+		if (status1 != 0x90) {
+			DEBUG_AUTOCONF("serial: ttyS%d: no UART loopback "
+				       "failed\n", up->port.line);
+			goto out;
+		}
+	}
+	serial_outp(up, UART_LCR, 0xBF); /* set up for StarTech test */
+	serial_outp(up, UART_EFR, 0);	/* EFR is the same as FCR */
+	serial_outp(up, UART_LCR, 0);
+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	scratch = serial_in(up, UART_IIR) >> 6;
+
+	if (!up->port.type)
+	switch (scratch) {
+		case 0:
+			up->port.type = PORT_16450;
+			break;
+		case 1:
+			up->port.type = PORT_UNKNOWN;
+			break;
+		case 2:
+			up->port.type = PORT_16550;
+			break;
+		case 3:
+			up->port.type = PORT_16550A;
+			break;
+	}
+#ifdef CONFIG_MC16550II
+	if ((up->port.iobase & 0xf0) == 0xd0) {
+		up->port.type = PORT_MC16550II;
+		switch (up->port.irq) {
+		case 3:
+			outb(0x4, (info->port.iobase & 0xff) + 0x1000);
+			break;          
+		case 5:
+			outb(0x5, (info->port.iobase & 0xff) + 0x1000);
+			break;          
+		case 6:
+			outb(0x6, (info->port.iobase & 0xff) + 0x1000);
+			break;          
+		case 12:
+			outb(0x7, (info->port.iobase & 0xff) + 0x1000);
+			break;
+		}
+	}
+
+	if (up->port.type == PORT_16550A || up->port.type == PORT_MC16550II)
+#else
+	if (up->port.type == PORT_16550A)
+#endif
+	{
+		/* Check for Startech UART's */
+		serial_outp(up, UART_LCR, UART_LCR_DLAB);
+		if (serial_in(up, UART_EFR) == 0) {
+			up->port.type = PORT_16650;
+		} else {
+			serial_outp(up, UART_LCR, 0xBF);
+			if (serial_in(up, UART_EFR) == 0)
+				autoconfig_startech_uarts(up);
+		}
+	}
+#ifdef CONFIG_MC16550II
+	if (up->port.type == PORT_16550A || up->port.type == PORT_MC16550II)
+#else
+	if (up->port.type == PORT_16550A)
+#endif
+	{
+		/* Check for TI 16750 */
+		serial_outp(up, UART_LCR, save_lcr | UART_LCR_DLAB);
+		serial_outp(up, UART_FCR,
+			    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
+		scratch = serial_in(up, UART_IIR) >> 5;
+		if (scratch == 7) {
+			/*
+			 * If this is a 16750, and not a cheap UART
+			 * clone, then it should only go into 64 byte
+			 * mode if the UART_FCR7_64BYTE bit was set
+			 * while UART_LCR_DLAB was latched.
+			 */
+ 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_outp(up, UART_LCR, 0);
+			serial_outp(up, UART_FCR,
+				    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
+			scratch = serial_in(up, UART_IIR) >> 5;
+			if (scratch == 6)
+				up->port.type = PORT_16750;
+		}
+		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	}
+#if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
+	/*
+	 * Only probe for RSA ports if we got the region.
+	 */
+	if (up->port.type == PORT_16550A && probeflags & PROBE_RSA) {
+		int i;
+
+		for (i = 0 ; i < PORT_RSA_MAX ; ++i) {
+			if (!probe_rsa[i] && !force_rsa[i])
+				break;
+			if (((probe_rsa[i] != up->port.iobase) ||
+			     check_region(up->port.iobase + UART_RSA_BASE, 16)) &&
+			    (force_rsa[i] != up->port.iobase))
+				continue;
+			if (__enable_rsa(up)) {
+				up->port.type = PORT_RSA;
+				break;
+			}
+		}
+	}
+#endif
+	serial_outp(up, UART_LCR, save_lcr);
+	if (up->port.type == PORT_16450) {
+		scratch = serial_in(up, UART_SCR);
+		serial_outp(up, UART_SCR, 0xa5);
+		status1 = serial_in(up, UART_SCR);
+		serial_outp(up, UART_SCR, 0x5a);
+		status2 = serial_in(up, UART_SCR);
+		serial_outp(up, UART_SCR, scratch);
+
+		if ((status1 != 0xa5) || (status2 != 0x5a))
+			up->port.type = PORT_8250;
+	}
+
+	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+
+	if (up->port.type == PORT_UNKNOWN)
+		goto out;
+
+	/*
+	 * Reset the UART.
+	 */
+#ifdef CONFIG_SERIAL_8250_RSA
+	if (up->port.type == PORT_RSA)
+		serial_outp(up, UART_RSA_FRR, 0);
+#endif
+	serial_outp(up, UART_MCR, save_mcr);
+	serial_outp(up, UART_FCR, (UART_FCR_ENABLE_FIFO |
+				     UART_FCR_CLEAR_RCVR |
+				     UART_FCR_CLEAR_XMIT));
+	serial_outp(up, UART_FCR, 0);
+	(void)serial_in(up, UART_RX);
+	serial_outp(up, UART_IER, 0);
+
+ out:	
+	spin_unlock_irqrestore(&up->port.lock, flags);
+//	restore_flags(flags);
+#ifdef CONFIG_SERIAL_8250_RSA
+	if (up->port.iobase && up->port.type == PORT_RSA) {
+		release_region(up->port.iobase, 8);
+		request_region(up->port.iobase + UART_RSA_BASE, 16,
+			       "serial_rsa");
+	}
+#endif
+}
+
+static void autoconfig_irq(struct uart_8250_port *up)
+{
+	unsigned char save_mcr, save_ier;
+	unsigned char save_ICP = 0;
+	unsigned int ICP = 0;
+	unsigned long irqs;
+	int irq;
+
+	if (up->port.flags & ASYNC_FOURPORT) {
+		ICP = (up->port.iobase & 0xfe0) | 0x1f;
+		save_ICP = inb_p(ICP);
+		outb_p(0x80, ICP);
+		(void) inb_p(ICP);
+	}
+
+	/* forget possible initially masked and pending IRQ */
+	probe_irq_off(probe_irq_on());
+	save_mcr = serial_inp(up, UART_MCR);
+	save_ier = serial_inp(up, UART_IER);
+	serial_outp(up, UART_MCR, UART_MCR_OUT1 | UART_MCR_OUT2);
+	
+	irqs = probe_irq_on();
+	serial_outp(up, UART_MCR, 0);
+	udelay (10);
+	if (up->port.flags & ASYNC_FOURPORT)  {
+		serial_outp(up, UART_MCR,
+			    UART_MCR_DTR | UART_MCR_RTS);
+	} else {
+		serial_outp(up, UART_MCR,
+			    UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
+	}
+	serial_outp(up, UART_IER, 0x0f);	/* enable all intrs */
+	(void)serial_inp(up, UART_LSR);
+	(void)serial_inp(up, UART_RX);
+	(void)serial_inp(up, UART_IIR);
+	(void)serial_inp(up, UART_MSR);
+	serial_outp(up, UART_TX, 0xFF);
+	udelay (20);
+	irq = probe_irq_off(irqs);
+
+	serial_outp(up, UART_MCR, save_mcr);
+	serial_outp(up, UART_IER, save_ier);
+
+	if (up->port.flags & ASYNC_FOURPORT)
+		outb_p(save_ICP, ICP);
+
+	up->port.irq = (irq > 0) ? irq : 0;
+}
+
+static void serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+			ier_out(up);
+		else
+			serial_out(up, UART_IER, up->ier);
+	}
+	if (up->port.type == PORT_16C950 && tty_stop) {
+		up->acr |= UART_ACR_TXDIS;
+		serial_icr_write(up, UART_ACR, up->acr);
+	}
+}
+
+static void serial8250_start_tx(struct uart_port *port, unsigned int tty_start)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	if (!(up->ier & UART_IER_THRI)) {
+		up->ier |= UART_IER_THRI;
+		if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+			ier_out(up);
+		else
+			serial_out(up, UART_IER, up->ier);
+	}
+	/*
+	 * We only do this from uart_start
+	 */
+	if (tty_start && up->port.type == PORT_16C950) {
+		up->acr &= ~UART_ACR_TXDIS;
+		serial_icr_write(up, UART_ACR, up->acr);
+	}
+}
+
+static void serial8250_stop_rx(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	up->ier &= ~UART_IER_RLSI;
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		ier_out(up);
+	else
+		serial_out(up, UART_IER, up->ier);
+}
+
+static void serial8250_enable_ms(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	up->ier |= UART_IER_MSI;
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		ier_out(up);
+	else
+		serial_out(up, UART_IER, up->ier);
+}
+
+static _INLINE_ void
+receive_chars(struct uart_8250_port *up, int *status, struct pt_regs *regs)
+{
+	struct tty_struct *tty = up->port.info->tty;
+	unsigned char ch;
+	int max_count = 256;
+
+	do {
+		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
+			tty->flip.work.func((void *)tty);
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+				return; // if TTY_DONT_FLIP is set
+		}
+		ch = serial_inp(up, UART_RX);
+		*tty->flip.char_buf_ptr = ch;
+		*tty->flip.flag_buf_ptr = TTY_NORMAL;
+		up->port.icount.rx++;
+
+		if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
+				       UART_LSR_FE | UART_LSR_OE))) {
+			/*
+			 * For statistics only
+			 */
+			if (*status & UART_LSR_BI) {
+				*status &= ~(UART_LSR_FE | UART_LSR_PE);
+				up->port.icount.brk++;
+				/*
+				 * We do the SysRQ and SAK checking
+				 * here because otherwise the break
+				 * may get masked by ignore_status_mask
+				 * or read_status_mask.
+				 */
+				if (uart_handle_break(&up->port))
+					goto ignore_char;
+			} else if (*status & UART_LSR_PE)
+				up->port.icount.parity++;
+			else if (*status & UART_LSR_FE)
+				up->port.icount.frame++;
+			if (*status & UART_LSR_OE)
+				up->port.icount.overrun++;
+
+			/*
+			 * Mask off conditions which should be ingored.
+			 */
+			*status &= up->port.read_status_mask;
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+			if (up->port.line == up->port.cons->index) {
+				/* Recover the break flag from console xmit */
+				*status |= up->lsr_break_flag;
+				up->lsr_break_flag = 0;
+			}
+#endif
+			if (*status & UART_LSR_BI) {
+				DEBUG_INTR("handling break....");
+				*tty->flip.flag_buf_ptr = TTY_BREAK;
+			} else if (*status & UART_LSR_PE)
+				*tty->flip.flag_buf_ptr = TTY_PARITY;
+			else if (*status & UART_LSR_FE)
+				*tty->flip.flag_buf_ptr = TTY_FRAME;
+		}
+		if (uart_handle_sysrq_char(&up->port, ch, regs))
+			goto ignore_char;
+		if ((*status & up->port.ignore_status_mask) == 0) {
+			tty->flip.flag_buf_ptr++;
+			tty->flip.char_buf_ptr++;
+			tty->flip.count++;
+		}
+		if ((*status & UART_LSR_OE) &&
+		    tty->flip.count < TTY_FLIPBUF_SIZE) {
+			/*
+			 * Overrun is special, since it's reported
+			 * immediately, and doesn't affect the current
+			 * character.
+			 */
+			*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+			tty->flip.flag_buf_ptr++;
+			tty->flip.char_buf_ptr++;
+			tty->flip.count++;
+		}
+	ignore_char:
+		*status = serial_inp(up, UART_LSR);
+	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+	tty_flip_buffer_push(tty);
+}
+
+static _INLINE_ void transmit_chars(struct uart_8250_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	if (up->port.x_char) {
+		serial_outp(up, UART_TX, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		serial8250_stop_tx(&up->port, 0);
+		return;
+	}
+
+	count = up->port.fifosize;
+	do {
+		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_event(&up->port, EVT_WRITE_WAKEUP);
+
+	DEBUG_INTR("THRE...");
+
+	if (uart_circ_empty(xmit))
+		serial8250_stop_tx(&up->port, 0);
+}
+
+static _INLINE_ void check_modem_status(struct uart_8250_port *up)
+{
+	int status;
+
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		status = msr_in(up);
+	else
+		status = serial_in(up, UART_MSR);
+
+	if ((status & UART_MSR_ANY_DELTA) == 0)
+		return;
+
+	if (status & UART_MSR_TERI)
+		up->port.icount.rng++;
+	if (status & UART_MSR_DDSR)
+		up->port.icount.dsr++;
+	if (status & UART_MSR_DDCD)
+		uart_handle_dcd_change(&up->port, status & UART_MSR_DCD);
+	if (status & UART_MSR_DCTS)
+		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
+
+	wake_up_interruptible(&up->port.info->delta_msr_wait);
+}
+
+static void rs_interrupt_8251(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l, *end = NULL;
+	int pass_counter = 0;
+
+	DEBUG_INTR("rs_interrupt_8251(%d)...", irq);
+
+	spin_lock(&i->lock);
+
+	l = i->head;
+	do {
+		struct uart_8250_port *up;
+		int status;
+
+		up = list_entry(l, struct uart_8250_port, list);
+
+		status = inb(0x32);
+		spin_lock(&up->port.lock);
+		if (status & STAT_8251_RXRDY)
+			receive_chars_8251(up, &status, regs);
+
+		check_modem_status(up);
+		if (status & STAT_8251_TXRDY)
+			transmit_chars_8251(up);
+
+		spin_unlock(&up->port.lock);
+
+		end = NULL;
+		l = l->next;
+
+		if (l == i->head && pass_counter++ > PASS_LIMIT) {
+			/* If we hit this, we're dead. */
+			printk(KERN_ERR "serial8251: too much work for "
+				"irq%d\n", irq);
+			break;
+		}
+	} while (l != end && (inb(0x32) & (STAT_8251_TXRDY | STAT_8251_RXRDY)));
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline void
+serial8250_handle_port(struct uart_8250_port *up, struct pt_regs *regs)
+{
+	unsigned int status = serial_inp(up, UART_LSR);
+
+	DEBUG_INTR("status = %x...", status);
+
+	if (status & UART_LSR_DR)
+		receive_chars(up, &status, regs);
+	check_modem_status(up);
+	if (status & UART_LSR_THRE)
+		transmit_chars(up);
+}
+
+/*
+ * This is the serial driver's interrupt routine.
+ *
+ * Arjan thinks the old way was overly complex, so it got simplified.
+ * Alan disagrees, saying that need the complexity to handle the weird
+ * nature of ISA shared interrupts.  (This is a special exception.)
+ *
+ * In order to handle ISA shared interrupts properly, we need to check
+ * that all ports have been serviced, and therefore the ISA interrupt
+ * line has been de-asserted.
+ *
+ * This means we need to loop through all ports. checking that they
+ * don't have an interrupt pending.
+ */
+static void serial8250_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l, *end = NULL;
+	int pass_counter = 0;
+
+	DEBUG_INTR("serial8250_interrupt(%d)...", irq);
+
+	spin_lock(&i->lock);
+
+	l = i->head;
+	do {
+		struct uart_8250_port *up;
+		unsigned int iir;
+
+		up = list_entry(l, struct uart_8250_port, list);
+
+		iir = serial_in(up, UART_IIR);
+		if (!(iir & UART_IIR_NO_INT)) {
+			spin_lock(&up->port.lock);
+			serial8250_handle_port(up, regs);
+			spin_unlock(&up->port.lock);
+
+			end = NULL;
+		} else if (end == NULL)
+			end = l;
+
+		l = l->next;
+
+		if (l == i->head && pass_counter++ > PASS_LIMIT) {
+			/* If we hit this, we're dead. */
+			printk(KERN_ERR "serial8250: too much work for "
+				"irq%d\n", irq);
+			break;
+		}
+	} while (l != end);
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+}
+
+/*
+ * To support ISA shared interrupts, we need to have one interrupt
+ * handler that ensures that the IRQ line has been deasserted
+ * before returning.  Failing to do this will result in the IRQ
+ * line being stuck active, and, since ISA irqs are edge triggered,
+ * no more IRQs will be seen.
+ */
+static int serial_link_irq_chain(struct uart_8250_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+	int ret, irq_flags = share_irqs ? SA_SHIRQ : 0;
+
+	spin_lock_irq(&i->lock);
+
+	if (i->head) {
+		list_add(&up->list, i->head);
+		spin_unlock_irq(&i->lock);
+
+		ret = 0;
+	} else {
+		INIT_LIST_HEAD(&up->list);
+		i->head = &up->list;
+		spin_unlock_irq(&i->lock);
+
+		if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+			ret = request_irq(up->port.irq, rs_interrupt_8251,
+				  		irq_flags, "serial", i);
+		else
+			ret = request_irq(up->port.irq, serial8250_interrupt,
+					  irq_flags, "serial", i);
+	}
+
+	return ret;
+}
+
+static void serial_unlink_irq_chain(struct uart_8250_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+
+	BUG_ON(i->head == NULL);
+
+	if (list_empty(i->head))
+		free_irq(up->port.irq, i);
+
+	spin_lock_irq(&i->lock);
+
+	if (!list_empty(i->head)) {
+		if (i->head == &up->list)
+			i->head = i->head->next;
+		list_del(&up->list);
+	} else {
+		BUG_ON(i->head != &up->list);
+		i->head = NULL;
+	}
+
+	spin_unlock_irq(&i->lock);
+}
+
+static int startup8251(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+	int retval = 0;
+
+#ifdef SERIAL_DEBUG_OPEN
+	printk("starting up ttys%d (irq %d)...", up->port.line, up->port.irq);
+#endif
+
+	//save_flags(flags); cli();
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/* Wake up UART */
+	out_8251_lcr(0xFC);       /* 0x6E */
+	outb(0, IER1_8251F);
+	out_8251_lcr(0);
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) inb(0x30);
+	(void) inb(0x32);  /* 0x32 */
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	retval = serial_link_irq_chain(up);
+	if (retval)
+		return retval;
+
+	/*
+	 * Now, initialize the UART 
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->cmd8251 = 0;
+	out_8251_lcr(0x6E);
+
+	up->mcr = UART_MCR_DTR | UART_MCR_RTS;
+	cmd_out_8251(up);
+
+	/*
+	 * Finally, enable interrupts
+	 */
+	up->ier = UART_IER_THRI | UART_IER_RLSI | UART_IER_RDI;
+	ier_out(up);  /* enable interrupts */
+	
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	(void)inb(0x32);
+	(void)inb(0x30);
+
+	//restore_flags(flags);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	return retval;
+}
+
+/*
+ * This function is used to handle ports that do not have an
+ * interrupt.  This doesn't work very well for 16450's, but gives
+ * barely passable results for a 16550A.  (Although at the expense
+ * of much CPU overhead).
+ */
+static void serial8250_timeout(unsigned long data)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)data;
+	unsigned int timeout;
+	unsigned int iir;
+
+	iir = serial_in(up, UART_IIR);
+	if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&up->port.lock);
+		serial8250_handle_port(up, NULL);
+		spin_unlock(&up->port.lock);
+	}
+
+	timeout = up->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+	mod_timer(&up->timer, jiffies + timeout);
+}
+
+static unsigned int serial8250_tx_empty(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		ret = chk_temt(up) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	else
+		ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	return ret;
+}
+
+static unsigned int serial8250_get_mctrl(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+	unsigned char status;
+	unsigned int ret;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		status = msr_in(up);
+	else
+		status = serial_in(up, UART_MSR);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	ret = 0;
+	if (status & UART_MSR_DCD)
+		ret |= TIOCM_CAR;
+	if (status & UART_MSR_RI)
+		ret |= TIOCM_RNG;
+	if (status & UART_MSR_DSR)
+		ret |= TIOCM_DSR;
+	if (status & UART_MSR_CTS)
+		ret |= TIOCM_CTS;
+	return ret;
+}
+
+static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned char mcr = ALPHA_KLUDGE_MCR;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= UART_MCR_RTS;
+	if (mctrl & TIOCM_DTR)
+		mcr |= UART_MCR_DTR;
+	if (mctrl & TIOCM_OUT1)
+		mcr |= UART_MCR_OUT1;
+	if (mctrl & TIOCM_OUT2)
+		mcr |= UART_MCR_OUT2;
+	if (mctrl & TIOCM_LOOP)
+		mcr |= UART_MCR_LOOP;
+
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL) {
+		up->mcr = mcr;
+		mcr_out(up);
+	} else
+		serial_out(up, UART_MCR, mcr);
+}
+
+static void serial8250_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL) {
+		if (break_state == -1)
+			begin_break_8251(up);
+		else
+			end_break_8251(up);
+	} else {
+		if (break_state == -1)
+			up->lcr |= UART_LCR_SBC;
+		else
+			up->lcr &= ~UART_LCR_SBC;
+		serial_out(up, UART_LCR, up->lcr);
+	}
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int serial8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+	int retval;
+
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL) {
+		/* do almost same thing */
+		return startup8251(port);
+	}
+
+	if (up->port.type == PORT_16C950) {
+		/* Wake up and initialize UART */
+		up->acr = 0;
+		serial_outp(up, UART_LCR, 0xBF);
+		serial_outp(up, UART_EFR, UART_EFR_ECB);
+		serial_outp(up, UART_IER, 0);
+		serial_outp(up, UART_LCR, 0);
+		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
+		serial_outp(up, UART_LCR, 0xBF);
+		serial_outp(up, UART_EFR, UART_EFR_ECB);
+		serial_outp(up, UART_LCR, 0);
+	}
+
+#ifdef CONFIG_SERIAL_8250_RSA
+	/*
+	 * If this is an RSA port, see if we can kick it up to the
+	 * higher speed clock.
+	 */
+	enable_rsa(up);
+#endif
+
+	/*
+	 * Clear the FIFO buffers and disable them.
+	 * (they will be reeanbled in change_speed())
+	 */
+	if (uart_config[up->port.type].flags & UART_CLEAR_FIFO) {
+		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+				UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		serial_outp(up, UART_FCR, 0);
+	}
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) serial_inp(up, UART_LSR);
+	(void) serial_inp(up, UART_RX);
+	(void) serial_inp(up, UART_IIR);
+	(void) serial_inp(up, UART_MSR);
+
+	/*
+	 * At this point, there's no way the LSR could still be 0xff;
+	 * if it is, then bail out, because there's likely no UART
+	 * here.
+	 */
+	if (!(up->port.flags & ASYNC_BUGGY_UART) &&
+	    (serial_inp(up, UART_LSR) == 0xff)) {
+		printk("ttyS%d: LSR safety check engaged!\n", up->port.line);
+		return -ENODEV;
+	}
+
+	/*
+	 * If the "interrupt" for this port doesn't correspond with any
+	 * hardware interrupt, we use a timer-based system.  The original
+	 * driver used to do this with IRQ0.
+	 */
+	if (!is_real_interrupt(up->port.irq)) {
+		unsigned int timeout = up->port.timeout;
+
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + timeout);
+	} else {
+		retval = serial_link_irq_chain(up);
+		if (retval)
+			return retval;
+	}
+
+	/*
+	 * Now, initialize the UART
+	 */
+	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->port.flags & ASYNC_FOURPORT) {
+		if (!is_real_interrupt(up->port.irq))
+			up->port.mctrl |= TIOCM_OUT1;
+	} else
+		/*
+		 * Most PC uarts need OUT2 raised to enable interrupts.
+		 */
+		if (is_real_interrupt(up->port.irq))
+			up->port.mctrl |= TIOCM_OUT2;
+
+	serial8250_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Finally, enable interrupts.  Note: Modem status interrupts
+	 * are set via change_speed(), which will be occuring imminently
+	 * anyway, so we don't enable them here.
+	 */
+	up->ier = UART_IER_RLSI | UART_IER_RDI;
+	serial_outp(up, UART_IER, up->ier);
+
+	if (up->port.flags & ASYNC_FOURPORT) {
+		unsigned int icp;
+		/*
+		 * Enable interrupts on the AST Fourport board
+		 */
+		icp = (up->port.iobase & 0xfe0) | 0x01f;
+		outb_p(0x80, icp);
+		(void) inb_p(icp);
+	}
+
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	(void) serial_inp(up, UART_LSR);
+	(void) serial_inp(up, UART_RX);
+	(void) serial_inp(up, UART_IIR);
+	(void) serial_inp(up, UART_MSR);
+
+	return 0;
+}
+
+static void serial8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	/*
+	 * Disable interrupts from this port
+	 */
+	up->ier = 0;
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		ier_out(up);
+	else
+		serial_outp(up, UART_IER, 0);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->port.flags & ASYNC_FOURPORT) {
+		/* reset interrupts on the AST Fourport board */
+		inb((up->port.iobase & 0xfe0) | 0x1f);
+		up->port.mctrl |= TIOCM_OUT1;
+	} else
+		up->port.mctrl &= ~TIOCM_OUT2;
+
+	serial8250_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL)
+		(void)inb(up->port.iobase + PORT_8251_DATA);
+	else {
+		serial_out(up, UART_LCR,
+				serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
+		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+				  UART_FCR_CLEAR_RCVR |
+				  UART_FCR_CLEAR_XMIT);
+		serial_outp(up, UART_FCR, 0);
+
+#ifdef CONFIG_SERIAL_8250_RSA
+		/*
+		 * Reset the RSA board back to 115kbps compat mode.
+		 */
+		disable_rsa(up);
+#endif
+
+		/*
+		 * Read data port to reset things, and then unlink from
+		 * the IRQ chain.
+		 */
+		(void) serial_in(up, UART_RX);
+	}
+
+	if (!is_real_interrupt(up->port.irq))
+		del_timer_sync(&up->timer);
+	else
+		serial_unlink_irq_chain(up);
+}
+
+static void
+serial8250_change_speed(struct uart_port *port, unsigned int cflag,
+			unsigned int iflag, unsigned int quot)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned char cval, fcr = 0;
+	unsigned long flags;
+
+	if (up->port.line == 0 && mode_com1 == MODE_COM1_NORMAL) {
+		change_speed_8251(port, cflag, iflag, quot);
+		return;
+	}
+	switch (cflag & CSIZE) {
+	case CS5:
+		cval = 0x00;
+		break;
+	case CS6:
+		cval = 0x01;
+		break;
+	case CS7:
+		cval = 0x02;
+		break;
+	default:
+	case CS8:
+		cval = 0x03;
+		break;
+	}
+
+	if (cflag & CSTOPB)
+		cval |= 0x04;
+	if (cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+	if (cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+#endif
+
+	/*
+	 * Work around a bug in the Oxford Semiconductor 952 rev B
+	 * chip which causes it to seriously miscalculate baud rates
+	 * when DLL is 0.
+	 */
+	if ((quot & 0xff) == 0 && up->port.type == PORT_16C950 &&
+	    up->rev == 0x5201)
+		quot ++;
+
+	if (uart_config[up->port.type].flags & UART_USE_FIFO) {
+		if ((up->port.uartclk / quot) < (2400 * 16))
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+#ifdef CONFIG_SERIAL_8250_RSA
+		else if (up->port.type == PORT_RSA)
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;
+#endif
+		else if (up->port.line == 0 && mode_com1 == MODE_COM1_FIFO)
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+		else
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
+	}
+	if (up->port.type == PORT_16750)
+		fcr |= UART_FCR7_64BYTE;
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, cflag))
+		up->ier |= UART_IER_MSI;
+
+	serial_out(up, UART_IER, up->ier);
+
+	if (uart_config[up->port.type].flags & UART_STARTECH) {
+		serial_outp(up, UART_LCR, 0xBF);
+		serial_outp(up, UART_EFR, cflag & CRTSCTS ? UART_EFR_CTS :0);
+	}
+	serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
+	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	if (up->port.type == PORT_16750)
+		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;					/* Save LCR */
+	if (up->port.type != PORT_16750) {
+		if (fcr & UART_FCR_ENABLE_FIFO) {
+			/* emulated UARTs (Lucent Venus 167x) need two steps */
+			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+		}
+		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+	}
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void
+serial8250_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	if (state) {
+		/* sleep */
+		if (uart_config[up->port.type].flags & UART_STARTECH) {
+			/* Arrange to enter sleep mode */
+			serial_outp(up, UART_LCR, 0xBF);
+			serial_outp(up, UART_EFR, UART_EFR_ECB);
+			serial_outp(up, UART_LCR, 0);
+			serial_outp(up, UART_IER, UART_IERX_SLEEP);
+			serial_outp(up, UART_LCR, 0xBF);
+			serial_outp(up, UART_EFR, 0);
+			serial_outp(up, UART_LCR, 0);
+		}
+		if (up->port.type == PORT_16750) {
+			/* Arrange to enter sleep mode */
+			serial_outp(up, UART_IER, UART_IERX_SLEEP);
+		}
+
+		if (up->pm)
+			up->pm(port, state, oldstate);
+	} else {
+		/* wake */
+		if (uart_config[up->port.type].flags & UART_STARTECH) {
+			/* Wake up UART */
+			serial_outp(up, UART_LCR, 0xBF);
+			serial_outp(up, UART_EFR, UART_EFR_ECB);
+			/*
+			 * Turn off LCR == 0xBF so we actually set the IER
+			 * register on the XR16C850
+			 */
+			serial_outp(up, UART_LCR, 0);
+			serial_outp(up, UART_IER, 0);
+			/*
+			 * Now reset LCR so we can turn off the ECB bit
+			 */
+			serial_outp(up, UART_LCR, 0xBF);
+			serial_outp(up, UART_EFR, 0);
+			/*
+			 * For a XR16C850, we need to set the trigger levels
+			 */
+			if (up->port.type == PORT_16850) {
+				unsigned char fctr;
+
+				fctr = serial_inp(up, UART_FCTR) &
+					 ~(UART_FCTR_RX | UART_FCTR_TX);
+				serial_outp(up, UART_FCTR, fctr |
+						UART_FCTR_TRGD |
+						UART_FCTR_RX);
+				serial_outp(up, UART_TRG, UART_TRG_96);
+				serial_outp(up, UART_FCTR, fctr |
+						UART_FCTR_TRGD |
+						UART_FCTR_TX);
+				serial_outp(up, UART_TRG, UART_TRG_96);
+			}
+			serial_outp(up, UART_LCR, 0);
+		}
+
+		if (up->port.type == PORT_16750) {
+			/* Wake up UART */
+			serial_outp(up, UART_IER, 0);
+		}
+
+		if (up->pm)
+			up->pm(port, state, oldstate);
+	}
+}
+
+/*
+ * Resource handling.  This is complicated by the fact that resources
+ * depend on the port type.  Maybe we should be claiming the standard
+ * 8250 ports, and then trying to get other resources as necessary?
+ */
+static int
+serial8250_request_std_resource(struct uart_8250_port *up, struct resource **res)
+{
+	unsigned int size = 8 << up->port.regshift;
+	int ret = 0;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_MEM:
+		if (up->port.mapbase) {
+			*res = request_mem_region(up->port.mapbase, size, "serial");
+			if (!*res)
+				ret = -EBUSY;
+		}
+		break;
+
+	case SERIAL_IO_HUB6:
+	case SERIAL_IO_PORT:
+		*res = 0;
+		if (up->port.iobase == 0x30) {
+#ifdef CONFIG_RESOURCE98
+			if (!(*res = request_region(up->port.iobase,
+						COM1_EXTENT1,
+						"serial(pc98-1)")))
+				return -EBUSY;
+/*			*res = request_region(up->port.iobase + 4,
+ *						COM1_EXTENT2,
+ *						"serial(pc98-2)");
+ */
+#endif
+			if (!(*res = request_region(up->port.iobase + 0x100,
+							COM1_EXTENT3,
+							"serial(pc98-3)"))) {
+				release_region(up->port.iobase, COM1_EXTENT1);
+				return -EBUSY;
+			}
+		} else
+#ifdef CONFIG_MC16550II
+		if ((up->port.iobase & 0xf0) == 0xd0) {
+			for (i = 0; i < 7; i++) {
+				if (!(*res = request_region(up->port.iobase + i * 0x100, 1, "serial(MC16550)"))) {
+					while (i--)
+						release_region(up->port.iobase + i, 1);
+					return -EBUSY;
+				}
+			}
+		} else
+#endif
+		*res = request_region(up->port.iobase, size, "serial");
+		if (!*res)
+			ret = -EBUSY;
+		break;
+	}
+	return ret;
+}
+
+static int
+serial8250_request_rsa_resource(struct uart_8250_port *up, struct resource **res)
+{
+	unsigned int size = 8 << up->port.regshift;
+	unsigned long start;
+	int ret = 0;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_MEM:
+		if (up->port.mapbase) {
+			start = up->port.mapbase;
+			start += UART_RSA_BASE << up->port.regshift;
+			*res = request_mem_region(start, size, "serial-rsa");
+			if (!*res)
+				ret = -EBUSY;
+		}
+		break;
+
+	case SERIAL_IO_HUB6:
+	case SERIAL_IO_PORT:
+		start = up->port.iobase;
+		start += UART_RSA_BASE << up->port.regshift;
+		*res = request_region(start, size, "serial-rsa");
+		if (!*res)
+			ret = -EBUSY;
+		break;
+	}
+
+	return ret;
+}
+
+static void serial8250_release_port(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long start, offset = 0, size = 0;
+
+	if (up->port.type == PORT_RSA) {
+		offset = UART_RSA_BASE << up->port.regshift;
+		size = 8;
+	}
+
+	size <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_MEM:
+		if (up->port.mapbase) {
+			/*
+			 * Unmap the area.
+			 */
+			iounmap(up->port.membase);
+			up->port.membase = NULL;
+
+			start = up->port.mapbase;
+
+			if (size)
+				release_mem_region(start + offset, size);
+			release_mem_region(start, 8 << up->port.regshift);
+		}
+		break;
+
+	case SERIAL_IO_HUB6:
+	case SERIAL_IO_PORT:
+		start = up->port.iobase;
+
+		if (start == 0x30) {
+#ifdef CONFIG_RESOURCE98
+			release_region(start, COM1_EXTENT1);
+/*			release_region(start + 4, COM1_EXTENT2);
+ */
+#endif
+			release_region(start + 0x100, COM1_EXTENT3);
+			break;
+		}
+#ifdef CONFIG_MC16550II
+		if ((start & 0xf0) == 0xd0) {
+			for (i = 0; i < 7; i++)
+				release_region(start + i * 0x100, 1);
+			break;
+		}
+#endif
+		if (size)
+			release_region(start + offset, size);
+		release_region(start + offset, 8 << up->port.regshift);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int serial8250_request_port(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct resource *res = NULL, *res_rsa = NULL;
+	int ret = 0;
+
+	if (up->port.flags & UPF_RESOURCES) {
+		if (up->port.type == PORT_RSA) {
+			ret = serial8250_request_rsa_resource(up, &res_rsa);
+			if (ret)
+				return ret;
+		}
+
+		ret = serial8250_request_std_resource(up, &res);
+	}
+
+	/*
+	 * If we have a mapbase, then request that as well.
+	 */
+	if (ret == 0 && up->port.flags & UPF_IOREMAP) {
+		int size = res->end - res->start + 1;
+
+		up->port.membase = ioremap(up->port.mapbase, size);
+		if (!up->port.membase)
+			ret = -ENOMEM;
+	}
+
+	if (ret) {
+		if (res_rsa)
+			release_resource(res_rsa);
+		if (res)
+			release_resource(res);
+	}
+	return ret;
+}
+
+static void serial8250_config_port(struct uart_port *port, int flags)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct resource *res_std = NULL, *res_rsa = NULL;
+	int probeflags = PROBE_ANY;
+	int ret;
+
+#ifdef CONFIG_MCA
+	/*
+	 * Don't probe for MCA ports on non-MCA machines.
+	 */
+	if (up->port.flags & ASYNC_BOOT_ONLYMCA && !MCA_bus)
+		return;
+#endif
+
+	/*
+	 * Find the region that we can probe for.  This in turn
+	 * tells us whether we can probe for the type of port.
+	 */
+	if (up->port.flags & UPF_RESOURCES) {
+		ret = serial8250_request_std_resource(up, &res_std);
+		if (ret)
+			return;
+
+		ret = serial8250_request_rsa_resource(up, &res_rsa);
+		if (ret)
+			probeflags &= ~PROBE_RSA;
+	} else {
+		probeflags &= ~PROBE_RSA;
+	}
+
+	if (flags & UART_CONFIG_TYPE)
+		autoconfig(up, probeflags);
+	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
+		autoconfig_irq(up);
+
+	/*
+	 * If the port wasn't an RSA port, release the resource.
+	 */
+	if (up->port.type != PORT_RSA && res_rsa)
+		release_resource(res_rsa);
+
+	if (up->port.type == PORT_UNKNOWN && res_std)
+		release_resource(res_std);
+}
+
+static int
+serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if (ser->irq >= NR_IRQS || ser->irq < 0 ||
+	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
+	    ser->type > PORT_MAX_8250 || ser->type == PORT_CIRRUS ||
+	    ser->type == PORT_STARTECH)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *
+serial8250_type(struct uart_port *port)
+{
+	int type = port->type;
+
+	if (type >= ARRAY_SIZE(uart_config))
+		type = 0;
+	return uart_config[type].name;
+}
+
+static struct uart_ops serial8250_pops = {
+	.tx_empty	= serial8250_tx_empty,
+	.set_mctrl	= serial8250_set_mctrl,
+	.get_mctrl	= serial8250_get_mctrl,
+	.stop_tx	= serial8250_stop_tx,
+	.start_tx	= serial8250_start_tx,
+	.stop_rx	= serial8250_stop_rx,
+	.enable_ms	= serial8250_enable_ms,
+	.break_ctl	= serial8250_break_ctl,
+	.startup	= serial8250_startup,
+	.shutdown	= serial8250_shutdown,
+	.change_speed	= serial8250_change_speed,
+	.pm		= serial8250_pm,
+	.type		= serial8250_type,
+	.release_port	= serial8250_release_port,
+	.request_port	= serial8250_request_port,
+	.config_port	= serial8250_config_port,
+	.verify_port	= serial8250_verify_port,
+};
+
+static struct uart_8250_port serial8250_ports[UART_NR];
+
+static void __init serial8250_isa_init_ports(void)
+{
+	struct uart_8250_port *up;
+	static int first = 1;
+	int i;
+
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
+	     i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_cannonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		up->port.flags    = old_serial_port[i].flags |
+				    UPF_RESOURCES;
+		up->port.hub6     = old_serial_port[i].hub6;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		up->port.ops      = &serial8250_pops;
+	}
+}
+
+static void __init serial8250_register_ports(struct uart_driver *drv)
+{
+	int i;
+
+	serial8250_isa_init_ports();
+
+	for (i = 0; i < UART_NR; i++) {
+		serial8250_ports[i].port.line = i;
+		serial8250_ports[i].port.ops = &serial8250_pops;
+		init_timer(&serial8250_ports[i].timer);
+		serial8250_ports[i].timer.function = serial8250_timeout;
+		uart_add_one_port(drv, &serial8250_ports[i].port);
+	}
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static inline void wait_for_xmitr(struct uart_8250_port *up)
+{
+	unsigned int status, tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	do {
+		status = serial_in(up, UART_LSR);
+
+		if (status & UART_LSR_BI)
+			up->lsr_break_flag = UART_LSR_BI;
+
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & ASYNC_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout &&
+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+			udelay(1);
+	}
+}
+
+/*
+ *	Print a string to the serial port trying not to disturb
+ *	any possible real use of the port...
+ *
+ *	The console_lock must be held when we get here.
+ */
+static void
+serial8250_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+	unsigned int ier;
+	int i;
+
+	/*
+	 *	First save the UER then disable the interrupts
+	 */
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, 0);
+
+	/*
+	 *	Now, do each character
+	 */
+	for (i = 0; i < count; i++, s++) {
+		wait_for_xmitr(up);
+
+		/*
+		 *	Send the character out.
+		 *	If a LF, also do CR...
+		 */
+		serial_out(up, UART_TX, *s);
+		if (*s == 10) {
+			wait_for_xmitr(up);
+			serial_out(up, UART_TX, 13);
+		}
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	serial_out(up, UART_IER, ier);
+}
+
+static kdev_t serial8250_console_device(struct console *co)
+{
+	return mk_kdev(TTY_MAJOR, 64 + co->index);
+}
+
+static int __init serial8250_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= UART_NR)
+		co->index = 0;
+	port = &serial8250_ports[co->index].port;
+
+	/*
+	 * Temporary fix.
+	 */
+	spin_lock_init(&port->lock);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console serial8250_console = {
+	.name		= "ttyS",
+	.write		= serial8250_console_write,
+	.device		= serial8250_console_device,
+	.setup		= serial8250_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
+
+void __init serial8250_console_init(void)
+{
+	serial8250_isa_init_ports();
+	register_console(&serial8250_console);
+}
+
+#define SERIAL8250_CONSOLE	&serial8250_console
+#else
+#define SERIAL8250_CONSOLE	NULL
+#endif
+
+static struct uart_driver serial8250_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "serial",
+#ifdef CONFIG_DEVFS_FS
+	.dev_name		= "tts/%d",
+#else
+	.dev_name		= "ttyS",
+#endif
+	.major			= TTY_MAJOR,
+	.minor			= 64,
+	.nr			= UART_NR,
+	.cons			= SERIAL8250_CONSOLE,
+};
+
+/*
+ * register_serial and unregister_serial allows for 16x50 serial ports to be
+ * configured at run-time, to support PCMCIA modems.
+ */
+
+static int __register_serial(struct serial_struct *req, int line)
+{
+	struct uart_port port;
+
+	port.iobase   = req->port;
+	port.membase  = req->iomem_base;
+	port.irq      = req->irq;
+	port.uartclk  = req->baud_base * 16;
+	port.fifosize = req->xmit_fifo_size;
+	port.regshift = req->iomem_reg_shift;
+	port.iotype   = req->io_type;
+	port.flags    = req->flags | ASYNC_BOOT_AUTOCONF;
+	port.line     = line;
+
+	if (HIGH_BITS_OFFSET)
+		port.iobase |= (long) req->port_high << HIGH_BITS_OFFSET;
+
+	/*
+	 * If a clock rate wasn't specified by the low level
+	 * driver, then default to the standard clock rate.
+	 */
+	if (port.uartclk == 0)
+		port.uartclk = BASE_BAUD * 16;
+
+	return uart_register_port(&serial8250_reg, &port);
+}
+
+/**
+ *	register_serial - configure a 16x50 serial port at runtime
+ *	@req: request structure
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use an error is returned. If the port
+ *	is not currently in the table it is added.
+ *
+ *	The port is then probed and if neccessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int register_serial(struct serial_struct *req)
+{
+	return __register_serial(req, -1);
+}
+
+int __init early_serial_setup(struct serial_struct *req)
+{
+	__register_serial(req, req->line);
+	return 0;
+}
+
+/**
+ *	unregister_serial - remove a 16x50 serial port at runtime
+ *	@line: serial line number
+ *
+ *	Remove one serial port.  This may be called from interrupt
+ *	context.
+ */
+void unregister_serial(int line)
+{
+	uart_unregister_port(&serial8250_reg, line);
+}
+
+/*
+ * This is for ISAPNP only.
+ */
+void serial8250_get_irq_map(unsigned int *map)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++) {
+		if (serial8250_ports[i].port.type != PORT_UNKNOWN &&
+		    serial8250_ports[i].port.irq < 16)
+			*map |= 1 << serial8250_ports[i].port.irq;
+	}
+}
+
+static int __init serial8250_init(void)
+{
+	int ret, i;
+
+	printk(KERN_INFO "Serial: PC-9801 driver $Revision: 0.01 $ "
+		"IRQ sharing %sabled\n", share_irqs ? "en" : "dis");
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
+
+	ret = uart_register_driver(&serial8250_reg);
+	if (ret)
+		return ret;
+
+	serial8250_register_ports(&serial8250_reg);
+	return 0;
+}
+
+static void __exit serial8250_exit(void)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++)
+		uart_remove_one_port(&serial8250_reg, &serial8250_ports[i].port);
+
+	uart_unregister_driver(&serial8250_reg);
+}
+
+module_init(serial8250_init);
+module_exit(serial8250_exit);
+
+EXPORT_SYMBOL(register_serial);
+EXPORT_SYMBOL(unregister_serial);
+EXPORT_SYMBOL(serial8250_get_irq_map);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NEC PC-9801 serial driver $Revision: 0.01 $");
+
+MODULE_PARM(share_irqs, "i");
+MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
+	" (unsafe)");
+
+#if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
+MODULE_PARM(probe_rsa, "1-" __MODULE_STRING(PORT_RSA_MAX) "i");
+MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
+MODULE_PARM(force_rsa, "1-" __MODULE_STRING(PORT_RSA_MAX) "i");
+MODULE_PARM_DESC(force_rsa, "Force I/O ports for RSA");
+#endif
