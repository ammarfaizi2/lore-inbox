Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288169AbSAUUgM>; Mon, 21 Jan 2002 15:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288184AbSAUUgD>; Mon, 21 Jan 2002 15:36:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43536
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S288169AbSAUUfs>; Mon, 21 Jan 2002 15:35:48 -0500
Date: Mon, 21 Jan 2002 12:18:21 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121184433.C1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201211133310.15703-100000@master.linux-ide.org>
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

I will and have done so in the past when I am, and it would be nice if you
and Linus could do the same.  However since both are going to enforce the
partial completion of IO on page boundaries or 4k, and you are not
allowed to pause or stop in the middle of a command execution to play
memory games under ATA/IDE PIO rules, period.

You two have limited me to having a single 4k or one page of memory per
request.  Regardless if the rq->buffer pointer list is handed to me, I can
not use or walk it with out having to jump in and out of a memory window.

So if you want partial completions of 4k boundaries then do not send down
requests bigger than 4k, or give me back the rq scratch pad copy (and I do
not want it back, it is lame), or grant the mempool for the atomic io of
the request and it must be contigious to the allow a clean walk of the
buffer from head to tail.

<insert your reasons why it will never be granted here>

Linux's requirements are against the hardware, thus why it does not work.

I have stated if (rq->current_nr_sectors != drive_multicount) do single
sector and restrict the data-io to rq->current_nr_sectors.
So it is clear for everyone "rq->current_nr_sectors" is bounded to be
1,2,3,4,5,6,7,8 sectors of data io.  It is not allowed to do any more
because is of the 4k rule.

Now if we want to do multi_count, on a dynamic range from 1-8 because that
is the range of "rq->current_nr_sectors" fine state it clearly and I will
adjust.  Since we are in PIO we have already had screwups some where, and
so grinding the IO to a single page or less is okay, but you two take the
heat for the performance kill-joy.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

