Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUAPWSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAPWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:16:04 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:57571 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265846AbUAPWMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:12:25 -0500
Date: Fri, 16 Jan 2004 15:12:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Let arches provide serial infos to kgdb
Message-ID: <20040116221223.GA13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following is against kgdb-2.0.3, and allows for
architectures to provide different serial infos to the 8250 stub.  This
patch doesn't allow for (yet) registers to be shifted, but that's my
next step.  With the following patch applied (and some other bits that
I'm not done with) I can hookup kgdb on one of my PPC boxes and get a
backtrace.

--- 1.1/drivers/serial/kgdb_8250.c	Wed Jan 14 15:16:15 2004
+++ edited/drivers/serial/kgdb_8250.c	Fri Jan 16 14:27:03 2004
@@ -20,6 +20,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/serialP.h>
 #include <linux/config.h>
@@ -48,24 +49,55 @@
 static int kgdb8250_got_dollar = -3, kgdb8250_got_H = -3,
 	kgdb8250_interrupt_iteration = 0;
 
+/* We only allow for 4 ports to be registered.  We default to standard
+ * PC values. */
+static struct uart_port rs_table[4] = {
+	{ .line = 0x3f8, .irq = 4 },
+	{ .line = 0x2f8, .irq = 3 },
+	{ .line = 0x3e8, .irq = 4 },
+	{ .line = 0x2e8, .irq = 3 },
+};
+static void (*serial_outb)(unsigned char, unsigned long);
+static unsigned long (*serial_inb)(unsigned long);
+
 extern void	set_debug_traps(void) ;		/* GDB routine */
 int serial8250_release_irq(int irq);
 
 int kgdb8250_irq;
-int kgdb8250_port;
+unsigned long  kgdb8250_port;
 
 static int initialized = -1;
 
 int kgdb8250_baud = 115200;
 int kgdb8250_ttyS;
 
+static unsigned long direct_inb(unsigned long addr)
+{
+	return readb(addr);
+}
+
+static void direct_outb(unsigned char val, unsigned long addr)
+{
+	writeb(val, addr);
+}
+
+static unsigned long io_inb(unsigned long port)
+{
+	return inb(port);
+}
+
+static void io_outb(unsigned char val, unsigned long port)
+{
+	outb(val, port);
+}
+
 /*
  * Get a byte from the hardware data buffer and return it
  */
 static int read_data_bfr(void)
 {
-	if (inb(kgdb8250_port + UART_LSR) & UART_LSR_DR)
-		return(inb(kgdb8250_port + UART_RX));
+	if (serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_DR)
+		return(serial_inb(kgdb8250_port + UART_RX));
 
 	return( -1 ) ;
 
@@ -99,9 +133,9 @@
  */
 static void kgdb8250_write_char(int chr)
 {
-    while ( !(inb(kgdb8250_port + UART_LSR) & UART_LSR_THRE) ) ;
+    while ( !(serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_THRE) ) ;
 
-    outb(chr, kgdb8250_port+UART_TX);
+    serial_outb(chr, kgdb8250_port+UART_TX);
 
 } /* write_char */
 
@@ -135,7 +169,7 @@
 	do
 	{
 		chr = read_data_bfr();
-		iir = inb(kgdb8250_port + UART_IIR);
+		iir = serial_inb(kgdb8250_port + UART_IIR);
 		if (chr < 0) continue ;
 
 		/* Check whether gdb sent interrupt */
@@ -272,17 +306,17 @@
          *      and set speed.
          */
 	cval = 0x3;
-        outb(cval | UART_LCR_DLAB, kgdb8250_port + UART_LCR);       /* set DLAB */
-        outb(quot & 0xff, kgdb8250_port + UART_DLL);         /* LS of divisor */
-        outb(quot >> 8, kgdb8250_port + UART_DLM);           /* MS of divisor */
-        outb(cval, kgdb8250_port + UART_LCR);                /* reset DLAB */
-        outb(UART_IER_RDI, kgdb8250_port + UART_IER);        /* turn on interrupts*/
-        outb(UART_MCR_OUT2 | UART_MCR_DTR | UART_MCR_RTS, kgdb8250_port + UART_MCR);
+        serial_outb(cval | UART_LCR_DLAB, kgdb8250_port + UART_LCR);       /* set DLAB */
+        serial_outb(quot & 0xff, kgdb8250_port + UART_DLL);         /* LS of divisor */
+        serial_outb(quot >> 8, kgdb8250_port + UART_DLM);           /* MS of divisor */
+        serial_outb(cval, kgdb8250_port + UART_LCR);                /* reset DLAB */
+        serial_outb(UART_IER_RDI, kgdb8250_port + UART_IER);        /* turn on interrupts*/
+        serial_outb(UART_MCR_OUT2 | UART_MCR_DTR | UART_MCR_RTS, kgdb8250_port + UART_MCR);
 
         /*
          *      If we read 0xff from the LSR, there is no UART here.
          */
-        if (inb(kgdb8250_port + UART_LSR) == 0xff)
+        if (serial_inb(kgdb8250_port + UART_LSR) == 0xff)
                 return -1;
         return 0;
 }
@@ -294,25 +328,18 @@
 	/*
 	 * Set port and irq number.
 	 */
-	switch(kgdb8250_ttyS)
+	kgdb8250_irq = rs_table[kgdb8250_ttyS].irq;
+	switch(rs_table[kgdb8250_ttyS].iotype)
 	{
-	case 0:
-	default:
-		kgdb8250_port = 0x3f8;
-		kgdb8250_irq = 4;
-		break;
-	case 1:
-		kgdb8250_port = 0x2f8;
-		kgdb8250_irq = 3;
-		break;
-	case 2:
-		kgdb8250_port = 0x3e8;
-		kgdb8250_irq = 4;
-		break;
-	case 3:
-		kgdb8250_port = 0x2e8;
-		kgdb8250_irq = 3;
+	case SERIAL_IO_MEM:
+		kgdb8250_port = (unsigned long)rs_table[kgdb8250_ttyS].membase;
+		serial_inb = direct_inb;
+		serial_outb = direct_outb;
 		break;
+	default:
+		kgdb8250_port = rs_table[kgdb8250_ttyS].line;
+		serial_inb = io_inb;
+		serial_outb = io_outb;
 	}
 
 #ifdef CONFIG_SERIAL_8250
@@ -334,6 +361,15 @@
 
 	return 0;
 
+}
+
+void
+kgdb8250_add_port(int i, struct uart_port *serial_req)
+{
+	rs_table[i].iotype = serial_req->iotype;
+	rs_table[i].line = serial_req->line;
+	rs_table[i].membase = serial_req->membase;
+	rs_table[i].regshift = serial_req->regshift;
 }
 
 struct kgdb_serial kgdb8250_serial = {

-- 
Tom Rini
http://gate.crashing.org/~trini/
