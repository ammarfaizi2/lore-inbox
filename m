Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUCEWnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUCEWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:43:13 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:33173 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261395AbUCEWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:43:07 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Serial console transition hook
Date: Fri, 5 Mar 2004 15:43:02 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051543.02700.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another piece of serial console support.  In general,
we don't know the (device -> ttySN) mapping until the serial
driver is initialized, so we really can't make "console=ttySN"
work early.

The idea here is that early platform code can discover the
serial console device (on IA64, this comes from firmware),
set up an early console on it, then transparently switch to
using the normal serial console driver after it is initialized.

This hook allows the platform code to supply the UART info,
and we match it to a ttySN, register that as a console, and
return N.  The platform code may need to export N to userland
so it can figure out where to start a getty on the console.
(Currently we insert the correct "console=ttySN" string in
saved_command_line[] so it shows up in /proc/cmdline, for
lack of a better approach.)

This is against 2.6.4-rc1 plus the previous late console init
patch (no dependency, just happens to be adjacent in the source).

===== drivers/serial/8250.c 1.46 vs edited =====
--- 1.46/drivers/serial/8250.c	Fri Mar  5 15:00:38 2004
+++ edited/drivers/serial/8250.c	Fri Mar  5 15:04:23 2004
@@ -2017,6 +2017,29 @@
 }
 late_initcall(serial8250_late_console_init);
 
+int __init serial8250_start_console(struct uart_port *port, char *options)
+{
+	struct uart_port *up;
+	int i;
+
+	for (i = 0; i < UART_NR; i++) {
+		up = &serial8250_ports[i].port;
+		if (up->iotype == port->iotype &&up->iobase == port->iobase &&
+		    up->membase == port->membase) {
+			add_preferred_console("ttyS", i, options);
+			break;
+		}
+	}
+	if (i == UART_NR)
+		return -ENODEV;
+
+	if (!(serial8250_console.flags & CON_ENABLED)) {
+		serial8250_console.flags &= ~CON_PRINTBUFFER;
+		register_console(&serial8250_console);
+	}
+	return i;
+}
+
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
 #define SERIAL8250_CONSOLE	NULL
===== drivers/serial/8250.h 1.7 vs edited =====
--- 1.7/drivers/serial/8250.h	Tue Sep  9 06:14:16 2003
+++ edited/drivers/serial/8250.h	Fri Mar  5 15:06:56 2004
@@ -29,6 +29,7 @@
 void serial8250_get_irq_map(unsigned int *map);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
+int __init serial8250_start_console(struct uart_port *port, char *options);
 
 struct old_serial_port {
 	unsigned int uart;

