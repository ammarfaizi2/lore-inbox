Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRA3JX7>; Tue, 30 Jan 2001 04:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRA3JXs>; Tue, 30 Jan 2001 04:23:48 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:62672 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129172AbRA3JXk>; Tue, 30 Jan 2001 04:23:40 -0500
Date: Tue, 30 Jan 2001 10:23:22 +0100
From: Dejan Muhamedagic <dejan@xsoft.at>
To: linux-kernel@vger.kernel.org
Subject: file corruption on v2.2
Message-ID: <20010130102322.B1151@smtp.chello.at>
Reply-To: Dejan Muhamedagic <dejan@xsoft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: XSoft GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have got a reproducible file corruption with kernels from
2.2 series.  Ftp-ing a 350MB file revealed the problem.
md5sum produced a different checksum on the target host.
In fact any write operation of a similar size will result in
file corruption (i.e. the file written is not the same as
the file read).  Running a modified Bonnie test yielded the
following results (writing/comparing a ~1.7GB file):

filepos		bytes	offset to the next (in MB)
287977473	4094	293
595566593	4094	293
902807553	4094	292
1209094145	4094	292
1515995137	4094	291
1822068737	4094

The number of bytes corrupted looks suspiciously close to the
page size.  The offsets hint at the amount of memory
available for the caching purpose.  The test was run in
single and multiple user modes and produced the same results
with both versions 2.2.17 and 2.2.18.  Sometimes the laptop
would freeze as well.  I tested the memory and it seems to
be OK.

Later, I found out that disabling the DMA solves the issue
(of course, with a severe performance penalty).  Also,
kernel v2.4.0 doesn't exhibit this problem.

Below is some info I thought relevant [in case somebody
needs more, just drop me a line].

Cheers.

Dejan

P.S.  Please respond directly to my address (not subscribed
to linux-kernel).

-- 
Dejan Muhamedagic                      mailto:dejan@xsoft.at
Xsoft GmbH                               http://www.xsoft.at
Modecenterstr. 14, 1030 Vienna, Austria    +43 1 7963636 676

--------------------------------------------------

IBM ThinkPad 600x (320MB of memory)
Stock kernels 2.2.17 and 2.2.18 with international crypto patches

# gcc --version
2.95.2
# dpkg -l libc6 | grep libc6
ii  libc6          2.2-6          GNU C Library: Shared libraries and Timezone
# ld -v
GNU ld version 2.10.91 (with BFD 2.10.1.0.2)
# ldd --version
ldd (GNU libc) 2.2
Copyright (C) 1999 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Written by Roland McGrath and Ulrich Drepper.
# cat /proc/interrupts
           CPU0       
  0:     100277          XT-PIC  timer
  1:       3014          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:      38768          XT-PIC  ibmtr_cs
 11:          1          XT-PIC  cs461x, i82365
 12:      17960          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:     118526          XT-PIC  ide0
 15:          7          XT-PIC  ide1
NMI:          0
# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 440BX - 82443BX Host (rev 3).
      Medium devsel.  Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0x40000000 [0x40000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel 440BX - 82443BX AGP (rev 3).
      Medium devsel.  Master Capable.  Latency=168.  Min Gnt=136.
  Bus  0, device   2, function  0:
    CardBus bridge: Texas Instruments Unknown device (rev 3).
      Vendor id=104c. Device id=ac1b.
      Medium devsel.  IRQ 11.  Master Capable.  Latency=168.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x50103000 [0x50103000].
  Bus  0, device   2, function  1:
    CardBus bridge: Texas Instruments Unknown device (rev 3).
      Vendor id=104c. Device id=ac1b.
      Medium devsel.  IRQ 11.  Master Capable.  Latency=168.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x2000 [0x2000].
  Bus  0, device   3, function  0:
    Communication controller: Lucent (ex-AT&T) Microelectronics Unknown device (rev 1).
      Vendor id=11c1. Device id=449.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  No bursts.  Min Gnt=252.Max Lat=14.
      Non-prefetchable 32 bit memory at 0x50101000 [0x50101000].
      I/O at 0x4500 [0x4501].
      I/O at 0x4400 [0x4401].
  Bus  0, device   6, function  0:
    Multimedia audio controller: Cirrus Logic Unknown device (rev 1).
      Vendor id=1013. Device id=6003.
      Slow devsel.  IRQ 11.  Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0x50100000 [0x50100000].
      Non-prefetchable 32 bit memory at 0x50000000 [0x50000000].
  Bus  0, device   7, function  0:
    Bridge: Intel 82371AB PIIX4 ISA (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=48.  
      I/O at 0xfcf0 [0xfcf1].
  Bus  0, device   7, function  2:
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=48.  
      I/O at 0x4000 [0x4001].
  Bus  0, device   7, function  3:
    Bridge: Intel 82371AB PIIX4 ACPI (rev 3).
      Medium devsel.  Fast back-to-back capable.  
  Bus  1, device   0, function  0:
    VGA compatible controller: Neomagic Unknown device (rev 0).
      Vendor id=10c8. Device id=6.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=128.  Min Gnt=16.Max Lat=255.
      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
      Non-prefetchable 32 bit memory at 0x70000000 [0x70000000].
      Non-prefetchable 32 bit memory at 0x70400000 [0x70400000].

--------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
