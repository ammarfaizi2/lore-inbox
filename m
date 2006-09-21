Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWIUJ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWIUJ5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWIUJ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:57:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:17694 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751105AbWIUJ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:57:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ZSho7OoRocs538StKoFKHIIHGXSKVCR96T1QC0RBGvD1yuOaZ1Qx5HwACEcwEVUPnbCPnzT71RmSNnSpBBXs8toBDip/502ubNphMxZ46aGPZvrrYdOWNKnfhT6GMiCI1ICGaUdjPs4LISv3bnYqB0iww44vgIAXCecvHFgKa3A=
Message-ID: <489ecd0c0609210257tb8daf0fl7603ff96e6e21c2e@mail.gmail.com>
Date: Thu, 21 Sep 2006 17:57:03 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <6d6a94c50609210223o5adf9bb5w7bfb70fb59094c85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4633_33308932.1158832623121"
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <1158830784.11109.93.camel@localhost.localdomain>
	 <6d6a94c50609210223o5adf9bb5w7bfb70fb59094c85@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4633_33308932.1158832623121
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Great thanks. Here is the new patch:

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Acked-by: Randy.Dunlap <rdunlap@xenotime.net>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

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
17:51:02.000000000 +0800
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


On 9/21/06, Aubrey <aubreylee@gmail.com> wrote:
> On 9/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Ar Iau, 2006-09-21 am 11:33 +0800, ysgrifennodd Luke Yang:
> > > Hi,
> > >
> > > This is the serial driver for Blackfin. It is designed for the serial
> > > core framework.
> >
> > > +#define DMA_RX_XCOUNT                TTY_FLIPBUF_SIZE
> >
> > TTY_FLIPBUF_SIZE is going away. Just pick a value good for your hardware
> > and under PAGE_SIZE.
>
> Thanks for your comments. I'll change it soon and submit a new patch.
>
> >
> > Other question - is your locking ok for low latency. In low latency mode
> > tty_flip_buffer_push() may directly end up calling your write methods.
> >
> Yes, I noticed that and I think it's ok. The driver is tested everday
> and works fine.
>
> -Aubrey
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_4633_33308932.1158832623121
Content-Type: text/x-patch; name="blackfin_serial_drv_2.6.18.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blackfin_serial_drv_2.6.18.patch"
X-Attachment-Id: f_escywkmy

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
YwkyMDA2LTA5LTIxIDE3OjUxOjAyLjAwMDAwMDAwMCArMDgwMApAQCAtMCwwICsxLDkwNiBAQAor
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
ayhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCk7CisKKy8qCisgKiBpbnRlcnJ1cHRzIGRp
c2FibGVkIG9uIGVudHJ5CisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3N0b3BfdHgoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9
IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7CisJdW5zaWduZWQgc2hvcnQgaWVyOwor
CWllciA9IFVBUlRfR0VUX0lFUih1YXJ0KTsKKwlpZXIgJj0gfkVUQkVJOworCVVBUlRfUFVUX0lF
Uih1YXJ0LCBpZXIpOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlkaXNhYmxlX2Rt
YSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisjZW5kaWYKK30KKworLyoKKyAqIHBvcnQgbG9ja2Vk
IGFuZCBpbnRlcnJ1cHRzIGRpc2FibGVkCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3N0
YXJ0X3R4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3Bv
cnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworI2lmZGVmIENPTkZJ
R19TRVJJQUxfQkZJTl9ETUEKKwliZmluX3NlcmlhbF9kbWFfdHhfY2hhcnModWFydCk7CisjZWxz
ZQorCXVuc2lnbmVkIHNob3J0IGllcjsKKwlpZXIgPSBVQVJUX0dFVF9JRVIodWFydCk7CisJaWVy
IHw9IEVUQkVJOworCVVBUlRfUFVUX0lFUih1YXJ0LCBpZXIpOworCWJmaW5fc2VyaWFsX3R4X2No
YXJzKHVhcnQpOworI2VuZGlmCit9CisKKy8qCisgKiBJbnRlcnJ1cHRzIGVuYWJsZWQKKyAqLwor
c3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfc3RvcF9yeChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQor
eworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9w
b3J0ICopcG9ydDsKKwl1bnNpZ25lZCBzaG9ydCBpZXI7CisJaWVyID0gVUFSVF9HRVRfSUVSKHVh
cnQpOworCWllciAmPSBFUkJGSTsKKwlVQVJUX1BVVF9JRVIodWFydCwgaWVyKTsKK30KKworLyoK
KyAqIFNldCB0aGUgbW9kZW0gY29udHJvbCB0aW1lciB0byBmaXJlIGltbWVkaWF0ZWx5LgorICov
CitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9lbmFibGVfbXMoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCkKK3sKK30KKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9QSU8KK3N0YXRpYyB2b2lkIGxv
Y2FsX3B1dF9jaGFyKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0LCBjaGFyIGNoKQorewor
ICAgICAgICB1bnNpZ25lZCBzaG9ydCBzdGF0dXM7CisgICAgICAgIGludCBmbGFncyA9IDA7CisK
KyAgICAgICAgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCisgICAgICAgIGRvIHsKKyAgICAgICAg
ICAgICAgICBzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7CisgICAgICAgIH0gd2hpbGUgKCEo
c3RhdHVzICYgVEhSRSkpOworCisgICAgICAgIFVBUlRfUFVUX0NIQVIodWFydCwgY2gpOworICAg
ICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7Cit9CisKK3N0YXRpYyB2b2lkCitiZmluX3Nl
cmlhbF9yeF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCwgc3RydWN0IHB0X3Jl
Z3MgKnJlZ3MpCit7CisJc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSA9IHVhcnQtPnBvcnQuaW5mby0+
dHR5OworCXVuc2lnbmVkIGludCBzdGF0dXM9MCwgY2gsIGZsZzsKKwljaCA9IFVBUlRfR0VUX0NI
QVIodWFydCk7CisJdWFydC0+cG9ydC5pY291bnQucngrKzsKKwlmbGcgPSBUVFlfTk9STUFMOwor
CWlmICh1YXJ0X2hhbmRsZV9zeXNycV9jaGFyKCZ1YXJ0LT5wb3J0LCBjaCwgcmVncykpCisJCWdv
dG8gaWdub3JlX2NoYXI7CisJdWFydF9pbnNlcnRfY2hhcigmdWFydC0+cG9ydCwgc3RhdHVzLCAx
LCBjaCwgZmxnKTsKKworaWdub3JlX2NoYXI6CisJdHR5X2ZsaXBfYnVmZmVyX3B1c2godHR5KTsK
K30KKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfdHhfY2hhcnMoc3RydWN0IGJmaW5fc2VyaWFs
X3BvcnQgKnVhcnQpCit7CisJc3RydWN0IGNpcmNfYnVmICp4bWl0ID0gJnVhcnQtPnBvcnQuaW5m
by0+eG1pdDsKKworCWlmICh1YXJ0LT5wb3J0LnhfY2hhcikgeworCQlVQVJUX1BVVF9DSEFSKHVh
cnQsIHVhcnQtPnBvcnQueF9jaGFyKTsKKwkJdWFydC0+cG9ydC5pY291bnQudHgrKzsKKwkJdWFy
dC0+cG9ydC54X2NoYXIgPSAwOworCQlyZXR1cm47CisJfQorCS8qCisJICogQ2hlY2sgdGhlIG1v
ZGVtIGNvbnRyb2wgbGluZXMgYmVmb3JlCisJICogdHJhbnNtaXR0aW5nIGFueXRoaW5nLgorCSAq
LworCWJmaW5fc2VyaWFsX21jdHJsX2NoZWNrKHVhcnQpOworCisJaWYgKHVhcnRfY2lyY19lbXB0
eSh4bWl0KSB8fCB1YXJ0X3R4X3N0b3BwZWQoJnVhcnQtPnBvcnQpKSB7CisJCWJmaW5fc2VyaWFs
X3N0b3BfdHgoJnVhcnQtPnBvcnQpOworCQlyZXR1cm47CisJfQorCisJbG9jYWxfcHV0X2NoYXIo
dWFydCwgeG1pdC0+YnVmW3htaXQtPnRhaWxdKTsKKwl4bWl0LT50YWlsID0gKHhtaXQtPnRhaWwg
KyAxKSAmIChVQVJUX1hNSVRfU0laRSAtIDEpOworCXVhcnQtPnBvcnQuaWNvdW50LnR4Kys7CisK
KwlpZiAodWFydF9jaXJjX2NoYXJzX3BlbmRpbmcoeG1pdCkgPCBXQUtFVVBfQ0hBUlMpCisJCXVh
cnRfd3JpdGVfd2FrZXVwKCZ1YXJ0LT5wb3J0KTsKKworCWlmICh1YXJ0X2NpcmNfZW1wdHkoeG1p
dCkpCisJCWJmaW5fc2VyaWFsX3N0b3BfdHgoJnVhcnQtPnBvcnQpOworfQorCitzdGF0aWMgaXJx
cmV0dXJuX3QgYmZpbl9zZXJpYWxfaW50KGludCBpcnEsIHZvaWQgKmRldl9pZCwgc3RydWN0IHB0
X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBkZXZfaWQ7
CisJdW5zaWduZWQgc2hvcnQgc3RhdHVzOworCisJc3Bpbl9sb2NrKCZ1YXJ0LT5wb3J0LmxvY2sp
OworCXN0YXR1cyA9IFVBUlRfR0VUX0lJUih1YXJ0KTsKKwlkbyB7CisJCWlmICgoc3RhdHVzICYg
SUlSX1NUQVRVUykgPT0gSUlSX1RYX1JFQURZKQorCQkJYmZpbl9zZXJpYWxfdHhfY2hhcnModWFy
dCk7CisJCWlmICgoc3RhdHVzICYgSUlSX1NUQVRVUykgPT0gSUlSX1JYX1JFQURZKQorCQkJYmZp
bl9zZXJpYWxfcnhfY2hhcnModWFydCwgcmVncyk7CisJCXN0YXR1cyA9IFVBUlRfR0VUX0lJUih1
YXJ0KTsKKwl9IHdoaWxlIChzdGF0dXMgJihJSVJfVFhfUkVBRFkgfCBJSVJfUlhfUkVBRFkpKTsK
KwlzcGluX3VubG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9
CisKK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2RvX3dvcmsodm9pZCAqcG9ydCkKK3sKKwlzdHJ1
Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBv
cnQ7CisJYmZpbl9zZXJpYWxfbWN0cmxfY2hlY2sodWFydCk7Cit9CisKKyNlbmRpZgorCisjaWZk
ZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfZG1hX3R4
X2NoYXJzKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0KQoreworCXN0cnVjdCBjaXJjX2J1
ZiAqeG1pdCA9ICZ1YXJ0LT5wb3J0LmluZm8tPnhtaXQ7CisJdW5zaWduZWQgc2hvcnQgaWVyOwor
CWludCBmbGFncyA9IDA7CisKKwlpZiAoIXVhcnQtPnR4X2RvbmUpCisJCXJldHVybjsKKworCXVh
cnQtPnR4X2RvbmUgPSAwOworCisJaWYgKHVhcnQtPnBvcnQueF9jaGFyKSB7CisJCVVBUlRfUFVU
X0NIQVIodWFydCwgdWFydC0+cG9ydC54X2NoYXIpOworCQl1YXJ0LT5wb3J0Lmljb3VudC50eCsr
OworCQl1YXJ0LT5wb3J0LnhfY2hhciA9IDA7CisJCXVhcnQtPnR4X2RvbmUgPSAxOworCQlyZXR1
cm47CisJfQorCS8qCisJICogQ2hlY2sgdGhlIG1vZGVtIGNvbnRyb2wgbGluZXMgYmVmb3JlCisJ
ICogdHJhbnNtaXR0aW5nIGFueXRoaW5nLgorCSAqLworCWJmaW5fc2VyaWFsX21jdHJsX2NoZWNr
KHVhcnQpOworCisJaWYgKHVhcnRfY2lyY19lbXB0eSh4bWl0KSB8fCB1YXJ0X3R4X3N0b3BwZWQo
JnVhcnQtPnBvcnQpKSB7CisJCWJmaW5fc2VyaWFsX3N0b3BfdHgoJnVhcnQtPnBvcnQpOworCQl1
YXJ0LT50eF9kb25lID0gMTsKKwkJcmV0dXJuOworCX0KKworCWxvY2FsX2lycV9zYXZlKGZsYWdz
KTsKKwl1YXJ0LT50eF9jb3VudCA9IENJUkNfQ05UKHhtaXQtPmhlYWQsIHhtaXQtPnRhaWwsIFVB
UlRfWE1JVF9TSVpFKTsKKwlpZiAodWFydC0+dHhfY291bnQgPiAoVUFSVF9YTUlUX1NJWkUgLSB4
bWl0LT50YWlsKSkKKwl1YXJ0LT50eF9jb3VudCA9IFVBUlRfWE1JVF9TSVpFIC0geG1pdC0+dGFp
bDsKKwlibGFja2Zpbl9kY2FjaGVfZmx1c2hfcmFuZ2UoKHVuc2lnbmVkIGxvbmcpKHhtaXQtPmJ1
Zit4bWl0LT50YWlsKSwKKwkJCQkJKHVuc2lnbmVkIGxvbmcpKHhtaXQtPmJ1Zit4bWl0LT50YWls
K3VhcnQtPnR4X2NvdW50KSk7CisJc2V0X2RtYV9jb25maWcodWFydC0+dHhfZG1hX2NoYW5uZWws
CisJCXNldF9iZmluX2RtYV9jb25maWcoRElSX1JFQUQsIERNQV9GTE9XX1NUT1AsCisJCQlJTlRS
X09OX0JVRiwKKwkJCURJTUVOU0lPTl9MSU5FQVIsCisJCQlEQVRBX1NJWkVfOCkpOworCXNldF9k
bWFfc3RhcnRfYWRkcih1YXJ0LT50eF9kbWFfY2hhbm5lbCwgKHVuc2lnbmVkIGxvbmcpKHhtaXQt
PmJ1Zit4bWl0LT50YWlsKSk7CisJc2V0X2RtYV94X2NvdW50KHVhcnQtPnR4X2RtYV9jaGFubmVs
LCB1YXJ0LT50eF9jb3VudCk7CisJc2V0X2RtYV94X21vZGlmeSh1YXJ0LT50eF9kbWFfY2hhbm5l
bCwgMSk7CisJZW5hYmxlX2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCk7CisJaWVyID0gVUFSVF9H
RVRfSUVSKHVhcnQpOworCWllciB8PSBFVEJFSTsKKwlVQVJUX1BVVF9JRVIodWFydCwgaWVyKTsK
Kwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7Cit9CisKK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFs
X2RtYV9yeF9jaGFycyhzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqIHVhcnQpCit7CisJc3RydWN0
IHR0eV9zdHJ1Y3QgKnR0eSA9IHVhcnQtPnBvcnQuaW5mby0+dHR5OworCWludCBpLCBmbGcsIHN0
YXR1cyA9IDA7CisKKwl1YXJ0LT5wb3J0Lmljb3VudC5yeCArPSBDSVJDX0NOVCh1YXJ0LT5yeF9k
bWFfYnVmLmhlYWQsIHVhcnQtPnJ4X2RtYV9idWYudGFpbCwgVUFSVF9YTUlUX1NJWkUpOzsKKwlm
bGcgPSBUVFlfTk9STUFMOworCWZvciAoaSA9IHVhcnQtPnJ4X2RtYV9idWYuaGVhZDsgaSA8IHVh
cnQtPnJ4X2RtYV9idWYudGFpbDsgaSsrKSB7CisJCWlmICh1YXJ0X2hhbmRsZV9zeXNycV9jaGFy
KCZ1YXJ0LT5wb3J0LCB1YXJ0LT5yeF9kbWFfYnVmLmJ1ZltpXSwgTlVMTCkpCisJCQlnb3RvIGRt
YV9pZ25vcmVfY2hhcjsKKwkJdWFydF9pbnNlcnRfY2hhcigmdWFydC0+cG9ydCwgc3RhdHVzLCAx
LCB1YXJ0LT5yeF9kbWFfYnVmLmJ1ZltpXSwgZmxnKTsKKwl9CitkbWFfaWdub3JlX2NoYXI6CisJ
dHR5X2ZsaXBfYnVmZmVyX3B1c2godHR5KTsKK30KKwordm9pZCBiZmluX3NlcmlhbF9yeF9kbWFf
dGltZW91dChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCkKK3sKKwlpbnQgeF9wb3MsIHBv
czsKKwlpbnQgZmxhZ3MgPSAwOworCisJYmZpbl9zZXJpYWxfZG1hX3R4X2NoYXJzKHVhcnQpOwor
CisJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCXhfcG9zID0gRE1BX1JYX1hDT1VOVCAtIGdldF9k
bWFfY3Vycl94Y291bnQodWFydC0+cnhfZG1hX2NoYW5uZWwpOworCWlmICh4X3BvcyA9PSBETUFf
UlhfWENPVU5UKQorCQl4X3BvcyA9IDA7CisKKwlwb3MgPSB1YXJ0LT5yeF9kbWFfbnJvd3MgKiBE
TUFfUlhfWENPVU5UICsgeF9wb3M7CisKKwlpZiAocG9zPnVhcnQtPnJ4X2RtYV9idWYudGFpbCkg
eworCQl1YXJ0LT5yeF9kbWFfYnVmLnRhaWwgPSBwb3M7CisJCWJmaW5fc2VyaWFsX2RtYV9yeF9j
aGFycyh1YXJ0KTsKKwkJdWFydC0+cnhfZG1hX2J1Zi5oZWFkID0gdWFydC0+cnhfZG1hX2J1Zi50
YWlsOworCX0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CisJdWFydC0+cnhfZG1hX3RpbWVy
LmV4cGlyZXMgPSBqaWZmaWVzICsgRE1BX1JYX0ZMVVNIX0pJRkZJRVM7CisJYWRkX3RpbWVyKCYo
dWFydC0+cnhfZG1hX3RpbWVyKSk7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBiZmluX3Nlcmlh
bF9kbWFfdHhfaW50KGludCBpcnEsIHZvaWQgKmRldl9pZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
Cit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBkZXZfaWQ7CisJc3RydWN0IGNp
cmNfYnVmICp4bWl0ID0gJnVhcnQtPnBvcnQuaW5mby0+eG1pdDsKKwl1bnNpZ25lZCBzaG9ydCBp
ZXI7CisKKwlzcGluX2xvY2soJnVhcnQtPnBvcnQubG9jayk7CisJaWYgKCEoZ2V0X2RtYV9jdXJy
X2lycXN0YXQodWFydC0+dHhfZG1hX2NoYW5uZWwpJkRNQV9SVU4pKSB7CisJCWNsZWFyX2RtYV9p
cnFzdGF0KHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwkJZGlzYWJsZV9kbWEodWFydC0+dHhfZG1h
X2NoYW5uZWwpOworCQlpZXIgPSBVQVJUX0dFVF9JRVIodWFydCk7CisJCWllciAmPSB+RVRCRUk7
CisJCVVBUlRfUFVUX0lFUih1YXJ0LCBpZXIpOworCQl4bWl0LT50YWlsID0gKHhtaXQtPnRhaWwr
dWFydC0+dHhfY291bnQpICYoVUFSVF9YTUlUX1NJWkUgLTEpOworCQl1YXJ0LT5wb3J0Lmljb3Vu
dC50eCs9dWFydC0+dHhfY291bnQ7CisKKwkJaWYgKHVhcnRfY2lyY19jaGFyc19wZW5kaW5nKHht
aXQpIDwgV0FLRVVQX0NIQVJTKQorCQkJdWFydF93cml0ZV93YWtldXAoJnVhcnQtPnBvcnQpOwor
CisJCWlmICh1YXJ0X2NpcmNfZW1wdHkoeG1pdCkpCisJCQliZmluX3NlcmlhbF9zdG9wX3R4KCZ1
YXJ0LT5wb3J0KTsKKwkJdWFydC0+dHhfZG9uZSA9IDE7CisJfQorCisJc3Bpbl91bmxvY2soJnVh
cnQtPnBvcnQubG9jayk7CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorCitzdGF0aWMgaXJxcmV0
dXJuX3QgYmZpbl9zZXJpYWxfZG1hX3J4X2ludChpbnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVj
dCBwdF9yZWdzICpyZWdzKQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gZGV2
X2lkOworCXVuc2lnbmVkIHNob3J0IGlycXN0YXQ7CisKKwl1YXJ0LT5yeF9kbWFfbnJvd3MrKzsK
KwlpZiAodWFydC0+cnhfZG1hX25yb3dzID09IERNQV9SWF9ZQ09VTlQpIHsKKwkJdWFydC0+cnhf
ZG1hX25yb3dzID0gMDsKKwkJdWFydC0+cnhfZG1hX2J1Zi50YWlsID0gRE1BX1JYX1hDT1VOVCpE
TUFfUlhfWUNPVU5UOworCQliZmluX3NlcmlhbF9kbWFfcnhfY2hhcnModWFydCk7CisJCXVhcnQt
PnJ4X2RtYV9idWYuaGVhZCA9IHVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IDA7CisJfQorCXNwaW5f
bG9jaygmdWFydC0+cG9ydC5sb2NrKTsKKwlpcnFzdGF0ID0gZ2V0X2RtYV9jdXJyX2lycXN0YXQo
dWFydC0+cnhfZG1hX2NoYW5uZWwpOworCWNsZWFyX2RtYV9pcnFzdGF0KHVhcnQtPnJ4X2RtYV9j
aGFubmVsKTsKKworCXNwaW5fdW5sb2NrKCZ1YXJ0LT5wb3J0LmxvY2spOworCXJldHVybiBJUlFf
SEFORExFRDsKK30KKyNlbmRpZgorCisvKgorICogUmV0dXJuIFRJT0NTRVJfVEVNVCB3aGVuIHRy
YW5zbWl0dGVyIGlzIG5vdCBidXN5LgorICovCitzdGF0aWMgdW5zaWduZWQgaW50IGJmaW5fc2Vy
aWFsX3R4X2VtcHR5KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2Vy
aWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCXVuc2ln
bmVkIHNob3J0IGxzcjsKKwlsc3IgPSBVQVJUX0dFVF9MU1IodWFydCk7CisJaWYgKGxzciAmIFRI
UkUpCisJCXJldHVybiBUSU9DU0VSX1RFTVQ7CisJZWxzZQorCQlyZXR1cm4gMDsKK30KKworc3Rh
dGljIHVuc2lnbmVkIGludCBiZmluX3NlcmlhbF9nZXRfbWN0cmwoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCkKK3sKKwkvKiBIYXJkd2FyZSBmbG93IGNvbnRyb2wgaXMgb25seSBzdXBwb3J0ZWQgb24g
dGhlIGZpcnN0IHBvcnQgKi8KKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fQ1RTUlRTCisJaWYg
KChiZmluX3JlYWQxNihDVFNfUE9SVCkgJiAoMSA8PCBDVFNfUElOKSkgJiYgKHBvcnQtPmxpbmUg
PT0gMCkpCisJCXJldHVybiBUSU9DTV9EU1IgfCBUSU9DTV9DQVI7CisJZWxzZQorI2VuZGlmCisJ
CXJldHVybiBUSU9DTV9DVFMgfCBUSU9DTV9EU1IgfCBUSU9DTV9DQVI7Cit9CisKK3N0YXRpYyB2
b2lkIGJmaW5fc2VyaWFsX3NldF9tY3RybChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25l
ZCBpbnQgbWN0cmwpCit7CisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0NUU1JUUworCWlmICht
Y3RybCAmIFRJT0NNX1JUUykKKwkJYmZpbl93cml0ZTE2KFJUU19QT1JULCBiZmluX3JlYWQxNihS
VFNfUE9SVCkgJiAofjEgPDwgUlRTX1BJTikpOworCWVsc2UKKwkJYmZpbl93cml0ZTE2KFJUU19Q
T1JULCBiZmluX3JlYWQxNihSVFNfUE9SVCkgfCAoMSA8PCBSVFNfUElOKSk7CisjZW5kaWYKK30K
KworLyoKKyAqIEhhbmRsZSBhbnkgY2hhbmdlIG9mIG1vZGVtIHN0YXR1cyBzaWduYWwgc2luY2Ug
d2Ugd2VyZSBsYXN0IGNhbGxlZC4KKyAqLworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfbWN0cmxf
Y2hlY2soc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQpCit7CisjaWZkZWYgQ09ORklHX1NF
UklBTF9CRklOX0NUU1JUUworCXVuc2lnbmVkIGludCBzdGF0dXM7CisjaWZkZWYgQ09ORklHX1NF
UklBTF9CRklOX0RNQQorCXN0cnVjdCB1YXJ0X2luZm8gKmluZm8gPSB1YXJ0LT5wb3J0LmluZm87
CisJc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSA9IGluZm8tPnR0eTsKKwlzdGF0dXMgPSBiZmluX3Nl
cmlhbF9nZXRfbWN0cmwoJnVhcnQtPnBvcnQpOworCWlmICghKHN0YXR1cyAmIFRJT0NNX0NUUykp
IHsKKwkJdHR5LT5od19zdG9wcGVkID0gMTsKKwl9IGVsc2UgeworCQl0dHktPmh3X3N0b3BwZWQg
PSAwOworCX0KKyNlbHNlCisJc3RhdHVzID0gYmZpbl9zZXJpYWxfZ2V0X21jdHJsKCZ1YXJ0LT5w
b3J0KTsKKwl1YXJ0X2hhbmRsZV9jdHNfY2hhbmdlKCZ1YXJ0LT5wb3J0LCBzdGF0dXMgJiBUSU9D
TV9DVFMpOworCWlmICghKHN0YXR1cyAmIFRJT0NNX0NUUykpCisJCXNjaGVkdWxlX3dvcmsoJnVh
cnQtPmN0c193b3JrcXVldWUpOworI2VuZGlmCisjZW5kaWYKK30KKworLyoKKyAqIEludGVycnVw
dHMgYWx3YXlzIGRpc2FibGVkLgorICovCitzdGF0aWMgdm9pZCBiZmluX3NlcmlhbF9icmVha19j
dGwoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgaW50IGJyZWFrX3N0YXRlKQoreworfQorCitpbnQg
YmZpbl9zZXJpYWxfc3RhcnR1cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBi
ZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsK
KworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlkbWFfYWRkcl90IGRtYV9oYW5kbGU7
CisKKwlpZiAocmVxdWVzdF9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwsICJCRklOX1VBUlRfUlgi
KSA8IDApIHsKKwkJcHJpbnRrKEtFUk5fTk9USUNFICJVbmFibGUgdG8gYXR0YWNoIEJsYWNrZmlu
IFVBUlQgUlggRE1BIGNoYW5uZWxcbiIpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKworCWlmIChy
ZXF1ZXN0X2RtYSh1YXJ0LT50eF9kbWFfY2hhbm5lbCwgIkJGSU5fVUFSVF9UWCIpIDwgMCkgewor
CQlwcmludGsoS0VSTl9OT1RJQ0UgIlVuYWJsZSB0byBhdHRhY2ggQmxhY2tmaW4gVUFSVCBUWCBE
TUEgY2hhbm5lbFxuIik7CisJCWZyZWVfZG1hKHVhcnQtPnJ4X2RtYV9jaGFubmVsKTsKKwkJcmV0
dXJuIC1FQlVTWTsKKwl9CisKKwlzZXRfZG1hX2NhbGxiYWNrKHVhcnQtPnJ4X2RtYV9jaGFubmVs
LCBiZmluX3NlcmlhbF9kbWFfcnhfaW50LCB1YXJ0KTsKKwlzZXRfZG1hX2NhbGxiYWNrKHVhcnQt
PnR4X2RtYV9jaGFubmVsLCBiZmluX3NlcmlhbF9kbWFfdHhfaW50LCB1YXJ0KTsKKworCXVhcnQt
PnJ4X2RtYV9idWYuYnVmID0gKHVuc2lnbmVkIGNoYXIgKilkbWFfYWxsb2NfY29oZXJlbnQoTlVM
TCwgUEFHRV9TSVpFLCAmZG1hX2hhbmRsZSwgR0ZQX0RNQSk7CisJdWFydC0+cnhfZG1hX2J1Zi5o
ZWFkID0gMDsKKwl1YXJ0LT5yeF9kbWFfYnVmLnRhaWwgPSAwOworCXVhcnQtPnJ4X2RtYV9ucm93
cyA9IDA7CisKKwlzZXRfZG1hX2NvbmZpZyh1YXJ0LT5yeF9kbWFfY2hhbm5lbCwKKwkJc2V0X2Jm
aW5fZG1hX2NvbmZpZyhESVJfV1JJVEUsIERNQV9GTE9XX0FVVE8sCisJCQkJSU5UUl9PTl9ST1cs
IERJTUVOU0lPTl8yRCwKKwkJCQlEQVRBX1NJWkVfOCkpOworCXNldF9kbWFfeF9jb3VudCh1YXJ0
LT5yeF9kbWFfY2hhbm5lbCwgRE1BX1JYX1hDT1VOVCk7CisJc2V0X2RtYV94X21vZGlmeSh1YXJ0
LT5yeF9kbWFfY2hhbm5lbCwgMSk7CisJc2V0X2RtYV95X2NvdW50KHVhcnQtPnJ4X2RtYV9jaGFu
bmVsLCBETUFfUlhfWUNPVU5UKTsKKwlzZXRfZG1hX3lfbW9kaWZ5KHVhcnQtPnJ4X2RtYV9jaGFu
bmVsLCAxKTsKKwlzZXRfZG1hX3N0YXJ0X2FkZHIodWFydC0+cnhfZG1hX2NoYW5uZWwsICh1bnNp
Z25lZCBsb25nKXVhcnQtPnJ4X2RtYV9idWYuYnVmKTsKKwllbmFibGVfZG1hKHVhcnQtPnJ4X2Rt
YV9jaGFubmVsKTsKKworCXVhcnQtPnJ4X2RtYV90aW1lci5kYXRhID0gKHVuc2lnbmVkIGxvbmcp
KHVhcnQpOworCXVhcnQtPnJ4X2RtYV90aW1lci5mdW5jdGlvbiA9ICh2b2lkICopYmZpbl9zZXJp
YWxfcnhfZG1hX3RpbWVvdXQ7CisJdWFydC0+cnhfZG1hX3RpbWVyLmV4cGlyZXMgPSBqaWZmaWVz
ICsgRE1BX1JYX0ZMVVNIX0pJRkZJRVM7CisJYWRkX3RpbWVyKCYodWFydC0+cnhfZG1hX3RpbWVy
KSk7CisjZWxzZQorCWlmIChyZXF1ZXN0X2lycQorCSAgICAodWFydC0+cG9ydC5pcnEsIGJmaW5f
c2VyaWFsX2ludCwgSVJRRl9ESVNBQkxFRCB8IElSUUZfU0hBUkVELAorCSAgICAgIkJGSU5fVUFS
VDBfUlgiLCB1YXJ0KSkgeworCQlwcmludGsoS0VSTl9OT1RJQ0UgIlVuYWJsZSB0byBhdHRhY2gg
QmxhY2tGaW4gVUFSVCBSWCBpbnRlcnJ1cHRcbiIpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKwor
CWlmIChyZXF1ZXN0X2lycQorCSAgICAodWFydC0+cG9ydC5pcnErMSwgYmZpbl9zZXJpYWxfaW50
LCBJUlFGX0RJU0FCTEVEIHwgSVJRRl9TSEFSRUQsCisJICAgICAiQkZJTl9VQVJUMF9UWCIsIHVh
cnQpKSB7CisJCXByaW50ayhLRVJOX05PVElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja0ZpbiBV
QVJUIFRYIGludGVycnVwdFxuIik7CisJCWZyZWVfaXJxKHVhcnQtPnBvcnQuaXJxLCB1YXJ0KTsK
KwkJcmV0dXJuIC1FQlVTWTsKKwl9CisjZW5kaWYKKwlVQVJUX1BVVF9JRVIodWFydCwgVUFSVF9H
RVRfSUVSKHVhcnQpIHwgRVJCRkkpOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBiZmlu
X3NlcmlhbF9zaHV0ZG93bihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmlu
X3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKwor
I2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlkaXNhYmxlX2RtYSh1YXJ0LT50eF9kbWFf
Y2hhbm5lbCk7CisJZnJlZV9kbWEodWFydC0+dHhfZG1hX2NoYW5uZWwpOworCWRpc2FibGVfZG1h
KHVhcnQtPnJ4X2RtYV9jaGFubmVsKTsKKwlmcmVlX2RtYSh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7
CisJZGVsX3RpbWVyKCYodWFydC0+cnhfZG1hX3RpbWVyKSk7CisjZWxzZQorCWZyZWVfaXJxKHVh
cnQtPnBvcnQuaXJxLCB1YXJ0KTsKKwlmcmVlX2lycSh1YXJ0LT5wb3J0LmlycSsxLCB1YXJ0KTsK
KyNlbmRpZgorfQorCitzdGF0aWMgdm9pZAorYmZpbl9zZXJpYWxfc2V0X3Rlcm1pb3Moc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IHRlcm1pb3MgKnRlcm1pb3MsCisJCSAgIHN0cnVjdCB0
ZXJtaW9zICpvbGQpCit7Cit9CisKK3N0YXRpYyBjb25zdCBjaGFyICpiZmluX3NlcmlhbF90eXBl
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVh
cnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilwb3J0OworCXJldHVybiB1YXJ0LT5wb3J0
LnR5cGUgPT0gUE9SVF9CRklOID8gIkJGSU4tVUFSVCIgOiBOVUxMOworfQorCisvKgorICogUmVs
ZWFzZSB0aGUgbWVtb3J5IHJlZ2lvbihzKSBiZWluZyB1c2VkIGJ5ICdwb3J0Jy4KKyAqLworc3Rh
dGljIHZvaWQgYmZpbl9zZXJpYWxfcmVsZWFzZV9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQp
Cit7Cit9CisKKy8qCisgKiBSZXF1ZXN0IHRoZSBtZW1vcnkgcmVnaW9uKHMpIGJlaW5nIHVzZWQg
YnkgJ3BvcnQnLgorICovCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3JlcXVlc3RfcG9ydChzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXJldHVybiAwOworfQorCisvKgorICogQ29uZmlndXJl
L2F1dG9jb25maWd1cmUgdGhlIHBvcnQuCisgKi8KK3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX2Nv
bmZpZ19wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIGludCBmbGFncykKK3sKKwlzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7
CisKKwlpZiAoZmxhZ3MgJiBVQVJUX0NPTkZJR19UWVBFICYmCisJICAgIGJmaW5fc2VyaWFsX3Jl
cXVlc3RfcG9ydCgmdWFydC0+cG9ydCkgPT0gMCkKKwkJdWFydC0+cG9ydC50eXBlID0gUE9SVF9C
RklOOworfQorCisvKgorICogVmVyaWZ5IHRoZSBuZXcgc2VyaWFsX3N0cnVjdCAoZm9yIFRJT0NT
U0VSSUFMKS4KKyAqIFRoZSBvbmx5IGNoYW5nZSB3ZSBhbGxvdyBhcmUgdG8gdGhlIGZsYWdzIGFu
ZCB0eXBlLCBhbmQKKyAqIGV2ZW4gdGhlbiBvbmx5IGJldHdlZW4gUE9SVF9CRklOIGFuZCBQT1JU
X1VOS05PV04KKyAqLworc3RhdGljIGludAorYmZpbl9zZXJpYWxfdmVyaWZ5X3BvcnQoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9zdHJ1Y3QgKnNlcikKK3sKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIHN0cnVjdCB1YXJ0X29wcyBiZmluX3NlcmlhbF9wb3BzID0geworCS50
eF9lbXB0eQk9IGJmaW5fc2VyaWFsX3R4X2VtcHR5LAorCS5zZXRfbWN0cmwJPSBiZmluX3Nlcmlh
bF9zZXRfbWN0cmwsCisJLmdldF9tY3RybAk9IGJmaW5fc2VyaWFsX2dldF9tY3RybCwKKwkuc3Rv
cF90eAk9IGJmaW5fc2VyaWFsX3N0b3BfdHgsCisJLnN0YXJ0X3R4CT0gYmZpbl9zZXJpYWxfc3Rh
cnRfdHgsCisJLnN0b3BfcngJPSBiZmluX3NlcmlhbF9zdG9wX3J4LAorCS5lbmFibGVfbXMJPSBi
ZmluX3NlcmlhbF9lbmFibGVfbXMsCisJLmJyZWFrX2N0bAk9IGJmaW5fc2VyaWFsX2JyZWFrX2N0
bCwKKwkuc3RhcnR1cAk9IGJmaW5fc2VyaWFsX3N0YXJ0dXAsCisJLnNodXRkb3duCT0gYmZpbl9z
ZXJpYWxfc2h1dGRvd24sCisJLnNldF90ZXJtaW9zCT0gYmZpbl9zZXJpYWxfc2V0X3Rlcm1pb3Ms
CisJLnR5cGUJCT0gYmZpbl9zZXJpYWxfdHlwZSwKKwkucmVsZWFzZV9wb3J0CT0gYmZpbl9zZXJp
YWxfcmVsZWFzZV9wb3J0LAorCS5yZXF1ZXN0X3BvcnQJPSBiZmluX3NlcmlhbF9yZXF1ZXN0X3Bv
cnQsCisJLmNvbmZpZ19wb3J0CT0gYmZpbl9zZXJpYWxfY29uZmlnX3BvcnQsCisJLnZlcmlmeV9w
b3J0CT0gYmZpbl9zZXJpYWxfdmVyaWZ5X3BvcnQsCit9OworCitzdGF0aWMgaW50IGJmaW5fc2Vy
aWFsX2NhbGNfYmF1ZCh1bnNpZ25lZCBpbnQgdWFydGNsaykKK3sKKwlpbnQgYmF1ZDsKKwliYXVk
ID0gZ2V0X3NjbGsoKSAvICh1YXJ0Y2xrKjgpOworCWlmICgoYmF1ZCAmIDB4MSkgPT0gMSkgewor
CQliYXVkKys7CisJfQorCXJldHVybiBiYXVkLzI7Cit9CisKK3N0YXRpYyB2b2lkIF9faW5pdCBi
ZmluX3NlcmlhbF9pbml0X3BvcnRzKHZvaWQpCit7CisJc3RhdGljIGludCBmaXJzdCA9IDE7CisJ
aW50IGk7CisJdW5zaWduZWQgc2hvcnQgdmFsOworCWludCBiYXVkOworCisJaWYgKCFmaXJzdCkK
KwkJcmV0dXJuOworCWZpcnN0ID0gMDsKKwliZmluX3NlcmlhbF9od19pbml0KCk7CisKKwlmb3Ig
KGkgPSAwOyBpIDwgTlJfUE9SVFM7IGkrKykgeworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5wb3J0
LnVhcnRjbGsgICA9IENPTlNPTEVfQkFVRF9SQVRFOworCQliZmluX3NlcmlhbF9wb3J0c1tpXS5w
b3J0Lm9wcyAgICAgICA9ICZiZmluX3NlcmlhbF9wb3BzOworCQliZmluX3NlcmlhbF9wb3J0c1tp
XS5wb3J0LmxpbmUgICAgICA9IGk7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQuaW90eXBl
ICAgID0gVVBJT19NRU07CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQubWVtYmFzZSAgID0g
KHZvaWQgX19pb21lbSAqKXVhcnRfYmFzZV9hZGRyW2ldOworCQliZmluX3NlcmlhbF9wb3J0c1tp
XS5wb3J0Lm1hcGJhc2UgICA9IHVhcnRfYmFzZV9hZGRyW2ldOworCQliZmluX3NlcmlhbF9wb3J0
c1tpXS5wb3J0LmlycSAgICAgICA9IHVhcnRfaXJxW2ldOworCQliZmluX3NlcmlhbF9wb3J0c1tp
XS5wb3J0LmZsYWdzICAgICA9IFVQRl9CT09UX0FVVE9DT05GOworI2lmZGVmIENPTkZJR19TRVJJ
QUxfQkZJTl9ETUEKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0udHhfZG9uZQkgICAgPSAxOworCQli
ZmluX3NlcmlhbF9wb3J0c1tpXS50eF9jb3VudAkgICAgPSAwOworCQliZmluX3NlcmlhbF9wb3J0
c1tpXS50eF9kbWFfY2hhbm5lbCA9IHVhcnRfdHhfZG1hX2NoYW5uZWxbaV07CisJCWJmaW5fc2Vy
aWFsX3BvcnRzW2ldLnJ4X2RtYV9jaGFubmVsID0gdWFydF9yeF9kbWFfY2hhbm5lbFtpXTsKKwor
CQlpbml0X3RpbWVyKCYoYmZpbl9zZXJpYWxfcG9ydHNbaV0ucnhfZG1hX3RpbWVyKSk7CisjZWxz
ZQorCQlJTklUX1dPUksoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLmN0c193b3JrcXVldWUsIGJmaW5f
c2VyaWFsX2RvX3dvcmssICZiZmluX3NlcmlhbF9wb3J0c1tpXSk7CisjZW5kaWYKKworCQliYXVk
ID0gYmZpbl9zZXJpYWxfY2FsY19iYXVkKGJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQudWFydGNs
ayk7CisKKwkJLyogRW5hYmxlIFVBUlQgKi8KKwkJdmFsID0gVUFSVF9HRVRfR0NUTCgmYmZpbl9z
ZXJpYWxfcG9ydHNbaV0pOworCQl2YWwgfD0gVUNFTjsKKwkJVUFSVF9QVVRfR0NUTCgmYmZpbl9z
ZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisKKwkJLyogU2V0IERMQUIgaW4gTENSIHRvIEFjY2VzcyBE
TEwgYW5kIERMSCAqLworCQl2YWwgPSBVQVJUX0dFVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ld
KTsKKwkJdmFsIHw9IERMQUI7CisJCVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0s
IHZhbCk7CisKKwkJVUFSVF9QVVRfRExMKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgYmF1ZCAmIDB4
RkYpOworCQlVQVJUX1BVVF9ETEgoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCAoYmF1ZCA+PiA4KSAm
IDB4RkYpOworCisJCS8qIENsZWFyIERMQUIgaW4gTENSIHRvIEFjY2VzcyBUSFIgUkJSIElFUiAq
LworCQl2YWwgPSBVQVJUX0dFVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKwkJdmFsICY9
IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCB2YWwpOworCisJ
CS8qIFNldCBMQ1IgdG8gV29yZCBMZW5naCA4LWJpdCB3b3JkIHNlbGVjdCAqLworCQl2YWwgPSBX
TFMoOCk7CisJCVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisJfQor
fQorCisjaWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0NPTlNPTEUKKy8qCisgKiBJbnRlcnJ1cHRz
IGFyZSBkaXNhYmxlZCBvbiBlbnRlcmluZworICovCitzdGF0aWMgdm9pZAorYmZpbl9zZXJpYWxf
Y29uc29sZV93cml0ZShzdHJ1Y3QgY29uc29sZSAqY28sIGNvbnN0IGNoYXIgKnMsIHVuc2lnbmVk
IGludCBjb3VudCkKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9ICZiZmluX3Nl
cmlhbF9wb3J0c1tjby0+aW5kZXhdOworCWludCBmbGFncyA9IDA7CisJdW5zaWduZWQgc2hvcnQg
c3RhdHVzLCB0bXA7CisJaW50IGk7CisKKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisKKwlmb3Ig
KGkgPSAwOyBpIDwgY291bnQ7IGkrKykgeworCQlkbyB7CisJCQlzdGF0dXMgPSBVQVJUX0dFVF9M
U1IodWFydCk7CisJCX0gd2hpbGUgKCEoc3RhdHVzICYgVEhSRSkpOworCisJCXRtcCA9IFVBUlRf
R0VUX0xDUih1YXJ0KTsKKwkJdG1wICY9IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IodWFydCwgdG1w
KTsKKworCQlVQVJUX1BVVF9DSEFSKHVhcnQsIHNbaV0pOworCQlpZiAoc1tpXSA9PSAnXG4nKSB7
CisJCQlkbyB7CisJCQkJc3RhdHVzID0gVUFSVF9HRVRfTFNSKHVhcnQpOworCQkJfSB3aGlsZSgh
KHN0YXR1cyAmIFRIUkUpKTsKKwkJCVVBUlRfUFVUX0NIQVIodWFydCwgJ1xyJyk7CisJCX0KKwl9
CisKKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7Cit9CisKKy8qCisgKiBJZiB0aGUgcG9ydCB3
YXMgYWxyZWFkeSBpbml0aWFsaXNlZCAoZWcsIGJ5IGEgYm9vdCBsb2FkZXIpLAorICogdHJ5IHRv
IGRldGVybWluZSB0aGUgY3VycmVudCBzZXR1cC4KKyAqLworc3RhdGljIHZvaWQgX19pbml0Citi
ZmluX3NlcmlhbF9jb25zb2xlX2dldF9vcHRpb25zKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1
YXJ0LCBpbnQgKmJhdWQsCisJCQkgICBpbnQgKnBhcml0eSwgaW50ICpiaXRzKQoreworCXVuc2ln
bmVkIHNob3J0IHN0YXR1czsKKworCXN0YXR1cyA9IFVBUlRfR0VUX0lFUih1YXJ0KSAmIChFUkJG
SSB8IEVUQkVJKTsKKwlpZiAoc3RhdHVzID09IChFUkJGSSB8IEVUQkVJKSkgeworCQkvKiBvaywg
dGhlIHBvcnQgd2FzIGVuYWJsZWQgKi8KKwkJdW5zaWduZWQgc2hvcnQgbGNyLCB2YWw7CisJCXVu
c2lnbmVkIHNob3J0IGRsaCwgZGxsOworCisJCWxjciA9IFVBUlRfR0VUX0xDUih1YXJ0KTsKKwor
CQkqcGFyaXR5ID0gJ24nOworCQlpZiAobGNyICYgUEVOKSB7CisJCQlpZiAobGNyICYgRVBTKQor
CQkJCSpwYXJpdHkgPSAnZSc7CisJCQllbHNlCisJCQkJKnBhcml0eSA9ICdvJzsKKwkJfQorCQlz
d2l0Y2ggKGxjciAmIDB4MDMpIHsKKwkJCWNhc2UgMDoJKmJpdHMgPSA1OyBicmVhazsKKwkJCWNh
c2UgMToJKmJpdHMgPSA2OyBicmVhazsKKwkJCWNhc2UgMjoJKmJpdHMgPSA3OyBicmVhazsKKwkJ
CWNhc2UgMzoJKmJpdHMgPSA4OyBicmVhazsKKwkJfQorCQkvKiBTZXQgRExBQiBpbiBMQ1IgdG8g
QWNjZXNzIERMTCBhbmQgRExIICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUih1YXJ0KTsKKwkJdmFs
IHw9IERMQUI7CisJCVVBUlRfUFVUX0xDUih1YXJ0LCB2YWwpOworCisJCWRsbCA9IFVBUlRfR0VU
X0RMTCh1YXJ0KTsKKwkJZGxoID0gVUFSVF9HRVRfRExIKHVhcnQpOworCisJCS8qIENsZWFyIERM
QUIgaW4gTENSIHRvIEFjY2VzcyBUSFIgUkJSIElFUiAqLworCQl2YWwgPSBVQVJUX0dFVF9MQ1Io
dWFydCk7CisJCXZhbCAmPSB+RExBQjsKKwkJVUFSVF9QVVRfTENSKHVhcnQsIHZhbCk7CisKKwkJ
KmJhdWQgPSBnZXRfc2NsaygpIC8gKDE2KihkbGwgfCBkbGggPDwgOCkpOworCX0KKwlEUFJJTlRL
KCIlczpiYXVkID0gJWQsIHBhcml0eSA9ICVjLCBiaXRzPSAlZFxuIiwgX19GVU5DVElPTl9fLCAq
YmF1ZCwgKnBhcml0eSwgKmJpdHMpOworfQorCitzdGF0aWMgaW50IF9faW5pdAorYmZpbl9zZXJp
YWxfY29uc29sZV9zZXR1cChzdHJ1Y3QgY29uc29sZSAqY28sIGNoYXIgKm9wdGlvbnMpCit7CisJ
c3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQ7CisJaW50IGJhdWQgPSBDT05TT0xFX0JBVURf
UkFURTsKKwlpbnQgYml0cyA9IDg7CisJaW50IHBhcml0eSA9ICduJzsKKyNpZmRlZiBDT05GSUdf
U0VSSUFMX0JGSU5fQ1RTUlRTCisJaW50IGZsb3cgPSAncic7CisjZWxzZQorCWludCBmbG93ID0g
J24nOworI2VuZGlmCisKKwkvKgorCSAqIENoZWNrIHdoZXRoZXIgYW4gaW52YWxpZCB1YXJ0IG51
bWJlciBoYXMgYmVlbiBzcGVjaWZpZWQsIGFuZAorCSAqIGlmIHNvLCBzZWFyY2ggZm9yIHRoZSBm
aXJzdCBhdmFpbGFibGUgcG9ydCB0aGF0IGRvZXMgaGF2ZQorCSAqIGNvbnNvbGUgc3VwcG9ydC4K
KwkgKi8KKwlpZiAoY28tPmluZGV4ID09IC0xIHx8IGNvLT5pbmRleCA+PSBOUl9QT1JUUykKKwkJ
Y28tPmluZGV4ID0gMDsKKwl1YXJ0ID0gJmJmaW5fc2VyaWFsX3BvcnRzW2NvLT5pbmRleF07CisK
KwlpZiAob3B0aW9ucykKKwkJdWFydF9wYXJzZV9vcHRpb25zKG9wdGlvbnMsICZiYXVkLCAmcGFy
aXR5LCAmYml0cywgJmZsb3cpOworCWVsc2UKKwkJYmZpbl9zZXJpYWxfY29uc29sZV9nZXRfb3B0
aW9ucyh1YXJ0LCAmYmF1ZCwgJnBhcml0eSwgJmJpdHMpOworCisJcmV0dXJuIHVhcnRfc2V0X29w
dGlvbnMoJnVhcnQtPnBvcnQsIGNvLCBiYXVkLCBwYXJpdHksIGJpdHMsIGZsb3cpOworfQorCitz
dGF0aWMgc3RydWN0IHVhcnRfZHJpdmVyIGJmaW5fc2VyaWFsX3JlZzsKK3N0YXRpYyBzdHJ1Y3Qg
Y29uc29sZSBiZmluX3NlcmlhbF9jb25zb2xlID0geworCS5uYW1lCQk9ICJ0dHlTIiwKKwkud3Jp
dGUJCT0gYmZpbl9zZXJpYWxfY29uc29sZV93cml0ZSwKKwkuZGV2aWNlCQk9IHVhcnRfY29uc29s
ZV9kZXZpY2UsCisJLnNldHVwCQk9IGJmaW5fc2VyaWFsX2NvbnNvbGVfc2V0dXAsCisJLmZsYWdz
CQk9IENPTl9QUklOVEJVRkZFUiwKKwkuaW5kZXgJCT0gLTEsCisJLmRhdGEJCT0gJmJmaW5fc2Vy
aWFsX3JlZywKK307CisKK3N0YXRpYyBpbnQgX19pbml0IGJmaW5fc2VyaWFsX3JzX2NvbnNvbGVf
aW5pdCh2b2lkKQoreworCWJmaW5fc2VyaWFsX2luaXRfcG9ydHMoKTsKKwlyZWdpc3Rlcl9jb25z
b2xlKCZiZmluX3NlcmlhbF9jb25zb2xlKTsKKwlyZXR1cm4gMDsKK30KK2NvbnNvbGVfaW5pdGNh
bGwoYmZpbl9zZXJpYWxfcnNfY29uc29sZV9pbml0KTsKKworI2RlZmluZSBCRklOX1NFUklBTF9D
T05TT0xFCSZiZmluX3NlcmlhbF9jb25zb2xlCisjZWxzZQorI2RlZmluZSBCRklOX1NFUklBTF9D
T05TT0xFCU5VTEwKKyNlbmRpZgorCitzdGF0aWMgc3RydWN0IHVhcnRfZHJpdmVyIGJmaW5fc2Vy
aWFsX3JlZyA9IHsKKwkub3duZXIJCQk9IFRISVNfTU9EVUxFLAorCS5kcml2ZXJfbmFtZQkJPSAi
YmZpbi11YXJ0IiwKKwkuZGV2X25hbWUJCT0gInR0eVMiLAorCS5kZXZmc19uYW1lCQk9ICJ0dHlT
LyIsCisJLm1ham9yCQkJPSBTRVJJQUxfQkZJTl9NQUpPUiwKKwkubWlub3IJCQk9IE1JTk9SX1NU
QVJULAorCS5ucgkJCT0gTlJfUE9SVFMsCisJLmNvbnMJCQk9IEJGSU5fU0VSSUFMX0NPTlNPTEUs
Cit9OworCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3Bv
cnQgKnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJaWYgKHVhcnQpCisJCXVh
cnRfc3VzcGVuZF9wb3J0KCZiZmluX3NlcmlhbF9yZWcsICZ1YXJ0LT5wb3J0KTsKKworCXJldHVy
biAwOworfQorCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBwbGF0Zm9y
bV9nZXRfZHJ2ZGF0YShkZXYpOworCisJaWYgKHVhcnQpCisJCXVhcnRfcmVzdW1lX3BvcnQoJmJm
aW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBp
bnQgYmZpbl9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQoreworCXN0
cnVjdCByZXNvdXJjZSAqcmVzID0gZGV2LT5yZXNvdXJjZTsKKwlpbnQgaTsKKworCWZvciAoaSA9
IDA7IGkgPCBkZXYtPm51bV9yZXNvdXJjZXM7IGkrKywgcmVzKyspCisJCWlmIChyZXMtPmZsYWdz
ICYgSU9SRVNPVVJDRV9NRU0pCisJCQlicmVhazsKKworCWlmIChpIDwgZGV2LT5udW1fcmVzb3Vy
Y2VzKSB7CisJCWZvciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsgaSsrLCByZXMrKykgeworCQkJaWYg
KGJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQubWFwYmFzZSAhPSByZXMtPnN0YXJ0KQorCQkJCWNv
bnRpbnVlOworCQkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5kZXYgPSAmZGV2LT5kZXY7CisJ
CQl1YXJ0X2FkZF9vbmVfcG9ydCgmYmZpbl9zZXJpYWxfcmVnLCAmYmZpbl9zZXJpYWxfcG9ydHNb
aV0ucG9ydCk7CisJCQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShkZXYsICZiZmluX3NlcmlhbF9wb3J0
c1tpXSk7CisJCX0KKwl9CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBiZmluX3Nlcmlh
bF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgYmZpbl9z
ZXJpYWxfcG9ydCAqdWFydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCisJcGxhdGZv
cm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisKKwlpZiAodWFydCkKKwkJdWFydF9yZW1vdmVf
b25lX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOworCisJcmV0dXJuIDA7Cit9
CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGJmaW5fc2VyaWFsX2RyaXZlciA9IHsK
KwkucHJvYmUJCT0gYmZpbl9zZXJpYWxfcHJvYmUsCisJLnJlbW92ZQkJPSBiZmluX3NlcmlhbF9y
ZW1vdmUsCisJLnN1c3BlbmQJPSBiZmluX3NlcmlhbF9zdXNwZW5kLAorCS5yZXN1bWUJCT0gYmZp
bl9zZXJpYWxfcmVzdW1lLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9ICJiZmluLXVhcnQiLAor
CX0sCit9OworCitzdGF0aWMgaW50IF9faW5pdCBiZmluX3NlcmlhbF9pbml0KHZvaWQpCit7CisJ
aW50IHJldDsKKworCXByaW50ayhLRVJOX0lORk8gIlNlcmlhbDogQmxhY2tmaW4gc2VyaWFsIGRy
aXZlclxuIik7CisKKwliZmluX3NlcmlhbF9pbml0X3BvcnRzKCk7CisKKwlyZXQgPSB1YXJ0X3Jl
Z2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKKwlpZiAocmV0ID09IDApIHsKKwkJcmV0
ID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZiZmluX3NlcmlhbF9kcml2ZXIpOworCQlpZiAo
cmV0KSB7CisJCQlEUFJJTlRLKCJ1YXJ0IHJlZ2lzdGVyIGZhaWxlZFxuIik7CisJCQl1YXJ0X3Vu
cmVnaXN0ZXJfZHJpdmVyKCZiZmluX3NlcmlhbF9yZWcpOworCQl9CisJfQorCXJldHVybiByZXQ7
Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBiZmluX3NlcmlhbF9leGl0KHZvaWQpCit7CisJcGxh
dGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmJmaW5fc2VyaWFsX2RyaXZlcik7CisJdWFydF91bnJl
Z2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKK30KKworbW9kdWxlX2luaXQoYmZpbl9z
ZXJpYWxfaW5pdCk7Cittb2R1bGVfZXhpdChiZmluX3NlcmlhbF9leGl0KTsKKworTU9EVUxFX0FV
VEhPUigiQXVicmV5LkxpIDxhdWJyZXkubGlAYW5hbG9nLmNvbT4iKTsKK01PRFVMRV9ERVNDUklQ
VElPTigiQmxhY2tmaW4gZ2VuZXJpYyBzZXJpYWwgcG9ydCBkcml2ZXIiKTsKK01PRFVMRV9MSUNF
TlNFKCJHUEwiKTsKK01PRFVMRV9BTElBU19DSEFSREVWX01BSk9SKFNFUklBTF9CRklOX01BSk9S
KTsKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvaW5jbHVkZS9saW51eC9zZXJpYWxfY29y
ZS5oIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9saW51eC9zZXJpYWxfY29yZS5oCi0tLSBs
aW51eC0yLjYuMTgucGF0Y2gxL2luY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaAkyMDA2LTA5LTIx
IDA5OjE0OjU0LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMi9pbmNsdWRl
L2xpbnV4L3NlcmlhbF9jb3JlLmgJMjAwNi0wOS0yMSAwOTozODoxNy4wMDAwMDAwMDAgKzA4MDAK
QEAgLTEzMiw2ICsxMzIsOSBAQAogCiAjZGVmaW5lIFBPUlRfUzNDMjQxMgk3MwogCisvKiBCbGFj
a2ZpbiBiZjV4eCAqLworI2RlZmluZSBQT1JUX0JGSU4JNzQKKwogCiAjaWZkZWYgX19LRVJORUxf
XwogCg==
------=_Part_4633_33308932.1158832623121--
