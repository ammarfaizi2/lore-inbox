Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130494AbRCDMXo>; Sun, 4 Mar 2001 07:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130495AbRCDMXe>; Sun, 4 Mar 2001 07:23:34 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:53255 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130494AbRCDMXP>; Sun, 4 Mar 2001 07:23:15 -0500
Date: Sun, 4 Mar 2001 15:19:10 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support
Message-ID: <20010304151910.A29393@jurassic.park.msu.ru>
In-Reply-To: <200103021932.LAA29704@milano.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103021932.LAA29704@milano.cup.hp.com>; from grundler@cup.hp.com on Fri, Mar 02, 2001 at 11:32:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 11:32:35AM -0800, Grant Grundler wrote:
> Code in parisc-linux CVS (based on 2.4.0) does boot on my OB800
> (133Mhz Pentium), C3000, and A500 with PCI-PCI bridge support
> working. I'm quite certain PCI-PCI bridge configuration (ie BIOS
> didn't configure the bridge) support was broken.

I believe it isn't. ;-) It works on various alphas including
configurations with chained PCI-PCI bridges.
Some comments on the patch:

> +** If I/O or MEM ranges are overlapping, that's a BIOS bug.

No. As we reallocate everything, it is quite possible that we'll
have temporary overlaps during setup with resources allocated
by BIOS. I'm not sure if it is harmful though.

> +#ifdef __hppa__
> +/* XXX FIXME
> +** PCI_BRIDGE_CONTROL and PCI_COMMAND programming need to be revisited
> +** to support FBB.  Make all this crud "configurable" by the arch specific
> +** (ie "PCI BIOS") support and the ifdef __hppa__ crap can go away then.
> +*/

Agreed. Something like pcibios_set_bridge_control().

>  	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
>  		struct pci_bus *b = pci_bus_b(ln);
>  
> -		b->resource[0]->start = ranges->io_start = ranges->io_end;
> -		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
> -
> +		ranges->io_start = ranges->io_end;
> +		ranges->mem_start = ranges->mem_end;
>  		pbus_assign_resources(b, ranges);
> -
> -		b->resource[0]->end = ranges->io_end - 1;
> -		b->resource[1]->end = ranges->mem_end - 1;
> -
>  		pci_setup_bridge(b);
>  	}

This change totally breaks PCI allocation logic.
Probably you assign PCI-PCI bridge windows in arch specific
code - why?
The only thing you need is to set up the root bus resources
properly and generic code will do the rest.

> +#ifndef __hppa__
>  		/* PCI-PCI bridges may have I/O ports or
>  		   memory on the primary bus */
>  		if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI &&
>  						i >= PCI_BRIDGE_RESOURCES)
>  			continue;
> +#endif

Same here.

Ivan.
