Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSAQBY4>; Wed, 16 Jan 2002 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSAQBYu>; Wed, 16 Jan 2002 20:24:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36769 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288040AbSAQBYk>;
	Wed, 16 Jan 2002 20:24:40 -0500
Date: Wed, 16 Jan 2002 17:14:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Gerald Champagne <gerald.champagne@esstech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20268 PCI register decoding
In-Reply-To: <3C4624CC.7020401@esstech.com>
Message-ID: <Pine.LNX.4.10.10201161713080.30663-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I fixed that problem after it was discovered.
It is in the newest drivers.


On Wed, 16 Jan 2002, Gerald Champagne wrote:

> I thought I understood the way PCI devices are accessed in Linux,
> but the code for the Promise PCI controllers has me confused.  To
> me it looks like the code is accessing registers outside the area
> allocated to the PCI device during initialization.
> 
> The device is configured with the following resources (on a Mips-based
> platform):
> 
> 00:08.0 Class 0180: 105a:4d68 (rev 01)
>          I/O at 0x00000080 [size=0x8]
>          I/O at 0x00000088 [size=0x4]
>          I/O at 0x00000090 [size=0x8]
>          I/O at 0x00000098 [size=0x4]
>          I/O at 0x000000a0 [size=0x10]
>          Mem at 0x08004000 [size=0x4000]
> 
> The Promise code uses registers specified using bar4 but it uses offsets
> above 0x0f.  Here's an example of the code in drivers/ide/pdc202xx.c:
> 
> void pdc202xx_reset (ide_drive_t *drive)
> {
>          unsigned long high_16   = pci_resource_start(HWIF(drive)->pci_dev, 4);
>          byte udma_speed_flag    = inb(high_16 + 0x001f);
> 
>          OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
>          mdelay(100);
>          OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
>          mdelay(2000);           /* 2 seconds ?! */
> }
> 
> How can the code above try to write to a register 0x1f into a region with
> a size of 0x10?  Wouldn't that stomp on the registers of some other PCI device?
> 
> Thanks.
> 
> Gerald
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


