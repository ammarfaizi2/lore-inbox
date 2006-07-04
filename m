Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWGDHGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGDHGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGDHGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:06:47 -0400
Received: from colo.lackof.org ([198.49.126.79]:40859 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751111AbWGDHGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:06:46 -0400
Date: Tue, 4 Jul 2006 01:06:43 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent busses flags
Message-ID: <20060704070643.GA16632@colo.lackof.org>
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703004055.835863000@myri.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 08:40:02PM -0400, Brice Goglin wrote:
> MSI only requires support in the root chipset, which may not even have
> a subordinate bus.

Brice,
The above comment and the main part of this patch don't look right to me.
Maybe it's the glass of wine I had two hours ago and it's around midnight
now...

If the "root chipset" is not a PCI device and the architecture doesn't
fake it, the root chipset (aka "PCI Host bus controller") is not visible
to PCI subsystem. Some of the arch code (e.g. drivers/parisc/dino.c)
uses "bus->self == NULL" to differentiate between PCI-PCI secondary busses
and PCI bus below a "root chipset". ISTR alpha and sparc doing the same.

Can you confirm I'm remembering/understanding this bit correctly?

> pci_msi_supported() now checks the no_msi flag in the root_chipset pci_dev
> struct instead of the PCI_BUS_FLAGS_NO_MSI flag of all its parent busses.
> The MSI quirk now sets the no_msi flag accordingly.

I don't see how this could work for alpha/parisc/sparc (IIRC) or any other
architecture that doesn't create "fake" PCI Root busses.
I think your previous patch was correct in this regard.

> Index: linux-git/drivers/pci/msi.c
> ===================================================================
> --- linux-git.orig/drivers/pci/msi.c	2006-07-02 20:28:28.000000000 -0400
> +++ linux-git/drivers/pci/msi.c	2006-07-02 20:28:58.000000000 -0400
> @@ -905,19 +905,24 @@
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   *
>   * MSI must be globally enabled and supported by the device and
> - * its parent busses.
> + * its root chipset.
>   **/
>  static
>  int pci_msi_supported(struct pci_dev * dev)
>  {
> -	struct pci_bus *bus;
> +	struct pci_dev *pdev;
>  
>  	if (!pci_msi_enable || !dev || dev->no_msi)
>  		return -1;
>  
> -	for (bus = dev->bus; bus; bus = bus->parent)
> -		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> -			return -1;
> +	/* find root complex for our device */
> +	pdev = dev;
> +	while (pdev->bus && pdev->bus->self)
> +		pdev = pdev->bus->self;

In particular, I'm thinking this loop isn't correct though I'm not
in a particular, erm, "certain" frame of mind right now.
Under a parisc root device, pdev->bus->self would be NULL.

Maybe that's why parisc uses pci_scan_bus_parented()
instead of pci_scan_bus(). (I've forgot the background
behind that change).

thanks,
grant
