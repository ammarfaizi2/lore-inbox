Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUHNRwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUHNRwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHNRwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 13:52:51 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:11670 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S264298AbUHNRwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 13:52:45 -0400
Subject: PROBLEM: c2 error detection on CD-R broken with kernel 2.6.8
	(since rc4)
From: GhePeU <ghepeu@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1092505965.7913.17.camel@KazeNoTani>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 19:52:46 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

c2 error detection performed by readcd (cdrtools 2.01alpha28) seems to
be broken with vanilla kernel >= 2.6.8rc4 (didn't check with rc1, 2 and
3). This happens with both CDRW and CDROM on ATA (not the old scsi
emulation) on a VIA KT266A chipset with DMA enabled. CD-R/RW burning
seems to work flawlessy and I didn't get any error from a surface scan
on a different OS.
kernel config is the same I used to have, I just did a make oldconfig
and answered N to all new options.


this is the output I get with kernel 2.6.7:

$ readcd dev=/dev/hdd -c2scan
Read  speed:  7056 kB/s (CD  40x, DVD  5x).
Write speed:     0 kB/s (CD   0x, DVD  0x).
Capacity: 356199 Blocks = 712398 kBytes = 695 MBytes = 729 prMB
Sectorsize: 2048 Bytes
Copy from SCSI (1,1,0) disk to file '/dev/null'
end:    356199
addr:   356199 cnt: 39
Time total: 171.991sec
Read 920412.65 kB at 5351.5 kB/sec.
Total of 0 hard read errors.
C2 errors total: 0 bytes in 0 sectors on disk
C2 errors rate: 0.000000%
C2 errors on worst sector: 0, sectors with 100+ C2 errors: 0



and this is what I get with newer kernel (same cd, obviously):

$ readcd dev=/dev/hdd -c2scan
readcd: Success. read dvd structure: scsi sendcmd: no error
CDB:  AD 00 00 00 00 00 00 00 00 20 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 30 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x30 Qual 0x02 (cannot read medium - incompatible format)
Fru 0x0
Sense flags: Blk 0 (not valid)
resid: 32
cmd finished after 0.000s timeout 240s
readcd: Operation not permitted. set cd speed: scsi sendcmd: no error
CDB:  BB 00 FF FF FF FF 00 00 00 00 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 40s
Read  speed:  7056 kB/s (CD  40x, DVD  5x).
Write speed:     0 kB/s (CD   0x, DVD  0x).
Capacity: 356199 Blocks = 712398 kBytes = 695 MBytes = 729 prMB
Sectorsize: 2048 Bytes
readcd: Operation not permitted. mode select g1: scsi sendcmd: no error
CDB:  55 10 00 00 00 00 00 00 14 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 40s
Copy from SCSI (1,1,0) disk to file '/dev/null'
end:    356199
C2 in sector:   8 first at byte:    3 (0x14) total:  617 errors
C2 in sector:  11 first at byte:    7 (0x01) total: 1129 errors
C2 in sector:  12 first at byte:    2 (0x26) total: 1064 errors

[...]

C2 in sector: 356027 first at byte:   33 (0x66) total:  577 errors
C2 in sector: 356028 first at byte:   32 (0xAE) total:  559 errors
C2 in sector: 356029 first at byte:   33 (0x7A) total:  556 errors
C2 in sector: 356030 first at byte:   35 (0x18) total:  567 errors
C2 in sector: 356031 first at byte:   34 (0x22) total:  607 errors
addr:   356199 cnt: 18
Time total: 646.623sec
Read 920412.65 kB at 1423.4 kB/sec.
readcd: Operation not permitted. mode select g1: scsi sendcmd: no error
CDB:  55 10 00 00 00 00 00 00 14 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 40s
Total of 0 hard read errors.
C2 errors total: 262256530 bytes in 225476 sectors on disk
C2 errors rate: 31.303833%
C2 errors on worst sector: 1960, sectors with 100+ C2 errors: 225440
readcd: Operation not permitted. mode select g1: scsi sendcmd: no error
CDB:  55 10 00 00 00 00 00 00 14 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 40s


kernel messages:

VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[...]
hdc: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
[...]
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)


cdrecord output:

$ cdrecord dev=ATAPI -scanbus
Cdrecord-Clone 2.01a28 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg
Schilling
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.8'.
scsibus0:
        0,0,0     0) 'LITE-ON ' 'LTR-52327S      ' 'QS0C' Removable
CD-ROM
        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-M1612' '1806' Removable
CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *




