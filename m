Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318984AbSICV61>; Tue, 3 Sep 2002 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318986AbSICV61>; Tue, 3 Sep 2002 17:58:27 -0400
Received: from host194.steeleye.com ([216.33.1.194]:26641 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318984AbSICV6Y>; Tue, 3 Sep 2002 17:58:24 -0400
Message-Id: <200209032202.g83M2mC09323@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Tue, 03 Sep 2002 14:24:34 PDT." <20020903142434.A2538@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 17:02:48 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> If we only send an abort or reset after a quiesce I don't see why one
> is better than the other.

Quiesce means from the top (no more commands go from the block layer to the 
device) not from the bottom (commands can still be completed for the device).

> Not specific to reset or abort - if a single command gets an error, we
> wait for oustanding commands to complete before starting up the error
> handler thread. If all the commands (error one and outstanding) have
> barriers, those that do not error out will complete out of order from
> the errored command. 

We don't wait.  The commands may possibly be completing in parallel with 
recovery.  To address your point, though, that's why the device needs to be 
reset as fast as possible: to preserve what's left of the command order.  I 
accept that for a misbehaving device, this may be a race.

> And what happens if one command gets some sort of check condition
> (like medium error, or aborted command) that causes a retry? Will IO's
> still be correctly ordered? 

Retries get eliminated.  It should be up to the upper layers (sd or beyond) to 
say whether a retry is done.  Since, as you point out, retries automatically 
violate any barrier, it is probably up to the block layer to judge what should 
be done about the problem.

> I would like to see error handling occur without quiescing the entire
> adapter before taking any action. Stopping all adapter IO for a
> timeout can be a bit expensive - imagine a tape drive and multiple
> disks on an adapter, any IO disk timeout or failure will wait for the
> tape IO to complete before allowing any other IO, if the tape
> operation is long or is going to timeout this could be minutes or
> hours. 

Actually, I do think that quiescing has an important role to play.  A lot of 
drive errors can be self inflicted indigestion by accepting more tags into the 
queue than it can process.  Quiescing the queue lets us see if the drive can 
digest what it currently has or whether we need to apply a strong emetic.

I'd actually like to add tag starvation recovery to the error handler's list 
of things to do.  In that case, all you do on entry to the error handler is 
quiesce the upper queue and wait a while to see if the commands continue 
returning.  You only begin more drastic measures if nothing comes back in the 
designated time period.

James


