Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTJFSXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTJFSXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:23:53 -0400
Received: from boxer.fnal.gov ([131.225.80.86]:50352 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id S263228AbTJFSXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:23:48 -0400
Date: Mon, 6 Oct 2003 13:23:47 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: linux-kernel@vger.kernel.org
Subject: AMD7441 vs Seagate Barracuda--dma_intr: error=0x40 { UncorrectableError
 }
Message-ID: <Pine.LNX.4.58.0310061322070.22937@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have the following situation:
Tyan 2466 motherboard (which has AMD7441 ide controller, AMD760MPX
chipset, dual Athlon MP2000+ processors).
We are running kernel 2.4.20-18.7smp as released by RedHat as
an errata kernel.  The later errata releases (2.4.20-19, 2.4.20-20)
have the same problem.  This is on top of Linux version 7.3.

The systems have two disk drives, 40GB and 80 GB.  Originally
both were Seagate ST340016A and ST380021A, both part of the
Barracuda ATA IV family of drives.  Both drives are attached
to the primary IDE bus, one as master and one as slave.
On all variants of kernel we have tried to date (2.4.9, 2.4.18, 2.4.20) we got
the following error in bunches:

kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=21791009, sector=21790896
kernel: end_request: I/O error, dev 03:41 (hdb), sector 21790896

At the time, the system was usually doing a copy of a large file
across the network and was probably swapping as well.  When we shifted
the arrangement of our disk so that the high sector numbers were
used most frequently instead of the low sector numbers, the frequency
of errors went up.  We google-searched
intensively but found no other explanation that the drives were
actually going bad.  Seagate hardware diagnostics usually did
indicate some problem with the drive.  Sometimes low-level formatting
enabled the disk to go on for a couple of months, sometimes it
failed again almost immediately.  Drive self-tests showed that
many of these drives were failing the electrical self-test or the
read self-test.

The frequency of this error increased with time on the 80 GB
drives so that we eventually replaced all of the 240 80 GB Seagate ST380021A
with IBM/Hitachi drives, model IC35L090AVV207-0.  At that time 180
of the 240 drives had some kind of error already. This led to
a significant reduction in this error, although it did not stop
entirely--we have seen it on two IBM/Hitachi drives to date.

The system drives, the Seagate ST340016A 40 GB disks, seem to be
having the same trouble, just at a slower rate...about 70 of 240
have been affected thus far.  I know similar problems have been observed
with Seagate drives and Serverworks chipsets, but I haven't been
able to find any record of the same problems happening with the AMD
chipset.  The fact that it is occurring in a high-stress situation
where disk I/O, swapping, and network activity are going simultaneously
leads me to believe there may be an issue here in the interaction
of the Linux drivers and the chipset.  Is anyone aware of such
an issue?  Before I go swapping out the rest of the system drives, it
would be good to know if there are any kernel issues.

Once we started getting a large number of systems with one or
two IBM/Hitachi drives in them, we started seeing a different error.
This has happened only on about 16 nodes thus far, many of them several
times.  It has the advantage that it doesn't make any damage to
the file system and can be easily recovered from, either by
resetting the ultraDMA on the drives or via reboot.  But it
is an annoyance. Does anyone know what might be causing
an error of this type, or has anyone seen it before?  Would
dialing down the ultraDMA help?

I'm aware that the dma_timer_expiry code was added at the 2.4.20 kernel
stage.  We did have instances of dma_disabled before this in
similar systems.  If anyone can help us figure out what is going
wrong with this hardware it would be very much appreciated.

Thanks.

Steve Timm


The new error has the following form:
Oct  2 20:53:12 fnd0311 kernel: hda: dma_timer_expiry: dma status == 0x60
Oct  2 20:53:12 fnd0311 kernel: hda: timeout waiting for DMA
Oct  2 20:53:12 fnd0311 kernel: hda: timeout waiting for DMA
Oct  2 20:53:12 fnd0311 kernel: hda: (__ide_dma_test_irq) called while not waiti
ng
Oct  2 20:53:12 fnd0311 kernel: hda: status timeout: status=0xd0 { Busy }
Oct  2 20:53:12 fnd0311 kernel:
Oct  2 20:53:12 fnd0311 kernel: hdb: DMA disabled
Oct  2 20:53:12 fnd0311 kernel: hda: drive not ready for command
Oct  2 20:53:12 fnd0311 kernel: ide0: reset: success
Oct  2 20:53:12 fnd0311 kernel: blk: queue c03d8ee0, I/O limit 4095Mb (mask 0xff
ffffff)
Oct  2 20:53:36 fnd0311 kernel: hda: dma_timer_expiry: dma status == 0x21
Oct  2 20:53:46 fnd0311 kernel: hda: error waiting for DMA
Oct  2 20:53:46 fnd0311 kernel: hda: dma timeout retry: status=0xd0 { Busy }
Oct  2 20:53:46 fnd0311 kernel:
Oct  2 20:53:46 fnd0311 kernel: hda: DMA disabled

Oct  2 20:53:46 fnd0311 kernel: ide0: reset: success
Oct  2 20:54:06 fnd0311 kernel: hda: dma_timer_expiry: dma status == 0x21
Oct  2 20:54:16 fnd0311 kernel: hda: error waiting for DMA
Oct  2 20:54:16 fnd0311 kernel: hda: dma timeout retry: status=0x58 { DriveReady
 SeekComplete DataRequest }
Oct  2 20:54:16 fnd0311 kernel:
Oct  2 20:54:21 fnd0311 kernel: hda: status timeout: status=0xd0 { Busy }
Oct  2 20:54:21 fnd0311 kernel:
Oct  2 20:54:21 fnd0311 kernel: hda: drive not ready for command
Oct  2 20:54:59 fnd0311 kernel: ide0: reset: success
Oct  2 20:55:01 fnd0311 kernel: hda: dma_timer_expiry: dma status == 0x21
Oct  2 20:55:02 fnd0311 kernel: hda: error waiting for DMA
Oct  2 20:55:02 fnd0311 kernel: hda: dma timeout retry: status=0x58 { DriveReady
 SeekComplete DataRequest }
Oct  2 20:55:02 fnd0311 kernel:
Oct  2 20:55:02 fnd0311 kernel: hda: status timeout: status=0xd0 { Busy }
Oct  2 20:55:02 fnd0311 kernel:
Oct  2 20:55:02 fnd0311 kernel: hda: drive not ready for command
