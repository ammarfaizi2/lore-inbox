Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKVQkx>; Fri, 22 Nov 2002 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKVQkw>; Fri, 22 Nov 2002 11:40:52 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:43018 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S265023AbSKVQkv>; Fri, 22 Nov 2002 11:40:51 -0500
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533 drivers)
References: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
	<1037800851.3241.10.camel@irongate.swansea.linux.org.uk>
	<20021122113904.0052e208.Manuel.Serrano@sophia.inria.fr>
	<8765up1wr6.fsf@devron.myhome.or.jp>
	<20021122161147.6283c0ee.Manuel.Serrano@sophia.inria.fr>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 23 Nov 2002 01:47:46 +0900
In-Reply-To: <20021122161147.6283c0ee.Manuel.Serrano@sophia.inria.fr>
Message-ID: <87of8hzh3h.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Serrano <Manuel.Serrano@sophia.inria.fr> writes:

> On Fri, 22 Nov 2002 23:53:33 +0900
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> 
> > Manuel Serrano <Manuel.Serrano@sophia.inria.fr> writes:
> > 
> > > Stack: 000000ff 00000001 c029da4c c019ed05 000000ff 00000001 c1a13fa0 c029da4c
> > >        0000e000 00000286 c019f91c c029da4c c0275554 c0267fd8 00000000 00000001
> > >        00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
> > > Call Trace:   [<c019ed05>] [<c019f91c>] [<c0105021>] [<c01054a9>]
> > > Code: 0b 40 10 ff d0 83 c4 04 56 9d 83 3d 84 dc 27 c0 00 75 0f 89
> > > 
> > > 
> > > >>EIP; c0107cab <disable_irq+2f/54>   <=====
> > > 
> > > >>edi; c029da4c <ide_hwifs+46c/2c38>
> > 
> > Looks like the same problem on my VAIO-U3. The following log is on
> > 2.5.47.
> > 
> > ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 9
> > ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 9
> > ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> > PCI: Using ACPI for IRQ routing
> > 
> > [...]
> > 
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ALI15X3: IDE controller at PCI slot 00:10.0
> > ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> > ALI15X3: chipset revision 196
> > ALI15X3: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
> > ALI15X3: simplex device: DMA forced
> >     ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: TOSHIBA MK2003GAH, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hda: host protected area => 1
> > hda: 39062520 sectors (20000 MB), CHS=2431/255/63, UDMA(100)
> >  hda: hda1 hda2 hda3
> > register interface 'mouse' with class 'input
> > 
> > It seems ACPI assigned 255 to IRQ, so disable_irq() did oops.
> > The following is my stupid patch. I hope this info helps.
> > 
> > --- linux-2.5.47/drivers/ide/ide-probe.c~ide-kludge	2002-11-14 02:41:40.000000000 +0900
> > +++ linux-2.5.47-hirofumi/drivers/ide/ide-probe.c	2002-11-14 02:41:40.000000000 +0900
> > @@ -654,6 +654,8 @@ void probe_hwif (ide_hwif_t *hwif)
> >  	 * We must always disable IRQ, as probe_for_drive will assert IRQ, but
> >  	 * we'll install our IRQ driver much later...
> >  	 */
> > +	if (hwif->irq == 255)
> > +		hwif->irq = 0;
> >  	irqd = hwif->irq;
> >  	if (irqd)
> >  		disable_irq(hwif->irq);
> > -- 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> You patch helps a lot because the new kernel is now able to boot, with
> the DMA enabled. I have the impression that there is still one 
> problem because when I enable ATA66 (with hdparm -X66) I have the following
> error message:
> 
> -----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
> hda: dma_intr: status=0x5a { DriveReady SeekComplete DataRequest Index }
> 
> hda: dma_timer_expiry: dma status == 0x21
> hda: timeout waiting for DMA
> hda: timeout waiting for DMA
> hda: (__ide_dma_test_irq) called while not waiting
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: drive not ready for command
> -----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
> 
> Do you have an idea of the meaning of this message?

Sorry, I don't know. On my machine with 2.5.47 seems hdparm -X
34/66/67/68/69 works fine.

/dev/hda:

 Model=TOSHIBA MK2003GAH, FwRev=AM.05 A, SerialNo=X2630112T
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=46
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39062520
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
