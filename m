Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUHPNHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUHPNHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHPNGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:06:35 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:1800
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267608AbUHPNEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:04:05 -0400
Date: Mon, 16 Aug 2004 06:04:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Juha Yrjola <juha.yrjola@nokia.com>
Subject: [PATCH 2/2]: Serial 8250 OMAP support
Message-ID: <20040816130403.GF11621@atomide.com>
References: <20040816125702.GE11621@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040816125702.GE11621@atomide.com>
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following patch adds OMAP support to the 8250 serial driver.


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename="patch-2.6.8.1-8250-serial-add-omap-support"
Content-Transfer-Encoding: 8bit

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2004-08-16 05:15:36 -07:00
+++ b/drivers/serial/8250.c	2004-08-16 05:15:36 -07:00
@@ -173,6 +173,7 @@
 	{ "RSA",	2048,	UART_CLEAR_FIFO | UART_USE_FIFO },
 	{ "NS16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_NATSEMI },
 	{ "XScale",	32,	UART_CLEAR_FIFO | UART_USE_FIFO  },
+	{ "OMAP UART",	64,	UART_CLEAR_FIFO | UART_USE_FIFO | UART_STARTECH }
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -1215,6 +1216,28 @@
 		serial_outp(up, UART_LCR, 0);
 	}
 
+#ifdef CONFIG_ARCH_OMAP
+       if (up->port.type == PORT_OMAP) {
+                serial_outp(up, UART_OMAP_MDR1, 0x07); /* disable UART */
+                serial_outp(up, UART_LCR, 0xBF);       /* select EFR */
+                serial_outp(up, UART_EFR, UART_EFR_ECB);
+                serial_outp(up, UART_LCR, UART_LCR_DLAB); /* set DLAB */
+                serial_outp(up, UART_DLL, 0x00);
+                serial_outp(up, UART_DLM, 0x00);
+                serial_outp(up, UART_LCR, 0x00);       /* reset DLAB */
+                serial_outp(up, UART_OMAP_SCR, 0x08);
+                serial_outp(up, UART_FCR, 0x00);
+                serial_outp(up, UART_MCR, 0x40);       /* enable TCR/TLR */
+                serial_outp(up, UART_OMAP_TCR, 0x0F);
+                serial_outp(up, UART_OMAP_TLR, 0x00);
+                serial_outp(up, UART_MCR, 0x00);
+                serial_outp(up, UART_LCR, 0xBF);       /* select EFR */
+                serial_outp(up, UART_EFR, 0x00);
+                serial_outp(up, UART_LCR, 0x00);       /* reset DLAB */
+                serial_outp(up, UART_OMAP_MDR1, 0x00); /* enable UART */
+        }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -1447,6 +1470,10 @@
 		else if (up->port.type == PORT_RSA)
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;
 #endif
+#ifdef CONFIG_ARCH_OMAP
+		else if (up->port.type == PORT_OMAP)
+			fcr = UART_FCR_T_TRIGGER_56 | UART_FCR_R_TRIGGER_60 | UART_FCR_ENABLE_FIFO;
+#endif
 		else
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
 	}
@@ -1519,6 +1546,16 @@
 		serial_outp(up, UART_EFR,
 			    termios->c_cflag & CRTSCTS ? UART_EFR_CTS :0);
 	}
+
+#ifdef CONFIG_ARCH_OMAP1510	/* Needed for 1510 only */
+        if (up->port.type == PORT_OMAP && cpu_is_omap1510()) {
+		if (baud == 115200) {
+			quot = 1;
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 1);
+		} else
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 0);
+        }
+#endif
 
 	if (up->capabilities & UART_NATSEMI) {
 		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
diff -Nru a/drivers/serial/8250_omap.c b/drivers/serial/8250_omap.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/8250_omap.c	2004-08-16 05:15:36 -07:00
@@ -0,0 +1,125 @@
+/*
+ *  linux/drivers/serial/8250_omap.c
+ *  Partially copied from 8250_acorn.c
+ *
+ *  Copyright (C) 1996-2003 Russell King.
+ *  Copyright (C) 2004 Nokia Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/tty.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/arch/serial.h>
+#include <asm/string.h>
+
+#define UART_SYSC       0x15
+
+#define MAX_PORTS       3
+
+struct omap_serial_port {
+	unsigned long baddr;
+	unsigned int irq;
+};
+
+static const struct omap_serial_port omap1510_serial_ports[] = {
+	{ .baddr = (unsigned long)IO_ADDRESS(OMAP_UART1_BASE), .irq = INT_UART1 },
+	{ .baddr = (unsigned long)IO_ADDRESS(OMAP_UART2_BASE), .irq = INT_UART2 },
+	{ .baddr = (unsigned long)IO_ADDRESS(OMAP_UART3_BASE), .irq = INT_UART3 },
+};
+
+static const struct omap_serial_port omap730_serial_ports[] = {
+	{ .baddr = (unsigned long)IO_ADDRESS(OMAP_UART1_BASE), .irq = INT_730_UART_MODEM_1 },
+	{ .baddr = (unsigned long)IO_ADDRESS(OMAP_UART2_BASE), .irq = INT_730_UART_MODEM_IRDA_2 },
+};
+
+static void
+reset_port(struct serial_struct *port)
+{
+	if (cpu_is_omap1510())
+		return;
+	writeb(0x01, port->iomap_base + (UART_SYSC << port->iomem_reg_shift));
+	while (!(readb(port->iomap_base + (UART_SYSC << port->iomem_reg_shift)) & 0x01));
+}
+
+static inline int
+serial_register_onedev(const struct omap_serial_port *port)
+{
+	struct serial_struct req;
+
+	memset(&req, 0, sizeof(req));
+	req.type                = PORT_OMAP;
+	req.irq			= port->irq;
+	req.flags		= UPF_SKIP_TEST;
+	req.io_type		= UPIO_MEM;
+	req.iomem_base		= (unsigned char *) port->baddr;
+	req.iomap_base		= port->baddr;
+
+	if (cpu_is_omap1510()) {
+		req.baud_base		= OMAP1510_BASE_BAUD;
+		req.iomem_reg_shift	= 2;
+	}
+	if (cpu_is_omap1610() || cpu_is_omap5912() || cpu_is_omap1710()) {
+		req.baud_base		= OMAP1610_BASE_BAUD;
+		req.iomem_reg_shift	= 2;
+	}
+	if (cpu_is_omap730()) {
+		req.baud_base		= OMAP1610_BASE_BAUD;
+		req.iomem_reg_shift	= 0;
+	}
+
+        reset_port(&req);
+
+	return register_serial(&req);
+}
+
+static int port_count = 0;
+static int ports[MAX_PORTS];
+
+static int __init omap_serial_init(void)
+{
+	int i;
+	const struct omap_serial_port *port_table = NULL;
+	
+	if (cpu_is_omap1510() || cpu_is_omap1610() || cpu_is_omap5912()
+						   || cpu_is_omap1710()) {
+		port_count = 3;
+		port_table = omap1510_serial_ports;
+	}
+	if (cpu_is_omap730()) {
+		port_count = 2;
+		port_table = omap730_serial_ports;
+	}
+	for (i = 0; i < port_count; i++) {
+		ports[i] = serial_register_onedev(&port_table[i]);
+	}
+	printk(KERN_INFO "OMAP serial: activated %d ports\n", i);
+
+	return 0;
+}
+
+static void __exit omap_serial_exit(void)
+{
+	int i;
+
+	for (i = 0; i < port_count; i++)
+		unregister_serial(ports[i]);
+}
+
+MODULE_AUTHOR("Juha Yrjölä");
+MODULE_DESCRIPTION("OMAP 8250-compatible serial port driver");
+MODULE_LICENSE("GPL");
+
+module_init(omap_serial_init);
+module_exit(omap_serial_exit);
diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	2004-08-16 05:15:36 -07:00
+++ b/drivers/serial/Kconfig	2004-08-16 05:15:36 -07:00
@@ -166,6 +166,13 @@
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_OMAP
+	tristate "OMAP serial port support"
+	depends on ARM && ARCH_OMAP && SERIAL_8250
+	help
+	  Say Y or M here if you want to use the integrated UARTs of the TI
+	  OMAP multimedia processor.
+
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
 	depends on ARM_AMBA
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	2004-08-16 05:15:36 -07:00
+++ b/drivers/serial/Makefile	2004-08-16 05:15:36 -07:00
@@ -15,6 +15,7 @@
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
 obj-$(CONFIG_SERIAL_8250_CS) += serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
+obj-$(CONFIG_SERIAL_8250_OMAP) += 8250_omap.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
diff -Nru a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h	2004-08-16 05:15:36 -07:00
+++ b/include/linux/serial_core.h	2004-08-16 05:15:36 -07:00
@@ -37,7 +37,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_OMAP	16
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff -Nru a/include/linux/serial_reg.h b/include/linux/serial_reg.h
--- a/include/linux/serial_reg.h	2004-08-16 05:15:36 -07:00
+++ b/include/linux/serial_reg.h	2004-08-16 05:15:36 -07:00
@@ -294,5 +294,21 @@
 #define SERIAL_RSA_BAUD_BASE (921600)
 #define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
 
+/*
+ * Extra serial register definitions for the internal UARTs 
+ * in TI OMAP processors.
+ */
+#define UART_OMAP_TCR		0x06	/* Transmission control register */
+#define UART_OMAP_TLR		0x07	/* Trigger level register */
+#define UART_OMAP_MDR1		0x08	/* Mode definition register */
+#define UART_OMAP_MDR2		0x09	/* Mode definition register 2 */
+#define UART_OMAP_SCR		0x10	/* Supplementary control register */
+#define UART_OMAP_SSR		0x11	/* Supplementary status register */
+#define UART_OMAP_EBLR		0x12	/* BOF length register */
+#define UART_OMAP_OSC_12M_SEL	0x13	/* OMAP1510 12MHz osc select */
+#define UART_OMAP_MVER		0x14	/* Module version register */
+#define UART_OMAP_SYSC		0x15	/* System configuration register */
+#define UART_OMAP_SYSS		0x16	/* System status register */
+
 #endif /* _LINUX_SERIAL_REG_H */
 

--qcHopEYAB45HaUaB--
