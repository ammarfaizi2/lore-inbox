Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318965AbSICWhq>; Tue, 3 Sep 2002 18:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSICWhq>; Tue, 3 Sep 2002 18:37:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6595 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318964AbSICWhn>; Tue, 3 Sep 2002 18:37:43 -0400
Date: Tue, 3 Sep 2002 18:42:16 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903184216.F12201@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <dledford@redhat.com> <200209032148.g83LmeP09177@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209032148.g83LmeP09177@localhost.localdomain>; from James.Bottomley@SteelEye.com on Tue, Sep 03, 2002 at 04:48:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 04:48:39PM -0500, James Bottomley wrote:
> dledford@redhat.com said:
> You are correct.  However, as soon as you abort the problem command (assuming 
> the device recovers from this), it will go on its merry way processing the 
> remaining commands in the queue.  Assuming one of these is the barrier, you've 
> no way now of re-queueing the aborted command so that it comes before the 
> ordered tag barrier.  You can try using a head of queue tag, but it's still a 
> nasty race.

(Solution to this race was in my next paragraph as you found ;-)

> > On direct access  devices you are only concerned about ordering around
> > the barrier, not  ordering of the actual tagged commands, so for abort
> > you can actually call  abort on all the commands past the REQ_BARRIER
> > command first, then the  REQ_BARRIER command, then the hung command.
> > That would do the job and  preserve REQ_BARRIER ordering while still
> > using aborts.
> 
> I agree, but the most likely scenario is that now you're trying to abort 
> almost every tag for that device in the system.  Isn't reset a simpler 
> alternative to this?

Not really.  It hasn't been done yet, but one of my goals is to change the 
scsi commands over to reasonable list usage (finally) so that we can avoid 
all these horrible linear scans it does now looking for an available 
command (it also means things like SCSI_OWNER_MID_LAYER can go away 
because ownership is defined implicitly by list membership).  So, 
basically, you have a list item struct on each command.  When you build 
the commands, you add them to SDpnt->free_list.  When you need a command, 
instead of searching for a free one, you just grab the head of 
SDpnt->free_list and use it.  Once you've built the command and are ready 
to hand it off to the lldd, you put the command on the tail of the 
SDpnt->active_list.  When a command completes, you list_remove() it from 
the SDpnt->active_list and put it on the SDpnt->complete_list to be 
handled by the tasklet.  When the tasklet actually completes the command, 
it frees the scsi command struct by simply putting it back on the 
SDpnt->free_list.  Now, if you do things that way, your reset vs. abort 
code is actually pretty trivial.

Case 1: you want to throw a BDR.  Sample code might end up looking like 
this,

	[ oops we timed out ]
	hostt->bus_device_reset(cmd);
	if(!list_empty(cmd->device->active_list)) {
		[ our commands haven't all been returned, spew chunks! ]
	}
	[ do post reset processing ]

Case 2: you want to do an abort, but you need to preserve ordering around 
any possible REQ_BARRIERs on the bus.  This requires that we keep a 
REQ_BARRIER count for the device, it is after all possible that we could 
have multiple barriers active at once, so as each command is put on the 
active_list, if it is a barrier, then we increment SDpnt->barrier_count 
and as we complete commands (at the interrupt context completion, not the 
final completion) if it is a barrier command we decrement the count.

	[ oops we timed out ]
	while(SDpnt->barrier_count && cmd) {
		// when the aborted command is returned via the done()
		// it will remove it from the active_list, so don't remove
		// it here
		abort_cmd = list_get_tail(SDpnt->active_list);
		if(hostt->abort(abort_cmd) != SUCCESS) {
			[ oops, go on to more drastic action ]
		} else {
			if(abort_cmd->type == BARRIER)
				SDpnt->barrier_count--;
			if(abort_cmd == cmd)
				cmd = NULL;
		}
	}
	if(cmd) {
		if(hostt->abort(cmd) != SUCCESS)
			[ oops, go on to more drastic action ]
	}

Now, granted, that is more complex than going straight to a BDR, but I 
have to argue that it *isn't* that complex.  It certainly isn't the 
nightmare you make it sound like ;-)


> > > At best, abort probably causes a command to overtake a barrier it shouldn't, 
> > > at worst we abort the ordered tag that is the barrier and transactional 
> > > integrity is lost.
> > > 
> > > When error correction is needed, we have to return all the commands for that 
> > > device to the block layer so that ordering and barrier issues can be taken 
> > > care of in the reissue.
> 
> > Not really, this would be easily enough done in the ML_QUEUE area of
> > the  scsi layer, but it matters not to me.  However, if you throw a
> > BDR, then  you have cancelled all outstanding commands and (typically)
> > initiated a  hard reset of the device which then requires a device
> > settle time.  All of  this is more drastic and typically takes longer
> > than the individual aborts  which are completed in a single connect->
> > disconnect cycle without ever  hitting a data phase and without
> > triggering a full device reset and  requiring a settle time. 
> 
> I agree.  I certainly could do it.  I'm just a lazy so-and-so.  However, think 
> what it does.  Apart from me having to do more work, the code becomes longer 
> and the error recovery path more convoluted and difficult to follow.  The 
> benefit?  well, error recovery might be faster in certain circumstances.

Well, as I've laid it out above, I don't really think it's all that much 
to implement ;-)  At least not in the mid layer.  The low level device 
drivers are doing *far* more work to support aborts than the mid layer has 
to do.

>  I 
> just don't see that it's a cost effective change.

Matter of some question, I'm sure.  I don't see it as all that much work, 
so it seems reasonably cost effective to me ;-)

>  If you're hitting error 
> recovery so often that whether it recovers in  half a second or several 
> seconds makes a difference, I'd say there's something else wrong.

Hehehe, if you are hitting error recovery at all then something else is 
wrong by definition, the only difference is in how you handle it :-P

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
