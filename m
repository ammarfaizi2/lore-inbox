Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVJCBWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVJCBWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVJCBWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:22:47 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:35795 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S932107AbVJCBWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:22:46 -0400
Date: Mon, 3 Oct 2005 03:22:43 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, dsaxena@plexity.net
Subject: [PATCH] don't disable xscale serial ports after autoconfig
Message-ID: <20051003012242.GA15549@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC, not on the list)

Hi,

xscale-type UARTs have an extra bit (UUE) in the IER register that has
to be written as 1 to enable the UART.  At the end of autoconfig() in
drivers/serial/8250.c, the IER register is unconditionally written as
zero, which turns off the UART, and makes any subsequent printch() hang
the box.

Since other 8250-type UARTs don't have this enable bit and are thus
always 'enabled' in this sense, it can't hurt to enable xscale-type
serial ports all the time as well.  The attached patch changes the
autoconfig() exit path to see if the port has an UUE enable bit, and if
yes, to write UUE=1 instead of just putting a zero into IER, using the
same test as is used at the beginning of serial8250_console_write().


cheers,
Lennert

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff -urN linux-2.6.13.orig/drivers/serial/8250.c linux-2.6.13/drivers/serial/8250.c
--- linux-2.6.13.orig/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/serial/8250.c	2005-10-02 21:38:51.000000000 +0200
@@ -936,7 +936,10 @@
 	serial_outp(up, UART_MCR, save_mcr);
 	serial8250_clear_fifos(up);
 	(void)serial_in(up, UART_RX);
-	serial_outp(up, UART_IER, 0);
+	if (up->capabilities & UART_CAP_UUE)
+		serial_outp(up, UART_IER, UART_IER_UUE);
+	else
+		serial_outp(up, UART_IER, 0);
 
  out:	
 	spin_unlock_irqrestore(&up->port.lock, flags);
