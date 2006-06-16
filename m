Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWFPNVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWFPNVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 09:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWFPNVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 09:21:20 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:14901 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S1751391AbWFPNVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 09:21:19 -0400
Message-ID: <4492CC64.80501@ra.rockwell.com>
Date: Fri, 16 Jun 2006 15:21:08 +0000
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] no_pci_serial
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 06/16/2006 08:21:22 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 06/16/2006 08:22:05 AM,
	Serialize complete at 06/16/2006 08:22:05 AM
Content-Type: multipart/mixed;
 boundary="------------010804060800010303060205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010804060800010303060205
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

This patch allows to compile 8250 driver on systems without pci bus.

Feedback and comments are highly appreciated.

This patch is against 2.6.17-rc5.

Please CC me, I'm not subscribed to the mailing list.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---


--------------010804060800010303060205
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="no_pci_serial.patch"
Content-Disposition: inline;
 filename="no_pci_serial.patch"

diff -uprN -X orig.bak.never.touch/Documentation/dontdiff orig.bak.never.touch/drivers/serial/8250.c new_gadget.newest/drivers/serial/8250.c
--- orig.bak.never.touch/drivers/serial/8250.c	2006-05-30 09:37:42.000000000 +0000
+++ new_gadget.newest/drivers/serial/8250.c	2006-06-14 12:14:45.000000000 +0000
@@ -303,23 +303,23 @@ static unsigned int serial_in(struct uar
 	offset = map_8250_in_reg(up, offset) << up->port.regshift;
 
 	switch (up->port.iotype) {
+#ifdef CONFIG_PCI
 	case UPIO_HUB6:
 		outb(up->port.hub6 - 1 + offset, up->port.iobase);
 		return inb(up->port.iobase + 1);
-
-	case UPIO_MEM:
-		return readb(up->port.membase + offset);
-
+#endif
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
-
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 		return __raw_readl(up->port.membase + offset);
 #endif
-
-	default:
+#ifdef CONFIG_PCI
+	case UPIO_PORT:
 		return inb(up->port.iobase + offset);
+#endif
+	default:
+		return readb(up->port.membase + offset);
 	}
 }
 
@@ -329,15 +329,12 @@ serial_out(struct uart_8250_port *up, in
 	offset = map_8250_out_reg(up, offset) << up->port.regshift;
 
 	switch (up->port.iotype) {
+#ifdef CONFIG_PCI
 	case UPIO_HUB6:
 		outb(up->port.hub6 - 1 + offset, up->port.iobase);
 		outb(value, up->port.iobase + 1);
 		break;
-
-	case UPIO_MEM:
-		writeb(value, up->port.membase + offset);
-		break;
-
+#endif
 	case UPIO_MEM32:
 		writel(value, up->port.membase + offset);
 		break;
@@ -347,9 +344,13 @@ serial_out(struct uart_8250_port *up, in
 		__raw_writel(value, up->port.membase + offset);
 		break;
 #endif
-
-	default:
+#ifdef CONFIG_PCI
+	case UPIO_PORT:
 		outb(value, up->port.iobase + offset);
+		break;
+#endif
+	default:
+		writeb(value, up->port.membase + offset);
 	}
 }
 
@@ -1045,17 +1046,20 @@ static void autoconfig(struct uart_8250_
 static void autoconfig_irq(struct uart_8250_port *up)
 {
 	unsigned char save_mcr, save_ier;
-	unsigned char save_ICP = 0;
-	unsigned int ICP = 0;
 	unsigned long irqs;
 	int irq;
 
+#ifdef CONFIG_SERIAL_8250_FOURPORT
+	unsigned char save_ICP = 0;
+	unsigned int ICP = 0;
+
 	if (up->port.flags & UPF_FOURPORT) {
 		ICP = (up->port.iobase & 0xfe0) | 0x1f;
 		save_ICP = inb_p(ICP);
 		outb_p(0x80, ICP);
 		(void) inb_p(ICP);
 	}
+#endif
 
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
@@ -1066,13 +1070,16 @@ static void autoconfig_irq(struct uart_8
 	irqs = probe_irq_on();
 	serial_outp(up, UART_MCR, 0);
 	udelay (10);
+
+#ifdef CONFIG_SERIAL_8250_FOURPORT
 	if (up->port.flags & UPF_FOURPORT)  {
 		serial_outp(up, UART_MCR,
 			    UART_MCR_DTR | UART_MCR_RTS);
-	} else {
+	} else
+#endif
 		serial_outp(up, UART_MCR,
 			    UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
-	}
+
 	serial_outp(up, UART_IER, 0x0f);	/* enable all intrs */
 	(void)serial_inp(up, UART_LSR);
 	(void)serial_inp(up, UART_RX);
@@ -1085,8 +1092,10 @@ static void autoconfig_irq(struct uart_8
 	serial_outp(up, UART_MCR, save_mcr);
 	serial_outp(up, UART_IER, save_ier);
 
+#ifdef CONFIG_SERIAL_8250_FOURPORT
 	if (up->port.flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
+#endif
 
 	up->port.irq = (irq > 0) ? irq : 0;
 }
@@ -1622,10 +1631,13 @@ static int serial8250_startup(struct uar
 	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
 
 	spin_lock_irqsave(&up->port.lock, flags);
+
+#ifdef CONFIG_SERIAL_8250_FOURPORT
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!is_real_interrupt(up->port.irq))
 			up->port.mctrl |= TIOCM_OUT1;
 	} else
+#endif
 		/*
 		 * Most PC uarts need OUT2 raised to enable interrupts.
 		 */
@@ -1663,6 +1675,7 @@ static int serial8250_startup(struct uar
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_outp(up, UART_IER, up->ier);
 
+#ifdef CONFIG_SERIAL_8250_FOURPORT
 	if (up->port.flags & UPF_FOURPORT) {
 		unsigned int icp;
 		/*
@@ -1672,6 +1685,7 @@ static int serial8250_startup(struct uar
 		outb_p(0x80, icp);
 		(void) inb_p(icp);
 	}
+#endif
 
 	/*
 	 * And clear the interrupt registers again for luck.
@@ -1696,11 +1710,14 @@ static void serial8250_shutdown(struct u
 	serial_outp(up, UART_IER, 0);
 
 	spin_lock_irqsave(&up->port.lock, flags);
+
+#ifdef CONFIG_SERIAL_8250_FOURPORT
 	if (up->port.flags & UPF_FOURPORT) {
 		/* reset interrupts on the AST Fourport board */
 		inb((up->port.iobase & 0xfe0) | 0x1f);
 		up->port.mctrl |= TIOCM_OUT1;
 	} else
+#endif
 		up->port.mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
diff -uprN -X orig.bak.never.touch/Documentation/dontdiff orig.bak.never.touch/drivers/serial/8250_early.c new_gadget.newest/drivers/serial/8250_early.c
--- orig.bak.never.touch/drivers/serial/8250_early.c	2006-05-30 09:37:42.000000000 +0000
+++ new_gadget.newest/drivers/serial/8250_early.c	2006-06-15 12:11:15.000000000 +0000
@@ -46,18 +46,22 @@ static int early_uart_registered __initd
 
 static unsigned int __init serial_in(struct uart_port *port, int offset)
 {
-	if (port->iotype == UPIO_MEM)
-		return readb(port->membase + offset);
-	else
+#ifdef CONFIG_PCI
+	if (port->iotype != UPIO_MEM)
 		return inb(port->iobase + offset);
+	else
+#endif
+		return readb(port->membase + offset);
 }
 
 static void __init serial_out(struct uart_port *port, int offset, int value)
 {
-	if (port->iotype == UPIO_MEM)
-		writeb(value, port->membase + offset);
-	else
+#ifdef CONFIG_PCI
+	if (port->iotype != UPIO_MEM)
 		outb(value, port->iobase + offset);
+	else
+#endif
+		writeb(value, port->membase + offset);
 }
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)


--------------010804060800010303060205--
