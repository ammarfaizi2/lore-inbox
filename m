Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUCDQsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCDQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:48:12 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:46299 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262012AbUCDQsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:48:05 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Make serial console work for any port (take 2)
Date: Thu, 4 Mar 2004 09:48:00 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403040948.00936.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current serial console code only works for ports that are either
defined in SERIAL_PORT_DFNS (and set up by serial8250_isa_init_ports())
or registered by early_serial_setup().

On ia64, SERIAL_PORT_DFNS is empty because we discover everything
via ACPI and PCI.  And we only use early_serial_setup() for one port
described by the HCDP firmware table.

This patch against 2.6.4-rc1 makes it work for any valid port.  If we
don't know about the port early, we just return -ENODEV from the
setup() function, which leaves the serial console disabled.  After the
driver has found all the ports, we try to register the serial console
again if it hasn't been enabled already.

Keith Owens noticed that the first version of this patch broke some
serial console setups because many early serial ports are registered
with "type == PORT_UNKNOWN".  So this version tests "port->ops"
instead, and Keith has confirmed that this works for him.

===== drivers/serial/8250.c 1.45 vs edited =====
--- 1.45/drivers/serial/8250.c	Mon Feb 16 17:20:22 2004
+++ edited/drivers/serial/8250.c	Tue Mar  2 14:24:04 2004
@@ -1976,6 +1976,8 @@
 	if (co->index >= UART_NR)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
+	if (!port->ops)
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
===== drivers/serial/serial_core.c 1.81 vs edited =====
--- 1.81/drivers/serial/serial_core.c	Sat Feb 21 15:42:50 2004
+++ edited/drivers/serial/serial_core.c	Tue Mar  2 14:17:22 2004
@@ -1874,9 +1874,6 @@
 	if (flow == 'r')
 		termios.c_cflag |= CRTSCTS;
 
-	if (!port->ops)
-		return 0;	/* "console=" on ia64 */
-
 	port->ops->set_termios(port, &termios, NULL);
 	co->cflag = termios.c_cflag;
 



