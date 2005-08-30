Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVH3QWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVH3QWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVH3QWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:22:46 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:34703 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S932202AbVH3QWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:22:45 -0400
Date: Tue, 30 Aug 2005 19:22:04 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
X-X-Sender: teanropo@kanto
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86: pci_assign_unassigned_resources() update
In-Reply-To: <20050830184852.A25380@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0508301921080.17329@kanto>
References: <20050830184852.A25380@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Tue, 30 Aug 2005 19:22:36 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Ivan Kokshaysky wrote:

>
> Tero, can you confirm that 2.6.13 with this patch works for you?
>
> Ivan.

Confirmed. Vanilla 2.6.13 with this patch works for me.

-
Tero Roponen


>
> --- 2.6.13/arch/i386/pci/common.c	2005-08-29 03:41:01.000000000 +0400
> +++ linux/arch/i386/pci/common.c	2005-08-30 13:44:24.000000000 +0400
> @@ -165,7 +165,6 @@ static int __init pcibios_init(void)
>  	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
>  		pcibios_sort();
>  #endif
> -	pci_assign_unassigned_resources();
>  	return 0;
>  }
>
> --- 2.6.13/arch/i386/pci/i386.c	2005-08-29 03:41:01.000000000 +0400
> +++ linux/arch/i386/pci/i386.c	2005-08-30 17:35:03.000000000 +0400
> @@ -170,43 +170,26 @@ static void __init pcibios_allocate_reso
>  static int __init pcibios_assign_resources(void)
>  {
>  	struct pci_dev *dev = NULL;
> -	int idx;
> -	struct resource *r;
> +	struct resource *r, *pr;
>
> -	for_each_pci_dev(dev) {
> -		int class = dev->class >> 8;
> -
> -		/* Don't touch classless devices and host bridges */
> -		if (!class || class == PCI_CLASS_BRIDGE_HOST)
> -			continue;
> -
> -		for(idx=0; idx<6; idx++) {
> -			r = &dev->resource[idx];
> -
> -			/*
> -			 *  Don't touch IDE controllers and I/O ports of video cards!
> -			 */
> -			if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
> -			    (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
> -				continue;
> -
> -			/*
> -			 *  We shall assign a new address to this resource, either because
> -			 *  the BIOS forgot to do so or because we have decided the old
> -			 *  address was unusable for some reason.
> -			 */
> -			if (!r->start && r->end)
> -				pci_assign_resource(dev, idx);
> -		}
> -
> -		if (pci_probe & PCI_ASSIGN_ROMS) {
> +	if (!(pci_probe & PCI_ASSIGN_ROMS)) {
> +		/* Try to use BIOS settings for ROMs, otherwise let
> +		   pci_assign_unassigned_resources() allocate the new
> +		   addresses. */
> +		for_each_pci_dev(dev) {
>  			r = &dev->resource[PCI_ROM_RESOURCE];
> -			r->end -= r->start;
> -			r->start = 0;
> -			if (r->end)
> -				pci_assign_resource(dev, PCI_ROM_RESOURCE);
> +			if (!r->flags || !r->start)
> +				continue;
> +			pr = pci_find_parent_resource(dev, r);
> +			if (!pr || request_resource(pr, r) < 0) {
> +				r->end -= r->start;
> +				r->start = 0;
> +			}
>  		}
>  	}
> +
> +	pci_assign_unassigned_resources();
> +
>  	return 0;
>  }
>
> --- 2.6.13/drivers/pci/setup-bus.c	2005-08-29 03:41:01.000000000 +0400
> +++ linux/drivers/pci/setup-bus.c	2005-08-30 13:44:24.000000000 +0400
> @@ -40,7 +40,7 @@
>   * FIXME: IO should be max 256 bytes.  However, since we may
>   * have a P2P bridge below a cardbus bridge, we need 4K.
>   */
> -#define CARDBUS_IO_SIZE		(256)
> +#define CARDBUS_IO_SIZE		(4*1024)
>  #define CARDBUS_MEM_SIZE	(32*1024*1024)
>
>  static void __devinit
>
