Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCFQgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCFQgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCFQgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:36:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14567 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750820AbWCFQfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:35:50 -0500
Date: Mon, 6 Mar 2006 14:23:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, linux@dominikbrodowski.net
Subject: Re: [patch] collie: fix missing pcmcia bits
Message-ID: <20060306132329.GA1737@elf.ucw.cz>
References: <20060305135351.GA16481@elf.ucw.cz> <1141583008.6521.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141583008.6521.49.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds missing bits of collie (sharp sl-5500) PCMCIA support and
MFD support.
 
Signed-off-by: Pavel Machek <pavel@suse.cz>

---

> > @@ -242,8 +249,7 @@ static void __init collie_init(void)
> >  	GPDR |= GPIO_32_768kHz;
> >  	TUCR  = TUCR_32_768kHz;
> >  
> > -	scoop_num = 1;
> > -	scoop_devs = &collie_pcmcia_scoop[0];
> 
> These lines don't exist in mainline kernels anymore? What was this
> diffed against?

Will check; I used old diff because new diff included too much
additional fluff.. oops.

...ahha, oops, sorry, I have some bad stuff in my "good" tree.

Here's updated patch...

> > +
> > +#ifdef CONFIG_SA1100_COLLIE
> > +#include <asm/arch-sa1100/collie.h>
> 
> I can't immediately see why this is needed anymore.

It is not. Sorry about it and surrounding changes.

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 6888816..ce2b479 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -40,6 +40,7 @@
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
+#include <asm/arch/mcp.h>
 
 #include "generic.h"
 
@@ -66,6 +67,32 @@ struct platform_device colliescoop_devic
 	.resource	= collie_scoop_resources,
 };
 
+static struct scoop_pcmcia_dev collie_pcmcia_scoop[] = {
+{
+       .dev        = &colliescoop_device.dev,
+       .irq        = COLLIE_IRQ_GPIO_CF_IRQ,
+       .cd_irq     = COLLIE_IRQ_GPIO_CF_CD,
+       .cd_irq_str = "PCMCIA0 CD",
+},
+};
+
+static struct scoop_pcmcia_config collie_pcmcia_config = {
+	.devs         = &collie_pcmcia_scoop[0],
+	.num_devs     = 1,
+};
+
+
+static struct mcp_plat_data collie_mcp_data = {
+	.mccr0          = MCCR0_ADM,
+	.sclk_rate      = 11981000,
+};
+
+
+static struct sa1100_port_fns collie_port_fns __initdata = {
+	.set_mctrl	= collie_uart_set_mctrl,
+	.get_mctrl	= collie_uart_get_mctrl,
+};
+
 
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -153,12 +246,14 @@ static void __init collie_init(void)
 		 PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS | \
 	 	 PPC_TXD1 | PPC_TXD2 | PPC_RXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM );
 
 	PSDR = ( PPC_RXD1 | PPC_RXD2 | PPC_RXD3 | PPC_RXD4 );
 
 	GAFR |= GPIO_32_768kHz;
 	GPDR |= GPIO_32_768kHz;
 	TUCR  = TUCR_32_768kHz;
 
+	platform_scoop_config = &collie_pcmcia_config;
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
@@ -166,6 +302,7 @@ static void __init collie_init(void)
 
 	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
 			      ARRAY_SIZE(collie_flash_resources));
+	sa11x0_set_mcp_data(&collie_mcp_data);
 
 	sharpsl_save_param();
 }


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
