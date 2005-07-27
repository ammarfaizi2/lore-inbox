Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVG0WvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVG0WvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVG0WtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:49:15 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:22447 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261215AbVG0WrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:47:23 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+serial@arm.linux.org.uk>, linux-serial@vger.kernel.org
Subject: [PATCH] SERIAL: add MMIO support to 8250_pnp
Date: Wed, 27 Jul 2005 16:47:12 -0600
User-Agent: KMail/1.8.1
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507271647.12882.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UARTs in MMIO space and clean up a little whitespace.

HP legacy-free ia64 machines need this.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work/drivers/serial/8250_pnp.c
===================================================================
--- work.orig/drivers/serial/8250_pnp.c	2005-07-27 09:57:10.000000000 -0600
+++ work/drivers/serial/8250_pnp.c	2005-07-27 10:07:09.000000000 -0600
@@ -394,7 +394,7 @@
 }
 
 static int __devinit
-serial_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
+serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_port port;
 	int ret, line, flags = dev_id->driver_data;
@@ -406,15 +406,23 @@
 	}
 
 	memset(&port, 0, sizeof(struct uart_port));
-	port.irq = pnp_irq(dev,0);
-	port.iobase = pnp_port_start(dev, 0);
+	port.irq = pnp_irq(dev, 0);
+	if (pnp_port_valid(dev, 0)) {
+		port.iobase = pnp_port_start(dev, 0);
+		port.iotype = UPIO_PORT;
+	} else if (pnp_mem_valid(dev, 0)) {
+		port.mapbase = pnp_mem_start(dev, 0);
+		port.iotype = UPIO_MEM;
+		port.flags = UPF_IOREMAP;
+	} else
+		return -ENODEV;
 
 #ifdef SERIAL_DEBUG_PNP
-	printk("Setup PNP port: port %x, irq %d, type %d\n",
-	       port.iobase, port.irq, port.iotype);
+	printk("Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
+	       port.iobase, port.mapbase, port.irq, port.iotype);
 #endif
 
-	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	port.uartclk = 1843200;
 	port.dev = &dev->dev;
 
@@ -426,7 +434,7 @@
 
 }
 
-static void __devexit serial_pnp_remove(struct pnp_dev * dev)
+static void __devexit serial_pnp_remove(struct pnp_dev *dev)
 {
 	long line = (long)pnp_get_drvdata(dev);
 	if (line)
