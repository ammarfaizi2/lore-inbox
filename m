Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVCQXbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVCQXbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVCQXbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:31:14 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:55983
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261370AbVCQXaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:30:23 -0500
Date: Thu, 17 Mar 2005 23:30:20 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: 8250 - sparse error fixes
Message-ID: <20050317233020.GA29700@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure __iomem on the correct bits of the serial_struct
and other definitions.

Remove the attempts to size zero length arrays, which
causes problems from sparse.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.11.3-bk3/include/linux/serial.h linux-2.6.11.3-bk3-fix1/include/linux/serial.h
--- linux-2.6.11.3-bk3/include/linux/serial.h	2005-03-02 07:37:50.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/include/linux/serial.h	2005-03-17 23:08:53.000000000 +0000
@@ -45,7 +45,7 @@
 	int	hub6;
 	unsigned short	closing_wait; /* time to wait before closing */
 	unsigned short	closing_wait2; /* no longer used... */
-	unsigned char	*iomem_base;
+	unsigned char __iomem *iomem_base;
 	unsigned short	iomem_reg_shift;
 	unsigned int	port_high;
 	unsigned long	iomap_base;	/* cookie passed into ioremap */
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/8250.c linux-2.6.11.3-bk3-fix1/drivers/serial/8250.c
--- linux-2.6.11.3-bk3/drivers/serial/8250.c	2005-03-17 22:58:47.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/8250.c	2005-03-17 23:23:39.000000000 +0000
@@ -111,15 +111,41 @@
  * standard enumeration mechanism.   Platforms that can find all
  * serial ports via mechanisms like ACPI or PCI need not supply it.
  */
-#ifndef SERIAL_PORT_DFNS
-#define SERIAL_PORT_DFNS
-#endif
 
+#ifdef SERIAL_PORT_DFNS
 static struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
+static inline void __init serial8240_isa_init_asmdefs(void)
+{
+	struct uart_8250_port *up;
+	int i;
+
+	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
+	     i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		up->port.flags    = old_serial_port[i].flags;
+		up->port.hub6     = old_serial_port[i].hub6;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		if (share_irqs)
+			up->port.flags |= UPF_SHARE_IRQ;
+	}
+}
+
 #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
+#else
+
+#define UART_NR	(CONFIG_SERIAL_8250_NR_UARTS)
+
+static inline void __init serial8240_isa_init_asmdefs(void)
+{
+}
+#endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
@@ -2021,9 +2047,9 @@
 		return;
 	first = 0;
 
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
+	up = &serial8250_ports[0];
 
+	for (i = 0; i < UART_NR; i++, up++) {
 		up->port.line = i;
 		spin_lock_init(&up->port.lock);
 
@@ -2039,19 +2065,7 @@
 		up->port.ops = &serial8250_pops;
 	}
 
-	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
-	     i++, up++) {
-		up->port.iobase   = old_serial_port[i].port;
-		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
-		up->port.hub6     = old_serial_port[i].hub6;
-		up->port.membase  = old_serial_port[i].iomem_base;
-		up->port.iotype   = old_serial_port[i].io_type;
-		up->port.regshift = old_serial_port[i].iomem_reg_shift;
-		if (share_irqs)
-			up->port.flags |= UPF_SHARE_IRQ;
-	}
+	serial8240_isa_init_asmdefs();
 }
 
 static void __init
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/8250.h linux-2.6.11.3-bk3-fix1/drivers/serial/8250.h
--- linux-2.6.11.3-bk3/drivers/serial/8250.h	2005-03-02 07:37:30.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/8250.h	2005-03-17 23:07:10.000000000 +0000
@@ -30,7 +30,7 @@
 	unsigned int flags;
 	unsigned char hub6;
 	unsigned char io_type;
-	unsigned char *iomem_base;
+	unsigned char __iomem *iomem_base;
 	unsigned short iomem_reg_shift;
 };
 
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/serial_core.c linux-2.6.11.3-bk3-fix1/drivers/serial/serial_core.c
--- linux-2.6.11.3-bk3/drivers/serial/serial_core.c	2005-03-02 07:37:50.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/serial_core.c	2005-03-17 23:09:36.000000000 +0000
@@ -592,7 +592,7 @@
 	tmp.hub6	    = port->hub6;
 	tmp.io_type         = port->iotype;
 	tmp.iomem_reg_shift = port->regshift;
-	tmp.iomem_base      = (void *)port->mapbase;
+	tmp.iomem_base      = (void __iomem *)port->mapbase;
 
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250-sparse-fix.patch"

diff -urN -X ../dontdiff linux-2.6.11.3-bk3/include/linux/serial.h linux-2.6.11.3-bk3-fix1/include/linux/serial.h
--- linux-2.6.11.3-bk3/include/linux/serial.h	2005-03-02 07:37:50.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/include/linux/serial.h	2005-03-17 23:08:53.000000000 +0000
@@ -45,7 +45,7 @@
 	int	hub6;
 	unsigned short	closing_wait; /* time to wait before closing */
 	unsigned short	closing_wait2; /* no longer used... */
-	unsigned char	*iomem_base;
+	unsigned char __iomem *iomem_base;
 	unsigned short	iomem_reg_shift;
 	unsigned int	port_high;
 	unsigned long	iomap_base;	/* cookie passed into ioremap */
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/8250.c linux-2.6.11.3-bk3-fix1/drivers/serial/8250.c
--- linux-2.6.11.3-bk3/drivers/serial/8250.c	2005-03-17 22:58:47.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/8250.c	2005-03-17 23:23:39.000000000 +0000
@@ -111,15 +111,41 @@
  * standard enumeration mechanism.   Platforms that can find all
  * serial ports via mechanisms like ACPI or PCI need not supply it.
  */
-#ifndef SERIAL_PORT_DFNS
-#define SERIAL_PORT_DFNS
-#endif
 
+#ifdef SERIAL_PORT_DFNS
 static struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
+static inline void __init serial8240_isa_init_asmdefs(void)
+{
+	struct uart_8250_port *up;
+	int i;
+
+	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
+	     i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		up->port.flags    = old_serial_port[i].flags;
+		up->port.hub6     = old_serial_port[i].hub6;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		if (share_irqs)
+			up->port.flags |= UPF_SHARE_IRQ;
+	}
+}
+
 #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
+#else
+
+#define UART_NR	(CONFIG_SERIAL_8250_NR_UARTS)
+
+static inline void __init serial8240_isa_init_asmdefs(void)
+{
+}
+#endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
@@ -2021,9 +2047,9 @@
 		return;
 	first = 0;
 
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
+	up = &serial8250_ports[0];
 
+	for (i = 0; i < UART_NR; i++, up++) {
 		up->port.line = i;
 		spin_lock_init(&up->port.lock);
 
@@ -2039,19 +2065,7 @@
 		up->port.ops = &serial8250_pops;
 	}
 
-	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
-	     i++, up++) {
-		up->port.iobase   = old_serial_port[i].port;
-		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
-		up->port.hub6     = old_serial_port[i].hub6;
-		up->port.membase  = old_serial_port[i].iomem_base;
-		up->port.iotype   = old_serial_port[i].io_type;
-		up->port.regshift = old_serial_port[i].iomem_reg_shift;
-		if (share_irqs)
-			up->port.flags |= UPF_SHARE_IRQ;
-	}
+	serial8240_isa_init_asmdefs();
 }
 
 static void __init
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/8250.h linux-2.6.11.3-bk3-fix1/drivers/serial/8250.h
--- linux-2.6.11.3-bk3/drivers/serial/8250.h	2005-03-02 07:37:30.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/8250.h	2005-03-17 23:07:10.000000000 +0000
@@ -30,7 +30,7 @@
 	unsigned int flags;
 	unsigned char hub6;
 	unsigned char io_type;
-	unsigned char *iomem_base;
+	unsigned char __iomem *iomem_base;
 	unsigned short iomem_reg_shift;
 };
 
diff -urN -X ../dontdiff linux-2.6.11.3-bk3/drivers/serial/serial_core.c linux-2.6.11.3-bk3-fix1/drivers/serial/serial_core.c
--- linux-2.6.11.3-bk3/drivers/serial/serial_core.c	2005-03-02 07:37:50.000000000 +0000
+++ linux-2.6.11.3-bk3-fix1/drivers/serial/serial_core.c	2005-03-17 23:09:36.000000000 +0000
@@ -592,7 +592,7 @@
 	tmp.hub6	    = port->hub6;
 	tmp.io_type         = port->iotype;
 	tmp.iomem_reg_shift = port->regshift;
-	tmp.iomem_base      = (void *)port->mapbase;
+	tmp.iomem_base      = (void __iomem *)port->mapbase;
 
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;

--AqsLC8rIMeq19msA--
