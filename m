Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbULFSTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbULFSTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbULFSTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:19:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:46285 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbULFST0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:19:26 -0500
Message-ID: <41B49A63.6030104@osdl.org>
Date: Mon, 06 Dec 2004 09:44:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan McDowell <noodles@earth.li>
CC: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc MODULE_PARM fix
References: <20041206180242.GJ10285@earth.li>
In-Reply-To: <20041206180242.GJ10285@earth.li>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan McDowell wrote:
> [I hope sending this to just the linux-parport list is the right thing
> to do; I'm assuming the maintainers read it and don't want individual
> CCs as well.]
> 
> In the 2.6.10-rc releases parport_pc doesn't seem to want to take any
> module parameters:
> 
> parport_pc: Ignoring new-style parameters in presence of obsolete ones
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> 
> I need to pass parameters to the module to make it detect my port fully
> (the printer doesn't seem to want to print more than a page or so
> without an irq in use). With the patch below, against 2.6.10-rc3 I can
> do so and get:
> 
> parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> 
> ------
> --- drivers/parport/parport_pc.c.orig	2004-12-06 17:44:08.000000000 +0000
> +++ drivers/parport/parport_pc.c	2004-12-06 17:49:59.000000000 +0000
> @@ -3157,7 +3157,7 @@
>  #ifdef CONFIG_PCI
>  static int __init parport_init_mode_setup(char *str)
>  {
> -	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
> +	DPRINTK(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
>  
>  	if (!strcmp (str, "spp"))
>  		parport_init_mode=1;
> @@ -3176,7 +3176,7 @@
>  #ifdef MODULE
>  static const char *irq[PARPORT_PC_MAX_PORTS];
>  static const char *dma[PARPORT_PC_MAX_PORTS];
> -static char *init_mode;
> +static char init_mode[7];
>  
>  MODULE_PARM_DESC(io, "Base I/O address (SPP regs)");
>  module_param_array(io, int, NULL, 0);
> @@ -3193,7 +3193,7 @@
>  #endif
>  #ifdef CONFIG_PCI
>  MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
> -MODULE_PARM(init_mode, "s");
> +module_param_string(init_mode, init_mode, 7, 0);
>  #endif

I think that it should be:

module_param(init_mode, charp, 0);

and leave 'init_mode' as a char *, not a char array.

Can you test that change and resubmit the patch (if it works :) ?

Thanks,
-- 
~Randy
