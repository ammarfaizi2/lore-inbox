Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTIIUww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTIIUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:52:31 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:2227 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264601AbTIIUwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:52:10 -0400
Message-ID: <3F5E3DDE.4070109@unr.edu>
Date: Tue, 09 Sep 2003 13:53:50 -0700
From: Scott Fritzinger <scottf@unr.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multiple drives on 2 IDE controllers on 2.4.22 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Background:

I have 4 CD burners, 2 on each channel of the MB's IDE controller:

   VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
   ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
   ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA

and a 120 Gig HD (boot drive) on a PCI Promise IDE controller:

   PDC20268: IDE controller at PCI slot 00:09.0
   ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
   ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio

and have ide-scsi attached to the 4 CD burners via a boot param:

   Kernel command line: auto BOOT_IMAGE=Linux-2.4.22 ro root=210
   ide-scsi hdc=ide-scsi hdd=ide-scsi
   ide_setup: hda=ide-scsi
   ide_setup: hdb=ide-scsi
   ide_setup: hdc=ide-scsi
   ide_setup: hdd=ide-scsi
     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hd
     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hd
     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hd
     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hd
   hda: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
   hdb: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
   hdc: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
   hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
   hde: Maxtor 6Y080P0, ATA DISK drive
   hde: attached ide-disk driver.
   hde: host protected area => 1
   hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816
    hde: hde1 hde2
   hda: attached ide-scsi driver.
   hdb: attached ide-scsi driver.
   hdc: attached ide-scsi driver.
   hdd: attached ide-scsi driver.

I am using 4 instances of CDRDAO to burn a single image to the 4 
different CD burners. When running with 2.4.21-ac1, everything ran 
'mostly' fine. Occasionally one of the drives would write a VERY large 
lead-out, and the other drive on that channel would not eject until the 
lead-out was done on the other drive (eject command wasn't received?). 
Burning occurred at full speed in this setup, but the freeze-ups and 
delays were frustrating. The firmware on the drives is up to date, and 
burning an image to a single drive works flawlessly.

We updated to 2.4.22 to see if something had been fixed, and it looks 
like everything is working fine now, but everything is VERY VERY slow. 
The drives are burning at about 1/3rd speed as they were. It also 
appears as though 1 of the drives will receive a large chunk of data and 
spin-up, then another drive receives a large chunk and spins up, etc.. 
instead of uniformly writing to all 4 drives at the same time.

Running 'top' during the burn shows that kernel time was at 65% and user 
time was near zero. It is almost as if the ide driver or the ide scsi 
emulation layer was locked up (mutex'd?) on a single command until it 
completed (speculation! :-P)

Anyone else see this? Is there an explanation for this? Any pointers to 
docs that I should read? I've grep'd the Documentation and searched 
elsewhere, but couldn't find any more info on this topic. :-/ Below is 
some more information that might be helpful.

Thanks!

-Scott

uname -a:
Linux doop1 2.4.22 #2 Mon Sep 8 14:09:27 CDT 2003 i686 unknown

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2200+
stepping        : 1
cpu MHz         : 1810.027
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3604.48

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
9000-907f : Silicon Integrated Systems [SiS] SiS300/305 PCI/AGP VGA 
Display Adapter
9400-9407 : Promise Technology, Inc. 20268
   9400-9407 : ide2
9800-9803 : Promise Technology, Inc. 20268
   9802-9802 : ide2
9c00-9c07 : Promise Technology, Inc. 20268
a000-a003 : Promise Technology, Inc. 20268
a400-a40f : Promise Technology, Inc. 20268
   a400-a407 : ide2
   a408-a40f : ide3
bc00-bc07 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
c000-c003 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
c400-c407 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
c800-c803 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
cc00-cc0f : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
d000-d01f : VIA Technologies, Inc. USB
d400-d41f : VIA Technologies, Inc. USB (#2)
d800-d81f : VIA Technologies, Inc. USB (#3)
dc00-dc0f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C 
PIPC Bus Master IDE
   dc00-dc07 : ide0
   dc08-dc0f : ide1
e000-e0ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
e400-e4ff : VIA Technologies, Inc. VT6102 [Rhine-II]
   e400-e4ff : via-rhine

/proc/iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
   00100000-001ee67d : Kernel code
   001ee67e-0022d87f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
d8000000-dfffffff : Silicon Integrated Systems [SiS] SiS300/305 PCI/AGP 
VGA Display Adapter
e0060000-e007ffff : Silicon Integrated Systems [SiS] SiS300/305 PCI/AGP 
VGA Display Adapter
e00a0000-e00a3fff : Promise Technology, Inc. 20268
e00a4000-e00a41ff : CMD Technology Inc Silicon Image SiI 3112 SATARaid 
Controller
e00a5000-e00a50ff : VIA Technologies, Inc. USB 2.0
e00a6000-e00a60ff : VIA Technologies, Inc. VT6102 [Rhine-II]
   e00a6000-e00a60ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

lsmod:
Module                  Size  Used by    Not tainted
ide-scsi                9152   0
scsi_mod               85512   1  [ide-scsi]
via-rhine              13416   1
mii                     2416   0  [via-rhine]
crc32                   2816   0  [via-rhine]
rtc                     6044   0  (autoclean)

/proc/pci:
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge 
(rev 0).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (rev 0).
       Master Capable.  No bursts.  Min Gnt=4.
   Bus  0, device   8, function  0:
     VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS300/305 PCI/AGP VGA Display Adapter (rev 144).
       Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
       Non-prefetchable 32 bit memory at 0xe0060000 [0xe007ffff].
       I/O at 0x9000 [0x907f].
   Bus  0, device   9, function  0:
     Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 2).
       IRQ 10.
       Master Capable.  Latency=32.  Min Gnt=4.Max Lat=18.
       I/O at 0x9400 [0x9407].
       I/O at 0x9800 [0x9803].
       I/O at 0x9c00 [0x9c07].
       I/O at 0xa000 [0xa003].
       I/O at 0xa400 [0xa40f].
       Non-prefetchable 32 bit memory at 0xe00a0000 [0xe00a3fff].
   Bus  0, device  15, function  0:
     RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 1).
       IRQ 11.
       Master Capable.  Latency=32.
       I/O at 0xbc00 [0xbc07].
       I/O at 0xc000 [0xc003].
       I/O at 0xc400 [0xc407].
       I/O at 0xc800 [0xc803].
       I/O at 0xcc00 [0xcc0f].
       Non-prefetchable 32 bit memory at 0xe00a4000 [0xe00a41ff].
   Bus  0, device  16, function  0:
     USB Controller: VIA Technologies, Inc. USB (rev 128).
       IRQ 12.
       Master Capable.  Latency=32.
       I/O at 0xd000 [0xd01f].
   Bus  0, device  16, function  1:
     USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
       IRQ 10.
       Master Capable.  Latency=32.
       I/O at 0xd400 [0xd41f].
   Bus  0, device  16, function  2:
     USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
       IRQ 11.
       Master Capable.  Latency=32.
       I/O at 0xd800 [0xd81f].
   Bus  0, device  16, function  3:
     USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
       IRQ 5.
       Master Capable.  Latency=32.
       Non-prefetchable 32 bit memory at 0xe00a5000 [0xe00a50ff].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
       Master Capable.  Latency=32.
       I/O at 0xdc00 [0xdc0f].
   Bus  0, device  17, function  5:
     Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 
AC97 Audio Controller (rev 80).
       IRQ 11.
       I/O at 0xe000 [0xe0ff].
   Bus  0, device  18, function  0:
     Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
116).
       IRQ 12.
       Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
       I/O at 0xe400 [0xe4ff].
       Non-prefetchable 32 bit memory at 0xe00a6000 [0xe00a60ff].


