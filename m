Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVIGUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVIGUPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVIGUPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:15:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48108 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932211AbVIGUPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:15:03 -0400
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions -
	please update your drivers NOW
From: Max Asbock <masbock@us.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
In-Reply-To: <20050907202504.F19199@flint.arm.linux.org.uk>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
	 <1126120374.17335.169.camel@w-amax>
	 <20050907202504.F19199@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1126123988.17335.174.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 13:13:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 12:25, Russell King wrote:
> On Wed, Sep 07, 2005 at 12:12:54PM -0700, Max Asbock wrote:
> > Here is a patch for the ibmasm driver. Let me know it I missed
> > something.
> 
> Thanks.  Does it still need to include serial.h?
> 
> Also, can I have a signed-off-by line as per the DCO v1.1 please
> (see Documentation/SubmittingPatches) ?
> 
> Thanks again.

It doesn't need serial.h included. So here it is again.

max

Signed-off-by: Max Asbock <masbock@us.ibm.com>

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
+++ linux-2.6.13-git6-ibmasm/drivers/misc/ibmasm/uart.c	2005-09-07 13:07:02.000000000 -0700
@@ -25,15 +25,15 @@
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
-#include <linux/serial.h>
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
@@ -47,14 +47,14 @@ void ibmasm_register_uart(struct service
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
@@ -68,5 +68,5 @@ void ibmasm_unregister_uart(struct servi
 		return;
 
 	disable_uart_interrupts(sp->base_address);
-	unregister_serial(sp->serial_line);
+	serial8250_unregister_port(sp->serial_line);
 }


