Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUBKUzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266104AbUBKUzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:55:32 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:44427 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S265751AbUBKUzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:55:21 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Make serial console work for any port
Date: Wed, 11 Feb 2004 13:55:15 -0700
User-Agent: KMail/1.5.4
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402111355.15835.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current serial console code only works for ports that are either
defined in SERIAL_PORT_DFNS (and set up by serial8250_isa_init_ports())
or registered by early_serial_setup().

On ia64, SERIAL_PORT_DFNS is empty because we discover everything
via ACPI and PCI.  And we only use early_serial_setup() for one port
described by the HCDP firmware table.

This patch against 2.6.3-rc2 makes it work for any valid port.  If we
don't know about the port early, we just return -ENODEV from the
setup() function, which leaves the serial console disabled.  After the
driver has found all the ports, we try to register the serial console
again if it hasn't been enabled already.

I think the "port->type == PORT_UNKNOWN" test is cleaner than the
"port->ops" test -- it more clearly gets to the point of "do we know
about this port".


===== drivers/serial/8250.c 1.43 vs edited =====
--- 1.43/drivers/serial/8250.c	Fri Jan  2 12:35:07 2004
+++ edited/drivers/serial/8250.c	Wed Feb 11 13:13:11 2004
@@ -1976,6 +1976,8 @@
 	if (co->index >= UART_NR)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
+	if (port->type == PORT_UNKNOWN)
+		return -ENODEV;
 
 	/*
 	 * Temporary fix.
@@ -2006,6 +2008,14 @@
 	return 0;
 }
 console_initcall(serial8250_console_init);
+
+static int __init serial8250_late_console_init(void)
+{
+	if (!(serial8250_console.flags & CON_ENABLED))
+		register_console(&serial8250_console);
+	return 0;
+}
+late_initcall(serial8250_late_console_init);
 
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
===== drivers/serial/serial_core.c 1.78 vs edited =====
--- 1.78/drivers/serial/serial_core.c	Sat Jan 24 14:53:13 2004
+++ edited/drivers/serial/serial_core.c	Wed Feb 11 12:36:12 2004
@@ -1871,9 +1871,6 @@
 	if (flow == 'r')
 		termios.c_cflag |= CRTSCTS;
 
-	if (!port->ops)
-		return 0;	/* "console=" on ia64 */
-
 	port->ops->set_termios(port, &termios, NULL);
 	co->cflag = termios.c_cflag;
 

