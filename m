Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282721AbRK0Bm1>; Mon, 26 Nov 2001 20:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282720AbRK0BmT>; Mon, 26 Nov 2001 20:42:19 -0500
Received: from smtp.integrinautics.com ([204.247.117.11]:55798 "EHLO
	smtp.integrinautics.com") by vger.kernel.org with ESMTP
	id <S282721AbRK0BmH>; Mon, 26 Nov 2001 20:42:07 -0500
Message-ID: <3C02EE9F.F987ECA6@integrinautics.com>
Date: Mon, 26 Nov 2001 17:38:39 -0800
From: Dave Lawrence <dgl@integrinautics.com>
Organization: IntegriNautics Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compact flash IDE problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using the 2.2.17 kernel with compact flash and have had
intermittent
problems, which I'll describe later.  I thought that newer kernels might
deal
with Compact Flash better, so I
tried upgrading to 2.4.13.  My new problem is that I can't access the
second CF disk (/dev/hdb) using the 2.4 kernels.  I tried sending
a "hda=flash hdb=flash" switch to loadlin, but it doesn't seem to help.
The BIOS
recognizes that the second disk is there, but I can't access it.  Linux
also recognizes
that I sent the hdb=flash switch.  Here is the relavent output of dmesg:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

Kernel command line: hdb=flash hdB=flash root=/dev/ram rw
BOOT_IMAGE=bzimage
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try
using pci=biosirq.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: LEXAR ATA FLASH, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that it does not detect hdb despite the fact that hdb is there.
The BIOS sees it, DOS sees it before loadlin runs, and 2.2.17 sees it.
Why can't I access if from 2.4.x?


My hardware:

A Jumptec MOPSLCD6 Pentium 166 single board computer with an ALI
M1543C/M1531 chipset.  On ide0, there are two Compact Flash cards, one
configured as master and one as slave (they are both plugged onto a PCB
that accepts two CF devices and has a master/slave jumper).  For
historical reasons, I boot to DOS and then use loadlin to load the
kernel.

My original problem:
Using 2.2.17, I would always see the following message:
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
This error did not seem to cause any problems, but it could be related
to the more serious problem I mention next.

On rare occasions, I would see messages like this:
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error
}
hda: read_intr: error=0x40 { UnrecoverableError }, LBAsect=54196,
sector=33556
end_request: I/O error, dev03:05(hda), sector 33556
EXT2-ft error (device ide0(3,5)): ext2_readdir: directory #3528
containts a hole at offset 0

This error did cause problems... one directory in the file system of a
read-only partition was corrupted.  Rebuilding filesystem fixed the
problem, so there was apparently no permanent damage to the flash disk.
This problem has happened on multiple systems, so it's not related to a
failure of a specific computer, disk, cable, or compact flash interface
PCB.  We have ~50 systems in the field and the problem has occurred ~10
times in ~5 months.  Once a disk is corrupt, it behaves the same way on
all of our computers... once the file system is rebuilt, it seems to
work fine again.  As I mentioned, the partition that is corrupt is
always mounted read-only.  Of the ~10 failures, it usually happened when

two CF disks were present, but it happened at least once when only hda
was present.  We never insert or remove disks with the power on.

What could cause the read-only partition corruption I'm seeing in
2.2.17?
I don't know if the corruption problem happens in 2.4.x because I
haven't
used if for long enough.

Thanks in advance for any suggestions.

                                   Dave

|      David Lawrence                         (650)833-7847 (W)       |
|      IntegriNautics Corporation             (650)833-5601 (Fax)     |
|      1505 Adams Drive                                               |
|      Menlo Park, CA 94025                   (650)960-6864 (H)       |
|      mailto:dgl@IntegriNautics.com                                  |

