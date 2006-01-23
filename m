Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWAWGFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWAWGFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWAWGFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:05:15 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:28453 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S964830AbWAWGFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:05:13 -0500
Date: Mon, 23 Jan 2006 15:05:02 +0900 (JST)
Message-Id: <20060123.150502.89066381.nemoto@toshiba-tops.co.jp>
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060122230209.GB5511@flint.arm.linux.org.uk>
References: <20060122080015.GA10398@flint.arm.linux.org.uk>
	<20060122003307.738931b7.akpm@osdl.org>
	<20060122230209.GB5511@flint.arm.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 22 Jan 2006 23:02:09 +0000, Russell King <rmk+lkml@arm.linux.org.uk> said:
>> > > Are you sure about this part?  Shifting something left by sizeof(something)
>> > > seems very strange.  It'll give different results on 64-bit machines for
>> > > the same hardware.  Are you sure it wasn't supposed to be an addition?
>> > 
>> > There is a definition for that constant - it's called HIGH_BITS_OFFSET.
>> 
>> There are two definitions, actually.  drivers/serial/serial_core.c and
>> drivers/serial/8250.h.
>> 
>> > No need to try to buggily recreate it.
>> 
>> Where's the bug in the proposed code?

rmk> There isn't, but because it's wider than 80 columns, it got mis-read.
rmk> As demonstrated, the 80 column rule _still_ matters for readability.

Thank you for all comments.  Then I updated my patch using the
HIGH_BITS_OFFSET.

---
This patch updates serial_txx9 driver.  (diff from 2.6.16-rc1)

 * More strict check in verify_port.  Cleanup.
 * Do not insert a char caused previous overrun.
 * Fix some spin_locks.
 * Do not call uart_add_one_port for absent ports.

Also, this patch removes a BROKEN tag from Kconfig.  This driver has
been marked as BROKEN by removal of uart_register_port, but it has
been solved already on Sep 2005.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9fd1925..27c4676 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -858,7 +858,7 @@ config SERIAL_M32R_PLDSIO
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends HAS_TXX9_SERIAL && BROKEN
+	depends HAS_TXX9_SERIAL
 	select SERIAL_CORE
 	default y
 
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index ee98a86..141173e 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -33,6 +33,10 @@
  *	1.02	Cleanup. (import 8250.c changes)
  *	1.03	Fix low-latency mode. (import 8250.c changes)
  *	1.04	Remove usage of deprecated functions, cleanup.
+ *	1.05	More strict check in verify_port.  Cleanup.
+ *	1.06	Do not insert a char caused previous overrun.
+ *		Fix some spin_locks.
+ *		Do not call uart_add_one_port for absent ports.
  */
 #include <linux/config.h>
 
@@ -57,7 +61,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char *serial_version = "1.04";
+static char *serial_version = "1.06";
 static char *serial_name = "TX39/49 Serial driver";
 
 #define PASS_LIMIT	256
@@ -94,6 +98,8 @@ static char *serial_name = "TX39/49 Seri
 #define UART_NR  4
 #endif
 
+#define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
+
 struct uart_txx9_port {
 	struct uart_port	port;
 
@@ -210,7 +216,7 @@ static inline unsigned int sio_in(struct
 {
 	switch (up->port.iotype) {
 	default:
-		return *(volatile u32 *)(up->port.membase + offset);
+		return __raw_readl(up->port.membase + offset);
 	case UPIO_PORT:
 		return inl(up->port.iobase + offset);
 	}
@@ -221,7 +227,7 @@ sio_out(struct uart_txx9_port *up, int o
 {
 	switch (up->port.iotype) {
 	default:
-		*(volatile u32 *)(up->port.membase + offset) = value;
+		__raw_writel(value, up->port.membase + offset);
 		break;
 	case UPIO_PORT:
 		outl(value, up->port.iobase + offset);
@@ -259,34 +265,19 @@ sio_quot_set(struct uart_txx9_port *up, 
 static void serial_txx9_stop_tx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	sio_mask(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_start_tx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	sio_set(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_stop_rx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	up->port.read_status_mask &= ~TXX9_SIDISR_RDIS;
-#if 0
-	sio_mask(up, TXX9_SIDICR, TXX9_SIDICR_RIE);
-#endif
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_enable_ms(struct uart_port *port)
@@ -302,12 +293,16 @@ receive_chars(struct uart_txx9_port *up,
 	unsigned int disr = *status;
 	int max_count = 256;
 	char flag;
+	unsigned int next_ignore_status_mask;
 
 	do {
 		ch = sio_in(up, TXX9_SIRFIFO);
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
+		/* mask out RFDN_MASK bit added by previous overrun */
+		next_ignore_status_mask =
+			up->port.ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
 		if (unlikely(disr & (TXX9_SIDISR_UBRK | TXX9_SIDISR_UPER |
 				     TXX9_SIDISR_UFER | TXX9_SIDISR_UOER))) {
 			/*
@@ -328,8 +323,17 @@ receive_chars(struct uart_txx9_port *up,
 				up->port.icount.parity++;
 			else if (disr & TXX9_SIDISR_UFER)
 				up->port.icount.frame++;
-			if (disr & TXX9_SIDISR_UOER)
+			if (disr & TXX9_SIDISR_UOER) {
 				up->port.icount.overrun++;
+				/*
+				 * The receiver read buffer still hold
+				 * a char which caused overrun.
+				 * Ignore next char by adding RFDN_MASK
+				 * to ignore_status_mask temporarily.
+				 */
+				next_ignore_status_mask |=
+					TXX9_SIDISR_RFDN_MASK;
+			}
 
 			/*
 			 * Mask off conditions which should be ingored.
@@ -349,6 +353,7 @@ receive_chars(struct uart_txx9_port *up,
 		uart_insert_char(&up->port, disr, TXX9_SIDISR_UOER, ch, flag);
 
 	ignore_char:
+		up->port.ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
@@ -450,14 +455,11 @@ static unsigned int serial_txx9_get_mctr
 static void serial_txx9_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	if (mctrl & TIOCM_RTS)
 		sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
 	else
 		sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_break_ctl(struct uart_port *port, int break_state)
@@ -784,8 +786,14 @@ static void serial_txx9_config_port(stru
 static int
 serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq < 0 ||
-	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
+	unsigned long new_port = ser->port;
+	if (HIGH_BITS_OFFSET)
+		new_port += (unsigned long)ser->port_high << HIGH_BITS_OFFSET;
+	if (ser->type != port->type ||
+	    ser->irq != port->irq ||
+	    ser->io_type != port->iotype ||
+	    new_port != port->iobase ||
+	    (unsigned long)ser->iomem_base != port->mapbase)
 		return -EINVAL;
 	return 0;
 }
@@ -827,7 +835,8 @@ static void __init serial_txx9_register_
 
 		up->port.line = i;
 		up->port.ops = &serial_txx9_pops;
-		uart_add_one_port(drv, &up->port);
+		if (up->port.iobase || up->port.mapbase)
+			uart_add_one_port(drv, &up->port);
 	}
 }
 
@@ -927,11 +936,6 @@ static int serial_txx9_console_setup(str
 		return -ENODEV;
 
 	/*
-	 * Temporary fix.
-	 */
-	spin_lock_init(&port->lock);
-
-	/*
 	 *	Disable UART interrupts, set DTR and RTS high
 	 *	and set speed.
 	 */
@@ -1041,11 +1045,10 @@ static int __devinit serial_txx9_registe
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart->port.type == PORT_UNKNOWN)
+		if (!(uart->port.iobase || uart->port.mapbase))
 			break;
 	}
 	if (i < UART_NR) {
-		uart_remove_one_port(&serial_txx9_reg, &uart->port);
 		uart->port.iobase = port->iobase;
 		uart->port.membase = port->membase;
 		uart->port.irq      = port->irq;
@@ -1080,9 +1083,8 @@ static void __devexit serial_txx9_unregi
 	uart->port.type = PORT_UNKNOWN;
 	uart->port.iobase = 0;
 	uart->port.mapbase = 0;
-	uart->port.membase = 0;
+	uart->port.membase = NULL;
 	uart->port.dev = NULL;
-	uart_add_one_port(&serial_txx9_reg, &uart->port);
 	mutex_unlock(&serial_txx9_mutex);
 }
 
@@ -1198,8 +1200,11 @@ static void __exit serial_txx9_exit(void
 #ifdef ENABLE_SERIAL_TXX9_PCI
 	pci_unregister_driver(&serial_txx9_pci_driver);
 #endif
-	for (i = 0; i < UART_NR; i++)
-		uart_remove_one_port(&serial_txx9_reg, &serial_txx9_ports[i].port);
+	for (i = 0; i < UART_NR; i++) {
+		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		if (up->port.iobase || up->port.mapbase)
+			uart_remove_one_port(&serial_txx9_reg, &up->port);
+	}
 
 	uart_unregister_driver(&serial_txx9_reg);
 }

