Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWAUSu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWAUSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWAUSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:50:58 -0500
Received: from mailhub.hp.com ([192.151.27.10]:46054 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S932246AbWAUSu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:50:57 -0500
Subject: [PATCH] backup timer for UARTs that lose interrupts (updated
	spinlocking)
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Jan 2006 11:53:06 -0700
Message-Id: <1137869586.16056.146.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   This is an update to the following patch current found in the -mm
tree:

backup-timer-for-uarts-that-lose-interrupts-take-3.patch

The only change is that the spinlocks around 8250_handle_port() have
been removed to be consistent with changes to upstream.  Original submit
message below.  Thanks

	Alex


Work around a minor bug found in the UART of the remote management card
used in many HP ia64 and parisc servers (aka the Diva UARTs).

The problem is that the UART does not reassert the THRE interrupt if it
has been previously cleared and the IIR THRI bit is re-enabled.  This
can produce a very annoying failure mode when used as a serial console,
allowing a boot/reboot to hang indefinitely until an RX interrupt kicks
it into working again (ie.  an unattended reboot could stall).

Paul Bame submitted a complete workaround for 2.4 kernels a few years
ago - http://lkml.org/lkml/2003/5/6/203.  The problem has not been as
prevalent on the 2.6 serial driver, thus the solution below is
simplified to only insert a backup timeout to kick the UART when it gets
into trouble.

This runs alongside the normal interrupt driven UART code and has a
longer period that the standard polling driver to reduce CPU overhead.
The detection test should be safe for all UARTs and the backup timer can
easily be extended to include other UARTs with similar disorders.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
---

 drivers/serial/8250.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 105 insertions(+), 33 deletions(-)

--- linux/drivers/serial/8250.c	2006-01-21 11:28:44.902787605 -0700
+++ linux/drivers/serial/8250.c	2006-01-21 11:29:14.315873182 -0700
@@ -1428,6 +1428,47 @@
 	mod_timer(&up->timer, jiffies + timeout);
 }
 
+static void serial8250_backup_timeout(unsigned long data)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)data;
+	unsigned int iir, ier = 0;
+	unsigned int timeout = up->port.timeout;
+
+	/*
+	 * Must disable interrupts or else we risk triggering an interrupt
+	 * and getting dead locked by the port.lock.
+	 */
+	if (is_real_interrupt(up->port.irq)) {
+		ier = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, 0);
+	}
+
+	iir = serial_in(up, UART_IIR);
+
+	/*
+	 * This should be a safe test for anyone who doesn't trust the
+	 * IIR bits on their UART, but it's specifically designed for
+	 * the "Diva" UART used on the management processor on many HP
+	 * ia64 and parisc boxes.
+	 */
+	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
+	    (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
+	    (serial_in(up, UART_LSR) & UART_LSR_THRE)) {
+		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
+		iir |= UART_IIR_THRI;
+	}
+
+	if (!(iir & UART_IIR_NO_INT))
+		serial8250_handle_port(up, NULL);
+
+	if (is_real_interrupt(up->port.irq))
+		serial_out(up, UART_IER, ier);
+
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+	mod_timer(&up->timer, jiffies + (timeout * 100));
+}
+
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
@@ -1496,6 +1537,36 @@
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static void wait_for_xmitr(struct uart_8250_port *up)
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
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout &&
+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+			udelay(1);
+	}
+}
+
 static int serial8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
@@ -1624,6 +1695,37 @@
 		up->bugs &= ~UART_BUG_TXEN;
 	}
 
+	if (is_real_interrupt(up->port.irq) && !timer_pending(&up->timer)) {
+		/*
+		 * Test for UARTs that do not reassert THRE when the
+		 * transmitter is idle and the interrupt has already
+		 * been cleared.  Real 16550s should always reassert
+		 * this interrupt whenever the transmitter is idle and
+		 * the interrupt is enabled.
+		 */
+		wait_for_xmitr(up);
+		serial_outp(up, UART_IER, UART_IER_THRI);
+		(void)serial_in(up, UART_IIR);
+		serial_outp(up, UART_IER, 0);
+		serial_outp(up, UART_IER, UART_IER_THRI);
+		iir = serial_in(up, UART_IIR);
+		serial_outp(up, UART_IER, 0);
+
+		/*
+		 * If the interrupt is not reasserted, setup a timer to
+		 * kick the UART on a regular basis.
+		 */
+		if (iir & UART_IIR_NO_INT) {
+			unsigned int timeout = up->port.timeout;
+
+			pr_debug("ttyS%d - using backup timer\n", port->line);
+			timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+			up->timer.function = serial8250_backup_timeout;
+			up->timer.data = (unsigned long)up;
+			mod_timer(&up->timer, jiffies + (timeout * 100));
+		}
+	}
+
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	/*
@@ -1696,9 +1798,9 @@
 	 */
 	(void) serial_in(up, UART_RX);
 
-	if (!is_real_interrupt(up->port.irq))
-		del_timer_sync(&up->timer);
-	else
+	del_timer_sync(&up->timer);
+	up->timer.function = serial8250_timeout;
+	if (is_real_interrupt(up->port.irq))
 		serial_unlink_irq_chain(up);
 }
 
@@ -2159,36 +2261,6 @@
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
-/*
- *	Wait for transmitter & holding register to empty
- */
-static inline void wait_for_xmitr(struct uart_8250_port *up)
-{
-	unsigned int status, tmout = 10000;
-
-	/* Wait up to 10ms for the character(s) to be sent. */
-	do {
-		status = serial_in(up, UART_LSR);
-
-		if (status & UART_LSR_BI)
-			up->lsr_break_flag = UART_LSR_BI;
-
-		if (--tmout == 0)
-			break;
-		udelay(1);
-	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
-
-	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-			udelay(1);
-	}
-}
-
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...


