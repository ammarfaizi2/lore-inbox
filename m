Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSAJPE5>; Thu, 10 Jan 2002 10:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289486AbSAJPEr>; Thu, 10 Jan 2002 10:04:47 -0500
Received: from dsl-213-023-060-253.arcor-ip.net ([213.23.60.253]:48645 "HELO
	spot.local") by vger.kernel.org with SMTP id <S289482AbSAJPEg>;
	Thu, 10 Jan 2002 10:04:36 -0500
Date: Thu, 10 Jan 2002 16:07:18 +0100
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: HPT370 controller set wrong udma mode
Message-ID: <20020110160718.A296@gmxpro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	My onboard (Epox 8KTA3+) HPT370 controller seems to set the wrong udma 
transfer mode for the attached drive. Resulting in BadCRC errors. The drive 
attached is an IBM DJSA-205 2.5" drive. It can do udma4 max.

	The HD is connected with the controller with a 3.5"->2.5" adapter 
cable that is only 40 pin. The controller BIOS shows that the drive uses 
udma2. However when I boot Linux the HPT370 driver sets the drive to udma4. 
Setting the mode manually with hdparm makes the drive work.

	The drive is correctly accessed with udma2 when attached to the 
VIA686B IDE controller. Cable type "40w" is shown in /proc/ide/via. Does the 
HPT driver even detect if there is an 80w or 40w cable in place? The 
chip should be able to distinguish this somehow since the correct mode is 
shown in the BIOS.

	The log messages for the ide controllers are (drive set to UDMA(66)):

Kernel is 2.4.16
[...]
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:DMA
HPT370A: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:09.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DHEA-36481, ATA DISK drive
hdb: IBM-DJNA-351520, ATA DISK drive
hdd: Pioneer CD-ROM ATAPI Model DR-744 0102, ATAPI CD/DVD-ROM drive
hde: IBM-DJSA-205, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xbc00-0xbc07,0xc002 on irq 10
hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
hdb: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=1869/255/63, UDMA(33)
hde: 9767520 sectors (5001 MB) w/384KiB Cache, CHS=10336/15/63, UDMA(66)
hdd: ATAPI 32X CD-ROM drive, 128kB Cache, DMA

	The drive settings after the boot:

/dev/discs/disc2/disc:

 Model=IBM-DJSA-205, FwRev=JS1OAB7A, SerialNo=8ZY8Z353728
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=10336/15/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=384kB, MaxMultSect=16, MultSect=off
 CurCHS=10336/15/63, CurSects=9767520, LBA=yes, LBAsects=9767520
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 

	Writing/reading data results in:

Jan 10 15:40:42 kiza kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan 10 15:40:42 kiza kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan 10 15:40:43 kiza kernel: ide2: reset: success



-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
