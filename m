Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUEGF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUEGF4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUEGF4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 01:56:19 -0400
Received: from hoemail1.lucent.com ([192.11.226.161]:48296 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263204AbUEGF4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 01:56:12 -0400
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Can't mount a CDRW under ide-cd
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 May 2004 00:56:06 -0500
From: "Timothy E. Jedlicka - wrk" <bonzo@lucent.com>
Message-Id: <20040507055607.52C2187F93@bonzo.localdomain.fake>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens or any other expert,

Thank you for supporting/maintaining the CD modules.
I'm sorry if this is the wrong place for debugging help. I've tried several 
other lists and everyone just keeps telling me to use ide-scsi. 

Basic problem, I can't mount CDs on my cdRW. They mount just fine on my cdROM 
(but not my CDRW). I get:

       mount: No medium found

I'm running 2.6.5, Debian, PDC20276: IDE controller.

When I try to burn CDs (using cdrecord with -dev /dev/hdf) it appears to burn - 
the laser comes on - i.e. I can communicate with the CD.

I hacked ide-cd.c and stuck a few printk's in to prove that when I try to 
mount the CDRW I am hitting ide-cd (cdrom_prepare_request and ide_startstop_t)

Any hints of how to debug this further? Is it possibly an incompatibility with 
my model of CDRW? strace didn't get me anywhere. Adding my breakpoints helped 
at least prove that I'm hitting ide-cd, but I don't know what function 
interacts with mount and finding a medium.

I am a tester by profession - not a coder. I can test (and break) 
anything you throw at me, but I get lost when it comes to coding. Thanks for 
your help. Some more info on my config is attached.

-----
Timothy Jedlicka, bonzo@lucent.com, 1-630-713-4436, AOL-IM=bonzowork
Network Entomologist, Lucent Technologies, Testers For Hire

PDC20276: IDE controller at PCI slot 0000:00:06.0
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA

Tried with and without DMA

cdRW (doesn't work)                             cdROM (works)

# hdparm /dev/hdd                               # hdparm /dev/hdc

/dev/hdd:                                       /dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument     (same)
 IO_support   =  1 (32-bit)                      (same)
 unmaskirq    =  1 (on)                          (same)
 using_dma    =  1 (on)                          (same)
 keepsettings =  0 (off)                         (same)
 readonly     =  1 (on)                          (same)
 readahead    = 256 (on)                         (same)
 HDIO_GETGEO failed: Invalid argument            (same)


bonzopad:~# cat /dev/hdd | od | more
cat: /dev/hdd: No medium found
0000000
kern.log - bonzopad kernel: cdrom: open failed.

bonzopad:~# date;mount -t iso9660 /dev/hdd /cdrw
Fri May  7 00:38:11 CDT 2004
mount: block device /dev/hdd is write-protected, mounting read-only
mount: No medium found  <<< this comes out 45 seconds later along with kern.log
kern.log - 00:38:56 bonzopad kernel: cdrom: open failed.

bonzopad:~# hdparm -i /dev/hdd   (my cdRW - doesn't work)

/dev/hdd:

 Model=CENDYNE_481648AX, FwRev=V150F, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: device does not report version:  4

 * signifies the current active mode

bonzopad:~# hdparm -i /dev/hdc   (my cdROM - it does work)

/dev/hdc:

 Model=ATAPI 48X CDROM, FwRev=VER-3.40, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

 * signifies the current active mode








