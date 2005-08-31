Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVHaP0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVHaP0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVHaP0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:26:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:16857 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964839AbVHaP0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:26:36 -0400
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions -
	please update your drivers NOW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
In-Reply-To: <20050831103352.A26480@flint.arm.linux.org.uk>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 16:49:59 +0100
Message-Id: <1125503399.3355.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is all that is needed for Mwave.

Signed-off-by: Alan Cox <alan@redhat.com>

--- ../linux.vanilla-2.6.13-rc6-mm2/drivers/char/mwave/mwavedd.c	2005-08-25 17:04:20.000000000 +0100
+++ drivers/char/mwave/mwavedd.c	2005-08-31 16:16:29.128028248 +0100
@@ -57,6 +57,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+#include <linux/serial_8250.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
@@ -410,8 +411,8 @@
 
 static int register_serial_portandirq(unsigned int port, int irq)
 {
-	struct serial_struct serial;
-
+	struct uart_port uart;
+	
 	switch ( port ) {
 		case 0x3f8:
 		case 0x2f8:
@@ -442,12 +443,14 @@
 	} /* switch */
 	/* irq is okay */
 
-	memset(&serial, 0, sizeof(serial));
-	serial.port = port;
-	serial.irq = irq;
-	serial.flags = ASYNC_SHARE_IRQ;
-
-	return register_serial(&serial);
+	memset(&uart, 0, sizeof(struct uart_port));
+	
+	uart.uartclk =  1843200;
+	uart.iobase = port;
+	uart.irq = irq;
+	uart.iotype = UPIO_PORT;
+	uart.flags =  UPF_SHARE_IRQ;
+	return serial8250_register_port(&uart);
 }
 
 
@@ -523,7 +526,7 @@
 #endif
 
 	if ( pDrvData->sLine >= 0 ) {
-		unregister_serial(pDrvData->sLine);
+		serial8250_unregister_port(pDrvData->sLine);
 	}
 	if (pDrvData->bMwaveDevRegistered) {
 		misc_deregister(&mwave_misc_dev);

