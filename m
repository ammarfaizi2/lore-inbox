Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132198AbQKKTra>; Sat, 11 Nov 2000 14:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbQKKTrU>; Sat, 11 Nov 2000 14:47:20 -0500
Received: from dial-206-102-3-214.easystreet.com ([206.102.3.214]:35076 "EHLO
	enzo.localdomain") by vger.kernel.org with ESMTP id <S132198AbQKKTrP>;
	Sat, 11 Nov 2000 14:47:15 -0500
Date: Sat, 11 Nov 2000 11:47:10 -0800
From: BJerrick@easystreet.com
Message-Id: <200011111947.eABJlAG02240@enzo.localdomain>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA/lost interrupt problem with RAID0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Can anyone shed some light on this?

I get "lost interrupt" or "timeout waiting for DMA" (and a subsequent
reset) when reading software RAID0 (striped) partitions using IDE drives,
iff I enable any of the following:

    % hdparm -c1  /dev/hda /dev/hdc	(enable 32-bit I/O)
    % hdparm -m16 /dev/hda /dev/hdc	(enable multiple sector I/O)
    % hdparm -d1  /dev/hda /dev/hdc	(enable DMA)

(If it's not evident, the lost interrupts happen when using PIO, the
"timeout waiting ..." with DMA.)

The RAID0 partitions use two identical hd partitions each, on hda and hdc,
with 8k chunks.

Doing "hdparm -t /dev/md0" (or md{1,2,3}) will invoke a reset, but
"hdparm -t /dev/hda" (or /dev/hdc) does not.

If I don't enable DMA, and don't use hdparm -c1 or -m16, I don't get
the resets.

A typical reset sequence (in /var/log/messages) is this for the DMA case:

    hda: timeout waiting for DMA
    hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
    hda: status timeout: status=0xd0 { Busy }
    hda: DMA disabled
    hda: drive not ready for command
    ide0: reset: success

and this for PIO:

    hda: lost interrupt
    hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    hda: drive not ready for command
    hda: status timeout: status=0xd0 { Busy }
    hda: drive not ready for command
    ide0: unexpected interrupt, status=0x80, count=6
    ide0: reset: success

This behavior started with kernel 2.2.16; it didn't happen under 2.2.14 .

Some hardware/software particulars:

    Disks (hda, hdc): Maxtor 52049U4 (20 GB, 7200 rpm, UDMA66)
    Motherboard/chipset: Tyan S1682D (Intel 440FX)
    IDE interface: Intel 82371SB PIIX3 (onboard)
    CPUs: dual Pentium II 266 MHz.
    Kernel: Built from Red Hat 7.0 kernel-source-2.2.16-22; SMP configured;
	built-in IDE and RAID (i.e., not modular)

I don't seem to have this problem on another machine:

    Disks (hda, hdc): Maxtor 91366U4 (13.6 GB, 7200 rpm, UDMA66)
    Motherboard/chipset: Supermicro PIIISCA (Intel 820)
    IDE interface: Intel 82801AA (onboard)
    CPU: single Pentium III 666 MHz.
    Kernel: same binaries

I get about 24% performance improvement (reading) from striping,
1.8x improvement with -c1 -m16, and 2.6x improvement with DMA (5.6x on
the second machine!), so if anything has to be sacrificed, it will be
striping.  But does anyone have some insights on why RAID doesn't work
with DMA or the hdparm tweaks?

Please Cc any replies to me, since I'm not a list subscriber.

Thanks --

Bruce Jerrick
Portland, Oregon, USA
email:   bjerrick@easystreet.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
