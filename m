Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLBOeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTLBOeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:34:16 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:48035 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S262164AbTLBOeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:34:08 -0500
Message-ID: <3FCCB0F4.9010907@free.fr>
Date: Tue, 02 Dec 2003 15:34:12 +0000
From: shal <shal@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via82cxxx, DMA and performance problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a MSI KT3 Ultra2 mother card with the VT82C586 IDE interface.

I have a question about IDE performance.


On the 2.6.0-test10-mm1, I have this :
# lsmod
Module                  Size  Used by
eagle_usb             113280  0

# hdparm /dev/hda
/dev/hda:
  multcount    = 16 (on)
  IO_support   =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  0 (off)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 65535/16/63, sectors = 78177792, start = 0

# hdparm -tT /dev/hda
/dev/hda:
  Timing buffer-cache reads:   920 MB in  2.01 seconds = 458.24 MB/sec
  Timing buffered disk reads:   22 MB in  3.05 seconds =   7.21 MB/sec

I do :
# modprobe via82cxxx

Now I have:

# hdparm -tT /dev/hda
/dev/hda:
  Timing buffer-cache reads:   744 MB in  2.00 seconds = 371.87 MB/sec
  Timing buffered disk reads:   20 MB in  3.06 seconds =   6.54 MB/sec

I active DMA:
# hdparm -d 1 /dev/hda
/dev/hda:
  setting using_dma to 1 (on)
  using_dma    =  1 (on)


And do a sync , the sync take one minute !!!!
When I active DMA, during one minute the disk freeze (sync or other 
program)!!

After the freeze, this work but no amelioration :
# hdparm -tT /dev/hda
/dev/hda:
  Timing buffer-cache reads:   940 MB in  2.01 seconds = 467.97 MB/sec
  Timing buffered disk reads:   20 MB in  3.05 seconds =   6.56 MB/sec


kernel message:
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using 
IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free.
hda: ERROR, PORTS ALREADY IN USE
hdb: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 3 for ide0
ide1: I/O resource 0x376-0x376 not free.
hdc: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 22 for ide1
Module via82cxxx cannot be unloaded due to unsafe usage in 
include/linux/module.h:483
blk: queue cf5cabf8, I/O limit 4095Mb (mask 0xffffffff)
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }









Information :

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0a.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee 
(rev 03)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: Maxtor 83240D3, ATA DISK drive
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
hdb: max request size: 128KiB
hdb: 6329388 sectors (3240 MB) w/256KiB Cache, CHS=6697/15/63
  hdb: hdb1 hdb2
hdc: ATAPI 32X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12



Another with the small hard drive (4G only):

# hdparm -tT /dev/hdb
/dev/hdb:
  Timing buffer-cache reads:   968 MB in  2.00 seconds = 483.83 MB/sec
  Timing buffered disk reads:   20 MB in  3.11 seconds =   6.43 MB/sec

root@shal:~# hdparm -d 1 /dev/hdb
/dev/hdb:
  setting using_dma to 1 (on)
  using_dma    =  1 (on)

root@shal:~# hdparm -tT /dev/hdb
/dev/hdb:
  Timing buffer-cache reads:   968 MB in  2.00 seconds = 483.35 MB/sec
  Timing buffered disk reads:   34 MB in  3.09 seconds =  11.00 MB/sec

The small hard drive is more speed than the big hard drive !!


On a normal Linux 2.4 (non ac tree) I can't use the via82cxxx without 
problem (DMA interrupt lost during boot).
If the Alan Cox kernel (2.4.22-ac4) it work fine.
Performance are 2MBit/sec without module and 6MBit/sec with module.





