Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUAFOJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUAFOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:09:19 -0500
Received: from [139.30.44.16] ([139.30.44.16]:8327 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263260AbUAFOJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:09:14 -0500
Date: Tue, 6 Jan 2004 15:09:10 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Bauke Jan Douma <bjdouma@xs4all.nl>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSC cannot be used as a timesource -> SOLVED
In-Reply-To: <20040106140044.GA944@sagittarius.unix9.prv>
Message-ID: <Pine.LNX.4.53.0401061452350.5896@gockel.physik3.uni-rostock.de>
References: <20040106140044.GA944@sagittarius.unix9.prv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First
> -----
> Until today I had my Linux system running on an old 1.7Gb /dev/hda and a
> newer 20Gb /dev/hdb.  Because the 1.7Gb was extremely unreliable with
> DMA (established a long time ago), I always had it off for that disk;
> the 20Gb disk had DMA on (udma4).
> 
> Kernel in recent months has always been the current 2.6.0-testNN and
> since its release, kernel 2.6.0
> 
> With the 2.6 kernels (and possibly with late 2.5 versions too?) I would
> always get the mystifying:
> 
>   Losing too many ticks!
>   TSC cannot be used as a timesource. (Are you running with SpeedStep?)
>   Falling back to a sane timesource.
> 
> during the boot-up, right at the point it seems where a standard e2fsck
> is run.
> 

As the message says, your system loses timer interrupts (clock ticks)  
compared to the CPU-internal Time Stamp Counter. This is probably due to
the old harddrive disabling interrupts for too long a time.
Since the wall clock and the TSC differ, the kernel has to decide which 
time source to trust. Current kernels choose the timer interrupt (this 
might change in the future), which in your case is just the wrong 
decision.

> Today I installed a new 80Gb harddisk, making the 20Gb /dev/hda and
> the 80Gb /dev/hdb, and junking the 1.7Gb.  Both have DMA enabled (udma5).
> 
> It seems the TSC problem has vanished, no more such messages -- knock on
> wood.

Yep, since the culprit is removed that turned interrupts off for long 
intervals.

> 
[detailed system description skipped]
> 
> Second
> ------
> In order to use my new 80Gb harddisk, I first installed it alongside
> the two 'old' disks, as /dev/hdc, so as to be able to move ca. 16Gb of
> data from the 20Gb to the 80Gb.  So I temporarily had:
> hda: 1.7Gb / no dma
> hdb: 20Gb / udma4
> hdc: 80Gb / udma5
> 
> Now here's what happened: during the one foul swoop 'cp -axvp *' from
> the 20Gb HD to the 80Gb HD, at two times the copying process seemed
> to 'hang' for ca. 10-15 minutes (at least there were two times I noticed),
> the copy being in a 'D' state (uninterruptable sleep).
> 
> By the time the cp was finally finished (could be ~1.5 hr later wall clock
> time!), the system clock was running behind ca. 45 minutes!

This is again explained by your system losing clock ticks. It just shows 
how bad the situation was: on average it seems to lose every other clock 
tick.
What happens if you turn interrupt unmasking on for your old drive? 
(hdparm -u1 /dev/hda)
BEWARE: rare chance of data corruption ahead, better mount the drive 
read-only before doing so.

This should give your system the chance to catch many more timer 
interrupts.

Easiest solution, of course, is to just retire the old drive.

Hope this explains your findings,
Tim
