Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbRAJHYx>; Wed, 10 Jan 2001 02:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRAJHYo>; Wed, 10 Jan 2001 02:24:44 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:38148 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S130464AbRAJHYZ>; Wed, 10 Jan 2001 02:24:25 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Jan 2001 08:24:17 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: some issues for 2.4.0
Message-ID: <3A5C1C26.1288.209640@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some issues on Linux-2.4.0:

During boot the (slightly modified, see later) kernel says:

<4>Linux version 2.4.0-NANO (root@elf) (gcc version 2.95.2 19991024 (release)) #1 Mon Jan 8 
22:04:48 MET 2001
[...]
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb280, last bus=1
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>Unknown bridge resource 0: assuming transparent

??? What does the message above mean?

<4>PCI: Using IRQ router VIA [1106/0596] at 00:07.0
<6>Activating ISA DMA hang workarounds.

The DMI reports some funny values for my low-price board (the vendor
did not ship a DMI utility as Asus did for my old one):

<6>DMI 2.2 present.
<6>39 structures occupying 1055 bytes.
<6>DMI table at 0x000F0800.
<4>BIOS Vendor: Award Software International, Inc.
<4>BIOS Version: 4.51 PG
<4>BIOS Release: 06/19/00
<4>System Vendor: VIA Technologies, Inc..
<4>Product Name: VT82C693BX.
<4>Version  .
<4>Serial Number  .

??? Aren't they (above two lines) funny?

<4>Board Vendor: Shuttle Inc..
<4>Board Name: HOT-AV11 693-596-W977.
<4>Board Version: 2A6LGH2A.

[...]

As reported for 2.4.0-test12 there seems to be a problem timing events
within an interrupt (e.g. serial): The jitter is quite high. I'm
timing pulses generated from a GPS clock every second to estimate the
clock error. I'll show the first few updates.  Let's show some facts
first, and they state a suspect. The pair is seconds:nanoseconds
for the captured timestamps. My pulse is roughly 200ms+800ms:

979070631:649924277
979070632:49920873
979070633:649922851
979070634:49921630
979070635:649923125
979070636:49920800

??? Oops! Time jumped back!

979070633:354954544
979070633:754953483
979070635:354954708
979070635:754954209
979070637:354955615
979070637:754953649
979070639:354955938
979070639:754953328

??? Again!

979070637:59988575
979070637:459985921
979070639:59986981
979070639:459985930
979070641:59986854
979070641:459985908
979070643:59987006
979070643:459987393
979070645:59987262
979070645:136458168

979070642:765020874
979070643:165018428
979070644:765019464
979070645:165018406
979070646:765019339
979070647:165018295
979070648:765019475
979070649:165018274

979070646:470052764
979070646:870050956
979070648:470053050
979070648:870051264
979070650:470052609
979070650:870051691
979070652:470052047
979070652:870050772

979070650:175085546
979070650:575083574
979070652:175084550
979070652:575083463
979070654:175085050
979070654:575084190
979070656:175084787
979070656:575083420
979070658:175084652
979070658:251540985
979070655:880118226
979070656:280115991
979070657:880118654
979070658:280116032
979070659:880118844
979070660:280115978
979070661:880123413
979070662:280115897

979070659:585150248
979070659:985148519
979070661:585149737
979070661:985148498
979070663:585150396
979070663:985148476
979070665:585150361
979070665:985148365

979070663:290189552
979070663:690181048
979070665:290182834
979070665:690181774
979070667:290182445
979070667:690181783
979070669:290182466
979070669:690181672
979070671:290182951

I either think that some overflow happens, or that some spinlock is
really busy. You can find the patch used in
ftp://ftp.kernel.org/pub/linux/daemons/ntp/PPS/PPS-2.4.0-pre3.tar.bz2

My CPU is identified as:
elf:/tmp # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.149
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 999.42


Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
