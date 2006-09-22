Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWIVFFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWIVFFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWIVFFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:05:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932272AbWIVFFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:05:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=BbcG2+HjtAzYT7WeBgaIY/YTuBYzVH5Un3/1LtE0igSlOQeQsC+waRHf5w2ssiOorcvWZzGO7lQ3mc4QtjHuw+mSKkrKx1k5286auu+PrkNMCLs7S9X248swUjDsGNq0gIDSVTaLHOiNymCcqkZQ2xayVEWyASHrHZ3jxbILoOQ=
Message-ID: <489ecd0c0609212205s4e034181h786b906168ec677f@mail.gmail.com>
Date: Fri, 22 Sep 2006 13:05:00 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
Subject: [PATCH 2/3] [BFIN] serial driver for Blackfin
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_373_6648230.1158901500512"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_373_6648230.1158901500512
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Fixed some issues and resend the patch now.

This is the serial driver for Blackfin. It is designed for the serial
core framework.

As to other drivers, I'll send them one by one later.

Signed-off-by: Luke Yang <luke.adi@gmail.com>


 drivers/serial/Kconfig      |   44 ++
 drivers/serial/Makefile     |    1
 drivers/serial/bfin_5xx.c   |  915 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    3
 4 files changed, 963 insertions(+)

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
+++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c	2006-09-22
12:16:59.000000000 +0800
@@ -0,0 +1,915 @@
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
+#undef DEBUG
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
+#define DMA_RX_XCOUNT		512
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
+ * interrupts are disabled on entry
+ */
+static void bfin_serial_stop_tx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	unsigned short ier;
+
+	ier = UART_GET_IER(uart);
+	ier &= ~ETBEI;
+	UART_PUT_IER(uart, ier);
+#ifdef CONFIG_SERIAL_BFIN_DMA
+	disable_dma(uart->tx_dma_channel);
+#endif
+}
+
+/*
+ * port is locked and interrupts are disabled
+ */
+static void bfin_serial_start_tx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+
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
+ * Interrupts are enabled
+ */
+static void bfin_serial_stop_rx(struct uart_port *port)
+{
+	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
+	unsigned short ier;
+
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
+
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
+
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
+		uart->tx_count = UART_XMIT_SIZE - xmit->tail;
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
+
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
+
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
+ * Interrupts are always disabled.
+ */
+static void bfin_serial_break_ctl(struct uart_port *port, int break_state)
+{
+}
+
+static int bfin_serial_startup(struct uart_port *port)
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
+
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
+
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

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_373_6648230.1158901500512
Content-Type: text/x-patch; name=blackfin_serial_drv_2.6.18.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ese3p6vq
Content-Disposition: attachment; filename="blackfin_serial_drv_2.6.18.patch"

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
YwkyMDA2LTA5LTIyIDEyOjE2OjU5LjAwMDAwMDAwMCArMDgwMApAQCAtMCwwICsxLDkxNSBAQAor
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
CQk2NAorCisjdW5kZWYgREVCVUcKKworI2lmZGVmIERFQlVHCisjIGRlZmluZSBEUFJJTlRLKHgu
Li4pICAgcHJpbnRrKEtFUk5fREVCVUcgeCkKKyNlbHNlCisjIGRlZmluZSBEUFJJTlRLKHguLi4p
ICAgZG8geyB9IHdoaWxlICgwKQorI2VuZGlmCisKKy8qCisgKiBTZXR1cCBmb3IgY29uc29sZS4g
QXJndW1lbnQgY29tZXMgZnJvbSB0aGUgbWVudWNvbmZpZworICovCisKKyNpZiBkZWZpbmVkKENP
TkZJR19CQVVEXzk2MDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9SQVRFICAgICAgIDk2MDAKKyNl
bGlmIGRlZmluZWQoQ09ORklHX0JBVURfMTkyMDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9SQVRF
ICAgICAgIDE5MjAwCisjZWxpZiBkZWZpbmVkKENPTkZJR19CQVVEXzM4NDAwKQorI2RlZmluZSBD
T05TT0xFX0JBVURfUkFURSAgICAgICAzODQwMAorI2VsaWYgZGVmaW5lZChDT05GSUdfQkFVRF81
NzYwMCkKKyNkZWZpbmUgQ09OU09MRV9CQVVEX1JBVEUgICAgICAgNTc2MDAKKyNlbGlmIGRlZmlu
ZWQoQ09ORklHX0JBVURfMTE1MjAwKQorI2RlZmluZSBDT05TT0xFX0JBVURfUkFURSAgICAgICAx
MTUyMDAKKyNlbmRpZgorCisjZGVmaW5lIERNQV9SWF9YQ09VTlQJCTUxMgorI2RlZmluZSBETUFf
UlhfWUNPVU5UCQkoUEFHRV9TSVpFIC8gRE1BX1JYX1hDT1VOVCkKKworI2RlZmluZSBETUFfUlhf
RkxVU0hfSklGRklFUwk1CisKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCit3YWl0X3F1
ZXVlX2hlYWRfdCBiZmluX3NlcmlhbF90eF9xdWV1ZVtOUl9QT1JUU107CitzdGF0aWMgdm9pZCBi
ZmluX3NlcmlhbF9kbWFfdHhfY2hhcnMoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQpOwor
I2Vsc2UKK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2RvX3dvcmsodm9pZCAqKTsKK3N0YXRpYyB2
b2lkIGJmaW5fc2VyaWFsX3R4X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KTsK
K3N0YXRpYyB2b2lkIGxvY2FsX3B1dF9jaGFyKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0
LCBjaGFyIGNoKTsKKyNlbmRpZgorCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9tY3RybF9jaGVj
ayhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCk7CisKKy8qCisgKiBpbnRlcnJ1cHRzIGFy
ZSBkaXNhYmxlZCBvbiBlbnRyeQorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9zdG9wX3R4
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVh
cnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCXVuc2lnbmVkIHNob3J0IGll
cjsKKworCWllciA9IFVBUlRfR0VUX0lFUih1YXJ0KTsKKwlpZXIgJj0gfkVUQkVJOworCVVBUlRf
UFVUX0lFUih1YXJ0LCBpZXIpOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlkaXNh
YmxlX2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisjZW5kaWYKK30KKworLyoKKyAqIHBvcnQg
aXMgbG9ja2VkIGFuZCBpbnRlcnJ1cHRzIGFyZSBkaXNhYmxlZAorICovCitzdGF0aWMgdm9pZCBi
ZmluX3NlcmlhbF9zdGFydF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBi
ZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsK
KworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwliZmluX3NlcmlhbF9kbWFfdHhfY2hh
cnModWFydCk7CisjZWxzZQorCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpZXIgPSBVQVJUX0dFVF9J
RVIodWFydCk7CisJaWVyIHw9IEVUQkVJOworCVVBUlRfUFVUX0lFUih1YXJ0LCBpZXIpOworCWJm
aW5fc2VyaWFsX3R4X2NoYXJzKHVhcnQpOworI2VuZGlmCit9CisKKy8qCisgKiBJbnRlcnJ1cHRz
IGFyZSBlbmFibGVkCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3N0b3Bfcngoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChz
dHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisJdW5zaWduZWQgc2hvcnQgaWVyOworCisJ
aWVyID0gVUFSVF9HRVRfSUVSKHVhcnQpOworCWllciAmPSBFUkJGSTsKKwlVQVJUX1BVVF9JRVIo
dWFydCwgaWVyKTsKK30KKworLyoKKyAqIFNldCB0aGUgbW9kZW0gY29udHJvbCB0aW1lciB0byBm
aXJlIGltbWVkaWF0ZWx5LgorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9lbmFibGVfbXMo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKK30KKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJ
Tl9QSU8KK3N0YXRpYyB2b2lkIGxvY2FsX3B1dF9jaGFyKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0
ICp1YXJ0LCBjaGFyIGNoKQoreworICAgICAgICB1bnNpZ25lZCBzaG9ydCBzdGF0dXM7CisgICAg
ICAgIGludCBmbGFncyA9IDA7CisKKyAgICAgICAgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCisg
ICAgICAgIGRvIHsKKyAgICAgICAgICAgICAgICBzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7
CisgICAgICAgIH0gd2hpbGUgKCEoc3RhdHVzICYgVEhSRSkpOworCisgICAgICAgIFVBUlRfUFVU
X0NIQVIodWFydCwgY2gpOworICAgICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7Cit9CisK
K3N0YXRpYyB2b2lkCitiZmluX3NlcmlhbF9yeF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9y
dCAqdWFydCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0IHR0eV9zdHJ1Y3QgKnR0
eSA9IHVhcnQtPnBvcnQuaW5mby0+dHR5OworCXVuc2lnbmVkIGludCBzdGF0dXM9MCwgY2gsIGZs
ZzsKKworCWNoID0gVUFSVF9HRVRfQ0hBUih1YXJ0KTsKKwl1YXJ0LT5wb3J0Lmljb3VudC5yeCsr
OworCWZsZyA9IFRUWV9OT1JNQUw7CisJaWYgKHVhcnRfaGFuZGxlX3N5c3JxX2NoYXIoJnVhcnQt
PnBvcnQsIGNoLCByZWdzKSkKKwkJZ290byBpZ25vcmVfY2hhcjsKKwl1YXJ0X2luc2VydF9jaGFy
KCZ1YXJ0LT5wb3J0LCBzdGF0dXMsIDEsIGNoLCBmbGcpOworCitpZ25vcmVfY2hhcjoKKwl0dHlf
ZmxpcF9idWZmZXJfcHVzaCh0dHkpOworfQorCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF90eF9j
aGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCkKK3sKKwlzdHJ1Y3QgY2lyY19idWYg
KnhtaXQgPSAmdWFydC0+cG9ydC5pbmZvLT54bWl0OworCisJaWYgKHVhcnQtPnBvcnQueF9jaGFy
KSB7CisJCVVBUlRfUFVUX0NIQVIodWFydCwgdWFydC0+cG9ydC54X2NoYXIpOworCQl1YXJ0LT5w
b3J0Lmljb3VudC50eCsrOworCQl1YXJ0LT5wb3J0LnhfY2hhciA9IDA7CisJCXJldHVybjsKKwl9
CisJLyoKKwkgKiBDaGVjayB0aGUgbW9kZW0gY29udHJvbCBsaW5lcyBiZWZvcmUKKwkgKiB0cmFu
c21pdHRpbmcgYW55dGhpbmcuCisJICovCisJYmZpbl9zZXJpYWxfbWN0cmxfY2hlY2sodWFydCk7
CisKKwlpZiAodWFydF9jaXJjX2VtcHR5KHhtaXQpIHx8IHVhcnRfdHhfc3RvcHBlZCgmdWFydC0+
cG9ydCkpIHsKKwkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFydC0+cG9ydCk7CisJCXJldHVybjsK
Kwl9CisKKwlsb2NhbF9wdXRfY2hhcih1YXJ0LCB4bWl0LT5idWZbeG1pdC0+dGFpbF0pOworCXht
aXQtPnRhaWwgPSAoeG1pdC0+dGFpbCArIDEpICYgKFVBUlRfWE1JVF9TSVpFIC0gMSk7CisJdWFy
dC0+cG9ydC5pY291bnQudHgrKzsKKworCWlmICh1YXJ0X2NpcmNfY2hhcnNfcGVuZGluZyh4bWl0
KSA8IFdBS0VVUF9DSEFSUykKKwkJdWFydF93cml0ZV93YWtldXAoJnVhcnQtPnBvcnQpOworCisJ
aWYgKHVhcnRfY2lyY19lbXB0eSh4bWl0KSkKKwkJYmZpbl9zZXJpYWxfc3RvcF90eCgmdWFydC0+
cG9ydCk7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBiZmluX3NlcmlhbF9pbnQoaW50IGlycSwg
dm9pZCAqZGV2X2lkLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJp
YWxfcG9ydCAqdWFydCA9IGRldl9pZDsKKwl1bnNpZ25lZCBzaG9ydCBzdGF0dXM7CisKKwlzcGlu
X2xvY2soJnVhcnQtPnBvcnQubG9jayk7CisJc3RhdHVzID0gVUFSVF9HRVRfSUlSKHVhcnQpOwor
CWRvIHsKKwkJaWYgKChzdGF0dXMgJiBJSVJfU1RBVFVTKSA9PSBJSVJfVFhfUkVBRFkpCisJCQli
ZmluX3NlcmlhbF90eF9jaGFycyh1YXJ0KTsKKwkJaWYgKChzdGF0dXMgJiBJSVJfU1RBVFVTKSA9
PSBJSVJfUlhfUkVBRFkpCisJCQliZmluX3NlcmlhbF9yeF9jaGFycyh1YXJ0LCByZWdzKTsKKwkJ
c3RhdHVzID0gVUFSVF9HRVRfSUlSKHVhcnQpOworCX0gd2hpbGUgKHN0YXR1cyAmKElJUl9UWF9S
RUFEWSB8IElJUl9SWF9SRUFEWSkpOworCXNwaW5fdW5sb2NrKCZ1YXJ0LT5wb3J0LmxvY2spOwor
CXJldHVybiBJUlFfSEFORExFRDsKK30KKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG9fd29y
ayh2b2lkICpwb3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVj
dCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKworCWJmaW5fc2VyaWFsX21jdHJsX2NoZWNrKHVh
cnQpOworfQorCisjZW5kaWYKKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKK3N0YXRp
YyB2b2lkIGJmaW5fc2VyaWFsX2RtYV90eF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
dWFydCkKK3sKKwlzdHJ1Y3QgY2lyY19idWYgKnhtaXQgPSAmdWFydC0+cG9ydC5pbmZvLT54bWl0
OworCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpbnQgZmxhZ3MgPSAwOworCisJaWYgKCF1YXJ0LT50
eF9kb25lKQorCQlyZXR1cm47CisKKwl1YXJ0LT50eF9kb25lID0gMDsKKworCWlmICh1YXJ0LT5w
b3J0LnhfY2hhcikgeworCQlVQVJUX1BVVF9DSEFSKHVhcnQsIHVhcnQtPnBvcnQueF9jaGFyKTsK
KwkJdWFydC0+cG9ydC5pY291bnQudHgrKzsKKwkJdWFydC0+cG9ydC54X2NoYXIgPSAwOworCQl1
YXJ0LT50eF9kb25lID0gMTsKKwkJcmV0dXJuOworCX0KKwkvKgorCSAqIENoZWNrIHRoZSBtb2Rl
bSBjb250cm9sIGxpbmVzIGJlZm9yZQorCSAqIHRyYW5zbWl0dGluZyBhbnl0aGluZy4KKwkgKi8K
KwliZmluX3NlcmlhbF9tY3RybF9jaGVjayh1YXJ0KTsKKworCWlmICh1YXJ0X2NpcmNfZW1wdHko
eG1pdCkgfHwgdWFydF90eF9zdG9wcGVkKCZ1YXJ0LT5wb3J0KSkgeworCQliZmluX3NlcmlhbF9z
dG9wX3R4KCZ1YXJ0LT5wb3J0KTsKKwkJdWFydC0+dHhfZG9uZSA9IDE7CisJCXJldHVybjsKKwl9
CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJdWFydC0+dHhfY291bnQgPSBDSVJDX0NOVCh4
bWl0LT5oZWFkLCB4bWl0LT50YWlsLCBVQVJUX1hNSVRfU0laRSk7CisJaWYgKHVhcnQtPnR4X2Nv
dW50ID4gKFVBUlRfWE1JVF9TSVpFIC0geG1pdC0+dGFpbCkpCisJCXVhcnQtPnR4X2NvdW50ID0g
VUFSVF9YTUlUX1NJWkUgLSB4bWl0LT50YWlsOworCWJsYWNrZmluX2RjYWNoZV9mbHVzaF9yYW5n
ZSgodW5zaWduZWQgbG9uZykoeG1pdC0+YnVmK3htaXQtPnRhaWwpLAorCQkJCQkodW5zaWduZWQg
bG9uZykoeG1pdC0+YnVmK3htaXQtPnRhaWwrdWFydC0+dHhfY291bnQpKTsKKwlzZXRfZG1hX2Nv
bmZpZyh1YXJ0LT50eF9kbWFfY2hhbm5lbCwKKwkJc2V0X2JmaW5fZG1hX2NvbmZpZyhESVJfUkVB
RCwgRE1BX0ZMT1dfU1RPUCwKKwkJCUlOVFJfT05fQlVGLAorCQkJRElNRU5TSU9OX0xJTkVBUiwK
KwkJCURBVEFfU0laRV84KSk7CisJc2V0X2RtYV9zdGFydF9hZGRyKHVhcnQtPnR4X2RtYV9jaGFu
bmVsLCAodW5zaWduZWQgbG9uZykoeG1pdC0+YnVmK3htaXQtPnRhaWwpKTsKKwlzZXRfZG1hX3hf
Y291bnQodWFydC0+dHhfZG1hX2NoYW5uZWwsIHVhcnQtPnR4X2NvdW50KTsKKwlzZXRfZG1hX3hf
bW9kaWZ5KHVhcnQtPnR4X2RtYV9jaGFubmVsLCAxKTsKKwllbmFibGVfZG1hKHVhcnQtPnR4X2Rt
YV9jaGFubmVsKTsKKwlpZXIgPSBVQVJUX0dFVF9JRVIodWFydCk7CisJaWVyIHw9IEVUQkVJOwor
CVVBUlRfUFVUX0lFUih1YXJ0LCBpZXIpOworCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKK30K
Kworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG1hX3J4X2NoYXJzKHN0cnVjdCBiZmluX3Nlcmlh
bF9wb3J0ICogdWFydCkKK3sKKwlzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5ID0gdWFydC0+cG9ydC5p
bmZvLT50dHk7CisJaW50IGksIGZsZywgc3RhdHVzID0gMDsKKworCXVhcnQtPnBvcnQuaWNvdW50
LnJ4ICs9IENJUkNfQ05UKHVhcnQtPnJ4X2RtYV9idWYuaGVhZCwgdWFydC0+cnhfZG1hX2J1Zi50
YWlsLCBVQVJUX1hNSVRfU0laRSk7OworCWZsZyA9IFRUWV9OT1JNQUw7CisJZm9yIChpID0gdWFy
dC0+cnhfZG1hX2J1Zi5oZWFkOyBpIDwgdWFydC0+cnhfZG1hX2J1Zi50YWlsOyBpKyspIHsKKwkJ
aWYgKHVhcnRfaGFuZGxlX3N5c3JxX2NoYXIoJnVhcnQtPnBvcnQsIHVhcnQtPnJ4X2RtYV9idWYu
YnVmW2ldLCBOVUxMKSkKKwkJCWdvdG8gZG1hX2lnbm9yZV9jaGFyOworCQl1YXJ0X2luc2VydF9j
aGFyKCZ1YXJ0LT5wb3J0LCBzdGF0dXMsIDEsIHVhcnQtPnJ4X2RtYV9idWYuYnVmW2ldLCBmbGcp
OworCX0KK2RtYV9pZ25vcmVfY2hhcjoKKwl0dHlfZmxpcF9idWZmZXJfcHVzaCh0dHkpOworfQor
Cit2b2lkIGJmaW5fc2VyaWFsX3J4X2RtYV90aW1lb3V0KHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0
ICp1YXJ0KQoreworCWludCB4X3BvcywgcG9zOworCWludCBmbGFncyA9IDA7CisKKwliZmluX3Nl
cmlhbF9kbWFfdHhfY2hhcnModWFydCk7CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJeF9w
b3MgPSBETUFfUlhfWENPVU5UIC0gZ2V0X2RtYV9jdXJyX3hjb3VudCh1YXJ0LT5yeF9kbWFfY2hh
bm5lbCk7CisJaWYgKHhfcG9zID09IERNQV9SWF9YQ09VTlQpCisJCXhfcG9zID0gMDsKKworCXBv
cyA9IHVhcnQtPnJ4X2RtYV9ucm93cyAqIERNQV9SWF9YQ09VTlQgKyB4X3BvczsKKworCWlmIChw
b3M+dWFydC0+cnhfZG1hX2J1Zi50YWlsKSB7CisJCXVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IHBv
czsKKwkJYmZpbl9zZXJpYWxfZG1hX3J4X2NoYXJzKHVhcnQpOworCQl1YXJ0LT5yeF9kbWFfYnVm
LmhlYWQgPSB1YXJ0LT5yeF9kbWFfYnVmLnRhaWw7CisJfQorCWxvY2FsX2lycV9yZXN0b3JlKGZs
YWdzKTsKKwl1YXJ0LT5yeF9kbWFfdGltZXIuZXhwaXJlcyA9IGppZmZpZXMgKyBETUFfUlhfRkxV
U0hfSklGRklFUzsKKwlhZGRfdGltZXIoJih1YXJ0LT5yeF9kbWFfdGltZXIpKTsKK30KKworc3Rh
dGljIGlycXJldHVybl90IGJmaW5fc2VyaWFsX2RtYV90eF9pbnQoaW50IGlycSwgdm9pZCAqZGV2
X2lkLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
dWFydCA9IGRldl9pZDsKKwlzdHJ1Y3QgY2lyY19idWYgKnhtaXQgPSAmdWFydC0+cG9ydC5pbmZv
LT54bWl0OworCXVuc2lnbmVkIHNob3J0IGllcjsKKworCXNwaW5fbG9jaygmdWFydC0+cG9ydC5s
b2NrKTsKKwlpZiAoIShnZXRfZG1hX2N1cnJfaXJxc3RhdCh1YXJ0LT50eF9kbWFfY2hhbm5lbCkm
RE1BX1JVTikpIHsKKwkJY2xlYXJfZG1hX2lycXN0YXQodWFydC0+dHhfZG1hX2NoYW5uZWwpOwor
CQlkaXNhYmxlX2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisJCWllciA9IFVBUlRfR0VUX0lF
Uih1YXJ0KTsKKwkJaWVyICY9IH5FVEJFSTsKKwkJVUFSVF9QVVRfSUVSKHVhcnQsIGllcik7CisJ
CXhtaXQtPnRhaWwgPSAoeG1pdC0+dGFpbCt1YXJ0LT50eF9jb3VudCkgJihVQVJUX1hNSVRfU0la
RSAtMSk7CisJCXVhcnQtPnBvcnQuaWNvdW50LnR4Kz11YXJ0LT50eF9jb3VudDsKKworCQlpZiAo
dWFydF9jaXJjX2NoYXJzX3BlbmRpbmcoeG1pdCkgPCBXQUtFVVBfQ0hBUlMpCisJCQl1YXJ0X3dy
aXRlX3dha2V1cCgmdWFydC0+cG9ydCk7CisKKwkJaWYgKHVhcnRfY2lyY19lbXB0eSh4bWl0KSkK
KwkJCWJmaW5fc2VyaWFsX3N0b3BfdHgoJnVhcnQtPnBvcnQpOworCQl1YXJ0LT50eF9kb25lID0g
MTsKKwl9CisKKwlzcGluX3VubG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlyZXR1cm4gSVJRX0hB
TkRMRUQ7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBiZmluX3NlcmlhbF9kbWFfcnhfaW50KGlu
dCBpcnEsIHZvaWQgKmRldl9pZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0IGJm
aW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBkZXZfaWQ7CisJdW5zaWduZWQgc2hvcnQgaXJxc3RhdDsK
KworCXVhcnQtPnJ4X2RtYV9ucm93cysrOworCWlmICh1YXJ0LT5yeF9kbWFfbnJvd3MgPT0gRE1B
X1JYX1lDT1VOVCkgeworCQl1YXJ0LT5yeF9kbWFfbnJvd3MgPSAwOworCQl1YXJ0LT5yeF9kbWFf
YnVmLnRhaWwgPSBETUFfUlhfWENPVU5UKkRNQV9SWF9ZQ09VTlQ7CisJCWJmaW5fc2VyaWFsX2Rt
YV9yeF9jaGFycyh1YXJ0KTsKKwkJdWFydC0+cnhfZG1hX2J1Zi5oZWFkID0gdWFydC0+cnhfZG1h
X2J1Zi50YWlsID0gMDsKKwl9CisJc3Bpbl9sb2NrKCZ1YXJ0LT5wb3J0LmxvY2spOworCWlycXN0
YXQgPSBnZXRfZG1hX2N1cnJfaXJxc3RhdCh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisJY2xlYXJf
ZG1hX2lycXN0YXQodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCisJc3Bpbl91bmxvY2soJnVhcnQt
PnBvcnQubG9jayk7CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorI2VuZGlmCisKKy8qCisgKiBS
ZXR1cm4gVElPQ1NFUl9URU1UIHdoZW4gdHJhbnNtaXR0ZXIgaXMgbm90IGJ1c3kuCisgKi8KK3N0
YXRpYyB1bnNpZ25lZCBpbnQgYmZpbl9zZXJpYWxfdHhfZW1wdHkoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9z
ZXJpYWxfcG9ydCAqKXBvcnQ7CisJdW5zaWduZWQgc2hvcnQgbHNyOworCisJbHNyID0gVUFSVF9H
RVRfTFNSKHVhcnQpOworCWlmIChsc3IgJiBUSFJFKQorCQlyZXR1cm4gVElPQ1NFUl9URU1UOwor
CWVsc2UKKwkJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgYmZpbl9zZXJpYWxf
Z2V0X21jdHJsKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJLyogSGFyZHdhcmUgZmxvdyBj
b250cm9sIGlzIG9ubHkgc3VwcG9ydGVkIG9uIHRoZSBmaXJzdCBwb3J0ICovCisjaWZkZWYgQ09O
RklHX1NFUklBTF9CRklOX0NUU1JUUworCWlmICgoYmZpbl9yZWFkMTYoQ1RTX1BPUlQpICYgKDEg
PDwgQ1RTX1BJTikpICYmIChwb3J0LT5saW5lID09IDApKQorCQlyZXR1cm4gVElPQ01fRFNSIHwg
VElPQ01fQ0FSOworCWVsc2UKKyNlbmRpZgorCQlyZXR1cm4gVElPQ01fQ1RTIHwgVElPQ01fRFNS
IHwgVElPQ01fQ0FSOworfQorCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9zZXRfbWN0cmwoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IG1jdHJsKQoreworI2lmZGVmIENPTkZJ
R19TRVJJQUxfQkZJTl9DVFNSVFMKKwlpZiAobWN0cmwgJiBUSU9DTV9SVFMpCisJCWJmaW5fd3Jp
dGUxNihSVFNfUE9SVCwgYmZpbl9yZWFkMTYoUlRTX1BPUlQpICYgKH4xIDw8IFJUU19QSU4pKTsK
KwllbHNlCisJCWJmaW5fd3JpdGUxNihSVFNfUE9SVCwgYmZpbl9yZWFkMTYoUlRTX1BPUlQpIHwg
KDEgPDwgUlRTX1BJTikpOworI2VuZGlmCit9CisKKy8qCisgKiBIYW5kbGUgYW55IGNoYW5nZSBv
ZiBtb2RlbSBzdGF0dXMgc2lnbmFsIHNpbmNlIHdlIHdlcmUgbGFzdCBjYWxsZWQuCisgKi8KK3N0
YXRpYyB2b2lkIGJmaW5fc2VyaWFsX21jdHJsX2NoZWNrKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0
ICp1YXJ0KQoreworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9DVFNSVFMKKwl1bnNpZ25lZCBp
bnQgc3RhdHVzOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlzdHJ1Y3QgdWFydF9p
bmZvICppbmZvID0gdWFydC0+cG9ydC5pbmZvOworCXN0cnVjdCB0dHlfc3RydWN0ICp0dHkgPSBp
bmZvLT50dHk7CisKKwlzdGF0dXMgPSBiZmluX3NlcmlhbF9nZXRfbWN0cmwoJnVhcnQtPnBvcnQp
OworCWlmICghKHN0YXR1cyAmIFRJT0NNX0NUUykpIHsKKwkJdHR5LT5od19zdG9wcGVkID0gMTsK
Kwl9IGVsc2UgeworCQl0dHktPmh3X3N0b3BwZWQgPSAwOworCX0KKyNlbHNlCisJc3RhdHVzID0g
YmZpbl9zZXJpYWxfZ2V0X21jdHJsKCZ1YXJ0LT5wb3J0KTsKKwl1YXJ0X2hhbmRsZV9jdHNfY2hh
bmdlKCZ1YXJ0LT5wb3J0LCBzdGF0dXMgJiBUSU9DTV9DVFMpOworCWlmICghKHN0YXR1cyAmIFRJ
T0NNX0NUUykpCisJCXNjaGVkdWxlX3dvcmsoJnVhcnQtPmN0c193b3JrcXVldWUpOworI2VuZGlm
CisjZW5kaWYKK30KKworLyoKKyAqIEludGVycnVwdHMgYXJlIGFsd2F5cyBkaXNhYmxlZC4KKyAq
Lworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfYnJlYWtfY3RsKHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsIGludCBicmVha19zdGF0ZSkKK3sKK30KKworc3RhdGljIGludCBiZmluX3NlcmlhbF9zdGFy
dHVwKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQg
KnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCisjaWZkZWYgQ09ORklH
X1NFUklBTF9CRklOX0RNQQorCWRtYV9hZGRyX3QgZG1hX2hhbmRsZTsKKworCWlmIChyZXF1ZXN0
X2RtYSh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgIkJGSU5fVUFSVF9SWCIpIDwgMCkgeworCQlwcmlu
dGsoS0VSTl9OT1RJQ0UgIlVuYWJsZSB0byBhdHRhY2ggQmxhY2tmaW4gVUFSVCBSWCBETUEgY2hh
bm5lbFxuIik7CisJCXJldHVybiAtRUJVU1k7CisJfQorCisJaWYgKHJlcXVlc3RfZG1hKHVhcnQt
PnR4X2RtYV9jaGFubmVsLCAiQkZJTl9VQVJUX1RYIikgPCAwKSB7CisJCXByaW50ayhLRVJOX05P
VElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja2ZpbiBVQVJUIFRYIERNQSBjaGFubmVsXG4iKTsK
KwkJZnJlZV9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCQlyZXR1cm4gLUVCVVNZOworCX0K
KworCXNldF9kbWFfY2FsbGJhY2sodWFydC0+cnhfZG1hX2NoYW5uZWwsIGJmaW5fc2VyaWFsX2Rt
YV9yeF9pbnQsIHVhcnQpOworCXNldF9kbWFfY2FsbGJhY2sodWFydC0+dHhfZG1hX2NoYW5uZWws
IGJmaW5fc2VyaWFsX2RtYV90eF9pbnQsIHVhcnQpOworCisJdWFydC0+cnhfZG1hX2J1Zi5idWYg
PSAodW5zaWduZWQgY2hhciAqKWRtYV9hbGxvY19jb2hlcmVudChOVUxMLCBQQUdFX1NJWkUsICZk
bWFfaGFuZGxlLCBHRlBfRE1BKTsKKwl1YXJ0LT5yeF9kbWFfYnVmLmhlYWQgPSAwOworCXVhcnQt
PnJ4X2RtYV9idWYudGFpbCA9IDA7CisJdWFydC0+cnhfZG1hX25yb3dzID0gMDsKKworCXNldF9k
bWFfY29uZmlnKHVhcnQtPnJ4X2RtYV9jaGFubmVsLAorCQlzZXRfYmZpbl9kbWFfY29uZmlnKERJ
Ul9XUklURSwgRE1BX0ZMT1dfQVVUTywKKwkJCQlJTlRSX09OX1JPVywgRElNRU5TSU9OXzJELAor
CQkJCURBVEFfU0laRV84KSk7CisJc2V0X2RtYV94X2NvdW50KHVhcnQtPnJ4X2RtYV9jaGFubmVs
LCBETUFfUlhfWENPVU5UKTsKKwlzZXRfZG1hX3hfbW9kaWZ5KHVhcnQtPnJ4X2RtYV9jaGFubmVs
LCAxKTsKKwlzZXRfZG1hX3lfY291bnQodWFydC0+cnhfZG1hX2NoYW5uZWwsIERNQV9SWF9ZQ09V
TlQpOworCXNldF9kbWFfeV9tb2RpZnkodWFydC0+cnhfZG1hX2NoYW5uZWwsIDEpOworCXNldF9k
bWFfc3RhcnRfYWRkcih1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgKHVuc2lnbmVkIGxvbmcpdWFydC0+
cnhfZG1hX2J1Zi5idWYpOworCWVuYWJsZV9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCisJ
dWFydC0+cnhfZG1hX3RpbWVyLmRhdGEgPSAodW5zaWduZWQgbG9uZykodWFydCk7CisJdWFydC0+
cnhfZG1hX3RpbWVyLmZ1bmN0aW9uID0gKHZvaWQgKiliZmluX3NlcmlhbF9yeF9kbWFfdGltZW91
dDsKKwl1YXJ0LT5yeF9kbWFfdGltZXIuZXhwaXJlcyA9IGppZmZpZXMgKyBETUFfUlhfRkxVU0hf
SklGRklFUzsKKwlhZGRfdGltZXIoJih1YXJ0LT5yeF9kbWFfdGltZXIpKTsKKyNlbHNlCisJaWYg
KHJlcXVlc3RfaXJxCisJICAgICh1YXJ0LT5wb3J0LmlycSwgYmZpbl9zZXJpYWxfaW50LCBJUlFG
X0RJU0FCTEVEIHwgSVJRRl9TSEFSRUQsCisJICAgICAiQkZJTl9VQVJUMF9SWCIsIHVhcnQpKSB7
CisJCXByaW50ayhLRVJOX05PVElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja0ZpbiBVQVJUIFJY
IGludGVycnVwdFxuIik7CisJCXJldHVybiAtRUJVU1k7CisJfQorCisJaWYgKHJlcXVlc3RfaXJx
CisJICAgICh1YXJ0LT5wb3J0LmlycSsxLCBiZmluX3NlcmlhbF9pbnQsIElSUUZfRElTQUJMRUQg
fCBJUlFGX1NIQVJFRCwKKwkgICAgICJCRklOX1VBUlQwX1RYIiwgdWFydCkpIHsKKwkJcHJpbnRr
KEtFUk5fTk9USUNFICJVbmFibGUgdG8gYXR0YWNoIEJsYWNrRmluIFVBUlQgVFggaW50ZXJydXB0
XG4iKTsKKwkJZnJlZV9pcnEodWFydC0+cG9ydC5pcnEsIHVhcnQpOworCQlyZXR1cm4gLUVCVVNZ
OworCX0KKyNlbmRpZgorCVVBUlRfUFVUX0lFUih1YXJ0LCBVQVJUX0dFVF9JRVIodWFydCkgfCBF
UkJGSSk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3NodXRkb3du
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVh
cnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCisjaWZkZWYgQ09ORklHX1NF
UklBTF9CRklOX0RNQQorCWRpc2FibGVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwlmcmVl
X2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisJZGlzYWJsZV9kbWEodWFydC0+cnhfZG1hX2No
YW5uZWwpOworCWZyZWVfZG1hKHVhcnQtPnJ4X2RtYV9jaGFubmVsKTsKKwlkZWxfdGltZXIoJih1
YXJ0LT5yeF9kbWFfdGltZXIpKTsKKyNlbHNlCisJZnJlZV9pcnEodWFydC0+cG9ydC5pcnEsIHVh
cnQpOworCWZyZWVfaXJxKHVhcnQtPnBvcnQuaXJxKzEsIHVhcnQpOworI2VuZGlmCit9CisKK3N0
YXRpYyB2b2lkCitiZmluX3NlcmlhbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LCBzdHJ1Y3QgdGVybWlvcyAqdGVybWlvcywKKwkJICAgc3RydWN0IHRlcm1pb3MgKm9sZCkKK3sK
K30KKworc3RhdGljIGNvbnN0IGNoYXIgKmJmaW5fc2VyaWFsX3R5cGUoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZp
bl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisKKwlyZXR1cm4gdWFydC0+cG9ydC50eXBlID09IFBPUlRf
QkZJTiA/ICJCRklOLVVBUlQiIDogTlVMTDsKK30KKworLyoKKyAqIFJlbGVhc2UgdGhlIG1lbW9y
eSByZWdpb24ocykgYmVpbmcgdXNlZCBieSAncG9ydCcuCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5f
c2VyaWFsX3JlbGVhc2VfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworfQorCisvKgor
ICogUmVxdWVzdCB0aGUgbWVtb3J5IHJlZ2lvbihzKSBiZWluZyB1c2VkIGJ5ICdwb3J0Jy4KKyAq
Lworc3RhdGljIGludCBiZmluX3NlcmlhbF9yZXF1ZXN0X3BvcnQoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCkKK3sKKwlyZXR1cm4gMDsKK30KKworLyoKKyAqIENvbmZpZ3VyZS9hdXRvY29uZmlndXJl
IHRoZSBwb3J0LgorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9jb25maWdfcG9ydChzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0LCBpbnQgZmxhZ3MpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3Bv
cnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCisJaWYgKGZsYWdz
ICYgVUFSVF9DT05GSUdfVFlQRSAmJgorCSAgICBiZmluX3NlcmlhbF9yZXF1ZXN0X3BvcnQoJnVh
cnQtPnBvcnQpID09IDApCisJCXVhcnQtPnBvcnQudHlwZSA9IFBPUlRfQkZJTjsKK30KKworLyoK
KyAqIFZlcmlmeSB0aGUgbmV3IHNlcmlhbF9zdHJ1Y3QgKGZvciBUSU9DU1NFUklBTCkuCisgKiBU
aGUgb25seSBjaGFuZ2Ugd2UgYWxsb3cgYXJlIHRvIHRoZSBmbGFncyBhbmQgdHlwZSwgYW5kCisg
KiBldmVuIHRoZW4gb25seSBiZXR3ZWVuIFBPUlRfQkZJTiBhbmQgUE9SVF9VTktOT1dOCisgKi8K
K3N0YXRpYyBpbnQKK2JmaW5fc2VyaWFsX3ZlcmlmeV9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsIHN0cnVjdCBzZXJpYWxfc3RydWN0ICpzZXIpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRp
YyBzdHJ1Y3QgdWFydF9vcHMgYmZpbl9zZXJpYWxfcG9wcyA9IHsKKwkudHhfZW1wdHkJPSBiZmlu
X3NlcmlhbF90eF9lbXB0eSwKKwkuc2V0X21jdHJsCT0gYmZpbl9zZXJpYWxfc2V0X21jdHJsLAor
CS5nZXRfbWN0cmwJPSBiZmluX3NlcmlhbF9nZXRfbWN0cmwsCisJLnN0b3BfdHgJPSBiZmluX3Nl
cmlhbF9zdG9wX3R4LAorCS5zdGFydF90eAk9IGJmaW5fc2VyaWFsX3N0YXJ0X3R4LAorCS5zdG9w
X3J4CT0gYmZpbl9zZXJpYWxfc3RvcF9yeCwKKwkuZW5hYmxlX21zCT0gYmZpbl9zZXJpYWxfZW5h
YmxlX21zLAorCS5icmVha19jdGwJPSBiZmluX3NlcmlhbF9icmVha19jdGwsCisJLnN0YXJ0dXAJ
PSBiZmluX3NlcmlhbF9zdGFydHVwLAorCS5zaHV0ZG93bgk9IGJmaW5fc2VyaWFsX3NodXRkb3du
LAorCS5zZXRfdGVybWlvcwk9IGJmaW5fc2VyaWFsX3NldF90ZXJtaW9zLAorCS50eXBlCQk9IGJm
aW5fc2VyaWFsX3R5cGUsCisJLnJlbGVhc2VfcG9ydAk9IGJmaW5fc2VyaWFsX3JlbGVhc2VfcG9y
dCwKKwkucmVxdWVzdF9wb3J0CT0gYmZpbl9zZXJpYWxfcmVxdWVzdF9wb3J0LAorCS5jb25maWdf
cG9ydAk9IGJmaW5fc2VyaWFsX2NvbmZpZ19wb3J0LAorCS52ZXJpZnlfcG9ydAk9IGJmaW5fc2Vy
aWFsX3ZlcmlmeV9wb3J0LAorfTsKKworc3RhdGljIGludCBiZmluX3NlcmlhbF9jYWxjX2JhdWQo
dW5zaWduZWQgaW50IHVhcnRjbGspCit7CisJaW50IGJhdWQ7CisKKwliYXVkID0gZ2V0X3NjbGso
KSAvICh1YXJ0Y2xrKjgpOworCWlmICgoYmF1ZCAmIDB4MSkgPT0gMSkgeworCQliYXVkKys7CisJ
fQorCXJldHVybiBiYXVkLzI7Cit9CisKK3N0YXRpYyB2b2lkIF9faW5pdCBiZmluX3NlcmlhbF9p
bml0X3BvcnRzKHZvaWQpCit7CisJc3RhdGljIGludCBmaXJzdCA9IDE7CisJaW50IGk7CisJdW5z
aWduZWQgc2hvcnQgdmFsOworCWludCBiYXVkOworCisJaWYgKCFmaXJzdCkKKwkJcmV0dXJuOwor
CWZpcnN0ID0gMDsKKwliZmluX3NlcmlhbF9od19pbml0KCk7CisKKwlmb3IgKGkgPSAwOyBpIDwg
TlJfUE9SVFM7IGkrKykgeworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0LnVhcnRjbGsgICA9
IENPTlNPTEVfQkFVRF9SQVRFOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0Lm9wcyAgICAg
ICA9ICZiZmluX3NlcmlhbF9wb3BzOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0LmxpbmUg
ICAgICA9IGk7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQuaW90eXBlICAgID0gVVBJT19N
RU07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQubWVtYmFzZSAgID0gKHZvaWQgX19pb21l
bSAqKXVhcnRfYmFzZV9hZGRyW2ldOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0Lm1hcGJh
c2UgICA9IHVhcnRfYmFzZV9hZGRyW2ldOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0Lmly
cSAgICAgICA9IHVhcnRfaXJxW2ldOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0LmZsYWdz
ICAgICA9IFVQRl9CT09UX0FVVE9DT05GOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEK
KwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0udHhfZG9uZQkgICAgPSAxOworCQliZmluX3NlcmlhbF9w
b3J0c1tpXS50eF9jb3VudAkgICAgPSAwOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS50eF9kbWFf
Y2hhbm5lbCA9IHVhcnRfdHhfZG1hX2NoYW5uZWxbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ld
LnJ4X2RtYV9jaGFubmVsID0gdWFydF9yeF9kbWFfY2hhbm5lbFtpXTsKKworCQlpbml0X3RpbWVy
KCYoYmZpbl9zZXJpYWxfcG9ydHNbaV0ucnhfZG1hX3RpbWVyKSk7CisjZWxzZQorCQlJTklUX1dP
UksoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLmN0c193b3JrcXVldWUsIGJmaW5fc2VyaWFsX2RvX3dv
cmssICZiZmluX3NlcmlhbF9wb3J0c1tpXSk7CisjZW5kaWYKKworCQliYXVkID0gYmZpbl9zZXJp
YWxfY2FsY19iYXVkKGJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQudWFydGNsayk7CisKKwkJLyog
RW5hYmxlIFVBUlQgKi8KKwkJdmFsID0gVUFSVF9HRVRfR0NUTCgmYmZpbl9zZXJpYWxfcG9ydHNb
aV0pOworCQl2YWwgfD0gVUNFTjsKKwkJVUFSVF9QVVRfR0NUTCgmYmZpbl9zZXJpYWxfcG9ydHNb
aV0sIHZhbCk7CisKKwkJLyogU2V0IERMQUIgaW4gTENSIHRvIEFjY2VzcyBETEwgYW5kIERMSCAq
LworCQl2YWwgPSBVQVJUX0dFVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKwkJdmFsIHw9
IERMQUI7CisJCVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisKKwkJ
VUFSVF9QVVRfRExMKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgYmF1ZCAmIDB4RkYpOworCQlVQVJU
X1BVVF9ETEgoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCAoYmF1ZCA+PiA4KSAmIDB4RkYpOworCisJ
CS8qIENsZWFyIERMQUIgaW4gTENSIHRvIEFjY2VzcyBUSFIgUkJSIElFUiAqLworCQl2YWwgPSBV
QVJUX0dFVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKwkJdmFsICY9IH5ETEFCOworCQlV
QVJUX1BVVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCB2YWwpOworCisJCS8qIFNldCBMQ1Ig
dG8gV29yZCBMZW5naCA4LWJpdCB3b3JkIHNlbGVjdCAqLworCQl2YWwgPSBXTFMoOCk7CisJCVVB
UlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisJfQorfQorCisjaWZkZWYg
Q09ORklHX1NFUklBTF9CRklOX0NPTlNPTEUKKy8qCisgKiBJbnRlcnJ1cHRzIGFyZSBkaXNhYmxl
ZCBvbiBlbnRlcmluZworICovCitzdGF0aWMgdm9pZAorYmZpbl9zZXJpYWxfY29uc29sZV93cml0
ZShzdHJ1Y3QgY29uc29sZSAqY28sIGNvbnN0IGNoYXIgKnMsIHVuc2lnbmVkIGludCBjb3VudCkK
K3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9ICZiZmluX3NlcmlhbF9wb3J0c1tj
by0+aW5kZXhdOworCWludCBmbGFncyA9IDA7CisJdW5zaWduZWQgc2hvcnQgc3RhdHVzLCB0bXA7
CisJaW50IGk7CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisKKwlmb3IgKGkgPSAwOyBpIDwg
Y291bnQ7IGkrKykgeworCQlkbyB7CisJCQlzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7CisJ
CX0gd2hpbGUgKCEoc3RhdHVzICYgVEhSRSkpOworCisJCXRtcCA9IFVBUlRfR0VUX0xDUih1YXJ0
KTsKKwkJdG1wICY9IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IodWFydCwgdG1wKTsKKworCQlVQVJU
X1BVVF9DSEFSKHVhcnQsIHNbaV0pOworCQlpZiAoc1tpXSA9PSAnXG4nKSB7CisJCQlkbyB7CisJ
CQkJc3RhdHVzID0gVUFSVF9HRVRfTFNSKHVhcnQpOworCQkJfSB3aGlsZSghKHN0YXR1cyAmIFRI
UkUpKTsKKwkJCVVBUlRfUFVUX0NIQVIodWFydCwgJ1xyJyk7CisJCX0KKwl9CisKKwlsb2NhbF9p
cnFfcmVzdG9yZShmbGFncyk7Cit9CisKKy8qCisgKiBJZiB0aGUgcG9ydCB3YXMgYWxyZWFkeSBp
bml0aWFsaXNlZCAoZWcsIGJ5IGEgYm9vdCBsb2FkZXIpLAorICogdHJ5IHRvIGRldGVybWluZSB0
aGUgY3VycmVudCBzZXR1cC4KKyAqLworc3RhdGljIHZvaWQgX19pbml0CitiZmluX3NlcmlhbF9j
b25zb2xlX2dldF9vcHRpb25zKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0LCBpbnQgKmJh
dWQsCisJCQkgICBpbnQgKnBhcml0eSwgaW50ICpiaXRzKQoreworCXVuc2lnbmVkIHNob3J0IHN0
YXR1czsKKworCXN0YXR1cyA9IFVBUlRfR0VUX0lFUih1YXJ0KSAmIChFUkJGSSB8IEVUQkVJKTsK
KwlpZiAoc3RhdHVzID09IChFUkJGSSB8IEVUQkVJKSkgeworCQkvKiBvaywgdGhlIHBvcnQgd2Fz
IGVuYWJsZWQgKi8KKwkJdW5zaWduZWQgc2hvcnQgbGNyLCB2YWw7CisJCXVuc2lnbmVkIHNob3J0
IGRsaCwgZGxsOworCisJCWxjciA9IFVBUlRfR0VUX0xDUih1YXJ0KTsKKworCQkqcGFyaXR5ID0g
J24nOworCQlpZiAobGNyICYgUEVOKSB7CisJCQlpZiAobGNyICYgRVBTKQorCQkJCSpwYXJpdHkg
PSAnZSc7CisJCQllbHNlCisJCQkJKnBhcml0eSA9ICdvJzsKKwkJfQorCQlzd2l0Y2ggKGxjciAm
IDB4MDMpIHsKKwkJCWNhc2UgMDoJKmJpdHMgPSA1OyBicmVhazsKKwkJCWNhc2UgMToJKmJpdHMg
PSA2OyBicmVhazsKKwkJCWNhc2UgMjoJKmJpdHMgPSA3OyBicmVhazsKKwkJCWNhc2UgMzoJKmJp
dHMgPSA4OyBicmVhazsKKwkJfQorCQkvKiBTZXQgRExBQiBpbiBMQ1IgdG8gQWNjZXNzIERMTCBh
bmQgRExIICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUih1YXJ0KTsKKwkJdmFsIHw9IERMQUI7CisJ
CVVBUlRfUFVUX0xDUih1YXJ0LCB2YWwpOworCisJCWRsbCA9IFVBUlRfR0VUX0RMTCh1YXJ0KTsK
KwkJZGxoID0gVUFSVF9HRVRfRExIKHVhcnQpOworCisJCS8qIENsZWFyIERMQUIgaW4gTENSIHRv
IEFjY2VzcyBUSFIgUkJSIElFUiAqLworCQl2YWwgPSBVQVJUX0dFVF9MQ1IodWFydCk7CisJCXZh
bCAmPSB+RExBQjsKKwkJVUFSVF9QVVRfTENSKHVhcnQsIHZhbCk7CisKKwkJKmJhdWQgPSBnZXRf
c2NsaygpIC8gKDE2KihkbGwgfCBkbGggPDwgOCkpOworCX0KKwlEUFJJTlRLKCIlczpiYXVkID0g
JWQsIHBhcml0eSA9ICVjLCBiaXRzPSAlZFxuIiwgX19GVU5DVElPTl9fLCAqYmF1ZCwgKnBhcml0
eSwgKmJpdHMpOworfQorCitzdGF0aWMgaW50IF9faW5pdAorYmZpbl9zZXJpYWxfY29uc29sZV9z
ZXR1cChzdHJ1Y3QgY29uc29sZSAqY28sIGNoYXIgKm9wdGlvbnMpCit7CisJc3RydWN0IGJmaW5f
c2VyaWFsX3BvcnQgKnVhcnQ7CisJaW50IGJhdWQgPSBDT05TT0xFX0JBVURfUkFURTsKKwlpbnQg
Yml0cyA9IDg7CisJaW50IHBhcml0eSA9ICduJzsKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5f
Q1RTUlRTCisJaW50IGZsb3cgPSAncic7CisjZWxzZQorCWludCBmbG93ID0gJ24nOworI2VuZGlm
CisKKwkvKgorCSAqIENoZWNrIHdoZXRoZXIgYW4gaW52YWxpZCB1YXJ0IG51bWJlciBoYXMgYmVl
biBzcGVjaWZpZWQsIGFuZAorCSAqIGlmIHNvLCBzZWFyY2ggZm9yIHRoZSBmaXJzdCBhdmFpbGFi
bGUgcG9ydCB0aGF0IGRvZXMgaGF2ZQorCSAqIGNvbnNvbGUgc3VwcG9ydC4KKwkgKi8KKwlpZiAo
Y28tPmluZGV4ID09IC0xIHx8IGNvLT5pbmRleCA+PSBOUl9QT1JUUykKKwkJY28tPmluZGV4ID0g
MDsKKwl1YXJ0ID0gJmJmaW5fc2VyaWFsX3BvcnRzW2NvLT5pbmRleF07CisKKwlpZiAob3B0aW9u
cykKKwkJdWFydF9wYXJzZV9vcHRpb25zKG9wdGlvbnMsICZiYXVkLCAmcGFyaXR5LCAmYml0cywg
JmZsb3cpOworCWVsc2UKKwkJYmZpbl9zZXJpYWxfY29uc29sZV9nZXRfb3B0aW9ucyh1YXJ0LCAm
YmF1ZCwgJnBhcml0eSwgJmJpdHMpOworCisJcmV0dXJuIHVhcnRfc2V0X29wdGlvbnMoJnVhcnQt
PnBvcnQsIGNvLCBiYXVkLCBwYXJpdHksIGJpdHMsIGZsb3cpOworfQorCitzdGF0aWMgc3RydWN0
IHVhcnRfZHJpdmVyIGJmaW5fc2VyaWFsX3JlZzsKK3N0YXRpYyBzdHJ1Y3QgY29uc29sZSBiZmlu
X3NlcmlhbF9jb25zb2xlID0geworCS5uYW1lCQk9ICJ0dHlTIiwKKwkud3JpdGUJCT0gYmZpbl9z
ZXJpYWxfY29uc29sZV93cml0ZSwKKwkuZGV2aWNlCQk9IHVhcnRfY29uc29sZV9kZXZpY2UsCisJ
LnNldHVwCQk9IGJmaW5fc2VyaWFsX2NvbnNvbGVfc2V0dXAsCisJLmZsYWdzCQk9IENPTl9QUklO
VEJVRkZFUiwKKwkuaW5kZXgJCT0gLTEsCisJLmRhdGEJCT0gJmJmaW5fc2VyaWFsX3JlZywKK307
CisKK3N0YXRpYyBpbnQgX19pbml0IGJmaW5fc2VyaWFsX3JzX2NvbnNvbGVfaW5pdCh2b2lkKQor
eworCWJmaW5fc2VyaWFsX2luaXRfcG9ydHMoKTsKKwlyZWdpc3Rlcl9jb25zb2xlKCZiZmluX3Nl
cmlhbF9jb25zb2xlKTsKKwlyZXR1cm4gMDsKK30KK2NvbnNvbGVfaW5pdGNhbGwoYmZpbl9zZXJp
YWxfcnNfY29uc29sZV9pbml0KTsKKworI2RlZmluZSBCRklOX1NFUklBTF9DT05TT0xFCSZiZmlu
X3NlcmlhbF9jb25zb2xlCisjZWxzZQorI2RlZmluZSBCRklOX1NFUklBTF9DT05TT0xFCU5VTEwK
KyNlbmRpZgorCitzdGF0aWMgc3RydWN0IHVhcnRfZHJpdmVyIGJmaW5fc2VyaWFsX3JlZyA9IHsK
Kwkub3duZXIJCQk9IFRISVNfTU9EVUxFLAorCS5kcml2ZXJfbmFtZQkJPSAiYmZpbi11YXJ0IiwK
KwkuZGV2X25hbWUJCT0gInR0eVMiLAorCS5kZXZmc19uYW1lCQk9ICJ0dHlTLyIsCisJLm1ham9y
CQkJPSBTRVJJQUxfQkZJTl9NQUpPUiwKKwkubWlub3IJCQk9IE1JTk9SX1NUQVJULAorCS5ucgkJ
CT0gTlJfUE9SVFMsCisJLmNvbnMJCQk9IEJGSU5fU0VSSUFMX0NPTlNPTEUsCit9OworCitzdGF0
aWMgaW50IGJmaW5fc2VyaWFsX3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2LCBw
bV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBw
bGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJaWYgKHVhcnQpCisJCXVhcnRfc3VzcGVuZF9w
b3J0KCZiZmluX3NlcmlhbF9yZWcsICZ1YXJ0LT5wb3J0KTsKKworCXJldHVybiAwOworfQorCitz
dGF0aWMgaW50IGJmaW5fc2VyaWFsX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYp
Cit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShkZXYpOworCisJaWYgKHVhcnQpCisJCXVhcnRfcmVzdW1lX3BvcnQoJmJmaW5fc2VyaWFsX3Jl
ZywgJnVhcnQtPnBvcnQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgYmZpbl9zZXJp
YWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQoreworCXN0cnVjdCByZXNvdXJj
ZSAqcmVzID0gZGV2LT5yZXNvdXJjZTsKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBkZXYt
Pm51bV9yZXNvdXJjZXM7IGkrKywgcmVzKyspCisJCWlmIChyZXMtPmZsYWdzICYgSU9SRVNPVVJD
RV9NRU0pCisJCQlicmVhazsKKworCWlmIChpIDwgZGV2LT5udW1fcmVzb3VyY2VzKSB7CisJCWZv
ciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsgaSsrLCByZXMrKykgeworCQkJaWYgKGJmaW5fc2VyaWFs
X3BvcnRzW2ldLnBvcnQubWFwYmFzZSAhPSByZXMtPnN0YXJ0KQorCQkJCWNvbnRpbnVlOworCQkJ
YmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5kZXYgPSAmZGV2LT5kZXY7CisJCQl1YXJ0X2FkZF9v
bmVfcG9ydCgmYmZpbl9zZXJpYWxfcmVnLCAmYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydCk7CisJ
CQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShkZXYsICZiZmluX3NlcmlhbF9wb3J0c1tpXSk7CisJCX0K
Kwl9CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBiZmluX3NlcmlhbF9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAq
dWFydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCisJcGxhdGZvcm1fc2V0X2RydmRh
dGEocGRldiwgTlVMTCk7CisKKwlpZiAodWFydCkKKwkJdWFydF9yZW1vdmVfb25lX3BvcnQoJmJm
aW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGJmaW5fc2VyaWFsX2RyaXZlciA9IHsKKwkucHJvYmUJCT0g
YmZpbl9zZXJpYWxfcHJvYmUsCisJLnJlbW92ZQkJPSBiZmluX3NlcmlhbF9yZW1vdmUsCisJLnN1
c3BlbmQJPSBiZmluX3NlcmlhbF9zdXNwZW5kLAorCS5yZXN1bWUJCT0gYmZpbl9zZXJpYWxfcmVz
dW1lLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9ICJiZmluLXVhcnQiLAorCX0sCit9OworCitz
dGF0aWMgaW50IF9faW5pdCBiZmluX3NlcmlhbF9pbml0KHZvaWQpCit7CisJaW50IHJldDsKKwor
CXByaW50ayhLRVJOX0lORk8gIlNlcmlhbDogQmxhY2tmaW4gc2VyaWFsIGRyaXZlclxuIik7CisK
KwliZmluX3NlcmlhbF9pbml0X3BvcnRzKCk7CisKKwlyZXQgPSB1YXJ0X3JlZ2lzdGVyX2RyaXZl
cigmYmZpbl9zZXJpYWxfcmVnKTsKKwlpZiAocmV0ID09IDApIHsKKwkJcmV0ID0gcGxhdGZvcm1f
ZHJpdmVyX3JlZ2lzdGVyKCZiZmluX3NlcmlhbF9kcml2ZXIpOworCQlpZiAocmV0KSB7CisJCQlE
UFJJTlRLKCJ1YXJ0IHJlZ2lzdGVyIGZhaWxlZFxuIik7CisJCQl1YXJ0X3VucmVnaXN0ZXJfZHJp
dmVyKCZiZmluX3NlcmlhbF9yZWcpOworCQl9CisJfQorCXJldHVybiByZXQ7Cit9CisKK3N0YXRp
YyB2b2lkIF9fZXhpdCBiZmluX3NlcmlhbF9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVy
X3VucmVnaXN0ZXIoJmJmaW5fc2VyaWFsX2RyaXZlcik7CisJdWFydF91bnJlZ2lzdGVyX2RyaXZl
cigmYmZpbl9zZXJpYWxfcmVnKTsKK30KKworbW9kdWxlX2luaXQoYmZpbl9zZXJpYWxfaW5pdCk7
Cittb2R1bGVfZXhpdChiZmluX3NlcmlhbF9leGl0KTsKKworTU9EVUxFX0FVVEhPUigiQXVicmV5
LkxpIDxhdWJyZXkubGlAYW5hbG9nLmNvbT4iKTsKK01PRFVMRV9ERVNDUklQVElPTigiQmxhY2tm
aW4gZ2VuZXJpYyBzZXJpYWwgcG9ydCBkcml2ZXIiKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsK
K01PRFVMRV9BTElBU19DSEFSREVWX01BSk9SKFNFUklBTF9CRklOX01BSk9SKTsKZGlmZiAtdXJO
IGxpbnV4LTIuNi4xOC5wYXRjaDEvaW5jbHVkZS9saW51eC9zZXJpYWxfY29yZS5oIGxpbnV4LTIu
Ni4xOC5wYXRjaDIvaW5jbHVkZS9saW51eC9zZXJpYWxfY29yZS5oCi0tLSBsaW51eC0yLjYuMTgu
cGF0Y2gxL2luY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaAkyMDA2LTA5LTIxIDA5OjE0OjU0LjAw
MDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMi9pbmNsdWRlL2xpbnV4L3Nlcmlh
bF9jb3JlLmgJMjAwNi0wOS0yMSAwOTozODoxNy4wMDAwMDAwMDAgKzA4MDAKQEAgLTEzMiw2ICsx
MzIsOSBAQAogCiAjZGVmaW5lIFBPUlRfUzNDMjQxMgk3MwogCisvKiBCbGFja2ZpbiBiZjV4eCAq
LworI2RlZmluZSBQT1JUX0JGSU4JNzQKKwogCiAjaWZkZWYgX19LRVJORUxfXwogCg==
------=_Part_373_6648230.1158901500512--
