Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUJFJOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUJFJOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUJFJOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:14:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:38804 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269050AbUJFJN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:13:57 -0400
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20041006082658.A18379@flint.arm.linux.org.uk>
References: <1096534248.32721.36.camel@gaston>
	 <20041006082658.A18379@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097053663.21132.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 19:07:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 17:26, Russell King wrote:

> serial.h is used by userspace programs.  We should not expose this
> structure to those programs.  Instead, maybe creating an 8250.h
> header, or even moving the existing 8250.h header ?

Here's a new version of that patch that moves 8250.h to
include/linux, moves the definition of old_serial_ports there,
and also corrects the problem I told you about with serial console.

Let me know if I can send it to Andrew...

Ben.

diff -urN linux-2.5/drivers/serial/8250.c linux-maple/drivers/serial/8250.c
--- linux-2.5/drivers/serial/8250.c	2004-09-30 18:31:42.000000000 +1000
+++ linux-maple/drivers/serial/8250.c	2004-10-06 19:05:13.042342513 +1000
@@ -41,7 +41,7 @@
 #endif
 
 #include <linux/serial_core.h>
-#include "8250.h"
+#include <linux/8250.h>
 
 /*
  * Configuration:
@@ -112,11 +112,18 @@
 #define SERIAL_PORT_DFNS
 #endif
 
+#ifndef ARCH_HAS_GET_LEGACY_SERIAL_PORTS
 static struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
-
+static inline struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
+{
+	*count = ARRAY_SIZE(old_serial_port);
+	return old_serial_port;
+}
 #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
+#endif /* ARCH_HAS_DYNAMIC_LEGACY_SERIAL_PORTS */
+
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
@@ -1839,22 +1846,28 @@
 {
 	struct uart_8250_port *up;
 	static int first = 1;
+	struct old_serial_port *old_ports;
+	int count;
 	int i;
 
 	if (!first)
 		return;
 	first = 0;
 
-	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
+	old_ports = get_legacy_serial_ports(&count);
+	if (old_ports == NULL)
+		return;
+
+	for (i = 0, up = serial8250_ports; i < count;
 	     i++, up++) {
-		up->port.iobase   = old_serial_port[i].port;
-		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
-		up->port.hub6     = old_serial_port[i].hub6;
-		up->port.membase  = old_serial_port[i].iomem_base;
-		up->port.iotype   = old_serial_port[i].io_type;
-		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		up->port.iobase   = old_ports[i].port;
+		up->port.irq      = irq_canonicalize(old_ports[i].irq);
+		up->port.uartclk  = old_ports[i].baud_base * 16;
+		up->port.flags    = old_ports[i].flags;
+		up->port.hub6     = old_ports[i].hub6;
+		up->port.membase  = old_ports[i].iomem_base;
+		up->port.iotype   = old_ports[i].io_type;
+		up->port.regshift = old_ports[i].iomem_reg_shift;
 		up->port.ops      = &serial8250_pops;
 		if (share_irqs)
 			up->port.flags |= UPF_SHARE_IRQ;
@@ -1870,6 +1883,9 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (!up->port.iobase)
+			continue;
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		init_timer(&up->timer);
diff -urN linux-2.5/drivers/serial/8250.h linux-maple/drivers/serial/8250.h
--- linux-2.5/drivers/serial/8250.h	2004-09-30 18:31:42.000000000 +1000
+++ /dev/null	2004-10-05 22:10:47.391719208 +1000
@@ -1,71 +0,0 @@
-/*
- *  linux/drivers/char/8250.h
- *
- *  Driver for 8250/16550-type serial ports
- *
- *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
- *
- *  Copyright (C) 2001 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- *  $Id: 8250.h,v 1.8 2002/07/21 21:32:30 rmk Exp $
- */
-
-#include <linux/config.h>
-
-void serial8250_get_irq_map(unsigned int *map);
-void serial8250_suspend_port(int line);
-void serial8250_resume_port(int line);
-
-struct old_serial_port {
-	unsigned int uart;
-	unsigned int baud_base;
-	unsigned int port;
-	unsigned int irq;
-	unsigned int flags;
-	unsigned char hub6;
-	unsigned char io_type;
-	unsigned char *iomem_base;
-	unsigned short iomem_reg_shift;
-};
-
-/*
- * This replaces serial_uart_config in include/linux/serial.h
- */
-struct serial8250_config {
-	const char	*name;
-	unsigned int	fifo_size;
-	unsigned int	tx_loadsz;
-	unsigned int	flags;
-};
-
-#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
-#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
-#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
-
-#undef SERIAL_DEBUG_PCI
-
-#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
-#define SERIAL_INLINE
-#endif
-  
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#else
-#define _INLINE_
-#endif
-
-#define PROBE_RSA	(1 << 0)
-#define PROBE_ANY	(~0)
-
-#define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
-
-#ifdef CONFIG_SERIAL_8250_SHARE_IRQ
-#define SERIAL8250_SHARE_IRQS 1
-#else
-#define SERIAL8250_SHARE_IRQS 0
-#endif
diff -urN linux-2.5/drivers/serial/8250_pci.c linux-maple/drivers/serial/8250_pci.c
--- linux-2.5/drivers/serial/8250_pci.c	2004-09-30 18:31:42.000000000 +1000
+++ linux-maple/drivers/serial/8250_pci.c	2004-10-06 19:05:41.301674308 +1000
@@ -25,13 +25,12 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/8250_pci.h>
+#include <linux/8250.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
-#include "8250.h"
-
 /*
  * Definitions for PCI support.
  */
diff -urN linux-2.5/drivers/serial/8250_pnp.c linux-maple/drivers/serial/8250_pnp.c
--- linux-2.5/drivers/serial/8250_pnp.c	2004-09-30 18:31:42.000000000 +1000
+++ linux-maple/drivers/serial/8250_pnp.c	2004-10-06 19:05:55.788749883 +1000
@@ -25,13 +25,12 @@
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/serial_core.h>
+#include <linux/8250.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/serial.h>
 
-#include "8250.h"
-
 #define UNKNOWN_DEV 0x3000
 
 
diff -urN linux-2.5/drivers/serial/au1x00_uart.c linux-maple/drivers/serial/au1x00_uart.c
--- linux-2.5/drivers/serial/au1x00_uart.c	2004-09-30 18:31:42.000000000 +1000
+++ linux-maple/drivers/serial/au1x00_uart.c	2004-10-06 19:07:39.461032916 +1000
@@ -40,7 +40,7 @@
 #endif
 
 #include <linux/serial_core.h>
-#include "8250.h"
+#include <linux/8250.h>
 
 /*
  * Debugging.
diff -urN linux-2.5/drivers/serial/serial_cs.c linux-maple/drivers/serial/serial_cs.c
--- linux-2.5/drivers/serial/serial_cs.c	2004-09-30 18:31:42.000000000 +1000
+++ linux-maple/drivers/serial/serial_cs.c	2004-10-06 19:07:35.059700476 +1000
@@ -44,6 +44,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/major.h>
+#include <linux/8250.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -55,8 +56,6 @@
 #include <pcmcia/ds.h>
 #include <pcmcia/cisreg.h>
 
-#include "8250.h"
-
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
 MODULE_PARM(pc_debug, "i");
diff -urN linux-2.5/include/linux/8250.h linux-maple/include/linux/8250.h
--- /dev/null	2004-10-05 22:10:47.391719208 +1000
+++ linux-maple/include/linux/8250.h	2004-10-06 19:06:45.680713598 +1000
@@ -0,0 +1,74 @@
+/*
+ *  linux/drivers/char/8250.h
+ *
+ *  Driver for 8250/16550-type serial ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *
+ *  Copyright (C) 2001 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ *  $Id: 8250.h,v 1.8 2002/07/21 21:32:30 rmk Exp $
+ */
+
+#include <linux/config.h>
+
+void serial8250_get_irq_map(unsigned int *map);
+void serial8250_suspend_port(int line);
+void serial8250_resume_port(int line);
+
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
+/*
+ * Definition of a legacy serial port
+ */
+struct old_serial_port {
+	unsigned int uart;
+	unsigned int baud_base;
+	unsigned int port;
+	unsigned int irq;
+	unsigned int flags;
+	unsigned char hub6;
+	unsigned char io_type;
+	unsigned char *iomem_base;
+	unsigned short iomem_reg_shift;
+};
+
+#undef SERIAL_DEBUG_PCI
+
+#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#define SERIAL_INLINE
+#endif
+  
+#ifdef SERIAL_INLINE
+#define _INLINE_ inline
+#else
+#define _INLINE_
+#endif
+
+#define PROBE_RSA	(1 << 0)
+#define PROBE_ANY	(~0)
+
+#define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
+
+#ifdef CONFIG_SERIAL_8250_SHARE_IRQ
+#define SERIAL8250_SHARE_IRQS 1
+#else
+#define SERIAL8250_SHARE_IRQS 0
+#endif


