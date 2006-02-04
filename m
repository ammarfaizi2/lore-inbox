Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946126AbWBDAMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946126AbWBDAMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946128AbWBDAMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:12:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946126AbWBDAMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:12:22 -0500
Date: Fri, 3 Feb 2006 19:12:01 -0500
From: Dave Jones <davej@redhat.com>
To: rmk@arm.linux.org.uk
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, a2@adamis.de
Subject: Re: 8250.c: Fix to make 16c950 UARTs work
Message-ID: <20060204001201.GA20330@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, rmk@arm.linux.org.uk,
	Linux Kernel <linux-kernel@vger.kernel.org>, a2@adamis.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,
 This patch seemed to have got dropped on the floor somewhere.
http://marc.theaimsgroup.com/?l=linux-kernel&m=112687270832687&w=2

We've had a Fedora user requesting this after patching his kernel
with it, and using it without problems for some time.
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126403)
I just checked, and it still applies (with a few offsets) to .16rc2
On those grounds, I'm comfortable to add a Signed-off-by:
Is there any reason not to apply this ?

From: Mathias Adam <a2@adamis.de>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.13-org/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/serial/8250.c	2005-09-16 12:18:14.000000000 +0200
@@ -7,6 +7,9 @@
  *
  *  Copyright (C) 2001 Russell King.
  *
+ *  2005/09/16: Enabled higher baud rates for 16C95x.
+ *		(Mathias Adam <a2@adamis.de>)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -1652,6 +1655,14 @@
 	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
 		 baud == (port->uartclk/8))
 		quot = 0x8002;
+	/*
+	 * For 16C950s UART_TCR is used in combination with divisor==1
+	 * to achieve baud rates up to baud_base*4.
+	 */
+	else if ((port->type == PORT_16C950) &&
+		 baud > (port->uartclk/16))
+		quot = 1;
+
 	else
 		quot = uart_get_divisor(port, baud);
 
@@ -1665,7 +1676,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1697,7 +1708,8 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
 	quot = serial8250_get_divisor(port, baud);
 
 	/*
@@ -1733,6 +1745,19 @@
 	 */
 	spin_lock_irqsave(&up->port.lock, flags);
 
+	/* 
+	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
+	 * thus increasing max baud rate to uartclk/4.
+	 */
+	if (up->port.type == PORT_16C950) {
+		if (baud == port->uartclk/4)
+			serial_icr_write(up, UART_TCR, 0x4);
+		else if (baud == port->uartclk/8)
+			serial_icr_write(up, UART_TCR, 0x8);
+		else
+			serial_icr_write(up, UART_TCR, 0);
+	}
+	
 	/*
 	 * Update the per-port timeout.
 	 */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
