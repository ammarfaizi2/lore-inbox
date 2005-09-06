Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVIFAms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVIFAms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVIFAms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:42:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21690 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965004AbVIFAmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:42:47 -0400
Date: Tue, 6 Sep 2005 01:42:42 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk+serial@arm.linux.org.uk, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] sunsu compile fixes
Message-ID: <20050906004242.GN5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sunsu had been broken by ->stop_tx/->start_tx API changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-sata_qstor/drivers/serial/sunsu.c RC13-git5-sunsu/drivers/serial/sunsu.c
--- RC13-git5-sata_qstor/drivers/serial/sunsu.c	2005-09-05 07:05:15.000000000 -0400
+++ RC13-git5-sunsu/drivers/serial/sunsu.c	2005-09-05 16:41:08.000000000 -0400
@@ -269,7 +269,10 @@
 
 	__stop_tx(up);
 
-	if (up->port.type == PORT_16C950 && tty_stop /*FIXME*/) {
+	/*
+	 * We really want to stop the transmitter from sending.
+	 */
+	if (up->port.type == PORT_16C950) {
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
@@ -283,10 +286,11 @@
 		up->ier |= UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
 	}
+
 	/*
-	 * We only do this from uart_start
+	 * Re-enable the transmitter if we disabled it.
 	 */
-	if (tty_start && up->port.type == PORT_16C950 /*FIXME*/) {
+	if (up->port.type == PORT_16C950 && up->acr & UART_ACR_TXDIS) {
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
