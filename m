Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUDUASC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUDUASC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUDUASC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:18:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22176 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263824AbUDUAR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:17:56 -0400
Subject: Re: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
From: Max Asbock <masbock@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tony@bakeyournoodle.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040420164231.2fd3518a.akpm@osdl.org>
References: <20040420210110.GD3445@bakeyournoodle.com>
	 <20040420143418.08962d0b.akpm@osdl.org>
	 <1082501343.6129.180.camel@DYN318100BLD.beaverton.ibm.com>
	 <20040420164231.2fd3518a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1082506630.6129.207.camel@DYN318100BLD.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 17:17:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 16:42, Andrew Morton wrote:

> Max Asbock <masbock@us.ibm.com> wrote:

> > ... allows the driver to be built without serial line support. It
> > still functions that way. uart support is only part of the driver's
> > functions. Therefore it makes sense to not make the whole driver depend
> > on SERIAL_8250 and instead only configure away the uart support when
> > SERIAL_8250 is not defined.


> So I think you'll be needing something liek this?
> 
> 
>  25-akpm/drivers/misc/ibmasm/uart.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> diff -puN drivers/misc/ibmasm/uart.c~a drivers/misc/ibmasm/uart.c
> --- 25/drivers/misc/ibmasm/uart.c~a	Tue Apr 20 16:41:32 2004
> +++ 25-akpm/drivers/misc/ibmasm/uart.c	Tue Apr 20 16:41:56 2004
> @@ -54,12 +54,14 @@ void ibmasm_register_uart(struct service
>  	serial.io_type		= UPIO_MEM;
>  	serial.iomem_base	= iomem_base;
>  
> +#ifdef CONFIG_SERIAL_8250
>  	sp->serial_line = register_serial(&serial);
>  	if (sp->serial_line < 0) {
>  		dev_err(sp->dev, "Failed to register serial port\n");
>  		return;
>  	}
>  	enable_uart_interrupts(sp->base_address);
> +#endif
>  }
>  
>  void ibmasm_unregister_uart(struct service_processor *sp)
> @@ -68,5 +70,7 @@ void ibmasm_unregister_uart(struct servi
>  		return;
>  
>  	disable_uart_interrupts(sp->base_address);
> +#ifdef CONFIG_SERIAL_8250
>  	unregister_serial(sp->serial_line);
> +#endif
>  }
> 

I posted the following patch a little while ago. I arranged it that way
with the intention to avoid #ifdefs in the .c file. This patch has been
applied in 2.6.6-rc2. So it is all good. 

regards,
max

diff -urN linux-2.6.5/drivers/misc/ibmasm/ibmasm.h linux-2.6.5-ibmasm/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.5/drivers/misc/ibmasm/ibmasm.h	2004-04-03 19:36:18.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/ibmasm/ibmasm.h	2004-04-06 10:56:31.000000000 -0700
@@ -220,5 +220,10 @@
 extern void ibmasmfs_add_sp(struct service_processor *sp);
 
 /* uart */
+#ifdef CONFIG_SERIAL_8250
 extern void ibmasm_register_uart(struct service_processor *sp);
 extern void ibmasm_unregister_uart(struct service_processor *sp);
+#else
+#define ibmasm_register_uart(sp)	do { } while(0)
+#define ibmasm_unregister_uart(sp)	do { } while(0)
+#endif
diff -urN linux-2.6.5/drivers/misc/ibmasm/Makefile linux-2.6.5-ibmasm/drivers/misc/ibmasm/Makefile
--- linux-2.6.5/drivers/misc/ibmasm/Makefile	2004-04-03 19:37:37.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/ibmasm/Makefile	2004-04-06 13:07:54.000000000 -0700
@@ -1,7 +1,7 @@
 
 obj-$(CONFIG_IBM_ASM) := ibmasm.o
 
-ibmasm-objs :=	module.o      \
+ibmasm-y :=	module.o      \
 		ibmasmfs.o    \
 		event.o       \
 		command.o     \
@@ -9,5 +9,7 @@
 		heartbeat.o   \
 		r_heartbeat.o \
 		dot_command.o \
-		lowlevel.o    \
-		uart.o
+		lowlevel.o
+
+ibmasm-$(CONFIG_SERIAL_8250) += uart.o
+
diff -urN linux-2.6.5/drivers/misc/Kconfig linux-2.6.5-ibmasm/drivers/misc/Kconfig
--- linux-2.6.5/drivers/misc/Kconfig	2004-04-03 19:36:26.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/Kconfig	2004-04-06 13:50:49.924254952 -0700
@@ -16,7 +16,9 @@
 	  processor. The driver is meant to be used in conjunction with
 	  a user space API.
 	  The ibmasm driver also enables the OS to use the UART on the
-          service processor board as a regular serial port.
+	  service processor board as a regular serial port. To make use of
+	  this feature serial driver support (CONFIG_SERIAL_8250) must be
+	  enabled.
 	  
 
 	  If unsure, say N.



