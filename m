Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933156AbWKWTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbWKWTdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757454AbWKWTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:33:44 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:41856 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1757452AbWKWTdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:33:43 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 3/5] PCI : Add selected_regions funcs
Date: Thu, 23 Nov 2006 20:33:32 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
References: <456404FE.1040708@jp.fujitsu.com>
In-Reply-To: <456404FE.1040708@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611232033.35280.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidetoshi Seto,

bitfields (and bitmask) should be unsigned and use machine word size,
which is usually "long". So please pass them in "unsigned long" instead of "int".

On Wednesday, 22. November 2006 09:06, Hidetoshi Seto wrote:
> --- linux-2.6.19-rc6.orig/drivers/pci/pci.c
> +++ linux-2.6.19-rc6/drivers/pci/pci.c
> @@ -758,6 +758,47 @@
>  	return -EBUSY;
>  }
> 
> +/**
> + * pci_release_selected_regions - Release selected PCI I/O and memory resources
> + * @pdev: PCI device whose resources were previously reserved
> + * @bars: Bitmask of BARs to be released
> + *
> + * Release selected PCI I/O and memory resources previously reserved.
> + * Call this function only after all use of the PCI regions has ceased.
> + */
> +void pci_release_selected_regions(struct pci_dev *pdev, int bars)

"unsigned long bars" here 

> +{
> +	int i;

"unsigned long i" here

> +
> +	for (i = 0; i < 6; i++)
> +		if (bars & (1 << i))
> +			pci_release_region(pdev, i);
> +}
> +
> +/**
> + * pci_request_selected_regions - Reserve selected PCI I/O and memory resources
> + * @pdev: PCI device whose resources are to be reserved
> + * @bars: Bitmask of BARs to be requested
> + * @res_name: Name to be associated with resource
> + */
> +int pci_request_selected_regions(struct pci_dev *pdev, int bars,
> +				 const char *res_name)
> +{

"unsigned long bars" here

> +	int i;

"unsigned long i" here

> @@ -975,6 +1002,22 @@
>  }
>  #endif
> 
> +/**
> + * pci_select_bars - Make BAR mask from the type of resource
> + * @pdev: the PCI device for which BAR mask is made
> + * @flags: resource type mask to be selected
> + *
> + * This helper routine makes bar mask from the type of resource.
> + */
> +int pci_select_bars(struct pci_dev *dev, unsigned long flags)

unsigned long pci_select_bars(struct pci_dev *dev, unsigned long flags)

> +{
> +	int i, bars = 0;

"unsigned long i, bars" here

> +	for (i = 0; i < PCI_NUM_RESOURCES; i++)
> +		if (pci_resource_flags(dev, i) & flags)
> +			bars |= (1 << i);
> +	return bars;
> +}
> +
>  static int __devinit pci_init(void)
>  {
>  	struct pci_dev *dev = NULL;
> @@ -1023,6 +1066,8 @@
>  EXPORT_SYMBOL(pci_request_regions);
>  EXPORT_SYMBOL(pci_release_region);
>  EXPORT_SYMBOL(pci_request_region);
> +EXPORT_SYMBOL(pci_release_selected_regions);
> +EXPORT_SYMBOL(pci_request_selected_regions);
>  EXPORT_SYMBOL(pci_set_master);
>  EXPORT_SYMBOL(pci_set_mwi);
>  EXPORT_SYMBOL(pci_clear_mwi);
> @@ -1031,6 +1076,7 @@
>  EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>  EXPORT_SYMBOL(pci_assign_resource);
>  EXPORT_SYMBOL(pci_find_parent_resource);
> +EXPORT_SYMBOL(pci_select_bars);
> 
>  EXPORT_SYMBOL(pci_set_power_state);
>  EXPORT_SYMBOL(pci_save_state);
> Index: linux-2.6.19-rc6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.19-rc6.orig/include/linux/pci.h
> +++ linux-2.6.19-rc6/include/linux/pci.h
> @@ -514,6 +514,7 @@
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>  int __must_check pci_assign_resource_fixed(struct pci_dev *dev, int i);
>  void pci_restore_bars(struct pci_dev *dev);
> +int pci_select_bars(struct pci_dev *dev, unsigned long flags);

unsigned long pci_select_bars(struct pci_dev *dev, unsigned long flags)

> 
>  /* ROM control related routines */
>  void __iomem __must_check *pci_map_rom(struct pci_dev *pdev, size_t *size);
> @@ -542,6 +543,8 @@
>  void pci_release_regions(struct pci_dev *);
>  int __must_check pci_request_region(struct pci_dev *, int, const char *);
>  void pci_release_region(struct pci_dev *, int);
> +int pci_request_selected_regions(struct pci_dev *, int, const char *);
> +void pci_release_selected_regions(struct pci_dev *, int);

int pci_request_selected_regions(struct pci_dev *, unsigned long, const char *); 
void pci_release_selected_regions(struct pci_dev *, unsigned long);


Regards

Ingo Oeser
