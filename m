Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUBXABO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUBXABO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:01:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20745 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262100AbUBXAA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:00:56 -0500
Date: Tue, 24 Feb 2004 00:00:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Andrew Morton <akpm@osdl.org>, Guylhem Aznar <pcmcia@externe.net>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Message-ID: <20040224000051.C25358@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Andrew Morton <akpm@osdl.org>, Guylhem Aznar <pcmcia@externe.net>
References: <200402240033.31042.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402240033.31042.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Tue, Feb 24, 2004 at 12:33:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 12:33:31AM +0100, Daniel Ritz wrote:
> this patch should fix up wrongly initialized TI bridges. in a safe way
> (hopefully).

Unfortunately not.

This is a working setup:

DCR = 6162
MUX = fba97543

Changing MUX from those values _breaks_.  Let's see what the code does.

> +	/* check IRQ routing to see if 16bit cards would work */
> +	irqmux = irqmux_old = config_readl(socket, TI122X_IRQMUX);
> +	devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
> +	printk(KERN_INFO "Yenta TI: irqmux %08x, devctl %02x\n", irqmux, devctl);
> +
> +#if 1
> +	/* serialized interrupts: MFUNC3 must be IRQSER */
> +	if (devctl & TI113X_DCR_IMODE_SERIAL)
> +		irqmux = (irqmux & ~0xf000) | 0x1000;
> +#endif

DCR doesn't have bit 2 set, so we don't change this (which is fine.)

>  
> +#if 1
> +	/* if we have all serial: probe, fall back to parallel PCI */
> +	if ((devctl & TI113X_DCR_IMODE_MASK) == TI12XX_DCR_IMODE_ALL_SERIAL) {

Not true, so this is skipped (which again is fine.)

> +		/* write down if changed, probe */
> +		if (irqmux_old != irqmux) {
> +			printk(KERN_INFO "Yenta TI: changing to %08x", irqmux);
>  			config_writel(socket, TI122X_IRQMUX, irqmux);
> +		}
> +	
> +		probe_mask = yenta_probe_irq(socket, isa_interrupts);
> +		if (!probe_mask) {
> +			/* no chance to have all serial working -> PCI */
> +			printk(KERN_INFO "Yenta TI: serial interrupts not working -> PCI\n");
> +			devctl &= ~TI113X_DCR_IMODE_MASK;
>  			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
>  		}
>  	}
>  #endif
>  
> +	/* parallel PCI interrupts: MFUNC0 must be INTA */
> +	if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {

Ok, this is true.

> +		u32 sysctl;
> +		irqmux = (irqmux & ~0x0f) | 0x02;

Whoops, we've just taken out IRQ3 as a routed ISA IRQ.

> +
> +		/* route INTB depending on INTRTIE */
> +		switch (socket->dev->device) {
> +			/* there are more... */
> +			case PCI_DEVICE_ID_TI_1220:
> +			case PCI_DEVICE_ID_TI_1221:
> +			case PCI_DEVICE_ID_TI_1225:
> +			case PCI_DEVICE_ID_TI_1420:
> +			case PCI_DEVICE_ID_TI_1450:
> +			//case PCI_DEVICE_ID_TI_1451:
> +			case PCI_DEVICE_ID_TI_1520:
> +				sysctl = config_readl(socket, TI113X_SYSTEM_CONTROL);
> +				if (!(sysctl & TI122X_SCR_INTRTIE))
> +					irqmux = (irqmux & ~0xf0) | 0x20;

Whoops, just taken out IRQ4 as a routed ISA IRQ.

> +
> +			default:
> +				break;
> +		}
> +	}
> +
> +	if (irqmux_old != irqmux) {
> +		printk(KERN_INFO "Yenta TI: changing to %08x", irqmux);
> +		config_writel(socket, TI122X_IRQMUX, irqmux);
> +	}

Net result - not good and probably not acceptable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
