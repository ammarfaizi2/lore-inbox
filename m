Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbSIWL4W>; Mon, 23 Sep 2002 07:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265615AbSIWL4W>; Mon, 23 Sep 2002 07:56:22 -0400
Received: from dachs.cyberlink.ch ([62.12.136.4]:26556 "HELO
	dachs.cyberlink.ch") by vger.kernel.org with SMTP
	id <S265592AbSIWL4U> convert rfc822-to-8bit; Mon, 23 Sep 2002 07:56:20 -0400
Message-ID: <3D8F029A.50207@mitlinks.ch>
Date: Mon, 23 Sep 2002 14:01:30 +0200
From: Fabian Lienert <lienert@mitlinks.ch>
Organization: mitLinks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Hank Yang <support@promise.com.tw>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Promise Ultra 100 TX2 IDE cards provoce system crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Promise TX2 IDE cards and PDC20268 driver: Last night when backup 
writing started from our Software RAID5 to the single drive, the system 
crashed, no oops messages.


I built up a Debian stable fileserver with Software RAID5 and Reiserfs.
we use:

2 Promise Ultra 100 TX2 IDE Controller Cards,
4 Maxtor D740X ATA 133 80 GB harddisks, linked by Ultra ATA cables to 
the two Promise cards. Every disk is master. We use 3 disks for the 
Software RAID-5, one as a single (no raid) backup drive.

Kernel is 2.4.18 with Support for RAID-5, Reiserfs, Promise Ultra 100 
and Server Works OSB4 IDE Controllers (the onboard controller only for a 
unused spare disk and cdrom). Didn't found this fixed in 2.4.19.

The system crashed during the backup from RAID to /dev/hde while writing 
a huge file bigger than 770 MB. This is the last log I have.

Before this crash I had another crash because of setting the drives to 
udma6. Now the drives are set with hdparm to udma5:

hdparm -d 1 -c 1 -k 1 -X69 /dev/hde
hdparm -d 1 -c 1 -k 1 -X69 /dev/hdg
hdparm -d 1 -c 1 -k 1 -X69 /dev/hdi
hdparm -d 1 -c 1 -k 1 -X69 /dev/hdk

Because the kernel sets only /dev/hdi and /dev/hdk to udma5 even if
append="ide2=ata66 ide3=ata66 ide4=ata66 ide5=ata66" or the same with 
ata100 is in lilo.conf.

/etc/raidtab:
--
raiddev /dev/md0
         raid-level      5
         nr-raid-disks   3
         nr-spare-disks  0
         persistent-superblock 1
         parity-algorithm        left-symmetric
         chunk-size      32
         device          /dev/hdg1
         raid-disk       0
         device          /dev/hdi1
         raid-disk       1
         device          /dev/hdk1
         raid-disk       2
--

lspci:
--
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 PCI bridge: ServerWorks CNB20LE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
00:06.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP 
(rev 01)
02:01.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02)
02:02.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02)
--

part of dmesg:
--
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
PDC20268: IDE controller on PCI bus 02 dev 10
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xfebf8000
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
     ide2: BM-DMA at 0xef90-0xef97, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xef98-0xef9f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 02 dev 08
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xfebf0000
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER 
Mode.
     ide4: BM-DMA at 0xef60-0xef67, BIOS settings: hdi:pio, hdj:pio
     ide5: BM-DMA at 0xef68-0xef6f, BIOS settings: hdk:pio, hdl:pio
hda: IC35L080AVVA07-0, ATA DISK drive
hdc: ATAPI-CD ROM-DRIVE-56MAX, ATAPI CD/DVD-ROM drive
hde: MAXTOR 6L080J4, ATA DISK drive
hdg: MAXTOR 6L080J4, ATA DISK drive
hdi: MAXTOR 6L080J4, ATA DISK drive
hdk: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xeff0-0xeff7,0xefe6 on irq 24
ide3 at 0xefa8-0xefaf,0xefe2 on irq 24
ide4 at 0xefa0-0xefa7,0xef8e on irq 22
ide5 at 0xef80-0xef87,0xef8a on irq 22
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, 
UDMA(33)
hde: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, (U)DMA
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, (U)DMA
hdi: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, 
UDMA(100)
hdk: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, 
UDMA(100)
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
--

part of .config (enabled options only):
--
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=y
--

thanks for any help!
-- 
Fabian Lienert . mitLinks AG . Limmatstrasse 291 . CH-8005 Zürich
  lienert@mitlinks.ch . ++41 1 444 10 44 . http://www.mitlinks.ch
    pgp public key: http://www.mitlinks.ch/keys/lienert.asc

