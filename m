Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVFZWQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVFZWQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVFZWQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:16:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7945 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261369AbVFZWPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:15:05 -0400
Date: Sun, 26 Jun 2005 23:15:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT:PATCH] 1/3: Adjust serial locking 
Message-ID: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way serial ports are locked when getting modem
status.  This change is necessary because we will need to atomically
read the modem status and take action depending on the CTS status.

Any new drivers will need to be carefully reviewed for compliance
with this locking change.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: Documentation/serial/driver
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/Documentation/serial/driver  (mode:100644)
+++ uncommitted/Documentation/serial/driver  (mode:100644)
@@ -107,8 +107,8 @@
 	indicate that the signal is permanently active.  If RI is
 	not available, the signal should not be indicated as active.
 
-	Locking: none.
-	Interrupts: caller dependent.
+	Locking: port->lock taken.
+	Interrupts: locally disabled.
 	This call must not sleep
 
   stop_tx(port,tty_stop)
Index: drivers/serial/8250.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/8250.c  (mode:100644)
+++ uncommitted/drivers/serial/8250.c  (mode:100644)
@@ -1390,13 +1390,10 @@
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
-	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	status = serial_in(up, UART_MSR);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	ret = 0;
 	if (status & UART_MSR_DCD)
Index: drivers/serial/au1x00_uart.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/au1x00_uart.c  (mode:100644)
+++ uncommitted/drivers/serial/au1x00_uart.c  (mode:100644)
@@ -556,13 +556,10 @@
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
-	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	status = serial_in(up, UART_MSR);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	ret = 0;
 	if (status & UART_MSR_DCD)
Index: drivers/serial/ip22zilog.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/ip22zilog.c  (mode:100644)
+++ uncommitted/drivers/serial/ip22zilog.c  (mode:100644)
@@ -518,27 +518,28 @@
 static __inline__ unsigned char ip22zilog_read_channel_status(struct uart_port *port)
 {
 	struct zilog_channel *channel;
-	unsigned long flags;
 	unsigned char status;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 	status = readb(&channel->control);
 	ZSDELAY();
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	return status;
 }
 
 /* The port lock is not held.  */
 static unsigned int ip22zilog_tx_empty(struct uart_port *port)
 {
+	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	status = ip22zilog_read_channel_status(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	if (status & Tx_BUF_EMP)
 		ret = TIOCSER_TEMT;
 	else
@@ -547,7 +548,7 @@
 	return ret;
 }
 
-/* The port lock is not held.  */
+/* The port lock is held and interrupts are disabled.  */
 static unsigned int ip22zilog_get_mctrl(struct uart_port *port)
 {
 	unsigned char status;
Index: drivers/serial/mpsc.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/mpsc.c  (mode:100644)
+++ uncommitted/drivers/serial/mpsc.c  (mode:100644)
@@ -1058,12 +1058,9 @@
 {
 	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
 	u32 mflags, status;
-	ulong iflags;
 
-	spin_lock_irqsave(&pi->port.lock, iflags);
 	status = (pi->mirror_regs) ? pi->MPSC_CHR_10_m :
 		readl(pi->mpsc_base + MPSC_CHR_10);
-	spin_unlock_irqrestore(&pi->port.lock, iflags);
 
 	mflags = 0;
 	if (status & 0x1)
Index: drivers/serial/pmac_zilog.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/pmac_zilog.c  (mode:100644)
+++ uncommitted/drivers/serial/pmac_zilog.c  (mode:100644)
@@ -604,7 +604,7 @@
 /* 
  * Get Modem Control bits (only the input ones, the core will
  * or that with a cached value of the control ones)
- * The port lock is not held.
+ * The port lock is held and interrupts are disabled.
  */
 static unsigned int pmz_get_mctrl(struct uart_port *port)
 {
@@ -615,7 +615,7 @@
 	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
 		return 0;
 
-	status = pmz_peek_status(to_pmz(port));
+	status = read_zsreg(uap, R0);
 
 	ret = 0;
 	if (status & DCD)
Index: drivers/serial/pxa.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/pxa.c  (mode:100644)
+++ uncommitted/drivers/serial/pxa.c  (mode:100644)
@@ -274,14 +274,11 @@
 static unsigned int serial_pxa_get_mctrl(struct uart_port *port)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
-	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
 return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
-	spin_lock_irqsave(&up->port.lock, flags);
 	status = serial_in(up, UART_MSR);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	ret = 0;
 	if (status & UART_MSR_DCD)
Index: drivers/serial/serial_core.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/serial_core.c  (mode:100644)
+++ uncommitted/drivers/serial/serial_core.c  (mode:100644)
@@ -828,7 +828,10 @@
 	if ((!file || !tty_hung_up_p(file)) &&
 	    !(tty->flags & (1 << TTY_IO_ERROR))) {
 		result = port->mctrl;
+
+		spin_lock_irq(&port->lock);
 		result |= port->ops->get_mctrl(port);
+		spin_unlock_irq(&port->lock);
 	}
 	up(&state->sem);
 
@@ -1369,6 +1372,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	struct uart_info *info = state->info;
 	struct uart_port *port = state->port;
+	unsigned int mctrl;
 
 	info->blocked_open++;
 	state->count--;
@@ -1416,7 +1420,10 @@
 		 * and wait for the carrier to indicate that the
 		 * modem is ready for us.
 		 */
-		if (port->ops->get_mctrl(port) & TIOCM_CAR)
+		spin_lock_irq(&port->lock);
+		mctrl = port->ops->get_mctrl(port);
+		spin_unlock_irq(&port->lock);
+		if (mctrl & TIOCM_CAR)
 			break;
 
 		up(&state->sem);
@@ -1618,7 +1625,9 @@
 
 	if(capable(CAP_SYS_ADMIN))
 	{
+		spin_lock_irq(&port->lock);
 		status = port->ops->get_mctrl(port);
+		spin_unlock_irq(&port->lock);
 
 		ret += sprintf(buf + ret, " tx:%d rx:%d",
 				port->icount.tx, port->icount.rx);
Index: drivers/serial/serial_txx9.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/serial_txx9.c  (mode:100644)
+++ uncommitted/drivers/serial/serial_txx9.c  (mode:100644)
@@ -442,13 +442,10 @@
 static unsigned int serial_txx9_get_mctrl(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	ret =  ((sio_in(up, TXX9_SIFLCR) & TXX9_SIFLCR_RTSSC) ? 0 : TIOCM_RTS)
 		| ((sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS) ? 0 : TIOCM_CTS);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	return ret;
 }
Index: drivers/serial/sunsab.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/sunsab.c  (mode:100644)
+++ uncommitted/drivers/serial/sunsab.c  (mode:100644)
@@ -426,18 +426,15 @@
 		sunsab_tx_idle(up);
 }
 
-/* port->lock is not held.  */
+/* port->lock is held by caller and interrupts are disabled.  */
 static unsigned int sunsab_get_mctrl(struct uart_port *port)
 {
 	struct uart_sunsab_port *up = (struct uart_sunsab_port *) port;
-	unsigned long flags;
 	unsigned char val;
 	unsigned int result;
 
 	result = 0;
 
-	spin_lock_irqsave(&up->port.lock, flags);
-
 	val = readb(&up->regs->r.pvr);
 	result |= (val & up->pvr_dsr_bit) ? 0 : TIOCM_DSR;
 
@@ -447,8 +444,6 @@
 	val = readb(&up->regs->r.star);
 	result |= (val & SAB82532_STAR_CTS) ? TIOCM_CTS : 0;
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
-
 	return result;
 }
 
Index: drivers/serial/sunsu.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/sunsu.c  (mode:100644)
+++ uncommitted/drivers/serial/sunsu.c  (mode:100644)
@@ -572,13 +572,10 @@
 static unsigned int sunsu_get_mctrl(struct uart_port *port)
 {
 	struct uart_sunsu_port *up = (struct uart_sunsu_port *) port;
-	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	status = serial_in(up, UART_MSR);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	ret = 0;
 	if (status & UART_MSR_DCD)
Index: drivers/serial/sunzilog.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/sunzilog.c  (mode:100644)
+++ uncommitted/drivers/serial/sunzilog.c  (mode:100644)
@@ -610,27 +610,28 @@
 static __inline__ unsigned char sunzilog_read_channel_status(struct uart_port *port)
 {
 	struct zilog_channel __iomem *channel;
-	unsigned long flags;
 	unsigned char status;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 	status = sbus_readb(&channel->control);
 	ZSDELAY();
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	return status;
 }
 
 /* The port lock is not held.  */
 static unsigned int sunzilog_tx_empty(struct uart_port *port)
 {
+	unsigned long flags;
 	unsigned char status;
 	unsigned int ret;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	status = sunzilog_read_channel_status(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	if (status & Tx_BUF_EMP)
 		ret = TIOCSER_TEMT;
 	else
@@ -639,7 +640,7 @@
 	return ret;
 }
 
-/* The port lock is not held.  */
+/* The port lock is held and interrupts are disabled.  */
 static unsigned int sunzilog_get_mctrl(struct uart_port *port)
 {
 	unsigned char status;
