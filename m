Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVGBHZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVGBHZt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 03:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGBHZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 03:25:49 -0400
Received: from colo.lackof.org ([198.49.126.79]:5357 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261837AbVGBHZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 03:25:39 -0400
Date: Sat, 2 Jul 2005 01:29:54 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050702072954.GA14091@colo.lackof.org>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701022634.GA5629.1@tuxdriver.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:26:37PM -0400, John W. Linville wrote:
...
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -378,9 +378,56 @@ pci_restore_state(struct pci_dev *dev)
>  int
>  pci_enable_device_bars(struct pci_dev *dev, int bars)
>  {
> -	int err;
> +	int i, numres, err;
>  
>  	pci_set_power_state(dev, PCI_D0);
> +
> +	/* Some devices lose PCI config header data during D3hot->D0

Can you name some of those devices here?
I just want to know what sort of devices need to be tested 
if this code changes in the future.

> +	   transition.	Since some firmware leaves devices in D3hot
> +	   state at boot, this information needs to be restored.

Again, which firmware?
Examples are good since it makes it possible to track down
the offending devices for testing.

The following chunk looks like it will have issues with 64-bit BARs:
...
> +	for (i = 0; i < numres; i ++) {
> +		struct pci_bus_region region;
> +		u32 val;
> +		int reg;
...
> +		val = region.start
> +		    | (dev->resource[i].flags & PCI_REGION_FLAG_MASK);
> +
> +		reg = PCI_BASE_ADDRESS_0 + (i * 4);

ISTR dev->resource[i] doesn't necessarily correspond directly BAR[i].
If BAR0 is a 64-bit BAR, then dev->resource[1] will point at BAR2.

I'm not sure how to fix this since I'm not quite sure where
state is being saved off from.

> +		pci_write_config_dword(dev, reg, val);
> +
> +		if ((val & (PCI_BASE_ADDRESS_SPACE
> +		          | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
> +		 == (PCI_BASE_ADDRESS_SPACE_MEMORY
> +		   | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> +			pci_write_config_dword(dev, reg + 4, 0);

64-bit BARs need the upper half of dev->resource[] written.
I expect something like:
		val = region.start >> 4;
		pci_write_config_dword(dev, reg + 4, val);

This should put zero in the upper 32-bit if it's only a 32-bit value.
I suspect "i" needs to be split into two indices: one for dev->resource[]
and another for offset into PCI config space (BARs).
But it really depends on how dev->resource[] maps to the BARs.

hth,
grant

> +		}
> +	}
> +
>  	if ((err = pcibios_enable_device(dev, bars)) < 0)
>  		return err;
>  	return 0;
> -- 
> John W. Linville
> linville@tuxdriver.com
