Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268824AbTBZQuI>; Wed, 26 Feb 2003 11:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268822AbTBZQuI>; Wed, 26 Feb 2003 11:50:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268824AbTBZQuG>; Wed, 26 Feb 2003 11:50:06 -0500
Date: Wed, 26 Feb 2003 12:02:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jpiszcz <jpiszcz@lucidpixels.com>
cc: vishwas@india.hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about DMA and cd burning.
In-Reply-To: <3E5CE3B2.6010003@lucidpixels.com>
Message-ID: <Pine.LNX.3.95.1030226115335.4300A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, jpiszcz wrote:

> Yes, hdparm -d1 /dev/hd{b,c} did not work on older kernels for me, but 
> 2.4.20 appears to work successfully.
> 
> However, second question, both of my Plextors support UDMA2, and both 
> are on 80 PIN/IDE cables, when I enabled -d1 -X66, the kernel, it 
> crashed the kernel.
> 
[SNIPPED...]


This has turned out to be a FAQ.  DMA is not "better"
than some other transfer mode.  It's just a method.
What DMA does, is allow the CPU to do something else
while data are being transferred. With a multi-tasking
operating system, there are sometimes other things that
the CPU can be doing while a transfer is occurring.
This means that if a disk transfer is occurring using
DMA, this seems like a background operation to the user.

There are two basic kinds of DMA that occur in ix86
machines. One is called buss-mastering. This is the
kind of DMA that PCI/Bus devices that are memory-mapped
use. The other is I/O and it may use the cascaded
DMA controllers.

There is another kind of DMA in which an IDE drive tries
to perform a data transfer from I/O to memory by bypassing
the legacy DMA controllers and mucking with the I/O bits
themselves. This is variously called UDMA, "Ultra DMA",
like it's some special high-performance technique.
Using your favorite search-engine, search for UDMA
on the net sometime and see what a mess it is.

In other words, it pretends that its operations are buffered
by a PCI/Bus when, in fact, it doesn't use the PCI/Bus.
This kind of DMA sometimes works. It depends upon the cable
going to your drive being low capacity and just the right
length. The problem is that the "right" length isn't a constant.
It depends upon the speed of RAM, the CPU/cache access
pipe-line delay and numerous other things, probably even
the temperature of the room and the phase of the moon.

For DMA to work, the device performing the transfer must
do the transfer when it's the sole owner of the bus. To
do this with a PCI/Bus is easy because there is a bus
protocol that the hardware performs in a precisely-timed
manner. Once the vendors get it right, anything plugged
into that bus will work. On the other hand, IDE disk
drives, (IDE means Integrated Drive Electronics) are
connected to the motherboard with a simple transceiver.
The "smarts" necessary to acquire the bus, perform a
transfer, and release the bus, are inside the disk drive!

Some disk-drives work using DMA and some don't. So, you
try to use DMA and if your file system doesn't get corrupted,
you gain a bit of responsiveness. If your disk drive won't do
DMA, it's the disk drive, not something else! Just don't
enable DMA. It's that simple.

With IDE drives, the most reliable transfer mode is PIO. It
comes in several flavors, PIO (bytes) PIOW (words) PIOL
(longwords). With these modes, the CPU makes the transfer so
that the CPU is busy during the whole transfer time. The
transfer, using PIOL, is quite fast, a long-word every 150
nanoseconds or so. Since the CPU is never locked off the bus,
the entire transfer can complete, i.e., perhaps a whole
megabyte in one read operation. With DMA and bus-mastering,
the transfer is broken up into small groups so that the
CPU isn't locked off the bus for too long a time.

The result is that PIOL may be actually faster than DMA when
some task is I/O bound. Of course other tasks may be CPU starved
during a long transfer, but you get what you pay for.

If you want the best of all worlds, you need to get a good
SCSI Controller and some SCSI disks. Some SCSI disks have the
exact same drive components behind the SCSI interface. Don't
let this fool you. It's the buffering and isolation afforded
by the whole SCSI system that makes it perform better than
bare IDE drives. There is a CPU (or ASIC) on the SCSI board
that functions as a "secretary" or "housekeeper" to make
damn sure a transfer occurs correctly. Many retries are
transparent and it's only when there is a permanent error
that the host software even knows about it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


