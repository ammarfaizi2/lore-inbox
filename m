Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSGGU3Y>; Sun, 7 Jul 2002 16:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGGU3X>; Sun, 7 Jul 2002 16:29:23 -0400
Received: from 80-235-65-236-dsl.kj.estpak.ee ([80.235.65.236]:1664 "EHLO
	film.konimois") by vger.kernel.org with ESMTP id <S316545AbSGGU3W>;
	Sun, 7 Jul 2002 16:29:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Lillepuu <drac@hot.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 pdc20276 dma timeout
Date: Sun, 7 Jul 2002 23:32:17 +0300
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207072332.17747.drac@hot.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

One of my hdd's connected to pdc20276 ide raid controller gets dma timeout 
when performing backup to scsi tape. Using hp dat24i bundled backup sw 
tapeware (with latest service pack) it crashed 100%, usually close to the end 
of the backup or at latest, during verify process. Using dump/restore package 
it required some additional disk activity (copying files from/to samba share 
over network) and 3-4 tries to trigger the dma timeout. pdc20276 has 2 60Gb 
Maxtor D740X's configured as raid1 mirror. Motherboard is Asus A7V333 using 
VIA KT333 chipset. I'm currently using kernel version 2.4.19-rc1 (2.4.18 
didn't  recognize the pdc20276 correctly yet). I'm also using sg version 
30124, as tapeware support page suggests. Enabling taskfile and 'hack around 
chipsets that timeout (wip)' kernel options did not resolve the issue. The 
scsi board (sym53c810a) is one possible suspect, because stressing the disks 
using bonnie++ and some samba network activity while scsi tape is idle does 
not trigger the timeout.  Any ideas what to check, do or patch to resolve the 
issue are welcome :) 

here come the logs:

timeout dmesg:

hda: timeout waiting for DMA
PDC202XX: Primary channel reset.
hda: ide_dma_timeout: Lets do it again!stat = 0x50, dma_stat = 0x20
hda: DMA disabled
PDC202XX: Primary channel reset.
hda: ide_set_handler: handler not null; old=c01e6e50, new=c01ec0d0
bug: kernel timer added twice at c01e6cc5.


boot dmesg:

PDC20276: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 12 for device 00:06.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using 
pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
hda: MAXTOR 6L060J3, ATA DISK drive
hdc: MAXTOR 6L060J3, ATA DISK drive
hde: CDU5211, ATAPI CD/DVD-ROM drive
ide0 at 0xb400-0xb407,0xb002 on irq 12
ide1 at 0xa800-0xa807,0xa402 on irq 12
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(133)
hdc: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(133)
hde: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [7299/255/63] hda1 hda2 < hda5 hda6 >
 hdc: [PTBL] [7299/255/63] hdc1 hdc2 < hdc5 hdc6 >

....

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0f.0
sym53c8xx: at PCI bus 0, device 15, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c810a detected
sym53c810a-0: rev 0x23 on pci bus 0 device 15 function 0 irq 10
sym53c810a-0: ID 7, Fast-10, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: HP        Model: C1537A            Rev: L105
  Type:   Sequential-Access                  ANSI SCSI revision: 02

-----

/proc/interrupts

           CPU0
  0:     386333          XT-PIC  timer
  1:          8          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:    1758559          XT-PIC  eth0
 10:         16          XT-PIC  sym53c8xx
 12:     498085          XT-PIC  ide0, ide1
 14:          4          XT-PIC  ide2
NMI:          0
ERR:        634

-- 
Martin Lillepuu
