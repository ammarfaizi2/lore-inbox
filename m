Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSAULPh>; Mon, 21 Jan 2002 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSAULPT>; Mon, 21 Jan 2002 06:15:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:30222 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284144AbSAULPI>; Mon, 21 Jan 2002 06:15:08 -0500
Date: Mon, 21 Jan 2002 12:14:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121121456.A24656@suse.cz>
In-Reply-To: <Pine.LNX.4.40.0201201054011.7238-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.10.10201201555040.12376-100000@master.linux-ide.org> <20020121114311.A24604@suse.cz> <20020121114830.W27835@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121114830.W27835@suse.de>; from axboe@suse.de on Mon, Jan 21, 2002 at 11:48:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 11:48:30AM +0100, Jens Axboe wrote:
> On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> > On Sun, Jan 20, 2002 at 04:12:36PM -0800, Andre Hedrick wrote:
> > 
> > > > > > We only read out 4k thus the device has the the next 4k we may be wanting
> > > > > > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > > > > > to want to go south, thus [lost interrupt]
> > > > >
> > > > > Even if the drive is programmed for 16 sectors in multi mode, it still
> > > > > must honor lower transfer sizes. The fix I did was not to limit this,
> > > > > but rather to only setup transfers for the amount of sectors in the
> > > > > first chunk. This is indeed necessary now that we do not have a copy of
> > > > > the request to fool around with.
> > > 
> > > Listen and for just a second okay.
> > > 
> > > Since the set multimode command is similar to the set transfer rate, if
> > > you program the drive to run at U100 but the host can feed only U33 you
> > > have problems.  Much of this simple arguement is the same answer for
> > > multimode.
> > > 
> > > Same thing here but a variation, of the operations,
> > 
> > So you're saying that if you program the drive to multimode 16, you
> > can't read a single sector and always have to read 16? That not only
> > doesn't make sense to me, but it also contradicts anything that I've
> > heard before.
> 
> Well it didn't/doesn't make sense to me either, let me quote spec
> though:
> 
> (READ_MULTIPLE)
> 
> "If the number of requested sectors is not evenly divisible by the block
> count, as many full blocks as possible are transferred, followed by a
> final, partial block transfer."
> 
> (block count being the multi setting here)
> 
> I actually misread this the first time around, it seems my original code
> was indeed correct (and that 2.4 of course also is). For the example 24
> sector request and multi mode of 16, the drive _will_ only expect 8
> sectors in the final run. That makes sense to me again, I couldn't
> understand the apparent brain damage in the model Andre suggested.
> 
> Time for a new patch...

I always thought it is like this (and this is what I still believe after
having read the sprcification):

---
SET_MUTIPLE 16 sectors
---
READ_MULTIPLE 24 sectors
IRQ
PIO transfer 16 sectors
IRQ
PIO transfer 8 sectors
---

Where am I wrong?

By the way, the device *isn't* required to support any lower multiple
count than the maximum one it advertizes. Ugly.

-- 
Vojtech Pavlik
SuSE Labs
