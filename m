Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUL2VRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUL2VRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUL2VRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:17:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31908 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261504AbUL2VQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:16:12 -0500
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, linux-ide@vger.kernel.org
In-Reply-To: <58cb370e041229092919c1b4a8@mail.gmail.com>
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104351122.31052.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 20:12:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> Let me complain once again :-), libata based driver would be better...

Eventually probably but libata's PATA support is pretty pathetic right
now, it doesn't know anything about PATA drive errata. I did look at it
and when it grows up into a real IDE layer for PATA I'm all for moving
*every* IDE driver to it because some of the IDE error path corner cases
are almost rewrite level fixes (eg DMA changedown, timer/interrupt CD
race oops)

> > +       ide_hwif_t *hwif        = HWIF(drive);
> 
> Please do not use HWIF() macro in a new code, it does
> needless casting which hides errors and increases code size.

Ok - I agree entirely about that one.

> > +static byte it8212_ratemask (ide_drive_t *drive)
> 
> please don't use 'byte' type in a new code

Ok

> > +       u8 unit = drive->select.b.unit;
> > +       ide_hwif_t *hwif = HWIF(drive);
> > +       ide_drive_t *pair = &hwif->drives[1-unit];
> > +       u8 speed = 0, set_pio   = ide_get_best_pio_mode(drive, 4, 5, NULL);
> 
> ide_get_best_pio_mode(drive, 4, 5, NULL) always returns 4
> [ quick fix == hardcode 4 for now and add FIXME ]

Will look at that.

> > +       u8 speed                = ide_rate_filter(it8212_ratemask(drive), xferspeed);
> 
> itdev->smart check should be here

Can move that

> > +static int config_chipset_for_dma (ide_drive_t *drive)
> > +{
> > +       u8 speed        = ide_dma_speed(drive, it8212_ratemask(drive));
> > +
> > +       config_chipset_for_pio(drive, !speed);
> 
> set autotune in ->init_hwif instead, only difference will be that PIO command
> will be send out - if this is a problem cache set_speed parameter in ide_drive_t

That will be fine.

> > +       if (ide_set_xfer_rate(drive, speed))
> > +               return 0;
> 
> just use it8212_tune_chipset()

ok

> > +                *      If we are in pass through mode then not much
> > +                *      needs to be done, but we do bother to clear the
> > +                *      IRQ mask in case the drives are PIO (eg rev 0x10)
> > +                *      for now.
> > +                */
> 
> comment or code is wrong, unmask is turned on unconditionally

Disagree. It says "e.g."

> > +               if(strstr(id->model, "Integrated Technology Express")) {
> > +                       /* In raid mode the ident block is slightly buggy */
> > +                       id->capability |= 3;            /* LBA28, DMA */
> > +                       id->command_set_2 |= 0x0400;    /* LBA48 valid */
> > +                       id->cfs_enable_2 |= 0x0400;     /* LBA48 on */
> 
> comment why this is need would be helpful

Will add

> > +                       hwif->ide_dma_off_quietly(drive);
> > +#ifdef CONFIG_IDEDMA_ONLYDISK
> > +                       if (drive->media == ide_disk)
> > +#endif
> > +                               hwif->ide_dma_check(drive);
> 
> hack, it looks like fixup code in ide-probe.c need to be moved to probe_hwif()

I'm not sure of the best way to do that cleanly. What do you have in
mind ?


> > +                       id->csfo = 0;
> > +                       id->cfa_power = 0;
> 
> aargghh, this is a gross hack to support smart mode in IDE driver

The alternative is to stick a command filter into the IDE core in
various places. I'd rather hide the uglies in the driver having played
with ->taskfile hooks in 2.6.9-ac. That keeps the uglies where they
belong but isn't nice to retrofit to the IDE core (unlike libata)

> > +       if (it8212_noraid) {
> > +               printk(KERN_INFO "it8212: forcing bypass mode.\n");
> > +
> > +               /* Reset local CPU, and set BIOS not ready */
> > +               pci_write_config_byte(hwif->pci_dev, 0x5E, 0x01);
> > +
> > +               /* Set to bypass mode, and reset PCI bus */
> > +               pci_write_config_byte(hwif->pci_dev, 0x50, 0x00);
> > +
> > +               pci_write_config_word(hwif->pci_dev, PCI_COMMAND,
> > +                                     PCI_COMMAND_PARITY | PCI_COMMAND_IO |
> > +                                     PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > +
> > +               pci_write_config_word(hwif->pci_dev, 0x40, 0xA0F3);
> > +
> > +               pci_write_config_dword(hwif->pci_dev,0x4C, 0x02040204);
> > +               pci_write_config_byte(hwif->pci_dev, 0x42, 0x36);
> > +               pci_write_config_byte(hwif->pci_dev, PCI_LATENCY_TIMER, 0);
> > +       }
> 
> this code is in the wrong hook, it should be in ->init_chipset
> (it should be also moved to separate function for better readability)

Agreed

> > +       if(hwif->channel == 0)
> > +               printk(KERN_INFO "it8212: controller in %s mode.\n",
> > +                       mode[idev->smart]);
> 
> should be in ->init_chipset

Ok

> > +       pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
> 
> conf is already available

Ok

> > +       hwif->drives[0].autotune = 1;
> > +       hwif->drives[1].autotune = 1;
> 
> autotune should be always set

Thanks. I'll go and polish these up.

