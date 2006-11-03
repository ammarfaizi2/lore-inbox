Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753321AbWKCQAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbWKCQAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbWKCQAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:00:20 -0500
Received: from brick.kernel.dk ([62.242.22.158]:28513 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753321AbWKCQAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:00:18 -0500
Date: Fri, 3 Nov 2006 17:02:13 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Brent Baccala <cosine@freesoft.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061103160212.GK13555@kernel.dk>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03 2006, Brent Baccala wrote:
> On Fri, 3 Nov 2006, Jens Axboe wrote:
> 
> >On Fri, Nov 03 2006, Brent Baccala wrote:
> >>Hello -
> >>
> >>I'm running 2.6.15 (Debian) on a Pentium M laptop, PCI attached ext3
> >>filesystem.
> >>
> >>I'm writing my first asynchronous I/O program, and for a while I
> >>thought I was really doing something wrong, but more and more I'm
> >>starting to conclude that the problem might be in the kernel.
> >>
> >>Basically, I've narrowed things down to a test program which opens a
> >>large (700 MB) file in O_DIRECT mode and fires off 100 one MB async
> >>reads for the first 100 MB of data.  The enqueues take about 5 seconds
> >>to complete, which is also about the amount of time this disk needs to
> >>read 100 MB, so I suspect that it's blocking.
> >>
> >>I've gotten the POSIX AIO interface at least tolerably running using
> >>the GLIBC thread-based implementation, but I really want the native
> >>interface working.
> >>
> >>I whittled the test program down to use system calls instead of the
> >>POSIX AIO library, and I'm attaching a copy.  You put a big file at
> >>'testfile' (it just reads it) and run the program:
> >>
> >>
> >>baccala@debian ~/src/endgame$ time ./testaio
> >>Enqueues starting
> >>Enqueues complete
> >>
> >>real    0m5.327s
> >>user    0m0.004s
> >>sys     0m0.740s
> >>baccala@debian ~/src/endgame$
> >>
> >>
> >>Of that five seconds, it's almost all spent between the two "enqueues"
> >>messages.
> >
> >You don't mention what hardware you are running this on (the disk sub
> >system). io_submit() will block, if you run out of block layer requests.
> >We have 128 of those by default, but if your io ends up getting chopped
> >into somewhat smaller bits than 1MiB each, then you end up having to
> >block on allocation of those. So lets say your /src is mounted on
> >/dev/sdaX, try:
> >
> ># echo 512 > /sys/block/sda/queue/nr_requests
> >
> >(substitute sda for whatever device your /src is on)
> >
> >and re-test. The time between starting and complete should be a lot
> >smaller, now that you are not blocking on blkdev request allocation. You
> >may also want to look at the max_sectors_kb in the queue/ directory,
> >that'll tell you how large a single io will be at most once it reaches
> >the driver.
> >
> >-- 
> >Jens Axboe
> >
> 
> OK, good question.  Here's what the kernel reports about the controller:
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ALI15X3: IDE controller at PCI slot 0000:00:04.0
> ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
> ALI15X3: chipset revision 195
> ALI15X3: not 100%% native mode: will probe irqs later
>     ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
> ALI15X3: simplex device: DMA forced
>     ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:DMA
> 
> Your suggestion definitely helped!  /proc/sys/block/hda/queue/max_sectors_kb
> reported 128, so I tried:
> 
> # echo 1024 > /sys/block/hda/queue/nr_requests
> 
> And am now definately seeing async behavior!
> 
> The enqueues still take a noticable amount of time, though, just a lot
> less than before.  They average 1 second total.  That's 100 one-MB
> reads, broken down into 128 KB blocks, I suppose, for a total of 800
> low-level reads.  Setting nr_requests higher (2048) doesn't seem to do
> any more good.
> 
> I can see that you've put me on the right track, but I am still
> puzzling... any idea what the remaining second is being used for?

Try to time it (visual output of the app is not very telling, and it's
buffered) and then apply some profiling.

-- 
Jens Axboe

