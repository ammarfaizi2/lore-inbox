Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbRAEWnJ>; Fri, 5 Jan 2001 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEWm7>; Fri, 5 Jan 2001 17:42:59 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:11280
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129183AbRAEWmn>; Fri, 5 Jan 2001 17:42:43 -0500
Date: Fri, 5 Jan 2001 14:42:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Chung <adrian@enfusion-group.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra66 DMA problems.
In-Reply-To: <20010105170838.A1674@rogue.enfusion-group.com>
Message-ID: <Pine.LNX.4.10.10101051440290.6928-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
hdh: QUANTUM FIREBALLP LM30, ATA DISK drive

Well add these to the quirk list in the pdc202xx.c

There are known issues with several versions of the FIRMWARE of the
"QUANTUM FIREBALLP LM***" series.

Cheers,

On Fri, 5 Jan 2001, Adrian Chung wrote:

> I've been searching and watching lists for a while trying to figure
> out whether this problem had been solved or not, and haven't found
> anything suitable...
> 
> I'm experiencing two problems with a Promise UDMA66 controller
> (PDC20262) on hardware I'll list below.  The first problem is that
> on bootup I get:
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 21
> PIIX4: chipset revision 1
> PIIX4: not 100%% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> PDC20262: IDE controller on PCI bus 00 dev 60
> PDC20262: chipset revision 1
> PDC20262: not 100%% native mode: will probe irqs later
> PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI
> Mode.
>     ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
> hdc: NEC CD-ROM DRIVE:282, ATAPI CDROM drive
> hde: Maxtor 91024U3, ATA DISK drive
> hdf: Maxtor 94098U8, ATA DISK drive
> hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
> hdh: QUANTUM FIREBALLP LM30, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xb000-0xb007,0xa802 on irq 11
> ide3 at 0xa400-0xa407,0xa002 on irq 11
> 
> Then a hang.  Mentioned a while back, this patch fixes the problem,
> and allows the machine to boot properly.
> 
> --- /usr/src/linux-2.2.18-idepatch/drivers/block/ide-features.c Mon
> Jan  1 18:03:42 2001
> +++ ide-features.c      Mon Jan  1 18:30:37 2001
> @@ -297,8 +297,10 @@
>         SELECT_DRIVE(HWIF(drive), drive);
>         SELECT_MASK(HWIF(drive), drive, 0);
>         udelay(1);
> +       /*
>         if (IDE_CONTROL_REG)
>                 OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
> +       */
>         OUT_BYTE(speed, IDE_NSECTOR_REG);
>         OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
>         OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
> 
> I then found that I randomly get "Timeout waiting for DMA" messages
> prior to a complete system hang.
> 
> I tried forcing all of the drives into UDMA mode 2 (hdparm -X66) and
> this seemed to make the problem a bit better, but I still experience
> system hangs.  I can't seem to make the problem happen, it only
> happens randomly.  The past two times, an rsync has made the system crash.
> 
> I'm using kernel 2.2.18 (tried 2.4 final briefly today to see if it
> would boot, it hung on bootup as well), with the latest
> ide.2.2.18.1221.patch from Andre's directory.
> 
> The system in question is:
> 
> Celeron 533 - 384 MB RAM - Asus P2B-F
> 4 IDE Drives listed above:
> hde: Maxtor 91024U3, ATA DISK drive
> hdf: Maxtor 94098U8, ATA DISK drive
> hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
> hdh: QUANTUM FIREBALLP LM30, ATA DISK drive
> 1 IDE CDROM:
> hdc: NEC CD-ROM DRIVE:282, ATAPI CDROM drive
> Promise Ultra66 Controller, BIOS 2.0b18
> 2 D-Link DFE-538 (RTL8139) adapters
> 
> Any help, or any way I could help would be appreciated.  Eager to try
> and get this resolved, as I've seen it crop up a number of times, and
> it's also a pain to have to physically hit the reset button as the
> machine is off-site.
> 
> --
> Adrian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
