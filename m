Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVKUBOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVKUBOP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKUBOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:14:15 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:1000 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932160AbVKUBOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:14:11 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       Russell King <rmk+serial@arm.linux.org.uk>
Subject: [PATCH 5/5] Report serial ports without an IRQ correctly
Message-Id: <E1Ee0G0-0004CP-Gi@localhost.localdomain>
Date: Sun, 20 Nov 2005 20:14:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serial ports which have an IRQ set to NO_IRQ should report "polled" instead
of 'irq = -1'

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 drivers/serial/serial_core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

applies-to: 360e45920393be2254533e5a5bdfa802fd2f4766
2f0b5c3faa5e901ada0eaab0788f218323c9baa2
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 2331296..a63b268 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1961,6 +1961,7 @@ static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
 	char address[64];
+	char irq[16];
 
 	switch (port->iotype) {
 	case UPIO_PORT:
@@ -1982,10 +1983,16 @@ uart_report_port(struct uart_driver *drv
 		break;
 	}
 
-	printk(KERN_INFO "%s%s%s%d at %s (irq = %d) is a %s\n",
+	if (port->irq == NO_IRQ) {
+		strlcpy(irq, "polled", sizeof(irq));
+	} else {
+		snprintf(irq, sizeof(irq), "irq = %d", port->irq);
+	}
+
+	printk(KERN_INFO "%s%s%s%d at %s (%s) is a %s\n",
 	       port->dev ? port->dev->bus_id : "",
 	       port->dev ? ": " : "",
-	       drv->dev_name, port->line, address, port->irq, uart_type(port));
+	       drv->dev_name, port->line, address, irq, uart_type(port));
 }
 
 static void
---
0.99.8.GIT
