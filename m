Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVIGTOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVIGTOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIGTOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:14:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10723 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751226AbVIGTOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:14:22 -0400
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions -
	please update your drivers NOW
From: Max Asbock <masbock@us.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
In-Reply-To: <20050831103352.A26480@flint.arm.linux.org.uk>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1126120374.17335.169.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:12:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 02:33, Russell King wrote:
> As per the feature-removal.txt file, I will be removing the following
> functions shortly:
> 
> 	* register_serial
> 	* unregister_serial
> 	* uart_register_port
> 	* uart_unregister_port
> 
> However, there are still some drivers which use these functions:
> 
> drivers/char/mwave/mwavedd.c:   return register_serial(&serial);
> drivers/char/mwave/mwavedd.c:           unregister_serial(pDrvData->sLine);
> drivers/misc/ibmasm/uart.c:     sp->serial_line = register_serial(&serial);
> drivers/misc/ibmasm/uart.c:     unregister_serial(sp->serial_line);
> drivers/net/ioc3-eth.c: register_serial(&req);
> drivers/net/ioc3-eth.c: register_serial(&req);
> drivers/serial/serial_txx9.c:   line = uart_register_port(&serial_txx9_reg, &port);
> drivers/serial/serial_txx9.c:           uart_unregister_port(&serial_txx9_reg, line);
> 
> These drivers really really really need fixing in the next few days
> if they aren't going to break.  I hereby ask that the maintainers of
> the above drivers show some willingness to update their drivers.
> 

Here is a patch for the ibmasm driver. Let me know it I missed
something.

thanks,
max

diff -urNp linux-2.6.13-git6/drivers/misc/Kconfig linux-2.6.13-git6-ibmasm/drivers/misc/Kconfig
--- linux-2.6.13-git6/drivers/misc/Kconfig	2005-09-06 13:42:34.000000000 -0700
+++ linux-2.6.13-git6-ibmasm/drivers/misc/Kconfig	2005-09-07 12:09:09.000000000 -0700
@@ -6,7 +6,7 @@ menu "Misc devices"
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
-	depends on X86 && PCI && EXPERIMENTAL && BROKEN
+	depends on X86 && PCI && EXPERIMENTAL
 	---help---
 	  This option enables device driver support for in-band access to the
 	  IBM RSA (Condor) service processor in eServer xSeries systems.
diff -urNp linux-2.6.13-git6/drivers/misc/ibmasm/uart.c linux-2.6.13-git6-ibmasm/drivers/misc/ibmasm/uart.c
--- linux-2.6.13-git6/drivers/misc/ibmasm/uart.c	2005-09-06 13:42:34.000000000 -0700
+++ linux-2.6.13-git6-ibmasm/drivers/misc/ibmasm/uart.c	2005-09-06 13:43:45.000000000 -0700
@@ -27,13 +27,14 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
 #include "ibmasm.h"
 #include "lowlevel.h"
 
 
 void ibmasm_register_uart(struct service_processor *sp)
 {
-	struct serial_struct serial;
+	struct uart_port uport;
 	void __iomem *iomem_base;
 
 	iomem_base = sp->base_address + SCOUT_COM_B_BASE;
@@ -47,14 +48,14 @@ void ibmasm_register_uart(struct service
 		return;
 	}
 
-	memset(&serial, 0, sizeof(serial));
-	serial.irq		= sp->irq;
-	serial.baud_base	= 3686400 / 16;
-	serial.flags		= UPF_AUTOPROBE | UPF_SHARE_IRQ;
-	serial.io_type		= UPIO_MEM;
-	serial.iomem_base	= iomem_base;
+	memset(&uport, 0, sizeof(struct uart_port));
+	uport.irq	= sp->irq;
+	uport.uartclk	= 3686400;
+	uport.flags	= UPF_AUTOPROBE | UPF_SHARE_IRQ;
+	uport.iotype	= UPIO_MEM;
+	uport.membase	= iomem_base;
 
-	sp->serial_line = register_serial(&serial);
+	sp->serial_line = serial8250_register_port(&uport);
 	if (sp->serial_line < 0) {
 		dev_err(sp->dev, "Failed to register serial port\n");
 		return;
@@ -68,5 +69,5 @@ void ibmasm_unregister_uart(struct servi
 		return;
 
 	disable_uart_interrupts(sp->base_address);
-	unregister_serial(sp->serial_line);
+	serial8250_unregister_port(sp->serial_line);
 }


