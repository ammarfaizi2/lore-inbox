Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbRAMSdT>; Sat, 13 Jan 2001 13:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131059AbRAMScf>; Sat, 13 Jan 2001 13:32:35 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130540AbRAMSYy>;
	Sat, 13 Jan 2001 13:24:54 -0500
Date: Sat, 13 Jan 2001 17:20:44 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount
In-Reply-To: <20010113153522.A1495@suse.cz>
Message-ID: <Pine.LNX.4.30.0101131700230.1112-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Vojtech Pavlik wrote:

> On Sat, Jan 13, 2001 at 09:12:27AM +0100, Tobias Ringstrom wrote:
> > > 2) What's in /proc/ide/via?
> >
> > It's not there since I disabled the VIA driver.
>
> Ok. Could you send me this file when you boot with fs r-o?

Ok, but this is with the wrong disc.  Withe the bad disc, drive0 looks
exacly like drive2, i.e. normal UDMA(33).  Sorry about that.

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     2.1e
South Bridge:                       VIA vt82c686a rev 0x1b
Command register:                   0x7
Latency timer:                      32
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
FIFO Output Data 1/2 Clock Advance: off
BM IDE Status Register Read Retry:  on
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:           on                  on
End Sect. FIFO flush:          on                  on
Prefetch Buffer:               on                  on
Post Write Buffer:             on                  on
FIFO size:                      8                   8
Threshold Prim.:              1/2                 1/2
Bytes Per Sector:             512                 512
Both channels togth:          yes                 yes
-------------------drive0----drive1----drive2----drive3-----
BMDMA enabled:        yes       yes       yes       yes
Transfer Mode:       UDMA   DMA/PIO      UDMA   DMA/PIO
Address Setup:       30ns     120ns      30ns     120ns
Active Pulse:        90ns     330ns      90ns     330ns
Recovery Time:       30ns     270ns      30ns     270ns
Cycle Time:          30ns     600ns      60ns     600ns
Transfer Rate:   66.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s

> > > 4) If you mount your filesystem read-only, does it read garbage?
> >
> > Now here's a strange part, or possibly a crusial clue.  When I booted a
> > 2.4.0 kernel (from floppy using the excellent syslinux) with "ro
> > init=/bin/sh", I could access the filesystem just fine.  I could even
> > remount the root filesystem rw, and there were no problems.  But I did not
> > write anything to the disk, since I was convinced that the problem was
> > gone (this was the second try).  After this I rebooted with
> > ctrl-alt-delete, forgetting how bad an idea that is with init=/bin/sh,
> > booted up the RH7 2.2.16 kernel, and fsck was run with no errors.
>
> So far no problem. Rebooting with c-a-d with fs r-o is OK.
>
> > Now I
> > though all was well, rebooted from floppy again, but without the init=
> > part, and poof, it hang.
>
> Where? It could be a different reason than IDE setup ...

Don't think so.  It happens on the "Remounting root read-write".

> > More interesting may be that I had to turn the computer off and on again
> > to get BIOS to find the hard drive. Repeated long reset button presses
> > did not help.  It is possible that it hung during BIOS hd detection - I
> > wish I could remember.
>
> I fear this isn't much of a clue, sorry.

The clue is that the VIA driver messed up either the chipset or the drive
quite a lot, but maybe that is already obvious.

> > I suspect that I could have hung the drive with init=/bin/sh if I would
> > have done some reading and writing to the device, besides ls.
>
> Please try it. Best mke2fs your swap partition and try reading & writing
> to that. You can mkswap it back after you finish.

After more testing, I think I have isolated the problem to this disk, or
at least this disk with this controller.  With another (UDMA66) disk,
there are no problems.  Details at the end.

> > I think I can spend some more time today trying it out some more.
>
> Please do. 'lspci -vvxxx' data for the case without a driver, with 2.4.0
> driver and with 3.11 driver would help me find the problem.

Ok, I'll do that later.

> Make sure you *don't* have any hdparm -d1 or hdparm -X66 or similar
> stuff in your init scripts.

I'm sure I don't.  This happens with a clean fresh RH7 installation.

> > I will
> > also try your 3.11 driver, which seems to be an enormous cleanup.
>
> the 2.1e driver is an enormous cleanup of the original driver from the
> 2.2 kernels. the 3.11 is an enormous cleanup of 2.1e, yes.

I have not had a chance to try the 3.11 driver yet.

Now for the new details.  When writing to the disk with DMA enabled, I get
the following errors, in two different machines.  Both are VIA IDE
machines.  I is NOT a cable error.  I have tries with several cables.
Possibly a connector or soldering problem.  I'll try the disk in more
machines an get back with more info.  I have to run now.

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
