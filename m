Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVKPGrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVKPGrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVKPGrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:47:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:39050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751184AbVKPGqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:46:55 -0500
Date: Tue, 15 Nov 2005 22:21:54 -0800
From: Greg KH <gregkh@suse.de>
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] PCI PM: capability probing and setup
Message-ID: <20051116062154.GB31375@suse.de>
References: <1132111878.9809.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132111878.9809.52.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:17PM -0500, Adam Belay wrote:
> +int pci_setup_device_pm(struct pci_dev *dev)

Care to give kernel doc for this new function?

> +{
> +	int pm;
> +	u16 pmcsr, pmc;
> +	struct pci_dev_pm *pm_data;
> +
> +	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> +	if (!pm) {
> +		dev->current_state = PCI_D0;
> +		return 0;
> +	}
> +
> +	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> +
> +	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
> +		printk(KERN_DEBUG
> +		       "PCI: %s has unsupported PM cap regs version (%u)\n",
> +		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
> +		return -EIO;
> +	}
> +
> +	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
> +	if (!pm_data)
> +		return -ENOMEM;
> +
> +	memset(pm_data, 0, sizeof(struct pci_dev_pm));
> +
> +	pm_data->pm_offset = pm;
> +
> +	/* determine supported device states */
> +	/* all PM capable devices support at least D0 and D3 */
> +	pm_data->state_mask |= ((1 << PCI_D0) | (1 << PCI_D3hot));
> +	if (pmc & PCI_PM_CAP_D1)
> +		pm_data->state_mask |= (1 << PCI_D1);
> +	if (pmc & PCI_PM_CAP_D2)
> +		pm_data->state_mask |= (1 << PCI_D2);
> +
> +	/* PME capabilities */
> +	pm_data->pme_mask = ((pmc & PCI_PM_CAP_PME_MASK)
> +			 >> (ffs(PCI_PM_CAP_PME_MASK) - 1));
> +
> +	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
> +
> +	/* device context retention */
> +	pm_data->dsi = (pmc & PCI_PM_CAP_DSI) ? 1 : 0;
> +	pm_data->no_soft_reset = (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) ? 1 : 0;
> +
> +	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +
> +	return 0;
> +}
> --- a/drivers/pci/probe.c	2005-11-07 08:08:00.000000000 -0500
> +++ b/drivers/pci/probe.c	2005-11-07 08:05:10.000000000 -0500
> @@ -601,8 +601,7 @@
>  	pr_debug("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
>  		 dev->vendor, dev->device, class, dev->hdr_type);
>  
> -	/* "Unknown power state" */
> -	dev->current_state = PCI_UNKNOWN;
> +	pci_setup_device_pm(dev);
>  
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
> --- a/include/linux/pci.h	2005-11-07 08:08:00.000000000 -0500
> +++ b/include/linux/pci.h	2005-11-07 08:02:55.000000000 -0500
> @@ -68,6 +68,18 @@
>  #define DEVICE_COUNT_COMPATIBLE	4
>  #define DEVICE_COUNT_RESOURCE	12
>  
> +struct pci_dev_pm {
> +	unsigned int	pm_offset;	/* the PCI PM capability offset */
> +
> +	unsigned int	dsi:1;		/* vendor-specific initialization needed
> +					   after a reset */
> +	unsigned int	no_soft_reset:1; /* PCI config context retained when
> +					    going from D3_hot to D0 */
> +
> +	unsigned char	state_mask;	/* a mask of supported power states */
> +	unsigned char	pme_mask;	/* a mask of power states that allow #PME */ 

Trailing space, use quilt it strips this :)

> +	struct pci_dev_pm *pm;		/* power management information */

Why make this a pointer and not just part of this structure?  Don't all
pci devices need this?

thanks,

greg k-h
