Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284111AbRLFPCC>; Thu, 6 Dec 2001 10:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284117AbRLFPBw>; Thu, 6 Dec 2001 10:01:52 -0500
Received: from alquanto.nextra.it ([193.43.2.90]:51133 "EHLO
	alquanto.nextra.it") by vger.kernel.org with ESMTP
	id <S284111AbRLFPBn>; Thu, 6 Dec 2001 10:01:43 -0500
Date: Thu, 6 Dec 2001 16:01:33 +0100
From: Fabio Parodi <fabio.parodi@fredreggiane.com>
To: linux-kernel@vger.kernel.org
Subject: WAIT_DRQ and ATA flash
Message-ID: <20011206160133.A31127@freemail.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.4.14 on a i686
X-Organization: Debian Linux Users
X-Disclaimer: Linux - The choice of a GNU generation!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

We use a Samsung ATA flash as /dev/hda. Filesystem is ext3 but the same
occurs with minix. It worked fine up to kernel 2.4.10. But from kernel
2.4.11 (2.4.12) onward a troublesome problem crept in.

We fixed it by modifying the timeout value of WAIT_DRQ. 

IDE specs allow up to 20ms, standard Linux kernel allows up to
50ms, but Samsung ATA CF needs 100ms. 

What should we do? We have four options:

A - keep this patch for us. Stop bothering.
B - #define WAIT_DRQ (10*HZ/100) in standard kernel tree
C - put a parameter to be adjusted at boot time 
D - write some code that autoadjusts WAIT_DRQ depending on device type

We think that option B should not harm other users - after all, 
this timeout only occurs in case of errors. 

If you are interested in details, this is an excerpt from dmesg:

Linux version 2.4.16 (root@devel-linux) (gcc version 2.95.2 19991024
(release)) 
...
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
CS5530: IDE controller on PCI bus 00 dev 92
CS5530: chipset revision 0
CS5530: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG ATA CF, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
hda: 123392 sectors (63 MB) w/1KiB Cache, CHS=964/4/32
Partition check:
 hda: hda1        
...


After one minute from the boot, the ide driver
prints these messages:

hda: status timeout: status=0xd0 { Busy }
hda: no DRQ after issuing WRITE
ide0: reset: master: error (0x00?)
hda: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: status error: error=0x00 { }
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
ide0: reset: master: error (0x00?)
end_request: I/O error, dev 03:01 (hda), sector 2
end_request: I/O error, dev 03:01 (hda), sector 16
end_request: I/O error, dev 03:01 (hda), sector 18
end_request: I/O error, dev 03:01 (hda), sector 20
end_request: I/O error, dev 03:01 (hda), sector 22
end_request: I/O error, dev 03:01 (hda), sector 24
end_request: I/O error, dev 03:01 (hda), sector 26
end_request: I/O error, dev 03:01 (hda), sector 28
end_request: I/O error, dev 03:01 (hda), sector 30       

The system becomes unstable.

Fabio Parodi
