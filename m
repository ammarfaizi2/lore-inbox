Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWEUNJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWEUNJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWEUNJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:09:14 -0400
Received: from [194.90.237.34] ([194.90.237.34]:18232 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964827AbWEUNJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:09:13 -0400
Date: Sun, 21 May 2006 16:10:25 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Brice Goglin <brice@myri.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060521131025.GR30211@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44705DA4.2020807@myri.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 21 May 2006 13:13:11.0859 (UTC) FILETIME=[4FB3A030:01C67CD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Brice Goglin <brice@myri.com>:
> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
> 
> Michael S. Tsirkin wrote:
> > MSI is an optional feature so things are supposed to work even without MSI -
> > are you getting that great a benefit from MSI?
> >   
> 
> Not great, I would say small.

Me too.

> > All mellanox PCI-X devices have a bridge inside them, so ...
> >   
> 
> Ok so you really need something for 2.6.17. What about the attached
> patch to fix the fact that bus flags are not inherited ?
> 
> Signed-off-by: Brice Goglin <brice@myri.com>

Seems to work for MSI but not for MSI-X. With MSI-X, I still see:

ib_mthca 0000:04:00.0: NOP command failed to generate interrupt (IRQ 217),
aborting.
ib_mthca 0000:04:00.0: Try again with MSI/MSI-X disabled.


> > Doesn't seem to work for me:
> >
> > ib_mthca: Initializing 0000:04:00.0
> > GSI 18 sharing vector 0xB9 and IRQ 18
> > ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 29 (level, low) -> IRQ 185
> > ib_mthca 0000:04:00.0: NOP command failed to generate interrupt (IRQ 217),
> > aborting.
> > ib_mthca 0000:04:00.0: Try again with MSI/MSI-X disabled.
> > ACPI: PCI interrupt for device 0000:04:00.0 disabled
> > ib_mthca: probe of 0000:04:00.0 failed with error -16
> >   
> 
> Ok. Do you at least see the quirk message ?

Yes.

> Thanks,
> Brice
> 
> 
> Index: linux-mm/drivers/pci/msi.c
> ===================================================================
> --- linux-mm.orig/drivers/pci/msi.c	2006-05-21 14:25:53.000000000 +0200
> +++ linux-mm/drivers/pci/msi.c	2006-05-21 14:26:56.000000000 +0200
> @@ -916,6 +916,7 @@
>   **/
>  int pci_enable_msi(struct pci_dev* dev)
>  {
> +	struct pci_bus *bus;
>  	int pos, temp, status = -EINVAL;
>  	u16 control;
>  
> @@ -925,8 +926,9 @@
>  	if (dev->no_msi)
>  		return status;
>  
> -	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> -		return -EINVAL;
> +	for (bus = dev->bus; bus; bus = bus->parent)
> +		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> +			return -EINVAL;
>  
>  	temp = dev->irq;
>  
> 
> 

It seems we must add this loop to pci_enable_msix as well.

-- 
MST
