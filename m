Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVLAVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVLAVlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVLAVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:41:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:6291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932490AbVLAVlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:41:39 -0500
Date: Thu, 1 Dec 2005 13:40:03 -0800
From: Greg KH <gregkh@suse.de>
To: "Yeisley, Dan P." <dan.yeisley@unisys.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.15-rc3-mm1] PCI Quirk: 1K I/O Space Granularity on Intel P64H2
Message-ID: <20051201214002.GA22539@suse.de>
References: <94C8C9E8B25F564F95185BDA64AB05F60298EA04@USTR-EXCH5.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94C8C9E8B25F564F95185BDA64AB05F60298EA04@USTR-EXCH5.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 02:37:03PM -0500, Yeisley, Dan P. wrote:
> I've implemented a quirk to take advantage of the 1KB I/O space
> granularity option on the Intel P64H2 PCI Bridge.  I had to change
> probe.c because it sets the resource start and end to be aligned on 4k
> boundaries (after the quirk sets them to 1k boundaries).  I've tested
> this patch on a Unisys ES7000-600 both with and without the 1KB option
> enabled.  I also tested this on a 2 processor Dell box that doesn't have
> a P64H2 to make sure there were no negative affects there.
> 
> Signed-off-by: Dan Yeisley <dan.yeisley@unisys.com>
> ---
> 
> 
> diff -Naur linux-a/drivers/pci/probe.c linux-b/drivers/pci/probe.c
> --- linux-a/drivers/pci/probe.c	2005-12-01 01:07:30.000000000 -0800
> +++ linux-b/drivers/pci/probe.c	2005-11-30 05:13:41.000000000 -0800
> @@ -264,8 +264,10 @@
>  
>  	if (base <= limit) {
>  		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) |
> IORESOURCE_IO;

Your patch is linewrapped and can not be applied :(

Care to try again?

> -		res->start = base;
> -		res->end = limit + 0xfff;
> +		if(!res->start)
> +			res->start = base;
> +		if(!res->end)
> +			res->end = limit + 0xfff;

Why is this necessary, if your quirk already sets these values?

>  	}
>  
>  	res = child->resource[1];
> diff -Naur linux-a/drivers/pci/quirks.c linux-b/drivers/pci/quirks.c
> --- linux-a/drivers/pci/quirks.c	2005-12-01 01:07:30.000000000
> -0800
> +++ linux-b/drivers/pci/quirks.c	2005-12-01 01:10:41.000000000
> -0800
> @@ -1312,6 +1312,35 @@
>  	pci_do_fixups(dev, start, end);
>  }
>  
> +/*
> +** Intel P64H2 PCI Bridge
> +** 	Enable 1k I/O space granularity
> +*/

That's a very odd function comment format.  Care to use the standard
kernel format instead?

> +static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
> +{
> +	u16 en1k;
> +	u8 io_base_lo, io_limit_lo;
> +	unsigned long base, limit;
> +	struct resource *res = dev->resource + PCI_BRIDGE_RESOURCES;
> +
> +	pci_read_config_word(dev, 0x40, &en1k);
> +
> +	if(en1k & 0x200) {

Space after "if" and before "(" please.

> +		printk(KERN_INFO "PCI: Enable I/O Space to 1 KB
> Granularity\n");
> +
> +		pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
> +		pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
> +		base = (io_base_lo & (PCI_IO_RANGE_MASK | 0x0c)) << 8;
> +		limit = (io_limit_lo & (PCI_IO_RANGE_MASK | 0x0c)) << 8;
> +
> +		if(base <= limit) {

Space after "if" and before "(" please.

thanks,

greg k-h
