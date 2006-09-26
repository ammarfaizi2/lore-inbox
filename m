Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWIZPJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWIZPJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWIZPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:09:24 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:29335 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932096AbWIZPJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:09:23 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: eiichiro.oiwa.nm@hitachi.com
Subject: Re: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for embedded VGA
Date: Tue, 26 Sep 2006 09:09:12 -0600
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, tony.luck@intel.com, greg@kroah.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260909.12876.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 01:42, eiichiro.oiwa.nm@hitachi.com wrote:
> To be compatible with Xorg's handling of PCI, we need pci_fixup_video on IA64
> platform like x86 platform. There are also machines, which have VGA embedded
> into main board, among IA64 platform. Embedded VGA generally don't have PCI ROM,
> and there are VGA ROM image in System BIOS. Therefore, these machines need
> pci_fixup_video for the sysfs rom. pci_fixup_video already exists in x86 Linux
> kernel. However since this function doesn't exist in IA64 kernel, we could not
> run X server on IA64 box has embedded-VGA.
> 
> I tested pci_fixup_video on IA64 box has embedded-VGA. I confirmed we can read
> VGA BIOS from the sysfs rom regardless of embedded-VGA.

What other architectures will need this?  There's nothing ia64-specific
in the patch below.  Can it be put somewhere more generic?

> diff -dupNr linux-2.6.18.orig/arch/ia64/pci/Makefile linux-2.6.18/arch/ia64/pci/Makefile
> --- linux-2.6.18.orig/arch/ia64/pci/Makefile	2006-09-20 12:42:06.000000000 +0900
> +++ linux-2.6.18/arch/ia64/pci/Makefile	2006-09-25 18:36:50.000000000 +0900
> @@ -1,4 +1,4 @@
>  #
>  # Makefile for the ia64-specific parts of the pci bus
>  #
> -obj-y		:= pci.o
> +obj-y		:= pci.o fixup.o
> diff -dupNr linux-2.6.18.orig/arch/ia64/pci/fixup.c linux-2.6.18/arch/ia64/pci/fixup.c
> --- linux-2.6.18.orig/arch/ia64/pci/fixup.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.18/arch/ia64/pci/fixup.c	2006-09-25 18:35:12.000000000 +0900
> @@ -0,0 +1,56 @@
> +/*
> + * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
> + *
> + * Derived from fixup.c of i386 tree.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +
> +
> +/*
> + * Fixup to mark boot BIOS video selected by BIOS before it changes
> + *
> + * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
> + *
> + * The standard boot ROM sequence for an x86 machine uses the BIOS
> + * to select an initial video card for boot display. This boot video
> + * card will have it's BIOS copied to C0000 in system RAM.
> + * IORESOURCE_ROM_SHADOW is used to associate the boot video
> + * card with this copy. On laptops this copy has to be used since
> + * the main ROM may be compressed or combined with another image.
> + * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
> + * is marked here since the boot video device will be the only enabled
> + * video device at this point.
> + */
> +
> +static void __devinit pci_fixup_video(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge;
> +	struct pci_bus *bus;
> +	u16 config;
> +
> +	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> +		return;
> +
> +	/* Is VGA routed to us? */
> +	bus = pdev->bus;
> +	while (bus) {
> +		bridge = bus->self;
> +		if (bridge) {
> +			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
> +						&config);
> +			if (!(config & PCI_BRIDGE_CTL_VGA))
> +				return;
> +		}
> +		bus = bus->parent;
> +	}
> +	pci_read_config_word(pdev, PCI_COMMAND, &config);
> +	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> +		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
> +		printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
