Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUJSGRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUJSGRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUJSGRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:17:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:3729 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268019AbUJSGQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:16:45 -0400
Subject: [PATCH] 1/2 : 8250 serial: dynamic port table from arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098166305.15029.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 16:11:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds the possibility for the arch code to provide
a function that gives the list of default motherboard 8250
serial ports instead of relying on a static #define. It was
posted earlier, this version takes into account Russell comments,
so I hope he's ok with it as-is. It won't change anything for
existing archs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-maple/drivers/serial/8250.c
===================================================================
--- linux-maple.orig/drivers/serial/8250.c	2004-10-19 13:37:18.000000000 +1000
+++ linux-maple/drivers/serial/8250.c	2004-10-19 15:42:05.418518568 +1000
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
Index: linux-maple/drivers/serial/8250.h
===================================================================
--- linux-maple.orig/drivers/serial/8250.h	2004-10-19 13:37:15.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
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
Index: linux-maple/drivers/serial/8250_pci.c
===================================================================
--- linux-maple.orig/drivers/serial/8250_pci.c	2004-10-19 13:37:57.000000000 +1000
+++ linux-maple/drivers/serial/8250_pci.c	2004-10-19 15:42:05.427517200 +1000
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
Index: linux-maple/drivers/serial/8250_pnp.c
===================================================================
--- linux-maple.orig/drivers/serial/8250_pnp.c	2004-10-19 13:37:18.000000000 +1000
+++ linux-maple/drivers/serial/8250_pnp.c	2004-10-19 15:42:05.428517048 +1000
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
 
 
Index: linux-maple/drivers/serial/au1x00_uart.c
===================================================================
--- linux-maple.orig/drivers/serial/au1x00_uart.c	2004-10-19 13:37:21.000000000 +1000
+++ linux-maple/drivers/serial/au1x00_uart.c	2004-10-19 15:42:05.429516896 +1000
@@ -40,7 +40,7 @@
 #endif
 
 #include <linux/serial_core.h>
-#include "8250.h"
+#include <linux/8250.h>
 
 /*
  * Debugging.
Index: linux-maple/drivers/serial/serial_cs.c
===================================================================
--- linux-maple.orig/drivers/serial/serial_cs.c	2004-10-19 13:37:40.000000000 +1000
+++ linux-maple/drivers/serial/serial_cs.c	2004-10-19 15:42:05.429516896 +1000
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
Index: linux-maple/include/linux/8250.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-maple/include/linux/8250.h	2004-10-19 15:42:05.430516744 +1000
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


