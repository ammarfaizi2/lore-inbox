Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKUKA1>; Tue, 21 Nov 2000 05:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQKUKAR>; Tue, 21 Nov 2000 05:00:17 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18187
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130073AbQKUKAA> convert rfc822-to-8bit; Tue, 21 Nov 2000 05:00:00 -0500
Date: Tue, 21 Nov 2000 01:29:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem
In-Reply-To: <20001121073955.16B948960@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.10.10011210112530.26514-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.x and 2.4.0-xxx, do not share the same interrupt pin hack.

This is in 2.2.x patches.

printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", d->name, pin1, pin2);
#if 1
/* I forgot why I did this once, but it fixed something. */
pci_write_config_byte(dev2, PCI_INTERRUPT_PIN, dev->irq);
printk("PCI: %s: Fixing interrupt %d pin %d to ZERO \n", d->name, dev2->irq, pin2);
pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, 0);
#endif

It does the undocumented "mode 3" that I had to explain to HighPoint that
ABIT violated the OEM docs.

It is a PCI-addon chipset style deployed like a legacy chipset.

Primary   channel is set to IRQ X   and PIN A
Secondary channel is set to IRQ X++ and PIN B

This is not allowed by the guidelines but it you do the big nasty above,
it will fix it 99% of the time.

Add the above stub to ide-pci.c near or at line 756 to look like 2.2, then
retry and see if it fixes it.  Then you bitch at Linus, not me, because it
is a functional kludge, but a "kludge".

Cheers,

On Tue, 21 Nov 2000, Hakan Lennestal wrote:

> 
> Hi !
> 
> I'm having problems when booting 2.4.0 test10 and test11 kernels
> (perhaps some earlier kernels too).
> Approximately nine out of ten times the kernel hangs when
> trying to detect partitions on the first HPT366 disk.
> 
> It looks something like this:
> 
>   Nov 21 08:08:40 t kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
>   Nov 21 08:08:40 t kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>   Nov 21 08:08:40 t kernel: PIIX4: IDE controller on PCI bus 00 dev 39
>   Nov 21 08:08:40 t kernel: PIIX4: chipset revision 1
>   Nov 21 08:08:40 t kernel: PIIX4: not 100%% native mode: will probe irqs later
>   Nov 21 08:08:40 t kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>   Nov 21 08:08:40 t kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
>   Nov 21 08:08:40 t kernel: HPT366: IDE controller on PCI bus 00 dev 48
>   Nov 21 08:08:40 t kernel: HPT366: chipset revision 1
>   Nov 21 08:08:40 t kernel: HPT366: not 100%% native mode: will probe irqs later
>   Nov 21 08:08:40 t kernel:     ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:DMA, hdf:pio
>   Nov 21 08:08:40 t kernel: HPT366: IDE controller on PCI bus 00 dev 49
>   Nov 21 08:08:40 t kernel: HPT366: chipset revision 1
>   Nov 21 08:08:40 t kernel: HPT366: not 100%% native mode: will probe irqs later
>   Nov 21 08:08:40 t kernel:     ide3: BM-DMA at 0xb800-0xb807, BIOS settings: hdg:DMA, hdh:pio
>   Nov 21 08:08:40 t kernel: hda: FUJITSU MPD3064AT, ATA DISK drive
>   Nov 21 08:08:40 t kernel: hdc: Hewlett-Packard CD-Writer Plus 8200, ATAPI CDROM drive
>   Nov 21 08:08:40 t kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
>   Nov 21 08:08:40 t kernel: hde: IBM-DTLA-307030, ATA DISK drive
>   Nov 21 08:08:40 t kernel: hdg: QUANTUM Bigfoot TX12.0AT, ATA DISK drive
>   Nov 21 08:08:40 t kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>   Nov 21 08:08:40 t kernel: ide1 at 0x170-0x177,0x376 on irq 15
>   Nov 21 08:08:40 t kernel: ide2 at 0xa400-0xa407,0xa802 on irq 9
>   Nov 21 08:08:40 t kernel: ide3 at 0xb000-0xb007,0xb402 on irq 9
>   Nov 21 08:08:40 t kernel: hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=788/255/63, UDMA(33)
>   Nov 21 08:08:40 t kernel: hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(66)
>   Nov 21 08:08:40 t kernel: hdg: 23547888 sectors (12057 MB) w/69KiB Cache, CHS=23361/16/63, UDMA(33)
>   Nov 21 08:08:40 t kernel: Partition check:
>   Nov 21 08:08:40 t kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
>   Nov 21 08:08:40 t kernel:  hde: hde1 hde2 < hde5
> 
> And then after a while it gets a DMA timeout and hangs hard.
> 
> The hang can occur anywhere during the partition detection and it can for 
> instance also fail at once and look like:
> 
>   hde:
> 
> or fail even after the last partiton:
> 
>   hde: hde1 hde2 < hde5 hde6 hde7 hde8
> 
> Approximately one out of ten reboots the detection succedes and I'm able
> to boot up the kernel and then everything works smoothly.
> 
> There are no problems when booting 2.2.*-kernels with the HPT366-patch.
> 
> Regards.
> 
> /Håkan
> 
> 
> ---------------------------------------
> e-mail: Hakan.Lennestal@lu.erisoft.se |
>      or Hakan.Lennestal@cdt.luth.se   |
> ---------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
