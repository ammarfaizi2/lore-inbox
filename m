Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131736AbRCUTP5>; Wed, 21 Mar 2001 14:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRCUTPs>; Wed, 21 Mar 2001 14:15:48 -0500
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:55475 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S131736AbRCUTPh>; Wed, 21 Mar 2001 14:15:37 -0500
Message-ID: <3AB8FDAD.BF71A5F@bigfoot.com>
Date: Wed, 21 Mar 2001 11:14:53 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    Device Boot    Start       End    Blocks   Id  System
> > /dev/hda1   *         1       932   7486258+   b  Win95 FAT32
> > ...
> > I also ran hdparm -tT /dev/hda1:
> >
> > Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
> >  Timing buffered disk reads:  64 MB in  4.35 seconds = 14.71 MB/sec
> >
> > I then tried hdparm -tT /dev/hda7:
> >
> >  Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
> >  Timing buffered disk reads:  64 MB in  2.12 seconds = 30.19 MB/sec

Change partition type to 'c' (fat32+LBA); check that BIOS is set for
(AUTO or USER) and LBA.


Regarding the PIIX4, I reran basic throughput read tests on a more
recent UDMA5, 5400RPM Maxtor on the PIIX4 and HPT366 (Abit BP6 +
2.2.19p17 + ide.2.2.18.1221.patch) chipsets.

Since pin 30 is plugged on my ATA66 cable, I used an Asus P3B-F as a
ATA66+PIIX4 sanity check.  Neither the Abit or Asus PIIX4 controller
would go higher than UDMA2.  Although hdparm -i reported UDMA4, neither
the -tT or dd tests demonstrated faster results.  The kernel logged
'ide0: Speed warnings UDMA 3/4/5 is not functional' when attempting a
setting higher than UDMA2 on the PIIX4.

Apparently IDE drive technology has improved over the last year,
however real world PIIX4 speeds are still in the 14-19MB/s range.

UDMA2/PIIX4	16-21MB/s
UDMA4/HPT366	19-28MB/s

rgds,
tim.

[tim@asus tim]# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev20)
00:0f.0 VGA compatible unclassified device: 3DLabs Permedia II 2D+3D (rev
01)
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)

PIIX4 -----------------------------
[tim@asus tim]# hdparm -iv /dev/hdb

/dev/hdb:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40021632, start = 0

 Model=Maxtor 32049H2, FwRev=YAH814Y0, SerialNo=L21R7EKC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40021632
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 

[tim@asus tim]# hdparm -tT /dev/hdb

/dev/hdb:
 Timing buffer-cache reads:   128 MB in  1.47 seconds = 87.07 MB/sec
 Timing buffered disk reads:  64 MB in  3.02 seconds = 21.19 MB/sec

[tim@asus tim]# time dd if=/dev/hdb of=/dev/null bs=1k count=512k
524288+0 records in
524288+0 records out
0.540u 10.520s 0:32.85 33.6%    0+0k 0+0io 115pf+0w
[tim@asus tim]# echo "514288/32.85" | bc -q
15655

HPT366 ----------------------------
[tim@asus tim]# hdparm -iv /dev/hdf

/dev/hdf:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40021632, start = 0

 Model=Maxtor 32049H2, FwRev=YAH814Y0, SerialNo=L21R7EKC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=40021632
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 

[tim@asus tim]# hdparm -tT /dev/hdf

/dev/hdf:
 Timing buffer-cache reads:   128 MB in  1.50 seconds = 85.33 MB/sec
 Timing buffered disk reads:  64 MB in  2.28 seconds = 28.07 MB/sec

[tim@asus tim]# time dd if=/dev/hdf of=/dev/null bs=1k count=512k
524288+0 records in
524288+0 records out
0.530u 11.140s 0:27.45 42.5%    0+0k 0+0io 115pf+0w
[tim@asus tim]# echo "524288/27.45" | bc -q
19099


--
