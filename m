Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUJFGWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUJFGWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUJFGWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:22:36 -0400
Received: from mail.renesas.com ([202.234.163.13]:33408 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268312AbUJFGT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:19:27 -0400
Date: Wed, 06 Oct 2004 15:19:12 +0900 (JST)
Message-Id: <20041006.151912.840807084.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to support the M32R SIO (serial IO) driver.
Please apply.

This driver supports the M32R serial ports.
- Supports two types M32R serial interfaces; M32R_SIO and M32R_PLDSIO.
- With SMP safeness.

Currently the M32R_PLDSIO serial interface, which is implemented on a PLD 
on the M3T-M32700UT evaluation board, has slightly different specification
from the integrated peripheral SIO (M32R_SIO).
Now we can select them by CONFIG_ option.

It is a serial-core based driver, based on drivers/serial/8250.c.
Any comments or suggestions will be appreciated.

Thanks in advance.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/serial/Kconfig        |   29 
 drivers/serial/Makefile       |    1 
 drivers/serial/m32r_sio.c     | 1373 ++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/m32r_sio.h     |   56 +
 drivers/serial/m32r_sio_reg.h |  343 ++++++++++
 5 files changed, 1802 insertions(+)


diff -ruNp a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	2004-10-05 12:39:28.000000000 +0900
+++ b/drivers/serial/Kconfig	2004-10-05 21:15:44.000000000 +0900
@@ -741,4 +741,33 @@ config SERIAL_MPSC_CONSOLE
 	help
 	  Say Y here if you want to support a serial console on a Marvell MPSC.
 
+config SERIAL_M32R_SIO
+	bool "M32R SIO I/F"
+	depends on M32R
+	default y
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the M32R serial controller.
+
+config SERIAL_M32R_SIO_CONSOLE
+	bool "use SIO console"
+	depends on SERIAL_M32R_SIO=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you want to support a serial console.
+
+	  If you use an M3T-M32700UT or an OPSPUT platform,
+	  please say also y for SERIAL_M32R_PLDSIO.
+
+config SERIAL_M32R_PLDSIO
+	bool "M32R SIO I/F on a PLD"
+	depends on SERIAL_M32R_SIO=y
+	default n
+	help
+	  Say Y here if you want to use the M32R serial controller
+	  on a PLD (Programmable Logic Device).
+
+	  If you use an M3T-M32700UT or an OPSPUT platform,
+	  please say Y.
+
 endmenu
diff -ruNp a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	2004-10-05 12:39:28.000000000 +0900
+++ b/drivers/serial/Makefile	2004-10-05 21:15:44.000000000 +0900
@@ -42,3 +42,4 @@ obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += s
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc/
+obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
diff -ruNp a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/serial/m32r_sio.c	2004-10-05 21:25:03.000000000 +0900
@@ -0,0 +1,1373 @@
+/*
+ *  m32r_sio.c
+ *
+ *  Driver for M32R serial ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/serial/8250.c.
+ *
+ *  Copyright (C) 2001  Russell King.
+ *  Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/*
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
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#include <linux/delay.h>
+
+#include <asm/m32r.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#if defined(CONFIG_SERIAL_M32R_SIO_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#define PORT_SIO	1
+#define PORT_MAX_SIO	1
+#define BAUD_RATE	115200
+
+#include <linux/serial_core.h>
+#include "m32r_sio.h"
+#include "m32r_sio_reg.h"
+
+/*
+ * Configuration:
+ *   share_irqs - whether we pass SA_SHIRQ to request_irq().  This option
+ *                is unsafe when used on edge-triggered interrupts.
+ */
+unsigned int share_irqs_sio = M32R_SIO_SHARE_IRQS;
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
+#ifdef CONFIG_SERIAL_M32R_SIO_DETECT_IRQ
+#define CONFIG_SERIAL_DETECT_IRQ 1
+#endif
+#ifdef CONFIG_SERIAL_M32R_SIO_MULTIPORT
+#define CONFIG_SERIAL_MULTIPORT 1
+#endif
+#ifdef CONFIG_SERIAL_M32R_SIO_MANY_PORTS
+#define CONFIG_SERIAL_MANY_PORTS 1
+#endif
+
+/*
+ * HUB6 is always on.  This will be removed once the header
+ * files have been cleaned.
+ */
+#define CONFIG_HUB6 1
+
+#include <asm/serial.h>
+
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+static struct old_serial_port old_serial_port[] = {
+	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV, STD_COM_FLAGS },
+};
+#else
+static struct old_serial_port old_serial_port[] = {
+	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R, STD_COM_FLAGS },
+};
+#endif
+
+#define UART_NR	ARRAY_SIZE(old_serial_port)
+
+struct uart_sio_port {
+	struct uart_port	port;
+	struct timer_list	timer;		/* "no irq" timer */
+	struct list_head	list;		/* ports on this IRQ */
+	unsigned short		rev;
+	unsigned char		acr;
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr_mask;	/* mask of user bits */
+	unsigned char		mcr_force;	/* mask of forced bits */
+	unsigned char		lsr_break_flag;
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
+static const struct serial_uart_config uart_config[PORT_MAX_SIO+1] = {
+	{ "unknown",	1,	0 },
+	{ "M32RSIO",	1,	0 }
+};
+
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+
+#define __sio_in(x) inw((unsigned long)(x))
+#define __sio_out(v,x) outw((v),(unsigned long)(x))
+
+static inline void sio_set_baud_rate(unsigned long baud)
+{
+	unsigned short sbaud;
+	sbaud = (boot_cpu_data.bus_clock / (baud * 4))-1;
+	__sio_out(sbaud, PLD_ESIO0BAUR);
+}
+
+static void sio_reset(void)
+{
+	unsigned short tmp;
+
+	tmp = __sio_in(PLD_ESIO0RXB);
+	tmp = __sio_in(PLD_ESIO0RXB);
+	tmp = __sio_in(PLD_ESIO0CR);
+	sio_set_baud_rate(BAUD_RATE);
+	__sio_out(0x0300, PLD_ESIO0CR);
+	__sio_out(0x0003, PLD_ESIO0CR);
+}
+
+static void sio_init(void)
+{
+	unsigned short tmp;
+
+	tmp = __sio_in(PLD_ESIO0RXB);
+	tmp = __sio_in(PLD_ESIO0RXB);
+	tmp = __sio_in(PLD_ESIO0CR);
+	__sio_out(0x0300, PLD_ESIO0CR);
+	__sio_out(0x0003, PLD_ESIO0CR);
+}
+
+static void sio_error(int *status)
+{
+	printk("SIO0 error[%04x]\n", *status);
+	do {
+		sio_init();
+	} while ((*status = __sio_in(PLD_ESIO0CR)) != 3);
+}
+
+#else /* not CONFIG_SERIAL_M32R_PLDSIO */
+
+#define __sio_in(x) inl(x)
+#define __sio_out(v,x) outl((v),(x))
+
+static inline void sio_set_baud_rate(unsigned long baud)
+{
+	unsigned long i, j;
+
+	i = boot_cpu_data.bus_clock / (baud * 16);
+	j = (boot_cpu_data.bus_clock - (i * baud * 16)) / baud;
+	i -= 1;
+	j = (j + 1) >> 1;
+
+	__sio_out(i, M32R_SIO0_BAUR_PORTL);
+	__sio_out(j, M32R_SIO0_RBAUR_PORTL);
+}
+
+static void sio_reset(void)
+{
+	__sio_out(0x00000300, M32R_SIO0_CR_PORTL);	/* init status */
+	__sio_out(0x00000800, M32R_SIO0_MOD1_PORTL);	/* 8bit        */
+	__sio_out(0x00000080, M32R_SIO0_MOD0_PORTL);	/* 1stop non   */
+	sio_set_baud_rate(BAUD_RATE);
+	__sio_out(0x00000000, M32R_SIO0_TRCR_PORTL);
+	__sio_out(0x00000003, M32R_SIO0_CR_PORTL);	/* RXCEN */
+}
+
+static void sio_init(void)
+{
+	unsigned int tmp;
+
+	tmp = __sio_in(M32R_SIO0_RXB_PORTL);
+	tmp = __sio_in(M32R_SIO0_RXB_PORTL);
+	tmp = __sio_in(M32R_SIO0_STS_PORTL);
+	__sio_out(0x00000003, M32R_SIO0_CR_PORTL);
+}
+
+static void sio_error(int *status)
+{
+	printk("SIO0 error[%04x]\n", *status);
+	do {
+		sio_init();
+	} while ((*status = __sio_in(M32R_SIO0_CR_PORTL)) != 3);
+}
+
+#endif /* CONFIG_SERIAL_M32R_PLDSIO */
+
+static _INLINE_ unsigned int sio_in(struct uart_sio_port *up, int offset)
+{
+	return __sio_in(up->port.iobase + offset);
+}
+
+static _INLINE_ void sio_out(struct uart_sio_port *up, int offset, int value)
+{
+	__sio_out(value, up->port.iobase + offset);
+}
+
+static _INLINE_ unsigned int serial_in(struct uart_sio_port *up, int offset)
+{
+	if (!offset)
+		return 0;
+
+	return __sio_in(offset);
+}
+
+static _INLINE_ void
+serial_out(struct uart_sio_port *up, int offset, int value)
+{
+	if (!offset)
+		return;
+
+	__sio_out(value, offset);
+}
+
+static void m32r_sio_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static void m32r_sio_start_tx(struct uart_port *port, unsigned int tty_start)
+{
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+	struct circ_buf *xmit = &up->port.info->xmit;
+
+	if (!(up->ier & UART_IER_THRI)) {
+		up->ier |= UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+	}
+	while((serial_in(up, UART_LSR) & UART_EMPTY) != UART_EMPTY);
+#else
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	if (!(up->ier & UART_IER_THRI)) {
+		up->ier |= UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+#endif
+}
+
+static void m32r_sio_stop_rx(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	up->ier &= ~UART_IER_RLSI;
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static void m32r_sio_enable_ms(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	up->ier |= UART_IER_MSI;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static _INLINE_ void receive_chars(struct uart_sio_port *up, int *status,
+	struct pt_regs *regs)
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
+		ch = sio_in(up, SIORXB);
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
+			if (up->port.line == up->port.cons->index) {
+				/* Recover the break flag from console xmit */
+				*status |= up->lsr_break_flag;
+				up->lsr_break_flag = 0;
+			}
+
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
+		*status = serial_in(up, UART_LSR);
+	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+	tty_flip_buffer_push(tty);
+}
+
+static _INLINE_ void transmit_chars(struct uart_sio_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	if (up->port.x_char) {
+#ifndef CONFIG_SERIAL_M32R_PLDSIO	/* XXX */
+		serial_out(up, UART_TX, up->port.x_char);
+#endif
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		m32r_sio_stop_tx(&up->port, 0);
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
+		while (!serial_in(up, UART_LSR) & UART_LSR_THRE);
+
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	DEBUG_INTR("THRE...");
+
+	if (uart_circ_empty(xmit))
+		m32r_sio_stop_tx(&up->port, 0);
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline void m32r_sio_handle_port(struct uart_sio_port *up,
+	unsigned int status, struct pt_regs *regs)
+{
+	DEBUG_INTR("status = %x...", status);
+
+	if (status & 0x04)
+		receive_chars(up, &status, regs);
+	// check_modem_status(up);
+	if (status & 0x01)
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
+static irqreturn_t m32r_sio_interrupt(int irq, void *dev_id,
+	struct pt_regs *regs)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l, *end = NULL;
+	int pass_counter = 0;
+
+	DEBUG_INTR("m32r_sio_interrupt(%d)...", irq);
+
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+//	if (irq == PLD_IRQ_SIO0_SND)
+//		irq = PLD_IRQ_SIO0_RCV;
+#else
+	if (irq == M32R_IRQ_SIO0_S)
+		irq = M32R_IRQ_SIO0_R;
+#endif
+
+	spin_lock(&i->lock);
+
+	l = i->head;
+	do {
+		struct uart_sio_port *up;
+		unsigned int sts;
+
+		up = list_entry(l, struct uart_sio_port, list);
+
+		sts = sio_in(up, SIOSTS);
+		if (sts & 0x5) {
+			spin_lock(&up->port.lock);
+			m32r_sio_handle_port(up, sts, regs);
+			spin_unlock(&up->port.lock);
+
+			end = NULL;
+		} else if (end == NULL)
+			end = l;
+
+		l = l->next;
+
+		if (l == i->head && pass_counter++ > PASS_LIMIT) {
+			if (sts & 0xe0)
+				sio_error(&sts);
+			break;
+		}
+	} while (l != end);
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * To support ISA shared interrupts, we need to have one interrupt
+ * handler that ensures that the IRQ line has been deasserted
+ * before returning.  Failing to do this will result in the IRQ
+ * line being stuck active, and, since ISA irqs are edge triggered,
+ * no more IRQs will be seen.
+ */
+static void serial_do_unlink(struct irq_info *i, struct uart_sio_port *up)
+{
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
+static int serial_link_irq_chain(struct uart_sio_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
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
+		ret = request_irq(up->port.irq, m32r_sio_interrupt,
+				  irq_flags, "SIO0-RX", i);
+		ret |= request_irq(up->port.irq + 1, m32r_sio_interrupt,
+				  irq_flags, "SIO0-TX", i);
+		if (ret < 0)
+			serial_do_unlink(i, up);
+	}
+
+	return ret;
+}
+
+static void serial_unlink_irq_chain(struct uart_sio_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+
+	BUG_ON(i->head == NULL);
+
+	if (list_empty(i->head)) {
+		free_irq(up->port.irq, i);
+		free_irq(up->port.irq + 1, i);
+	}
+
+	serial_do_unlink(i, up);
+}
+
+/*
+ * This function is used to handle ports that do not have an
+ * interrupt.  This doesn't work very well for 16450's, but gives
+ * barely passable results for a 16550A.  (Although at the expense
+ * of much CPU overhead).
+ */
+static void m32r_sio_timeout(unsigned long data)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)data;
+	unsigned int timeout;
+	unsigned int sts;
+
+	sts = sio_in(up, SIOSTS);
+	if (sts & 0x5) {
+		spin_lock(&up->port.lock);
+		m32r_sio_handle_port(up, sts, NULL);
+		spin_unlock(&up->port.lock);
+	}
+
+	timeout = up->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+	mod_timer(&up->timer, jiffies + timeout);
+}
+
+static unsigned int m32r_sio_tx_empty(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	return ret;
+}
+
+static unsigned int m32r_sio_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void m32r_sio_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+
+}
+
+static void m32r_sio_break_ctl(struct uart_port *port, int break_state)
+{
+
+}
+
+static int m32r_sio_startup(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+	int retval;
+
+	sio_init();
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
+	 * Finally, enable interrupts.  Note: Modem status interrupts
+	 * are set via set_termios(), which will be occurring imminently
+	 * anyway, so we don't enable them here.
+	 * - M32R_SIO: 0x0c
+	 * - M32R_PLDSIO: 0x04
+	 */
+	up->ier = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
+	sio_out(up, SIOTRCR, up->ier);
+
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	sio_reset();
+
+	return 0;
+}
+
+static void m32r_sio_shutdown(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	/*
+	 * Disable interrupts from this port
+	 */
+	up->ier = 0;
+	sio_out(up, SIOTRCR, 0);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+
+	sio_init();
+
+	if (!is_real_interrupt(up->port.irq))
+		del_timer_sync(&up->timer);
+	else
+		serial_unlink_irq_chain(up);
+}
+
+static unsigned int m32r_sio_get_divisor(struct uart_port *port,
+	unsigned int baud)
+{
+	return uart_get_divisor(port, baud);
+}
+
+static void m32r_sio_set_termios(struct uart_port *port,
+	struct termios *termios, struct termios *old)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+	unsigned char cval = 0;
+	unsigned long flags;
+	unsigned int baud, quot;
+
+	switch (termios->c_cflag & CSIZE) {
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
+	if (termios->c_cflag & CSTOPB)
+		cval |= 0x04;
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+#endif
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/4);
+#else
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
+#endif
+	quot = m32r_sio_get_divisor(port, baud);
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	sio_set_baud_rate(baud);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+
+	serial_out(up, UART_IER, up->ier);
+
+	up->lcr = cval;					/* Save LCR */
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void m32r_sio_pm(struct uart_port *port, unsigned int state,
+	unsigned int oldstate)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	if (up->pm)
+		up->pm(port, state, oldstate);
+}
+
+/*
+ * Resource handling.  This is complicated by the fact that resources
+ * depend on the port type.  Maybe we should be claiming the standard
+ * 8250 ports, and then trying to get other resources as necessary?
+ */
+static int
+m32r_sio_request_std_resource(struct uart_sio_port *up, struct resource **res)
+{
+	unsigned int size = 8 << up->port.regshift;
+#ifndef CONFIG_SERIAL_M32R_PLDSIO
+	unsigned long start;
+#endif
+	int ret = 0;
+
+	switch (up->port.iotype) {
+	case SERIAL_IO_MEM:
+		if (up->port.mapbase) {
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+			*res = request_mem_region(up->port.mapbase, size, "serial");
+#else
+			start = up->port.mapbase;
+			start += UARRT_RSA_BASE << up->port.regshift;
+			*res = request_mem_region(start, size, "serial");
+#endif
+			if (!*res)
+				ret = -EBUSY;
+		}
+		break;
+
+	case SERIAL_IO_HUB6:
+	case SERIAL_IO_PORT:
+		*res = request_region(up->port.iobase, size, "serial");
+		if (!*res)
+			ret = -EBUSY;
+		break;
+	}
+	return ret;
+}
+
+static int
+m32r_sio_request_rsa_resource(struct uart_sio_port *up, struct resource **res)
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
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+			*res = request_mem_region(start, size, "serial-rsa");
+#else
+			*res = request_mem_region(up->port.mapbase, size, "serial-rsa");
+#endif
+			if (!*res)
+				ret = -EBUSY;
+		}
+		break;
+
+	case SERIAL_IO_HUB6:
+	case SERIAL_IO_PORT:
+		start = up->port.iobase;
+		start += UART_RSA_BASE << up->port.regshift;
+		*res = request_region(up->port.iobase, size, "serial-rsa");
+		if (!*res)
+			ret = -EBUSY;
+		break;
+	}
+
+	return ret;
+}
+
+static void m32r_sio_release_port(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
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
+static int m32r_sio_request_port(struct uart_port *port)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+	struct resource *res = NULL, *res_rsa = NULL;
+	int ret = 0;
+
+	if (up->port.type == PORT_RSA){
+		ret = m32r_sio_request_rsa_resource(up, &res_rsa);
+		if (ret < 0)
+			return ret;
+	}
+	ret = m32r_sio_request_std_resource(up, &res);
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
+	if (ret < 0) {
+		if (res_rsa)
+			release_resource(res_rsa);
+		if (res)
+			release_resource(res);
+	}
+	return ret;
+}
+
+static void m32r_sio_config_port(struct uart_port *port, int flags)
+{
+	struct uart_sio_port *up = (struct uart_sio_port *)port;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->port.type = PORT_SIO;
+	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int
+m32r_sio_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if (ser->irq >= NR_IRQS || ser->irq < 0 ||
+	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
+	    ser->type > PORT_MAX_SIO || ser->type == PORT_CIRRUS ||
+	    ser->type == PORT_STARTECH)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *
+m32r_sio_type(struct uart_port *port)
+{
+	int type = port->type;
+
+	if (type >= ARRAY_SIZE(uart_config))
+		type = 0;
+	return uart_config[type].name;
+}
+
+static struct uart_ops m32r_sio_pops = {
+	.tx_empty	= m32r_sio_tx_empty,
+	.set_mctrl	= m32r_sio_set_mctrl,
+	.get_mctrl	= m32r_sio_get_mctrl,
+	.stop_tx	= m32r_sio_stop_tx,
+	.start_tx	= m32r_sio_start_tx,
+	.stop_rx	= m32r_sio_stop_rx,
+	.enable_ms	= m32r_sio_enable_ms,
+	.break_ctl	= m32r_sio_break_ctl,
+	.startup	= m32r_sio_startup,
+	.shutdown	= m32r_sio_shutdown,
+	.set_termios	= m32r_sio_set_termios,
+	.pm		= m32r_sio_pm,
+	.type		= m32r_sio_type,
+	.release_port	= m32r_sio_release_port,
+	.request_port	= m32r_sio_request_port,
+	.config_port	= m32r_sio_config_port,
+	.verify_port	= m32r_sio_verify_port,
+};
+
+static struct uart_sio_port m32r_sio_ports[UART_NR];
+
+static void __init m32r_sio_isa_init_ports(void)
+{
+	struct uart_sio_port *up;
+	static int first = 1;
+	int i;
+
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0, up = m32r_sio_ports; i < ARRAY_SIZE(old_serial_port);
+	     i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		up->port.flags    = old_serial_port[i].flags;
+		up->port.hub6     = old_serial_port[i].hub6;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		up->port.ops      = &m32r_sio_pops;
+		if (share_irqs_sio)
+			up->port.flags |= UPF_SHARE_IRQ;
+	}
+}
+
+static void __init m32r_sio_register_ports(struct uart_driver *drv)
+{
+	int i;
+
+	m32r_sio_isa_init_ports();
+
+	for (i = 0; i < UART_NR; i++) {
+		struct uart_sio_port *up = &m32r_sio_ports[i];
+
+		up->port.line = i;
+		up->port.ops = &m32r_sio_pops;
+		init_timer(&up->timer);
+		up->timer.function = m32r_sio_timeout;
+
+		/*
+		 * ALPHA_KLUDGE_MCR needs to be killed.
+		 */
+		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
+		up->mcr_force = ALPHA_KLUDGE_MCR;
+
+		uart_add_one_port(drv, &up->port);
+	}
+}
+
+#ifdef CONFIG_SERIAL_M32R_SIO_CONSOLE
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static inline void wait_for_xmitr(struct uart_sio_port *up)
+{
+	unsigned int status, tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	do {
+		status = sio_in(up, SIOSTS);
+
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while ((status & UART_EMPTY) != UART_EMPTY);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout)
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
+static void m32r_sio_console_write(struct console *co, const char *s,
+	unsigned int count)
+{
+	struct uart_sio_port *up = &m32r_sio_ports[co->index];
+	unsigned int ier;
+	int i;
+
+	/*
+	 *	First save the UER then disable the interrupts
+	 */
+	ier = sio_in(up, SIOTRCR);
+	sio_out(up, SIOTRCR, 0);
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
+		sio_out(up, SIOTXB, *s);
+
+		if (*s == 10) {
+			wait_for_xmitr(up);
+			sio_out(up, SIOTXB, 13);
+		}
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	sio_out(up, SIOTRCR, ier);
+}
+
+static int __init m32r_sio_console_setup(struct console *co, char *options)
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
+	port = &m32r_sio_ports[co->index].port;
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
+extern struct uart_driver m32r_sio_reg;
+static struct console m32r_sio_console = {
+	.name		= "ttyS",
+	.write		= m32r_sio_console_write,
+	.device		= uart_console_device,
+	.setup		= m32r_sio_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &m32r_sio_reg,
+};
+
+static int __init m32r_sio_console_init(void)
+{
+	sio_reset();
+	sio_init();
+	m32r_sio_isa_init_ports();
+	register_console(&m32r_sio_console);
+	return 0;
+}
+console_initcall(m32r_sio_console_init);
+
+#define M32R_SIO_CONSOLE	&m32r_sio_console
+#else
+#define M32R_SIO_CONSOLE	NULL
+#endif
+
+static struct uart_driver m32r_sio_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "sio",
+	.devfs_name		= "tts/",
+	.dev_name		= "ttyS",
+	.major			= TTY_MAJOR,
+	.minor			= 64,
+	.nr			= UART_NR,
+	.cons			= M32R_SIO_CONSOLE,
+};
+
+/*
+ * register_serial and unregister_serial allows for 16x50 serial ports to be
+ * configured at run-time, to support PCMCIA modems.
+ */
+
+static int __register_m32r_sio(struct serial_struct *req, int line)
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
+	port.flags    = req->flags | UPF_BOOT_AUTOCONF;
+	port.mapbase  = req->iomap_base;
+	port.line     = line;
+
+	if (share_irqs_sio)
+		port.flags |= UPF_SHARE_IRQ;
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
+	return uart_register_port(&m32r_sio_reg, &port);
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
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int register_m32r_sio(struct serial_struct *req)
+{
+	return __register_m32r_sio(req, -1);
+}
+
+int __init early_m32r_sio_setup(struct uart_port *port)
+{
+	m32r_sio_isa_init_ports();
+ 	m32r_sio_ports[port->line].port = *port;
+	m32r_sio_ports[port->line].port.ops = &m32r_sio_pops;
+
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
+void unregister_m32r_sio(int line)
+{
+	uart_unregister_port(&m32r_sio_reg, line);
+}
+
+/*
+ * This is for ISAPNP only.
+ */
+void m32r_sio_get_irq_map(unsigned int *map)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++) {
+		if (m32r_sio_ports[i].port.type != PORT_UNKNOWN &&
+		    m32r_sio_ports[i].port.irq < 16)
+			*map |= 1 << m32r_sio_ports[i].port.irq;
+	}
+}
+
+/**
+ *	m32r_sio_suspend_port - suspend one serial port
+ *	@line: serial line number
+ *
+ *	Suspend one serial port.
+ */
+void m32r_sio_suspend_port(int line)
+{
+	uart_suspend_port(&m32r_sio_reg, &m32r_sio_ports[line].port);
+}
+
+/**
+ *	m32r_sio_resume_port - resume one serial port
+ *	@line: serial line number
+ *
+ *	Resume one serial port.
+ */
+void m32r_sio_resume_port(int line)
+{
+	uart_resume_port(&m32r_sio_reg, &m32r_sio_ports[line].port);
+}
+
+static int __init m32r_sio_init(void)
+{
+	int ret, i;
+
+	printk(KERN_INFO "Serial: M32R SIO driver $Revision: 1.6 $ "
+		"IRQ sharing %sabled\n", share_irqs_sio ? "en" : "dis");
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
+
+	ret = uart_register_driver(&m32r_sio_reg);
+	if (ret >= 0)
+		m32r_sio_register_ports(&m32r_sio_reg);
+
+	return ret;
+}
+
+static void __exit m32r_sio_exit(void)
+{
+	int i;
+
+	for (i = 0; i < UART_NR; i++)
+		uart_remove_one_port(&m32r_sio_reg, &m32r_sio_ports[i].port);
+
+	uart_unregister_driver(&m32r_sio_reg);
+}
+
+module_init(m32r_sio_init);
+module_exit(m32r_sio_exit);
+
+EXPORT_SYMBOL(register_m32r_sio);
+EXPORT_SYMBOL(unregister_m32r_sio);
+EXPORT_SYMBOL(m32r_sio_get_irq_map);
+EXPORT_SYMBOL(m32r_sio_suspend_port);
+EXPORT_SYMBOL(m32r_sio_resume_port);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic M32R SIO serial driver $Revision: 1.6 $");
+
+MODULE_PARM(share_irqs_sio, "i");
+MODULE_PARM_DESC(share_irqs_sio, "Share IRQs with other non-M32R SIO devices"
+	" (unsafe)");
diff -ruNp a/drivers/serial/m32r_sio.h b/drivers/serial/m32r_sio.h
--- a/drivers/serial/m32r_sio.h	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/serial/m32r_sio.h	2004-10-05 21:25:03.000000000 +0900
@@ -0,0 +1,56 @@
+/*
+ *  m32r_sio.h
+ *
+ *  Driver for M32R serial ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/serial/8250.h.
+ *
+ *  Copyright (C) 2001  Russell King.
+ *  Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/config.h>
+
+struct m32r_sio_probe {
+	struct module	*owner;
+	int		(*pci_init_one)(struct pci_dev *dev);
+	void		(*pci_remove_one)(struct pci_dev *dev);
+	void		(*pnp_init)(void);
+};
+
+int m32r_sio_register_probe(struct m32r_sio_probe *probe);
+void m32r_sio_unregister_probe(struct m32r_sio_probe *probe);
+void m32r_sio_get_irq_map(unsigned int *map);
+void m32r_sio_suspend_port(int line);
+void m32r_sio_resume_port(int line);
+
+struct old_serial_port {
+	unsigned int uart;
+	unsigned int baud_base;
+	unsigned int port;
+	unsigned int irq;
+	unsigned int flags;
+	unsigned char hub6;
+	unsigned char io_type;
+	unsigned char *iomem_base;
+	unsigned short iomem_reg_shift;
+};
+
+#define _INLINE_ inline
+
+#define PROBE_RSA	(1 << 0)
+#define PROBE_ANY	(~0)
+
+#define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
+
+#ifdef CONFIG_SERIAL_SIO_SHARE_IRQ
+#define M32R_SIO_SHARE_IRQS 1
+#else
+#define M32R_SIO_SHARE_IRQS 0
+#endif
diff -ruNp a/drivers/serial/m32r_sio_reg.h b/drivers/serial/m32r_sio_reg.h
--- a/drivers/serial/m32r_sio_reg.h	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/serial/m32r_sio_reg.h	2004-10-05 21:25:03.000000000 +0900
@@ -0,0 +1,343 @@
+/*
+ * m32r_sio_reg.h
+ *
+ * Copyright (C) 1992, 1994 by Theodore Ts'o.
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ *
+ * Redistribution of this file is permitted under the terms of the GNU
+ * Public License (GPL)
+ *
+ * These are the UART port assignments, expressed as offsets from the base
+ * register.  These assignments should hold for any serial port based on
+ * a 8250, 16450, or 16550(A).
+ */
+
+#ifndef _M32R_SIO_REG_H
+#define _M32R_SIO_REG_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_SERIAL_M32R_PLDSIO
+
+#define SIOCR		0x000
+#define SIOMOD0		0x002
+#define SIOMOD1		0x004
+#define SIOSTS		0x006
+#define SIOTRCR		0x008
+#define SIOBAUR		0x00a
+// #define SIORBAUR	0x018
+#define SIOTXB		0x00c
+#define SIORXB		0x00e
+
+#define UART_RX		((unsigned long) PLD_ESIO0RXB)
+				/* In:  Receive buffer (DLAB=0) */
+#define UART_TX		((unsigned long) PLD_ESIO0TXB)
+				/* Out: Transmit buffer (DLAB=0) */
+#define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
+#define UART_TRG	0	/* (LCR=BF) FCTR bit 7 selects Rx or Tx
+				 * In: Fifo count
+				 * Out: Fifo custom trigger levels
+				 * XR16C85x only */
+
+#define UART_DLM	0	/* Out: Divisor Latch High (DLAB=1) */
+#define UART_IER	((unsigned long) PLD_ESIO0INTCR)
+				/* Out: Interrupt Enable Register */
+#define UART_FCTR	0	/* (LCR=BF) Feature Control Register
+				 * XR16C85x only */
+
+#define UART_IIR	0	/* In:  Interrupt ID Register */
+#define UART_FCR	0	/* Out: FIFO Control Register */
+#define UART_EFR	0	/* I/O: Extended Features Register */
+				/* (DLAB=1, 16C660 only) */
+
+#define UART_LCR	0	/* Out: Line Control Register */
+#define UART_MCR	0	/* Out: Modem Control Register */
+#define UART_LSR	((unsigned long) PLD_ESIO0STS)
+				/* In:  Line Status Register */
+#define UART_MSR	0	/* In:  Modem Status Register */
+#define UART_SCR	0	/* I/O: Scratch Register */
+#define UART_EMSR	0	/* (LCR=BF) Extended Mode Select Register
+				 * FCTR bit 6 selects SCR or EMSR
+				 * XR16c85x only */
+
+#else /* not CONFIG_SERIAL_M32R_PLDSIO */
+
+#define SIOCR		0x000
+#define SIOMOD0		0x004
+#define SIOMOD1		0x008
+#define SIOSTS		0x00c
+#define SIOTRCR		0x010
+#define SIOBAUR		0x014
+#define SIORBAUR	0x018
+#define SIOTXB		0x01c
+#define SIORXB		0x020
+
+#define UART_RX		M32R_SIO0_RXB_PORTL	/* In:  Receive buffer (DLAB=0) */
+#define UART_TX		M32R_SIO0_TXB_PORTL	/* Out: Transmit buffer (DLAB=0) */
+#define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
+#define UART_TRG	0	/* (LCR=BF) FCTR bit 7 selects Rx or Tx
+				 * In: Fifo count
+				 * Out: Fifo custom trigger levels
+				 * XR16C85x only */
+
+#define UART_DLM	0	/* Out: Divisor Latch High (DLAB=1) */
+#define UART_IER	M32R_SIO0_TRCR_PORTL	/* Out: Interrupt Enable Register */
+#define UART_FCTR	0	/* (LCR=BF) Feature Control Register
+				 * XR16C85x only */
+
+#define UART_IIR	0	/* In:  Interrupt ID Register */
+#define UART_FCR	0	/* Out: FIFO Control Register */
+#define UART_EFR	0	/* I/O: Extended Features Register */
+				/* (DLAB=1, 16C660 only) */
+
+#define UART_LCR	0	/* Out: Line Control Register */
+#define UART_MCR	0	/* Out: Modem Control Register */
+#define UART_LSR	M32R_SIO0_STS_PORTL	/* In:  Line Status Register */
+#define UART_MSR	0	/* In:  Modem Status Register */
+#define UART_SCR	0	/* I/O: Scratch Register */
+#define UART_EMSR	0	/* (LCR=BF) Extended Mode Select Register
+				 * FCTR bit 6 selects SCR or EMSR
+				 * XR16c85x only */
+
+#endif /* CONFIG_SERIAL_M32R_PLDSIO */
+
+#define UART_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
+
+/*
+ * These are the definitions for the FIFO Control Register
+ * (16650 only)
+ */
+#define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
+#define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
+#define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
+#define UART_FCR_DMA_SELECT	0x08 /* For DMA applications */
+#define UART_FCR_TRIGGER_MASK	0xC0 /* Mask for the FIFO trigger range */
+#define UART_FCR_TRIGGER_1	0x00 /* Mask for trigger set at 1 */
+#define UART_FCR_TRIGGER_4	0x40 /* Mask for trigger set at 4 */
+#define UART_FCR_TRIGGER_8	0x80 /* Mask for trigger set at 8 */
+#define UART_FCR_TRIGGER_14	0xC0 /* Mask for trigger set at 14 */
+/* 16650 redefinitions */
+#define UART_FCR6_R_TRIGGER_8	0x00 /* Mask for receive trigger set at 1 */
+#define UART_FCR6_R_TRIGGER_16	0x40 /* Mask for receive trigger set at 4 */
+#define UART_FCR6_R_TRIGGER_24  0x80 /* Mask for receive trigger set at 8 */
+#define UART_FCR6_R_TRIGGER_28	0xC0 /* Mask for receive trigger set at 14 */
+#define UART_FCR6_T_TRIGGER_16	0x00 /* Mask for transmit trigger set at 16 */
+#define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
+#define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
+#define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
+/* TI 16750 definitions */
+#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode */
+
+/*
+ * These are the definitions for the Line Control Register
+ *
+ * Note: if the word length is 5 bits (UART_LCR_WLEN5), then setting
+ * UART_LCR_STOP will select 1.5 stop bits, not 2 stop bits.
+ */
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
+/*
+ * These are the definitions for the Line Status Register
+ */
+#define UART_LSR_TEMT	0x02	/* Transmitter empty */
+#define UART_LSR_THRE	0x01	/* Transmit-hold-register empty */
+#define UART_LSR_BI	0x00	/* Break interrupt indicator */
+#define UART_LSR_FE	0x80	/* Frame error indicator */
+#define UART_LSR_PE	0x40	/* Parity error indicator */
+#define UART_LSR_OE	0x20	/* Overrun error indicator */
+#define UART_LSR_DR	0x04	/* Receiver data ready */
+
+/*
+ * These are the definitions for the Interrupt Identification Register
+ */
+#define UART_IIR_NO_INT	0x01	/* No interrupts pending */
+#define UART_IIR_ID	0x06	/* Mask for the interrupt ID */
+
+#define UART_IIR_MSI	0x00	/* Modem status interrupt */
+#define UART_IIR_THRI	0x02	/* Transmitter holding register empty */
+#define UART_IIR_RDI	0x04	/* Receiver data interrupt */
+#define UART_IIR_RLSI	0x06	/* Receiver line status interrupt */
+
+/*
+ * These are the definitions for the Interrupt Enable Register
+ */
+#define UART_IER_MSI	0x00	/* Enable Modem status interrupt */
+#define UART_IER_RLSI	0x08	/* Enable receiver line status interrupt */
+#define UART_IER_THRI	0x03	/* Enable Transmitter holding register int. */
+#define UART_IER_RDI	0x04	/* Enable receiver data interrupt */
+/*
+ * Sleep mode for ST16650 and TI16750.
+ * Note that for 16650, EFR-bit 4 must be selected as well.
+ */
+#define UART_IERX_SLEEP  0x10	/* Enable sleep mode */
+
+/*
+ * These are the definitions for the Modem Control Register
+ */
+#define UART_MCR_LOOP	0x10	/* Enable loopback test mode */
+#define UART_MCR_OUT2	0x08	/* Out2 complement */
+#define UART_MCR_OUT1	0x04	/* Out1 complement */
+#define UART_MCR_RTS	0x02	/* RTS complement */
+#define UART_MCR_DTR	0x01	/* DTR complement */
+
+/*
+ * These are the definitions for the Modem Status Register
+ */
+#define UART_MSR_DCD	0x80	/* Data Carrier Detect */
+#define UART_MSR_RI	0x40	/* Ring Indicator */
+#define UART_MSR_DSR	0x20	/* Data Set Ready */
+#define UART_MSR_CTS	0x10	/* Clear to Send */
+#define UART_MSR_DDCD	0x08	/* Delta DCD */
+#define UART_MSR_TERI	0x04	/* Trailing edge ring indicator */
+#define UART_MSR_DDSR	0x02	/* Delta DSR */
+#define UART_MSR_DCTS	0x01	/* Delta CTS */
+#define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
+
+/*
+ * These are the definitions for the Extended Features Register
+ * (StarTech 16C660 only, when DLAB=1)
+ */
+#define UART_EFR_CTS	0x80	/* CTS flow control */
+#define UART_EFR_RTS	0x40	/* RTS flow control */
+#define UART_EFR_SCD	0x20	/* Special character detect */
+#define UART_EFR_ECB	0x10	/* Enhanced control bit */
+/*
+ * the low four bits control software flow control
+ */
+
+/*
+ * These register definitions are for the 16C950
+ */
+#define UART_ASR	0x01	/* Additional Status Register */
+#define UART_RFL	0x03	/* Receiver FIFO level */
+#define UART_TFL 	0x04	/* Transmitter FIFO level */
+#define UART_ICR	0x05	/* Index Control Register */
+
+/* The 16950 ICR registers */
+#define UART_ACR	0x00	/* Additional Control Register */
+#define UART_CPR	0x01	/* Clock Prescalar Register */
+#define UART_TCR	0x02	/* Times Clock Register */
+#define UART_CKS	0x03	/* Clock Select Register */
+#define UART_TTL	0x04	/* Transmitter Interrupt Trigger Level */
+#define UART_RTL	0x05	/* Receiver Interrupt Trigger Level */
+#define UART_FCL	0x06	/* Flow Control Level Lower */
+#define UART_FCH	0x07	/* Flow Control Level Higher */
+#define UART_ID1	0x08	/* ID #1 */
+#define UART_ID2	0x09	/* ID #2 */
+#define UART_ID3	0x0A	/* ID #3 */
+#define UART_REV	0x0B	/* Revision */
+#define UART_CSR	0x0C	/* Channel Software Reset */
+#define UART_NMR	0x0D	/* Nine-bit Mode Register */
+#define UART_CTR	0xFF
+
+/*
+ * The 16C950 Additional Control Reigster
+ */
+#define UART_ACR_RXDIS	0x01	/* Receiver disable */
+#define UART_ACR_TXDIS	0x02	/* Receiver disable */
+#define UART_ACR_DSRFC	0x04	/* DSR Flow Control */
+#define UART_ACR_TLENB	0x20	/* 950 trigger levels enable */
+#define UART_ACR_ICRRD	0x40	/* ICR Read enable */
+#define UART_ACR_ASREN	0x80	/* Additional status enable */
+
+/*
+ * These are the definitions for the Feature Control Register
+ * (XR16C85x only, when LCR=bf; doubles with the Interrupt Enable
+ * Register, UART register #1)
+ */
+#define UART_FCTR_RTS_NODELAY	0x00  /* RTS flow control delay */
+#define UART_FCTR_RTS_4DELAY	0x01
+#define UART_FCTR_RTS_6DELAY	0x02
+#define UART_FCTR_RTS_8DELAY	0x03
+#define UART_FCTR_IRDA	0x04  /* IrDa data encode select */
+#define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
+#define UART_FCTR_TRGA	0x00  /* Tx/Rx 550 trigger table select */
+#define UART_FCTR_TRGB	0x10  /* Tx/Rx 650 trigger table select */
+#define UART_FCTR_TRGC	0x20  /* Tx/Rx 654 trigger table select */
+#define UART_FCTR_TRGD	0x30  /* Tx/Rx 850 programmable trigger select */
+#define UART_FCTR_SCR_SWAP	0x40  /* Scratch pad register swap */
+#define UART_FCTR_RX	0x00  /* Programmable trigger mode select */
+#define UART_FCTR_TX	0x80  /* Programmable trigger mode select */
+
+/*
+ * These are the definitions for the Enhanced Mode Select Register
+ * (XR16C85x only, when LCR=bf and FCTR bit 6=1; doubles with the
+ * Scratch register, UART register #7)
+ */
+#define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
+#define UART_EMSR_ALT_COUNT	0x02  /* Alternating count select */
+
+/*
+ * These are the definitions for the Programmable Trigger
+ * Register (XR16C85x only, when LCR=bf; doubles with the UART RX/TX
+ * register, UART register #0)
+ */
+#define UART_TRG_1	0x01
+#define UART_TRG_4	0x04
+#define UART_TRG_8	0x08
+#define UART_TRG_16	0x10
+#define UART_TRG_32	0x20
+#define UART_TRG_64	0x40
+#define UART_TRG_96	0x60
+#define UART_TRG_120	0x78
+#define UART_TRG_128	0x80
+
+/*
+ * These definitions are for the RSA-DV II/S card, from
+ *
+ * Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
+ */
+
+#define UART_RSA_BASE (-8)
+
+#define UART_RSA_MSR ((UART_RSA_BASE) + 0) /* I/O: Mode Select Register */
+
+#define UART_RSA_MSR_SWAP (1 << 0) /* Swap low/high 8 bytes in I/O port addr */
+#define UART_RSA_MSR_FIFO (1 << 2) /* Enable the external FIFO */
+#define UART_RSA_MSR_FLOW (1 << 3) /* Enable the auto RTS/CTS flow control */
+#define UART_RSA_MSR_ITYP (1 << 4) /* Level (1) / Edge triger (0) */
+
+#define UART_RSA_IER ((UART_RSA_BASE) + 1) /* I/O: Interrupt Enable Register */
+
+#define UART_RSA_IER_Rx_FIFO_H (1 << 0) /* Enable Rx FIFO half full int. */
+#define UART_RSA_IER_Tx_FIFO_H (1 << 1) /* Enable Tx FIFO half full int. */
+#define UART_RSA_IER_Tx_FIFO_E (1 << 2) /* Enable Tx FIFO empty int. */
+#define UART_RSA_IER_Rx_TOUT (1 << 3) /* Enable char receive timeout int */
+#define UART_RSA_IER_TIMER (1 << 4) /* Enable timer interrupt */
+
+#define UART_RSA_SRR ((UART_RSA_BASE) + 2) /* IN: Status Read Register */
+
+#define UART_RSA_SRR_Tx_FIFO_NEMP (1 << 0) /* Tx FIFO is not empty (1) */
+#define UART_RSA_SRR_Tx_FIFO_NHFL (1 << 1) /* Tx FIFO is not half full (1) */
+#define UART_RSA_SRR_Tx_FIFO_NFUL (1 << 2) /* Tx FIFO is not full (1) */
+#define UART_RSA_SRR_Rx_FIFO_NEMP (1 << 3) /* Rx FIFO is not empty (1) */
+#define UART_RSA_SRR_Rx_FIFO_NHFL (1 << 4) /* Rx FIFO is not half full (1) */
+#define UART_RSA_SRR_Rx_FIFO_NFUL (1 << 5) /* Rx FIFO is not full (1) */
+#define UART_RSA_SRR_Rx_TOUT (1 << 6) /* Character reception timeout occurred (1) */
+#define UART_RSA_SRR_TIMER (1 << 7) /* Timer interrupt occurred */
+
+#define UART_RSA_FRR ((UART_RSA_BASE) + 2) /* OUT: FIFO Reset Register */
+
+#define UART_RSA_TIVSR ((UART_RSA_BASE) + 3) /* I/O: Timer Interval Value Set Register */
+
+#define UART_RSA_TCR ((UART_RSA_BASE) + 4) /* OUT: Timer Control Register */
+
+#define UART_RSA_TCR_SWITCH (1 << 0) /* Timer on */
+
+/*
+ * The RSA DSV/II board has two fixed clock frequencies.  One is the
+ * standard rate, and the other is 8 times faster.
+ */
+#define SERIAL_RSA_BAUD_BASE (921600)
+#define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
+
+#endif /* _M32R_SIO_REG_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
