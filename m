Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVKHU0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVKHU0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKHU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:26:34 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:58556 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932412AbVKHU0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:26:34 -0500
Subject: [PATCH] backup timer for UARTs that lose interrupts
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Tue, 08 Nov 2005 13:27:57 -0700
Message-Id: <1131481677.8541.24.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

   The patch below works around a minor bug found in the UART of the
remote management card used in many HP ia64 and parisc servers (aka the
Diva UARTs).  The problem is that the UART does not reassert the THRE
interrupt if it has been previously cleared and the IIR THRI bit is
re-enabled.  This can produce a very annoying failure mode when used as
a serial console, allowing a boot/reboot to hang indefinitely until an
RX interrupt kicks it into working again (ie. an unattended reboot could
stall).  Paul Bame submitted a complete workaround for 2.4 kernels a few
years ago - http://lkml.org/lkml/2003/5/6/203.  The problem has not been
as prevalent on the 2.6 serial driver, thus the solution below is
simplified to only insert a backup timeout to kick the UART when it gets
into trouble.  This runs alongside the normal interrupt driven UART code
and has a longer period that the standard polling driver to reduce CPU
overhead.  The detection test should be safe for all UARTs and the
backup timer can easily be extended to include other UARTs with similar
disorders.  It would also be trivial to pass a flag from 8250_pci
specifically for these devices if for any reason the detection method is
too risky.  Please include.  Patch versus 2.6.14-mm1.  Thanks,

	Alex

-- 
Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r 40c675e519db drivers/serial/8250.c
--- a/drivers/serial/8250.c	Mon Nov  7 02:45:51 2005
+++ b/drivers/serial/8250.c	Tue Nov  8 10:49:27 2005
@@ -1359,6 +1359,50 @@
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
+	if ((iir & UART_IIR_NO_INT)  && (up->ier & UART_IER_THRI)  &&
+	    (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
+	    (serial_in(up, UART_LSR) & UART_LSR_THRE)) {
+		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
+		iir |= UART_IIR_THRI;
+	}
+
+	if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&up->port.lock);
+		serial8250_handle_port(up, NULL);
+		spin_unlock(&up->port.lock);
+	}
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
@@ -1431,6 +1475,8 @@
 int kgdb_irq = -1;
 EXPORT_SYMBOL(kgdb_irq);
 #endif
+
+static inline void wait_for_xmitr(struct uart_8250_port *up);
 
 static int serial8250_startup(struct uart_port *port)
 {
@@ -1520,6 +1566,7 @@
 
 		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
 
+		up->timer.function = serial8250_timeout;
 		up->timer.data = (unsigned long)up;
 		mod_timer(&up->timer, jiffies + timeout);
 	} else {
@@ -1565,6 +1612,36 @@
 		up->bugs &= ~UART_BUG_TXEN;
 	}
 
+	/*
+	 * Test for UARTs that do not reassert THRE when the
+	 * transmitter is idle and the interrupt has already
+	 * been cleared.  Real 16550s should always reassert
+	 * this interrupt whenever the transmitter is idle and
+	 * the interrupt is enabled.
+	 */
+	wait_for_xmitr(up);
+	serial_outp(up, UART_IER, UART_IER_THRI);
+	(void)serial_in(up, UART_IIR);
+	serial_outp(up, UART_IER, 0);
+	serial_outp(up, UART_IER, UART_IER_THRI);
+	iir = serial_in(up, UART_IIR);
+	serial_outp(up, UART_IER, 0);
+
+	/*
+	 * If the interrupt is not reasserted, setup a timer to
+	 * kick the UART on a regular basis.
+	 */
+	if (iir & UART_IIR_NO_INT && is_real_interrupt(up->port.irq) &&
+	    !timer_pending(&up->timer)) {
+		unsigned int timeout = up->port.timeout;
+
+		pr_debug("ttyS%d - using backup timer\n", port->line);
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+		up->timer.function = serial8250_backup_timeout;
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + (timeout * 100));
+	}
+
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	/*
@@ -1637,9 +1714,8 @@
 	 */
 	(void) serial_in(up, UART_RX);
 
-	if (!is_real_interrupt(up->port.irq))
-		del_timer_sync(&up->timer);
-	else
+	del_timer_sync(&up->timer);
+	if (is_real_interrupt(up->port.irq))
 		serial_unlink_irq_chain(up);
 }
 



