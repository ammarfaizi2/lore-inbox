Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVHCBGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVHCBGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVHCBGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:06:02 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:25490 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261844AbVHCBFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:05:54 -0400
Message-ID: <42F0185A.7060901@jp.fujitsu.com>
Date: Wed, 03 Aug 2005 10:05:30 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
References: <200508020955.54844.bjorn.helgaas@hp.com>
In-Reply-To: <200508020955.54844.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

>  static void
> -pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
> +pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
>  {
>  	int i = 0;
>  	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -85,13 +85,13 @@
>  			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->irq_resource[i].start =(unsigned long) irq;
> -		res->irq_resource[i].end = (unsigned long) irq;
> +		res->irq_resource[i].start = irq;
> +		res->irq_resource[i].end = irq;
>  	}
>  }

This breaks the following patch that is already included into -mm
tree.

http://sourceforge.net/mailarchive/forum.php?thread_id=7844247&forum_id=6102

I think we need to check if acpi_register_gsi() succeeded or not.

Thanks,
Kenji Kaneshige



Bjorn Helgaas wrote:
> Any objections to the patch below?  I posted it last Wednesday,
> but haven't heard anything.  Once we have this fix, 8250_pnp
> should have sufficient functionality that we can get rid of
> 8250_acpi.
> 
> 
> 
> Use types that match the ACPI resource structures.  Previously
> the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> which corrupts the value.
> 
> This is one of the things that prevents 8250_pnp from working
> on HP ia64 boxes.  After 8250_pnp works, we will be able to
> remove 8250_acpi.c.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work/drivers/pnp/pnpacpi/rsparser.c
> ===================================================================
> --- work.orig/drivers/pnp/pnpacpi/rsparser.c	2005-07-25 15:04:26.000000000 -0600
> +++ work/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:02:19.000000000 -0600
> @@ -73,7 +73,7 @@
>  }
>  
>  static void
> -pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
> +pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
>  {
>  	int i = 0;
>  	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -85,13 +85,13 @@
>  			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->irq_resource[i].start =(unsigned long) irq;
> -		res->irq_resource[i].end = (unsigned long) irq;
> +		res->irq_resource[i].start = irq;
> +		res->irq_resource[i].end = irq;
>  	}
>  }
>  
>  static void
> -pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
> +pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
>  {
>  	int i = 0;
>  	while (i < PNP_MAX_DMA &&
> @@ -103,14 +103,14 @@
>  			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->dma_resource[i].start =(unsigned long) dma;
> -		res->dma_resource[i].end = (unsigned long) dma;
> +		res->dma_resource[i].start = dma;
> +		res->dma_resource[i].end = dma;
>  	}
>  }
>  
>  static void
>  pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
> -	int io, int len)
> +	u32 io, u32 len)
>  {
>  	int i = 0;
>  	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -122,14 +122,14 @@
>  			res->port_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->port_resource[i].start = (unsigned long) io;
> -		res->port_resource[i].end = (unsigned long)(io + len - 1);
> +		res->port_resource[i].start = io;
> +		res->port_resource[i].end = io + len - 1;
>  	}
>  }
>  
>  static void
>  pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
> -	int mem, int len)
> +	u64 mem, u64 len)
>  {
>  	int i = 0;
>  	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -141,8 +141,8 @@
>  			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->mem_resource[i].start = (unsigned long) mem;
> -		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
> +		res->mem_resource[i].start = mem;
> +		res->mem_resource[i].end = mem + len - 1;
>  	}
>  }
>  
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

