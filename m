Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUDAWEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDAWDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:03:48 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:20389 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262176AbUDAV6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:58:07 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] early serial console support
Date: Thu, 1 Apr 2004 14:58:04 -0700
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011458.04264.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds fairly generic early console support to the 8250 serial driver.

The current early_serial_setup() functionality is a bit of a problem for
ia64 because it assumes that you know where ttyS0 is before the driver
initializes.  On ia64, we don't know that because all the devices are
enumerated via ACPI and PCI.

However, we do have a firmware interface to tell us where the serial
console device is.  So this patch adds serial8250_early_console_setup()
so the architecture can specify the MMIO or I/O port address instead of
the ttyS0 device name.

After the serial driver initializes, we automatically try to locate
the corresponding ttyS device, and start up a console on that.

I'll post the corresponding ia64 changes that take advantage of these
as a response.  Feedback/comments welcome.

Bjorn


===== drivers/serial/8250.c 1.48 vs edited =====
--- 1.48/drivers/serial/8250.c	Mon Mar 15 15:16:26 2004
+++ edited/drivers/serial/8250.c	Thu Apr  1 14:31:04 2004
@@ -1882,6 +1882,7 @@
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
+static int serial8250_early_device(struct uart_port *);
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
@@ -1977,6 +1978,13 @@
 		return -ENODEV;
 
 	/*
+	 * No need to dump the buffer again if the port is already in
+	 * use as the early console device.
+	 */
+	if (serial8250_early_device(port))
+		co->flags &= ~CON_PRINTBUFFER;
+
+	/*
 	 * Temporary fix.
 	 */
 	spin_lock_init(&port->lock);
@@ -2013,6 +2021,166 @@
 	return 0;
 }
 late_initcall(serial8250_late_console_init);
+
+/*
+ * This is for use before the serial driver has initialized, in
+ * particular, before the UARTs have been discovered and named.
+ * Instead of specifying the console device as "ttyS0", platform
+ * code can call serial8250_early_console_setup() to specify it
+ * directly with an MMIO or I/O port address.
+ */
+static struct uart_8250_port serial8250_early_port __initdata;
+static char *serial8250_early_options __initdata;
+
+static void __init serial8250_early_putc(struct uart_8250_port *up, char c)
+{
+	while (!(UART_LSR_TEMT & serial_in(up, UART_LSR)))
+		;
+
+	serial_out(up, UART_TX, c);
+}
+
+/*
+ * Can't use serial8250_console_write() because delay() might not work yet.
+ */
+static void __init serial8250_early_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_8250_port *up = &serial8250_early_port;
+
+	while (*s && count-- > 0) {
+		serial8250_early_putc(up, *s);
+		if (*s == '\n')
+			serial8250_early_putc(up, '\r');
+		s++;
+	}
+}
+
+static struct console serial8250_early_console __initdata = {
+	.name	= "serial",
+	.write	= serial8250_early_write,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+static unsigned int __init serial8250_probe_baud(struct uart_8250_port *port)
+{
+	unsigned char lcr, dll, dlm;
+	unsigned int quot, baud;
+
+	lcr = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
+	dll = serial_in(port, UART_DLL);
+	dlm = serial_in(port, UART_DLM);
+	serial_out(port, UART_LCR, lcr);
+
+	quot = (dlm << 8) | dll;
+	baud = BASE_BAUD / quot;
+	return baud;
+}
+
+static void __init serial8250_early_init(struct uart_8250_port *port, unsigned int baud)
+{
+	unsigned char c;
+	unsigned int divisor;
+
+	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial_out(port, UART_IER, 0);		/* no interrupt */
+	serial_out(port, UART_FCR, 0);		/* no fifo */
+	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+
+	divisor = 115200 / baud;
+	c = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
+	serial_out(port, UART_DLL, divisor & 0xff);
+	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+}
+
+void __init serial8250_early_console_setup(struct uart_port *port, char *options)
+{
+	unsigned int baud = 9600;
+	static char probed_options[16];
+
+	serial8250_early_port.port = *port;
+	if (options) {
+		serial8250_early_options = options;
+		baud = simple_strtoul(options, 0, 0);
+	} else {
+		baud = serial8250_probe_baud(&serial8250_early_port);
+		snprintf(probed_options, sizeof(probed_options), "%u", baud);
+		serial8250_early_options = probed_options;
+	}
+	serial8250_early_init(&serial8250_early_port, baud);
+	printk("Early serial console at %s 0x%lx (options %s)\n",
+		port->iotype == SERIAL_IO_MEM ? "MMIO" : "I/O port",
+		port->iotype == SERIAL_IO_MEM ? (unsigned long) port->mapbase :
+		    (unsigned long) port->iobase,
+		serial8250_early_options);
+	register_console(&serial8250_early_console);
+}
+
+static int __init serial8250_early_device(struct uart_port *port)
+{
+	struct uart_port *early = &serial8250_early_port.port;
+
+	if (early->iotype == port->iotype &&
+	    early->iobase == port->iobase &&
+	    early->membase == port->membase)
+		return 1;
+	return 0;
+}
+
+static int __init serial8250_start_console(char *options)
+{
+	int line;
+	struct uart_port *port;
+
+	for (line = 0; line < UART_NR; line++) {
+		port = &serial8250_ports[line].port;
+		if (serial8250_early_device(port)) {
+			add_preferred_console("ttyS", line, options);
+			break;
+		}
+	}
+	if (line == UART_NR)
+		return -ENODEV;
+
+	printk("Starting serial console on ttyS%d at %s 0x%lx (options %s)\n",
+		line,
+		port->iotype == SERIAL_IO_MEM ? "MMIO" : "I/O port",
+		port->iotype == SERIAL_IO_MEM ? (unsigned long) port->mapbase :
+		(unsigned long) port->iobase,
+		options);
+	if (!(serial8250_console.flags & CON_ENABLED))
+		register_console(&serial8250_console);
+	return line;
+}
+
+static int __init serial8250_early_console_switch(void)
+{
+	struct uart_port *port = &serial8250_early_port.port;
+	int line;
+
+	if (!(serial8250_early_console.flags & CON_ENABLED))
+		return 0;
+
+	/* Try to start the normal driver on a matching line.  */
+	line = serial8250_start_console(serial8250_early_options);
+	if (line < 0)
+		printk("No ttyS device at %s 0x%lx for console\n",
+			port->iotype == SERIAL_IO_MEM ?  "MMIO" : "I/O port",
+			port->iotype == SERIAL_IO_MEM ?
+			    (unsigned long) port->mapbase :
+			    (unsigned long) port->iobase);
+
+	unregister_console(&serial8250_early_console);
+	if (line >= 0)
+		if (port->iotype == SERIAL_IO_MEM)
+			iounmap(port->membase);
+
+	return 0;
+}
+late_initcall(serial8250_early_console_switch);
 
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
===== drivers/serial/8250_hcdp.c 1.3 vs edited =====
--- 1.3/drivers/serial/8250_hcdp.c	Mon Mar 15 15:53:32 2004
+++ edited/drivers/serial/8250_hcdp.c	Thu Apr  1 14:31:04 2004
@@ -1,8 +1,9 @@
 /*
- * linux/drivers/char/hcdp_serial.c
+ * EFI HCDP support
  *
- * Copyright (C) 2002 Hewlett-Packard Co.
+ * Copyright (C) 2002, 2004 Hewlett-Packard Co.
  *	Khalid Aziz <khalid_aziz@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
  * Parse the EFI HCDP table to locate serial console and debug ports and
  * initialize them.
@@ -10,19 +11,19 @@
  * 2002/08/29 davidm	Adjust it to new 2.5 serial driver infrastructure.
  */
 
-#include <linux/config.h>
+#include <linux/acpi.h>
+#include <linux/console.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/string.h>
 #include <linux/types.h>
-#include <linux/acpi.h>
 
 #include <asm/io.h>
 #include <asm/serial.h>
-#include <asm/acpi.h>
 
 #include "8250_hcdp.h"
 
@@ -203,6 +204,50 @@
 #ifdef SERIAL_DEBUG_HCDP
 	printk("Leaving setup_serial_hcdp()\n");
 #endif
+}
+
+void __init
+setup_hcdp_console(hcdp_t *hcdp, char *cmdline)
+{
+	hcdp_dev_t *dev;
+	unsigned long iobase;
+	struct uart_port port;
+	static char options[16];
+	int i;
+
+	if (!hcdp)
+		return;
+
+	/*
+	 * The presence of an HCDP entry does not imply that we should
+	 * use a serial console.
+	 */
+	if (!strstr(cmdline, "console=serial"))
+		return;
+
+	memset(&port, 0, sizeof(port));
+
+	for (i = 0; i < hcdp->num_entries; i++) {
+		dev = hcdp->hcdp_dev + i;
+		if (dev->type != HCDP_DEV_CONSOLE)
+			continue;
+
+		iobase = (u64) dev->base_addr.addrhi << 32 | dev->base_addr.addrlo;
+		if (dev->base_addr.space_id == ACPI_MEM_SPACE) {
+			port.mapbase = iobase;
+			port.membase = ioremap(iobase, 64);
+			port.iotype = SERIAL_IO_MEM;
+		} else if (dev->base_addr.space_id == ACPI_IO_SPACE) {
+			port.iobase = iobase;
+			port.iotype = SERIAL_IO_PORT;
+		} else
+			return;
+
+		snprintf(options, sizeof(options), "%lun%d", dev->baud,
+			dev->bits ? dev->bits : 8);
+		serial8250_early_console_setup(&port, options);
+		return;
+	}
 }
 
 #ifdef CONFIG_IA64_EARLY_PRINTK_UART
===== include/linux/serial.h 1.11 vs edited =====
--- 1.11/include/linux/serial.h	Thu Feb 26 04:26:01 2004
+++ edited/include/linux/serial.h	Thu Apr  1 14:31:05 2004
@@ -181,6 +181,7 @@
 /* Allow architectures to override entries in serial8250_ports[] at run time: */
 struct uart_port;	/* forward declaration */
 extern int early_serial_setup(struct uart_port *port);
+extern void serial8250_early_console_setup(struct uart_port *port, char *options);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
