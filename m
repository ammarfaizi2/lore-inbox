Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSAULkm>; Mon, 21 Jan 2002 06:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSAULkd>; Mon, 21 Jan 2002 06:40:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8720 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284890AbSAULk0>; Mon, 21 Jan 2002 06:40:26 -0500
Date: Mon, 21 Jan 2002 03:34:15 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121121456.A24656@suse.cz>
Message-ID: <Pine.LNX.4.10.10201210324150.14375-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Vojtech Pavlik wrote:

> On Mon, Jan 21, 2002 at 11:48:30AM +0100, Jens Axboe wrote:
> > On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> > > On Sun, Jan 20, 2002 at 04:12:36PM -0800, Andre Hedrick wrote:
> > > 
> > > > > > > We only read out 4k thus the device has the the next 4k we may be wanting
> > > > > > > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > > > > > > to want to go south, thus [lost interrupt]
> > > > > >
> > > > > > Even if the drive is programmed for 16 sectors in multi mode, it still
> > > > > > must honor lower transfer sizes. The fix I did was not to limit this,
> > > > > > but rather to only setup transfers for the amount of sectors in the
> > > > > > first chunk. This is indeed necessary now that we do not have a copy of
> > > > > > the request to fool around with.
> > > > 
> > > > Listen and for just a second okay.
> > > > 
> > > > Since the set multimode command is similar to the set transfer rate, if
> > > > you program the drive to run at U100 but the host can feed only U33 you
> > > > have problems.  Much of this simple arguement is the same answer for
> > > > multimode.
> > > > 
> > > > Same thing here but a variation, of the operations,
> > > 
> > > So you're saying that if you program the drive to multimode 16, you
> > > can't read a single sector and always have to read 16? That not only
> > > doesn't make sense to me, but it also contradicts anything that I've
> > > heard before.
> > 
> > Well it didn't/doesn't make sense to me either, let me quote spec
> > though:
> > 
> > (READ_MULTIPLE)
> > 
> > "If the number of requested sectors is not evenly divisible by the block
> > count, as many full blocks as possible are transferred, followed by a
> > final, partial block transfer."
> > 
> > (block count being the multi setting here)
> > 
> > I actually misread this the first time around, it seems my original code
> > was indeed correct (and that 2.4 of course also is). For the example 24
> > sector request and multi mode of 16, the drive _will_ only expect 8
> > sectors in the final run. That makes sense to me again, I couldn't
> > understand the apparent brain damage in the model Andre suggested.
> > 
> > Time for a new patch...
> 
> I always thought it is like this (and this is what I still believe after
> having read the sprcification):
> 
> ---
> SET_MUTIPLE 16 sectors
> ---
> READ_MULTIPLE 24 sectors
> IRQ
> PIO transfer 16 sectors
> IRQ
> PIO transfer 8 sectors
> ---
> 
> Where am I wrong?
> 
> By the way, the device *isn't* required to support any lower multiple
> count than the maximum one it advertizes. Ugly.

No but the HOST is to obey the requirements of the device.
The spec is written from the drive side not the host side.

"All Ye Hosts, SHALL address me in such a manner as described, or be
aborted or I SHALL remain in an undertermined state."

Note only recently have the HOSTS been about to setup guidelines for what
is sane and not stupid for the device to do or behave.

Again, the HOST(Linux) is not following the device side rules so expect
difficulty when we depart.  The Brain Damage is how to talk to the
hardware, and it is clear we are not doing it right because we are bending
the rules stuff it into and API that not acceptable.  However we are
stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
buffer pages are contigious and the 4k page dance is a NOOP.  Until that
time we will be fussing about.

Regards,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

