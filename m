Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTHMGtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTHMGtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:49:35 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:29193
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S271415AbTHMGtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:49:32 -0400
Date: Tue, 12 Aug 2003 23:49:23 -0700
To: Daniela Engert <dani@ngrt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Serial ATA chipset
Message-ID: <20030813064923.GA27610@nasledov.com>
References: <20030811223423.GA9955@nasledov.com> <20030812111332.351001ACFB@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812111332.351001ACFB@mail.medav.de>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, this patch works for me. I have the following in my dmesg:

VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
PCI: Found IRQ 3 for device 0000:00:0f.0
IRQ routing conflict for 0000:00:0f.0, have irq 11, want irq 3
PCI: Sharing IRQ 3 with 0000:00:0f.1
IRQ routing conflict for 0000:00:10.0, have irq 11, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 11, want irq 3
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 11
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio

The IRQ routing conflict lines have always existed, and there are more
similar lines in other parts of the dmesg. I'm not sure if they are
pertinent at all. Unfortunately, the drive does not seem to perform as
well as a SATA drive should; my UDMA/133 drive currently outperforms
this. However, it seems to significantly faster than the UDMA/66 drive
I run Linux on, so I am glad that it works as fast it does because now
I can perhaps use this as my new system drive.

Are there any plans on the horizon for a more complete driver for this
chipset?

On Tue, Aug 12, 2003 at 01:13:59PM +0200, Daniela Engert wrote:
> Looking at the sources of /drivers/ide/pci/generic.* shows that the
> "generic" driver is much less generic than its name might suggest. The
> following patch should help.
> 
> Ciao,
>   Dani
> 
> --- generic.c	Tue Aug 12 07:58:08 2003
> +++ generic.c	Tue Aug 12 12:59:02 2003
> @@ -140,6 +140,7 @@
> 	{ PCI_VENDOR_ID_HINT,	PCI_DEVICE_ID_HINT_VXPROII_IDE,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C561,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
> 	{ PCI_VENDOR_ID_OPTI,	PCI_DEVICE_ID_OPTI_82C558,
>   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
> +	 { PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_8237_SATA,	    PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> 9},
> 	{ 0, },
>  };
> 
> --- generic.h	Mon Jul 14 03:30:48 2003
> +++ generic.h	Tue Aug 12 13:02:08 2003
> @@ -127,7 +127,20 @@
> 		.enablebits	= {{0x00,0x00,0x00},
> {0x00,0x00,0x00}},
> 		.bootable	= ON_BOARD,
> 		.extra		= 0,
> -	},{
> +	 },{	 /* 9 */
> +		 .vendor	 = PCI_VENDOR_ID_VIA,
> +		 .device	 = PCI_DEVICE_ID_VIA_8237_SATA,
> +		 .name		 = "VIA8237SATA",
> +		.init_chipset	= init_chipset_generic,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_generic,
> +		.init_dma	= init_dma_generic,
> +		.channels	= 2,
> +		 .autodma	 = AUTODMA,
> +		.enablebits	= {{0x00,0x00,0x00},
> {0x00,0x00,0x00}},
> +		 .bootable	 = OFF_BOARD,
> +		.extra		= 0,
> +	 },{
> 		.vendor 	= 0,
> 		.device 	= 0,
> 		.channels	= 0,
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Daniela Engert, systems engineer at MEDAV GmbH
> Gr?fenberger Str. 32-34, 91080 Uttenreuth, Germany
> Phone ++49-9131-583-348, Fax ++49-9131-583-11
> 
> 

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
