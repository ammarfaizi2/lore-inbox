Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277183AbRJ0VmS>; Sat, 27 Oct 2001 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277188AbRJ0VmJ>; Sat, 27 Oct 2001 17:42:09 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:11977 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S277183AbRJ0Vl7>;
	Sat, 27 Oct 2001 17:41:59 -0400
Date: Sat, 27 Oct 2001 23:42:00 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Janne Liimatainen <jannel@iki.fi>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: HPT366 problems continued
Message-ID: <20011027234200.A2975@se1.cogenit.fr>
In-Reply-To: <1004077903.3bd9034f7360f@mail.arabuusimiehet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1004077903.3bd9034f7360f@mail.arabuusimiehet.com>; from jannel@iki.fi on Fri, Oct 26, 2001 at 09:31:43AM +0300
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne Liimatainen <jannel@iki.fi> :
[...]
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
> HPT366: IDE controller on PCI bus 00 dev 70
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> HPT366: simplex device:  DMA disabled
> ide0: HPT366 Bus-Master DMA disabled (BIOS)
> HPT366: IDE controller on PCI bus 00 dev 71
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> HPT366: simplex device:  DMA disabled
> ide1: HPT366 Bus-Master DMA disabled (BIOS)
> hda: Maxtor 4D080H4, ATA DISK drive
> hdc: Maxtor 4D080H4, ATA DISK drive

drivers/ide/ide-dma.c::ide_get_or_set_dma_base
741     if (hwif->mate && hwif->mate->dma_base) {
742             dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
        } else {
                dma_base = pci_resource_start(dev, 4);
                -> We take this branch first (or I've missed where
                   mate->dma_base is set)
[...]
	if ((inb(dma_base+2) & 0x80)) { /* simplex device? */
793	        if ((!hwif->drives[0].present && !hwif->drives[1].present) ||
                -> do_identify is called later, we pass this test
794		    (hwif->mate && hwif->mate->dma_base)) {
                    -> + we can't succeed this one or it means we would have
                    -> passed through the other branch (742). It would imply 
		    -> at least one mate accepts to enable DMA.
			printk("%s: simplex device:  DMA disabled\n", name);
			dma_base = 0;

I'd say either mate->dma_base is set too soon for both mate (and they're both
guaranteed to generate dma_base = 0 as soon as they reach 794) or do_identify
is called too late (and dma_base = 0 because of 793).
I haven't found a lot of dma_base field setting and they seem to happen late.

M. Hedrick ?

-- 
Ueimor
