Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBZVYZ>; Mon, 26 Feb 2001 16:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBZVYQ>; Mon, 26 Feb 2001 16:24:16 -0500
Received: from mail18.bigmailbox.com ([209.132.220.49]:6156 "EHLO
	mail18.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S129116AbRBZVYI>; Mon, 26 Feb 2001 16:24:08 -0500
Date: Mon, 26 Feb 2001 13:23:57 -0800
Message-Id: <200102262123.NAA14599@mail18.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.7.28.120]
From: "Quim K Holland" <qkholland@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: CD-RW ide-scsi lost interrupts on 2.4.2 w/ VIA vt82c686b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Plextor CD-RW connected as slave at ide1 and have
append="hdd=ide-scsi" in lilo.conf.  Motherboard is AOpen
AK73-PRO which has VIA vt82c686b onboard.

On recent kernels, cdrecord (1.9) started to barf when trying to
write (both with and without --dummy).  The system reports irq
timeouts for /dev/hdd.  Reading data from /dev/scd0 (11,0) works
as expected.  I would appreciate it if somebody can fix this.

The kernel is compiled with the following enabled.

    CONFIG_BLK_DEV_IDESCSI=y
    CONFIG_IDEDMA_PCI_AUTO=y
    CONFIG_BLK_DEV_IDEDMA=y
    CONFIG_BLK_DEV_VIA82CXXX=y
    CONFIG_IDEDMA_AUTO=y
    CONFIG_SCSI=y
    CONFIG_BLK_DEV_SR=y
    CONFIG_BLK_DEV_SR_VENDOR=y
    CONFIG_SR_EXTRA_DEVS=1
    CONFIG_CHR_DEV_SG=y

Here are the lines from syslog when this problem occured.

    Feb 24 13:20:31 linux kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x00 00 00 00 00 00 
    Feb 24 13:20:31 linux kernel: hdd: lost interrupt
    Feb 24 13:20:52 linux kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x01 00 00 00 00 00 
    Feb 24 13:20:52 linux kernel: hdd: irq timeout: status=0xd0 { Busy }
    Feb 24 13:20:52 linux kernel: hdd: ATAPI reset complete
    Feb 24 13:20:52 linux kernel: hdd: irq timeout: status=0x80 { Busy }
    Feb 24 13:20:52 linux kernel: hdd: ATAPI reset complete
    Feb 24 13:20:53 linux kernel: hdd: irq timeout: status=0x80 { Busy }
    Feb 24 13:20:53 linux kernel: hdc: status timeout: status=0x80 { Busy }
    Feb 24 13:20:53 linux kernel: hdc: drive not ready for command
    Feb 24 13:20:53 linux kernel: ide1: reset: success
    Feb 24 13:21:13 linux kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x00 00 00 00 00 00 
    Feb 24 13:21:13 linux kernel: hdd: lost interrupt

Here is what hdparm -i /dev/hdd reports:

    /dev/hdd:

     Model=PLEXTOR CD-R PX-W8432T, FwRev=1.05, SerialNo=
     Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
     RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
     BuffType=unknown, BuffSize=0kB, MaxMultSect=0
     (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
     IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
     PIO modes: pio0 pio1 pio2 pio3 pio4 
     DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 

And the following is from /proc/ide/via (before lost-interrupts
disables DMA for /dev/hdd).  For /dev/hda and /dev/hdc (they are
hard disks), hdparm -d0 is run at the system startup time to
disable UDMA (I have 80-wire UDMA-100 cable on these channels,
but previously lost a lot of data without CRC errors, so am
being paranoid to do this for now).

    ----------VIA BusMastering IDE Configuration----------------
    Driver Version:                     3.20
    South Bridge:                       VIA vt82c686b
    Revision:                           ISA 0x40 IDE 0x6
    BM-DMA base:                        0xc000
    PCI clock:                          33MHz
    Master Read  Cycle IRDY:            0ws
    Master Write Cycle IRDY:            0ws
    BM IDE Status Register Read Retry:  yes
    Max DRDY Pulse Width:               No limit
    -----------------------Primary IDE-------Secondary IDE------
    Read DMA FIFO flush:          yes                 yes
    End Sector FIFO flush:         no                  no
    Prefetch Buffer:              yes                 yes
    Post Write Buffer:            yes                  no
    Enabled:                      yes                 yes
    Simplex only:                  no                  no
    Cable Type:                   80w                 80w
    -------------------drive0----drive1----drive2----drive3-----
    Transfer Mode:        PIO       PIO       PIO      UDMA
    Address Setup:       30ns     120ns      30ns      30ns
    Cmd Active:          90ns      90ns      90ns      90ns
    Cmd Recovery:        30ns      30ns      30ns      30ns
    Data Active:         90ns     330ns      90ns      90ns
    Data Recovery:       30ns     270ns      30ns      30ns
    Cycle Time:          60ns      50ns      60ns      90ns
    Transfer Rate:   33.3MB/s  40.0MB/s  33.3MB/s  22.2MB/s


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


