Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUDTXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUDTXlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUDTXlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:41:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:53136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263745AbUDTXlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:41:05 -0400
Date: Tue, 20 Apr 2004 16:42:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Max Asbock <masbock@us.ibm.com>
Cc: tony@bakeyournoodle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
Message-Id: <20040420164231.2fd3518a.akpm@osdl.org>
In-Reply-To: <1082501343.6129.180.camel@DYN318100BLD.beaverton.ibm.com>
References: <20040420210110.GD3445@bakeyournoodle.com>
	<20040420143418.08962d0b.akpm@osdl.org>
	<1082501343.6129.180.camel@DYN318100BLD.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Asbock <masbock@us.ibm.com> wrote:
>
> On Tue, 2004-04-20 at 14:34, Andrew Morton wrote:
> > Tony Breeds <tony@bakeyournoodle.com> wrote:
> > 
> > Seems sane to me, but I'm not sure why this wasn't done originally.  ie, this:
> > 
> > +#ifdef CONFIG_SERIAL_8250
> >  extern void ibmasm_register_uart(struct service_processor *sp);
> >  extern void ibmasm_unregister_uart(struct service_processor *sp);
> > +#else
> > +#define ibmasm_register_uart(sp)	do { } while(0)
> > +#define ibmasm_unregister_uart(sp)	do { } while(0)
> > +#endif
> > 
> > becomes unnecessary with your patch.
> > 
> > Max, any preferences?
> > 
> 
> The above allows the driver to be built without serial line support. It
> still functions that way. uart support is only part of the driver's
> functions. Therefore it makes sense to not make the whole driver depend
> on SERIAL_8250 and instead only configure away the uart support when
> SERIAL_8250 is not defined.

So I think you'll be needing something liek this?


 25-akpm/drivers/misc/ibmasm/uart.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/misc/ibmasm/uart.c~a drivers/misc/ibmasm/uart.c
--- 25/drivers/misc/ibmasm/uart.c~a	Tue Apr 20 16:41:32 2004
+++ 25-akpm/drivers/misc/ibmasm/uart.c	Tue Apr 20 16:41:56 2004
@@ -54,12 +54,14 @@ void ibmasm_register_uart(struct service
 	serial.io_type		= UPIO_MEM;
 	serial.iomem_base	= iomem_base;
 
+#ifdef CONFIG_SERIAL_8250
 	sp->serial_line = register_serial(&serial);
 	if (sp->serial_line < 0) {
 		dev_err(sp->dev, "Failed to register serial port\n");
 		return;
 	}
 	enable_uart_interrupts(sp->base_address);
+#endif
 }
 
 void ibmasm_unregister_uart(struct service_processor *sp)
@@ -68,5 +70,7 @@ void ibmasm_unregister_uart(struct servi
 		return;
 
 	disable_uart_interrupts(sp->base_address);
+#ifdef CONFIG_SERIAL_8250
 	unregister_serial(sp->serial_line);
+#endif
 }

_

