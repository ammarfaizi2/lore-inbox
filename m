Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265284AbRF0HaY>; Wed, 27 Jun 2001 03:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265286AbRF0HaP>; Wed, 27 Jun 2001 03:30:15 -0400
Received: from temp20.astound.net ([24.219.123.215]:44554 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265284AbRF0HaJ>; Wed, 27 Jun 2001 03:30:09 -0400
Date: Wed, 27 Jun 2001 00:29:47 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <3B38EE96.A6C11980@t-online.de>
Message-ID: <Pine.LNX.4.10.10106270017350.13459-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can not help if you have a device that not compliant to the rules.
ATA-2 is OBSOLETED thus we forced (the NCITS Standards Body) the CFA
people to move to ATA-4 or ATA-5.

That device is enabling with its ablity to assert its device->host
interrupt regardless of the HOST...that is a bad device.

Send me the manufacturer and I will tear them apart for making a
non-compliant device.  Then figure out a way to de-assert the like
regardless if it exists without hang the rest of the driver.

Cheers,


On Tue, 26 Jun 2001, Gunther Mayer wrote:

> Hi,
> 
> this patch fixes the hard hang (no SYSRQ) on inserting
> any PCMCIA ATA/IDE card (e.g. CompactFlash, Clik40 etc)
> to a PCI-Cardbus bridge add-in card.
> 
> Thanks David for his valuable explanation about what happens:
> ide-probe registers it's irq handler too late! After it
> triggers the interrupt during the probe the (shared) irq
> loops forever, effectively wedging the machine completely.
> 
> Regards, Gunther
> 
> 
> 
> --- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
> +++ linux/drivers/ide/ide-cs.c  Tue Jun 26 21:22:19 2001
> @@ -324,6 +324,9 @@
>      if (link->io.NumPorts2)
>         release_region(link->io.BasePort2, link->io.NumPorts2);
>  
> +    outb(0x02, ctl_base); // Set nIEN = disable device interrupts
> +                         // else it hangs on PCI-Cardbus add-in cards, wedging irq
> +
>      /* retry registration in case device is still spinning up */
>      for (i = 0; i < 10; i++) {
>         hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
> --- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
> +++ linux/drivers/ide/ide-probe.c       Tue Jun 26 21:25:07 2001
> @@ -685,6 +685,8 @@
>  #else /* !CONFIG_IDEPCI_SHARE_IRQ */
>                 int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
>  #endif /* CONFIG_IDEPCI_SHARE_IRQ */
> +
> +               outb(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
>                 if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
>                         if (!match)
>                                 kfree(hwgroup);
> 

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

