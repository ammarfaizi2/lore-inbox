Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTAOTly>; Wed, 15 Jan 2003 14:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTAOTly>; Wed, 15 Jan 2003 14:41:54 -0500
Received: from pop-be-13-1-dialup-280.freesurf.ch ([194.230.234.24]:6016 "EHLO
	valsheda.taprogge.wh") by vger.kernel.org with ESMTP
	id <S266933AbTAOTlv>; Wed, 15 Jan 2003 14:41:51 -0500
Date: Wed, 15 Jan 2003 20:47:38 +0100
To: Yaacov Akiba Slama <ya@slamail.org>
Cc: linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>,
       zwane@holomorphy.com, bvermeul@blackstar.nl, dave@codemonkey.org.uk
Subject: Re: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
Message-ID: <20030115194738.GA2377@valsheda.taprogge.wh>
Mail-Followup-To: Jens Taprogge <jens.taprogge@rwth-aachen.de>,
	Yaacov Akiba Slama <ya@slamail.org>, linux-kernel@vger.kernel.org,
	Mikael Pettersson <mikpe@csd.uu.se>, zwane@holomorphy.com,
	bvermeul@blackstar.nl, dave@codemonkey.org.uk
References: <20030115081109.GA3839@valsheda.taprogge.wh> <15909.9796.157927.447889@harpo.it.uu.se> <3E258BBC.7010902@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E258BBC.7010902@slamail.org>
User-Agent: Mutt/1.5.3i
From: Jens Taprogge <jens.taprogge@rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are not freeing the possibly already allocated resources in case of
a failure of either pci_assign_resource() or pca_enable_device(). In
fact you are not even checking if pci_assign_resource() fails. That
seems wrong to me.

Btw.: who is in charge of this file? Dave Jones? Is someone working on
integrating it with PCI Hotplug?

Best Regards 
Jens


On Wed, Jan 15, 2003 at 06:26:36PM +0200, Yaacov Akiba Slama wrote:
> Can you test the enclosed patch. It seems to be both simple and to 
> resolve the resource collisions and the "No IRQ known" problem.
> I added a smal comment (and modified another) so future janitors won't 
> move pci_enable above pci_assign_resource again.
> If everyone is ok, I can send it to Linus for inclusion in BK (I have 
> the green light of Dave Jones).
> 
> Thanks,
> Yaacov Akiba Slama
> 
> Mikael Pettersson wrote:
> 
> >Jens Taprogge writes:
> >> The cardbus problems are caused by 
> >> 
> >> ChangeSet@1.797.145.6  2002-11-25 18:31:10-08:00 davej@codemonkey.org.uk
> >> 
> >> as far as I can tell. 
> >> 
> >> pci_enable_device() will fail at least on i386 (see
> >> arch/i386/pci/i386.c: pcibios_enable_resource (line 260)) if the
> >> resources have not been assigned previously. Hence the ostensible
> >> resource collisions.
> >> 
> >> The attached patch should fix the problem.
> >> 
> >> I have send the patch to Dave Jones some time ago but did not hear from
> >> him yet.
> >> 
> >> I am not subscribed to the list so please cc me on replys. 
> >
> >Thanks. Your patch fixed the cardbus hotplug issue perfectly on my laptop.
> >It survives multiple insert/eject cycles without any problems.
> >
> >The patch posted by Yaacov Akiba Slama today also fixed cardbus hotplug
> >for me, but with his patch the kernel still prints "PCI: No IRQ known for
> >interrupt pin A of device xx:xx.x. Please try using pci=biosirq" when the
> >cardbus NIC is inserted; Jens Taprogge's patch silenced that warning.
> >
> >/Mikael
> >
> > 
> >

> --- drivers/pcmcia/cardbus.c.original	2003-01-14 19:38:49.000000000 +0200
> +++ drivers/pcmcia/cardbus.c	2003-01-15 18:21:40.000000000 +0200
> @@ -285,25 +285,29 @@
>  		dev->dev.dma_mask = &dev->dma_mask;
>  
>  		pci_setup_device(dev);
> -		if (pci_enable_device(dev))
> -			continue;
>  
>  		strcpy(dev->dev.bus_id, dev->slot_name);
>  
> -		/* FIXME: Do we need to enable the expansion ROM? */
> +		/* We need to assign resources for expansion ROM. */
>  		for (r = 0; r < 7; r++) {
>  			struct resource *res = dev->resource + r;
> -			if (res->flags)
> +			if (!res->start && res->end)
>  				pci_assign_resource(dev, r);
>  		}
>  
>  		/* Does this function have an interrupt at all? */
>  		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
> -		if (irq_pin) {
> +		if (irq_pin)
>  			dev->irq = irq;
> -			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
> -		}
> +		
> +		/* pci_enable_device needs to be called after pci_assign_resource */
> +		/* because it returns an error if (!res->start && res->end).      */
> +		if (pci_enable_device(dev))
> +			continue;
>  
> +		if (irq_pin)
> +			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
> +		
>  		device_register(&dev->dev);
>  		pci_insert_device(dev, bus);
>  	}


-- 
Jens Taprogge

