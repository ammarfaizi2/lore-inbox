Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbSAUWDy>; Mon, 21 Jan 2002 17:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSAUWDp>; Mon, 21 Jan 2002 17:03:45 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:50192
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287490AbSAUWDg>; Mon, 21 Jan 2002 17:03:36 -0500
Date: Mon, 21 Jan 2002 13:44:07 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121184433.C1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201211323500.15703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > I always thought it is like this (and this is what I still believe after
> > > having read the sprcification):
> > > 
> > > ---
> > > SET_MUTIPLE 16 sectors
> > > ---
> > > READ_MULTIPLE 24 sectors
> > > IRQ
> > > PIO transfer 16 sectors
> > > IRQ
> > > PIO transfer 8 sectors
> > > ---
> > > 
> > > Where am I wrong?
> > > 
> > > By the way, the device *isn't* required to support any lower multiple
> > > count than the maximum one it advertizes. Ugly.
> > 
> > No but the HOST is to obey the requirements of the device.
> > The spec is written from the drive side not the host side.
> > 
> > "All Ye Hosts, SHALL address me in such a manner as described, or be
> > aborted or I SHALL remain in an undertermined state."
> > 
> > Note only recently have the HOSTS been about to setup guidelines for what
> > is sane and not stupid for the device to do or behave.
> > 
> > Again, the HOST(Linux) is not following the device side rules so expect
> > difficulty when we depart.  The Brain Damage is how to talk to the
> > hardware, and it is clear we are not doing it right because we are bending
> > the rules stuff it into and API that not acceptable.  However we are
> > stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
> > buffer pages are contigious and the 4k page dance is a NOOP.  Until that
> > time we will be fussing about.
> 
> Andre,
> 
> Do you know how to say "I was wrong"? You are walking off-track again.
> It's clearly the way that Vojtech and I describe, otherwise current code
> would just not work. And 2.4, 2.2, 2.0 neither.

255 * 512bytes != 128K  BUG
256 * 512bytes == 128K

You insure we will fail on alignemnt.

You have stated BLOCK can not deal with correct sector alignments, and
thus 255 so please fix it first.  I have accepted this brokeness in BLOCK
and dropped to 128 sectors or a clean 64k.

If we restrict multi-sector PIO to 8 sectors we can do multi interrupt
ATOMIC disk IO on the paging alignments, but you have enforced single
sector IO in the multi-sector writing and can not see the difference.
If rq->current_nr_sectors is less than 8 we do PIO single sector IO, but
we are doing that now w/ the copy paste changes from the old ide-disk.c
stuff that we are attempting deleting.

You are making mistakes left and right because you think you understand
the hardware.  I thought we had an agreement, BLOCK stops at DO_REQUEST.
Now you are altering the driver core, and the ISR's.  BLOCK has no
business in dictating how to talk to the hardware, especially since it
violates the specification willfully and without need.

We do a DMA of two PRD's of 128 sectors and 127 sectors, thus a mess.

So at this point pull it and put back the munge for before and I will fix
it completely and return a turn-key, now that I understand the brokeness
of the interface I am deal w/ on both sides.

Until you understand the execution of the command block is ATOMIC it will
never work.  Also when the SCSI-MID Layer is deleted, you will have a
repeat of this issue on a much grander scale.  Eric was a brilliant to
hide the nature of the transport layer in the SCSI-MID Layer and return
back partial completion against his ATOMIC Command IO calls.

Had I been as clever as him in the past nobody would know the difference.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

