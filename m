Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJPV6M>; Wed, 16 Oct 2002 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJPV6M>; Wed, 16 Oct 2002 17:58:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19724 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261495AbSJPV6L>; Wed, 16 Oct 2002 17:58:11 -0400
Date: Wed, 16 Oct 2002 14:48:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Shawn <core@enodev.com>
cc: Bill Davidsen <davidsen@tmr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <20021016163515.C2874@q.mn.rr.com>
Message-ID: <Pine.LNX.4.44.0210161437010.1108-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Shawn wrote:
> On 10/16, Bill Davidsen said something like:
> > On Tue, 15 Oct 2002, Linus Torvalds wrote:
> > > A huge merging frenzy for the feature freeze, although I also spent a few
> > > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > > those off to the maintainer).
> > 
> > I hope you haven't broken running WITH ide-scsi, because most people still
> > run 2.4 kernels in real life and only test 2.5 because someone has to do
> > it. Reconfiguring the system to use ide-scsi or not is just one more PITA
> > thing which needs to be done, or more likely forgotten, with every new
> > kernel.
> 
> Honestly, I think it's ok to bust the old stuff if needed. This is
> simply my opinion from a user standpoint.

Anyway, ide-scsi should work as well as it ever did, which is not to say
too well.  It's just that the IDE native implementation is cleaner and 
simpler, and a _hell_ of a lot easier to use.

The scsi-generic layer is a total nightmare. If you want to write to the 
device that is /dev/scd0, you can't just use /dev/scd0, you have to use 
the right /dev/sgX, and the X depends on how many disks etc you have in 
the system and where your controller is. The amount of crap you have to do 
with things like "cdrecord -scanbus" to just figure out what the right 
device is is just ludicrous.

With the native IDE setup, if your CD is /dev/hdc, then that's what you 
use for cdburning too. Just do "cdrecord dev=/dev/hdc" and that's it. No 
made-up SCSI bus numbers, no need to try to figure out what the right 
thing is, no crap. 

In fact, I hope that in linux-2.7.x the SCSI layer itself will start using
the same interface, so that we can drop scsi-generic some day completely.  
The interface is totally generic, and doesn't have anything to do with IDE
per se - ide-cd.c just needed to be cleaned up enough to be able to use
it. The interface really just says "hey, you can push SCSI commands down
the request queue" (and ide-cd.c will take the SCSI command and convert it
into an ATAPI packet command - which is a pretty trivial transform).

So right now, you can do "cdrecord dev=/dev/hdc ..", but because I didn't
bother to try to figure out what the SCSI layer wants to do you can _not_
do the simple "cdrecord dev=/dev/scd0 .." if you have a SCSI disk. That's
nothing fundamental, I just don't think SCSI CD-RW's are very interesting
any more, since they are overpriced and hard to find. I hope some SCSI 
fanatic will do the (probably trivial) addition to sr.c to accept the SCSI 
ioctl interface.

(Hint for such SCSI users: you should just do:

 - call "scsi_cmd_ioctl()" in your ioctl routine, and if it returns 
   ENOTTY that means that it wasn't one of the SCSI generic commands.

 - make the request queue handler understand that requests with the
   REQ_BLOCK_PC flag set are SCSI packet commands, and "req->cmd" contains 
   the command, while "req->data" and "req->data_len" are the data for the 
   command)

 - make sure that an open() with the O_NONBLOCK flag set will succeed even 
   if the medium is not accessible (and will succeed even if it's a
   writable open).

and that should be pretty much it).

		Linus

