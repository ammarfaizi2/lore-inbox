Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWIUJB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWIUJB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWIUJB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:01:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:37006 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751005AbWIUJBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=XmcxKpyodYQFf9vgyTn0A5OJDIV1CfKUcNpUUunlnCcNgZ5/gdHq9iJz8+h+Psbb6hvminAJugGdjpyabpKV0jBAds7M2mnL7SiScfMzmR/VMtzkAoTAWM5WOZR0bnhs6lppXsGDZSoc9DsGpFuyCUGtny/xeiLrVQYYZIDJYyA=
Message-ID: <489ecd0c0609210201i46fd349ep73d50218ed02069@mail.gmail.com>
Date: Thu, 21 Sep 2006 17:01:51 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: "Randy. Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <489ecd0c0609210128l5b59554fk56436f84d22935a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3241_1132425.1158829311727"
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <20060920222837.8b2d2a88.rdunlap@xenotime.net>
	 <6d6a94c50609210020x5bb32474wa61fab5f9581a124@mail.gmail.com>
	 <489ecd0c0609210128l5b59554fk56436f84d22935a5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3241_1132425.1158829311727
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Some more fixes in the serial driver. new patch here.

 drivers/serial/Kconfig      |   44 ++
 drivers/serial/Makefile     |    1
 drivers/serial/bfin_5xx.c   |  906 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    3
 4 files changed, 954 insertions(+)

diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
linux-2.6.18.patch2/drivers/serial/Kconfig
--- linux-2.6.18.patch1/drivers/serial/Kconfig	2006-09-21
09:14:42.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/Kconfig	2006-09-21
16:17:50.000000000 +0800
@@ -488,6 +488,50 @@
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)

+config SERIAL_BFIN
+	tristate "Blackfin serial port support (EXPERIMENTAL)"
+	depends on BFIN && EXPERIMENTAL
+	select SERIAL_CORE
+	help
+	  Add support for the built-in UARTs on the Blackfin.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bfin_5xx.
+
+config SERIAL_BFIN_CONSOLE
+	bool "Console on Blackfin serial port"
+	depends on SERIAL_BFIN
+	select SERIAL_CORE_CONSOLE
+
+choice
+	prompt  "Blackfin UART Mode"
+	depends on SERIAL_BFIN
+	default SERIAL_BFIN_DMA
+	help
+	  This driver supports the built-in serial ports of the Blackfin family
+	  of CPUs
+
+config SERIAL_BFIN_DMA
+	bool "Blackfin UART DMA mode"
+	depends on DMA_UNCACHED_1M
+	help
+	  This driver works under DMA mode. If this option is selected, the
+	  blackfin simple dma driver is also enabled.
+
+config SERIAL_BFIN_PIO
+	bool "Blackfin UART PIO mode"
+	help
+	  This driver works under PIO mode.
+
+endchoice
+
+config SERIAL_BFIN_CTSRTS
+	bool "Enable hardware flow control"
+	depends on SERIAL_BFIN
+	help
+	  Enable hardware flow control in the driver. Using GPIO emulate the CTS/RTS
+	  signal.
+
 config SERIAL_IMX
 	bool "IMX serial port support"
 	depends on ARM && ARCH_IMX
diff -urN linux-2.6.18.patch1/drivers/serial/Makefile
linux-2.6.18.patch2/drivers/serial/Makefile
--- linux-2.6.18.patch1/drivers/serial/Makefile	2006-09-21
09:14:42.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/Makefile	2006-09-21
15:54:13.000000000 +0800
@@ -25,6 +25,7 @@
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
+obj-$(CONFIG_SERIAL_BFIN) += bfin_5xx.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
 obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
 obj-$(CONFIG_SERIAL_SUNHV) += sunhv.o
diff -urN linux-2.6.18.patch1/drivers/serial/bfin_5xx.c
linux-2.6.18.patch2/drivers/serial/bfin_5xx.c
--- linux-2.6.18.patch1/drivers/serial/bfin_5xx.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c	2006-09-21
16:54:46.000000000 +0800
@@ -0,0 +1,906 @@
+/*
+ * File:         drivers/serial/bfin_5xx.c
+ * Based on:     Based on drivers/serial/sa1100.c
+ * Author:       Aubrey Li <aubrey.li@analog.com>
+ *
+ * Created:
+ * Description:  Driver for blackfin 5xx serial ports
+ *
+ * Rev:          $Id: bfin_5xx.c,v 1.12 2006/09/04 04:44:27 aubrey Exp $
+ *
+ * Modified:
+ *               Copyright 2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#if defined(CONFIG_SERIAL_BFIN_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/platform_device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/bfin_serial_5xx.h>
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+#include <linux/dma-mapping.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/cacheflush.h>
+#endif
+
+/* We've been assigned a range on the "Low-density serial ports" major */
+#define SERIAL_BFIN_MAJOR	TTY_MAJOR
+#define MINOR_START		64
+
+#define DEBUG
+
+#ifdef DEBUG
+# define DPRINTK(x...)   printk(KERN_DEBUG x)
+#else
+# define DPRINTK(x...)   do { } while (0)
+#endif
+
+/*
+ * Setup for console. Argument comes from the menuconfig
+ */
+
+#if defined(CONFIG_BAUD_9600)
+#define CONSOLE_BAUD_RATE       9600
+#elif defined(CONFIG_BAUD_19200)
+#define CONSOLE_BAUD_RATE       19200
+#elif defined(CONFIG_BAUD_38400)
+#define CONSOLE_BAUD_RATE       38400
+#elif defined(CONFIG_BAUD_57600)
+#define CONSOLE_BAUD_RATE       57600
+#elif defined(CONFIG_BAUD_115200)
+#define CONSOLE_BAUD_RATE       115200
+#endif
+
+#define DMA_RX_XCOUNT		TTY_FLIPBUF_SIZE
+#define DMA_RX_YCOUNT		(PAGE_SIZE / DMA_RX_XCOUNT)
+
+#define DMA_RX_FLUSH_JIFFIES	5
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+wait_queue_head_t bfin_serial_tx_queue[NR_PORTS];
+static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart);
+#else
+static void bfin_serial_do_work(void *);
+static void bfin_serial_tx_chars(struct bfin_serial_port *uart);
+static void local_put_char(struct bfin_serial_port *uart, char ch);
+#endif
+
+static void bfin_serial_mctrl_check(struct bfin_serial_port *uart);
+
+/*
+ * interrupts disabled on entry
+ */
+static void bfin_serial_stop_tx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	unsigned short ier;
+	ier = UART_GET_IER(uart);
+	ier &= ~ETBEI;
+	UART_PUT_IER(uart, ier);
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	disable_dma(uart->tx_dma_channel);
+#endif
+}
+
+/*
+ * port locked and interrupts disabled
+ */
+static void bfin_serial_start_tx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	bfin_serial_dma_tx_chars(uart);
+#else
+	unsigned short ier;
+	ier = UART_GET_IER(uart);
+	ier |= ETBEI;
+	UART_PUT_IER(uart, ier);
+	bfin_serial_tx_chars(uart);
+#endif
+}
+
+/*
+ * Interrupts enabled
+ */
+static void bfin_serial_stop_rx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	unsigned short ier;
+	ier = UART_GET_IER(uart);
+	ier &= ERBFI;
+	UART_PUT_IER(uart, ier);
+}
+
+/*
+ * Set the modem control timer to fire immediately.
+ */
+static void bfin_serial_enable_ms(struct uart_port *port)
+{
+}
+
+#ifdef CONFIG_SERIAL_BFIN_PIO
+static void local_put_char(struct bfin_serial_port *uart, char ch)
+{
+        unsigned short status;
+        int flags = 0;
+
+        local_irq_save(flags);
+
+        do {
+                status = UART_GET_LSR(uart);
+        } while (!(status & THRE));
+
+        UART_PUT_CHAR(uart, ch);
+        local_irq_restore(flags);
+}
+
+static void
+bfin_serial_rx_chars(struct bfin_serial_port *uart, struct pt_regs *regs)
+{
+	struct tty_struct *tty = uart->port.info->tty;
+	unsigned int status=0, ch, flg;
+	ch = UART_GET_CHAR(uart);
+	uart->port.icount.rx++;
+	flg = TTY_NORMAL;
+	if (uart_handle_sysrq_char(&uart->port, ch, regs))
+		goto ignore_char;
+	uart_insert_char(&uart->port, status, 1, ch, flg);
+
+ignore_char:
+	tty_flip_buffer_push(tty);
+}
+
+static void bfin_serial_tx_chars(struct bfin_serial_port *uart)
+{
+	struct circ_buf *xmit = &uart->port.info->xmit;
+
+	if (uart->port.x_char) {
+		UART_PUT_CHAR(uart, uart->port.x_char);
+		uart->port.icount.tx++;
+		uart->port.x_char = 0;
+		return;
+	}
+	/*
+	 * Check the modem control lines before
+	 * transmitting anything.
+	 */
+	bfin_serial_mctrl_check(uart);
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
+		bfin_serial_stop_tx(&uart->port);
+		return;
+	}
+
+	local_put_char(uart, xmit->buf[xmit->tail]);
+	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+	uart->port.icount.tx++;
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&uart->port);
+
+	if (uart_circ_empty(xmit))
+		bfin_serial_stop_tx(&uart->port);
+}
+
+static irqreturn_t bfin_serial_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct bfin_serial_port *uart = dev_id;
+	unsigned short status;
+
+	spin_lock(&uart->port.lock);
+	status = UART_GET_IIR(uart);
+	do {
+		if ((status & IIR_STATUS) == IIR_TX_READY)
+			bfin_serial_tx_chars(uart);
+		if ((status & IIR_STATUS) == IIR_RX_READY)
+			bfin_serial_rx_chars(uart, regs);
+		status = UART_GET_IIR(uart);
+	} while (status &(IIR_TX_READY | IIR_RX_READY));
+	spin_unlock(&uart->port.lock);
+	return IRQ_HANDLED;
+}
+
+static void bfin_serial_do_work(void *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	bfin_serial_mctrl_check(uart);
+}
+
+#endif
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart)
+{
+	struct circ_buf *xmit = &uart->port.info->xmit;
+	unsigned short ier;
+	int flags = 0;
+
+	if (!uart->tx_done)
+		return;
+
+	uart->tx_done = 0;
+
+	if (uart->port.x_char) {
+		UART_PUT_CHAR(uart, uart->port.x_char);
+		uart->port.icount.tx++;
+		uart->port.x_char = 0;
+		uart->tx_done = 1;
+		return;
+	}
+	/*
+	 * Check the modem control lines before
+	 * transmitting anything.
+	 */
+	bfin_serial_mctrl_check(uart);
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
+		bfin_serial_stop_tx(&uart->port);
+		uart->tx_done = 1;
+		return;
+	}
+
+	local_irq_save(flags);
+	uart->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	if (uart->tx_count > (UART_XMIT_SIZE - xmit->tail))
+	uart->tx_count = UART_XMIT_SIZE - xmit->tail;
+	blackfin_dcache_flush_range((unsigned long)(xmit->buf+xmit->tail),
+					(unsigned long)(xmit->buf+xmit->tail+uart->tx_count));
+	set_dma_config(uart->tx_dma_channel,
+		set_bfin_dma_config(DIR_READ, DMA_FLOW_STOP,
+			INTR_ON_BUF,
+			DIMENSION_LINEAR,
+			DATA_SIZE_8));
+	set_dma_start_addr(uart->tx_dma_channel, (unsigned
long)(xmit->buf+xmit->tail));
+	set_dma_x_count(uart->tx_dma_channel, uart->tx_count);
+	set_dma_x_modify(uart->tx_dma_channel, 1);
+	enable_dma(uart->tx_dma_channel);
+	ier = UART_GET_IER(uart);
+	ier |= ETBEI;
+	UART_PUT_IER(uart, ier);
+	local_irq_restore(flags);
+}
+
+static void bfin_serial_dma_rx_chars(struct bfin_serial_port * uart)
+{
+	struct tty_struct *tty = uart->port.info->tty;
+	int i, flg, status = 0;
+
+	uart->port.icount.rx += CIRC_CNT(uart->rx_dma_buf.head,
uart->rx_dma_buf.tail, UART_XMIT_SIZE);;
+	flg = TTY_NORMAL;
+	for (i = uart->rx_dma_buf.head; i < uart->rx_dma_buf.tail; i++) {
+		if (uart_handle_sysrq_char(&uart->port, uart->rx_dma_buf.buf[i], NULL))
+			goto dma_ignore_char;
+		uart_insert_char(&uart->port, status, 1, uart->rx_dma_buf.buf[i], flg);
+	}
+dma_ignore_char:
+	tty_flip_buffer_push(tty);
+}
+
+void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
+{
+	int x_pos, pos;
+	int flags = 0;
+
+	bfin_serial_dma_tx_chars(uart);
+
+	local_irq_save(flags);
+	x_pos = DMA_RX_XCOUNT - get_dma_curr_xcount(uart->rx_dma_channel);
+	if (x_pos == DMA_RX_XCOUNT)
+		x_pos = 0;
+
+	pos = uart->rx_dma_nrows * DMA_RX_XCOUNT + x_pos;
+
+	if (pos>uart->rx_dma_buf.tail) {
+		uart->rx_dma_buf.tail = pos;
+		bfin_serial_dma_rx_chars(uart);
+		uart->rx_dma_buf.head = uart->rx_dma_buf.tail;
+	}
+	local_irq_restore(flags);
+	uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
+	add_timer(&(uart->rx_dma_timer));
+}
+
+static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id,
struct pt_regs *regs)
+{
+	struct bfin_serial_port *uart = dev_id;
+	struct circ_buf *xmit = &uart->port.info->xmit;
+	unsigned short ier;
+
+	spin_lock(&uart->port.lock);
+	if (!(get_dma_curr_irqstat(uart->tx_dma_channel)&DMA_RUN)) {
+		clear_dma_irqstat(uart->tx_dma_channel);
+		disable_dma(uart->tx_dma_channel);
+		ier = UART_GET_IER(uart);
+		ier &= ~ETBEI;
+		UART_PUT_IER(uart, ier);
+		xmit->tail = (xmit->tail+uart->tx_count) &(UART_XMIT_SIZE -1);
+		uart->port.icount.tx+=uart->tx_count;
+
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(&uart->port);
+
+		if (uart_circ_empty(xmit))
+			bfin_serial_stop_tx(&uart->port);
+		uart->tx_done = 1;
+	}
+
+	spin_unlock(&uart->port.lock);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id,
struct pt_regs *regs)
+{
+	struct bfin_serial_port *uart = dev_id;
+	unsigned short irqstat;
+
+	uart->rx_dma_nrows++;
+	if (uart->rx_dma_nrows == DMA_RX_YCOUNT) {
+		uart->rx_dma_nrows = 0;
+		uart->rx_dma_buf.tail = DMA_RX_XCOUNT*DMA_RX_YCOUNT;
+		bfin_serial_dma_rx_chars(uart);
+		uart->rx_dma_buf.head = uart->rx_dma_buf.tail = 0;
+	}
+	spin_lock(&uart->port.lock);
+	irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
+	clear_dma_irqstat(uart->rx_dma_channel);
+
+	spin_unlock(&uart->port.lock);
+	return IRQ_HANDLED;
+}
+#endif
+
+/*
+ * Return TIOCSER_TEMT when transmitter is not busy.
+ */
+static unsigned int bfin_serial_tx_empty(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	unsigned short lsr;
+	lsr = UART_GET_LSR(uart);
+	if (lsr & THRE)
+		return TIOCSER_TEMT;
+	else
+		return 0;
+}
+
+static unsigned int bfin_serial_get_mctrl(struct uart_port *port)
+{
+	/* Hardware flow control is only supported on the first port */
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+	if ((bfin_read16(CTS_PORT) & (1 << CTS_PIN)) && (port->line == 0))
+		return TIOCM_DSR | TIOCM_CAR;
+	else
+#endif
+		return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void bfin_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+	if (mctrl & TIOCM_RTS)
+		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT) & (~1 << RTS_PIN));
+	else
+		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT) | (1 << RTS_PIN));
+#endif
+}
+
+/*
+ * Handle any change of modem status signal since we were last called.
+ */
+static void bfin_serial_mctrl_check(struct bfin_serial_port *uart)
+{
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+	unsigned int status;
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	struct uart_info *info = uart->port.info;
+	struct tty_struct *tty = info->tty;
+	status = bfin_serial_get_mctrl(&uart->port);
+	if (!(status & TIOCM_CTS)) {
+		tty->hw_stopped = 1;
+	} else {
+		tty->hw_stopped = 0;
+	}
+#else
+	status = bfin_serial_get_mctrl(&uart->port);
+	uart_handle_cts_change(&uart->port, status & TIOCM_CTS);
+	if (!(status & TIOCM_CTS))
+		schedule_work(&uart->cts_workqueue);
+#endif
+#endif
+}
+
+/*
+ * Interrupts always disabled.
+ */
+static void bfin_serial_break_ctl(struct uart_port *port, int break_state)
+{
+}
+
+int bfin_serial_startup(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	dma_addr_t dma_handle;
+
+	if (request_dma(uart->rx_dma_channel, "BFIN_UART_RX") < 0) {
+		printk(KERN_NOTICE "Unable to attach Blackfin UART RX DMA channel\n");
+		return -EBUSY;
+	}
+
+	if (request_dma(uart->tx_dma_channel, "BFIN_UART_TX") < 0) {
+		printk(KERN_NOTICE "Unable to attach Blackfin UART TX DMA channel\n");
+		free_dma(uart->rx_dma_channel);
+		return -EBUSY;
+	}
+
+	set_dma_callback(uart->rx_dma_channel, bfin_serial_dma_rx_int, uart);
+	set_dma_callback(uart->tx_dma_channel, bfin_serial_dma_tx_int, uart);
+
+	uart->rx_dma_buf.buf = (unsigned char *)dma_alloc_coherent(NULL,
PAGE_SIZE, &dma_handle, GFP_DMA);
+	uart->rx_dma_buf.head = 0;
+	uart->rx_dma_buf.tail = 0;
+	uart->rx_dma_nrows = 0;
+
+	set_dma_config(uart->rx_dma_channel,
+		set_bfin_dma_config(DIR_WRITE, DMA_FLOW_AUTO,
+				INTR_ON_ROW, DIMENSION_2D,
+				DATA_SIZE_8));
+	set_dma_x_count(uart->rx_dma_channel, DMA_RX_XCOUNT);
+	set_dma_x_modify(uart->rx_dma_channel, 1);
+	set_dma_y_count(uart->rx_dma_channel, DMA_RX_YCOUNT);
+	set_dma_y_modify(uart->rx_dma_channel, 1);
+	set_dma_start_addr(uart->rx_dma_channel, (unsigned long)uart->rx_dma_buf.buf);
+	enable_dma(uart->rx_dma_channel);
+
+	uart->rx_dma_timer.data = (unsigned long)(uart);
+	uart->rx_dma_timer.function = (void *)bfin_serial_rx_dma_timeout;
+	uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
+	add_timer(&(uart->rx_dma_timer));
+#else
+	if (request_irq
+	    (uart->port.irq, bfin_serial_int, IRQF_DISABLED | IRQF_SHARED,
+	     "BFIN_UART0_RX", uart)) {
+		printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
+		return -EBUSY;
+	}
+
+	if (request_irq
+	    (uart->port.irq+1, bfin_serial_int, IRQF_DISABLED | IRQF_SHARED,
+	     "BFIN_UART0_TX", uart)) {
+		printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");
+		free_irq(uart->port.irq, uart);
+		return -EBUSY;
+	}
+#endif
+	UART_PUT_IER(uart, UART_GET_IER(uart) | ERBFI);
+	return 0;
+}
+
+static void bfin_serial_shutdown(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	disable_dma(uart->tx_dma_channel);
+	free_dma(uart->tx_dma_channel);
+	disable_dma(uart->rx_dma_channel);
+	free_dma(uart->rx_dma_channel);
+	del_timer(&(uart->rx_dma_timer));
+#else
+	free_irq(uart->port.irq, uart);
+	free_irq(uart->port.irq+1, uart);
+#endif
+}
+
+static void
+bfin_serial_set_termios(struct uart_port *port, struct termios *termios,
+		   struct termios *old)
+{
+}
+
+static const char *bfin_serial_type(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	return uart->port.type == PORT_BFIN ? "BFIN-UART" : NULL;
+}
+
+/*
+ * Release the memory region(s) being used by 'port'.
+ */
+static void bfin_serial_release_port(struct uart_port *port)
+{
+}
+
+/*
+ * Request the memory region(s) being used by 'port'.
+ */
+static int bfin_serial_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+/*
+ * Configure/autoconfigure the port.
+ */
+static void bfin_serial_config_port(struct uart_port *port, int flags)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+
+	if (flags & UART_CONFIG_TYPE &&
+	    bfin_serial_request_port(&uart->port) == 0)
+		uart->port.type = PORT_BFIN;
+}
+
+/*
+ * Verify the new serial_struct (for TIOCSSERIAL).
+ * The only change we allow are to the flags and type, and
+ * even then only between PORT_BFIN and PORT_UNKNOWN
+ */
+static int
+bfin_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	return 0;
+}
+
+static struct uart_ops bfin_serial_pops = {
+	.tx_empty	= bfin_serial_tx_empty,
+	.set_mctrl	= bfin_serial_set_mctrl,
+	.get_mctrl	= bfin_serial_get_mctrl,
+	.stop_tx	= bfin_serial_stop_tx,
+	.start_tx	= bfin_serial_start_tx,
+	.stop_rx	= bfin_serial_stop_rx,
+	.enable_ms	= bfin_serial_enable_ms,
+	.break_ctl	= bfin_serial_break_ctl,
+	.startup	= bfin_serial_startup,
+	.shutdown	= bfin_serial_shutdown,
+	.set_termios	= bfin_serial_set_termios,
+	.type		= bfin_serial_type,
+	.release_port	= bfin_serial_release_port,
+	.request_port	= bfin_serial_request_port,
+	.config_port	= bfin_serial_config_port,
+	.verify_port	= bfin_serial_verify_port,
+};
+
+static int bfin_serial_calc_baud(unsigned int uartclk)
+{
+	int baud;
+	baud = get_sclk() / (uartclk*8);
+	if ((baud & 0x1) == 1) {
+		baud++;
+	}
+	return baud/2;
+}
+
+static void __init bfin_serial_init_ports(void)
+{
+	static int first = 1;
+	int i;
+	unsigned short val;
+	int baud;
+
+	if (!first)
+		return;
+	first = 0;
+	bfin_serial_hw_init();
+
+	for (i = 0; i < NR_PORTS; i++) {
+		bfin_serial_ports[i].port.uartclk   = CONSOLE_BAUD_RATE;
+		bfin_serial_ports[i].port.ops       = &bfin_serial_pops;
+		bfin_serial_ports[i].port.line      = i;
+		bfin_serial_ports[i].port.iotype    = UPIO_MEM;
+		bfin_serial_ports[i].port.membase   = (void __iomem *)uart_base_addr[i];
+		bfin_serial_ports[i].port.mapbase   = uart_base_addr[i];
+		bfin_serial_ports[i].port.irq       = uart_irq[i];
+		bfin_serial_ports[i].port.flags     = UPF_BOOT_AUTOCONF;
+#ifdef CONFIG_SERIAL_BFIN_DMA
+		bfin_serial_ports[i].tx_done	    = 1;
+		bfin_serial_ports[i].tx_count	    = 0;
+		bfin_serial_ports[i].tx_dma_channel = uart_tx_dma_channel[i];
+		bfin_serial_ports[i].rx_dma_channel = uart_rx_dma_channel[i];
+
+		init_timer(&(bfin_serial_ports[i].rx_dma_timer));
+#else
+		INIT_WORK(&bfin_serial_ports[i].cts_workqueue, bfin_serial_do_work,
&bfin_serial_ports[i]);
+#endif
+
+		baud = bfin_serial_calc_baud(bfin_serial_ports[i].port.uartclk);
+
+		/* Enable UART */
+		val = UART_GET_GCTL(&bfin_serial_ports[i]);
+		val |= UCEN;
+		UART_PUT_GCTL(&bfin_serial_ports[i], val);
+
+		/* Set DLAB in LCR to Access DLL and DLH */
+		val = UART_GET_LCR(&bfin_serial_ports[i]);
+		val |= DLAB;
+		UART_PUT_LCR(&bfin_serial_ports[i], val);
+
+		UART_PUT_DLL(&bfin_serial_ports[i], baud & 0xFF);
+		UART_PUT_DLH(&bfin_serial_ports[i], (baud >> 8) & 0xFF);
+
+		/* Clear DLAB in LCR to Access THR RBR IER */
+		val = UART_GET_LCR(&bfin_serial_ports[i]);
+		val &= ~DLAB;
+		UART_PUT_LCR(&bfin_serial_ports[i], val);
+
+		/* Set LCR to Word Lengh 8-bit word select */
+		val = WLS(8);
+		UART_PUT_LCR(&bfin_serial_ports[i], val);
+	}
+}
+
+#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+/*
+ * Interrupts are disabled on entering
+ */
+static void
+bfin_serial_console_write(struct console *co, const char *s, unsigned
int count)
+{
+	struct bfin_serial_port *uart = &bfin_serial_ports[co->index];
+	int flags = 0;
+	unsigned short status, tmp;
+	int i;
+
+	local_irq_save(flags);
+
+	for (i = 0; i < count; i++) {
+		do {
+			status = UART_GET_LSR(uart);
+		} while (!(status & THRE));
+
+		tmp = UART_GET_LCR(uart);
+		tmp &= ~DLAB;
+		UART_PUT_LCR(uart, tmp);
+
+		UART_PUT_CHAR(uart, s[i]);
+		if (s[i] == '\n') {
+			do {
+				status = UART_GET_LSR(uart);
+			} while(!(status & THRE));
+			UART_PUT_CHAR(uart, '\r');
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
+/*
+ * If the port was already initialised (eg, by a boot loader),
+ * try to determine the current setup.
+ */
+static void __init
+bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
+			   int *parity, int *bits)
+{
+	unsigned short status;
+
+	status = UART_GET_IER(uart) & (ERBFI | ETBEI);
+	if (status == (ERBFI | ETBEI)) {
+		/* ok, the port was enabled */
+		unsigned short lcr, val;
+		unsigned short dlh, dll;
+
+		lcr = UART_GET_LCR(uart);
+
+		*parity = 'n';
+		if (lcr & PEN) {
+			if (lcr & EPS)
+				*parity = 'e';
+			else
+				*parity = 'o';
+		}
+		switch (lcr & 0x03) {
+			case 0:	*bits = 5; break;
+			case 1:	*bits = 6; break;
+			case 2:	*bits = 7; break;
+			case 3:	*bits = 8; break;
+		}
+		/* Set DLAB in LCR to Access DLL and DLH */
+		val = UART_GET_LCR(uart);
+		val |= DLAB;
+		UART_PUT_LCR(uart, val);
+
+		dll = UART_GET_DLL(uart);
+		dlh = UART_GET_DLH(uart);
+
+		/* Clear DLAB in LCR to Access THR RBR IER */
+		val = UART_GET_LCR(uart);
+		val &= ~DLAB;
+		UART_PUT_LCR(uart, val);
+
+		*baud = get_sclk() / (16*(dll | dlh << 8));
+	}
+	DPRINTK("%s:baud = %d, parity = %c, bits= %d\n", __FUNCTION__,
*baud, *parity, *bits);
+}
+
+static int __init
+bfin_serial_console_setup(struct console *co, char *options)
+{
+	struct bfin_serial_port *uart;
+	int baud = CONSOLE_BAUD_RATE;
+	int bits = 8;
+	int parity = 'n';
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+	int flow = 'r';
+#else
+	int flow = 'n';
+#endif
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index == -1 || co->index >= NR_PORTS)
+		co->index = 0;
+	uart = &bfin_serial_ports[co->index];
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		bfin_serial_console_get_options(uart, &baud, &parity, &bits);
+
+	return uart_set_options(&uart->port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver bfin_serial_reg;
+static struct console bfin_serial_console = {
+	.name		= "ttyS",
+	.write		= bfin_serial_console_write,
+	.device		= uart_console_device,
+	.setup		= bfin_serial_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &bfin_serial_reg,
+};
+
+static int __init bfin_serial_rs_console_init(void)
+{
+	bfin_serial_init_ports();
+	register_console(&bfin_serial_console);
+	return 0;
+}
+console_initcall(bfin_serial_rs_console_init);
+
+#define BFIN_SERIAL_CONSOLE	&bfin_serial_console
+#else
+#define BFIN_SERIAL_CONSOLE	NULL
+#endif
+
+static struct uart_driver bfin_serial_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "bfin-uart",
+	.dev_name		= "ttyS",
+	.devfs_name		= "ttyS/",
+	.major			= SERIAL_BFIN_MAJOR,
+	.minor			= MINOR_START,
+	.nr			= NR_PORTS,
+	.cons			= BFIN_SERIAL_CONSOLE,
+};
+
+static int bfin_serial_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct bfin_serial_port *uart = platform_get_drvdata(dev);
+
+	if (uart)
+		uart_suspend_port(&bfin_serial_reg, &uart->port);
+
+	return 0;
+}
+
+static int bfin_serial_resume(struct platform_device *dev)
+{
+	struct bfin_serial_port *uart = platform_get_drvdata(dev);
+
+	if (uart)
+		uart_resume_port(&bfin_serial_reg, &uart->port);
+
+	return 0;
+}
+
+static int bfin_serial_probe(struct platform_device *dev)
+{
+	struct resource *res = dev->resource;
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++, res++)
+		if (res->flags & IORESOURCE_MEM)
+			break;
+
+	if (i < dev->num_resources) {
+		for (i = 0; i < NR_PORTS; i++, res++) {
+			if (bfin_serial_ports[i].port.mapbase != res->start)
+				continue;
+			bfin_serial_ports[i].port.dev = &dev->dev;
+			uart_add_one_port(&bfin_serial_reg, &bfin_serial_ports[i].port);
+			platform_set_drvdata(dev, &bfin_serial_ports[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int bfin_serial_remove(struct platform_device *pdev)
+{
+	struct bfin_serial_port *uart = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (uart)
+		uart_remove_one_port(&bfin_serial_reg, &uart->port);
+
+	return 0;
+}
+
+static struct platform_driver bfin_serial_driver = {
+	.probe		= bfin_serial_probe,
+	.remove		= bfin_serial_remove,
+	.suspend	= bfin_serial_suspend,
+	.resume		= bfin_serial_resume,
+	.driver		= {
+		.name	= "bfin-uart",
+	},
+};
+
+static int __init bfin_serial_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Serial: Blackfin serial driver\n");
+
+	bfin_serial_init_ports();
+
+	ret = uart_register_driver(&bfin_serial_reg);
+	if (ret == 0) {
+		ret = platform_driver_register(&bfin_serial_driver);
+		if (ret) {
+			DPRINTK("uart register failed\n");
+			uart_unregister_driver(&bfin_serial_reg);
+		}
+	}
+	return ret;
+}
+
+static void __exit bfin_serial_exit(void)
+{
+	platform_driver_unregister(&bfin_serial_driver);
+	uart_unregister_driver(&bfin_serial_reg);
+}
+
+module_init(bfin_serial_init);
+module_exit(bfin_serial_exit);
+
+MODULE_AUTHOR("Aubrey.Li <aubrey.li@analog.com>");
+MODULE_DESCRIPTION("Blackfin generic serial port driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_BFIN_MAJOR);
diff -urN linux-2.6.18.patch1/include/linux/serial_core.h
linux-2.6.18.patch2/include/linux/serial_core.h
--- linux-2.6.18.patch1/include/linux/serial_core.h	2006-09-21
09:14:54.000000000 +0800
+++ linux-2.6.18.patch2/include/linux/serial_core.h	2006-09-21
09:38:17.000000000 +0800
@@ -132,6 +132,9 @@

 #define PORT_S3C2412	73

+/* Blackfin bf5xx */
+#define PORT_BFIN	74
+

 #ifdef __KERNEL__



> On 9/21/06, Aubrey <aubreylee@gmail.com> wrote:
> > On 9/21/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > On Thu, 21 Sep 2006 11:33:05 +0800 Luke Yang wrote:
> > >
> > > > This is the serial driver for Blackfin. It is designed for the serial
> > > > core framework.
> > > >
> > > > As to other drivers, I'll send them one by one later.
> > > >
> > > > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> > > >
> > > >  drivers/serial/Kconfig      |   35 +
> > > >  drivers/serial/Makefile     |    3
> > > >  drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/serial_core.h |    3
> > > >  4 files changed, 943 insertions(+), 1 deletion(-)
> > > >
> > > > diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
> > > > linux-2.6.18.patch2/drivers/serial/Kconfig
> > > > --- linux-2.6.18.patch1/drivers/serial/Kconfig        2006-09-21
> > > > 09:14:42.000000000 +0800
> > > > +++ linux-2.6.18.patch2/drivers/serial/Kconfig        2006-09-21
> > > > 09:38:17.000000000 +0800
> > > > @@ -488,6 +488,41 @@
> > > >         your boot loader (lilo or loadlin) about how to pass options to the
> > > >         kernel at boot time.)
> > > >
> > > > +config SERIAL_BFIN
> > > > +     bool "Blackfin serial port support (EXPERIMENTAL)"
> > > > +     depends on BFIN && EXPERIMENTAL
> > > > +     select SERIAL_CORE
> > >
> > > Just curious:  why bool and not tristate?  (i.e., why is loadable
> > > module not allowed?)
> >
> > Thanks to point it out, this will be changed in the new patch.
> >
> > >
> > > > +config SERIAL_BFIN_CONSOLE
> > > > +     bool "Console on Blackfin serial port"
> > > > +     depends on SERIAL_BFIN
> > > > +     select SERIAL_CORE_CONSOLE
> > > > +
> > > > +choice
> > > > +        prompt  "Blackfin UART Mode"
> > > > +        depends on SERIAL_BFIN
> > > > +        default SERIAL_BFIN_DMA
> > > > +        ---help---
> > > > +          This driver supports the built-in serial ports of the
> > > > Blackfin family of CPUs
> > > > +
> > > > +config SERIAL_BFIN_DMA
> > > > +        bool "Blackfin UART DMA mode"
> > > > +        depends on DMA_UNCACHED_1M
> > > > +        help
> > > > +          This driver works under DMA mode. If this option is
> > > > selected, the blackfin simple dma driver is also enabled.
> > >
> > > Please break that long line at < 80 columns (so that left-right
> > > scrolling is not required to read it in menuconfig).
> >
> > It will be corrected in the new patch.
> >
> > >
> > > > +config SERIAL_BFIN_PIO
> > > > +        bool "Blackfin UART PIO mode"
> > > > +        help
> > > > +          This driver works under PIO mode.
> > > > +endchoice
> > > > +
> > > > +config SERIAL_BFIN_CTSRTS
> > > > +     bool "Enable hardware flow control"
> > > > +     depends on SERIAL_BFIN
> > > > +     help
> > > > +       Enable hardware flow control in the driver. Using GPIO emulate the
> > > > CTS/RTS signal.
> > >
> > > Split the long help text into 2 lines.
> > >
> > > >  config SERIAL_IMX
> > > >       bool "IMX serial port support"
> > > >       depends on ARM && ARCH_IMX
> > >
> > > > diff -urN linux-2.6.18.patch1/drivers/serial/Makefile
> > > > linux-2.6.18.patch2/drivers/serial/Makefile
> > > > --- linux-2.6.18.patch1/drivers/serial/Makefile       2006-09-21
> > > > 09:14:42.000000000 +0800
> > > > +++ linux-2.6.18.patch2/drivers/serial/Makefile       2006-09-21
> > > > 09:38:17.000000000 +0800
> > > > @@ -55,4 +56,4 @@
> > > >  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
> > > >  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
> > > >  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> > > > -obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> > > > +obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> > > > \ No newline at end of file
> > >
> > > What is the purpose of the change above?
> >
> > This shouldn't be changed, should be excluded in the patch.
> > >
> > > > diff -urN linux-2.6.18.patch1/drivers/serial/bfin_5xx.c
> > > > linux-2.6.18.patch2/drivers/serial/bfin_5xx.c
> > > > --- linux-2.6.18.patch1/drivers/serial/bfin_5xx.c     1970-01-01
> > > > 08:00:00.000000000 +0800
> > > > +++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c     2006-09-21
> > > > 09:38:17.000000000 +0800
> > > > @@ -0,0 +1,903 @@
> > > > +
> > > > +#include <linux/config.h>
> > >
> > > Don't include the config.h header file.  That's done automatically
> > > by the build system.
> >
> > The driver is based on the current serial driver sa1100.c. But yes,
> > I'll remove it in the new patch.
> >
> > >
> > > > +static irqreturn_t bfin_serial_int(int irq, void *dev_id, struct pt_regs *regs)
> > > > +{
> > > > +     struct bfin_serial_port *uart = dev_id;
> > > > +     unsigned short status;
> > > > +
> > > > +     spin_lock(&uart->port.lock);
> > > > +     status = UART_GET_IIR(uart);
> > > > +     do {
> > > > +             if ((status & IIR_STATUS) == IIR_TX_READY)
> > > > +                     bfin_serial_tx_chars(uart);
> > > > +             if ((status & IIR_STATUS) == IIR_RX_READY)
> > > > +                     bfin_serial_rx_chars(uart, regs);
> > > > +             status = UART_GET_IIR(uart);
> > > > +     } while (status &(IIR_TX_READY | IIR_RX_READY));
> > > > +     spin_unlock(&uart->port.lock);
> > > > +     return IRQ_HANDLED;
> > >
> > > So, the interrupt is requested as Shared, but then the int. handler
> > > code (above here) does not check to see if the interrupt was
> > > for this device.  Shouldn't it do that and then return IRQ_NONE
> > > if it wasn't for this device?
> > >
> >
> > IMHO, I don't think it's necessary. Because it's not possble that the
> > interrupt occurs from a device and the handler is called by another
> > one.
> >
> > > > +}
> > > > +     bfin_serial_mctrl_check(uart);
> > > > +}
> > > > +
> > > > +#endif
> > > > +
> > > > +#ifdef CONFIG_SERIAL_BFIN_DMA
> > > > +static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart)
> > > > +{
> > > > +     struct circ_buf *xmit = &uart->port.info->xmit;
> > > > +     unsigned short ier;
> > > > +     int flags = 0;
> > > > +
> > > > +     if (!uart->tx_done)
> > > > +             return;
> > > > +
> > > > +     uart->tx_done = 0;
> > > > +
> > > > +     if (uart->port.x_char) {
> > > > +             UART_PUT_CHAR(uart, uart->port.x_char);
> > > > +             uart->port.icount.tx++;
> > > > +             uart->port.x_char = 0;
> > > > +             uart->tx_done = 1;
> > > > +             return;
> > > > +     }
> > > > +     /*
> > > > +      * Check the modem control lines before
> > > > +      * transmitting anything.
> > > > +      */
> > > > +     bfin_serial_mctrl_check(uart);
> > > > +
> > > > +     if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
> > > > +             bfin_serial_stop_tx(&uart->port);
> > > > +             uart->tx_done = 1;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     local_irq_save(flags);
> > > > +     uart->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> > > > +     if (uart->tx_count > (UART_XMIT_SIZE - xmit->tail))
> > > > +     uart->tx_count = UART_XMIT_SIZE - xmit->tail;
> > >
> > > odd indentation above.
> >
> > Please comments the attachment on all coding style issues
> >
> > >
> > > > +     blackfin_dcache_flush_range((unsigned long)(xmit->buf+xmit->tail),
> > > > +                                     (unsigned long)(xmit->buf+xmit->tail+uart->tx_count));
> > > > +     set_dma_config(uart->tx_dma_channel,
> > > > +             set_bfin_dma_config(DIR_READ, DMA_FLOW_STOP,
> > > > +                     INTR_ON_BUF,
> > > > +                     DIMENSION_LINEAR,
> > > > +                     DATA_SIZE_8));
> > > > +     set_dma_start_addr(uart->tx_dma_channel, (unsigned
> > > > long)(xmit->buf+xmit->tail));
> > > > +     set_dma_x_count(uart->tx_dma_channel, uart->tx_count);
> > > > +     set_dma_x_modify(uart->tx_dma_channel, 1);
> > > > +     enable_dma(uart->tx_dma_channel);
> > > > +     ier = UART_GET_IER(uart);
> > > > +     ier |= ETBEI;
> > > > +     UART_PUT_IER(uart, ier);
> > > > +     local_irq_restore(flags);
> > > > +}
> > > > +
> > >
> > > > +static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id,
> > > > struct pt_regs *regs)
> > >
> > > "struct" line above is a separate line but does not have a
> > > beginning '+' mark, so the patch is malformed/corrupted.
> > > This happened in a few other places also, so something is
> > > breaking/splitting lines badly for us.  :(
> > >
> > > > +{
> > > > +     struct bfin_serial_port *uart = dev_id;
> > > > +     struct circ_buf *xmit = &uart->port.info->xmit;
> > > > +     unsigned short ier;
> > > > +
> > > > +     spin_lock(&uart->port.lock);
> > > > +     if (!(get_dma_curr_irqstat(uart->tx_dma_channel)&DMA_RUN)) {
> > > > +             clear_dma_irqstat(uart->tx_dma_channel);
> > > > +             disable_dma(uart->tx_dma_channel);
> > > > +             ier = UART_GET_IER(uart);
> > > > +             ier &= ~ETBEI;
> > > > +             UART_PUT_IER(uart, ier);
> > > > +             xmit->tail = (xmit->tail+uart->tx_count) &(UART_XMIT_SIZE -1);
> > > > +             uart->port.icount.tx+=uart->tx_count;
> > > > +
> > > > +             if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > > > +                     uart_write_wakeup(&uart->port);
> > > > +
> > > > +             if (uart_circ_empty(xmit))
> > > > +                     bfin_serial_stop_tx(&uart->port);
> > > > +             uart->tx_done = 1;
> > > > +     }
> > > > +
> > > > +     spin_unlock(&uart->port.lock);
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id,
> > > > struct pt_regs *regs)
> > > > +{
> > > > +     struct bfin_serial_port *uart = dev_id;
> > > > +     unsigned short irqstat;
> > > > +
> > > > +     uart->rx_dma_nrows++;
> > > > +     if (uart->rx_dma_nrows == DMA_RX_YCOUNT) {
> > > > +             uart->rx_dma_nrows = 0;
> > > > +             uart->rx_dma_buf.tail = DMA_RX_XCOUNT*DMA_RX_YCOUNT;
> > > > +             bfin_serial_dma_rx_chars(uart);
> > > > +             uart->rx_dma_buf.head = uart->rx_dma_buf.tail = 0;
> > > > +     }
> > > > +     spin_lock(&uart->port.lock);
> > > > +     irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
> > > > +     clear_dma_irqstat(uart->rx_dma_channel);
> > > > +
> > > > +     spin_unlock(&uart->port.lock);
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +#endif
> > >
> > > > +static unsigned int bfin_serial_get_mctrl(struct uart_port *port)
> > > > +{
> > > > +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> > > > +     if (bfin_read16(CTS_PORT) & (1<<CTS_PIN))
> > > > +             return TIOCM_DSR | TIOCM_CAR;
> > > > +     else
> > > > +#endif
> > > > +             return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > >
> > > Hardcoded return value, without reading a port, right?
> >
> > Right. It will be corrected in the new patch.
> >
> > >
> > > > +}
> > > > +
> > > > +static void bfin_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > > > +{
> > > > +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> > > > +     if (mctrl & TIOCM_RTS)
> > > > +             bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)&(~1<<RTS_PIN));
> > > > +     else
> > > > +             bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)|(1<<RTS_PIN));
> > > > +#endif
> > > > +}
> > >
> > > > +int bfin_serial_startup(struct uart_port *port)
> > > > +{
> > > > +     struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> > > > +
> > > > +#ifdef CONFIG_SERIAL_BFIN_DMA
> > > > +     dma_addr_t dma_handle;
> > > > +
> > > > +     if (request_dma(uart->rx_dma_channel, "BFIN_UART_RX") < 0) {
> > > > +             printk(KERN_NOTICE "Unable to attach Blackfin UART RX DMA channel\n");
> > > > +             return -EBUSY;
> > > > +     } else
> > > > +             set_dma_callback(uart->rx_dma_channel, bfin_serial_dma_rx_int, uart);
> > > > +
> > > > +     if (request_dma(uart->tx_dma_channel, "BFIN_UART_TX") < 0) {
> > > > +             printk(KERN_NOTICE "Unable to attach Blackfin UART TX DMA channel\n");
> > >
> > > Before returning, this failure path needs to free_dma() for the
> > > first request_dma() that succeeded.
> > > I would also suggest doing the set_dma_callback() calls after
> > > both request_dma() calls have succeeded.
> > >
> >
> > Good suggestion.
> >
> > > > +             return -EBUSY;
> > > > +     } else
> > > > +             set_dma_callback(uart->tx_dma_channel, bfin_serial_dma_tx_int, uart);
> > > > +
> > > > +     uart->rx_dma_buf.buf = (unsigned char *)dma_alloc_coherent(NULL,
> > > > PAGE_SIZE, &dma_handle, GFP_DMA);
> > >
> > > bad line split.
> > >
> > > > +     uart->rx_dma_buf.head = 0;
> > > > +     uart->rx_dma_buf.tail = 0;
> > > > +     uart->rx_dma_nrows = 0;
> > > > +
> > > > +     set_dma_config(uart->rx_dma_channel,
> > > > +             set_bfin_dma_config(DIR_WRITE, DMA_FLOW_AUTO,
> > > > +                             INTR_ON_ROW, DIMENSION_2D,
> > > > +                             DATA_SIZE_8));
> > > > +     set_dma_x_count(uart->rx_dma_channel, DMA_RX_XCOUNT);
> > > > +     set_dma_x_modify(uart->rx_dma_channel, 1);
> > > > +     set_dma_y_count(uart->rx_dma_channel, DMA_RX_YCOUNT);
> > > > +     set_dma_y_modify(uart->rx_dma_channel, 1);
> > > > +     set_dma_start_addr(uart->rx_dma_channel, (unsigned long)uart->rx_dma_buf.buf);
> > >
> > > ditto
> > >
> > > > +     enable_dma(uart->rx_dma_channel);
> > > > +
> > > > +     uart->rx_dma_timer.data = (unsigned long)(uart);
> > > > +     uart->rx_dma_timer.function = (void *)bfin_serial_rx_dma_timeout;
> > > > +     uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
> > > > +     add_timer(&(uart->rx_dma_timer));
> > > > +#else
> > > > +     if (request_irq
> > > > +         (uart->port.irq, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
> > >
> > > The request_irq() parameters have changed a bit recently.
> > > SA_SHIRQ is now IRQF_SHARED and SA_INTERRUPT is IRQF_DISABLED.
> > > Please change to use the new interface.
> > > It is documented in Documentation/DocBook/genericirq*
> > >
> >
> > I'll change it.
> >
> > > > +          "BFIN_UART0_RX", uart)) {
> > > > +             printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
> > > > +             return -EBUSY;
> > > > +     }
> > > > +
> > > > +     if (request_irq
> > > > +         (uart->port.irq+1, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
> > > > +          "BFIN_UART0_TX", uart)) {
> > > > +             printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");
> > >
> > > This second request_irq() failure needs to call free_irq() for the
> > > first request_irq() that succeeded...
> > >
> >
> > Yeah, will change it.
> >
> > > > +             return -EBUSY;
> > > > +     }
> > > > +#endif
> > > > +     UART_PUT_IER(uart, UART_GET_IER(uart) | ERBFI);
> > > > +     return 0;
> > > > +}
> > >
> > > > +static int bfin_serial_calc_baud(unsigned int uartclk)
> > > > +{
> > > > +     int baud;
> > > > +     baud = get_sclk()/(uartclk*8);
> > >
> > > Throw a few spaces in there, like so:
> > >        baud = get_sclk() / (uartclk * 8);
> > >
> > > > +     if ((baud & 0x1) == 1) {
> > > > +             baud++;
> > > > +     }
> > > > +     return baud/2;
> > > > +}
> > >
> >
> > It will be fixed.
> >
> > Thanks for your comments.
> > -Aubrey
> >
>
>
> --
> Best regards,
> Luke Yang
> luke.adi@gmail.com
>
>
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_3241_1132425.1158829311727
Content-Type: text/x-patch; name="blackfin_serial_drv_2.6.18.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blackfin_serial_drv_2.6.18.patch"
X-Attachment-Id: f_escwxpew

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvS2NvbmZpZyBsaW51
eC0yLjYuMTgucGF0Y2gyL2RyaXZlcnMvc2VyaWFsL0tjb25maWcKLS0tIGxpbnV4LTIuNi4xOC5w
YXRjaDEvZHJpdmVycy9zZXJpYWwvS2NvbmZpZwkyMDA2LTA5LTIxIDA5OjE0OjQyLjAwMDAwMDAw
MCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMi9kcml2ZXJzL3NlcmlhbC9LY29uZmlnCTIw
MDYtMDktMjEgMTY6MTc6NTAuMDAwMDAwMDAwICswODAwCkBAIC00ODgsNiArNDg4LDUwIEBACiAJ
ICB5b3VyIGJvb3QgbG9hZGVyIChsaWxvIG9yIGxvYWRsaW4pIGFib3V0IGhvdyB0byBwYXNzIG9w
dGlvbnMgdG8gdGhlCiAJICBrZXJuZWwgYXQgYm9vdCB0aW1lLikKIAorY29uZmlnIFNFUklBTF9C
RklOCisJdHJpc3RhdGUgIkJsYWNrZmluIHNlcmlhbCBwb3J0IHN1cHBvcnQgKEVYUEVSSU1FTlRB
TCkiCisJZGVwZW5kcyBvbiBCRklOICYmIEVYUEVSSU1FTlRBTAorCXNlbGVjdCBTRVJJQUxfQ09S
RQorCWhlbHAKKwkgIEFkZCBzdXBwb3J0IGZvciB0aGUgYnVpbHQtaW4gVUFSVHMgb24gdGhlIEJs
YWNrZmluLgorCisJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2Ug
TSBoZXJlOiB0aGUKKwkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBiZmluXzV4eC4KKworY29uZmln
IFNFUklBTF9CRklOX0NPTlNPTEUKKwlib29sICJDb25zb2xlIG9uIEJsYWNrZmluIHNlcmlhbCBw
b3J0IgorCWRlcGVuZHMgb24gU0VSSUFMX0JGSU4KKwlzZWxlY3QgU0VSSUFMX0NPUkVfQ09OU09M
RQorCitjaG9pY2UKKwlwcm9tcHQgICJCbGFja2ZpbiBVQVJUIE1vZGUiCisJZGVwZW5kcyBvbiBT
RVJJQUxfQkZJTgorCWRlZmF1bHQgU0VSSUFMX0JGSU5fRE1BCisJaGVscAorCSAgVGhpcyBkcml2
ZXIgc3VwcG9ydHMgdGhlIGJ1aWx0LWluIHNlcmlhbCBwb3J0cyBvZiB0aGUgQmxhY2tmaW4gZmFt
aWx5CisJICBvZiBDUFVzCisKK2NvbmZpZyBTRVJJQUxfQkZJTl9ETUEKKwlib29sICJCbGFja2Zp
biBVQVJUIERNQSBtb2RlIgorCWRlcGVuZHMgb24gRE1BX1VOQ0FDSEVEXzFNCisJaGVscAorCSAg
VGhpcyBkcml2ZXIgd29ya3MgdW5kZXIgRE1BIG1vZGUuIElmIHRoaXMgb3B0aW9uIGlzIHNlbGVj
dGVkLCB0aGUgCisJICBibGFja2ZpbiBzaW1wbGUgZG1hIGRyaXZlciBpcyBhbHNvIGVuYWJsZWQu
CisKK2NvbmZpZyBTRVJJQUxfQkZJTl9QSU8KKwlib29sICJCbGFja2ZpbiBVQVJUIFBJTyBtb2Rl
IgorCWhlbHAKKwkgIFRoaXMgZHJpdmVyIHdvcmtzIHVuZGVyIFBJTyBtb2RlLgorCitlbmRjaG9p
Y2UKKworY29uZmlnIFNFUklBTF9CRklOX0NUU1JUUworCWJvb2wgIkVuYWJsZSBoYXJkd2FyZSBm
bG93IGNvbnRyb2wiCisJZGVwZW5kcyBvbiBTRVJJQUxfQkZJTgorCWhlbHAKKwkgIEVuYWJsZSBo
YXJkd2FyZSBmbG93IGNvbnRyb2wgaW4gdGhlIGRyaXZlci4gVXNpbmcgR1BJTyBlbXVsYXRlIHRo
ZSBDVFMvUlRTCisJICBzaWduYWwuCisKIGNvbmZpZyBTRVJJQUxfSU1YCiAJYm9vbCAiSU1YIHNl
cmlhbCBwb3J0IHN1cHBvcnQiCiAJZGVwZW5kcyBvbiBBUk0gJiYgQVJDSF9JTVgKZGlmZiAtdXJO
IGxpbnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvTWFrZWZpbGUgbGludXgtMi42LjE4
LnBhdGNoMi9kcml2ZXJzL3NlcmlhbC9NYWtlZmlsZQotLS0gbGludXgtMi42LjE4LnBhdGNoMS9k
cml2ZXJzL3NlcmlhbC9NYWtlZmlsZQkyMDA2LTA5LTIxIDA5OjE0OjQyLjAwMDAwMDAwMCArMDgw
MAorKysgbGludXgtMi42LjE4LnBhdGNoMi9kcml2ZXJzL3NlcmlhbC9NYWtlZmlsZQkyMDA2LTA5
LTIxIDE1OjU0OjEzLjAwMDAwMDAwMCArMDgwMApAQCAtMjUsNiArMjUsNyBAQAogb2JqLSQoQ09O
RklHX1NFUklBTF9DTFBTNzExWCkgKz0gY2xwczcxMXgubwogb2JqLSQoQ09ORklHX1NFUklBTF9Q
WEEpICs9IHB4YS5vCiBvYmotJChDT05GSUdfU0VSSUFMX1NBMTEwMCkgKz0gc2ExMTAwLm8KK29i
ai0kKENPTkZJR19TRVJJQUxfQkZJTikgKz0gYmZpbl81eHgubwogb2JqLSQoQ09ORklHX1NFUklB
TF9TM0MyNDEwKSArPSBzM2MyNDEwLm8KIG9iai0kKENPTkZJR19TRVJJQUxfU1VOQ09SRSkgKz0g
c3VuY29yZS5vCiBvYmotJChDT05GSUdfU0VSSUFMX1NVTkhWKSArPSBzdW5odi5vCmRpZmYgLXVy
TiBsaW51eC0yLjYuMTgucGF0Y2gxL2RyaXZlcnMvc2VyaWFsL2JmaW5fNXh4LmMgbGludXgtMi42
LjE4LnBhdGNoMi9kcml2ZXJzL3NlcmlhbC9iZmluXzV4eC5jCi0tLSBsaW51eC0yLjYuMTgucGF0
Y2gxL2RyaXZlcnMvc2VyaWFsL2JmaW5fNXh4LmMJMTk3MC0wMS0wMSAwODowMDowMC4wMDAwMDAw
MDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOC5wYXRjaDIvZHJpdmVycy9zZXJpYWwvYmZpbl81eHgu
YwkyMDA2LTA5LTIxIDE2OjU0OjQ2LjAwMDAwMDAwMCArMDgwMApAQCAtMCwwICsxLDkwNiBAQAor
LyoKKyAqIEZpbGU6ICAgICAgICAgZHJpdmVycy9zZXJpYWwvYmZpbl81eHguYworICogQmFzZWQg
b246ICAgICBCYXNlZCBvbiBkcml2ZXJzL3NlcmlhbC9zYTExMDAuYworICogQXV0aG9yOiAgICAg
ICBBdWJyZXkgTGkgPGF1YnJleS5saUBhbmFsb2cuY29tPgorICoKKyAqIENyZWF0ZWQ6CisgKiBE
ZXNjcmlwdGlvbjogIERyaXZlciBmb3IgYmxhY2tmaW4gNXh4IHNlcmlhbCBwb3J0cworICoKKyAq
IFJldjogICAgICAgICAgJElkOiBiZmluXzV4eC5jLHYgMS4xMiAyMDA2LzA5LzA0IDA0OjQ0OjI3
IGF1YnJleSBFeHAgJAorICoKKyAqIE1vZGlmaWVkOgorICogICAgICAgICAgICAgICBDb3B5cmln
aHQgMjAwNiBBbmFsb2cgRGV2aWNlcyBJbmMuCisgKgorICogQnVnczogICAgICAgICBFbnRlciBi
dWdzIGF0IGh0dHA6Ly9ibGFja2Zpbi51Y2xpbnV4Lm9yZy8KKyAqCisgKiBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkKKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRl
ciB2ZXJzaW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9w
ZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3
aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSB0aGUgZmlsZSBDT1BZSU5HLCBv
ciB3cml0ZQorICogdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyAqIDUx
IEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCisg
Ki8KKworI2lmIGRlZmluZWQoQ09ORklHX1NFUklBTF9CRklOX0NPTlNPTEUpICYmIGRlZmluZWQo
Q09ORklHX01BR0lDX1NZU1JRKQorI2RlZmluZSBTVVBQT1JUX1NZU1JRCisjZW5kaWYKKworI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPgorI2luY2x1
ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CisjaW5jbHVkZSA8
bGludXgvc3lzcnEuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNs
dWRlIDxsaW51eC90dHkuaD4KKyNpbmNsdWRlIDxsaW51eC90dHlfZmxpcC5oPgorI2luY2x1ZGUg
PGxpbnV4L3NlcmlhbF9jb3JlLmg+CisKKyNpbmNsdWRlIDxhc20vbWFjaC9iZmluX3NlcmlhbF81
eHguaD4KKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKyNpbmNsdWRlIDxsaW51eC9k
bWEtbWFwcGluZy5oPgorI2luY2x1ZGUgPGFzbS9pby5oPgorI2luY2x1ZGUgPGFzbS9pcnEuaD4K
KyNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPgorI2VuZGlmCisKKy8qIFdlJ3ZlIGJlZW4gYXNz
aWduZWQgYSByYW5nZSBvbiB0aGUgIkxvdy1kZW5zaXR5IHNlcmlhbCBwb3J0cyIgbWFqb3IgKi8K
KyNkZWZpbmUgU0VSSUFMX0JGSU5fTUFKT1IJVFRZX01BSk9SCisjZGVmaW5lIE1JTk9SX1NUQVJU
CQk2NAorCisjZGVmaW5lIERFQlVHCisKKyNpZmRlZiBERUJVRworIyBkZWZpbmUgRFBSSU5USyh4
Li4uKSAgIHByaW50ayhLRVJOX0RFQlVHIHgpCisjZWxzZQorIyBkZWZpbmUgRFBSSU5USyh4Li4u
KSAgIGRvIHsgfSB3aGlsZSAoMCkKKyNlbmRpZgorCisvKgorICogU2V0dXAgZm9yIGNvbnNvbGUu
IEFyZ3VtZW50IGNvbWVzIGZyb20gdGhlIG1lbnVjb25maWcKKyAqLworCisjaWYgZGVmaW5lZChD
T05GSUdfQkFVRF85NjAwKQorI2RlZmluZSBDT05TT0xFX0JBVURfUkFURSAgICAgICA5NjAwCisj
ZWxpZiBkZWZpbmVkKENPTkZJR19CQVVEXzE5MjAwKQorI2RlZmluZSBDT05TT0xFX0JBVURfUkFU
RSAgICAgICAxOTIwMAorI2VsaWYgZGVmaW5lZChDT05GSUdfQkFVRF8zODQwMCkKKyNkZWZpbmUg
Q09OU09MRV9CQVVEX1JBVEUgICAgICAgMzg0MDAKKyNlbGlmIGRlZmluZWQoQ09ORklHX0JBVURf
NTc2MDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9SQVRFICAgICAgIDU3NjAwCisjZWxpZiBkZWZp
bmVkKENPTkZJR19CQVVEXzExNTIwMCkKKyNkZWZpbmUgQ09OU09MRV9CQVVEX1JBVEUgICAgICAg
MTE1MjAwCisjZW5kaWYKKworI2RlZmluZSBETUFfUlhfWENPVU5UCQlUVFlfRkxJUEJVRl9TSVpF
CisjZGVmaW5lIERNQV9SWF9ZQ09VTlQJCShQQUdFX1NJWkUgLyBETUFfUlhfWENPVU5UKQorCisj
ZGVmaW5lIERNQV9SWF9GTFVTSF9KSUZGSUVTCTUKKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJ
Tl9ETUEKK3dhaXRfcXVldWVfaGVhZF90IGJmaW5fc2VyaWFsX3R4X3F1ZXVlW05SX1BPUlRTXTsK
K3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2RtYV90eF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxf
cG9ydCAqdWFydCk7CisjZWxzZQorc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG9fd29yayh2b2lk
ICopOworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfdHhfY2hhcnMoc3RydWN0IGJmaW5fc2VyaWFs
X3BvcnQgKnVhcnQpOworc3RhdGljIHZvaWQgbG9jYWxfcHV0X2NoYXIoc3RydWN0IGJmaW5fc2Vy
aWFsX3BvcnQgKnVhcnQsIGNoYXIgY2gpOworI2VuZGlmCisKK3N0YXRpYyB2b2lkIGJmaW5fc2Vy
aWFsX21jdHJsX2NoZWNrKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KTsKKworLyoKKyAq
IGludGVycnVwdHMgZGlzYWJsZWQgb24gZW50cnkKKyAqLworc3RhdGljIHZvaWQgYmZpbl9zZXJp
YWxfc3RvcF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmluX3Nlcmlh
bF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKwl1bnNpZ25l
ZCBzaG9ydCBpZXI7CisJaWVyID0gVUFSVF9HRVRfSUVSKHVhcnQpOworCWllciAmPSB+RVRCRUk7
CisJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7CisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RN
QQorCWRpc2FibGVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKyNlbmRpZgorfQorCisvKgor
ICogcG9ydCBsb2NrZWQgYW5kIGludGVycnVwdHMgZGlzYWJsZWQKKyAqLworc3RhdGljIHZvaWQg
YmZpbl9zZXJpYWxfc3RhcnRfdHgoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7
CisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorCWJmaW5fc2VyaWFsX2RtYV90eF9jaGFy
cyh1YXJ0KTsKKyNlbHNlCisJdW5zaWduZWQgc2hvcnQgaWVyOworCWllciA9IFVBUlRfR0VUX0lF
Uih1YXJ0KTsKKwlpZXIgfD0gRVRCRUk7CisJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7CisJYmZp
bl9zZXJpYWxfdHhfY2hhcnModWFydCk7CisjZW5kaWYKK30KKworLyoKKyAqIEludGVycnVwdHMg
ZW5hYmxlZAorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9zdG9wX3J4KHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0
IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpZXIgPSBV
QVJUX0dFVF9JRVIodWFydCk7CisJaWVyICY9IEVSQkZJOworCVVBUlRfUFVUX0lFUih1YXJ0LCBp
ZXIpOworfQorCisvKgorICogU2V0IHRoZSBtb2RlbSBjb250cm9sIHRpbWVyIHRvIGZpcmUgaW1t
ZWRpYXRlbHkuCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2VuYWJsZV9tcyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0KQoreworfQorCisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX1BJTwor
c3RhdGljIHZvaWQgbG9jYWxfcHV0X2NoYXIoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQs
IGNoYXIgY2gpCit7CisgICAgICAgIHVuc2lnbmVkIHNob3J0IHN0YXR1czsKKyAgICAgICAgaW50
IGZsYWdzID0gMDsKKworICAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisKKyAgICAgICAg
ZG8geworICAgICAgICAgICAgICAgIHN0YXR1cyA9IFVBUlRfR0VUX0xTUih1YXJ0KTsKKyAgICAg
ICAgfSB3aGlsZSAoIShzdGF0dXMgJiBUSFJFKSk7CisKKyAgICAgICAgVUFSVF9QVVRfQ0hBUih1
YXJ0LCBjaCk7CisgICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKK30KKworc3RhdGlj
IHZvaWQKK2JmaW5fc2VyaWFsX3J4X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0
LCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sKKwlzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5ID0gdWFy
dC0+cG9ydC5pbmZvLT50dHk7CisJdW5zaWduZWQgaW50IHN0YXR1cz0wLCBjaCwgZmxnOworCWNo
ID0gVUFSVF9HRVRfQ0hBUih1YXJ0KTsKKwl1YXJ0LT5wb3J0Lmljb3VudC5yeCsrOworCWZsZyA9
IFRUWV9OT1JNQUw7CisJaWYgKHVhcnRfaGFuZGxlX3N5c3JxX2NoYXIoJnVhcnQtPnBvcnQsIGNo
LCByZWdzKSkKKwkJZ290byBpZ25vcmVfY2hhcjsKKwl1YXJ0X2luc2VydF9jaGFyKCZ1YXJ0LT5w
b3J0LCBzdGF0dXMsIDEsIGNoLCBmbGcpOworCitpZ25vcmVfY2hhcjoKKwl0dHlfZmxpcF9idWZm
ZXJfcHVzaCh0dHkpOworfQorCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF90eF9jaGFycyhzdHJ1
Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCkKK3sKKwlzdHJ1Y3QgY2lyY19idWYgKnhtaXQgPSAm
dWFydC0+cG9ydC5pbmZvLT54bWl0OworCisJaWYgKHVhcnQtPnBvcnQueF9jaGFyKSB7CisJCVVB
UlRfUFVUX0NIQVIodWFydCwgdWFydC0+cG9ydC54X2NoYXIpOworCQl1YXJ0LT5wb3J0Lmljb3Vu
dC50eCsrOworCQl1YXJ0LT5wb3J0LnhfY2hhciA9IDA7CisJCXJldHVybjsKKwl9CisJLyoKKwkg
KiBDaGVjayB0aGUgbW9kZW0gY29udHJvbCBsaW5lcyBiZWZvcmUKKwkgKiB0cmFuc21pdHRpbmcg
YW55dGhpbmcuCisJICovCisJYmZpbl9zZXJpYWxfbWN0cmxfY2hlY2sodWFydCk7CisKKwlpZiAo
dWFydF9jaXJjX2VtcHR5KHhtaXQpIHx8IHVhcnRfdHhfc3RvcHBlZCgmdWFydC0+cG9ydCkpIHsK
KwkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFydC0+cG9ydCk7CisJCXJldHVybjsKKwl9CisKKwls
b2NhbF9wdXRfY2hhcih1YXJ0LCB4bWl0LT5idWZbeG1pdC0+dGFpbF0pOworCXhtaXQtPnRhaWwg
PSAoeG1pdC0+dGFpbCArIDEpICYgKFVBUlRfWE1JVF9TSVpFIC0gMSk7CisJdWFydC0+cG9ydC5p
Y291bnQudHgrKzsKKworCWlmICh1YXJ0X2NpcmNfY2hhcnNfcGVuZGluZyh4bWl0KSA8IFdBS0VV
UF9DSEFSUykKKwkJdWFydF93cml0ZV93YWtldXAoJnVhcnQtPnBvcnQpOworCisJaWYgKHVhcnRf
Y2lyY19lbXB0eSh4bWl0KSkKKwkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFydC0+cG9ydCk7Cit9
CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBiZmluX3NlcmlhbF9pbnQoaW50IGlycSwgdm9pZCAqZGV2
X2lkLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
dWFydCA9IGRldl9pZDsKKwl1bnNpZ25lZCBzaG9ydCBzdGF0dXM7CisKKwlzcGluX2xvY2soJnVh
cnQtPnBvcnQubG9jayk7CisJc3RhdHVzID0gVUFSVF9HRVRfSUlSKHVhcnQpOworCWRvIHsKKwkJ
aWYgKChzdGF0dXMgJiBJSVJfU1RBVFVTKSA9PSBJSVJfVFhfUkVBRFkpCisJCQliZmluX3Nlcmlh
bF90eF9jaGFycyh1YXJ0KTsKKwkJaWYgKChzdGF0dXMgJiBJSVJfU1RBVFVTKSA9PSBJSVJfUlhf
UkVBRFkpCisJCQliZmluX3NlcmlhbF9yeF9jaGFycyh1YXJ0LCByZWdzKTsKKwkJc3RhdHVzID0g
VUFSVF9HRVRfSUlSKHVhcnQpOworCX0gd2hpbGUgKHN0YXR1cyAmKElJUl9UWF9SRUFEWSB8IElJ
Ul9SWF9SRUFEWSkpOworCXNwaW5fdW5sb2NrKCZ1YXJ0LT5wb3J0LmxvY2spOworCXJldHVybiBJ
UlFfSEFORExFRDsKK30KKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG9fd29yayh2b2lkICpw
b3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3Nl
cmlhbF9wb3J0ICopcG9ydDsKKwliZmluX3NlcmlhbF9tY3RybF9jaGVjayh1YXJ0KTsKK30KKwor
I2VuZGlmCisKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCitzdGF0aWMgdm9pZCBiZmlu
X3NlcmlhbF9kbWFfdHhfY2hhcnMoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQpCit7CisJ
c3RydWN0IGNpcmNfYnVmICp4bWl0ID0gJnVhcnQtPnBvcnQuaW5mby0+eG1pdDsKKwl1bnNpZ25l
ZCBzaG9ydCBpZXI7CisJaW50IGZsYWdzID0gMDsKKworCWlmICghdWFydC0+dHhfZG9uZSkKKwkJ
cmV0dXJuOworCisJdWFydC0+dHhfZG9uZSA9IDA7CisKKwlpZiAodWFydC0+cG9ydC54X2NoYXIp
IHsKKwkJVUFSVF9QVVRfQ0hBUih1YXJ0LCB1YXJ0LT5wb3J0LnhfY2hhcik7CisJCXVhcnQtPnBv
cnQuaWNvdW50LnR4Kys7CisJCXVhcnQtPnBvcnQueF9jaGFyID0gMDsKKwkJdWFydC0+dHhfZG9u
ZSA9IDE7CisJCXJldHVybjsKKwl9CisJLyoKKwkgKiBDaGVjayB0aGUgbW9kZW0gY29udHJvbCBs
aW5lcyBiZWZvcmUKKwkgKiB0cmFuc21pdHRpbmcgYW55dGhpbmcuCisJICovCisJYmZpbl9zZXJp
YWxfbWN0cmxfY2hlY2sodWFydCk7CisKKwlpZiAodWFydF9jaXJjX2VtcHR5KHhtaXQpIHx8IHVh
cnRfdHhfc3RvcHBlZCgmdWFydC0+cG9ydCkpIHsKKwkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFy
dC0+cG9ydCk7CisJCXVhcnQtPnR4X2RvbmUgPSAxOworCQlyZXR1cm47CisJfQorCisJbG9jYWxf
aXJxX3NhdmUoZmxhZ3MpOworCXVhcnQtPnR4X2NvdW50ID0gQ0lSQ19DTlQoeG1pdC0+aGVhZCwg
eG1pdC0+dGFpbCwgVUFSVF9YTUlUX1NJWkUpOworCWlmICh1YXJ0LT50eF9jb3VudCA+IChVQVJU
X1hNSVRfU0laRSAtIHhtaXQtPnRhaWwpKQorCXVhcnQtPnR4X2NvdW50ID0gVUFSVF9YTUlUX1NJ
WkUgLSB4bWl0LT50YWlsOworCWJsYWNrZmluX2RjYWNoZV9mbHVzaF9yYW5nZSgodW5zaWduZWQg
bG9uZykoeG1pdC0+YnVmK3htaXQtPnRhaWwpLAorCQkJCQkodW5zaWduZWQgbG9uZykoeG1pdC0+
YnVmK3htaXQtPnRhaWwrdWFydC0+dHhfY291bnQpKTsKKwlzZXRfZG1hX2NvbmZpZyh1YXJ0LT50
eF9kbWFfY2hhbm5lbCwKKwkJc2V0X2JmaW5fZG1hX2NvbmZpZyhESVJfUkVBRCwgRE1BX0ZMT1df
U1RPUCwKKwkJCUlOVFJfT05fQlVGLAorCQkJRElNRU5TSU9OX0xJTkVBUiwKKwkJCURBVEFfU0la
RV84KSk7CisJc2V0X2RtYV9zdGFydF9hZGRyKHVhcnQtPnR4X2RtYV9jaGFubmVsLCAodW5zaWdu
ZWQgbG9uZykoeG1pdC0+YnVmK3htaXQtPnRhaWwpKTsKKwlzZXRfZG1hX3hfY291bnQodWFydC0+
dHhfZG1hX2NoYW5uZWwsIHVhcnQtPnR4X2NvdW50KTsKKwlzZXRfZG1hX3hfbW9kaWZ5KHVhcnQt
PnR4X2RtYV9jaGFubmVsLCAxKTsKKwllbmFibGVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsK
KwlpZXIgPSBVQVJUX0dFVF9JRVIodWFydCk7CisJaWVyIHw9IEVUQkVJOworCVVBUlRfUFVUX0lF
Uih1YXJ0LCBpZXIpOworCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKK30KKworc3RhdGljIHZv
aWQgYmZpbl9zZXJpYWxfZG1hX3J4X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICogdWFy
dCkKK3sKKwlzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5ID0gdWFydC0+cG9ydC5pbmZvLT50dHk7CisJ
aW50IGksIGZsZywgc3RhdHVzID0gMDsKKworCXVhcnQtPnBvcnQuaWNvdW50LnJ4ICs9IENJUkNf
Q05UKHVhcnQtPnJ4X2RtYV9idWYuaGVhZCwgdWFydC0+cnhfZG1hX2J1Zi50YWlsLCBVQVJUX1hN
SVRfU0laRSk7OworCWZsZyA9IFRUWV9OT1JNQUw7CisJZm9yIChpID0gdWFydC0+cnhfZG1hX2J1
Zi5oZWFkOyBpIDwgdWFydC0+cnhfZG1hX2J1Zi50YWlsOyBpKyspIHsKKwkJaWYgKHVhcnRfaGFu
ZGxlX3N5c3JxX2NoYXIoJnVhcnQtPnBvcnQsIHVhcnQtPnJ4X2RtYV9idWYuYnVmW2ldLCBOVUxM
KSkKKwkJCWdvdG8gZG1hX2lnbm9yZV9jaGFyOworCQl1YXJ0X2luc2VydF9jaGFyKCZ1YXJ0LT5w
b3J0LCBzdGF0dXMsIDEsIHVhcnQtPnJ4X2RtYV9idWYuYnVmW2ldLCBmbGcpOworCX0KK2RtYV9p
Z25vcmVfY2hhcjoKKwl0dHlfZmxpcF9idWZmZXJfcHVzaCh0dHkpOworfQorCit2b2lkIGJmaW5f
c2VyaWFsX3J4X2RtYV90aW1lb3V0KHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KQorewor
CWludCB4X3BvcywgcG9zOworCWludCBmbGFncyA9IDA7CisKKwliZmluX3NlcmlhbF9kbWFfdHhf
Y2hhcnModWFydCk7CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJeF9wb3MgPSBETUFfUlhf
WENPVU5UIC0gZ2V0X2RtYV9jdXJyX3hjb3VudCh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisJaWYg
KHhfcG9zID09IERNQV9SWF9YQ09VTlQpCisJCXhfcG9zID0gMDsKKworCXBvcyA9IHVhcnQtPnJ4
X2RtYV9ucm93cyAqIERNQV9SWF9YQ09VTlQgKyB4X3BvczsKKworCWlmIChwb3M+dWFydC0+cnhf
ZG1hX2J1Zi50YWlsKSB7CisJCXVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IHBvczsKKwkJYmZpbl9z
ZXJpYWxfZG1hX3J4X2NoYXJzKHVhcnQpOworCQl1YXJ0LT5yeF9kbWFfYnVmLmhlYWQgPSB1YXJ0
LT5yeF9kbWFfYnVmLnRhaWw7CisJfQorCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKKwl1YXJ0
LT5yeF9kbWFfdGltZXIuZXhwaXJlcyA9IGppZmZpZXMgKyBETUFfUlhfRkxVU0hfSklGRklFUzsK
KwlhZGRfdGltZXIoJih1YXJ0LT5yeF9kbWFfdGltZXIpKTsKK30KKworc3RhdGljIGlycXJldHVy
bl90IGJmaW5fc2VyaWFsX2RtYV90eF9pbnQoaW50IGlycSwgdm9pZCAqZGV2X2lkLCBzdHJ1Y3Qg
cHRfcmVncyAqcmVncykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IGRldl9p
ZDsKKwlzdHJ1Y3QgY2lyY19idWYgKnhtaXQgPSAmdWFydC0+cG9ydC5pbmZvLT54bWl0OworCXVu
c2lnbmVkIHNob3J0IGllcjsKKworCXNwaW5fbG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlpZiAo
IShnZXRfZG1hX2N1cnJfaXJxc3RhdCh1YXJ0LT50eF9kbWFfY2hhbm5lbCkmRE1BX1JVTikpIHsK
KwkJY2xlYXJfZG1hX2lycXN0YXQodWFydC0+dHhfZG1hX2NoYW5uZWwpOworCQlkaXNhYmxlX2Rt
YSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisJCWllciA9IFVBUlRfR0VUX0lFUih1YXJ0KTsKKwkJ
aWVyICY9IH5FVEJFSTsKKwkJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7CisJCXhtaXQtPnRhaWwg
PSAoeG1pdC0+dGFpbCt1YXJ0LT50eF9jb3VudCkgJihVQVJUX1hNSVRfU0laRSAtMSk7CisJCXVh
cnQtPnBvcnQuaWNvdW50LnR4Kz11YXJ0LT50eF9jb3VudDsKKworCQlpZiAodWFydF9jaXJjX2No
YXJzX3BlbmRpbmcoeG1pdCkgPCBXQUtFVVBfQ0hBUlMpCisJCQl1YXJ0X3dyaXRlX3dha2V1cCgm
dWFydC0+cG9ydCk7CisKKwkJaWYgKHVhcnRfY2lyY19lbXB0eSh4bWl0KSkKKwkJCWJmaW5fc2Vy
aWFsX3N0b3BfdHgoJnVhcnQtPnBvcnQpOworCQl1YXJ0LT50eF9kb25lID0gMTsKKwl9CisKKwlz
cGluX3VubG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisK
K3N0YXRpYyBpcnFyZXR1cm5fdCBiZmluX3NlcmlhbF9kbWFfcnhfaW50KGludCBpcnEsIHZvaWQg
KmRldl9pZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3Bv
cnQgKnVhcnQgPSBkZXZfaWQ7CisJdW5zaWduZWQgc2hvcnQgaXJxc3RhdDsKKworCXVhcnQtPnJ4
X2RtYV9ucm93cysrOworCWlmICh1YXJ0LT5yeF9kbWFfbnJvd3MgPT0gRE1BX1JYX1lDT1VOVCkg
eworCQl1YXJ0LT5yeF9kbWFfbnJvd3MgPSAwOworCQl1YXJ0LT5yeF9kbWFfYnVmLnRhaWwgPSBE
TUFfUlhfWENPVU5UKkRNQV9SWF9ZQ09VTlQ7CisJCWJmaW5fc2VyaWFsX2RtYV9yeF9jaGFycyh1
YXJ0KTsKKwkJdWFydC0+cnhfZG1hX2J1Zi5oZWFkID0gdWFydC0+cnhfZG1hX2J1Zi50YWlsID0g
MDsKKwl9CisJc3Bpbl9sb2NrKCZ1YXJ0LT5wb3J0LmxvY2spOworCWlycXN0YXQgPSBnZXRfZG1h
X2N1cnJfaXJxc3RhdCh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisJY2xlYXJfZG1hX2lycXN0YXQo
dWFydC0+cnhfZG1hX2NoYW5uZWwpOworCisJc3Bpbl91bmxvY2soJnVhcnQtPnBvcnQubG9jayk7
CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorI2VuZGlmCisKKy8qCisgKiBSZXR1cm4gVElPQ1NF
Ul9URU1UIHdoZW4gdHJhbnNtaXR0ZXIgaXMgbm90IGJ1c3kuCisgKi8KK3N0YXRpYyB1bnNpZ25l
ZCBpbnQgYmZpbl9zZXJpYWxfdHhfZW1wdHkoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlz
dHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
KXBvcnQ7CisJdW5zaWduZWQgc2hvcnQgbHNyOworCWxzciA9IFVBUlRfR0VUX0xTUih1YXJ0KTsK
KwlpZiAobHNyICYgVEhSRSkKKwkJcmV0dXJuIFRJT0NTRVJfVEVNVDsKKwllbHNlCisJCXJldHVy
biAwOworfQorCitzdGF0aWMgdW5zaWduZWQgaW50IGJmaW5fc2VyaWFsX2dldF9tY3RybChzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCS8qIEhhcmR3YXJlIGZsb3cgY29udHJvbCBpcyBvbmx5
IHN1cHBvcnRlZCBvbiB0aGUgZmlyc3QgcG9ydCAqLworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJ
Tl9DVFNSVFMKKwlpZiAoKGJmaW5fcmVhZDE2KENUU19QT1JUKSAmICgxIDw8IENUU19QSU4pKSAm
JiAocG9ydC0+bGluZSA9PSAwKSkKKwkJcmV0dXJuIFRJT0NNX0RTUiB8IFRJT0NNX0NBUjsKKwll
bHNlCisjZW5kaWYKKwkJcmV0dXJuIFRJT0NNX0NUUyB8IFRJT0NNX0RTUiB8IFRJT0NNX0NBUjsK
K30KKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfc2V0X21jdHJsKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQsIHVuc2lnbmVkIGludCBtY3RybCkKK3sKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5f
Q1RTUlRTCisJaWYgKG1jdHJsICYgVElPQ01fUlRTKQorCQliZmluX3dyaXRlMTYoUlRTX1BPUlQs
IGJmaW5fcmVhZDE2KFJUU19QT1JUKSAmICh+MSA8PCBSVFNfUElOKSk7CisJZWxzZQorCQliZmlu
X3dyaXRlMTYoUlRTX1BPUlQsIGJmaW5fcmVhZDE2KFJUU19QT1JUKSB8ICgxIDw8IFJUU19QSU4p
KTsKKyNlbmRpZgorfQorCisvKgorICogSGFuZGxlIGFueSBjaGFuZ2Ugb2YgbW9kZW0gc3RhdHVz
IHNpZ25hbCBzaW5jZSB3ZSB3ZXJlIGxhc3QgY2FsbGVkLgorICovCitzdGF0aWMgdm9pZCBiZmlu
X3NlcmlhbF9tY3RybF9jaGVjayhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCkKK3sKKyNp
ZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fQ1RTUlRTCisJdW5zaWduZWQgaW50IHN0YXR1czsKKyNp
ZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisJc3RydWN0IHVhcnRfaW5mbyAqaW5mbyA9IHVh
cnQtPnBvcnQuaW5mbzsKKwlzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5ID0gaW5mby0+dHR5OworCXN0
YXR1cyA9IGJmaW5fc2VyaWFsX2dldF9tY3RybCgmdWFydC0+cG9ydCk7CisJaWYgKCEoc3RhdHVz
ICYgVElPQ01fQ1RTKSkgeworCQl0dHktPmh3X3N0b3BwZWQgPSAxOworCX0gZWxzZSB7CisJCXR0
eS0+aHdfc3RvcHBlZCA9IDA7CisJfQorI2Vsc2UKKwlzdGF0dXMgPSBiZmluX3NlcmlhbF9nZXRf
bWN0cmwoJnVhcnQtPnBvcnQpOworCXVhcnRfaGFuZGxlX2N0c19jaGFuZ2UoJnVhcnQtPnBvcnQs
IHN0YXR1cyAmIFRJT0NNX0NUUyk7CisJaWYgKCEoc3RhdHVzICYgVElPQ01fQ1RTKSkKKwkJc2No
ZWR1bGVfd29yaygmdWFydC0+Y3RzX3dvcmtxdWV1ZSk7CisjZW5kaWYKKyNlbmRpZgorfQorCisv
KgorICogSW50ZXJydXB0cyBhbHdheXMgZGlzYWJsZWQuCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5f
c2VyaWFsX2JyZWFrX2N0bChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBpbnQgYnJlYWtfc3RhdGUp
Cit7Cit9CisKK2ludCBiZmluX3NlcmlhbF9zdGFydHVwKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQp
Cit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFs
X3BvcnQgKilwb3J0OworCisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorCWRtYV9hZGRy
X3QgZG1hX2hhbmRsZTsKKworCWlmIChyZXF1ZXN0X2RtYSh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwg
IkJGSU5fVUFSVF9SWCIpIDwgMCkgeworCQlwcmludGsoS0VSTl9OT1RJQ0UgIlVuYWJsZSB0byBh
dHRhY2ggQmxhY2tmaW4gVUFSVCBSWCBETUEgY2hhbm5lbFxuIik7CisJCXJldHVybiAtRUJVU1k7
CisJfQorCisJaWYgKHJlcXVlc3RfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsLCAiQkZJTl9VQVJU
X1RYIikgPCAwKSB7CisJCXByaW50ayhLRVJOX05PVElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFj
a2ZpbiBVQVJUIFRYIERNQSBjaGFubmVsXG4iKTsKKwkJZnJlZV9kbWEodWFydC0+cnhfZG1hX2No
YW5uZWwpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKworCXNldF9kbWFfY2FsbGJhY2sodWFydC0+
cnhfZG1hX2NoYW5uZWwsIGJmaW5fc2VyaWFsX2RtYV9yeF9pbnQsIHVhcnQpOworCXNldF9kbWFf
Y2FsbGJhY2sodWFydC0+dHhfZG1hX2NoYW5uZWwsIGJmaW5fc2VyaWFsX2RtYV90eF9pbnQsIHVh
cnQpOworCisJdWFydC0+cnhfZG1hX2J1Zi5idWYgPSAodW5zaWduZWQgY2hhciAqKWRtYV9hbGxv
Y19jb2hlcmVudChOVUxMLCBQQUdFX1NJWkUsICZkbWFfaGFuZGxlLCBHRlBfRE1BKTsKKwl1YXJ0
LT5yeF9kbWFfYnVmLmhlYWQgPSAwOworCXVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IDA7CisJdWFy
dC0+cnhfZG1hX25yb3dzID0gMDsKKworCXNldF9kbWFfY29uZmlnKHVhcnQtPnJ4X2RtYV9jaGFu
bmVsLAorCQlzZXRfYmZpbl9kbWFfY29uZmlnKERJUl9XUklURSwgRE1BX0ZMT1dfQVVUTywKKwkJ
CQlJTlRSX09OX1JPVywgRElNRU5TSU9OXzJELAorCQkJCURBVEFfU0laRV84KSk7CisJc2V0X2Rt
YV94X2NvdW50KHVhcnQtPnJ4X2RtYV9jaGFubmVsLCBETUFfUlhfWENPVU5UKTsKKwlzZXRfZG1h
X3hfbW9kaWZ5KHVhcnQtPnJ4X2RtYV9jaGFubmVsLCAxKTsKKwlzZXRfZG1hX3lfY291bnQodWFy
dC0+cnhfZG1hX2NoYW5uZWwsIERNQV9SWF9ZQ09VTlQpOworCXNldF9kbWFfeV9tb2RpZnkodWFy
dC0+cnhfZG1hX2NoYW5uZWwsIDEpOworCXNldF9kbWFfc3RhcnRfYWRkcih1YXJ0LT5yeF9kbWFf
Y2hhbm5lbCwgKHVuc2lnbmVkIGxvbmcpdWFydC0+cnhfZG1hX2J1Zi5idWYpOworCWVuYWJsZV9k
bWEodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCisJdWFydC0+cnhfZG1hX3RpbWVyLmRhdGEgPSAo
dW5zaWduZWQgbG9uZykodWFydCk7CisJdWFydC0+cnhfZG1hX3RpbWVyLmZ1bmN0aW9uID0gKHZv
aWQgKiliZmluX3NlcmlhbF9yeF9kbWFfdGltZW91dDsKKwl1YXJ0LT5yeF9kbWFfdGltZXIuZXhw
aXJlcyA9IGppZmZpZXMgKyBETUFfUlhfRkxVU0hfSklGRklFUzsKKwlhZGRfdGltZXIoJih1YXJ0
LT5yeF9kbWFfdGltZXIpKTsKKyNlbHNlCisJaWYgKHJlcXVlc3RfaXJxCisJICAgICh1YXJ0LT5w
b3J0LmlycSwgYmZpbl9zZXJpYWxfaW50LCBJUlFGX0RJU0FCTEVEIHwgSVJRRl9TSEFSRUQsCisJ
ICAgICAiQkZJTl9VQVJUMF9SWCIsIHVhcnQpKSB7CisJCXByaW50ayhLRVJOX05PVElDRSAiVW5h
YmxlIHRvIGF0dGFjaCBCbGFja0ZpbiBVQVJUIFJYIGludGVycnVwdFxuIik7CisJCXJldHVybiAt
RUJVU1k7CisJfQorCisJaWYgKHJlcXVlc3RfaXJxCisJICAgICh1YXJ0LT5wb3J0LmlycSsxLCBi
ZmluX3NlcmlhbF9pbnQsIElSUUZfRElTQUJMRUQgfCBJUlFGX1NIQVJFRCwKKwkgICAgICJCRklO
X1VBUlQwX1RYIiwgdWFydCkpIHsKKwkJcHJpbnRrKEtFUk5fTk9USUNFICJVbmFibGUgdG8gYXR0
YWNoIEJsYWNrRmluIFVBUlQgVFggaW50ZXJydXB0XG4iKTsKKwkJZnJlZV9pcnEodWFydC0+cG9y
dC5pcnEsIHVhcnQpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKyNlbmRpZgorCVVBUlRfUFVUX0lF
Uih1YXJ0LCBVQVJUX0dFVF9JRVIodWFydCkgfCBFUkJGSSk7CisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3NodXRkb3duKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7
CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3Bv
cnQgKilwb3J0OworCisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorCWRpc2FibGVfZG1h
KHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwlmcmVlX2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7
CisJZGlzYWJsZV9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCWZyZWVfZG1hKHVhcnQtPnJ4
X2RtYV9jaGFubmVsKTsKKwlkZWxfdGltZXIoJih1YXJ0LT5yeF9kbWFfdGltZXIpKTsKKyNlbHNl
CisJZnJlZV9pcnEodWFydC0+cG9ydC5pcnEsIHVhcnQpOworCWZyZWVfaXJxKHVhcnQtPnBvcnQu
aXJxKzEsIHVhcnQpOworI2VuZGlmCit9CisKK3N0YXRpYyB2b2lkCitiZmluX3NlcmlhbF9zZXRf
dGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3QgdGVybWlvcyAqdGVybWlvcywK
KwkJICAgc3RydWN0IHRlcm1pb3MgKm9sZCkKK3sKK30KKworc3RhdGljIGNvbnN0IGNoYXIgKmJm
aW5fc2VyaWFsX3R5cGUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9z
ZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisJcmV0
dXJuIHVhcnQtPnBvcnQudHlwZSA9PSBQT1JUX0JGSU4gPyAiQkZJTi1VQVJUIiA6IE5VTEw7Cit9
CisKKy8qCisgKiBSZWxlYXNlIHRoZSBtZW1vcnkgcmVnaW9uKHMpIGJlaW5nIHVzZWQgYnkgJ3Bv
cnQnLgorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9yZWxlYXNlX3BvcnQoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCkKK3sKK30KKworLyoKKyAqIFJlcXVlc3QgdGhlIG1lbW9yeSByZWdpb24o
cykgYmVpbmcgdXNlZCBieSAncG9ydCcuCisgKi8KK3N0YXRpYyBpbnQgYmZpbl9zZXJpYWxfcmVx
dWVzdF9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJcmV0dXJuIDA7Cit9CisKKy8q
CisgKiBDb25maWd1cmUvYXV0b2NvbmZpZ3VyZSB0aGUgcG9ydC4KKyAqLworc3RhdGljIHZvaWQg
YmZpbl9zZXJpYWxfY29uZmlnX3BvcnQoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgaW50IGZsYWdz
KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3Nlcmlh
bF9wb3J0ICopcG9ydDsKKworCWlmIChmbGFncyAmIFVBUlRfQ09ORklHX1RZUEUgJiYKKwkgICAg
YmZpbl9zZXJpYWxfcmVxdWVzdF9wb3J0KCZ1YXJ0LT5wb3J0KSA9PSAwKQorCQl1YXJ0LT5wb3J0
LnR5cGUgPSBQT1JUX0JGSU47Cit9CisKKy8qCisgKiBWZXJpZnkgdGhlIG5ldyBzZXJpYWxfc3Ry
dWN0IChmb3IgVElPQ1NTRVJJQUwpLgorICogVGhlIG9ubHkgY2hhbmdlIHdlIGFsbG93IGFyZSB0
byB0aGUgZmxhZ3MgYW5kIHR5cGUsIGFuZAorICogZXZlbiB0aGVuIG9ubHkgYmV0d2VlbiBQT1JU
X0JGSU4gYW5kIFBPUlRfVU5LTk9XTgorICovCitzdGF0aWMgaW50CitiZmluX3NlcmlhbF92ZXJp
ZnlfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3N0cnVjdCAqc2Vy
KQoreworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0IHVhcnRfb3BzIGJmaW5fc2VyaWFs
X3BvcHMgPSB7CisJLnR4X2VtcHR5CT0gYmZpbl9zZXJpYWxfdHhfZW1wdHksCisJLnNldF9tY3Ry
bAk9IGJmaW5fc2VyaWFsX3NldF9tY3RybCwKKwkuZ2V0X21jdHJsCT0gYmZpbl9zZXJpYWxfZ2V0
X21jdHJsLAorCS5zdG9wX3R4CT0gYmZpbl9zZXJpYWxfc3RvcF90eCwKKwkuc3RhcnRfdHgJPSBi
ZmluX3NlcmlhbF9zdGFydF90eCwKKwkuc3RvcF9yeAk9IGJmaW5fc2VyaWFsX3N0b3BfcngsCisJ
LmVuYWJsZV9tcwk9IGJmaW5fc2VyaWFsX2VuYWJsZV9tcywKKwkuYnJlYWtfY3RsCT0gYmZpbl9z
ZXJpYWxfYnJlYWtfY3RsLAorCS5zdGFydHVwCT0gYmZpbl9zZXJpYWxfc3RhcnR1cCwKKwkuc2h1
dGRvd24JPSBiZmluX3NlcmlhbF9zaHV0ZG93biwKKwkuc2V0X3Rlcm1pb3MJPSBiZmluX3Nlcmlh
bF9zZXRfdGVybWlvcywKKwkudHlwZQkJPSBiZmluX3NlcmlhbF90eXBlLAorCS5yZWxlYXNlX3Bv
cnQJPSBiZmluX3NlcmlhbF9yZWxlYXNlX3BvcnQsCisJLnJlcXVlc3RfcG9ydAk9IGJmaW5fc2Vy
aWFsX3JlcXVlc3RfcG9ydCwKKwkuY29uZmlnX3BvcnQJPSBiZmluX3NlcmlhbF9jb25maWdfcG9y
dCwKKwkudmVyaWZ5X3BvcnQJPSBiZmluX3NlcmlhbF92ZXJpZnlfcG9ydCwKK307CisKK3N0YXRp
YyBpbnQgYmZpbl9zZXJpYWxfY2FsY19iYXVkKHVuc2lnbmVkIGludCB1YXJ0Y2xrKQoreworCWlu
dCBiYXVkOworCWJhdWQgPSBnZXRfc2NsaygpIC8gKHVhcnRjbGsqOCk7CisJaWYgKChiYXVkICYg
MHgxKSA9PSAxKSB7CisJCWJhdWQrKzsKKwl9CisJcmV0dXJuIGJhdWQvMjsKK30KKworc3RhdGlj
IHZvaWQgX19pbml0IGJmaW5fc2VyaWFsX2luaXRfcG9ydHModm9pZCkKK3sKKwlzdGF0aWMgaW50
IGZpcnN0ID0gMTsKKwlpbnQgaTsKKwl1bnNpZ25lZCBzaG9ydCB2YWw7CisJaW50IGJhdWQ7CisK
KwlpZiAoIWZpcnN0KQorCQlyZXR1cm47CisJZmlyc3QgPSAwOworCWJmaW5fc2VyaWFsX2h3X2lu
aXQoKTsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsgaSsrKSB7CisJCWJmaW5fc2VyaWFs
X3BvcnRzW2ldLnBvcnQudWFydGNsayAgID0gQ09OU09MRV9CQVVEX1JBVEU7CisJCWJmaW5fc2Vy
aWFsX3BvcnRzW2ldLnBvcnQub3BzICAgICAgID0gJmJmaW5fc2VyaWFsX3BvcHM7CisJCWJmaW5f
c2VyaWFsX3BvcnRzW2ldLnBvcnQubGluZSAgICAgID0gaTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNb
aV0ucG9ydC5pb3R5cGUgICAgPSBVUElPX01FTTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9y
dC5tZW1iYXNlICAgPSAodm9pZCBfX2lvbWVtICopdWFydF9iYXNlX2FkZHJbaV07CisJCWJmaW5f
c2VyaWFsX3BvcnRzW2ldLnBvcnQubWFwYmFzZSAgID0gdWFydF9iYXNlX2FkZHJbaV07CisJCWJm
aW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQuaXJxICAgICAgID0gdWFydF9pcnFbaV07CisJCWJmaW5f
c2VyaWFsX3BvcnRzW2ldLnBvcnQuZmxhZ3MgICAgID0gVVBGX0JPT1RfQVVUT0NPTkY7CisjaWZk
ZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorCQliZmluX3NlcmlhbF9wb3J0c1tpXS50eF9kb25l
CSAgICA9IDE7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnR4X2NvdW50CSAgICA9IDA7CisJCWJm
aW5fc2VyaWFsX3BvcnRzW2ldLnR4X2RtYV9jaGFubmVsID0gdWFydF90eF9kbWFfY2hhbm5lbFtp
XTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucnhfZG1hX2NoYW5uZWwgPSB1YXJ0X3J4X2RtYV9j
aGFubmVsW2ldOworCisJCWluaXRfdGltZXIoJihiZmluX3NlcmlhbF9wb3J0c1tpXS5yeF9kbWFf
dGltZXIpKTsKKyNlbHNlCisJCUlOSVRfV09SSygmYmZpbl9zZXJpYWxfcG9ydHNbaV0uY3RzX3dv
cmtxdWV1ZSwgYmZpbl9zZXJpYWxfZG9fd29yaywgJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKyNl
bmRpZgorCisJCWJhdWQgPSBiZmluX3NlcmlhbF9jYWxjX2JhdWQoYmZpbl9zZXJpYWxfcG9ydHNb
aV0ucG9ydC51YXJ0Y2xrKTsKKworCQkvKiBFbmFibGUgVUFSVCAqLworCQl2YWwgPSBVQVJUX0dF
VF9HQ1RMKCZiZmluX3NlcmlhbF9wb3J0c1tpXSk7CisJCXZhbCB8PSBVQ0VOOworCQlVQVJUX1BV
VF9HQ1RMKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgdmFsKTsKKworCQkvKiBTZXQgRExBQiBpbiBM
Q1IgdG8gQWNjZXNzIERMTCBhbmQgRExIICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUigmYmZpbl9z
ZXJpYWxfcG9ydHNbaV0pOworCQl2YWwgfD0gRExBQjsKKwkJVUFSVF9QVVRfTENSKCZiZmluX3Nl
cmlhbF9wb3J0c1tpXSwgdmFsKTsKKworCQlVQVJUX1BVVF9ETEwoJmJmaW5fc2VyaWFsX3BvcnRz
W2ldLCBiYXVkICYgMHhGRik7CisJCVVBUlRfUFVUX0RMSCgmYmZpbl9zZXJpYWxfcG9ydHNbaV0s
IChiYXVkID4+IDgpICYgMHhGRik7CisKKwkJLyogQ2xlYXIgRExBQiBpbiBMQ1IgdG8gQWNjZXNz
IFRIUiBSQlIgSUVSICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNb
aV0pOworCQl2YWwgJj0gfkRMQUI7CisJCVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNb
aV0sIHZhbCk7CisKKwkJLyogU2V0IExDUiB0byBXb3JkIExlbmdoIDgtYml0IHdvcmQgc2VsZWN0
ICovCisJCXZhbCA9IFdMUyg4KTsKKwkJVUFSVF9QVVRfTENSKCZiZmluX3NlcmlhbF9wb3J0c1tp
XSwgdmFsKTsKKwl9Cit9CisKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fQ09OU09MRQorLyoK
KyAqIEludGVycnVwdHMgYXJlIGRpc2FibGVkIG9uIGVudGVyaW5nCisgKi8KK3N0YXRpYyB2b2lk
CitiZmluX3NlcmlhbF9jb25zb2xlX3dyaXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hh
ciAqcywgdW5zaWduZWQgaW50IGNvdW50KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1
YXJ0ID0gJmJmaW5fc2VyaWFsX3BvcnRzW2NvLT5pbmRleF07CisJaW50IGZsYWdzID0gMDsKKwl1
bnNpZ25lZCBzaG9ydCBzdGF0dXMsIHRtcDsKKwlpbnQgaTsKKworCWxvY2FsX2lycV9zYXZlKGZs
YWdzKTsKKworCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7CisJCWRvIHsKKwkJCXN0YXR1
cyA9IFVBUlRfR0VUX0xTUih1YXJ0KTsKKwkJfSB3aGlsZSAoIShzdGF0dXMgJiBUSFJFKSk7CisK
KwkJdG1wID0gVUFSVF9HRVRfTENSKHVhcnQpOworCQl0bXAgJj0gfkRMQUI7CisJCVVBUlRfUFVU
X0xDUih1YXJ0LCB0bXApOworCisJCVVBUlRfUFVUX0NIQVIodWFydCwgc1tpXSk7CisJCWlmIChz
W2ldID09ICdcbicpIHsKKwkJCWRvIHsKKwkJCQlzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7
CisJCQl9IHdoaWxlKCEoc3RhdHVzICYgVEhSRSkpOworCQkJVUFSVF9QVVRfQ0hBUih1YXJ0LCAn
XHInKTsKKwkJfQorCX0KKworCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKK30KKworLyoKKyAq
IElmIHRoZSBwb3J0IHdhcyBhbHJlYWR5IGluaXRpYWxpc2VkIChlZywgYnkgYSBib290IGxvYWRl
ciksCisgKiB0cnkgdG8gZGV0ZXJtaW5lIHRoZSBjdXJyZW50IHNldHVwLgorICovCitzdGF0aWMg
dm9pZCBfX2luaXQKK2JmaW5fc2VyaWFsX2NvbnNvbGVfZ2V0X29wdGlvbnMoc3RydWN0IGJmaW5f
c2VyaWFsX3BvcnQgKnVhcnQsIGludCAqYmF1ZCwKKwkJCSAgIGludCAqcGFyaXR5LCBpbnQgKmJp
dHMpCit7CisJdW5zaWduZWQgc2hvcnQgc3RhdHVzOworCisJc3RhdHVzID0gVUFSVF9HRVRfSUVS
KHVhcnQpICYgKEVSQkZJIHwgRVRCRUkpOworCWlmIChzdGF0dXMgPT0gKEVSQkZJIHwgRVRCRUkp
KSB7CisJCS8qIG9rLCB0aGUgcG9ydCB3YXMgZW5hYmxlZCAqLworCQl1bnNpZ25lZCBzaG9ydCBs
Y3IsIHZhbDsKKwkJdW5zaWduZWQgc2hvcnQgZGxoLCBkbGw7CisKKwkJbGNyID0gVUFSVF9HRVRf
TENSKHVhcnQpOworCisJCSpwYXJpdHkgPSAnbic7CisJCWlmIChsY3IgJiBQRU4pIHsKKwkJCWlm
IChsY3IgJiBFUFMpCisJCQkJKnBhcml0eSA9ICdlJzsKKwkJCWVsc2UKKwkJCQkqcGFyaXR5ID0g
J28nOworCQl9CisJCXN3aXRjaCAobGNyICYgMHgwMykgeworCQkJY2FzZSAwOgkqYml0cyA9IDU7
IGJyZWFrOworCQkJY2FzZSAxOgkqYml0cyA9IDY7IGJyZWFrOworCQkJY2FzZSAyOgkqYml0cyA9
IDc7IGJyZWFrOworCQkJY2FzZSAzOgkqYml0cyA9IDg7IGJyZWFrOworCQl9CisJCS8qIFNldCBE
TEFCIGluIExDUiB0byBBY2Nlc3MgRExMIGFuZCBETEggKi8KKwkJdmFsID0gVUFSVF9HRVRfTENS
KHVhcnQpOworCQl2YWwgfD0gRExBQjsKKwkJVUFSVF9QVVRfTENSKHVhcnQsIHZhbCk7CisKKwkJ
ZGxsID0gVUFSVF9HRVRfRExMKHVhcnQpOworCQlkbGggPSBVQVJUX0dFVF9ETEgodWFydCk7CisK
KwkJLyogQ2xlYXIgRExBQiBpbiBMQ1IgdG8gQWNjZXNzIFRIUiBSQlIgSUVSICovCisJCXZhbCA9
IFVBUlRfR0VUX0xDUih1YXJ0KTsKKwkJdmFsICY9IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IodWFy
dCwgdmFsKTsKKworCQkqYmF1ZCA9IGdldF9zY2xrKCkgLyAoMTYqKGRsbCB8IGRsaCA8PCA4KSk7
CisJfQorCURQUklOVEsoIiVzOmJhdWQgPSAlZCwgcGFyaXR5ID0gJWMsIGJpdHM9ICVkXG4iLCBf
X0ZVTkNUSU9OX18sICpiYXVkLCAqcGFyaXR5LCAqYml0cyk7Cit9CisKK3N0YXRpYyBpbnQgX19p
bml0CitiZmluX3NlcmlhbF9jb25zb2xlX3NldHVwKHN0cnVjdCBjb25zb2xlICpjbywgY2hhciAq
b3B0aW9ucykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydDsKKwlpbnQgYmF1ZCA9
IENPTlNPTEVfQkFVRF9SQVRFOworCWludCBiaXRzID0gODsKKwlpbnQgcGFyaXR5ID0gJ24nOwor
I2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9DVFNSVFMKKwlpbnQgZmxvdyA9ICdyJzsKKyNlbHNl
CisJaW50IGZsb3cgPSAnbic7CisjZW5kaWYKKworCS8qCisJICogQ2hlY2sgd2hldGhlciBhbiBp
bnZhbGlkIHVhcnQgbnVtYmVyIGhhcyBiZWVuIHNwZWNpZmllZCwgYW5kCisJICogaWYgc28sIHNl
YXJjaCBmb3IgdGhlIGZpcnN0IGF2YWlsYWJsZSBwb3J0IHRoYXQgZG9lcyBoYXZlCisJICogY29u
c29sZSBzdXBwb3J0LgorCSAqLworCWlmIChjby0+aW5kZXggPT0gLTEgfHwgY28tPmluZGV4ID49
IE5SX1BPUlRTKQorCQljby0+aW5kZXggPSAwOworCXVhcnQgPSAmYmZpbl9zZXJpYWxfcG9ydHNb
Y28tPmluZGV4XTsKKworCWlmIChvcHRpb25zKQorCQl1YXJ0X3BhcnNlX29wdGlvbnMob3B0aW9u
cywgJmJhdWQsICZwYXJpdHksICZiaXRzLCAmZmxvdyk7CisJZWxzZQorCQliZmluX3NlcmlhbF9j
b25zb2xlX2dldF9vcHRpb25zKHVhcnQsICZiYXVkLCAmcGFyaXR5LCAmYml0cyk7CisKKwlyZXR1
cm4gdWFydF9zZXRfb3B0aW9ucygmdWFydC0+cG9ydCwgY28sIGJhdWQsIHBhcml0eSwgYml0cywg
Zmxvdyk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9kcml2ZXIgYmZpbl9zZXJpYWxfcmVnOwor
c3RhdGljIHN0cnVjdCBjb25zb2xlIGJmaW5fc2VyaWFsX2NvbnNvbGUgPSB7CisJLm5hbWUJCT0g
InR0eVMiLAorCS53cml0ZQkJPSBiZmluX3NlcmlhbF9jb25zb2xlX3dyaXRlLAorCS5kZXZpY2UJ
CT0gdWFydF9jb25zb2xlX2RldmljZSwKKwkuc2V0dXAJCT0gYmZpbl9zZXJpYWxfY29uc29sZV9z
ZXR1cCwKKwkuZmxhZ3MJCT0gQ09OX1BSSU5UQlVGRkVSLAorCS5pbmRleAkJPSAtMSwKKwkuZGF0
YQkJPSAmYmZpbl9zZXJpYWxfcmVnLAorfTsKKworc3RhdGljIGludCBfX2luaXQgYmZpbl9zZXJp
YWxfcnNfY29uc29sZV9pbml0KHZvaWQpCit7CisJYmZpbl9zZXJpYWxfaW5pdF9wb3J0cygpOwor
CXJlZ2lzdGVyX2NvbnNvbGUoJmJmaW5fc2VyaWFsX2NvbnNvbGUpOworCXJldHVybiAwOworfQor
Y29uc29sZV9pbml0Y2FsbChiZmluX3NlcmlhbF9yc19jb25zb2xlX2luaXQpOworCisjZGVmaW5l
IEJGSU5fU0VSSUFMX0NPTlNPTEUJJmJmaW5fc2VyaWFsX2NvbnNvbGUKKyNlbHNlCisjZGVmaW5l
IEJGSU5fU0VSSUFMX0NPTlNPTEUJTlVMTAorI2VuZGlmCisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9k
cml2ZXIgYmZpbl9zZXJpYWxfcmVnID0geworCS5vd25lcgkJCT0gVEhJU19NT0RVTEUsCisJLmRy
aXZlcl9uYW1lCQk9ICJiZmluLXVhcnQiLAorCS5kZXZfbmFtZQkJPSAidHR5UyIsCisJLmRldmZz
X25hbWUJCT0gInR0eVMvIiwKKwkubWFqb3IJCQk9IFNFUklBTF9CRklOX01BSk9SLAorCS5taW5v
cgkJCT0gTUlOT1JfU1RBUlQsCisJLm5yCQkJPSBOUl9QT1JUUywKKwkuY29ucwkJCT0gQkZJTl9T
RVJJQUxfQ09OU09MRSwKK307CisKK3N0YXRpYyBpbnQgYmZpbl9zZXJpYWxfc3VzcGVuZChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKK3sKKwlzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGRldik7CisKKwlp
ZiAodWFydCkKKwkJdWFydF9zdXNwZW5kX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBv
cnQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgYmZpbl9zZXJpYWxfcmVzdW1lKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
dWFydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGRldik7CisKKwlpZiAodWFydCkKKwkJdWFydF9y
ZXN1bWVfcG9ydCgmYmZpbl9zZXJpYWxfcmVnLCAmdWFydC0+cG9ydCk7CisKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIGludCBiZmluX3NlcmlhbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpkZXYpCit7CisJc3RydWN0IHJlc291cmNlICpyZXMgPSBkZXYtPnJlc291cmNlOworCWludCBp
OworCisJZm9yIChpID0gMDsgaSA8IGRldi0+bnVtX3Jlc291cmNlczsgaSsrLCByZXMrKykKKwkJ
aWYgKHJlcy0+ZmxhZ3MgJiBJT1JFU09VUkNFX01FTSkKKwkJCWJyZWFrOworCisJaWYgKGkgPCBk
ZXYtPm51bV9yZXNvdXJjZXMpIHsKKwkJZm9yIChpID0gMDsgaSA8IE5SX1BPUlRTOyBpKyssIHJl
cysrKSB7CisJCQlpZiAoYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5tYXBiYXNlICE9IHJlcy0+
c3RhcnQpCisJCQkJY29udGludWU7CisJCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0LmRldiA9
ICZkZXYtPmRldjsKKwkJCXVhcnRfYWRkX29uZV9wb3J0KCZiZmluX3NlcmlhbF9yZWcsICZiZmlu
X3NlcmlhbF9wb3J0c1tpXS5wb3J0KTsKKwkJCXBsYXRmb3JtX3NldF9kcnZkYXRhKGRldiwgJmJm
aW5fc2VyaWFsX3BvcnRzW2ldKTsKKwkJfQorCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMg
aW50IGJmaW5fc2VyaWFsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQorewor
CXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRl
dik7CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKKworCWlmICh1YXJ0KQor
CQl1YXJ0X3JlbW92ZV9vbmVfcG9ydCgmYmZpbl9zZXJpYWxfcmVnLCAmdWFydC0+cG9ydCk7CisK
KwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYmZpbl9zZXJp
YWxfZHJpdmVyID0geworCS5wcm9iZQkJPSBiZmluX3NlcmlhbF9wcm9iZSwKKwkucmVtb3ZlCQk9
IGJmaW5fc2VyaWFsX3JlbW92ZSwKKwkuc3VzcGVuZAk9IGJmaW5fc2VyaWFsX3N1c3BlbmQsCisJ
LnJlc3VtZQkJPSBiZmluX3NlcmlhbF9yZXN1bWUsCisJLmRyaXZlcgkJPSB7CisJCS5uYW1lCT0g
ImJmaW4tdWFydCIsCisJfSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IGJmaW5fc2VyaWFsX2lu
aXQodm9pZCkKK3sKKwlpbnQgcmV0OworCisJcHJpbnRrKEtFUk5fSU5GTyAiU2VyaWFsOiBCbGFj
a2ZpbiBzZXJpYWwgZHJpdmVyXG4iKTsKKworCWJmaW5fc2VyaWFsX2luaXRfcG9ydHMoKTsKKwor
CXJldCA9IHVhcnRfcmVnaXN0ZXJfZHJpdmVyKCZiZmluX3NlcmlhbF9yZWcpOworCWlmIChyZXQg
PT0gMCkgeworCQlyZXQgPSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmJmaW5fc2VyaWFsX2Ry
aXZlcik7CisJCWlmIChyZXQpIHsKKwkJCURQUklOVEsoInVhcnQgcmVnaXN0ZXIgZmFpbGVkXG4i
KTsKKwkJCXVhcnRfdW5yZWdpc3Rlcl9kcml2ZXIoJmJmaW5fc2VyaWFsX3JlZyk7CisJCX0KKwl9
CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHZvaWQgX19leGl0IGJmaW5fc2VyaWFsX2V4aXQo
dm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmYmZpbl9zZXJpYWxfZHJpdmVy
KTsKKwl1YXJ0X3VucmVnaXN0ZXJfZHJpdmVyKCZiZmluX3NlcmlhbF9yZWcpOworfQorCittb2R1
bGVfaW5pdChiZmluX3NlcmlhbF9pbml0KTsKK21vZHVsZV9leGl0KGJmaW5fc2VyaWFsX2V4aXQp
OworCitNT0RVTEVfQVVUSE9SKCJBdWJyZXkuTGkgPGF1YnJleS5saUBhbmFsb2cuY29tPiIpOwor
TU9EVUxFX0RFU0NSSVBUSU9OKCJCbGFja2ZpbiBnZW5lcmljIHNlcmlhbCBwb3J0IGRyaXZlciIp
OworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOworTU9EVUxFX0FMSUFTX0NIQVJERVZfTUFKT1IoU0VS
SUFMX0JGSU5fTUFKT1IpOwpkaWZmIC11ck4gbGludXgtMi42LjE4LnBhdGNoMS9pbmNsdWRlL2xp
bnV4L3NlcmlhbF9jb3JlLmggbGludXgtMi42LjE4LnBhdGNoMi9pbmNsdWRlL2xpbnV4L3Nlcmlh
bF9jb3JlLmgKLS0tIGxpbnV4LTIuNi4xOC5wYXRjaDEvaW5jbHVkZS9saW51eC9zZXJpYWxfY29y
ZS5oCTIwMDYtMDktMjEgMDk6MTQ6NTQuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTgu
cGF0Y2gyL2luY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaAkyMDA2LTA5LTIxIDA5OjM4OjE3LjAw
MDAwMDAwMCArMDgwMApAQCAtMTMyLDYgKzEzMiw5IEBACiAKICNkZWZpbmUgUE9SVF9TM0MyNDEy
CTczCiAKKy8qIEJsYWNrZmluIGJmNXh4ICovCisjZGVmaW5lIFBPUlRfQkZJTgk3NAorCiAKICNp
ZmRlZiBfX0tFUk5FTF9fCiAK
------=_Part_3241_1132425.1158829311727--
