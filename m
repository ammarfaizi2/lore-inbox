Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRF0QWx>; Wed, 27 Jun 2001 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRF0QWo>; Wed, 27 Jun 2001 12:22:44 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:62984 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S263923AbRF0QWi>; Wed, 27 Jun 2001 12:22:38 -0400
Message-ID: <3B3A0885.69E2177C@t-online.de>
Date: Wed, 27 Jun 2001 18:23:33 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@aslab.com>
CC: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <Pine.LNX.4.10.10106270017350.13459-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> I can not help if you have a device that not compliant to the rules.
> ATA-2 is OBSOLETED thus we forced (the NCITS Standards Body) the CFA
> people to move to ATA-4 or ATA-5.

See Alan's point about existing hardware.

> 
> That device is enabling (with its ablity to assert) its device->host
> interrupt regardless of the HOST...that is a bad device.

Does this imply ATA-4 specifies the device should
come up with nIEN set (i.e. interrupts disabled)?


> 
> Send me the manufacturer and I will tear them apart for making a
> non-compliant device.  

see below.

>Then figure out a way to de-assert the like
> regardless if it exists without hang the rest of the driver.
>

My patch has figured this out !
It enables interrupts again (clear nIEN) shortly before it registers the irq handler.
At least boot+root on /dev/hda do not hang.

Regards, Gunther



1) Compact Flash 48MB, Silicon Tech/Hitachi 
===========================================
dump_cis
Socket 0:
  dev_info
    fn_specific 400ns, 2kb
  common_jedec 0xdf 0x01
  manfid 0x014d, 0x0001
  vers_1 4.1, "SiliconTech,Inc.", "48MB Compact PC Card", "Ver 3.0"
  funcid fixed_disk [post]
  disk_interface [ide]
  disk_features [silicon] [unique] [single]
    [sleep] [standby] [idle] [low power]
  config base 0x0200 mask 0x000f last_index 0x03
  cftable_entry 0x00 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V
    memory 0x0000-0x07ff @ 0x0000
  cftable_entry 0x00
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x01 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V
    io 0x0000-0x000f [lines=4] [8bit] [16bit]
    irq mask 0xffff [level] [pulse] [shared]
  cftable_entry 0x01
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x02 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V
    io 0x01f0-0x01f7, 0x03f6-0x03f7 [lines=10] [8bit] [16bit] [range]
    irq 14 [level] [pulse] [shared]
  cftable_entry 0x02
    Vcc Vnom 3300mV Ipeak 45mA
  cftable_entry 0x03 [default]
    [rdybsy] [pwrdown]
    Vcc Vnom 5V
    io 0x0170-0x0177, 0x0376-0x0377 [lines=10] [8bit] [16bit] [range]
    irq 14 [level] [pulse] [shared]
  cftable_entry 0x03
    Vcc Vnom 3300mV Ipeak 45mA

Jun 27 17:32:13 linux kernel: hde: Hitachi CV 7.1.1, ATA DISK drive

2) Iomega Clik40
================
 dump_cis
Socket 0:
  dev_info
    NULL 0ns, 512b
  attr_dev_info
    EEPROM 250ns, 2kb
  vers_1 4.1, "PC CARD MANUFACTURER", "PCMCIA ATA/ATAPI Adapter",
    "Version 3.00"
  manfid 0xffff, 0x0003
  funcid fixed_disk
  disk_interface [ide]
  config base 0x0800 mask 0x0001 last_index 0x05
  cftable_entry 0x25 [default]
    io 0x0180-0x0187, 0x0386-0x0387 [lines=10] [16bit] [range]
    irq mask 0xfe00 [level] [pulse]
  cftable_entry 0x0d
    io 0x0170-0x0177, 0x0376-0x0377 [lines=10] [16bit] [range]
  cftable_entry 0x15
    io 0x01e8-0x01ef, 0x03ee-0x03ef [lines=10] [16bit] [range]
  cftable_entry 0x1d
    io 0x0168-0x016f, 0x036e-0x036f [lines=10] [16bit] [range]
  cftable_entry 0x05
    io 0x01f0-0x01f7, 0x03f6-0x03f7 [lines=10] [16bit] [range]

Jun 27 17:36:39 linux kernel: hde: IOMEGA Clik! 40 CZ ATAPI, ATAPI cdrom or floppy?, assuming FLOPPY drive

> 
> On Tue, 26 Jun 2001, Gunther Mayer wrote:
> 
> > Hi,
> >
> > this patch fixes the hard hang (no SYSRQ) on inserting
> > any PCMCIA ATA/IDE card (e.g. CompactFlash, Clik40 etc)
> > to a PCI-Cardbus bridge add-in card.
> >
> > Thanks David for his valuable explanation about what happens:
> > ide-probe registers it's irq handler too late! After it
> > triggers the interrupt during the probe the (shared) irq
> > loops forever, effectively wedging the machine completely.
> >
> > Regards, Gunther
> >
> >
> >
> > --- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
> > +++ linux/drivers/ide/ide-cs.c  Tue Jun 26 21:22:19 2001
> > @@ -324,6 +324,9 @@
> >      if (link->io.NumPorts2)
> >         release_region(link->io.BasePort2, link->io.NumPorts2);
> >
> > +    outb(0x02, ctl_base); // Set nIEN = disable device interrupts
> > +                         // else it hangs on PCI-Cardbus add-in cards, wedging irq
> > +
> >      /* retry registration in case device is still spinning up */
> >      for (i = 0; i < 10; i++) {
> >         hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
> > --- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
> > +++ linux/drivers/ide/ide-probe.c       Tue Jun 26 21:25:07 2001
> > @@ -685,6 +685,8 @@
> >  #else /* !CONFIG_IDEPCI_SHARE_IRQ */
> >                 int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
> >  #endif /* CONFIG_IDEPCI_SHARE_IRQ */
> > +
> > +               outb(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
> >                 if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
> >                         if (!match)
> >                                 kfree(hwgroup);
> >
