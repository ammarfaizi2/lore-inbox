Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUBUCFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUBUCFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:05:36 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:43203 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261479AbUBUCF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:05:27 -0500
Date: Fri, 20 Feb 2004 21:05:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2/2 add the Intel Alder IO-APIC PCI device to quirks
In-Reply-To: <1077316973.1769.12.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0402202102570.7734@montezuma.fsmlabs.com>
References: <1077316973.1769.12.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, James Bottomley wrote:

> The alder has an intel Extended Express System Support Controller
> which presents apparently spurious BARs.  When the pci resource
> code tries to reassign these BARs, the second IO-APIC gets disabled
> (with disastrous consequences).
>
> The first BAR is the actual IO-APIC, the remaining five bars seem to be
> spurious resources, so we forcibly insert the first one into the
> resource tree and clear all the others.

Nice i have one of these, i currently have to boot with noapic
unfortunately due to aic7xxx exploding. I'll apply your patch and try it
out anyway.

00:0f.0 Class ff00: Intel Corp.: Unknown device 0008
        Subsystem: Unknown device f808:ffe7
        Flags: fast devsel
        Memory at ffe7f800 (32-bit, prefetchable) [size=1K]
        Memory at 10000000 (32-bit, prefetchable) [size=1K]
        Memory at 10000400 (32-bit, prefetchable) [size=1K]
        Memory at 10000800 (32-bit, prefetchable) [size=1K]
        Memory at 10000c00 (32-bit, prefetchable) [size=1K]
        Memory at 10001000 (32-bit, prefetchable) [size=1K]
        Expansion ROM at fffff800 [disabled] [size=2K]
00: 86 80 08 00 43 01 80 00 00 00 00 ff 00 00 00 00
10: 08 f8 e7 ff 08 f8 e7 ff 08 f8 e7 ff 08 f8 e7 ff
20: 08 f8 e7 ff 08 f8 e7 ff 08 f8 e7 ff 08 f8 e7 ff
30: 08 f8 e7 ff 08 f8 e7 ff 08 f8 e7 ff ff 00 00 00

01:00.0 Host bridge: Intel Corp. 82452KX/GX [Orion] (rev 02)
        Flags: bus master, medium devsel, latency 6
00: 86 80 25 12 07 00 00 22 02 00 00 06 00 06 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00


> ===== drivers/pci/quirks.c 1.40 vs edited =====
> --- 1.40/drivers/pci/quirks.c	Wed Feb 18 05:31:36 2004
> +++ edited/drivers/pci/quirks.c	Fri Feb 20 14:35:36 2004
> @@ -789,6 +789,29 @@
>  	sis_96x_compatible = 1;
>  }
>
> +#ifdef CONFIG_X86_IO_APIC
> +static void __init quirk_alder_ioapic(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	if ((pdev->class >> 8) != 0xff00)
> +		return;
> +
> +	/* the first BAR is the location of the IO APIC...we must
> +	 * not touch this (and it's already covered by the fixmap), so
> +	 * forcibly insert it into the resource tree */
> +	if(pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
> +		insert_resource(&iomem_resource, &pdev->resource[0]);
> +
> +	/* The next five BARs all seem to be rubbish, so just clean
> +	 * them out */
> +	for(i=1; i < 6; i++) {
> +		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
> +	}
> +
> +}
> +#endif
> +
>  #ifdef CONFIG_SCSI_SATA
>  static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
>  {
> @@ -914,6 +937,7 @@
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
>          { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,
>            quirk_amd_8131_ioapic },
> +	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic },
>  #endif
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
> ===== include/linux/pci_ids.h 1.139 vs edited =====
> --- 1.139/include/linux/pci_ids.h	Fri Feb 20 08:57:29 2004
> +++ edited/include/linux/pci_ids.h	Fri Feb 20 14:35:38 2004
> @@ -1928,6 +1928,7 @@
>  #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
>
>  #define PCI_VENDOR_ID_INTEL		0x8086
> +#define PCI_DEVICE_ID_INTEL_EESSC	0x0008
>  #define PCI_DEVICE_ID_INTEL_21145	0x0039
>  #define PCI_DEVICE_ID_INTEL_82375	0x0482
>  #define PCI_DEVICE_ID_INTEL_82424	0x0483
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
