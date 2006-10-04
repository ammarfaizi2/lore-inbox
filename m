Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWJDSlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWJDSlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWJDSlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:41:52 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:11519 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1422715AbWJDSlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:41:50 -0400
Date: Wed, 4 Oct 2006 22:41:36 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: akpm@osdl.org
Cc: "Ralf Baechle" <ralf@linux-mips.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] add pnx8xxx serial driver support
Message-Id: <20061004224136.000040c1.vitalywool@gmail.com>
Organization: MontaVista
X-Mailer: Sylpheed version 0.7.5-20020429 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for PNX8330/8550/8950 Philips MIPS-based SoCs.

 drivers/serial/Kconfig         |   16 
 drivers/serial/Makefile        |    1 
 drivers/serial/pnx8xxx_uart.c  |  853 +++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h    |    2 
 include/linux/serial_ip3106.h  |   81 ---
 include/linux/serial_pnx8xxx.h |   81 +++
 6 files changed, 952 insertions(+), 82 deletions(-)

 Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6.git/drivers/serial/Kconfig
===================================================================
--- linux-2.6.git.orig/drivers/serial/Kconfig
+++ linux-2.6.git/drivers/serial/Kconfig
@@ -657,6 +657,22 @@ config SERIAL_SH_SCI_CONSOLE
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 
+config SERIAL_PNX8XXX
+	bool "Enable PNX8XXX SoCs' UART Support"
+	depends on MIPS && SOC_PNX8550
+	select SERIAL_CORE
+	help
+	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  and you want to use serial ports, say Y.  Otherwise, say N.
+
+config SERIAL_PNX8XXX_CONSOLE
+	bool "Enable PNX8XX0 serial console"
+	depends on SERIAL_PNX8XXX
+	select SERIAL_CORE_CONSOLE
+	help
+	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  and you want to use serial console, say Y. Otherwise, say N.
+
 config SERIAL_CORE
 	tristate
 
Index: linux-2.6.git/drivers/serial/pnx8xxx_uart.c
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/serial/pnx8xxx_uart.c
@@ -0,0 +1,853 @@
+/*
+ * UART driver for PNX8XXX SoCs
+ *
+ * Author: Per Hallsmark per.hallsmark@mvista.com
+ * Ported to 2.6 kernel by EmbeddedAlley
+ * Reworked by Vitaly Wool <vitalywool@gmail.com>
+ *
+ * Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ * Copyright (C) 2000 Deep Blue Solutions Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ *
+ */
+
+#if defined(CONFIG_SERIAL_PNX8XXX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_pnx8xxx.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+/* We'll be using StrongARM sa1100 serial port major/minor */
+#define SERIAL_PNX8XXX_MAJOR	204
+#define MINOR_START		5
+
+#define NR_PORTS		2
+
+#define PNX8XXX_ISR_PASS_LIMIT	256
+
+/*
+ * Convert from ignore_status_mask or read_status_mask to FIFO
+ * and interrupt status bits
+ */
+#define SM_TO_FIFO(x)	((x) >> 10)
+#define SM_TO_ISTAT(x)	((x) & 0x000001ff)
+#define FIFO_TO_SM(x)	((x) << 10)
+#define ISTAT_TO_SM(x)	((x) & 0x000001ff)
+
+/*
+ * This is the size of our serial port register set.
+ */
+#define UART_PORT_SIZE	0x1000
+
+/*
+ * This determines how often we check the modem status signals
+ * for any change.  They generally aren't connected to an IRQ
+ * so we have to poll them.  We also check immediately before
+ * filling the TX fifo incase CTS has been dropped.
+ */
+#define MCTRL_TIMEOUT	(250*HZ/1000)
+
+extern struct pnx8xxx_port pnx8xxx_ports[];
+
+static inline int serial_in(struct pnx8xxx_port *sport, int offset)
+{
+	return (__raw_readl(sport->port.membase + offset));
+}
+
+static inline void serial_out(struct pnx8xxx_port *sport, int offset, int value)
+{
+	__raw_writel(value, sport->port.membase + offset);
+}
+
+/*
+ * Handle any change of modem status signal since we were last called.
+ */
+static void pnx8xxx_mctrl_check(struct pnx8xxx_port *sport)
+{
+	unsigned int status, changed;
+
+	status = sport->port.ops->get_mctrl(&sport->port);
+	changed = status ^ sport->old_status;
+
+	if (changed == 0)
+		return;
+
+	sport->old_status = status;
+
+	if (changed & TIOCM_RI)
+		sport->port.icount.rng++;
+	if (changed & TIOCM_DSR)
+		sport->port.icount.dsr++;
+	if (changed & TIOCM_CAR)
+		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
+	if (changed & TIOCM_CTS)
+		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
+
+	wake_up_interruptible(&sport->port.info->delta_msr_wait);
+}
+
+/*
+ * This is our per-port timeout handler, for checking the
+ * modem status signals.
+ */
+static void pnx8xxx_timeout(unsigned long data)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)data;
+	unsigned long flags;
+
+	if (sport->port.info) {
+		spin_lock_irqsave(&sport->port.lock, flags);
+		pnx8xxx_mctrl_check(sport);
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+		mod_timer(&sport->timer, jiffies + MCTRL_TIMEOUT);
+	}
+}
+
+/*
+ * interrupts disabled on entry
+ */
+static void pnx8xxx_stop_tx(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	u32 ien;
+
+	/* Disable TX intr */
+	ien = serial_in(sport, PNX8XXX_IEN);
+	serial_out(sport, PNX8XXX_IEN, ien & ~PNX8XXX_UART_INT_ALLTX);
+
+	/* Clear all pending TX intr */
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLTX);
+}
+
+/*
+ * interrupts may not be disabled on entry
+ */
+static void pnx8xxx_start_tx(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	u32 ien;
+
+	/* Clear all pending TX intr */
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLTX);
+
+	/* Enable TX intr */
+	ien = serial_in(sport, PNX8XXX_IEN);
+	serial_out(sport, PNX8XXX_IEN, ien | PNX8XXX_UART_INT_ALLTX);
+}
+
+/*
+ * Interrupts enabled
+ */
+static void pnx8xxx_stop_rx(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	u32 ien;
+
+	/* Disable RX intr */
+	ien = serial_in(sport, PNX8XXX_IEN);
+	serial_out(sport, PNX8XXX_IEN, ien & ~PNX8XXX_UART_INT_ALLRX);
+
+	/* Clear all pending RX intr */
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLRX);
+}
+
+/*
+ * Set the modem control timer to fire immediately.
+ */
+static void pnx8xxx_enable_ms(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+
+	mod_timer(&sport->timer, jiffies);
+}
+
+static void
+pnx8xxx_rx_chars(struct pnx8xxx_port *sport, struct pt_regs *regs)
+{
+	struct tty_struct *tty = sport->port.info->tty;
+	unsigned int status, ch, flg;
+
+	status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
+		 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
+	while (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFIFO)) {
+		ch = serial_in(sport, PNX8XXX_FIFO);
+
+		sport->port.icount.rx++;
+
+		flg = TTY_NORMAL;
+
+		/*
+		 * note that the error handling code is
+		 * out of the main execution path
+		 */
+		if (status & (FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE |
+					PNX8XXX_UART_FIFO_RXPAR) |
+			      ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN))) {
+			if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR))
+				sport->port.icount.parity++;
+			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
+				sport->port.icount.frame++;
+			if (status & ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN))
+				sport->port.icount.overrun++;
+
+			status &= sport->port.read_status_mask;
+
+			if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR))
+				flg = TTY_PARITY;
+			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
+				flg = TTY_FRAME;
+
+#ifdef SUPPORT_SYSRQ
+			sport->port.sysrq = 0;
+#endif
+		}
+
+		if (uart_handle_sysrq_char(&sport->port, ch, regs))
+			goto ignore_char;
+
+		uart_insert_char(&sport->port, status,
+				ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN), ch, flg);
+
+	ignore_char:
+		serial_out(sport, PNX8XXX_LCR, serial_in(sport, PNX8XXX_LCR) |
+				PNX8XXX_UART_LCR_RX_NEXT);
+		status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
+			 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
+	}
+	tty_flip_buffer_push(tty);
+}
+
+static void pnx8xxx_tx_chars(struct pnx8xxx_port *sport)
+{
+	struct circ_buf *xmit = &sport->port.info->xmit;
+
+	if (sport->port.x_char) {
+		serial_out(sport, PNX8XXX_FIFO, sport->port.x_char);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
+		return;
+	}
+
+	/*
+	 * Check the modem control lines before
+	 * transmitting anything.
+	 */
+	pnx8xxx_mctrl_check(sport);
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+		pnx8xxx_stop_tx(&sport->port);
+		return;
+	}
+
+	/*
+	 * TX while bytes available
+	 */
+	while (((serial_in(sport, PNX8XXX_FIFO) &
+					PNX8XXX_UART_FIFO_TXFIFO) >> 16) < 16) {
+		serial_out(sport, PNX8XXX_FIFO, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		sport->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&sport->port);
+
+	if (uart_circ_empty(xmit))
+		pnx8xxx_stop_tx(&sport->port);
+}
+
+static irqreturn_t pnx8xxx_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct pnx8xxx_port *sport = dev_id;
+	unsigned int status;
+
+	spin_lock(&sport->port.lock);
+	/* Get the interrupts */
+	status  = serial_in(sport, PNX8XXX_ISTAT) & serial_in(sport, PNX8XXX_IEN);
+
+	/* Break signal received */
+	if (status & PNX8XXX_UART_INT_BREAK) {
+		sport->port.icount.brk++;
+		uart_handle_break(&sport->port);
+	}
+
+	/* Byte received */
+	if (status & PNX8XXX_UART_INT_RX)
+		pnx8xxx_rx_chars(sport, regs);
+
+	/* TX holding register empty - transmit a byte */
+	if (status & PNX8XXX_UART_INT_TX)
+		pnx8xxx_tx_chars(sport);
+
+	/* Clear the ISTAT register */
+	serial_out(sport, PNX8XXX_ICLR, status);
+
+	spin_unlock(&sport->port.lock);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Return TIOCSER_TEMT when transmitter is not busy.
+ */
+static unsigned int pnx8xxx_tx_empty(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+
+	return serial_in(sport, PNX8XXX_FIFO) & PNX8XXX_UART_FIFO_TXFIFO_STA ? 0 : TIOCSER_TEMT;
+}
+
+static unsigned int pnx8xxx_get_mctrl(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	unsigned int mctrl = TIOCM_DSR;
+	unsigned int msr;
+
+	/* REVISIT */
+
+	msr = serial_in(sport, PNX8XXX_MCR);
+
+	mctrl |= msr & PNX8XXX_UART_MCR_CTS ? TIOCM_CTS : 0;
+	mctrl |= msr & PNX8XXX_UART_MCR_DCD ? TIOCM_CAR : 0;
+
+	return mctrl;
+}
+
+static void pnx8xxx_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+#if	0	/* FIXME */
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	unsigned int msr;
+#endif
+}
+
+/*
+ * Interrupts always disabled.
+ */
+static void pnx8xxx_break_ctl(struct uart_port *port, int break_state)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	unsigned long flags;
+	unsigned int lcr;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	lcr = serial_in(sport, PNX8XXX_LCR);
+	if (break_state == -1)
+		lcr |= PNX8XXX_UART_LCR_TXBREAK;
+	else
+		lcr &= ~PNX8XXX_UART_LCR_TXBREAK;
+	serial_out(sport, PNX8XXX_LCR, lcr);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
+static int pnx8xxx_startup(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	int retval;
+
+	/*
+	 * Allocate the IRQ
+	 */
+	retval = request_irq(sport->port.irq, pnx8xxx_int, 0,
+			     "pnx8xxx-uart", sport);
+	if (retval)
+		return retval;
+
+	/*
+	 * Finally, clear and enable interrupts
+	 */
+
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLRX |
+			     PNX8XXX_UART_INT_ALLTX);
+
+	serial_out(sport, PNX8XXX_IEN, serial_in(sport, PNX8XXX_IEN) |
+			    PNX8XXX_UART_INT_ALLRX |
+			    PNX8XXX_UART_INT_ALLTX);
+
+	/*
+	 * Enable modem status interrupts
+	 */
+	spin_lock_irq(&sport->port.lock);
+	pnx8xxx_enable_ms(&sport->port);
+	spin_unlock_irq(&sport->port.lock);
+
+	return 0;
+}
+
+static void pnx8xxx_shutdown(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	int lcr;
+
+	/*
+	 * Stop our timer.
+	 */
+	del_timer_sync(&sport->timer);
+
+	/*
+	 * Disable all interrupts
+	 */
+	serial_out(sport, PNX8XXX_IEN, 0);
+
+	/*
+	 * Reset the Tx and Rx FIFOS, disable the break condition
+	 */
+	lcr = serial_in(sport, PNX8XXX_LCR);
+	lcr &= ~PNX8XXX_UART_LCR_TXBREAK;
+	lcr |= PNX8XXX_UART_LCR_TX_RST | PNX8XXX_UART_LCR_RX_RST;
+	serial_out(sport, PNX8XXX_LCR, lcr);
+
+	/*
+	 * Clear all interrupts
+	 */
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLRX |
+			     PNX8XXX_UART_INT_ALLTX);
+
+	/*
+	 * Free the interrupt
+	 */
+	free_irq(sport->port.irq, sport);
+}
+
+static void
+pnx8xxx_set_termios(struct uart_port *port, struct termios *termios,
+		   struct termios *old)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	unsigned long flags;
+	unsigned int lcr_fcr, old_ien, baud, quot;
+	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
+
+	/*
+	 * We only support CS7 and CS8.
+	 */
+	while ((termios->c_cflag & CSIZE) != CS7 &&
+	       (termios->c_cflag & CSIZE) != CS8) {
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= old_csize;
+		old_csize = CS8;
+	}
+
+	if ((termios->c_cflag & CSIZE) == CS8)
+		lcr_fcr = PNX8XXX_UART_LCR_8BIT;
+	else
+		lcr_fcr = 0;
+
+	if (termios->c_cflag & CSTOPB)
+		lcr_fcr |= PNX8XXX_UART_LCR_2STOPB;
+	if (termios->c_cflag & PARENB) {
+		lcr_fcr |= PNX8XXX_UART_LCR_PAREN;
+		if (!(termios->c_cflag & PARODD))
+			lcr_fcr |= PNX8XXX_UART_LCR_PAREVN;
+	}
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
+	quot = uart_get_divisor(port, baud);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	sport->port.read_status_mask = ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN) |
+				ISTAT_TO_SM(PNX8XXX_UART_INT_EMPTY) |
+				ISTAT_TO_SM(PNX8XXX_UART_INT_RX);
+	if (termios->c_iflag & INPCK)
+		sport->port.read_status_mask |=
+			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE) |
+			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR);
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		sport->port.read_status_mask |=
+			ISTAT_TO_SM(PNX8XXX_UART_INT_BREAK);
+
+	/*
+	 * Characters to ignore
+	 */
+	sport->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		sport->port.ignore_status_mask |=
+			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE) |
+			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR);
+	if (termios->c_iflag & IGNBRK) {
+		sport->port.ignore_status_mask |=
+			ISTAT_TO_SM(PNX8XXX_UART_INT_BREAK);
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			sport->port.ignore_status_mask |=
+				ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN);
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		sport->port.ignore_status_mask |=
+			ISTAT_TO_SM(PNX8XXX_UART_INT_RX);
+
+	del_timer_sync(&sport->timer);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
+	 * disable interrupts and drain transmitter
+	 */
+	old_ien = serial_in(sport, PNX8XXX_IEN);
+	serial_out(sport, PNX8XXX_IEN, old_ien & ~(PNX8XXX_UART_INT_ALLTX |
+					PNX8XXX_UART_INT_ALLRX));
+
+	while (serial_in(sport, PNX8XXX_FIFO) & PNX8XXX_UART_FIFO_TXFIFO_STA)
+		barrier();
+
+	/* then, disable everything */
+	serial_out(sport, PNX8XXX_IEN, 0);
+
+	/* Reset the Rx and Tx FIFOs too */
+	lcr_fcr |= PNX8XXX_UART_LCR_TX_RST;
+	lcr_fcr |= PNX8XXX_UART_LCR_RX_RST;
+
+	/* set the parity, stop bits and data size */
+	serial_out(sport, PNX8XXX_LCR, lcr_fcr);
+
+	/* set the baud rate */
+	quot -= 1;
+	serial_out(sport, PNX8XXX_BAUD, quot);
+
+	serial_out(sport, PNX8XXX_ICLR, -1);
+
+	serial_out(sport, PNX8XXX_IEN, old_ien);
+
+	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
+		pnx8xxx_enable_ms(&sport->port);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
+static const char *pnx8xxx_type(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+
+	return sport->port.type == PORT_PNX8XXX ? "PNX8XXX" : NULL;
+}
+
+/*
+ * Release the memory region(s) being used by 'port'.
+ */
+static void pnx8xxx_release_port(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+
+	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+}
+
+/*
+ * Request the memory region(s) being used by 'port'.
+ */
+static int pnx8xxx_request_port(struct uart_port *port)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+			"pnx8xxx-uart") != NULL ? 0 : -EBUSY;
+}
+
+/*
+ * Configure/autoconfigure the port.
+ */
+static void pnx8xxx_config_port(struct uart_port *port, int flags)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+
+	if (flags & UART_CONFIG_TYPE &&
+	    pnx8xxx_request_port(&sport->port) == 0)
+		sport->port.type = PORT_PNX8XXX;
+}
+
+/*
+ * Verify the new serial_struct (for TIOCSSERIAL).
+ * The only change we allow are to the flags and type, and
+ * even then only between PORT_PNX8XXX and PORT_UNKNOWN
+ */
+static int
+pnx8xxx_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	int ret = 0;
+
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_PNX8XXX)
+		ret = -EINVAL;
+	if (sport->port.irq != ser->irq)
+		ret = -EINVAL;
+	if (ser->io_type != SERIAL_IO_MEM)
+		ret = -EINVAL;
+	if (sport->port.uartclk / 16 != ser->baud_base)
+		ret = -EINVAL;
+	if ((void *)sport->port.mapbase != ser->iomem_base)
+		ret = -EINVAL;
+	if (sport->port.iobase != ser->port)
+		ret = -EINVAL;
+	if (ser->hub6 != 0)
+		ret = -EINVAL;
+	return ret;
+}
+
+static struct uart_ops pnx8xxx_pops = {
+	.tx_empty	= pnx8xxx_tx_empty,
+	.set_mctrl	= pnx8xxx_set_mctrl,
+	.get_mctrl	= pnx8xxx_get_mctrl,
+	.stop_tx	= pnx8xxx_stop_tx,
+	.start_tx	= pnx8xxx_start_tx,
+	.stop_rx	= pnx8xxx_stop_rx,
+	.enable_ms	= pnx8xxx_enable_ms,
+	.break_ctl	= pnx8xxx_break_ctl,
+	.startup	= pnx8xxx_startup,
+	.shutdown	= pnx8xxx_shutdown,
+	.set_termios	= pnx8xxx_set_termios,
+	.type		= pnx8xxx_type,
+	.release_port	= pnx8xxx_release_port,
+	.request_port	= pnx8xxx_request_port,
+	.config_port	= pnx8xxx_config_port,
+	.verify_port	= pnx8xxx_verify_port,
+};
+
+
+/*
+ * Setup the PNX8XXX serial ports.
+ *
+ * Note also that we support "console=ttySx" where "x" is either 0 or 1.
+ */
+static void __init pnx8xxx_init_ports(void)
+{
+	static int first = 1;
+	int i;
+
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0; i < NR_PORTS; i++) {
+		init_timer(&pnx8xxx_ports[i].timer);
+		pnx8xxx_ports[i].timer.function = pnx8xxx_timeout;
+		pnx8xxx_ports[i].timer.data     = (unsigned long)&pnx8xxx_ports[i];
+		pnx8xxx_ports[i].port.ops = &pnx8xxx_pops;
+	}
+}
+
+#ifdef CONFIG_SERIAL_PNX8XXX_CONSOLE
+
+static void pnx8xxx_console_putchar(struct uart_port *port, int ch)
+{
+	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
+	int status;
+
+	do {
+		/* Wait for UART_TX register to empty */
+		status = serial_in(sport, PNX8XXX_FIFO);
+	} while (status & PNX8XXX_UART_FIFO_TXFIFO);
+	serial_out(sport, PNX8XXX_FIFO, ch);
+}
+
+/*
+ * Interrupts are disabled on entering
+ */static void
+pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct pnx8xxx_port *sport = &pnx8xxx_ports[co->index];
+	unsigned int old_ien, status;
+
+	/*
+	 *	First, save IEN and then disable interrupts
+	 */
+	old_ien = serial_in(sport, PNX8XXX_IEN);
+	serial_out(sport, PNX8XXX_IEN, old_ien & ~(PNX8XXX_UART_INT_ALLTX |
+					PNX8XXX_UART_INT_ALLRX));
+
+	uart_console_write(&sport->port, s, count, pnx8xxx_console_putchar);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore IEN
+	 */
+	do {
+		/* Wait for UART_TX register to empty */
+		status = serial_in(sport, PNX8XXX_FIFO);
+	} while (status & PNX8XXX_UART_FIFO_TXFIFO);
+
+	/* Clear TX and EMPTY interrupt */
+	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX |
+			     PNX8XXX_UART_INT_EMPTY);
+
+	serial_out(sport, PNX8XXX_IEN, old_ien);
+}
+
+static int __init
+pnx8xxx_console_setup(struct console *co, char *options)
+{
+	struct pnx8xxx_port *sport;
+	int baud = 38400;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index == -1 || co->index >= NR_PORTS)
+		co->index = 0;
+	sport = &pnx8xxx_ports[co->index];
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
+}
+
+extern struct uart_driver pnx8xxx_reg;
+static struct console pnx8xxx_console = {
+	.name		= "ttyS",
+	.write		= pnx8xxx_console_write,
+	.device		= uart_console_device,
+	.setup		= pnx8xxx_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &pnx8xxx_reg,
+};
+
+static int __init pnx8xxx_rs_console_init(void)
+{
+	pnx8xxx_init_ports();
+	register_console(&pnx8xxx_console);
+	return 0;
+}
+console_initcall(pnx8xxx_rs_console_init);
+
+#define PNX8XXX_CONSOLE	&pnx8xxx_console
+#else
+#define PNX8XXX_CONSOLE	NULL
+#endif
+
+static struct uart_driver pnx8xxx_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "ttyS",
+	.dev_name		= "ttyS",
+	.major			= SERIAL_PNX8XXX_MAJOR,
+	.minor			= MINOR_START,
+	.nr			= NR_PORTS,
+	.cons			= PNX8XXX_CONSOLE,
+};
+
+static int pnx8xxx_serial_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
+
+	return uart_suspend_port(&pnx8xxx_reg, &sport->port);
+}
+
+static int pnx8xxx_serial_resume(struct platform_device *pdev)
+{
+	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
+
+	return uart_resume_port(&pnx8xxx_reg, &sport->port);
+}
+
+static int pnx8xxx_serial_probe(struct platform_device *pdev)
+{
+	struct resource *res = pdev->resource;
+	int i;
+
+	for (i = 0; i < pdev->num_resources; i++, res++) {
+		if (!(res->flags & IORESOURCE_MEM))
+			continue;
+
+		for (i = 0; i < NR_PORTS; i++) {
+			if (pnx8xxx_ports[i].port.mapbase != res->start)
+				continue;
+
+			pnx8xxx_ports[i].port.dev = &pdev->dev;
+			uart_add_one_port(&pnx8xxx_reg, &pnx8xxx_ports[i].port);
+			platform_set_drvdata(pdev, &pnx8xxx_ports[i]);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int pnx8xxx_serial_remove(struct platform_device *pdev)
+{
+	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (sport)
+		uart_remove_one_port(&pnx8xxx_reg, &sport->port);
+
+	return 0;
+}
+
+static struct platform_driver pnx8xxx_serial_driver = {
+	.driver		= {
+		.name	= "pnx8xxx-uart",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pnx8xxx_serial_probe,
+	.remove		= pnx8xxx_serial_remove,
+	.suspend	= pnx8xxx_serial_suspend,
+	.resume		= pnx8xxx_serial_resume,
+};
+
+static int __init pnx8xxx_serial_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Serial: PNX8XXX driver $Revision: 1.2 $\n");
+
+	pnx8xxx_init_ports();
+
+	ret = uart_register_driver(&pnx8xxx_reg);
+	if (ret == 0) {
+		ret = platform_driver_register(&pnx8xxx_serial_driver);
+		if (ret)
+			uart_unregister_driver(&pnx8xxx_reg);
+	}
+	return ret;
+}
+
+static void __exit pnx8xxx_serial_exit(void)
+{
+	platform_driver_unregister(&pnx8xxx_serial_driver);
+	uart_unregister_driver(&pnx8xxx_reg);
+}
+
+module_init(pnx8xxx_serial_init);
+module_exit(pnx8xxx_serial_exit);
+
+MODULE_AUTHOR("Embedded Alley Solutions, Inc.");
+MODULE_DESCRIPTION("PNX8XXX SoCs serial port driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_PNX8XXX_MAJOR);
Index: linux-2.6.git/drivers/serial/Makefile
===================================================================
--- linux-2.6.git.orig/drivers/serial/Makefile
+++ linux-2.6.git/drivers/serial/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
+obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
 obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
Index: linux-2.6.git/include/linux/serial_ip3106.h
===================================================================
--- linux-2.6.git.orig/include/linux/serial_ip3106.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Embedded Alley Solutions, source@embeddedalley.com.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef _LINUX_SERIAL_IP3106_H
-#define _LINUX_SERIAL_IP3106_H
-
-#include <linux/serial_core.h>
-#include <linux/device.h>
-
-#define IP3106_NR_PORTS		2
-
-struct ip3106_port {
-	struct uart_port	port;
-	struct timer_list	timer;
-	unsigned int		old_status;
-};
-
-/* register offsets */
-#define IP3106_LCR		0
-#define IP3106_MCR		0x004
-#define IP3106_BAUD		0x008
-#define IP3106_CFG		0x00c
-#define IP3106_FIFO		0x028
-#define IP3106_ISTAT		0xfe0
-#define IP3106_IEN		0xfe4
-#define IP3106_ICLR		0xfe8
-#define IP3106_ISET		0xfec
-#define IP3106_PD		0xff4
-#define IP3106_MID		0xffc
-
-#define IP3106_UART_LCR_TXBREAK		(1<<30)
-#define IP3106_UART_LCR_PAREVN		0x10000000
-#define IP3106_UART_LCR_PAREN		0x08000000
-#define IP3106_UART_LCR_2STOPB		0x04000000
-#define IP3106_UART_LCR_8BIT		0x01000000
-#define IP3106_UART_LCR_TX_RST		0x00040000
-#define IP3106_UART_LCR_RX_RST		0x00020000
-#define IP3106_UART_LCR_RX_NEXT		0x00010000
-
-#define IP3106_UART_MCR_SCR		0xFF000000
-#define IP3106_UART_MCR_DCD		0x00800000
-#define IP3106_UART_MCR_CTS		0x00100000
-#define IP3106_UART_MCR_LOOP		0x00000010
-#define IP3106_UART_MCR_RTS		0x00000002
-#define IP3106_UART_MCR_DTR		0x00000001
-
-#define IP3106_UART_INT_TX		0x00000080
-#define IP3106_UART_INT_EMPTY		0x00000040
-#define IP3106_UART_INT_RCVTO		0x00000020
-#define IP3106_UART_INT_RX		0x00000010
-#define IP3106_UART_INT_RXOVRN		0x00000008
-#define IP3106_UART_INT_FRERR		0x00000004
-#define IP3106_UART_INT_BREAK		0x00000002
-#define IP3106_UART_INT_PARITY		0x00000001
-#define IP3106_UART_INT_ALLRX		0x0000003F
-#define IP3106_UART_INT_ALLTX		0x000000C0
-
-#define IP3106_UART_FIFO_TXFIFO		0x001F0000
-#define IP3106_UART_FIFO_TXFIFO_STA	(0x1f<<16)
-#define IP3106_UART_FIFO_RXBRK		0x00008000
-#define IP3106_UART_FIFO_RXFE		0x00004000
-#define IP3106_UART_FIFO_RXPAR		0x00002000
-#define IP3106_UART_FIFO_RXFIFO		0x00001F00
-#define IP3106_UART_FIFO_RBRTHR		0x000000FF
-
-#endif
Index: linux-2.6.git/include/linux/serial_pnx8xxx.h
===================================================================
--- /dev/null
+++ linux-2.6.git/include/linux/serial_pnx8xxx.h
@@ -0,0 +1,81 @@
+/*
+ * Embedded Alley Solutions, source@embeddedalley.com.
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _LINUX_SERIAL_PNX8XXX_H
+#define _LINUX_SERIAL_PNX8XXX_H
+
+#include <linux/serial_core.h>
+#include <linux/device.h>
+
+#define PNX8XXX_NR_PORTS	2
+
+struct pnx8xxx_port {
+	struct uart_port	port;
+	struct timer_list	timer;
+	unsigned int		old_status;
+};
+
+/* register offsets */
+#define PNX8XXX_LCR		0
+#define PNX8XXX_MCR		0x004
+#define PNX8XXX_BAUD		0x008
+#define PNX8XXX_CFG		0x00c
+#define PNX8XXX_FIFO		0x028
+#define PNX8XXX_ISTAT		0xfe0
+#define PNX8XXX_IEN		0xfe4
+#define PNX8XXX_ICLR		0xfe8
+#define PNX8XXX_ISET		0xfec
+#define PNX8XXX_PD		0xff4
+#define PNX8XXX_MID		0xffc
+
+#define PNX8XXX_UART_LCR_TXBREAK	(1<<30)
+#define PNX8XXX_UART_LCR_PAREVN		0x10000000
+#define PNX8XXX_UART_LCR_PAREN		0x08000000
+#define PNX8XXX_UART_LCR_2STOPB		0x04000000
+#define PNX8XXX_UART_LCR_8BIT		0x01000000
+#define PNX8XXX_UART_LCR_TX_RST		0x00040000
+#define PNX8XXX_UART_LCR_RX_RST		0x00020000
+#define PNX8XXX_UART_LCR_RX_NEXT	0x00010000
+
+#define PNX8XXX_UART_MCR_SCR		0xFF000000
+#define PNX8XXX_UART_MCR_DCD		0x00800000
+#define PNX8XXX_UART_MCR_CTS		0x00100000
+#define PNX8XXX_UART_MCR_LOOP		0x00000010
+#define PNX8XXX_UART_MCR_RTS		0x00000002
+#define PNX8XXX_UART_MCR_DTR		0x00000001
+
+#define PNX8XXX_UART_INT_TX		0x00000080
+#define PNX8XXX_UART_INT_EMPTY		0x00000040
+#define PNX8XXX_UART_INT_RCVTO		0x00000020
+#define PNX8XXX_UART_INT_RX		0x00000010
+#define PNX8XXX_UART_INT_RXOVRN		0x00000008
+#define PNX8XXX_UART_INT_FRERR		0x00000004
+#define PNX8XXX_UART_INT_BREAK		0x00000002
+#define PNX8XXX_UART_INT_PARITY		0x00000001
+#define PNX8XXX_UART_INT_ALLRX		0x0000003F
+#define PNX8XXX_UART_INT_ALLTX		0x000000C0
+
+#define PNX8XXX_UART_FIFO_TXFIFO	0x001F0000
+#define PNX8XXX_UART_FIFO_TXFIFO_STA	(0x1f<<16)
+#define PNX8XXX_UART_FIFO_RXBRK		0x00008000
+#define PNX8XXX_UART_FIFO_RXFE		0x00004000
+#define PNX8XXX_UART_FIFO_RXPAR		0x00002000
+#define PNX8XXX_UART_FIFO_RXFIFO	0x00001F00
+#define PNX8XXX_UART_FIFO_RBRTHR	0x000000FF
+
+#endif
Index: linux-2.6.git/include/linux/serial_core.h
===================================================================
--- linux-2.6.git.orig/include/linux/serial_core.h
+++ linux-2.6.git/include/linux/serial_core.h
@@ -122,7 +122,7 @@
 /*Digi jsm */
 #define PORT_JSM        69
 
-#define PORT_IP3106	70
+#define PORT_PNX8XXX	70
 
 /* Hilscher netx */
 #define PORT_NETX	71
