Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbTCYWY1>; Tue, 25 Mar 2003 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTCYWY1>; Tue, 25 Mar 2003 17:24:27 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15365 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S261461AbTCYWYZ>; Tue, 25 Mar 2003 17:24:25 -0500
Date: Tue, 25 Mar 2003 17:33:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.66-bk1 - functional success and a few minor oddities
Message-ID: <Pine.LNX.4.44.0303251730540.1125-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well hum! So 2.5.66-bk1 built with 2.5.59 on my little test system, and
booted, and after booting it and rebuilding the kernel from make clean
the remake was a tiny bit faster. And the system has stayed up for 80
minutes, and is reasonably responsive. Running X on a P-II 350 with
only 96MB RAM is a good test system, if not much fun to use.

Don't know what changed from 2.5.65 to 2.5.66-bk1, but my /dev/lp0 is
found again. The aha152x module compiled, perhaps it will work after I
put the SCSI hardware back in the machine.


2.5.59:
  real	23m45.675s
  user	19m46.912s
  sys	1m34.438s


2.5.66-bk1:
  real	22m30.302s
  user	19m39.510s
  sys	1m30.998s


I only see a few problems, after normal boot my log shows thousands of these:
  Mar 25 15:38:16 oddball kernel: end_request: I/O error, dev hdc, sector 0
  Mar 25 15:38:48 oddball last message repeated 48 times
  Mar 25 15:39:50 oddball last message repeated 93 times
  Mar 25 15:40:52 oddball last message repeated 93 times
  Mar 25 15:41:44 oddball last message repeated 80 times

Now hdc is a CD-ROM:
  oddball:davidsen> cat /proc/ide/hd?/model
  Maxtor 90845D4
  WDC AC31600H
  NEC CD-ROM DRIVE:28C

This started before X, I booted into text mode. There is no CD in the
drive, no automount anything running, and nothing I can see which should
be trying to read the CD. From the dmesg, the first error happens as
soon as the drive is seen, as if the kernel were trying to read a
partition table...

  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  PIIX4: IDE controller at PCI slot 00:07.1
  PIIX4: chipset revision 1
  PIIX4: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
      ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:DMA, hdd:pio
  hda: Maxtor 90845D4, ATA DISK drive
  hdb: WDC AC31600H, ATA DISK drive
  hdb: Disabling (U)DMA for WDC AC31600H
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hdc: NEC CD-ROM DRIVE:28C, ATAPI CD/DVD-ROM drive
  ide1 at 0x170-0x177,0x376 on irq 15
  hda: host protected area => 1
  hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
   hda: hda1 hda2 hda3 hda4 < hda5 >
  hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
  hdb: task_no_data_intr: error=0x10 { SectorIdNotFound }, LBAsect=0, sector=0
  hdb: 3173184 sectors (1625 MB) w/128KiB Cache, CHS=3148/16/63
   hdb: hdb1 hdb2 hdb3
  hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
  Uniform CD-ROM driver Revision: 3.12
  end_request: I/O error, dev hdc, sector 0
  mice: PS/2 mouse device common for all mice

If I explicitly add hdc=cdrom to the boot parameters this doesn't
happen, so I suspect this is some minor glitch in detection.


Another minor issue is that DMA gets disabled on the hdb device, it is
dma capable, or so it claims. And setting the mode by hand has not
resulted in any "learning experiences." This may be caution by default,
I'm just noting it for completeness.

Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 128.0kB	ECC bytes: 22
	Standby timer values: spec'd by standard
	r/w multiple sector transfer: Max = 16	Current = 16
	DMA: mdma0 mdma1 *mdma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=160ns  IORDY flow control=120ns


Other than that I have (so far) no problems, I'm running with NMI and
softdog, and will be doing a number of benchmarks after 12 hours of
assorted compiles and the like.

