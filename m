Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVFWKXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVFWKXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFWKUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:20:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44303 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262449AbVFWKDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:03:44 -0400
Date: Thu, 23 Jun 2005 11:03:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linux Serial List <linux-serial@vger.kernel.org>
Subject: [RFC/CFT] Split 8250 port table
Message-ID: <20050623110337.A31259@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Serial List <linux-serial@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch which some people may rejoice over, others may groan.

Add separate files for the different 8250 ISA-based serial boards.

Looking across all the various architectures, it seems reasonable that
we can key the availability of the configuration options for these
beasts to the bus-related symbols (iow, CONFIG_ISA).  We also standardise
the base baud/uart clock rate for these boards - I'm sure that isn't
architecture specific, but is solely dependent on the crystal fitted
on the board (which should be the same no matter what type of machine
its fitted into.)

The ordering of the ports has been kept the same, provided the modules
are linked into the kernel in the link order specified.

Once this patch has been accepted, we can kill the ISA serial board
static entries in _all_ of the architecture specific serial.h files.

However, the biggest downside to this is the way platform devices with
the same name are handled - they must have a unique ID, which is
hard-coded into the structure.

There appears to be three choices in respect of this:

1. we hard-code the values as below
2. we build into the kernel another object whose sole purpose is to
   provide 8250-based platform devices with unique IDs.
3. we fix the platform device layer so that it can look at the ID, and
   if its an "allocate me a new number" it scans the platform device
   list for the next free ID for that name.

Comments?

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250.c linux/drivers/serial/8250.c
--- orig/drivers/serial/8250.c	Sun May  1 20:59:28 2005
+++ linux/drivers/serial/8250.c	Wed May  4 13:18:10 2005
@@ -77,23 +77,9 @@ static unsigned int share_irqs = SERIAL8
  */
 #define is_real_interrupt(irq)	((irq) != 0)
 
-/*
- * This converts from our new CONFIG_ symbols to the symbols
- * that asm/serial.h expects.  You _NEED_ to comment out the
- * linux/config.h include contained inside asm/serial.h for
- * this to work.
- */
-#undef CONFIG_SERIAL_MANY_PORTS
-#undef CONFIG_SERIAL_DETECT_IRQ
-#undef CONFIG_SERIAL_MULTIPORT
-#undef CONFIG_HUB6
-
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define CONFIG_SERIAL_DETECT_IRQ 1
 #endif
-#ifdef CONFIG_SERIAL_8250_MULTIPORT
-#define CONFIG_SERIAL_MULTIPORT 1
-#endif
 #ifdef CONFIG_SERIAL_8250_MANY_PORTS
 #define CONFIG_SERIAL_MANY_PORTS 1
 #endif
@@ -2348,10 +2334,11 @@ static int __devinit serial8250_probe(st
 {
 	struct plat_serial8250_port *p = dev->platform_data;
 	struct uart_port port;
+	int ret, i;
 
 	memset(&port, 0, sizeof(struct uart_port));
 
-	for (; p && p->flags != 0; p++) {
+	for (i = 0; p && p->flags != 0; p++, i++) {
 		port.iobase	= p->iobase;
 		port.membase	= p->membase;
 		port.irq	= p->irq;
@@ -2360,10 +2347,16 @@ static int __devinit serial8250_probe(st
 		port.iotype	= p->iotype;
 		port.flags	= p->flags;
 		port.mapbase	= p->mapbase;
+		port.hub6	= p->hub6;
 		port.dev	= dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
-		serial8250_register_port(&port);
+		ret = serial8250_register_port(&port);
+		if (ret < 0) {
+			dev_err(dev, "unable to register port at index %d "
+				"(IO%lx MEM%lx IRQ%d): %d\n", i,
+				p->iobase, p->mapbase, p->irq, ret);
+		}
 	}
 	return 0;
 }
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250_accent.c linux/drivers/serial/8250_accent.c
--- orig/drivers/serial/8250_accent.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/serial/8250_accent.c	Wed May  4 13:31:09 2005
@@ -0,0 +1,47 @@
+/*
+ *  linux/drivers/serial/8250_accent.c
+ *
+ *  Copyright (C) 2005 Russell King.
+ *  Data taken from include/asm-i386/serial.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#define PORT(_base,_irq)				\
+	{						\
+		.iobase		= _base,		\
+		.irq		= _irq,			\
+		.uartclk	= 1843200,		\
+		.iotype		= UPIO_PORT,		\
+		.flags		= UPF_BOOT_AUTOCONF,	\
+	}
+
+static struct plat_serial8250_port accent_data[] = {
+	PORT(0x330, 4),
+	PORT(0x338, 4),
+	{ },
+};
+
+static struct platform_device accent_device = {
+	.name			= "serial8250",
+	.id			= 2,
+	.dev			= {
+		.platform_data	= accent_data,
+	},
+};
+
+static int __init accent_init(void)
+{
+	return platform_device_register(&accent_device);
+}
+
+module_init(accent_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("8250 serial probe module for Accent Async cards");
+MODULE_LICENSE("GPL");
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250_boca.c linux/drivers/serial/8250_boca.c
--- orig/drivers/serial/8250_boca.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/serial/8250_boca.c	Wed May  4 13:31:09 2005
@@ -0,0 +1,61 @@
+/*
+ *  linux/drivers/serial/8250_boca.c
+ *
+ *  Copyright (C) 2005 Russell King.
+ *  Data taken from include/asm-i386/serial.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#define PORT(_base,_irq)				\
+	{						\
+		.iobase		= _base,		\
+		.irq		= _irq,			\
+		.uartclk	= 1843200,		\
+		.iotype		= UPIO_PORT,		\
+		.flags		= UPF_BOOT_AUTOCONF,	\
+	}
+
+static struct plat_serial8250_port boca_data[] = {
+	PORT(0x100, 12),
+	PORT(0x108, 12),
+	PORT(0x110, 12),
+	PORT(0x118, 12),
+	PORT(0x120, 12),
+	PORT(0x128, 12),
+	PORT(0x130, 12),
+	PORT(0x138, 12),
+	PORT(0x140, 12),
+	PORT(0x148, 12),
+	PORT(0x150, 12),
+	PORT(0x158, 12),
+	PORT(0x160, 12),
+	PORT(0x168, 12),
+	PORT(0x170, 12),
+	PORT(0x178, 12),
+	{ },
+};
+
+static struct platform_device boca_device = {
+	.name			= "serial8250",
+	.id			= 3,
+	.dev			= {
+		.platform_data	= boca_data,
+	},
+};
+
+static int __init boca_init(void)
+{
+	return platform_device_register(&boca_device);
+}
+
+module_init(boca_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("8250 serial probe module for Boca cards");
+MODULE_LICENSE("GPL");
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250_fourport.c linux/drivers/serial/8250_fourport.c
--- orig/drivers/serial/8250_fourport.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/serial/8250_fourport.c	Wed May  4 13:31:09 2005
@@ -0,0 +1,53 @@
+/*
+ *  linux/drivers/serial/8250_fourport.c
+ *
+ *  Copyright (C) 2005 Russell King.
+ *  Data taken from include/asm-i386/serial.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#define PORT(_base,_irq)						\
+	{								\
+		.iobase		= _base,				\
+		.irq		= _irq,					\
+		.uartclk	= 1843200,				\
+		.iotype		= UPIO_PORT,				\
+		.flags		= UPF_BOOT_AUTOCONF | UPF_FOURPORT,	\
+	}
+
+static struct plat_serial8250_port fourport_data[] = {
+	PORT(0x1a0, 9),
+	PORT(0x1a8, 9),
+	PORT(0x1b0, 9),
+	PORT(0x1b8, 9),
+	PORT(0x2a0, 5),
+	PORT(0x2a8, 5),
+	PORT(0x2b0, 5),
+	PORT(0x2b8, 5),
+	{ },
+};
+
+static struct platform_device fourport_device = {
+	.name			= "serial8250",
+	.id			= 1,
+	.dev			= {
+		.platform_data	= fourport_data,
+	},
+};
+
+static int __init fourport_init(void)
+{
+	return platform_device_register(&fourport_device);
+}
+
+module_init(fourport_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("8250 serial probe module for AST Fourport cards");
+MODULE_LICENSE("GPL");
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250_hub6.c linux/drivers/serial/8250_hub6.c
--- orig/drivers/serial/8250_hub6.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/serial/8250_hub6.c	Wed May  4 13:31:09 2005
@@ -0,0 +1,58 @@
+/*
+ *  linux/drivers/serial/8250_hub6.c
+ *
+ *  Copyright (C) 2005 Russell King.
+ *  Data taken from include/asm-i386/serial.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#define HUB6(card,port)							\
+	{								\
+		.iobase		= 0x302,				\
+		.irq		= 3,					\
+		.uartclk	= 1843200,				\
+		.iotype		= UPIO_HUB6,				\
+		.flags		= UPF_BOOT_AUTOCONF,			\
+		.hub6		= (card) << 6 | (port) << 3 | 1,	\
+	}
+
+static struct plat_serial8250_port hub6_data[] = {
+	HUB6(0,0),
+	HUB6(0,1),
+	HUB6(0,2),
+	HUB6(0,3),
+	HUB6(0,4),
+	HUB6(0,5),
+	HUB6(1,0),
+	HUB6(1,1),
+	HUB6(1,2),
+	HUB6(1,3),
+	HUB6(1,4),
+	HUB6(1,5),
+	{ },
+};
+
+static struct platform_device hub6_device = {
+	.name			= "serial8250",
+	.id			= 4,
+	.dev			= {
+		.platform_data	= hub6_data,
+	},
+};
+
+static int __init hub6_init(void)
+{
+	return platform_device_register(&hub6_device);
+}
+
+module_init(hub6_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("8250 serial probe module for Hub6 cards");
+MODULE_LICENSE("GPL");
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/8250_mca.c linux/drivers/serial/8250_mca.c
--- orig/drivers/serial/8250_mca.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/serial/8250_mca.c	Wed May  4 13:31:09 2005
@@ -0,0 +1,64 @@
+/*
+ *  linux/drivers/serial/8250_mca.c
+ *
+ *  Copyright (C) 2005 Russell King.
+ *  Data taken from include/asm-i386/serial.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mca.h>
+#include <linux/serial_8250.h>
+
+/*
+ * FIXME: Should we be doing AUTO_IRQ here?
+ */
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
+#define MCA_FLAGS	UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ
+#else
+#define MCA_FLAGS	UPF_BOOT_AUTOCONF | UPF_SKIP_TEST
+#endif
+
+#define PORT(_base,_irq)			\
+	{					\
+		.iobase		= _base,	\
+		.irq		= _irq,		\
+		.uartclk	= 1843200,	\
+		.iotype		= UPIO_PORT,	\
+		.flags		= MCA_FLAGS,	\
+	}
+
+static struct plat_serial8250_port mca_data[] = {
+	PORT(0x3220, 3),
+	PORT(0x3228, 3),
+	PORT(0x4220, 3),
+	PORT(0x4228, 3),
+	PORT(0x5220, 3),
+	PORT(0x5228, 3),
+	{ },
+};
+
+static struct platform_device mca_device = {
+	.name			= "serial8250",
+	.id			= 5,
+	.dev			= {
+		.platform_data	= mca_data,
+	},
+};
+
+static int __init mca_init(void)
+{
+	if (!MCA_bus)
+		return -ENODEV;
+	return platform_device_register(&mca_device);
+}
+
+module_init(mca_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("8250 serial probe module for MCA ports");
+MODULE_LICENSE("GPL");
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git orig/drivers/serial/Kconfig linux/drivers/serial/Kconfig
--- orig/drivers/serial/Kconfig	Sun May  1 08:07:54 2005
+++ linux/drivers/serial/Kconfig	Wed May  4 13:38:46 2005
@@ -89,11 +89,11 @@ config SERIAL_8250_NR_UARTS
 	int "Maximum number of non-legacy 8250/16550 serial ports"
 	depends on SERIAL_8250
 	default "4"
-	---help---
-	  Set this to the number of non-legacy serial ports you want
-	  the driver to support.  This includes any ports discovered
-	  via ACPI or PCI enumeration and any ports that may be added
-	  at run-time via hot-plug.
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.  This includes any ports discovered via ACPI or
+	  PCI enumeration and any ports that may be added at run-time
+	  via hot-plug, or any ISA multi-port serial cards.
 
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
@@ -141,31 +141,74 @@ config SERIAL_8250_DETECT_IRQ
 
 	  If unsure, say N.
 
-config SERIAL_8250_MULTIPORT
-	bool "Support special multiport boards"
-	depends on SERIAL_8250_EXTENDED
-	help
-	  Some multiport serial ports have special ports which are used to
-	  signal when there are any serial ports on the board which need
-	  servicing. Say Y here to enable the serial driver to take advantage
-	  of those special I/O ports.
-
 config SERIAL_8250_RSA
 	bool "Support RSA serial ports"
 	depends on SERIAL_8250_EXTENDED
 	help
 	  ::: To be written :::
 
-comment "Non-8250 serial port support"
+#
+# Multi-port serial cards
+#
+
+config SERIAL_8250_FOURPORT
+	tristate "Support Fourport cards"
+	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	help
+	  Say Y here if you have an AST FourPort serial board.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_fourport.
+
+config SERIAL_8250_ACCENT
+	tristate "Support Accent cards"
+	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	help
+	  Say Y here if you have an Accent Async serial board.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_accent.
+
+
+config SERIAL_8250_BOCA
+	tristate "Support Boca cards"
+	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	help
+	  Say Y here if you have a Boca serial board.  Please read the Boca
+	  mini-HOWTO, avaialble from <http://www.tldp.org/docs.html#howto>
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_boca.
+
+
+config SERIAL_8250_HUB6
+	tristate "Support Hub6 cards"
+	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	help
+	  Say Y here if you have a HUB6 serial board.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_hub6.
+
+config SERIAL_8250_MCA
+	tristate "Support 8250-type ports on MCA buses"
+	depends on SERIAL_8250 != n && MCA
+	help
+	  Say Y here if you have a MCA serial ports.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_mca.
 
 config SERIAL_8250_ACORN
 	tristate "Acorn expansion card serial port support"
-	depends on ARM && ARCH_ACORN && SERIAL_8250
+	depends on ARCH_ACORN && SERIAL_8250
 	help
 	  If you have an Atomwide Serial card or Serial Port card for an Acorn
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+comment "Non-8250 serial port support"
+
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
 	depends on ARM_AMBA
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/serial/Makefile linux/drivers/serial/Makefile
--- orig/drivers/serial/Makefile	Sun May  1 08:07:54 2005
+++ linux/drivers/serial/Makefile	Wed May  4 11:23:11 2005
@@ -17,6 +17,11 @@ obj-$(CONFIG_SERIAL_8250) += 8250.o $(se
 obj-$(CONFIG_SERIAL_8250_CS) += serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
 obj-$(CONFIG_SERIAL_8250_CONSOLE) += 8250_early.o
+obj-$(CONFIG_SERIAL_8250_FOURPORT) += 8250_fourport.o
+obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250_accent.o
+obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
+obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
+obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git orig/include/linux/serial_8250.h linux/include/linux/serial_8250.h
--- orig/include/linux/serial_8250.h	Sun May  1 08:11:18 2005
+++ linux/include/linux/serial_8250.h	Wed May  4 12:31:24 2005
@@ -22,6 +22,7 @@ struct plat_serial8250_port {
 	unsigned int	uartclk;	/* UART clock rate */
 	unsigned char	regshift;	/* register shift */
 	unsigned char	iotype;		/* UPIO_* */
+	unsigned char	hub6;
 	unsigned int	flags;		/* UPF_* flags */
 };
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
