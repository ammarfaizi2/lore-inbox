Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWIUI2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWIUI2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWIUI2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:28:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18750 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWIUI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:28:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=SNg1kLk+01akFtirfygIiONl0+hBvTpNJeOOxm93qiqmFR7ig3c4zvLfXIbFEEhVY+h6FlWbG4UuKAL25dl5aSf4k7lPB5EsFESwXH6YJuEchDa01XGIf3Inx2vEHStPjXdhcrJjFZkKq6heAx5+3bG0UYisri08IaENUWSWit0=
Message-ID: <489ecd0c0609210128l5b59554fk56436f84d22935a5@mail.gmail.com>
Date: Thu, 21 Sep 2006 16:28:31 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: "Randy. Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <6d6a94c50609210020x5bb32474wa61fab5f9581a124@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2595_16924823.1158827311478"
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <20060920222837.8b2d2a88.rdunlap@xenotime.net>
	 <6d6a94c50609210020x5bb32474wa61fab5f9581a124@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2595_16924823.1158827311478
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

OK I merged the fixes and renewed the patch.

 drivers/serial/Kconfig      |   44 ++
 drivers/serial/Makefile     |    1
 drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    3
 4 files changed, 951 insertions(+)

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
16:19:02.000000000 +0800
@@ -0,0 +1,903 @@
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
+#include <linux/config.h>
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
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+	if (bfin_read16(CTS_PORT) & (1<<CTS_PIN))
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
+		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)&(~1<<RTS_PIN));
+	else
+		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)|(1<<RTS_PIN));
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
+	} else
+		set_dma_callback(uart->rx_dma_channel, bfin_serial_dma_rx_int, uart);
+
+	if (request_dma(uart->tx_dma_channel, "BFIN_UART_TX") < 0) {
+		printk(KERN_NOTICE "Unable to attach Blackfin UART TX DMA channel\n");
+		return -EBUSY;
+	} else
+		set_dma_callback(uart->tx_dma_channel, bfin_serial_dma_tx_int, uart);
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
+	baud = get_sclk()/(uartclk*8);
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
+		UART_PUT_DLL(&bfin_serial_ports[i], baud&0xFF);
+		UART_PUT_DLH(&bfin_serial_ports[i], (baud>>8)&0xFF);
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
+		*baud = get_sclk()/(16*(dll|dlh<<8));
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


On 9/21/06, Aubrey <aubreylee@gmail.com> wrote:
> On 9/21/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Thu, 21 Sep 2006 11:33:05 +0800 Luke Yang wrote:
> >
> > > This is the serial driver for Blackfin. It is designed for the serial
> > > core framework.
> > >
> > > As to other drivers, I'll send them one by one later.
> > >
> > > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> > >
> > >  drivers/serial/Kconfig      |   35 +
> > >  drivers/serial/Makefile     |    3
> > >  drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/serial_core.h |    3
> > >  4 files changed, 943 insertions(+), 1 deletion(-)
> > >
> > > diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
> > > linux-2.6.18.patch2/drivers/serial/Kconfig
> > > --- linux-2.6.18.patch1/drivers/serial/Kconfig        2006-09-21
> > > 09:14:42.000000000 +0800
> > > +++ linux-2.6.18.patch2/drivers/serial/Kconfig        2006-09-21
> > > 09:38:17.000000000 +0800
> > > @@ -488,6 +488,41 @@
> > >         your boot loader (lilo or loadlin) about how to pass options to the
> > >         kernel at boot time.)
> > >
> > > +config SERIAL_BFIN
> > > +     bool "Blackfin serial port support (EXPERIMENTAL)"
> > > +     depends on BFIN && EXPERIMENTAL
> > > +     select SERIAL_CORE
> >
> > Just curious:  why bool and not tristate?  (i.e., why is loadable
> > module not allowed?)
>
> Thanks to point it out, this will be changed in the new patch.
>
> >
> > > +config SERIAL_BFIN_CONSOLE
> > > +     bool "Console on Blackfin serial port"
> > > +     depends on SERIAL_BFIN
> > > +     select SERIAL_CORE_CONSOLE
> > > +
> > > +choice
> > > +        prompt  "Blackfin UART Mode"
> > > +        depends on SERIAL_BFIN
> > > +        default SERIAL_BFIN_DMA
> > > +        ---help---
> > > +          This driver supports the built-in serial ports of the
> > > Blackfin family of CPUs
> > > +
> > > +config SERIAL_BFIN_DMA
> > > +        bool "Blackfin UART DMA mode"
> > > +        depends on DMA_UNCACHED_1M
> > > +        help
> > > +          This driver works under DMA mode. If this option is
> > > selected, the blackfin simple dma driver is also enabled.
> >
> > Please break that long line at < 80 columns (so that left-right
> > scrolling is not required to read it in menuconfig).
>
> It will be corrected in the new patch.
>
> >
> > > +config SERIAL_BFIN_PIO
> > > +        bool "Blackfin UART PIO mode"
> > > +        help
> > > +          This driver works under PIO mode.
> > > +endchoice
> > > +
> > > +config SERIAL_BFIN_CTSRTS
> > > +     bool "Enable hardware flow control"
> > > +     depends on SERIAL_BFIN
> > > +     help
> > > +       Enable hardware flow control in the driver. Using GPIO emulate the
> > > CTS/RTS signal.
> >
> > Split the long help text into 2 lines.
> >
> > >  config SERIAL_IMX
> > >       bool "IMX serial port support"
> > >       depends on ARM && ARCH_IMX
> >
> > > diff -urN linux-2.6.18.patch1/drivers/serial/Makefile
> > > linux-2.6.18.patch2/drivers/serial/Makefile
> > > --- linux-2.6.18.patch1/drivers/serial/Makefile       2006-09-21
> > > 09:14:42.000000000 +0800
> > > +++ linux-2.6.18.patch2/drivers/serial/Makefile       2006-09-21
> > > 09:38:17.000000000 +0800
> > > @@ -55,4 +56,4 @@
> > >  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
> > >  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
> > >  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> > > -obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> > > +obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> > > \ No newline at end of file
> >
> > What is the purpose of the change above?
>
> This shouldn't be changed, should be excluded in the patch.
> >
> > > diff -urN linux-2.6.18.patch1/drivers/serial/bfin_5xx.c
> > > linux-2.6.18.patch2/drivers/serial/bfin_5xx.c
> > > --- linux-2.6.18.patch1/drivers/serial/bfin_5xx.c     1970-01-01
> > > 08:00:00.000000000 +0800
> > > +++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c     2006-09-21
> > > 09:38:17.000000000 +0800
> > > @@ -0,0 +1,903 @@
> > > +
> > > +#include <linux/config.h>
> >
> > Don't include the config.h header file.  That's done automatically
> > by the build system.
>
> The driver is based on the current serial driver sa1100.c. But yes,
> I'll remove it in the new patch.
>
> >
> > > +static irqreturn_t bfin_serial_int(int irq, void *dev_id, struct pt_regs *regs)
> > > +{
> > > +     struct bfin_serial_port *uart = dev_id;
> > > +     unsigned short status;
> > > +
> > > +     spin_lock(&uart->port.lock);
> > > +     status = UART_GET_IIR(uart);
> > > +     do {
> > > +             if ((status & IIR_STATUS) == IIR_TX_READY)
> > > +                     bfin_serial_tx_chars(uart);
> > > +             if ((status & IIR_STATUS) == IIR_RX_READY)
> > > +                     bfin_serial_rx_chars(uart, regs);
> > > +             status = UART_GET_IIR(uart);
> > > +     } while (status &(IIR_TX_READY | IIR_RX_READY));
> > > +     spin_unlock(&uart->port.lock);
> > > +     return IRQ_HANDLED;
> >
> > So, the interrupt is requested as Shared, but then the int. handler
> > code (above here) does not check to see if the interrupt was
> > for this device.  Shouldn't it do that and then return IRQ_NONE
> > if it wasn't for this device?
> >
>
> IMHO, I don't think it's necessary. Because it's not possble that the
> interrupt occurs from a device and the handler is called by another
> one.
>
> > > +}
> > > +     bfin_serial_mctrl_check(uart);
> > > +}
> > > +
> > > +#endif
> > > +
> > > +#ifdef CONFIG_SERIAL_BFIN_DMA
> > > +static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart)
> > > +{
> > > +     struct circ_buf *xmit = &uart->port.info->xmit;
> > > +     unsigned short ier;
> > > +     int flags = 0;
> > > +
> > > +     if (!uart->tx_done)
> > > +             return;
> > > +
> > > +     uart->tx_done = 0;
> > > +
> > > +     if (uart->port.x_char) {
> > > +             UART_PUT_CHAR(uart, uart->port.x_char);
> > > +             uart->port.icount.tx++;
> > > +             uart->port.x_char = 0;
> > > +             uart->tx_done = 1;
> > > +             return;
> > > +     }
> > > +     /*
> > > +      * Check the modem control lines before
> > > +      * transmitting anything.
> > > +      */
> > > +     bfin_serial_mctrl_check(uart);
> > > +
> > > +     if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
> > > +             bfin_serial_stop_tx(&uart->port);
> > > +             uart->tx_done = 1;
> > > +             return;
> > > +     }
> > > +
> > > +     local_irq_save(flags);
> > > +     uart->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> > > +     if (uart->tx_count > (UART_XMIT_SIZE - xmit->tail))
> > > +     uart->tx_count = UART_XMIT_SIZE - xmit->tail;
> >
> > odd indentation above.
>
> Please comments the attachment on all coding style issues
>
> >
> > > +     blackfin_dcache_flush_range((unsigned long)(xmit->buf+xmit->tail),
> > > +                                     (unsigned long)(xmit->buf+xmit->tail+uart->tx_count));
> > > +     set_dma_config(uart->tx_dma_channel,
> > > +             set_bfin_dma_config(DIR_READ, DMA_FLOW_STOP,
> > > +                     INTR_ON_BUF,
> > > +                     DIMENSION_LINEAR,
> > > +                     DATA_SIZE_8));
> > > +     set_dma_start_addr(uart->tx_dma_channel, (unsigned
> > > long)(xmit->buf+xmit->tail));
> > > +     set_dma_x_count(uart->tx_dma_channel, uart->tx_count);
> > > +     set_dma_x_modify(uart->tx_dma_channel, 1);
> > > +     enable_dma(uart->tx_dma_channel);
> > > +     ier = UART_GET_IER(uart);
> > > +     ier |= ETBEI;
> > > +     UART_PUT_IER(uart, ier);
> > > +     local_irq_restore(flags);
> > > +}
> > > +
> >
> > > +static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id,
> > > struct pt_regs *regs)
> >
> > "struct" line above is a separate line but does not have a
> > beginning '+' mark, so the patch is malformed/corrupted.
> > This happened in a few other places also, so something is
> > breaking/splitting lines badly for us.  :(
> >
> > > +{
> > > +     struct bfin_serial_port *uart = dev_id;
> > > +     struct circ_buf *xmit = &uart->port.info->xmit;
> > > +     unsigned short ier;
> > > +
> > > +     spin_lock(&uart->port.lock);
> > > +     if (!(get_dma_curr_irqstat(uart->tx_dma_channel)&DMA_RUN)) {
> > > +             clear_dma_irqstat(uart->tx_dma_channel);
> > > +             disable_dma(uart->tx_dma_channel);
> > > +             ier = UART_GET_IER(uart);
> > > +             ier &= ~ETBEI;
> > > +             UART_PUT_IER(uart, ier);
> > > +             xmit->tail = (xmit->tail+uart->tx_count) &(UART_XMIT_SIZE -1);
> > > +             uart->port.icount.tx+=uart->tx_count;
> > > +
> > > +             if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > > +                     uart_write_wakeup(&uart->port);
> > > +
> > > +             if (uart_circ_empty(xmit))
> > > +                     bfin_serial_stop_tx(&uart->port);
> > > +             uart->tx_done = 1;
> > > +     }
> > > +
> > > +     spin_unlock(&uart->port.lock);
> > > +     return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id,
> > > struct pt_regs *regs)
> > > +{
> > > +     struct bfin_serial_port *uart = dev_id;
> > > +     unsigned short irqstat;
> > > +
> > > +     uart->rx_dma_nrows++;
> > > +     if (uart->rx_dma_nrows == DMA_RX_YCOUNT) {
> > > +             uart->rx_dma_nrows = 0;
> > > +             uart->rx_dma_buf.tail = DMA_RX_XCOUNT*DMA_RX_YCOUNT;
> > > +             bfin_serial_dma_rx_chars(uart);
> > > +             uart->rx_dma_buf.head = uart->rx_dma_buf.tail = 0;
> > > +     }
> > > +     spin_lock(&uart->port.lock);
> > > +     irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
> > > +     clear_dma_irqstat(uart->rx_dma_channel);
> > > +
> > > +     spin_unlock(&uart->port.lock);
> > > +     return IRQ_HANDLED;
> > > +}
> > > +#endif
> >
> > > +static unsigned int bfin_serial_get_mctrl(struct uart_port *port)
> > > +{
> > > +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> > > +     if (bfin_read16(CTS_PORT) & (1<<CTS_PIN))
> > > +             return TIOCM_DSR | TIOCM_CAR;
> > > +     else
> > > +#endif
> > > +             return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> >
> > Hardcoded return value, without reading a port, right?
>
> Right. It will be corrected in the new patch.
>
> >
> > > +}
> > > +
> > > +static void bfin_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > > +{
> > > +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> > > +     if (mctrl & TIOCM_RTS)
> > > +             bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)&(~1<<RTS_PIN));
> > > +     else
> > > +             bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)|(1<<RTS_PIN));
> > > +#endif
> > > +}
> >
> > > +int bfin_serial_startup(struct uart_port *port)
> > > +{
> > > +     struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> > > +
> > > +#ifdef CONFIG_SERIAL_BFIN_DMA
> > > +     dma_addr_t dma_handle;
> > > +
> > > +     if (request_dma(uart->rx_dma_channel, "BFIN_UART_RX") < 0) {
> > > +             printk(KERN_NOTICE "Unable to attach Blackfin UART RX DMA channel\n");
> > > +             return -EBUSY;
> > > +     } else
> > > +             set_dma_callback(uart->rx_dma_channel, bfin_serial_dma_rx_int, uart);
> > > +
> > > +     if (request_dma(uart->tx_dma_channel, "BFIN_UART_TX") < 0) {
> > > +             printk(KERN_NOTICE "Unable to attach Blackfin UART TX DMA channel\n");
> >
> > Before returning, this failure path needs to free_dma() for the
> > first request_dma() that succeeded.
> > I would also suggest doing the set_dma_callback() calls after
> > both request_dma() calls have succeeded.
> >
>
> Good suggestion.
>
> > > +             return -EBUSY;
> > > +     } else
> > > +             set_dma_callback(uart->tx_dma_channel, bfin_serial_dma_tx_int, uart);
> > > +
> > > +     uart->rx_dma_buf.buf = (unsigned char *)dma_alloc_coherent(NULL,
> > > PAGE_SIZE, &dma_handle, GFP_DMA);
> >
> > bad line split.
> >
> > > +     uart->rx_dma_buf.head = 0;
> > > +     uart->rx_dma_buf.tail = 0;
> > > +     uart->rx_dma_nrows = 0;
> > > +
> > > +     set_dma_config(uart->rx_dma_channel,
> > > +             set_bfin_dma_config(DIR_WRITE, DMA_FLOW_AUTO,
> > > +                             INTR_ON_ROW, DIMENSION_2D,
> > > +                             DATA_SIZE_8));
> > > +     set_dma_x_count(uart->rx_dma_channel, DMA_RX_XCOUNT);
> > > +     set_dma_x_modify(uart->rx_dma_channel, 1);
> > > +     set_dma_y_count(uart->rx_dma_channel, DMA_RX_YCOUNT);
> > > +     set_dma_y_modify(uart->rx_dma_channel, 1);
> > > +     set_dma_start_addr(uart->rx_dma_channel, (unsigned long)uart->rx_dma_buf.buf);
> >
> > ditto
> >
> > > +     enable_dma(uart->rx_dma_channel);
> > > +
> > > +     uart->rx_dma_timer.data = (unsigned long)(uart);
> > > +     uart->rx_dma_timer.function = (void *)bfin_serial_rx_dma_timeout;
> > > +     uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
> > > +     add_timer(&(uart->rx_dma_timer));
> > > +#else
> > > +     if (request_irq
> > > +         (uart->port.irq, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
> >
> > The request_irq() parameters have changed a bit recently.
> > SA_SHIRQ is now IRQF_SHARED and SA_INTERRUPT is IRQF_DISABLED.
> > Please change to use the new interface.
> > It is documented in Documentation/DocBook/genericirq*
> >
>
> I'll change it.
>
> > > +          "BFIN_UART0_RX", uart)) {
> > > +             printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
> > > +             return -EBUSY;
> > > +     }
> > > +
> > > +     if (request_irq
> > > +         (uart->port.irq+1, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
> > > +          "BFIN_UART0_TX", uart)) {
> > > +             printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");
> >
> > This second request_irq() failure needs to call free_irq() for the
> > first request_irq() that succeeded...
> >
>
> Yeah, will change it.
>
> > > +             return -EBUSY;
> > > +     }
> > > +#endif
> > > +     UART_PUT_IER(uart, UART_GET_IER(uart) | ERBFI);
> > > +     return 0;
> > > +}
> >
> > > +static int bfin_serial_calc_baud(unsigned int uartclk)
> > > +{
> > > +     int baud;
> > > +     baud = get_sclk()/(uartclk*8);
> >
> > Throw a few spaces in there, like so:
> >        baud = get_sclk() / (uartclk * 8);
> >
> > > +     if ((baud & 0x1) == 1) {
> > > +             baud++;
> > > +     }
> > > +     return baud/2;
> > > +}
> >
>
> It will be fixed.
>
> Thanks for your comments.
> -Aubrey
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_2595_16924823.1158827311478
Content-Type: text/x-patch; name="blackfin_serial_drv_2.6.18.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blackfin_serial_drv_2.6.18.patch"
X-Attachment-Id: f_escvqs9q

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
YwkyMDA2LTA5LTIxIDE2OjE5OjAyLjAwMDAwMDAwMCArMDgwMApAQCAtMCwwICsxLDkwMyBAQAor
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
Ki8KKworI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgorCisjaWYgZGVmaW5lZChDT05GSUdfU0VS
SUFMX0JGSU5fQ09OU09MRSkgJiYgZGVmaW5lZChDT05GSUdfTUFHSUNfU1lTUlEpCisjZGVmaW5l
IFNVUFBPUlRfU1lTUlEKKyNlbmRpZgorCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5j
bHVkZSA8bGludXgvaW9wb3J0Lmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUg
PGxpbnV4L2NvbnNvbGUuaD4KKyNpbmNsdWRlIDxsaW51eC9zeXNycS5oPgorI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L3R0eS5oPgorI2luY2x1ZGUg
PGxpbnV4L3R0eV9mbGlwLmg+CisjaW5jbHVkZSA8bGludXgvc2VyaWFsX2NvcmUuaD4KKworI2lu
Y2x1ZGUgPGFzbS9tYWNoL2JmaW5fc2VyaWFsXzV4eC5oPgorCisjaWZkZWYgQ09ORklHX1NFUklB
TF9CRklOX0RNQQorI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+CisjaW5jbHVkZSA8YXNt
L2lvLmg+CisjaW5jbHVkZSA8YXNtL2lycS5oPgorI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+
CisjZW5kaWYKKworLyogV2UndmUgYmVlbiBhc3NpZ25lZCBhIHJhbmdlIG9uIHRoZSAiTG93LWRl
bnNpdHkgc2VyaWFsIHBvcnRzIiBtYWpvciAqLworI2RlZmluZSBTRVJJQUxfQkZJTl9NQUpPUglU
VFlfTUFKT1IKKyNkZWZpbmUgTUlOT1JfU1RBUlQJCTY0CisKKyNkZWZpbmUgREVCVUcKKworI2lm
ZGVmIERFQlVHCisjIGRlZmluZSBEUFJJTlRLKHguLi4pICAgcHJpbnRrKEtFUk5fREVCVUcgeCkK
KyNlbHNlCisjIGRlZmluZSBEUFJJTlRLKHguLi4pICAgZG8geyB9IHdoaWxlICgwKQorI2VuZGlm
CisKKy8qCisgKiBTZXR1cCBmb3IgY29uc29sZS4gQXJndW1lbnQgY29tZXMgZnJvbSB0aGUgbWVu
dWNvbmZpZworICovCisKKyNpZiBkZWZpbmVkKENPTkZJR19CQVVEXzk2MDApCisjZGVmaW5lIENP
TlNPTEVfQkFVRF9SQVRFICAgICAgIDk2MDAKKyNlbGlmIGRlZmluZWQoQ09ORklHX0JBVURfMTky
MDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9SQVRFICAgICAgIDE5MjAwCisjZWxpZiBkZWZpbmVk
KENPTkZJR19CQVVEXzM4NDAwKQorI2RlZmluZSBDT05TT0xFX0JBVURfUkFURSAgICAgICAzODQw
MAorI2VsaWYgZGVmaW5lZChDT05GSUdfQkFVRF81NzYwMCkKKyNkZWZpbmUgQ09OU09MRV9CQVVE
X1JBVEUgICAgICAgNTc2MDAKKyNlbGlmIGRlZmluZWQoQ09ORklHX0JBVURfMTE1MjAwKQorI2Rl
ZmluZSBDT05TT0xFX0JBVURfUkFURSAgICAgICAxMTUyMDAKKyNlbmRpZgorCisjZGVmaW5lIERN
QV9SWF9YQ09VTlQJCVRUWV9GTElQQlVGX1NJWkUKKyNkZWZpbmUgRE1BX1JYX1lDT1VOVAkJKFBB
R0VfU0laRSAvIERNQV9SWF9YQ09VTlQpCisKKyNkZWZpbmUgRE1BX1JYX0ZMVVNIX0pJRkZJRVMJ
NQorCisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQord2FpdF9xdWV1ZV9oZWFkX3QgYmZp
bl9zZXJpYWxfdHhfcXVldWVbTlJfUE9SVFNdOworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG1h
X3R4X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KTsKKyNlbHNlCitzdGF0aWMg
dm9pZCBiZmluX3NlcmlhbF9kb193b3JrKHZvaWQgKik7CitzdGF0aWMgdm9pZCBiZmluX3Nlcmlh
bF90eF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCk7CitzdGF0aWMgdm9pZCBs
b2NhbF9wdXRfY2hhcihzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCwgY2hhciBjaCk7Cisj
ZW5kaWYKKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfbWN0cmxfY2hlY2soc3RydWN0IGJmaW5f
c2VyaWFsX3BvcnQgKnVhcnQpOworCisvKgorICogaW50ZXJydXB0cyBkaXNhYmxlZCBvbiBlbnRy
eQorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9zdG9wX3R4KHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5f
c2VyaWFsX3BvcnQgKilwb3J0OworCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpZXIgPSBVQVJUX0dF
VF9JRVIodWFydCk7CisJaWVyICY9IH5FVEJFSTsKKwlVQVJUX1BVVF9JRVIodWFydCwgaWVyKTsK
KyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisJZGlzYWJsZV9kbWEodWFydC0+dHhfZG1h
X2NoYW5uZWwpOworI2VuZGlmCit9CisKKy8qCisgKiBwb3J0IGxvY2tlZCBhbmQgaW50ZXJydXB0
cyBkaXNhYmxlZAorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9zdGFydF90eChzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0
cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5f
RE1BCisJYmZpbl9zZXJpYWxfZG1hX3R4X2NoYXJzKHVhcnQpOworI2Vsc2UKKwl1bnNpZ25lZCBz
aG9ydCBpZXI7CisJaWVyID0gVUFSVF9HRVRfSUVSKHVhcnQpOworCWllciB8PSBFVEJFSTsKKwlV
QVJUX1BVVF9JRVIodWFydCwgaWVyKTsKKwliZmluX3NlcmlhbF90eF9jaGFycyh1YXJ0KTsKKyNl
bmRpZgorfQorCisvKgorICogSW50ZXJydXB0cyBlbmFibGVkCisgKi8KK3N0YXRpYyB2b2lkIGJm
aW5fc2VyaWFsX3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZp
bl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisJ
dW5zaWduZWQgc2hvcnQgaWVyOworCWllciA9IFVBUlRfR0VUX0lFUih1YXJ0KTsKKwlpZXIgJj0g
RVJCRkk7CisJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7Cit9CisKKy8qCisgKiBTZXQgdGhlIG1v
ZGVtIGNvbnRyb2wgdGltZXIgdG8gZmlyZSBpbW1lZGlhdGVseS4KKyAqLworc3RhdGljIHZvaWQg
YmZpbl9zZXJpYWxfZW5hYmxlX21zKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7Cit9CisKKyNp
ZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fUElPCitzdGF0aWMgdm9pZCBsb2NhbF9wdXRfY2hhcihz
dHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCwgY2hhciBjaCkKK3sKKyAgICAgICAgdW5zaWdu
ZWQgc2hvcnQgc3RhdHVzOworICAgICAgICBpbnQgZmxhZ3MgPSAwOworCisgICAgICAgIGxvY2Fs
X2lycV9zYXZlKGZsYWdzKTsKKworICAgICAgICBkbyB7CisgICAgICAgICAgICAgICAgc3RhdHVz
ID0gVUFSVF9HRVRfTFNSKHVhcnQpOworICAgICAgICB9IHdoaWxlICghKHN0YXR1cyAmIFRIUkUp
KTsKKworICAgICAgICBVQVJUX1BVVF9DSEFSKHVhcnQsIGNoKTsKKyAgICAgICAgbG9jYWxfaXJx
X3Jlc3RvcmUoZmxhZ3MpOworfQorCitzdGF0aWMgdm9pZAorYmZpbl9zZXJpYWxfcnhfY2hhcnMo
c3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQorewor
CXN0cnVjdCB0dHlfc3RydWN0ICp0dHkgPSB1YXJ0LT5wb3J0LmluZm8tPnR0eTsKKwl1bnNpZ25l
ZCBpbnQgc3RhdHVzPTAsIGNoLCBmbGc7CisJY2ggPSBVQVJUX0dFVF9DSEFSKHVhcnQpOworCXVh
cnQtPnBvcnQuaWNvdW50LnJ4Kys7CisJZmxnID0gVFRZX05PUk1BTDsKKwlpZiAodWFydF9oYW5k
bGVfc3lzcnFfY2hhcigmdWFydC0+cG9ydCwgY2gsIHJlZ3MpKQorCQlnb3RvIGlnbm9yZV9jaGFy
OworCXVhcnRfaW5zZXJ0X2NoYXIoJnVhcnQtPnBvcnQsIHN0YXR1cywgMSwgY2gsIGZsZyk7CisK
K2lnbm9yZV9jaGFyOgorCXR0eV9mbGlwX2J1ZmZlcl9wdXNoKHR0eSk7Cit9CisKK3N0YXRpYyB2
b2lkIGJmaW5fc2VyaWFsX3R4X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KQor
eworCXN0cnVjdCBjaXJjX2J1ZiAqeG1pdCA9ICZ1YXJ0LT5wb3J0LmluZm8tPnhtaXQ7CisKKwlp
ZiAodWFydC0+cG9ydC54X2NoYXIpIHsKKwkJVUFSVF9QVVRfQ0hBUih1YXJ0LCB1YXJ0LT5wb3J0
LnhfY2hhcik7CisJCXVhcnQtPnBvcnQuaWNvdW50LnR4Kys7CisJCXVhcnQtPnBvcnQueF9jaGFy
ID0gMDsKKwkJcmV0dXJuOworCX0KKwkvKgorCSAqIENoZWNrIHRoZSBtb2RlbSBjb250cm9sIGxp
bmVzIGJlZm9yZQorCSAqIHRyYW5zbWl0dGluZyBhbnl0aGluZy4KKwkgKi8KKwliZmluX3Nlcmlh
bF9tY3RybF9jaGVjayh1YXJ0KTsKKworCWlmICh1YXJ0X2NpcmNfZW1wdHkoeG1pdCkgfHwgdWFy
dF90eF9zdG9wcGVkKCZ1YXJ0LT5wb3J0KSkgeworCQliZmluX3NlcmlhbF9zdG9wX3R4KCZ1YXJ0
LT5wb3J0KTsKKwkJcmV0dXJuOworCX0KKworCWxvY2FsX3B1dF9jaGFyKHVhcnQsIHhtaXQtPmJ1
Zlt4bWl0LT50YWlsXSk7CisJeG1pdC0+dGFpbCA9ICh4bWl0LT50YWlsICsgMSkgJiAoVUFSVF9Y
TUlUX1NJWkUgLSAxKTsKKwl1YXJ0LT5wb3J0Lmljb3VudC50eCsrOworCisJaWYgKHVhcnRfY2ly
Y19jaGFyc19wZW5kaW5nKHhtaXQpIDwgV0FLRVVQX0NIQVJTKQorCQl1YXJ0X3dyaXRlX3dha2V1
cCgmdWFydC0+cG9ydCk7CisKKwlpZiAodWFydF9jaXJjX2VtcHR5KHhtaXQpKQorCQliZmluX3Nl
cmlhbF9zdG9wX3R4KCZ1YXJ0LT5wb3J0KTsKK30KKworc3RhdGljIGlycXJldHVybl90IGJmaW5f
c2VyaWFsX2ludChpbnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQor
eworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gZGV2X2lkOworCXVuc2lnbmVkIHNo
b3J0IHN0YXR1czsKKworCXNwaW5fbG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlzdGF0dXMgPSBV
QVJUX0dFVF9JSVIodWFydCk7CisJZG8geworCQlpZiAoKHN0YXR1cyAmIElJUl9TVEFUVVMpID09
IElJUl9UWF9SRUFEWSkKKwkJCWJmaW5fc2VyaWFsX3R4X2NoYXJzKHVhcnQpOworCQlpZiAoKHN0
YXR1cyAmIElJUl9TVEFUVVMpID09IElJUl9SWF9SRUFEWSkKKwkJCWJmaW5fc2VyaWFsX3J4X2No
YXJzKHVhcnQsIHJlZ3MpOworCQlzdGF0dXMgPSBVQVJUX0dFVF9JSVIodWFydCk7CisJfSB3aGls
ZSAoc3RhdHVzICYoSUlSX1RYX1JFQURZIHwgSUlSX1JYX1JFQURZKSk7CisJc3Bpbl91bmxvY2so
JnVhcnQtPnBvcnQubG9jayk7CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorCitzdGF0aWMgdm9p
ZCBiZmluX3NlcmlhbF9kb193b3JrKHZvaWQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFs
X3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCWJmaW5fc2Vy
aWFsX21jdHJsX2NoZWNrKHVhcnQpOworfQorCisjZW5kaWYKKworI2lmZGVmIENPTkZJR19TRVJJ
QUxfQkZJTl9ETUEKK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2RtYV90eF9jaGFycyhzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCkKK3sKKwlzdHJ1Y3QgY2lyY19idWYgKnhtaXQgPSAmdWFy
dC0+cG9ydC5pbmZvLT54bWl0OworCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpbnQgZmxhZ3MgPSAw
OworCisJaWYgKCF1YXJ0LT50eF9kb25lKQorCQlyZXR1cm47CisKKwl1YXJ0LT50eF9kb25lID0g
MDsKKworCWlmICh1YXJ0LT5wb3J0LnhfY2hhcikgeworCQlVQVJUX1BVVF9DSEFSKHVhcnQsIHVh
cnQtPnBvcnQueF9jaGFyKTsKKwkJdWFydC0+cG9ydC5pY291bnQudHgrKzsKKwkJdWFydC0+cG9y
dC54X2NoYXIgPSAwOworCQl1YXJ0LT50eF9kb25lID0gMTsKKwkJcmV0dXJuOworCX0KKwkvKgor
CSAqIENoZWNrIHRoZSBtb2RlbSBjb250cm9sIGxpbmVzIGJlZm9yZQorCSAqIHRyYW5zbWl0dGlu
ZyBhbnl0aGluZy4KKwkgKi8KKwliZmluX3NlcmlhbF9tY3RybF9jaGVjayh1YXJ0KTsKKworCWlm
ICh1YXJ0X2NpcmNfZW1wdHkoeG1pdCkgfHwgdWFydF90eF9zdG9wcGVkKCZ1YXJ0LT5wb3J0KSkg
eworCQliZmluX3NlcmlhbF9zdG9wX3R4KCZ1YXJ0LT5wb3J0KTsKKwkJdWFydC0+dHhfZG9uZSA9
IDE7CisJCXJldHVybjsKKwl9CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJdWFydC0+dHhf
Y291bnQgPSBDSVJDX0NOVCh4bWl0LT5oZWFkLCB4bWl0LT50YWlsLCBVQVJUX1hNSVRfU0laRSk7
CisJaWYgKHVhcnQtPnR4X2NvdW50ID4gKFVBUlRfWE1JVF9TSVpFIC0geG1pdC0+dGFpbCkpCisJ
dWFydC0+dHhfY291bnQgPSBVQVJUX1hNSVRfU0laRSAtIHhtaXQtPnRhaWw7CisJYmxhY2tmaW5f
ZGNhY2hlX2ZsdXNoX3JhbmdlKCh1bnNpZ25lZCBsb25nKSh4bWl0LT5idWYreG1pdC0+dGFpbCks
CisJCQkJCSh1bnNpZ25lZCBsb25nKSh4bWl0LT5idWYreG1pdC0+dGFpbCt1YXJ0LT50eF9jb3Vu
dCkpOworCXNldF9kbWFfY29uZmlnKHVhcnQtPnR4X2RtYV9jaGFubmVsLAorCQlzZXRfYmZpbl9k
bWFfY29uZmlnKERJUl9SRUFELCBETUFfRkxPV19TVE9QLAorCQkJSU5UUl9PTl9CVUYsCisJCQlE
SU1FTlNJT05fTElORUFSLAorCQkJREFUQV9TSVpFXzgpKTsKKwlzZXRfZG1hX3N0YXJ0X2FkZHIo
dWFydC0+dHhfZG1hX2NoYW5uZWwsICh1bnNpZ25lZCBsb25nKSh4bWl0LT5idWYreG1pdC0+dGFp
bCkpOworCXNldF9kbWFfeF9jb3VudCh1YXJ0LT50eF9kbWFfY2hhbm5lbCwgdWFydC0+dHhfY291
bnQpOworCXNldF9kbWFfeF9tb2RpZnkodWFydC0+dHhfZG1hX2NoYW5uZWwsIDEpOworCWVuYWJs
ZV9kbWEodWFydC0+dHhfZG1hX2NoYW5uZWwpOworCWllciA9IFVBUlRfR0VUX0lFUih1YXJ0KTsK
KwlpZXIgfD0gRVRCRUk7CisJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7CisJbG9jYWxfaXJxX3Jl
c3RvcmUoZmxhZ3MpOworfQorCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9kbWFfcnhfY2hhcnMo
c3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKiB1YXJ0KQoreworCXN0cnVjdCB0dHlfc3RydWN0ICp0
dHkgPSB1YXJ0LT5wb3J0LmluZm8tPnR0eTsKKwlpbnQgaSwgZmxnLCBzdGF0dXMgPSAwOworCisJ
dWFydC0+cG9ydC5pY291bnQucnggKz0gQ0lSQ19DTlQodWFydC0+cnhfZG1hX2J1Zi5oZWFkLCB1
YXJ0LT5yeF9kbWFfYnVmLnRhaWwsIFVBUlRfWE1JVF9TSVpFKTs7CisJZmxnID0gVFRZX05PUk1B
TDsKKwlmb3IgKGkgPSB1YXJ0LT5yeF9kbWFfYnVmLmhlYWQ7IGkgPCB1YXJ0LT5yeF9kbWFfYnVm
LnRhaWw7IGkrKykgeworCQlpZiAodWFydF9oYW5kbGVfc3lzcnFfY2hhcigmdWFydC0+cG9ydCwg
dWFydC0+cnhfZG1hX2J1Zi5idWZbaV0sIE5VTEwpKQorCQkJZ290byBkbWFfaWdub3JlX2NoYXI7
CisJCXVhcnRfaW5zZXJ0X2NoYXIoJnVhcnQtPnBvcnQsIHN0YXR1cywgMSwgdWFydC0+cnhfZG1h
X2J1Zi5idWZbaV0sIGZsZyk7CisJfQorZG1hX2lnbm9yZV9jaGFyOgorCXR0eV9mbGlwX2J1ZmZl
cl9wdXNoKHR0eSk7Cit9CisKK3ZvaWQgYmZpbl9zZXJpYWxfcnhfZG1hX3RpbWVvdXQoc3RydWN0
IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQpCit7CisJaW50IHhfcG9zLCBwb3M7CisJaW50IGZsYWdz
ID0gMDsKKworCWJmaW5fc2VyaWFsX2RtYV90eF9jaGFycyh1YXJ0KTsKKworCWxvY2FsX2lycV9z
YXZlKGZsYWdzKTsKKwl4X3BvcyA9IERNQV9SWF9YQ09VTlQgLSBnZXRfZG1hX2N1cnJfeGNvdW50
KHVhcnQtPnJ4X2RtYV9jaGFubmVsKTsKKwlpZiAoeF9wb3MgPT0gRE1BX1JYX1hDT1VOVCkKKwkJ
eF9wb3MgPSAwOworCisJcG9zID0gdWFydC0+cnhfZG1hX25yb3dzICogRE1BX1JYX1hDT1VOVCAr
IHhfcG9zOworCisJaWYgKHBvcz51YXJ0LT5yeF9kbWFfYnVmLnRhaWwpIHsKKwkJdWFydC0+cnhf
ZG1hX2J1Zi50YWlsID0gcG9zOworCQliZmluX3NlcmlhbF9kbWFfcnhfY2hhcnModWFydCk7CisJ
CXVhcnQtPnJ4X2RtYV9idWYuaGVhZCA9IHVhcnQtPnJ4X2RtYV9idWYudGFpbDsKKwl9CisJbG9j
YWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOworCXVhcnQtPnJ4X2RtYV90aW1lci5leHBpcmVzID0gamlm
ZmllcyArIERNQV9SWF9GTFVTSF9KSUZGSUVTOworCWFkZF90aW1lcigmKHVhcnQtPnJ4X2RtYV90
aW1lcikpOworfQorCitzdGF0aWMgaXJxcmV0dXJuX3QgYmZpbl9zZXJpYWxfZG1hX3R4X2ludChp
bnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQoreworCXN0cnVjdCBi
ZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gZGV2X2lkOworCXN0cnVjdCBjaXJjX2J1ZiAqeG1pdCA9
ICZ1YXJ0LT5wb3J0LmluZm8tPnhtaXQ7CisJdW5zaWduZWQgc2hvcnQgaWVyOworCisJc3Bpbl9s
b2NrKCZ1YXJ0LT5wb3J0LmxvY2spOworCWlmICghKGdldF9kbWFfY3Vycl9pcnFzdGF0KHVhcnQt
PnR4X2RtYV9jaGFubmVsKSZETUFfUlVOKSkgeworCQljbGVhcl9kbWFfaXJxc3RhdCh1YXJ0LT50
eF9kbWFfY2hhbm5lbCk7CisJCWRpc2FibGVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwkJ
aWVyID0gVUFSVF9HRVRfSUVSKHVhcnQpOworCQlpZXIgJj0gfkVUQkVJOworCQlVQVJUX1BVVF9J
RVIodWFydCwgaWVyKTsKKwkJeG1pdC0+dGFpbCA9ICh4bWl0LT50YWlsK3VhcnQtPnR4X2NvdW50
KSAmKFVBUlRfWE1JVF9TSVpFIC0xKTsKKwkJdWFydC0+cG9ydC5pY291bnQudHgrPXVhcnQtPnR4
X2NvdW50OworCisJCWlmICh1YXJ0X2NpcmNfY2hhcnNfcGVuZGluZyh4bWl0KSA8IFdBS0VVUF9D
SEFSUykKKwkJCXVhcnRfd3JpdGVfd2FrZXVwKCZ1YXJ0LT5wb3J0KTsKKworCQlpZiAodWFydF9j
aXJjX2VtcHR5KHhtaXQpKQorCQkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFydC0+cG9ydCk7CisJ
CXVhcnQtPnR4X2RvbmUgPSAxOworCX0KKworCXNwaW5fdW5sb2NrKCZ1YXJ0LT5wb3J0LmxvY2sp
OworCXJldHVybiBJUlFfSEFORExFRDsKK30KKworc3RhdGljIGlycXJldHVybl90IGJmaW5fc2Vy
aWFsX2RtYV9yeF9pbnQoaW50IGlycSwgdm9pZCAqZGV2X2lkLCBzdHJ1Y3QgcHRfcmVncyAqcmVn
cykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IGRldl9pZDsKKwl1bnNpZ25l
ZCBzaG9ydCBpcnFzdGF0OworCisJdWFydC0+cnhfZG1hX25yb3dzKys7CisJaWYgKHVhcnQtPnJ4
X2RtYV9ucm93cyA9PSBETUFfUlhfWUNPVU5UKSB7CisJCXVhcnQtPnJ4X2RtYV9ucm93cyA9IDA7
CisJCXVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IERNQV9SWF9YQ09VTlQqRE1BX1JYX1lDT1VOVDsK
KwkJYmZpbl9zZXJpYWxfZG1hX3J4X2NoYXJzKHVhcnQpOworCQl1YXJ0LT5yeF9kbWFfYnVmLmhl
YWQgPSB1YXJ0LT5yeF9kbWFfYnVmLnRhaWwgPSAwOworCX0KKwlzcGluX2xvY2soJnVhcnQtPnBv
cnQubG9jayk7CisJaXJxc3RhdCA9IGdldF9kbWFfY3Vycl9pcnFzdGF0KHVhcnQtPnJ4X2RtYV9j
aGFubmVsKTsKKwljbGVhcl9kbWFfaXJxc3RhdCh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisKKwlz
cGluX3VubG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9Cisj
ZW5kaWYKKworLyoKKyAqIFJldHVybiBUSU9DU0VSX1RFTVQgd2hlbiB0cmFuc21pdHRlciBpcyBu
b3QgYnVzeS4KKyAqLworc3RhdGljIHVuc2lnbmVkIGludCBiZmluX3NlcmlhbF90eF9lbXB0eShz
dHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0
ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKwl1bnNpZ25lZCBzaG9ydCBsc3I7
CisJbHNyID0gVUFSVF9HRVRfTFNSKHVhcnQpOworCWlmIChsc3IgJiBUSFJFKQorCQlyZXR1cm4g
VElPQ1NFUl9URU1UOworCWVsc2UKKwkJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBp
bnQgYmZpbl9zZXJpYWxfZ2V0X21jdHJsKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisjaWZk
ZWYgQ09ORklHX1NFUklBTF9CRklOX0NUU1JUUworCWlmIChiZmluX3JlYWQxNihDVFNfUE9SVCkg
JiAoMTw8Q1RTX1BJTikpCisJCXJldHVybiBUSU9DTV9EU1IgfCBUSU9DTV9DQVI7CisJZWxzZQor
I2VuZGlmCisJCXJldHVybiBUSU9DTV9DVFMgfCBUSU9DTV9EU1IgfCBUSU9DTV9DQVI7Cit9CisK
K3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3NldF9tY3RybChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LCB1bnNpZ25lZCBpbnQgbWN0cmwpCit7CisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0NUU1JU
UworCWlmIChtY3RybCAmIFRJT0NNX1JUUykKKwkJYmZpbl93cml0ZTE2KFJUU19QT1JULCBiZmlu
X3JlYWQxNihSVFNfUE9SVCkmKH4xPDxSVFNfUElOKSk7CisJZWxzZQorCQliZmluX3dyaXRlMTYo
UlRTX1BPUlQsIGJmaW5fcmVhZDE2KFJUU19QT1JUKXwoMTw8UlRTX1BJTikpOworI2VuZGlmCit9
CisKKy8qCisgKiBIYW5kbGUgYW55IGNoYW5nZSBvZiBtb2RlbSBzdGF0dXMgc2lnbmFsIHNpbmNl
IHdlIHdlcmUgbGFzdCBjYWxsZWQuCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX21jdHJs
X2NoZWNrKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KQoreworI2lmZGVmIENPTkZJR19T
RVJJQUxfQkZJTl9DVFNSVFMKKwl1bnNpZ25lZCBpbnQgc3RhdHVzOworI2lmZGVmIENPTkZJR19T
RVJJQUxfQkZJTl9ETUEKKwlzdHJ1Y3QgdWFydF9pbmZvICppbmZvID0gdWFydC0+cG9ydC5pbmZv
OworCXN0cnVjdCB0dHlfc3RydWN0ICp0dHkgPSBpbmZvLT50dHk7CisJc3RhdHVzID0gYmZpbl9z
ZXJpYWxfZ2V0X21jdHJsKCZ1YXJ0LT5wb3J0KTsKKwlpZiAoIShzdGF0dXMgJiBUSU9DTV9DVFMp
KSB7CisJCXR0eS0+aHdfc3RvcHBlZCA9IDE7CisJfSBlbHNlIHsKKwkJdHR5LT5od19zdG9wcGVk
ID0gMDsKKwl9CisjZWxzZQorCXN0YXR1cyA9IGJmaW5fc2VyaWFsX2dldF9tY3RybCgmdWFydC0+
cG9ydCk7CisJdWFydF9oYW5kbGVfY3RzX2NoYW5nZSgmdWFydC0+cG9ydCwgc3RhdHVzICYgVElP
Q01fQ1RTKTsKKwlpZiAoIShzdGF0dXMgJiBUSU9DTV9DVFMpKQorCQlzY2hlZHVsZV93b3JrKCZ1
YXJ0LT5jdHNfd29ya3F1ZXVlKTsKKyNlbmRpZgorI2VuZGlmCit9CisKKy8qCisgKiBJbnRlcnJ1
cHRzIGFsd2F5cyBkaXNhYmxlZC4KKyAqLworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfYnJlYWtf
Y3RsKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIGludCBicmVha19zdGF0ZSkKK3sKK30KKworaW50
IGJmaW5fc2VyaWFsX3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7
CisKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisJZG1hX2FkZHJfdCBkbWFfaGFuZGxl
OworCisJaWYgKHJlcXVlc3RfZG1hKHVhcnQtPnJ4X2RtYV9jaGFubmVsLCAiQkZJTl9VQVJUX1JY
IikgPCAwKSB7CisJCXByaW50ayhLRVJOX05PVElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja2Zp
biBVQVJUIFJYIERNQSBjaGFubmVsXG4iKTsKKwkJcmV0dXJuIC1FQlVTWTsKKwl9IGVsc2UKKwkJ
c2V0X2RtYV9jYWxsYmFjayh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgYmZpbl9zZXJpYWxfZG1hX3J4
X2ludCwgdWFydCk7CisKKwlpZiAocmVxdWVzdF9kbWEodWFydC0+dHhfZG1hX2NoYW5uZWwsICJC
RklOX1VBUlRfVFgiKSA8IDApIHsKKwkJcHJpbnRrKEtFUk5fTk9USUNFICJVbmFibGUgdG8gYXR0
YWNoIEJsYWNrZmluIFVBUlQgVFggRE1BIGNoYW5uZWxcbiIpOworCQlyZXR1cm4gLUVCVVNZOwor
CX0gZWxzZQorCQlzZXRfZG1hX2NhbGxiYWNrKHVhcnQtPnR4X2RtYV9jaGFubmVsLCBiZmluX3Nl
cmlhbF9kbWFfdHhfaW50LCB1YXJ0KTsKKworCXVhcnQtPnJ4X2RtYV9idWYuYnVmID0gKHVuc2ln
bmVkIGNoYXIgKilkbWFfYWxsb2NfY29oZXJlbnQoTlVMTCwgUEFHRV9TSVpFLCAmZG1hX2hhbmRs
ZSwgR0ZQX0RNQSk7CisJdWFydC0+cnhfZG1hX2J1Zi5oZWFkID0gMDsKKwl1YXJ0LT5yeF9kbWFf
YnVmLnRhaWwgPSAwOworCXVhcnQtPnJ4X2RtYV9ucm93cyA9IDA7CisKKwlzZXRfZG1hX2NvbmZp
Zyh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwKKwkJc2V0X2JmaW5fZG1hX2NvbmZpZyhESVJfV1JJVEUs
IERNQV9GTE9XX0FVVE8sCisJCQkJSU5UUl9PTl9ST1csIERJTUVOU0lPTl8yRCwKKwkJCQlEQVRB
X1NJWkVfOCkpOworCXNldF9kbWFfeF9jb3VudCh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgRE1BX1JY
X1hDT1VOVCk7CisJc2V0X2RtYV94X21vZGlmeSh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgMSk7CisJ
c2V0X2RtYV95X2NvdW50KHVhcnQtPnJ4X2RtYV9jaGFubmVsLCBETUFfUlhfWUNPVU5UKTsKKwlz
ZXRfZG1hX3lfbW9kaWZ5KHVhcnQtPnJ4X2RtYV9jaGFubmVsLCAxKTsKKwlzZXRfZG1hX3N0YXJ0
X2FkZHIodWFydC0+cnhfZG1hX2NoYW5uZWwsICh1bnNpZ25lZCBsb25nKXVhcnQtPnJ4X2RtYV9i
dWYuYnVmKTsKKwllbmFibGVfZG1hKHVhcnQtPnJ4X2RtYV9jaGFubmVsKTsKKworCXVhcnQtPnJ4
X2RtYV90aW1lci5kYXRhID0gKHVuc2lnbmVkIGxvbmcpKHVhcnQpOworCXVhcnQtPnJ4X2RtYV90
aW1lci5mdW5jdGlvbiA9ICh2b2lkICopYmZpbl9zZXJpYWxfcnhfZG1hX3RpbWVvdXQ7CisJdWFy
dC0+cnhfZG1hX3RpbWVyLmV4cGlyZXMgPSBqaWZmaWVzICsgRE1BX1JYX0ZMVVNIX0pJRkZJRVM7
CisJYWRkX3RpbWVyKCYodWFydC0+cnhfZG1hX3RpbWVyKSk7CisjZWxzZQorCWlmIChyZXF1ZXN0
X2lycQorCSAgICAodWFydC0+cG9ydC5pcnEsIGJmaW5fc2VyaWFsX2ludCwgSVJRRl9ESVNBQkxF
RCB8IElSUUZfU0hBUkVELAorCSAgICAgIkJGSU5fVUFSVDBfUlgiLCB1YXJ0KSkgeworCQlwcmlu
dGsoS0VSTl9OT1RJQ0UgIlVuYWJsZSB0byBhdHRhY2ggQmxhY2tGaW4gVUFSVCBSWCBpbnRlcnJ1
cHRcbiIpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKworCWlmIChyZXF1ZXN0X2lycQorCSAgICAo
dWFydC0+cG9ydC5pcnErMSwgYmZpbl9zZXJpYWxfaW50LCBJUlFGX0RJU0FCTEVEIHwgSVJRRl9T
SEFSRUQsCisJICAgICAiQkZJTl9VQVJUMF9UWCIsIHVhcnQpKSB7CisJCXByaW50ayhLRVJOX05P
VElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja0ZpbiBVQVJUIFRYIGludGVycnVwdFxuIik7CisJ
CXJldHVybiAtRUJVU1k7CisJfQorI2VuZGlmCisJVUFSVF9QVVRfSUVSKHVhcnQsIFVBUlRfR0VU
X0lFUih1YXJ0KSB8IEVSQkZJKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgYmZpbl9z
ZXJpYWxfc2h1dGRvd24oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9z
ZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisKKyNp
ZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisJZGlzYWJsZV9kbWEodWFydC0+dHhfZG1hX2No
YW5uZWwpOworCWZyZWVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwlkaXNhYmxlX2RtYSh1
YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisJZnJlZV9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwpOwor
CWRlbF90aW1lcigmKHVhcnQtPnJ4X2RtYV90aW1lcikpOworI2Vsc2UKKwlmcmVlX2lycSh1YXJ0
LT5wb3J0LmlycSwgdWFydCk7CisJZnJlZV9pcnEodWFydC0+cG9ydC5pcnErMSwgdWFydCk7Cisj
ZW5kaWYKK30KKworc3RhdGljIHZvaWQKK2JmaW5fc2VyaWFsX3NldF90ZXJtaW9zKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCB0ZXJtaW9zICp0ZXJtaW9zLAorCQkgICBzdHJ1Y3QgdGVy
bWlvcyAqb2xkKQoreworfQorCitzdGF0aWMgY29uc3QgY2hhciAqYmZpbl9zZXJpYWxfdHlwZShz
dHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0
ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKwlyZXR1cm4gdWFydC0+cG9ydC50
eXBlID09IFBPUlRfQkZJTiA/ICJCRklOLVVBUlQiIDogTlVMTDsKK30KKworLyoKKyAqIFJlbGVh
c2UgdGhlIG1lbW9yeSByZWdpb24ocykgYmVpbmcgdXNlZCBieSAncG9ydCcuCisgKi8KK3N0YXRp
YyB2b2lkIGJmaW5fc2VyaWFsX3JlbGVhc2VfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQor
eworfQorCisvKgorICogUmVxdWVzdCB0aGUgbWVtb3J5IHJlZ2lvbihzKSBiZWluZyB1c2VkIGJ5
ICdwb3J0Jy4KKyAqLworc3RhdGljIGludCBiZmluX3NlcmlhbF9yZXF1ZXN0X3BvcnQoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlyZXR1cm4gMDsKK30KKworLyoKKyAqIENvbmZpZ3VyZS9h
dXRvY29uZmlndXJlIHRoZSBwb3J0LgorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9jb25m
aWdfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBpbnQgZmxhZ3MpCit7CisJc3RydWN0IGJm
aW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0Owor
CisJaWYgKGZsYWdzICYgVUFSVF9DT05GSUdfVFlQRSAmJgorCSAgICBiZmluX3NlcmlhbF9yZXF1
ZXN0X3BvcnQoJnVhcnQtPnBvcnQpID09IDApCisJCXVhcnQtPnBvcnQudHlwZSA9IFBPUlRfQkZJ
TjsKK30KKworLyoKKyAqIFZlcmlmeSB0aGUgbmV3IHNlcmlhbF9zdHJ1Y3QgKGZvciBUSU9DU1NF
UklBTCkuCisgKiBUaGUgb25seSBjaGFuZ2Ugd2UgYWxsb3cgYXJlIHRvIHRoZSBmbGFncyBhbmQg
dHlwZSwgYW5kCisgKiBldmVuIHRoZW4gb25seSBiZXR3ZWVuIFBPUlRfQkZJTiBhbmQgUE9SVF9V
TktOT1dOCisgKi8KK3N0YXRpYyBpbnQKK2JmaW5fc2VyaWFsX3ZlcmlmeV9wb3J0KHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfc3RydWN0ICpzZXIpCit7CisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9vcHMgYmZpbl9zZXJpYWxfcG9wcyA9IHsKKwkudHhf
ZW1wdHkJPSBiZmluX3NlcmlhbF90eF9lbXB0eSwKKwkuc2V0X21jdHJsCT0gYmZpbl9zZXJpYWxf
c2V0X21jdHJsLAorCS5nZXRfbWN0cmwJPSBiZmluX3NlcmlhbF9nZXRfbWN0cmwsCisJLnN0b3Bf
dHgJPSBiZmluX3NlcmlhbF9zdG9wX3R4LAorCS5zdGFydF90eAk9IGJmaW5fc2VyaWFsX3N0YXJ0
X3R4LAorCS5zdG9wX3J4CT0gYmZpbl9zZXJpYWxfc3RvcF9yeCwKKwkuZW5hYmxlX21zCT0gYmZp
bl9zZXJpYWxfZW5hYmxlX21zLAorCS5icmVha19jdGwJPSBiZmluX3NlcmlhbF9icmVha19jdGws
CisJLnN0YXJ0dXAJPSBiZmluX3NlcmlhbF9zdGFydHVwLAorCS5zaHV0ZG93bgk9IGJmaW5fc2Vy
aWFsX3NodXRkb3duLAorCS5zZXRfdGVybWlvcwk9IGJmaW5fc2VyaWFsX3NldF90ZXJtaW9zLAor
CS50eXBlCQk9IGJmaW5fc2VyaWFsX3R5cGUsCisJLnJlbGVhc2VfcG9ydAk9IGJmaW5fc2VyaWFs
X3JlbGVhc2VfcG9ydCwKKwkucmVxdWVzdF9wb3J0CT0gYmZpbl9zZXJpYWxfcmVxdWVzdF9wb3J0
LAorCS5jb25maWdfcG9ydAk9IGJmaW5fc2VyaWFsX2NvbmZpZ19wb3J0LAorCS52ZXJpZnlfcG9y
dAk9IGJmaW5fc2VyaWFsX3ZlcmlmeV9wb3J0LAorfTsKKworc3RhdGljIGludCBiZmluX3Nlcmlh
bF9jYWxjX2JhdWQodW5zaWduZWQgaW50IHVhcnRjbGspCit7CisJaW50IGJhdWQ7CisJYmF1ZCA9
IGdldF9zY2xrKCkvKHVhcnRjbGsqOCk7CisJaWYgKChiYXVkICYgMHgxKSA9PSAxKSB7CisJCWJh
dWQrKzsKKwl9CisJcmV0dXJuIGJhdWQvMjsKK30KKworc3RhdGljIHZvaWQgX19pbml0IGJmaW5f
c2VyaWFsX2luaXRfcG9ydHModm9pZCkKK3sKKwlzdGF0aWMgaW50IGZpcnN0ID0gMTsKKwlpbnQg
aTsKKwl1bnNpZ25lZCBzaG9ydCB2YWw7CisJaW50IGJhdWQ7CisKKwlpZiAoIWZpcnN0KQorCQly
ZXR1cm47CisJZmlyc3QgPSAwOworCWJmaW5fc2VyaWFsX2h3X2luaXQoKTsKKworCWZvciAoaSA9
IDA7IGkgPCBOUl9QT1JUUzsgaSsrKSB7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQudWFy
dGNsayAgID0gQ09OU09MRV9CQVVEX1JBVEU7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQu
b3BzICAgICAgID0gJmJmaW5fc2VyaWFsX3BvcHM7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBv
cnQubGluZSAgICAgID0gaTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5pb3R5cGUgICAg
PSBVUElPX01FTTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5tZW1iYXNlICAgPSAodm9p
ZCBfX2lvbWVtICopdWFydF9iYXNlX2FkZHJbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBv
cnQubWFwYmFzZSAgID0gdWFydF9iYXNlX2FkZHJbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ld
LnBvcnQuaXJxICAgICAgID0gdWFydF9pcnFbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBv
cnQuZmxhZ3MgICAgID0gVVBGX0JPT1RfQVVUT0NPTkY7CisjaWZkZWYgQ09ORklHX1NFUklBTF9C
RklOX0RNQQorCQliZmluX3NlcmlhbF9wb3J0c1tpXS50eF9kb25lCSAgICA9IDE7CisJCWJmaW5f
c2VyaWFsX3BvcnRzW2ldLnR4X2NvdW50CSAgICA9IDA7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ld
LnR4X2RtYV9jaGFubmVsID0gdWFydF90eF9kbWFfY2hhbm5lbFtpXTsKKwkJYmZpbl9zZXJpYWxf
cG9ydHNbaV0ucnhfZG1hX2NoYW5uZWwgPSB1YXJ0X3J4X2RtYV9jaGFubmVsW2ldOworCisJCWlu
aXRfdGltZXIoJihiZmluX3NlcmlhbF9wb3J0c1tpXS5yeF9kbWFfdGltZXIpKTsKKyNlbHNlCisJ
CUlOSVRfV09SSygmYmZpbl9zZXJpYWxfcG9ydHNbaV0uY3RzX3dvcmtxdWV1ZSwgYmZpbl9zZXJp
YWxfZG9fd29yaywgJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKyNlbmRpZgorCisJCWJhdWQgPSBi
ZmluX3NlcmlhbF9jYWxjX2JhdWQoYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC51YXJ0Y2xrKTsK
KworCQkvKiBFbmFibGUgVUFSVCAqLworCQl2YWwgPSBVQVJUX0dFVF9HQ1RMKCZiZmluX3Nlcmlh
bF9wb3J0c1tpXSk7CisJCXZhbCB8PSBVQ0VOOworCQlVQVJUX1BVVF9HQ1RMKCZiZmluX3Nlcmlh
bF9wb3J0c1tpXSwgdmFsKTsKKworCQkvKiBTZXQgRExBQiBpbiBMQ1IgdG8gQWNjZXNzIERMTCBh
bmQgRExIICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0pOwor
CQl2YWwgfD0gRExBQjsKKwkJVUFSVF9QVVRfTENSKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgdmFs
KTsKKworCQlVQVJUX1BVVF9ETEwoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCBiYXVkJjB4RkYpOwor
CQlVQVJUX1BVVF9ETEgoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCAoYmF1ZD4+OCkmMHhGRik7CisK
KwkJLyogQ2xlYXIgRExBQiBpbiBMQ1IgdG8gQWNjZXNzIFRIUiBSQlIgSUVSICovCisJCXZhbCA9
IFVBUlRfR0VUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0pOworCQl2YWwgJj0gfkRMQUI7CisJ
CVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisKKwkJLyogU2V0IExD
UiB0byBXb3JkIExlbmdoIDgtYml0IHdvcmQgc2VsZWN0ICovCisJCXZhbCA9IFdMUyg4KTsKKwkJ
VUFSVF9QVVRfTENSKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgdmFsKTsKKwl9Cit9CisKKyNpZmRl
ZiBDT05GSUdfU0VSSUFMX0JGSU5fQ09OU09MRQorLyoKKyAqIEludGVycnVwdHMgYXJlIGRpc2Fi
bGVkIG9uIGVudGVyaW5nCisgKi8KK3N0YXRpYyB2b2lkCitiZmluX3NlcmlhbF9jb25zb2xlX3dy
aXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqcywgdW5zaWduZWQgaW50IGNvdW50
KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gJmJmaW5fc2VyaWFsX3BvcnRz
W2NvLT5pbmRleF07CisJaW50IGZsYWdzID0gMDsKKwl1bnNpZ25lZCBzaG9ydCBzdGF0dXMsIHRt
cDsKKwlpbnQgaTsKKworCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKworCWZvciAoaSA9IDA7IGkg
PCBjb3VudDsgaSsrKSB7CisJCWRvIHsKKwkJCXN0YXR1cyA9IFVBUlRfR0VUX0xTUih1YXJ0KTsK
KwkJfSB3aGlsZSAoIShzdGF0dXMgJiBUSFJFKSk7CisKKwkJdG1wID0gVUFSVF9HRVRfTENSKHVh
cnQpOworCQl0bXAgJj0gfkRMQUI7CisJCVVBUlRfUFVUX0xDUih1YXJ0LCB0bXApOworCisJCVVB
UlRfUFVUX0NIQVIodWFydCwgc1tpXSk7CisJCWlmIChzW2ldID09ICdcbicpIHsKKwkJCWRvIHsK
KwkJCQlzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7CisJCQl9IHdoaWxlKCEoc3RhdHVzICYg
VEhSRSkpOworCQkJVUFSVF9QVVRfQ0hBUih1YXJ0LCAnXHInKTsKKwkJfQorCX0KKworCWxvY2Fs
X2lycV9yZXN0b3JlKGZsYWdzKTsKK30KKworLyoKKyAqIElmIHRoZSBwb3J0IHdhcyBhbHJlYWR5
IGluaXRpYWxpc2VkIChlZywgYnkgYSBib290IGxvYWRlciksCisgKiB0cnkgdG8gZGV0ZXJtaW5l
IHRoZSBjdXJyZW50IHNldHVwLgorICovCitzdGF0aWMgdm9pZCBfX2luaXQKK2JmaW5fc2VyaWFs
X2NvbnNvbGVfZ2V0X29wdGlvbnMoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQsIGludCAq
YmF1ZCwKKwkJCSAgIGludCAqcGFyaXR5LCBpbnQgKmJpdHMpCit7CisJdW5zaWduZWQgc2hvcnQg
c3RhdHVzOworCisJc3RhdHVzID0gVUFSVF9HRVRfSUVSKHVhcnQpICYgKEVSQkZJIHwgRVRCRUkp
OworCWlmIChzdGF0dXMgPT0gKEVSQkZJIHwgRVRCRUkpKSB7CisJCS8qIG9rLCB0aGUgcG9ydCB3
YXMgZW5hYmxlZCAqLworCQl1bnNpZ25lZCBzaG9ydCBsY3IsIHZhbDsKKwkJdW5zaWduZWQgc2hv
cnQgZGxoLCBkbGw7CisKKwkJbGNyID0gVUFSVF9HRVRfTENSKHVhcnQpOworCisJCSpwYXJpdHkg
PSAnbic7CisJCWlmIChsY3IgJiBQRU4pIHsKKwkJCWlmIChsY3IgJiBFUFMpCisJCQkJKnBhcml0
eSA9ICdlJzsKKwkJCWVsc2UKKwkJCQkqcGFyaXR5ID0gJ28nOworCQl9CisJCXN3aXRjaCAobGNy
ICYgMHgwMykgeworCQkJY2FzZSAwOgkqYml0cyA9IDU7IGJyZWFrOworCQkJY2FzZSAxOgkqYml0
cyA9IDY7IGJyZWFrOworCQkJY2FzZSAyOgkqYml0cyA9IDc7IGJyZWFrOworCQkJY2FzZSAzOgkq
Yml0cyA9IDg7IGJyZWFrOworCQl9CisJCS8qIFNldCBETEFCIGluIExDUiB0byBBY2Nlc3MgRExM
IGFuZCBETEggKi8KKwkJdmFsID0gVUFSVF9HRVRfTENSKHVhcnQpOworCQl2YWwgfD0gRExBQjsK
KwkJVUFSVF9QVVRfTENSKHVhcnQsIHZhbCk7CisKKwkJZGxsID0gVUFSVF9HRVRfRExMKHVhcnQp
OworCQlkbGggPSBVQVJUX0dFVF9ETEgodWFydCk7CisKKwkJLyogQ2xlYXIgRExBQiBpbiBMQ1Ig
dG8gQWNjZXNzIFRIUiBSQlIgSUVSICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUih1YXJ0KTsKKwkJ
dmFsICY9IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IodWFydCwgdmFsKTsKKworCQkqYmF1ZCA9IGdl
dF9zY2xrKCkvKDE2KihkbGx8ZGxoPDw4KSk7CisJfQorCURQUklOVEsoIiVzOmJhdWQgPSAlZCwg
cGFyaXR5ID0gJWMsIGJpdHM9ICVkXG4iLCBfX0ZVTkNUSU9OX18sICpiYXVkLCAqcGFyaXR5LCAq
Yml0cyk7Cit9CisKK3N0YXRpYyBpbnQgX19pbml0CitiZmluX3NlcmlhbF9jb25zb2xlX3NldHVw
KHN0cnVjdCBjb25zb2xlICpjbywgY2hhciAqb3B0aW9ucykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJp
YWxfcG9ydCAqdWFydDsKKwlpbnQgYmF1ZCA9IENPTlNPTEVfQkFVRF9SQVRFOworCWludCBiaXRz
ID0gODsKKwlpbnQgcGFyaXR5ID0gJ24nOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9DVFNS
VFMKKwlpbnQgZmxvdyA9ICdyJzsKKyNlbHNlCisJaW50IGZsb3cgPSAnbic7CisjZW5kaWYKKwor
CS8qCisJICogQ2hlY2sgd2hldGhlciBhbiBpbnZhbGlkIHVhcnQgbnVtYmVyIGhhcyBiZWVuIHNw
ZWNpZmllZCwgYW5kCisJICogaWYgc28sIHNlYXJjaCBmb3IgdGhlIGZpcnN0IGF2YWlsYWJsZSBw
b3J0IHRoYXQgZG9lcyBoYXZlCisJICogY29uc29sZSBzdXBwb3J0LgorCSAqLworCWlmIChjby0+
aW5kZXggPT0gLTEgfHwgY28tPmluZGV4ID49IE5SX1BPUlRTKQorCQljby0+aW5kZXggPSAwOwor
CXVhcnQgPSAmYmZpbl9zZXJpYWxfcG9ydHNbY28tPmluZGV4XTsKKworCWlmIChvcHRpb25zKQor
CQl1YXJ0X3BhcnNlX29wdGlvbnMob3B0aW9ucywgJmJhdWQsICZwYXJpdHksICZiaXRzLCAmZmxv
dyk7CisJZWxzZQorCQliZmluX3NlcmlhbF9jb25zb2xlX2dldF9vcHRpb25zKHVhcnQsICZiYXVk
LCAmcGFyaXR5LCAmYml0cyk7CisKKwlyZXR1cm4gdWFydF9zZXRfb3B0aW9ucygmdWFydC0+cG9y
dCwgY28sIGJhdWQsIHBhcml0eSwgYml0cywgZmxvdyk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdWFy
dF9kcml2ZXIgYmZpbl9zZXJpYWxfcmVnOworc3RhdGljIHN0cnVjdCBjb25zb2xlIGJmaW5fc2Vy
aWFsX2NvbnNvbGUgPSB7CisJLm5hbWUJCT0gInR0eVMiLAorCS53cml0ZQkJPSBiZmluX3Nlcmlh
bF9jb25zb2xlX3dyaXRlLAorCS5kZXZpY2UJCT0gdWFydF9jb25zb2xlX2RldmljZSwKKwkuc2V0
dXAJCT0gYmZpbl9zZXJpYWxfY29uc29sZV9zZXR1cCwKKwkuZmxhZ3MJCT0gQ09OX1BSSU5UQlVG
RkVSLAorCS5pbmRleAkJPSAtMSwKKwkuZGF0YQkJPSAmYmZpbl9zZXJpYWxfcmVnLAorfTsKKwor
c3RhdGljIGludCBfX2luaXQgYmZpbl9zZXJpYWxfcnNfY29uc29sZV9pbml0KHZvaWQpCit7CisJ
YmZpbl9zZXJpYWxfaW5pdF9wb3J0cygpOworCXJlZ2lzdGVyX2NvbnNvbGUoJmJmaW5fc2VyaWFs
X2NvbnNvbGUpOworCXJldHVybiAwOworfQorY29uc29sZV9pbml0Y2FsbChiZmluX3NlcmlhbF9y
c19jb25zb2xlX2luaXQpOworCisjZGVmaW5lIEJGSU5fU0VSSUFMX0NPTlNPTEUJJmJmaW5fc2Vy
aWFsX2NvbnNvbGUKKyNlbHNlCisjZGVmaW5lIEJGSU5fU0VSSUFMX0NPTlNPTEUJTlVMTAorI2Vu
ZGlmCisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9kcml2ZXIgYmZpbl9zZXJpYWxfcmVnID0geworCS5v
d25lcgkJCT0gVEhJU19NT0RVTEUsCisJLmRyaXZlcl9uYW1lCQk9ICJiZmluLXVhcnQiLAorCS5k
ZXZfbmFtZQkJPSAidHR5UyIsCisJLm1ham9yCQkJPSBTRVJJQUxfQkZJTl9NQUpPUiwKKwkubWlu
b3IJCQk9IE1JTk9SX1NUQVJULAorCS5ucgkJCT0gTlJfUE9SVFMsCisJLmNvbnMJCQk9IEJGSU5f
U0VSSUFMX0NPTlNPTEUsCit9OworCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3N1c3BlbmQoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0
IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJ
aWYgKHVhcnQpCisJCXVhcnRfc3VzcGVuZF9wb3J0KCZiZmluX3NlcmlhbF9yZWcsICZ1YXJ0LT5w
b3J0KTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3Jlc3VtZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQg
KnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJaWYgKHVhcnQpCisJCXVhcnRf
cmVzdW1lX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOworCisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyBpbnQgYmZpbl9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqZGV2KQoreworCXN0cnVjdCByZXNvdXJjZSAqcmVzID0gZGV2LT5yZXNvdXJjZTsKKwlpbnQg
aTsKKworCWZvciAoaSA9IDA7IGkgPCBkZXYtPm51bV9yZXNvdXJjZXM7IGkrKywgcmVzKyspCisJ
CWlmIChyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9NRU0pCisJCQlicmVhazsKKworCWlmIChpIDwg
ZGV2LT5udW1fcmVzb3VyY2VzKSB7CisJCWZvciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsgaSsrLCBy
ZXMrKykgeworCQkJaWYgKGJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQubWFwYmFzZSAhPSByZXMt
PnN0YXJ0KQorCQkJCWNvbnRpbnVlOworCQkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5kZXYg
PSAmZGV2LT5kZXY7CisJCQl1YXJ0X2FkZF9vbmVfcG9ydCgmYmZpbl9zZXJpYWxfcmVnLCAmYmZp
bl9zZXJpYWxfcG9ydHNbaV0ucG9ydCk7CisJCQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShkZXYsICZi
ZmluX3NlcmlhbF9wb3J0c1tpXSk7CisJCX0KKwl9CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGlj
IGludCBiZmluX3NlcmlhbF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sK
KwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBk
ZXYpOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisKKwlpZiAodWFydCkK
KwkJdWFydF9yZW1vdmVfb25lX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOwor
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGJmaW5fc2Vy
aWFsX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gYmZpbl9zZXJpYWxfcHJvYmUsCisJLnJlbW92ZQkJ
PSBiZmluX3NlcmlhbF9yZW1vdmUsCisJLnN1c3BlbmQJPSBiZmluX3NlcmlhbF9zdXNwZW5kLAor
CS5yZXN1bWUJCT0gYmZpbl9zZXJpYWxfcmVzdW1lLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9
ICJiZmluLXVhcnQiLAorCX0sCit9OworCitzdGF0aWMgaW50IF9faW5pdCBiZmluX3NlcmlhbF9p
bml0KHZvaWQpCit7CisJaW50IHJldDsKKworCXByaW50ayhLRVJOX0lORk8gIlNlcmlhbDogQmxh
Y2tmaW4gc2VyaWFsIGRyaXZlclxuIik7CisKKwliZmluX3NlcmlhbF9pbml0X3BvcnRzKCk7CisK
KwlyZXQgPSB1YXJ0X3JlZ2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKKwlpZiAocmV0
ID09IDApIHsKKwkJcmV0ID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZiZmluX3NlcmlhbF9k
cml2ZXIpOworCQlpZiAocmV0KSB7CisJCQlEUFJJTlRLKCJ1YXJ0IHJlZ2lzdGVyIGZhaWxlZFxu
Iik7CisJCQl1YXJ0X3VucmVnaXN0ZXJfZHJpdmVyKCZiZmluX3NlcmlhbF9yZWcpOworCQl9CisJ
fQorCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBiZmluX3NlcmlhbF9leGl0
KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmJmaW5fc2VyaWFsX2RyaXZl
cik7CisJdWFydF91bnJlZ2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKK30KKworbW9k
dWxlX2luaXQoYmZpbl9zZXJpYWxfaW5pdCk7Cittb2R1bGVfZXhpdChiZmluX3NlcmlhbF9leGl0
KTsKKworTU9EVUxFX0FVVEhPUigiQXVicmV5LkxpIDxhdWJyZXkubGlAYW5hbG9nLmNvbT4iKTsK
K01PRFVMRV9ERVNDUklQVElPTigiQmxhY2tmaW4gZ2VuZXJpYyBzZXJpYWwgcG9ydCBkcml2ZXIi
KTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVMRV9BTElBU19DSEFSREVWX01BSk9SKFNF
UklBTF9CRklOX01BSk9SKTsKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvaW5jbHVkZS9s
aW51eC9zZXJpYWxfY29yZS5oIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9saW51eC9zZXJp
YWxfY29yZS5oCi0tLSBsaW51eC0yLjYuMTgucGF0Y2gxL2luY2x1ZGUvbGludXgvc2VyaWFsX2Nv
cmUuaAkyMDA2LTA5LTIxIDA5OjE0OjU0LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4
LnBhdGNoMi9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgJMjAwNi0wOS0yMSAwOTozODoxNy4w
MDAwMDAwMDAgKzA4MDAKQEAgLTEzMiw2ICsxMzIsOSBAQAogCiAjZGVmaW5lIFBPUlRfUzNDMjQx
Mgk3MwogCisvKiBCbGFja2ZpbiBiZjV4eCAqLworI2RlZmluZSBQT1JUX0JGSU4JNzQKKwogCiAj
aWZkZWYgX19LRVJORUxfXwogCg==
------=_Part_2595_16924823.1158827311478--
