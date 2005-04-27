Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVD0L3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVD0L3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVD0L3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:29:18 -0400
Received: from coderock.org ([193.77.147.115]:61376 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261444AbVD0L3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:29:01 -0400
Date: Wed, 27 Apr 2005 13:28:51 +0200
From: Domen Puncer <domen@coderock.org>
To: Sune =?iso-8859-1?Q?M=F8lgaard?= <sune@molgaard.org>
Cc: linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: [PATCH] 2.4.30 PicoPower IRQ router
Message-ID: <20050427112850.GA18533@nd47.coderock.org>
References: <426C9DED.9010206@molgaard.org> <200504261740.08794.lists@b-open-solutions.it> <426E8FE4.5040307@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <426E8FE4.5040307@molgaard.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/05 21:00 +0200, Sune Mølgaard wrote:
> Alessandro Amici wrote:
> >just in case you didn't notice: your patch is empty :)
> 
> How so? I see it fine in the mail that came back to me, but ok. I'll
> repost below.
> 
> >and try to gather info on someone actually in charge of the subsystem 
> >you are modifying and CC him. random patches on l-k may not get the 
> >needed attention.
> >
> 
> I thought of that and forwarded to Martin Mares, but thank you for the tip
> 
> Best regards,
> 
> Sune
> 
> --Start patch--

Signed-off-by? And weird indentification, try to use tabs.

> 
> --- linux-2.4.30/arch/i386/kernel/pci-irq.c	2005-04-04
> 03:42:19.000000000 +0200
> +++ linux/arch/i386/kernel/pci-irq.c	2005-04-25 08:43:02.501678464 +0200
> @@ -157,6 +157,25 @@
>  }
> 
>  /*
> + * PicoPower PT86C523
> + */
> +
> +static int pirq_pico_get(struct pci_dev *router, struct pci_dev *dev,
> int pirq)
> +{
> +  outb(0x10+((pirq-1)>>1), 0x24);
> +  return ((pirq-1)&1) ? (inb(0x26)>>4) : (inb(0x26)&0xf);
> +}
> +
> +static int pirq_pico_set(struct pci_dev *router, struct pci_dev *dev,
> int pirq, int irq)
> +{
> +  outb(0x10+((pirq-1)>>1), 0x24);
> +  unsigned int x;
> +  x = inb(0x26);
> +  x = ((pirq-1)&1) ? ((x&0x0f)|(irq<<4)) : ((x&0xf0)|(irq));
> +  outb(x,0x26);
> +}

I really don't know about this, but existing code (2.6.x) uses
{read,write}_config_nybble which looks suspiciously similar.

> +
> +/*
>   * ALI pirq entries are damn ugly, and completely undocumented.
>   * This has been figured out from pirq tables, and it's not a pretty
>   * picture.
> @@ -609,6 +628,23 @@
> 
>  #endif
> 
> +static __init int pico_router_probe(struct irq_router *r, struct
> pci_dev *router, u16 device)
> +{
> +  switch(device)
> +  {
> +    case 0x0002:

Use/define some PCI_DEVICE_ID_

> +      r->name = "PicoPower PT86C523";
> +      r->get = pirq_pico_get;
> +      r->set = pirq_pico_set;
> +      return 1;
> +
> +    case 0x8002:
> +      r->name = "PicoPower PT86C523 rev. BB+";
> +      r->get = pirq_pico_get;
> +      r->set = pirq_pico_set;
> +      return 1;
> +  }
> +}

return 0; missing

> 
>  static __init int intel_router_probe(struct irq_router *r, struct
> pci_dev *router, u16 device)
>  {
> @@ -814,6 +850,7 @@
>  }
>  		
>  static __initdata struct irq_router_handler pirq_routers[] = {
> +        { 0x1066, pico_router_probe },

PCI_VENDOR_ID_?

>  	{ PCI_VENDOR_ID_INTEL, intel_router_probe },
>  	{ PCI_VENDOR_ID_AL, ali_router_probe },
>  	{ PCI_VENDOR_ID_ITE, ite_router_probe },
> 


	Domen
