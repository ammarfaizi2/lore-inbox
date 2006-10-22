Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWJVUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWJVUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJVUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:30:56 -0400
Received: from smtp1.enomia.com ([64.128.160.11]:9531 "EHLO smtp1.enomia.com")
	by vger.kernel.org with ESMTP id S1751420AbWJVUaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:30:55 -0400
Subject: Re: [PATCH] Exar quad port serial
From: Paul B Schroeder <pschroeder@uplogix.com>
Reply-To: pschroeder@uplogix.com
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061018133430.GU30991@csclub.uwaterloo.ca>
References: <1160068402.29393.7.camel@rupert>
	 <20061005173628.GB30993@csclub.uwaterloo.ca> <45357CA1.80706@uplogix.com>
	 <20061018133430.GU30991@csclub.uwaterloo.ca>
Content-Type: text/plain
Organization: Uplogix, Inc.
Date: Sun, 22 Oct 2006 15:30:45 -0500
Message-Id: <1161549045.16482.3.camel@rupert>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-CTCH-ID: _16B2DEF3-E0AE-415C-85D2-641185C139C9_
X-CTCH-RefID: str=0001.0A090205.453BD47B.0098,ss=1,fgs=0
X-CTCH-Action: Ignore
X-OriginalArrivalTime: 22 Oct 2006 20:30:52.0833 (UTC) FILETIME=[F813C110:01C6F618]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 09:34 -0400, Lennart Sorensen wrote:
> I suspect all you have to do might be to change how many ports it looks
> for.  The default max ports is 4 I believe on many kernel versions.
> 
> Look for CONFIG_SERIAL_8250_NR_UARTS and
> CONFIG_SERIAL_8250_RUNTIME_UARTS in the kernel config.
> 
> If that doesn't work and you do need a special driver, at least label it
> with more detail like 'for exar st16c554 quad uart' or 'for envoy board'
> or whatever makes it clear which hardware it is for.  I use exar pci
> uarts (exar XR17d15[248] chips) which work fine already with the 8250
> driver, or optionally with the jsm driver with a small change to the
> list if pci identifiers.  THey of course would not work with your driver
> since they are completely different exar chips (even though one is also
> a quad uart, although 64byte fifo).

Okay..  Here it is again with a little more detail:

----------------------------------------------------
diff -urN linux-2.6.19-rc2.orig/drivers/serial/8250_exar_st16c554.c linux-2.6.19-rc2/drivers/serial/8250_exar_st16c554.c
--- linux-2.6.19-rc2.orig/drivers/serial/8250_exar_st16c554.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.19-rc2/drivers/serial/8250_exar_st16c554.c	2006-10-22 14:58:55.000000000 -0500
@@ -0,0 +1,52 @@
+/*
+ *  linux/drivers/serial/8250_exar.c
+ *
+ *  Written by Paul B Schroeder < pschroeder "at" uplogix "dot" com >
+ *  Based on 8250_boca.
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
+static struct plat_serial8250_port exar_data[] = {
+	PORT(0x100, 5),
+	PORT(0x108, 5),
+	PORT(0x110, 5),
+	PORT(0x118, 5),
+	{ },
+};
+
+static struct platform_device exar_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_EXAR,
+	.dev			= {
+		.platform_data	= exar_data,
+	},
+};
+
+static int __init exar_init(void)
+{
+	return platform_device_register(&exar_device);
+}
+
+module_init(exar_init);
+
+MODULE_AUTHOR("Paul B Schroeder");
+MODULE_DESCRIPTION("8250 serial probe module for Exar cards");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.19-rc2.orig/drivers/serial/Kconfig linux-2.6.19-rc2/drivers/serial/Kconfig
--- linux-2.6.19-rc2.orig/drivers/serial/Kconfig	2006-10-13 11:25:04.000000000 -0500
+++ linux-2.6.19-rc2/drivers/serial/Kconfig	2006-10-22 15:13:03.000000000 -0500
@@ -210,6 +210,17 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_boca.
 
+config SERIAL_8250_EXAR_ST16C554
+	tristate "Support Exar ST16C554/554D Quad UART"
+	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
+	help
+	  The Uplogix Envoy TU301 uses this Exar Quad UART.  If you are
+	  tinkering with your Envoy TU301, or have a machine with this UART,
+	  say Y here.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_exar_st16c554.
+
 config SERIAL_8250_HUB6
 	tristate "Support Hub6 cards"
 	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
diff -urN linux-2.6.19-rc2.orig/drivers/serial/Makefile linux-2.6.19-rc2/drivers/serial/Makefile
--- linux-2.6.19-rc2.orig/drivers/serial/Makefile	2006-10-13 11:25:04.000000000 -0500
+++ linux-2.6.19-rc2/drivers/serial/Makefile	2006-10-22 15:14:11.000000000 -0500
@@ -17,6 +17,7 @@
 obj-$(CONFIG_SERIAL_8250_FOURPORT) += 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
+obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554) += 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
 obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
diff -urN linux-2.6.19-rc2.orig/include/linux/serial_8250.h linux-2.6.19-rc2/include/linux/serial_8250.h
--- linux-2.6.19-rc2.orig/include/linux/serial_8250.h	2006-10-13 11:25:04.000000000 -0500
+++ linux-2.6.19-rc2/include/linux/serial_8250.h	2006-10-22 15:15:15.000000000 -0500
@@ -41,6 +41,7 @@
 	PLAT8250_DEV_FOURPORT,
 	PLAT8250_DEV_ACCENT,
 	PLAT8250_DEV_BOCA,
+	PLAT8250_DEV_EXAR_ST16C554,
 	PLAT8250_DEV_HUB6,
 	PLAT8250_DEV_MCA,
 	PLAT8250_DEV_AU1X00,

----------------------------------------------------

Cheers...Paul...

