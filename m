Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRKNIlm>; Wed, 14 Nov 2001 03:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280351AbRKNIld>; Wed, 14 Nov 2001 03:41:33 -0500
Received: from [212.65.238.182] ([212.65.238.182]:5127 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S280368AbRKNIlX>; Wed, 14 Nov 2001 03:41:23 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA109593B@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: mcintosh@research.telcordia.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Promise PDC20262 in kernel 2.4.x
Date: Wed, 14 Nov 2001 09:41:24 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
and how about IRQ sharing? I wonder that Promise cards are little bit
selfish about their resources, because I spent a lot of time setting them up
to cooperate with rest of hardware (scsi controller, ide onboard
controllers, NIC etc.). Finally I discovered, that my Promise controller had
to have polished setup in BIOS to init&boot correctly:
1) PCI-IDE map to <PCI slot # of Promise card>
2) PCI-IRQ on <PCI slot # of Promise card> setup to some certain value, as
high as possible (not AUTO)
3)in PCI/PnP section of BIOS set this value as USED BY ISA (if I remember
well :)
4) of course setup your BIOS to "Not PnP OS (even if linux is PnP)"

I hope this can help.

Regards,
Petr

> ----- Original message follows -----
> Setup: Dell Dimension XPS T-700r
> 	Onboard PCI Controller:
> 		Primary IDE: empty
> 		Secondary IDE: CD, CD-RW
> 	Promise PDC 20262 IDE card
> 		Primary: Quantum Fireball 30Gb
> 		Secondary: Seagate ST330630A
> 
> Symptoms: No recent stock distribution install disk I have will boot. (RH
> 7.x,
> MDK 8.x)  The boot sequence gets all the addresses right, but dies after
> printing
> 	ide2 at 0x10f8-0x10ff,0x10f2 on irq 10
> I haven't found kernel options that will cure this.  The addresses printed
> by the kernel are all correct, and
> 	ide0=noautotune,ide2=noautotune
> has no effect.  (This has all been reported before.  If someone can point
> me to a FM to R, I would be eternally grateful :-)
> 
> BUT
> 
> I discovered by accident that a kernel with NO Promise support compiled
> in boots just fine!  The resulting system is slow - I suspect it's not
> using DMA - but the system does run.
> This statement applies to kernels 2.4.5, 2.4.10 and 2.4.14.
> (For anyone with a similar problem who might be reading this, the
> implication is that a disk built on another machine with a custom
> kernel will boot when installed.)
> 
> So... anyone have any insight?  I'm willing to change configuration,
> test patches, provide more information, etc.
> 
> Gory details:
> 
> Kernel configuration that works (IDE stuff only):
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDEFLOPPY=y
> CONFIG_BLK_DEV_IDESCSI=y
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_CMD640_ENHANCED=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_OFFBOARD=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_PIIX_TUNING is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_PDC202XX_FORCE is not set
> 
> 
> Diffs with kernel configuration that doesn't work:
> 
> < # CONFIG_BLK_DEV_PDC202XX is not set
> ---
> > CONFIG_BLK_DEV_PDC202XX=y
> 
> 
> (Turning on CONFIG_PDC202XX_BURST made no difference.)
> 
> IDE related messages from successful boot (kernel with no Promise
> support):
> 
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:pio, hdd:DMA
> PDC20262: IDE controller on PCI bus 00 dev 70
> PCI: Found IRQ 10 for device 00:0e.0
> PDC20262: chipset revision 1
> PDC20262: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:pio, hdb:pio
>     ide2: BM-DMA at 0x1088-0x108f, BIOS settings: hde:pio, hdf:pio
> hda: QUANTUM FIREBALLP LM30.0, ATA DISK drive
> hdc: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
> hdd: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
> hde: ST330630A, ATA DISK drive
> ide0 at 0x1400-0x1407,0x10f6 on irq 10
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x10f8-0x10ff,0x10f2 on irq 10
> hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63
> hde: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=59303/16/63
> ide-floppy driver 0.97.sv
> Partition check:
>  hda: [PTBL] [3649/255/63] hda1
>  hde: [PTBL] [3720/255/63] hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9
> hde10 >
> ide-floppy driver 0.97.sv
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: _NEC      Model: DV-5700A          Rev: 1.05
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: SONY      Model: CD-RW  CRX140E    Rev: 1.0n
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
> sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.12
> sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> usb.c: registered new driver usbdevfs
> 
> 
> IDE related messages from failed boot:
> 
> PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode
> 
> appears before
> 	ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:pio, hdb:pio
> and the system dies after
> 	ide2 at 0x10f8-0x10ff,0x10f2 on irq 10
> 
> 
> hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=QUANTUM FIREBALLP LM30.0, FwRev=A35.0700, SerialNo=186011032806
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=1900kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
>  AdvancedPM=no
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
> ATA-4 ATA-5 
> 
> hdparm -i /dev/hde
> 
> /dev/hde:
> 
>  Model=ST330630A, FwRev=3.21, SerialNo=3CK04SY4
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=59777640
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
>  AdvancedPM=no
>  Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 
> 
> One final note: The RH 7.2 kernel (and maybe earlier ones, I can't
> remember)
> puts the Promise controller at hde/f and hdg/h instead, but the net result
> is the same.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
