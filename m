Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUKJVZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUKJVZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUKJVYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:24:25 -0500
Received: from ptr-207-54-98-202.ptr.terago.ca ([207.54.98.202]:58480 "EHLO
	nagios.knad.ca") by vger.kernel.org with ESMTP id S262120AbUKJVWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:22:45 -0500
Message-ID: <419286A2.3060706@kuehne-nagel.com>
Date: Wed, 10 Nov 2004 14:22:42 -0700
From: Robert Toole <robert.toole@kuehne-nagel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
References: <418FE1B3.8020203@kuehne-nagel.com>	 <1099956451.14146.4.camel@localhost.localdomain>	 <4192308C.3060100@kuehne-nagel.com> <1100110612.20556.6.camel@localhost.localdomain>
In-Reply-To: <1100110612.20556.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> On Mer, 2004-11-10 at 15:15, Robert Toole wrote:
> 
>>I installed -ac7 yesterday, and have been testing for 24 hours now with 
>>no problems. (It's way better than the scsi hack from ITE) There is just 
>>one thing, the driver did not enable DMA by default, needless to say 
>>performance was awful. I turned it on with hdparm and everything appears 
>>ok. Is this by design due to the experimental nature of the driver?
> 
> 
> Ah that is a bug. Please send me more info - drive info, hdparm etc.
> 
> 
Ok here is what I have:

Gigabyte GA-7M400 Pro 2 (Rev 2.0) integrated IT8212 controller:

- Bios for the controller: 1.14, Firmware ver 02093030

Info from the setup utility:

- RAID resources
   Ch0 Interrupt:B I/P port: 00009410
   Ch1 Interrupt:B I/P port: 00009C10

- Auto rebuild is on

- The controller sets up the drives with UDMA6 on post.

Hard drive info:

2 x Maxtor 40GB 7200rpm ATA133 Model: 6E040L0 set up in a raid 1 config.

Right after I boot I do: hdparm -tT /dev/hde

/dev/hde:
  Timing cached reads:   1620 MB in  2.00 seconds = 809.31 MB/sec
  Timing buffered disk reads:    6 MB in  3.40 seconds =   1.77 MB/sec

hdparm /dev/hde

/dev/hde:
  multcount    =  0 (off)
  IO_support   =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  0 (off)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 4998/255/63, sectors = 41110141952, start = 0

hdparm -d 1 -A 1 -m 16 -u 1 -a 64 /dev/hde

- it does not like the multicount setting, saying HDIO_SET_MULTCOUNT 
failed: invalid argument. (I don't really understand this, and don't 
think I need it, I picked it up from the gentoo howto.) the drives work 
great anyway :) I included the error because it might tell you something.

/dev/hde:
  setting fs readahead to 64
  setting multcount to 16
  setting unmaskirq to 1 (on)
  setting using_dma to 1 (on)
  setting drive read-lookahead to 1 (on)
  multcount    =  0 (off)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)
  readahead    = 64 (on)

hdparm -tT /dev/hde

/dev/hde:
  Timing cached reads:   1604 MB in  2.00 seconds = 801.72 MB/sec
  Timing buffered disk reads:  158 MB in  3.00 seconds =  52.59 MB/sec

For comparison, here is hdparm from /dev/hda which is attached to the 
nforce2 controller:

/dev/hda:
  Timing cached reads:   1624 MB in  2.00 seconds = 810.10 MB/sec
  Timing buffered disk reads:  150 MB in  3.01 seconds =  49.81 MB/sec

/dev/hda:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 16383/255/63, sectors = 40059321856, start = 0

It works fantastic once you enable dma

Here is dmesg (snipped for brevity)

<--snip-->

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP0411N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
IT8212: IDE controller at PCI slot 0000:01:0c.0
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
IT8212: chipset revision 17
IT8212: 100% native mode on irq 11
     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
it8212: controller in smart mode.
     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 RAID 1 volume.
ide2 at 0x9410-0x9417,0x9802 on irq 11
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: Host Protected Area detected.
  current capacity is 78240863 sectors (40059 MB)
  native  capacity is 78242976 sectors (40060 MB)
hda: 78240863 sectors (40059 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(100)
hda: cache flushes supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hde: max request size: 128KiB
hde: 80293246 sectors (41110 MB), CHS=4998/255/63
hde: cache flushes not supported
  /dev/ide/host2/bus0/target0/lun0: p1
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

Is there any more info you could use? My lspci, .config is in my first 
post. This is a pure test box, so I can do pretty much anything you want 
to it :)

Thanks,
Robert.


-




