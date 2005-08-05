Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVHEW24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVHEW24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVHEW24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:28:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261986AbVHEW16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:27:58 -0400
Date: Fri, 5 Aug 2005 15:26:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-Id: <20050805152645.60c0e8d4.akpm@osdl.org>
In-Reply-To: <1123279513.4706.7.camel@whizzy>
References: <1123259263.8917.9.camel@whizzy>
	<20050805183505.GA32405@kroah.com>
	<1123279513.4706.7.camel@whizzy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi <kristen.c.accardi@intel.com> wrote:
>
> ...
> On the 6700/6702 PXH part, a MSI may get corrupted if an ACPI hotplug
> driver and SHPC driver in MSI mode are used together.  This patch will
> prevent MSI from being enabled for the SHPC.  
> 
> I made this patch more generic than just shpc because I thought it was
> possible that other devices in the system might need to add themselves
> to the msi black list.
> 
> diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/msi.c linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c
> --- linux-2.6.13-rc4/drivers/pci/msi.c	2005-07-28 15:44:44.000000000 -0700
> +++ linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c	2005-08-05 11:38:00.000000000 -0700
> @@ -38,6 +38,32 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
>  u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
>  #endif
>  
> +
> +LIST_HEAD(msi_quirk_list);
> +

Can't this have static scope?

> +struct msi_quirk 
> +{
> +	struct list_head list;
> +	struct pci_dev *dev;
> +};

We normally do

	struct msi_quirk {

> +
> +int msi_add_quirk(struct pci_dev *dev)
> +{
> +	struct msi_quirk *quirk;
> +
> +	quirk = (struct msi_quirk *) kmalloc(sizeof(*quirk), GFP_KERNEL);

kmalloc() returns void*, hence no typecast is needed.  In fact it's
undesirable because the cast defeats all typechecking.

> +	if (!quirk)
> +		return -ENOMEM;
> +	
> +	INIT_LIST_HEAD(&quirk->list);
> +	quirk->dev = dev;
> +	list_add(&quirk->list, &msi_quirk_list);
> +	return 0;
> +}

Does the list not need any locking?

> --- linux-2.6.13-rc4/drivers/pci/quirks.c	2005-07-28 15:44:44.000000000 -0700
> +++ linux-2.6.13-rc4-pxhquirk/drivers/pci/quirks.c	2005-08-05 11:54:15.000000000 -0700
> @@ -21,6 +21,10 @@
>  #include <linux/acpi.h>
>  #include "pci.h"
>  
> +
> +void disable_msi_mode(struct pci_dev *dev, int pos, int type);
> +int msi_add_quirk(struct pci_dev *dev);
> +

Please put these declarations in a .h file which is visible to the
implementations and to all users.

> +static void __devinit quirk_pcie_pxh(struct pci_dev *dev)
> +{
> +	disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> +					PCI_CAP_ID_MSI);
> +	if (!msi_add_quirk(dev)) 
> +		printk(KERN_WARNING "PCI: PXH quirk detected, disabling MSI for SHPC device\n");
> +	else {
> +		pci_msi_quirk = 1;
> +		printk(KERN_WARNING "PCI: PXH quirk detected, unable to disable MSI for SHPC device, disabling MSI for all devices\n");
> +	}

Some people use 80-column xterms.   Break the strings up thusly:

		printk(KERN_WARNING "PCI: PXH quirk detected, disabling "
				"MSI for SHPC device\n");


