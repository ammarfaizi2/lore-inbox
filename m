Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266033AbUF2Ul2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUF2Ul2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUF2Ul2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:41:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266033AbUF2UlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:41:18 -0400
Date: Tue, 29 Jun 2004 21:41:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [CFT] [SERIAL] Remove UPF_RESOURCES
Message-ID: <20040629214115.D24951@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UPF_RESOURCES flag was added to the serial layer to cater for the
idiosyncrasies of the PCMCIA layer, where the PCMCIA core code handles
the claiming of busy resources.

However, the PCMCIA core has progressed, and now does not claim busy
resources - IOW, it now behaves just like any other bus driver, where
resources are allocated non-busy and its up to the drivers to mark
their regions busy using request_region / request_mem_region.

The effect of this is that the UPF_RESOURCES hack in the serial layer
is now redundant, and can now be removed - 8250 devices should now
always use request_region / request_mem_region unconditionally.

In theory, this should only affect the 8250 driver, but I see some
other drivers (au1x00) also using this flag.  However, since this flag
is always set in the driver, it's rather pointless.

(Of course, this all assumes that you're using Linus' latest BK or
akpm's -mm2 or later, which has the necessary PCMCIA changes in
place.)

akpm - feel free to apply to -mm.

So, here's a patch which removes the UPF_RESOURCES entirely:

===== drivers/serial/8250.c 1.55 vs edited =====
--- 1.55/drivers/serial/8250.c	2004-04-17 10:48:54 +01:00
+++ edited/drivers/serial/8250.c	2004-06-29 21:34:53 +01:00
@@ -1687,8 +1687,6 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long start, offset = 0, size = 0;
 
-	if (!(up->port.flags & UPF_RESOURCES))
-		return;
 	if (up->port.type == PORT_RSA) {
 		offset = UART_RSA_BASE << up->port.regshift;
 		size = 8;
@@ -1733,16 +1731,14 @@
 	struct resource *res = NULL, *res_rsa = NULL;
 	int ret = 0;
 
-	if (up->port.flags & UPF_RESOURCES) {
-		if (up->port.type == PORT_RSA) {
-			ret = serial8250_request_rsa_resource(up, &res_rsa);
-			if (ret < 0)
-				return ret;
-		}
-
-		ret = serial8250_request_std_resource(up, &res);
+	if (up->port.type == PORT_RSA) {
+		ret = serial8250_request_rsa_resource(up, &res_rsa);
+		if (ret < 0)
+			return ret;
 	}
 
+	ret = serial8250_request_std_resource(up, &res);
+
 	/*
 	 * If we have a mapbase, then request that as well.
 	 */
@@ -1782,17 +1778,13 @@
 	 * Find the region that we can probe for.  This in turn
 	 * tells us whether we can probe for the type of port.
 	 */
-	if (up->port.flags & UPF_RESOURCES) {
-		ret = serial8250_request_std_resource(up, &res_std);
-		if (ret < 0)
-			return;
+	ret = serial8250_request_std_resource(up, &res_std);
+	if (ret < 0)
+		return;
 
-		ret = serial8250_request_rsa_resource(up, &res_rsa);
-		if (ret < 0)
-			probeflags &= ~PROBE_RSA;
-	} else {
+	ret = serial8250_request_rsa_resource(up, &res_rsa);
+	if (ret < 0)
 		probeflags &= ~PROBE_RSA;
-	}
 
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
@@ -1867,8 +1859,7 @@
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
 		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags |
-				    UPF_RESOURCES;
+		up->port.flags    = old_serial_port[i].flags;
 		up->port.hub6     = old_serial_port[i].hub6;
 		up->port.membase  = old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
===== drivers/serial/8250_acorn.c 1.4 vs edited =====
--- 1.4/drivers/serial/8250_acorn.c	2003-04-29 07:51:37 +01:00
+++ edited/drivers/serial/8250_acorn.c	2004-06-29 21:34:53 +01:00
@@ -43,8 +43,7 @@
 
 	memset(&req, 0, sizeof(req));
 	req.irq			= irq;
-	req.flags		= UPF_AUTOPROBE | UPF_RESOURCES |
-				  UPF_SHARE_IRQ;
+	req.flags		= UPF_AUTOPROBE | UPF_SHARE_IRQ;
 	req.baud_base		= baud_base;
 	req.io_type		= UPIO_MEM;
 	req.iomem_base		= vaddr;
===== drivers/serial/8250_acpi.c 1.10 vs edited =====
--- 1.10/drivers/serial/8250_acpi.c	2004-05-25 06:32:34 +01:00
+++ edited/drivers/serial/8250_acpi.c	2004-06-29 21:34:53 +01:00
@@ -123,7 +123,7 @@
 	}
 
 	serial_req.baud_base = BASE_BAUD;
-	serial_req.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
+	serial_req.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 
 	priv->line = register_serial(&serial_req);
 	if (priv->line < 0) {
===== drivers/serial/8250_pci.c 1.35 vs edited =====
--- 1.35/drivers/serial/8250_pci.c	2004-05-16 12:06:18 +01:00
+++ edited/drivers/serial/8250_pci.c	2004-06-29 21:34:53 +01:00
@@ -1665,7 +1665,7 @@
 	for (i = 0; i < nr_ports; i++) {
 		memset(&serial_req, 0, sizeof(serial_req));
 		serial_req.flags = UPF_SKIP_TEST | UPF_AUTOPROBE |
-				   UPF_RESOURCES | UPF_SHARE_IRQ;
+				   UPF_SHARE_IRQ;
 		serial_req.baud_base = board->base_baud;
 		serial_req.irq = get_pci_irq(dev, board, i);
 		if (quirk->setup(dev, board, &serial_req, i))
===== drivers/serial/8250_pnp.c 1.22 vs edited =====
--- 1.22/drivers/serial/8250_pnp.c	2004-06-18 07:43:58 +01:00
+++ edited/drivers/serial/8250_pnp.c	2004-06-29 21:34:53 +01:00
@@ -413,7 +413,7 @@
 	       serial_req.port, serial_req.irq, serial_req.io_type);
 #endif
 
-	serial_req.flags = UPF_SKIP_TEST | UPF_AUTOPROBE  | UPF_RESOURCES;
+	serial_req.flags = UPF_SKIP_TEST | UPF_AUTOPROBE;
 	serial_req.baud_base = 115200;
 	line = register_serial(&serial_req);
 
===== drivers/serial/au1x00_uart.c 1.1 vs edited =====
--- 1.1/drivers/serial/au1x00_uart.c	2004-02-19 03:42:44 +00:00
+++ edited/drivers/serial/au1x00_uart.c	2004-06-29 21:34:53 +01:00
@@ -969,9 +969,7 @@
 	struct resource *res = NULL, *res_rsa = NULL;
 	int ret = 0;
 
-	if (up->port.flags & UPF_RESOURCES) {
-		ret = serial8250_request_std_resource(up, &res);
-	}
+	ret = serial8250_request_std_resource(up, &res);
 
 	/*
 	 * If we have a mapbase, then request that as well.
@@ -1072,8 +1070,7 @@
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = old_serial_port[i].irq;
 		up->port.uartclk  = get_au1x00_uart_baud_base();
-		up->port.flags    = old_serial_port[i].flags |
-				    UPF_RESOURCES;
+		up->port.flags    = old_serial_port[i].flags;
 		up->port.hub6     = old_serial_port[i].hub6;
 		up->port.membase  = old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
===== drivers/serial/bast_sio.c 1.1 vs edited =====
--- 1.1/drivers/serial/bast_sio.c	2004-04-05 22:19:09 +01:00
+++ edited/drivers/serial/bast_sio.c	2004-06-29 21:34:53 +01:00
@@ -24,7 +24,7 @@
 	printk("BAST: SuperIO serial (%08lx,%d)\n", port, irq);
 #endif
 
-	serial_req.flags      = UPF_AUTOPROBE | UPF_RESOURCES | UPF_SHARE_IRQ;
+	serial_req.flags      = UPF_AUTOPROBE | UPF_SHARE_IRQ;
 	serial_req.baud_base  = BASE_BAUD;
 	serial_req.irq        = irq;
 	serial_req.io_type    = UPIO_MEM;
===== include/linux/serial_core.h 1.40 vs edited =====
--- 1.40/include/linux/serial_core.h	2004-06-26 22:16:08 +01:00
+++ edited/include/linux/serial_core.h	2004-06-29 21:33:26 +01:00
@@ -205,7 +205,6 @@
 #define UPF_CONS_FLOW		(1 << 23)
 #define UPF_SHARE_IRQ		(1 << 24)
 #define UPF_BOOT_AUTOCONF	(1 << 28)
-#define UPF_RESOURCES		(1 << 30)
 #define UPF_IOREMAP		(1 << 31)
 
 #define UPF_CHANGE_MASK		(0x17fff)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
