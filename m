Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVFGPuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVFGPuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVFGPuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:50:06 -0400
Received: from colo.lackof.org ([198.49.126.79]:56256 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261910AbVFGPtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:49:46 -0400
Date: Tue, 7 Jun 2005 09:53:24 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607155324.GA29220@colo.lackof.org>
References: <20050607002045.GA12849@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607002045.GA12849@suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 05:20:45PM -0700, Greg KH wrote:
> -EXPORT_SYMBOL(pci_enable_msi);
> -EXPORT_SYMBOL(pci_disable_msi);
> +//EXPORT_SYMBOL(pci_enable_msi);
> +//EXPORT_SYMBOL(pci_disable_msi);

You do plan on deleting these lines, right? (Just a reminder)

> --- gregkh-2.6.orig/drivers/pci/pci.c	2005-06-06 16:16:30.000000000 -0700
> +++ gregkh-2.6/drivers/pci/pci.c	2005-06-06 16:20:06.000000000 -0700
> @@ -402,6 +402,7 @@
>  	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
>  		return err;
>  	pci_fixup_device(pci_fixup_enable, dev);
> +	pci_enable_msi(dev);
>  	dev->is_enabled = 1;
>  	return 0;
>  }

I'm wondering if it would be better/possible to call
enable_msi before calling fixup_device.
But I couldn't find any references to DECLARE_PCI_FIXUP_ENABLE
to see if it would matter.


> @@ -427,7 +428,8 @@
>  pci_disable_device(struct pci_dev *dev)
>  {
>  	u16 pci_command;
> -	
> +
> +	pci_disable_msi(dev);
>  	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>  	if (pci_command & PCI_COMMAND_MASTER) {
>  		pci_command &= ~PCI_COMMAND_MASTER;

reminder: you probably need to check that msi is still enabled
here or in pci_disable_msi(). I'm thinking of the case where
the driver switched to MSI-X.


> +#ifndef CONFIG_PCI_MSI
> +static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
> +static inline void pci_disable_msi(struct pci_dev *dev) {}
> +#else
> +extern int pci_enable_msi(struct pci_dev *dev);
> +extern void pci_disable_msi(struct pci_dev *dev);
> +#endif

wouldn't it make more sense to invert this to "ifdef" (vs ifndef)?

> @@ -398,8 +397,6 @@
>  	/* Switch to INTx by default if MSI enabled */
>  	if (interrupt_mode == PCIE_PORT_MSIX_MODE)
>  		pci_disable_msix(dev);
> -	else if (interrupt_mode == PCIE_PORT_MSI_MODE)
> -		pci_disable_msi(dev);

Why disable msix here but not msi?
This doesn't seem like a good design choice.
I'm suspicious more occurrances will need special handling of MSIX.

Will assign_interrupt_mode() in drivers/pci/pcie/portdrv_core.c
need more changes to deal with the switch to/from MSI/MSIX?


> +++ gregkh-2.6/drivers/net/tg3.c	2005-06-06 16:57:34.000000000 -0700
> @@ -5984,7 +5984,6 @@
>  		       tp->dev->name);
>  
>  	free_irq(tp->pdev->irq, dev);
> -	pci_disable_msi(tp->pdev);
>  
>  	tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;

This chunk of tg3 code will need more than just deleting
the call to pci_disable_msi(). The printk will be wrong
and it's changing the semantics of what TG3_FLG2_USING_MSI
means.

> @@ -6047,7 +6046,7 @@
>  		if (!(tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)) {
>  			printk(KERN_WARNING PFX "%s: MSI without TAGGED? "
>  			       "Not using MSI.\n", tp->dev->name);
> -		} else if (pci_enable_msi(tp->pdev) == 0) {
> +		} else if (pci_in_msi_mode(tp->pdev)) {

Again - the "Not Using MSI" msg here needs more help to be correct.


hth,
grant
