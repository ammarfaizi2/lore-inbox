Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWGAREW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWGAREW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWGAREW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:24980 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751536AbWGAREW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:04:22 -0400
Date: Sat, 1 Jul 2006 10:00:50 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <brice@myri.com>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060701170050.GA2727@kroah.com>
References: <20060701033524.3c478698.akpm@osdl.org> <44A657B8.7040702@reub.net> <20060701045100.88c4eadc.akpm@osdl.org> <44A66B17.50008@reub.net> <44A67346.5030705@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A67346.5030705@myri.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 09:06:14AM -0400, Brice Goglin wrote:
> Reuben Farrelly wrote:
> >>
> >> It oopsed here:
> >>
> >> static
> >> int pci_msi_supported(struct pci_dev * dev)
> >> {
> >>     struct pci_dev *pdev;
> >>
> >>     if (!pci_msi_enable || !dev || dev->no_msi)
> >>         return -1;
> >>
> >>     /* find root complex for our device */
> >>     pdev = dev;
> >>     while (pdev->bus && pdev->bus->self)
> >>         pdev = pdev->bus->self;
> >>
> >>     /* check its bus flags */
> >>     if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> >>         return -1;
> >>
> >>     return 0;
> >> }
> >>
> >> pdev->subordinate is NULL.
> >>
> >
> >> You may find that this gets things going again:
> >>
> >> --- a/drivers/pci/msi.c~a
> >> +++ a/drivers/pci/msi.c
> >> @@ -913,6 +913,9 @@ int pci_msi_supported(struct pci_dev * d
> >>      while (pdev->bus && pdev->bus->self)
> >>          pdev = pdev->bus->self;
> >>  
> >> +    if (!pdev->subordinate)
> >> +        return -1;
> >> +
> >>      /* check its bus flags */
> >>      if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> >>          return -1;
> >> _
> > Yes it does.
> 
> I was not expecting a root chipset without subordinate bus... Maybe we
> should store the NO_MSI flags in the device itself instead of in its
> subordinate bus (I would have to rework all my patches then).

If that solves this issue, I guess so.

> After all,
> we don't inherit bus flags anymore, and I don't see why bus flags would
> have been chosen initially except to help flags inheritance.
> I am still convinced that checking to root chipset (bus) flags only is a
> good idea since the root chipset is where MSI are translated from PCI
> messages into DMA (we don't care about MSI support in the bridges
> between the chipset and the devices since they only forward PCI messages).

Yes, I agree with that, just be able to handle the above issue too :)

thanks,

greg k-h
