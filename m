Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbRFWFdj>; Sat, 23 Jun 2001 01:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265642AbRFWFd3>; Sat, 23 Jun 2001 01:33:29 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30983 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265641AbRFWFdU>; Sat, 23 Jun 2001 01:33:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, Jens Axboe <axboe@suse.de>
Subject: Re: [RFC] Early flush (was: spindown)
Date: Sat, 23 Jun 2001 07:10:45 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca> <20010623012550.B415@pelks01.extern.uni-tuebingen.de>
In-Reply-To: <20010623012550.B415@pelks01.extern.uni-tuebingen.de>
MIME-Version: 1.0
Message-Id: <01062307104500.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 June 2001 01:25, Daniel Kobras wrote:
> On Wed, Jun 20, 2001 at 10:12:38AM -0600, Richard Gooch wrote:
> > Daniel Phillips writes:
> > > I'd like that too, but what about sync writes?  As things stand now,
> > > there is no option but to spin the disk back up.  To get around this
> > > we'd have to change the basic behavior of the block device and
> > > that's doable, but it's an entirely different proposition than the
> > > little patch above.
> >
> > I don't care as much about sync writes. They don't seem to happen very
> > often on my boxes.
>
> syslog and some editors are the most common users of sync writes. vim,
> e.g., per default keeps fsync()ing its swapfile. Tweaking the configuration
> of these apps, this can be prevented fairly easy though. Changing sync
> semantics for this matter on the other hand seems pretty awkward to me. I'd
> expect an application calling fsync() to have good reason for having its
> data flushed to disk _now_, no matter what state the disk happens to be in.
> If it hasn't, fix the app, not the kernel.

But apps shouldn't have to know about the special requirements of laptops.  
I've been playing a little with the idea of creating a special block device 
for laptops that goes between the vfs and the real block device, and adds the 
behaviour of being able to buffer writes in memory.  In all respects it would 
seem to the vfs to be a disk.  So far this is just a thought experiment.

> > > You know about this project no doubt:
> > >
> > >    http://noflushd.sourceforge.net/
> >
> > Only vaguely. It's huge. Over 2300 lines of C code and >560 lines in
> > .h files! As you say, not really lightweight. There must be a better
> > way.
>
> noflushd would benefit a lot from being able to set bdflush parameters per
> device or per disk. So I'm really eager to see what Daniel comes up with.
> Currently, we can only turn kupdate either on or off as a whole, which
> means that noflushd implements a crude replacement for the benefit of
> multi-disk setups. A lot of the cruft stems from there.

Yes, another person to talk to about this is Jens Axboe who has been doing 
some serious hacking on the block layer.  I thought I'd get the early flush 
patch working well for one disk before generalizing to N ;-)

> > Also, I suspect (without having looked at the code) that it
> > doesn't handle memory pressure well. Things may get nasty when we run
> > low on free pages.
>
> It doesn't handle memory pressure at all. It doesn't have to. noflushd only
> messes with kupdate{,d} but leaves bdflush (formerly known as kflushd)
> alone. If memory gets tight, bdflush starts writing out dirty buffers,
> which makes the disk spin up, and we're back to normal.

Exactly.  And in addition, when bdflush does wake up, I try to get kupdate 
out of the way as much as possible, though I've been following the 
traditional recipe and having it submit all buffers past a certain age.  This 
is quite possibily a bad thing to do because it could starve the swapper.  
Ouch.

--
Daniel
