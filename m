Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318960AbSICV2U>; Tue, 3 Sep 2002 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318961AbSICV2U>; Tue, 3 Sep 2002 17:28:20 -0400
Received: from host194.steeleye.com ([216.33.1.194]:529 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318960AbSICV2R>; Tue, 3 Sep 2002 17:28:17 -0400
Message-Id: <200209032132.g83LWdD09043@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "03 Sep 2002 21:59:37 BST." <1031086777.21579.33.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 16:32:38 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> What do we plan to do for the cases where reset is disabled because we
> have shared disk scsi so don't want to reset and hose the reservations

The reset gets issued and the reservation gets broken.  Good HA or other 
software knows the reservation may be lost and takes this into account in the 
cluster algorithm.

With SCSI-2 reservations, there's no way to preserve the reservation and have 
the reset be effective (I know, in theory, that this can be circumvented by 
the soft reset alternative, but I've never seen a device that implements it 
correctly).  I suppose we hope SCSI-3 Persistent Group Reservations come along 
quickly.

> If your error correction always requires all commands return to the
> block layer then the block layer is IMHO broken. Its messy enough
> doing that before you hit the fun situations where insert scsi
> commands of their own the block layer never initiated. 

This is part of the slim SCSI down approach.  The block layer already has 
handling for tag errors like this.  Inserted SCSI commands should now work 
correctly since we're deprecating the scsi_do_cmnd() in favour of scsi_do_req, 
which means the command is always associated with a request and goes into the 
block queue just like any other request.

I think the block layer, which already knows about the barrier ordering, is 
the appropriate place for this.  If you think the scsi error handler is a 
hairy wart now, just watch it grow into a stonking great carbuncle as I try to 
introduce it to the concept of command queue ordering and appropriate recovery.

> Next you only need to return stuff if commands have been issued
> between the aborting command and a barrier. Since most sane systems
> will never be causing REQ_BARRIER that should mean the general case
> for an abort is going to be fine. The CD burner example is also true
> for this. If we track barrier sequences then we will know the barrier
> count for the command we are aborting and the top barrier count for
> commands issued to the device. Finally you only need to go to the
> large hammer approach when you are dealing with a media changing
> command (ie WRITE*) - if we abort a read then knowing we don't queue
> overlapping read then write to disk we already know that the read will
> not break down the tag ordering as I understand it ? 

I agree with your reasoning.  However, errors occur infrequently enough (I 
hope) so that its just not worth the extra code complexity to make the error 
handler look for that case.

However, in all honesty, I have to say that I just don't believe ABORTs are 
ever particularly effective.  As part of error recovery, If a device is 
tipping over into failure, adding another message isn't a good way to pull it 
back.  ABORT is really part of the I/O cancellation API, and, like all 
cancellation implementations, it's potentially full of holes.  The only uses 
it might have---like oops I didn't mean to fixate that CD, give it back to me 
now---aren't clearly defined in the SPEC to produce the desired effect (stop 
the fixation so the drive door can be opened).

> If we get to the point we need an abort we don't want to issue a
> reset. Not every device comes back sane from a reset and in some cases
> we have to issue a whole sequence of commands to get the state of the
> device back (door locking, power management, ..)

Well, this is SCSI---the first thing most controllers do for parallel SCSI at 
least is reset the BUS.  Some FC drivers do the FC equivalent as well (not 
that they should, but that's another issue).

The pain of coming back from a reset (and I grant, it isn't trivial) is well 
known and well implemented in SCSI.  It also, from error handlings point of 
view, sets the device back to a known point in the state model.

James


