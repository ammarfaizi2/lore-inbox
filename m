Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285632AbSAAWfs>; Tue, 1 Jan 2002 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbSAAWfj>; Tue, 1 Jan 2002 17:35:39 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:16610 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S285632AbSAAWfW>;
	Tue, 1 Jan 2002 17:35:22 -0500
Date: Tue, 1 Jan 2002 23:34:44 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: <andre@linuxdiskcert.org>, <andre@linux-ide.org>
Subject: Two hdds on one channel - why so slow?
Message-ID: <Pine.LNX.4.33.0201012330380.8078-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There is something wrong with ide data throughput with at last both via
kt133 and promise pcd20265 controllers.

I have Asus A7V-133 Mobo with VIA KT133A chipset and onboard Promise
pcd20265 ide controller. My CPU is Athlon 1400 MHz and I have 512 MB of
PC133 SDRAM. I noticed that connecting two ata100 hdds into the same
channel makes everything much slower. So I made some test:

# uname -r
2.4.18pre1

1) PDC20265

PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 11 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:pio, hdd:pio
hdc: ST380021A, ATA DISK drive
hdd: ST380021A, ATA DISK drive
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)


# /usr/bin/time hdparm -t /dev/hdc

/dev/hdc:
 Timing buffered disk reads:  64 MB in  1.63 seconds = 39.26 MB/sec
0.05user 0.26system 0:04.66elapsed 6%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps

# /usr/bin/time hdparm -t /dev/hdd

/dev/hdd:
 Timing buffered disk reads:  64 MB in  1.63 seconds = 39.26 MB/sec
0.03user 0.39system 0:04.67elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps
root@nimfa:~# /usr/bin/time hdparm -t /dev/hdd

OK, it seems that with one hdd there is no problem. Data transfers
are quite high (about 40 MB/sec) and CPU usage is low: 6% to 8% is
AFAIK quite good value. But let's try this:

# /usr/bin/time hdparm -t /dev/hdc & /usr/bin/time hdparm -t /dev/hdd
[1] 152

/dev/hdc:

/dev/hdd:
 Timing buffered disk reads:   Timing buffered disk reads:  64 MB in  5.48 seconds = 11.68 MB/sec
0.01user 0.41system 0:08.52elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps
64 MB in  5.55 seconds = 11.53 MB/sec
0.05user 0.30system 0:08.60elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps
[1]+  Done                    /usr/bin/time hdparm -t /dev/hdc

Oooops?!!?! Two ata100 hdds and each one can only archive read speed
at 11.5 MB/sec - this is only 24% of ATA100 interface throughput!

2) vt82c686b

VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
hdg: ST380021A, ATA DISK drive
hdh: ST380021A, ATA DISK drive
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hdh: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)

# /usr/bin/time hdparm -t /dev/hdg

/dev/hdg:
 Timing buffered disk reads:  64 MB in  1.63 seconds = 39.26 MB/sec
0.05user 0.21system 0:04.67elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps

# /usr/bin/time hdparm -t /dev/hdh

/dev/hdh:
 Timing buffered disk reads:  64 MB in  1.63 seconds = 39.26 MB/sec
0.00user 0.35system 0:04.67elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps

Nice :) 39.26 MB/sec - the same value like for PDC :) OK, what about two
disks at the same time:

# /usr/bin/time hdparm -t /dev/hdg & /usr/bin/time hdparm -t /dev/hdh
[1] 185

/dev/hdg:

/dev/hdh:
 Timing buffered disk reads:   Timing buffered disk reads:  64 MB in  5.35 seconds = 11.96 MB/sec
0.01user 0.43system 0:08.40elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps
64 MB in  5.45 seconds = 11.74 MB/sec
0.04user 0.27system 0:08.50elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (371major+12minor)pagefaults 0swaps
[1]+  Done                    /usr/bin/time hdparm -t /dev/hdg

And again! ATA100 with 24 MB/sec! Why this is so slow?! Any ideas?

Best regards,

			Krzysztof Oledzki


