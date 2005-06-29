Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVF2WRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVF2WRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbVF2WRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:17:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36111 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262682AbVF2WLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:11:52 -0400
Date: Wed, 29 Jun 2005 23:11:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH] Serial updates
Message-ID: <20050629221127.GA23770@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes have been submitted to Linus and Andrew, as seen
previously (and individually) on this mailing list.

 Documentation/serial/driver         |    4 -
 arch/parisc/configs/712_defconfig   |    2 
 arch/parisc/configs/a500_defconfig  |    2 
 arch/parisc/configs/b180_defconfig  |    2 
 arch/parisc/configs/c3000_defconfig |    2 
 arch/parisc/defconfig               |    2 
 drivers/serial/8250.c               |   33 ++++++-----
 drivers/serial/Kconfig              |    2 
 drivers/serial/au1x00_uart.c        |    3 -
 drivers/serial/ip22zilog.c          |   13 ++--
 drivers/serial/mpsc.c               |    3 -
 drivers/serial/pmac_zilog.c         |    4 -
 drivers/serial/pxa.c                |    3 -
 drivers/serial/serial_core.c        |   28 +++++++++
 drivers/serial/serial_txx9.c        |    3 -
 drivers/serial/sunsab.c             |    7 --
 drivers/serial/sunsu.c              |    3 -
 drivers/serial/sunzilog.c           |   13 ++--
 include/asm-alpha/serial.h          |   47 ----------------
 include/asm-arm26/serial.h          |   22 -------
 include/asm-i386/serial.h           |  102 ------------------------------------
 include/asm-m68k/serial.h           |   47 ----------------
 include/asm-mips/serial.h           |   84 -----------------------------
 include/asm-parisc/serial.h         |   16 -----
 include/asm-ppc/pc_serial.h         |   86 ------------------------------
 include/asm-sh/bigsur/serial.h      |    5 -
 include/asm-sh/ec3104/serial.h      |    4 -
 include/asm-sh/serial.h             |    6 --
 include/asm-sh64/serial.h           |    4 -
 include/asm-x86_64/serial.h         |  102 ------------------------------------
 30 files changed, 82 insertions(+), 572 deletions(-)

From: Russell King: Wed Jun 29 18:45:19 BST 2005
	
	[PATCH] Serial: Split 8250 port table (part 2)
	
	Remove legacy ISA serial ports for Accent, Boca, Fourport, Hub6 and MCA
	from the architecture specific serial.h include.
	
	The only ports which remain in asm-*/serial.h are the platform specific
	entries.  These should really be converted by platform maintainers to
	use a platform device, such as can be found in
	arch/arm/mach-footbridge/isa.c
	
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Wed Jun 29 18:41:51 BST 2005
	
	[PATCH] Serial: Disable OX950 transmitter for flow control
	
	Disable the transmitter whenever we want to prevent characters
	being transmitted by flow control.  However, if we run out of
	characters to send and want to only disable the TX interrupt,
	allow that scenario.
	
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Wed Jun 29 18:40:53 BST 2005
	
	[PATCH] Serial: Check status of CTS when using flow control
	
	Fix bugme #4712: read the CTS status and set hw_stopped if CTS
	is not active when opening the port and/or enabling CRTSCTS
	
	Thanks to Stefan Wolff for spotting this problem.
	
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Wed Jun 29 09:42:38 BST 2005
	
	[PATCH] Serial: Adjust serial locking
	
	This patch changes the way serial ports are locked when getting modem
	status.  This change is necessary because we will need to atomically
	read the modem status and take action depending on the CTS status.
	
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: Documentation/serial/driver
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/Documentation/serial/driver  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/Documentation/serial/driver  (mode:100644)
@@ -107,8 +107,8 @@
 	indicate that the signal is permanently active.  If RI is
 	not available, the signal should not be indicated as active.
 
-	Locking: none.
-	Interrupts: caller dependent.
+	Locking: port->lock taken.
+	Interrupts: locally disabled.
 	This call must not sleep
 
   stop_tx(port,tty_stop)
Index: arch/parisc/configs/712_defconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/arch/parisc/configs/712_defconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/arch/parisc/configs/712_defconfig  (mode:100644)
@@ -506,7 +506,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_NR_UARTS=17
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/a500_defconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/arch/parisc/configs/a500_defconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/arch/parisc/configs/a500_defconfig  (mode:100644)
@@ -662,7 +662,7 @@
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_CS=m
-CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_NR_UARTS=17
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/b180_defconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/arch/parisc/configs/b180_defconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/arch/parisc/configs/b180_defconfig  (mode:100644)
@@ -514,7 +514,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/c3000_defconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/arch/parisc/configs/c3000_defconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/arch/parisc/configs/c3000_defconfig  (mode:100644)
@@ -661,7 +661,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/defconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/arch/parisc/defconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/arch/parisc/defconfig  (mode:100644)
@@ -517,7 +517,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: drivers/serial/8250.c
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/8250.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/8250.c  (mode:100644)
@@ -105,7 +105,7 @@
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
-#define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
+#define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
@@ -993,21 +993,24 @@
 	up->port.irq = (irq > 0) ? irq : 0;
 }
 
+static inline void __stop_tx(struct uart_8250_port *p)
+{
+	if (p->ier & UART_IER_THRI) {
+		p->ier &= ~UART_IER_THRI;
+		serial_out(p, UART_IER, p->ier);
+	}
+}
+
 static void serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
-	if (up->ier & UART_IER_THRI) {
-		up->ier &= ~UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
-	}
+	__stop_tx(up);
 
 	/*
-	 * We only do this from uart_stop - if we run out of
-	 * characters to send, we don't want to prevent the
-	 * FIFO from emptying.
+	 * We really want to stop the transmitter from sending.
 	 */
-	if (up->port.type == PORT_16C950 && tty_stop) {
+	if (up->port.type == PORT_16C950) {
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
@@ -1031,10 +1034,11 @@
 				transmit_chars(up);
 		}
 	}
+
 	/*
-	 * We only do this from uart_start
+	 * Re-enable the transmitter if we disabled it.
 	 */
-	if (tty_start && up->port.type == PORT_16C950) {
+	if (up->port.type == PORT_16C950 && up->acr & UART_ACR_TXDIS) {
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
@@ -1155,7 +1159,7 @@
 		return;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial8250_stop_tx(&up->port, 0);
+		__stop_tx(up);
 		return;
 	}
 
@@ -1174,7 +1178,7 @@
 	DEBUG_INTR("THRE...");
 
 	if (uart_circ_empty(xmit))
-		serial8250_stop_tx(&up->port, 0);
+		__stop_tx(up);
 }
 
 static _INLINE_ void check_modem_status(struct uart_8250_port *up)
@@ -1376,13 +1380,10 @@
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
Index: drivers/serial/Kconfig
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/Kconfig  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/Kconfig  (mode:100644)
@@ -86,7 +86,7 @@
 	  namespace, say Y here.  If unsure, say N.
 
 config SERIAL_8250_NR_UARTS
-	int "Maximum number of non-legacy 8250/16550 serial ports"
+	int "Maximum number of 8250/16550 serial ports"
 	depends on SERIAL_8250
 	default "4"
 	help
Index: drivers/serial/au1x00_uart.c
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/au1x00_uart.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/au1x00_uart.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/ip22zilog.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/ip22zilog.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/mpsc.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/mpsc.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/pmac_zilog.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/pmac_zilog.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/pxa.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/pxa.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/serial_core.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/serial_core.c  (mode:100644)
@@ -182,6 +182,13 @@
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 		}
 
+		if (info->flags & UIF_CTS_FLOW) {
+			spin_lock_irq(&port->lock);
+			if (!(port->ops->get_mctrl(port) & TIOCM_CTS))
+				info->tty->hw_stopped = 1;
+			spin_unlock_irq(&port->lock);
+		}
+
 		info->flags |= UIF_INITIALIZED;
 
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -828,7 +835,10 @@
 	if ((!file || !tty_hung_up_p(file)) &&
 	    !(tty->flags & (1 << TTY_IO_ERROR))) {
 		result = port->mctrl;
+
+		spin_lock_irq(&port->lock);
 		result |= port->ops->get_mctrl(port);
+		spin_unlock_irq(&port->lock);
 	}
 	up(&state->sem);
 
@@ -1131,6 +1141,16 @@
 		spin_unlock_irqrestore(&state->port->lock, flags);
 	}
 
+	/* Handle turning on CRTSCTS */
+	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
+		spin_lock_irqsave(&state->port->lock, flags);
+		if (!(state->port->ops->get_mctrl(state->port) & TIOCM_CTS)) {
+			tty->hw_stopped = 1;
+			state->port->ops->stop_tx(state->port, 0);
+		}
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	}
+
 #if 0
 	/*
 	 * No need to wake up processes in open wait, since they
@@ -1369,6 +1389,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	struct uart_info *info = state->info;
 	struct uart_port *port = state->port;
+	unsigned int mctrl;
 
 	info->blocked_open++;
 	state->count--;
@@ -1416,7 +1437,10 @@
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
@@ -1618,7 +1642,9 @@
 
 	if(capable(CAP_SYS_ADMIN))
 	{
+		spin_lock_irq(&port->lock);
 		status = port->ops->get_mctrl(port);
+		spin_unlock_irq(&port->lock);
 
 		ret += sprintf(buf + ret, " tx:%d rx:%d",
 				port->icount.tx, port->icount.rx);
Index: drivers/serial/serial_txx9.c
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/serial_txx9.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/serial_txx9.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/sunsab.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/sunsab.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/sunsu.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/sunsu.c  (mode:100644)
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
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/drivers/serial/sunzilog.c  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/drivers/serial/sunzilog.c  (mode:100644)
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
Index: include/asm-alpha/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-alpha/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-alpha/serial.h  (mode:100644)
@@ -22,54 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#endif
-	
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
Index: include/asm-arm26/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-arm26/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-arm26/serial.h  (mode:100644)
@@ -30,34 +30,16 @@
 #if defined(CONFIG_ARCH_A5K)
      /* UART CLK        PORT  IRQ     FLAGS        */
 
-#define STD_SERIAL_PORT_DEFNS                                           \
+#define SERIAL_PORT_DFNS                                                \
         { 0, BASE_BAUD, 0x3F8, 10, STD_COM_FLAGS },     /* ttyS0 */     \
         { 0, BASE_BAUD, 0x2F8, 10, STD_COM_FLAGS },     /* ttyS1 */
 
 #else
 
-#define STD_SERIAL_PORT_DEFNS                                           \
+#define SERIAL_PORT_DFNS                                                \
         { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS0 */     \
         { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS1 */
 
 #endif
 
-#define EXTRA_SERIAL_PORT_DEFNS \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS2 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS3 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS4 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS5 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS6 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS7 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS8 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS9 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS10 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS11 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS12 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS13 */
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
-
 #endif
Index: include/asm-i386/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-i386/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-i386/serial.h  (mode:100644)
@@ -22,109 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-
-#define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#ifdef CONFIG_MCA
-#define MCA_SERIAL_PORT_DFNS			\
-	{ 0, BASE_BAUD, 0x3220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x3228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5228, 3, MCA_COM_FLAGS },
-#else
-#define MCA_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
-
Index: include/asm-m68k/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-m68k/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-m68k/serial.h  (mode:100644)
@@ -26,54 +26,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#endif
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS },	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
Index: include/asm-mips/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-mips/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-mips/serial.h  (mode:100644)
@@ -29,32 +29,6 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#define RS_TABLE_SIZE	64
-#else
-#define RS_TABLE_SIZE
-#endif
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
 #ifdef CONFIG_MACH_JAZZ
 #include <asm/jazz.h>
 
@@ -240,66 +214,10 @@
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },			/* ttyS14 (spare) */ \
-	{ 0, BASE_BAUD, 0x000, 0, 0 },			/* ttyS15 (spare) */ \
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else /* CONFIG_SERIAL_MANY_PORTS */
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif /* CONFIG_SERIAL_MANY_PORTS */
-
 #else /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
 #define STD_SERIAL_PORT_DEFNS
-#define EXTRA_SERIAL_PORT_DEFNS
 #endif /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
 
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
 #ifdef CONFIG_MOMENCO_JAGUAR_ATX
 /* Ordinary NS16552 duart with a 20MHz crystal.  */
 #define JAGUAR_ATX_UART_CLK	20000000
@@ -427,8 +345,6 @@
 	COBALT_SERIAL_PORT_DEFNS			\
 	DDB5477_SERIAL_PORT_DEFNS			\
 	EV96100_SERIAL_PORT_DEFNS			\
-	EXTRA_SERIAL_PORT_DEFNS				\
-	HUB6_SERIAL_PORT_DFNS				\
 	IP32_SERIAL_PORT_DEFNS                          \
 	ITE_SERIAL_PORT_DEFNS           		\
 	IVR_SERIAL_PORT_DEFNS           		\
Index: include/asm-parisc/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-parisc/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-parisc/serial.h  (mode:100644)
@@ -19,18 +19,4 @@
  * A500 w/ PCI serial cards: 5 + 4 * card ~= 17
  */
  
-#define STD_SERIAL_PORT_DEFNS			\
-	{ 0, },		/* ttyS0 */	\
-	{ 0, },		/* ttyS1 */	\
-	{ 0, },		/* ttyS2 */	\
-	{ 0, },		/* ttyS3 */	\
-	{ 0, },		/* ttyS4 */	\
-	{ 0, },		/* ttyS5 */	\
-	{ 0, },		/* ttyS6 */	\
-	{ 0, },		/* ttyS7 */	\
-	{ 0, },		/* ttyS8 */
-
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS
-
+#define SERIAL_PORT_DFNS
Index: include/asm-ppc/pc_serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-ppc/pc_serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-ppc/pc_serial.h  (mode:100644)
@@ -35,93 +35,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-	
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS
Index: include/asm-sh/bigsur/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-sh/bigsur/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-sh/bigsur/serial.h  (mode:100644)
@@ -14,13 +14,10 @@
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 
-#define STD_SERIAL_PORT_DEFNS                   \
+#define SERIAL_PORT_DFNS                   \
         /* UART CLK   PORT IRQ     FLAGS        */                      \
         { 0, BASE_BAUD, 0x3F8, HD64465_IRQ_UART, STD_COM_FLAGS } /* ttyS0 */ 
 
-
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
 
Index: include/asm-sh/ec3104/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-sh/ec3104/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-sh/ec3104/serial.h  (mode:100644)
@@ -10,13 +10,11 @@
  * it's got the keyboard controller behind it so we can't really use it
  * (without moving the keyboard driver to userspace, which doesn't sound
  * like a very good idea) */
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x11C00, EC3104_IRQBASE+7, STD_COM_FLAGS }, /* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x12000, EC3104_IRQBASE+8, STD_COM_FLAGS }, /* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x12400, EC3104_IRQBASE+9, STD_COM_FLAGS }, /* ttyS2 */
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
Index: include/asm-sh/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-sh/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-sh/serial.h  (mode:100644)
@@ -29,20 +29,18 @@
 #ifdef CONFIG_HD64465
 #include <asm/hd64465.h>
 
-#define STD_SERIAL_PORT_DEFNS                   \
+#define SERIAL_PORT_DFNS                   \
         /* UART CLK   PORT IRQ     FLAGS        */                      \
         { 0, BASE_BAUD, 0x3F8, HD64465_IRQ_UART, STD_COM_FLAGS }  /* ttyS0 */
 
 #else
 
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS }	/* ttyS1 */
 
 #endif
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 #endif
 #endif /* _ASM_SERIAL_H */
Index: include/asm-sh64/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-sh64/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-sh64/serial.h  (mode:100644)
@@ -20,13 +20,11 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS }	/* ttyS1 */
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
 
Index: include/asm-x86_64/serial.h
===================================================================
--- a174d93d568ba9735b13bb6ebb5f1a36c8f56308/include/asm-x86_64/serial.h  (mode:100644)
+++ dc1b05766bb5737a77113dd3071431c4f164523c/include/asm-x86_64/serial.h  (mode:100644)
@@ -22,109 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-
-#define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#ifdef CONFIG_MCA
-#define MCA_SERIAL_PORT_DFNS			\
-	{ 0, BASE_BAUD, 0x3220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x3228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5228, 3, MCA_COM_FLAGS },
-#else
-#define MCA_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
-
