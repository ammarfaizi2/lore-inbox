Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKHK2I>; Wed, 8 Nov 2000 05:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQKHK17>; Wed, 8 Nov 2000 05:27:59 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:49158 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129055AbQKHK1x>; Wed, 8 Nov 2000 05:27:53 -0500
Date: Wed, 8 Nov 2000 10:19:48 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108101948.A7083@bart.dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001108013931.A26972@twiddle.net>; from rth@twiddle.net on Wed, Nov 08, 2000 at 01:39:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard.

I'm _very_ keen to try this (my Alpha won't boot 2.4 at the mo), however I
think the attachments faery has been playing tricks again.

Do you have a patch relative to 2.4.0-test10?

Sean

On Wed, Nov 08, 2000 at 01:39:31AM -0800, Richard Henderson wrote:
> [ For l-k, the issue is that pci-pci bridges and the devices behind
>   them are not initialized properly.  There are a number of Alphas
>   whose built-in scsi controlers are behind such a bridge preventing
>   these machines from booting at all.  Ivan provided an initial 
>   patch to solve this issue.  ]
> 
> I've not gotten a chance to try this on the rawhide yet,
> but I did give it a whirl on my up1000, which does have
> an agp bridge that acts like a pci bridge.
> 
> Notable changes from your patch:
> 
>   * Use kmalloc, not vmalloc.  (ouch!)
>   * Replace cropped found_vga detection code.
>   * Handle bridges with empty I/O (or MEM) ranges.
>   * Collect the proper width of the bus range.
> 
> 
> r~

Content-Description: diff vs bridges-2.4.0t10
> diff -rup linux/drivers/pci/setup-bus.c 2.4.0-11-1/drivers/pci/setup-bus.c
> --- linux/drivers/pci/setup-bus.c	Wed Nov  8 01:24:16 2000
> +++ 2.4.0-11-1/drivers/pci/setup-bus.c	Wed Nov  8 01:04:17 2000
> @@ -20,7 +20,7 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
> -#include <linux/vmalloc.h>
> +#include <linux/slab.h>
>  
>  
>  #define DEBUG_CONFIG 1
> @@ -56,31 +56,50 @@ pbus_assign_resources_sorted(struct pci_
>  			mem_reserved += 32*1024*1024;
>  			continue;
>  		}
> +
> +		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
> +			found_vga = 1;
> +
>  		pdev_sort_resources(dev, &head_io, IORESOURCE_IO);
>  		pdev_sort_resources(dev, &head_mem, IORESOURCE_MEM);
>  	}
> +
>  	for (list = head_io.next; list;) {
>  		res = list->res;
>  		idx = res - &list->dev->resource[0];
> -		if (pci_assign_resource(list->dev, idx) == 0)
> +		if (pci_assign_resource(list->dev, idx) == 0
> +		    && ranges->io_end < res->end)
>  			ranges->io_end = res->end;
>  		tmp = list;
>  		list = list->next;
> -		vfree(tmp);
> +		kfree(tmp);
>  	}
>  	for (list = head_mem.next; list;) {
>  		res = list->res;
>  		idx = res - &list->dev->resource[0];
> -		if (pci_assign_resource(list->dev, idx) == 0)
> +		if (pci_assign_resource(list->dev, idx) == 0
> +		    && ranges->mem_end < res->end)
>  			ranges->mem_end = res->end;
>  		tmp = list;
>  		list = list->next;
> -		vfree(tmp);
> +		kfree(tmp);
>  	}
> +
>  	ranges->io_end += io_reserved;
>  	ranges->mem_end += mem_reserved;
> +
> +	/* ??? How to turn off a bus from responding to, say, I/O at
> +	   all if there are no I/O ports behind the bus?  Turning off
> +	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
> +	   allow for at least one unit.  */
> +	if (ranges->io_end == ranges->io_start)
> +		ranges->io_end += 1;
> +	if (ranges->mem_end == ranges->mem_start)
> +		ranges->mem_end += 1;
> +
>  	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
>  	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
> +
>  	return found_vga;
>  }
>  
> diff -rup linux/drivers/pci/setup-res.c 2.4.0-11-1/drivers/pci/setup-res.c
> --- linux/drivers/pci/setup-res.c	Wed Nov  8 01:24:16 2000
> +++ 2.4.0-11-1/drivers/pci/setup-res.c	Wed Nov  8 00:21:13 2000
> @@ -22,10 +22,10 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
> -#include <linux/vmalloc.h>
> +#include <linux/slab.h>
>  
>  
> -#define DEBUG_CONFIG 0
> +#define DEBUG_CONFIG 1
>  #if DEBUG_CONFIG
>  # define DBGC(args)     printk args
>  #else
> @@ -146,7 +146,7 @@ pdev_sort_resources(struct pci_dev *dev,
>  			if (ln)
>  				size = ln->res->end - ln->res->start;
>  			if (r->end - r->start > size) {
> -				tmp = vmalloc(sizeof(*tmp));
> +				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
>  				tmp->next = ln;
>  				tmp->res = r;
>  				tmp->dev = dev;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
