Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVGLDV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVGLDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVGLDTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:19:15 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:38634 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262213AbVGLDRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:17:51 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       rmk+serial@arm.linux.org.uk
Subject: [patch 2.6.13-git] 8250 tweaks
Date: Mon, 11 Jul 2005 19:22:04 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mly0ChnRM10s0ss"
Message-Id: <200507111922.04800.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Mly0ChnRM10s0ss
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Two small changes:  make the IRQ name less generic, and stop
whining about certain non-errors (details in the patch comments).
Please merge.

- Dave


--Boundary-00=_Mly0ChnRM10s0ss
Content-Type: text/x-diff;
  charset="us-ascii";
  name="8250.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="8250.patch"

Make the 8250 UART driver register its IRQ using a label that's more
appropriate ... it's an 8250 UART, not one of dozens of other kind of
serial link (I2C, SPI, USB, McBSP, I2S, non-8250 UART, USART, SSP,
MicroWire, PS/2 kbd/mouse/touchpad, MCSI, HDQ/1-Wire, ... etc).

Also, make it stop whining when one of the platform serial ports has
been disabled, e.g. because a given board doesn't wire it out.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- o26.orig/drivers/serial/8250.c	2005-07-11 18:41:03.000000000 -0700
+++ o26/drivers/serial/8250.c	2005-07-11 18:58:26.000000000 -0700
@@ -1317,7 +1317,7 @@ static int serial_link_irq_chain(struct 
 		spin_unlock_irq(&i->lock);
 
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, "serial", i);
+				  irq_flags, "uart_8250", i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
@@ -2331,6 +2331,8 @@ static int __devinit serial8250_probe(st
 	memset(&port, 0, sizeof(struct uart_port));
 
 	for (i = 0; p && p->flags != 0; p++, i++) {
+		if (!p->iobase && !p->membase)
+			continue;
 		port.iobase	= p->iobase;
 		port.membase	= p->membase;
 		port.irq	= p->irq;

--Boundary-00=_Mly0ChnRM10s0ss--
