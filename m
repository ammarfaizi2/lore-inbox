Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVK0A1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVK0A1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 19:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVK0A1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 19:27:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:14480 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750796AbVK0A1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 19:27:47 -0500
Subject: uart_match_port() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 11:21:46 +1100
Message-Id: <1133050906.7768.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel, would you accept a patch like that:

Index: linux-work/drivers/serial/serial_core.c
===================================================================
--- linux-work.orig/drivers/serial/serial_core.c	2005-11-14 20:32:16.000000000 +1100
+++ linux-work/drivers/serial/serial_core.c	2005-11-27 11:13:54.000000000 +1100
@@ -2307,7 +2307,8 @@
 		return (port1->iobase == port2->iobase) &&
 		       (port1->hub6   == port2->hub6);
 	case UPIO_MEM:
-		return (port1->membase == port2->membase);
+		return (port1->membase == port2->membase) ||
+			(port1->mapbase && port1->mapbase == port2->mapbase);
 	}
 	return 0;
 }

The reason is a bit complicated, but basically, we have some arch code
that builds a list of available serial ports very early and registers that
as a platform device. It also detects which one is the default firmware port
and what speed it's been configured for and builds a proper config line to
pass to add_preferred_console() so we get the default serial console setup
properly automatically.

This list includes however ports that are on PCI devices on some recent
machines. Thus, we need to make sure that, when 8250_pci.c kicks in, it
property detects that those platform ports are the same it's discovered
and thus properly re-uses the same port & minor. However, while that works
for PIO ports, it doesn't for MMIO since membase is obtained from ioremap,
and thus will be different between the port registered at boot and the
value passed by the PCI code. Only mapbase will be the same.

If we just skipped PCI devices in our early discovery code (thus letting
8250_pci.c alone discover them), we would be unable to use them for very
early console output, and we would be unable to "know" what their minor number
will be, and thus build an appropriate argument string for add_preferred_console(),
which means we would be unable to have the console automatically pick the port
that we set by the firmware and at the right speed, which basically means
console not working for users. 

Cheers,
Ben.

