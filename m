Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSKVPNh>; Fri, 22 Nov 2002 10:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSKVPNg>; Fri, 22 Nov 2002 10:13:36 -0500
Received: from redrock.inria.fr ([138.96.248.51]:53155 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S264946AbSKVPN0>;
	Fri, 22 Nov 2002 10:13:26 -0500
SCF: #mh/Mailbox/outboxDate: Fri, 22 Nov 2002 16:11:47 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533 drivers)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20021122161147.6283c0ee.Manuel.Serrano@sophia.inria.fr>
References: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
	<1037800851.3241.10.camel@irongate.swansea.linux.org.uk>
	<20021122113904.0052e208.Manuel.Serrano@sophia.inria.fr>
	<8765up1wr6.fsf@devron.myhome.or.jp>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 22 Nov 2002 16:14:06 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Nov 2002 23:53:33 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Manuel Serrano <Manuel.Serrano@sophia.inria.fr> writes:
> 
> > Stack: 000000ff 00000001 c029da4c c019ed05 000000ff 00000001 c1a13fa0 c029da4c
> >        0000e000 00000286 c019f91c c029da4c c0275554 c0267fd8 00000000 00000001
> >        00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
> > Call Trace:   [<c019ed05>] [<c019f91c>] [<c0105021>] [<c01054a9>]
> > Code: 0b 40 10 ff d0 83 c4 04 56 9d 83 3d 84 dc 27 c0 00 75 0f 89
> > 
> > 
> > >>EIP; c0107cab <disable_irq+2f/54>   <=====
> > 
> > >>edi; c029da4c <ide_hwifs+46c/2c38>
> 
> Looks like the same problem on my VAIO-U3. The following log is on
> 2.5.47.
> 
> ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 9
> ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> PCI: Using ACPI for IRQ routing
> 
> [...]
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ALI15X3: IDE controller at PCI slot 00:10.0
> ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> ALI15X3: chipset revision 196
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
> ALI15X3: simplex device: DMA forced
>     ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:DMA, hdd:DMA
> hda: TOSHIBA MK2003GAH, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: host protected area => 1
> hda: 39062520 sectors (20000 MB), CHS=2431/255/63, UDMA(100)
>  hda: hda1 hda2 hda3
> register interface 'mouse' with class 'input
> 
> It seems ACPI assigned 255 to IRQ, so disable_irq() did oops.
> The following is my stupid patch. I hope this info helps.
> 
> --- linux-2.5.47/drivers/ide/ide-probe.c~ide-kludge	2002-11-14 02:41:40.000000000 +0900
> +++ linux-2.5.47-hirofumi/drivers/ide/ide-probe.c	2002-11-14 02:41:40.000000000 +0900
> @@ -654,6 +654,8 @@ void probe_hwif (ide_hwif_t *hwif)
>  	 * We must always disable IRQ, as probe_for_drive will assert IRQ, but
>  	 * we'll install our IRQ driver much later...
>  	 */
> +	if (hwif->irq == 255)
> +		hwif->irq = 0;
>  	irqd = hwif->irq;
>  	if (irqd)
>  		disable_irq(hwif->irq);
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
You patch helps a lot because the new kernel is now able to boot, with
the DMA enabled. I have the impression that there is still one 
problem because when I enable ATA66 (with hdparm -X66) I have the following
error message:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
hda: dma_intr: status=0x5a { DriveReady SeekComplete DataRequest Index }

hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Do you have an idea of the meaning of this message?

Anyway, many thanks for your help.

-- 
Manuel
