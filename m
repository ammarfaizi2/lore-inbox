Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWIUDdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWIUDdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIUDdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:33:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12434 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751177AbWIUDdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:33:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=fAnCqfcm4zRf0yadaUq+VbSFKogBiDMNWfVgQ0xjUFk5tu4+YOHwLe6dvOPHAIv4vLZVNQRANkNTiiUav+lyuygB7AZkzpD+LECf9krLRj3DJbbhpzq52GslK1jvAw8K52AyWotvXrsjLWDafz8f6rQPZr0N/WduOQS+ffLk4N0=
Message-ID: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
Date: Thu, 21 Sep 2006 11:33:05 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14260_8703619.1158809585647"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14260_8703619.1158809585647
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is the serial driver for Blackfin. It is designed for the serial
core framework.

As to other drivers, I'll send them one by one later.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 drivers/serial/Kconfig      |   35 +
 drivers/serial/Makefile     |    3
 drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    3
 4 files changed, 943 insertions(+), 1 deletion(-)

diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
linux-2.6.18.patch2/drivers/serial/Kconfig
--- linux-2.6.18.patch1/drivers/serial/Kconfig	2006-09-21
09:14:42.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/Kconfig	2006-09-21
09:38:17.000000000 +0800
@@ -488,6 +488,41 @@
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)

+config SERIAL_BFIN
+	bool "Blackfin serial port support (EXPERIMENTAL)"
+	depends on BFIN && EXPERIMENTAL
+	select SERIAL_CORE
+
+config SERIAL_BFIN_CONSOLE
+	bool "Console on Blackfin serial port"
+	depends on SERIAL_BFIN
+	select SERIAL_CORE_CONSOLE
+
+choice
+        prompt  "Blackfin UART Mode"
+        depends on SERIAL_BFIN
+        default SERIAL_BFIN_DMA
+        ---help---
+          This driver supports the built-in serial ports of the
Blackfin family of CPUs
+
+config SERIAL_BFIN_DMA
+        bool "Blackfin UART DMA mode"
+        depends on DMA_UNCACHED_1M
+        help
+          This driver works under DMA mode. If this option is
selected, the blackfin simple dma driver is also enabled.
+
+config SERIAL_BFIN_PIO
+        bool "Blackfin UART PIO mode"
+        help
+          This driver works under PIO mode.
+endchoice
+
+config SERIAL_BFIN_CTSRTS
+	bool "Enable hardware flow control"
+	depends on SERIAL_BFIN
+	help
+	  Enable hardware flow control in the driver. Using GPIO emulate the
CTS/RTS signal.
+
 config SERIAL_IMX
 	bool "IMX serial port support"
 	depends on ARM && ARCH_IMX
diff -urN linux-2.6.18.patch1/drivers/serial/Makefile
linux-2.6.18.patch2/drivers/serial/Makefile
--- linux-2.6.18.patch1/drivers/serial/Makefile	2006-09-21
09:14:42.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/Makefile	2006-09-21
09:38:17.000000000 +0800
@@ -25,6 +25,7 @@
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
+obj-$(CONFIG_SERIAL_BFIN) += bfin_5xx.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
 obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
 obj-$(CONFIG_SERIAL_SUNHV) += sunhv.o
@@ -55,4 +56,4 @@
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
-obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
+obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
\ No newline at end of file
diff -urN linux-2.6.18.patch1/drivers/serial/bfin_5xx.c
linux-2.6.18.patch2/drivers/serial/bfin_5xx.c
--- linux-2.6.18.patch1/drivers/serial/bfin_5xx.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c	2006-09-21
09:38:17.000000000 +0800
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
+	    (uart->port.irq, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
+	     "BFIN_UART0_RX", uart)) {
+		printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
+		return -EBUSY;
+	}
+
+	if (request_irq
+	    (uart->port.irq+1, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
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

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_14260_8703619.1158809585647
Content-Type: text/x-patch; name=blackfin_serial_drv_2.6.18.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_escjll66
Content-Disposition: attachment; filename="blackfin_serial_drv_2.6.18.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvS2NvbmZpZyBsaW51
eC0yLjYuMTgucGF0Y2gyL2RyaXZlcnMvc2VyaWFsL0tjb25maWcKLS0tIGxpbnV4LTIuNi4xOC5w
YXRjaDEvZHJpdmVycy9zZXJpYWwvS2NvbmZpZwkyMDA2LTA5LTIxIDA5OjE0OjQyLjAwMDAwMDAw
MCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMi9kcml2ZXJzL3NlcmlhbC9LY29uZmlnCTIw
MDYtMDktMjEgMDk6Mzg6MTcuMDAwMDAwMDAwICswODAwCkBAIC00ODgsNiArNDg4LDQxIEBACiAJ
ICB5b3VyIGJvb3QgbG9hZGVyIChsaWxvIG9yIGxvYWRsaW4pIGFib3V0IGhvdyB0byBwYXNzIG9w
dGlvbnMgdG8gdGhlCiAJICBrZXJuZWwgYXQgYm9vdCB0aW1lLikKIAorY29uZmlnIFNFUklBTF9C
RklOCisJYm9vbCAiQmxhY2tmaW4gc2VyaWFsIHBvcnQgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKSIK
KwlkZXBlbmRzIG9uIEJGSU4gJiYgRVhQRVJJTUVOVEFMCisJc2VsZWN0IFNFUklBTF9DT1JFCisK
K2NvbmZpZyBTRVJJQUxfQkZJTl9DT05TT0xFCisJYm9vbCAiQ29uc29sZSBvbiBCbGFja2ZpbiBz
ZXJpYWwgcG9ydCIKKwlkZXBlbmRzIG9uIFNFUklBTF9CRklOCisJc2VsZWN0IFNFUklBTF9DT1JF
X0NPTlNPTEUKKworY2hvaWNlCisgICAgICAgIHByb21wdCAgIkJsYWNrZmluIFVBUlQgTW9kZSIK
KyAgICAgICAgZGVwZW5kcyBvbiBTRVJJQUxfQkZJTgorICAgICAgICBkZWZhdWx0IFNFUklBTF9C
RklOX0RNQQorICAgICAgICAtLS1oZWxwLS0tCisgICAgICAgICAgVGhpcyBkcml2ZXIgc3VwcG9y
dHMgdGhlIGJ1aWx0LWluIHNlcmlhbCBwb3J0cyBvZiB0aGUgQmxhY2tmaW4gZmFtaWx5IG9mIENQ
VXMKKworY29uZmlnIFNFUklBTF9CRklOX0RNQQorICAgICAgICBib29sICJCbGFja2ZpbiBVQVJU
IERNQSBtb2RlIgorICAgICAgICBkZXBlbmRzIG9uIERNQV9VTkNBQ0hFRF8xTQorICAgICAgICBo
ZWxwCisgICAgICAgICAgVGhpcyBkcml2ZXIgd29ya3MgdW5kZXIgRE1BIG1vZGUuIElmIHRoaXMg
b3B0aW9uIGlzIHNlbGVjdGVkLCB0aGUgYmxhY2tmaW4gc2ltcGxlIGRtYSBkcml2ZXIgaXMgYWxz
byBlbmFibGVkLgorCitjb25maWcgU0VSSUFMX0JGSU5fUElPCisgICAgICAgIGJvb2wgIkJsYWNr
ZmluIFVBUlQgUElPIG1vZGUiCisgICAgICAgIGhlbHAKKyAgICAgICAgICBUaGlzIGRyaXZlciB3
b3JrcyB1bmRlciBQSU8gbW9kZS4KK2VuZGNob2ljZQorCitjb25maWcgU0VSSUFMX0JGSU5fQ1RT
UlRTCisJYm9vbCAiRW5hYmxlIGhhcmR3YXJlIGZsb3cgY29udHJvbCIKKwlkZXBlbmRzIG9uIFNF
UklBTF9CRklOCisJaGVscAorCSAgRW5hYmxlIGhhcmR3YXJlIGZsb3cgY29udHJvbCBpbiB0aGUg
ZHJpdmVyLiBVc2luZyBHUElPIGVtdWxhdGUgdGhlIENUUy9SVFMgc2lnbmFsLgorCiBjb25maWcg
U0VSSUFMX0lNWAogCWJvb2wgIklNWCBzZXJpYWwgcG9ydCBzdXBwb3J0IgogCWRlcGVuZHMgb24g
QVJNICYmIEFSQ0hfSU1YCmRpZmYgLXVyTiBsaW51eC0yLjYuMTgucGF0Y2gxL2RyaXZlcnMvc2Vy
aWFsL01ha2VmaWxlIGxpbnV4LTIuNi4xOC5wYXRjaDIvZHJpdmVycy9zZXJpYWwvTWFrZWZpbGUK
LS0tIGxpbnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvTWFrZWZpbGUJMjAwNi0wOS0y
MSAwOToxNDo0Mi4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOC5wYXRjaDIvZHJpdmVy
cy9zZXJpYWwvTWFrZWZpbGUJMjAwNi0wOS0yMSAwOTozODoxNy4wMDAwMDAwMDAgKzA4MDAKQEAg
LTI1LDYgKzI1LDcgQEAKIG9iai0kKENPTkZJR19TRVJJQUxfQ0xQUzcxMVgpICs9IGNscHM3MTF4
Lm8KIG9iai0kKENPTkZJR19TRVJJQUxfUFhBKSArPSBweGEubwogb2JqLSQoQ09ORklHX1NFUklB
TF9TQTExMDApICs9IHNhMTEwMC5vCitvYmotJChDT05GSUdfU0VSSUFMX0JGSU4pICs9IGJmaW5f
NXh4Lm8KIG9iai0kKENPTkZJR19TRVJJQUxfUzNDMjQxMCkgKz0gczNjMjQxMC5vCiBvYmotJChD
T05GSUdfU0VSSUFMX1NVTkNPUkUpICs9IHN1bmNvcmUubwogb2JqLSQoQ09ORklHX1NFUklBTF9T
VU5IVikgKz0gc3VuaHYubwpAQCAtNTUsNCArNTYsNCBAQAogb2JqLSQoQ09ORklHX1NFUklBTF9T
R0lfSU9DNCkgKz0gaW9jNF9zZXJpYWwubwogb2JqLSQoQ09ORklHX1NFUklBTF9TR0lfSU9DMykg
Kz0gaW9jM19zZXJpYWwubwogb2JqLSQoQ09ORklHX1NFUklBTF9BVDkxKSArPSBhdDkxX3Nlcmlh
bC5vCi1vYmotJChDT05GSUdfU0VSSUFMX05FVFgpICs9IG5ldHgtc2VyaWFsLm8KK29iai0kKENP
TkZJR19TRVJJQUxfTkVUWCkgKz0gbmV0eC1zZXJpYWwubwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9m
IGZpbGUKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvYmZpbl81
eHguYyBsaW51eC0yLjYuMTgucGF0Y2gyL2RyaXZlcnMvc2VyaWFsL2JmaW5fNXh4LmMKLS0tIGxp
bnV4LTIuNi4xOC5wYXRjaDEvZHJpdmVycy9zZXJpYWwvYmZpbl81eHguYwkxOTcwLTAxLTAxIDA4
OjAwOjAwLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMi9kcml2ZXJzL3Nl
cmlhbC9iZmluXzV4eC5jCTIwMDYtMDktMjEgMDk6Mzg6MTcuMDAwMDAwMDAwICswODAwCkBAIC0w
LDAgKzEsOTAzIEBACisvKgorICogRmlsZTogICAgICAgICBkcml2ZXJzL3NlcmlhbC9iZmluXzV4
eC5jCisgKiBCYXNlZCBvbjogICAgIEJhc2VkIG9uIGRyaXZlcnMvc2VyaWFsL3NhMTEwMC5jCisg
KiBBdXRob3I6ICAgICAgIEF1YnJleSBMaSA8YXVicmV5LmxpQGFuYWxvZy5jb20+CisgKgorICog
Q3JlYXRlZDoKKyAqIERlc2NyaXB0aW9uOiAgRHJpdmVyIGZvciBibGFja2ZpbiA1eHggc2VyaWFs
IHBvcnRzCisgKgorICogUmV2OiAgICAgICAgICAkSWQ6IGJmaW5fNXh4LmMsdiAxLjEyIDIwMDYv
MDkvMDQgMDQ6NDQ6MjcgYXVicmV5IEV4cCAkCisgKgorICogTW9kaWZpZWQ6CisgKiAgICAgICAg
ICAgICAgIENvcHlyaWdodCAyMDA2IEFuYWxvZyBEZXZpY2VzIEluYy4KKyAqCisgKiBCdWdzOiAg
ICAgICAgIEVudGVyIGJ1Z3MgYXQgaHR0cDovL2JsYWNrZmluLnVjbGludXgub3JnLworICoKKyAq
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9w
dGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBB
TlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVS
Q0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRo
ZQorICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisg
KiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIHRoZSBm
aWxlIENPUFlJTkcsIG9yIHdyaXRlCisgKiB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
LCBJbmMuLAorICogNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BICAwMjEx
MC0xMzAxICBVU0EKKyAqLworCisjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CisKKyNpZiBkZWZp
bmVkKENPTkZJR19TRVJJQUxfQkZJTl9DT05TT0xFKSAmJiBkZWZpbmVkKENPTkZJR19NQUdJQ19T
WVNSUSkKKyNkZWZpbmUgU1VQUE9SVF9TWVNSUQorI2VuZGlmCisKKyNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9pb3BvcnQuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+CisjaW5jbHVkZSA8bGludXgvY29uc29sZS5oPgorI2luY2x1ZGUgPGxpbnV4L3N5c3JxLmg+
CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvdHR5
Lmg+CisjaW5jbHVkZSA8bGludXgvdHR5X2ZsaXAuaD4KKyNpbmNsdWRlIDxsaW51eC9zZXJpYWxf
Y29yZS5oPgorCisjaW5jbHVkZSA8YXNtL21hY2gvYmZpbl9zZXJpYWxfNXh4Lmg+CisKKyNpZmRl
ZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4K
KyNpbmNsdWRlIDxhc20vaW8uaD4KKyNpbmNsdWRlIDxhc20vaXJxLmg+CisjaW5jbHVkZSA8YXNt
L2NhY2hlZmx1c2guaD4KKyNlbmRpZgorCisvKiBXZSd2ZSBiZWVuIGFzc2lnbmVkIGEgcmFuZ2Ug
b24gdGhlICJMb3ctZGVuc2l0eSBzZXJpYWwgcG9ydHMiIG1ham9yICovCisjZGVmaW5lIFNFUklB
TF9CRklOX01BSk9SCVRUWV9NQUpPUgorI2RlZmluZSBNSU5PUl9TVEFSVAkJNjQKKworI2RlZmlu
ZSBERUJVRworCisjaWZkZWYgREVCVUcKKyMgZGVmaW5lIERQUklOVEsoeC4uLikgICBwcmludGso
S0VSTl9ERUJVRyB4KQorI2Vsc2UKKyMgZGVmaW5lIERQUklOVEsoeC4uLikgICBkbyB7IH0gd2hp
bGUgKDApCisjZW5kaWYKKworLyoKKyAqIFNldHVwIGZvciBjb25zb2xlLiBBcmd1bWVudCBjb21l
cyBmcm9tIHRoZSBtZW51Y29uZmlnCisgKi8KKworI2lmIGRlZmluZWQoQ09ORklHX0JBVURfOTYw
MCkKKyNkZWZpbmUgQ09OU09MRV9CQVVEX1JBVEUgICAgICAgOTYwMAorI2VsaWYgZGVmaW5lZChD
T05GSUdfQkFVRF8xOTIwMCkKKyNkZWZpbmUgQ09OU09MRV9CQVVEX1JBVEUgICAgICAgMTkyMDAK
KyNlbGlmIGRlZmluZWQoQ09ORklHX0JBVURfMzg0MDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9S
QVRFICAgICAgIDM4NDAwCisjZWxpZiBkZWZpbmVkKENPTkZJR19CQVVEXzU3NjAwKQorI2RlZmlu
ZSBDT05TT0xFX0JBVURfUkFURSAgICAgICA1NzYwMAorI2VsaWYgZGVmaW5lZChDT05GSUdfQkFV
RF8xMTUyMDApCisjZGVmaW5lIENPTlNPTEVfQkFVRF9SQVRFICAgICAgIDExNTIwMAorI2VuZGlm
CisKKyNkZWZpbmUgRE1BX1JYX1hDT1VOVAkJVFRZX0ZMSVBCVUZfU0laRQorI2RlZmluZSBETUFf
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
cG9ydCkKK3sKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fQ1RTUlRTCisJaWYgKGJmaW5fcmVh
ZDE2KENUU19QT1JUKSAmICgxPDxDVFNfUElOKSkKKwkJcmV0dXJuIFRJT0NNX0RTUiB8IFRJT0NN
X0NBUjsKKwllbHNlCisjZW5kaWYKKwkJcmV0dXJuIFRJT0NNX0NUUyB8IFRJT0NNX0RTUiB8IFRJ
T0NNX0NBUjsKK30KKworc3RhdGljIHZvaWQgYmZpbl9zZXJpYWxfc2V0X21jdHJsKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsIHVuc2lnbmVkIGludCBtY3RybCkKK3sKKyNpZmRlZiBDT05GSUdfU0VS
SUFMX0JGSU5fQ1RTUlRTCisJaWYgKG1jdHJsICYgVElPQ01fUlRTKQorCQliZmluX3dyaXRlMTYo
UlRTX1BPUlQsIGJmaW5fcmVhZDE2KFJUU19QT1JUKSYofjE8PFJUU19QSU4pKTsKKwllbHNlCisJ
CWJmaW5fd3JpdGUxNihSVFNfUE9SVCwgYmZpbl9yZWFkMTYoUlRTX1BPUlQpfCgxPDxSVFNfUElO
KSk7CisjZW5kaWYKK30KKworLyoKKyAqIEhhbmRsZSBhbnkgY2hhbmdlIG9mIG1vZGVtIHN0YXR1
cyBzaWduYWwgc2luY2Ugd2Ugd2VyZSBsYXN0IGNhbGxlZC4KKyAqLworc3RhdGljIHZvaWQgYmZp
bl9zZXJpYWxfbWN0cmxfY2hlY2soc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQpCit7Cisj
aWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0NUU1JUUworCXVuc2lnbmVkIGludCBzdGF0dXM7Cisj
aWZkZWYgQ09ORklHX1NFUklBTF9CRklOX0RNQQorCXN0cnVjdCB1YXJ0X2luZm8gKmluZm8gPSB1
YXJ0LT5wb3J0LmluZm87CisJc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSA9IGluZm8tPnR0eTsKKwlz
dGF0dXMgPSBiZmluX3NlcmlhbF9nZXRfbWN0cmwoJnVhcnQtPnBvcnQpOworCWlmICghKHN0YXR1
cyAmIFRJT0NNX0NUUykpIHsKKwkJdHR5LT5od19zdG9wcGVkID0gMTsKKwl9IGVsc2UgeworCQl0
dHktPmh3X3N0b3BwZWQgPSAwOworCX0KKyNlbHNlCisJc3RhdHVzID0gYmZpbl9zZXJpYWxfZ2V0
X21jdHJsKCZ1YXJ0LT5wb3J0KTsKKwl1YXJ0X2hhbmRsZV9jdHNfY2hhbmdlKCZ1YXJ0LT5wb3J0
LCBzdGF0dXMgJiBUSU9DTV9DVFMpOworCWlmICghKHN0YXR1cyAmIFRJT0NNX0NUUykpCisJCXNj
aGVkdWxlX3dvcmsoJnVhcnQtPmN0c193b3JrcXVldWUpOworI2VuZGlmCisjZW5kaWYKK30KKwor
LyoKKyAqIEludGVycnVwdHMgYWx3YXlzIGRpc2FibGVkLgorICovCitzdGF0aWMgdm9pZCBiZmlu
X3NlcmlhbF9icmVha19jdGwoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgaW50IGJyZWFrX3N0YXRl
KQoreworfQorCitpbnQgYmZpbl9zZXJpYWxfc3RhcnR1cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3Nlcmlh
bF9wb3J0ICopcG9ydDsKKworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJTl9ETUEKKwlkbWFfYWRk
cl90IGRtYV9oYW5kbGU7CisKKwlpZiAocmVxdWVzdF9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWws
ICJCRklOX1VBUlRfUlgiKSA8IDApIHsKKwkJcHJpbnRrKEtFUk5fTk9USUNFICJVbmFibGUgdG8g
YXR0YWNoIEJsYWNrZmluIFVBUlQgUlggRE1BIGNoYW5uZWxcbiIpOworCQlyZXR1cm4gLUVCVVNZ
OworCX0gZWxzZQorCQlzZXRfZG1hX2NhbGxiYWNrKHVhcnQtPnJ4X2RtYV9jaGFubmVsLCBiZmlu
X3NlcmlhbF9kbWFfcnhfaW50LCB1YXJ0KTsKKworCWlmIChyZXF1ZXN0X2RtYSh1YXJ0LT50eF9k
bWFfY2hhbm5lbCwgIkJGSU5fVUFSVF9UWCIpIDwgMCkgeworCQlwcmludGsoS0VSTl9OT1RJQ0Ug
IlVuYWJsZSB0byBhdHRhY2ggQmxhY2tmaW4gVUFSVCBUWCBETUEgY2hhbm5lbFxuIik7CisJCXJl
dHVybiAtRUJVU1k7CisJfSBlbHNlCisJCXNldF9kbWFfY2FsbGJhY2sodWFydC0+dHhfZG1hX2No
YW5uZWwsIGJmaW5fc2VyaWFsX2RtYV90eF9pbnQsIHVhcnQpOworCisJdWFydC0+cnhfZG1hX2J1
Zi5idWYgPSAodW5zaWduZWQgY2hhciAqKWRtYV9hbGxvY19jb2hlcmVudChOVUxMLCBQQUdFX1NJ
WkUsICZkbWFfaGFuZGxlLCBHRlBfRE1BKTsKKwl1YXJ0LT5yeF9kbWFfYnVmLmhlYWQgPSAwOwor
CXVhcnQtPnJ4X2RtYV9idWYudGFpbCA9IDA7CisJdWFydC0+cnhfZG1hX25yb3dzID0gMDsKKwor
CXNldF9kbWFfY29uZmlnKHVhcnQtPnJ4X2RtYV9jaGFubmVsLAorCQlzZXRfYmZpbl9kbWFfY29u
ZmlnKERJUl9XUklURSwgRE1BX0ZMT1dfQVVUTywKKwkJCQlJTlRSX09OX1JPVywgRElNRU5TSU9O
XzJELAorCQkJCURBVEFfU0laRV84KSk7CisJc2V0X2RtYV94X2NvdW50KHVhcnQtPnJ4X2RtYV9j
aGFubmVsLCBETUFfUlhfWENPVU5UKTsKKwlzZXRfZG1hX3hfbW9kaWZ5KHVhcnQtPnJ4X2RtYV9j
aGFubmVsLCAxKTsKKwlzZXRfZG1hX3lfY291bnQodWFydC0+cnhfZG1hX2NoYW5uZWwsIERNQV9S
WF9ZQ09VTlQpOworCXNldF9kbWFfeV9tb2RpZnkodWFydC0+cnhfZG1hX2NoYW5uZWwsIDEpOwor
CXNldF9kbWFfc3RhcnRfYWRkcih1YXJ0LT5yeF9kbWFfY2hhbm5lbCwgKHVuc2lnbmVkIGxvbmcp
dWFydC0+cnhfZG1hX2J1Zi5idWYpOworCWVuYWJsZV9kbWEodWFydC0+cnhfZG1hX2NoYW5uZWwp
OworCisJdWFydC0+cnhfZG1hX3RpbWVyLmRhdGEgPSAodW5zaWduZWQgbG9uZykodWFydCk7CisJ
dWFydC0+cnhfZG1hX3RpbWVyLmZ1bmN0aW9uID0gKHZvaWQgKiliZmluX3NlcmlhbF9yeF9kbWFf
dGltZW91dDsKKwl1YXJ0LT5yeF9kbWFfdGltZXIuZXhwaXJlcyA9IGppZmZpZXMgKyBETUFfUlhf
RkxVU0hfSklGRklFUzsKKwlhZGRfdGltZXIoJih1YXJ0LT5yeF9kbWFfdGltZXIpKTsKKyNlbHNl
CisJaWYgKHJlcXVlc3RfaXJxCisJICAgICh1YXJ0LT5wb3J0LmlycSwgYmZpbl9zZXJpYWxfaW50
LCBTQV9JTlRFUlJVUFQgfCBTQV9TSElSUSwKKwkgICAgICJCRklOX1VBUlQwX1JYIiwgdWFydCkp
IHsKKwkJcHJpbnRrKEtFUk5fTk9USUNFICJVbmFibGUgdG8gYXR0YWNoIEJsYWNrRmluIFVBUlQg
UlggaW50ZXJydXB0XG4iKTsKKwkJcmV0dXJuIC1FQlVTWTsKKwl9CisKKwlpZiAocmVxdWVzdF9p
cnEKKwkgICAgKHVhcnQtPnBvcnQuaXJxKzEsIGJmaW5fc2VyaWFsX2ludCwgU0FfSU5URVJSVVBU
IHwgU0FfU0hJUlEsCisJICAgICAiQkZJTl9VQVJUMF9UWCIsIHVhcnQpKSB7CisJCXByaW50ayhL
RVJOX05PVElDRSAiVW5hYmxlIHRvIGF0dGFjaCBCbGFja0ZpbiBVQVJUIFRYIGludGVycnVwdFxu
Iik7CisJCXJldHVybiAtRUJVU1k7CisJfQorI2VuZGlmCisJVUFSVF9QVVRfSUVSKHVhcnQsIFVB
UlRfR0VUX0lFUih1YXJ0KSB8IEVSQkZJKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQg
YmZpbl9zZXJpYWxfc2h1dGRvd24oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlzdHJ1Y3Qg
YmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IChzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqKXBvcnQ7
CisKKyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fRE1BCisJZGlzYWJsZV9kbWEodWFydC0+dHhf
ZG1hX2NoYW5uZWwpOworCWZyZWVfZG1hKHVhcnQtPnR4X2RtYV9jaGFubmVsKTsKKwlkaXNhYmxl
X2RtYSh1YXJ0LT5yeF9kbWFfY2hhbm5lbCk7CisJZnJlZV9kbWEodWFydC0+cnhfZG1hX2NoYW5u
ZWwpOworCWRlbF90aW1lcigmKHVhcnQtPnJ4X2RtYV90aW1lcikpOworI2Vsc2UKKwlmcmVlX2ly
cSh1YXJ0LT5wb3J0LmlycSwgdWFydCk7CisJZnJlZV9pcnEodWFydC0+cG9ydC5pcnErMSwgdWFy
dCk7CisjZW5kaWYKK30KKworc3RhdGljIHZvaWQKK2JmaW5fc2VyaWFsX3NldF90ZXJtaW9zKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCB0ZXJtaW9zICp0ZXJtaW9zLAorCQkgICBzdHJ1
Y3QgdGVybWlvcyAqb2xkKQoreworfQorCitzdGF0aWMgY29uc3QgY2hhciAqYmZpbl9zZXJpYWxf
dHlwZShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0
ICp1YXJ0ID0gKHN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICopcG9ydDsKKwlyZXR1cm4gdWFydC0+
cG9ydC50eXBlID09IFBPUlRfQkZJTiA/ICJCRklOLVVBUlQiIDogTlVMTDsKK30KKworLyoKKyAq
IFJlbGVhc2UgdGhlIG1lbW9yeSByZWdpb24ocykgYmVpbmcgdXNlZCBieSAncG9ydCcuCisgKi8K
K3N0YXRpYyB2b2lkIGJmaW5fc2VyaWFsX3JlbGVhc2VfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpw
b3J0KQoreworfQorCisvKgorICogUmVxdWVzdCB0aGUgbWVtb3J5IHJlZ2lvbihzKSBiZWluZyB1
c2VkIGJ5ICdwb3J0Jy4KKyAqLworc3RhdGljIGludCBiZmluX3NlcmlhbF9yZXF1ZXN0X3BvcnQo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKK3sKKwlyZXR1cm4gMDsKK30KKworLyoKKyAqIENvbmZp
Z3VyZS9hdXRvY29uZmlndXJlIHRoZSBwb3J0LgorICovCitzdGF0aWMgdm9pZCBiZmluX3Nlcmlh
bF9jb25maWdfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBpbnQgZmxhZ3MpCit7CisJc3Ry
dWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSAoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKilw
b3J0OworCisJaWYgKGZsYWdzICYgVUFSVF9DT05GSUdfVFlQRSAmJgorCSAgICBiZmluX3Nlcmlh
bF9yZXF1ZXN0X3BvcnQoJnVhcnQtPnBvcnQpID09IDApCisJCXVhcnQtPnBvcnQudHlwZSA9IFBP
UlRfQkZJTjsKK30KKworLyoKKyAqIFZlcmlmeSB0aGUgbmV3IHNlcmlhbF9zdHJ1Y3QgKGZvciBU
SU9DU1NFUklBTCkuCisgKiBUaGUgb25seSBjaGFuZ2Ugd2UgYWxsb3cgYXJlIHRvIHRoZSBmbGFn
cyBhbmQgdHlwZSwgYW5kCisgKiBldmVuIHRoZW4gb25seSBiZXR3ZWVuIFBPUlRfQkZJTiBhbmQg
UE9SVF9VTktOT1dOCisgKi8KK3N0YXRpYyBpbnQKK2JmaW5fc2VyaWFsX3ZlcmlmeV9wb3J0KHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfc3RydWN0ICpzZXIpCit7CisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9vcHMgYmZpbl9zZXJpYWxfcG9wcyA9IHsK
KwkudHhfZW1wdHkJPSBiZmluX3NlcmlhbF90eF9lbXB0eSwKKwkuc2V0X21jdHJsCT0gYmZpbl9z
ZXJpYWxfc2V0X21jdHJsLAorCS5nZXRfbWN0cmwJPSBiZmluX3NlcmlhbF9nZXRfbWN0cmwsCisJ
LnN0b3BfdHgJPSBiZmluX3NlcmlhbF9zdG9wX3R4LAorCS5zdGFydF90eAk9IGJmaW5fc2VyaWFs
X3N0YXJ0X3R4LAorCS5zdG9wX3J4CT0gYmZpbl9zZXJpYWxfc3RvcF9yeCwKKwkuZW5hYmxlX21z
CT0gYmZpbl9zZXJpYWxfZW5hYmxlX21zLAorCS5icmVha19jdGwJPSBiZmluX3NlcmlhbF9icmVh
a19jdGwsCisJLnN0YXJ0dXAJPSBiZmluX3NlcmlhbF9zdGFydHVwLAorCS5zaHV0ZG93bgk9IGJm
aW5fc2VyaWFsX3NodXRkb3duLAorCS5zZXRfdGVybWlvcwk9IGJmaW5fc2VyaWFsX3NldF90ZXJt
aW9zLAorCS50eXBlCQk9IGJmaW5fc2VyaWFsX3R5cGUsCisJLnJlbGVhc2VfcG9ydAk9IGJmaW5f
c2VyaWFsX3JlbGVhc2VfcG9ydCwKKwkucmVxdWVzdF9wb3J0CT0gYmZpbl9zZXJpYWxfcmVxdWVz
dF9wb3J0LAorCS5jb25maWdfcG9ydAk9IGJmaW5fc2VyaWFsX2NvbmZpZ19wb3J0LAorCS52ZXJp
ZnlfcG9ydAk9IGJmaW5fc2VyaWFsX3ZlcmlmeV9wb3J0LAorfTsKKworc3RhdGljIGludCBiZmlu
X3NlcmlhbF9jYWxjX2JhdWQodW5zaWduZWQgaW50IHVhcnRjbGspCit7CisJaW50IGJhdWQ7CisJ
YmF1ZCA9IGdldF9zY2xrKCkvKHVhcnRjbGsqOCk7CisJaWYgKChiYXVkICYgMHgxKSA9PSAxKSB7
CisJCWJhdWQrKzsKKwl9CisJcmV0dXJuIGJhdWQvMjsKK30KKworc3RhdGljIHZvaWQgX19pbml0
IGJmaW5fc2VyaWFsX2luaXRfcG9ydHModm9pZCkKK3sKKwlzdGF0aWMgaW50IGZpcnN0ID0gMTsK
KwlpbnQgaTsKKwl1bnNpZ25lZCBzaG9ydCB2YWw7CisJaW50IGJhdWQ7CisKKwlpZiAoIWZpcnN0
KQorCQlyZXR1cm47CisJZmlyc3QgPSAwOworCWJmaW5fc2VyaWFsX2h3X2luaXQoKTsKKworCWZv
ciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsgaSsrKSB7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ldLnBv
cnQudWFydGNsayAgID0gQ09OU09MRV9CQVVEX1JBVEU7CisJCWJmaW5fc2VyaWFsX3BvcnRzW2ld
LnBvcnQub3BzICAgICAgID0gJmJmaW5fc2VyaWFsX3BvcHM7CisJCWJmaW5fc2VyaWFsX3BvcnRz
W2ldLnBvcnQubGluZSAgICAgID0gaTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5pb3R5
cGUgICAgPSBVUElPX01FTTsKKwkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC5tZW1iYXNlICAg
PSAodm9pZCBfX2lvbWVtICopdWFydF9iYXNlX2FkZHJbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRz
W2ldLnBvcnQubWFwYmFzZSAgID0gdWFydF9iYXNlX2FkZHJbaV07CisJCWJmaW5fc2VyaWFsX3Bv
cnRzW2ldLnBvcnQuaXJxICAgICAgID0gdWFydF9pcnFbaV07CisJCWJmaW5fc2VyaWFsX3BvcnRz
W2ldLnBvcnQuZmxhZ3MgICAgID0gVVBGX0JPT1RfQVVUT0NPTkY7CisjaWZkZWYgQ09ORklHX1NF
UklBTF9CRklOX0RNQQorCQliZmluX3NlcmlhbF9wb3J0c1tpXS50eF9kb25lCSAgICA9IDE7CisJ
CWJmaW5fc2VyaWFsX3BvcnRzW2ldLnR4X2NvdW50CSAgICA9IDA7CisJCWJmaW5fc2VyaWFsX3Bv
cnRzW2ldLnR4X2RtYV9jaGFubmVsID0gdWFydF90eF9kbWFfY2hhbm5lbFtpXTsKKwkJYmZpbl9z
ZXJpYWxfcG9ydHNbaV0ucnhfZG1hX2NoYW5uZWwgPSB1YXJ0X3J4X2RtYV9jaGFubmVsW2ldOwor
CisJCWluaXRfdGltZXIoJihiZmluX3NlcmlhbF9wb3J0c1tpXS5yeF9kbWFfdGltZXIpKTsKKyNl
bHNlCisJCUlOSVRfV09SSygmYmZpbl9zZXJpYWxfcG9ydHNbaV0uY3RzX3dvcmtxdWV1ZSwgYmZp
bl9zZXJpYWxfZG9fd29yaywgJmJmaW5fc2VyaWFsX3BvcnRzW2ldKTsKKyNlbmRpZgorCisJCWJh
dWQgPSBiZmluX3NlcmlhbF9jYWxjX2JhdWQoYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydC51YXJ0
Y2xrKTsKKworCQkvKiBFbmFibGUgVUFSVCAqLworCQl2YWwgPSBVQVJUX0dFVF9HQ1RMKCZiZmlu
X3NlcmlhbF9wb3J0c1tpXSk7CisJCXZhbCB8PSBVQ0VOOworCQlVQVJUX1BVVF9HQ1RMKCZiZmlu
X3NlcmlhbF9wb3J0c1tpXSwgdmFsKTsKKworCQkvKiBTZXQgRExBQiBpbiBMQ1IgdG8gQWNjZXNz
IERMTCBhbmQgRExIICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNb
aV0pOworCQl2YWwgfD0gRExBQjsKKwkJVUFSVF9QVVRfTENSKCZiZmluX3NlcmlhbF9wb3J0c1tp
XSwgdmFsKTsKKworCQlVQVJUX1BVVF9ETEwoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCBiYXVkJjB4
RkYpOworCQlVQVJUX1BVVF9ETEgoJmJmaW5fc2VyaWFsX3BvcnRzW2ldLCAoYmF1ZD4+OCkmMHhG
Rik7CisKKwkJLyogQ2xlYXIgRExBQiBpbiBMQ1IgdG8gQWNjZXNzIFRIUiBSQlIgSUVSICovCisJ
CXZhbCA9IFVBUlRfR0VUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0pOworCQl2YWwgJj0gfkRM
QUI7CisJCVVBUlRfUFVUX0xDUigmYmZpbl9zZXJpYWxfcG9ydHNbaV0sIHZhbCk7CisKKwkJLyog
U2V0IExDUiB0byBXb3JkIExlbmdoIDgtYml0IHdvcmQgc2VsZWN0ICovCisJCXZhbCA9IFdMUyg4
KTsKKwkJVUFSVF9QVVRfTENSKCZiZmluX3NlcmlhbF9wb3J0c1tpXSwgdmFsKTsKKwl9Cit9CisK
KyNpZmRlZiBDT05GSUdfU0VSSUFMX0JGSU5fQ09OU09MRQorLyoKKyAqIEludGVycnVwdHMgYXJl
IGRpc2FibGVkIG9uIGVudGVyaW5nCisgKi8KK3N0YXRpYyB2b2lkCitiZmluX3NlcmlhbF9jb25z
b2xlX3dyaXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqcywgdW5zaWduZWQgaW50
IGNvdW50KQoreworCXN0cnVjdCBiZmluX3NlcmlhbF9wb3J0ICp1YXJ0ID0gJmJmaW5fc2VyaWFs
X3BvcnRzW2NvLT5pbmRleF07CisJaW50IGZsYWdzID0gMDsKKwl1bnNpZ25lZCBzaG9ydCBzdGF0
dXMsIHRtcDsKKwlpbnQgaTsKKworCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKworCWZvciAoaSA9
IDA7IGkgPCBjb3VudDsgaSsrKSB7CisJCWRvIHsKKwkJCXN0YXR1cyA9IFVBUlRfR0VUX0xTUih1
YXJ0KTsKKwkJfSB3aGlsZSAoIShzdGF0dXMgJiBUSFJFKSk7CisKKwkJdG1wID0gVUFSVF9HRVRf
TENSKHVhcnQpOworCQl0bXAgJj0gfkRMQUI7CisJCVVBUlRfUFVUX0xDUih1YXJ0LCB0bXApOwor
CisJCVVBUlRfUFVUX0NIQVIodWFydCwgc1tpXSk7CisJCWlmIChzW2ldID09ICdcbicpIHsKKwkJ
CWRvIHsKKwkJCQlzdGF0dXMgPSBVQVJUX0dFVF9MU1IodWFydCk7CisJCQl9IHdoaWxlKCEoc3Rh
dHVzICYgVEhSRSkpOworCQkJVUFSVF9QVVRfQ0hBUih1YXJ0LCAnXHInKTsKKwkJfQorCX0KKwor
CWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKK30KKworLyoKKyAqIElmIHRoZSBwb3J0IHdhcyBh
bHJlYWR5IGluaXRpYWxpc2VkIChlZywgYnkgYSBib290IGxvYWRlciksCisgKiB0cnkgdG8gZGV0
ZXJtaW5lIHRoZSBjdXJyZW50IHNldHVwLgorICovCitzdGF0aWMgdm9pZCBfX2luaXQKK2JmaW5f
c2VyaWFsX2NvbnNvbGVfZ2V0X29wdGlvbnMoc3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQs
IGludCAqYmF1ZCwKKwkJCSAgIGludCAqcGFyaXR5LCBpbnQgKmJpdHMpCit7CisJdW5zaWduZWQg
c2hvcnQgc3RhdHVzOworCisJc3RhdHVzID0gVUFSVF9HRVRfSUVSKHVhcnQpICYgKEVSQkZJIHwg
RVRCRUkpOworCWlmIChzdGF0dXMgPT0gKEVSQkZJIHwgRVRCRUkpKSB7CisJCS8qIG9rLCB0aGUg
cG9ydCB3YXMgZW5hYmxlZCAqLworCQl1bnNpZ25lZCBzaG9ydCBsY3IsIHZhbDsKKwkJdW5zaWdu
ZWQgc2hvcnQgZGxoLCBkbGw7CisKKwkJbGNyID0gVUFSVF9HRVRfTENSKHVhcnQpOworCisJCSpw
YXJpdHkgPSAnbic7CisJCWlmIChsY3IgJiBQRU4pIHsKKwkJCWlmIChsY3IgJiBFUFMpCisJCQkJ
KnBhcml0eSA9ICdlJzsKKwkJCWVsc2UKKwkJCQkqcGFyaXR5ID0gJ28nOworCQl9CisJCXN3aXRj
aCAobGNyICYgMHgwMykgeworCQkJY2FzZSAwOgkqYml0cyA9IDU7IGJyZWFrOworCQkJY2FzZSAx
OgkqYml0cyA9IDY7IGJyZWFrOworCQkJY2FzZSAyOgkqYml0cyA9IDc7IGJyZWFrOworCQkJY2Fz
ZSAzOgkqYml0cyA9IDg7IGJyZWFrOworCQl9CisJCS8qIFNldCBETEFCIGluIExDUiB0byBBY2Nl
c3MgRExMIGFuZCBETEggKi8KKwkJdmFsID0gVUFSVF9HRVRfTENSKHVhcnQpOworCQl2YWwgfD0g
RExBQjsKKwkJVUFSVF9QVVRfTENSKHVhcnQsIHZhbCk7CisKKwkJZGxsID0gVUFSVF9HRVRfRExM
KHVhcnQpOworCQlkbGggPSBVQVJUX0dFVF9ETEgodWFydCk7CisKKwkJLyogQ2xlYXIgRExBQiBp
biBMQ1IgdG8gQWNjZXNzIFRIUiBSQlIgSUVSICovCisJCXZhbCA9IFVBUlRfR0VUX0xDUih1YXJ0
KTsKKwkJdmFsICY9IH5ETEFCOworCQlVQVJUX1BVVF9MQ1IodWFydCwgdmFsKTsKKworCQkqYmF1
ZCA9IGdldF9zY2xrKCkvKDE2KihkbGx8ZGxoPDw4KSk7CisJfQorCURQUklOVEsoIiVzOmJhdWQg
PSAlZCwgcGFyaXR5ID0gJWMsIGJpdHM9ICVkXG4iLCBfX0ZVTkNUSU9OX18sICpiYXVkLCAqcGFy
aXR5LCAqYml0cyk7Cit9CisKK3N0YXRpYyBpbnQgX19pbml0CitiZmluX3NlcmlhbF9jb25zb2xl
X3NldHVwKHN0cnVjdCBjb25zb2xlICpjbywgY2hhciAqb3B0aW9ucykKK3sKKwlzdHJ1Y3QgYmZp
bl9zZXJpYWxfcG9ydCAqdWFydDsKKwlpbnQgYmF1ZCA9IENPTlNPTEVfQkFVRF9SQVRFOworCWlu
dCBiaXRzID0gODsKKwlpbnQgcGFyaXR5ID0gJ24nOworI2lmZGVmIENPTkZJR19TRVJJQUxfQkZJ
Tl9DVFNSVFMKKwlpbnQgZmxvdyA9ICdyJzsKKyNlbHNlCisJaW50IGZsb3cgPSAnbic7CisjZW5k
aWYKKworCS8qCisJICogQ2hlY2sgd2hldGhlciBhbiBpbnZhbGlkIHVhcnQgbnVtYmVyIGhhcyBi
ZWVuIHNwZWNpZmllZCwgYW5kCisJICogaWYgc28sIHNlYXJjaCBmb3IgdGhlIGZpcnN0IGF2YWls
YWJsZSBwb3J0IHRoYXQgZG9lcyBoYXZlCisJICogY29uc29sZSBzdXBwb3J0LgorCSAqLworCWlm
IChjby0+aW5kZXggPT0gLTEgfHwgY28tPmluZGV4ID49IE5SX1BPUlRTKQorCQljby0+aW5kZXgg
PSAwOworCXVhcnQgPSAmYmZpbl9zZXJpYWxfcG9ydHNbY28tPmluZGV4XTsKKworCWlmIChvcHRp
b25zKQorCQl1YXJ0X3BhcnNlX29wdGlvbnMob3B0aW9ucywgJmJhdWQsICZwYXJpdHksICZiaXRz
LCAmZmxvdyk7CisJZWxzZQorCQliZmluX3NlcmlhbF9jb25zb2xlX2dldF9vcHRpb25zKHVhcnQs
ICZiYXVkLCAmcGFyaXR5LCAmYml0cyk7CisKKwlyZXR1cm4gdWFydF9zZXRfb3B0aW9ucygmdWFy
dC0+cG9ydCwgY28sIGJhdWQsIHBhcml0eSwgYml0cywgZmxvdyk7Cit9CisKK3N0YXRpYyBzdHJ1
Y3QgdWFydF9kcml2ZXIgYmZpbl9zZXJpYWxfcmVnOworc3RhdGljIHN0cnVjdCBjb25zb2xlIGJm
aW5fc2VyaWFsX2NvbnNvbGUgPSB7CisJLm5hbWUJCT0gInR0eVMiLAorCS53cml0ZQkJPSBiZmlu
X3NlcmlhbF9jb25zb2xlX3dyaXRlLAorCS5kZXZpY2UJCT0gdWFydF9jb25zb2xlX2RldmljZSwK
Kwkuc2V0dXAJCT0gYmZpbl9zZXJpYWxfY29uc29sZV9zZXR1cCwKKwkuZmxhZ3MJCT0gQ09OX1BS
SU5UQlVGRkVSLAorCS5pbmRleAkJPSAtMSwKKwkuZGF0YQkJPSAmYmZpbl9zZXJpYWxfcmVnLAor
fTsKKworc3RhdGljIGludCBfX2luaXQgYmZpbl9zZXJpYWxfcnNfY29uc29sZV9pbml0KHZvaWQp
Cit7CisJYmZpbl9zZXJpYWxfaW5pdF9wb3J0cygpOworCXJlZ2lzdGVyX2NvbnNvbGUoJmJmaW5f
c2VyaWFsX2NvbnNvbGUpOworCXJldHVybiAwOworfQorY29uc29sZV9pbml0Y2FsbChiZmluX3Nl
cmlhbF9yc19jb25zb2xlX2luaXQpOworCisjZGVmaW5lIEJGSU5fU0VSSUFMX0NPTlNPTEUJJmJm
aW5fc2VyaWFsX2NvbnNvbGUKKyNlbHNlCisjZGVmaW5lIEJGSU5fU0VSSUFMX0NPTlNPTEUJTlVM
TAorI2VuZGlmCisKK3N0YXRpYyBzdHJ1Y3QgdWFydF9kcml2ZXIgYmZpbl9zZXJpYWxfcmVnID0g
eworCS5vd25lcgkJCT0gVEhJU19NT0RVTEUsCisJLmRyaXZlcl9uYW1lCQk9ICJiZmluLXVhcnQi
LAorCS5kZXZfbmFtZQkJPSAidHR5UyIsCisJLm1ham9yCQkJPSBTRVJJQUxfQkZJTl9NQUpPUiwK
KwkubWlub3IJCQk9IE1JTk9SX1NUQVJULAorCS5ucgkJCT0gTlJfUE9SVFMsCisJLmNvbnMJCQk9
IEJGSU5fU0VSSUFMX0NPTlNPTEUsCit9OworCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3N1c3Bl
bmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJ
c3RydWN0IGJmaW5fc2VyaWFsX3BvcnQgKnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYp
OworCisJaWYgKHVhcnQpCisJCXVhcnRfc3VzcGVuZF9wb3J0KCZiZmluX3NlcmlhbF9yZWcsICZ1
YXJ0LT5wb3J0KTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGJmaW5fc2VyaWFsX3Jl
c3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGJmaW5fc2VyaWFs
X3BvcnQgKnVhcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJaWYgKHVhcnQpCisJ
CXVhcnRfcmVzdW1lX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBvcnQpOworCisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgYmZpbl9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqZGV2KQoreworCXN0cnVjdCByZXNvdXJjZSAqcmVzID0gZGV2LT5yZXNvdXJjZTsK
KwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBkZXYtPm51bV9yZXNvdXJjZXM7IGkrKywgcmVz
KyspCisJCWlmIChyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9NRU0pCisJCQlicmVhazsKKworCWlm
IChpIDwgZGV2LT5udW1fcmVzb3VyY2VzKSB7CisJCWZvciAoaSA9IDA7IGkgPCBOUl9QT1JUUzsg
aSsrLCByZXMrKykgeworCQkJaWYgKGJmaW5fc2VyaWFsX3BvcnRzW2ldLnBvcnQubWFwYmFzZSAh
PSByZXMtPnN0YXJ0KQorCQkJCWNvbnRpbnVlOworCQkJYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9y
dC5kZXYgPSAmZGV2LT5kZXY7CisJCQl1YXJ0X2FkZF9vbmVfcG9ydCgmYmZpbl9zZXJpYWxfcmVn
LCAmYmZpbl9zZXJpYWxfcG9ydHNbaV0ucG9ydCk7CisJCQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShk
ZXYsICZiZmluX3NlcmlhbF9wb3J0c1tpXSk7CisJCX0KKwl9CisKKwlyZXR1cm4gMDsKK30KKwor
c3RhdGljIGludCBiZmluX3NlcmlhbF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKK3sKKwlzdHJ1Y3QgYmZpbl9zZXJpYWxfcG9ydCAqdWFydCA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisKKwlpZiAo
dWFydCkKKwkJdWFydF9yZW1vdmVfb25lX3BvcnQoJmJmaW5fc2VyaWFsX3JlZywgJnVhcnQtPnBv
cnQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGJm
aW5fc2VyaWFsX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gYmZpbl9zZXJpYWxfcHJvYmUsCisJLnJl
bW92ZQkJPSBiZmluX3NlcmlhbF9yZW1vdmUsCisJLnN1c3BlbmQJPSBiZmluX3NlcmlhbF9zdXNw
ZW5kLAorCS5yZXN1bWUJCT0gYmZpbl9zZXJpYWxfcmVzdW1lLAorCS5kcml2ZXIJCT0geworCQku
bmFtZQk9ICJiZmluLXVhcnQiLAorCX0sCit9OworCitzdGF0aWMgaW50IF9faW5pdCBiZmluX3Nl
cmlhbF9pbml0KHZvaWQpCit7CisJaW50IHJldDsKKworCXByaW50ayhLRVJOX0lORk8gIlNlcmlh
bDogQmxhY2tmaW4gc2VyaWFsIGRyaXZlclxuIik7CisKKwliZmluX3NlcmlhbF9pbml0X3BvcnRz
KCk7CisKKwlyZXQgPSB1YXJ0X3JlZ2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKKwlp
ZiAocmV0ID09IDApIHsKKwkJcmV0ID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZiZmluX3Nl
cmlhbF9kcml2ZXIpOworCQlpZiAocmV0KSB7CisJCQlEUFJJTlRLKCJ1YXJ0IHJlZ2lzdGVyIGZh
aWxlZFxuIik7CisJCQl1YXJ0X3VucmVnaXN0ZXJfZHJpdmVyKCZiZmluX3NlcmlhbF9yZWcpOwor
CQl9CisJfQorCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBiZmluX3Nlcmlh
bF9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmJmaW5fc2VyaWFs
X2RyaXZlcik7CisJdWFydF91bnJlZ2lzdGVyX2RyaXZlcigmYmZpbl9zZXJpYWxfcmVnKTsKK30K
KworbW9kdWxlX2luaXQoYmZpbl9zZXJpYWxfaW5pdCk7Cittb2R1bGVfZXhpdChiZmluX3Nlcmlh
bF9leGl0KTsKKworTU9EVUxFX0FVVEhPUigiQXVicmV5LkxpIDxhdWJyZXkubGlAYW5hbG9nLmNv
bT4iKTsKK01PRFVMRV9ERVNDUklQVElPTigiQmxhY2tmaW4gZ2VuZXJpYyBzZXJpYWwgcG9ydCBk
cml2ZXIiKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVMRV9BTElBU19DSEFSREVWX01B
Sk9SKFNFUklBTF9CRklOX01BSk9SKTsKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDEvaW5j
bHVkZS9saW51eC9zZXJpYWxfY29yZS5oIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9saW51
eC9zZXJpYWxfY29yZS5oCi0tLSBsaW51eC0yLjYuMTgucGF0Y2gxL2luY2x1ZGUvbGludXgvc2Vy
aWFsX2NvcmUuaAkyMDA2LTA5LTIxIDA5OjE0OjU0LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgt
Mi42LjE4LnBhdGNoMi9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgJMjAwNi0wOS0yMSAwOToz
ODoxNy4wMDAwMDAwMDAgKzA4MDAKQEAgLTEzMiw2ICsxMzIsOSBAQAogCiAjZGVmaW5lIFBPUlRf
UzNDMjQxMgk3MwogCisvKiBCbGFja2ZpbiBiZjV4eCAqLworI2RlZmluZSBQT1JUX0JGSU4JNzQK
KwogCiAjaWZkZWYgX19LRVJORUxfXwogCg==
------=_Part_14260_8703619.1158809585647--
