Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUJVXoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUJVXoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUJVXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:43:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:46779 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269277AbUJVXkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:40:08 -0400
Subject: [PATCH] 8250: Let arch provide the list of leagacy ports
	dynamically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098488236.11740.97.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 09:37:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds an optional callback for the 8250 driver to request
the list of legacy port via a function call instead of relying on
a #define of an array. This finally allows to fix the problem of
platforms like ppc and ppc64 for which the same kernel can boot
machines with and without a 8250, and is necessary to properly deal
with a new platform coming to ppc64 which has a 8250 but with
different irq numbers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/8250.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/linux/8250.h	2004-10-23 09:03:30.751015360 +1000
@@ -0,0 +1,75 @@
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
+int serial8250_register_port(struct uart_port *);
+void serial8250_unregister_port(int line);
+void serial8250_get_irq_map(unsigned int *map);
+void serial8250_suspend_port(int line);
+void serial8250_resume_port(int line);
+
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
+/*
+ * This replaces serial_uart_config in include/linux/serial.h
+ */
+struct serial8250_config {
+	const char	*name;
+	unsigned short	fifo_size;
+	unsigned short	tx_loadsz;
+	unsigned char	fcr;
+	unsigned int	flags;
+};
+
+#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
+#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
+#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
+#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
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
Index: linux-work/drivers/serial/8250.h
===================================================================
--- linux-work.orig/drivers/serial/8250.h	2004-10-20 13:01:02.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,75 +0,0 @@
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
-int serial8250_register_port(struct uart_port *);
-void serial8250_unregister_port(int line);
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
-	unsigned short	fifo_size;
-	unsigned short	tx_loadsz;
-	unsigned char	fcr;
-	unsigned int	flags;
-};
-
-#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
-#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
-#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
-#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
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
Index: linux-work/drivers/serial/au1x00_uart.c
===================================================================
--- linux-work.orig/drivers/serial/au1x00_uart.c	2004-09-24 14:34:50.000000000 +1000
+++ linux-work/drivers/serial/au1x00_uart.c	2004-10-23 09:06:15.159021544 +1000
@@ -29,6 +29,7 @@
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/delay.h>
+#include <linux/8250.h>
 
 #include <asm/serial.h>
 #include <asm/io.h>
@@ -40,7 +41,6 @@
 #endif
 
 #include <linux/serial_core.h>
-#include "8250.h"
 
 /*
  * Debugging.
Index: linux-work/drivers/serial/serial_cs.c
===================================================================
--- linux-work.orig/drivers/serial/serial_cs.c	2004-10-21 11:47:02.000000000 +1000
+++ linux-work/drivers/serial/serial_cs.c	2004-10-23 09:06:39.578309248 +1000
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
Index: linux-work/drivers/serial/8250_pnp.c
===================================================================
--- linux-work.orig/drivers/serial/8250_pnp.c	2004-10-22 10:35:47.000000000 +1000
+++ linux-work/drivers/serial/8250_pnp.c	2004-10-23 09:05:52.738429992 +1000
@@ -26,12 +26,11 @@
 #include <linux/serialP.h>
 #include <linux/serial_core.h>
 #include <linux/bitops.h>
+#include <linux/8250.h>
 
 #include <asm/byteorder.h>
 #include <asm/serial.h>
 
-#include "8250.h"
-
 #define UNKNOWN_DEV 0x3000
 
 
Index: linux-work/drivers/serial/8250_pci.c
===================================================================
--- linux-work.orig/drivers/serial/8250_pci.c	2004-10-21 11:47:02.000000000 +1000
+++ linux-work/drivers/serial/8250_pci.c	2004-10-23 09:33:39.766003280 +1000
@@ -23,13 +23,13 @@
 #include <linux/delay.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
-#include <linux/8250_pci.h>
 #include <linux/bitops.h>
+#include <linux/8250.h>
+#include <linux/8250_pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
-#include "8250.h"
 
 /*
  * Definitions for PCI support.
Index: linux-work/drivers/serial/8250.c
===================================================================
--- linux-work.orig/drivers/serial/8250.c	2004-10-21 11:47:02.000000000 +1000
+++ linux-work/drivers/serial/8250.c	2004-10-23 09:31:25.530410192 +1000
@@ -32,6 +32,7 @@
 #include <linux/serialP.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/8250.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -41,7 +42,6 @@
 #endif
 
 #include <linux/serial_core.h>
-#include "8250.h"
 
 /*
  * Configuration:
@@ -112,11 +112,17 @@
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
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
@@ -1958,22 +1964,27 @@
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
-	     i++, up++) {
-		up->port.iobase   = old_serial_port[i].port;
-		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
-		up->port.hub6     = old_serial_port[i].hub6;
-		up->port.membase  = old_serial_port[i].iomem_base;
-		up->port.iotype   = old_serial_port[i].io_type;
-		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+	old_ports = get_legacy_serial_ports(&count);
+	if (old_ports == NULL)
+		return;
+
+	for (i = 0, up = serial8250_ports; i < count; i++, up++) {
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
@@ -1990,6 +2001,13 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		/* Don't register "empty" ports, setting "ops" on them
+		 * makes the console driver "setup" routine to succeed,
+		 * which is wrong. --BenH.
+		 */
+		if (!up->port.iobase)
+			continue;
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		up->port.dev = dev;


