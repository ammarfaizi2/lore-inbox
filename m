Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318943AbSICVoZ>; Tue, 3 Sep 2002 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318944AbSICVoU>; Tue, 3 Sep 2002 17:44:20 -0400
Received: from host194.steeleye.com ([216.33.1.194]:16913 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318943AbSICVoQ>; Tue, 3 Sep 2002 17:44:16 -0400
Message-Id: <200209032148.g83LmeP09177@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Tue, 03 Sep 2002 17:13:21 EDT." <20020903171321.A12201@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 16:48:39 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dledford@redhat.com said:
> But, regardless, the REQ_BARRIER ordering *can* be preserved  while
> using abort processing.  Since the command that needs aborting is,  as
> you are hypothesizing, before the REQ_BARRIER command, and since it
> hasn't completed, then the REQ_BARRIER command can not be complete and
>  neither can any of the commands behind the REQ_BARRIER.

You are correct.  However, as soon as you abort the problem command (assuming 
the device recovers from this), it will go on its merry way processing the 
remaining commands in the queue.  Assuming one of these is the barrier, you've 
no way now of re-queueing the aborted command so that it comes before the 
ordered tag barrier.  You can try using a head of queue tag, but it's still a 
nasty race.

> On direct access  devices you are only concerned about ordering around
> the barrier, not  ordering of the actual tagged commands, so for abort
> you can actually call  abort on all the commands past the REQ_BARRIER
> command first, then the  REQ_BARRIER command, then the hung command.
> That would do the job and  preserve REQ_BARRIER ordering while still
> using aborts.

I agree, but the most likely scenario is that now you're trying to abort 
almost every tag for that device in the system.  Isn't reset a simpler 
alternative to this?

> > At best, abort probably causes a command to overtake a barrier it shouldn't, 
> > at worst we abort the ordered tag that is the barrier and transactional 
> > integrity is lost.
> > 
> > When error correction is needed, we have to return all the commands for that 
> > device to the block layer so that ordering and barrier issues can be taken 
> > care of in the reissue.

> Not really, this would be easily enough done in the ML_QUEUE area of
> the  scsi layer, but it matters not to me.  However, if you throw a
> BDR, then  you have cancelled all outstanding commands and (typically)
> initiated a  hard reset of the device which then requires a device
> settle time.  All of  this is more drastic and typically takes longer
> than the individual aborts  which are completed in a single connect->
> disconnect cycle without ever  hitting a data phase and without
> triggering a full device reset and  requiring a settle time. 

I agree.  I certainly could do it.  I'm just a lazy so-and-so.  However, think 
what it does.  Apart from me having to do more work, the code becomes longer 
and the error recovery path more convoluted and difficult to follow.  The 
benefit?  well, error recovery might be faster in certain circumstances.  I 
just don't see that it's a cost effective change.  If you're hitting error 
recovery so often that whether it recovers in  half a second or several 
seconds makes a difference, I'd say there's something else wrong.

James


