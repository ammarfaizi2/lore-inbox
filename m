Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSK3XnJ>; Sat, 30 Nov 2002 18:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSK3XnJ>; Sat, 30 Nov 2002 18:43:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50183 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261322AbSK3XnI>; Sat, 30 Nov 2002 18:43:08 -0500
Date: Sat, 30 Nov 2002 23:50:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [CFT] Serial double initialisation
Message-ID: <20021130235031.C30365@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, Alan reported to me a double-initialisation bug between the
ISA init and PNP initialisation of serial ports.

Since then, Alan integrated a patch I sent him into -ac, and as yet I
haven't heard any feedback.  Since I don't have the PNP hardware to be
able to test this, I'm not putting it into Linus' tree until I hear some
success.

So, if people are using 2.5.50 with PNP support enabled, and if you are
seeing two "ttyS0" lines during the kernel boot messages, please apply
this patch and confirm to me that it correctly reports one ttyS0 message.

This is the exact same patch I sent to Alan, and appears to apply cleanly
to the current 2.5.50 BK tree.

Hopefully looking forward to some feedback.

Thanks.

--- orig/drivers/serial/core.c	Tue Nov  5 12:51:26 2002
+++ linux/drivers/serial/core.c	Mon Nov 25 11:44:08 2002
@@ -2405,17 +2405,22 @@
 			goto out;
 		}
 
-		state->port->iobase   = port->iobase;
-		state->port->membase  = port->membase;
-		state->port->irq      = port->irq;
-		state->port->uartclk  = port->uartclk;
-		state->port->fifosize = port->fifosize;
-		state->port->regshift = port->regshift;
-		state->port->iotype   = port->iotype;
-		state->port->flags    = port->flags;
-		state->port->line     = state - drv->state;
+		/*
+		 * If the port is already initialised, don't touch it.
+		 */
+		if (state->port->type == PORT_UNKNOWN) {
+			state->port->iobase   = port->iobase;
+			state->port->membase  = port->membase;
+			state->port->irq      = port->irq;
+			state->port->uartclk  = port->uartclk;
+			state->port->fifosize = port->fifosize;
+			state->port->regshift = port->regshift;
+			state->port->iotype   = port->iotype;
+			state->port->flags    = port->flags;
+			state->port->line     = state - drv->state;
 
-		__uart_register_port(drv, state, state->port);
+			__uart_register_port(drv, state, state->port);
+		}
 
 		ret = state->port->line;
 	} else


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

