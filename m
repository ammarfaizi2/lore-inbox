Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314454AbSEFObR>; Mon, 6 May 2002 10:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314456AbSEFObQ>; Mon, 6 May 2002 10:31:16 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:4868 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S314454AbSEFObP>;
	Mon, 6 May 2002 10:31:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Promise IDE on Alpha
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 06 May 2002 16:31:15 +0200
Message-ID: <yw1xg015pcuk.fsf@xq506.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Promise PDC20268 IDE controller in a PWS433au Alpha machine.

With kernel 2.4.18 it works, but only at UDMA3 which must be forced with
hdparm. UDMA4/5 can be set with hdparm, but at any disk access there are
some errors and the mode is dropped to UDMA3.

I tried 2.4.19-pre8 in the hope that it would work better. It does
correctly detect the drive as UDMA capable but only UDMA2. The higher
modes can't be set with hdparm. I found out that this was because a
udma_four flag in some struct wasn't set. I changed pdc2026xx.c and
set this flag and could set UDMA3. The better modes were still broken.

Is this Alpha specific or a generic driver problem?

dmesg output with original 2.4.19-pre8:
Linux version 2.4.19-pre8 (mru@zaphod) (gcc version 3.0.4) #1 Sun May 5 11:44:45 CEST 2002
Booting on Miata using machine vector Miata from SRM
[snip]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller on PCI bus 00 dev 20
CMD646: detected chipset, but driver not compiled in!
CMD646: chipset revision 1
CMD646: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev 60
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0x09074000
    ide2: BM-DMA at 0x8090-0x8097, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8098-0x809f, BIOS settings: hdg:pio, hdh:pio
hde: ST340810A, ATA DISK drive
hdg: SAMSUNG COMBO SM-304B, ATAPI CD/DVD-ROM drive
ide2 at 0x80a0-0x80a7,0x80b2 on irq 32
ide3 at 0x80a8-0x80af,0x80b6 on irq 32
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(33)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: unknown partition table
[snip]
ide2: Speed warnings UDMA 3/4/5 is not functional. << Caused by hdparm

dmesg output with my changes:
Linux version 2.4.19-pre8 (mru@zaphod) (gcc version 3.0.4) #2 Sun May 5 17:54:12 CEST 2002
Booting on Miata using machine vector Miata from SRM
[snip]
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
pci: tbia workaround enabled
pci: pyxis 8K boundary dma bug - sg dma disabled
[snip]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller on PCI bus 00 dev 20
CMD646: detected chipset, but driver not compiled in!
CMD646: chipset revision 1
CMD646: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev 60
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0x09074000
    ide2: BM-DMA at 0x8090-0x8097, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8098-0x809f, BIOS settings: hdg:pio, hdh:pio
hde: ST340810A, ATA DISK drive
hdg: SAMSUNG COMBO SM-304B, ATAPI CD/DVD-ROM drive
ide2 at 0x80a0-0x80a7,0x80b2 on irq 32
ide3 at 0x80a8-0x80af,0x80b6 on irq 32
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus0/target0/lun0:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success
 unknown partition table


-- 
Måns Rullgård
mru@users.sf.net
