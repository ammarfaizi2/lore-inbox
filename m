Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVKQQZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKQQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKQQZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:25:27 -0500
Received: from mailhub.hp.com ([192.151.27.10]:30179 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1750992AbVKQQZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:25:27 -0500
Subject: [PATCH] backup timer for UARTs that lose interrupts (take 3)
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 17 Nov 2005 09:26:52 -0700
Message-Id: <1132244813.4143.11.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   One more try.  Andrew was kind enough to find a bone head mistake on
my part (creating a forward declaration for a function that is only
defined when 8250 serial console support is enabled).  That's fixed as
requested in the version below.  Updated patch versus 2.6.15-rc1-mm1.
Original patch description:

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
disorders.

Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
---

diff -r 6ed2da14626d drivers/serial/8250.c
--- a/drivers/serial/8250.c	Thu Nov 17 10:45:14 2005
+++ b/drivers/serial/8250.c	Thu Nov 17 09:10:39 2005
@@ -1425,6 +1425,50 @@
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
@@ -1491,6 +1535,36 @@
 		up->lcr &= ~UART_LCR_SBC;
 	serial_out(up, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
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
 }
 
 #ifdef CONFIG_KGDB
@@ -1631,6 +1705,37 @@
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
@@ -1703,9 +1808,9 @@
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
 
@@ -2212,36 +2317,6 @@
 
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



