Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTI3WqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTI3WqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:46:18 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:1237 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261814AbTI3WqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:46:03 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: rmk@arm.linux.org.uk
Subject: RFC: removing legacy UART cruft
Date: Tue, 30 Sep 2003 16:46:00 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301646.00703.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to remove all the legacy UART cruft from ia64.  In theory
we should be able to discover all UARTs on ia64 via ACPI and PCI
enumeration, so we shouldn't need SERIAL_PORT_DFNS.

But SERIAL_PORT_DFNS currently does two things:
	1) it tells you about legacy devices you can't discover
	   via a standard enumeration method, and
	2) it sizes old_serial_port[], which determines UART_NR,
	   which is the maximum number of ports the driver will
	   support

So here's a proposal to make SERIAL_PORT_DFNS optional and
provide another mechanism for configuring the number of ports
to support.

Comments welcome.

Bjorn


diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	Tue Sep 30 19:10:48 2003
+++ b/drivers/serial/8250.c	Tue Sep 30 19:10:48 2003
@@ -105,11 +105,20 @@
 
 #include <asm/serial.h>
 
+/*
+ * SERIAL_PORT_DFNS tells us about built-in ports that have no
+ * standard enumeration mechanism.   Platforms that can find all
+ * serial ports via mechanisms like ACPI or PCI need not supply it.
+ */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
 static struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
-#define UART_NR	ARRAY_SIZE(old_serial_port)
+#define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
 
 #if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
 
@@ -2136,7 +2145,8 @@
 	int ret, i;
 
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
-		"IRQ sharing %sabled\n", share_irqs ? "en" : "dis");
+		"%d ports, IRQ sharing %sabled\n", (int) UART_NR,
+		share_irqs ? "en" : "dis");
 
 	for (i = 0; i < NR_IRQS; i++)
 		spin_lock_init(&irq_lists[i].lock);
diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Tue Sep 30 19:10:48 2003
+++ b/drivers/serial/8250_pci.c	Tue Sep 30 19:10:48 2003
@@ -1552,8 +1552,10 @@
 #endif
 		
 		priv->line[i] = register_serial(&serial_req);
-		if (priv->line[i] < 0)
+		if (priv->line[i] < 0) {
+			printk(KERN_WARNING "Couldn't register serial port %s: %d\n", pci_name(dev), priv->line[i]);
 			break;
+		}
 	}
 
 	priv->nr = i;
diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	Tue Sep 30 19:10:48 2003
+++ b/drivers/serial/Kconfig	Tue Sep 30 19:10:48 2003
@@ -93,6 +93,16 @@
 	  purpose port, say Y here. See
 	  <http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf>.
 
+config SERIAL_8250_NR_UARTS
+	int "Maximum number of non-legacy 8250/16550 serial ports"
+	depends on SERIAL_8250
+	default "4"
+	---help---
+	  Set this to the number of non-legacy serial ports you want
+	  the driver to support.  This includes any ports discovered
+	  via ACPI or PCI enumeration and any ports that may be added
+	  at run-time via hot-plug.
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
@@ -107,8 +117,8 @@
 	  the questions about serial driver options. If unsure, say N.
 
 config SERIAL_8250_MANY_PORTS
-	bool "Support more than 4 serial ports"
-	depends on SERIAL_8250_EXTENDED
+	bool "Support more than 4 legacy serial ports"
+	depends on SERIAL_8250_EXTENDED && !IA64
 	help
 	  Say Y here if you have dumb serial boards other than the four
 	  standard COM 1/2/3/4 ports. This may happen if you have an AST

