Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJQNI0>; Thu, 17 Oct 2002 09:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJQNI0>; Thu, 17 Oct 2002 09:08:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37893 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261477AbSJQNIY>; Thu, 17 Oct 2002 09:08:24 -0400
Date: Thu, 17 Oct 2002 09:14:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Shawn <core@enodev.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <Pine.LNX.4.44.0210161437010.1108-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021017085823.16060C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Linus Torvalds wrote:

> On Wed, 16 Oct 2002, Shawn wrote:
> > On 10/16, Bill Davidsen said something like:
> > > On Tue, 15 Oct 2002, Linus Torvalds wrote:
> > > > A huge merging frenzy for the feature freeze, although I also spent a few
> > > > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > > > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > > > those off to the maintainer).
> > > 
> > > I hope you haven't broken running WITH ide-scsi, because most people still
> > > run 2.4 kernels in real life and only test 2.5 because someone has to do
> > > it. Reconfiguring the system to use ide-scsi or not is just one more PITA
> > > thing which needs to be done, or more likely forgotten, with every new
> > > kernel.
> > 
> > Honestly, I think it's ok to bust the old stuff if needed. This is
> > simply my opinion from a user standpoint.
> 
> Anyway, ide-scsi should work as well as it ever did, which is not to say
> too well.  It's just that the IDE native implementation is cleaner and 
> simpler, and a _hell_ of a lot easier to use.

Clearly you are talking about systems which are not used in production,
and which run 2.5 kernels all the time. Having to switch back and forth in
all the naming conventions, device to interface assignments, etc, is a
PITA. And like anything you have to do to convert, some day you will
forget a step and leave your production 2.4 capability broken.
 
> The scsi-generic layer is a total nightmare. If you want to write to the 
> device that is /dev/scd0, you can't just use /dev/scd0, you have to use 
> the right /dev/sgX, and the X depends on how many disks etc you have in 
> the system and where your controller is. The amount of crap you have to do 
> with things like "cdrecord -scanbus" to just figure out what the right 
> device is is just ludicrous.

Do you mean that the new cdrecord -scanbus will now scan the IDE bus(es)
as well, or that we can just try to find time to write something else
which lists all the CD devices? You are aware that you don't *need* to
know any of that /dev/sgX stuff, you just say dev=b,d,l (bus, device, lun)
and cdrecord does it?
 
> So right now, you can do "cdrecord dev=/dev/hdc ..", but because I didn't
> bother to try to figure out what the SCSI layer wants to do you can _not_
> do the simple "cdrecord dev=/dev/scd0 .." if you have a SCSI disk. That's
> nothing fundamental, I just don't think SCSI CD-RW's are very interesting
> any more, since they are overpriced and hard to find. I hope some SCSI 
> fanatic will do the (probably trivial) addition to sr.c to accept the SCSI 
> ioctl interface.

Again, I think you have never done any of this in a production
environment. Joe User burning a little music on his one CD-RW and a
production CD based distribution or backup setup are as related as the guy
with the the single Celeron and a NUMA system. SCSI allow writing multiple
CDs at once without fighting with "what's on the same cable," and allows
more than a few drives. And these days the writers are becoming DVD, which
makes it even more desirable to have an adult-strength bus.
 
> (Hint for such SCSI users: you should just do:
> 
>  - call "scsi_cmd_ioctl()" in your ioctl routine, and if it returns 
>    ENOTTY that means that it wasn't one of the SCSI generic commands.
> 
>  - make the request queue handler understand that requests with the
>    REQ_BLOCK_PC flag set are SCSI packet commands, and "req->cmd" contains 
>    the command, while "req->data" and "req->data_len" are the data for the 
>    command)
> 
>  - make sure that an open() with the O_NONBLOCK flag set will succeed even 
>    if the medium is not accessible (and will succeed even if it's a
>    writable open).
> 
> and that should be pretty much it).

All tips and hints appreciated.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

