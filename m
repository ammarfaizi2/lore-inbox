Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbUJ1TwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUJ1TwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUJ1Tuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:50:40 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:35546 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261866AbUJ1TrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:47:15 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] early uart console support
Date: Thu, 28 Oct 2004 13:47:10 -0600
User-Agent: KMail/1.7
Cc: Russell King <rmk@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+yUgBtM/m0yM99n"
Message-Id: <200410281347.10784.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+yUgBtM/m0yM99n
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This adds an early polled-mode "uart" console driver, based on Andi
Kleen's early_printk work.

The difference is that this locates the UART device directly by its
MMIO or I/O port address, so we don't have to make assumptions about
how ttyS devices will be named.  After the normal serial driver
starts, we try to locate the matching ttyS device and start a console
there.

Sample usage:
    console=uart,io,0x3f8
    console=uart,mmio,0xff5e0000,115200n8

If the baud rate isn't specified, we peek at the UART to figure it
out.

--Boundary-00=_+yUgBtM/m0yM99n
Content-Type: text/x-diff;
  charset="us-ascii";
  name="early-uart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="early-uart.patch"

This adds an early polled-mode "uart" console driver, based on Andi
Kleen's early_printk work.

The difference is that this locates the UART device directly by its
MMIO or I/O port address, so we don't have to make assumptions about
how ttyS devices will be named.  After the normal serial driver
starts, we try to locate the matching ttyS device and start a console
there.

Sample usage:
    console=uart,io,0x3f8
    console=uart,mmio,0xff5e0000,115200n8

If the baud rate isn't specified, we peek at the UART to figure it
out.

 Documentation/kernel-parameters.txt |   20 ++
 drivers/serial/8250.c               |   35 ++++
 drivers/serial/8250_early.c         |  255 ++++++++++++++++++++++++++++++++++++
 drivers/serial/Makefile             |    1 
 include/linux/serial.h              |    2 
 kernel/printk.c                     |    2 
 6 files changed, 312 insertions(+), 3 deletions(-)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -urN 2.6.10-rc1-mm1/Documentation/kernel-parameters.txt 2.6.10-rc1-mm1-uart/Documentation/kernel-parameters.txt
--- 2.6.10-rc1-mm1/Documentation/kernel-parameters.txt	2004-10-28 13:01:52.196670988 -0600
+++ 2.6.10-rc1-mm1-uart/Documentation/kernel-parameters.txt	2004-10-28 13:03:57.057021021 -0600
@@ -311,8 +311,24 @@
 	condev=		[HW,S390] console device
 	conmode=
  
-	console=	[KNL] Output console
-			Console device and comm spec (speed, control, parity).
+	console=	[KNL] Output console device and options.
+
+		tty<n>	Use the virtual console device <n>.
+
+		ttyS<n>[,options]
+			Use the specified serial port.  The options are of
+			the form "bbbbpn", where "bbbb" is the baud rate,
+			"p" is parity ("n", "o", or "e"), and "n" is bits.
+			Default is "9600n8".
+			
+			See also Documentation/serial-console.txt.
+
+		uart,io,<addr>[,options]
+		uart,mmio,<addr>[,options]
+			Start an early, polled-mode console on the 8250/16550
+			UART at the specified I/O port or MMIO address,
+			switching to the matching ttyS device later.  The
+			options are the same as for ttyS, above.
 
 	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
 			Format: <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
diff -u -urN 2.6.10-rc1-mm1/drivers/serial/8250.c 2.6.10-rc1-mm1-uart/drivers/serial/8250.c
--- 2.6.10-rc1-mm1/drivers/serial/8250.c	2004-10-28 13:01:52.843155355 -0600
+++ 2.6.10-rc1-mm1-uart/drivers/serial/8250.c	2004-10-28 13:03:57.058974146 -0600
@@ -2226,6 +2226,41 @@
 }
 late_initcall(serial8250_late_console_init);
 
+static int __init find_port(struct uart_port *p)
+{
+	int line;
+	struct uart_port *port;
+
+	for (line = 0; line < UART_NR; line++) {
+		port = &serial8250_ports[line].port;
+		if (p->iotype == port->iotype &&
+		    p->iobase == port->iobase &&
+		    p->membase == port->membase)
+			return line;
+	}
+	return -ENODEV;
+}
+
+int __init serial8250_start_console(struct uart_port *port, char *options)
+{
+	int line;
+
+	line = find_port(port);
+	if (line < 0)
+		return -ENODEV;
+
+	add_preferred_console("ttyS", line, options);
+	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
+		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
+		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
+		    (unsigned long) port->iobase, options);
+	if (!(serial8250_console.flags & CON_ENABLED)) {
+		serial8250_console.flags &= ~CON_PRINTBUFFER;
+		register_console(&serial8250_console);
+	}
+	return line;
+}
+
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
 #define SERIAL8250_CONSOLE	NULL
diff -u -urN 2.6.10-rc1-mm1/drivers/serial/8250_early.c 2.6.10-rc1-mm1-uart/drivers/serial/8250_early.c
--- 2.6.10-rc1-mm1/drivers/serial/8250_early.c	1969-12-31 17:00:00.000000000 -0700
+++ 2.6.10-rc1-mm1-uart/drivers/serial/8250_early.c	2004-10-28 13:03:57.059950708 -0600
@@ -0,0 +1,255 @@
+/*
+ * Early serial console for 8250/16550 devices
+ *
+ * (c) Copyright 2004 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on the 8250.c serial driver, Copyright (C) 2001 Russell King,
+ * and on early_printk.c by Andi Kleen.
+ *
+ * This is for use before the serial driver has initialized, in
+ * particular, before the UARTs have been discovered and named.
+ * Instead of specifying the console device as, e.g., "ttyS0",
+ * we locate the device directly by its MMIO or I/O port address.
+ *
+ * The user can specify the device directly, e.g.,
+ *	console=uart,io,0x3f8,9600n8
+ *	console=uart,mmio,0xff5e0000,115200n8
+ * or platform code can call early_uart_console_init() to set
+ * the early UART device.
+ *
+ * After the normal serial driver starts, we try to locate the
+ * matching ttyS device and start a console there.
+ */
+
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/serial.h>
+#include <asm/io.h>
+#include <asm/serial.h>
+
+struct early_uart_device {
+	struct uart_port port;
+	char options[16];		/* e.g., 115200n8 */
+	unsigned int baud;
+};
+
+static struct early_uart_device early_device __initdata;
+static int early_uart_registered __initdata;
+
+static unsigned int __init serial_in(struct uart_port *port, int offset)
+{
+	if (port->iotype == UPIO_MEM)
+		return readb(port->membase + offset);
+	else 
+		return inb(port->iobase + offset);
+}
+
+static void __init serial_out(struct uart_port *port, int offset, int value)
+{
+	if (port->iotype == UPIO_MEM)
+		writeb(value, port->membase + offset);
+	else
+		outb(value, port->iobase + offset);
+}
+
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+static void __init wait_for_xmitr(struct uart_port *port)
+{
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in(port, UART_LSR);
+		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
+			return;
+		cpu_relax();
+	}
+}
+
+static void __init putc(struct uart_port *port, unsigned char c)
+{
+	wait_for_xmitr(port);
+	serial_out(port, UART_TX, c);
+}
+
+static void __init early_uart_write(struct console *console, const char *s, unsigned int count)
+{
+	struct uart_port *port = &early_device.port;
+	unsigned int ier;
+
+	/* Save the IER and disable interrupts */
+	ier = serial_in(port, UART_IER);
+	serial_out(port, UART_IER, 0);
+
+	while (*s && count-- > 0) {
+		putc(port, *s);
+		if (*s == '\n')
+			putc(port, '\r');
+		s++;
+	}
+
+	/* Wait for transmitter to become empty and restore the IER */
+	wait_for_xmitr(port);
+	serial_out(port, UART_IER, ier);
+}
+
+static unsigned int __init probe_baud(struct uart_port *port)
+{
+	unsigned char lcr, dll, dlm;
+	unsigned int quot;
+
+	lcr = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
+	dll = serial_in(port, UART_DLL);
+	dlm = serial_in(port, UART_DLM);
+	serial_out(port, UART_LCR, lcr);
+
+	quot = (dlm << 8) | dll;
+	return (port->uartclk / 16) / quot;
+}
+
+static void __init init_port(struct early_uart_device *device)
+{
+	struct uart_port *port = &device->port;
+	unsigned int divisor;
+	unsigned char c;
+
+	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial_out(port, UART_IER, 0);		/* no interrupt */
+	serial_out(port, UART_FCR, 0);		/* no fifo */
+	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+
+	divisor = port->uartclk / (16 * device->baud);
+	c = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
+	serial_out(port, UART_DLL, divisor & 0xff);
+	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+}
+
+static int __init parse_options(struct early_uart_device *device, char *options)
+{
+	struct uart_port *port = &device->port;
+	int mapsize = 64;
+	int mmio, length;
+
+	if (!options)
+		return -ENODEV;
+
+	port->uartclk = BASE_BAUD * 16;
+	if (!strncmp(options, "mmio,", 5)) {
+		port->iotype = UPIO_MEM;
+		port->mapbase = simple_strtoul(options + 5, &options, 0);
+		port->membase = ioremap(port->mapbase, mapsize);
+		if (!port->membase) {
+			printk(KERN_ERR "%s: Couldn't ioremap 0x%lx\n",
+				__FUNCTION__, port->mapbase);
+			return -ENOMEM;
+		}
+		mmio = 1;
+	} else if (!strncmp(options, "io,", 3)) {
+		port->iotype = UPIO_PORT;
+		port->iobase = simple_strtoul(options + 3, &options, 0);
+		mmio = 0;
+	} else
+		return -EINVAL;
+
+	if ((options = strchr(options, ','))) {
+		options++;
+		device->baud = simple_strtoul(options, 0, 0);
+		length = min(strcspn(options, " "), sizeof(device->options));
+		strncpy(device->options, options, length);
+	} else {
+		device->baud = probe_baud(port);
+		snprintf(device->options, sizeof(device->options), "%u",
+			device->baud);
+	}
+
+	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
+		mmio ? "MMIO" : "I/O port",
+		mmio ? port->mapbase : (unsigned long) port->iobase,
+		device->options);
+	return 0;
+}
+
+static int __init early_uart_setup(struct console *console, char *options)
+{
+	struct early_uart_device *device = &early_device;
+	int err;
+
+	if (device->port.membase || device->port.iobase)
+		return 0;
+
+	if ((err = parse_options(device, options)) < 0)
+		return err;
+
+	init_port(device);
+	return 0;
+}
+
+static struct console early_uart_console __initdata = {
+	.name	= "uart",
+	.write	= early_uart_write,
+	.setup	= early_uart_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+static int __init early_uart_console_init(void)
+{
+	if (!early_uart_registered) {
+		register_console(&early_uart_console);
+		early_uart_registered = 1;
+	}
+	return 0;
+}
+console_initcall(early_uart_console_init);
+
+int __init early_serial_console_init(char *cmdline)
+{
+	char *options;
+	int err;
+
+	options = strstr(cmdline, "console=uart,");
+	if (!options)
+		return -ENODEV;
+
+	options = strchr(cmdline, ',') + 1;
+	if ((err = early_uart_setup(NULL, options)) < 0)
+		return err;
+	return early_uart_console_init();
+}
+
+static int __init early_uart_console_switch(void)
+{
+	struct early_uart_device *device = &early_device;
+	struct uart_port *port = &device->port;
+	int mmio, line;
+
+	if (!(early_uart_console.flags & CON_ENABLED))
+		return 0;
+
+	/* Try to start the normal driver on a matching line.  */
+	mmio = (port->iotype == UPIO_MEM);
+	line = serial8250_start_console(port, device->options);
+	if (line < 0)
+		printk("No ttyS device at %s 0x%lx for console\n",
+			mmio ? "MMIO" : "I/O port",
+			mmio ? port->mapbase :
+			    (unsigned long) port->iobase);
+
+	unregister_console(&early_uart_console);
+	if (mmio)
+		iounmap(port->membase);
+
+	return 0;
+}
+late_initcall(early_uart_console_switch);
diff -u -urN 2.6.10-rc1-mm1/drivers/serial/Makefile 2.6.10-rc1-mm1-uart/drivers/serial/Makefile
--- 2.6.10-rc1-mm1/drivers/serial/Makefile	2004-10-28 13:01:43.912491402 -0600
+++ 2.6.10-rc1-mm1-uart/drivers/serial/Makefile	2004-10-28 13:03:57.059950708 -0600
@@ -15,6 +15,7 @@
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
 obj-$(CONFIG_SERIAL_8250_CS) += serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
+obj-$(CONFIG_SERIAL_8250_CONSOLE) += 8250_early.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
diff -u -urN 2.6.10-rc1-mm1/include/linux/serial.h 2.6.10-rc1-mm1-uart/include/linux/serial.h
--- 2.6.10-rc1-mm1/include/linux/serial.h	2004-10-28 13:01:53.603897533 -0600
+++ 2.6.10-rc1-mm1-uart/include/linux/serial.h	2004-10-28 13:03:57.060927271 -0600
@@ -182,6 +182,8 @@
 /* Allow architectures to override entries in serial8250_ports[] at run time: */
 struct uart_port;	/* forward declaration */
 extern int early_serial_setup(struct uart_port *port);
+extern int early_serial_console_init(char *options);
+extern int serial8250_start_console(struct uart_port *port, char *options);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
diff -u -urN 2.6.10-rc1-mm1/kernel/printk.c 2.6.10-rc1-mm1-uart/kernel/printk.c
--- 2.6.10-rc1-mm1/kernel/printk.c	2004-10-28 13:01:53.658585032 -0600
+++ 2.6.10-rc1-mm1-uart/kernel/printk.c	2004-10-28 13:03:57.061903833 -0600
@@ -142,7 +142,7 @@
 		strcpy(name, "ttyS1");
 #endif
 	for(s = name; *s; s++)
-		if (*s >= '0' && *s <= '9')
+		if ((*s >= '0' && *s <= '9') || *s == ',')
 			break;
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;

--Boundary-00=_+yUgBtM/m0yM99n--
