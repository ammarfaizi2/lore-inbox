Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULGJDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULGJDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULGJDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:03:12 -0500
Received: from [213.146.154.40] ([213.146.154.40]:65517 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261665AbULGJCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:02:45 -0500
Date: Tue, 7 Dec 2004 09:02:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Werner <werner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][AGPGART]Allow multiple backends to be initialized
Message-ID: <20041207090244.GA13591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Werner <werner@sgi.com>, linux-kernel@vger.kernel.org
References: <200412061740.52337.werner@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412061740.52337.werner@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -struct agp_bridge_data agp_bridge_dummy = { .type = NOT_SUPPORTED };
> -struct agp_bridge_data *agp_bridge = &agp_bridge_dummy;
> +agp_bridge_data_p agp_bridge;

Please don't intoroduce new new typedefs, especially not for pointer
types.

> +LIST_HEAD(agp_bridges);
>  EXPORT_SYMBOL(agp_bridge);
> -
> +EXPORT_SYMBOL(agp_bridges);

> -int agp_backend_acquire(void)
> +int agp_backend_acquire(struct pci_dev *pdev, agp_bridge_data_p 
> *acquired_bridge)
>  {
> -	if (agp_bridge->type == NOT_SUPPORTED)
> -		return -EINVAL;
> -	if (atomic_read(&agp_bridge->agp_in_use))
> +	agp_bridge_data_p bridge;
> +
> +	if (!pdev) {
> +		if (!agp_bridge)
> +			return -ENODEV;
> +		bridge = agp_bridge;
> +	} else {
> +        	list_for_each_entry(bridge, &agp_bridges, list) {
> +			int match=0;
> +			switch(pdev->class) {
> +				/* Standard bridges have a valid pci_dev */
> +				case PCI_CLASS_BRIDGE_HOST:
> +					if (bridge->dev==pdev)
> +						match=1;
> +					break;
> +				/* Non-standard bridges can use a devices pci_dev */
> +				default:
> +                			if (bridge->dev->bus==pdev->bus)
> +						match=1;
> +					break;
> +			}
> +                        if (match)
> +				break;
> +        	}
> +	}

Wrong interface.  Please pass in the pci_dev of the grpahics cards and
add a new method for lowlevel drivers to find the bridge.  For the normal
bridges (aka everything but the hp, alpha and your new driver) you'd do
a generic helper that just walks down the parent pointers until it finds
a class.

Also I'd suggest returning the found bridges as return value of the
function.

> -	printk(KERN_INFO PFX "AGP aperture is %dM @ 0x%lx\n",
> -	       size_value, bridge->gart_bus_addr);
> +	printk(KERN_INFO PFX "agp_bridge = 0x%lx: AGP aperture is %dM @ 0x%lx\n",
> +	       (unsigned long)bridge, size_value, bridge->gart_bus_addr);

pointers should be printed using %p, but this isn't a place where you should
print it at all.

