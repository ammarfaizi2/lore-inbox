Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317658AbSGUIL5>; Sun, 21 Jul 2002 04:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317659AbSGUIL5>; Sun, 21 Jul 2002 04:11:57 -0400
Received: from [196.26.86.1] ([196.26.86.1]:30920 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317658AbSGUIL4>; Sun, 21 Jul 2002 04:11:56 -0400
Date: Sun, 21 Jul 2002 10:32:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] serial8250_stop_tx deadlock
Message-ID: <Pine.LNX.4.44.0207211030090.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
This patch fixes a deadlock and spinlock initialisation.

Index: linux-2.5.26/drivers/serial//serial_8250.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.26/drivers/serial/serial_8250.c,v
retrieving revision 1.1
diff -u -r1.1 serial_8250.c
--- linux-2.5.26/drivers/serial//serial_8250.c	20 Jul 2002 18:03:12 -0000	1.1
+++ linux-2.5.26/drivers/serial//serial_8250.c	20 Jul 2002 19:01:15 -0000
@@ -690,12 +690,10 @@
 	up->port.irq = (irq > 0) ? irq : 0;
 }
 
-static void serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
+static void __serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	if (up->ier & UART_IER_THRI) {
 		up->ier &= ~UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
@@ -704,6 +702,15 @@
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+}
+
+static void serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	__serial8250_stop_tx(port, tty_stop);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
@@ -845,7 +852,7 @@
 		return;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial8250_stop_tx(&up->port, 0);
+		__serial8250_stop_tx(&up->port, 0);
 		return;
 	}
 
@@ -864,7 +871,7 @@
 	DEBUG_INTR("THRE...");
 
 	if (uart_circ_empty(xmit))
-		serial8250_stop_tx(&up->port, 0);
+		__serial8250_stop_tx(&up->port, 0);
 }
 
 static _INLINE_ void check_modem_status(struct uart_8250_port *up)
@@ -1951,10 +1958,13 @@
 
 static int __init serial8250_init(void)
 {
-	int ret;
+	int ret, i;
 
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.1 $ "
 		"IRQ sharing %sabled\n", share_irqs ? "en" : "dis");
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
 
 	ret = uart_register_driver(&serial8250_reg);
 	if (ret)

-- 
function.linuxpower.ca

