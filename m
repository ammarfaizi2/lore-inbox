Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUH3XWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUH3XWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUH3XWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:22:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55049 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265230AbUH3XVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:21:48 -0400
Date: Tue, 31 Aug 2004 00:21:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Serial updates
Message-ID: <20040831002138.H22480@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BK changelog at the end.  Essentially, this sorts out a couple of things:

1. Try to make the serial driver more "capability"-based rather than
   "port type"-based.  This means that we codify some of the rules
   which otherwise appear in the table - for example, if we have a
   FIFO, we always flush it, but only ever enable it if we have a
   FIFO depth > 1.

2. Some serial ports signal transmit interrupts when their FIFOs are
   not completely empty.  Use separate parameter to indicate how
   many bytes we should transfer on each transmit IRQ.

Overall, this means that "struct serial_uart_config" in
include/linux/serial.h is no longer used by the standard kernel serial
driver.  It could be removed if it weren't used by "clone" drivers...
Note that some cloned drivers define the table, but only use one entry
_and_ one string from it.  Using a single string of course is far more
space efficient. 8)

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2004-08-29 23:26:37 +01:00
+++ b/drivers/serial/8250.c	2004-08-29 23:26:37 +01:00
@@ -130,6 +130,7 @@
 	struct timer_list	timer;		/* "no irq" timer */
 	struct list_head	list;		/* ports on this IRQ */
 	unsigned int		capabilities;	/* port capabilities */
+	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned short		rev;
 	unsigned char		acr;
 	unsigned char		ier;
@@ -156,23 +157,23 @@
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
-static const struct serial_uart_config uart_config[PORT_MAX_8250+1] = {
-	{ "unknown",	1,	0 },
-	{ "8250",	1,	0 },
-	{ "16450",	1,	0 },
-	{ "16550",	1,	0 },
-	{ "16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO },
-	{ "Cirrus",	1, 	0 },
-	{ "ST16650",	1,	UART_CLEAR_FIFO | UART_STARTECH },
-	{ "ST16650V2",	32,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
-	{ "TI16750",	64,	UART_CLEAR_FIFO | UART_USE_FIFO },
-	{ "Startech",	1,	0 },
-	{ "16C950/954",	128,	UART_CLEAR_FIFO | UART_USE_FIFO },
-	{ "ST16654",	64,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
-	{ "XR16850",	128,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH },
-	{ "RSA",	2048,	UART_CLEAR_FIFO | UART_USE_FIFO },
-	{ "NS16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_NATSEMI },
-	{ "XScale",	32,	UART_CLEAR_FIFO | UART_USE_FIFO  },
+static const struct serial8250_config uart_config[PORT_MAX_8250+1] = {
+	{ "unknown",	1,	1,	0 },
+	{ "8250",	1,	1,	0 },
+	{ "16450",	1,	1,	0 },
+	{ "16550",	1,	1,	0 },
+	{ "16550A",	16,	16,	UART_CAP_FIFO },
+	{ "Cirrus",	1, 	1,	0 },
+	{ "ST16650",	1,	1,	UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_EFR },
+	{ "ST16650V2",	32,	16,	UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_EFR },
+	{ "TI16750",	64,	64,	UART_CAP_FIFO | UART_CAP_SLEEP },
+	{ "Startech",	1,	1,	0 },
+	{ "16C950/954",	128,	128,	UART_CAP_FIFO },
+	{ "ST16654",	64,	32,	UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_EFR },
+	{ "XR16850",	128,	128,	UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_EFR },
+	{ "RSA",	2048,	2048,	UART_CAP_FIFO },
+	{ "NS16550A",	16,	16,	UART_CAP_FIFO | UART_NATSEMI },
+	{ "XScale",	32,	32,	UART_CAP_FIFO },
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -243,6 +244,41 @@
 	return value;
 }
 
+/*
+ * FIFO support.
+ */
+static inline void serial8250_clear_fifos(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_FIFO) {
+		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO |
+			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		serial_outp(p, UART_FCR, 0);
+	}
+}
+
+/*
+ * IER sleep support.  UARTs which have EFRs need the "extended
+ * capability" bit enabled.  Note that on XR16C850s, we need to
+ * reset LCR to write to IER.
+ */
+static inline void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
+{
+	if (p->capabilities & UART_CAP_SLEEP) {
+		if (p->capabilities & UART_CAP_EFR) {
+			serial_outp(p, UART_LCR, 0xBF);
+			serial_outp(p, UART_EFR, UART_EFR_ECB);
+			serial_outp(p, UART_LCR, 0);
+		}
+		serial_outp(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
+		if (p->capabilities & UART_CAP_EFR) {
+			serial_outp(p, UART_LCR, 0xBF);
+			serial_outp(p, UART_EFR, 0);
+			serial_outp(p, UART_LCR, 0);
+		}
+	}
+}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -697,8 +733,9 @@
 #endif
 	serial_outp(up, UART_LCR, save_lcr);
 
-	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;
+	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
 
 	if (up->port.type == PORT_UNKNOWN)
 		goto out;
@@ -711,10 +748,7 @@
 		serial_outp(up, UART_RSA_FRR, 0);
 #endif
 	serial_outp(up, UART_MCR, save_mcr);
-	serial_outp(up, UART_FCR, (UART_FCR_ENABLE_FIFO |
-				     UART_FCR_CLEAR_RCVR |
-				     UART_FCR_CLEAR_XMIT));
-	serial_outp(up, UART_FCR, 0);
+	serial8250_clear_fifos(up);
 	(void)serial_in(up, UART_RX);
 	serial_outp(up, UART_IER, 0);
 
@@ -923,7 +957,7 @@
 		return;
 	}
 
-	count = up->port.fifosize;
+	count = up->tx_loadsz;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -1227,12 +1261,7 @@
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reeanbled in set_termios())
 	 */
-	if (up->capabilities & UART_CLEAR_FIFO) {
-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
-				UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
-		serial_outp(up, UART_FCR, 0);
-	}
+	serial8250_clear_fifos(up);
 
 	/*
 	 * Clear the interrupt registers.
@@ -1254,6 +1283,23 @@
 	}
 
 	/*
+	 * For a XR16C850, we need to set the trigger levels
+	 */
+	if (up->port.type == PORT_16850) {
+		unsigned char fctr;
+
+		serial_outp(up, UART_LCR, 0xbf);
+
+		fctr = serial_inp(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
+		serial_outp(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_RX);
+		serial_outp(up, UART_TRG, UART_TRG_96);
+		serial_outp(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_TX);
+		serial_outp(up, UART_TRG, UART_TRG_96);
+
+		serial_outp(up, UART_LCR, 0);
+	}
+
+	/*
 	 * If the "interrupt" for this port doesn't correspond with any
 	 * hardware interrupt, we use a timer-based system.  The original
 	 * driver used to do this with IRQ0.
@@ -1345,10 +1391,7 @@
 	 * Disable break condition and FIFOs
 	 */
 	serial_out(up, UART_LCR, serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
-				  UART_FCR_CLEAR_RCVR |
-				  UART_FCR_CLEAR_XMIT);
-	serial_outp(up, UART_FCR, 0);
+	serial8250_clear_fifos(up);
 
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
@@ -1440,7 +1483,7 @@
 	    up->rev == 0x5201)
 		quot ++;
 
-	if (up->capabilities & UART_USE_FIFO) {
+	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
 		if (baud < 2400)
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -1514,7 +1557,7 @@
 
 	serial_out(up, UART_IER, up->ier);
 
-	if (up->capabilities & UART_STARTECH) {
+	if (up->capabilities & UART_CAP_EFR) {
 		serial_outp(up, UART_LCR, 0xBF);
 		serial_outp(up, UART_EFR,
 			    termios->c_cflag & CRTSCTS ? UART_EFR_CTS :0);
@@ -1554,71 +1597,12 @@
 serial8250_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
-	if (state) {
-		/* sleep */
-		if (up->capabilities & UART_STARTECH) {
-			/* Arrange to enter sleep mode */
-			serial_outp(up, UART_LCR, 0xBF);
-			serial_outp(up, UART_EFR, UART_EFR_ECB);
-			serial_outp(up, UART_LCR, 0);
-			serial_outp(up, UART_IER, UART_IERX_SLEEP);
-			serial_outp(up, UART_LCR, 0xBF);
-			serial_outp(up, UART_EFR, 0);
-			serial_outp(up, UART_LCR, 0);
-		}
-		if (up->port.type == PORT_16750) {
-			/* Arrange to enter sleep mode */
-			serial_outp(up, UART_IER, UART_IERX_SLEEP);
-		}
-
-		if (up->pm)
-			up->pm(port, state, oldstate);
-	} else {
-		/* wake */
-		if (up->capabilities & UART_STARTECH) {
-			/* Wake up UART */
-			serial_outp(up, UART_LCR, 0xBF);
-			serial_outp(up, UART_EFR, UART_EFR_ECB);
-			/*
-			 * Turn off LCR == 0xBF so we actually set the IER
-			 * register on the XR16C850
-			 */
-			serial_outp(up, UART_LCR, 0);
-			serial_outp(up, UART_IER, 0);
-			/*
-			 * Now reset LCR so we can turn off the ECB bit
-			 */
-			serial_outp(up, UART_LCR, 0xBF);
-			serial_outp(up, UART_EFR, 0);
-			/*
-			 * For a XR16C850, we need to set the trigger levels
-			 */
-			if (up->port.type == PORT_16850) {
-				unsigned char fctr;
+	struct uart_8250_port *p = (struct uart_8250_port *)port;
 
-				fctr = serial_inp(up, UART_FCTR) &
-					 ~(UART_FCTR_RX | UART_FCTR_TX);
-				serial_outp(up, UART_FCTR, fctr |
-						UART_FCTR_TRGD |
-						UART_FCTR_RX);
-				serial_outp(up, UART_TRG, UART_TRG_96);
-				serial_outp(up, UART_FCTR, fctr |
-						UART_FCTR_TRGD |
-						UART_FCTR_TX);
-				serial_outp(up, UART_TRG, UART_TRG_96);
-			}
-			serial_outp(up, UART_LCR, 0);
-		}
+	serial8250_set_sleep(p, state != 0);
 
-		if (up->port.type == PORT_16750) {
-			/* Wake up UART */
-			serial_outp(up, UART_IER, 0);
-		}
-
-		if (up->pm)
-			up->pm(port, state, oldstate);
-	}
+	if (p->pm)
+		p->pm(port, state, oldstate);
 }
 
 /*
diff -Nru a/drivers/serial/8250.h b/drivers/serial/8250.h
--- a/drivers/serial/8250.h	2004-08-29 23:26:37 +01:00
+++ b/drivers/serial/8250.h	2004-08-29 23:26:37 +01:00
@@ -33,6 +33,20 @@
 	unsigned short iomem_reg_shift;
 };
 
+/*
+ * This replaces serial_uart_config in include/linux/serial.h
+ */
+struct serial8250_config {
+	const char	*name;
+	unsigned int	fifo_size;
+	unsigned int	tx_loadsz;
+	unsigned int	flags;
+};
+
+#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
+#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
+#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
+
 #undef SERIAL_DEBUG_PCI
 
 #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/29 13:07:31+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: Rename UART_STARTECH to UART_CAP_EFR
#   
#   UART_STARTECH is really telling us that the UART has an EFR register,
#   so call this flag UART_CAP_EFR.
# 
# drivers/serial/8250.h
#   2004/08/29 13:05:20+01:00 rmk@flint.arm.linux.org.uk +1 -0
#   Rename UART_STARTECH to UART_CAP_EFR, since that's what it's really
#   telling us - that the UART has an EFR register.
# 
# drivers/serial/8250.c
#   2004/08/29 13:05:19+01:00 rmk@flint.arm.linux.org.uk +10 -8
#   Rename UART_STARTECH to UART_CAP_EFR, since that's what it's really
#   telling us - that the UART has an EFR register.
# 
# ChangeSet
#   2004/08/29 12:59:58+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: add UART_CAP_SLEEP capability.
# 
# drivers/serial/8250.h
#   2004/08/29 12:57:48+01:00 rmk@flint.arm.linux.org.uk +1 -0
#   Add UART_CAP_SLEEP definition.
# 
# drivers/serial/8250.c
#   2004/08/29 12:57:48+01:00 rmk@flint.arm.linux.org.uk +17 -17
#   Add UART_CAP_SLEEP - this indicates which UART types have IER sleep
#   capability.  We generalise the code in serial8250_set_sleep() since
#   Startech is a superset of the TI16750 sleep code.
# 
# ChangeSet
#   2004/08/29 12:52:25+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: serial8250_set_sleep
#   
#   Add container function for UART sleep code.  Currently only Startech
#   and TI16750 uses this.
# 
# drivers/serial/8250.c
#   2004/08/29 12:49:56+01:00 rmk@flint.arm.linux.org.uk +24 -46
#   Add serial8250_set_sleep - this contains the code to place UARTs into
#   sleep mode.
# 
# ChangeSet
#   2004/08/29 11:52:58+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: combine UART_CLEAR_FIFO/UART_USE_FIFO into one flag.
#   
#   Combine UART_CLEAR_FIFO and UART_USE_FIFO into one capability -
#   UART_CAP_FIFO.  There is only one UART with an unused FIFO - ST16650.
#   Since we check the fifo size before enabling, we maintain the
#   existing behaviour.
# 
# drivers/serial/8250.h
#   2004/08/29 11:50:41+01:00 rmk@flint.arm.linux.org.uk +2 -0
#   Add UART_CAP_FIFO flag.
# 
# drivers/serial/8250.c
#   2004/08/29 11:50:41+01:00 rmk@flint.arm.linux.org.uk +12 -12
#   Combine UART_CLEAR_FIFO and UART_USE_FIFO into one capability -
#   UART_CAP_FIFO.  There is only one UART with an unused FIFO, ST16650.
#   Since we check the fifo size before enabling, we maintain the
#   existing behaviour.
# 
# ChangeSet
#   2004/08/29 00:48:16+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: tell transmit path the data transfer size.
#   
#   Some UARTs give us a transmit interrupt when the TX FIFO is less
#   than half empty.  This means we should not transfer a FIFO-full
#   of data to the device.  Introduce "tx_loadsz" to indicate the
#   size of this transfer.
# 
# drivers/serial/8250.h
#   2004/08/29 00:46:09+01:00 rmk@flint.arm.linux.org.uk +1 -0
#   Add tx_loadsz element to serial8250_config
# 
# drivers/serial/8250.c
#   2004/08/29 00:46:08+01:00 rmk@flint.arm.linux.org.uk +19 -17
#   Add "tx_loadsz".  This gives the size of the data transfer when we
#   receive a transmit interrupt.  Add transmit load size data to the
#   uart_config table.
# 
# ChangeSet
#   2004/08/29 00:29:43+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: Add serial8250_config structure definition.
#   
#   This structure replaces serial_uart_config to allow the 8250 driver
#   to extend it without breaking all the other users.
# 
# drivers/serial/8250.h
#   2004/08/29 00:27:37+01:00 rmk@flint.arm.linux.org.uk +9 -0
#   Add serial8250_config structure definition.
# 
# drivers/serial/8250.c
#   2004/08/29 00:27:36+01:00 rmk@flint.arm.linux.org.uk +2 -2
#   Rename serial_uart_config structure to serial8250_config, and
#   dfl_xmit_fifo_size to fifo_size.
# 
# ChangeSet
#   2004/08/29 00:06:41+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] 8250: We can only use the FIFO if fifosize > 1.
# 
# drivers/serial/8250.c
#   2004/08/29 00:03:54+01:00 rmk@flint.arm.linux.org.uk +1 -1
#   We can only use the FIFO if fifosize > 1.
# 
# ChangeSet
#   2004/08/28 23:48:25+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] Move XR16C850 Tx/Rx trigger level setup to startup code
# 
# drivers/serial/8250.c
#   2004/08/28 23:46:09+01:00 rmk@flint.arm.linux.org.uk +17 -17
#   Move TX/RX trigger level settings for XR16C850 into startup code
#   rather than power management code.
# 
# ChangeSet
#   2004/08/28 23:34:57+01:00 rmk@flint.arm.linux.org.uk 
#   [SERIAL] Factor out "clear fifo" functionality.
#   
#   Move "clear fifo" into separate function dependent on
#   UART_CLEAR_FIFO capability.  We take note of the comment about
#   Lucent Venus and always use the two-stage enable-then-clear as
#   we do on startup.
# 
# drivers/serial/8250.c
#   2004/08/28 23:32:32+01:00 rmk@flint.arm.linux.org.uk +16 -14
#   Move "clear fifo" into separate function dependent on
#   UART_CLEAR_FIFO capability.  We take note of the comment about
#   Lucent Venus and always use the two-stage enable-then-clear as
#   we do on startup.
# 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
