Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTFLUGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTFLUGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:06:35 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:6647 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S264973AbTFLUGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:06:32 -0400
Date: Thu, 12 Jun 2003 13:20:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] early_port_register
Message-ID: <20030612132001.A4693@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This has been discussed in a previous thread originated by David
Mosberger.  This removed early_serial_setup() in favor of  a
working early_port_register() call.  Many PPC systems rely on
this functionality and are currently hacking around it in the
PPC devel tree.  Last I looked, IA64 still had this in their
devel tree too.

-Matt

===== drivers/serial/8250.c 1.32 vs edited =====
--- 1.32/drivers/serial/8250.c	Thu Jun  5 23:36:47 2003
+++ edited/drivers/serial/8250.c	Thu Jun 12 11:43:54 2003
@@ -2061,9 +2061,15 @@
 	return __register_serial(req, -1);
 }
 
-int __init early_serial_setup(struct serial_struct *req)
+int __init early_register_port(struct uart_port *port)
 {
-	__register_serial(req, req->line);
+	if (port->line >= ARRAY_SIZE(serial8250_ports))
+		return -ENODEV;
+
+	serial8250_isa_init_ports();    /* force ISA defaults */
+	serial8250_ports[port->line].port = *port;
+	serial8250_ports[port->line].port.ops = &serial8250_pops;
+
 	return 0;
 }
 
===== include/linux/serial.h 1.8 vs edited =====
--- 1.8/include/linux/serial.h	Sun Feb 16 12:59:58 2003
+++ edited/include/linux/serial.h	Thu Jun 12 11:43:59 2003
@@ -180,8 +180,10 @@
 extern int register_serial(struct serial_struct *req);
 extern void unregister_serial(int line);
 
+struct uart_port;
+
 /* Allow complicated architectures to specify rs_table[] at run time */
-extern int early_serial_setup(struct serial_struct *req);
+extern int early_register_port(struct uart_port *port);
 
 #ifdef CONFIG_ACPI
 /* tty ports reserved for the ACPI serial console port and debug port */
