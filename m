Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTJPSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTJPSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:31:09 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:52619 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263064AbTJPSbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:31:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] early_serial_setup array bounds check (2.6)
Date: Thu, 16 Oct 2003 12:29:24 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161229.24566.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

early_serial_setup() doesn't validate the array index,
so a caller could corrupt memory after serial8250_ports[]
by supplying a value of port->line that's too large.

I haven't seen a failure related to this, but it seems fragile
to rely on callers to know how many ports the driver
supports.

Bjorn

===== drivers/serial/8250.c 1.40 vs edited =====
--- 1.40/drivers/serial/8250.c	Sun Oct  5 15:07:20 2003
+++ edited/drivers/serial/8250.c	Thu Oct 16 10:01:07 2003
@@ -2086,6 +2086,9 @@
 
 int __init early_serial_setup(struct uart_port *port)
 {
+	if (port->line >= ARRAY_SIZE(serial8250_ports))
+		return -ENODEV;
+
 	serial8250_isa_init_ports();
 	serial8250_ports[port->line].port	= *port;
 	serial8250_ports[port->line].port.ops	= &serial8250_pops;

