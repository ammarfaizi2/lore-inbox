Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284133AbRLFP4G>; Thu, 6 Dec 2001 10:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbRLFPz5>; Thu, 6 Dec 2001 10:55:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:49157 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284133AbRLFPzo>; Thu, 6 Dec 2001 10:55:44 -0500
Date: Thu, 6 Dec 2001 12:39:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix pcmcia errors
In-Reply-To: <15374.54521.402903.123657@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.21.0112061238210.20750-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul, 

As David commented, you're using PCI code unconditionally.

Could you please fix that ? 


On Thu, 6 Dec 2001, Paul Mackerras wrote:

> Marcelo,
> 
> The PCMCIA patch that I sent you and which you included in 2.4.17-pre2
> turns out to have a case where it can get a NULL pointer dereference.
> The patch below fixes that.  I posted this patch on the list earlier
> and the person who was having the problem (Alan Ford) reported that it
> fixes the problem for him, so please include this patch in your next
> release.
> 
> Thanks,
> Paul.
> 
> diff -urN linux-2.4.17-pre2/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
> --- linux-2.4.17-pre2/drivers/pcmcia/rsrc_mgr.c	Sat Dec  1 15:49:24 2001
> +++ pmac/drivers/pcmcia/rsrc_mgr.c	Mon Dec  3 14:28:16 2001
> @@ -107,17 +107,19 @@
>  static struct resource *resource_parent(unsigned long b, unsigned long n,
>  					int flags, struct pci_dev *dev)
>  {
> -	struct resource res;
> +	struct resource res, *pr;
>  
> -	if (dev == NULL) {
> -		if (flags & IORESOURCE_MEM)
> -			return &iomem_resource;
> -		return &ioport_resource;
> +	if (dev != NULL) {
> +		res.start = b;
> +		res.end = b + n - 1;
> +		res.flags = flags;
> +		pr = pci_find_parent_resource(dev, &res);
> +		if (pr)
> +			return pr;
>  	}
> -	res.start = b;
> -	res.end = b + n - 1;
> -	res.flags = flags;
> -	return pci_find_parent_resource(dev, &res);
> +	if (flags & IORESOURCE_MEM)
> +		return &iomem_resource;
> +	return &ioport_resource;
>  }
>  
>  static inline int check_io_resource(unsigned long b, unsigned long n,
> 

