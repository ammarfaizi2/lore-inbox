Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSD1Qh2>; Sun, 28 Apr 2002 12:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSD1Qh2>; Sun, 28 Apr 2002 12:37:28 -0400
Received: from mail.netbeat.de ([62.208.140.19]:7687 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id <S311710AbSD1Qh0>;
	Sun, 28 Apr 2002 12:37:26 -0400
Date: Sun, 28 Apr 2002 18:37:13 +0200
From: Henning Schroeder <hgs@anna-strasse.de>
X-Mailer: The Bat! (v1.53d)
Reply-To: Henning Schroeder <hgs@anna-strasse.de>
Organization: =?ISO-8859-1?B?QW5uYXN0cmFzc2UgV/xyemJ1cmc=?=
X-Priority: 3 (Normal)
Message-ID: <19984436483.20020428183713@anna-strasse.de>
To: linux-kernel@vger.kernel.org
Subject: VT8367 [KT266] and high IDE load crashes
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an ASUS A7V266-E Mainboard (VT8367 [KT266] Chipset, with VIA
IDE and Promise 20265 IDE Controller on board) that keeps crashing
under high IDE load. Athlon XP2000+ cpu, 1.5GiB DDR-RAM.

At each IDE port (running UDMA100), a MAXTOR 6L020J1 (four in total) 
running as master is connected.

The system runs fine for days, until I start massaging (e.g. running mysql 
over a raid-0 array of the four drives) the IDE system.
Using just one channel works perfectly, but as soon as I use two or
more channels heavily at the same time, it doesn´t take long for the
system to go down.

For testing, linux is installed on hda, so hdc, hde & hdf are unused.
I issue

badblocks -b 4096 -c 50000 -p 5 -v /dev/hdc &
badblocks -b 4096 -c 50000 -p 5 -v /dev/hde &
badblocks -b 4096 -c 50000 -p 5 -v /dev/hdg &

for stress testing and see the following after seconds, minutes or
hours:

hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdc: status error: error=0x84 { DriveStatusError BadCRC }
hdc: drive not ready for command
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdc: status error: error=0x84 { DriveStatusError BadCRC }
hdc: drive not ready for command
[...]

(different hd´s everytime). After a while, the system either crashes
or says "Unable to handle kernel paging request..." and crashes with
blinking keyboard led´s (CapsLock/ScrollLock)

Sometimes, there is "timeout waiting for DMA" or "drive not ready for
command" interspersed.

When I reboot I usually find out that the root fs on hda4(!) is fried
(Kernel panic: VFS: Unable to mount root fs on 03:04). e2fsck finds
gazillions of errors, what I don´t quite understand, since hda
shouldn´t have been touched very much.

Switching to PIO helps, but is not an option (system is supposed to be a
fast budget MySQL-Server with RAID-0). Removing Hard Disks does
not help, the problem occurs as well when I use only drives at the VIA
interface or only ones on the Promise interface.

I tried kernels 2.2.20, 2.4.18, 2.4.17 with Andre Hedricks
ide.2.4.17.02152002.patch, 2.4.19p7, 2.4.19p7-ac2 and 2.4.19p7 with
Andre Hedricks ide-2.4.19-p7.all.convert.6.patch. Same everywhere.

I tried BIOS versions 1004, 1007 and 1008.003 beta. No avail.

I changed and rerouted IDE cables. The PSU should be okay as well,
because it happens with only two drives (less load on the PSU) too. RAM is fine 
(several days of memtest86).

>From reading this list and googling it seems that problems like these
seem to be quite common, but i couldn´t find out whether they are likely
to be solved any time soon. Would I be better off just replacing the
board? From my understanding, the KT266 is the problem here, so would a
AMD761/VT82C686B chipset be trouble free?

Attached is some further information, I´d be happy to provide more 
if wanted/needed.

------------------------------------

dmesg says:

Linux version 2.4.19-pre7-ac2 (root@odin) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sun Apr 28 14:15:13 CEST 2002
[...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 12 for device 00:06.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: Assigned IRQ 5 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L020J1, ATA DISK drive
hdc: MAXTOR 6L020J1, ATA DISK drive
hde: MAXTOR 6L020J1, ATA DISK drive
hdg: MAXTOR 6L020J1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xd402 on irq 12
ide3 at 0xd000-0xd007,0xb802 on irq 12
hda: 40132503 sectors (20548 MB) w/1819KiB Cache, CHS=2498/255/63, UDMA(100)
hdc: 40132503 sectors (20548 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(100)
hde: 40132503 sectors (20548 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(100)
hdg: 40132503 sectors (20548 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(100)
[...]

-------------------------------------

lspci says:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
00:0c.0 VGA compatible unclassified device: S3 Inc. 86c864 [Vision 864 DRAM] vers 0
00:0e.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
00:0f.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

i´m using the intel e100 drivers because the eepro100 give me errors (card reports no resources et al.)



Best regards,
 Henning 
 
-- 
   Henning Schroeder, Wuerzburg                          mailto:hgs@anna-strasse.de                        

