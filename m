Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHYOxY>; Sun, 25 Aug 2002 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSHYOxY>; Sun, 25 Aug 2002 10:53:24 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:28328 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317392AbSHYOxW>; Sun, 25 Aug 2002 10:53:22 -0400
Date: Sun, 25 Aug 2002 07:57:29 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>, ink@jurassic.park.msu.ru
Cc: ggs@shiresoft.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, dhinds@zen.stanford.edu
Subject: Re: [Fwd: [PATCH] reduce size of bridge regions for yenta.c]
Message-ID: <20020825075729.A14924@lucon.org>
References: <3D6874A0.5B110F6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6874A0.5B110F6@zip.com.au>; from akpm@zip.com.au on Sat, Aug 24, 2002 at 11:09:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't like it at all. That change is not right. Usually the PCI
bridge before the CardBus bridge is transparent. Please check out the
Microsoft web site. Windows allocates 64MB region for each CardBus
bridge by default and goes down from there. You should apply Ivan
Kokshaysky's PCI bridge fix first. His first patch has a typo in it.

BTW, Guy, I bought an external USB-floppy drive. It is on sale at
Fry's, $39.99. I can create a boot floopy on my Sony and boot from
it.


H.J.
On Sat, Aug 24, 2002 at 11:09:36PM -0700, Andrew Morton wrote:
> You guys may need this...
> 
> -------- Original Message --------
> Subject: [PATCH] reduce size of bridge regions for yenta.c
> Date: Sat, 24 Aug 2002 17:03:30 +0200
> From: Manfred Spraul <manfred@colorfullife.com>
> To: linux-kernel@vger.kernel.org
> CC: torvalds@transmeta.com, dhinds@zen.stanford.edu
> 
> yenta.c tries to allocate 2 bridge regions, each 4 MB: one for 
> prefetchable memory, one for non-prefetchable memory.
> 
> The size of the regions must be adaptive: in my laptop, the cardbus 
> bridge sits behind a pci bridge with a 1 MB bridge region :-(
> 
> The attached patch:
> - limits the memory window to 1/8 of the window of the parent bridge 
> (max 4 MB, min 16 kB)
> - frees the resources during module unload
> - adds error checking+printk
> 
> Please test it - my laptop now works.
> Patch vs. 2.4.19, applies to 2.5.30, too.
> 
> --
> 	Manfred
> --- 2.4/drivers/pcmcia/yenta.c	Sat Aug  3 02:39:44 2002
> +++ build-2.4/drivers/pcmcia/yenta.c	Sat Aug 24 16:59:34 2002
> @@ -2,6 +2,11 @@
>   * Regular lowlevel cardbus driver ("yenta")
>   *
>   * (C) Copyright 1999, 2000 Linus Torvalds
> + *
> + * Changelog:
> + * Aug 2002: Manfred Spraul <manfred@colorfullife.com>
> + * 	Dynamically adjust the size of the bridge resource
> + * 	
>   */
>  #include <linux/init.h>
>  #include <linux/pci.h>
> @@ -704,6 +709,15 @@
>  	return 0;
>  }
>  
> +/*
> + * Use an adaptive allocation for the memory resource,
> + * sometimes the size behind pci bridges is limited:
> + * 1/8 of the size of the io window of the parent.
> + * max 4 MB, min 16 kB.
> + */
> +#define BRIDGE_SIZE_MAX	4*1024*1024
> +#define BRIDGE_SIZE_MIN	16*1024
> +
>  static void yenta_allocate_res(pci_socket_t *socket, int nr, unsigned type)
>  {
>  	struct pci_bus *bus;
> @@ -735,21 +749,42 @@
>  	if (start && end > start) {
>  		res->start = start;
>  		res->end = end;
> -		request_resource(root, res);
> -		return;
> +		if (request_resource(root, res) == 0)
> +			return;
> +		printk(KERN_INFO "yenta %s: Preassigned resource %d busy, reconfiguring...\n",
> +				socket->dev->slot_name, nr);
> +		res->start = res->end = 0;
>  	}
>  
> -	align = size = 4*1024*1024;
> -	min = PCIBIOS_MIN_MEM; max = ~0U;
>  	if (type & IORESOURCE_IO) {
>  		align = 1024;
>  		size = 256;
>  		min = 0x4000;
>  		max = 0xffff;
> +	} else {
> +		unsigned long avail = root->end - root->start;
> +		int i;
> +		align = size = BRIDGE_SIZE_MAX;
> +		if (size > avail/8) {
> +			size=(avail+1)/8;
> +			/* round size down to next power of 2 */
> +			i = 0;
> +			while ((size /= 2) != 0)
> +				i++;
> +			size = 1 << i;
> +		}
> +		if (size < BRIDGE_SIZE_MIN)
> +			size = BRIDGE_SIZE_MIN;
> +		align = size;
> +		min = PCIBIOS_MIN_MEM; max = ~0U;
>  	}
>  		
> -	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0)
> +	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0) {
> +		printk(KERN_INFO "yenta %s: no resource of type %x available, trying to continue...\n",
> +				socket->dev->slot_name, type);
> +		res->start = res->end = 0;
>  		return;
> +	}
>  
>  	config_writel(socket, offset, res->start);
>  	config_writel(socket, offset+4, res->end);
> @@ -767,6 +802,20 @@
>  }
>  
>  /*
> + * Free the bridge mappings for the device..
> + */
> +static void yenta_free_resources(pci_socket_t *socket)
> +{
> +	int i;
> +	for (i=0;i<4;i++) {
> +		struct resource *res;
> +		res = socket->dev->resource + PCI_BRIDGE_RESOURCES + i;
> +		if (res->start != 0 && res->end != 0)
> +			release_resource(res);
> +		res->start = res->end = 0;
> +	}
> +}
> +/*
>   * Close it down - release our resources and go home..
>   */
>  static void yenta_close(pci_socket_t *sock)
> @@ -782,6 +831,7 @@
>  
>  	if (sock->base)
>  		iounmap(sock->base);
> +	yenta_free_resources(sock);
>  }
>  
>  #include "ti113x.h"
> 

